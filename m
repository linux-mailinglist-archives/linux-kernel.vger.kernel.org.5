Return-Path: <linux-kernel+bounces-152875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 749338AC599
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FEAC2831AB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AB64D11D;
	Mon, 22 Apr 2024 07:29:42 +0000 (UTC)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92604AEC1;
	Mon, 22 Apr 2024 07:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713770982; cv=none; b=M4IDv/9Lc880FUoMAqBS34cjGwTxISvf5iiae2eAaGIvlxpK17u9plmsEN/Flg5aKOnMA6iZIO11ylS9KNGr3499e61twwezV8Bl8uoiKXUut7oJolt01cUDxOejbsgk0SNUhibEn03nC34GxE+B/pre/ojfRsoKNA1zNuNYuvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713770982; c=relaxed/simple;
	bh=wzr0S+zBXr2J4EwCg1/zHzVxtvlB6OvBzu/g4tUzYJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pz7ke29joxjWKkZnV7Dzf8JYZUr6Y6Zm9yE+kL324xeHr3Qc+orPTJCgryFf1F0XPgZYHK1tbwlYIGCcvpjfTaJHTwFARxydkAZwsfmHZHZGtxixzwyQFXyZFBMx05zFazDY1nA7o0TQCZiR3N4Z261hsut/OrJIMDuHHgfPNSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2da01cb187cso68771611fa.0;
        Mon, 22 Apr 2024 00:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713770979; x=1714375779;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9BhVrRInUM8ivkTxhyo1VsgJ8qkpCRGBJvKQ87MN4U=;
        b=STsyNl1EuIOVXfyubGR4lKjb5pMBlzDSxN5riKW/S2JB2V2JohAucFluloj6dr9O1S
         Ah8LNu4EAm5yR1bAu4n8dP4Apx4rNf3WqsJuUFv8nHsCek73l4gxOrT4GUFy/btcEZPN
         COhsN/sfJx3WmFuPNtyZYMAK6yqMACjNMUeOZlh826laAWhPaTSWuGrGIjeRVS8wZmXj
         SM7VQp8H3FITREKsy4QGtXAvRSPVhKLgORxDpItxck3DHMHif/gxoWuPDNMTPIhx5DXP
         BynOM12BF4aIK/07U522xMiSDWZr3TZFlPxZuJF9VcuSYzuH8UPNIqvADmEjQozIKj7k
         MvPA==
X-Forwarded-Encrypted: i=1; AJvYcCUlyoO1tpg2OA+Lj9T+Uk0gGp8qgjuJ3115OutF4d4r6ozOPi9kIrXJcAcqP81NTUNcB94cKhYTskK2o9q+DOt+aJhRepg5/A2zcULM/6XMdFBNDd3NaFDdNf9JxDseLxHLpj/85OiycrIr5v8/F2Rgs4NkS1OlFPHfyM7VU5cF
X-Gm-Message-State: AOJu0YweS5m5Alt1Adw+1e6MsmHF2zLsUoGEn8l4BihHa/dnfTmKMZCF
	e3VHOuPcd2uLerWQyE6x4qrYA+yBHn5O0gpJTO9SFxlHIk6E8BhrZMRSaWpblpU=
X-Google-Smtp-Source: AGHT+IGykvHxXLAxop0/stWRB/4mST3jPX/xcZlMeKNQ4P3uXGwi8MKuZN1MU9/+Xxk2HU5zE+z3Qw==
X-Received: by 2002:a2e:98cd:0:b0:2dd:41a:cdce with SMTP id s13-20020a2e98cd000000b002dd041acdcemr4700960ljj.26.1713770978621;
        Mon, 22 Apr 2024 00:29:38 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id dq16-20020a170907735000b00a524318c380sm5417547ejc.80.2024.04.22.00.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 00:29:38 -0700 (PDT)
Message-ID: <bb5c1fd1-c3e7-4aaf-b28d-a45479ff0815@kernel.org>
Date: Mon, 22 Apr 2024 09:29:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net,v3] net: ppp: Fix deadlock caused by unsafe-irq lock
 in ap_get()
To: Jeongjun Park <aha310510@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, gregkh@linuxfoundation.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com,
 syzbot+393d0ef63475d9bb1f16@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <0032f249-7787-4875-a782-0847c04d5c9c@kernel.org>
 <20240422071858.140237-1-aha310510@gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240422071858.140237-1-aha310510@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22. 04. 24, 9:18, Jeongjun Park wrote:
> ========================================================
> WARNING: possible irq lock inversion dependency detected
> 6.8.0-rc3-syzkaller-00041-g547ab8fc4cb0 #0 Not tainted
> --------------------------------------------------------
..
>    ... key      at: [<ffffffff947ae860>] port_lock_key+0x0/0x20
>    ... acquired at:
>     lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
>     __raw_read_lock include/linux/rwlock_api_smp.h:150 [inline]
>     _raw_read_lock+0x36/0x50 kernel/locking/spinlock.c:228
>     ap_get drivers/net/ppp/ppp_async.c:136 [inline]
>     ppp_asynctty_wakeup+0x20/0x210 drivers/net/ppp/ppp_async.c:352
>     tty_wakeup+0xbb/0x100 drivers/tty/tty_io.c:523
>     tty_port_default_wakeup+0xa6/0xf0 drivers/tty/tty_port.c:69
>     serial8250_tx_chars+0x6ad/0x8a0 drivers/tty/serial/8250/8250_port.c:1835

> This is the stack trace for the issue causing the deadlock reported
> by syzbot. I think there is definitely a problem with ap_get() and
> this needs to be fixed.

OK, but read_unlock_irq() is not the right way to do it. It would enable 
irqs unconditionally, so serial8250_tx_chars() would not thank you in 
the above call chain.

Plus the issues Jakub had with the patch.

And what about ppp_synctty?

thanks,
-- 
js
suse labs



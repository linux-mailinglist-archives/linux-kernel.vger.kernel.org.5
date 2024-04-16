Return-Path: <linux-kernel+bounces-147768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5E08A7965
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E101AB21CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1B113AA42;
	Tue, 16 Apr 2024 23:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gtwiBh6O"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12E713A894
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 23:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713311774; cv=none; b=Abp2ldciVChFe6iwv+0QWEUVa61ZhFxtiryP9iBi3u8faqVQVnirTR5Klgc9pX5htJC7hG5gIi2tqTD3ltbWuGZR4g+V8YRSOXArNjQuAzHy9mkDqLUkSsYOpkKs+e/MEY+3WuSRiaWro7/046PAXDXuXLpI+h1bUQKQ71ZecB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713311774; c=relaxed/simple;
	bh=rwJftUeU/lbuNRsOtZmgiInugjY1VkK+eRR7xa/Txy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKrMHO0KeNMYMEVCKjWOaZwxMKlAqS0JiKWdHQyf49N9SLOl8HrC97WUKPK6eOyjxOJJJ+G5PIFCVTaBWpqLS8m4Ezq4tDKCF9S8nDgjjmZPKBZIPkYAYF4KhVBWx6nNFwTK3XXo92eQIMLl8pfw291kK+zvHzG87z/mlM8qXk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gtwiBh6O; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d9c78d1087so12325339f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1713311772; x=1713916572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=20k6hAYpVVcRpxhrJeU7g8eIaqwNO+HIAqzC4kADoz0=;
        b=gtwiBh6Ohk1BLPmB8zKJBf1hUbJa9O1Mk7Iut6Bccq6AKiboHul8blHaQaOh95Emqe
         lRpkvxFMZvycKM5uweEP5fRiYULyCautOIBWZxX9I+aIeKa+4IQwt1EIw9s8Duk95UNM
         jxbX/kZ0woSa8PmJQhNg6Nj/2KzLK6LUgica4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713311772; x=1713916572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=20k6hAYpVVcRpxhrJeU7g8eIaqwNO+HIAqzC4kADoz0=;
        b=lX+bRm47FHLuYxMKUj0c5zX47289UtXC0NdgxAYbaUc8fng8CnyhLGL/9BWMHgZ90q
         A3CK0RwcU6RAPpf4i9c82pseqpR1QzAeAycmoTx38W+YvcLA3Nzr/y+p6+nDgv9K85gt
         W2lxIUJcfVGj/7+LsepTKC/hrJ/R4odPA4f498C1OB7ZlPnqWaZUcrPaD2QGeQC6Tc9A
         /TI5OKklySoH7myWjXIzYJNmqRlRfRwXXRR0tl0yLGfys8TCf7KIMVXM4AvYD9y1/6sA
         rgH0w7p/WINbCGUnHDd4xXlHdIiQhhSJccLLOn4xQjMnEwo5IjBpcIuySc/wYpuRl9oR
         94+g==
X-Forwarded-Encrypted: i=1; AJvYcCUcT7j/9nK7s7Bcw0vCypvjkdIjUJz/wdy3HFSN+Ddowv5p6gWYDpHTeemUNoqyJ5TM9sfkemK/ELIUnlFyj3SJv2QKFdlX+EARE41v
X-Gm-Message-State: AOJu0YwsQlQywguvbzmjIuk/5sE8wTQ+L1LNw1Xcn1WLv2DV1Vg72gnK
	MjZFa7+3AcMVsgZXyQV4j10tFiXuUv7WVTGy8L9O45UEH7/tsOqSNAxWqXbrlJ0=
X-Google-Smtp-Source: AGHT+IFOvVxAAgDDGF0ZqJGKKI+J9AoZavpdV8gOREBSQGxb48v1ml8uaagqeXHKHxh05hbwU9/vXg==
X-Received: by 2002:a92:2c0d:0:b0:368:efa4:be12 with SMTP id t13-20020a922c0d000000b00368efa4be12mr12905023ile.3.1713311771784;
        Tue, 16 Apr 2024 16:56:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id l20-20020a056e020dd400b0036b34c1b30fsm114056ilj.43.2024.04.16.16.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 16:56:11 -0700 (PDT)
Message-ID: <eb963531-14ab-4bb3-be54-fe175b97df4f@linuxfoundation.org>
Date: Tue, 16 Apr 2024 17:56:10 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the kselftest tree with Linus' tree
To: Stephen Rothwell <sfr@canb.auug.org.au>, Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240415143901.578b3b4e@canb.auug.org.au>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240415143901.578b3b4e@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/14/24 22:39, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the kselftest tree got a conflict in:
> 
>    tools/testing/selftests/kselftest.h
> 
> between commit:
> 
>    f7d5bcd35d42 ("selftests: kselftest: Mark functions that unconditionally call exit() as __noreturn")
> 
> from Linus' tree and commit:
> 
>    5d3a9274f0d1 ("kselftest: Add mechanism for reporting a KSFT_ result code")
>    f07041728422 ("selftests: add ksft_exit_fail_perror()")
> 
> from the kselftest tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 

Rebased to Linux 6.9-rc4 and resolved these two merge conflicts
in linux-kselftest next.

thanks,
-- Shuah


Return-Path: <linux-kernel+bounces-73282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD95F85C074
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF241C22C08
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5045E762FB;
	Tue, 20 Feb 2024 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGmZRkNx"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BE72C6AA;
	Tue, 20 Feb 2024 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444750; cv=none; b=hITfHGzG5tLoBf+Zkmq74ungzEOeQEbvpI7X4eC4d/HenByndBIBY0/JOtAoDoFp4Hc+F60JDp/1uommQsfFPjVsWoVrt7DAFB9HcvYgb4hT+ShMq3PEUm/jWSwS0x55yrYNa/LC/8roj6ac73fBi7tKLJ7myAY0QAVW3PL50w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444750; c=relaxed/simple;
	bh=MOpHuZkqZuakUIIYoCBCmX4mX2x67w2XfxMFBtKZwT4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ryHYkIo6JesRyWixANsS0J4yD1qHJUDifGwvm0JEwGqeftOyWRk5QXdYHyfaqKyeRD9ukJT2PIuFH9Dxdm+axWBmfhr40BVgTDqpE9vpS1VbLsiLIDP2XsD25orUllX8AjIW0FiZf73BVB52AGHqKlrFnXyh7JxUUKiiMV7BXAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGmZRkNx; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7875c347a03so153067885a.0;
        Tue, 20 Feb 2024 07:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708444748; x=1709049548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCK0r275/9M5VcCk14uq8TLpwW3NBUK9EHRnNNnH/E0=;
        b=IGmZRkNx/cDtwoSV+gv53OE8VG3WXq2IoAiRzbMDt8h8KCF2ZClCn7EVYdh/2414sm
         7rK/Vbq7taxiUXy6HGW78QDRZO8tKpgVFU2UTMLCGKVIbOLIyLKhyojoE5aaz7T/75jP
         IMi/Zf1tDJaNldHelzOcWPwi2gwMYZp7NKuh8iAkLIezBzdBxIHBvz1IyrTmnhZKKu4J
         dr6qCSpXtq2C1LNOYYOjduyi4pOtQ/en6k39gPfsJUeloysxOp2YBOcCNjxcTDMYbI35
         vFvZwyAo+3AZbX+yDaxrGihYCxbBcdwltiIqGp6yturJBA1m3Ho55ji+Yq/dybQ1hJ1Y
         DUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708444748; x=1709049548;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lCK0r275/9M5VcCk14uq8TLpwW3NBUK9EHRnNNnH/E0=;
        b=PmJhtNOkVXECZjdXW1SyiJ86cOIVijawa3RLhDVSH58i875HGy1EtKTeACUuwcD7bd
         N+3rPWqheD3YfEPpZhk6ox4CMrdySYFgBuQdBXWrlA9UQwdc8NE4vscrfpxTwO2XVRMX
         hI9UDKT0WDhRI90hkDSTP4KYe0UKlsPeH/pOo26g9C3wp1j+kswBmDfRGVFOJ5O35NHN
         qmSjcJH2qqXbLs5PawFXsvvMbTwsxtMub+rOVBRq3r6+dYBdL/DDPQVsROGJqn5DnuYZ
         qbzg+ANgRh42dSK3qPG1NARzrHht7Pbo5xmsQif8KZdeQfzFteVoSUX+gWsESuQDaDHH
         PKEg==
X-Forwarded-Encrypted: i=1; AJvYcCUfs8qILZWfMQ1GjEgHFwZjxObQ4pjFeqqytKP5XBn2WxXQ1iGQHMt03RcQ8St6G2yXm3RKHcXWv7rX+7YDAGsFpsJvrAJeL9k7Ssps
X-Gm-Message-State: AOJu0YyuAZZmQt1oHjV9oR0Z9F1pwT5E4C0j5UN3JWyNBLvxeUPi5E4G
	3rdic6aUua0FtyqtC0uYpyWdCW16IOb6K1QzmTj2nRAh+yMvcPlP
X-Google-Smtp-Source: AGHT+IH2WxU0EK9I4jj96n6lU5LCcUmZuiR3qoOM3f38DHd/chGKyBEhzBZOP29c9beAvCffo4yEUg==
X-Received: by 2002:a05:620a:568f:b0:786:c1d1:ba6a with SMTP id wg15-20020a05620a568f00b00786c1d1ba6amr18740746qkn.25.1708444748045;
        Tue, 20 Feb 2024 07:59:08 -0800 (PST)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id e9-20020a37db09000000b00787549c6ff3sm3036257qki.68.2024.02.20.07.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:59:07 -0800 (PST)
Date: Tue, 20 Feb 2024 10:59:07 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yunjian Wang <wangyunjian@huawei.com>, 
 willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 kuba@kernel.org, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 brouer@redhat.com, 
 xudingke@huawei.com, 
 Yunjian Wang <wangyunjian@huawei.com>
Message-ID: <65d4cc4b88e56_23483829431@willemb.c.googlers.com.notmuch>
In-Reply-To: <1708398727-46308-1-git-send-email-wangyunjian@huawei.com>
References: <1708398727-46308-1-git-send-email-wangyunjian@huawei.com>
Subject: Re: [PATCH net] tun: Fix xdp_rxq_info's queue_index when detaching
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yunjian Wang wrote:
> When a queue(tfile) is detached, we only update tfile's queue_index,
> but do not update xdp_rxq_info's queue_index. This patch fixes it.
> 
> Fixes: 8bf5c4ee1889 ("tun: setup xdp_rxq_info")
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---
>  drivers/net/tun.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index bc80fc1d576e..be37235af55d 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -652,6 +652,7 @@ static void __tun_detach(struct tun_file *tfile, bool clean)
>  				   tun->tfiles[tun->numqueues - 1]);
>  		ntfile = rtnl_dereference(tun->tfiles[index]);
>  		ntfile->queue_index = index;
> +		ntfile->xdp_rxq.queue_index = index;
>  		rcu_assign_pointer(tun->tfiles[tun->numqueues - 1],
>  				   NULL);

Does it matter that this value is stale when undetached?

It is replaced in tun_attach if previously attached:

		/* Re-attach detached tfile, updating XDP queue_index */
                WARN_ON(!xdp_rxq_info_is_reg(&tfile->xdp_rxq));

                if (tfile->xdp_rxq.queue_index    != tfile->queue_index)
                        tfile->xdp_rxq.queue_index = tfile->queue_index;


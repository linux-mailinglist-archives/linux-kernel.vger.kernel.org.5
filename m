Return-Path: <linux-kernel+bounces-111087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A65368867B9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612CB2869EF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB1E171C9;
	Fri, 22 Mar 2024 07:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V979Jrjf"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734EE16429;
	Fri, 22 Mar 2024 07:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711094351; cv=none; b=Ffj6VcUGhXt9sXXllYMHiqLm9bpUra4ga6CYhcVm1nKahqgd+0qfS9BgP8D9rcPqwiCZWL6jFjpvAtJdpTJ1W6/ew1TnyIUYAHbAhOeKxX79IU8e6kVeKJy9GTUYVnG7WHC8JvNunSwAmQayn/UQqA0Hk1ploiwyQHOi2sJ/pZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711094351; c=relaxed/simple;
	bh=RUZ5/53DHnVGJizqo5Aou3AF5iR7J4ZbuYQ9yPxcxYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5sl7H7HUVceA3t5qiA2YvPbyMo0rd1QDVGhvojDwPG/oQf34A257s7b7L3Yn+VqPy5Ew8ALs2IqgALweYJ49YC/VQz2JdKyLqfcU2/31v6lrSMbsB23SY/gW+sJpGLnhgQ28BvOac1qhrvwSpi8CDxYj5JlgGRtddPCaurECRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V979Jrjf; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a46f97b8a1bso241178466b.0;
        Fri, 22 Mar 2024 00:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711094348; x=1711699148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Evota0EZ/I3ybP8XWAvtgwwod+AOlk4QbEeMKUypvQo=;
        b=V979JrjfTK5WT7/QRY9MvbCcoI9UaLZXTu3OSdVXIgXEVgjiiwg1CaSKdYbhRe6a+P
         JSPTO/KZJILmPq2cORuLMPOU3v5IMh+w8ANs2tAC/NoKBXztSOUzhW95NlZEYUytQZjs
         cQoy+3bK4UuTqjtcCkMI5kwp1I/wxXiAUSdtt82yr7qb5qUW4nONKryvGo/zHXI+WPcv
         9cAqb/MVDeV8EAHnJdjRVqfuMIccLtIuv8/HrszbHFB5jQ3/2sIaD6Becf+4T85H7krW
         WHen6lQ14QOGCawDPa5Tjmfgs4p3xYMl+utDxmSw1IVam44S4XHzmcIY/1A/z/JnQZdU
         UV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711094348; x=1711699148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Evota0EZ/I3ybP8XWAvtgwwod+AOlk4QbEeMKUypvQo=;
        b=RSkp6RyhYQmBx9r8jaeQvPK10+cZuvs4SLBx+5ZIS6K69+qNQAvgXU0kyDLkSYpsI8
         HpZOuZnu+CFa+R8blOvVbNdOsG7nLkwWaK0eO8aj7wppw7OFiGTl2A4b7cuCF91k6ys7
         e0Rst4ekOnWtpMD/pvZJAx9buMQaTqGxjThywK6//zt9HFUUORugm0dUSK1tUlYvrQp7
         nJiJHAuqx9lcjTbir4blyYerHMc9n5WiId7nmah9hNhZb3INP0y/OiIaSzhls2K3KzI7
         Awgm1PoQHEmiZhGYSG6pdQb1DdTDz+AzPvXi6v+IT4JaLJf+3cqx+89OaIGQFnrtmWQS
         emGA==
X-Forwarded-Encrypted: i=1; AJvYcCV265TyG8Znm0gCiGXr993nYdeFlCozmuzckR2N+e4fUB9S9TmvEkFvTavsFaqwX32uCfEmapy/BPVD5t9nu6shZCtXaDAjrQMIVnb43pTHZS6KcRd46p+r9fb11AD+JVTGN4bC
X-Gm-Message-State: AOJu0YyKgbEpL2VCOQV12DaRWjtmWTlBZKnold9Lkd70Jyf/7Qu6zjUB
	A79zAsGA498t4IbR/TI685NUvQBy09S5qsSnKNusFIrn+Xy4zD5ttHW77uANU4aplp5grANBRxE
	J2JyIPpfjSws6HLLbQTWxcBq9pCshG5T/DRk=
X-Google-Smtp-Source: AGHT+IHkR+Uv6+IgiN5dfa5Enx06mQZLfIB4lxnLzZNQy7D1C/g7lY+vQ4BsGOZEyOxg98z6/qnNJgOXSkr8CzIc/m8=
X-Received: by 2002:a17:906:6b17:b0:a46:4d16:439b with SMTP id
 q23-20020a1709066b1700b00a464d16439bmr1103225ejr.43.1711094347623; Fri, 22
 Mar 2024 00:59:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322072456.1251387-1-gaoxingwang1@huawei.com>
In-Reply-To: <20240322072456.1251387-1-gaoxingwang1@huawei.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 22 Mar 2024 15:58:30 +0800
Message-ID: <CAL+tcoDiSsqhef=aAAwRP92pNv=K43UE--T_MikxpmsTchxCaA@mail.gmail.com>
Subject: Re: [PATCH] netlink: fix typo
To: gaoxingwang <gaoxingwang1@huawei.com>
Cc: mkubecek@suse.cz, idosch@nvidia.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yanan@huawei.com, liaichun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 3:26=E2=80=AFPM gaoxingwang <gaoxingwang1@huawei.co=
m> wrote:
>
> Add missing colon in coalesce_reply_cb
>
> Fixes: ec573f209d (netlink: settings: add netlink support for coalesce tx=
 aggr params)

This commit cannot be found in net/net-next tree...

> Signed-off-by: gaoxingwang <gaoxingwang1@huawei.com>
>
> Signed-off-by: gaoxingwang <gaoxingwang1@huawei.com>

nit: two duplicated SoB

> ---
>  netlink/coalesce.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/netlink/coalesce.c b/netlink/coalesce.c
> index bc34d3d..bb93f9b 100644
> --- a/netlink/coalesce.c
> +++ b/netlink/coalesce.c

Where is this file? I suspect you're not using the standard mainline?

> @@ -93,7 +93,7 @@ int coalesce_reply_cb(const struct nlmsghdr *nlhdr, voi=
d *data)
>                  tb[ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES]);
>         show_u32("tx-aggr-max-frames", "tx-aggr-max-frames:\t",
>                  tb[ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES]);
> -       show_u32("tx-aggr-time-usecs", "tx-aggr-time-usecs\t",
> +       show_u32("tx-aggr-time-usecs", "tx-aggr-time-usecs:\t",
>                  tb[ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS]);
>         show_cr();
>
> --
> 2.27.0
>
>


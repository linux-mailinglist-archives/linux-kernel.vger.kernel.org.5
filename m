Return-Path: <linux-kernel+bounces-144676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1AF8A4914
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D1628535D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEF125601;
	Mon, 15 Apr 2024 07:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3le1Tgl"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C222374E;
	Mon, 15 Apr 2024 07:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713166353; cv=none; b=AsEp62SurCFBJT74BmNdu1iVDnLlPOuBbcp4jf3EOZqKa1cA/ZlafO1rVObClMhixi0PQVzsKeWn5iX+1RuRukAwDbxWBWq8bhaaNk6ALk1XnD5Xtx7oL8e7rWnp4cAXZAmVjBRbsS7WqQQ4Y3zdcyD281mFSnTto8BBqE6ZWco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713166353; c=relaxed/simple;
	bh=ds8rQwAgmdMOFBFo3sSml/CF/rMu8R1uc3x5Kf+BvfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLOJeLI+ID6kSWHU2XLA7EupX7zrP5+UZfElMrc9lAvin3g1RuL0ZfCKA3FHlwnqoeZIPwoQlbGm9pp8CYQwL5j3X5vIkB4NSCdGzoY88fGhWsXnpYj6J6CmWro1YBlTzEfIJTcZvPakiUdAP3h7/NIftTRJxPo/qC+Rr3dH+Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3le1Tgl; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ed2dc03df6so2602282b3a.1;
        Mon, 15 Apr 2024 00:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713166350; x=1713771150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WUmnixeG+B3BoDinJmPWqoj2FRLDOu7Npt2WWfE76BE=;
        b=a3le1TglTIUzRIUHnJ3lARVBhDrVlnnbcH8MKDeweI9pXnxO20A3Ir/soe6n8zwzQo
         3Sr+wTzlbxtOe8dsw6OixEjz6RAok8SkCpNxJFQcMPv7Y7q62wEJFard+Ohs7Cl7n3sg
         XUBSFlvuCt/lXr4s2VmKRql6IDVUAHWs4gMPtPqdlij17AR701SjxsW4SKcxL07ny8SG
         5pNIJtraMLYs/f/zZmysCcU98qgAp1BME343Mpbr7Ai906TinkQnVgLX4Rop5ScVHkHY
         8oRnmuKJq+GAVr+5JtgM1vPN8M1sXCtPkTRxb8Tgl41kvZutoZkXgoi5pwLVW83IEadR
         wyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713166350; x=1713771150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUmnixeG+B3BoDinJmPWqoj2FRLDOu7Npt2WWfE76BE=;
        b=KjervEOVMUN7XkpKmgpA26wFMLkXjfd/izY2ZbIr7hOpW8qyie1XHhqScCxWViq90Z
         q8hlzHcjwql1bn1bLhrGqaspSlKjxIV29VbNhleb+boU26TVQUsjyYAFIxXAFSmUmCMy
         dcx19Ap2tOB0tKt3WKq/gIf4CGyWHf6aeEO7a2CEpyH4pkO6jDn1Uc1qiyvGfDTaliVH
         QvU7CnAhbn2myZOqpFBoDq3sqaHBOha6QM4cK5+adWZ5w74z4o9loRZG0CE5Y7YD2tcg
         1ieyH3X/G020GT0WaczBNyto8CenWqAEBQcPkRfYiqsi46xgQ8wHuxlOjnI3U5Yj2xog
         bzgg==
X-Forwarded-Encrypted: i=1; AJvYcCU84hb4EzF+RmUiOHNOp/9cdOTwhoGc+Igwcr5oKM2746t+fY6++AKF40dEeqDSwrAEgETmh59hw6RmXS8IBweGDFKAf+Zo
X-Gm-Message-State: AOJu0YzkjW87M91TR7KNutUh6zPdBn219z5TOQVtKQtvl5knefYaG53Z
	Up914Pc3wJG0PrkKCDokbsK2HciqclxTz2hR0uSo/cbupDfQYDea
X-Google-Smtp-Source: AGHT+IGvPzw/HWjG2isFtpVTIoEB+NaFp3rSdwicdBEOVfAu+7O9238npZ8ia53S77vObL7HZZ8Ydg==
X-Received: by 2002:a05:6a00:1147:b0:6ee:1508:eda0 with SMTP id b7-20020a056a00114700b006ee1508eda0mr12879264pfm.18.1713166350099;
        Mon, 15 Apr 2024 00:32:30 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id z3-20020aa78883000000b006e5571be110sm6582831pfe.214.2024.04.15.00.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 00:32:29 -0700 (PDT)
Date: Mon, 15 Apr 2024 15:32:25 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	j.vosburgh@gmail.com, andy@greyhouse.net, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net v1] drivers/net/bonding: Fix out-of-bounds read in
 bond_option_arp_ip_targets_set()
Message-ID: <ZhzYCZyfsWgYWxIe@Laptop-X1>
References: <CAEkJfYPYF-nNB2oiXfXwjPG0VVB2Bd8Q8kAq+74J=R+4HkngWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEkJfYPYF-nNB2oiXfXwjPG0VVB2Bd8Q8kAq+74J=R+4HkngWw@mail.gmail.com>

On Mon, Apr 15, 2024 at 11:40:31AM +0800, Sam Sun wrote:
> In function bond_option_arp_ip_targets_set(), if newval->string is an
> empty string, newval->string+1 will point to the byte after the
> string, causing an out-of-bound read.
> 
> BUG: KASAN: slab-out-of-bounds in strlen+0x7d/0xa0 lib/string.c:418
> Read of size 1 at addr ffff8881119c4781 by task syz-executor665/8107
> CPU: 1 PID: 8107 Comm: syz-executor665 Not tainted 6.7.0-rc7 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:364 [inline]
>  print_report+0xc1/0x5e0 mm/kasan/report.c:475
>  kasan_report+0xbe/0xf0 mm/kasan/report.c:588
>  strlen+0x7d/0xa0 lib/string.c:418
>  __fortify_strlen include/linux/fortify-string.h:210 [inline]
>  in4_pton+0xa3/0x3f0 net/core/utils.c:130
>  bond_option_arp_ip_targets_set+0xc2/0x910
> drivers/net/bonding/bond_options.c:1201
>  __bond_opt_set+0x2a4/0x1030 drivers/net/bonding/bond_options.c:767
>  __bond_opt_set_notify+0x48/0x150 drivers/net/bonding/bond_options.c:792
>  bond_opt_tryset_rtnl+0xda/0x160 drivers/net/bonding/bond_options.c:817
>  bonding_sysfs_store_option+0xa1/0x120 drivers/net/bonding/bond_sysfs.c:156
>  dev_attr_store+0x54/0x80 drivers/base/core.c:2366
>  sysfs_kf_write+0x114/0x170 fs/sysfs/file.c:136
>  kernfs_fop_write_iter+0x337/0x500 fs/kernfs/file.c:334
>  call_write_iter include/linux/fs.h:2020 [inline]
>  new_sync_write fs/read_write.c:491 [inline]
>  vfs_write+0x96a/0xd80 fs/read_write.c:584
>  ksys_write+0x122/0x250 fs/read_write.c:637
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> ---[ end trace ]---
> 
> Fix it by adding a check of string length before using it.
> 
> Reported-by: Yue Sun <samsun1006219@gmail.com>

Not sure if there is a need to add Reported-by yourself if you are the author.

Also you need a Fixes tag if the patch target is net tree.

> Signed-off-by: Yue Sun <samsun1006219@gmail.com>
> ---
>  drivers/net/bonding/bond_options.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/bond_options.c
> b/drivers/net/bonding/bond_options.c
> index 4cdbc7e084f4..db8d99ca1de0 100644
> --- a/drivers/net/bonding/bond_options.c
> +++ b/drivers/net/bonding/bond_options.c
> @@ -1214,7 +1214,8 @@ static int bond_option_arp_ip_targets_set(struct
> bonding *bond,
>      __be32 target;
> 
>      if (newval->string) {
> -        if (!in4_pton(newval->string+1, -1, (u8 *)&target, -1, NULL)) {
> +        if (!(strlen(newval->string)) ||
> +            !in4_pton(newval->string + 1, -1, (u8 *)&target, -1, NULL)) {
>              netdev_err(bond->dev, "invalid ARP target %pI4 specified\n",
>                     &target);

Do we need to init target first if !(strlen(newval->string)) ?

Thanks
Hangbin
>              return ret;
> -- 
> 2.34.1


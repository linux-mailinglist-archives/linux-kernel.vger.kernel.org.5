Return-Path: <linux-kernel+bounces-146585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA038A67A2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252BE28304D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DAB86ADC;
	Tue, 16 Apr 2024 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLSwLxUI"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1062283CBD;
	Tue, 16 Apr 2024 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713261831; cv=none; b=CCTbutw7sOoqETZSePZD7NHexKt2y4w5USUwcjrnvIl2H7+PwR5jQzwpFPKZxvkymuomsHaVwAFou77Rl3znKGbF0m3y+dFGhTwIogADdgUNbLwi1BU+KzVMberjkBjCj4hmiJUymNSdroIgUkKX4rPGd/YO1+3W5x+uPq3CHHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713261831; c=relaxed/simple;
	bh=Bb1D3KrKedP6JVJJvJg6ZDfHxFVvZygGKN9CvvTV7co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrFJMdNTq+m7GEmEt5FQVVGOACdJNhtZuRzqYnDZb6bWY3BkREFc8ni/wDodUZmvedrz4Q3FMWZ8ewIYnsn+7QX9T0KRrAr9Rx7WarUP+71/Jeq7NJ5mlubecmXKA2JAaSBziAGihZ5CWJ2XRTIgg13R0uXXqy+dYt+u81iSa3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLSwLxUI; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2a526803fccso2397173a91.1;
        Tue, 16 Apr 2024 03:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713261829; x=1713866629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XDnwsDO84mVc+05BpNmMsEUqsfPZm5hg+4IFgnGZSy4=;
        b=SLSwLxUIXbPXcwJla0a+DJsPbHpqNIPEjMnkUB4Ao7Kly8rQCMo97tNrV96orh0vGs
         KIxvyx3XxoR1keQURbGVVZTqtNT7kCh/33V0NOYiqKnHqHUNyxudJA3uud6pjbQeTh0t
         Mnh2g2lNc089L0Zo8abJ/wgZ9q269c/Jxw/Akl8gjo29FWBX1yL0t1KgCEk4KhxpNxEW
         D5nSlCOXWJdhr1SSQpBjC4noN2YoxXDjzD02WyWMmJWe2wzmw9u+BhVE8F8WwVfHG460
         vNY51ECaShDRyUcM5JY3tRsx2o5kfyzFCx7thUQKsoEvxJaUuUOtyjYXKn3HWZyhBlo8
         zwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713261829; x=1713866629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDnwsDO84mVc+05BpNmMsEUqsfPZm5hg+4IFgnGZSy4=;
        b=heJjQrltLHGNMFVnSTa91si3cVJdCBxCSyBNJJD1Dai02IW3Ui8nQre+S266crflBx
         /Hs+xVW1PF8ZPykfvpR1Fp1XiK6Wm5EAXo9jDs9n/MumSXOYvBNguX5ZtCYRml3F2EvG
         3AFD1FcSOxo2B0h+JtHpsiKj7r1Vh+aYeuNPkZ7KzEoMVP+3jP0YylJ/aK68HTiuk8ux
         GgbWYHsZjp675uHTv9ZhR3/HajWkKF3UyjVbxGA5wnW1tTkw+ZItyGXTyMotBDgMYJ5h
         n/kEMsbsrFscUIFyM2d8dWvbgmu056Cxfkqg4zeghMYBEBibzdXY9Im32WUCMOYuZ2ig
         selQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH0AZo26UDyUbGX/FRh7ocgjy5DnuPQdcRowB108mbZOLhGAy++mNpOw4zvJFpv8g0ZRCHYRwVlhuXCrCWh0OQkgwYgf+Q
X-Gm-Message-State: AOJu0Yw1TKK5c2xGA9cR3aoDLpK5ZOz/zC1pRkfgG0aUSfPBIkWfSfRf
	XroMcsJVZ/mpTvaOHy5xn8r6Tz0JH6c9n0OYcI6vKR2LzGzHzG6h
X-Google-Smtp-Source: AGHT+IHHqBLvFvHLCTH0SiKYfmmW5OcnrBkFzfxkUpPRn/7IyGJGSmwwgeBwqOXW7VvBFu73J4Oq1w==
X-Received: by 2002:a17:90a:fb82:b0:2a5:2db0:cc9a with SMTP id cp2-20020a17090afb8200b002a52db0cc9amr12022268pjb.15.1713261829338;
        Tue, 16 Apr 2024 03:03:49 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id f22-20020a17090ace1600b002a25bf61931sm10410194pju.29.2024.04.16.03.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 03:03:48 -0700 (PDT)
Date: Tue, 16 Apr 2024 18:03:43 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sam Sun <samsun1006219@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	j.vosburgh@gmail.com, andy@greyhouse.net, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net v2] drivers/net/bonding: Fix out-of-bounds read in
 bond_option_arp_ip_targets_set()
Message-ID: <Zh5M_9K3g6-9U2VA@Laptop-X1>
References: <CAEkJfYMdDQKY1C-wBZLiaJ=dCqfM9r=rykwwf+J-XHsFp7D9Ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEkJfYMdDQKY1C-wBZLiaJ=dCqfM9r=rykwwf+J-XHsFp7D9Ag@mail.gmail.com>

On Tue, Apr 16, 2024 at 03:28:02PM +0800, Sam Sun wrote:
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
> Fix it by adding a check of string length before using it. Remove
> target address in netdev_err message since target is not initialized
> in error path and will not provide useful information.
> 
> Fixes: 4fb0ef585eb2 ("bonding: convert arp_ip_target to use the new option API")
> Signed-off-by: Yue Sun <samsun1006219@gmail.com>

I think the fixes tag should be

f9de11a16594 ("bonding: add ip checks when store ip target").

Thanks
Hangbin

> ---
>  drivers/net/bonding/bond_options.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_options.c
> b/drivers/net/bonding/bond_options.c
> index 4cdbc7e084f4..8f3fb91897b3 100644
> --- a/drivers/net/bonding/bond_options.c
> +++ b/drivers/net/bonding/bond_options.c
> @@ -1214,9 +1214,9 @@ static int bond_option_arp_ip_targets_set(struct
> bonding *bond,
>      __be32 target;
> 
>      if (newval->string) {
> -        if (!in4_pton(newval->string+1, -1, (u8 *)&target, -1, NULL)) {
> -            netdev_err(bond->dev, "invalid ARP target %pI4 specified\n",
> -                   &target);
> +        if (!(strlen(newval->string)) ||
> +            !in4_pton(newval->string + 1, -1, (u8 *)&target, -1, NULL)) {
> +            netdev_err(bond->dev, "invalid ARP target I4 specified\n");
>              return ret;
>          }
>          if (newval->string[0] == '+')
> -- 
> 2.34.1


Return-Path: <linux-kernel+bounces-144975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8EF8A4D73
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87D10B230DA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F185EE73;
	Mon, 15 Apr 2024 11:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJepF66z"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417BC5D497;
	Mon, 15 Apr 2024 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713179821; cv=none; b=SukBS8haSluXlC7Yl6nItohGcjsspKNW5iIlyxHTHO0o43n7h3dp0mnpXlGcdHowuKzz1xbe2/bYyFg6zItBNq3fSxO/VdaRFEtiwjR1miMyYdumNO4gUElMtVzi1PaXYF7yew2P6xtrPLAyLeokwuSFJE5huhyL1bZ/Ad3w+rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713179821; c=relaxed/simple;
	bh=X6660uQgxaGiaIQ8QGh4i6N24apbQOESikWJD5zAAJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1312F4QLRsKRh6vG5dThlywBdStEz2reC54/SrdoYNtSsRJlnR/xcey/LRIi4lvI8gdEX2dMLzaiWqybxey/mwI8nVH1pFDb8cI+B2v4EXxTsiyHzP763jApI0g1nMkEQ58ZG/ulGdkTo19tI7KFO5tUvM3M2I2Y95enyO/XGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJepF66z; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5ac8c73cf88so1419267eaf.2;
        Mon, 15 Apr 2024 04:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713179819; x=1713784619; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fBm8RL97F+4qf+V4jDEUa/P8XnHDDN6lRk7BTnH7EBg=;
        b=NJepF66zd46UWpOHBrXKuhQwyc906emAw7KXVAYxC0RjFB5P9fCZGtxlmpk4YRXgs3
         drzu9WBWXxgNksEOQjiOJYReUrRarCmZmwnssd4nXYGBWFnKuHP/41048BbNeZwgucna
         C0mG3ZzVYd9jOnakOIilNmirZDD5WiFqA79sW000o4jIvCb1epQMII4OPm/Uo73y08LS
         8rEgXn8Ccw45ugC2461pFd7k3BB+0DrU4NzRnpmZzoGKabP3A4oqyMB3yOMVpmuhK+6r
         2MHcRE6PX3q0C0zjRzMom9HLuHbm6sywILcKJ0p7cJa0NQGqh0S9dex5OeFIACNYZaNG
         2ApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713179819; x=1713784619;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fBm8RL97F+4qf+V4jDEUa/P8XnHDDN6lRk7BTnH7EBg=;
        b=NlRI+ybXZ2W4lQrHRTb+9qgO5oEQqARuSU22uzgVEUxGuJia0s2Z/ye8d6LRCpqeny
         JbujpjNbo50F1QmGGfNWje2POFkrxPT9B7xJEoGT5QUBTLHYxFvovaKfOh+O848g2/0l
         hDgr7OGdFIB3+XaKBRWHtoKM+Qy9W2lC+bhH3h/YM06bhxKGXkIJAnT7eCFaOrBfmb+q
         0zFNTCGnYPCgxdg3jGYlJaqhAly9FmpYmX90gwPjtMAv3KVT7ucrYNHhaLdLJ4MjQ8x2
         1ED0BuVtu5ZKSVqntx4T+pZAyFqdXriRo5ng3EXx+Zg5Xd7f+7MZnCf+u45eiFcgG7P6
         izsA==
X-Forwarded-Encrypted: i=1; AJvYcCU30yz7F+DbjU8g+mi3nvOeNpVKn87AWl9Io8F/s8Mx3oNQbC0zYimb9w6vQ5fLu9Xi+45xYvgBLmrvG7L4h5LxMQ2UQdpqqyMbf+GXo/9RuxEi+ZvwRKKcTujTGe1t0EjCMM8uYOJ1ClykLTRRXeLdmZOLq0Z16N+SAou3AvzuJg==
X-Gm-Message-State: AOJu0Yz1m+YZUK2GKJlS/XymuIb3v7ujZBYg0ynn/sdbUauy+XvC/zQI
	WozUyaP55e/yR/EXmqTI/oik70PyJrAl1ydfr/tYRG+9toeKGzAb
X-Google-Smtp-Source: AGHT+IH35/Ea+3kQfyCxitEFQt0LWntwk8N74targm/HyvPhzvq+hRJ7l8zdT2FzJFYvsfun8aGwHg==
X-Received: by 2002:a05:6358:378b:b0:186:431:d9be with SMTP id m11-20020a056358378b00b001860431d9bemr8044722rwe.19.1713179819254;
        Mon, 15 Apr 2024 04:16:59 -0700 (PDT)
Received: from libra05 ([143.248.188.128])
        by smtp.gmail.com with ESMTPSA id q1-20020a634301000000b005e43cce33f8sm6768154pga.88.2024.04.15.04.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 04:16:59 -0700 (PDT)
Date: Mon, 15 Apr 2024 20:16:54 +0900
From: Yewon Choi <woni9911@gmail.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Dae R. Jeong" <threeearcat@gmail.com>
Subject: Re: net/smc: Buggy reordering scenario in smc socket
Message-ID: <Zh0Mpr5fZqFUGzkb@libra05>
References: <Zh0JLYHtd0i416XO@libra05>
 <CAFgxCDwA8Lv8LLwEpJur3FKs=Gkkc0KE=bx7Q1Do2+iwdAzoCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFgxCDwA8Lv8LLwEpJur3FKs=Gkkc0KE=bx7Q1Do2+iwdAzoCw@mail.gmail.com>


On Mon, Apr 15, 2024 at 8:02 PM Yewon Choi <woni9911@gmail.com> wrote:
> Hello,
> we suspect some buggy scenario due to memory reordering in concurrent
> execution
> of setsockopt() and sendmmsg().
>
> (CPU 1) setsockopt():
>     case TCP_FASTOPEN_NO_COOKIE:
>         ...
>         smc_switch_to_fallback():
>             clcsock->file = sk.sk_socket->file; // (1)
>             clcsock->file->private_data = clcsock; // (2)
>
> (CPU 2) __sys_sendmmsg():
>     sockfd_lookup_light():
>         sock_from_file():
>             sock = file->private_data; // (3)
>     ...
>     fput_light(sock->file, fput_needed): // (4)
>         fput():
>             refcount_dec_and_test(sock->file->f_count) // null-ptr-deref
>
> There is no memory barrier between (1) and (2), so (1) might be reordered
> after
> (2) is written to memory. Then, execution order can be (2)->(3)->(4)->(1)
> and (4) will read uninitialized value which may cause system crash.
>
>
> This kind of reordering may happen in smc_ulp_init():
>
> (CPU 1) smc_ulp_init():
>     ...
>     smcsock->file = tcp->file; // (5)
>         smcsock->file->private_data = smcsock; // (6)
>
> Execution order can be (6)->(3)->(4)->(5), showing same symptom as above.
>
>
> One possible solution seems to be adding release semantic in (2) and (6).
>
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 4b52b3b159c0..37c23ef3e2d5 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -921,7 +921,7 @@ static int smc_switch_to_fallback(struct smc_sock
> *smc, int reason_code)
>         trace_smc_switch_to_fallback(smc, reason_code);
>         if (smc->sk.sk_socket && smc->sk.sk_socket->file) {
>                 smc->clcsock->file = smc->sk.sk_socket->file;
> -               smc->clcsock->file->private_data = smc->clcsock;
> +               smp_store_release(&smc->clcsock->file->private_data,
> smc->clcsock);
>                 smc->clcsock->wq.fasync_list =
>                         smc->sk.sk_socket->wq.fasync_list;
>                 smc->sk.sk_socket->wq.fasync_list = NULL;
> @@ -3410,7 +3410,7 @@ static int smc_ulp_init(struct sock *sk)
>
>         /* replace tcp socket to smc */
>         smcsock->file = tcp->file;
> -       smcsock->file->private_data = smcsock;
> +       smp_store_release(&smcsock->file->private_data, smcsock);
>         smcsock->file->f_inode = SOCK_INODE(smcsock); /* replace inode
> when sock_close */
>         smcsock->file->f_path.dentry->d_inode = SOCK_INODE(smcsock); /*
> dput() in __fput */
>         tcp->file = NULL;
>
> I think we don't need memory barrier between (3) and (4) because there are
> critical section between (3) and (4), so lock(lock_sock/release_sock) will
> do this.
>
>
> Could you check these? If confirmed to be a bug, we will send a patch.
>
> Best Regards,
> Yewon Choi
>

Additionally, we found that below line (1) in smc_ulp_init() triggers 
kernel panic even when normaly executed. 

smc_ulp_init():
    ...
    tcp->file = NULL; // (1)

It can be triggered by simple system calls: 
    int sk = socket(0xa, 0x1, 0)
    setsockopt(sk, 0x6, 0x1f, "smc", sizeof("smc"))

[350998.391059] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000018
[350998.391980] Mem abort info:
[350998.392288]   ESR = 0x0000000096000006
[350998.392691]   EC = 0x25: DABT (current EL), IL = 32 bits
[350998.393252]   SET = 0, FnV = 0
[350998.393586]   EA = 0, S1PTW = 0
[350998.396496]   FSC = 0x06: level 2 translation fault
[350998.399755] Data abort info:
[350998.400720]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
[350998.402329]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[350998.404023]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[350998.405543] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000047e44000
[350998.406735] [0000000000000018] pgd=080000004b288003, p4d=080000004b288003, pud=080000004aea9003, pmd=0000000000000000
[350998.409243] Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
[350998.409996] Modules linked in:
[350998.410404] CPU: 1 PID: 2936860 Comm: tls Not tainted 6.8.0-rc5-00163-gffd2cb6b718e-dirty #45
[350998.411462] Hardware name: linux,dummy-virt (DT)
[350998.412050] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[350998.412923] pc : fput+0x20/0x188
[350998.413349] lr : __sys_setsockopt+0xb4/0xc0
[350998.413889] sp : ffff800080443d90
[350998.414325] x29: ffff800080443d90 x28: ffff0000051cc740 x27: 0000000000000000
[350998.415218] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
[350998.416112] x23: 0000000000000004 x22: 00000000004613c8 x21: 000000000000001f
[350998.417007] x20: 0000000000000006 x19: 0000000000000000 x18: 0000000000000001
[350998.417909] x17: ffffc369333ee3cc x16: ffffc36933410ad8 x15: ffffc369335203a8
[350998.418797] x14: ffffc36933520188 x13: ffffc36932426dc0 x12: ffffc36932426cf4
[350998.419621] x11: ffffc36932426bec x10: ffffc36933522a34 x9 : 0000000fffffffe0
[350998.420447] x8 : ffffc3693351ef8c x7 : ffff00000a790578 x6 : ffff00000a790558
[350998.421273] x5 : ffff00000a790420 x4 : ffff0000051cc740 x3 : 0000000000000001
[350998.422105] x2 : 0000000000000000 x1 : 0000000000000018 x0 : ffffffffffffffff
[350998.422932] Call trace:
[350998.423231]  fput+0x20/0x188
[350998.423583]  __sys_setsockopt+0xb4/0xc0
[350998.424041]  __arm64_sys_setsockopt+0x28/0x38
[350998.424557]  invoke_syscall+0x48/0x114
[350998.425006]  el0_svc_common+0x3c/0xe8
[350998.425444]  do_el0_svc+0x20/0x2c
[350998.425844]  el0_svc+0x34/0xb8
[350998.426235]  el0t_64_sync_handler+0x13c/0x158
[350998.426749]  el0t_64_sync+0x190/0x194
[350998.427187] Code: aa0003f3 d503201f 92800000 91006261 (f8e00020) 
[350998.427893] ---[ end trace 0000000000000000 ]---
[350998.428460] Kernel panic - not syncing: Oops: Fatal exception
[350998.429126] SMP: stopping secondary CPUs
[350998.429617] Kernel Offset: 0x4368b2400000 from 0xffff800080000000
[350998.430335] PHYS_OFFSET: 0x40000000
[350998.430752] CPU features: 0x0,00000021,7002014a,2140720b
[350998.431371] Memory Limit: none
[350998.431741] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---

Could you check this, too?

Yewon Choi


Return-Path: <linux-kernel+bounces-95051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5714387489E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12577284C40
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D79F1D555;
	Thu,  7 Mar 2024 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leCBMQTO"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7AF3D6B;
	Thu,  7 Mar 2024 07:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709796240; cv=none; b=ooaK79J+a9aHSPCY6xuWtC1thyNcb5aBHXsvf/ftnmaRRMWXiydYSiYGl74hsH5LtxDvMK86jWNMbUrJ+JOKuAWHMmIjrpL0UJ7BT8+AjmQB9KaYMo8yRQaVZEjB9+in0J1EjLXYQP0P8NdWsjXOumosHnJhc0i0pe4cxq+PmdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709796240; c=relaxed/simple;
	bh=gjISR60uq+ya8maqdsGJ9wHx3jkUl2ijmsJeV0ROz/k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=S8bNIhNcqG+L/Je/uOMoWp8ryFboSbgErSocdhlHPHZw9SpqnWtuLprvVcTUZPgdFGHk2N9zHjNrhUNkyNmpHAZCaPYJgEksN1FUTtpgaxS32vJ1/P0o1Lus9yXskZfzOj4mRTfMF+slpndLSRLsjxHBnH/MHzEnQ41xKKef7R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leCBMQTO; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5a136ac89b3so285756eaf.0;
        Wed, 06 Mar 2024 23:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709796238; x=1710401038; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VIH6l6TAaG5Cqe0bpJodgiCiZ7ro0zZHdOeKB9khDLM=;
        b=leCBMQTOEYP8V8TBnHbpA+43I3Yq+B59AKDMgX5VXkUr65j07+uNjXwRh7fzsM5OQO
         iokqFbIbeSSQy3DxMWmPOzecUAkn7Cszc+HoFd2NvJprgpAkWC579rlqr8+iqklchwJZ
         NMpcE/O9uy+qcz816YHuASa4oIvU9I04ycsI18jIdDn9uufTYj74+Gaj/2KwYHOTz//U
         leVGex12iGYwXSWsGx929jBzPUyiaFPRJKzqUj8xqKhA6iHD+WMQExz7Gy1Hn9zKdwbk
         OMm3rlKISNqevo2e79MjH6WLz2auA8MmRVv7Z/sOtv882lqYcuzvF+rHXZslAh30FIX0
         atBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709796238; x=1710401038;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VIH6l6TAaG5Cqe0bpJodgiCiZ7ro0zZHdOeKB9khDLM=;
        b=CNBd017UXPcnWPeXEE6QkuA8BKEbc6EC4pwHOvQAPQ+NyyNloe/PxTLF5RMrmpbIrt
         cGNQYyM8oK2gnIPQkRUxzArWIB1hvwxDSW2kJGxsEXLXaE2cP5caqHOlPmpdVj81Qik4
         6wGAe4dNRZivOS9i8Ft/d4dvOHkX0acc1nG3FCGKLeCaLKeJzkT50OBbFaovz/vZWn6i
         I+37NDdQR5/gpYgC3z9H2TdF+EgGgsh8Dwl62ROebob5ZyHtNSj2eWP2Je7kUuITVmHm
         xnaDFQfNRbye/f8/h/vNuWclingTsvtGQKfkXQ1Gy0xsFC9xW0PXFQrNHAcY9n386eiQ
         5iuA==
X-Forwarded-Encrypted: i=1; AJvYcCWD5BUNIZwqnbp4UIfuLYD6O13oPM6rwL1GHH6SsCWAFe+6MY1i0R2mpdqpnAtJ/VUkeXPHZR/Qvx9zgpiZV6DY9GX4Rbk0iDgR8AhoEmaraa9QeVd7FhDm2bCHjF/pRKOEwWWlEJ2p
X-Gm-Message-State: AOJu0Yypuz4nvU1niIGRhx+kiJsATrNVY0R9LDiPkuqLB/t6aT4Ci8YA
	mwbWjqKHbPbccp4J56nGifwS/Sk96uCnK8cT4DoSJxH98HliYvWXLEz80iMDzwm1WhZ2FtevzeV
	WXtThAOHXoxg9pB8wnLwO/Jkcu/TOsOS1wGw=
X-Google-Smtp-Source: AGHT+IG9cC2X8lydTyGZzxOiU0q07paTCuhvnq6di0s3iUThXYVZjzJDvz+n3zDfUs1nhEsOpl2RWJu4bu2IRNkQY2A=
X-Received: by 2002:a4a:3159:0:b0:5a1:b4d7:c8e9 with SMTP id
 v25-20020a4a3159000000b005a1b4d7c8e9mr709957oog.1.1709796237514; Wed, 06 Mar
 2024 23:23:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?5YiY6YCa?= <lyutoon@gmail.com>
Date: Thu, 7 Mar 2024 15:23:46 +0800
Message-ID: <CAEJPjCvT3Uag-pMTYuigEjWZHn1sGMZ0GCjVVCv29tNHK76Cgg@mail.gmail.com>
Subject: A bug was found in Linux Kernel 5.15.148 and 5.15.150: KASAN:
 use-after-free in xfs_allocbt_init_key_from_rec (with POC)
To: leah.rumancik@gmail.com, djwong@kernel.org, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi upstream community,

I was fuzzing a LTS version of Linux kernel 5.15.148 with my modified
syzkaller and I found a bug named "KASAN: use-after-free in
xfs_allocbt_init_key_from_rec".

I tested the PoC on 5.15.148, 5.15.149 and 5.15.150 with sanitizer on
and found sanitizer through a panic as "KASAN: use-after-free in
xfs_allocbt_init_key_from_rec" on 5.15.148 and 5.15.150, but there was
no panic and sanitizer error in 5.15.149.

The syzkaller log, report, kernel config, PoC can be found here:
https://drive.google.com/file/d/1w6VKKewt4VQzb9FzcGtkELJUOwd1wMcC/view?usp=sharing

# Analysis (rough):
Because that I cannot understand the report0 clearly in the zip file
above, so I rerun the PoC on my vm (5.15.148) and I get another report
named as the same but it looks much clearer than the report0. The new
report can be found in:
https://drive.google.com/file/d/1Vg_4Qwueow6VgjLrijnUB8QbZVx902sv/view?usp=sharing
In this report, we can easily see that the memory allocation and free:
Allocation:
```
[   62.995194][ T6349] Allocated by task 6343:
[   62.995610][ T6349]  kasan_save_stack+0x1b/0x40
[   62.996044][ T6349]  __kasan_slab_alloc+0x61/0x80
[   62.996475][ T6349]  kmem_cache_alloc+0x18e/0x6b0
[   62.996918][ T6349]  getname_flags+0xd2/0x5b0
[   62.997335][ T6349]  user_path_at_empty+0x2b/0x60
[   62.997782][ T6349]  vfs_statx+0x13c/0x370
[   62.998193][ T6349]  __do_sys_newlstat+0x91/0x110
[   62.998634][ T6349]  do_syscall_64+0x35/0xb0
[   62.999033][ T6349]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
```
Free:
```
[   62.999776][ T6349] Freed by task 6343:
[   63.000135][ T6349]  kasan_save_stack+0x1b/0x40
[   63.000555][ T6349]  kasan_set_track+0x1c/0x30
[   63.001053][ T6349]  kasan_set_free_info+0x20/0x30
[   63.001638][ T6349]  __kasan_slab_free+0xe1/0x110
[   63.002206][ T6349]  kmem_cache_free+0x82/0x5b0
[   63.002742][ T6349]  putname+0xfe/0x140
[   63.003103][ T6349]  user_path_at_empty+0x4d/0x60
[   63.003551][ T6349]  vfs_statx+0x13c/0x370
[   63.003943][ T6349]  __do_sys_newlstat+0x91/0x110
[   63.004378][ T6349]  do_syscall_64+0x35/0xb0
[   63.004841][ T6349]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
```
So this is a use-after-free bug: allocated by `kmem_cache_alloc` and
freed by `kmem_cache_free`.
And according to the report, the UAF occurs in
`xfs_allocbt_init_key_from_rec`, `key->alloc.ar_startblock =
rec->alloc.ar_startblock;` which indicates that maybe
`rec->alloc.ar_startblock` was freed before.

# Step to reproduce:
1. download the zip file
2. unzip it
3. compile the kernel (5.15.148, 5.15.150) with kernel_config
4. start the kernel with qemu vm
5. scp repro.c to the vm
6. compile the repro.c and run it: gcc repro.c -o exp && ./exp
7. you will see the KASAN error

# Note:
I didn't find any related reports on the internet, which indicates
that it may be a 0day. Hope the upstream can help check and fix it.
And I'll be happy to provide more information if needed.

Best,
Tong


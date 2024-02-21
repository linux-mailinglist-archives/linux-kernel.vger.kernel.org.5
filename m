Return-Path: <linux-kernel+bounces-74295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F3185D267
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3433285760
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520093BB4C;
	Wed, 21 Feb 2024 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="Yg7xS3CF"
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5B33A8F5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 08:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708503620; cv=none; b=MFSHsxs4sOkSqhQ+wCtwSZB7rkWsReWWsIs56pCMgVJ2C3DD/CSE8pXte9CgGdY4wvYOL+eo0YDYhS6T4yutwigpscmI7hNX61yuyCFE4LTbSdd+zc6LkgdyydwTGoljJ9owWIjTQjZiMQjtNzujwXsmsJu8P3zcDuTfKrXa7RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708503620; c=relaxed/simple;
	bh=Um5+f0FrZXtSaIH4pDGP51HZ/k5cYcZctwOZ85WPZXI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hKrMGVxinJLeA67UJq54c9ef+px2qkMfp+hZdrnuxbfAAhTlCWfFZZmAEfe3KAS1dakGfxQqvfjhT08YfnM6/aw0eAJ61S7+ODGTmfqZSdUzvBVXbrE+UzsHIpg7+dzOwpoutT7E9ArS9qHP26DZQgHHGcrmcHcwXmBQKYANm0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=Yg7xS3CF; arc=none smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-2d22b8801b9so4619621fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 00:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1708503616; x=1709108416; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MysAWxNbCc//vI31BIPucjF70SlQY+heO/NoaZw6Ql0=;
        b=Yg7xS3CFYTRmwGdoznfV03gBYlzWeVYBuJDYIY9p++62+//JEA/piPCIEZc1ywA/5L
         QTBELrLGL/kmhsGf+l3s1vjd/WIsswkDl/MO2Oyq/moNjsDK7kfptQBV8LLbaxZ03wrT
         vRldgqVmkP98M9MSr1gy2/z4A/pSxJ0gKfqerV93pAxhY0ssd/eT4mLXTr1cUwk6+r+T
         AR+cng8Os3grgQjVy8mnXz3i+vD+d36KPQBrnNgJRwbidqCOIhMkkQvLzz4JMCBX1rjj
         UWUoMj6xXjMXCQzheqzxs6J4l+hFEENDssvngNU17ksbHgkVfKdTLabhvkLa8GwrmRYH
         fo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708503616; x=1709108416;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MysAWxNbCc//vI31BIPucjF70SlQY+heO/NoaZw6Ql0=;
        b=ocE8iFQ3y9Q7LzA5qcah5jiWPDefwc4xpRi4idpeJucg3R2anKxDM0TwNw+Z3rcJNh
         0rplZZ/3immMtjWBX3/uXsmHdJHN/xhI4IBvco1B8uNeXa8PFX+nTNRcQow0gCInssIe
         /5MYgvXX1AST7tjl0T4vfXiS4Mb3vV5VmCddzFiHRVdeGyvrUMnZZPre1M87R97PPhc9
         tD6LMzOwABXGBl5kUEKoZEkxHCfQlE06A7wCO8T9/yrBhA8EGpfErCQ2gmd/HdFhJL2J
         jBeDFAKtzJhrsS3L6rZz1DkcK93qTxkULJeXIfx14mv1Nx8c3TQrGTXskED50WyItU32
         /kNg==
X-Forwarded-Encrypted: i=1; AJvYcCWgsT04FJiHu0D2Dji5w+VRxSF+EFf71rEfbAPh/i5CJa6mY/MCQqodvYx45Yl7XWxq1ugbhTMzOQ6/BMoSNb8HF43z0JwYjP+lwepi
X-Gm-Message-State: AOJu0YxlcdqO/PKf+JR/kzNuoFMfqVTGVc2ocFy09gaB/Eh8/L33+JZW
	AFI9qNuyq88AqcwQ/qaydGQ5OPvH/gjSF8PtfeL3EAweDtZ1OUxJdsJf+PFZ1hTuwWB4N/pJq3w
	9O1KaDktM0oAn70xIlCRINnlP2YQsZKgB9ug1HQ==
X-Google-Smtp-Source: AGHT+IG8BAQ2Gu7OHNA4ftEbbbJU0FZLf8ClOhtXCEcoK/cXoZTQ08otPgZ5OHMjQYFAHngVnpgUaRS9PGRBqGW2S08=
X-Received: by 2002:a2e:9790:0:b0:2d2:3db6:b168 with SMTP id
 y16-20020a2e9790000000b002d23db6b168mr4391133lji.14.1708503615614; Wed, 21
 Feb 2024 00:20:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zhitao Li <zhitao.li@smartx.com>
Date: Wed, 21 Feb 2024 16:20:02 +0800
Message-ID: <CAPKjjnrYvzH8hEk9boaBt-fETX3VD2cjjN-Z6iNgwZpHqYUjWw@mail.gmail.com>
Subject: PROBLEM: NFS client IO fails with ERESTARTSYS when another mount
 point with the same export is unmounted with force [NFS] [SUNRPC]
To: Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ping Huang <huangping@smartx.com>
Content-Type: text/plain; charset="UTF-8"

Hi, everyone,

- Facts:
I have a remote NFS export and I mount the same export on two
different directories in my OS with the same options. There is an
inflight IO under one mounted directory. And then I unmount another
mounted directory with force. The inflight IO ends up with "Unknown
error 512", which is ERESTARTSYS.

OS: Linux kernel v6.7.0
NFS mount options: vers=4.1


- My speculation:
When the same export is mounted on different directories with the same
options, superblock and sunrpc_client will be shared. Unmount with
force will kill all rpc_tasks with ERESTARTSYS in rpc_killall_tasks().
However, no signal gets involved in this case. So ERESTARTSYS is not
handled before entering user mode.

I think there are two unexpected points here:
1. The inflight IO should not fail when I unmount another directory,
though the two directories share the same export.
2. "ERESTARTSYS" should not be seen in user space. EIO may be better.


- Reproduction:
1. Prepare some NFS export, nfsd or nfs-ganesha. For example, the
export is "ip:/export_path".
2. On the latest stable mainstream Linux kernel v6.7.0, mount the
export into two different directories with the same options:
      mount -t nfs -o vers=4.1 ip:/export_path  /mnt/test1
      mount -t nfs -o vers=4.1 ip:/export_path  /mnt/test2
3. Start an inflight IO in "/mnt/test1":
      dd if=/dev/urandom of=/mnt/test1/1G bs=1M count=1024 oflag=direct
4. Umount "/mnt/test2" with force when IO in step 3 is going:
      umount -f /mnt/test2
5. The "dd" is expected to fail with following information:
       # dd if=/dev/urandom of=/mnt/test1/1G bs=1M count=1024 oflag=direct
       dd: error writing '/mnt/test1/1G': Unknown error 512
       214+0 records in
       213+0 records out
       223346688 bytes (223 MB, 213 MiB) copied, 7.87017 s, 28.4 MB/s.


- Helpful links
1. v6.7.0 rpc_killall_tasks():
https://elixir.bootlin.com/linux/v6.7/source/net/sunrpc/clnt.c#L869
2. COMMIT "SUNRPC: Fix up task signalling v5.2-rc1" changes the error
code of rpc_tasks in rpc_killall_tasks() from EIO to ERESTARTSYS. The
link is https://github.com/torvalds/linux/commit/ae67bd3821bb0a54d97e7883d211196637d487a9?diff=split&w=0


Looking forward to your early reply :)

Best regards,
Zhitao Li, in SmartX.


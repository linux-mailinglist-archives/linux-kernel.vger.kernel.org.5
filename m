Return-Path: <linux-kernel+bounces-156347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6581E8B0198
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2047B210FA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0100F156F23;
	Wed, 24 Apr 2024 06:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+b7Q2EO"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0657A15687B;
	Wed, 24 Apr 2024 06:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713939141; cv=none; b=P+Y7rV7on/TMluYRgTEtXpPdmgSfuNwb1IAmK8+ZOIIArw1SGkTUgO1wyKQavViwJ/ZCUxQHZA8+lSYZ7Tz3eAExc9AM0MXPhhDgpMVKiBQTMAennURgoshQ5yiVToZn26KohYqcb6l7geYLk34Q1CqlXIqA5uIt59JZ0N41Z8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713939141; c=relaxed/simple;
	bh=forXqGqJV7y0aFWFMx9D/iO8YCfUNxtiX8QmxItC1oQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=h2oNVK/pOhHzoVUczmb2YK9lqDJER7AyHSyaIHPjcHPcQBxxyRy6XH0dwHWgqPuOg0i8bMWa0LD9GZY3oWcmxVaE7GLk0Qdpodv5wtIF4JZzUS2dv+/V7CHoIW+gl4mHDEB8KN12pgX9J4cgc1CwhoQe+DNakR8uD/yovOncgrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+b7Q2EO; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6eb8809a44eso3901556a34.0;
        Tue, 23 Apr 2024 23:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713939139; x=1714543939; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=forXqGqJV7y0aFWFMx9D/iO8YCfUNxtiX8QmxItC1oQ=;
        b=S+b7Q2EOaLTdc+FAr3CRAwNIPqBp2Wi1F1tS56QZg7iH8iFfxV9p4JOe20z8VUqN2m
         pLz4XSFHPaKAxSRfNcLX1cuzbC5bdgYFt4PNQzB3a3dkWm9eRKehOZOBDGyENkHssnpR
         CrXJWk1bWsG73mAFb1exN+sJp5SU+YnChmHncgLPLj0/okozilZN4656NqMnSLYEr3oR
         uILwHf6dMKV4UCBLKAkHKhujVEB/X7MdDvL7+vx5StlzXU1zRFVIKmWBAycxcdBYfcQD
         bQTCFOYnCH+QDpMbXWi2hqVp6SlDHslDdq9Na+wrorqdCawmwL0lOMhsm/r3K1pWC630
         7hZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713939139; x=1714543939;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=forXqGqJV7y0aFWFMx9D/iO8YCfUNxtiX8QmxItC1oQ=;
        b=RAsfkokx/zP31whAA7yufOzgxCy26+n0x5zhxeyeTA+ZGP7E1tKYowxSoMpl4Durn5
         ShmCfMrji/sD4jBPPFYH1+fTZZQmPcx+zlvaJ6V65jhkB2r8UhdO6fQxW4kkTQPKkyoj
         HZ8R2SFClkl7UdsRuhFmGqBTWoKHJVXo0pliVOL1qflKb91GuB5QK2xdLDwHFtnahI4M
         kThmA9MIXpkCw6FGSfflpvEiKPJnzVx82iqy77XOIs0ehYSeyTWR1rfvNSJx+VsaCY4S
         lWO0uKeH1se55TnXTnKJAsjlZJOrSTZ+4lDR/mEocqHu29Nd34uVv8lkSowcUOG71Qtu
         57tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGfpFlk+7RnWcG/GgvbLhyThTHPLTwNi+CHPi2qsZAttAU4jMwBdUFpeeoLOuGAYD6/6TKCDYE/ocv+tsu36cYRBhXB8s61ctskNjH
X-Gm-Message-State: AOJu0YzjyHWMXLkZmXKnRczqTbU6y+wfWTJ9z16T+ER1UZWyvb+BJS43
	jy5oXhqPoJhaowu8qiKgnlZvl/YtkUm5cqMj9q2iqu9B/NTTq9Gx4BvOVbf+oUW+nZcpLtqRBPM
	LWhhJdwJH+VSnYMut3PeL5qMgldD/e5O6CoioEg==
X-Google-Smtp-Source: AGHT+IGZXoGlFFJcnk+bAbQaAGTF8TANyxYL6ozHWYW1ktIxF1Q5p9p+f4nIjZ8YSs6akSYYakbUBbcFxzDk7OkPtvw=
X-Received: by 2002:a05:6871:331f:b0:22e:f3cd:b6b7 with SMTP id
 nf31-20020a056871331f00b0022ef3cdb6b7mr1456211oac.27.1713939138821; Tue, 23
 Apr 2024 23:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?5YiY6YCa?= <lyutoon@gmail.com>
Date: Wed, 24 Apr 2024 14:12:07 +0800
Message-ID: <CAEJPjCv=M-RQhp4MkO9MPETsh8gpGOqrhNqXhe1Wm-nj1UTpUA@mail.gmail.com>
Subject: KASAN: use-after-free in snd_usbtv_pcm_close (with PoC and analysis)
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mchehab@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi upstream community,

I was fuzzing a LTS version of Linux kernel 5.15.148 with my modified
syzkaller and I found a bug named "KASAN: use-after-free in
snd_usbtv_pcm_close".

I tested the PoC on 5.5.148 ~ 6.8+ with sanitizer on and found
sanitizer through a panic as "KASAN: use-after-free in
snd_usbtv_pcm_close".

The syzkaller log, report, kernel config, PoC can be found here:
https://drive.google.com/file/d/12ubxzCGrkUVz8BWRwprHjRHYh3l0oMMd/view?usp=sharing

# Analysis:
I wrote an analysis to explain the root cause in an markdown file (in
Chinese, so you may use translators to read it... Sorry about that)
which can be found here:
https://drive.google.com/file/d/1-TjLRqLs1_C_MDgvAy-TURxldUabW2Eq/view?usp=sharing

# Step to reproduce:
1. download the zip file
2. unzip it
3. compile the kernel (5.15.148) with kernel_config
4. start the kernel with qemu vm
5. scp repro.c to the vm
6. compile the repro.cprog and run it: gcc repro.c -o exp && ./exp
7. you will see the KASAN error

# Note:
I didn't find any related reports on the internet, which indicates
that it may be a 0day. Hope the upstream can help check and fix it.
And I'll be happy to provide more information if needed.

Best,
Tong


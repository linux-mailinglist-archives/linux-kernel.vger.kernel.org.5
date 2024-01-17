Return-Path: <linux-kernel+bounces-28912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A07B083048A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B21A1F273EB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDECA1DFC4;
	Wed, 17 Jan 2024 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DC+VVppE"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF83F14282
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705491001; cv=none; b=ppVkJOCG3aYB3rsPvjdogKNusVZVHypKQlbPbrf+VXGyQMFTUNhSXmT85AqV1x4vndIjC/msNfh/ptqLCbrcZST5CdnZkCr1sPOxaBsbjIhEB5g3E0JMbo/cO7LaerPMdL2wItVktX5g6oZK/SUc8UIm9tG90dCXV/368Oke8nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705491001; c=relaxed/simple;
	bh=2jZE4B7oyMh+K54PZDBUFcKJKnJC0+zvIPiDax6VE2E=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=uVxffB0zE+R2aepdUNNFgBq22n9Ulgp1hazClw7SQJFfpKccYJS07izvcH31j6QOYyx/4RHfZx9WRGtUrtbDF0ixwOMdeo/BNGrnlV3qe5whgH04OisAraV+B3FUCexyxRbmWGmsoH3DYka+BmdlBxi92VedwJ7tspNGok+pvZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DC+VVppE; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d9bec20980so5891734b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 03:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705490999; x=1706095799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I8roRW4no/xjoj4KDpxJtxjDBfp5JaqR128va6VQkGc=;
        b=DC+VVppE7LRDRw+QeFAnBi1OfeFC1bUoA+8semwwY+e275YCLbkOaeC5VsdnIKtyZL
         VrpcRO85wPtyYIofWaQUPw3KHwy5KL18/lOEe2gBt3OOPpaZ6VS6rfbBqnyblETtOH5e
         goojGxrUixirf9M9RzoutzQRpkMha+xfwwc6b0j2KmQEv6UeWxfsXBtRj6EfbbfR6zR0
         SMXfCvB8GYQolsFzpzMSJbxMlsx24jYy8KJjxHNMz25tt7oYIJK1RqlHqw+jAeqKvK2A
         6u82thCb8oNf3EUB948S2mAWN69T9aR/E3dQJBUmCS4QqYsG+6mdRmcaXU8KWkm73j3+
         wKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705490999; x=1706095799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I8roRW4no/xjoj4KDpxJtxjDBfp5JaqR128va6VQkGc=;
        b=wB7ub2pVEABMZcv2KHMUfW4LeGeT1Z9IQlv72yu80H0JOF32UjhJd6DT8zdqtdADbg
         IExS6mZQjY9Yml8zKtTgj6ONx4516YI6688tvg5ucAnNK/f7VN1WejJcy4Lq9GF2hYLp
         Snm57dffXiIDKd+PCe3nDH0sm+PZlP5eMu7xiwgDnLrseJs604UtdhDknk3u4JoVeGif
         nIXOJHog3DzFoUpuo45PM89Wt8gb7m5s3z5/bAFohqsvjAYoIUbl2ECOjO6xGs+4TM65
         9LVigHqlmoVGcA51//8exaMWyedOGyeP4fK9GcPK7wcKyJ4kgEx7cDeUf/K7nY7tDpxc
         yoZQ==
X-Gm-Message-State: AOJu0YyccWKGqJ7z6ueRVnLKCzU3H2dBSHmd4zdg960ARpsk0spUrTQQ
	C6hjADG4wBxvgts3ruMOUao=
X-Google-Smtp-Source: AGHT+IEyruLwrDk2uUrkXJTrMIjBVEPkHnNG1cf7u25ADYL7J+psmIm3jg1Fq9GTcPPL2olJON552g==
X-Received: by 2002:a05:6a20:8402:b0:19a:11fa:9181 with SMTP id c2-20020a056a20840200b0019a11fa9181mr5599051pzd.63.1705490999014;
        Wed, 17 Jan 2024 03:29:59 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net (c-73-63-239-93.hsd1.ca.comcast.net. [73.63.239.93])
        by smtp.gmail.com with ESMTPSA id sc4-20020a17090b510400b0028cefda6fa2sm13752724pjb.24.2024.01.17.03.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 03:29:58 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/4] xtensa updates for v6.8
Date: Wed, 17 Jan 2024 03:29:33 -0800
Message-Id: <20240117112933.303593-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

please pull the following updates for the Xtensa architecture.

The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20240117

for you to fetch changes up to a03cd7602a090eae277d2b79d43925661e7fbe9a:

  xtensa: don't produce FDPIC output with fdpic toolchain (2024-01-11 18:58:47 -0800)

----------------------------------------------------------------
Xtensa updates for v6.8

- small cleanups in the xtensa PCI and asmmacro code
- fix kernel build with FDPIC toolchain

----------------------------------------------------------------
Ilpo Järvinen (1):
      xtensa: Use PCI_HEADER_TYPE_MFD instead of literal

Masahiro Yamada (1):
      xtensa: replace <asm-generic/export.h> with <linux/export.h>

Max Filippov (1):
      xtensa: don't produce FDPIC output with fdpic toolchain

Yujie Liu (1):
      xtensa: fix variants path in the Kconfig help

 arch/xtensa/Kconfig                | 2 +-
 arch/xtensa/Makefile               | 6 +++++-
 arch/xtensa/include/asm/asmmacro.h | 2 +-
 arch/xtensa/lib/pci-auto.c         | 8 +++++---
 4 files changed, 12 insertions(+), 6 deletions(-)

-- 
Thanks.
-- Max


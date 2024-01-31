Return-Path: <linux-kernel+bounces-46221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D832843C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11899B2C65F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E445B745C8;
	Wed, 31 Jan 2024 10:22:02 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1BE69964;
	Wed, 31 Jan 2024 10:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696522; cv=none; b=ct2e/JnpFWA6mRAzoD1PVLlmjK4ysIVuwLlbRURlNKMgzRxPsip/DnKWu5MNnQ02DlEMPWreL4VaoheHqzrlOfmoNGovz/vrOTi5BFurayjjuxVhtPKIh4YDAQxRq04Zo/xT+Mczy4SbyaDLqY76ikn2pwOxousx4aN+Ovmud2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696522; c=relaxed/simple;
	bh=/JV1uEYHXrbnJa7WNg6DLHiDN+2ZhG/Pr0mBmoeU/90=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=skrpAw+OWTDeyQEg3IIodLxAeiMy0Z/l3dRWHkxxT5P3iV3KP4VVjngXoL8gd6ZQUcJceyjzdojddBUbiyneAMLT26E4Pa4Hj6XNzzwSWITCAqxHGY/beIjw7TmCCnCtD5ZcbH9SaPjtq0Mjk33hHiZNVfJivTka77iaPzTYZAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a271a28aeb4so634503266b.2;
        Wed, 31 Jan 2024 02:22:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706696519; x=1707301319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rzbanewUQQj5wy+n5V1UkkEIPWprha4U/2Zbco09ODI=;
        b=E6l8B4bO7IBH7s2QyLGlDOoDxhBOZDKmbAQvIoxI+fPLrBPHEUdduPqAGRy1R4p9YF
         gks22U/45Iv0fIOaP0/0pAGDMasb/pleQG5CG6fq/LqBiMcDnV240Gm24tTHX2ufvx46
         qmNifaCZerH+Yngn/ziJhZz83nHoplpVtNzR7yl4+9oBigsGQCd1saeKiGBCKFJbvmtE
         HEc+j2C5sEPQUh6rasj6Qxs2n7H7qJeWGMyUY3EfTAjYZ+NrMqaOHcDRxOx77RDtPrgu
         nLwehrDIyCZfYf+BCNRs4MPosrwgDx0HcpswOHegn4P+KRnilWuzGzIpuaLFbar9v2KI
         l3Bw==
X-Gm-Message-State: AOJu0YwWP8XRb6SfsbcMqCgnh291fFyiT9BDB4ePBvl/lYP9zNBgk4z9
	gO/BTDl411oefohEUUxgR8jqY0pOVr320Ff8EH9Sq7+Iiav10LmMpP0bp8slF3NVrw==
X-Google-Smtp-Source: AGHT+IEvV88HpIrKBoF15pOJUZ3uGLGI3fOhI9zplk/CdOISgvYsRom10j6DQYozMbgtTJdMcDle0A==
X-Received: by 2002:a17:906:78a:b0:a30:2597:83dd with SMTP id l10-20020a170906078a00b00a30259783ddmr868370ejc.43.1706696518457;
        Wed, 31 Jan 2024 02:21:58 -0800 (PST)
Received: from localhost (fwdproxy-cln-005.fbsv.net. [2a03:2880:31ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id f14-20020a170906494e00b00a3681468567sm307427ejt.81.2024.01.31.02.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 02:21:58 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/2] net: dqs: NIC stall detector
Date: Wed, 31 Jan 2024 02:21:48 -0800
Message-Id: <20240131102150.728960-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a patch that was sent by Jakub Kicinski six month ago, and I
am reviving it.

This is still mostly Jakub's code, with some small improvements,
described in the changelog.

Changelog:
----------

v1:
  * https://lore.kernel.org/netdev/202306172057.jx7YhLiu-lkp@intel.com/T/

v2:
  * Fix the documentation file in patch 0001, since patch 0002 will
    touch it later.
  * Fix the kernel test robot issues, marking functions as statics.
  * Use #include <linux/bitops.h> instead of <asm/bitops.h>.
  * Added some new comments around, mainly around barriers.
  * Format struct `netdev_queue_attribute` assignments to make
    checkpatch happy.
  * Updated and fixed the path in sysfs-class-net-queues
    documentation.

Breno Leitao (1):
  net: sysfs: Fix /sys/class/net/<iface> path

Jakub Kicinski (1):
  net: dqs: add NIC stall detector based on BQL

 .../ABI/testing/sysfs-class-net-queues        | 45 ++++++++++----
 include/linux/dynamic_queue_limits.h          | 35 +++++++++++
 include/trace/events/napi.h                   | 33 ++++++++++
 lib/dynamic_queue_limits.c                    | 58 +++++++++++++++++
 net/core/net-sysfs.c                          | 62 +++++++++++++++++++
 5 files changed, 222 insertions(+), 11 deletions(-)

-- 
2.34.1



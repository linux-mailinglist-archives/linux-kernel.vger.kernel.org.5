Return-Path: <linux-kernel+bounces-33119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B708364EE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ABD92895D4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EA73D388;
	Mon, 22 Jan 2024 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgdW4dZK"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7950A3D386;
	Mon, 22 Jan 2024 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932131; cv=none; b=O6H1mA1lrebhC/gIwWdNUUpL736p9kF26uXkA8Vbwps/GMo1RJMtMuRbIE8OvDyMn38xhnXs6rjZOc78XvqFX79LZxN3sJdbpKgyFHpeIqHrjSBhlDE/Jk+CuFYr6y2jZDnenqwGnb0jxR3q4wW1BR4P5FqxyME0X40bqULP2eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932131; c=relaxed/simple;
	bh=gw6XTAyXJYmH0W7Wh65iumUQ/VqSPsxTX+GfSXeJtb0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bjceqLDLzouoE+yACLYNLUByUVmFg8qXCZbBzmJLPs0L+YXMEh6+QupW3M30iufLXhLdQ3qsx8TL+S7wJMSLnf1qqOCxn8iKhulgUU+8xnq7WIta1cMbhqqm096Y/JP3gFxqOFWZhx4rrancQ9olQtkALDyifXXEz8xzwRfBWeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgdW4dZK; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so3126522b3a.0;
        Mon, 22 Jan 2024 06:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705932130; x=1706536930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N7KNCuGYtqBfqagGWXWHT3i54L4EKBZ2GgjmMoSLIIc=;
        b=kgdW4dZKa1UvF4rEO16kLW5nWTt+iJB5k66wIunqFNr3Fk/ZeVFx3uLDBmHMEEced9
         nVyFUkBoFX+NRdIL2mwrS5l3XWFsSLDgyWGK7pUEV4gwD68hm719Liyb2wrhlwvHiBQz
         wEto6ZiO7YxGwhycElYvqVAxFxrpt4VbDiKWgcv/6T4TESAVBdbhxLbgVKHIasd6KzvM
         ZoCnAgegd/KvRKvDlcj0HJ1+6p61y862P7gZgNRS/nN15DtHlaW5ZUbCs9VnAelaJUBX
         ff74ESUB0s8sMnPBj5IQocBujxIJIFxlAiwE+yd8C9RZLPMpoEk3vJdJFI7IqkB5q/WH
         rMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705932130; x=1706536930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N7KNCuGYtqBfqagGWXWHT3i54L4EKBZ2GgjmMoSLIIc=;
        b=TiH1HT9S1fudW2DJvxiuGnDeoM7Pt2FiKYoTSuRZmS8UzjkNPwMTKuYCT6Zll6fYiG
         KoAaXh72KnKDn4WNgFwJjJfueDsC9JEL+sXcr0gscCbhiVBrEbp+olZNS3hfGVcNqq1P
         YqEJXpoKrJqU/QfuVrFnD7Hf21q9mbUun6q0KsmNUH+uhjvnNJxmoUpHjxcJYl84QlGK
         AZWx2RIGD/DF9OmeraW9ZAsdb1cOxAlRTwuvWYNIgy3iJPX3MHCFG5PxVyWVSZZfpG2A
         sqHa1x/A6FUxyp9MKAYsruhoTdISerUBDn22aHvKN0CbUQBXIP3/TyqLjyNcWdvBVUYl
         JM9g==
X-Gm-Message-State: AOJu0YzPRDq843jDeIe7DJuUmg3Q2DONcLADrfDGX+KMWGDTXZ953vei
	ZWaple3q+z+A8x+BkeGYtxnayFiAAZfaLDbyJgNaurDQ7e1Q8MKvwU84VNsF
X-Google-Smtp-Source: AGHT+IGWzrIDO861IAIDwIVC2Ch/3S2RXSMEtVb7hBXmt76PhdzT2JSKvINOkn9TQhpS48P4B5Yq9g==
X-Received: by 2002:a05:6a00:6c83:b0:6db:ec88:5ec with SMTP id jc3-20020a056a006c8300b006dbec8805ecmr253442pfb.45.1705932129560;
        Mon, 22 Jan 2024 06:02:09 -0800 (PST)
Received: from carrot.. (i223-218-154-72.s42.a014.ap.plala.or.jp. [223.218.154.72])
        by smtp.gmail.com with ESMTPSA id n14-20020a62e50e000000b006da2aad58adsm9901913pff.176.2024.01.22.06.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 06:02:08 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/15] nilfs2: eliminate kmap and kmap_atomic calls
Date: Mon, 22 Jan 2024 23:01:47 +0900
Message-Id: <20240122140202.6950-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

Please queue this series for the next merge window.

This series converts remaining kmap and kmap_atomic calls to use
kmap_local, mainly in metadata files, and eliminates calls to these
deprecated kmap functions from nilfs2.

This series does not include converting metadata files to use folios,
but it is a step in that direction.

Most conversions are straightforward, but some are not: the checkpoint
file, the inode file, and the persistent object allocator.  These have
been adjusted or rewritten to avoid multiple kmap_local calls or nest
them if necessary, and to eliminate long waits like block I/O within
the highmem mapping sections.

This series has been tested in both 32-bit and 64-bit environments
with varying block sizes.


Thanks,
Ryusuke Konishi


Ryusuke Konishi (15):
  nilfs2: convert recovery logic to use kmap_local
  nilfs2: convert segment buffer to use kmap_local
  nilfs2: convert nilfs_copy_buffer() to use kmap_local
  nilfs2: convert metadata file common code to use kmap_local
  nilfs2: convert sufile to use kmap_local
  nilfs2: convert persistent object allocator to use kmap_local
  nilfs2: convert DAT to use kmap_local
  nilfs2: move nilfs_bmap_write call out of nilfs_write_inode_common
  nilfs2: do not acquire rwsem in nilfs_bmap_write()
  nilfs2: convert ifile to use kmap_local
  nilfs2: localize highmem mapping for checkpoint creation within cpfile
  nilfs2: localize highmem mapping for checkpoint finalization within
    cpfile
  nilfs2: localize highmem mapping for checkpoint reading within cpfile
  nilfs2: remove nilfs_cpfile_{get,put}_checkpoint()
  nilfs2: convert cpfile to use kmap_local

 fs/nilfs2/alloc.c    |  91 ++++++------
 fs/nilfs2/bmap.c     |   3 -
 fs/nilfs2/cpfile.c   | 319 +++++++++++++++++++++++++++++--------------
 fs/nilfs2/cpfile.h   |  10 +-
 fs/nilfs2/dat.c      |  38 +++---
 fs/nilfs2/ifile.c    |  21 +--
 fs/nilfs2/ifile.h    |  10 +-
 fs/nilfs2/inode.c    |  44 +++---
 fs/nilfs2/mdt.c      |   4 +-
 fs/nilfs2/nilfs.h    |   3 +-
 fs/nilfs2/page.c     |   8 +-
 fs/nilfs2/recovery.c |   4 +-
 fs/nilfs2/segbuf.c   |   4 +-
 fs/nilfs2/segment.c  | 121 ++++++----------
 fs/nilfs2/sufile.c   |  86 ++++++------
 fs/nilfs2/super.c    |  31 +----
 16 files changed, 425 insertions(+), 372 deletions(-)

-- 
2.34.1



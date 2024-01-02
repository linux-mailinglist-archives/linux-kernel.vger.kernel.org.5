Return-Path: <linux-kernel+bounces-14506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A94B4821E0C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558BD1F22E5D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DECE1426C;
	Tue,  2 Jan 2024 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0rFy34s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F61C13FF4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-28bfdf3cd12so3683527a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 06:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704206988; x=1704811788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YDhrdw2EFatZsZwpVBL+5yckJoyULeS7zHGr7sK85zc=;
        b=m0rFy34sydUn8G5OFtyyBlBr+tFirjuyN97rCANxn31s4Ymc7NKplvs98T8oIgbP05
         wYnSxd4Wn6jQVTOpVrfHxIKPuGb1ujC1lMXh4lptZhEdpHybTvano2oRx659aVHcvdMf
         9Gmk/lyCbKqtONNLXW6KxYJ6Af7ehSjn3qCpa7W7uVyTLAKqFGFu3kYS2M76/JIVHQ9S
         yFmWO0NnJsKuc2Ld+rehdsqdWe1vl2VCZBim1aowtCRxRN7KdcfrjAH5jo2f6FyC1BQT
         XWTJ9k6fyRmNAhoiTT9Lct+J9Qu15C5DVA0sU7HrRprW/DdRIkPvtsLDsug/7E6EpmEC
         E0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704206988; x=1704811788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YDhrdw2EFatZsZwpVBL+5yckJoyULeS7zHGr7sK85zc=;
        b=mBlZWNHYZY8PSjbvlvMgcvMytYNxhwO9Cmpijsvf8kThsKudMbep826DF6x40FKciI
         HLKlmkaJEJItiE6wyZ1KHvUqrVGcn+uDonnmwoOhbzNKzdclSMZCFuvXxwGbJbk5hUCu
         qCB/0hsag/JatoU9f96I9xFw8alSC1qX6IrrhgfoaX2NlR02GveloJRIElHTMcxClLG/
         i+KcITi0VyyFeyKXR/IBmn+H76l2MeZdXqTyTvEUwTC9pzoTbZoJewelseW3ZpDWejf0
         znb0Wll6OyT7Jy9Ipa9i6FoC5axTyjuBPmY4pqY4aVpW82zNruB1lBFXNTDgl0sgA/h4
         MP7A==
X-Gm-Message-State: AOJu0YwIFELGQ41PE6OchsD5ImQuJwZ8pbERcQjAV3UbR9uthJxKgDcS
	OnLDnuf+mvo7psaTf1okYU7cKtBb0iyP9A==
X-Google-Smtp-Source: AGHT+IGzJFyW9a5iYIIvP/E1B6Aq5OU4Dd2tRSLGwh0HbPDRNg3iINd607/Z9goxsovbYD0ClJHHwQ==
X-Received: by 2002:a17:90a:4708:b0:28b:be23:67a6 with SMTP id h8-20020a17090a470800b0028bbe2367a6mr5269342pjg.80.1704206988582;
        Tue, 02 Jan 2024 06:49:48 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id 19-20020a17090a005300b0028be216595csm25836878pjb.4.2024.01.02.06.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 06:49:48 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Takashi Iwai <tiwai@suse.de>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH v2 0/3] crash: Some cleanups and fixes
Date: Tue,  2 Jan 2024 22:49:02 +0800
Message-ID: <20240102144905.110047-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset includes two cleanups and one fix.

v1 -> v2:
  Patch 1 and 2 have no changes.

  Patch 3 has no functional changes. I just squashed the following patch
  into it based on Baoquan's suggestion, to make it easier to merge.

  [PATCH] crash_core: optimize crash_exclude_mem_range()
  https://lore.kernel.org/all/20231219163418.108591-1-ytcoode@gmail.com/T/#u

  The link to the v1 version of this patchset is:
  https://lore.kernel.org/lkml/ZZPMLextp0n3lwbD@MiWiFi-R3L-srv/t/#m4d20eee5aee48a1daf0a754b5570afb4b5d4fa03

Yuntao Wang (3):
  x86/crash: remove the unused image parameter from
    prepare_elf_headers()
  x86/crash: use SZ_1M macro instead of hardcoded value
  crash_core: fix and simplify the logic of crash_exclude_mem_range()

 arch/x86/kernel/crash.c | 12 +++----
 kernel/crash_core.c     | 80 +++++++++++++++--------------------------
 2 files changed, 35 insertions(+), 57 deletions(-)

-- 
2.43.0



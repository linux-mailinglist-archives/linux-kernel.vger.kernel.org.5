Return-Path: <linux-kernel+bounces-73732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B93B85CA1F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06451F21E7D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F26151CEE;
	Tue, 20 Feb 2024 21:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJhK2oa/"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5CA14F9C8
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 21:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708465344; cv=none; b=c4LCKd33HNvuqqilTsmQ4MsLGq1fmMI+99mikPNc/kiwh4HG8aU0Y0ia58oPJ7uNYMw/7+ZXzlbRGnE2V82Kq/pgY374Ntigcnm17h2EcPuWMblDYj19h0EZzVMQ28WJhcC17TVVs2o8W1uho7quNj8t/Gzvz6qozw07vm0dYlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708465344; c=relaxed/simple;
	bh=G2mNUitTGG1KhBtMJnPfhpNhPMEAqPr9W7kdvUCbE9k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PEoaNIAAekNUEi5qn00Zcke9816FzTmNnysvSgMfFhgWIfWviMm9ZlJ8i71SAuEXVMEWBiTCvi+ANJm3AOZ0NRFZiigy6wY2kfNczRAGtupXmEGkXMlMPRUC8YbEt/O1z68t/ndB8xH/3D9aaKVD/5NCb+WDMei/xzghb0B8L4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJhK2oa/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d731314e67so42712785ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 13:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708465342; x=1709070142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5FhqsiQDKEAn6Yfpxe63BK7w9ctSLeshC951FYVN1HY=;
        b=gJhK2oa/mxYixfzG+8DBIIjARC8/K4Rw2YKlVNxnCe4kRFWW2hx6XsA6QTMjmEU1A+
         0Fvu8EgG7PJP/pjLMxnQx2wI+KjMoAX6LEFMTibKVLNciakWXh1GBFalNuP0PIUKKalX
         rNgPhBlS2Y0kC90+/d2HU8onWdnQX66h/6f+FwXnQAoGCIYi8zicPc2FiJtpx05SW8my
         f1WUQ60tQbIXdryV4yx9tYBUGQCXLT5GkDzi9TpaKqqNcqanZmS6ZwdbVZXxbLADsLin
         SdSnR5Ql4QYzEcsiFPgcza2dUVHMJWHUyQEH2EKVsQfWGTASv40h11moFNhEP1146aEr
         Tk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708465342; x=1709070142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5FhqsiQDKEAn6Yfpxe63BK7w9ctSLeshC951FYVN1HY=;
        b=mneycRGoQLrHsl7tb8YoiHXhXre2Ow4Dm8g4ndevX1CJ64bym+TBenfg1Lrw03i4sO
         ntLlVaLfuj5OZJU5lInK47dkjYzfBhU853CqCKG78iWRLb5iQjDTuy5dpWeRlGP0Tmfa
         XYVT1DEfMeR3d6PL8dz5ssIoaSRgvAn4u4GR2ZHr7gRrDcD93292AAbFOZJ2WrcjIHME
         xtsm8BdFqlxtsZIxOmvo/LMotdeGQQ1eigL2q4zQn5aD4bwsyas1kvQVkBMQHdrkpcw8
         9egbPrVUX+7foMoYNjCjn6qT40N2nMVdf/8sX2fdJQ9t9rsHpm7ny7WJsj3aPJAldOON
         qZdw==
X-Gm-Message-State: AOJu0YzjoCHBUG3hI9xvmBQRcgS3Mbp/W/6tM1j8ZjkWFHtHtxZlTUTj
	leENz2XzL5lH2jBiWUKB5T9+2imhT+7J1Wu85fVlBtYt/y5frJ1/
X-Google-Smtp-Source: AGHT+IG7geGBtg9yOSehILON+Xx96yPGfiFacRJe1mVy2Qqt1TLTiTxLM4+BJID91aatArvFbiEMCQ==
X-Received: by 2002:a17:902:8496:b0:1db:47bb:65d6 with SMTP id c22-20020a170902849600b001db47bb65d6mr13482472plo.58.1708465341919;
        Tue, 20 Feb 2024 13:42:21 -0800 (PST)
Received: from localhost.localdomain ([116.73.143.161])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090323d000b001d9edac54b1sm6792408plh.171.2024.02.20.13.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 13:42:21 -0800 (PST)
From: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
To: suzuki.poulose@arm.com,
	mike.leach@linaro.org,
	james.clark@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
Subject: [PATCH] Correcting the spelling mistakes in "Documentation/ABI/testing/sysfs-bus-cxl" and "Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc"
Date: Wed, 21 Feb 2024 03:12:12 +0530
Message-Id: <20240220214212.10231-1-pvkumar5749404@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>

Changes:
	- "avaialble" corrected to "available" in "Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc"
	- "firwmare" corrected to "firmware" in "Documentation/ABI/testing/sysfs-bus-cxl"
Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc | 2 +-
 Documentation/ABI/testing/sysfs-bus-cxl                   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
index 96aafa66b4a5..339cec3b2f1a 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
@@ -97,7 +97,7 @@ Date:		August 2023
 KernelVersion:	6.7
 Contact:	Anshuman Khandual <anshuman.khandual@arm.com>
 Description:	(Read) Shows all supported Coresight TMC-ETR buffer modes available
-		for the users to configure explicitly. This file is avaialble only
+		for the users to configure explicitly. This file is available only
 		for TMC ETR devices.
 
 What:		/sys/bus/coresight/devices/<memory_map>.tmc/buf_mode_preferred
diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index fff2581b8033..bbf6de5a4ca1 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -224,7 +224,7 @@ Description:
 		decoding a Host Physical Address range. Note that this number
 		may be elevated without any regionX objects active or even
 		enumerated, as this may be due to decoders established by
-		platform firwmare or a previous kernel (kexec).
+		platform firmware or a previous kernel (kexec).
 
 
 What:		/sys/bus/cxl/devices/decoderX.Y
-- 
2.34.1



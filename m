Return-Path: <linux-kernel+bounces-3812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7DE8172BF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4997E287548
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA14F498B6;
	Mon, 18 Dec 2023 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHs1pkCR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B720A42390;
	Mon, 18 Dec 2023 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cc5ee69960so19454571fa.0;
        Mon, 18 Dec 2023 06:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702908580; x=1703513380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e/ByvKvbVcMp9OFK102BFaynb7vl3RcGPXPYnDPsZ4I=;
        b=fHs1pkCRqYLEKYepXLHMAFHJnbXku9Nv/dyXiVojcoiFeFwd8QK9kUorYPz+d25LYL
         NqozBkbh6C73mpvD8cQytlOjXANWUuj5rJv7DJkvkfgaKFf1jrM4MoYyNs6JW4f3qfh7
         9zm6ITvxQzGFQEoSF8kiq/neFEvm2M1yrhDO7nwvO45H1A3Osm1m4PbFrwS4/Zh4IsfL
         luJ5Kv3b66vOtvziahopnbG0QCaEsbPObtdejoPmL6q8w24xri+aZGvcrVIY0AVFM96p
         VFaCojvIxjWPeIGl58Txb0w4P5JdlEa8lra15kNJ4stXy9iA/7+6kVJE0ehmeCMJEV6s
         DDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702908580; x=1703513380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/ByvKvbVcMp9OFK102BFaynb7vl3RcGPXPYnDPsZ4I=;
        b=QF/Zfa8Hzf021pScXkiE6yxCDdXHxWmW4CIgOubEVY3jYWuyqctnSBBVRQrXtdxTpI
         jA/UNMA5Gn8SRuMmoQzUVkyQrHetjQJTp7L5R7elSk77yFs77NxDcYat6MEjrQ9N3d/L
         kPhyZeL4cNpKbqPyt0mtAQSpdTHF/rniBdhzxU7v9tOgF8BAueLZU/2BAn8/JDuD9cGR
         vFiWk/wXFzIi8U695Uj5TT7jUVNhJJjwSP1kCcLVdjasd8Ix3SQShWpS1u/Xtvb3rK3N
         /PlIF24T1hVKxTxV+CK+mqmqHT7dzkvvGnANQiuXrlUxrh7FaPq0k7Mbxx87ToRpFX2H
         07bg==
X-Gm-Message-State: AOJu0YwDx2Q8fpfCSP55A1bgAu6iAl5MdFtZAW/bjAgSQu4mFN1dPiQm
	k9TugtVrPqMbWYNW7TxUJZU=
X-Google-Smtp-Source: AGHT+IH8CM0n/gMn9zCl7bR3h8LZEhXzmPawPytla43m6a1Q1qPPJeV94/CYSzoLe5i70YAenlOF8w==
X-Received: by 2002:a2e:a588:0:b0:2cb:3169:b348 with SMTP id m8-20020a2ea588000000b002cb3169b348mr4449619ljp.96.1702908579419;
        Mon, 18 Dec 2023 06:09:39 -0800 (PST)
Received: from rand-ubuntu-development.dl.local (mail.confident.ru. [85.114.29.218])
        by smtp.gmail.com with ESMTPSA id b4-20020a05651c098400b002cc7925cf2bsm90679ljq.124.2023.12.18.06.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 06:09:39 -0800 (PST)
From: Rand Deeb <rand.sec96@gmail.com>
To: Hannes Reinecke <hare@suse.com>,
	"James E . J . Bottomley" <jejb@linux.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: deeb.rand@confident.ru,
	lvc-project@linuxtesting.org,
	voskresenski.stanislav@confident.ru,
	Rand Deeb <rand.sec96@gmail.com>
Subject: [PATCH] ahd: Remove Redundant Comparison in ahd_intr()
Date: Mon, 18 Dec 2023 17:09:02 +0300
Message-Id: <20231218140902.36774-1-rand.sec96@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'ahd_intr()' function contained a redundant comparisonthat was
always false. The comparison in question was:

if ((intstat == 0xFF) && (ahd->features & AHD_REMOVABLE) != 0)

The 'AHD_REMOVABLE' constant had a value of '0x00000'. Therefore, the
condition 'ahd->features & AHD_REMOVABLE' was always '0', making the
comparison unnecessary.

This patch removes the redundant comparison, making the code clearer
and more efficient.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
---
 drivers/scsi/aic7xxx/aic79xx_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx_core.c b/drivers/scsi/aic7xxx/aic79xx_core.c
index 98b02e7d38bb..4c790fe28f73 100644
--- a/drivers/scsi/aic7xxx/aic79xx_core.c
+++ b/drivers/scsi/aic7xxx/aic79xx_core.c
@@ -1008,9 +1008,7 @@ ahd_intr(struct ahd_softc *ahd)
 	 * Handle statuses that may invalidate our cached
 	 * copy of INTSTAT separately.
 	 */
-	if (intstat == 0xFF && (ahd->features & AHD_REMOVABLE) != 0) {
-		/* Hot eject.  Do nothing */
-	} else if (intstat & HWERRINT) {
+	if (intstat & HWERRINT) {
 		ahd_handle_hwerrint(ahd);
 	} else if ((intstat & (PCIINT|SPLTINT)) != 0) {
 		ahd->bus_intr(ahd);
-- 
2.34.1



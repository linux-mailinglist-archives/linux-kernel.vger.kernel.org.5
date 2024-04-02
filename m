Return-Path: <linux-kernel+bounces-128728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DF5895EB5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589091C23BCC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A3415E5D6;
	Tue,  2 Apr 2024 21:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giK7ekR2"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E251215AAA7;
	Tue,  2 Apr 2024 21:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712093454; cv=none; b=mefoCZ4Lbc6KJ8JHyvm3FFkmS6tO67VZDEeZU+h2zefZXlXQ1JSfriqKj065UyddC8qDHVW8nhotvkMHM+koJgRZCOGZBbkXps+1zCloToUywUX6m6+UYZsPWBmHCDs9vcrWdSfFEHNDNIdmg/P/fxxRnwZlSz7J0g8Z3DFcCfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712093454; c=relaxed/simple;
	bh=hNVDekXEPKdNQ8nGR4QQ1IEFyjTV+QlVT98R13nD3NA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ElLKx2MSdHIKC6pUuxJgcfK7mmAFpWmyaSzOmVqKY4RQwEClEc4bUUxeFkRrbv3kO9bHo01X6e35fAUg7SI5h52SyAtYJD4u2Ka5bWOhFmsprJRKAHad5ttVKrz/2gDDDWZrz2pGCi09pfXvST/qMCoC0RxKsyWntGXoTBPBQ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giK7ekR2; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d6ff0422a2so77713781fa.2;
        Tue, 02 Apr 2024 14:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712093451; x=1712698251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d4wUD2z9yRcsRFUV0GZ2KtedkGxq+PRtlFMNXAo0fIc=;
        b=giK7ekR2UB0FPjvOEL+TYfwb0jxbOdvWlPQex1xu9TqM5R+pAiNdh0DpRuKYA0GLg8
         hzrpfyCAxW1netCc6OBHl+6jR36Sj7W7gZTvUd4Ofs331cw3AaLp2ehCQyHtHjskAsQP
         6dREn8E3cHh1ybmTiphQoMblE25JHZvw8Mmb1ceRHPFnP7j98JIvTnnFxj6qzir82CUz
         5v4VdeHFG6xOjhNBBhvAnyi5KJPIoTntcY7vLIeJB3BzkzLouJH8dh5QY0vRWYWJi7tN
         DPeNkKyJofExWmzz8x5XwHLJBxPwBYRwTVJWaP7pID94Y7U1c7PMEnhh6OEfxAYZ4zaF
         xK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712093451; x=1712698251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4wUD2z9yRcsRFUV0GZ2KtedkGxq+PRtlFMNXAo0fIc=;
        b=NvCUvQPxWuConnn/sbffnd2AASp/xmnhemraIeHKVhnbdZCrUAGL+o/9kjh40Ymjz3
         LXA1ngf03KJwtKuOdAdnLrM7L0IqI+PgoaQlyjLObG9Jdjvbn99Hv5gAQwL/T9RG2sRZ
         UX4Sm21mX3Ez0lpL65Jg9h0K1A1cfw/PqlUeCk5fVYth4kSszktp2Ierif0qr0pA251h
         cdyjC9dqx817TVHPeQ3ftsDjGpEcw/yS2qtjusTtKuVWPzFvhjhXjQ+lg6VU1AghtDY4
         MSwBSjGl6ITBwGaPu0IEjzamLVnEt8cbHZCXYRyrk+Aze9ilXpFMYEUiF18SnqHrPeNY
         7T5A==
X-Forwarded-Encrypted: i=1; AJvYcCWog9qEwpDT7yLwS9+rpVWdHDoyUlJwzV0IEQ//L2KCpi4w5Met2AEt04raEFUlEgaUPSlgFLHPPMgi4pzf+7lIMAfD+SbgQ/sP0TWeRx4qUqikDbVJOBIIIT2HVSyUVRc6hvNE
X-Gm-Message-State: AOJu0YxljPyIanbk5au94NbdpS0L6jdd+1ZKGSVe9eLx6EOSK19t+mq1
	PEQvefns+8QK8giIT+TjEBuqAZjfNvPBE/2K6/neNQnefuIXA7JBg3hEMpBF
X-Google-Smtp-Source: AGHT+IGHiDlGzpUaByzv1Mat8TWtJADllDTg3rUOQ7RF+vs2KUWXAyysTRN4kWevr3lyuN9B1n3rEA==
X-Received: by 2002:a2e:96cb:0:b0:2d5:b33c:1f64 with SMTP id d11-20020a2e96cb000000b002d5b33c1f64mr8253135ljj.38.1712093450818;
        Tue, 02 Apr 2024 14:30:50 -0700 (PDT)
Received: from localhost.localdomain (host-79-35-252-101.retail.telecomitalia.it. [79.35.252.101])
        by smtp.googlemail.com with ESMTPSA id g18-20020a05600c4ed200b0041495d17992sm19232476wmq.34.2024.04.02.14.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 14:30:50 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Michael Walle <michael@walle.cc>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] mtd: limit OTP NVMEM Cell parse to non Nand devices
Date: Tue,  2 Apr 2024 23:23:19 +0200
Message-ID: <20240402212331.27328-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MTD OTP logic is very fragile on parsing NVMEM Cell and can be
problematic with some specific kind of devices.

The problem was discovered by e87161321a40 ("mtd: rawnand: macronix:
OTP access for MX30LFxG18AC") where OTP support was added to a NAND
device. With the case of NAND devices, it does require a node where ECC
info are declared and all the fixed partitions, and this cause the OTP
codepath to parse this node as OTP NVMEM Cells, making probe fail and
the NAND device registration fail.

MTD OTP parsing should have been limited to always using compatible to
prevent this error by using node with compatible "otp-user" or
"otp-factory".

NVMEM across the years had various iteration on how Cells could be
declared in DT, in some old implementation, no_of_node should have been
enabled but now add_legacy_fixed_of_cells should be used to disable
NVMEM to parse child node as NVMEM Cell.

To fix this and limit any regression with other MTD that makes use of
declaring OTP as direct child of the dev node, disable
add_legacy_fixed_of_cells if we detect the MTD type is Nand.

With the following logic, the OTP NVMEM entry is correctly created with
no Cells and the MTD Nand is correctly probed and partitions are
correctly exposed.

Fixes: 4b361cfa8624 ("mtd: core: add OTP nvmem provider support")
Cc: <stable@vger.kernel.org> # v6.7+
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---

To backport this to v6.6 and previous,

config.no_of_node = mtd_type_is_nand(mtd);

should be used as it does pose the same usage of
add_legacy_fixed_of_cells.

Changes v4:
- Add info on how to backport this to previous kernel
- Fix Fixes tag
- Reformat commit description as it was unprecise and
  had false statement
Changes v3:
- Fix commit description
Changes v2:
- Use mtd_type_is_nand instead of node name check

 drivers/mtd/mtdcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 5887feb347a4..0de87bc63840 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -900,7 +900,7 @@ static struct nvmem_device *mtd_otp_nvmem_register(struct mtd_info *mtd,
 	config.name = compatible;
 	config.id = NVMEM_DEVID_AUTO;
 	config.owner = THIS_MODULE;
-	config.add_legacy_fixed_of_cells = true;
+	config.add_legacy_fixed_of_cells = !mtd_type_is_nand(mtd);
 	config.type = NVMEM_TYPE_OTP;
 	config.root_only = true;
 	config.ignore_wp = true;
-- 
2.43.0



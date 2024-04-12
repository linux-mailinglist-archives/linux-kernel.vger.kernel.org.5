Return-Path: <linux-kernel+bounces-142533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E98CD8A2CE1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B621F2319A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4755952F9B;
	Fri, 12 Apr 2024 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1/WMHyR"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF58502B2;
	Fri, 12 Apr 2024 10:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712919038; cv=none; b=jgMCZxvI/7SKoEECo4ZQ4uijPDmmSJsWp509E2Sn30ubqRoZxN0AmGcBP6ufvk8exjSEub4P33+b5ES5vrY8jvHxItzr5/Udp1DYNGAbYj3LkMX/w1B+2g/GkFR6LADpNWXOZMH3+RtQVO2UCGWy+B5HZ1PPHSJCJeBv32VR5Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712919038; c=relaxed/simple;
	bh=EG9jR/QPLwg4Z3lsGtCubxD2TUKTj5A1BfHD47gCkks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pSa6Ym799HtZhybQ+ot1mVE5Rb6kvySmVcGd6omsNpTTg7qJOmYqjCkD/GRMiAU22hXh884il0JpALSWHP2O4rJ8W1x89PtbsLSnCwU0c3YiOmx20vbKPVj2buJPl2ERFcZoH+maY/FTFk5/fIGTHrGwSaeg8QwcFoPDxzBv1Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1/WMHyR; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-518931f8d23so194647e87.3;
        Fri, 12 Apr 2024 03:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712919035; x=1713523835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xk4BMWMVvQupqS79Z5nZKAbQw55+VEr9ka9ICZUphJI=;
        b=S1/WMHyRwmZuK0+//4+Wq9nR3KK+YINF0a9fUaj1UwXb/j0mEeMMjbPpvLAzpHKbyg
         GDKpIw06Ilkfp7GT0BCcuh7X8bIGCsnmTWFl0dLYdmbor8Eie5KZCznqq4fI128jZZij
         WN4YsBHFCp2elXarhfFZEZcP3lZCg0hZuupaYVTTo9LgKTHX0VDDb1OvWF8sNYCydSFK
         amreqZ+BgKSkieKhvwvMB/kYyPD10ZqOIvjuNRuwRwXQQ5tci/dg+0XKLD4rABfjSyuu
         l1WLpWj8yIWes/XQaB5pkGt7w+pli0daKXUhn5kzADRhyIuEIpAfwCWeUfDrnmzvXnYB
         EfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712919035; x=1713523835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xk4BMWMVvQupqS79Z5nZKAbQw55+VEr9ka9ICZUphJI=;
        b=ROnLd0nAP6eu0qyo+SjCifHLCbFy3nzjj55fyCwXSoM47qrE0A34oAGDSXFcI5nY4t
         dEiIPKQEvOLjhF4+83kokRCHNSYvpPmx8Yepnl+N77SIAOLvQSOccbz7riLJGOAOTYL/
         ZKGThYEompHLnRl4BAJlrce/mt1seFWJhJ6pq7auqT1eoSIYuHMAHXSoLEY9drA3fTnh
         Ij2xVIEpKuSfpt3BAcSfSFamJGi1MfaO+a7DJtvK/GTOEpqzhCPCO/3ah3WGRUoKGrMn
         IAf+nOGhIUu9q9t9gH/D/W93mZvxq2WqcsFXA9OEM9bPS8ryGjLGyguyTIPX5iuxdX4+
         dr/g==
X-Forwarded-Encrypted: i=1; AJvYcCUl9o46t+xSsDyOUJHpzTW07QPUPq6QTmoCjQnZXb7PqODhXFG5KjCfXQASDU6/vjl+cTC+u7QCMm9XEW9vyabenOf/NEX0p6uvhgKbBstM17gbBUqkjNGmfodRKMEHwrmYo5dl
X-Gm-Message-State: AOJu0Yxob73QXQaNe8UO5ypsJdejliVlX0vKqAYjBAEmyJNxicEqt/e+
	xpaLfWVLnO80fYrW0pWyuMsRFOrqjItDwAKLZvn+9W5IkfrQ9Xui
X-Google-Smtp-Source: AGHT+IEzG+QBAfudom+xCyCipcpGNwEniBQkhv1ZUiT8+WjEhSRZsAFlyIsgm6AF9vCKCveZaS4kfg==
X-Received: by 2002:ac2:4c12:0:b0:515:d0e6:a141 with SMTP id t18-20020ac24c12000000b00515d0e6a141mr1298818lfq.40.1712919034712;
        Fri, 12 Apr 2024 03:50:34 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id gw7-20020a05600c850700b004146e58cc35sm8595853wmb.46.2024.04.12.03.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 03:50:34 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Michael Walle <michael@walle.cc>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5] mtd: limit OTP NVMEM cell parse to non-NAND devices
Date: Fri, 12 Apr 2024 12:50:26 +0200
Message-ID: <20240412105030.1598-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MTD OTP logic is very fragile on parsing NVMEM cell and can be
problematic with some specific kind of devices.

The problem was discovered by e87161321a40 ("mtd: rawnand: macronix:
OTP access for MX30LFxG18AC") where OTP support was added to a NAND
device. With the case of NAND devices, it does require a node where ECC
info are declared and all the fixed partitions, and this cause the OTP
codepath to parse this node as OTP NVMEM cells, making probe fail and
the NAND device registration fail.

MTD OTP parsing should have been limited to always using compatible to
prevent this error by using node with compatible "otp-user" or
"otp-factory".

NVMEM across the years had various iteration on how cells could be
declared in DT, in some old implementation, no_of_node should have been
enabled but now add_legacy_fixed_of_cells should be used to disable
NVMEM to parse child node as NVMEM cell.

To fix this and limit any regression with other MTD that makes use of
declaring OTP as direct child of the dev node, disable
add_legacy_fixed_of_cells if we detect the MTD type is Nand.

With the following logic, the OTP NVMEM entry is correctly created with
no cells and the MTD Nand is correctly probed and partitions are
correctly exposed.

Fixes: 4b361cfa8624 ("mtd: core: add OTP nvmem provider support")
Cc: <stable@vger.kernel.org> # v6.7+
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
To backport this to v6.6 and previous,

config.no_of_node = mtd_type_is_nand(mtd);

should be used as it does pose the same usage of
add_legacy_fixed_of_cells.

Changes v5:
- Lower case of cell and use non-NAND 
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



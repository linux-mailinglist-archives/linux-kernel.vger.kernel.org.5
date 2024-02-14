Return-Path: <linux-kernel+bounces-65858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B65768552E0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DD891F22C3F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8151013A276;
	Wed, 14 Feb 2024 19:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="ZiDKMayk"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F1360DE5
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 19:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707937464; cv=none; b=jNFGDWywtcCts9HclA4fSuy80J/Cx7qNE3vDHs/fAi4pz9u0SWHA+d92E6R4liLEqbgLA1ozRTwolMQBBOOKJBjIpGhIks1djsTR9GHzCoO0aPRjmDtqbAIPJAoA8e8rzPEyGpVzWpJ2hDaXCEHwO4pezzEo7iKebZgxKSqVqkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707937464; c=relaxed/simple;
	bh=gEX56zyGYCAkYwObM0xHsGCbNkJ7PbZ0/osPmJc0q0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Wv3Owtur14E86RwXoYFxrpTgm/35YVQlyeVmMG4OC/q64WUN5P7D+5GQuWn45swCPuDfIiQMRWHP3luFHKZ8F3UGJk/5U6agqAZe8IRYAkumbycWr31LvsEKNZuFB5zTGpdi+2dvCs67NGT+0XhZ+k2MIBsVo3dzrUw41X9zXlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=ZiDKMayk; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1db51e55023so387205ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:04:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707937462; x=1708542262;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWR3ntY/o3FEZFRnAhLIAn20rtTWHEaVS2u8Mhk+8ds=;
        b=xQqoPhHONbVV4fqcPuif553sUGu7u59HeMpcHHXgdIvYK91mtyt2QmuPW5oJMmLVfx
         tuAKYvoyryk4b+srGXDr7BHvnaMv2AoxMN/MmBO0/UaKHe+s7UNlbnjShQPPfkm6ppg3
         n47ipZUkFLKT61PoIvW4fgLHntPC0LINsxxTsOs/+qzdEQIc8rxmBwYhKjS5b0vrtslE
         v5iauMSMKmZssFJVV4X8dogH+QgAxOQ+mKwLgv8H26x1XJ3+rh8A1rjx96L89DNormdw
         Ju3JWxasAYTzPlLjRCuqm9idcAQ8pyckOR/26l+Zanq/yi9TCR+AGNjWdMpZYHMXRbcw
         qIYQ==
X-Gm-Message-State: AOJu0YxJv4hHEa/N87rgwH1xdzqst2GXn0OZOtbcVWni/GewOnuohbTI
	Dtiq8+Ggfu2GvAx6LvtAHboFpeYF//Rf/8D13xJuBF7/DkX7yyis
X-Google-Smtp-Source: AGHT+IEGpuUxiPCs0DX0Hhb6ikf40nJnGbd2w2cu+ZEnHvz/D+N7xxyjNKN7jFh0nfhbFtvdblJQNA==
X-Received: by 2002:a17:903:11c6:b0:1d9:6de3:9980 with SMTP id q6-20020a17090311c600b001d96de39980mr4405365plh.48.1707937461268;
        Wed, 14 Feb 2024 11:04:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWFyYK66M+6zRoAj+ilUK4rtV6YFugBeieAo7Yi381XZezNJYICO07Xg4NzLNREKSDuJ8f5tWAApyVdVMDS7/daTsvt/gz+RCUZaQ==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id d10-20020a170903230a00b001db3548fba0sm3287303plh.195.2024.02.14.11.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 11:04:20 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707937458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hWR3ntY/o3FEZFRnAhLIAn20rtTWHEaVS2u8Mhk+8ds=;
	b=ZiDKMaykIoqtd1iMXKaRrByVJVpb6E0FB5kp0lSrwqnuf1TUST93bXTzoBPv83S+AUIShv
	vnOPPJL33yOMhUrfaIxFWig7lup94Q9XmAVTyxhQs6T/Av9Mz5+P2L0WekkEl3Lmy/5Zxm
	4YByrLP1hQ/ghgUnYSCznWLv/X6UHbmcjLJIjHOh022d56SfCbZeQSwQFNGEOma+O8PTgV
	aB30p6VeD1LW6TNJscYFoCqwu0UPFk1nqXNNNazw1Mo3YxetclthUwdxSuwEoZHt2EJKOv
	8+yNyjnCWejvyw6SRbxhjraVfEBlngbxn+rkaKidwgQrgWbmNg6q+d8NI2lZ6Q==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Wed, 14 Feb 2024 16:04:57 -0300
Subject: [PATCH] nvmem: core: make nvmem_layout_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240214-bus_cleanup-nvmem2-v1-1-97960007da18@marliere.net>
X-B4-Tracking: v=1; b=H4sIANgOzWUC/x3MQQqAIBBA0avErBN0EIyuEhFaUw2UiaIE0d2Tl
 m/x/wOJIlOCvnkgUuHEl69QbQPzbv1GgpdqQIlaotLC5TTNB1mfg/DlpBOFM6aTWhm00kENQ6S
 V7386jO/7AaQikHBkAAAA
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1235; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=gEX56zyGYCAkYwObM0xHsGCbNkJ7PbZ0/osPmJc0q0k=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlzQ7aZPOBKNcvQUhAC3kdoZvM3jF4EWnb3M/1Z
 MeUY5YrjciJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZc0O2gAKCRDJC4p8Y4ZY
 ppGhD/9s2xWYbmP/4IXXCpCaC2cmbNfZMs9Bk5ZfGETjsd4XGV29yAKgSMq7ePCEK47W9XiLhcm
 dDWPdSu1+02XXh55KoUwRd7cNeD5rTKcpvm8ErJJEQPAOb9ECZxPJNsdqz4i2yILlMT8Wk6e0iB
 f/u7X/r0Rs6/cK0EgT2h409Cb0n49YsNM4J5+I/0NyuMUzOSruCwlX+XchduHXl4xzwIlC2OxiH
 /1Y1/HKmL6b3DolG4yz+Xw58YYrWK2c49EFCDI1WQvtgD8MQRBEPUdNfSWl58PFLhfHyM2+DraR
 2TSDW8n7Lb57Qr627E5y00QqCrCr7ppU8z2n1qaP6k3k2kORDAUudUcQCl8KjTOlD/IndohPYEc
 J33fBfOMC7cJ3/ThJoXe1hjpJ5644JqCJ72GFluZUMcj3AoJTo2Hz+OEuFp1yqhav2jJbbZuSHE
 wguRY8CUVChrMYqfJFSG1xdX0jfib4BNwuCbA+texpmBEP6rfBIeRoIFTC35Ws5tleMIKvxrC1v
 8YAxkJ6ll/b7LM7D4U+TBXEIsG3qkI+IhqWHJbtfF+iwMabSUPsWwlmos/O40UJuckdwg3Z6obd
 ucCEuHBebsdXDfXE/rFPKi6SGVd4ee+sPhZpqeMcSk7mJjlbsdlMWVIJtttvJVjIUVHvu/OpLS4
 aI9UR5GdZEreDSQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit d492cc2573a0 ("driver core: device.h: make struct bus_type
a const *"), the driver core can properly handle constant struct
bus_type, move the nvmem_layout_bus_type variable to be a constant
structure as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/nvmem/layouts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/layouts.c b/drivers/nvmem/layouts.c
index 6a6aa58369ff..8b5e2de138eb 100644
--- a/drivers/nvmem/layouts.c
+++ b/drivers/nvmem/layouts.c
@@ -45,7 +45,7 @@ static void nvmem_layout_bus_remove(struct device *dev)
 	return drv->remove(layout);
 }
 
-static struct bus_type nvmem_layout_bus_type = {
+static const struct bus_type nvmem_layout_bus_type = {
 	.name		= "nvmem-layout",
 	.match		= nvmem_layout_bus_match,
 	.probe		= nvmem_layout_bus_probe,

---
base-commit: 2c8df24cc166478910c4e9e870adf44d157330fa
change-id: 20240214-bus_cleanup-nvmem2-b77804172a0b

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>



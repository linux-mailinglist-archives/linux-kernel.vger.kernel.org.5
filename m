Return-Path: <linux-kernel+bounces-134791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE07189B6EE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4995D1F21D72
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5848F17BDA;
	Mon,  8 Apr 2024 04:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qz5uGkLP"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C177F6FA8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 04:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712550658; cv=none; b=ZrxQp+RKu/yfkIIN/diyD2PBlcskKgR6ZAWTAPwLAmZ5OdkxikoMVp941rCvRBbGfyZjfU9T3Gq9b3x59YV0xYv1MC4SYPfz077Q2bL31HaZyOs478pLZ38tVcb5dzCB0GLypytB5V0k81LvCSYoKDFaXVTqm6y3xjF88fgvnH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712550658; c=relaxed/simple;
	bh=6Pp8ISuDZAtUkxCFA5Mzr7Pj0egqS4eDsl4x+9fdzEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z0wGUMZY950lB6RA2ZjLFO2iOV8Yjd36BCiz50XC04IuJmZ3asBS3RmyliKZ9VH9NGZwNr6cYToZRErhtxwI617b2fPdAPJ9ZE/qujyXpBoMGngZhD6/kGgZ9t0cb7z3zKmZbtKEo1oUC9aCIZye/JuLQDRNOrHNhsviXL+VJ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qz5uGkLP; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d4360ab3daso45899081fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 21:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712550655; x=1713155455; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENukurxkpnH6btr43WV4x/+l5y/bB4zzdKjrs7ksqE0=;
        b=Qz5uGkLPm7X1ffIvwhdN7kZdNkRJz5c9tU2AU5YzS92xA0Y3PMMbRcCJo1ztnpYOot
         ki5kORBS3g4z2H60jLqTjwwYAl8+TyX4XtECgpDhqb8YOumywlRFmzduS1m4ORorTfdj
         7/E3PbxOYpDxAjceibZYXVL9/6JI/k/bRCrX/zzN020aiKAz8jf5tRG5NoXosMnk4sMY
         btNHUxrwKujJEeGuk3JlDEogCONyjEINqexShjW8IhCgh36ZMm2YewsA6kq1tXmEQUIo
         k1sww6Dr4WXjt4QtcjkZns6heVgIyw8cMtQflSIwMDpilBWPmPKWv230oynjmEcgV4c4
         0uwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712550655; x=1713155455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENukurxkpnH6btr43WV4x/+l5y/bB4zzdKjrs7ksqE0=;
        b=paC59iDYHgESIEDrna0r9LGKJa4JAMkWYTGjUpoqC6FMWyMdQqAdXtyLdSs7m3ovCa
         hL51SkIfir6dkpavt5edLOmQwyPRSMBA+NZuydGUrgbekCtsY11KOgJ0CwpSdHQNEgg9
         1VIS2h6YPRzFupVhVGdfP8gtGZyYFw1CMi/sL24KhcneH3nbIgstHKeg7ILofLBy++J9
         UxK9ExjOX7s738XAcjPdSIkyoynAKBOaarfG1e1AhxZDv+EzO8huqBaTG9nd+Efr/bCc
         smYzSR1vKeRNCy6tWL5b1vxwf7Ge+YF+KzBvrRWs5PwEMiz9coTeU4YCiTXBetgmRf8G
         oJFA==
X-Forwarded-Encrypted: i=1; AJvYcCUT8LbpcUof1Qb/6mMDTFHjQhjeanFT39vipqIAX5w5KKVjXSGbx0SVTMVdiJG4v7SQ24ixDHHN0W5H/K8wlhHBYLYmIOdEAU+QtfsL
X-Gm-Message-State: AOJu0YzPL+FSFdjhnlHX7j0Om5WgDDbSHgizSN1VF6vQ7Ob1/n0h5QkG
	aqUZptemzpzkTqJJ955EPh+LHeIHbJoAI9NDyc94m7NtUAn+RL7sWhleHyX6kSQ=
X-Google-Smtp-Source: AGHT+IEjiBzAFkgSlnDA5c4dvuKfeCyu6QTyl5XSf+HAw91rTnk+Y0NsxdtJ8Wa70bGWdxCBEcih7Q==
X-Received: by 2002:a19:6457:0:b0:516:d17f:3c30 with SMTP id b23-20020a196457000000b00516d17f3c30mr5266580lfj.3.1712550655081;
        Sun, 07 Apr 2024 21:30:55 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id g13-20020ac2538d000000b005132f12ee7asm1033207lfh.174.2024.04.07.21.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 21:30:54 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 08 Apr 2024 07:30:51 +0300
Subject: [PATCH 3/5] usb: typec: ucsi: glink: use typec_set_orientation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-ucsi-orient-aware-v1-3-95a74a163a10@linaro.org>
References: <20240408-ucsi-orient-aware-v1-0-95a74a163a10@linaro.org>
In-Reply-To: <20240408-ucsi-orient-aware-v1-0-95a74a163a10@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, linux-usb@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1822;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=6Pp8ISuDZAtUkxCFA5Mzr7Pj0egqS4eDsl4x+9fdzEg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmE3L7gAxLAJjmRw2Ft1WpQQJcHwpO52VWP8lAH
 1Anz7mkGzWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZhNy+wAKCRCLPIo+Aiko
 1aIAB/47+POeBCZy8cZ2CnEAbZYdtAhvloPtBOZ2ao7zEDTzYMD8yRKcF2Iacq7wo3MbDVfS+4+
 sqUpRs2ENNWrinfQxmju5WLt/I/i3ReB9u3GVXxbkntyVQUGVuxRQ4znK7Ekskc01gSU1mJ2XZW
 x/W9gQfwMSkvgpzCDK5WRZTcbh8yGb5dVt8VU1pxIWhE6h2PhsXZLTFiwfSE8WFS10oqmb2apPV
 DrUHjXYCoEK8j+LmH5IU3hy+tbyDGs5KKDDkpsgkZFGA+xOJSnazYJRT43Brg/ZBqdw3YpGvgPv
 Pf+36qEskA3818lMpuofRHUNRTvhDmhXIBSvZyc8l4/BvBZV
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Use typec_set_orientation() instead of calling typec_switch_set()
manually. This way the rest of the typec framework and the userspace are
notified about the orientation change.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index d21f8cd2fe35..d279e2cf9bba 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -58,7 +58,6 @@ struct pmic_glink_ucsi {
 	struct device *dev;
 
 	struct gpio_desc *port_orientation[PMIC_GLINK_MAX_PORTS];
-	struct typec_switch *port_switch[PMIC_GLINK_MAX_PORTS];
 
 	struct pmic_glink_client *client;
 
@@ -198,9 +197,10 @@ static void pmic_glink_ucsi_connector_status(struct ucsi_connector *con)
 
 	orientation = gpiod_get_value(ucsi->port_orientation[con->num - 1]);
 	if (orientation >= 0) {
-		typec_switch_set(ucsi->port_switch[con->num - 1],
-				 orientation ? TYPEC_ORIENTATION_REVERSE
-				 : TYPEC_ORIENTATION_NORMAL);
+		typec_set_orientation(con->port,
+				      orientation ?
+				      TYPEC_ORIENTATION_REVERSE :
+				      TYPEC_ORIENTATION_NORMAL);
 	}
 }
 
@@ -378,11 +378,6 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
 			return dev_err_probe(dev, PTR_ERR(desc),
 					     "unable to acquire orientation gpio\n");
 		ucsi->port_orientation[port] = desc;
-
-		ucsi->port_switch[port] = fwnode_typec_switch_get(fwnode);
-		if (IS_ERR(ucsi->port_switch[port]))
-			return dev_err_probe(dev, PTR_ERR(ucsi->port_switch[port]),
-					"failed to acquire orientation-switch\n");
 	}
 
 	ucsi->client = devm_pmic_glink_register_client(dev,

-- 
2.39.2



Return-Path: <linux-kernel+bounces-51926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8EC84911A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 23:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2511C21466
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 22:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29B03308A;
	Sun,  4 Feb 2024 22:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="PsAKe+jQ"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A61932C8C
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 22:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707085578; cv=none; b=f1oVyzgFgEW20CF1JUOjcniQvFt0OW1ru07aiQXfjrIfEu20AjRGKZBHLqzuS98PpdmHGiobQsF6gY0FtX+WVP+2RegNM2K82jNU3nO+KnXjYe0NgfXxrYJ7rJJwmNCEaqtbLAr5HBPxgzPMhrrROOXPKJQxQKq7EO7yzmsnfhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707085578; c=relaxed/simple;
	bh=cfKZA8JwrvajsKT7dpAgmq7Gng3G8VVQ/bL8Td3NETM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RfJRz5fioBRiMpEQ4KYSAf5PM6CDmq9ZLPetgo4uD/rsSnwF9CvJGmLaeOSZDS4QJv6Wwpj6/3fsWcf8v+mQpvzOl/69aUVSbc7fdkZ3Q6WWoUZdRMxrHx9y1+Zmm2zcSSq9tmTDbyrdDDOux27xyl4ctQ0t8fpMAEoIV+CGiGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=PsAKe+jQ reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d934c8f8f7so31056725ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 14:26:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707085575; x=1707690375;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/W3LZp10TffmhixcJTAtNyq/vNddBu7cZnZ3wB42iI=;
        b=egcXQCfmhJqDsDc5J+xUltRsUiEIVyPDq5zCN6eZ6577NnkXBfMshOIRz4Rl8gUXLH
         uGLNIfw4pdXCaxnMm6EYhOmEc2cT6vVuH3ZyljBmLVBPtFQZD6V06A7tGvScDUbDrG2t
         fVie6iF6mTjbCMvoLloiKuIOP/C1sM/OvDrmPAsIU8K4U1V/Yf1YyeLmR/QfN/6qCy/O
         ro0y5ccZEQlbffIJbg9Yi4SDPOWGzDE/WlNiPylxEKteM01mZwc+x1AVzF57uPWh+/Co
         iNdex+dT9/cPS1+FhKgHz7d3TTqd+e0ya534A2cNbSVl1+XL2moX8MVcY5NpaVDA6D6v
         h+Dw==
X-Gm-Message-State: AOJu0YyOmoNNBBRqJEqwyShyVnPxDvk22/wurvmZmZe6pSNw7gct6d9+
	7Pk0h56jufKGcB9UNO9tJw81fxcz91UYLIY+Wz2luFSjq0Z9wzAd
X-Google-Smtp-Source: AGHT+IEB3YTuZ2rtsv5qr2qwTifieDMcUh3qbuA2JzvJ1XjBJDG7pm6Fq6/xDFjZDri2LxN2lca3Wg==
X-Received: by 2002:a17:902:6503:b0:1d9:50ca:c4e4 with SMTP id b3-20020a170902650300b001d950cac4e4mr10107774plk.27.1707085575482;
        Sun, 04 Feb 2024 14:26:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUmf1ar6HoNz9k3QoCfNJMZNLrXSBzQAzhznLpXMydALAPsHvdXr/etEZcL0LDxywxnz/zJCSJqLDLNIThwrTIRNIbjYhKRbgOMCaswWW8mp/6r9O3dU/ZPg7djGbDIlQE6Pf/XqS9mrqThezA+677d1VJCTj4/Wvnm6/yPYw6x0Iw=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id ix3-20020a170902f80300b001d8d7323ea2sm4960919plb.74.2024.02.04.14.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 14:26:14 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707085572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U/W3LZp10TffmhixcJTAtNyq/vNddBu7cZnZ3wB42iI=;
	b=PsAKe+jQtT/rGYzZtzzaCnN0YC1lCftCvZdWuXuRSLfCr9na7u5Lh5ePRvdUUjwn9I4d/X
	2rey5FJdAimV6OfByFoFfBdI4tMYdarvdx5yV9akPvMU2B/Ol16YNBL78ADhQ0OLSCgU4b
	mX7KyciXbLk6bY0CndnNSePWbQzy81rJoFGv2HgKJ9UTvII+bTzFhbPIT64+daJpymwPjI
	+jlatItxTYurGKmSBAmEL2lYCD4W+j7/V3D8con+8cPghU8DG/1oYGHSkkuleC3WqCDt0K
	aAlOygpyM0/JwyadIKMyGYJsizXnFwrdkdqASAAh3nIDHH8vpeIVa+xow5fsow==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 19:26:42 -0300
Subject: [PATCH v2] siox: make siox_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-siox-v2-1-3813a6a55dcc@marliere.net>
X-B4-Tracking: v=1; b=H4sIACEPwGUC/32NWw6DIBREt2Lud2kAn/Wr+2hMg3ipN7FoQImNY
 e+lLqCfZzJz5gCPjtBDmx3gMJCn2SaQlwz0qOwLGQ2JQXJZcMkL1m/+qSdUdltYKu9Ma9PUddk
 bXt0gzRaHhvZT+egSj+TX2X3OhyB+6R9ZEEwwOQhZNvmQq0rf38pNhA6vFlfoYoxfJ/bO37MAA
 AA=
To: Thorsten Scherer <t.scherer@eckelmann.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1371; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=cfKZA8JwrvajsKT7dpAgmq7Gng3G8VVQ/bL8Td3NETM=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlwA8i8xFpMojsLwkbWThcTtc+VMz3VSZr9mIrK
 KV5PjuKXwaJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcAPIgAKCRDJC4p8Y4ZY
 pjcxEACMW0ir7f2kHqm0IDM+RKAFkcaXinNLnlT1C5RAdoIoo0f2vYtda5Joz/IxM0nLQortN4z
 LIrNx1ny8LdnX+rZ5falz0TNXVGtA5v7i09qsRxC72F/FhVSAOwf51QsHxZZtMLgOwHTbvpSTlA
 FUJgPB7tCaqAqTqq/+h8QKnly/VNUm7Jw5ybHeICPHikSemnFLmkiTXhJCnECC01tqAbVPYiRF6
 4leyH32cqw01ewrPCAaXbOwlztJ6bLUPm29Ncj1vZdPB1bHmMhI+GHAEd0sFL53ot+sActJX7ZL
 kPC+K2WzMs6391Hx0aIlVJkpkiw03aWBgKjSbrDE4fGEhR1ksWaJfDSNh056r+f3jFmqmIMUEVK
 8pWf2nwJgyQPrvcyNRZj6hIoDKx8LomI8F5r+ksDf5z78gJiOcdnTuIRQ2LmPaR0M/n8OAVmHdX
 HJSbSH+1+yq/7Fi+ducoY3hU7mN7boTCWu90xM0lqWKqtvFB0ZyMbfS4QOS21G+KA5kbf0aEERR
 lRfnt04nkuHyDQcUeCmTAL6dTPUF+ojENjDOnHa4NznFYuo4gCuRVNGdhcAXbD2VtSNeINNedQs
 oChYCLrqs/P8KTuCr5Fxg/jNAd1W9HpJq3c1EGLkrrF6u7781ZW/GKxdSAivMzc8wraLzFHmTWQ
 QqWgFGi3Ypequhw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit d492cc2573a0 ("driver core: device.h: make struct bus_type
a const *"), the driver core can properly handle constant struct
bus_type. Move the siox_bus_type variable to be a constant structure as
well, placing it into read-only memory which can not be modified at
runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
Changes in v2:
- Fixed changelog: mentioned commit d492cc2573a0 instead of the word
  "Now".
- Link to v1: https://lore.kernel.org/r/20240204-bus_cleanup-siox-v1-1-2d12583d3a6c@marliere.net
---
 drivers/siox/siox-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/siox/siox-core.c b/drivers/siox/siox-core.c
index 561408583b2b..a1eda7bd76ed 100644
--- a/drivers/siox/siox-core.c
+++ b/drivers/siox/siox-core.c
@@ -543,7 +543,7 @@ static void siox_shutdown(struct device *dev)
 		sdriver->shutdown(sdevice);
 }
 
-static struct bus_type siox_bus_type = {
+static const struct bus_type siox_bus_type = {
 	.name = "siox",
 	.match = siox_match,
 	.probe = siox_probe,

---
base-commit: 41b9fb381a486360b2daaec0c7480f8e3ff72bc7
change-id: 20240204-bus_cleanup-siox-ccf8775bf069

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>



Return-Path: <linux-kernel+bounces-123510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8635890A02
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AC491F244FC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BF713B596;
	Thu, 28 Mar 2024 19:50:45 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFAD13957B;
	Thu, 28 Mar 2024 19:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655444; cv=none; b=VRIJBWHHyL7sLFlMq3PamrAxWM24E1uSvN1E04oWNVGCjkNQvZJ/QL78ku4/lpbKW82v3UFIiQVpfFLnFCS/cwY98pVAh5eyCh52mkdN9tN/vn1lQDGBSNuGgmDnJF9oVms57fY1ZA5n6OvZAxpAkT54/U/lmvKnyrwP4LaPy0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655444; c=relaxed/simple;
	bh=bp47ddJMjIQ5/SWy3n969WYfRfPfoIUb5K9bse8GbEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sWRT+pawEu46B4IMWWZr5DYsj04fv3rD2qMtJ4ZR42T9x/Ov4ygSmgE+/0NDv5R9G+x6XNWuyMMBJw8B++AJQeU3ElOIFpRwND6f+OM+QeGSZdhGIqn8T7YWuigA/Dx9zxdCDWl26Zh93Bp31Uss7r+guwRSRqyOVp2Ip1gVIUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BA2C43142;
	Thu, 28 Mar 2024 19:50:36 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 20:49:16 +0100
Subject: [PATCH v2 06/19] platform: classmate-laptop: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-module-owner-acpi-v2-6-1e5552c2c69f@linaro.org>
References: <20240328-b4-module-owner-acpi-v2-0-1e5552c2c69f@linaro.org>
In-Reply-To: <20240328-b4-module-owner-acpi-v2-0-1e5552c2c69f@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Corentin Chary <corentin.chary@gmail.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Matan Ziv-Av <matan@svgalib.org>, Mattia Dongili <malattia@linux.it>, 
 Azael Avalos <coproscefalo@gmail.com>, Ajay Kaher <akaher@vmware.com>, 
 Alexey Makhalov <amakhalov@vmware.com>, 
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, 
 Richard Cochran <richardcochran@gmail.com>, Theodore Ts'o <tytso@mit.edu>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, linux-input@vger.kernel.org, 
 netdev@vger.kernel.org, chrome-platform@lists.linux.dev, 
 platform-driver-x86@vger.kernel.org, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1931;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=bp47ddJMjIQ5/SWy3n969WYfRfPfoIUb5K9bse8GbEg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBcnDAE9WAhKdt+YISIs3ScByHxrEuXeEODw34
 +YrKxhmhhmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXJwwAKCRDBN2bmhouD
 14tDEACJbHvOZiNOZTNjIQWJaJLFBG9WTqcTieozh2AkcnXobGXqgLtfduTaFVkWn71vgCHzl3X
 YGK3wHWBxtoAAA4IB7tRtAK81gFo0yq7ReRgXiT0OnfBmUUmFLdmp+a+OgC0bU39R/NhWzyB37a
 55+TYFQ9+1AiNlgEstn8qZUtZ8TPC78QKN6lhUvj45j6NIzdu5jP+H/a+g2+RepeZUMwToVRkZ4
 z3UCLArOcSnjy7U0biSOMKBgMY9pFH4ZaEjC+Dx/WKDWJa4RuJXweuGFtWBfIZTCMaTCVegAyWN
 kSilku+B2KnPD74j5CTcVF3+njEmsfOI/DjavqFXYxrg9KO7Is8tXFyP/V7Ip504Umh3NaxQqfM
 I65f/vkk9V7eWfBeVcUytVA/jgpXChvpRo4t6KFiLaDRvT8heGWK5MX2C4yHL1klqeFUsLYOQjI
 WYvhF8Zf7rC+0ytc9lHnkKjzMiHYAq36q+MYrH/s2IBU31seKbGz3DAuqW19S6+3ZmsbSMmoxZ2
 nQx+jlB8KzMh2HNWk9VQZUVw3zcApM5DL7ilWWalH37zsCWYiRuYvugLQNgAPcUqtJZRH7kBhbY
 pVygzjkLJo3EBu5hvqyWW9IaVOjqamBPn2NeJ2mrI7cwELbHNHvl8dBTcVLqU/U/zko5osJAXnq
 +PiIY5d8BMp7syw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ACPI bus core already sets the .owner, so driver does not need to.

Acked-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/platform/x86/classmate-laptop.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index 2edaea2492df..87462e7c6219 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -434,7 +434,6 @@ static const struct acpi_device_id cmpc_accel_device_ids_v4[] = {
 };
 
 static struct acpi_driver cmpc_accel_acpi_driver_v4 = {
-	.owner = THIS_MODULE,
 	.name = "cmpc_accel_v4",
 	.class = "cmpc_accel_v4",
 	.ids = cmpc_accel_device_ids_v4,
@@ -660,7 +659,6 @@ static const struct acpi_device_id cmpc_accel_device_ids[] = {
 };
 
 static struct acpi_driver cmpc_accel_acpi_driver = {
-	.owner = THIS_MODULE,
 	.name = "cmpc_accel",
 	.class = "cmpc_accel",
 	.ids = cmpc_accel_device_ids,
@@ -754,7 +752,6 @@ static const struct acpi_device_id cmpc_tablet_device_ids[] = {
 };
 
 static struct acpi_driver cmpc_tablet_acpi_driver = {
-	.owner = THIS_MODULE,
 	.name = "cmpc_tablet",
 	.class = "cmpc_tablet",
 	.ids = cmpc_tablet_device_ids,
@@ -996,7 +993,6 @@ static const struct acpi_device_id cmpc_ipml_device_ids[] = {
 };
 
 static struct acpi_driver cmpc_ipml_acpi_driver = {
-	.owner = THIS_MODULE,
 	.name = "cmpc",
 	.class = "cmpc",
 	.ids = cmpc_ipml_device_ids,
@@ -1064,7 +1060,6 @@ static const struct acpi_device_id cmpc_keys_device_ids[] = {
 };
 
 static struct acpi_driver cmpc_keys_acpi_driver = {
-	.owner = THIS_MODULE,
 	.name = "cmpc_keys",
 	.class = "cmpc_keys",
 	.ids = cmpc_keys_device_ids,

-- 
2.34.1



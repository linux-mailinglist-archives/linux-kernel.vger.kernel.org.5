Return-Path: <linux-kernel+bounces-123515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8C7890A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0C61C2ACC0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D400813C3C2;
	Thu, 28 Mar 2024 19:51:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC7913A86C;
	Thu, 28 Mar 2024 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655487; cv=none; b=t2PzoxmqgYa7Ji08teZYXf/CMdbSDSj3SlqO+BaGPVILSvjvWTeuTto3qbaxS4Vps39ZQsO5CtgQU00YMfEhzpXtU2OwKhvym/na603SP5IrfJuYXmiod1tzC6cGjSFp7qb414vfpd9nz4jGXbDW1p1Sxsi0+v/EiR8obWfKFW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655487; c=relaxed/simple;
	bh=5+ORG/j/kb1Cve3f9rEDzoG0cfc3WHU3p/pEfGdSHAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BdgJS86Rzq/SuqkEaO/4hFCWU1DujNs4mVEDyP5NK1/Ax9+LO1PimQyJcmlKTNfjA64hrLnGh48v7xmlKVRFXEplEgdGynddfvwjn0HaSgHC1kAxHHzi+Ty8oas5R190SqvoJAn90+Uiek9WmjfNDdozCCUrRMl5wY8CX1bAvvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7417C43143;
	Thu, 28 Mar 2024 19:51:17 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 20:49:21 +0100
Subject: [PATCH v2 11/19] platform/x86/lg-laptop: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-module-owner-acpi-v2-11-1e5552c2c69f@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=735;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=5+ORG/j/kb1Cve3f9rEDzoG0cfc3WHU3p/pEfGdSHAI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBcnIQ8hQdZMOn2jGeMGfQmpim/Q8HVFW1L/dr
 QNO6uQwzuCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXJyAAKCRDBN2bmhouD
 1+j/D/4m8pRSwGGl6rlDdeTZDx9mSnA1417XbXeU4pItzPnbaows031JtAyLICdsNKXciXft9j7
 Qf/V/BSJTL4zZ6/LHVOXrdp+Et5Xr0ZC1eA9p/Ps05WqPVxYXGLXehHX04DA8bL9GzOjYUPttF2
 T3LesFXytBT/aHgNedyO3OjIsVcqtwixwiqH9e3oIKF1w8Y6oWyy/znWKCb7ost4WlpK76USI1z
 62zowiRAFb5q0FI3ND3gf80gicXq2eWRTq8di/vwLQu7IjCr6feL+F173ZKquG8POzM0u0kdH3N
 1iyGmVZi6FY2GLmwo7qJ0cqNRU8OrVTqWY0eN0eC1Jt1BEukU42PRrNNsO1lJC/eMF9/NAJb7HD
 7iPDZdsxE+SCoM6sEThSQtx5H0wLx7ii5iZvt37cr2LsWDem5QdP/EFS6Ps83fwbDKQlrIuNtZl
 as6gRFiIKOr08JZoor6vhIFltMs9xMnq5BTqPEmmguQMZUxNgDBfkDgTjyvYoDMDZUZ/izsDa2w
 kfbm7lk7rv09s1oJXq0Ioc29YInWiF7dEr42V4SuLuUzf+2pgvocdVLp+qdtIsnOEnf3Yi//3zs
 ftUOyLVgdcK/DbyE+M1nLfSmvJnvvP/BvrhNWqC1uKIh7VeJbMRRdO/4c+NLIKSvky/R4ePPRat
 U/Cgj3Q6W/ueC5w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

ACPI bus core already sets the .owner, so driver does not need to.

Acked-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/platform/x86/lg-laptop.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
index ad3c39e9e9f5..36e88b9d59ea 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -790,7 +790,6 @@ static struct acpi_driver acpi_driver = {
 		.remove = acpi_remove,
 		.notify = acpi_notify,
 		},
-	.owner = THIS_MODULE,
 };
 
 static int __init acpi_init(void)

-- 
2.34.1



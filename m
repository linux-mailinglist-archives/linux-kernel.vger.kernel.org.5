Return-Path: <linux-kernel+bounces-144296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B15B8A4444
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 19:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409651F213F4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC03136649;
	Sun, 14 Apr 2024 17:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Na1NUYLe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC0C135407;
	Sun, 14 Apr 2024 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713114092; cv=none; b=FsV7d4fCR6VEH1vQDCfjntO4Ktwv92PNKGrpjM9/D1TFQHi+hMQtZa2OcC+LkQJ5TW3RZB1f9xVacY7kPWPNbMSWpMqXclw9aLZIl9NUx5CHZ9YVwFbJZUYYOAHuSw4iokeEVTSVvh4u6Izqvq80AlBDdCczF0indMz+UkcTQfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713114092; c=relaxed/simple;
	bh=68xt7Zl6oS75woZQFbbtcf5AEvnxXJ4zbEAjvFHKlSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ELAbW9bcvqKManGtGjFX4kOiVEV0K8V1Pi1XeU4VgAvxnpXMlmdnpO8snkgjOrIcO96fgFapYo94IsrTf3l+FENKbj0eL8k9ptMHljD9pP5FGRrkjYQRHAV0fELhmv+1IY5Qtwm+iFPqle8K1PlY0i52ftllSXhAEMJalGB0Ho0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Na1NUYLe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD829C32781;
	Sun, 14 Apr 2024 17:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713114091;
	bh=68xt7Zl6oS75woZQFbbtcf5AEvnxXJ4zbEAjvFHKlSU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Na1NUYLexRksUs+vypvnWGeGqT6Ov2mGXyCS4zHuGd0qcpSrnydkxAJt+uk1sn9zJ
	 f9Ws0eijnpaktEKJ0w3B1o+SXaWYCGSdsvDQ4kdqYHgWX9cyAeK1mq2ID4kybgj23u
	 aJ7y5q8xielyXoGw+WJe5N1lnS5DFCXmqFC7N74aJlJeDVCk8XJkIi2L0U+ywDpoR+
	 GGEAE0BXuARMmV+nKezllwXcAtoQ9/PhAfkXIpxWwxhV0R7qZHnbfl/adnJ2tV/0Xm
	 61NwKk5xQn24Iba3NLbB8vscCPCluOVwy7F+ObM+IZbFQavhQAy69o5xTMa4YlrGzi
	 rcZc7MqN2608Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DF6C05023;
	Sun, 14 Apr 2024 17:01:31 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Sun, 14 Apr 2024 20:01:23 +0300
Subject: [PATCH 3/4] ARM: dts: BCM5301X: remove duplicate compatible on
 ASUS RT-AC3100 & AC88U
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240414-for-soc-asus-rt-ac3100-improvements-v1-3-0e40caf1a70a@arinc9.com>
References: <20240414-for-soc-asus-rt-ac3100-improvements-v1-0-0e40caf1a70a@arinc9.com>
In-Reply-To: <20240414-for-soc-asus-rt-ac3100-improvements-v1-0-0e40caf1a70a@arinc9.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Hauke Mehrtens <hauke@hauke-m.de>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713114081; l=755;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=7GCgujVUrJeA8ePIinKhDBblwNfvpTAeDc0zJTmfQ78=;
 b=tTf9mICbwbUHVFCGoZzFsEdu5Hulm2dWxlh+OwxaTG1Mb5oVITpwaLareFHGK4SvScM8QkLht
 x8T4iVz96ETACCQSnIkTOWExpKyWKq9Rl0RkzNb8Lfsa7hlBhed6dZY
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt
 with auth_id=115
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Arınç ÜNAL <arinc.unal@arinc9.com>

The compatible property on the node with the srab handle is already
described with the same value on the included device tree. Remove it.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dtsi b/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dtsi
index 9271792a9e44..84d583168d81 100644
--- a/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac3100.dtsi
@@ -101,7 +101,6 @@ button-wps {
 };
 
 &srab {
-	compatible = "brcm,bcm53012-srab", "brcm,bcm5301x-srab";
 	status = "okay";
 
 	ports {

-- 
2.40.1




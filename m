Return-Path: <linux-kernel+bounces-48065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FC08456D1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1921F1F28F78
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0157816087E;
	Thu,  1 Feb 2024 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmLebLwU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237BC160874;
	Thu,  1 Feb 2024 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789024; cv=none; b=uLOq+R/wWYnc1NdUyOW5KNJAaKEX4lGPdYsXIKmcxG4uEOK/B+G8M9HhKjpe6d96jREEe9Ri2s2Dk0gBXABjwBvL0nRtUGbbRQLB/D6TJ+v4+5rFqXdQxQpB77IL2snM+wrwtX5krN2uo0lXw6/047pvbaSzodH25VVwW+zSXXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789024; c=relaxed/simple;
	bh=8PY4KboI/lU7yNn117uZUCKReF1E0FByFkI4iEpBXas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H+IpZy4qsd1QpCqkMrkYNONPngXB6mDvNEBvG9hPMWat1o2B9NOzbMuWHdbQnuOu8kfbNKO0Xb/bKdOH++oinsr+Mt9/81ik7W8+GWJRERaPVELG1QJ6irz2aa+UYbYtPEA1RDwsKiuIRZcVFZggu1+8m3RqXifaYDJKrxiE19I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmLebLwU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E03C43394;
	Thu,  1 Feb 2024 12:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706789023;
	bh=8PY4KboI/lU7yNn117uZUCKReF1E0FByFkI4iEpBXas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QmLebLwUQ7lIInKf3bHIZnPKRRVsgun7NH9zWFSxt/9T4Ud3+bTLcFhC5pzPNHGQV
	 JV2HrCC7A5IBMjJLH91KBmP0HR7jSsRwIh+PobWmjBbeMtFkFlSvsKlSLEovVMWZ/8
	 9SKdxddJiEeUEzg3+2BeNCN87Mkxc/cTV97dF2VCCqB60QOqAzdjRxiZj/Y496vNsE
	 2F1nNqHwlYLWXJKGr82U4qW0BhScO1Z+rSiiTuw5D9Y5fqaU4h0ADNDvBXJE2UyxG8
	 rz4ryRQYhWT9txy+9hREs10pGDh25alqxkfhMwP+pWsYsAFDiGFem56tmWJlXIKwAM
	 galWz3x8Oyudw==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	vigneshr@ti.com
Cc: afd@ti.com,
	kristo@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	srk@ti.com,
	r-gunasekaran@ti.com,
	b-liu@ti.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v3 1/5] dt-bindings: mfd: syscon: Add ti,am62-usb-phy-ctrl compatible
Date: Thu,  1 Feb 2024 14:03:28 +0200
Message-Id: <20240201120332.4811-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201120332.4811-1-rogerq@kernel.org>
References: <20240201120332.4811-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the compatible for TI AM62 USB PHY Control register. This
register is found in the TI AM62 WKUP_CTRL_MMR0 space [1]. It
is used to indicate the USB PHY PLL reference clock rate and
core voltage level to the USB controller.

[1] - https://www.ti.com/lit/pdf/spruiv7

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---

Notes:
    Changelog:
    
    v3 - add compatibles in alphabetical order
    v2 - New patch
    
    Changelog:
    
    v2 - New patch

 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 084b5c2a2a3c..9437705af92f 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -72,6 +72,7 @@ properties:
               - rockchip,rk3588-qos
               - rockchip,rv1126-qos
               - starfive,jh7100-sysmain
+              - ti,am62-usb-phy-ctrl
               - ti,am654-dss-oldi-io-ctrl
 
           - const: syscon
-- 
2.34.1



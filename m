Return-Path: <linux-kernel+bounces-64220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A98853C1A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F571286685
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB8460B94;
	Tue, 13 Feb 2024 20:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsySa6xI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821C160EC3;
	Tue, 13 Feb 2024 20:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707855240; cv=none; b=p6n8bwb+bY8SIabZmUZo2afRJzas1K8WHfl3JlmwmzMkQij5DWYY7PlT+Wj12nv1yb6JRwdKUxW06+0pUDcmv9UKwk1FDj9knR1i9/LJH7aL1yreiMVFXsY6lwu06vunfEVR+WHhL4IRUYsrTQBGs8p9EIjLtPtzRBdytB5ZOxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707855240; c=relaxed/simple;
	bh=oJqi+TkCFTQfeAF3TAmEu+UcwKS0++cFDBDB9TAcdDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jEIpx/mpZuBP32DJcJmskZ9uQ8tGtJzuYKH50NE99NdgETtQnOBGaER3bIG51EwkVxMtu5StetpzvbS4cFescrxcJ1eWmO7Qf6TK3ye+haYJzrTUw8gNwGP4huXHh74Y/cG2R+w3RVbibO1xE4f+5iF8Ltf/rCfmBghiwtm2uoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsySa6xI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAF2C433C7;
	Tue, 13 Feb 2024 20:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707855240;
	bh=oJqi+TkCFTQfeAF3TAmEu+UcwKS0++cFDBDB9TAcdDA=;
	h=From:To:Cc:Subject:Date:From;
	b=rsySa6xIVALy8A8vdXWYBEIVuHAhI9HBVDZNQLg+JtlYjWUVfiVVJSG63o7py12SH
	 jMCKONPxC1IaLaxVnQmfhbucetwhFWPSpUYWHenWfaj412Q5G53e016I7CP4Q3mZMF
	 wYxSD4TlnfRKCa+3f2Yr4bMdrNNWQAQ2YKaZ4jljvHWeq1WEbvCBJlt4VK4/KCPsZX
	 2glaNKmDJIuasE/s9o0XtMsVjZ7uEKaVqHZaHIXig6q+J1q9F4ZCFgf+bYVGQ/YR1w
	 yUX4nhhRdlIw7BTSJ3iaJBLV+E6PU4mLbh8LOODVCb0IZsRKdVUjkUJGd4ltHzoT4q
	 Hh64pW+l2EzRw==
From: Conor Dooley <conor@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Pavel Machek <pavel@ucw.cz>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: leds: pwm-multicolour: re-allow active-low
Date: Tue, 13 Feb 2024 20:13:41 +0000
Message-ID: <20240213-verse-clinic-e6de06e1f18d@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1565; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=EBDvz2f7L83vswny9H9PgyID1DoSZ6oLH7Vj9u17jOE=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKmnz5ZKr2S5F3UlL+9BSMDiAx6plTP+ibWVRv5IWz/JZ Jld4umwjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEzkyGOGf0oc25gmJJauXLQ4 aLNKEvPUXyahsYz3RHq73eU8Jxz10GP4X8bZfdtzyZ9flk1bjIrsVptFn57Tkxvv8vtdQPPtqnm a7AA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

active-low was lifted to the common schema for leds, but it went
unnoticed that the leds-multicolour binding had "additionalProperties:
false" where the other users had "unevaluatedProperties: false", thereby
disallowing active-low for multicolour leds. Explicitly permit it again.

Fixes: c94d1783136e ("dt-bindings: net: phy: Make LED active-low property common")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---

I'm just assuming this is intentionally restrictive, if its not, we
could easily just change this to uneval: false.

CC: Pavel Machek <pavel@ucw.cz>
CC: Lee Jones <lee@kernel.org>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Conor Dooley <conor+dt@kernel.org>
CC: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
CC: Christian Marangi <ansuelsmth@gmail.com>
CC: linux-leds@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
index 5edfbe347341..a31a202afe5c 100644
--- a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
@@ -41,6 +41,8 @@ properties:
 
           pwm-names: true
 
+          active-low: true
+
           color: true
 
         required:
-- 
2.43.0



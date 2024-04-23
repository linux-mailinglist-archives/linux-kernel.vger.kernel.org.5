Return-Path: <linux-kernel+bounces-155298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BB88AE887
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E202285496
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6077D139594;
	Tue, 23 Apr 2024 13:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNpvskNG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F49135A78;
	Tue, 23 Apr 2024 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880012; cv=none; b=NFBrKYyWCBPyg6Bl5tOFRItt+nAckE2eiguCsLFlEwqDhCI5WEsEOz/zznCAGdiBXrh6OidcdxnACj3xQ4murn8tJemiyEBbK/UFcFzool4X/wi11Zxqvoz5uVXqN2JLiH16moVTnEVaFC1c0xUTvPf5rPFEeEhAayClclZrkfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880012; c=relaxed/simple;
	bh=tCfBMb3DOalmVHX+fKphZQx4T+5g7FInpPlj/Ww+I/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtXGrK9QpbgRuAiH3NzfjDrrCc1bxN/aH8ejj7V+U/FIvVTrbp1h2DWeqnkTDHsKPy75793bAq81Bt45YnQp3jWNFb0x901AkhlQDCo7QapYgNtHwE4CKLwSntw3cQOdKxOehLovSZ8omZrV4XAPBdqHkvuqbByNdNuqjZnYxH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNpvskNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F217FC116B1;
	Tue, 23 Apr 2024 13:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713880012;
	bh=tCfBMb3DOalmVHX+fKphZQx4T+5g7FInpPlj/Ww+I/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MNpvskNGtKjrw85/aCr/RXmboU6e8AvOWeXGUwV329/8YZkgIBU4eKVxMeh9Zboce
	 YuVM4p5AXMykfl+7pzVHREMd6UIa2KkFHqxqy5Yojna4/pfNVlvCReRH0bwcmthPNi
	 eMOnWsKUf+ZtukOShJwCv7qO4qhyljeKcP94opVmYCOQwQ84DD8uZvS/362NEUwY7/
	 9jtNu51nqI0ABNE6HtYqhDN7A2Da1vi6Q0Ns3zBWsuVtsopB7uqT/TINBDdSmI2qu5
	 EEc8GaBSINdd9lsfXj/v27uFA/1NIgjC5+/SJWXrLkVi0v4r+i+6v43019QRE+DDC+
	 a80J+KdSGwT8w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rzGTy-000000008Kk-1836;
	Tue, 23 Apr 2024 15:46:50 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 3/6] dt-bindings: HID: i2c-hid: elan: add 'no-reset-on-power-off' property
Date: Tue, 23 Apr 2024 15:46:08 +0200
Message-ID: <20240423134611.31979-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240423134611.31979-1-johan+linaro@kernel.org>
References: <20240423134611.31979-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the power supply is shared with other peripherals the reset line
can be wired in such a way that it can remain deasserted regardless of
whether the supply is on or not.

This is important as it can be used to avoid holding the controller in
reset for extended periods of time when it remains powered, something
which can lead to increased power consumption. Leaving reset deasserted
also avoids leaking current through the reset circuitry pull-up
resistors.

Add a new 'no-reset-on-power-off' devicetree property which can be used
by the OS to determine when reset needs to be asserted on power down.

Note that this property can also be used when the supply cannot be
turned off by the OS at all.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/input/elan,ekth6915.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
index c3a6f901ff45..3d20673f10b2 100644
--- a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
+++ b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
@@ -37,6 +37,12 @@ properties:
   reset-gpios:
     description: Reset GPIO; not all touchscreens using eKTH6915 hook this up.
 
+  no-reset-on-power-off:
+    type: boolean
+    description:
+      Reset line is wired so that it can be left deasserted when the power
+      supply is off.
+
   vcc33-supply:
     description: The 3.3V supply to the touchscreen.
 
-- 
2.43.2



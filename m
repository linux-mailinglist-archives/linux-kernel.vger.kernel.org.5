Return-Path: <linux-kernel+bounces-155300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DB38AE888
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53ABA28271D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63844139596;
	Tue, 23 Apr 2024 13:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ek9Gb2/J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7801D136986;
	Tue, 23 Apr 2024 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880012; cv=none; b=HETb22UEp6UKdqWfzD4M9GIHyiahtGnxo5UoCrPW3424HRqKlPtGsdovsNmlYqKkIKf3g/k8qdE6/vCBjbfh/6XN0JrndYIhaJB9yg1hqgyg/WiBQ+gWL0c8aO902b6iKn+ixR9qKwJxmyA90MkU3uCZkBb0sallCiGpIecbQO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880012; c=relaxed/simple;
	bh=OTreVTB2JCvMy1mBHfi2hPMPHGKxxD/lOjIeJI1Zor4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=peTtLLHvDsK0x6Az5uAztFU+RPYA3DnI9Z7fgDsjIjZNdDDUtrTI1tjB7g9zuHDDf7/lTdjlUmmFjo+Khy15s5JlUAEzqJVe6WChu+Vv1RYQfr7rtp7Ri4S7Ex5nxfhmmFhPgCoKGBjpdp0sshFMtucLomSc+PtPAEzzr9dfgkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ek9Gb2/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079E5C3277B;
	Tue, 23 Apr 2024 13:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713880012;
	bh=OTreVTB2JCvMy1mBHfi2hPMPHGKxxD/lOjIeJI1Zor4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ek9Gb2/J1piXyz6hLQ1J4WRrB1ATlALMehMSRWLL2qqm9ajJMSjh0gGOlvAvJoqUF
	 b5tPTnl1YN4ZWvqa2k3/kAuePrrle+jsuOnXw/IczWPbAnKq0G6fbACrt+5NhjoQ7D
	 +7NqWhKC//Ny0ZYx6MuIeAqL91IYuyRsTI2BlALG8IWa/W8Orl4xAUMbCIXxduWq28
	 vgCoHqY7cyfr+L8+ZpzkSz97tpxRB980Of8yUTq66GYmsaDMo7NLi3xYONljNfiuWd
	 IRfoXBYKT/w2bsv5QknGL8gC13VwBmVkirFezhxJ6lCWQImXz+Yl9o2ASpWdPgNL1j
	 +4ULUSzIEI0xw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rzGTy-000000008Ki-0nOy;
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
Subject: [PATCH 2/6] dt-bindings: HID: i2c-hid: elan: add Elan eKTH5015M
Date: Tue, 23 Apr 2024 15:46:07 +0200
Message-ID: <20240423134611.31979-3-johan+linaro@kernel.org>
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

Add a compatible string for the Elan eKTH5015M touch controller.

Judging from the current binding and commit bd3cba00dcc6 ("HID: i2c-hid:
elan: Add support for Elan eKTH6915 i2c-hid touchscreens"), eKTH5015M
appears to be compatible with eKTH6915. Notably the power-on sequence is
the same.

While at it, drop a redundant label from the example.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../devicetree/bindings/input/elan,ekth6915.yaml    | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
index 3e2d216c6432..c3a6f901ff45 100644
--- a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
+++ b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
@@ -18,8 +18,13 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - const: elan,ekth6915
+    oneOf:
+      - items:
+          - enum:
+              - elan,ekth5015m
+          - const: elan,ekth6915
+      - items:
+          - const: elan,ekth6915
 
   reg:
     const: 0x10
@@ -57,8 +62,8 @@ examples:
       #address-cells = <1>;
       #size-cells = <0>;
 
-      ap_ts: touchscreen@10 {
-        compatible = "elan,ekth6915";
+      touchscreen@10 {
+        compatible = "elan,ekth5015m", "elan,ekth6915";
         reg = <0x10>;
 
         interrupt-parent = <&tlmm>;
-- 
2.43.2



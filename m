Return-Path: <linux-kernel+bounces-99606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1BF878AB3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 315AEB212A3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8735788B;
	Mon, 11 Mar 2024 22:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKZv1lzc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4CC57861;
	Mon, 11 Mar 2024 22:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710195962; cv=none; b=cpIX3eDw3SLuAC76ogzAnFpFTllObA/uF+W4Wi03hnSVTimiJx/abFwx9Mnxi0DhD2ZMaoAyrRtpOILr7YeeFlLRbHc2CPzgkZKY/pQQZJrHuTakBgETLTz0d5xDWcgfcCEiMGpkBsGBpC+7rVsgA/55hjDkZnoE9GHYSR8az8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710195962; c=relaxed/simple;
	bh=nhbB7KN+EHCiAICcRdHdrKjxV/CnwlXVj5krZi1VAOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a6Kz7gH3/F0gkjKPd1tI5s5qLy24Hm/82PI1wNLB0y0rZ1MrwMUQC8WA/DSSJIfbOdMfZl+MPKSFeeSApBDMf2UL6q6nnqBk2uqgTEdb685dmMsYAWazKunsp9DBkz0vzC0ISkeRRokA5GmDhbHPttJbm9IMTLv3WYsQWSkOsDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKZv1lzc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400DFC433C7;
	Mon, 11 Mar 2024 22:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710195961;
	bh=nhbB7KN+EHCiAICcRdHdrKjxV/CnwlXVj5krZi1VAOQ=;
	h=From:To:Cc:Subject:Date:From;
	b=MKZv1lzcp4zTGpiciqj1xnbftzR2jp2AXkT8WSfbmufh6zCz8WjOAL5tnN5+e/eTX
	 x2sGXpz94n+SSI7tbH9T0Qps+spePhN9uSbrDLcDd41dDnWPH758lRTaPeUJ+fau8W
	 g8prQJGzGthmOm5s6Q3wbVGtMZzwtSt1hWqtpj3eWeU2ya8+/qCECr8/an5ltZlZnP
	 1AIZ9NpEBiCGOMI9dAfjM15ApZg7qCGGRwmKK+Kj6e/w4dtEkiuWBG33lIwIdLSTOm
	 df0b1aq9zGmcjql9igxmucTZ1QnozoYCOAFMVIaw7U24YhBa3GpAXTeHZEiaF2Lg/R
	 zBBizEmcRIMiA==
From: Rob Herring <robh@kernel.org>
To: James Schulman <james.schulman@cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	patches@opensource.cirrus.com
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: cirrus,cs42l43: Fix 'gpio-ranges' schema
Date: Mon, 11 Mar 2024 16:25:53 -0600
Message-ID: <20240311222554.1940567-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'gpio-ranges' is a phandle-array which is really a matrix. The schema in
cirrus,cs42l43 is incomplete as it doesn't define there's only a single
entry. Add the outer array constraints that there is a single entry.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/sound/cirrus,cs42l43.yaml     | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs42l43.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs42l43.yaml
index 7f9d8c7a635a..99a536601cc7 100644
--- a/Documentation/devicetree/bindings/sound/cirrus,cs42l43.yaml
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs42l43.yaml
@@ -185,11 +185,12 @@ properties:
 
       gpio-ranges:
         items:
-          - description: A phandle to the CODEC pinctrl node
-            minimum: 0
-          - const: 0
-          - const: 0
-          - const: 3
+          - items:
+              - description: A phandle to the CODEC pinctrl node
+                minimum: 0
+              - const: 0
+              - const: 0
+              - const: 3
 
     patternProperties:
       "-state$":
-- 
2.43.0



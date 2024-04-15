Return-Path: <linux-kernel+bounces-145437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 690F98A5623
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0B11C224BC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1340C79B84;
	Mon, 15 Apr 2024 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="V8dsG13Q"
Received: from outbound11.mail.transip.nl (outbound11.mail.transip.nl [136.144.136.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E5B74422;
	Mon, 15 Apr 2024 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713194218; cv=none; b=Dbh7Tft+/oynWUEzflAhFtszmbiqsnNMmPuhAf/Dlkq4veNsRxPzlXidW7WWVeGHZXiyUY0ruI2KR5aJOsy+qqm/Rsy+1a0Cwgf0/xXVBPgVO0jq0gncQLtSECiUfejzRspjSjtMhooxudCYnBr2ks2UY9MUv/tuQJC1Q/zQJ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713194218; c=relaxed/simple;
	bh=TChLNh/5v4W3HzfiubyKeWFbFBqtkO7yPwvPJuEtYhs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VfE+594gneRfl6CvG3uFTGDpjCMedR5tYn4ARl2m7lAnwKvFglPa+l9m9iJxaqTtRn41fR27B9nx55+JKoiQ3eN/OqB9TqgHTkdysabxO8vqETjdNnysAfMoClB07LXX1e2jVxHc/FXRvUR/jEsIbeqY+zrBxtNpb8iH9jAGURQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=V8dsG13Q; arc=none smtp.client-ip=136.144.136.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Received: from submission14.mail.transip.nl (unknown [10.103.8.165])
	by outbound11.mail.transip.nl (Postfix) with ESMTP id 4VJ9kV60LXzkQNKJ;
	Mon, 15 Apr 2024 17:16:50 +0200 (CEST)
Received: from herrie-desktop.. (110-31-146-85.ftth.glasoperator.nl [85.146.31.110])
	by submission14.mail.transip.nl (Postfix) with ESMTPA id 4VJ9kT6mfBz2SSWM;
	Mon, 15 Apr 2024 17:16:49 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
To: sre@kernel.org
Cc: benwolsieffer@gmail.com,
	chris.chapuis@gmail.com,
	Herman van Hazendonk <github.com@herrie.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: power: supply: max8903: specify flt-gpios as input
Date: Mon, 15 Apr 2024 17:16:45 +0200
Message-Id: <20240415151645.1986014-1-github.com@herrie.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission14.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1713194210; h=from:subject:to:cc:date:
 mime-version; bh=3v/qVp5PkSqTiKy/IQWDMAaYfmXPuyjg0Qt5SOb/Ouw=;
 b=V8dsG13QoSP3EKmJrZgItRbjkDh59MaVwpAoR8xD6yTUBxvP7f89iVSthukdjQvwZsqO3q
 dfrVAx59xTQQe3NgXIG/V72MBP33Aw+Isv/ErvknqvjjaiAXUfWGB6DNfD/91iz0YyvwtD
 glINt7w+Aq0K7wUMABLi8vvK3qR4I5h/tVJ+BuEwwtF8lVPzQxd+an2Y64cRTPRRFE/11Q
 xDG568e3rveY/sVPlUyjji6z+Cs7/Zhn7+qMMHJNJBja45F6Som55f/oSjWqubMKBtuaVk
 /mUnTeiwZ/f7/LzJVO3X08fZnFtLhE8JCJyww7mY10tduWBpyCS0Gc74jPE62g==
X-Report-Abuse-To: abuse@transip.nl

The FLT pin was incorrected documented as an output. The MAX8903 uses it to
signal to the processor that a charging fault has occurred.

Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
---
 .../devicetree/bindings/power/supply/maxim,max8903.yaml         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max8903.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max8903.yaml
index a8d625f285f1..86af38378999 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max8903.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max8903.yaml
@@ -34,7 +34,7 @@ properties:
 
   flt-gpios:
     maxItems: 1
-    description: Fault pin (active low, output)
+    description: Fault pin (active low, input)
 
   dcm-gpios:
     maxItems: 1


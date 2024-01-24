Return-Path: <linux-kernel+bounces-37580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B82683B1FE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C6D5B2E6F4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7175413399B;
	Wed, 24 Jan 2024 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3b1S1bK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CCF132C0B;
	Wed, 24 Jan 2024 19:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706123284; cv=none; b=UepKHYOnzh3riKLCX4UW7etisU054ncfo4yGZk6/8Vfgg1JQzAbFdPnV7fLbnRR5S+r19i46uIkFX+qRdODovh/O3TviyuETbf8/ATB6XWfSaIKOJu6jXsm+6N3i6eaD7RNl1tGCYiEPb77LIHt/XXpJjZnwhTGrZOVZDo/inQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706123284; c=relaxed/simple;
	bh=SwchdVgBg6neJuhnWaXo7T47sqrW4qt3snXZHu9PtNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KMRqgD6KxIoPD5Wn3nlYjFN+0FCjm6I7U1Uz/m43OeuiMjoI4sxNDvPslTpgtgCxq5DV1ezWQNwHSTh0o6bUKVqx7zHazJziBT7AiNhkpbI32LjuuoRkDQj4LHZ70bWRQo2WS7aTg7iugxbSj3GBn6mw8JR93KQUV6DuL+SjvnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3b1S1bK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604BCC433F1;
	Wed, 24 Jan 2024 19:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706123284;
	bh=SwchdVgBg6neJuhnWaXo7T47sqrW4qt3snXZHu9PtNs=;
	h=From:To:Cc:Subject:Date:From;
	b=P3b1S1bKil47eshjiDtblLxITFGqJFOMDH93eef6oCv3d+NFUujUCkL0m2FYyS7VQ
	 MNtPpYSC592H6rgLxd0In4yIr6Ehok+RZ1BL2CiuvNZ0ymEvL7QJZIWO0AqjDOzuG8
	 QhMtu79DN0UC12HUxGR+Ke2a1lTuJIE+cjEz1FgG8olWAxhU148efsxnNsKUU0eNky
	 4RRayonZbsCsgVP53MAeIKazX5s9xk1JRGqRELC7LjvnSUb9imGt9iYuilkcuY+VHA
	 I3nY9aQBxKNhOvdCaCYE/0oOJSA0C9aowvu/e8QfFBO2aqzxuyhlInM/FDMc7a65cg
	 A2h7xagDTitGw==
From: Rob Herring <robh@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: samsung,tm2: Correct "audio-codec" constraints
Date: Wed, 24 Jan 2024 13:07:53 -0600
Message-ID: <20240124190754.1554899-1-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "audio-codec" constraints define how many entries(2), but not the
size of each entry. Each entry is a single phandle. Define the size with
an inner 'items' list.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/samsung,tm2.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/samsung,tm2.yaml b/Documentation/devicetree/bindings/sound/samsung,tm2.yaml
index 760592599143..cbc7ba37362a 100644
--- a/Documentation/devicetree/bindings/sound/samsung,tm2.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung,tm2.yaml
@@ -25,8 +25,11 @@ properties:
     description: Phandles to the codecs.
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
-      - description: Phandle to the WM5110 audio codec.
-      - description: Phandle to the HDMI transmitter node.
+      - items:
+          - description: Phandle to the WM5110 audio codec.
+      - items:
+          - description: Phandle to the HDMI transmitter node.
+
 
   samsung,audio-routing:
     description: |
-- 
2.43.0



Return-Path: <linux-kernel+bounces-77744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FB48609A1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9DA11F266A5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DEF11CB1;
	Fri, 23 Feb 2024 03:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ya0ITmGn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B220111AD;
	Fri, 23 Feb 2024 03:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708660191; cv=none; b=GkMFxlqxfFx/3nALp0zmDN5tuM3WlDxIzGVUTZTKqIm2mpRKXc2M1mwq7STOiLt61POIDhyN32C8FymIopJY+lDJW7KvWcilQ1FiJiN90Yk9dQ5wzvLgEbVIbP4YDCd/zvdD//I2BLZBn5v5mBdNsLhp7SHBxdbZwAZOlDExx4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708660191; c=relaxed/simple;
	bh=UboJhJ2Na49LW6G1cI5tL0fPvFZ/OZtE9CHN8NnGtQg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nAWm+2qFTos/DU/Jtfqyqon5Dpv+UFiAd8DGMldXQiOetroI/f79dcEd9x0ziHHtcV0EZvtMDF2Gu+7J1mZAiU2gnXJwJCyemM1FCVFwHqjYW8hZQyI9pMpGo+N5mFTvbv0fhcC0Tujv4sBF9Vgth5qERACkQIO5z7RdSy7tb0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ya0ITmGn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F7E6C43390;
	Fri, 23 Feb 2024 03:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708660190;
	bh=UboJhJ2Na49LW6G1cI5tL0fPvFZ/OZtE9CHN8NnGtQg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ya0ITmGnjSbud6eY+M2zJYNLSPlF/cHUyzAAwLl/fcuEGiN+S5QyQvNxNzXtpY0k1
	 y+OdiwNDq8OIpP8AcNXy2F+Bv7+PyX5P/oUI3MQ0Z/fbtQWgyl8nJwrJkluxHpz72w
	 S6DRCL/8bcl7yGpSS/n7HBc9yY9PrA0zS/MGQ7tm8Wm0szgb3u6hrsk111OUdp9GW+
	 cyMHm3gEmg7aZ/AHh2K9ZgySOmGLJzAcdKMBrnD0QZo4b76rjekoQFNyFCb/iDIGCL
	 An5dQBtVJHyQcXVLvqIDCiGl/inHk5ZgT1V54IxlVlpMzAv4yYrfW3gWRiQpeEbjni
	 PBas63Jh1GzzQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7F7C54E41;
	Fri, 23 Feb 2024 03:49:50 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 23 Feb 2024 11:49:46 +0800
Subject: [PATCH 1/2] dt-bindings: simple-pm-bus: Add optional resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-b4-bus-v1-1-2803c3ac4673@outlook.com>
References: <20240223-b4-bus-v1-0-2803c3ac4673@outlook.com>
In-Reply-To: <20240223-b4-bus-v1-0-2803c3ac4673@outlook.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708660187; l=1458;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=eDExkZ8ch9F2IC6H0Bh6sbmnrZwqE83QU/hncSN1udA=;
 b=Ix+IGJnk37tLr6KiqN56bHt+twAmHGwLNjd3rCsPg1w/s3+c1zqNBQAm4VYR5tNYNB3gGUKd4
 lH6Meg3a0efD6SNUtc6v4IvRoM3GZA/sMRdx2ufsfbT63ahePugNiRL
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received:
 by B4 Relay for forbidden405@outlook.com/20230724 with auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
Reply-To: <forbidden405@outlook.com>

From: Yang Xiwen <forbidden405@outlook.com>

For some on-soc buses, it is also needed to deassert the resets before
access. Document it in the binding.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 Documentation/devicetree/bindings/bus/simple-pm-bus.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/simple-pm-bus.yaml b/Documentation/devicetree/bindings/bus/simple-pm-bus.yaml
index 182134d7a6a3..430638104980 100644
--- a/Documentation/devicetree/bindings/bus/simple-pm-bus.yaml
+++ b/Documentation/devicetree/bindings/bus/simple-pm-bus.yaml
@@ -14,8 +14,9 @@ description: |
   driver, as it's typically initialized by the boot loader.
 
   However, its bus controller is part of a PM domain, or under the control
-  of a functional clock.  Hence, the bus controller's PM domain and/or
-  clock must be enabled for child devices connected to the bus (either
+  of a functional clock, and it might have a reset control signal.  Hence,
+  the bus controller's PM domain and/or clock must be enabled, reset control
+  signal must be deasserted for child devices connected to the bus (either
   on-SoC or externally) to function.
 
   While "simple-pm-bus" follows the "simple-bus" set of properties, as
@@ -49,6 +50,8 @@ properties:
     # Required if clocks is absent, optional otherwise
     minItems: 1
 
+  resets: true
+
 required:
   - compatible
   - '#address-cells'

-- 
2.43.0



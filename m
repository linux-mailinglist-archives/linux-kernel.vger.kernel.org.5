Return-Path: <linux-kernel+bounces-117368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0C988AD6B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53E0DCE0B3D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED98C6F533;
	Mon, 25 Mar 2024 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="ciNOPsZ6"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72D913A3F6;
	Mon, 25 Mar 2024 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380503; cv=none; b=K5OqYwtl99fdCJOe09JWoin/0qG+MG6YmdH1TzVfzVqeryjk+PSLtEN8vUcs5YuuDISEdVZ5H8TlSGgOci0JiwyjxpnVSfhMofdscbV54h90w+IHn3lsQXn3w0zVPuq5hgsZ7R/gIRMc4Xp4uCKDTF2VT/zvQk+vq5JL23iXihY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380503; c=relaxed/simple;
	bh=GwEVbdkmLpszv/ngaAUPLIeaQ59bVg0nhbqSq4H0P3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J6NsAiZDVtvxq/fEjd4+TQ9WHy9QruU93t/tn3C4HM3P5LZnl6S7YMygf3Eqr84C3z1oqzflVWh45pZJcjAdMpGtUv/ZFvZ1gOxg/dwAD+SdzNU9oexr6lszqer9Ymmv+p2Qa3xQKWNjZdVu8NdaJdNU0JUw+sa/NuclRzmrm5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=ciNOPsZ6; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1roltA-003KDr-33;
	Mon, 25 Mar 2024 16:05:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Z1zoh3i/WdlwWIQFQXJ3ZX3i/xA5ug2avrjWbctrWe4=; b=ciNOPsZ65D5qZsOVr50ZrCeFgf
	FEGK+mbL76Mh2dQWluitzJ/8tg6SRjZjqbiTnmFukRaj0n6AQWbkw3A5JkL4KIhQ0rMX1eKcjBVkA
	o4dvW7FLCwXRhQPpK5HDxwfoHZq4ZYCiiMZZI6y5jeQhW8YO5eIepLsK79xEIQOQjTXOEfnj9vGJ7
	lK8JqeT0zUMZYN5FG0kiyyEAOGTrcAnfysuENLeQZ5m3OuW02CP6MenrO8Ov50pqmHeWCMECZSG42
	0WoWokKp1VFd4ozt6RTzooeV8XygqOoU4I3ps7Fu1nrlGKs9G8MBiDaENmv0uJ1ZHNXwtCuUF6pqy
	294d31Sw==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andreas@kemnade.info>)
	id 1roUCU-000Y9d-IN; Sun, 24 Mar 2024 21:12:14 +0100
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1roUCT-000yR8-1Q;
	Sun, 24 Mar 2024 21:12:13 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: lee@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	mazziesaccount@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [RFC PATCH 1/2] dt-bindings: mfd: Add ROHM BD71828 system-power-controller property
Date: Sun, 24 Mar 2024 21:12:09 +0100
Message-Id: <20240324201210.232301-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240324201210.232301-1-andreas@kemnade.info>
References: <20240324201210.232301-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the PMIC can power off the system, add the corresponding property.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
index 11089aa89ec6..0b62f854bf6b 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
@@ -73,6 +73,8 @@ properties:
       used to mark the pins which should not be configured for GPIO. Please see
       the ../gpio/gpio.txt for more information.
 
+  system-power-controller: true
+
 required:
   - compatible
   - reg
-- 
2.39.2



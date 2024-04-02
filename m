Return-Path: <linux-kernel+bounces-128584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8B6895CBB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FFF21F21C8C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D5C15CD52;
	Tue,  2 Apr 2024 19:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="jQ/SmOso"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCC615B55A;
	Tue,  2 Apr 2024 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086527; cv=none; b=qvI2E1RnVllFPGyLFPAe2U5OwFe4QS0LArg6G37WnIwyO7PhDZBJzXRmA2CmLfvDe9IaBOg4HX/1LQlsq/o3c8UKfjY8UNNphvZWIguCau/oIEdi+Y5kcW8mPubBjzQaef4Y7veh2L695aEpgP41vpVBLAKzZRJUX4qEKBl9gxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086527; c=relaxed/simple;
	bh=NQdtkQVygPR6jCndd16skewhDkJrHxgnDXjcFSrbNyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WM4Gd+LS4eTh7Lzl3vBRacdJcuvvTt1AV8hM79hDNKFPAXo5Nl5Wj8PenpCNsbDP/eEPVtJgThVxxba4qwMFSFJinake6wW5OsF3hDSnwVk14OBY5w7rQjnulG5xemTuJ9nxt9J5E7zw+TVtBX6xkHisNWFeQ9/FO1y4dj0o0d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=jQ/SmOso; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rrjul-003lfp-1J;
	Tue, 02 Apr 2024 21:35:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wj7MONmdEbm+rj+7lLEzP4rHwMzI980hLW5txpuzAIQ=; b=jQ/SmOsonA8xONeMOVjR+Qf71X
	sdp8GR51/r37pmaIlKdaOk6IkaBP2ZxzE0CF0NR5PfL9LtzTpCwyBWchkgvuN7/epIre0paMFywPC
	lkTzxiJgjtp/zi4PhMUvPEuAtNyfJNpxTEK0cuHlLvup9bbzk25GToOgcRsVQvd+iSuZi0BJtJolI
	fd4Ixd/PccMD0ihCoBJkaXSfg1c2kqM5kXOzUGVxb95Uif5yGIgUdtLA0uB/5QBh5iGmYOusRb9Fx
	kFt1J5KgFHZIrVLzckE5mhGzolaiVeyAyHVeOuWxyFbTxPh0ocvMhIjvfxD+XaDjkyF3+XmO6giNc
	GWXBGbPA==;
Received: from p2003010777026a001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:107:7702:6a00:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rrjuh-000J2z-2n;
	Tue, 02 Apr 2024 21:35:20 +0200
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1rrjuh-0029e1-1B;
	Tue, 02 Apr 2024 21:35:19 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: lee@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	mazziesaccount@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 1/2] dt-bindings: mfd: Add ROHM BD71879
Date: Tue,  2 Apr 2024 21:35:14 +0200
Message-Id: <20240402193515.513713-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240402193515.513713-1-andreas@kemnade.info>
References: <20240402193515.513713-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As this chip was seen in several devices in the wild, add it.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
index 0b62f854bf6b..e4df09e8961c 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
@@ -17,7 +17,9 @@ description: |
 
 properties:
   compatible:
-    const: rohm,bd71828
+    enum:
+      - rohm,bd71828
+      - rohm,bd71879
 
   reg:
     description:
-- 
2.39.2



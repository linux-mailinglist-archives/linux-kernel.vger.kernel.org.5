Return-Path: <linux-kernel+bounces-37188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 622FA83AC67
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8782994DC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A9A85C64;
	Wed, 24 Jan 2024 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="dWr1NJAh"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795ED60DD1;
	Wed, 24 Jan 2024 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106795; cv=none; b=s+aKjtqMtZ3Ok2lQEyUjQcasr9ghqySyEr0Qy3pkb2jzFRlmLkA9DdQKMW4K30fab2TcyOYWr9VOu4sVe3HDHPi8405ulKpShqRx9FUuOXWpqtO2JQko8270Orq+Wg5ghRddD7bG6P9BqZr507XULOGoEvjaZz59hOWdC1GAVpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106795; c=relaxed/simple;
	bh=vPpxGx3jdv7gATwmSPZOYv7TCt6Wkt2McFWe5Uq8e1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lb/StMGq7WreeU26FcYRPYgNvau+2C43LA8fWjryCVILS8+3xLA/aUZ8WXoQ0Zc7/yTTKTrmiPRlnczM2DhoJdvS/KP2PimVV7FINo+jP4xWm//vwwfGhG8u8J9PzQOS5oazt903A6Kv7XVuuIKTjVe+X22EwmrlaegoEWvehSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=dWr1NJAh; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=OtP8seYmSML3PMcVqkf6WfD0WEgT7yLINsGkyK/5yRY=; b=dWr1NJAh2O4A7EL6JyQkEBZIVJ
	Mo2YCfPIx9Ge2pYrb4Lo+ndhfWGE7LOXst4905l2N6eudCvEiDQzdaOIgiejSl/mRHr+zm8chVoFu
	mz6q4BoKMTBkMxa41EFJbFAODYnSdLcuIHKVMnGbFgaSWav9gY0/NXISgY9pVoGcR4VrT62kcS4Gj
	Xp8BwMj+yQqZuHkUDHx+VSQ6UR/mmm5HAGXTO8Ibd8TtU4CFOzyWHEVN8qtDz5UvIaOqLJH9SHfkX
	cZ0GwA8Jf7uiMy5BUyDU5tZ/sCLmFeqMMH69DIHjO7CVA9ZEFbgSdr/Jc99QRc7OVW0Hpkj+bQtjA
	Azl0nMGQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rSeJQ-000NaO-OK; Wed, 24 Jan 2024 15:33:08 +0100
Received: from [87.49.43.79] (helo=localhost)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <esben@geanix.com>)
	id 1rSeJP-0008fi-RM; Wed, 24 Jan 2024 15:33:08 +0100
From: Esben Haabendal <esben@geanix.com>
To: devicetree@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: net: snps,dwmac: Add time-based-scheduling property
Date: Wed, 24 Jan 2024 15:33:06 +0100
Message-ID: <30ce8f45b8752c603acc861ebb2f18d74d2f8a07.1706105494.git.esben@geanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <b365dc6f756a3fad4dfaa2675c98f4078aba8a55.1706105494.git.esben@geanix.com>
References: <b365dc6f756a3fad4dfaa2675c98f4078aba8a55.1706105494.git.esben@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27164/Wed Jan 24 10:45:32 2024)

Time Based Scheduling can be enabled per TX queue, if supported by the
controller.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 5c2769dc689a..301e9150ecc3 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -399,6 +399,12 @@ properties:
             type: boolean
             description: TX checksum offload is unsupported by the TX queue.
 
+          snps,time-based-scheduling:
+            type: boolean
+            description:
+              Time Based Scheduling will be enabled for TX queue.
+              This is typically not supported for TX queue 0.
+
         allOf:
           - if:
               required:
-- 
2.43.0



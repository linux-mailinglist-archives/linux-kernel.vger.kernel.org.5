Return-Path: <linux-kernel+bounces-127046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9247F89462D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F87B281CAA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDE8548E4;
	Mon,  1 Apr 2024 20:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdUfLDKO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393B029CFA;
	Mon,  1 Apr 2024 20:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712004283; cv=none; b=FD5WJKTe2apmOT3XYNfETZnuHRBR/C4qMfIyw6RZ8r3FnjZhImA6P4cYomZwJRSfNmJp1Aq3zw3UkDQPf7HzORbC9YuJ/oE4X5IXXzUiTS4xUnpnpi0VnCPb5B6OApfCUoGdYJYRytXff+LvU3gEoohYA6QrctihyCQQfrt7qZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712004283; c=relaxed/simple;
	bh=VVC52MCSMpHW2Q5JNIbH9ASpsjq2s/1rwQrg66hgqU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l5X+MdWBjZxPCncjLAn4oKhLfgDA9ZhAhxpp/DcZ0RRsJl+mhqzK4Y1yxy6bPGiCZmeHm3r98szfF7rfDPHcCZ9gZpPMw7pWSfDJCaTkY6LIFzD1DTxJMmAi+4KuBF9dFLSIgzt4qpomCcf9SWRzrht2BMJaCD+2HGQbh71xWMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdUfLDKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C93CC433F1;
	Mon,  1 Apr 2024 20:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712004282;
	bh=VVC52MCSMpHW2Q5JNIbH9ASpsjq2s/1rwQrg66hgqU0=;
	h=From:To:Cc:Subject:Date:From;
	b=IdUfLDKOz0fjUNbZPxGNFtaTkVLTNUMzPeafgY8xENuPsHc+FqNXK8Ph0PrEOvEJQ
	 qb7NiG2TLMLsTpt62YkzJpwLc9e/etfCXPk8i2JhBTLS+H18UaAgOZSKWB9T1CgWBi
	 RpPbzJhBV40CyFVWZBH9OfycK57Sav6w8W1Vf9KWlOoP84n4necekWijMb7XG8MfOt
	 0mfI327V9aP8htlaYKjtbkmciQjVo9sIvJBieLWtsULUBTHR4SRKEkTD6cFo9x63tB
	 qrQlaLopXn81ilQ8Kzex8vM+edDTplZIgbMpgYTJU/vGRCnMndQ+XSjwgxoQrHc+pC
	 dmr3B3xr1au0A==
From: Rob Herring <robh@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] dt-bindings: net: snps,dwmac: Align 'snps,priority' type definition
Date: Mon,  1 Apr 2024 15:44:22 -0500
Message-ID: <20240401204422.1692359-2-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'snps,priority' is also defined in dma/snps,dw-axi-dmac.yaml as a
uint32-array. It's preferred to have a single type for a given property
name, so update the type in snps,dwmac schema to match.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 6b0341a8e0ea..15073627c53a 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -242,7 +242,8 @@ properties:
             type: boolean
             description: Multicast & Broadcast Packets
           snps,priority:
-            $ref: /schemas/types.yaml#/definitions/uint32
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            maxItems: 1
             description: Bitmask of the tagged frames priorities assigned to the queue
         allOf:
           - if:
@@ -393,7 +394,8 @@ properties:
             $ref: /schemas/types.yaml#/definitions/uint32
             description: max read outstanding req. limit
           snps,priority:
-            $ref: /schemas/types.yaml#/definitions/uint32
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            maxItems: 1
             description:
               Bitmask of the tagged frames priorities assigned to the queue.
               When a PFC frame is received with priorities matching the bitmask,
-- 
2.43.0



Return-Path: <linux-kernel+bounces-111212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3A7886939
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E3AF288A91
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B49224EA;
	Fri, 22 Mar 2024 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lMEzKlbr"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D6E1CA94;
	Fri, 22 Mar 2024 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711099748; cv=none; b=jRHWOAkCjgYPx/pPRjJJgzeplAy+/DuI9BRQemXdqnbDIH1i/7OnOrh6SEMvUzaRgkcYYYLqGXPePEOWLxAPuw8LEM715Ej3By+MHzIjgLZ/A1yN54dDbxY8UDwtanDsAXQJ10cT6S06B1h8lypA68v7yajhNeFj2sH/swEgY8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711099748; c=relaxed/simple;
	bh=oe9T7E/FTpZFS5y5PY5XyYk+Y6xz/0zt8q1lRZf/WPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSSTYbSx7NRtzgwdzDBuxU74OSTe3spGYB2jGzdXsEewIEXtVMtlP1CB35wJj5Dbz035aguhxH83V/4q7svJwT8x/4c2JEnT3LlrkEAmhqjOoOJqqSr1j3EcVa78hrxI4Yd7+396VWjYlDzF3vKGexqXCTe1DZ09YvNyQXI1kck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lMEzKlbr; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711099745;
	bh=oe9T7E/FTpZFS5y5PY5XyYk+Y6xz/0zt8q1lRZf/WPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lMEzKlbrwkBOFCFdgYtbUfHHRNcOX4uDcqXfLp+o4do9c7NKsWHB9eV+bFZIWoGTB
	 wFYzVgnxAoIHLX8LhqBrVlF8vAmH9gU+GYsPJnGSPQ2QDfKI2XB6gjUIK0uP63wiSd
	 WtycvabOFvk9EoIW5ZnpH8f9dQVjYHv702g+fhj1hFVVW17tyyVit+aIlANKoHpROP
	 cPOhnqjpJV+KmN2+WUdVeEE+xiqK5CVJh5LHjqgGbTXR0RTAj7NS17xfAXwZ4Vo/gs
	 cLFjY37DyPepAxQvHcAQWR8A/GhGrb8J3tFmvJYiHyXtKm26LjPsj504ljxzy8zR0R
	 A6Zz7TV+Ey0Iw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5022D3782115;
	Fri, 22 Mar 2024 09:29:04 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-media@vger.kernel.org
Cc: mchehab@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	amergnat@baylibre.com,
	moudy.ho@mediatek.com,
	hverkuil-cisco@xs4all.nl,
	sebastian.fricke@collabora.com,
	u.kleine-koenig@pengutronix.de,
	chunkuang.hu@kernel.org,
	p.zabel@pengutronix.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 1/4] dt-bindings: soc: mediatek: Add support for MT8188 VPPSYS
Date: Fri, 22 Mar 2024 10:28:42 +0100
Message-ID: <20240322092845.381313-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322092845.381313-1-angelogioacchino.delregno@collabora.com>
References: <20240322092845.381313-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible for MT8188 VPP mutex.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/soc/mediatek/mediatek,mutex.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
index ba2014a8725c..a10326a9683d 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
@@ -33,6 +33,7 @@ properties:
       - mediatek,mt8186-disp-mutex
       - mediatek,mt8186-mdp3-mutex
       - mediatek,mt8188-disp-mutex
+      - mediatek,mt8188-vpp-mutex
       - mediatek,mt8192-disp-mutex
       - mediatek,mt8195-disp-mutex
       - mediatek,mt8195-vpp-mutex
-- 
2.44.0



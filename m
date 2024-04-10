Return-Path: <linux-kernel+bounces-138267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C024489EEFF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A2A1B24169
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B57315ADA9;
	Wed, 10 Apr 2024 09:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QhsoV/B2"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8061598F2;
	Wed, 10 Apr 2024 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712741589; cv=none; b=YrSGMM68JIOiWad51sERr2sQeIke7744hYIs+5VHQVPvKx/7MuxGaTd+WdVOdrCSvNhPAavfcZz5CaidvX7jTkvkHTDEmO0tzQuhuTLIpczns14r+M2gnijRcqu3H8BECIDDrGQ62ZWJp30cKViMo5OfRs/f2XSxXHBmUZniVQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712741589; c=relaxed/simple;
	bh=1nSBf6bY6T/hjYzEOpJcKmCPuaUO6X4kXnC660BYQeA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XMefd/nAecj2kCLJFdqUHdMue0Zm+0CV5hWrPbX6Q0JGYen+mbg6HVxfA6ct2tPAE5S2VhO3baNjco3vYcRQXhZ7ml0vOqYEDTnITArsfZFIG/l8kHT7vtw1CfGkeaGtp1/p1oTbTgJYJOvYXt8ticio2N19Qtu6cP+/+gGn5NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QhsoV/B2; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 6AD28C5F49;
	Wed, 10 Apr 2024 09:29:13 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1E6EBC000D;
	Wed, 10 Apr 2024 09:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712741350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=334v5AxGG/MkJbS2JIrPuKDmglCIG0uO//Ytkag6OEg=;
	b=QhsoV/B2Q7n/q41p414iJ2q2qcE2w1F/o+9LMbL4tr1DYPJIhCy4HQjniVMGYH2pIBIqMD
	Wwcmf97aVc9f1HaFA30TmvUgZF6gtRS222HrRU9wvbmo2T7cS1f3RV6btln9uRPUiEYj1R
	LjYwSDXLlcEVkaf2nHVf9PkvgG+dvcA8bausiKuokZJy6fMq+qcI4Po2jPahKvHNV1mbnt
	aIshsZZY/D04Yk+Ql0e1hJt+5Jap0vfL/G/HwEaIVcwl320U65mDEN/lEVOQ2FVyzCEkwR
	UqE185WoQfqrdlVf3OTiJNnIGbJDsgi/IbfD8EV1a6QEocgWcRJ8rkaLiIKocg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 10 Apr 2024 11:29:05 +0200
Subject: [PATCH v3 2/9] spi: dt-bindings: cdns,qspi-nor: add
 mobileye,eyeq5-ospi compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240410-cdns-qspi-mbly-v3-2-7b7053449cf7@bootlin.com>
References: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
In-Reply-To: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Rob Herring <robh@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-GND-Sasl: theo.lebrun@bootlin.com

Add Mobileye EyeQ5 compatible.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index b865d4cc25cc..587baf35e4e3 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -70,6 +70,7 @@ properties:
               - amd,pensando-elba-qspi
               - intel,lgm-qspi
               - intel,socfpga-qspi
+              - mobileye,eyeq5-ospi
               - starfive,jh7110-qspi
               - ti,am654-ospi
               - ti,k2g-qspi

-- 
2.44.0



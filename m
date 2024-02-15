Return-Path: <linux-kernel+bounces-67468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B82856BFC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A6228F1B5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B21F13958B;
	Thu, 15 Feb 2024 18:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="i0H4sebp"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2441384BA
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 18:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708020216; cv=none; b=VvGiFZPW24I5IcIvxaej78b+hAPC0gzcUAtMLl2w3AI6NWOkjzEsIz9E6LRmLfSd9eEvSGazzQAI1Mxk6vL1/0KFkRo+fdNAfjMb/NnOO1CVCOOwd74CjK9JTrnV82dybVngD3Q0vjJZ8En9e7KzuTjvRryFKx2+lMQ5/oEBKoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708020216; c=relaxed/simple;
	bh=Ycb04z0TQwvPmB4LG7faRAixQix29MoW65T7iFnIb9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kqap83apXDcAWxfqii9xwf8NASgztVttEn4exB/Y0cYwDroVJ0ZG1sR4o6Z0+rBTXNN0BQyvYfS7Gwif3binxSO/ReM9Fwpj648N4ZwPNKFI+8gLhJG+t5B1PoQ7ZukZS1D6S0QU8FEKoOO+j+1lfYkBo2oppNji3hkIfRmlLXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=i0H4sebp; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1708020212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XX0Rh2Nt++xF/IVkn5h4WMBkbMdKoALWeVdeACVylhI=;
	b=i0H4sebphrDX3QNM24COttVHt/ywLThAgJ4jvPBW5eUhmKbfPhYXw98oTfIJ3fOzPWNk7+
	O36hlRWj1nZdRm3BjMADmBKcOwQ+CsASnK9uIdJrcZGcoDPovb1miT+t5cQroCQO6RS9WV
	Qv9nVR3TAiV95RsjuHWGgEkl4yzUKnxQ678S9tkw5GcGAv8mCi/QShC44g6lFROC1/XMN1
	57XoxJZFPYD9P7TsED4tqxO8ysyMu+hFgsRiTcUUHz1GpXIeRA0eRSPl5z6EFGU/cBZ1Y8
	Au9lh52hBd+QDSxuzYbektgeguoxCHK2efoEOJ0PIvt0ggGD4AlV4iehaqcIVQ==
From: Stefan Hansson <newbyte@postmarketos.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	Stefan Hansson <newbyte@postmarketos.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 2/4] dt-bindings: arm: qcom: Add Samsung Galaxy Tab 4 10.1 LTE
Date: Thu, 15 Feb 2024 19:02:00 +0100
Message-ID: <20240215180322.99089-3-newbyte@postmarketos.org>
In-Reply-To: <20240215180322.99089-1-newbyte@postmarketos.org>
References: <20240215180322.99089-1-newbyte@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This documents Samsung Galaxy Tab 4 10.1 LTE (samsung,matisselte)
which is a tablet by Samsung based on the MSM8926 SoC.

Signed-off-by: Stefan Hansson <newbyte@postmarketos.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 2b993b4c51dc..66beaac60e1d 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -146,6 +146,7 @@ properties:
               - microsoft,superman-lte
               - microsoft,tesla
               - motorola,peregrine
+              - samsung,matisselte
           - const: qcom,msm8926
           - const: qcom,msm8226
 
-- 
2.43.0



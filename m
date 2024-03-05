Return-Path: <linux-kernel+bounces-93094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAF8872B00
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACE311C243DC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB83E12D216;
	Tue,  5 Mar 2024 23:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="y32wMJa5"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19BB12D212;
	Tue,  5 Mar 2024 23:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709681208; cv=none; b=pE16pjN00peaiYd+e3kj8mUsECa/LPyeVNY5ZLnLpsvodRvzOAJje7lBOly3zMyHscQnJTsNycRAuUe0EgSG+Y25HkaPy+oNvjAzC7G/83mbcCLDpBvUyOg3Ob/Csm5q92qVHDCzwavv/ehMxQ+BmadDnHilRahQq1j3I6C0RPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709681208; c=relaxed/simple;
	bh=kuZaB03DpO/M0ReYTwe+GiUjcMrdotBb+a00+AMdUDA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EQh6ZKv3b6dOa7oiANjibuugFdCMaLhGUxA4FFYVin8yjNuPDhlLicruWMi4wMEromFBm83z8U55nfqYBg4kIappLoUp9Y8yFnlKQHnUdHub+QJ2WLotd3uiGh4zu8BDQJatFmmNmPhjQoenbFc8E5JcELbgG7Ns7DJYSwICZ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=y32wMJa5; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1709680705; bh=kuZaB03DpO/M0ReYTwe+GiUjcMrdotBb+a00+AMdUDA=;
	h=From:Subject:Date:To:Cc;
	b=y32wMJa52kYZ5d1jZ3Mmn9LdKYsXHTJDUuELBLG16fYRuTXMd9lLMCqPlPSb4e79X
	 qD7iuKSjmEUWGOsNoTm8gOc5fA8+ZV/NAzqNeZlC4DosqFN5ENl2cN9rjx0dcFTZ7U
	 TSJrkzbuXiIBX6tnXj8TCrERa6PfF7r/QhoWCBLc=
From: Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 0/5] Some devicetree cleanup for MSM8974 Sony Xperia Z2
 Tablet
Date: Wed, 06 Mar 2024 00:18:03 +0100
Message-Id: <20240306-castor-changes-v1-0-2286eaf85fff@z3ntu.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACuo52UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYwNT3eTE4pL8Il2IZLFuUrKZuYVpUqKFiamFElBTQVFqWmYF2MDo2Np
 aAMNN8Y1gAAAA
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=863; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=kuZaB03DpO/M0ReYTwe+GiUjcMrdotBb+a00+AMdUDA=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBl56gxikXmUPUf+VkVYvLXOo+r+s3JnHnUA/zuk
 AETO3UoT96JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZeeoMQAKCRBy2EO4nU3X
 ViJ2EADJx5FNEhqpKKbzxlJBRgjsPO9oQlI4m1C5C3uGAcroEWtsH4WtYNZKOiTY3r/UfweiLnV
 iLjE3mKjtHfRHFcrEdERH6o+Oo71t+kLldjgap7MXMLEDXPCVO/apOJGspfQxeNoco6DcNdviDe
 PrSPjf7e+ZwSyGM90HGRZ2R6AznvjPrYE70mNXuTWDswUHUuHtlcWyIzZWPRFCBRui9qZk7PhVR
 VeDUTDqWmLZHSM3gWX3S0GPEAeLkqFuO7kA3JfRCeSso2bOjBuAi0FjnGPxqmoXA5fZeQVA1qpE
 OjVCJVWBEhbDLAMMN2O6NF2feNcBYK4kYmEE3Dm75DxdynfmTyomAlfRaX484C5I+S+JteVd5gz
 MmOUnu39mTRG+aNduAud+1x9LBzuXsehKkemXzXO/fC0EomqNXj1ktUihw15XuT6+2l8nAejl4h
 F1VE29x+nVijglHa42ulZeixJ+RBQX2GnG9pvJkpaJFXmT6ofwtxw32YrvdpyWiDnlLc0ur6MIx
 T4vVPMw8RZebORA3OGsKcVf+xNLnE2XE2jVx7uSQG3GS2JyrGblMry216yGB9EvEAZpLSbis2/L
 KFiyPIB/pKQpfr1/WAFXmCf6ml4EL/K7GAE0EkjrxpfJFAWsHXBOVgICqnhfihXAW7pBy3qzxt0
 bTbWsn+ES2Ademw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

The sony-castor dts has been around for a while, clean up some things to
prepare for further changes including the introduction of the
shinano-based Sony Xperia Z3.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Luca Weiss (5):
      ARM: dts: qcom: msm8974pro-castor: Clean up formatting
      ARM: dts: qcom: msm8974pro-castor: Add mmc aliases
      ARM: dts: qcom: msm8974pro-castor: Remove camera button definitions
      ARM: dts: qcom: msm8974pro-castor: Add debounce-interval for keys
      ARM: dts: qcom: msm8974pro-castor: Rename wifi node name

 .../qcom-msm8974pro-sony-xperia-shinano-castor.dts | 83 +++++++++-------------
 1 file changed, 32 insertions(+), 51 deletions(-)
---
base-commit: 2e397253aae928c6d318beb18c05bc2236f69a8a
change-id: 20240305-castor-changes-bc6785ba8458

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>



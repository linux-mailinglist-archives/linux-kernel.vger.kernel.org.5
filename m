Return-Path: <linux-kernel+bounces-31752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C425833378
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 10:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70E81F222AD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 09:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CB1D268;
	Sat, 20 Jan 2024 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="GslpJwm4"
Received: from mail-4324.protonmail.ch (mail-4324.protonmail.ch [185.70.43.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C520CA64;
	Sat, 20 Jan 2024 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705744680; cv=none; b=uV5cdM/vneltvJZTrMKHOLK5wz6gTJagWYgO46yP4u0Vp9bpOlfJGqZ6+pQsoBD5/iKyBARUQiKV8FZeFBBaijiXV3i0GCU0lyNFV8fz2G6lpTwUnrBOpy5D7D3TEXokTsbuVFLRs/zV0k3wq1RzHJaOzNw9UbGooyFGGKDTato=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705744680; c=relaxed/simple;
	bh=pOaMVycWprd8m7qPwTf/dsfp7D7iXcZQxoNLXR9zW1U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZcXZu+aBCpH2vjthJ3FEsZPGQbt8E4IMFIgKZJjc6+wAgQjrWcdF8glraISwGGBAgxkmw2sA5+ZFoZMc1L43iGTOn+hzH+FpyQJ9oYStW9NEgSHYNZ+AOjEjk33WqGZytrCCNH/7jDd3wF/BLmJegVn7ozz4OhmhjAwrNHlI44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=GslpJwm4; arc=none smtp.client-ip=185.70.43.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1705744669; x=1706003869;
	bh=2P2J+4Ct6tO2K+f9R9vJudtj9daoD8wfAXFUKvMfyMU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GslpJwm4zU249Y5eX8drurKFeVOorah9HH+Qvmp1cFKk5KC3Xn5rfMpYzj+r37Wqu
	 AkMyaUtgo2xQDM6cOIEQCYn46SZFLscGzaIETjWr/KQs+7Gy2ouWyIzICYueUvum8E
	 2NTnWwHVeHGV4IXY41oPt/oyF3GRkLxNtkn6gLFUSJyZViz7JSfwCuYaxkalsYsLUZ
	 1CovjRrMqLfM37L3qxuMOlibgxM5GequZDksogMsjKPmKtGQHLk3hmAZUySbThWFh5
	 +6he945aLwD2ikV9LHbdMRUlh3fhDOCvtNi7xcuPaCzfChlv9l+82G1onikKhkNeLi
	 ErHKdzYzTXyfw==
Date: Sat, 20 Jan 2024 09:57:38 +0000
To: linux-kernel@vger.kernel.org
From: Raymond Hackley <raymondhackley@protonmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Stephan Gerhold <stephan@gerhold.net>, Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: qcom: Document new msm8916-samsung devices
Message-ID: <20240120095715.13689-2-raymondhackley@protonmail.com>
In-Reply-To: <20240120095715.13689-1-raymondhackley@protonmail.com>
References: <20240120095715.13689-1-raymondhackley@protonmail.com>
Feedback-ID: 49437091:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Document the new following device tree bindings used in their
device trees:

- samsung,fortuna3g
- samsung,gprimeltecan
- samsung,grandprimelte
- samsung,rossa

Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentatio=
n/devicetree/bindings/arm/qcom.yaml
index 1a5fb889a444..337053ca700b 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -244,11 +244,15 @@ properties:
               - samsung,a5u-eur
               - samsung,e5
               - samsung,e7
+              - samsung,fortuna3g
+              - samsung,gprimeltecan
               - samsung,grandmax
+              - samsung,grandprimelte
               - samsung,gt510
               - samsung,gt58
               - samsung,j5
               - samsung,j5x
+              - samsung,rossa
               - samsung,serranove
               - thwc,uf896
               - thwc,ufi001c
--=20
2.39.2




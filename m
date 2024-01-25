Return-Path: <linux-kernel+bounces-38272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9D783BD6C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3282DB234C9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5B81CF87;
	Thu, 25 Jan 2024 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaZHQHdz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AB11C6B6;
	Thu, 25 Jan 2024 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175081; cv=none; b=mhTiQxqO7LGcWCY65AZq1gbAih3zMsY2W2+Igqr6l+Rm47nGddR1BswUMJ770D9o5++m9S4W0HRktZQzEjAc9237p6TrsOlP0pAFKdYUOXG0IAaL116O1IMLL9MhrZY1laNdUwdV6ZKZSqL0etuqtb3owS509VsuAFSlhCoOKAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175081; c=relaxed/simple;
	bh=HyKIL7MR0TT3sSkhF/hxv6Xzw9uF1jLRyVnGFnT9B4c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NvCN3UxMIPomWqGhFPWbPMQliQ4rmCsQTCGhpqRvuT6j2lhCY0BVU9QZ+UpkvKNvCVEdiy4CQuH879KkrlHXMi1XEQm/+deK/3faQo1qzxwoz37GIUAtIzf7webf0BZAdLjaz945oVjU8GyFephm7QvMla55jK+0dShT7ksNtG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaZHQHdz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37D3CC433C7;
	Thu, 25 Jan 2024 09:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706175081;
	bh=HyKIL7MR0TT3sSkhF/hxv6Xzw9uF1jLRyVnGFnT9B4c=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=YaZHQHdzCAosfsePBIPCfGVWTb1wt959cqEwr0ivySFxZrWY11Ia3lfCaRlmfYMG2
	 c+dHsifvCoRqXUqBZFSp1lBoTPVVZhjFuV3I2FwPpOyRj1mK5D+epI2dUvMkHZyY0K
	 1fKi9ZeTrQMtL69T9bvCdJo2UWAvazqrdPdwFGTQkzJEPB/6z+PFekbe+hoxEbEzVK
	 0ThlFXNYwjHh53gqVlxlBsQjsufIGClGwy5QiM1PNcFVPrA/dYkMLiN/ZEMa5AbCnh
	 LD/Dci8Tjm/2DTdMiU2UuHRtEb1c3ARE3sV2Abelm+z7O8mwY2hdXO2173vnY3DCsb
	 TcJVZli58R7tQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0918CC48260;
	Thu, 25 Jan 2024 09:31:21 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+quic_fenglinw.quicinc.com@kernel.org>
Subject: [PATCH v3 0/2] Add PM8010 regulators for sm8650 boards.
Date: Thu, 25 Jan 2024 17:31:14 +0800
Message-Id: <20240125-sm8650_pm8010_support-v3-0-2f291242a7c4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGIqsmUC/43NQQ6CMBCF4auQrq2ZDowQV97DGIJtkVkAtYVGQ
 7i7hZ0rXf4vmW8WEaxnG8Q5W4S3kQOPQ4r8kAndNcPDSjapBQIWoDCXoa9OBLXrK1BQh9m50U+
 yJNBADWlDRqRb523Lr9293lJ3HKbRv/c3UW3rLzEqCdJYjYiFobKAy3NmzYM+6rEXmxnxLweTQ
 9iSKu8IjTLfzrquH4ohnNkEAQAA
To: kernel@quicinc.com, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com, 
 Fenglin Wu <quic_fenglinw@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706175079; l=1205;
 i=quic_fenglinw@quicinc.com; s=20230725; h=from:subject:message-id;
 bh=HyKIL7MR0TT3sSkhF/hxv6Xzw9uF1jLRyVnGFnT9B4c=;
 b=MwaMrUsVDw8ZqP/STnoorwurZg9Rk9jDEX2VTUFbuKxodgE7PyVveBgbJclfsKgqubHwPiOTl
 j3onBIhMblrDi+SPMNNn2HsHIZsFRxCHeIsiRizg5QYJhUHHwSrAOuN
X-Developer-Key: i=quic_fenglinw@quicinc.com; a=ed25519;
 pk=hleIDz3Unk1zeiwwOnZUjoQVMMelRancDFXg927lNjI=
X-Endpoint-Received:
 by B4 Relay for quic_fenglinw@quicinc.com/20230725 with auth_id=68
X-Original-From: Fenglin Wu <quic_fenglinw@quicinc.com>
Reply-To: <quic_fenglinw@quicinc.com>

Add PM8010 RPMh regulators for sm8650-mtp and sm8650-qrd boards.

Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
Changes in v3:
- Split vdd-l6-l7 supply for regulator-6, and split vdd-l5-l6 for regulator-7,
  as vdd-[5-7]-supply is defined in the driver seperately.
- Add regulator-allow-set-load and regulator-allowed-modes for LDO1/LDO2
  as they are the only LDOs support mode transition in PM8010.
- Link to v2: https://lore.kernel.org/r/20240123-sm8650_pm8010_support-v2-0-52f517b20a1d@quicinc.com

Changes in v2:
- Added Reviewed-by/Tested-by trailers
- Link to v1: https://lore.kernel.org/r/20240123-sm8650_pm8010_support-v1-0-dec2224d5740@quicinc.com

---
Fenglin Wu (2):
      arm64: dts: qcom: sm8650-mtp: add PM8010 regulators
      arm64: dts: qcom: sm8650-qrd: add PM8010 regulators

 arch/arm64/boot/dts/qcom/sm8650-mtp.dts | 132 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 132 ++++++++++++++++++++++++++++++++
 2 files changed, 264 insertions(+)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240123-sm8650_pm8010_support-750c05a5cd5d

Best regards,
-- 
Fenglin Wu <quic_fenglinw@quicinc.com>



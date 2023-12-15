Return-Path: <linux-kernel+bounces-575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0830814328
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC511F22A4A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5D3125CF;
	Fri, 15 Dec 2023 08:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqrT7PTD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E401096D;
	Fri, 15 Dec 2023 08:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55432C433C8;
	Fri, 15 Dec 2023 08:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702627318;
	bh=cL4aJ9Ef2FV4/v1HsF2CM0pB+DdNoh12pxbeAGEls+Q=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=mqrT7PTDrNRO4FSB/gdnLRdYDfGXkv6ZbujlPkvwNa8lUF2r16gO15vBCvSRQHysk
	 2W7gIDdASsT0IsG7IyURdgohSIWJGVS3mkm/6Gyhe+akStxHjGfwZ2uWrymyGnrBNE
	 HyrAMlC3AfWBCAht2vj0Jz7QFxUzzeXC/R9DH898dPBzVOZYj+brCNmVncM2vSOHAc
	 M8vWVJ3luPV6Wd7OkRDOkBeB03WfISvc9///mIshfhXoJwDt+gYNcI3G1Ptp/aTr0x
	 Js6lIMn2vrYEmqbKYl3X5uVYJXKYt6kNZro5m+6f+Ck1wGgAYpY9DifB1Zh68y8TUz
	 uZDlIiBS2Wxaw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381FAC4332F;
	Fri, 15 Dec 2023 08:01:58 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+quic_fenglinw.quicinc.com@kernel.org>
Subject: [PATCH v3 0/2] Add pm8010 RPMH regulators for sm8550 boards
Date: Fri, 15 Dec 2023 16:01:44 +0800
Message-Id: <20231215-pm8010-regulator-v3-0-1bfc4b7ee5ab@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOgHfGUC/23NzQ6CMAzA8VchOzuzbiDDk+9hPLBRoIl8uMmiI
 by7g3jQ6PHftL/OzKMj9OyYzMxhIE9DH0PtEmbbsm+QUxWbSSEVSJHxsdMCBHfYTNfyPjguVKq
 tgULovGTxbHRY02Mjz5fYLfm49tw+BFinbwzgFwvABc9yQJHVJkVrT7eJLPV2b4eOrVyQn0T6h
 5CR0BIUVPXBFLn5JpZleQGs/CT29QAAAA==
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, kernel@quicinc.com
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, quic_collinsd@quicinc.com, 
 quic_subbaram@quicinc.com, quic_jprakash@quicinc.com, 
 Fenglin Wu <quic_fenglinw@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702627316; l=1213;
 i=quic_fenglinw@quicinc.com; s=20230725; h=from:subject:message-id;
 bh=cL4aJ9Ef2FV4/v1HsF2CM0pB+DdNoh12pxbeAGEls+Q=;
 b=vjXjJL1n7OizYx02Qb9kYiUtK00APtleGa4nw6kHvSqQa2SCyQUhjc85i+NrJJ+pyoSjp0GJK
 xIpseiD4nscDzPMSfXq8unJVnK0EwnT1ZABn6+OkRDVqNQHoGCFQpFc
X-Developer-Key: i=quic_fenglinw@quicinc.com; a=ed25519;
 pk=hleIDz3Unk1zeiwwOnZUjoQVMMelRancDFXg927lNjI=
X-Endpoint-Received:
 by B4 Relay for quic_fenglinw@quicinc.com/20230725 with auth_id=68
X-Original-From: Fenglin Wu <quic_fenglinw@quicinc.com>
Reply-To: <quic_fenglinw@quicinc.com>

There are 2 PM8010 PMICs present in sm8550-mtp/sm8550-qrd boards and
each of them exposes 7 LDOs. Add RPMH regulator support for them.

Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
Changes in v3:
- Mark has already applied the driver and dt-binding commits in regulator/for-next so only board
  file commits left.
- Added Reviewed-by tag.
- Link to v2: https://lore.kernel.org/r/20231214-pm8010-regulator-v2-0-82131df6b97b@quicinc.com

Changes in v2:
- Updated subject prefix in the dt-binding commit and fixed the typo.
- Separate the DTS commit with board name prefixes.
- Link to v1: https://lore.kernel.org/r/20231211-pm8010-regulator-v1-0-571e05fb4ecc@quicinc.com

---
Fenglin Wu (2):
      arm64: dts: qcom: sm8550-mtp: Add pm8010 regulators
      arm64: dts: qcom: sm8550-qrd: add PM8010 regulators

 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 120 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 120 ++++++++++++++++++++++++++++++++
 2 files changed, 240 insertions(+)
---
base-commit: 753e4d5c433da57da75dd4c3e1aececc8e874a62
change-id: 20231205-pm8010-regulator-0348cb19087a

Best regards,
-- 
Fenglin Wu <quic_fenglinw@quicinc.com>



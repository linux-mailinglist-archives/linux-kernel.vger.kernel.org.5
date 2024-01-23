Return-Path: <linux-kernel+bounces-34940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C3783897A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942B81C258B5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDCF57316;
	Tue, 23 Jan 2024 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlhskRKn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15D357892;
	Tue, 23 Jan 2024 08:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705999767; cv=none; b=d5NYG02QlxIXKimn42ZcorIpgxS5UNHnypevpVq+nEqgNzfkAmDxqqjTDtQSgI/CMw/YMA99Z+42HxJmB0t0Q38Fkzc5XlD8RHYtNRwmAxyv+qaxMSN0B0GW1bMXwRuhAeK2EiiwYi7hSaMTQ+1u8vba8EXxd/d1sU45P1fhLM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705999767; c=relaxed/simple;
	bh=SZpBe1ZMkjIIG1/Zbs/Nh5sfWuGE8hUuaJV6ZfEzdkU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uxcvEn9p3bmUNxtB7h2r2wsawgWGNN+E/CsrlPvcLlEmS67xwGCj1V7lb1KumfQB77T9beW4+C/8Gr00iabV1wveoHTfhlUsS17j3Q4SntODQD18ZEBVZxe6dV52quDg7qDtFZjnpkjdPyYNodIg2z/y4wvgpPwdIjoJBgj+ry0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlhskRKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DA1CC4166A;
	Tue, 23 Jan 2024 08:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705999767;
	bh=SZpBe1ZMkjIIG1/Zbs/Nh5sfWuGE8hUuaJV6ZfEzdkU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=QlhskRKnC50eaAP9CED/KZDmOAqelTNgf56+n6nLtftxrUDSoEf6a8cmtTCZ69EpG
	 eWsHVb8is/eopb1yYQ94jNwkU2G0QooUblOyaZh/5AyYEk6L3Fc2+wF9mGFBsxo1gC
	 ORJJ7Ww83sRc5Xi0bpQk6BkHZR+SV+XizeIwjohPJr0cizCZd1FQ6y8Z+o6BGnwd+e
	 imVuhqd1wNOVeGMkuB+8Krs6vZyFujGXCimx6k2oxYEEtbPwNH0Hf2G/nDjhr/Z9cu
	 SkSxxJ+ZHMZGd8fh9T6WtN4t3I/EGl8jMwshWsVxS0WFrdDBuULCcT+au3ZZmGr/QK
	 ox45IYDVrX3VA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F22C47DDB;
	Tue, 23 Jan 2024 08:49:27 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+quic_fenglinw.quicinc.com@kernel.org>
Subject: [PATCH v2 0/2] Add PM8010 regulators for sm8650 boards.
Date: Tue, 23 Jan 2024 16:49:23 +0800
Message-Id: <20240123-sm8650_pm8010_support-v2-0-52f517b20a1d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJR9r2UC/4WNQQ6CMBBFr0Jmbc10pEJceQ9DCJlWmQW0tEA0h
 LtbuYDL95L//gbJRXEJbsUG0a2SxI8Z6FQA9934ckpsZiCkEjVdVBrqq8E2DDVqbNMSgo+zqgw
 yms6wNRbyNkT3lPfRfTSZe0mzj5/jZtU/+6+4aoXKOiai0pqqxPu0CMvIZ/YDNPu+fwEuZ8tnv
 AAAAA==
To: kernel@quicinc.com, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com, 
 Fenglin Wu <quic_fenglinw@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705999765; l=807;
 i=quic_fenglinw@quicinc.com; s=20230725; h=from:subject:message-id;
 bh=SZpBe1ZMkjIIG1/Zbs/Nh5sfWuGE8hUuaJV6ZfEzdkU=;
 b=SJyv3SvVn4z9V6mFzNEYCCVYUdqUtlSzHFX9oiZvFyN66JZb88UZQd/Gnv4BaRKPeh7zSnwJw
 FFDyaq7jYa5A+JKPaeTYe1G5jqxiwlKrXy6295ITeDDgfl1/DWNmcNb
X-Developer-Key: i=quic_fenglinw@quicinc.com; a=ed25519;
 pk=hleIDz3Unk1zeiwwOnZUjoQVMMelRancDFXg927lNjI=
X-Endpoint-Received:
 by B4 Relay for quic_fenglinw@quicinc.com/20230725 with auth_id=68
X-Original-From: Fenglin Wu <quic_fenglinw@quicinc.com>
Reply-To: <quic_fenglinw@quicinc.com>

Add PM8010 RPMh regulators for sm8650-mtp and sm8650-qrd boards.

Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
Changes in v2:
- Added Reviewed-by/Tested-by trailers
- Link to v1: https://lore.kernel.org/r/20240123-sm8650_pm8010_support-v1-0-dec2224d5740@quicinc.com

---
Fenglin Wu (2):
      arm64: dts: qcom: sm8650-mtp: add PM8010 regulators
      arm64: dts: qcom: sm8650-qrd: add PM8010 regulators

 arch/arm64/boot/dts/qcom/sm8650-mtp.dts | 118 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 118 ++++++++++++++++++++++++++++++++
 2 files changed, 236 insertions(+)
---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240123-sm8650_pm8010_support-750c05a5cd5d

Best regards,
-- 
Fenglin Wu <quic_fenglinw@quicinc.com>



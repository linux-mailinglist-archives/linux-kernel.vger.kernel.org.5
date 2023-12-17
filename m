Return-Path: <linux-kernel+bounces-2728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF09816110
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB2D1C22079
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B495057337;
	Sun, 17 Dec 2023 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ma/lo0Wm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C0F57320;
	Sun, 17 Dec 2023 17:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08DF9C433C9;
	Sun, 17 Dec 2023 17:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702833730;
	bh=dU7NkqH9YHhXdOaXVjhL3EKtHSrrus3/4d8CE3oanUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ma/lo0WmGPnNRj7Joh3m+0QdOuBl4+Bo/MdYBtaa3yPPy7VHwySKH81dg9EImdG1U
	 x+r8KdOjrM7gYCwrBH3+lvZ20bltjDo0wDI9QqsgAzp1uOG8f0l+TZx+49rgLDl4m1
	 91tRqtKKDOmX35Dnaguu+1qr8q2wgePfY0t+EVVFqsD7u6qm/C4vCKp3eQTaMM0rCL
	 GZQr1mtMG4nLbfgqbcjDKw/5ZwlsOtFm0R4rUEmLkTLhRe1lMR8KINvqLO96BPGsQc
	 lPHvQc929NsRGLQqmJ+fjOb9WhhiAK20Vay2coDM+VyudEmnHIWHgADganwUMG3C5V
	 6+AssDO6eCOyw==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	kernel@quicinc.com,
	Fenglin Wu <quic_fenglinw@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	quic_collinsd@quicinc.com,
	quic_subbaram@quicinc.com,
	quic_jprakash@quicinc.com
Subject: Re: [PATCH v3 0/2] Add pm8010 RPMH regulators for sm8550 boards
Date: Sun, 17 Dec 2023 11:21:22 -0600
Message-ID: <170283349435.66089.17345540551415529182.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231215-pm8010-regulator-v3-0-1bfc4b7ee5ab@quicinc.com>
References: <20231215-pm8010-regulator-v3-0-1bfc4b7ee5ab@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 15 Dec 2023 16:01:44 +0800, Fenglin Wu wrote:
> There are 2 PM8010 PMICs present in sm8550-mtp/sm8550-qrd boards and
> each of them exposes 7 LDOs. Add RPMH regulator support for them.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sm8550-mtp: Add pm8010 regulators
      commit: 64dcc3d779abd4065d919d855979b33026370125
[2/2] arm64: dts: qcom: sm8550-qrd: add PM8010 regulators
      commit: 1d01007a62df2e49854d5727ba2b0ad794d2eb22

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>


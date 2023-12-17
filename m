Return-Path: <linux-kernel+bounces-2701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 949F28160B9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24FE0B21AFB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBED46442;
	Sun, 17 Dec 2023 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGc+9iwm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE05946420;
	Sun, 17 Dec 2023 17:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB221C433C7;
	Sun, 17 Dec 2023 17:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702833695;
	bh=CMmnXB2CNPDIqffldhQdQKBnVeMpdT3aYW8s5qEN3MY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GGc+9iwm8UEdWF2wZT2djfFZWTidVU/oyq+vBAnRZIfzjUcx+OByoJJmPKBttytbO
	 SSezwHEQwfUWCpoAqTgyJ9u3npBcCeDA/swQXgKEsXul0zQ2suu+ysq8jVi7IOEsu2
	 ra2ObR7ncH+yCWKNnz4QKXlFIpJyZn1CjWCqmdXygIKI5DT7aWeJSqiol8UM1v7OZU
	 jyJUkiOnIM8VfCthknRV9TzwiNHussbGGB384rpJOZWIaBUZldFTUpiSz8KjBGEwZk
	 UkREJc1o55tb3N/rd1DmMd3KM6zdVlGhYIMuS3CP2Yfa6R+b5CsqOrWPWX7iAumiFz
	 ZNw7icsQz+BbQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100-crd: Fix supplies for some LDOs in PM8550
Date: Sun, 17 Dec 2023 11:20:52 -0600
Message-ID: <170283349432.66089.3956721176712420638.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231214-x1e80100-dts-fix-pm8550-regulators-supplies-v1-1-6b5830dc337e@linaro.org>
References: <20231214-x1e80100-dts-fix-pm8550-regulators-supplies-v1-1-6b5830dc337e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 14 Dec 2023 21:24:50 +0200, Abel Vesa wrote:
> The LDOs 1, 4 and 10 from PM8550 share the same supply, the SMPS 4
> from PM8550ve. This needs to be done through shared supply approach
> otherwise the bindings check fails.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: x1e80100-crd: Fix supplies for some LDOs in PM8550
      commit: f8ab2984e5b0f1aaf94e3810b809bae055020e11

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>


Return-Path: <linux-kernel+bounces-5872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0528190CD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188F8282A6D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF35D39861;
	Tue, 19 Dec 2023 19:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HClMowVp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B26738FA7;
	Tue, 19 Dec 2023 19:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA5AC433C8;
	Tue, 19 Dec 2023 19:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703014420;
	bh=XCJvQlewT6Pf5hiFDnuA/dnAm1WfgOtda+sY8QJ7bvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HClMowVprLd6wtXxHo1L9+xhCioewJ71M5v1MFJC+Qpslu3bN2xwMCJaMyzT8+WWT
	 ViO+7XKDny6VquxGGFcp8E0MY2Z9KrUz+pbosjLTB1OFkveosvIk+4EtWaj6LhC7er
	 pgioFP7QKz4h4ZlDe32F4Y9UKGMIyfr7atAjRcS/ct6d6CjdtLe8Hyq7T7EcAp4GcL
	 SE3ucxhas1YLfLAC5iZYLi5qzl8ljY8IfepbbNueZjxY+OuSeyg66WUr3MHnofNZTf
	 bDGK29p84talWksg5aKyJXEa9QhdjnC6mxSDfnE192VfZDjVFaTdtogYiItG7Y82Au
	 d7H7WyQE9LpCA==
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
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100-qcp: Fix supplies for some LDOs in PM8550
Date: Tue, 19 Dec 2023 13:33:27 -0600
Message-ID: <170301441258.365364.1012098448184748849.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231218-x1e80100-qcp-dts-fix-pm8550-regulators-supplies-v1-1-0a313ce87745@linaro.org>
References: <20231218-x1e80100-qcp-dts-fix-pm8550-regulators-supplies-v1-1-0a313ce87745@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 18 Dec 2023 18:36:40 +0200, Abel Vesa wrote:
> The LDOs 1, 4 and 10 from PM8550 share the same supply, the SMPS 4
> from PM8550ve. This needs to be done through shared supply approach
> otherwise the parsing will fail. Also fix a bindings check failure.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: x1e80100-qcp: Fix supplies for some LDOs in PM8550
      commit: 49b0f4f141465b6446c0ade851ac11b13a888fa9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>


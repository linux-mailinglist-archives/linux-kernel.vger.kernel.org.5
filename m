Return-Path: <linux-kernel+bounces-5875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED0C8190D7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B601281F48
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A5C3B18A;
	Tue, 19 Dec 2023 19:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLLkOEKr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0233A1B2;
	Tue, 19 Dec 2023 19:33:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A41C433C7;
	Tue, 19 Dec 2023 19:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703014423;
	bh=Z0ixohNkqyatiTek3OeAgIzGghf3QJe3xe3ynfcKZnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gLLkOEKr+cC2gu3fj9cHPRCu/hilx3DqMPOs+wtn8/y0heOo0Ifmn5Ioyl8ZoUBML
	 8yjXsez2TacH58HBWCKJOw5dC6wMFoPlEen8qpofefAaKH8VjCCtWy4xvbCPlaCiD/
	 1VQ2NOpcv64Zxlg0b0jJ7Ql/nD1ZX01kfZex+YIk7Tw/RHq8Ym6G25UuUW1JVGX2HY
	 eR2ejTim/f4oW3OuFtBFuWKcCKGISY2huw6NFt8n5kOxnrwrMOKDLcp2aMr4m5jEFO
	 2PStLkT9/jz2OE2zh5c6CwjQMwBCNEaSQjt+uk59iEzSQKuoT+2i42RZVbjpBRQf9E
	 KVfEeQo1S8osA==
From: Bjorn Andersson <andersson@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ARM: dts: qcom: sdx55: fix USB wakeup interrupts
Date: Tue, 19 Dec 2023 13:33:30 -0600
Message-ID: <170301441244.365364.2259489337885946630.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231213173131.29436-1-johan+linaro@kernel.org>
References: <20231213173131.29436-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 13 Dec 2023 18:31:28 +0100, Johan Hovold wrote:
> The USB DP/DM HS PHY interrupts need to be provided by the PDC interrupt
> controller in order to be able to wake the system up from low-power
> states and to be able to detect disconnect events, which requires
> triggering on falling edges.
> 
> A recent commit updated the trigger type but failed to change the
> interrupt provider as required. This leads to the current Linux driver
> failing to probe instead of printing an error during suspend and USB
> wakeup not working as intended.
> 
> [...]

Applied, thanks!

[1/3] ARM: dts: qcom: sdx55: fix pdc '#interrupt-cells'
      commit: cc25bd06c16aa582596a058d375b2e3133f79b93
[2/3] ARM: dts: qcom: sdx55: fix USB DP/DM HS PHY interrupts
      commit: de95f139394a5ed82270f005bc441d2e7c1e51b7
[3/3] ARM: dts: qcom: sdx55: fix USB SS wakeup
      commit: 710dd03464e4ab5b3d329768388b165d61958577

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>


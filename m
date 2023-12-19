Return-Path: <linux-kernel+bounces-5873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6071A8190D0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C191281978
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C895B39AD0;
	Tue, 19 Dec 2023 19:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmhFwU1/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C9D39864;
	Tue, 19 Dec 2023 19:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C026AC433C9;
	Tue, 19 Dec 2023 19:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703014421;
	bh=K/R4ThD8zLuhuwkuswf0nShomOL105ktvktxLg4NLs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LmhFwU1/6xFS/xAuUg/HEA9bLvKUYhagM9Jm+lA3ZuRRmEs6P2qAe39LiKR8MSiGa
	 cRwlG4vRkeLaS4lfO/jcCIkQUqXSF/oe2gxBbthZUsWc7eUAk2BN9adstF//kH1I3i
	 rqmTsolGIcr/z/G1Pm6FLQu/1lEEBpJLB+3KDO7qh/kNs0Fw0WCzSbNzYD78m0T7r5
	 v6OBw9b/mOdPBF2Q2+Pqd7G0sbDH57O+xjL/zCZEuQH8V4lsLqrS3NgWu2gYQ/LuP7
	 YqA7FTDHkWgDEU3Mc3Br6IlDpHMpV0mJgmWhKWKRy1RXfD4hjtYcqB55s7mI+y2xyZ
	 5KUIos2XlaDqg==
From: Bjorn Andersson <andersson@kernel.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v3 1/1] arm64: dts: qcom: ipq6018: fix clock rates for GCC_USB0_MOCK_UTMI_CLK
Date: Tue, 19 Dec 2023 13:33:28 -0600
Message-ID: <170301441249.365364.17226924269873248133.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231218150805.1228160-1-amadeus@jmu.edu.cn>
References: <20231218150805.1228160-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 18 Dec 2023 23:08:05 +0800, Chukun Pan wrote:
> The downstream QSDK kernel [1] and GCC_USB1_MOCK_UTMI_CLK are both 24MHz.
> Adjust GCC_USB0_MOCK_UTMI_CLK to 24MHz to avoid the following error:
> 
> clk: couldn't set gcc_usb0_mock_utmi_clk clk rate to 20000000 (-22), current rate: 24000000
> 
> 1. https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/commit/486c8485f59
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: ipq6018: fix clock rates for GCC_USB0_MOCK_UTMI_CLK
      commit: 5c0dbe8b058436ad5daecb19c60869f832607ea3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>


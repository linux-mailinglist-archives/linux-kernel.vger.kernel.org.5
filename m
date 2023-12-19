Return-Path: <linux-kernel+bounces-5878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC06D8190E2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83AFDB24ECE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFABA3D0D6;
	Tue, 19 Dec 2023 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSWzMxJA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B673D0B6;
	Tue, 19 Dec 2023 19:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB56C43142;
	Tue, 19 Dec 2023 19:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703014428;
	bh=Q5y7rvlw1M/wxBUFlizZ8mcTj+L0StpouwUw/gjqQuQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iSWzMxJADBuL1ltZRJYERuF2JIoKJCvhyzP3xI3pBNmqdHsPqTJ6/uZsafndDFyWY
	 paxO05AsEvLgN0hHI5hsJeBn1xBEGRspYqbU/hh4xbV88U/EIsP2JpUeFXfcUT3B0a
	 8coCr4Rc7sPcIejniCk1nouXLNMuRkx51t8Mwz0fp8KnzTGMOLdI/nk1lvcbkjsZiV
	 aRB2ZX6co3k2DOIyMAI4JAiLhdAx4slk6nM5vBRlAx8/89hEGhuL7AB+G5ooEbOxxu
	 KxuB24s+NdQ9wFKsYNQMtN94zXA/jXo1AjhPSw6EnPw/pIgfrccG/edYffLPvFwmet
	 kskh36JGlbnxg==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Abel Vesa <abel.vesa@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100: align mem timer size cells with bindings
Date: Tue, 19 Dec 2023 13:33:33 -0600
Message-ID: <170301441248.365364.2782269663813563630.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231218150656.72892-1-krzysztof.kozlowski@linaro.org>
References: <20231218150656.72892-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 18 Dec 2023 16:06:56 +0100, Krzysztof Kozlowski wrote:
> The ARMv7 memory mapped architected timer bindings expect MMIO sizes up
> to 32-bit.  Keep 64-bit addressing but change the size of memory mapping
> to 32-bit (size-cells=1) and adjust the ranges to match this.
> 
> This fixes dtbs_check warnings like:
> 
>   x1e80100-qcp.dtb: timer@17800000: #size-cells:0:0: 1 was expected
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: x1e80100: align mem timer size cells with bindings
      commit: d336355492e4ab8c1fd78e582077146e065d1924

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>


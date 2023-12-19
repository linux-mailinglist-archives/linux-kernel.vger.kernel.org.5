Return-Path: <linux-kernel+bounces-5882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C99E8190EF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB941C21DA6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA5840C03;
	Tue, 19 Dec 2023 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVTiFcB+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5661A40BEE;
	Tue, 19 Dec 2023 19:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0288BC433CA;
	Tue, 19 Dec 2023 19:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703014433;
	bh=qTvzK/jfkz6fbK674cOzB3mIEmGwGicrFlDP/BvzEGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rVTiFcB+tBHZtf6tNMFPEvV9Eg4XlLbT4OuSJySPZdVPhYQu0mp7H7yS4/Yyvl0hE
	 +9MQY8t4V+6luRIHo/QEKQs88JOBWWN2dqJvcPv8jg88Fq2HJu2qySzNv66u3VDloc
	 yToA3Mqmu3qycyW7aqFcIM2kAZNBfJinAwFMgxU3SfawE2BAS79lxjjXj2UxDgXoRB
	 moTjN+zxnfujV2pk9HAS/lFhaB/VWAV88gHZTXccsRvMPn0ekT6xl70MIfunj21J1l
	 +9AukW0iLUIF9Gl5CLOISETdi1MUj8SYARTl7NTtXzyU1mdyDY7hnHMCTdn6vTw0vj
	 qbmLLpoqrclIA==
From: Bjorn Andersson <andersson@kernel.org>
To: konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	Tengfei Fan <quic_tengfan@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@quicinc.com
Subject: Re: (subset) [PATCH v3 0/1] arm64: dts: qcom: sm8550: remove
Date: Tue, 19 Dec 2023 13:33:37 -0600
Message-ID: <170301441259.365364.2180258670074890979.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231219003106.8663-1-quic_tengfan@quicinc.com>
References: <20231219003106.8663-1-quic_tengfan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 19 Dec 2023 08:31:05 +0800, Tengfei Fan wrote:
> The address/size-cells in mdss_dsi1 node have not ranges and child also
> have not reg, then this leads to dtc W=1 warnings:
> 
>   sm8550.dtsi:2937.27-2992.6: Warning (avoid_unnecessary_addr_size): /soc@0/display-subsystem@ae00000/dsi@ae96000:
>     unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sm8550: remove address/size-cells from mdss_dsi1
      commit: 53081095936cdb1501d6bcf6cb703fdd3ac71b85

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>


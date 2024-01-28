Return-Path: <linux-kernel+bounces-41514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6466683F30B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 03:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20882283790
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 02:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E76A1FA6;
	Sun, 28 Jan 2024 02:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQMXw1Xx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A343C17;
	Sun, 28 Jan 2024 02:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706409396; cv=none; b=LTAVNWY3aJ6h8OpC7UjSJzQE3wOkz1uWnJ0XjAe9h3ELO9nd2e6x5F/MZxy10KSlYBY1imPxOvDEQfW151uTY96za+O3NVARqEQCeua6J/TZ/XJrX4lK67B8AEcsrxlNt8dgQGmFouevwBFsncYWvikfhsLyIHZQy9jOx5Odcq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706409396; c=relaxed/simple;
	bh=lwkzL0yBH4YjD67G7PNVMhxf75iiEXFR//AEkOCpAXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOX4VtGjIHd381q5c91S/gpCvHILEXCSK513pHu/SY5gwfZy6aaXzRuM6aGK+CnP3zkhbrApSSeIqoAT7NRJW/N8lwUBtS7yOynJX0c2cpbzZthu4cxeV8auWNkqjcOkRBikgFatPXItCQHRYd2tjDvwkTPoHBOS9PpMh6SllCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQMXw1Xx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C17C433F1;
	Sun, 28 Jan 2024 02:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706409396;
	bh=lwkzL0yBH4YjD67G7PNVMhxf75iiEXFR//AEkOCpAXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQMXw1XxDbm2gjwp3lPDXzLG6aI0aAO4PDr7xtGaWutUIRvlHoSTSa5UMUQw5RsvK
	 op5fkaIGmoogJVO70700dMnj1g+C+xoipQwBE9LELa0/qc58yWkIEBGR8lNrM0ePvv
	 XGf17sM+jU8wWAdsYUf6nZUA9m7pjHBdVgrR6mSvifbeCmqnSqI67tL15eEyW5b6sY
	 x6l+gfTSzm6saEdw1cSjSCkbHGqVjFQlICQ9BnNKW/oLYSaYxmOKPP0aFcpF0IRMgf
	 pS180S5iSiQ4T6S4Rn0kLaySCcNxcBB5S8E3zoxGxaYoECBDAe3FAMfQ50oB3DtTwj
	 cohMP383s43zA==
Date: Sat, 27 Jan 2024 20:36:33 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Andy Gross <agross@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sibi Sankar <quic_sibis@quicinc.com>, Rajendra Nayak <quic_rjendra@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/11] arm64: dts: qcom: Add more support to X1E80100
 base dtsi, CRD and QCP boards
Message-ID: <ui5a4sr2wa4nta6uvvlejtwuus7uuj54iirddretysd6hcgv3k@iabyr65abxhi>
References: <20240126-x1e80100-dts-missing-nodes-v5-0-3bb716fb2af9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126-x1e80100-dts-missing-nodes-v5-0-3bb716fb2af9@linaro.org>

On Fri, Jan 26, 2024 at 12:00:11PM +0200, Abel Vesa wrote:
> This patchset adds every node necessary for both the CRD and QCP to boot
> with PCIe, USB and embedded DisplayPort.
> 
> This patchset depends on the Disp CC and TCSR CC bindings.

I'm guessing you're referring to the patches from December, which has
review feedback from your colleagues?

Please respin the clock series.

Thanks,
Bjorn

> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> Changes in v5:
> - Added Konrad's R-b tags to patches 1 through 4 and A-b tag to patch 11
> - Changed the clock of the usb2 HS PHY to TCSR_USB2_2_CLKREF_EN, the USB1
>   SSx HS PHY seem to be sharing the TCSR_USB2_1_CLKREF_EN
> - Prefixed DISP_CC_MDSS_CORE_* gdscs with MDSS_* to be more in line with
>   SM8[56]50 platforms.
> - Added "cpu-cfg" icc path to the mdss node.
> - Marked all USB1 SS[1-3] controllers as dma coherent.
> - Re-worded the adding TCSR node commit message by just dropping the
>   "halt" word as the halt registers are not part of this region. The
>   TCSR offers more than just a clock controller and therefore called it
>   generically "TCSR register space".
> - Link to v4: https://lore.kernel.org/r/20240123-x1e80100-dts-missing-nodes-v4-0-072dc2f5c153@linaro.org
> 
> Changes in v4:
> - After a discussion off-list, it was suggested by Bjorn to split in separate patches.
> - Addressed all of Konrad's comments, except of the clock-names one for the mdss,
>   which there is nothing to be done about as all non-v5 do clk_bulk_get_all.
> - Added more support to QCP, to be more aligned with CRD (except touchscreen
>   and keyboard)
> - Added a patch to fix some LDOs supplies on QCP
> - Link to v3: https://lore.kernel.org/r/20231215-x1e80100-dts-missing-nodes-v3-0-c4e8d186adf2@linaro.org
> 
> Changes in v3:
> - Reword the commit messages
> - Link to v2: https://lore.kernel.org/r/20231215-x1e80100-dts-missing-nodes-v2-0-5a6efc04d00c@linaro.org
> 
> Changes in v2:
> - Reword both commits to make it more clear nodes that are being added
> - Dropped comments from interrupt maps from pcie nodes
> - Replace all 0x0 with 0 in all reg properties
> - Moved on separate lines reg, reset and clock names
> - Dropped the sram and cpucp nodes
> - Dropped pmic glink node
> - Reordered all new clock controller nodes based on address
> - Dropped unnecessary indent from touchpad and keyboard TLMM nodes
> - Link to v1: https://lore.kernel.org/r/20231212-x1e80100-dts-missing-nodes-v1-0-1472efec2b08@linaro.org
> 
> ---
> Abel Vesa (7):
>       arm64: dts: qcom: x1e80100: Add TCSR node
>       arm64: dts: qcom: x1e80100: Add USB nodes
>       arm64: dts: qcom: x1e80100: Add PCIe nodes
>       arm64: dts: qcom: x1e80100: Add display nodes
>       arm64: dts: qcom: x1e80100-crd: Enable more support
>       arm64: dts: qcom: x1e80100-qcp: Enable more support
>       arm64: dts: qcom: x1e80100-qcp: Fix supplies for LDOs 3E and 2J
> 
> Sibi Sankar (4):
>       arm64: dts: qcom: x1e80100: Add IPCC node
>       arm64: dts: qcom: x1e80100: Add SMP2P nodes
>       arm64: dts: qcom: x1e80100: Add QMP AOSS node
>       arm64: dts: qcom: x1e80100: Add ADSP/CDSP remoteproc nodes
> 
>  arch/arm64/boot/dts/qcom/x1e80100-crd.dts |  222 +++++
>  arch/arm64/boot/dts/qcom/x1e80100-qcp.dts |  175 +++-
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi    | 1368 ++++++++++++++++++++++++++++-
>  3 files changed, 1758 insertions(+), 7 deletions(-)
> ---
> base-commit: 853dab01a34378871b37a5e6a800e97a997fe16c
> change-id: 20231201-x1e80100-dts-missing-nodes-a09f1ed99999
> 
> Best regards,
> -- 
> Abel Vesa <abel.vesa@linaro.org>
> 


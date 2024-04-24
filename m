Return-Path: <linux-kernel+bounces-156938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1758B0A9B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAEB42814E5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21A315B56F;
	Wed, 24 Apr 2024 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpGRqQry"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2F81422AF;
	Wed, 24 Apr 2024 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713964459; cv=none; b=WjLN3e+L+/QNTgtxmtsGkXpEKp2RGYa73Dh5N8nBCPI+9ywEltuj9DpFl9CJlsRVWycHch4wL88JW9Ddjmeo+lrr3H6R3yPcKIAm+lR9mpWBpc3RSRqpaBcu3k/zruo1Km5rBI9tje2ggFcUsLuCVYtmbqih7hsn4fftAKw05Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713964459; c=relaxed/simple;
	bh=XtltZntB1etOusP2DWgtGRu0qbOZFrTiglf7SrOR+cM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=FHYEkgXp9389dqif9KIlDpAvD7h2+j2EGXDY1eqPmaizQSt/U2EAmijp5GY0LE10vhKkxyzrK35aOq0FwCLcneNs8j2BL9QGokUL+RGC0hQM2PjBDmhpPDHADGrZTKYWXcQ5a7QKokyoT3TpS5wwy2q7RGBXWB0mB8F/tIfDWw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpGRqQry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD74C2BD10;
	Wed, 24 Apr 2024 13:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713964458;
	bh=XtltZntB1etOusP2DWgtGRu0qbOZFrTiglf7SrOR+cM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=rpGRqQrya3omzukyfXsX62UfCBwawA3sdH3sVpkJgATjCnbbPieRHDz2LU7xD7zLX
	 AbD5WJnDzZagHaAvgDVXsMKV4yAKqHyIPc5DyjCPn9B7jTzYSrV1Nz+qGMT8mn/9Mw
	 Rbcn3KLVegC7HwURdRld27FWgMqS0MRn96/8Joky07nNrRcyVFP4Mg6MQjr00IoxQv
	 UwuXiwCOUeH5czNVqG2ony6vnV9B8l8NH4H5oJ8TTCu5FjY3NRmOcQKjLNR6ea96C6
	 tHhA2cSnk2MgXp9+Cgbq5wu7Wi60CccAqxhwjuh1g32ysNK3XAvAvKbEvfhGfYD8po
	 EA5g8LwOrwe4w==
Date: Wed, 24 Apr 2024 08:14:17 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org, 
 gpiccoli@igalia.com, linux-hardening@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, conor+dt@kernel.org, kernel@quicinc.com, 
 krzk+dt@kernel.org, devicetree@vger.kernel.org, tony.luck@intel.com, 
 andersson@kernel.org, dmitry.baryshkov@linaro.org, keescook@chromium.org
In-Reply-To: <20240424024508.3857602-1-quic_tengfan@quicinc.com>
References: <20240424024508.3857602-1-quic_tengfan@quicinc.com>
Message-Id: <171396420131.3426982.6670175970780393669.robh@kernel.org>
Subject: Re: [PATCH v7 0/4] arm64: qcom: add AIM300 AIoT board support


On Wed, 24 Apr 2024 10:45:04 +0800, Tengfei Fan wrote:
> Add AIM300 AIoT support along with usb, ufs, regulators, serial, PCIe,
> and PMIC functions.
> AIM300 Series is a highly optimized family of modules designed to
> support AIoT applications. It integrates QCS8550 SoC, UFS and PMIC
> chip etc.
> Here is a diagram of AIM300 AIoT Carrie Board and SoM
>  +--------------------------------------------------+
>  |             AIM300 AIOT Carrier Board            |
>  |                                                  |
>  |           +-----------------+                    |
>  |power----->| Fixed regulator |---------+          |
>  |           +-----------------+         |          |
>  |                                       |          |
>  |                                       v VPH_PWR  |
>  | +----------------------------------------------+ |
>  | |                          AIM300 SOM |        | |
>  | |                                     |VPH_PWR | |
>  | |                                     v        | |
>  | |   +-------+       +--------+     +------+    | |
>  | |   | UFS   |       | QCS8550|     |PMIC  |    | |
>  | |   +-------+       +--------+     +------+    | |
>  | |                                              | |
>  | +----------------------------------------------+ |
>  |                                                  |
>  |                    +----+          +------+      |
>  |                    |USB |          | UART |      |
>  |                    +----+          +------+      |
>  +--------------------------------------------------+
> The following functions have been verified:
>   - uart
>   - usb
>   - ufs
>   - PCIe
>   - PMIC
>   - display
>   - adsp
>   - cdsp
>   - tlmm
> 
> Documentation for qcs8550[1] and sm8550[2]
> [1] https://docs.qualcomm.com/bundle/publicresource/87-61717-1_REV_A_Qualcomm_QCS8550_QCM8550_Processors_Product_Brief.pdf
> [2] https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/Snapdragon-8-Gen-2-Product-Brief.pdf
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
> 
> v6 -> v7:
>   - correct typos in the commit message
>   - move mdss_dsi0, mdss_dsi0_phy, pcie0_phy, pcie1_phy and usb_dp_qmpphy
>     vdda supply to qcs8550-aim300.dtsi
>   - move the perst and wake gpio settings of pcie0 and pcie1 to
>     qcs8550-aim300.dtsi
>   - move the clock frequency settings of pcie_1_phy_aux_clk, sleep_clk
>     and xo_board to qcs8550-aim300.dtsi
>   - verified with dtb check, and result is expected, because those
>     warnings are not introduced by current patch series.
>     arch/arm64/boot/dts/qcom/sm8550.dtsi:3037.27-3092.6: Warning
>     (avoid_unnecessary_addr_size): /soc@0/display-subsystem@ae00000/dsi@ae96000: unnecessary
>     #address-cells/#size-cells without "ranges" or child "reg" property
>     arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dtb:
>     phy@1c0e000: clock-output-names: ['pcie1_pipe_clk'] is too short
>         from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#
>     arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dtb: phy@1c0e000: #clock-cells:0:0: 1 was expected
>         from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#
> 
> v5 -> v6:
>   - move qcs8550 board info bebind sm8550 boards info in qcom.yaml
> 
> v4 -> v5:
>   - "2023-2024" instead of "2023~2024" for License
>   - update patch commit message to previous comments and with an updated
>     board diagram
>   - use qcs8550.dtsi instead of qcm8550.dtsi
>   - remove the reserved memory regions which will be handled by
>     bootloader
>   - remove pm8550_flash, pm8550_pwm nodes, Type-C USB/DP function node,
>     remoteproc_mpss function node, audio sound DTS node, new patch will
>     be updated after respective team's end to end full verification
>   - address comments to vph_pwr, move vph_pwr node and related
>     references to qcs8550-aim300-aiot.dts
>   - use "regulator-vph-pwr" instead of "vph_pwr_regulator"
>   - add pcie0I AND pcie1 support together
>   - the following patches were applied, so remove these patches from new
>     patch series:
>       - https://lore.kernel.org/linux-arm-msm/20240119100621.11788-3-quic_tengfan@quicinc.com
>       - https://lore.kernel.org/linux-arm-msm/20240119100621.11788-4-quic_tengfan@quicinc.com
>   - verified with dtb check, and result is expected, because those
>     warnings are not introduced by current patch series.
>     DTC_CHK arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dtb
>     arch/arm64/boot/dts/qcom/sm8550.dtsi:3015.27-3070.6: Warning
>     (avoid_unnecessary_addr_size): /soc@0/display-subsystem@ae00000/dsi@ae96000: unnecessary
>     #address-cells/#size-cells without "ranges" or child "reg" property
>     arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dtb:
>     opp-table: opp-75000000:opp-hz:0: [75000000, 0, 0, 75000000, 0, 0, 0, 0] is too long
>         from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
>     arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dtb:
>     opp-table: opp-150000000:opp-hz:0: [150000000, 0, 0, 150000000, 0, 0, 0, 0] is too long
>         from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
>     arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dtb:
>     opp-table: opp-300000000:opp-hz:0: [300000000, 0, 0, 300000000, 0, 0, 0, 0] is too long
>         from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
>     arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dtb:
>     opp-table: Unevaluated properties are not allowed ('opp-150000000', 'opp-300000000', 'opp-75000000' were unexpected)
>         from schema $id: http://devicetree.org/schemas/opp/opp-v2.yaml#
> 
> v3 -> v4:
>   - use qcm8550.dtsi instead of qcs8550.dtsi, qcs8550 is a QCS version
>     of qcm8550, another board with qcm8550 will be added later
>   - add AIM300 AIoT board string in qcom.yaml file
>   - add sm8550 and qcm8550 fallback compatible
>   - add qcm8550 SoC id
>   - add reserved memory map codes in qcm8550.dtsi
>   - pm8010 and pmr73d are splited into carrier board DTS file. Because
>     the regulators which in pm8550, pm8550ve and pm8550vs are present
>     on the SoM. The regulators which in pm8010 and pmr73d are present
>     on the carrier board.
>   - stay VPH_PWR at qcs8550-aim300.dtsi file
>       VPH_PWR is obtained by vonverting 12v voltage into 3.7 voltage
>       with a 3.7v buck. VPH_PWR is power supply for regulators in AIM300
>       SOM. VPH_PWR regulator is defined in AIM300 SOM dtsi file.
> 
> v2 -> v3:
>   - introduce qcs8550.dtsi
>   - separate fix dtc W=1 warning patch to another patch series
> 
> v1 -> v2:
>   - merge the splited dts patches into one patch
>   - update dts file name from qcom8550-aim300.dts to qcs8550-aim300 dts
>   - drop PCIe1 dts node due to it is not enabled
>   - update display node name for drop sde characters
> 
> previous discussion here:
> [1] v6 RESEND: https://lore.kernel.org/linux-arm-msm/20240401093843.2591147-1-quic_tengfan@quicinc.com
> [2] v6: https://lore.kernel.org/linux-arm-msm/20240308070432.28195-1-quic_tengfan@quicinc.com
> [3] v5: https://lore.kernel.org/linux-arm-msm/20240301134113.14423-1-quic_tengfan@quicinc.com
> [4] v4: https://lore.kernel.org/linux-arm-msm/20240119100621.11788-1-quic_tengfan@quicinc.com
> [5] v3: https://lore.kernel.org/linux-arm-msm/20231219005007.11644-1-quic_tengfan@quicinc.com
> [6] v2: https://lore.kernel.org/linux-arm-msm/20231207092801.7506-1-quic_tengfan@quicinc.com
> [7] v1: https://lore.kernel.org/linux-arm-msm/20231117101817.4401-1-quic_tengfan@quicinc.com
> 
> Tengfei Fan (4):
>   dt-bindings: arm: qcom: Document QCS8550 SoC and the AIM300 AIoT board
>   arm64: dts: qcom: qcs8550: introduce qcs8550 dtsi
>   arm64: dts: qcom: add base AIM300 dtsi
>   arm64: dts: qcom: aim300: add AIM300 AIoT
> 
>  .../devicetree/bindings/arm/qcom.yaml         |   8 +
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../boot/dts/qcom/qcs8550-aim300-aiot.dts     | 343 +++++++++++++++
>  arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi  | 403 ++++++++++++++++++
>  arch/arm64/boot/dts/qcom/qcs8550.dtsi         | 169 ++++++++
>  5 files changed, 924 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/qcs8550.dtsi
> 
> 
> base-commit: a59668a9397e7245b26e9be85d23f242ff757ae8
> --
> 2.25.1
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y qcom/qcs8550-aim300-aiot.dtb' for 20240424024508.3857602-1-quic_tengfan@quicinc.com:

arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dtb: phy@1c0e000: clock-output-names: ['pcie1_pipe_clk'] is too short
	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#
arch/arm64/boot/dts/qcom/qcs8550-aim300-aiot.dtb: phy@1c0e000: #clock-cells:0:0: 1 was expected
	from schema $id: http://devicetree.org/schemas/phy/qcom,sc8280xp-qmp-pcie-phy.yaml#







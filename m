Return-Path: <linux-kernel+bounces-164286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D90E28B7BB7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93FC1288931
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ACA174EC5;
	Tue, 30 Apr 2024 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zw+5rQP8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEF8BE49;
	Tue, 30 Apr 2024 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714491239; cv=none; b=QoNdZWcKUEmJdri+5kO+rHfA5fUvNvazM7Bguv1vprtkTm5aMFnkbgnfRsIrOqVRxNn0hwctvhmwVXOGUeOZqrVWSnDeeu7VyPHn8BRbn6pmkyMQ8K/pw46y8c49s2g856iHlN83Gj986hLYkYjxTQrPi31NmLM0LArprMeBmuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714491239; c=relaxed/simple;
	bh=0nKOSqddvGT0eIzhrYrSf2cuROkUOtP462KXoXDfiAQ=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=VjwobZlZIxBlF9TkJzCF+1oV1LMxOXVyIvpZD3eplVaU5AtWE1DY5AhCKzdd/pZ/dHd/IBb27PLZBiKwsoQvJSnSdoMHH2SbuiGoRce1vY/OZWnRSQNLGS7G8WkEitMPd/1GJ+3i4GZSTkMeXeKmiWzy1zChs+0Mu89yxw+51/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zw+5rQP8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25634C2BBFC;
	Tue, 30 Apr 2024 15:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714491238;
	bh=0nKOSqddvGT0eIzhrYrSf2cuROkUOtP462KXoXDfiAQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Zw+5rQP8zvFsqUni8xFlGIIG1SCowz9j3RQy+tvbqNL4hmO5YuB+iK2x9H7suVZxc
	 SGVHCnK+fz//7PgLdx4XvWFJfm3//ZzI/ytxPmYAmTlbCGYzoLUMTxcgyBK5RSVrcj
	 kDqAzx9xg1g3Qhl+nVpQYN+vhF3WNUAB6FiCEnHlZYI0LtmxJGv5WcAcs+TFde18I4
	 w3UxTbs7Ilh07dWrl3ohCwVYUh+ItzFw7lNi2VKDalYaLCoYz3gOQMEBV/15oQbpCN
	 MhZh/IkhxI9S6+pR1XT3iFtM0Ci/kwktM5jQn5osRWkpeXvNKfnmUgmY+VQXlOOfVx
	 dhSB3rarNs/KQ==
Date: Tue, 30 Apr 2024 10:33:55 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Conor Dooley <conor+dt@kernel.org>, quic_jackp@quicinc.com, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Johan Hovold <johan@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 quic_ppratap@quicinc.com, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>
In-Reply-To: <20240429162048.2133512-1-quic_kriskura@quicinc.com>
References: <20240429162048.2133512-1-quic_kriskura@quicinc.com>
Message-Id: <171449016553.3484108.5214033788092698309.robh@kernel.org>
Subject: Re: [PATCH v16 0/2] Add DT support for Multiport controller on
 SC8280XP


On Mon, 29 Apr 2024 21:50:46 +0530, Krishna Kurapati wrote:
> Series [1] introduces binding and driver support for DWC3 Multiport
> controllers. This series adds support for tertiary controller of SC8280
> and enabled multiport controller for SA8295P-ADP platform.
> 
> Till v13 [2] the DT was pushed along with driver code. Separated the DT
> changes from driver update and pushing it as this series. The first two
> versions were marked as v1 and v2. Marked this as v16 to avoid missing
> of change log till v13.
> 
> Changes in v16:
> Marked it as v16 rather than v3 since till v13, there were DT changes
> sent along with driver code but were separated and this version is
> supposed to be v16.
> Fixed interrupt triggers from EDGE_RISING to EDGE_BOTH.
> 
> Link to v15:
> https://lore.kernel.org/all/20240213082724.1789096-1-quic_kriskura@quicinc.com/
> 
> Changes in v15:
> SA8540 Ride related code changes have been dropped and will pushed later
> due to unavailability of hardware with either Andrew or me for testing the
> gpio hog changes suggested in v1.
> Implemented vbus boost regulators as fixed regulators instead of modelling
> their enable pins as pinctrl nodes.
> 
> Link to v14:
> https://lore.kernel.org/all/20240206114745.1388491-1-quic_kriskura@quicinc.com/
> 
> [1]: https://lore.kernel.org/all/20240420044901.884098-1-quic_kriskura@quicinc.com/
> [2]: https://lore.kernel.org/all/20231007154806.605-1-quic_kriskura@quicinc.com/#r
> 
> Krishna Kurapati (2):
>   arm64: dts: qcom: sc8280xp: Add USB DWC3 Multiport controller
>   arm64: dts: qcom: sa8295p: Enable tertiary controller and its 4 USB
>     ports
> 
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 83 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi   | 82 +++++++++++++++++++++++
>  2 files changed, 165 insertions(+)
> 
> --
> 2.34.1
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


New warnings running 'make CHECK_DTBS=y qcom/sa8295p-adp.dtb' for 20240429162048.2133512-1-quic_kriskura@quicinc.com:

arch/arm64/boot/dts/qcom/sa8295p-adp.dtb: usb@a4f8800: interrupt-names: ['pwr_event_1', 'pwr_event_2', 'pwr_event_3', 'pwr_event_4', 'hs_phy_1', 'hs_phy_2', 'hs_phy_3', 'hs_phy_4', 'dp_hs_phy_1', 'dm_hs_phy_1', 'dp_hs_phy_2', 'dm_hs_phy_2', 'dp_hs_phy_3', 'dm_hs_phy_3', 'dp_hs_phy_4', 'dm_hs_phy_4', 'ss_phy_1', 'ss_phy_2'] is too long
	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#
arch/arm64/boot/dts/qcom/sa8295p-adp.dtb: usb@a4f8800: interrupts-extended: [[1, 0, 130, 4], [1, 0, 135, 4], [1, 0, 857, 4], [1, 0, 856, 4], [1, 0, 131, 4], [1, 0, 136, 4], [1, 0, 860, 4], [1, 0, 859, 4], [118, 127, 3], [118, 126, 3], [118, 129, 3], [118, 128, 3], [118, 131, 3], [118, 130, 3], [118, 133, 3], [118, 132, 3], [118, 16, 4], [118, 17, 4]] is too long
	from schema $id: http://devicetree.org/schemas/usb/qcom,dwc3.yaml#







Return-Path: <linux-kernel+bounces-136982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CEC89DAA9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4E829086A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04645131BCB;
	Tue,  9 Apr 2024 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhaa14da"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE9013248D;
	Tue,  9 Apr 2024 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669938; cv=none; b=CJRrtsE5OU+jiK4HQlUSC4Yd0j/EUI1QDp1xHGYGuenncxqUovfgphVA4J+josNO7g81R98Oe1KxVSrkVYmAWIN6WasmQeSltIj/eqmKmzYF1hS+fVD6kvDW6jNTHKn8ykxLJfeEFUMUhXGiGRyQCjf6k1EAQJsLyNnTlPXjF/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669938; c=relaxed/simple;
	bh=K99Fz7vaSeq1E1vtm2u+tF1ZC+xbEgrSLRuL3JRM2HE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=iZZ42kIVmTu4XNssSYv+lpZWEPOwkOiXeR8gvti3U5XKfmVgOVfiyPmsE5kcLLmigbHzUkb6fQ3SuP7EvTGqk6HTnVYOtgsV+mBxEc68krr03q4mrI9kr4riXeVhAt5v6mblRmLIbxCuJ4UCVswR4tpQJgFowUtFmWoojEqT6TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhaa14da; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D23C43390;
	Tue,  9 Apr 2024 13:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712669938;
	bh=K99Fz7vaSeq1E1vtm2u+tF1ZC+xbEgrSLRuL3JRM2HE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=jhaa14da2hhFbbObUFNAJy1wudC187fLN+RSCi7gvP7bLWaamRfxswi4yooAsHTzX
	 WMM1gNr/ZnKoQd/i6mssv9sqNcrULlPZyaSiIscFArYhUkhaXLJ94sdYB5RJ7ZU/pA
	 MzoaQ8xGprJOKfOkHANGeEt+8stLMHruRCUL1FRXojKpmCk7Krmcm+sJ5brs+h2ndJ
	 z59Z8jRsKJ8eMhReoDTJ6X0O5c66PwTaIeRMwu/zsLe8KncmQLUWJZRq4kJjMi8/D/
	 CLJ51MMsKrjug9Yh6BW0/E0mWLqgMdLOqmgwIK06xASkmJBdIYiOmst+gyGmoPAJnI
	 Wt76h8VfQeKGg==
Date: Tue, 09 Apr 2024 08:38:56 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <20240408-hdk-orientation-gpios-v1-0-8064ba43e52a@linaro.org>
References: <20240408-hdk-orientation-gpios-v1-0-8064ba43e52a@linaro.org>
Message-Id: <171266958483.1032598.12332619537028473283.robh@kernel.org>
Subject: Re: [PATCH 0/4] arm64: dts: qcom: add USB-C orientation GPIOs


On Mon, 08 Apr 2024 05:33:58 +0300, Dmitry Baryshkov wrote:
> Populate orientation GPIOs for some of the PMIC-GLINK-based devices.
> This leaves only FairPhone5, RB3Gen2, SC8180X Primus and SC8280XP CRD
> without the orientation GPIOs declared.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Dmitry Baryshkov (4):
>       arm64: dts: qcom: sm8350-hdk: add USB-C orientation GPIO
>       arm64: dts: qcom: sm8450-hdk: add USB-C orientation GPIO
>       arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: add USB-C orientation GPIOs
>       arm64: dts: qcom: sc8180x-lenovo-flex-5g: add USB-C orientation GPIOs
> 
>  arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts        | 2 ++
>  arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 2 ++
>  arch/arm64/boot/dts/qcom/sm8350-hdk.dts                    | 1 +
>  arch/arm64/boot/dts/qcom/sm8450-hdk.dts                    | 1 +
>  4 files changed, 6 insertions(+)
> ---
> base-commit: 8568bb2ccc278f344e6ac44af6ed010a90aa88dc
> change-id: 20240408-hdk-orientation-gpios-141bc7fd247d
> 
> Best regards,
> --
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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


New warnings running 'make CHECK_DTBS=y qcom/sc8180x-lenovo-flex-5g.dtb qcom/sc8280xp-lenovo-thinkpad-x13s.dtb qcom/sm8350-hdk.dtb qcom/sm8450-hdk.dtb' for 20240408-hdk-orientation-gpios-v1-0-8064ba43e52a@linaro.org:

arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dtb: pmic-glink: orientation-gpios: False schema does not allow [[50, 38, 0], [50, 58, 0]]
	from schema $id: http://devicetree.org/schemas/soc/qcom/qcom,pmic-glink.yaml#
arch/arm64/boot/dts/qcom/sm8350-hdk.dtb: pmic-glink: orientation-gpios: False schema does not allow [[52, 81, 0]]
	from schema $id: http://devicetree.org/schemas/soc/qcom/qcom,pmic-glink.yaml#
arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dtb: pmic-glink: orientation-gpios: False schema does not allow [[62, 166, 0], [62, 49, 0]]
	from schema $id: http://devicetree.org/schemas/soc/qcom/qcom,pmic-glink.yaml#







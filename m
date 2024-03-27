Return-Path: <linux-kernel+bounces-120586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8BB88D9BB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0895A1C278B5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D86A37165;
	Wed, 27 Mar 2024 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VahVV8sP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E3C1EEFD;
	Wed, 27 Mar 2024 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711530108; cv=none; b=cLJwszZ5J12w2Cz1mp5ws1ncL1thgwv+NiXjO8ecMwtMKb1DoW5d5H5feMrn9jloPNfcY8KUTdFrt8WO6FM/zN//CQHSqfA+GteB+aKcRkKF1drQyFW9JT72XRlbe6RpXIZTEtgSShAJBXrCVsQ009HnDbL76vYdmvWnyw6A6p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711530108; c=relaxed/simple;
	bh=lyIEGaS1jPdeUhemduBEQ1WVoVPKb/fAHOq4AFGqAlY=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=aUxI/V2wVDcIpR90zgOFbb8I2L1Ce81IoS052MgCrDdUw8ZrMoPMvrE1y7YN/T+ej4EAVVHdJ2P4j6w7bmJIjlBFahN9bG/9cI1YfYezszqRlX7rUizhVr5feNUReojTZe5uPfiOhE5ysBGZFtxoi0Qh8fYGACXF0/duYaKjRyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VahVV8sP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2981BC43390;
	Wed, 27 Mar 2024 09:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711530108;
	bh=lyIEGaS1jPdeUhemduBEQ1WVoVPKb/fAHOq4AFGqAlY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=VahVV8sPUT8wuLtiT+/FuwYXJASdefezzd/GOLaob/zAnNobMN2Z+yBBon0KF0kog
	 WOqTFmPtX/3HWDyyP+CcaTxRqv6getFWAvw4kjgxYFdsnjHGHgqBpyHf04aACOWIZa
	 xrquFEwTS0eY2PlhGhceKPg6I5XG0Gnz1vuu0Q5v3jCOicg/NM6fUZZ1iSojhvkdi7
	 bgIWXlPXNA6gdiR7qV7VjH4uSppKPKWdp6WVYCvZKClNEB+PPS7TX7ARg0VE2z40UH
	 ZBzdjwfjOyN+rkOqqV4+4iKP8GGIrW7oBijefo/rq+1sPJvak59EmPfgcwvo0f9aYP
	 l0HgDlG+ODwFg==
Date: Wed, 27 Mar 2024 04:01:47 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: "yu-chang.lee" <yu-chang.lee@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
 MandyJH Liu <mandyjh.liu@mediatek.com>, xiufeng.li@mediatek.com, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-mediatek@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, fan.chen@mediatek.com, 
 linux-pm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20240327055732.28198-3-yu-chang.lee@mediatek.com>
References: <20240327055732.28198-1-yu-chang.lee@mediatek.com>
 <20240327055732.28198-3-yu-chang.lee@mediatek.com>
Message-Id: <171153010608.1499881.4707871183250112406.robh@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: power: Add mediatek larb
 definition


On Wed, 27 Mar 2024 13:57:31 +0800, yu-chang.lee wrote:
> Add Smart Multimedia Interface Local Arbiter to mediatek
> power domain.
> 
> Signed-off-by: yu-chang.lee <yu-chang.lee@mediatek.com>
> ---
>  .../devicetree/bindings/power/mediatek,power-controller.yaml  | 4 ++++
>  1 file changed, 4 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml:128:6: [error] syntax error: expected <block end>, but found '<block mapping start>' (syntax)
/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml:129:9: [warning] wrong indentation: expected 7 but found 8 (indentation)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/power/mediatek,power-controller.example.dts'
Documentation/devicetree/bindings/power/mediatek,power-controller.yaml:128:6: did not find expected key
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/power/mediatek,power-controller.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml:
while parsing a block mapping
  in "<unicode string>", line 64, column 5
did not find expected key
  in "<unicode string>", line 128, column 6
/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml:128:6: did not find expected key
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1430: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240327055732.28198-3-yu-chang.lee@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.



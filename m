Return-Path: <linux-kernel+bounces-130438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8249F897824
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 231581F215B2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A4515359B;
	Wed,  3 Apr 2024 18:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sg2afTlo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB68153580;
	Wed,  3 Apr 2024 18:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168651; cv=none; b=qUNvF94c3vpg4L71Cqf82W7sDN6A5OWFq3OZVFF8eDSvmBmk/YnrCaW8K+xB+NOhkA++OZlC84tuTB/tlKMj2Vw/i5qga/QuAHsmKqlu1Ro3kkMkF7soqgbrVEvf6YMUCr4j3vEO8x1RjJ16ixSncMjI/P6JJsAIST9zWX1Jfrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168651; c=relaxed/simple;
	bh=lYJ1OOy9SoM1VKUIpiLLjqnLsjUtvrF8je4vVleCm7Y=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=DzeXlS75qxebWzQTKUGy6cxpgAx8XmwOGRk4RfW++a2tBBOE6K82vEupsxsL2vSo1l3ur6swaKPTE2wPWdpZ+LlOTomtmgfDbdFcQDSN6xhQucxgvnLigLvLdJZ5p4RrAb7ut9nI9zUys4k9Ok16WlrC17oo7KzQZBJZAra0LIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sg2afTlo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0015BC433F1;
	Wed,  3 Apr 2024 18:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712168649;
	bh=lYJ1OOy9SoM1VKUIpiLLjqnLsjUtvrF8je4vVleCm7Y=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Sg2afTloh/CNK16CKRSEJUTBYO7qI332HHip/5SGma30FGT9lXcjmspzoBGDJxixy
	 CoHI+gb1XmGaFrhs46/CJzocEvhmW559Jpzo3M1C0+eL3sitsYQQCm5bCPRp5P3hgx
	 e2QNnFdH3y6+pIYQG83PiRtgWaulk4F5XsWdmZVIGomwpu4bigy7IlcPsSpqQbA5Yk
	 bnO3Sv3hoJQVmP31YTIhA0GchpRuLs51Qaj8hDmDbB4ptpMd2Q+3z1d6eboYny+oBD
	 D7IqQOqVuNYqVz/lRryANBTPKKbhNZK8YctbJIeCLu2sw5/7Y1VmnvoETdmXmr7lfR
	 JfZ78iuwUXGhw==
Date: Wed, 03 Apr 2024 13:24:07 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: sudeep.holla@arm.com, conor+dt@kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 jassisinghbrar@gmail.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
In-Reply-To: <20240403171346.3173843-2-cristian.marussi@arm.com>
References: <20240403171346.3173843-1-cristian.marussi@arm.com>
 <20240403171346.3173843-2-cristian.marussi@arm.com>
Message-Id: <171216864685.4137724.3624425413687368157.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: mailbox: arm,mhuv3: Add bindings


On Wed, 03 Apr 2024 18:13:45 +0100, Cristian Marussi wrote:
> Add bindings for the ARM MHUv3 Mailbox controller.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v1 -> v2
> - clarified extension descriptions around configurability and discoverability
> - removed unused labels from the example
> - using pattern properties to define interrupt-names
> - bumped interrupt maxItems to 74 (allowing uo to 8 channels per extension)
> ---
>  .../bindings/mailbox/arm,mhuv3.yaml           | 217 ++++++++++++++++++
>  1 file changed, 217 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
/Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml:86:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/mailbox/arm,mhuv3.example.dts'
Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml:86:1: found a tab character where an indentation space is expected
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/mailbox/arm,mhuv3.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
/Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml:86:1: found a tab character where an indentation space is expected
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1430: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240403171346.3173843-2-cristian.marussi@arm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.



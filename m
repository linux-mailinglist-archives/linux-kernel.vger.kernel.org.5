Return-Path: <linux-kernel+bounces-133895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4C289AA79
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 13:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1DD51F21E26
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C912C195;
	Sat,  6 Apr 2024 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGBSp5mv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D4D210E6;
	Sat,  6 Apr 2024 11:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712401349; cv=none; b=nm+Ar2N3K8Vmxk3Sh1bfEge+jPTrJAGZxXnR8lGZQ+WFRnArm/wjGr4gTpbquCM/cdiPbzR/9eSjjXF3SjYOAbx7LYnBppWuUiCS4BFpzMY8PksuU7z0u7V86/y+PFyC3olI2kz+rCDfjkJ5wielnSfow3rhLQlnMBmGrhr5bFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712401349; c=relaxed/simple;
	bh=ZpMrxADaKtuIXlCnRIxLx0NrrHdkrgR6Fbx126OpUO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IwAjQrNTgitpT0zl6TCpxoc51jCHKqS65s/Ode2koXN4IFUX/FmTCMzk1wGWDaC2ad04kyq9yZcmacxXOAFOD8QZRbVbJedMJwOb6hmiQTVPZijFKlTt0rX3r8Jn/tD6f+DKprZPrvk67+1Da2nIpxkJzKXBoduew98HdaKTOTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGBSp5mv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373C6C433C7;
	Sat,  6 Apr 2024 11:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712401349;
	bh=ZpMrxADaKtuIXlCnRIxLx0NrrHdkrgR6Fbx126OpUO0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OGBSp5mv7v2wdUBs6QxDpTnHMH9h1RadzFJbVbEW5sCOWjrDkmPTYm/kZVAMQWZUz
	 nexpFE0HxrFBlYNET9O+SzYFhqdVnudan30gX/UufdSdDPm1zQWqbN/5vmpjMJXtmi
	 +3vw0QqvQETlEsTNbmofz7d6hracXoNxc8EE0MGTQE0nJd7vhghxDNCtojGIG8Q9g+
	 cPUEMDk6VT+y8OIdA/uSa79KuWRydn7WCF8csTGZoLqQtRioMOx9TcT681N5fOvkyT
	 6+2828psFxvt1G2VWsRTPIokzkhi9MWRZkFmBvK9MeoJGFA+tpYFt8ckQmBGNC3jNe
	 JuEGoTNZaTDvw==
Message-ID: <9aab8dab-27c4-40b6-b1d5-0a2babe0700d@kernel.org>
Date: Sat, 6 Apr 2024 13:02:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] dt-bindings: firmware: add i.MX SCMI Extension
 protocol
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Cristian Marussi <cristian.marussi@arm.com>
Cc: Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
 <20240405-imx95-bbm-misc-v2-v2-2-9fc9186856c2@nxp.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240405-imx95-bbm-misc-v2-v2-2-9fc9186856c2@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/04/2024 14:39, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX SCMI Extension protocols bindings for:
>  - Battery Backed Secure Module(BBSM)

Which is what?

>  - MISC settings such as General Purpose Registers settings.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/firmware/imx,scmi.yaml     | 80 ++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/imx,scmi.yaml b/Documentation/devicetree/bindings/firmware/imx,scmi.yaml
> new file mode 100644
> index 000000000000..7ee19a661d83
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/imx,scmi.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2024 NXP
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/imx,scmi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX System Control and Management Interface(SCMI) Vendor Protocols Extension
> +
> +maintainers:
> +  - Peng Fan <peng.fan@nxp.com>
> +
> +allOf:
> +  - $ref: arm,scmi.yaml#

Sorry, but arm,scmi is a final schema. Is your plan to define some
common part?

> +
> +properties:
> +  protocol@81:
> +    $ref: 'arm,scmi.yaml#/$defs/protocol-node'
> +    unevaluatedProperties: false
> +    description:
> +      The BBM Protocol is for managing Battery Backed Secure Module (BBSM) RTC
> +      and the ON/OFF Key
> +
> +    properties:
> +      reg:
> +        const: 0x81
> +
> +    required:
> +      - reg
> +
> +  protocol@84:
> +    $ref: 'arm,scmi.yaml#/$defs/protocol-node'
> +    unevaluatedProperties: false
> +    description:
> +      The MISC Protocol is for managing SoC Misc settings, such as GPR settings

Genera register is not a setting... this is a pleonasm. Please be more
specific what is the GPR, MISC protocol etc.

> +
> +    properties:
> +      reg:
> +        const: 0x84
> +
> +      wakeup-sources:
> +        description:
> +          Each entry consists of 2 integers, represents the source and electric signal edge

Can you answer questions from reviewers?

> +        items:
> +          items:
> +            - description: the wakeup source
> +            - description: the wakeup electric signal edge
> +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +
> +    required:
> +      - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    firmware {
> +        scmi {
> +            compatible = "arm,scmi";

> +            mboxes = <&mu2 5 0>, <&mu2 3 0>, <&mu2 3 1>;
> +            shmem = <&scmi_buf0>, <&scmi_buf1>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            protocol@81 {
> +                reg = <0x81>;
> +            };
> +
> +            protocol@84 {
> +                reg = <0x84>;
> +                wakeup-sources = <0x8000 1
> +                                  0x8001 1
> +                                  0x8002 1
> +                                  0x8003 1
> +                                  0x8004 1>;

Nothing improved... If you are going to ignore reviews, then you will
only get NAKed.

Best regards,
Krzysztof



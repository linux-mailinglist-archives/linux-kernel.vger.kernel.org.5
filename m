Return-Path: <linux-kernel+bounces-139068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BC689FE1E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35A241F22913
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B51117BB21;
	Wed, 10 Apr 2024 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8R+u2Lc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488D3176FDB;
	Wed, 10 Apr 2024 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769568; cv=none; b=tyIe5js0Y8bMEotV3Bj00d6TsBkx0wD/CT0uHzc0pPu05+N00LmN4emviz0Au0WlCZHg4tXlwD2wo5oi+CrtpU0zUPOq+fU4F/ocSBouRxLu+PJGgnR5XIiwohlu9Uq0BO9rQAfeAMZlqdbqi9Vc5dWiG/lK2X7v+7Ij3kJw+q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769568; c=relaxed/simple;
	bh=W5eX1rU/9P9HprqQ9cPTQC7SCZNm4aigfiIYicPhLKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKblNNuSWyJPUv2X9SC1bbUypqDpptpkN3/q+DzK/IvCty31pRdpqYA4rFkEIcsJHQyef4H5xykNLwwW8i2iindizIC8TKaQIM/1fNFVQjYIi4sEhmHSWKijIdRfWM8z0nWa8GhqVv3R62MxaW1q0KfyTEi65dgQzARgdDlIByw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8R+u2Lc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919E3C433F1;
	Wed, 10 Apr 2024 17:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712769567;
	bh=W5eX1rU/9P9HprqQ9cPTQC7SCZNm4aigfiIYicPhLKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g8R+u2LcMjuhESgE2vdJd7RAdvDYicV1iPM5LiK+Cex1rJ4Kn+rqiOOKA4YgGBKvU
	 6wirhtTbJho6uV8fUZjciCHslvPTUwhW4UtoLt0zHxFxemaIr2QGwk1TON+DL5DPwh
	 h4NyvSfMciSRUzEYpe0gpKjAsugwpEW/EoOvZdRYg0QWazSXf8I5sdanN5s321ELEa
	 WJiUI7rmI6eD2Nw2Re3rpobNscN0B/NJ0kDU++7gyEtBdjRNw250mUOIQAgU3B7lA7
	 XlYVjideFzkiT88e516rW9xYi1ojtQpflKSFz+BxOzTxZ829xErrWrYMEn+5+DHuMX
	 ZuGXuEGz8Zh6A==
Date: Wed, 10 Apr 2024 12:19:25 -0500
From: Rob Herring <robh@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] dt-bindings: firmware: add i.MX SCMI Extension
 protocol
Message-ID: <20240410171925.GA564262-robh@kernel.org>
References: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
 <20240405-imx95-bbm-misc-v2-v2-2-9fc9186856c2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405-imx95-bbm-misc-v2-v2-2-9fc9186856c2@nxp.com>

On Fri, Apr 05, 2024 at 08:39:24PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX SCMI Extension protocols bindings for:
>  - Battery Backed Secure Module(BBSM)
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

This needs to be the other way around. Add a ref to this file in 
arm,scmi.yaml under an 'anyOf' entry.

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
> +
> +    properties:
> +      reg:
> +        const: 0x84
> +
> +      wakeup-sources:
> +        description:
> +          Each entry consists of 2 integers, represents the source and electric signal edge
> +        items:
> +          items:
> +            - description: the wakeup source
> +            - description: the wakeup electric signal edge

No constraints on the entry values?

> +        $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +
> +    required:
> +      - reg
> +
> +additionalProperties: false

And then this can be true.

Rob


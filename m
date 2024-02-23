Return-Path: <linux-kernel+bounces-78436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C164086137B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62F8FB22045
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BB580036;
	Fri, 23 Feb 2024 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLi4DYFc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B0E5DF00;
	Fri, 23 Feb 2024 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708696979; cv=none; b=uHV+lKd+SxPBps2Sb4+D9xZTkyX4h4lqW3lMXz/6DDXdsZIlbV3wTOfiKzbdawlqxfcaP6MBYkwsGtwqn3bK7cl0BveYRX+YRk69kdBYQpCgKdvd/bGUnhXLJa6tKMwmJKhZGn3AurtKMobMMWFeGnSHyXJ0toHerkOt4LEMc+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708696979; c=relaxed/simple;
	bh=KudqgcL6FXV7PnIRApxE0DX6lKwquS27CBUuH61ACuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZCNZ6zzWK87jfPUTFKPFmAIMsyoAiyrNgGnCdJAh12molDEJvVvVi0IcTeuoUo9w9OkoigG/mu85/8pG8irRsdj7E7XIw657e406Yn37pkhfaJdo86EpCxRSyTV6Ui22XsU0uNuKtLpyVNVmH/X2TMjelQ6LT3z44jeUtbVWwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLi4DYFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BDDC43390;
	Fri, 23 Feb 2024 14:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708696978;
	bh=KudqgcL6FXV7PnIRApxE0DX6lKwquS27CBUuH61ACuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fLi4DYFcXeqOjYNV4Q5Y0zzkCxXVhiAEIcopANPUixE0A00H3p4zQaXilBTNRWWAz
	 8WdpvA726hFRxVFaBV7VooO96ZCe8lQoO75INuRxATCb3qw09fQypMk1wtHPRPiUNH
	 3D/UnzbO/QSRQ5VsUuoN81I5eI7gAvPnmR2ts3yqN7JMAi1wvt3FB4W8WXCXGWh+kv
	 ILMB/mrEGzFtkwk/wyGov8x8/C4FR/kPzV5yksDYCaViYHPuVhwq/+J/WdfTQaTthb
	 LXW8WMDUAavJojYX2dwmpZAfKHfiWfnvIuRgNwpZQSxxJpBgmWl6f7XiUsBrz2eHnW
	 OPI70JWN1c/NA==
Date: Fri, 23 Feb 2024 07:02:56 -0700
From: Rob Herring <robh@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
	shawnguo@kernel.org, conor+dt@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	peter.chen@kernel.org, jun.li@nxp.com, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/9] dt-bindings: usb: add NXP ChipIdea USB2
 Controller schema
Message-ID: <20240223140256.GA1768266-robh@kernel.org>
References: <20240221145846.1611627-1-xu.yang_2@nxp.com>
 <20240221145846.1611627-4-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221145846.1611627-4-xu.yang_2@nxp.com>

On Wed, Feb 21, 2024 at 10:58:41PM +0800, Xu Yang wrote:
> As more and more NXP i.MX chips come out, it becomes harder to maintain
> ci-hdrc-usb2.yaml if more stuffs like property restrictions are added to
> this file. This will separate i.MX parts out of ci-hdrc-usb2.yaml and add
> a new schema for NXP ChipIdea USB2 Controller.
> 
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> ---
> Changes in v6:
>  - new patch
> ---
>  .../bindings/usb/ci-hdrc-usb2-imx.yaml        | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
> new file mode 100644
> index 000000000000..2ec62f564bf5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2-imx.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/ci-hdrc-usb2-imx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP USB2 ChipIdea USB controller
> +
> +maintainers:
> +  - Xu Yang <xu.yang_2@nxp.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - fsl,imx27-usb
> +      - items:
> +          - enum:
> +              - fsl,imx23-usb
> +              - fsl,imx25-usb
> +              - fsl,imx28-usb
> +              - fsl,imx35-usb
> +              - fsl,imx50-usb
> +              - fsl,imx51-usb
> +              - fsl,imx53-usb
> +              - fsl,imx6q-usb
> +              - fsl,imx6sl-usb
> +              - fsl,imx6sx-usb
> +              - fsl,imx6ul-usb
> +              - fsl,imx7d-usb
> +              - fsl,vf610-usb
> +          - const: fsl,imx27-usb
> +      - items:
> +          - enum:
> +              - fsl,imx8dxl-usb
> +              - fsl,imx8ulp-usb
> +          - const: fsl,imx7ulp-usb
> +          - const: fsl,imx6ul-usb
> +      - items:
> +          - enum:
> +              - fsl,imx8mm-usb
> +              - fsl,imx8mn-usb
> +          - const: fsl,imx7d-usb
> +          - const: fsl,imx27-usb
> +      - items:
> +          - enum:
> +              - fsl,imx6sll-usb
> +              - fsl,imx7ulp-usb
> +          - const: fsl,imx6ul-usb
> +          - const: fsl,imx27-usb

Now you just duplicated all the compatibles, and now any new compatibles 
have to be added in 2 places. For this to work, you have to split 
ci-hdrc-usb2.yaml into 2 files. One with all the common properties and 
one with compatibles (minus imx). This is also needed if imx has any 
extra properties the other don't.

Didn't I say this already?

Rob



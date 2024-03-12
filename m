Return-Path: <linux-kernel+bounces-100373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B58D87966E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB59A2830C6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3036D7C0BB;
	Tue, 12 Mar 2024 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5bljXPh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDF17B3F8;
	Tue, 12 Mar 2024 14:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253990; cv=none; b=AJ7bKibKKc5jNLxTZtVLk1uGfFyU3r1IXvBZJNcJwdbXg3e5N8eJCFXdW/4EtESKXDbO+cXK4BByKa8hZD05aRRVXPWHuD8ndpelZDu34rmxYoT0NuZ7oYc17xsyUTzeucy54invDdC2sMR3PYeiN/1BE+a8n5CNWJ7Ep1/oSNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253990; c=relaxed/simple;
	bh=xwQfX7wE+SHR+sIXXoDl3Mmp3oo9zjH1npQEC15cvY0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=IXDz50MoJWxqoAK3pXMn6uoX3ixPbx9EMrDX8b7kAmo+MG6rlOGdLgqknU7nolfR18CAQODVuW9XYOpV+numDKW+YbF8R93SAezVh5obbgUClzqjgbbaDnRHVBSN8ggu3Jbjod3z3yqrVqUGpVDrzgJBghWXqb8hlp5QBIEqO2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5bljXPh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72BFC43394;
	Tue, 12 Mar 2024 14:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710253990;
	bh=xwQfX7wE+SHR+sIXXoDl3Mmp3oo9zjH1npQEC15cvY0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=L5bljXPhLLgoz2yi4sUU66Nv22zcwZd5RCqG/KQUBG8J0puP93ibPnsyJJxC5OjLc
	 9IVaC6uRD5fhZIRiRJK6lIq6n+htvfQ4NsQmQlJlgrmYd3UwoT6JxCBWWua93ntZv0
	 dETjdz0m/jB3ulH4Tn0J2RVQMxLdukCC8OFEut3LbWkDv9TVLiwE8b6Mt3jjIYfT+x
	 TkSnXcwKaHavXTaJBYJXd7raC3x60AJ/dav8iltPXYW8noXyyCltb4RtiE7+Trrp57
	 oc0ZsNOm52AgxsDEvI74ggUTOTBAq9bmVGhEW+f2O+B0+UoJ+AIZCAjmDxFzvnJxH0
	 rvJckt1UOCp2w==
Date: Tue, 12 Mar 2024 08:33:08 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: krzysztof.kozlowski+dt@linaro.org, linux-imx@nxp.com, 
 shawnguo@kernel.org, linux-usb@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, robh+dt@kernel.org, 
 linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de, 
 peter.chen@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
 jun.li@nxp.com, festevam@gmail.com, gregkh@linuxfoundation.org
In-Reply-To: <20240312091703.1220649-1-xu.yang_2@nxp.com>
References: <20240312091703.1220649-1-xu.yang_2@nxp.com>
Message-Id: <171025376556.2190631.1099014276992034408.robh@kernel.org>
Subject: Re: [PATCH v8 01/10] dt-bindings: usb: usbmisc-imx: add
 fsl,imx8ulp-usbmisc compatible


On Tue, 12 Mar 2024 17:16:54 +0800, Xu Yang wrote:
> Add "fsl,imx8ulp-usbmisc" compatible.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> 
> ---
> Changes in v3:
>  - new patch due to missed this little one
> Changes in v4:
>  - no changes
> Changes in v5:
>  - add Acked-by tag
> Changes in v6:
>  - no changes
> Changes in v7:
>  - no changes
> Changes in v8:
>  - no changes
> ---
>  Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml | 1 +
>  1 file changed, 1 insertion(+)
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


New warnings running 'make CHECK_DTBS=y freescale/imx8ulp-evk.dtb freescale/imx93-11x11-evk.dtb' for 20240312091703.1220649-1-xu.yang_2@nxp.com:

arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: tcpc@50: compatible: ['nxp,ptn5110'] is too short
	from schema $id: http://devicetree.org/schemas/usb/nxp,ptn5110.yaml#
arch/arm64/boot/dts/freescale/imx93-11x11-evk.dtb: tcpc@51: compatible: ['nxp,ptn5110'] is too short
	from schema $id: http://devicetree.org/schemas/usb/nxp,ptn5110.yaml#







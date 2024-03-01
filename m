Return-Path: <linux-kernel+bounces-88887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AC686E7FC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23E4C1C229CB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B5822093;
	Fri,  1 Mar 2024 18:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IK8N7CTx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E671171A1;
	Fri,  1 Mar 2024 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709316611; cv=none; b=p5AD+yL9ml4mQMCL2SHe65HGPVwRVbBPGG4UPQp4daBMttg/iK+2JGG5qIm0XhJ7DWlp9WVX58GIIZ+2wt/7rxvWLAWMMvVKFU1q9uJ4N8LIb+B6wjFfx+tFm2cusG2EKFWpz3aI3weaepAxX6/F6X2yEtDaawBIyqiDiCFgt6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709316611; c=relaxed/simple;
	bh=oGgDYAMEcOek5vzs12UcoMNqw0pBRI+Tp6Tw2lcrknA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlS89qIMMwZ0wJH4w0bUjp5RooPyKd24E+udTakoKDI6UMM5txujGv+YjVYztGHZDm7VXlDQ+plZb+2WCbBsKhKKh53Kco2Yt4t31awTUPPEc1Lq7sLUjOLdeKRnkT/uWrYt2VCBxBtgIaIqtVfm9ydHPtgUzTODaKJEPgFYOQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IK8N7CTx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524E8C433C7;
	Fri,  1 Mar 2024 18:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709316609;
	bh=oGgDYAMEcOek5vzs12UcoMNqw0pBRI+Tp6Tw2lcrknA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IK8N7CTxXCT+ZohlOgRwslhOwKmwn14JE//RO0B49dvzoU0LIQhX04JV9TqoA6xB3
	 kZH1ErLMAK+dq4z/Lne+YMOjfFwrtGAyeGR8QvXI2IyTdV7wrFEERyDKF29Lq6/xIQ
	 z2Aal86VP39Ab2yob5tMqJ5CJLpBO6Nr/bhi5+oM4v2m+rdP+jy5IbmeNcDvj8HS3K
	 S7C/BCRe4HE6QNg4pXYsrBGO7jlsdcqDho7ZRR65wFGKfRXi6SjxWewX+5ZiAEFCiL
	 t1cUzHAxEKftKEJuTfm89UIrrIEMeMOO9zH2j//+g+54Uk4f8nRXg3lLRQVb+He3mV
	 juJGoyCGAIgXw==
Date: Fri, 1 Mar 2024 12:10:07 -0600
From: Rob Herring <robh@kernel.org>
To: Dharma.B@microchip.com
Cc: krzysztof.kozlowski@linaro.org, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	daniel@ffwll.ch, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, Nicolas.Ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: atmel,lcdc: convert to dtschema
Message-ID: <20240301181007.GA2481641-robh@kernel.org>
References: <20240223-lcdc-fb-v1-1-4c64cb6277df@microchip.com>
 <796652d5-af57-4aca-87c2-10a7b0b55959@linaro.org>
 <11c545e2-45df-4587-a5c7-12b05c2f01e0@microchip.com>
 <9bf7e492-891c-4d8f-b388-3b2ebae611c1@linaro.org>
 <e5cb705f-56cc-47cc-beb5-700c9a35c8cf@microchip.com>
 <34388175-7d5b-4f6b-b264-e85b84e98677@linaro.org>
 <dc8181d9-c7c9-4817-96f1-84a1b64575d6@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc8181d9-c7c9-4817-96f1-84a1b64575d6@microchip.com>

On Thu, Feb 29, 2024 at 06:25:56AM +0000, Dharma.B@microchip.com wrote:
> On 28/02/24 3:53 pm, Krzysztof Kozlowski wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On 28/02/2024 11:18, Dharma.B@microchip.com wrote:
> >> On 28/02/24 12:43 pm, Krzysztof Kozlowski wrote:
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>>
> >>> On 28/02/2024 07:59, Dharma.B@microchip.com wrote:
> >>>>
> >>>>>
> >>>>> I don't know what's this exactly, but if embedded display then maybe
> >>>>> could be part of this device node. If some other display, then maybe you
> >>>>> need another schema, with compatible? But first I would check how others
> >>>>> are doing this.
> >>>>
> >>>> Okay, then I think the driver also needs to be modified, currently the
> >>>> driver parses the phandle and looks for these properties. Also the
> >>>> corresponding dts files.
> >>>
> >>> Driver does not have to be modified in my proposal. You would still have
> >>> phandle.
> >>
> >> If I understand correctly, I could define the dt bindings as below
> >>
> >>     display:
> >>       $ref: /schemas/types.yaml#/definitions/phandle
> >>       description: A phandle pointing to the display node.
> >>
> >>     panel:
> >>       $ref: panel/panel-common.yaml#
> >>       properties:
> >>
> > 
> > So these are standard panel bindings? Then the node should live outside
> > of lcdc. If current driver needs to poke inside panel and panel could be
> > anything, then probably you need peripheral-props-like approach. :/
> 
> Thank you so much, so can I use something like this
> 
>    display:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description: A phandle pointing to the display node.
> 
> patternProperties:
>    "^panel":

Just 'panel' and not a pattern.

However, that's not what the original binding had. It was a separate 
node. If you want to preserve that, then you'll need a separate 
schema file and a special 'select'. Something like:

select:
  anyOf:
    - required: [ atmel,dmacon ]
    - required: [ atmel,lcdcon2 ]
    - required: [ atmel,guard-time ]

Up to you and at91 maintainers if you want to have to update your dts 
files or not.

Rob


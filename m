Return-Path: <linux-kernel+bounces-112687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD89887CF9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1CB1C20A39
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77B018032;
	Sun, 24 Mar 2024 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfiiQY+T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD38E17BCA;
	Sun, 24 Mar 2024 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711288482; cv=none; b=OeyAl4YW4L9NOrwF1kmnGff31NRnCt3gr5UBtFBnfllc/HtzgyK72dXYWcL6FZQRGBHWdQBJ2euYonQfVFd98nvQSZmeQ6n9IBs5vGr423lxWa0rfCO/sn9D4SdmUEkXkfGXcqmaDnT62N8lspgRQL5+6LXbBrV6ZJ/DFXyZue8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711288482; c=relaxed/simple;
	bh=L3eiBM3uq6W9B54PHA6++0VN5SYP8Sh0IVo8b/FkvIE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hn5kGOcuMq9PSvQ60q+pysDqNiQ9lhPldRUac3RJT8H9S4hIOSgA7Pz6sWnqXmZpuaEIoStbHohcYCGsIj3lloS6pyDaUwuk1Zm1uTYGGpylBJGwniflLzkdg5iuUJKzwrPcVJFwEHLJIqJNoJe2rfBYTbPKY93tovagKXCwvlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfiiQY+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4FAC433F1;
	Sun, 24 Mar 2024 13:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711288481;
	bh=L3eiBM3uq6W9B54PHA6++0VN5SYP8Sh0IVo8b/FkvIE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sfiiQY+TsD3FaX0kL3X/fKuSvqjPE3/1wMNAfjfC/BqoJ5/mloZ6YrOYfOBQF0rFc
	 R4NNlmOifgOI3sXL13QlHJh+Pwg/nL4WwcJz3Lr2XfiAcWGEEwBfe896Z1OwcR0r2m
	 VPaf2gSw75Fw5G7pjqm0g2DPh0Rgi6UmfGatEhnLbl11vVGbFLz5W+OTtHyevrdPjO
	 YoRJImLD9Hh28Dt25hWC4VK0ZV6ZPplCuEwMQhEhORzmrx5dBqHNgIQcledk8BOmYu
	 Nj0kphW0O1KKo5wthVGBrbH6iYZcPIXPe5Ne40U/31yGoNadxnaMgfWYzsAy4KYGWc
	 4zxp3apamBadQ==
Date: Sun, 24 Mar 2024 13:54:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andrej Picej <andrej.picej@norik.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 haibo.chen@nxp.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 lars@metafoo.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 upstream@lists.phytec.de
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: nxp,imx93-adc.yaml: Add
 calibration properties
Message-ID: <20240324135425.229622d6@jic23-huawei>
In-Reply-To: <1bbd4fdf-59c5-42b2-8698-95f402645c67@norik.com>
References: <20240320100407.1639082-1-andrej.picej@norik.com>
	<20240320100407.1639082-3-andrej.picej@norik.com>
	<38637621-1611-4268-ae79-7ac93a72c5ee@linaro.org>
	<e994b756-7f4e-4be3-b8f3-310988174b44@norik.com>
	<7e58bf96-3c38-467f-86b6-06ff5feedb31@linaro.org>
	<40e08a5e-e7e9-47c7-9102-24a2bbba67cf@norik.com>
	<a1b173c0-5120-40f6-9708-cd810b4a2406@linaro.org>
	<1bbd4fdf-59c5-42b2-8698-95f402645c67@norik.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Mar 2024 10:58:54 +0100
Andrej Picej <andrej.picej@norik.com> wrote:

> On 22. 03. 24 09:14, Krzysztof Kozlowski wrote:
> > On 22/03/2024 08:39, Andrej Picej wrote:  
> >> On 20. 03. 24 13:15, Krzysztof Kozlowski wrote:  
> >>> On 20/03/2024 13:05, Andrej Picej wrote:  
> >>>> Hi Krzysztof,
> >>>>
> >>>> On 20. 03. 24 11:26, Krzysztof Kozlowski wrote:  
> >>>>> On 20/03/2024 11:04, Andrej Picej wrote:  
> >>>>>> Document calibration properties and how to set them.  
> >>>>>
> >>>>> Bindings are before users.  
> >>>>
> >>>> will change patch order when I send a v2.
> >>>>  
> >>>>>
> >>>>> Please use subject prefixes matching the subsystem. You can get them for
> >>>>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> >>>>> your patch is touching.
> >>>>> There is no file extension in prefixes.  
> >>>>
> >>>> So: dt-bindings: iio/adc: nxp,imx93-adc: Add calibration properties?  
> >>>
> >>> Did you run the command I proposed? I don't see much of "/", but except
> >>> that looks good.  
> >>
> >> Ok noted.
> >>  
> >>>  
> >>>>  
> >>>>>  
> >>>>>>
> >>>>>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> >>>>>> ---
> >>>>>>     .../bindings/iio/adc/nxp,imx93-adc.yaml           | 15 +++++++++++++++
> >>>>>>     1 file changed, 15 insertions(+)
> >>>>>>
> >>>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> >>>>>> index dacc526dc695..64958be62a6a 100644
> >>>>>> --- a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> >>>>>> +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> >>>>>> @@ -46,6 +46,21 @@ properties:
> >>>>>>       "#io-channel-cells":
> >>>>>>         const: 1
> >>>>>>     
> >>>>>> +  nxp,calib-avg-en:
> >>>>>> +    description:
> >>>>>> +      Enable or disable averaging of calibration time.
> >>>>>> +    enum: [ 0, 1 ]
> >>>>>> +
> >>>>>> +  nxp,calib-nr-samples:
> >>>>>> +    description:
> >>>>>> +      Selects the number of averaging samples to be used during calibration.
> >>>>>> +    enum: [ 16, 32, 128, 512 ]
> >>>>>> +
> >>>>>> +  nxp,calib-t-samples:
> >>>>>> +    description:
> >>>>>> +      Specifies the sample time of calibration conversions.
> >>>>>> +    enum: [ 8, 16, 22, 32 ]  
> >>>>>
> >>>>> No, use existing, generic properties. Open other bindings for this.  
> >>>>
> >>>> You mean I should use generic properties for the ADC calibration
> >>>> settings? Is there already something in place? Because as I understand
> >>>> it, these calib-* values only effect the calibration process of the ADC.  
> >>>
> >>> Please take a look at other devices and dtschema. We already have some
> >>> properties for this... but maybe they cannot be used?
> >>>  
> >>
> >> I did look into other ADC devices, grep across iio/adc, adc bindings
> >> folders and couldn't find anything closely related to what we are
> >> looking for. Could you please point me to the properties that you think
> >> should be used for this?  
> > 
> > Indeed, there are few device specific like qcom,avg-samples. We have
> > though oversampling-ratio, settling-time-us and min-sample-time (which
> > is not that good because does not use unit suffix).  
> 
> Ok, these are examples but I think I should not use them, since these 
> are i.MX93 ADC specific settings, which are used for configuration of 
> calibration process, and are not related to the standard conversion 
> process during runtime. Calibration process is the first step that 
> should be done after every power-on reset.
> 
> > 
> > Then follow up questions:
> >   - nxp,calib-avg-en: Why is it a board-level decision? I would assume
> > this depends on user choice and what kind of input you have (which could
> > be board dependent or could be runtime decision).  
> 
> Not really sure I get your question, so please elaborate if I missed the 
> point.
> This is a user choice, to enable or disable the averaging function in 
> calibration, but this is a board-level decision, probably relates on 
> external ADC regulators and input connections. The same options are used 
> for every ADC channel and this can not be a runtime decision, since 
> calibration is done before the ADC is even registered.

I'll raise this question in reply to the cover letter or patch 1 where
it is perhaps more appropriate, but I'd really like to know more about why
these are useful at all. 

> 
> >   - nxp,calib-t-samples: what does it mean? Time is expressed in time
> > units, but there is nothing about units in the property name.
> >   
> 
> You are right, basically this is "time" in cycles of AD_CLK. I should at 
> least add that to the property description.
> 
> Best regards,
> Andrej Picej



Return-Path: <linux-kernel+bounces-117271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5393B88AD28
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 490A7B67BC8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B1516D9B4;
	Mon, 25 Mar 2024 14:38:30 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2002C13CFB1;
	Mon, 25 Mar 2024 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711377509; cv=none; b=Xu67CCl1CBphMcgmOL4J2AzQWc0Zwc8lN3/ZM1l23kXzjoOUQ09LEN93JiHTTRq6nOwFONDZTyPl/e6YXwlSvML8boHbqjCzijE0GgvRIPAPBA0t8jWpV4yjJe9OEzgKjlPRru2Htrfsp90hflOdyIKq697o0RCSDodNopSNqNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711377509; c=relaxed/simple;
	bh=Ckca2N9m0ahjegAreV5WnqCxxSRm3G5AE9yrUUmr61A=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RSfzlf24lgnXK30x7n5/0/i3/l5tvPK+bObAdzTXy1LGyB6qcYB/zadu32QUEHCz8DpezJxTXBHv34yCdaDFjCldXfSRCAh40gnGsbI66h1wWIRhrnbclqfiE3uM0Sja936POVcvZT562mP4Uwgw6VSETbQ/vFknwFwz+CvvWso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V3Fmm0GCCz6K9Tn;
	Mon, 25 Mar 2024 22:34:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 55533140B39;
	Mon, 25 Mar 2024 22:38:24 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 25 Mar
 2024 14:38:23 +0000
Date: Mon, 25 Mar 2024 14:38:22 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Andrej Picej <andrej.picej@norik.com>, <haibo.chen@nxp.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<jic23@kernel.org>, <lars@metafoo.de>, <shawnguo@kernel.org>,
	<s.hauer@pengutronix.de>, <kernel@pengutronix.de>, <festevam@gmail.com>,
	<imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <robh@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<upstream@lists.phytec.de>
Subject: Re: [PATCH 2/2] dt-bindings: iio: adc: nxp,imx93-adc.yaml: Add
 calibration properties
Message-ID: <20240325143822.000060db@Huawei.com>
In-Reply-To: <178594a2-cd5f-4608-aae6-7d68fd0817e0@linaro.org>
References: <20240320100407.1639082-1-andrej.picej@norik.com>
	<20240320100407.1639082-3-andrej.picej@norik.com>
	<38637621-1611-4268-ae79-7ac93a72c5ee@linaro.org>
	<e994b756-7f4e-4be3-b8f3-310988174b44@norik.com>
	<7e58bf96-3c38-467f-86b6-06ff5feedb31@linaro.org>
	<40e08a5e-e7e9-47c7-9102-24a2bbba67cf@norik.com>
	<a1b173c0-5120-40f6-9708-cd810b4a2406@linaro.org>
	<1bbd4fdf-59c5-42b2-8698-95f402645c67@norik.com>
	<178594a2-cd5f-4608-aae6-7d68fd0817e0@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 25 Mar 2024 10:58:51 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 22/03/2024 10:58, Andrej Picej wrote:
> > On 22. 03. 24 09:14, Krzysztof Kozlowski wrote:  
> >> On 22/03/2024 08:39, Andrej Picej wrote:  
> >>> On 20. 03. 24 13:15, Krzysztof Kozlowski wrote:  
> >>>> On 20/03/2024 13:05, Andrej Picej wrote:  
> >>>>> Hi Krzysztof,
> >>>>>
> >>>>> On 20. 03. 24 11:26, Krzysztof Kozlowski wrote:  
> >>>>>> On 20/03/2024 11:04, Andrej Picej wrote:  
> >>>>>>> Document calibration properties and how to set them.  
> >>>>>>
> >>>>>> Bindings are before users.  
> >>>>>
> >>>>> will change patch order when I send a v2.
> >>>>>  
> >>>>>>
> >>>>>> Please use subject prefixes matching the subsystem. You can get them for
> >>>>>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> >>>>>> your patch is touching.
> >>>>>> There is no file extension in prefixes.  
> >>>>>
> >>>>> So: dt-bindings: iio/adc: nxp,imx93-adc: Add calibration properties?  
> >>>>
> >>>> Did you run the command I proposed? I don't see much of "/", but except
> >>>> that looks good.  
> >>>
> >>> Ok noted.
> >>>  
> >>>>  
> >>>>>  
> >>>>>>  
> >>>>>>>
> >>>>>>> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> >>>>>>> ---
> >>>>>>>     .../bindings/iio/adc/nxp,imx93-adc.yaml           | 15 +++++++++++++++
> >>>>>>>     1 file changed, 15 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> >>>>>>> index dacc526dc695..64958be62a6a 100644
> >>>>>>> --- a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> >>>>>>> +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> >>>>>>> @@ -46,6 +46,21 @@ properties:
> >>>>>>>       "#io-channel-cells":
> >>>>>>>         const: 1
> >>>>>>>     
> >>>>>>> +  nxp,calib-avg-en:
> >>>>>>> +    description:
> >>>>>>> +      Enable or disable averaging of calibration time.
> >>>>>>> +    enum: [ 0, 1 ]
> >>>>>>> +
> >>>>>>> +  nxp,calib-nr-samples:
> >>>>>>> +    description:
> >>>>>>> +      Selects the number of averaging samples to be used during calibration.
> >>>>>>> +    enum: [ 16, 32, 128, 512 ]
> >>>>>>> +
> >>>>>>> +  nxp,calib-t-samples:
> >>>>>>> +    description:
> >>>>>>> +      Specifies the sample time of calibration conversions.
> >>>>>>> +    enum: [ 8, 16, 22, 32 ]  
> >>>>>>
> >>>>>> No, use existing, generic properties. Open other bindings for this.  
> >>>>>
> >>>>> You mean I should use generic properties for the ADC calibration
> >>>>> settings? Is there already something in place? Because as I understand
> >>>>> it, these calib-* values only effect the calibration process of the ADC.  
> >>>>
> >>>> Please take a look at other devices and dtschema. We already have some
> >>>> properties for this... but maybe they cannot be used?
> >>>>  
> >>>
> >>> I did look into other ADC devices, grep across iio/adc, adc bindings
> >>> folders and couldn't find anything closely related to what we are
> >>> looking for. Could you please point me to the properties that you think
> >>> should be used for this?  
> >>
> >> Indeed, there are few device specific like qcom,avg-samples. We have
> >> though oversampling-ratio, settling-time-us and min-sample-time (which
> >> is not that good because does not use unit suffix).  
> > 
> > Ok, these are examples but I think I should not use them, since these 
> > are i.MX93 ADC specific settings, which are used for configuration of   
> 
> 
> No vendor prefix, so they rather should be generic, not imx93
> specific... But this the binding for imx93, so I don't understand your
> statement.

Based on my current understanding what we have here is not remotely
generic, so standard properties don't make sense (though naming the
nxp ones in a consistent fashion with other bindings is useful)

I'm not entirely convinced there is a strong argument to support them at all
though.  Still thinking / gathering info on that.

> 
> > calibration process, and are not related to the standard conversion 
> > process during runtime. Calibration process is the first step that 
> > should be done after every power-on reset.
> >   
> >>
> >> Then follow up questions:
> >>   - nxp,calib-avg-en: Why is it a board-level decision? I would assume
> >> this depends on user choice and what kind of input you have (which could
> >> be board dependent or could be runtime decision).  
> > 
> > Not really sure I get your question, so please elaborate if I missed the 
> > point.
> > This is a user choice, to enable or disable the averaging function in 
> > calibration, but this is a board-level decision, probably relates on 
> > external ADC regulators and input connections. The same options are used 
> > for every ADC channel and this can not be a runtime decision, since 
> > calibration is done before the ADC is even registered.  
> 
> You now mix how Linux driver behaves with hardware. Why you cannot
> recalibrate later, e.g. when something else is being connected to the
> exposed pins?

Generally we don't make strong efforts to support dev board use cases where
the components wired tend to change.  So normally this isn't too much of
a concern.  Previously, we've tried to support this stuff and it always
ends up as a mess because of the crazy range of things that can be wired.

Jonathan

> 
> Best regards,
> Krzysztof
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



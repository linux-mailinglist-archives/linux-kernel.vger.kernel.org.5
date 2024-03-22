Return-Path: <linux-kernel+bounces-111774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921DA8870D0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF0731C22EC6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A7C5674C;
	Fri, 22 Mar 2024 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W3V1cRet"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522524F60D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711124777; cv=none; b=EnLjyfcZJdp/CQc7DwGHfUc0lPATddA25HgJLY6cpg8/UYunZfSqRAan+9CxuP4F2J5U+2wgJ+aqLrWYC4mqrB4Q2Uigd5mqKTvAC7OjdZcAiFUHuIi/W9aJWjri1oTPEjeZhZxIneGCQ+d/8Uub6m05JgVyYTRhKGsmpp0yEY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711124777; c=relaxed/simple;
	bh=HOkr8Hoor9LWrctKOQzP7fj5wIdq4ZleDhqNpY3eCFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6lV5KEG94XssEYTnmuAKtthz8olibpI81kGTEMnf5NCzFCDWQ6rZkGS+i8E1+5cnnXm+SelYHfMuSFQoyKTGBi5Opra25JeNkwtLbw+Y7jg/PFxMXChhTKxqbjuZE6RYRRarVrnHukPXzGMLY9v/tX55kUxZfShxeNw0QqmwQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W3V1cRet; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bcb82d05-3c8f-40f4-a8d3-a0d7c17497b3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711124774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/6J+YbEX3EYv+o0oRRUc2f+RR8PKsdbh2rDoDRf+CQ=;
	b=W3V1cRetDjH+QZIfP4YR4L6tc6g5V3rgUlEvOaJraPy1aw5TxWHFAm76DXOEaXXhFcDmRO
	/A8RFQT2CcLz+uR6kYkPmm9mRm2eUeXxXManLt/BUgoFyzoQVys+3F5xw6hW2idomfhSEl
	z0QwYPUnTiKYqSmUGTO8tb68riCfcj0=
Date: Fri, 22 Mar 2024 12:26:10 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: Remove fsl,t1023-sfp in favor of
 fsl,layerscape-sfp
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Conor Dooley <conor@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Richard Alpe <richard@bit42.se>, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Michael Walle <michael@walle.cc>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20240316002026.1808336-1-sean.anderson@linux.dev>
 <20240317-starved-pager-7a81c5045cfc@spud>
 <9daf9c8f-6606-4ff6-8065-6a32fa0d152c@linux.dev>
 <20240318-scarf-startup-64088b1d8d35@spud>
 <fa047914-da03-4234-b48f-eebdf350795e@linux.dev>
 <20240319-fondling-implode-322a9cb570b8@spud>
 <d947cb15-aafc-487e-8bbd-54d786683470@linux.dev>
 <024ca6eb-c3d8-4764-946e-1070d1bfb806@linaro.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <024ca6eb-c3d8-4764-946e-1070d1bfb806@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/22/24 03:01, Krzysztof Kozlowski wrote:
> On 21/03/2024 17:21, Sean Anderson wrote:
>> On 3/19/24 13:55, Conor Dooley wrote:
>>> On Mon, Mar 18, 2024 at 11:48:06AM -0400, Sean Anderson wrote:
>>>> On 3/18/24 11:40, Conor Dooley wrote:
>>>>> On Mon, Mar 18, 2024 at 11:08:00AM -0400, Sean Anderson wrote:
>>>>>> On 3/17/24 11:10, Conor Dooley wrote:
>>>>>
>>>>>>> Additionally, should
>>>>>>> they fall back to t1023-sfp? I see that there's already some dts files
>>>>>>> with these compatibles in them but seemingly no driver support as there
>>>>>>> is for the t1023-sfp.
>>>>>>
>>>>>> I checked the reference manuals for these processors, and all of them use TA 2.0.
>>>>>
>>>>> Sounds like a fallback is suitable then, although that will require
>>>>> updating the various dts files.
>>>>
>>>> Yes, a fallback (like what is done for the T-series) would be suitable,
>>>> but given that these devicetrees have been in-tree for eight years I
>>>> think it would be preferable to support the existing bindings for
>>>> compatibility purposes.
>>>
>>> Just cos stuff snuck into the tree in dts files doesn't make it right
>>> though, I'd rather the bindings were done correctly. I don't care if you
>>> want to support all of the compatibles in the driver so that it works
>>> with the existing devicetrees though, as long as you mention the
>>> rationale in the commit message.
>> 
>> It doesn't really matter what the schema has as long as the driver supports
>> existing device trees.
> 
> We do not talk about driver now but bindings. You add new compatibles on
> a basis that they were already used. This cannot bypass regular review
> comments, so if during regular review process we would require
> fallbacks, then you are expected to listen to review also when
> documenting existing compatibles. Otherwise everyone would prefer to
> snuck in incorrect code and later document it "it was there!".

To be clear, the existing nodes look like

	sfp: sfp@e8000 {
		compatible = "fsl,t1040-sfp";
		reg	   = <0xe8000 0x1000>;
	};

which is perfectly serviceable for read-only use (as the clock is only
necessary for writing). As these devices are effectively identical, the
compatible could also look like what the P-series has:

	sfp: sfp@e8000 {
		compatible = "fsl,p2041-sfp", "fsl,qoriq-sfp-1.0";
		reg	   = <0xe8000 0x1000>;
	};

but in either case, it is desirable for the driver to match based on the
more-specific compatible (as well as the less-specific compatible) as we
already have enough information from the more-specific compatible to
select the correct implementation.

--Sean


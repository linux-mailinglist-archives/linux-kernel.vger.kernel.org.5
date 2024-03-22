Return-Path: <linux-kernel+bounces-111941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D33688730B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014A61F24C80
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEE9664CD;
	Fri, 22 Mar 2024 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X6Rt1uD2"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4C0664AB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 18:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711132010; cv=none; b=ny1l2oXYC+xGE66FxnuQsnkTGKeCnjkrjWRp+m6yCu7O+PcZidxOD0bs798r2yi7Rie+eRVfm6QdEuN5OIw2WkILavB1yypfMKz5N5+anYorUKHZzf8HFTa6AHPQHEYs+IuSys2mlgSDJaB9OFAHY44itNUnqNwYMhkY8Fv4Vm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711132010; c=relaxed/simple;
	bh=ds2S8oOKPKbGJmOdmZIoArNZdXGmWgdMjim+3ig9zKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HKpH/9gJTepeVUa45a9TYSbG1w/WQSjGJ+6IUff8s3otsTsVKTNG9w4oaT1qFUpdQ5iEUCQEobWC7Tu1n2wXNJAth726l3Pj1Rg4qQc3foN0Mrz64ktzGeugkE7ke4MYx46CVFDkJk/VNw9d9kc1FGy2SwjTyVSHZcLRO9aaipc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X6Rt1uD2; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <068e2d29-f820-4727-a30f-60a5e9b3ee34@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711132006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jokNWs2/mLKgEghEqADBe3CIPJFKxT3p38VqRMGN0UI=;
	b=X6Rt1uD2Ir2SJnu1SfrrOb6yVHnV8/W/JZXwk0xMF0oskz9xO1j/xTW3fyVlRC4uqafktP
	2TiDlfu8X1LXLh2fTZMCTmUg0/3ZeDpKfooUjJKOhzUo6J7IzQcMVI9qGKTrXo0gLcBRgh
	dbdKPlS26GETvnWy19oDUVClhGhu1I8=
Date: Fri, 22 Mar 2024 14:26:42 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: Remove fsl,t1023-sfp in favor of
 fsl,layerscape-sfp
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
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
 <bcb82d05-3c8f-40f4-a8d3-a0d7c17497b3@linux.dev>
 <20240322-stool-hardwired-036a30767775@spud>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240322-stool-hardwired-036a30767775@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/22/24 14:14, Conor Dooley wrote:
> On Fri, Mar 22, 2024 at 12:26:10PM -0400, Sean Anderson wrote:
>> On 3/22/24 03:01, Krzysztof Kozlowski wrote:
>> > On 21/03/2024 17:21, Sean Anderson wrote:
>> >> On 3/19/24 13:55, Conor Dooley wrote:
>> >>> On Mon, Mar 18, 2024 at 11:48:06AM -0400, Sean Anderson wrote:
>> >>>> On 3/18/24 11:40, Conor Dooley wrote:
>> >>>>> On Mon, Mar 18, 2024 at 11:08:00AM -0400, Sean Anderson wrote:
>> >>>>>> On 3/17/24 11:10, Conor Dooley wrote:
>> >>>>>
>> >>>>>>> Additionally, should
>> >>>>>>> they fall back to t1023-sfp? I see that there's already some dts files
>> >>>>>>> with these compatibles in them but seemingly no driver support as there
>> >>>>>>> is for the t1023-sfp.
>> >>>>>>
>> >>>>>> I checked the reference manuals for these processors, and all of them use TA 2.0.
>> >>>>>
>> >>>>> Sounds like a fallback is suitable then, although that will require
>> >>>>> updating the various dts files.
>> >>>>
>> >>>> Yes, a fallback (like what is done for the T-series) would be suitable,
>> >>>> but given that these devicetrees have been in-tree for eight years I
>> >>>> think it would be preferable to support the existing bindings for
>> >>>> compatibility purposes.
>> >>>
>> >>> Just cos stuff snuck into the tree in dts files doesn't make it right
>> >>> though, I'd rather the bindings were done correctly. I don't care if you
>> >>> want to support all of the compatibles in the driver so that it works
>> >>> with the existing devicetrees though, as long as you mention the
>> >>> rationale in the commit message.
>> >> 
>> >> It doesn't really matter what the schema has as long as the driver supports
>> >> existing device trees.
>> > 
>> > We do not talk about driver now but bindings. You add new compatibles on
>> > a basis that they were already used. This cannot bypass regular review
>> > comments, so if during regular review process we would require
>> > fallbacks, then you are expected to listen to review also when
>> > documenting existing compatibles. Otherwise everyone would prefer to
>> > snuck in incorrect code and later document it "it was there!".
>> 
>> To be clear, the existing nodes look like
>> 
>> 	sfp: sfp@e8000 {
>> 		compatible = "fsl,t1040-sfp";
>> 		reg	   = <0xe8000 0x1000>;
>> 	};
>> 
>> which is perfectly serviceable for read-only use (as the clock is only
>> necessary for writing). As these devices are effectively identical, the
>> compatible could also look like what the P-series has:
> 
> I'd rather you just picked the oldest device and used that as the
> fallback, rather than introducing an "<blah>-sfp-2.0" compatible.
> The 2.1 and 3.0 ones don't have anything like that.

Because of course no one looked around at the other SoCs and noticed
that they all have the same TA version and use the same document for
this device. I would rather use a common name based on the version,
rather than arbitrarily picking a SoC to be "compatible" with. This
doesn't make sense to me, since each SoC's reference manual just calls
out to the appropriate TA manual for all register definitions.

>> 	sfp: sfp@e8000 {
>> 		compatible = "fsl,p2041-sfp", "fsl,qoriq-sfp-1.0";
>> 		reg	   = <0xe8000 0x1000>;
>> 	};
> 
> None of the seem to be documented either btw:
> rg fsl,qoriq-sfp-1.0
> arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
> 371:		compatible = "fsl,p5020-sfp", "fsl,qoriq-sfp-1.0";
> 
> arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
> 339:		compatible = "fsl,p2041-sfp", "fsl,qoriq-sfp-1.0";
> 
> arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
> 386:		compatible = "fsl,p4080-sfp", "fsl,qoriq-sfp-1.0";
> 
> arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
> 366:		compatible = "fsl,p3041-sfp", "fsl,qoriq-sfp-1.0";
> 
> arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
> 331:		compatible = "fsl,p5040-sfp", "fsl,qoriq-sfp-1.0";

Yeah. As noted in the next patch, someone with access to the TA 1.0 manual
would need to have a look.

--Sean

>> 
>> but in either case, it is desirable for the driver to match based on the
>> more-specific compatible (as well as the less-specific compatible) as we
>> already have enough information from the more-specific compatible to
>> select the correct implementation.
>> 
>> --Sean


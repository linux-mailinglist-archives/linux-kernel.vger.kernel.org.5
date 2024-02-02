Return-Path: <linux-kernel+bounces-49924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7276D847190
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2A34B26407
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFEE7AE4C;
	Fri,  2 Feb 2024 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6sbOLVY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7051854;
	Fri,  2 Feb 2024 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706882387; cv=none; b=tyRLkrUiHuoC/TvyzyelZUgW5/gq0iy7dSSq4ILfz1SpC7PBDTostpzs2hmV3ehps96TUDDpofbVMXNGtVqqJF+Vhaxi5ysJvSabxJRUbuY4fSa22ZUNsdKruX2eEcRFhdmgQFyh4vk/eM/poJdMdL2A4bI4GFwqSJP3xoRWaXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706882387; c=relaxed/simple;
	bh=EB64KQbpT/2xM56Dg8Pe2KB+GNAGsTics4C0ytXX5Fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/u+ba4KTQJGMhPjpYplw38tHxww2EVFN/9koFBZDGH04c3a9iJ1weJt9G9MG5lHPE70uWyY9Kn2yExM7/plAKRRiCdr7r8rsoA/074JdnhvBZulT/rh+ah+xZmiDyce1wcG8mS80zBFHm0Io1ktKwHeml8pGuG3mwfouFEKGeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6sbOLVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A773C433C7;
	Fri,  2 Feb 2024 13:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706882386;
	bh=EB64KQbpT/2xM56Dg8Pe2KB+GNAGsTics4C0ytXX5Fc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D6sbOLVYcht0FrBhp4RV6bhFx2YABMg+XDciPluz+tJ/sIPAq2sZCn3CmlO5HSdV0
	 FaiVmlPYMj5zu85VHK/AfCXxLHz9iUHt1Y+8uHP7awvRejK+FfC4AfIAN6zLRFmAnz
	 FgcSVPhcO2I7AiFuRW36N0J2b6W0VUsVoftxffyuoqyEkZ+rrsHiCBa9wKbqOTVB2N
	 wE2j5pkJ507On8wLMAga8lQcfKPSogTZCYVAk6BdaWPaM6UhxiEFPGpk+3Q+IrfROU
	 /V7DEhge1yfWRvPbTdx5bQ7WNMqfukVrh4iRMaWZAHLkcFN8A/lMgTCr1nfU8GXjyV
	 DzdD++H7eIc+g==
Message-ID: <2dbbcc17-38e9-48b4-a0b1-450350644fb9@kernel.org>
Date: Fri, 2 Feb 2024 15:59:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] dt-bindings: usb/ti,am62-usb.yaml: Add PHY2
 register space
To: Nishanth Menon <nm@ti.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Conor Dooley
 <conor@kernel.org>, Bin Liu <b-liu@ti.com>, vigneshr@ti.com, afd@ti.com,
 kristo@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, srk@ti.com, r-gunasekaran@ti.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240201120332.4811-1-rogerq@kernel.org>
 <20240201120332.4811-5-rogerq@kernel.org>
 <20240201-viewpoint-upload-fb714f650ff5@spud>
 <20240201-violet-chalice-51a73f113e7b@spud>
 <20240201183522.ssj553rwefr2wuqi@iaqt7>
 <20240201-clad-unopposed-ccfdfe53b770@spud>
 <bc3ab60f-539b-41d0-8595-6e0b55f2763d@kernel.org>
 <20240202-unzip-whacky-bb2f151c618b@wendy>
 <dc3c93dc-74d9-4b1c-a771-3ee6f67b5dcc@kernel.org>
 <20240202121828.oo7grngyh2heqdxn@disposal>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240202121828.oo7grngyh2heqdxn@disposal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 02/02/2024 14:18, Nishanth Menon wrote:
> On 12:13-20240202, Roger Quadros wrote:
> [..]
>>>>
>>>> As DTS and driver will be merged by separate maintainers I thought it
>>>> would be easier for maintainers this way.
>>>
>>> dts and driver might be merged by different people, but dt-bindings and
>>> drivers are merged by the same people. This is a bindings patch, not a
>>
>> If we do that then I get a bunch of dtbs_check warnings
>>
>> dwc3-usb@f900000: reg: [[0, 261095424, 0, 2048], [0, 261128192, 0, 1024]] is too long
> 
> Just my 2 cents: If the binding (and driver) change was truly backward
> compatible (which it should be - for example: errata can only be
> applied if the second property is described), then you want to control
> that reg property to add minItems? - thatm I think will allow the dts
> change to come in at the next cycle once the binding has been merged.
> 

Thanks for the hint.
Please drop patches 4 and 5 in case you pick this series.

I'll send patch 4 along with the driver series v2.
Patch 5, I'll send after the DT binding has been merged.

-- 
cheers,
-roger


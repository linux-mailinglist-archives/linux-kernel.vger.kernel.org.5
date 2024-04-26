Return-Path: <linux-kernel+bounces-160160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6056D8B3A02
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83CED1C23E4A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA9E148848;
	Fri, 26 Apr 2024 14:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="wjQ6mG0y"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9232145B0F;
	Fri, 26 Apr 2024 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141764; cv=none; b=JOSX5qAjOWRvjl1chl6s6kW9k0KT+owN2jnThQyjVFT3jWjCdWP6F3HRzOcTMmp2txkAVPuTPcRBpNR3D27YiAzjCcpaLAp+TdGiK7aVTM9sB/disSwRAkvD534UBtlPUBZfoWcqJfaqGI35czL6N+SDPVekGsWvzHfrr4+2rNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141764; c=relaxed/simple;
	bh=Znb1xj0wp3j9wu2S5+km0Zr7gTv3WKNdqmf0fG5IRu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c3ggKsocyRlqbpbspI9G9lomc/BCw4p3nbmy6H5Kkx3zzsDTBy1q6ulVJyaDSPipwLvlLFxFsG+vPOb61fHPYAKW4m4ZYmS+osb4tf1S38Jk+osVSEYUj9z613pNd7biw/5iwOA5q0rmSmWNs/p3z/rlZVGJx2yBfCxprfR8OWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=wjQ6mG0y; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43QDIXEs017548;
	Fri, 26 Apr 2024 16:29:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=moqXTB1lv5GnDsCg4JCgVgGRj4Dtsh3+19cxb1K9VLU=; b=wj
	Q6mG0yMk0mpbsc57DiRqHjh3zMUBXwhAhlXzP+RS2uo7xqnd5duaHfBPnBn6Cgnz
	ZBfa4z4w90BzGbovCO67RPYWggMHi5OhM+2nS6y1dFDKnLyBH8BHJznndsa1IVho
	Vs2bnPamSybmhTWlaBfmtKz87wGsuuU9gAL62q0KlhbHWli7rY07Mgy1SwVAtzjr
	bd0MNwDDHPTUlKA2hxKD78S89ilQvRbxs8XOkA3yZlbMRe3vQWUVnAXiczqrHfmJ
	eH5XHeVLhxZdbu466gls1B6SYQPmHgEd4ZlsacUcSvKjt8fYAkLEt0aQCg6OQFv/
	Htj998zGCQZv4vZfVhvA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm4cntxpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 16:29:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 20BFD40044;
	Fri, 26 Apr 2024 16:28:57 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6450C223661;
	Fri, 26 Apr 2024 16:28:11 +0200 (CEST)
Received: from [10.48.86.112] (10.48.86.112) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 16:28:10 +0200
Message-ID: <574df1fe-7562-40a2-b7bf-7b4b5d3901ba@foss.st.com>
Date: Fri, 26 Apr 2024 16:28:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ARM: st: use a correct pwr compatible for stm32mp15
To: Rob Herring <robh@kernel.org>, Marek Vasut <marex@denx.de>
CC: Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Pascal Paillet
	<p.paillet@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20240425074835.760134-1-patrick.delaunay@foss.st.com>
 <20240425163035.GA2783061-robh@kernel.org>
 <28aeb8b1-72f1-4dd9-b433-f5b693150475@foss.st.com>
 <CAL_Jsq+KGd2tumATzhJu0aZDZ0C1k9VGm5_xxTiE1RE2KHs0hA@mail.gmail.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <CAL_Jsq+KGd2tumATzhJu0aZDZ0C1k9VGm5_xxTiE1RE2KHs0hA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02

Hi,

On 4/26/24 14:51, Rob Herring wrote:
> On Fri, Apr 26, 2024 at 6:42 AM Patrick DELAUNAY
> <patrick.delaunay@foss.st.com> wrote:
>> Hi,
>>
>> On 4/25/24 18:30, Rob Herring wrote:
>>> On Thu, Apr 25, 2024 at 09:48:31AM +0200, Patrick Delaunay wrote:
>>>> This patchset removes the unexpected comma in the PWR compatible
>>>> "st,stm32mp1,pwr-reg" and uses a new compatible "st,stm32mp1-pwr-reg"
>>>> in STM3MP15 device trees.
>>> Why? I don't see any warnings from this. Yes, we wouldn't new cases
>>> following this pattern, but I don't think it is worth maintaining
>>> support for both strings. We're stuck with it. And the only way to
>>> maintain forward compatibility is:
>>
>> Yes, no warning because the compatible string are not yet checked by tools.
> What do you mean? There's a schema for it, so it is checked. I ran the
> tools and there's no warning. If there was a warning, I'd fix the
> tools in this case.


Sorry, I am  no clear


the tools (dts check or check patch) don't check the recommendation for 
compatible name:

     vendor specific string in the form|<vendor>,[<device>-]<usage>|

|   => for me: compatible should have only one comma,
               used as separator between vendor prefix end the device 
identifier.|


But it is normal because existing device tree have a already lot a 
strange compatible


>> I propose this patch to avoid the usage of this compatible for other SoC
>> in STM32MP1 family.
>>
>>
>> I see the invalid compatible string when I reviewed the U-Boot patch to
>> add the PWR node for STM32MP13 family:
>>
>> https://patchwork.ozlabs.org/project/uboot/patch/20240319024534.103299-1-marex@denx.de/
>>
> Perhaps you should add SoC specific compatible string instead.


yes it is a solution.


>
>> So I prefer change the PWR binding before to have the same patch applied
>> on Linux device tree
>>
>>> compatible = "st,stm32mp1-pwr-reg", "st,stm32mp1,pwr-reg";
>>
>> Yes, I will update the SoC patch with you proposal.
> NO! We don't want to support that.


Even mark the old binding deprecated is not acceptable:

  properties:
    compatible:
-    const: st,stm32mp1,pwr-reg
+    oneOf:
+    - const: st,stm32mp1-pwr-reg
+    - items:
+      - const: st,stm32mp1-pwr-reg
+      - const: st,stm32mp1,pwr-reg
+      deprecated: true


I understood.


>
> We have *tons* of examples in DT which don't follow recommended
> patterns and we're stuck with them. This is no different. We can get
> away with changing node names, but that's about it.


Ok,  I am stucked with this compatible for STM32MP15 = "st,stm32mp1,pwr-reg"

and I have no elegant solution to solved it.

So I will change my serie to add a new compatible for STM32MP13

"st,stm32mp13-pwr-reg"


>
> Rob


Regards

Patrick



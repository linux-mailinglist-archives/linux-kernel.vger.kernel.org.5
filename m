Return-Path: <linux-kernel+bounces-158625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9AB8B2333
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7559287E8B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A0B149DE3;
	Thu, 25 Apr 2024 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Y0bJFXvP"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CDB1494D2;
	Thu, 25 Apr 2024 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053315; cv=none; b=MvOubfZ4ti/3vNix/Z8jVLmcTtk6rabBpSIlvQhSmx9KcGFu1tXAgAsqr8SdUmzebXGg2F4HIqtq8fBfbcLwqWJpLCNf+HkSS0df/YGgvboq1W6jJbpEv63keBdX761sZp3UA7qDEZNhydGWR+oi1SnmqvRPgJ6pRTfpkxEFkB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053315; c=relaxed/simple;
	bh=DMy17TiCyjh/k8annerxF/kUrrwnYDuM432VfQVIIjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LQ+IThiHKFW8c+dxSSR2dcrWqLCOk62ETxaBYRf/o2vwEEbi9JuLNXaO0F8jNRxpTNLxPT6rCjv21ge/8IafeTXLwJAI/kDG9wl26EfC36fkvesqy93tT3g9qRn8GjGdwFjZJ0+SDY2FOrATtFX9h+L4HRW0j3QXvZJIPXSv6RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Y0bJFXvP; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PDZjKu032412;
	Thu, 25 Apr 2024 15:54:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=qQMU7VYo5fU0zpRtzK2tuitYtZnTvgB4cuzbACisKiA=; b=Y0
	bJFXvPbZDB44bmNvch6hUZSAAQxVZkqpbz+emUz5lnClsGLFE648hfukePk/lD/D
	ufuLBuAAjfD70FvnIrTEBx4gK1PX3lpJq1u+vPGcQEXJoGbbDBRSGt/+3tF6LKsO
	Mq1kdAxih2o/FTgzZ5gDeKSgO2rH6ipw0vKOKGnLSrwZbbZXb88av6Uv2ZCTN3Oz
	w6skHbWWiVsIGiAn1Kblwnqj7c+azlTgKSt/Y6g/9GKm9sofl7Nl8PqfehxCXqiD
	VlekJ6Q2thdJ93XbyBYg0JdXaxRh2KE7mqlJa/sbMe1nLSbBqyvgBnWxhFdduXaC
	lGxChjD1bQyNqg3wHetw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xm4kbdmmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 15:54:50 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 83AD640044;
	Thu, 25 Apr 2024 15:54:46 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A6D00221E9F;
	Thu, 25 Apr 2024 15:54:08 +0200 (CEST)
Received: from [10.48.86.112] (10.48.86.112) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 15:54:08 +0200
Message-ID: <c5d14ef4-15a3-40f1-b9f8-780525b0b172@foss.st.com>
Date: Thu, 25 Apr 2024 15:54:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ARM: dts: st: update the pwr compatible for stm32mp15
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre TORGUE
	<alexandre.torgue@foss.st.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime
 Coquelin <mcoquelin.stm32@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20240425074835.760134-1-patrick.delaunay@foss.st.com>
 <20240425094829.3.I493dfe2bde7f40beb48455f8ff8368cc8a869cdc@changeid>
 <b4e60272-cd79-417a-9028-fee243951f4a@kernel.org>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <b4e60272-cd79-417a-9028-fee243951f4a@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_13,2024-04-25_01,2023-05-22_02

Hi,

On 4/25/24 10:57, Krzysztof Kozlowski wrote:
> On 25/04/2024 09:48, Patrick Delaunay wrote:
>> Remove the unexpected comma in the compatible "st,stm32mp1,pwr-reg",
>> and use the new supported compatible "st,stm32mp1-pwr-reg" in STM3MP15
>> SoC dtsi.
>>
>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> ---
>>
>>   arch/arm/boot/dts/st/stm32mp151.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> This will break the users and is not bisectable, so patch should wait at
> least one cycle. This will preserve bisectability, although users will
> be affected anyway.


Sorry, I didn't know this constraint

But Ok, I remove this patch in serie V2 and push it later.


>
> Best regards,
> Krzysztof

Regards,

Patrick



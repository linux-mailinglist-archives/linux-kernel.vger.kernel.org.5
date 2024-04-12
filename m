Return-Path: <linux-kernel+bounces-143401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B468A387B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 00:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B3C1F238D7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1851152199;
	Fri, 12 Apr 2024 22:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bBFi0XAo"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D852F875;
	Fri, 12 Apr 2024 22:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712960074; cv=none; b=H/kID1/HPvIZj1/lPCUH9aRfnjtCEkJ3k2qmsaz6vvAXhzjJZamCtKGgqBE7ip541jBop87OlYzEQUZ+aKvdXXTDzqFCSFKiMn+RK/mOZ5Dzm7kuTwLtQZCe47ucFJKRVsuEw8cc34BMFZWIx+eQDspbDE4BEWxqUnZx+xhZ2fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712960074; c=relaxed/simple;
	bh=wYrqOGaHhJ2z5wVykzgwDbPbPajqDJOi07eRV3dAuvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KROCMMey4u8Qe5BP6N8ukLxJXdhPC9T4PEDBCnUgECzJEn6xI+FT11yZiHF905vTHqcp/b3uf0iRXoziPCWzNe7ajXQchLieVgfEvydaPfdZmx059hO/E9cfa4v0cIFxwqzzXt3+x9HtZ/mYeaAq3ijtAQ0sVGVUF104a42U4lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bBFi0XAo; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43CMEJHA118643;
	Fri, 12 Apr 2024 17:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712960060;
	bh=hrXDtCd4vWLhLQlCzwqd4oSWxkE0UmSh7nZI+EHPgo8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=bBFi0XAox76/AdFQV0+UfX/jEzai3lns0ioo7Th74N4Ts5oH8+uBA6QuYgas/X7j9
	 hJhYS4ymUfZGI/fGQ2zTI3Yaj/7QrsOh+saYYugugQzvxRwQ5OVvbFL/jNl/PbpMzQ
	 4rdwgacW+WWeboZDDywqMxdsJ9MxQLHVQD/+tyE4=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43CMEJm6113495
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Apr 2024 17:14:19 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Apr 2024 17:14:19 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Apr 2024 17:14:19 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43CMEJhJ016222;
	Fri, 12 Apr 2024 17:14:19 -0500
Message-ID: <ea99f171-e15c-4b57-8db2-b144bb604152@ti.com>
Date: Fri, 12 Apr 2024 17:14:19 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] arm64: dts: ti: k3-am69-sk: Remove HS400 mode support
 for eMMC
To: "Kumar, Udit" <u-kumar1@ti.com>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bhavya Kapoor <b-kapoor@ti.com>,
        Dasnavis
 Sabiya <sabiya.d@ti.com>
References: <20240411225257.383889-1-jm@ti.com>
 <20240411225257.383889-7-jm@ti.com>
 <87a289ce-6260-4249-9829-0de189663532@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <87a289ce-6260-4249-9829-0de189663532@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On 4/11/24 11:53 PM, Kumar, Udit wrote:
> Hi Judith
> 
> On 4/12/2024 4:22 AM, Judith Mendez wrote:
>> From: Dasnavis Sabiya <sabiya.d@ti.com>
>>
>> The eMMC fails to enumerate intermittently on HS400 mode. Also
>> observing multiple CQE recovery warnings.
>> Update the sdhci0 node to disable HS400 and set HS200 mode for
>> eMMC node.
>>
>> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am69-sk.dts | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts 
>> b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
>> index 50de2a448a3a6..a677bb9200a35 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
>> @@ -906,6 +906,7 @@ &main_sdhci0 {
>>       non-removable;
>>       ti,driver-strength-ohm = <50>;
>>       disable-wp;
>> +    no-mmc-hs400;
> 
> 
> This is just WA to get rid of CQE errors. I prefer to hold this patch 
> under debug from hardware side is not complete.

ok, will drop this patch.

~ Judith

> 
>>   };
>>   &main_sdhci1 {



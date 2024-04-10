Return-Path: <linux-kernel+bounces-138454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AAF89F17D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D4E1C22B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B0615B143;
	Wed, 10 Apr 2024 11:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uB85bfI7"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306BD15ADB6;
	Wed, 10 Apr 2024 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712750044; cv=none; b=f2FEBgSJ6usAdACvBCVCoaJbVtYPInx8XxmlOmiJLBBbxItueYw9YfhSnVcEEayvyfO1gTnZT2KlThCc2DNbJi9j/TIXgT89JID0Vb8wBTfARMGZmxXymmTZs/H+q2OtvIVO3OQNzUP/fNB1rtX3pQQaO31jxAwGa+d3KkVykE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712750044; c=relaxed/simple;
	bh=6Jm7s4gyyTcXqJ/8roiVJygUnDsgGeCObFkYjHDxRTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JVxi/LcpUKtVlSKgrGG9x4uZh5mxIHwkIOdmsIR/s8/uIdyvYgc6YjcFRr19Yd0/D3dOEiw0psN+R7hPcghu4/t33xBSqMP5CYpcLJs8xQsutBoiU4kTf3iCwV2PivrekL/JcoN8vDRTXh7l6IUfVGoFaeuuPQJdfn7aIOkudKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uB85bfI7; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43ABrfNM114821;
	Wed, 10 Apr 2024 06:53:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712750021;
	bh=toSUfMcLv0WNCJ4zhPtky0YQxNctanvw3Avt3dfN2SM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=uB85bfI7c/baej7WPg8+D7dOQC2+yyeGWE+/HP5DuhDkdc1NbBOJ65QzOaKOl+OKh
	 uf0g8cpfoE3W6ygqNe27h2Sgok1DEEjVPrRbSG5IQBXFZrzuh96/9w4iX12Xexeb7q
	 SSMQlO2VUX4Kkmjr3hOpdjSHSTjdR5xKpDiwITQ4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43ABrfWN046566
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Apr 2024 06:53:41 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Apr 2024 06:53:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Apr 2024 06:53:41 -0500
Received: from [172.24.227.252] (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.252])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43ABrbQo097683;
	Wed, 10 Apr 2024 06:53:38 -0500
Message-ID: <66633020-8044-4493-90d4-5deb29abf899@ti.com>
Date: Wed, 10 Apr 2024 17:23:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-am62-main: Fix the reg-range for
 dma-controller
To: "Kumar, Udit" <u-kumar1@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <bb@ti.com>, <devicetree@vger.kernel.org>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20240405085208.32227-1-j-choudhary@ti.com>
 <20240405085208.32227-2-j-choudhary@ti.com>
 <b77128a1-8c61-49c2-81a4-c0811c5c8e3c@ti.com>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <b77128a1-8c61-49c2-81a4-c0811c5c8e3c@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Udit,

On 10/04/24 15:36, Kumar, Udit wrote:
> Thanks for this fix Jayesh
> 
> On 4/5/2024 2:22 PM, Jayesh Choudhary wrote:
>> The TX Channel Realtime Registers region 'tchanrt' is 128KB and Ring
>> Realtime Registers region 'ringrt' is 2MB as shown in memory map in
>> the TRM[0]. So fix ranges for those reg-regions.
> 
> Minor one, but it will be better to say that you are fixing these 
> register ranges for  PKTDMA .
> 
> Something like that

The cover-letter[0] for the series does mention that the changes are for
DMASS0_PKTDMA_RINGRT and DMASS0_PKTDMA_TCHANRT with the current and
correct region size.
It also mentions the section and the Table from where we can check them.
{*** section for Main Memory Map (Table 2-1)}

[0]: https://lore.kernel.org/all/20240405085208.32227-1-j-choudhary@ti.com/

It was same check across all platform so added in cover letter.
But I will add that in each patch.

Thanks,
Jayesh

> 
> For PKTDMA, The TX Channel Realtime Registers region 'tchanrt' ....
> 
> Also, it will help reviewer if you can mention which section in TRM[0], 
> holding memory map .
> 
> If you are doing v2 then please take care of above in commit message.
> 
> rest for whole series
> 
> LGTM
> 
> 
> 
>> [0]: <https://www.ti.com/lit/pdf/spruiv7>
>>
>> Fixes: c37c58fdeb8a ("arm64: dts: ti: k3-am62: Add more peripheral 
>> nodes")
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi 
>> b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>> index e9cffca073ef..e10cc9fc0b10 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>> @@ -141,8 +141,8 @@ main_pktdma: dma-controller@485c0000 {
>>               compatible = "ti,am64-dmss-pktdma";
>>               reg = <0x00 0x485c0000 0x00 0x100>,
>>                     <0x00 0x4a800000 0x00 0x20000>,
>> -                  <0x00 0x4aa00000 0x00 0x40000>,
>> -                  <0x00 0x4b800000 0x00 0x400000>,
>> +                  <0x00 0x4aa00000 0x00 0x20000>,
>> +                  <0x00 0x4b800000 0x00 0x200000>,
>>                     <0x00 0x485e0000 0x00 0x10000>,
>>                     <0x00 0x484a0000 0x00 0x2000>,
>>                     <0x00 0x484c0000 0x00 0x2000>,


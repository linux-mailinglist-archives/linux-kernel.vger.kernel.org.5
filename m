Return-Path: <linux-kernel+bounces-56080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BE984C5AD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1EE51F267D0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5C11F932;
	Wed,  7 Feb 2024 07:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="r4bMyD7h"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64905200A5;
	Wed,  7 Feb 2024 07:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707291230; cv=none; b=TgUHGAFYpaNpKJ0nu9Do79U3Db6OsqeT5A8JjSBLiXrzruhlGwdwaSvwuDrdZfvg1ManjavHbrFoHu6Kky2ezD6xPevIqSCHli0yOK9yMEW77RZnyktJGHrCk2v9LFQnOen315oOk7Q15aci9n96wh2NfCSnxzMnpEVlERokTVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707291230; c=relaxed/simple;
	bh=aZfN4QV0rZOj0bvHsJFso3C2R3aMKyl4nAbtlscjEh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T9QRUQ3jY/QMp79G+hLfR9wyVUj3FoP0v9jdFc/uN/dJ7bq30reJ84hZ2il6AKDj6CmBxXaCiMeJKtFeTSMmjwF7Ey8KNW3zGmnt0uh/La+4ru5/ZOFrbvDcbqJllufdVmTolN5Si/B/HJlNdekQYvzHSCVdsoMEFUbZz630+00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=r4bMyD7h; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4177XfkM025798;
	Wed, 7 Feb 2024 01:33:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707291222;
	bh=EsP92h4eePCBBGFxVwd5JKzsC3yXRN6xn1zJUGYuGNs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=r4bMyD7h0n2/aGVFBgm/hh+GYvf5x2hEh16sFPtQ43ZXp/gGgPm5T9/CY88xV/F06
	 OqqfRbq1mxVJD+PO1VXpRT3vZRBK2IGfoTN+6OZDv15ds17zKNSsGbwgerJJIEgzKh
	 WLudLT/xvq5CenVabjBH+PmApHGcpGfpSLGLyfVc=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4177Xf7j120092
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Feb 2024 01:33:41 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 01:33:41 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Feb 2024 01:33:41 -0600
Received: from [172.24.20.156] (lt5cd2489kgj.dhcp.ti.com [172.24.20.156])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4177Xbxn112299;
	Wed, 7 Feb 2024 01:33:38 -0600
Message-ID: <978c8110-3083-4fc2-a348-d7f97fd7839c@ti.com>
Date: Wed, 7 Feb 2024 13:03:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: keystone: sci-clk: Adding support for non
 contiguous clocks
To: CHANDRU DHAVAMANI <chandru@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
        Nishanth Menon <nm@ti.com>
CC: <kristo@kernel.org>, <ssantosh@kernel.org>, <rishabh@ti.com>,
        <vigneshr@ti.com>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
References: <20240206104357.3803517-1-u-kumar1@ti.com>
 <20240206131420.wtitflgav23jto2q@verbally>
 <871q9pzoiq.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
 <c5b6bd1d-dbb4-4bfb-8b3e-9b0733e2ba5d@ti.com>
 <c2b7f22d-f07d-4cac-8a01-af7b014e7ff4@ti.com>
 <a4fdbcfe-e0e0-4280-8638-e39b6b46778e@ti.com>
 <87ttmly4fa.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
 <e2ea03ce-0367-413b-aca9-7c1fabda173a@ti.com>
 <4398af20-3396-4a5c-8fcb-a7b3d0d6f15b@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <4398af20-3396-4a5c-8fcb-a7b3d0d6f15b@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 2/7/2024 12:53 PM, CHANDRU DHAVAMANI wrote:
>
> On 07/02/24 11:03, Kumar, Udit wrote:
>>
>> On 2/6/2024 9:24 PM, Kamlesh Gurudasani wrote:
>>> "Kumar, Udit" <u-kumar1@ti.com> writes:
>>>
>>>>>>>> get_freq is a bit expensive as it has to walk the clock tree to 
>>>>>>>> find
>>>>>>>> the clock frequency (at least the first time?). just wondering if
>>>>>>>> there is lighter alternative here?
>>>>>>>>
>>>>>>> How about get_clock? Doesn't read the registers at least.
>>>>>> Said API needs, some flags to be passed,
>>>>>>
>>>>>> Can those flag be set to zero, Chandru ?
>>>>>
>>>>> get_clock doesn't require any flags to be passed.
>>>>
>>>> May be firmware does not need it but  I was referring to
>>>>
>>>> https://elixir.bootlin.com/linux/latest/source/drivers/clk/keystone/sci-clk.c#L78 
>>>>
>>> Just took a look,
>>>
>>> I now understand the reason for confusion,
>>>
>>> #define TI_SCI_MSG_SET_CLOCK_STATE    0x0100
>>> #define TI_SCI_MSG_GET_CLOCK_STATE    0x0101
>>>
>>> cops->get_clock = ti_sci_cmd_get_clock;  --> refers to
>>> TI_SCI_MSG_SET_CLOCK_STATE
>>> That's why we are passing the flag from linux for get_clock
>>>
>>> Linux is using terminology of get/put.
>>>
>>> As Chandru pointed, we don't have to pass flags, cause he is refering
>>> to TI_SCI_MSG_GET_CLOCK_STATE
>>>
>>> Below functions passes TI_SCI_MSG_GET_CLOCK_STATE to DM, which is what
>>> we actually want.
>>> cops->is_auto = ti_sci_cmd_clk_is_auto;
>>> cops->is_on = ti_sci_cmd_clk_is_on;
>>> cops->is_off = ti_sci_cmd_clk_is_off;
>>
>>
>> I think calling ti_sci_cmd_clk_is_auto should be good . other 
>> functions needs current state and requested state.
>>
>> Chandru ?
>>
>
> ti_sci_cmd_clk_is_auto is internal function to linux.
> For TI_SCI_MSG_GET_CLOCK_STATE, linux only needs to pass pointers to 
> the variables where result will be stored.


Yes this internal function calls TI_SCI_MSG_GET_CLOCK_STATE


>
>
>>>
>>> Which should be safe to call, Chandru can confirm.
>>>
>>> Regards,
>>> Kamlesh
>>>>
>>>>
>>>>>
>>>>>>
>>>>>>> Regards,
>>>>>>> Kamlesh


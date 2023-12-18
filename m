Return-Path: <linux-kernel+bounces-4300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE6D817B22
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A201F1F228CF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2DC7146B;
	Mon, 18 Dec 2023 19:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uUJOg5b8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DADC3A1A2;
	Mon, 18 Dec 2023 19:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BIJfWZs081573;
	Mon, 18 Dec 2023 13:41:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1702928492;
	bh=E3j5o1r3WSzePVAnSx4kOs/CvdmQUVjtTNc59nKgzBs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=uUJOg5b81K27loH39xfCaJelvQNn3J7+0g9om4FEZ61JiabaoDaURgkcpEtyopk1J
	 5M1f5Wp7v2CTS+cElMttkDu8bavO0YgnqXesVyIjVwDLdfagIcrYJL58MvHBl8Rcw1
	 cfQwRPokjURtZg9rMOx3bRVuGFve+rBjOK9CeLNA=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BIJfWqY020295
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Dec 2023 13:41:32 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Dec 2023 13:41:32 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Dec 2023 13:41:32 -0600
Received: from [10.249.40.136] ([10.249.40.136])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BIJfVAw020221;
	Mon, 18 Dec 2023 13:41:31 -0600
Message-ID: <849f7785-547c-4add-8bfd-c04608b3fbab@ti.com>
Date: Mon, 18 Dec 2023 13:41:31 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] *** Add fixed-paritions to phyCORE-AM62x and
 phyCORE-AM64x ***
To: Nathan Morrisson <nmorrisson@phytec.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>,
        <w.egorov@phytec.de>
References: <20231215191838.1925082-1-nmorrisson@phytec.com>
 <9f86870c-88cc-43ea-800c-3a05482953aa@ti.com>
 <d03e3dfc-ba3c-4474-8094-94c5557021f2@phytec.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <d03e3dfc-ba3c-4474-8094-94c5557021f2@phytec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 12/18/23 12:47 PM, Nathan Morrisson wrote:
> Hi Andrew,
> 
> We are adding the nodes directly to the device tree to match what is done in other device trees, for example: k3-am642-tqma64xxl.dtsi. You are correct that this could be done by the bootloader instead though. Why do you prefer having the bootloader add the nodes?
> 

k3-am642-tqma64xxl.dtsi should be fixed, it slipped past me and
shouldn't be used as a reference.

The bootloader might not fill it out at all, what if we start
using the new MTD GPT partitions? Then the new bootloaders
will have to start *removing* these stale half-nodes.

If the bootloader is going to add fixed partitions it should do
the whole job. There is no good reason to have a half complete
nodes here.

Andrew

> Regards,
> 
> Nathan
> 
> On 12/15/23 11:20 AM, Andrew Davis wrote:
>> On 12/15/23 1:18 PM, Nathan Morrisson wrote:
>>> Add a fixed-partitions node to the NOR flash of the phyCORE-AM62x
>>> and phyCORE-AM64x to enable the bootloader to fixup the partitions
>>> during boot.
>>>
>>
>> Why can't your bootloader add these nodes?
>>
>> Andrew
>>
>>> Nathan Morrisson (2):
>>>    arm64: dts: ti: k3-am62-phycore-som: Add fixed-partitions to NOR Flash
>>>    arm64: dts: ti: k3-am64-phycore-som: Add fixed-partitions to NOR Flash
>>>
>>>   arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi | 6 ++++++
>>>   arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi | 6 ++++++
>>>   2 files changed, 12 insertions(+)
>>>


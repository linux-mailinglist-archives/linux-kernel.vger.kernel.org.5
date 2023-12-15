Return-Path: <linux-kernel+bounces-1562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1831281501D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3C01C20E35
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0C53FE4C;
	Fri, 15 Dec 2023 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vKEQjODL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F041D3FB28;
	Fri, 15 Dec 2023 19:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BFJKnqe076075;
	Fri, 15 Dec 2023 13:20:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1702668049;
	bh=DMBCzXBY9HuAfHqQLXzTJQotbZ2A6GYQ9pRv6JiqaFI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=vKEQjODL1QZ8b1efqbgbruae6Dk+Z9vVzC7kPiTlWarfI+k2hYHNevlesUMmi/Y7J
	 mc+gv34wL7+taOyWZyIspb8o8U4420LGpEQbT9XfPk7UmmpXPK1Yztm5WAO2I6fGlG
	 mi8y8lMRweuFoMrSJ72CpIfAexoDs94XeH09nXDQ=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BFJKnNL051594
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 15 Dec 2023 13:20:49 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 15
 Dec 2023 13:20:48 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 15 Dec 2023 13:20:48 -0600
Received: from [10.247.16.251] (ula0226330.dhcp.ti.com [10.247.16.251])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BFJKmnW006253;
	Fri, 15 Dec 2023 13:20:48 -0600
Message-ID: <9f86870c-88cc-43ea-800c-3a05482953aa@ti.com>
Date: Fri, 15 Dec 2023 13:20:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] *** Add fixed-paritions to phyCORE-AM62x and
 phyCORE-AM64x ***
Content-Language: en-US
To: Nathan Morrisson <nmorrisson@phytec.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>,
        <w.egorov@phytec.de>
References: <20231215191838.1925082-1-nmorrisson@phytec.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20231215191838.1925082-1-nmorrisson@phytec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 12/15/23 1:18 PM, Nathan Morrisson wrote:
> Add a fixed-partitions node to the NOR flash of the phyCORE-AM62x
> and phyCORE-AM64x to enable the bootloader to fixup the partitions
> during boot.
> 

Why can't your bootloader add these nodes?

Andrew

> Nathan Morrisson (2):
>    arm64: dts: ti: k3-am62-phycore-som: Add fixed-partitions to NOR Flash
>    arm64: dts: ti: k3-am64-phycore-som: Add fixed-partitions to NOR Flash
> 
>   arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi | 6 ++++++
>   arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi | 6 ++++++
>   2 files changed, 12 insertions(+)
> 


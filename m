Return-Path: <linux-kernel+bounces-20404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B02827E53
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 06:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12021F2463A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75E66124;
	Tue,  9 Jan 2024 05:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cLQ9ZsbL"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24E9184C;
	Tue,  9 Jan 2024 05:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4095NMDA052464;
	Mon, 8 Jan 2024 23:23:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704777802;
	bh=3iv2AViqY+U91e2xM/Gos4xw8jk8fs9OKf31pnj5adU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=cLQ9ZsbL6NXDrflfml0dnY270OdXgtucHYp69vh+vjvlVwZgML3G1+4mtV4Ezpcgg
	 iCdB00uJjrP9SKnkzXQJYDIGYDUessxFfNS379l8wmj9nZStUAfaS0fwm1faURIE4A
	 bkSuKqmv5uQHfHDnSUwMB8yZ+R0HbN2ivD5iXxTs=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4095NM9h054323
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 8 Jan 2024 23:23:22 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Jan 2024 23:23:21 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Jan 2024 23:23:21 -0600
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4095NHsl123518;
	Mon, 8 Jan 2024 23:23:18 -0600
Message-ID: <f7dd0868-1eda-4dff-9b9f-ae55f07c7d96@ti.com>
Date: Tue, 9 Jan 2024 10:53:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: dts: ti: k3-am642-evm: add ICSSG1 Ethernet
 support
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>,
        <afd@ti.com>
References: <20231212165832.3933335-1-danishanwar@ti.com>
 <20231212165832.3933335-3-danishanwar@ti.com>
 <1a2aba0c-5c4d-4258-b89c-b1be4593d7ff@lunn.ch>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <1a2aba0c-5c4d-4258-b89c-b1be4593d7ff@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew,

On 13/12/23 6:56 pm, Andrew Lunn wrote:
> On Tue, Dec 12, 2023 at 10:28:31PM +0530, MD Danish Anwar wrote:
>> ICSSG1 provides dual Gigabit Ethernet support with proper FW loaded.
>>
>> The ICSSG1 MII0 (RGMII1) has DP83869 PHY attached to it. The ICSSG1 shares
>> MII1 (RGMII2) PHY DP83869 with CPSW3g and it's assigned by default to
>> CPSW3g. The MDIO access to MII1 (RGMII2) PHY DP83869 is controlled by MDIO
>> bus switch and also assigned to CPSW3g. Therefore the ICSSG1 MII1 (RGMII2)
>> port is kept disable and ICSSG1 is enabled in single MAC mode by
>> default.
> 
> FYI
> 
> I want to review all this MII muxing, but it won't be today.

Did you get the chance to review this?

> 
>   Andrew

-- 
Thanks and Regards,
Danish


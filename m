Return-Path: <linux-kernel+bounces-24796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3E682C2AF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07566B2372E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFABE6EB58;
	Fri, 12 Jan 2024 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="deWubXWy"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955786DD1D;
	Fri, 12 Jan 2024 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40CFNbBg107397;
	Fri, 12 Jan 2024 09:23:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705073017;
	bh=rxeMIUBpYhhgJ+/7WsbHlekb5lAjPg91dYI2p3c+ziA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=deWubXWy4RWejcfMEyjIIK8VCN1I8lNQMT2aPX/z50PUJY8k2eO/opMTyfe88jeDX
	 cBAoV6xCRxbfFzlnpJAh0xNROGdc6ADdhMhNcCoPW+XjcxFDWYWPLhW9Pf/nSrX7HL
	 hhWWSR7gaGP3y/ToA7iVcUZT3pkxckaX8LEzcbRY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40CFNbPL049420
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 12 Jan 2024 09:23:37 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Jan 2024 09:23:37 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Jan 2024 09:23:37 -0600
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40CFNXtZ110652;
	Fri, 12 Jan 2024 09:23:34 -0600
Message-ID: <8dee1738-0bde-48fb-bd0e-b8d06b609677@ti.com>
Date: Fri, 12 Jan 2024 20:53:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: can: Add support for aliases in CAN
To: Marc Kleine-Budde <mkl@pengutronix.de>, Bhavya Kapoor <b-kapoor@ti.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-can@vger.kernel.org>, <mailhol.vincent@wanadoo.fr>,
        <rcsekar@samsung.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <wg@grandegger.com>,
        <vigneshr@ti.com>
References: <20240102102949.138607-1-b-kapoor@ti.com>
 <20240102-chop-extending-b7dc1acaf5db-mkl@pengutronix.de>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240102-chop-extending-b7dc1acaf5db-mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Marc

On 1/2/2024 4:43 PM, Marc Kleine-Budde wrote:
> On 02.01.2024 15:59:49, Bhavya Kapoor wrote:
>> When multiple CAN's are present, then names that are getting assigned
>> changes after every boot even after providing alias in the device tree.
>> Thus, Add support for implementing CAN aliasing so that names or
>> alias for CAN will now be provided from device tree.
> NACK, please use udev or systemd-networkd to provide stable names for
> CAN interfaces.

Would you like to re-consider this NACK.

 From kernel side,

IMO if aliasing is set in device tree then kernel should provide 
consistent baseline names.

However, distributions may choose different or other stable naming,

Also, if some distribution want to rely on kernel naming they still can do.

Thanks

>
> regards,
> Marc
>


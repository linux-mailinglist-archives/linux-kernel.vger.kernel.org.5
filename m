Return-Path: <linux-kernel+bounces-21098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A99E8289D4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A360DB23E2F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD4B3A1CA;
	Tue,  9 Jan 2024 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DCu/0Xjk"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7677A38DC1;
	Tue,  9 Jan 2024 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 409GEqUp101353;
	Tue, 9 Jan 2024 10:14:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704816892;
	bh=+s45SriCMFg4wyEvqkMYU7sO4P+s/YfoTTH1GytTXY0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=DCu/0XjkGzbx4AhW4Q1Bb3nB8rlACZEnZAY0Bpm2ojwjiUTg/cetEuTlDffhw56Yi
	 JHfZdc5IIQ5KXToNOXeS7i84Lh9OyN5sM8buQlmsnnC/JfTQnTg0SIHnUVI8RMvNlW
	 o8UI9tzB5evh4h7HsKJ+3yV2TT+cZ+pbdjn9SWKs=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 409GEqtO030730
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jan 2024 10:14:52 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jan 2024 10:14:52 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jan 2024 10:14:52 -0600
Received: from [10.249.40.136] ([10.249.40.136])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 409GEoPJ008319;
	Tue, 9 Jan 2024 10:14:50 -0600
Message-ID: <4cdd5c4a-f940-4635-837b-872ab776f5c4@ti.com>
Date: Tue, 9 Jan 2024 10:14:50 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 01/11] dt-bindings: gpu: Rename img,powervr to
 img,powervr-rogue
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Frank Binns
	<frank.binns@imgtec.com>,
        Donald Robson <donald.robson@imgtec.com>,
        Matt
 Coster <matt.coster@imgtec.com>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Adam Ford <aford173@gmail.com>,
        Ivaylo Dimitrov
	<ivo.g.dimitrov.75@gmail.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec
	<jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren
	<tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Paul Cercueil
	<paul@crapouillou.net>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-omap@vger.kernel.org>,
        <linux-mips@vger.kernel.org>
References: <20240108183302.255055-1-afd@ti.com>
 <20240108183302.255055-2-afd@ti.com>
 <c99b898f-61d2-46a3-b639-b4de828dcab1@linaro.org>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <c99b898f-61d2-46a3-b639-b4de828dcab1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/9/24 5:28 AM, Krzysztof Kozlowski wrote:
> On 08/01/2024 19:32, Andrew Davis wrote:
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   .../bindings/gpu/{img,powervr.yaml => img,powervr-rogue.yaml} | 4 ++--
>>   MAINTAINERS                                                   | 2 +-
>>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> If you are renaming it, why not renaming to match compatible as we
> usually expect?
> 

There are (or will be) multiple compatible strings described in this
file, naming the file after just one would not fully convey the content
of the file. This generic style naming seems common already for bindings
with multiple compatibles.

Andrew

> Best regards,
> Krzysztof
> 


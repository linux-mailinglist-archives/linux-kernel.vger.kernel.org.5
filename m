Return-Path: <linux-kernel+bounces-21317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC48828D7A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC141F25D1D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6793D3AE;
	Tue,  9 Jan 2024 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Yay6++ki"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724FF3D38F;
	Tue,  9 Jan 2024 19:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 409JX9Hh038984;
	Tue, 9 Jan 2024 13:33:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704828789;
	bh=BdEDKS8hhvM51dkV/2LyiEX6b3nmCoOluAwncBQuyoM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Yay6++kiwuufQCT4frGk2sl7wablzPORTN7i2S+J3fmg0/Nxwgh7CrGJ0bUF656Wx
	 Fig3Fauo/KMWEoApgn17VlxZKD2A9zm2pOAfT9fZkR1ev5p7aMesoQ/vnCV2GrhNwj
	 V6+kNI+zu+Lw7GnLX5qR82snObxy6VlciAlX0dS0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 409JX9ke102629
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jan 2024 13:33:09 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jan 2024 13:33:08 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jan 2024 13:33:08 -0600
Received: from [10.249.40.136] ([10.249.40.136])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 409JX7V1125021;
	Tue, 9 Jan 2024 13:33:07 -0600
Message-ID: <61b0c6c7-e5ad-4cbf-a020-230d96d43d3e@ti.com>
Date: Tue, 9 Jan 2024 13:33:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] dt-bindings: gpu: Rename img,powervr to
 img,powervr-rogue
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Frank Binns
	<frank.binns@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        "H . Nikolaus
 Schaller" <hns@goldelico.com>,
        Adam Ford <aford173@gmail.com>,
        Ivaylo
 Dimitrov <ivo.g.dimitrov.75@gmail.com>,
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
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-mips@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-sunxi@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>
References: <20240109171950.31010-1-afd@ti.com>
 <20240109171950.31010-2-afd@ti.com>
 <11e3afae-76a7-4ebb-82ac-3dca040710dc@linaro.org>
 <d0c242ef-bb8f-49d9-bbb0-7922db2c322a@ti.com>
 <d584255f-87ee-48a7-869d-e2a0b40a52b4@linaro.org>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <d584255f-87ee-48a7-869d-e2a0b40a52b4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/9/24 1:17 PM, Krzysztof Kozlowski wrote:
> On 09/01/2024 20:04, Andrew Davis wrote:
>> On 1/9/24 12:59 PM, Krzysztof Kozlowski wrote:
>>> On 09/01/2024 18:19, Andrew Davis wrote:
>>>> This binding will be used for GPUs starting from Series6 (Rogue)
>>>> and later. A different binding document will describe Series5.
>>>> With that the name "img,powervr" is too generic, rename to
>>>> "img,powervr-rogue" to avoid confusion.
>>>>
>>>> Suggested-by: Maxime Ripard <mripard@kernel.org>
>>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>>> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>>>> Reviewed-by: Frank Binns <frank.binns@imgtec.com>
>>>> ---
>>>
>>> Why do you send new version while we still talk about previous?
>>>
>>> Please implement feedback from v1 (and this is v2, so next is v3) or
>>> keep discussing.
>>>
>>
>> I agreed with everything you said in the last round (RFC v2) and
>> made all requested changes. Did I miss something in this version?
> 
> The recommendation is that naming of the file matches generic compatible
> and your file has only one generic compatible. Therefore I don't
> understand why you claimed there are multiple compatibles.
> 

I said "There are (or will be) multiple compatible strings", the rest
are on the way. So I didn't want to make this file less generic when
other bindings are almost ready.

Frank, can you help here, I'm assuming you have "img,img-bxs" and
"img,img-8xe" bindings staged for upstreaming somewhere; you'll be
putting those in this same file, right?

Thanks,
Andrew

> Best regards,
> Krzysztof
> 


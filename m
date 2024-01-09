Return-Path: <linux-kernel+bounces-21286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C1E828D16
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B42E2878A3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9E83D0BF;
	Tue,  9 Jan 2024 19:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RxznrmQs"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35953D0A0;
	Tue,  9 Jan 2024 19:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 409J4d0m002479;
	Tue, 9 Jan 2024 13:04:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704827079;
	bh=+qOjCNdwumi7M253pRJB5h08L5CsGro6RhONwxvXlD0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=RxznrmQsX8yQ1AC3oh7NhQTdnQ8dGYs8Yxu0PaLUiR4WxJ6TdQ7tZCS1kVZ1sRtyU
	 AtDN7dUm/U3ws3jf6EHZ/qVWccOFi548eRAOvItVtlml0sZxykxwSOtggSI/zuR/nZ
	 clvgtTbbXhJ6QRqD+eJ6T5GK3MsPSPXRgEcWrz/4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 409J4dA9080614
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jan 2024 13:04:39 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jan 2024 13:04:39 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jan 2024 13:04:39 -0600
Received: from [10.249.40.136] ([10.249.40.136])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 409J4bgA086396;
	Tue, 9 Jan 2024 13:04:38 -0600
Message-ID: <d0c242ef-bb8f-49d9-bbb0-7922db2c322a@ti.com>
Date: Tue, 9 Jan 2024 13:04:37 -0600
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
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <linux-omap@vger.kernel.org>,
        <linux-mips@vger.kernel.org>
References: <20240109171950.31010-1-afd@ti.com>
 <20240109171950.31010-2-afd@ti.com>
 <11e3afae-76a7-4ebb-82ac-3dca040710dc@linaro.org>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <11e3afae-76a7-4ebb-82ac-3dca040710dc@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/9/24 12:59 PM, Krzysztof Kozlowski wrote:
> On 09/01/2024 18:19, Andrew Davis wrote:
>> This binding will be used for GPUs starting from Series6 (Rogue)
>> and later. A different binding document will describe Series5.
>> With that the name "img,powervr" is too generic, rename to
>> "img,powervr-rogue" to avoid confusion.
>>
>> Suggested-by: Maxime Ripard <mripard@kernel.org>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>> Reviewed-by: Frank Binns <frank.binns@imgtec.com>
>> ---
> 
> Why do you send new version while we still talk about previous?
> 
> Please implement feedback from v1 (and this is v2, so next is v3) or
> keep discussing.
> 

I agreed with everything you said in the last round (RFC v2) and
made all requested changes. Did I miss something in this version?

Thanks,
Andrew

> Best regards,
> Krzysztof
> 


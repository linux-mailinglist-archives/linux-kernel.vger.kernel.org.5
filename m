Return-Path: <linux-kernel+bounces-86356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD7E86C455
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F9C1F21899
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C951D55C26;
	Thu, 29 Feb 2024 08:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="cP7n2UeD"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5634E5674B;
	Thu, 29 Feb 2024 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196985; cv=none; b=QOCMeKnY+BI0EtGUom+Ggz9usEESXmAsKgyo/GtGMoXhDKUKTcQjK8GJbp6MjV8dg8rumjmAVmbeHMw8vs00fci4bQU77172ol61ZSXOHhIAhk3gW4kpfvcm/i6T7+7STEJ6mrpOeuz7EuZeDW7W3qRs4B7R4ajD3Qbs4w2C6Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196985; c=relaxed/simple;
	bh=aVkoHTk2ntu7MHr+KHAJ6yTHS1E2hTdndDgB9eicr/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Jq4aOXEx+Zj7aebKVGFrxw7a6rbhV/i8twxXBZLewHRLhc/4d4nJtUjRFMHezapofDs/lxk79fBZPsJTO+kxK0JfsdLAJGubd+jW3lQeF2owPFt225KSOiP6MRxLs8AcXlwhy2zW1Jl6kTH8M5y4AHegNs+pE2JGox87j9mOwHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=cP7n2UeD; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41T4cbCP014616;
	Thu, 29 Feb 2024 09:55:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=PRClVcFO7m3xuOH5U/cKOHOTQgP4AbIEED6u8ca7mZQ=; b=cP
	7n2UeD+dqWjp2VgHFeaJV7rLqzqvAv/tCpec0uTogLLHJlLCXgW6l2qsPYBcgRPe
	yomymGQy1m8Uq4MwbLXz6IHX0L/PxPqjjKIQ2f71PrrnbCYcs/FFetp1gcfE254D
	SAbww/pouzlgpYMf7G+Org7WIoB8HMQTwl+IKg8dNRY0/x0Q0LsNFIbtNbMLOfXH
	9+iUCSEwSMV0dmt81O9mJvGbcwgYuV8JU2G4Fm21Ty8rsf1Ch0GDRbPKsz9FERgD
	hAB6Wm/LO7QQCDJCRsE9rd898qoCf/k4wxgi4YFoVRf6Odz9JYD/cGiA/KxlEZcF
	LLidL0NXM3ENveByDsTg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3whf4bh934-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Feb 2024 09:55:52 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 056F840049;
	Thu, 29 Feb 2024 09:55:41 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ADD16249A2D;
	Thu, 29 Feb 2024 09:54:20 +0100 (CET)
Received: from [10.201.21.122] (10.201.21.122) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 29 Feb
 2024 09:54:19 +0100
Message-ID: <fe3b18a0-c25f-4c81-ba2f-f6daf5eca087@foss.st.com>
Date: Thu, 29 Feb 2024 09:54:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [drm-drm-misc:drm-misc-next v2] dt-bindings: nt35510: document
 'port' property
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, <heiko@sntech.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC: Conor Dooley <conor@kernel.org>, <linux-kernel@vger.kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie
	<airlied@gmail.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil
 Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, <devicetree@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
References: <20240131092852.643844-1-dario.binacchi@amarulasolutions.com>
 <20240131-gap-making-59055befaf04@spud>
 <494b51fa-0f0e-4c1b-add3-73b5fe0b3c29@foss.st.com>
 <CABGWkvr8RQrUf0Uc+e83qDgqmzUT7OBcS4EDr2DFQnavfRTRDQ@mail.gmail.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <CABGWkvr8RQrUf0Uc+e83qDgqmzUT7OBcS4EDr2DFQnavfRTRDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_01,2024-02-27_01,2023-05-22_02

Hi

On 2/25/24 10:01, Dario Binacchi wrote:
> Hi,
> 
> On Wed, Feb 14, 2024 at 10:47 AM Alexandre TORGUE
> <alexandre.torgue@foss.st.com> wrote:
>>
>> Hi Heiko
>>
>> On 1/31/24 16:53, Conor Dooley wrote:
>>> On Wed, Jan 31, 2024 at 10:28:44AM +0100, Dario Binacchi wrote:
>>>> Allow 'port' property (coming from panel-common.yaml) to be used in DTS:
>>>>
>>>>     st/stm32f769-disco-mb1166-reva09.dtb: panel@0: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
>>>>
>>>> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>>>> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
>>>
>>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>>>
>>>
>>>>
>>>> ---
>>>>
>>>> Changes in v2:
>>>> - Rework the patch to drop errors found by command
>>>>     'make DT_CHECKER_FLAGS=-m dt_binding_check'.
>>>>
>>>>    .../devicetree/bindings/display/panel/novatek,nt35510.yaml       | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml
>>>> index a4afaff483b7..91921f4b0e5f 100644
>>>> --- a/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml
>>>> +++ b/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml
>>>> @@ -31,6 +31,7 @@ properties:
>>>>      vddi-supply:
>>>>        description: regulator that supplies the vddi voltage
>>>>      backlight: true
>>>> +  port: true
>>>>
>>>>    required:
>>>>      - compatible
>>>> --
>>>> 2.43.0
>>>>
>>
>> Do you plan to take this patch in drm-misc next branch ? As I have a
>> dependency with it to merge a DT patch I can take in my tree
>> (stm32-next) if you prefer. Let me know.
>>
>> Cheers
>> Alex
> 
> It's been some weeks, so a gentle ping seems in order :)

Applied on stm32-next.

Thanks
Alex


> 
> Thanks and regards,
> Dario
> 


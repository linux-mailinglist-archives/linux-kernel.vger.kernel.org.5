Return-Path: <linux-kernel+bounces-120717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E1E88DBF2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8537E1F2CC24
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF2E535A1;
	Wed, 27 Mar 2024 11:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XzKpiN29"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE8F381C7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711537465; cv=none; b=q9RkSfhY48/c60Exeyv8YfngNMF4oEKqSStC7M2NENeYRa4zaB49Me9uXa1Nst3Ym8uMxsnuO76aIuxrsIG7Lq5t09edmi9/UK4cvWR9B41tM73ZniLBXYWhO8j1UrumT/4EdIGKqp7E+iRYOkKQb/5lzTVqi2E4SH9MGzpoNy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711537465; c=relaxed/simple;
	bh=/SczowyxxvpDJ5ee5m18UEMjHGgSK1BcBvy5KMTHBvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BBZMXM+KF8jGOvZsapphMPfSpKT+3VzoLqPCC2qdoqfH9EADp1BIgmnQRwIgtSw8NT0QaZ3ELgkHiFg+KDKqAy0CC+q8WPA8sLDlsuo40KKQ/QjgpbmvIM+giIxhvZrXMNK62nga6An546OBtA9dOLO5MSw9vpJymj7BRfz34To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XzKpiN29; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d6fd3cfaa6so4670341fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 04:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711537462; x=1712142262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wUaMf1iP80xdDLh0OzXWHzyf7XtnHr+wu/kj3Mk1yrE=;
        b=XzKpiN29O2r1gk+3QCJC+JQKLE1Ea3sAlzQFQYzFKLQVtPUW+47rBqC0lpM+27wJvl
         9gcJv2q65G+BX2ccUcfa9yEkYbFZNb9F8ylNwr69uaw/wg5lcSJRR+TKIzO8mliZmtz3
         sOdMrlmNiFNj4RHK2ifl5opnFwi/QhGNIV9IMVlFV6letB05/Lam5KtSzwsbCDh6rHfg
         qFl+8AR7lALwQYzvmnZ4NB9EgAW/o6c3XP1sNdCxxrqxAdTQByYVxtJTK4SirVmuo6yW
         hYUVCUZYp8/2q/a6LK2H5/Aazo/xpvPjCTDExmuphWeQmjuQxiykGGwwf/y0QfX8LhPc
         Dzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711537462; x=1712142262;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wUaMf1iP80xdDLh0OzXWHzyf7XtnHr+wu/kj3Mk1yrE=;
        b=sUT5kbtmSlCc2xBLaKWkVm+ilbwzzuHnA6Wl2GPgaTrwxHWZtV6/Vhd+p60ImhzXwp
         j/kUzCDZTqY+0QeN9MW9rH7v1m6PSqSSW0W/EDD3Sg7ckI23hF46wefK9Q5d+smBe/T9
         U2PSjC26JGcp33cqASkstsfHCOQHeUVlX8CieSbxYXyvbMiSUSXFUrQZvk+31fIkv04G
         5keOFe5b5azmpST7oqZEtS5zzC38LsuxJvcBXAinOMIE3Vz6Ujry7MewwXtmdyXS0bXO
         1QI82sx8zfHRxYCTyacbTM8hzG9EzDFhg2WmiPEBQiwk0f7Wh8o5SgPMeNGLBvuCKcpY
         smug==
X-Gm-Message-State: AOJu0YwAefdU0XxgHyz+TLcXi/Hv+DeESG38HWHwUBY7gT1EjKGZsLS8
	TcXwp9mFg0cT9/1I58COeHLXBp35Q4vqlIPRy0YpeYaKHZHKqpCeDsw6mFKFGz0=
X-Google-Smtp-Source: AGHT+IHMtf/SNAeFSEBXCHSu4TonpIb/9voXFk6aDr1n/oHR7DVgJUncgnXqtT8og0LuvuP+YLOo9g==
X-Received: by 2002:a2e:82d7:0:b0:2d6:da72:b5e with SMTP id n23-20020a2e82d7000000b002d6da720b5emr2727732ljh.28.1711537461668;
        Wed, 27 Mar 2024 04:04:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0a5500b004140c161e8dsm1807115wmq.43.2024.03.27.04.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 04:04:21 -0700 (PDT)
Message-ID: <c59f2f33-ad6b-469d-96be-9345920370b4@linaro.org>
Date: Wed, 27 Mar 2024 12:04:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dt-bindings: power: Add mediatek larb definition
To: =?UTF-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= <Yu-chang.Lee@mediatek.com>,
 =?UTF-8?B?TWFuZHlKSCBMaXUgKOWKieS6uuWDlik=?= <MandyJH.Liu@mediatek.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 =?UTF-8?B?WGl1ZmVuZyBMaSAo5p2O56eA5bOwKQ==?= <Xiufeng.Li@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, =?UTF-8?B?RmFuIENoZW4gKOmZs+WHoSk=?=
 <fan.chen@mediatek.com>
References: <20240327055732.28198-1-yu-chang.lee@mediatek.com>
 <20240327055732.28198-3-yu-chang.lee@mediatek.com>
 <6dd9959e-f741-47af-b10a-1894f72ae78f@linaro.org>
 <c3ca3d90-898e-44b0-ad0f-dd78c09c5fcd@linaro.org>
 <f3eedfb3495bb9c28b5cbf466387c24822c5b6f6.camel@mediatek.com>
 <7ff9c4c7-3b56-4a5b-95b7-c37cbf8bcd6d@linaro.org>
 <b957b072d5d88ed315982e914a7f700e0ccafb83.camel@mediatek.com>
 <038ccb20-71cb-40d2-9720-ce1a0d3eac8c@linaro.org>
 <7f24ca2806a7199e4de6fad17b8dc1f127c82180.camel@mediatek.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <7f24ca2806a7199e4de6fad17b8dc1f127c82180.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/03/2024 11:56, Yu-chang Lee (李禹璋) wrote:
> On Wed, 2024-03-27 at 11:43 +0100, Krzysztof Kozlowski wrote:
>>  	 
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>  On 27/03/2024 11:39, Yu-chang Lee (李禹璋) wrote:
>>>>>>
>>>>> Hi,
>>>>>
>>>>> I will double check the format of yaml for the next version,
>> sorry
>>>> for
>>>>> inconvenience. But I did test it on mt8188 chromebook, the reason
>>>> why
>>>>
>>>> How do you test a binding on chromebook?
>>>>
>>>>> power domain need larb node is that when mtcmos power on, signal
>>>> glitch
>>>>> may produce. Power domain driver must reset larb when this happen
>>>> to 
>>>>> prevent dummy transaction on bus. That why I need larb node in
>> dts.
>>>>
>>>> No one talks here about larb node...
>>>
>>> Sorry, May you elaborate on what information I need to provide to
>> you
>>> or it is just a syntax problem I need to fix?
>>
>> Please explain the purpose of this property (how is it going to be
>> used by drivers)and what does it represent.
>>
> 
> It represent SMI LARB(Local ARBitration). In power domain driver when
> power on power domain, It need to reset LARB to prevent potential power
> glitch which may cause dummy transaction on bus. Without taking care of
> this issue it often leads to camera hang in stress test.

That sounds rather like missing resets... or something else connecting
these devices. Maybe the explanation is just imprecise...

Best regards,
Krzysztof



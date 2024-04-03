Return-Path: <linux-kernel+bounces-129346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE398968D4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90D681C21C7D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9B15B1E8;
	Wed,  3 Apr 2024 08:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DwZ3RkmU"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE9B6DCE3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133376; cv=none; b=BQy8wgnF78mAPcgZmBqEFrV58DwS8cQmA5FWU6AW/sgusV6ndnMNo6cJ6xsQhZbTiijJ6HTyYptigfqQhgCXTPSBYT0krCzsIkESYpcNhYLFIx4Zc5Ll4J7PD7+/qwzplvyVJm63lIGVhl7EXedFplE0FV9YpwrqkC5wEPL7jCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133376; c=relaxed/simple;
	bh=EugTqBg0dFxHDkBdwswn5IxyxqQxh3qQJGuQ1IoDt8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rzBklyvkHbTOpJ8h3Sbjo87Rf0+KeNBkS4/oO+wMdWMPnBejo/U9O+D87bzn5YwFAjTvFbapPyyGa3K3hFcpkcUpo9pFGK1ibo9VRrZ1Biuo2vSs0GCuTZn55miF4zwtx/Uc4j0X9Fm9OKdQFP+NEBqU9FfdrG1czUKAftHJZSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DwZ3RkmU; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4e60a64abcso110248466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 01:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712133372; x=1712738172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2DlE9sdE174jtHAbEEqp/3KgZCYrkauZb2b8kE3LRVc=;
        b=DwZ3RkmUzC4kYU7yLd3yYl6vBx0TlwRey4vIJNTL3h2IjJO9U0Zvk5EDQVjb1QI1AF
         kLvSUUBqrY/ZFcEtUKCX5qbBRrcGO42wMOU+Egy7K3ABIDalRjqJvjDlvb451gX2sKTf
         fVSpyxuY/kUQMYRd+dNf0B6+BP14a44affef49VPgT4ejZIaHOlLc5bnpLDEA68lBt9c
         0rV9Adw4pU8P85C/oVKX9qUHzKJizR4sC0YTsv32n1j/7UpVh3QisjXGbDoWdZhqoeQs
         O4UVaVFTvEKTqovT8x+zIH0Wz6tr0yaVzDRoQOQqnJxCCVn1nMtJKgN5kQyzkOA3GSPc
         8Lug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712133372; x=1712738172;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DlE9sdE174jtHAbEEqp/3KgZCYrkauZb2b8kE3LRVc=;
        b=pip5SKbTbcMlEmRz1IwhmEANCw54QEeNeVvPhBLodpvl0Y8j0HECmGNIIvBE6KPXeo
         APYio5w29UNAIOSVIZPPOyS/pbMsET6oZPCIO0tageTXxYIkUySSxf+UmltFLzN10U0H
         D5vnNXcJbfjd1NSQrqI+YYNsmclEaTE6EZAF6ABFcTNLXlDTAb/NohDV9VI30JNiXlh8
         U5aizNunVfDsSmyi3tdvLE1yIAbfW/BRVMCRjORo3vaY/klOqpxC2DsdwOFHXFz6jJS7
         vSVvpQq/2UJ6g8eHpPrAXTI2FfaKBwKnr9s6vwBlRJfSVo09T9GHgo8iXOAqEoCZH7nD
         GoJg==
X-Forwarded-Encrypted: i=1; AJvYcCWdEn9W4zLpCkl8b6QDCzqSUo+JHmZHV/0bUnO7KFlaHae8TmZ+qzHBWgJNddVle9oFJ3Ir6QaalucDSiHoHvZkmjsjE7GQpvAcfi5b
X-Gm-Message-State: AOJu0Yxt9C2zppQ/yzXCkn5snWNLRzAroGHTnE+luNrQ3Kpl6KiwRICY
	ctkcE7vXMo0nvXmVSB4r0OF6ffV2prAYENo1jsL3szm3griqdTeoJB6CjgoQ4Ao=
X-Google-Smtp-Source: AGHT+IEOD9nY8jBi39laMExK/xyCbXnh66JjnaAqLDdr9ArwjZEi3U2TPyBXhCjkky8SdMpOd526bQ==
X-Received: by 2002:a17:906:806:b0:a4e:405d:8e3d with SMTP id e6-20020a170906080600b00a4e405d8e3dmr1696475ejd.22.1712133372368;
        Wed, 03 Apr 2024 01:36:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id jt20-20020a170906ca1400b00a47439647efsm7452946ejb.133.2024.04.03.01.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 01:36:11 -0700 (PDT)
Message-ID: <368e9817-0000-4f69-9f09-568827466121@linaro.org>
Date: Wed, 3 Apr 2024 10:36:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: leds: add LED_FUNCTION_FNLOCK
To: Hans de Goede <hdegoede@redhat.com>, Gergo Koteles <soyer@irl.hu>,
 Ike Panhc <ike.pan@canonical.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1712063200.git.soyer@irl.hu>
 <8ac95e85a53dc0b8cce1e27fc1cab6d19221543b.1712063200.git.soyer@irl.hu>
 <6b47886e-09ac-4cb9-ab53-ca64f5320005@linaro.org>
 <39acb3b9-a69f-4654-9749-a9af42fea39e@redhat.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <39acb3b9-a69f-4654-9749-a9af42fea39e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/04/2024 10:31, Hans de Goede wrote:
> Hi Krzysztof,
> 
> On 4/2/24 3:55 PM, Krzysztof Kozlowski wrote:
>> On 02/04/2024 15:21, Gergo Koteles wrote:
>>> Newer laptops have FnLock LED.
>>>
>>> Add a define for this very common function.
>>>
>>> Signed-off-by: Gergo Koteles <soyer@irl.hu>
>>> ---
>>>  include/dt-bindings/leds/common.h | 1 +
>>
>> Do we really need to define all these possible LED functions? Please
>> link to DTS user for this.
> 
> It is useful to have well established names for common
> LED functions instead of having each driver come up
> with its own name with slightly different spelling
> for various fixed function LEDs.
> 
> This is even documented in:
> 
> Documentation/leds/leds-class.rst :
> 
> """
> LED Device Naming
> =================
> 
> Is currently of the form:
> 
>         "devicename:color:function"
> 
> ...
> 
> 
> - function:
>         one of LED_FUNCTION_* definitions from the header
>         include/dt-bindings/leds/common.h.
> """
> 
> Note this even specifies these definitions should go into
> include/dt-bindings/leds/common.h .
> 
> In this case there is no dts user (yet) only an in kernel
> driver which wants to use a LED_FUNCTION_* define to
> establish how to identify FN-lock LEDs going forward.

Ack, reasonable.

> 
> Since a lot of LED_FUNCTION_* defines happen to be used
> in dts files these happen to live under include/dt-bindings/
> but the dts files are not the only consumer of these defines (1).

Yes, but if there was no DTS consumer at all, then it is not a binding,
so it should not go to include/dt-bindings.

> 
> IMHO having a hard this must be used in a dts file rule
> is not helpful for these kinda files with defines shared
> between dts and non dts cases.
> 
> If we were to follow this logic then any addition to
> 
> include/uapi/linux/input-event-codes.h
> 
> must have a dts user before being approved too ? Since
> that file is included from include/dt-bindings/input/input.h ?

Wait, that's UAPI :) and we just share the constants. That's kind of
special case, but I get what you mean.

> 
> TL;DR: not only is this patch fine, this is actually
> the correct place to add such a define according to
> the docs in Documentation/leds/leds-class.rst :
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof



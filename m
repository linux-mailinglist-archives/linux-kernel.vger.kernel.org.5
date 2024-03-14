Return-Path: <linux-kernel+bounces-103051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597B087BA68
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E083B284051
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35B86CDC0;
	Thu, 14 Mar 2024 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pi7KCbCj"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63978EEC4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710408561; cv=none; b=ZUfJRD5FUhl6EUrMNwxhvpDYqozLcwduMN+J2Hovku/aOHb30fCZ6S2klu+WI4vdZ9FoIj8SG100mLUiuUgy8VtDZuOgYOQWJkcnwgXeH1SZI7IT3uiZJo5my6LYbnmgruLTu4Zn8tXPCHeD5oQDeKdP72iQWDESp0vguR3F9HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710408561; c=relaxed/simple;
	bh=L8+rKuW0TUaSjATe3UMHZdyq8FKWrVImRUolwSRExj0=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=Py3r1IEtHK5k4ltVokeQKjaEhH+onCDgTU5ysDXZQyAjvyeCa6m6bG5jF5s3KDklsl9MdIrZi8gmhQRz41T/ps4bWTNjEz9Kd1LGbNgp5HMsd3s3IaTV56gmSXWGagWC0Icz9eoMBcbC+CunG6ZVCHXeVkmyv+hhX3NgH7X+Q2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pi7KCbCj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-413f2f3e5b5so1729175e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 02:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710408557; x=1711013357; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=YVpA2JX+fzlp/qRr3hVbu2IFpulUsmSIfEJZSoktU3E=;
        b=pi7KCbCjN/+qfCALO71Gwwg/VMH86MqviELxLuV73FFEoYwLiU5mY3Ru/UN8Nrpbv9
         SiAJgK7PvYlJ/Nb6oDmBeCJY86CIQvuHC8X+dMoxNN+Tud4Z+1m0x4KXm1pfGoW6zhHB
         yoe8OYm76Mcuwwz8r8nrYnnabPtZ1QUWbY6IXwMhI53l8TUo0y3fo4JsIYbOwHWO9Dfn
         ikfoGNggrtlFEYiOVnIweJkMo6udjxH+V8kLkJs8R26aPV1KwAZ+1daVLELDcUb1PY2/
         zZ/B5/eaqfruUIggyUCHMux9zm1se/5PPb+z5K2MqumM+NWI3FhaR6w5zjELClWr5WUm
         GIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710408557; x=1711013357;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVpA2JX+fzlp/qRr3hVbu2IFpulUsmSIfEJZSoktU3E=;
        b=MdDihnN2HVfERFMA1ZvajHJIyoWVkHWkXrDxU2KCiKDNyNTmt45Phw/MMuvFmsICkR
         rjmh5+Td0LA1hAYzGo0g2hD1uoRh7JKGzaLvJptizYT7GRuWLwr8XP7GLL/cCuU2psfn
         TSYtwgzK3T88+52oVBVF7kjCIctfNdwK7O3ZBwtVFZopnRRZ4OW8lqA3djIYd2BAyAhn
         a2QtsWOUXknk9O5ot6iesCquUd9OovsAYQ1XFPocXIEydNxgkMYkqS+rR7yWCIplozfA
         NDEc3q1nQ4XyzRw6+2YxUcqweXEoaPt1Ed2RqSCkiiho7iCQoLTqyaIFp1rW6Ohn+2Kb
         Q9bA==
X-Forwarded-Encrypted: i=1; AJvYcCXqdk/WrQ16aRMLX050VcceU431BRjpNXqRx9sqOvjHKxzATZ+Mhegee+MZZUhzjq3yu7vCv9v3DOLILcP/HOU3uMmOzON17INTFA5O
X-Gm-Message-State: AOJu0YyFpexLKZyiyGaP+fGzj6NQwDRGpGm7/XysvWaRFbTfpWnZbGEv
	Q96/jjRWnpMflecXmLR/r+9rMnddcvQbZ+ujz8pMKkML9VAm+ynR6K7KRmE97J0=
X-Google-Smtp-Source: AGHT+IFhNZ2TtpDUXtz09eVcfKUHcjWWWpUtXTeEmJ8m3au/jqm3KhAMcAZOfzORToIXAGGCUCJhrw==
X-Received: by 2002:a05:600c:4fce:b0:413:2e2b:bad2 with SMTP id o14-20020a05600c4fce00b004132e2bbad2mr929596wmq.5.1710408556468;
        Thu, 14 Mar 2024 02:29:16 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:cd51:5f38:3a35:2e03])
        by smtp.gmail.com with ESMTPSA id r21-20020a05600c35d500b004126afe04f6sm5047088wmq.32.2024.03.14.02.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 02:29:16 -0700 (PDT)
References: <20240312-basic_dt-v1-0-7f11df3a0896@amlogic.com>
 <20240312-basic_dt-v1-3-7f11df3a0896@amlogic.com>
 <1jsf0vephv.fsf@starbuckisacylon.baylibre.com>
 <9a38fd52-5eea-468d-bd7c-29a505503268@amlogic.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Kevin Hilman
 <khilman@baylibre.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 3/4] arm64: dts: add support for A4 based Amlogic BA400
Date: Thu, 14 Mar 2024 10:26:26 +0100
In-reply-to: <9a38fd52-5eea-468d-bd7c-29a505503268@amlogic.com>
Message-ID: <1jcyrxi2l0.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Thu 14 Mar 2024 at 16:08, Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:

>>> +
>>> +#include "amlogic-a4.dtsi"
>> Could you describe how the a4 and a5 differs from each other ?
>> The description given in the commit description is the same.
>> Beside the a53 vs a55, I'm not seeing much of a difference.
>> Admittedly, there is not much yet but I wonder if a4 and a5 should have
>> a common dtsi.
>> 
> They are mostly the same, A5 include HiFi-DSP and NPU, but A4 is not. And
> some peripheral modules are different, such as SPI and Ehernet phy.
>
> I would like to wait for the follow-on chips to come out before considering
> a merger with common dtsi file.
>

No, Please do it now. There is no reason for the community to review the
same thing twice if the SoCs are "mostly the same".

>>> +
>>> +/ {
>>> +     model = "Amlogic A113L2 ba400 Development Board";
>>> +     compatible = "amlogic,ba400","amlogic,a4";
>>> +     interrupt-parent = <&gic>;
>>> +     #address-cells = <2>;
>>> +     #size-cells = <2>;
>>> +
>>> +     aliases {
>>> +             serial0 = &uart_b;
>>> +     };
>>> +
>>> +     memory@0 {
>>> +             device_type = "memory";
>>> +             reg = <0x0 0x0 0x0 0x40000000>;
>>> +     };
>>> +
>>> +     reserved-memory {
>>> +             #address-cells = <2>;
>>> +             #size-cells = <2>;
>>> +             ranges;
>>> +
>>> +             /* 52 MiB reserved for ARM Trusted Firmware */
>> That's a lot of memory to blindly reserve.
>> Any chance we can stop doing that and have u-boot amend reserved memory
>> zone based on the actual needs of the device ?
> Yes. U-boot will change size of reserved memory base on actual usage.

Then u-boot should add (not change) the memory if necessary.
Please drop this.

>> 
>>> +             secmon_reserved:linux,secmon {
>>> +                     compatible = "shared-dma-pool";
>>> +                     no-map;
>>> +                     alignment = <0x0 0x400000>;
>>> +                     reg = <0x0 0x05000000 0x0 0x3400000>;
>>> +             };
>>> +     };
>>> +};
>>> +



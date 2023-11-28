Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666797FB28E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343816AbjK1HTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343790AbjK1HTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:19:20 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26C9D45
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:19:25 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40b4a8db314so5108705e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1701155964; x=1701760764; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0O6zkzqcbMXlk51y4qrd5QMvvb/RA7s3YqrHm2H8b8s=;
        b=g07ucgNF2LPg6dltMpU375rif5bDG3ZExzY2cjdjiTWV81RIsfMliqyICRuenVzTUh
         wn/e3ZyRmb8i+q17MdQnTkThENDaO9WdJOqa+tA/gcffCL9rriCgnOp0SWEwc2ywIXtM
         usxiPKh69JpcZEYyoXXCgoZxLMAKwID+xUu/BV1sFUSJujKC1iHiqVuDlNEHUhnZVtTb
         hu4KwMYA6PTnfV2+tPQ3XjiOG0YYHf/KcSKg1VQsoo9jdk+RvKKYlhicCAtASjhW/WNI
         o/FE93WJ9T0MtmNjgfZLDsPzbY4zqkgBlfyZlGkyqW1FEgYbepp+h8D0ibLwcgjhYIoS
         H2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701155964; x=1701760764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0O6zkzqcbMXlk51y4qrd5QMvvb/RA7s3YqrHm2H8b8s=;
        b=b3t38OgR7bNaTSNf26CStgaOU88stNGgZ0+jFlSVmpCmHVeYAmA2un5F0PrwNyjGUl
         T87oJ7a6Ysopb0LZjlt9yIYgxe+Kvk0uPl7huCIUY1hKvr6OUzImyv+Ge1TKSaojEUxV
         pisCmdpkHmOE5+XajNMDp4hwJMt20bPAACh/mC6G1pULz7NqqGRgYGEkwmo83aJWq3Ux
         uRkre+fD0Nmn4bwum0kmNte7J2gMBl59dq+MO7IC7zAFrzzwQBXrbNQNmHnpzhuRsLcp
         +0kRmLO/GPJ5Wc4dAGRlst+z8G2SKJdheAEqKAyn52CMpigCr7yEVWiJkU0ydQKjnYN0
         Uf4g==
X-Gm-Message-State: AOJu0Yy7bN2j2R/mc4HzdXbk4CjT4dGFmYdaM1Ju2jfKz4e7U/vVz0ia
        7x2fEAqpepAKzUzM/PbmJVAKCA==
X-Google-Smtp-Source: AGHT+IF5taK0NZHqg4xe1+c8aXbHW/UIOdJy182/wWh13QjbphEIYyGBNwkaFNNSrctEIo5miCp7kg==
X-Received: by 2002:a05:600c:3b16:b0:40b:4007:11f1 with SMTP id m22-20020a05600c3b1600b0040b400711f1mr6444085wms.11.1701155964070;
        Mon, 27 Nov 2023 23:19:24 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.125])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b0040b3829eb50sm14869836wmo.20.2023.11.27.23.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 23:19:23 -0800 (PST)
Message-ID: <20811ebf-04e0-4196-9d0e-bd46a88065dd@tuxon.dev>
Date:   Tue, 28 Nov 2023 09:19:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] net: ravb: Check return value of
 reset_control_deassert()
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        richardcochran@gmail.com, p.zabel@pengutronix.de,
        yoshihiro.shimoda.uh@renesas.com, geert+renesas@glider.be,
        wsa+renesas@sang-engineering.com, robh@kernel.org,
        biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        mitsuhiro.kimura.kc@renesas.com, masaru.nagai.vx@renesas.com
Cc:     netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20231127090426.3761729-1-claudiu.beznea.uj@bp.renesas.com>
 <20231127090426.3761729-2-claudiu.beznea.uj@bp.renesas.com>
 <b23a5e0c-cc55-b7b2-a6dc-1eac0a674814@omp.ru>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <b23a5e0c-cc55-b7b2-a6dc-1eac0a674814@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.11.2023 18:39, Sergey Shtylyov wrote:
> On 11/27/23 12:04 PM, Claudiu wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> reset_control_deassert() could return an error. Some devices cannot work
>> if reset signal de-assert operation fails.
> 
>    Well, I think all devices can't work if the reset line is connected at all. :-)

I was thinking at the fact that the de-assert support was added just 2
years ago, while the driver seems to be ~8 years old.

> 
>> To avoid this check the return
>> code of reset_control_deassert() in ravb_probe() and take proper action.
> 
>    I'd also mention moving of the free_nedev() call...

ok

> 
>> Fixes: 0d13a1a464a0 ("ravb: Add reset support")
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> [...]
> 
> MBR, Sergey

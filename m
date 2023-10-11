Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F096E7C58A4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346973AbjJKPzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346938AbjJKPzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:55:33 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BE1AF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:55:31 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53b8f8c6b1fso73924a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1697039729; x=1697644529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KbOpE5VKjIMjXNX7bXqdn8URAwp8xkDDntfrb/FwR4w=;
        b=TBV6E1D2JK263ZDj6oMrEJtO8JnZbEOmWj+afjWEctnm8Dsqu50FFbTmeFjo6ITZZX
         cbpRqvHFfm9IN5kBMIsVSERK+48FwXiS/KHSZfwYMvKivBRgIDLni+g0OIUfkffTDx99
         85ZTqByVHg7rIXdNejmpuPADvBgQqCS4AtDLyjER2za7wljt9FZjwHzwhurGi1AQqKxB
         TpGVeGt/sEtcRSN4pL6NaysaE7tNHx1HRDAYnYCFcUvq3MwAWoUfBzp74rx8GwVA2VgR
         KHkiM9ilp+JbkSuUhce72PiQZ0eko1VQoxayjjXmwlEcN0eGgnwKUMsDfcW8BEuRq1hY
         YZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697039729; x=1697644529;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KbOpE5VKjIMjXNX7bXqdn8URAwp8xkDDntfrb/FwR4w=;
        b=dtmeHTkHlCURd03JCeaSlSeoehNWOUM2+/xb0LHQO/SKzXiRo/OTGy6wMR4NLgOTLk
         BX7U/YGEFIcqRy877UjF+o5vryqMl+FaJFnZG2A2Jy6TyvMTfMwgrIejqLD1sAe8SjjT
         LkmJXxm3vfpcrmocGO1ZgMgAiGS4oZA7z55nzf0Q5Wnlof1hOcYY0DFo0PXExIHEbO6H
         GS3g5iRWSnyrFoHpsFR1OrOXpR2/hGMAIdO8lKZwH1maOu5NV+dYXClhrW5QNOWS01h3
         tnsHY8M/H/5XDc57KQOQo2an/jrqp4RpOs05z83Uxyjp0x7Ewxu6TGIn0mqF32liawWI
         65Pg==
X-Gm-Message-State: AOJu0YzVpqZT26s0mJ9H56St6ROiPBk/5UBzPhvYonXATnivrvjC5kq+
        XZc46fi/r0qHXokWA9DzAdXKAg==
X-Google-Smtp-Source: AGHT+IHtErofZM2x+uE8kBiPaK1/HljWwfQi6sW2rbSCUwN2JiCvdsMVCdEYynwvsBJNVVTBtUob8w==
X-Received: by 2002:aa7:c998:0:b0:530:ccf7:37af with SMTP id c24-20020aa7c998000000b00530ccf737afmr18702868edt.12.1697039729420;
        Wed, 11 Oct 2023 08:55:29 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.133])
        by smtp.gmail.com with ESMTPSA id ec22-20020a0564020d5600b0053defc8c15asm460905edb.51.2023.10.11.08.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 08:55:28 -0700 (PDT)
Message-ID: <fe375d1d-29b1-4514-963b-7a65a645a58d@tuxon.dev>
Date:   Wed, 11 Oct 2023 18:55:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] clk: renesas: rzg2l: Use %x format specifier to print
 CLK_ON_R()
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Sergei Shtylyov <sergei.shtylyov@gmail.com>, magnus.damm@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20231010132701.1658737-1-claudiu.beznea.uj@bp.renesas.com>
 <20231010132701.1658737-2-claudiu.beznea.uj@bp.renesas.com>
 <8226bd48-4297-0b32-c733-2e569114a934@gmail.com>
 <e1c9c2ca-144c-49fe-940c-9ca8ad40e377@tuxon.dev>
 <CAMuHMdW7jXSFx5kU6PKr55cXw2+Hu_J-Z4NdUk=m_2AxuaOC0g@mail.gmail.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdW7jXSFx5kU6PKr55cXw2+Hu_J-Z4NdUk=m_2AxuaOC0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Geert,

On 11.10.2023 10:43, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Wed, Oct 11, 2023 at 9:37 AM claudiu beznea <claudiu.beznea@tuxon.dev> wrote:
>> On 10.10.2023 17:52, Sergei Shtylyov wrote:
>>> On 10/10/23 4:26 PM, Claudiu wrote:
>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> Use %x format specifier to print CLK_ON_R(). This is easier when
>>>> debugging as the value printed will be hexadecimal like in the hardware
>>>> manual. Along with it "0x" has been added in front of the printed value.
>>>>
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>> ---
>>>>  drivers/clk/renesas/rzg2l-cpg.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
>>>> index d62f1bc1f60e..764bd72cf059 100644
>>>> --- a/drivers/clk/renesas/rzg2l-cpg.c
>>>> +++ b/drivers/clk/renesas/rzg2l-cpg.c
>>>> @@ -1213,7 +1213,7 @@ static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
>>>>              return 0;
>>>>      }
>>>>
>>>> -    dev_dbg(dev, "CLK_ON %u/%pC %s\n", CLK_ON_R(reg), hw->clk,
>>>> +    dev_dbg(dev, "CLK_ON 0x%x/%pC %s\n", CLK_ON_R(reg), hw->clk,
>>>
>>>    Perhaps "%#x" instead of "0x%x"?
>>
>> Yes, better, thanks!
> 
> "%#" is not very common in drivers/clk/.
> 
> And to me it always raises the question: What does "alternate form" mean
> for this conversion specifier and this implementation of vsnprintf()?

OK, I have no strong opinion on this. Please let me know in case you need
me to send a new version.

Thank you,
Claudiu Beznea

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5CB7772D8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjHJI0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjHJI0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:26:22 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DE4DC;
        Thu, 10 Aug 2023 01:26:21 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bc73a2b0easo5355955ad.0;
        Thu, 10 Aug 2023 01:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691655981; x=1692260781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YyYLtAiSPm/jR0Yq/J8XmIODN3EVvM9jc+bkni7Ghjg=;
        b=NcpclQmFc674BU9xqAEWd/Z9vv/QSngKSmt48UMEkeI+EUgaRrDHiYr3+PN7NFxmMI
         C1Z9B4OiWQL43DpFVoOEufXz5IgGx3avNFjyi7uOiQTOhhrpeNfCP1yVYX0QMLaBh/Bv
         gwu6T9KjIqFuolYw4GGP7ZINz3flI6rG3fFmdn/yU0IUh/ri98FDyVf1RCVaS9s7KDHe
         L7AIP2NwQvpG/ZIe2CUVsacr39zul3HOTo87EPFLyjenf+waoPsZo9UZ/zicR4/MrUjy
         R+d2H6U9NugqUvHbsQF2E1xvq10QmG7bjF/dpTaaSZ9gJcn2uWByMz0K29FxyU19Ub3A
         Po1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691655981; x=1692260781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YyYLtAiSPm/jR0Yq/J8XmIODN3EVvM9jc+bkni7Ghjg=;
        b=LIhyTSckaeN9okGuJkmpuVqlWgoXltGP/SOcX9SFHkGeZFyPs9wAAT968Z+d5DgZ+E
         IAZdKi6R0Yi7f/n3arvI29UNAmQ215rwVevODCszFoyD2Z6ADxP6JTm4DvrqsNadCgbD
         3qdbSuiBs5YsTPENXGXJhhhnUghT9WxjIFmAErfmYnr7Nr8PatcVG7rtK6Ry2bkZyroh
         IlT2bFrVXglZEsb04xMms2NS2j7p4DqEkei90TDPkul03PvF0Cs4dvUm2ZBmocO6jOg2
         ro8Vw2gKgcHmAf821egvXBErWUAGAlFe+6fT9wvB4Twlx55Et6uZCJBiAdeuUC8akqhr
         OvCg==
X-Gm-Message-State: AOJu0YwSsnfiORgk5YJuDQaaKEjoBDnLzjHrizNh70NXwoGM7cnYblLs
        tiZQEMQ4wqoBNIDL/TVA1z8=
X-Google-Smtp-Source: AGHT+IFEOBb7J2YylGCtStfggHdcYQr2dmrb4aRn5BcqslpwODeGItvSG6+rqAUioEWA5RCqAKGXVw==
X-Received: by 2002:a17:902:ecc1:b0:1bb:a367:a77 with SMTP id a1-20020a170902ecc100b001bba3670a77mr1735345plh.31.1691655980854;
        Thu, 10 Aug 2023 01:26:20 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id jc3-20020a17090325c300b001b86492d724sm1053650plb.223.2023.08.10.01.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 01:26:20 -0700 (PDT)
Message-ID: <fe38eff9-dff6-3128-3110-33739d8c1280@gmail.com>
Date:   Thu, 10 Aug 2023 16:26:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RESEND PATCH v2 3/3] rtc: Add driver for Nuvoton ma35d1 rtc
 controller
Content-Language: en-US
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, mjchen@nuvoton.com, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230809011542.429945-1-ychuang570808@gmail.com>
 <20230809011542.429945-4-ychuang570808@gmail.com>
 <20230809021025a7c0daec@mail.local>
 <426130f6-7b8a-91f9-559b-afc5afdc656e@gmail.com>
 <2023080922515326db190e@mail.local>
 <347cf148-bda8-852b-768c-fa2b57ce5bcb@gmail.com>
 <20230810073015d5545903@mail.local>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <20230810073015d5545903@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/10 下午 03:30, Alexandre Belloni wrote:
> On 10/08/2023 15:21:47+0800, Jacky Huang wrote:
>>>>>> +	return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int ma35d1_rtc_suspend(struct platform_device *pdev, pm_message_t state)
>>>>>> +{
>>>>>> +	struct ma35_rtc *rtc = platform_get_drvdata(pdev);
>>>>>> +	u32 regval;
>>>>>> +
>>>>>> +	if (device_may_wakeup(&pdev->dev))
>>>>>> +		enable_irq_wake(rtc->irq_num);
>>>>>> +
>>>>>> +	regval = rtc_reg_read(rtc, MA35_REG_RTC_INTEN);
>>>>>> +	regval &= ~RTC_INTEN_TICKIEN;
>>>>>> +	rtc_reg_write(rtc, MA35_REG_RTC_INTEN, regval);
>>>>> This is not what the user is asking, don't do this. Also, how was this
>>>>> tested?
>>>> Sure, I will remove these three lines of code.
>>>>
>>>> We test it with "echo mem > /sys/power/state".
>>>>
>>> Yes, my point is that if UIE is enabled, then the user wants to be woken
>>> up every second. If this is not what is wanted, then UIE has to be
>>> disabled before going to suspend.
>>>
>>> My question is why are you enabling RTC_INTEN_TICKIEN in probe? I don't
>>> expect anyone to use an actual hardware tick interrupt, unless the alarm
>>> is broken and can't be set every second. This is why I questioned the
>>> RTC_UF path because I don't expect it to be taken at all.
>> Yes, we will remove TICKIEN from probe and modify ma35d1_alarm_irq_enable().
>> TICKIEN will be enabled only if UIE is enabled.
>>
>> static int ma35d1_alarm_irq_enable(struct device *dev, unsigned int enabled)
>> {
>>      struct ma35d1_rtc *rtc = dev_get_drvdata(dev);
>>
>>      if (enabled) {
>>          if (rtc->rtc->uie_rtctimer.enabled)
>>              rtc_reg_write(rtc, NVT_RTC_INTEN,
>>                        (rtc_reg_read(rtc,
>> NVT_RTC_INTEN)|(RTC_INTEN_TICKIEN)));
>
> Don't do that unless the regular alarm can't be set every second. Simply
> always use ALMIEN, then check rtctest is passing properly.

OK, I got it. I will drop the TICKINT and use ALMIEN only.

MA35D1 RTC has an alarm mask register which supports alarm mask for 
seconds, minutes, and hours.
We will use the alarm mask to have RTC generate an alarm interrupt per 
second, and make sure
the driver can pass rtctest.

>>          if (rtc->rtc->aie_timer.enabled)
>>              rtc_reg_write(rtc, NVT_RTC_INTEN,
>>                        (rtc_reg_read(rtc,
>> NVT_RTC_INTEN)|(RTC_INTEN_ALMIEN)));
>>      } else {
>>          if (rtc->rtc->uie_rtctimer.enabled)
>>              rtc_reg_write(rtc, NVT_RTC_INTEN,
>>                        (rtc_reg_read(rtc, NVT_RTC_INTEN) &
>> (~RTC_INTEN_TICKIEN)));
>>          if (rtc->rtc->aie_timer.enabled)
>>              rtc_reg_write(rtc, NVT_RTC_INTEN,
>>                        (rtc_reg_read(rtc, NVT_RTC_INTEN) &
>> (~RTC_INTEN_ALMIEN)));
>>      }
>>      return 0;
>> }
>>


Best Regards,
Jacky Huang


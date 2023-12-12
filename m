Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E259680F000
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376646AbjLLPWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376624AbjLLPWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:22:18 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9384683;
        Tue, 12 Dec 2023 07:22:24 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b9dbbaa9a9so4770904b6e.2;
        Tue, 12 Dec 2023 07:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702394544; x=1702999344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=75Rm+5xBDQKmd+48f6tczEiVYrcFon2o4idJL/p3O7M=;
        b=BDHsEI/OVfZflTp+T/anCwxYO25+WBHMwkJ+H4kMJVtnWaNWG7Ay7DyvL4Goa5lZoJ
         UQCSCziGeBIVgUnavqgXKiWH3XjPYhDicltiglZmm2NKV+GqGJII7/NLkRnbsvAfSllV
         0qnvx2+Esbcn0MyL5Lf9kqCVolUN6cvfRPBTbpgWrZWdNhcYo4K3GuWy2Kika4g+NHfe
         yrFwvz/iRtZJMAEIT2lXIEBaZVkuPNDqtJwcMxIwgvKxO9ZU98zm1cBvNbWqoafVeUbX
         8pQVsdi2li7uaI0xjnNM+IWezeP9IrkUEqOVLG8ayEQkWLRf1MJgrDfz1PDcv1vfPwO7
         p6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702394544; x=1702999344;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=75Rm+5xBDQKmd+48f6tczEiVYrcFon2o4idJL/p3O7M=;
        b=Wd8XAy9prmMpd1J2kjIPIoZWXZGHEdaLWu0jkTAlGVeTE3ql2u+qPY/hG2qIXUaQr9
         aiePNfgSzE/nx9JYWCUsLmLK4LnTi7U3YhnPO5Jc69yrCph2r1IHw4zTJxxJS6+XGUDI
         7APHPHAWtL2O07+Doe+WaxpdU5y/B5JH18tzgR00rwWjguCzAp+eIdSR49wCaDHvJwo2
         esvtXJMD74R01Rh3+7yaWtciC5eXjiE/083PMqbaUtpPNr5ux6dHwnymr3oJMxF5N6Gq
         ibrjKaiskCiA2Nw0QNmVgSm8rF7Zf5duUPz6Cp8B/FxqB4Inb9sdFsjlXsC8OuvoMMgH
         ibzQ==
X-Gm-Message-State: AOJu0Yzjx9KEj9EJMGdsfNERxvVfdt/yDyDTFZPfnrrk5Y8v07NLz3jk
        UjkPK7hqKzpnUw/BG3rpFeU=
X-Google-Smtp-Source: AGHT+IHZ4pvntu/TwpQ+WJl0z4EXkuFPrI/3FnIMC3Z64SrFUnbiRb6pzz8yVWJ0MKShxAPcgZaE0A==
X-Received: by 2002:a05:6808:158e:b0:3b9:e801:7aae with SMTP id t14-20020a056808158e00b003b9e8017aaemr8926120oiw.54.1702394543815;
        Tue, 12 Dec 2023 07:22:23 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ck20-20020a056808251400b003b9f057de84sm806103oib.58.2023.12.12.07.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 07:22:22 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f7be8d89-25ae-4d83-9577-12fcac41d0ab@roeck-us.net>
Date:   Tue, 12 Dec 2023 07:22:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/6] pwm: Rename pwm_apply_state() to
 pwm_apply_might_sleep()
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Sean Young <sean@mess.org>, Jean Delvare <jdelvare@suse.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Helge Deller <deller@gmx.de>
Cc:     linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Support Opensource <support.opensource@diasemi.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jani Nikula <jani.nikula@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
References: <cover.1702369869.git.sean@mess.org>
 <9af7ba748fd2eb7e04208b6b183185f1daf78016.1702369869.git.sean@mess.org>
 <20231212114100.sn7nzntousql2ays@pengutronix.de>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20231212114100.sn7nzntousql2ays@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/23 03:41, Uwe Kleine-König wrote:
> On Tue, Dec 12, 2023 at 08:34:00AM +0000, Sean Young wrote:
>> In order to introduce a pwm api which can be used from atomic context,
>> we will need two functions for applying pwm changes:
>>
>> 	int pwm_apply_might_sleep(struct pwm *, struct pwm_state *);
>> 	int pwm_apply_atomic(struct pwm *, struct pwm_state *);
>>
>> This commit just deals with renaming pwm_apply_state(), a following
>> commit will introduce the pwm_apply_atomic() function.
>>
>> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com> # for input
>> Acked-by: Hans de Goede <hdegoede@redhat.com>
>> Acked-by: Jani Nikula <jani.nikula@intel.com>
>> Acked-by: Lee Jones <lee@kernel.org>
>> Signed-off-by: Sean Young <sean@mess.org>
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Several affected maintainers already acked, so I guess it's fine to take
> this via the pwm tree. An Ack from the remaining maintainers would be
> very welcome, an alternative would be to split the patch.
> 
> Missing Acks so far:
> 
>   - Jean Delvare / Guenter Roeck for drivers/hwmon/pwm-fan.c
>   - Javier Martinez Canillas for drivers/gpu/drm/solomon/ssd130x.c
>   - Liam Girdwood / Mark Brown for drivers/regulator/pwm-regulator.c
>   - Helge Deller for drivers/video/fbdev/ssd1307fb.c
> 
> Best regards
> Uwe
> 


Personally I find the change unnecessary and pointless, which is why I
didn't ack it. Even if function names were deemed important enough, keeping
pwm_apply_state() for the time being and just adding pwm_apply_might_sleep()
as duplicate would have done it, all the changes could have gone in long
ago, and per-subsystem cleanup could have been orthogonal.

I refrained from commenting because it might be considered bike shedding,
but I don't want to ack something I deem unnecessary and pointless without
comment. But then don't want to keep arguing either, so

Acked-by: Guenter Roeck <linux@roeck-us.net>

Guenter


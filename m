Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52417D6F73
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344639AbjJYOUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjJYOUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:20:14 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BB399;
        Wed, 25 Oct 2023 07:20:12 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507cee17b00so8441948e87.2;
        Wed, 25 Oct 2023 07:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698243611; x=1698848411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KXdFX0UY5tniJLRDcl1ufSs5c/hl+EfLWW5bDdsq8SA=;
        b=WemKRxkbCgLhSmp6vTOqZfbOnC1Ume8v/AP9mdV6ky5315lfssgVvsk9/O4UA3dtf5
         zTIcCvlzFA8+wiB0OzCbzG3bvIkt7tVI0+jamk5iXO30Koup6w2ug0aBcV+66MFmiCpp
         lny0FiAseXqcw79Na2A8X8QGqr+33mt15gBcajIn+0vcFU392TlGR/Zm7NJWXuaXQSS1
         DWcCVyVka/K57VbziPgYxSuLX9zYNt14X3IXKFGp2pNlF7ScGh3ze1i+xySyX6Qk6PtK
         2OSb+gH8AeFs53B99+2bdBTekfB05AEBWECnrKzVHQ1RXbR/Qz+mxSeF0Oq6udHzxZJu
         mtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698243611; x=1698848411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KXdFX0UY5tniJLRDcl1ufSs5c/hl+EfLWW5bDdsq8SA=;
        b=R3ZlUxyD2zh+JpYOB7HMCrAqMHN75z5QCmTCnonkYz9z1Ca702MrExC77psAwRyu6a
         F98hLgA6uTmvYKIAtmeKyvJ1WX2kWgppmzlHMoP3Emqv1neim51vN0FAMqDU9KYfRNV6
         5dIUv4BMq+94pGoQxYfdl+hedgEGgGkAxOATOuDpyV6zrtlepiL3vKWL80DMc5l+FlrG
         W1+Q0qVBThey78b6Vkt+Iu5LusemWg3/YyCagttIwWnCQV2nb2U0mbNAQURVrobp7vtD
         poitG53P4qaJCp5MlKjZPDZj6FgYHJDPCE7ZyRa+QeoF/EoDk0BcHT4+Ka+EibCWOtds
         Rg2w==
X-Gm-Message-State: AOJu0Yy52ICEV5JT68A6Ug/MMGDEVLsQaDM5s8NKGr9mOp7z3OkX+oML
        OE1CjydG7GqeUiHtNb/QyKc=
X-Google-Smtp-Source: AGHT+IHCJiQ2e6pDH3+U3/wVqmKSJcAM0uK7m8zA5flWq6iZTKh/qG9TOso4O1h1Ce74ljz0EvAsIw==
X-Received: by 2002:ac2:5550:0:b0:503:258f:fd1b with SMTP id l16-20020ac25550000000b00503258ffd1bmr11409838lfk.18.1698243610440;
        Wed, 25 Oct 2023 07:20:10 -0700 (PDT)
Received: from [192.168.76.157] (85-76-164-65-nat.elisa-mobile.fi. [85.76.164.65])
        by smtp.gmail.com with ESMTPSA id x13-20020ac25dcd000000b005041ce44bbdsm2568600lfq.5.2023.10.25.07.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 07:20:09 -0700 (PDT)
Message-ID: <a0db9dbb-df0e-406a-9a88-2a6968ec1469@gmail.com>
Date:   Wed, 25 Oct 2023 17:21:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ASoC: ti: omap-mcbsp: Ignore errors for getting
 fck_src
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, jarkko.nikula@bitmer.com,
        dmitry.torokhov@gmail.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <20230705190324.355282-1-andreas@kemnade.info>
 <20230705190324.355282-2-andreas@kemnade.info>
 <7d58d52d-2087-45af-b29e-2515b63ead13@gmail.com>
 <20230920063353.GQ5285@atomide.com>
 <dac768d2-2c66-4d6b-b3d3-d1ef69103c76@gmail.com>
 <20230921121626.GT5285@atomide.com> <20231006102348.GK34982@atomide.com>
 <20231006213003.0fbac87a@aktux> <20231007062518.GM34982@atomide.com>
 <20231007091156.588d7ba1@aktux>
 <db511d14-f2fe-4b4e-bd13-223e7a33f933@gmail.com>
 <20231013132503.25d63933@aktux>
Content-Language: en-US
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20231013132503.25d63933@aktux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/10/2023 14:25, Andreas Kemnade wrote:
>> I guess it is because of the pm_runtime_put_sync() in the
>> omap2_mcbsp_set_clks_src() around the fclk re-parenting.
>> That is a bit dubious thing for sure. We need to disable the device to
>> be able to re-parent the fclk but if we disable the device it is going
>> to be powered down, right? I think we have appropriate context handling,
>> so it might work, but it is certainly not a rock solid code... If you
>> have a stream running already, you don't really want to kill the McBSP.
>>
> Ok, so if the device is powered of at omap2_mcbsp_set_clks_src() 
> we get the usage count underflow, and the counter is incremented
> immediately again in the runtime put function. So things get out of balance...
> I'll check Tony's fix here.
> 
>> The problem is that this mux is outside of the McBSP IP, so we need a
>> system level (iow, clk API) way to change it runtime.
>>
>> What is the machine driver where this happens? If you set the sysclk in
>> hw_params of the machine driver, it will be OK, but if you do that in
>> probe time then it is likely going to fail as you experienced
>>
> As you see in the other patches of this series,
> it is a simple-audio-card with a tlv320aic3x codec
> in combination with the mcbsp.

To be honest I would be happier if we can just remove the whole
omap2_mcbsp_set_clks_src() and leave the CLKS source selection outside
of the driver.
But omap3pandora is selecting external clock as parent
(OMAP_MCBSP_SYSCLK_CLKS_EXT - in hw_params, so it actually works) and I
don't know what happens if this functionality is removed. Likely going
to break Pandora.
That is fixable, but what worries me is this comment and code:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/sound/soc/ti/omap-mcbsp.c#n388

Which is added by me a long time ago:
e386615c01d37 ("ASoC: omap-mcbsp: When closing the port select PRCM
source for CLKS signal")

I'm not sure if this is possible to do in any other way.

-- 
Péter

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E5F76BCE0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjHASqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjHASqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:46:37 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4C830C7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 11:46:15 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-55b22f82ac8so78229a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 11:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1690915575; x=1691520375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kvbZ9yYuWoTSFKJEhKENxSCBKtYpxpK0EzXBfLVY1p0=;
        b=IRoyV4Ead+c/d0ks99Zg14YSdO0tXd9vDFI5zWCjNpslgPTEqbT/ERBlexp7Q/JUUA
         jqDuqlMcyQ/nTpjEo/dQrnCBIwPk8V5i5hq3sMJxHatN1C99Z1yggSsvw7u+RwJLoIFO
         BUp5lZMfwE7b4BXasRkBB5pG83fbHRP8c13xQJEsMDQOlZ8D4GrW/wB4yixSGwfFQeBH
         Hy6JMROsMrIzoKN8QS9Z6/zQAOZTfLZPigos5R1dJFfb+DLxLT3cJHesifEklP3RzZAW
         n4b4fQJeBkaVEyNA7qedDXw1aOR4HZEV7UljyvTmgEGhHhbsLi8d+A/+rBY4ETcDyFBk
         BZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915575; x=1691520375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kvbZ9yYuWoTSFKJEhKENxSCBKtYpxpK0EzXBfLVY1p0=;
        b=Yxxf4TJMyZ+ltz1CFdDLMx/i7FTqZHS51qK9jq1gcJtwGy5rWleyCNjZmeJox//IbC
         BvA0Efesb+e6NGbO5frQmL6/Xa+QsecaMhWQVG96n0IacGpFDDpCLU2zKn4xNIGTmJm3
         ZC5idz2Qro57ZeMcrPCWCO8Q62IYFZH4LPXZXs81PE2MkVjWHIfYSKhxvrnwg/XvpANx
         JlDBkio4/RH42dgKer7n6LkkPnuPU0RGXH0hsYrPofAyN0GGFJSqLyFIgELlPej1Bg5T
         S3vMrQp7fgAvSQaUW8M8UxCWxcdh6P8DlOQZepcXDQbjp0MtphqNH83NvzX2I4D1ZIpj
         qa7Q==
X-Gm-Message-State: ABy/qLYjy3heyxM19N7BNHPckeaOE92Cm5CB7N91MbwCaoIuEJKiw6J+
        9DeGtZcqra0MCDOdyL2sAPBVLmjfZhLkuvfARmf2jA==
X-Google-Smtp-Source: APBJJlGn2yOBxuyGstntxTVsDJptbHmBTnZxJFLFSa58BxRZujPCSMKq7eDJRr06xgq825y3alknqiVR75AV0LTwJZ4=
X-Received: by 2002:a17:90b:23ce:b0:262:e589:678f with SMTP id
 md14-20020a17090b23ce00b00262e589678fmr17592816pjb.10.1690915574722; Tue, 01
 Aug 2023 11:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230727091358.3274620-1-Naresh.Solanki@9elements.com>
 <20230727091358.3274620-2-Naresh.Solanki@9elements.com> <41a8ae4b-0f96-9f26-f25b-b1554b2695d6@roeck-us.net>
 <CABqG17jKoJ8FJdA-vpX8uda9yi_ir3f2FxFAiE7GTaVM7Mb2aA@mail.gmail.com> <b4097ed6-95d6-b11b-9c9e-edd6e8c51d00@roeck-us.net>
In-Reply-To: <b4097ed6-95d6-b11b-9c9e-edd6e8c51d00@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Wed, 2 Aug 2023 00:16:04 +0530
Message-ID: <CABqG17iAsx2nysBSX10PTCK=fTpvaz2456a-s6CBwQjuJduWQw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hwmon: (pmbus/tda38640) Add workaround for bug in
 SVID mode
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

>
> On 8/1/23 05:34, Naresh Solanki wrote:
>
> [ ... ]
>
> >>> +     if (IS_ENABLED(CONFIG_SENSORS_TDA38640_REGULATOR) || svid) {
> >>
> >> If you hide this behind IS_ENABLED(CONFIG_SENSORS_TDA38640_REGULATOR), reading
> >> svid outside the if() statement has no value.
> > svid mode check is needed only when regulator is enabled for on/off
> > control later.
> > Will align the code such that if svid_mode check is done only when
> > REGULATOR config is enabled
> > & if it is in svid mode then apply the WA.
> >
> >>
> >>> +             /*
> >>> +              * Apply ON_OFF_CONFIG workaround as enabling the regulator using the
> >>> +              * OPERATION register doesn't work in SVID mode.
> >>> +              *
> >>> +              * One should configure PMBUS_ON_OFF_CONFIG here, but
> >>> +              * PB_ON_OFF_CONFIG_POWERUP_CONTROL and PB_ON_OFF_CONFIG_EN_PIN_REQ
> >>> +              * are ignored by the device.
> >>> +              * Only PB_ON_OFF_CONFIG_POLARITY_HIGH has an effect.
> >>
> >> Hmm, maybe I start to understand. This is really weird, since it changes
> >> the polarity of the EN input pin, effectively reverting its value.
> >> In other words, what really happens is that it is not possible to disable
> >> the chip with PMBUS_ON_OFF_CONFIG in SVID mode, and that reverting
> >> the EN pin polarity effectively simulates turning the chip on or off by
> >> software. Maybe software enable is disabled on purpose in VID mode.
> >> Is that really a bug or is it a feature, and is it really a good idea to
> >> override it ?
> > By design, SVID mode only has HW control enabled.
> > This was with the assumption that PGOOD will be used for controlling
> > Enable of another rail in Hardware.
> >
> > Since my use case needs the complete PMBUS based control,
> > EN pin polarity flipping can be used for controlling output.
> >
>
> So, effectively, this is not really a bug. It is working around chip functionality.
>
> That means we can not just enable this unconditionally in SVID mode after all.
> Sorry, but it has to be configurable after all, with appropriate explanation.
By 'configurable' you mean add a dt-property like 'en-svid-control' to have this
enabled ?

Regards,
Naresh
>
> Guenter
>
> >>
> >> AN_2203_PL12_2204_184108 might really help here.
> >>
> >> Guenter
> >>
> >>> +              */
> >>> +             data->info.read_byte_data = tda38640_read_byte_data;
> >>> +             data->info.write_byte_data = tda38640_write_byte_data;
> >>> +     }
> >>> +     return pmbus_do_probe(client, &data->info);
> >>>    }
> >>>
> >>>    static const struct i2c_device_id tda38640_id[] = {
> >>
>

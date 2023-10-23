Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4EA7D2C28
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjJWIED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjJWIEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:04:00 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5D4A1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:03:58 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d9a3d737d66so2233751276.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698048237; x=1698653037; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gmB9mDTwiF3uEH0iaSmju1hjjf2PC63Y5fnQXGlfFvY=;
        b=fu7Fm2CWDTbU4vgkZvk0KUscLqzKdSu6257lMymgRY9sILLbrOqdqyinFyrNaDGfE4
         m1nBqXpywvnoLTZ1tRewNBSZuvo0XQ+12uYKvMrvPBxGG6bx/sxoYOdOPh1942HSpuTq
         che/cfCX5eANbAMk8+pZl6fzmuYHd9y9Z3iqTxGENKMe9e8/YxwvwPX0JLweZiyUogDy
         vIXBTWsMpWbolKvbLfxoo8f3IWF0MrQ6oXZmiz6vO8qDTYgJuJzAh4X/JdgyJhSthmN9
         mFGCuOs8ufYglvDsYWHA9busqoiS/wJeSXpd2VMSWGMLQafa3RJ8VlV6OPBIbGgo2tEJ
         qkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698048237; x=1698653037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gmB9mDTwiF3uEH0iaSmju1hjjf2PC63Y5fnQXGlfFvY=;
        b=ur9l0/cMPRFjLJFEhIieoLo4Vh/ZAf1HX8x4gB/hYsMqSK6NVSP6GyXxKyU9Q/J3Oo
         pNbDCRKTku/SqgrbWSkoXyAcQsKYRmLtDIK9mFk42IgQ18LGPxveAdx+17vK1HnUdALB
         NzAH8UzLzyu6VY9mVYbkLj1wB2QDugdxPHAEusyp1M43GrUThbZgE6MbAJury/+0dHId
         cgCvQZ7iuYhHcNPQ6kYciKQWXdIf6tiEnDpsGLm7vtMc/mp3v3RqpJXMqIfHK72H+cMK
         eyYnC7bJ6LNscaZEkaThHiujl+UJ+BgVTRNLmgRAOss0EJiQzf8qaiNrAY+tswUaG8fc
         0JdA==
X-Gm-Message-State: AOJu0YwSkbwFWVtznFRJOcwvqlcvzh4r8Bgp4DiXUNF7CtoEc9xN0WlB
        dzKgwEa/+L8hI+wIYiMWxytqbBPb2wmzbCzh7jEfdw==
X-Google-Smtp-Source: AGHT+IElEdOoTwEWHGztCKoP/uOTBAVSI/z9UeRXX/JNfSNw3yEy28Sub6mcDg2QCSreuoawpXgqJLjt53W3G81bRMU=
X-Received: by 2002:a25:ef4e:0:b0:d9d:116a:89c8 with SMTP id
 w14-20020a25ef4e000000b00d9d116a89c8mr4808003ybm.54.1698048237350; Mon, 23
 Oct 2023 01:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-8-quic_jprakash@quicinc.com> <20230708165955.08c1159c@jic23-huawei>
 <13d5dee2-1da4-2ad0-91f8-a53b43adba2b@quicinc.com>
In-Reply-To: <13d5dee2-1da4-2ad0-91f8-a53b43adba2b@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 23 Oct 2023 11:03:46 +0300
Message-ID: <CAA8EJprb=804S=GfxPw_7AxoHRO1XzC+wGPCsvNGrRpJgj+y6A@mail.gmail.com>
Subject: Re: [PATCH 07/11] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
To:     Jishnu Prakash <quic_jprakash@quicinc.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, agross@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, Jonathan.Cameron@huawei.com,
        sboyd@kernel.org, quic_subbaram@quicinc.com,
        quic_collinsd@quicinc.com, quic_kamalw@quicinc.com,
        marijn.suijten@somainline.org, andriy.shevchenko@linux.intel.com,
        krzysztof.kozlowski@linaro.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Lee Jones <lee@kernel.org>,
        =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        Haibo Chen <haibo.chen@nxp.com>, linux-iio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 at 09:15, Jishnu Prakash <quic_jprakash@quicinc.com> wrote:
>
> Hi Jonathan,
>
> On 7/8/2023 9:29 PM, Jonathan Cameron wrote:
> > On Sat, 8 Jul 2023 12:58:31 +0530
> > Jishnu Prakash <quic_jprakash@quicinc.com> wrote:

> >> +
> >> +    ret = adc5_get_fw_data(adc);
> >> +    if (ret < 0) {
> >> +            dev_err(adc->dev, "adc get dt data failed, ret=%d\n", ret);
> >> +            return ret;
> >> +    }
> >> +
> >> +    for (i = 0; i < adc->num_sdams; i++) {
> >> +            ret = devm_request_irq(dev, adc->base[i].irq, adc5_gen3_isr,
> >> +                                    0, adc->base[i].irq_name, adc);
> >> +            if (ret < 0) {
> >> +                    dev_err(adc->dev, "Getting IRQ %d failed, ret=%d\n", adc->base[i].irq, ret);
> >> +                    return ret;
> >> +            }
> >> +    }
> >> +
> >> +    ret = adc_tm_register_tzd(adc);
> >> +    if (ret < 0)
> >> +            return ret;
> >> +
> >> +    if (adc->n_tm_channels)
> >> +            INIT_WORK(&adc->tm_handler_work, tm_handler_work);
> >> +
> >> +    indio_dev->name = pdev->name;
> >> +    indio_dev->modes = INDIO_DIRECT_MODE;
> >> +    indio_dev->info = &adc5_gen3_info;
> >> +    indio_dev->channels = adc->iio_chans;
> >> +    indio_dev->num_channels = adc->nchannels;
> >> +
> >> +    return devm_iio_device_register(dev, indio_dev);
> >> +}
> >> +
> >> +static int adc5_gen3_exit(struct platform_device *pdev)
> >> +{
> > As you are mixing devm manged cleanup and the explicit sort the
> > result is that you remove the userspace interfaces 'after' you run
> > everything in here. I'm thinking disabling the channels at least
> > isn't a good idea in that case.
> >
> > If you want to use devm (which is good) then you need to work out how
> > to register additional callbacks during probe to tear down everything in
> > the right order (typically the reverse of what happens in probe)
> > devm_add_action_or_reset() is the way to add those extra callbacks.
> >
> > If not, just don't use devm for at least those bits that will end up
> > running out of order (such as iio_device_register()) and manually call their
> > cleanup routines instead.
>
>
> I checked some other examples in the iio/adc/ folder, I think I see what
> you mean here. It looks like drivers with a remove callback always use
> iio_device_register and iio_device_unregister instead of the devm_*
> variant, due to the issue with sysfs removal as you said.
>
> I'll update the probe and remove functions similarly, to do explicit
> cleanups as required, avoiding devm_ usage for places where it should be
> avoided.

I think you got the message all wrong. There is nothing bad with using
devm_. As a matter of fact it is a preferred form in most of the
cases. However you have to be careful to tear down your device in the
correct order. And as Jonathan pointed
out, you might add necessary hooks manually by calling
devm_add_action_or_reset().

[skipped the rest]



-- 
With best wishes
Dmitry

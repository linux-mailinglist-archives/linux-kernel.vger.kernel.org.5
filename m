Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298A37B9DB8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 15:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjJEN4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 09:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243943AbjJENuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:50:21 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B1B26A74
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 05:58:28 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53627feca49so1551285a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 05:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696510707; x=1697115507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=54uUEylq3LVuurRVtb2mIY1GDBu2n1bSehibVDW31Ek=;
        b=TkVI5vH4Mq8NwWi2aiPtB6u7px28PwXRXDUNBhejq/y1pfLKUjoVJPR5LOz4h9+S/O
         VSb/iSVm0/MRjkx6STM8vVC1EuVqOJ290GzSRYJXeYVSdFE0vdyNLGVl3GvNhWgRE5sm
         RsB6CWMr5IcauVrc4HIFXIgc7e8TOvxWpvVmszNLUkfuGTUyi1dUJG2qLP8oC5Ld+lAj
         IPGwHSILgWzda7Ddm8a9G2Al3ix4IXZiRisjZVZUnX9Kvn7ES4SYTCD/JRhtrMB+moHN
         8EPAXLQ/YViemrrRxKhosF7QyP+3bz9FWR2cYOmjndupHzynSmJcKDseeAYRm4TkA9XW
         NxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696510707; x=1697115507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=54uUEylq3LVuurRVtb2mIY1GDBu2n1bSehibVDW31Ek=;
        b=A6zlz+p2InQ0xf/M6qZimfsi5U6CTHy2LmpyHUjfWA/d+rM7Rp6FPMC2roDuhugMWC
         rygMRAuWq0iGkKiGJVxrMGp7HX1zlSFn/SWYtdPX3in2bv/VCF3nEz10JepULSVQIw/A
         BNLQQrquqzyNXnzv4F9BrpycOc8KHBczSnkmGIBsAxVRSyH5gG1s2c61PuCqxHMo6SpU
         xCwN1yY/DoYuwpCoxtZ7lxuaD5ci9pNVVXBYFHkFL9IHMgvPMYqanXJgoO96s0ZAczXC
         Rrd6LYErGsFkjxo1EogmW+sNU/fS7Ye3hmotPV/LJFaOg7mLlqZfMBRoTHlcmkdqdz3Q
         7YVQ==
X-Gm-Message-State: AOJu0Yzj/gFMtO0KLsiMNMqDvBB6YaKIQS+N1Q5PYTQhQGBjL9YLBXBJ
        EZWEGmlsSSnhRoz4ZaFMeX0isg==
X-Google-Smtp-Source: AGHT+IGYliWIqnSbYurYXmldF5bpXzcFNUK7z8v11/xiPWf8HMiN9f4fcRM4OMhil9K85Li760ospg==
X-Received: by 2002:aa7:d945:0:b0:523:2e30:aaee with SMTP id l5-20020aa7d945000000b005232e30aaeemr4359227eds.32.1696510707341;
        Thu, 05 Oct 2023 05:58:27 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id m4-20020a056402050400b00533f111b61dsm1024857edv.68.2023.10.05.05.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 05:58:26 -0700 (PDT)
Date:   Thu, 5 Oct 2023 13:58:24 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: backlight: Add MPS MP3309C
Message-ID: <20231005125824.GC4874@aspen.lan>
References: <20230925122609.78849-1-f.suligoi@asem.it>
 <20230926130113.GB4356@aspen.lan>
 <DU2PR01MB8034F448F6E66BAC3823CDB1F9C4A@DU2PR01MB8034.eurprd01.prod.exchangelabs.com>
 <20231003102138.GB69443@aspen.lan>
 <DU2PR01MB80349344FB8CB1415BFA917DF9C4A@DU2PR01MB8034.eurprd01.prod.exchangelabs.com>
 <DU2PR01MB8034F17A9C81FE198CCAC5B7F9CBA@DU2PR01MB8034.eurprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU2PR01MB8034F17A9C81FE198CCAC5B7F9CBA@DU2PR01MB8034.eurprd01.prod.exchangelabs.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 03:18:24PM +0000, Flavio Suligoi wrote:
> Hi Daniel,
> ...
> > ...
> > > > > > +required:
> > > > > > +  - compatible
> > > > > > +  - reg
> > > > > > +  - max-brightness
> > > > >
> > > > > Why is this mandatory?
> > > > >
> > > > > There's no point in setting max-brightness when running in I2C
> > > > > mode
> > > > > (max- brightness should default to 31 in that case).
> > > > >
> > > > >
> > > > > > +  - default-brightness
> > > > >
> > > > > Again. I'm not clear why this needs to be mandatory.
> > > > >
> > > > >
> > > >
> > > > Ok, you are right, I'll remove max-brightness and default-brightness
> > > > from required properties list. I think to change these properties,
> > > > for the pwm dimming, into a clearer:
> > > >
> > > > - brightness-levels (uint32)
> > > > - default-brightness-levels (uint32).
> > > >
> > > > For example:
> > > >
> > > >   brightness-levels:
> > > >     description:
> > > >       Number of brightness levels. The actual brightness
> > > >       level (PWM duty cycle) will be interpolated from 0 to this value.
> > > >       0 means a  0% duty cycle (darkest/off), while the
> > > > brightness-levels
> > > represents
> > > >       a 100% duty cycle (brightest).
> > > >     $ref: /schemas/types.yaml#/definitions/uint32
> > > >
> > > >   default-brightness-level:
> > > >     description:
> > > >       The default brightness level (from 0 to brightness-levels)
> > > >     $ref: /schemas/types.yaml#/definitions/uint32
> > > >
> > > > Example:
> > > > brightness-levels = <10>;
> > > > default-brightness-level = <6>;
> > > >
> > > > What do you think about this solution?
> > >
> > > If you want to introduce a brightness-levels property then I would
> > > expect it to be defined with the same meaning as pwm-backlight (it's
> > > not relevant to the bindings but ideally it would be implemented by
> > > refactoring and reusing the code from pwm_bl.c).
> >
> > ok, I'll use the brightness-levels property as used in pwm-backlight
> >
> > >
> > > Same with default-brightness-level although I'm not sure why one
> > > wouldn't just use default-brightness for new bindings (doesn't
> > > default-brightness-level simply do exactly the same thing as default-
> > brightness).
> >
> > ok for default-brightness instead of default-brightness-level
>
> Just a question: default-brightness-level is the index into the brightness-levels array.
> But, if I use default-brightness instead of default-brightness-level,
> should I consider default-brightness also as an index into brightness-levels array?

Yes.


> Or, in this case, have the default-brightness to be equal to one of the values inside the
> brightness-levels array?

When there is a brightness array (and there is no interpolation) then
it is indexed by brightness. The values in the array are not
brightness (e.g. the controlable value describing the output of the
hardware). The values in the table are merely the PWM duty cycle...

Main difference is, with a correct table the brightness can use an
appropriate logarithmic power scale (which matches how humans perceive
brightness) instead of the linear scale provided by the PWM duty cycle.


Daniel.


Brightness and "index into the brightness-levels array" should be one
and the same thing
>
> >
> > >
> > >
> > > Daniel.
> >
> > Thanks an best regards,
> > Flavio
>
> Thanks,
>
> Flavio

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58BD78469E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbjHVQMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237505AbjHVQMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:12:01 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8E7185
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:11:59 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-26d4e1ba2dbso2509413a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1692720718; x=1693325518;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1OrmTxzyW+RpXjzsRL4/bIvhhff4L4PrTSfzkL5t+7E=;
        b=QxkXVlYcZ34AQOwsho3aShHKEyVq60NKEuoI5157+AofC4msmSplao6gY0f4gyqDlb
         cEMqU5/F0AO0XZquU2nPX+qJVbDivVb1FziR6vescVgXkJocvH7wq2JFnbfy9yLo0jss
         gZitx5mA0nv5mma6KbVxXy1oLy7Z1IliEktDNUluUsQ3LM5Ah9lH+wVI87kJM+sJurN5
         g/kZYuhc4nk3TR6/MqzhRj3vA/iNalxRJkKA8l85UbFBFGhU9LomofcJAAku6V21Mtau
         fM51Pm2ekIYK1IK5qTMJOWkmre/fOipzt+tDuxsf7VoCMlepdVl3dHRVwdg31cLuqjpv
         c6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692720718; x=1693325518;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1OrmTxzyW+RpXjzsRL4/bIvhhff4L4PrTSfzkL5t+7E=;
        b=LgSJudvttje6XSSeS3zdu0Qv7q31OuMTtrS9YFi9taJX9SaOxcVfiAtn5rYS6efDaV
         9CFBnwtDRInK9t2+0/4C2CfXFiOKYsaUnEMRqSVBgOnsEYaGR2OFy29CMrlb+a1VM1//
         ghwdBg1dvMnTXN5B8LjwmVYxre+wL/UPNvGyeaZ8bJ+cUGk1y8+Myd7d1xoPxp5hcTrA
         pUx/MgX9R7sl+SXdn+I11IpTcV8uwUBgE+YqUthTDUlx7qwGNOq2GtAWonzG9D+b6iWb
         Zy4wQHvCmaxw8C/477RL5NysontBZ63V2E9Vo7WI1kmoDaVeRY7pHrUiR2xe60sPeBYE
         ihGg==
X-Gm-Message-State: AOJu0YxRBilnJdpEag0ABMRxgc0LDO9nYgF60Ijg/Bv3mvRmwO7nKUqy
        /wZfDkj+qW95XEgXtDo5PUzp5p1MjI6qalMwAq9KcQ==
X-Google-Smtp-Source: AGHT+IEpROYCLvTLY4zt3kXDNUsRGmDha79UxFbmPGEJ1Y/O+jZr3ri8qEN3M/u+lPfQoKJ6NqroBTkuk+Q5oBiWArA=
X-Received: by 2002:a17:90a:bf12:b0:268:f987:305d with SMTP id
 c18-20020a17090abf1200b00268f987305dmr7375830pjs.5.1692720718590; Tue, 22 Aug
 2023 09:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230802193155.2170935-1-Naresh.Solanki@9elements.com>
 <20230808-stand-cheddar-b76b0b7509a0@spud> <eced746a-1181-bd8f-6828-4a4eeb79727c@roeck-us.net>
 <20230808-esquire-epidemic-f9bd74ffde25@spud> <CABqG17jm938MaEeqS03WeryVWSRBS7Bqq2Vwq9SL4QOGqXU43A@mail.gmail.com>
 <b3eebd2b-c73b-fdc7-2b2b-07e97db26d92@linaro.org> <CABqG17hgU44H9KbALy_336Sb+YOiEOzbnAihiox1OEuVnNiayQ@mail.gmail.com>
 <5cde8986-1b12-a85e-b2fe-e1aa1087b429@linaro.org> <CABqG17gL7XL0nKZ0QEYkF672AvfJQXapExw3p1iGm88U9idq=w@mail.gmail.com>
 <05ec3dc2-3ed5-4b04-8062-c10777e0a181@roeck-us.net>
In-Reply-To: <05ec3dc2-3ed5-4b04-8062-c10777e0a181@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Tue, 22 Aug 2023 21:41:48 +0530
Message-ID: <CABqG17hKcCwH7=AQq0-JtdeY0tmf=s_nWCoE3F-vh=ZPUBjObg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: hwmon: Add Infineon TDA38640
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 22 Aug 2023 at 18:47, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, Aug 22, 2023 at 02:32:31PM +0530, Naresh Solanki wrote:
> > Hi
> >
> > On Fri, 18 Aug 2023 at 14:53, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > >
> > > On 16/08/2023 10:51, Naresh Solanki wrote:
> > > > Hi Krzysztof,
> > > >
> > > > On Tue, 15 Aug 2023 at 01:02, Krzysztof Kozlowski
> > > > <krzysztof.kozlowski@linaro.org> wrote:
> > > >>
> > > >> On 11/08/2023 18:00, Naresh Solanki wrote:
> > > >>> Hi,
> > > >>>
> > > >>> On Tue, 8 Aug 2023 at 19:58, Conor Dooley <conor@kernel.org> wrote:
> > > >>>>
> > > >>>> On Tue, Aug 08, 2023 at 07:10:08AM -0700, Guenter Roeck wrote:
> > > >>>>> On 8/8/23 04:46, Conor Dooley wrote:
> > > >>>>>> On Wed, Aug 02, 2023 at 09:31:51PM +0200, Naresh Solanki wrote:
> > > >>>>>>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > >>>>>>>
> > > >>>>>>> The TDA38640 chip has different output control mechanisms depending on
> > > >>>>>>> its mode of operation. When the chip is in SVID mode, only
> > > >>>>>>> hardware-based output control is supported via ENABLE pin. However, when
> > > >>>>>>> it operates in PMBus mode, software control works perfectly.
> > > >>>>>>>
> > > >>>>>>> To enable software control as a workaround in SVID mode, add the DT
> > > >>>>>>> property 'infineon,en-svid-control'. This property will enable the
> > > >>>>>>> workaround, which utilizes ENABLE pin polarity flipping for output when
> > > >>>>>>> the chip is in SVID mode.
> > > >>>>>>
> > > >>>>>> Why do you need a custom property for this? How come it is not possible
> > > >>>>>> to determine what bus you are on?
> > > >>>>>>
> > > >>>>>
> > > >>>>> That is not the point. Yes, it can be detected if the control method is
> > > >>>>> PMBus or SVID. However, in SVID mode, SVID is supposed to control the
> > > >>>>> output, not PMBUs. This is bypassed by controlling the polarity of the
> > > >>>>> (physical) output enable signal. We do _not_ want this enabled automatically
> > > >>>>> in SVID mode. Its side effects on random boards using this chip are unknown.
> > > >>>>> Thus, this needs a property which specifically enables this functionality
> > > >>>>> for users who _really_ need to use it and (hopefully) know what they are
> > > >>>>> doing.
> > > >>>>
> > > >>>> Hmm, reading this it makes a lot more sense why this is a property - I
> > > >>>> guess I just struggled to understand the commit message here,
> > > >>>> particularly what the benefit of using the workaround is. I'm still
> > > >>>> having difficulty parsing the commit & property text though - its
> > > >>>> unclear to me when you would need to use it - so I will stay out
> > > >>>> of the way & let Rob or Krzysztof handle things.
> > > >>>
> > > >>> To provide context, my system employs a unique power sequence
> > > >>> strategy utilizing a BMC (Baseboard Management Controller),
> > > >>> rendering the reliance on the ENABLE pin unnecessary.
> > > >>> In this configuration, the ENABLE pin is grounded in the hardware.
> > > >>> While most regulators facilitate PMBus Operation for output control,
> > > >>> the TDA38640 chip, when in SVID mode, is constrained by the
> > > >>> ENABLE pin to align with Intel specifications.
> > > >>> My communication with Infineon confirmed that the recommended
> > > >>> approach is to invert the Enable Pin for my use case.
> > > >>>
> > > >>> Since this is not typically the use case for most setup & hence DT property
> > > >>> is must for enabling the special case.
> > > >>>
> > > >>> For further insight into my setup's power sequence strategy, you can
> > > >>> refer to the following link: https://github.com/9elements/pwrseqd
> > > >>>
> > > >>
> > > >> This justifies to me the property, but still you described desired
> > > >> driver behavior, not the hardware characteristic. Don't describe what
> > > >> you want to control, but describe the entire system.
> > > > I guess by entire system you mean how the regulators(including
> > > > TDA38640) connected & operated in our setup ?
> > >
> > > I mean, property name and description should say what is the
> > > characteristic of the hardware/firmware/entire system.
> > Based on your feedback, will update to below:
> > infineon,fixed-level-en-pin:
> >     description: |
> >       Indicate the ENABLE pin is set at fixed level or left
> >       unconnected(has internal pull-up).
> >     type: boolean
>
> Messy, because while it reflects physical connectivity, it doesn't reflect
> its use in the system at all. The pin may be at fixed level or left
> unconnected, but the system vendor doesn't want to give users the
> means to control output power (which would be the normal situation).
Maybe this would be better ?
infineon,svid-mode-fixed-en-pin
  description: |
    Indicate the ENABLE pin is set at fixed level or left
    unconnected(has internal pull-up) which chip in
    SVID mode.

Regards,
Naresh
>
> But then, if that is the only way to get a property accepted, so be it.
>
> Guenter

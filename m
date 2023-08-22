Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A766678487D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjHVRjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjHVRjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:39:02 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFAD35B6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:39:00 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5694a117254so3269488a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1692725940; x=1693330740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oLE8hKDrlGfTtUcqMTSUAVt71dMNQpyW2/v2HxOoLaI=;
        b=KZdz3G8RjOjbT8Gokba9folZsK073DVY7JW8POvKZ9umSSLd1aXcIe15EjXcKaqFlL
         WG5/Kt05oPegp01PZg0iydQJjdTvIjD4AnIGgTvSUyLygjYZfTKeW6zEmnr2gppOs5zP
         AY8JBTAMpul6h9n1BOl1Xzh75NBJAIY7ZCCXUwZ/Eu0K5rEXDK3avf7kccZNghPwokGt
         Dflo1t07yGirZh1BEnT4zWpiHg8pDsqZweUiLRAp0xZILnlk0x+L6jtkyKeMj4+E5Vpr
         kZOiQ3ERq87IyKU2pyT2epXdwuSS1mF9a71NUFKy6gzp5TlhVASf6JPzTnBa76EaGTVP
         7qNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692725940; x=1693330740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLE8hKDrlGfTtUcqMTSUAVt71dMNQpyW2/v2HxOoLaI=;
        b=fjK1V0chMNTw2QoGa1SrBl6hWHqSbCSRM/Kw0hT5AqOuFhfnmpJC53rudCERQfuLcD
         Eq6KJTytOdykM7b8BMVQkKbMqlwrVi3pWIvjpevL0DQ1m9f3qb6kRms/ALG99vj3Gdup
         /ifQH7yotg5/3+1FVTI//giGxwSpN29v3ScBrBlncbEw/o57zzQnEGw17Da6JFIfyhec
         ZXOoHzNH8tc2M51Q6c2CkF4p0HmQRlcAU0dSp6CqPGinQ7ieNcw29211Z5Rmr7esy1an
         FkUQKETFKN81cG6tUBtXGYHDA60GWOfpBLrxkqkMPNxcyccJFe0xALC8nzOUmHjPvf4Z
         ZS1A==
X-Gm-Message-State: AOJu0YzwMsDUqh2wACNwjJvIB6QFLwv4QSiB6EdHi7SucI2qdqIbzGu8
        DQNVruJEMsLsLwy9M21idhlpwSV1fMZknvUVxLHLwA==
X-Google-Smtp-Source: AGHT+IFVpmTBrNPNp3X2fKD9eCmmA0X1KdLhu0/hZWSb7UpXZMst5v1gvhV3C9W9kJjqTq6LPwjzjJ6rdEiGMa8xflQ=
X-Received: by 2002:a17:90a:eb09:b0:262:f06d:c0fc with SMTP id
 j9-20020a17090aeb0900b00262f06dc0fcmr9300490pjz.7.1692725940035; Tue, 22 Aug
 2023 10:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230808-stand-cheddar-b76b0b7509a0@spud> <eced746a-1181-bd8f-6828-4a4eeb79727c@roeck-us.net>
 <20230808-esquire-epidemic-f9bd74ffde25@spud> <CABqG17jm938MaEeqS03WeryVWSRBS7Bqq2Vwq9SL4QOGqXU43A@mail.gmail.com>
 <b3eebd2b-c73b-fdc7-2b2b-07e97db26d92@linaro.org> <CABqG17hgU44H9KbALy_336Sb+YOiEOzbnAihiox1OEuVnNiayQ@mail.gmail.com>
 <5cde8986-1b12-a85e-b2fe-e1aa1087b429@linaro.org> <CABqG17gL7XL0nKZ0QEYkF672AvfJQXapExw3p1iGm88U9idq=w@mail.gmail.com>
 <05ec3dc2-3ed5-4b04-8062-c10777e0a181@roeck-us.net> <CABqG17hKcCwH7=AQq0-JtdeY0tmf=s_nWCoE3F-vh=ZPUBjObg@mail.gmail.com>
 <c6ab0452-f976-469c-be85-9b065db46361@roeck-us.net>
In-Reply-To: <c6ab0452-f976-469c-be85-9b065db46361@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Tue, 22 Aug 2023 23:08:49 +0530
Message-ID: <CABqG17iv4SPgfF4LRy5sMzGSU4EPGJ0YPOu3_1XzV-NTcGn+qA@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 22 Aug 2023 at 22:20, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, Aug 22, 2023 at 09:41:48PM +0530, Naresh Solanki wrote:
> > Hi,
> >
> > On Tue, 22 Aug 2023 at 18:47, Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > On Tue, Aug 22, 2023 at 02:32:31PM +0530, Naresh Solanki wrote:
> > > > Hi
> > > >
> > > > On Fri, 18 Aug 2023 at 14:53, Krzysztof Kozlowski
> > > > <krzysztof.kozlowski@linaro.org> wrote:
> > > > >
> > > > > On 16/08/2023 10:51, Naresh Solanki wrote:
> > > > > > Hi Krzysztof,
> > > > > >
> > > > > > On Tue, 15 Aug 2023 at 01:02, Krzysztof Kozlowski
> > > > > > <krzysztof.kozlowski@linaro.org> wrote:
> > > > > >>
> > > > > >> On 11/08/2023 18:00, Naresh Solanki wrote:
> > > > > >>> Hi,
> > > > > >>>
> > > > > >>> On Tue, 8 Aug 2023 at 19:58, Conor Dooley <conor@kernel.org> wrote:
> > > > > >>>>
> > > > > >>>> On Tue, Aug 08, 2023 at 07:10:08AM -0700, Guenter Roeck wrote:
> > > > > >>>>> On 8/8/23 04:46, Conor Dooley wrote:
> > > > > >>>>>> On Wed, Aug 02, 2023 at 09:31:51PM +0200, Naresh Solanki wrote:
> > > > > >>>>>>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > > >>>>>>>
> > > > > >>>>>>> The TDA38640 chip has different output control mechanisms depending on
> > > > > >>>>>>> its mode of operation. When the chip is in SVID mode, only
> > > > > >>>>>>> hardware-based output control is supported via ENABLE pin. However, when
> > > > > >>>>>>> it operates in PMBus mode, software control works perfectly.
> > > > > >>>>>>>
> > > > > >>>>>>> To enable software control as a workaround in SVID mode, add the DT
> > > > > >>>>>>> property 'infineon,en-svid-control'. This property will enable the
> > > > > >>>>>>> workaround, which utilizes ENABLE pin polarity flipping for output when
> > > > > >>>>>>> the chip is in SVID mode.
> > > > > >>>>>>
> > > > > >>>>>> Why do you need a custom property for this? How come it is not possible
> > > > > >>>>>> to determine what bus you are on?
> > > > > >>>>>>
> > > > > >>>>>
> > > > > >>>>> That is not the point. Yes, it can be detected if the control method is
> > > > > >>>>> PMBus or SVID. However, in SVID mode, SVID is supposed to control the
> > > > > >>>>> output, not PMBUs. This is bypassed by controlling the polarity of the
> > > > > >>>>> (physical) output enable signal. We do _not_ want this enabled automatically
> > > > > >>>>> in SVID mode. Its side effects on random boards using this chip are unknown.
> > > > > >>>>> Thus, this needs a property which specifically enables this functionality
> > > > > >>>>> for users who _really_ need to use it and (hopefully) know what they are
> > > > > >>>>> doing.
> > > > > >>>>
> > > > > >>>> Hmm, reading this it makes a lot more sense why this is a property - I
> > > > > >>>> guess I just struggled to understand the commit message here,
> > > > > >>>> particularly what the benefit of using the workaround is. I'm still
> > > > > >>>> having difficulty parsing the commit & property text though - its
> > > > > >>>> unclear to me when you would need to use it - so I will stay out
> > > > > >>>> of the way & let Rob or Krzysztof handle things.
> > > > > >>>
> > > > > >>> To provide context, my system employs a unique power sequence
> > > > > >>> strategy utilizing a BMC (Baseboard Management Controller),
> > > > > >>> rendering the reliance on the ENABLE pin unnecessary.
> > > > > >>> In this configuration, the ENABLE pin is grounded in the hardware.
> > > > > >>> While most regulators facilitate PMBus Operation for output control,
> > > > > >>> the TDA38640 chip, when in SVID mode, is constrained by the
> > > > > >>> ENABLE pin to align with Intel specifications.
> > > > > >>> My communication with Infineon confirmed that the recommended
> > > > > >>> approach is to invert the Enable Pin for my use case.
> > > > > >>>
> > > > > >>> Since this is not typically the use case for most setup & hence DT property
> > > > > >>> is must for enabling the special case.
> > > > > >>>
> > > > > >>> For further insight into my setup's power sequence strategy, you can
> > > > > >>> refer to the following link: https://github.com/9elements/pwrseqd
> > > > > >>>
> > > > > >>
> > > > > >> This justifies to me the property, but still you described desired
> > > > > >> driver behavior, not the hardware characteristic. Don't describe what
> > > > > >> you want to control, but describe the entire system.
> > > > > > I guess by entire system you mean how the regulators(including
> > > > > > TDA38640) connected & operated in our setup ?
> > > > >
> > > > > I mean, property name and description should say what is the
> > > > > characteristic of the hardware/firmware/entire system.
> > > > Based on your feedback, will update to below:
> > > > infineon,fixed-level-en-pin:
> > > >     description: |
> > > >       Indicate the ENABLE pin is set at fixed level or left
> > > >       unconnected(has internal pull-up).
> > > >     type: boolean
> > >
> > > Messy, because while it reflects physical connectivity, it doesn't reflect
> > > its use in the system at all. The pin may be at fixed level or left
> > > unconnected, but the system vendor doesn't want to give users the
> > > means to control output power (which would be the normal situation).
> > Maybe this would be better ?
> > infineon,svid-mode-fixed-en-pin
> >   description: |
> >     Indicate the ENABLE pin is set at fixed level or left
> >     unconnected(has internal pull-up) which chip in
> >     SVID mode.
>
> which chip ? Do you mean "with the chip" ?
Yep. sorry for the typo.
>
> I don't think that makes a difference. It still doesn't describe
> your use case (which is something like "the chip is in SVID mode,
> its enable pin is set to fixed level, and we need to manipulate its
> interpretation by the chip so we can control the enable status from
> software). I have no idea how to express that in a way that would be
> acceptable as devicetree property.
In typical use case when chip is in SVID mode ,the ENABLE pin
isn't fixed i.e., either connected power good or FPGA pin.
If this property is explicitly specified then its clear in the hardware that
1. chip is in SVID mode,
2. ENABLE pin is fixed.
3. Intent to use the workaround.

@Krzysztof , Is this acceptable ? Can you please recommend a way
forward please.

Regards,
Naresh
>
> It doesn't seem to me that we are making much progress here.
> I know it isn't supposed to be done, and I don't really like it,
> but could you use a module parameter in your system ? I'd be
> open to accept that to make progress.
>
> Thanks,
> Guenter

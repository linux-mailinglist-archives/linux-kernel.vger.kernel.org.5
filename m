Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AED87841D2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbjHVNR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjHVNR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:17:56 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC94CE8;
        Tue, 22 Aug 2023 06:17:54 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5650ef42f6dso2509721a12.0;
        Tue, 22 Aug 2023 06:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692710274; x=1693315074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=weQf34xofDODWPjvp/B1jxJ4g6zTpqejkurB//D5bLc=;
        b=kq6RPquOUM4Z8KQ5DQtNBAOW/eTF0uKxZtayRMAl6I44WaLygReBkCskiqOsyPLUTf
         cPHIx7u8TXq/zNh628YnQY7oPaan2jLdy7PzE8E4SqRbU9igFBwntPttHOpGFOCy11s/
         qzJFICI89vouWBKMQ/ecmxEneGerHnnSRoeKp4T1b+P+hxyqZoMHV9ltIBPIN29MZ2y3
         6AIs4z6nsJQKxTvqQD5keqPZEv0u0kWEsmY0r0cZLzSMoEhVPHTWKg1M4GLEQu48UihI
         Mt2ATbuhnRQVg4ARzq9w1AFNcNMRenCrxjHueiz13wn28iDn8ggC1bhljJ0ciDfdfzF+
         Qcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692710274; x=1693315074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=weQf34xofDODWPjvp/B1jxJ4g6zTpqejkurB//D5bLc=;
        b=G/CNZBuV/2LU5yJqYIhoDxknMQcOVTNJxPA4swVW67I/0pLC6NdlPq5JcpDNFqLzOV
         WkiMqSaY9zJfwsBD79t7JGnCm7ZG4+I5sznPrF617M/F2tDbc6eV8iFLI/4TK4nEPJEs
         WlDAGo4VQnN8NNwmA5Ak1PYaxbKezkTj55Nf2cD1P0hvLR5SvX1QjUFYEYjhYvYI+/U4
         jvmifWdX0nnJYA+tZ4X6QikbQ/doT46i3dSACfq8v1SYmSNbjmjrowcKJ0zOeRVAOOMW
         oF/OleOSxkqI7B/H7T2H48xrO0nYfLpAFAf9dB3GA0exnlT6n3fQO35w2DYkxgk9zCN3
         oS2w==
X-Gm-Message-State: AOJu0Yw3GfmyedgNpjQsTcEsjTGNjBz7RZOAUWyewSS+0uNsaQNY1Nzo
        zSCyX8s2TorF9lXaXNqoVAU=
X-Google-Smtp-Source: AGHT+IGpIJbXPROb0KGQTrSk0eu1HHSozitZU5XK1x8xxqqRSMjA4NvDrxApqmRSyQbbmpI22yYz+g==
X-Received: by 2002:a17:90a:17a4:b0:268:e5db:6e19 with SMTP id q33-20020a17090a17a400b00268e5db6e19mr6759732pja.20.1692710274124;
        Tue, 22 Aug 2023 06:17:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z9-20020a17090ab10900b00262fc3d911esm9536304pjq.28.2023.08.22.06.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 06:17:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 22 Aug 2023 06:17:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
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
Subject: Re: [PATCH v3 1/3] dt-bindings: hwmon: Add Infineon TDA38640
Message-ID: <05ec3dc2-3ed5-4b04-8062-c10777e0a181@roeck-us.net>
References: <20230802193155.2170935-1-Naresh.Solanki@9elements.com>
 <20230808-stand-cheddar-b76b0b7509a0@spud>
 <eced746a-1181-bd8f-6828-4a4eeb79727c@roeck-us.net>
 <20230808-esquire-epidemic-f9bd74ffde25@spud>
 <CABqG17jm938MaEeqS03WeryVWSRBS7Bqq2Vwq9SL4QOGqXU43A@mail.gmail.com>
 <b3eebd2b-c73b-fdc7-2b2b-07e97db26d92@linaro.org>
 <CABqG17hgU44H9KbALy_336Sb+YOiEOzbnAihiox1OEuVnNiayQ@mail.gmail.com>
 <5cde8986-1b12-a85e-b2fe-e1aa1087b429@linaro.org>
 <CABqG17gL7XL0nKZ0QEYkF672AvfJQXapExw3p1iGm88U9idq=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABqG17gL7XL0nKZ0QEYkF672AvfJQXapExw3p1iGm88U9idq=w@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 02:32:31PM +0530, Naresh Solanki wrote:
> Hi
> 
> On Fri, 18 Aug 2023 at 14:53, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 16/08/2023 10:51, Naresh Solanki wrote:
> > > Hi Krzysztof,
> > >
> > > On Tue, 15 Aug 2023 at 01:02, Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> wrote:
> > >>
> > >> On 11/08/2023 18:00, Naresh Solanki wrote:
> > >>> Hi,
> > >>>
> > >>> On Tue, 8 Aug 2023 at 19:58, Conor Dooley <conor@kernel.org> wrote:
> > >>>>
> > >>>> On Tue, Aug 08, 2023 at 07:10:08AM -0700, Guenter Roeck wrote:
> > >>>>> On 8/8/23 04:46, Conor Dooley wrote:
> > >>>>>> On Wed, Aug 02, 2023 at 09:31:51PM +0200, Naresh Solanki wrote:
> > >>>>>>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> > >>>>>>>
> > >>>>>>> The TDA38640 chip has different output control mechanisms depending on
> > >>>>>>> its mode of operation. When the chip is in SVID mode, only
> > >>>>>>> hardware-based output control is supported via ENABLE pin. However, when
> > >>>>>>> it operates in PMBus mode, software control works perfectly.
> > >>>>>>>
> > >>>>>>> To enable software control as a workaround in SVID mode, add the DT
> > >>>>>>> property 'infineon,en-svid-control'. This property will enable the
> > >>>>>>> workaround, which utilizes ENABLE pin polarity flipping for output when
> > >>>>>>> the chip is in SVID mode.
> > >>>>>>
> > >>>>>> Why do you need a custom property for this? How come it is not possible
> > >>>>>> to determine what bus you are on?
> > >>>>>>
> > >>>>>
> > >>>>> That is not the point. Yes, it can be detected if the control method is
> > >>>>> PMBus or SVID. However, in SVID mode, SVID is supposed to control the
> > >>>>> output, not PMBUs. This is bypassed by controlling the polarity of the
> > >>>>> (physical) output enable signal. We do _not_ want this enabled automatically
> > >>>>> in SVID mode. Its side effects on random boards using this chip are unknown.
> > >>>>> Thus, this needs a property which specifically enables this functionality
> > >>>>> for users who _really_ need to use it and (hopefully) know what they are
> > >>>>> doing.
> > >>>>
> > >>>> Hmm, reading this it makes a lot more sense why this is a property - I
> > >>>> guess I just struggled to understand the commit message here,
> > >>>> particularly what the benefit of using the workaround is. I'm still
> > >>>> having difficulty parsing the commit & property text though - its
> > >>>> unclear to me when you would need to use it - so I will stay out
> > >>>> of the way & let Rob or Krzysztof handle things.
> > >>>
> > >>> To provide context, my system employs a unique power sequence
> > >>> strategy utilizing a BMC (Baseboard Management Controller),
> > >>> rendering the reliance on the ENABLE pin unnecessary.
> > >>> In this configuration, the ENABLE pin is grounded in the hardware.
> > >>> While most regulators facilitate PMBus Operation for output control,
> > >>> the TDA38640 chip, when in SVID mode, is constrained by the
> > >>> ENABLE pin to align with Intel specifications.
> > >>> My communication with Infineon confirmed that the recommended
> > >>> approach is to invert the Enable Pin for my use case.
> > >>>
> > >>> Since this is not typically the use case for most setup & hence DT property
> > >>> is must for enabling the special case.
> > >>>
> > >>> For further insight into my setup's power sequence strategy, you can
> > >>> refer to the following link: https://github.com/9elements/pwrseqd
> > >>>
> > >>
> > >> This justifies to me the property, but still you described desired
> > >> driver behavior, not the hardware characteristic. Don't describe what
> > >> you want to control, but describe the entire system.
> > > I guess by entire system you mean how the regulators(including
> > > TDA38640) connected & operated in our setup ?
> >
> > I mean, property name and description should say what is the
> > characteristic of the hardware/firmware/entire system.
> Based on your feedback, will update to below:
> infineon,fixed-level-en-pin:
>     description: |
>       Indicate the ENABLE pin is set at fixed level or left
>       unconnected(has internal pull-up).
>     type: boolean

Messy, because while it reflects physical connectivity, it doesn't reflect
its use in the system at all. The pin may be at fixed level or left
unconnected, but the system vendor doesn't want to give users the
means to control output power (which would be the normal situation).

But then, if that is the only way to get a property accepted, so be it.

Guenter

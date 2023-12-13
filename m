Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE6D811685
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442200AbjLMO42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442078AbjLMO4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:56:00 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760DBE3;
        Wed, 13 Dec 2023 06:56:06 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-336445a2749so11826f8f.0;
        Wed, 13 Dec 2023 06:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702479365; x=1703084165; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sa/zchDvaojeXBmFMfwQ8JH/HiDUmyDtZMznSOw98EI=;
        b=jBarmcXKQJqnOdPIPbzu/wpaDKLgMmPOQkgCa/PlfmGAmuyKgfww80ASz06pm/+KQn
         HPetXqg2YPBQCDfxWnC8DVmGTdhBvT/71qVz8hHkMUMZMGB34OqYUxaylQYIpw3VpTdw
         futOmNMcq1a+wk677GLyC8sYzpU2W8F1p0dLd8ani3ciNqpegmxhxf43WePRVZKp8ShR
         d/EbJj/K60KsC5YGLmHatSeYcLYz9XKbQfvt5Sj8y7KPDaKM905eiUqOAIY4kJ51TN/8
         TQkn64dz21xolTw60xNArGwWogHqf1WV4JUZjIXamI94pNLtEaTNLR1KJVUQ0MmvQqRl
         Md5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702479365; x=1703084165;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sa/zchDvaojeXBmFMfwQ8JH/HiDUmyDtZMznSOw98EI=;
        b=SrGMBWU6lMwNCIVHAEmOY36xZWtRnOvkDx/hmvLaOtvXV/XpcWT0PwMkhkZgAFp0qz
         usJKGzIhZaexTH8ZHg0FRcWya/rBLKUQ0psamlyhs4oegOyjBp4zqv7v+p/SwKb+OR/i
         tiTzxr2BqnoUfj+td1t8yLTlaPj6m8AIJp4ViJEw74usufivGUVt+j5BJlzEpkFI18uN
         AMapT/bQLu0iCxIcC9su+GNueV/8PSo2axtP6kQgQ/WE4B1R+/hcZkh6kT5gOQzlTAes
         frFFW95SPjJO/ITSCpliw2xI85FdEHXiweyoED6++gX+scz3BIcQFoPb/1F0XeMLm9Is
         MitA==
X-Gm-Message-State: AOJu0YzveShG21oUoB0jlTTI+3+ujfvbxHpDzniQAOcNkyQR+wqp45+9
        WnVSzfpr7iEtK1CaMHUzsJU=
X-Google-Smtp-Source: AGHT+IHr7ZoddLBHJcM/c4ufLqq1iksXl4Gfk4t5muApWsCUIqChcPLKmj9ItUPB5t7dqOgvTHcPRg==
X-Received: by 2002:a5d:5309:0:b0:336:3ac4:b8ba with SMTP id e9-20020a5d5309000000b003363ac4b8bamr582998wrv.60.1702479364595;
        Wed, 13 Dec 2023 06:56:04 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id i9-20020a05600011c900b0033635803441sm3317076wrx.110.2023.12.13.06.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:56:04 -0800 (PST)
Message-ID: <6579c604.050a0220.8fe5c.d191@mx.google.com>
X-Google-Original-Message-ID: <ZXnGAhHypc9sPrWu@Ansuel-xps.>
Date:   Wed, 13 Dec 2023 15:56:02 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] thermal: core: add initial support for cold and
 critical_cold trip point
References: <20231212221301.12581-1-ansuelsmth@gmail.com>
 <0e4cee10-4aa4-4979-9841-f1dbd207e0b7@linaro.org>
 <6579bdb2.5d0a0220.1ae22.1f92@mx.google.com>
 <CAJZ5v0gdLXBziENtZ9qmvntmaq6gNSXvGHq1eq8_o+xz0V_A0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gdLXBziENtZ9qmvntmaq6gNSXvGHq1eq8_o+xz0V_A0Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 03:43:54PM +0100, Rafael J. Wysocki wrote:
> On Wed, Dec 13, 2023 at 3:20 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > On Wed, Dec 13, 2023 at 03:12:41PM +0100, Daniel Lezcano wrote:
> > > On 12/12/2023 23:13, Christian Marangi wrote:
> > > > Add initial support for cold and critical_cold trip point. Many if not
> > > > all hwmon and thermal device have normally trip point for hot
> > > > temperature and for cold temperature.
> > > >
> > > > Till now only hot temperature were supported. Add support for also cold
> > > > temperature to permit complete definition of cold trip point in DT.
> > > >
> > > > Thermal driver may use these additional trip point to correctly set
> > > > interrupt for cold temperature values and react based on that with
> > > > various measure like enabling attached heater, forcing higher voltage
> > > > and other specialaized peripherals.
> > > >
> > > > For hwmon drivers this is needed as currently there is a problem with
> > > > setting the full operating range of the device for thermal devices
> > > > defined with hwmon. To better describe the problem, the following
> > > > example is needed:
> > > >
> > > > In the scenario of a simple hwmon with an active trip point declared
> > > > and a cooling device attached, the hwmon subsystem currently set the
> > > > min and max trip point based on the single active trip point.
> > > > Thermal subsystem parse all the trip points and calculate the lowest and
> > > > the highest trip point and calls the .set_trip of hwmon to setup the
> > > > trip points.
> > > >
> > > > The fact that we currently don't have a way to declare the cold/min
> > > > temperature values, makes the thermal subsystem to set the low value as
> > > > -INT_MAX.
> > > > For hwmon drivers that doesn't use clamp_value and actually reject
> > > > invalid values for the trip point, this results in the hwmon settings to
> > > > be rejected.
> > > >
> > > > To permit to pass the correct range of trip point, permit to set in DT
> > > > also cold and critical_cold trip point.
> > > >
> > > > Thermal driver may also define .cold and .critical_cold to act on these
> > > > trip point tripped and apply the required measure.
> > >
> > > Agree with the feature but we need to clarify the semantic of the trip
> > > points first. What actions do we expect for them in order to have like a
> > > mirror reflection of the existing hot trip points.
> > >
> > > What action do you expect with:
> > >
> > >  - 'cold' ?
> > >
> > >  - 'critical_cold' ?
> > >
> > >
> >
> > This is more of a sensible topic but I think it's the thermal driver
> > that needs to implement these. As said in the commit description,
> > examples are setting higher voltage from the attached regulator,
> > enabling some hardware heater.
> 
> So how is it different from an active trip point?  There are heating
> rather than cooling devices associated with it, but other than this??
>

From what I read from documentation, active trip point are used to
trigger cooling-device. Cold (and crit_cold) are to setup trip point to
the device. The device will normally trigger an interrupt (or even
internally with the correct register set autonomously apply some measure
to handle the problem)

In theory it's possible to have passive trip point for cold condition
but still we lack any definition of the lower spectrum of the trip
point.

> > Maybe with critical cold bigger measure can be applied. Currently for
> > critical trip point we shutdown the system (if the critical ops is not
> > declared) but with critical_cold condition I think it won't work... I
> > expect a system in -40°C would just lock up/glitch so rebooting in that
> > condition won't change a thing...
> >
> > Anyway yes we can define a shutdown by default for that but IMHO it
> > wouldn't make much sense.
> 
> So why do you want to add it at all?

Again it's really to fill a hole we have from a long time... One example
is the qcom tsens driver that have trip point for cold and crit_cold.
Those in theory can be set in DT with the trip point but we lack any
definition for them. (using passive trip point would be confusing IMHO)

Another example is an Aquantia PHY that have register for the cold and
critical_cold trip point.

Currently defining a critical trip point for the negative temp results
in the system shutdown.

-- 
	Ansuel

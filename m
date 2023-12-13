Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68FC8110C0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378835AbjLMMGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378812AbjLMMGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:06:06 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDCB10A;
        Wed, 13 Dec 2023 04:06:10 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-336378d3bfdso813634f8f.1;
        Wed, 13 Dec 2023 04:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702469169; x=1703073969; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TlDbUSpDUWcXzMYX25Kb5pfDJJH4Kj3A+SZ42orQHeg=;
        b=Dx71GK48jMmXFIJ250l1/1pv67Dgz3Bv8kZzYynMJfF8yufLtt3X7PMqT+6luDFnsa
         6w+wj7yTUqYTIKFmKqmhTCbINdAsmUGTEfZYJ+SqLfs/p9noovLUNqxWtHPlxff9PM/f
         sCPFfa6z2+PffJ2YQYFfr/EFc7ztfblAG/noDqXqukSTGjFWQgCKJSgn1A8nHd2JY4FK
         VY03VoI93s5vnVUsngFkPp+XiqwTHWHHbJjR9jOoCCoNclWn1TtA/ALVL7YlkWctlUvm
         NAAiwWPxxL+yabKKVhRvAfUQTcXwsQpfPMhmSFDJ1Ip4zdG9DRmetV2U0x/hTH00zroq
         nl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702469169; x=1703073969;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TlDbUSpDUWcXzMYX25Kb5pfDJJH4Kj3A+SZ42orQHeg=;
        b=TgfIQFon+65DQjiUQzbpYZERbmDnXtsthtB2iWBopJqt89J5HALpUDLyJz++/NRtJt
         MBc64dPJxl0jgDB2VziN1OGQxxJfH2bHJYuFWKw56W5SBc+LtixOjauW7x9bpNtmMrH0
         dRDGAQ3zFAWpDbHtKUn3qP/o8hgkWSdTfBqkAecbY1gET2JFMq0yDQZtuXAnDdgR0Kvx
         MOE5cvOox2MYe/WmP6JxxosCbJqGTLZ4hzKvcMDnAbUY4FSxgrv8L1hq7vrGoSrxXb0y
         UKbIUN+O3MGdQfOK8VWJJOXumtPLoSvEtwlCGDiHYAXvZpX3xLz9T8sWJrnAztH1jKw0
         64Dw==
X-Gm-Message-State: AOJu0YyZdArbQxbTuV9VqBNJlGouQpiQJF/1vtlZ8NaWG/pEhSK0+BtJ
        ejOehQq7AB7EHb/DGysn3II=
X-Google-Smtp-Source: AGHT+IFgEbfhXjCpArRJQ7JIlDerISrhrY2gn3YURNxHRfsck7KEAoNRo2VcQEE+nqGQeFZO2MbZzg==
X-Received: by 2002:a05:6000:4c6:b0:333:2e15:632c with SMTP id h6-20020a05600004c600b003332e15632cmr3739285wri.10.1702469168549;
        Wed, 13 Dec 2023 04:06:08 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id g9-20020a5d4889000000b0033609584b9dsm12965741wrq.74.2023.12.13.04.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 04:06:07 -0800 (PST)
Message-ID: <65799e2f.5d0a0220.1213a.f035@mx.google.com>
X-Google-Original-Message-ID: <ZXmeLUnsJikjY1X2@Ansuel-xps.>
Date:   Wed, 13 Dec 2023 13:06:05 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] thermal: core: add initial support for cold and
 critical_cold trip point
References: <20231212221301.12581-1-ansuelsmth@gmail.com>
 <CAJZ5v0gTUSFeR=8ov_CgMzkPF7hJ4_MXYZNvsONC8wMxyhiu=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gTUSFeR=8ov_CgMzkPF7hJ4_MXYZNvsONC8wMxyhiu=A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 01:01:51PM +0100, Rafael J. Wysocki wrote:
> On Tue, Dec 12, 2023 at 11:17 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > Add initial support for cold and critical_cold trip point. Many if not
> > all hwmon and thermal device have normally trip point for hot
> > temperature and for cold temperature.
> >
> > Till now only hot temperature were supported. Add support for also cold
> > temperature to permit complete definition of cold trip point in DT.
> >
> > Thermal driver may use these additional trip point to correctly set
> > interrupt for cold temperature values and react based on that with
> > various measure like enabling attached heater, forcing higher voltage
> > and other specialaized peripherals.
> >
> > For hwmon drivers this is needed as currently there is a problem with
> > setting the full operating range of the device for thermal devices
> > defined with hwmon. To better describe the problem, the following
> > example is needed:
> >
> > In the scenario of a simple hwmon with an active trip point declared
> > and a cooling device attached, the hwmon subsystem currently set the
> > min and max trip point based on the single active trip point.
> > Thermal subsystem parse all the trip points and calculate the lowest and
> > the highest trip point and calls the .set_trip of hwmon to setup the
> > trip points.
> >
> > The fact that we currently don't have a way to declare the cold/min
> > temperature values, makes the thermal subsystem to set the low value as
> > -INT_MAX.
> > For hwmon drivers that doesn't use clamp_value and actually reject
> > invalid values for the trip point, this results in the hwmon settings to
> > be rejected.
> >
> > To permit to pass the correct range of trip point, permit to set in DT
> > also cold and critical_cold trip point.
> >
> > Thermal driver may also define .cold and .critical_cold to act on these
> > trip point tripped and apply the required measure.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> Generally speaking, it is kind of late in the cycle for adding
> significant new features like this.  We can get to it when 6.8-rc1 is
> out, so please resend then.
>

Ok no problem.

> Also it would be nice to define/document the cold and crtitical_cold
> trip points somewhere and is there a better name for critical_cold?
> 

Ehhh I think critical_cold is the only correct one.
Thermal device normally have lowest low high and highest trip point. I
think the lowest has to match what we use for highest (critical). Using
coldest might be confusing and wouldn't display a critical condition of
low temp where the device can't work and immediate actions has to be
taken. 

> > ---
> >  drivers/thermal/thermal_core.c  | 13 +++++++++++++
> >  drivers/thermal/thermal_of.c    |  2 ++
> >  drivers/thermal/thermal_sysfs.c |  4 ++++
> >  drivers/thermal/thermal_trace.h |  4 ++++
> >  include/linux/thermal.h         |  2 ++
> >  include/uapi/linux/thermal.h    |  2 ++
> >  6 files changed, 27 insertions(+)
> >
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> > index 9c17d35ccbbd..3c5ab560e72f 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -344,6 +344,17 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
> >                 tz->ops->hot(tz);
> >  }
> >
> > +static void handle_critical_cold_trips(struct thermal_zone_device *tz,
> > +                                      const struct thermal_trip *trip)
> > +{
> > +       trace_thermal_zone_trip(tz, thermal_zone_trip_id(tz, trip), trip->type);
> > +
> > +       if (trip->type == THERMAL_TRIP_CRITICAL_COLD && tz->ops->critical_cold)
> > +               tz->ops->critical_cold(tz);
> > +       else if (trip->type == THERMAL_TRIP_COLD && tz->ops->cold)
> > +               tz->ops->cold(tz);
> > +}
> > +
> >  static void handle_thermal_trip(struct thermal_zone_device *tz,
> >                                 const struct thermal_trip *trip)
> >  {
> > @@ -365,6 +376,8 @@ static void handle_thermal_trip(struct thermal_zone_device *tz,
> >
> >         if (trip->type == THERMAL_TRIP_CRITICAL || trip->type == THERMAL_TRIP_HOT)
> >                 handle_critical_trips(tz, trip);
> > +       else if (trip->type == THERMAL_TRIP_CRITICAL_COLD || trip->type == THERMAL_TRIP_COLD)
> > +               handle_critical_cold_trips(tz, trip);
> >         else
> >                 handle_non_critical_trips(tz, trip);
> >  }
> > diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> > index 1e0655b63259..95bc600bb4b8 100644
> > --- a/drivers/thermal/thermal_of.c
> > +++ b/drivers/thermal/thermal_of.c
> > @@ -60,6 +60,8 @@ static const char * const trip_types[] = {
> >         [THERMAL_TRIP_PASSIVE]  = "passive",
> >         [THERMAL_TRIP_HOT]      = "hot",
> >         [THERMAL_TRIP_CRITICAL] = "critical",
> > +       [THERMAL_TRIP_COLD]     = "cold",
> > +       [THERMAL_TRIP_CRITICAL_COLD] = "critical_cold",
> >  };
> >
> >  /**
> > diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> > index eef40d4f3063..e1e69e0991c2 100644
> > --- a/drivers/thermal/thermal_sysfs.c
> > +++ b/drivers/thermal/thermal_sysfs.c
> > @@ -106,6 +106,10 @@ trip_point_type_show(struct device *dev, struct device_attribute *attr,
> >                 return sprintf(buf, "critical\n");
> >         case THERMAL_TRIP_HOT:
> >                 return sprintf(buf, "hot\n");
> > +       case THERMAL_TRIP_COLD:
> > +               return sprintf(buf, "cold\n");
> > +       case THERMAL_TRIP_CRITICAL_COLD:
> > +               return sprintf(buf, "critical_cold\n");
> >         case THERMAL_TRIP_PASSIVE:
> >                 return sprintf(buf, "passive\n");
> >         case THERMAL_TRIP_ACTIVE:
> > diff --git a/drivers/thermal/thermal_trace.h b/drivers/thermal/thermal_trace.h
> > index 459c8ce6cf3b..0a4f96075d7d 100644
> > --- a/drivers/thermal/thermal_trace.h
> > +++ b/drivers/thermal/thermal_trace.h
> > @@ -11,6 +11,8 @@
> >
> >  TRACE_DEFINE_ENUM(THERMAL_TRIP_CRITICAL);
> >  TRACE_DEFINE_ENUM(THERMAL_TRIP_HOT);
> > +TRACE_DEFINE_ENUM(THERMAL_TRIP_COLD);
> > +TRACE_DEFINE_ENUM(THERMAL_TRIP_CRITICAL_COLD);
> >  TRACE_DEFINE_ENUM(THERMAL_TRIP_PASSIVE);
> >  TRACE_DEFINE_ENUM(THERMAL_TRIP_ACTIVE);
> >
> > @@ -18,6 +20,8 @@ TRACE_DEFINE_ENUM(THERMAL_TRIP_ACTIVE);
> >         __print_symbolic(type,                                  \
> >                          { THERMAL_TRIP_CRITICAL, "CRITICAL"},  \
> >                          { THERMAL_TRIP_HOT,      "HOT"},       \
> > +                        { THERMAL_TRIP_COLD,      "COLD"},     \
> > +                        { THERMAL_TRIP_CRITICAL_COLD, "CRITICAL_COLD"}, \
> >                          { THERMAL_TRIP_PASSIVE,  "PASSIVE"},   \
> >                          { THERMAL_TRIP_ACTIVE,   "ACTIVE"})
> >
> > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > index cee814d5d1ac..d6345c9ec50d 100644
> > --- a/include/linux/thermal.h
> > +++ b/include/linux/thermal.h
> > @@ -84,6 +84,8 @@ struct thermal_zone_device_ops {
> >                           const struct thermal_trip *, enum thermal_trend *);
> >         void (*hot)(struct thermal_zone_device *);
> >         void (*critical)(struct thermal_zone_device *);
> > +       void (*cold)(struct thermal_zone_device *);
> > +       void (*critical_cold)(struct thermal_zone_device *);
> >  };
> >
> >  struct thermal_cooling_device_ops {
> > diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
> > index fc78bf3aead7..7fa1ba0dff05 100644
> > --- a/include/uapi/linux/thermal.h
> > +++ b/include/uapi/linux/thermal.h
> > @@ -14,6 +14,8 @@ enum thermal_trip_type {
> >         THERMAL_TRIP_PASSIVE,
> >         THERMAL_TRIP_HOT,
> >         THERMAL_TRIP_CRITICAL,
> > +       THERMAL_TRIP_COLD,
> > +       THERMAL_TRIP_CRITICAL_COLD,
> >  };
> >
> >  /* Adding event notification support elements */
> > --
> > 2.40.1
> >

-- 
	Ansuel

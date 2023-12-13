Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43B881147D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441884AbjLMOUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441849AbjLMOUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:20:31 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6748CD0;
        Wed, 13 Dec 2023 06:20:37 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3333fbbeab9so5947645f8f.2;
        Wed, 13 Dec 2023 06:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702477236; x=1703082036; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bVm8QFJMd6O/w77sQyOURR/hVbb6OBIbMzpfk2XfCKA=;
        b=iaCIfZYJEM6iHH/Gex+KNGrTSpQ66L8R26gAoHPNCCb4+S0Ru+IhR8lMUzQHvw/6Im
         5trenvRUt9LkV4m9JtkMfBw+HnpkQsAumLUvWzc4GHpGzLe682Bh+BPp1IetzRtmL72v
         kqYRlEU7f7loXO4GlPRc+E5H67+Ft51Enetl2eeNOxZtrSJSB4HY3dOO7Vta8a3pR23p
         liE2Gpj03Pq+dBuEJBsbUqItgzq8kW/ospSMWsE50ORHYljteEjl2R9IC7NFMggaH3xk
         nBGBXn/8TsrfCaVTAggFVswflYymDz7dOd1V3V8qG1vqc7do9+hOFAA8ySOmxlT2kQpV
         ShiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702477236; x=1703082036;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bVm8QFJMd6O/w77sQyOURR/hVbb6OBIbMzpfk2XfCKA=;
        b=ikhui0XNSiwNWhw0X529vCTZC8b3WX19J60oYV7XYiDDD0ROmwfSxdqWQ8bS+R1Rkm
         WqYNTik+2E21E0YVbMQ6JkmawTztptU70Kdh7Knt9GIBOJDG5vgiC4b3Eeo1sVxmHvgj
         Lw6CvF8Dvokbk/0AL/LhxJMjf5ZTSNg1jMpLNqFN6NhfxA5SQKH6WjHgkDFJzuqfXJr8
         pcYsiQQp56uK847hWHlndfTswkDAl9L8glbQ6s/KDZysCFVPyXAQv0HtXZGnVYE/0nw/
         kLQ1EAHcO2yVIrcKW75xJ8ITbdoNWxRr5SLei2xsRrW0oF0QPnKpG91mhNhVSx8BvAny
         4ufA==
X-Gm-Message-State: AOJu0YyxXiJpUUxn/kQuISPaJ44H6NDDrNg8yukfvfB4jy07s7y2nqS2
        5ita/Hiw58H+0MMYT+GK9khgObrRFhs=
X-Google-Smtp-Source: AGHT+IFSzyGZ3pXTadX5aHXgeOylNklh8Xe1FtNE4P6Ya10WfyyioEkSJWI2TERiCKIoyTlhOXKPrg==
X-Received: by 2002:a5d:620c:0:b0:332:e75b:7f5a with SMTP id y12-20020a5d620c000000b00332e75b7f5amr4135660wru.11.1702477235347;
        Wed, 13 Dec 2023 06:20:35 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id k14-20020a5d524e000000b00333479734a7sm13412163wrc.99.2023.12.13.06.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:20:34 -0800 (PST)
Message-ID: <6579bdb2.5d0a0220.1ae22.1f92@mx.google.com>
X-Google-Original-Message-ID: <ZXm9sApBerVJuhQ2@Ansuel-xps.>
Date:   Wed, 13 Dec 2023 15:20:32 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] thermal: core: add initial support for cold and
 critical_cold trip point
References: <20231212221301.12581-1-ansuelsmth@gmail.com>
 <0e4cee10-4aa4-4979-9841-f1dbd207e0b7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e4cee10-4aa4-4979-9841-f1dbd207e0b7@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 03:12:41PM +0100, Daniel Lezcano wrote:
> On 12/12/2023 23:13, Christian Marangi wrote:
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
> 
> Agree with the feature but we need to clarify the semantic of the trip
> points first. What actions do we expect for them in order to have like a
> mirror reflection of the existing hot trip points.
> 
> What action do you expect with:
> 
>  - 'cold' ?
> 
>  - 'critical_cold' ?
> 
>

This is more of a sensible topic but I think it's the thermal driver
that needs to implement these. As said in the commit description,
examples are setting higher voltage from the attached regulator,
enabling some hardware heater.

Maybe with critical cold bigger measure can be applied. Currently for
critical trip point we shutdown the system (if the critical ops is not
declared) but with critical_cold condition I think it won't work... I
expect a system in -40°C would just lock up/glitch so rebooting in that
condition won't change a thing...

Anyway yes we can define a shutdown by default for that but IMHO it
wouldn't make much sense.

> 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> Why are there two different names for the same email address?
> 
>  - Christian Marangi <ansuelsmth@gmail.com>
>  - Ansuel Smith <ansuelsmth@gmail.com>
> 

Stupid mistake in my ""childhood"". Ansuel it's my second name, when I
understood things have started to become more serious I fixed the very
stupid thing and started using correct naming. I'm extremely sorry for
the mistake I did and I know all the problems it does cause doing that.

> 
> > ---
> >   drivers/thermal/thermal_core.c  | 13 +++++++++++++
> >   drivers/thermal/thermal_of.c    |  2 ++
> >   drivers/thermal/thermal_sysfs.c |  4 ++++
> >   drivers/thermal/thermal_trace.h |  4 ++++
> >   include/linux/thermal.h         |  2 ++
> >   include/uapi/linux/thermal.h    |  2 ++
> >   6 files changed, 27 insertions(+)
> > 
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> > index 9c17d35ccbbd..3c5ab560e72f 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -344,6 +344,17 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
> >   		tz->ops->hot(tz);
> >   }
> > +static void handle_critical_cold_trips(struct thermal_zone_device *tz,
> > +				       const struct thermal_trip *trip)
> > +{
> > +	trace_thermal_zone_trip(tz, thermal_zone_trip_id(tz, trip), trip->type);
> > +
> > +	if (trip->type == THERMAL_TRIP_CRITICAL_COLD && tz->ops->critical_cold)
> > +		tz->ops->critical_cold(tz);
> > +	else if (trip->type == THERMAL_TRIP_COLD && tz->ops->cold)
> > +		tz->ops->cold(tz);
> > +}
> > +
> >   static void handle_thermal_trip(struct thermal_zone_device *tz,
> >   				const struct thermal_trip *trip)
> >   {
> > @@ -365,6 +376,8 @@ static void handle_thermal_trip(struct thermal_zone_device *tz,
> >   	if (trip->type == THERMAL_TRIP_CRITICAL || trip->type == THERMAL_TRIP_HOT)
> >   		handle_critical_trips(tz, trip);
> > +	else if (trip->type == THERMAL_TRIP_CRITICAL_COLD || trip->type == THERMAL_TRIP_COLD)
> > +		handle_critical_cold_trips(tz, trip);
> >   	else
> >   		handle_non_critical_trips(tz, trip);
> >   }
> > diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> > index 1e0655b63259..95bc600bb4b8 100644
> > --- a/drivers/thermal/thermal_of.c
> > +++ b/drivers/thermal/thermal_of.c
> > @@ -60,6 +60,8 @@ static const char * const trip_types[] = {
> >   	[THERMAL_TRIP_PASSIVE]	= "passive",
> >   	[THERMAL_TRIP_HOT]	= "hot",
> >   	[THERMAL_TRIP_CRITICAL]	= "critical",
> > +	[THERMAL_TRIP_COLD]	= "cold",
> > +	[THERMAL_TRIP_CRITICAL_COLD] = "critical_cold",
> >   };
> >   /**
> > diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> > index eef40d4f3063..e1e69e0991c2 100644
> > --- a/drivers/thermal/thermal_sysfs.c
> > +++ b/drivers/thermal/thermal_sysfs.c
> > @@ -106,6 +106,10 @@ trip_point_type_show(struct device *dev, struct device_attribute *attr,
> >   		return sprintf(buf, "critical\n");
> >   	case THERMAL_TRIP_HOT:
> >   		return sprintf(buf, "hot\n");
> > +	case THERMAL_TRIP_COLD:
> > +		return sprintf(buf, "cold\n");
> > +	case THERMAL_TRIP_CRITICAL_COLD:
> > +		return sprintf(buf, "critical_cold\n");
> >   	case THERMAL_TRIP_PASSIVE:
> >   		return sprintf(buf, "passive\n");
> >   	case THERMAL_TRIP_ACTIVE:
> > diff --git a/drivers/thermal/thermal_trace.h b/drivers/thermal/thermal_trace.h
> > index 459c8ce6cf3b..0a4f96075d7d 100644
> > --- a/drivers/thermal/thermal_trace.h
> > +++ b/drivers/thermal/thermal_trace.h
> > @@ -11,6 +11,8 @@
> >   TRACE_DEFINE_ENUM(THERMAL_TRIP_CRITICAL);
> >   TRACE_DEFINE_ENUM(THERMAL_TRIP_HOT);
> > +TRACE_DEFINE_ENUM(THERMAL_TRIP_COLD);
> > +TRACE_DEFINE_ENUM(THERMAL_TRIP_CRITICAL_COLD);
> >   TRACE_DEFINE_ENUM(THERMAL_TRIP_PASSIVE);
> >   TRACE_DEFINE_ENUM(THERMAL_TRIP_ACTIVE);
> > @@ -18,6 +20,8 @@ TRACE_DEFINE_ENUM(THERMAL_TRIP_ACTIVE);
> >   	__print_symbolic(type,					\
> >   			 { THERMAL_TRIP_CRITICAL, "CRITICAL"},	\
> >   			 { THERMAL_TRIP_HOT,      "HOT"},	\
> > +			 { THERMAL_TRIP_COLD,      "COLD"},	\
> > +			 { THERMAL_TRIP_CRITICAL_COLD, "CRITICAL_COLD"}, \
> >   			 { THERMAL_TRIP_PASSIVE,  "PASSIVE"},	\
> >   			 { THERMAL_TRIP_ACTIVE,   "ACTIVE"})
> > diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> > index cee814d5d1ac..d6345c9ec50d 100644
> > --- a/include/linux/thermal.h
> > +++ b/include/linux/thermal.h
> > @@ -84,6 +84,8 @@ struct thermal_zone_device_ops {
> >   			  const struct thermal_trip *, enum thermal_trend *);
> >   	void (*hot)(struct thermal_zone_device *);
> >   	void (*critical)(struct thermal_zone_device *);
> > +	void (*cold)(struct thermal_zone_device *);
> > +	void (*critical_cold)(struct thermal_zone_device *);
> >   };
> >   struct thermal_cooling_device_ops {
> > diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
> > index fc78bf3aead7..7fa1ba0dff05 100644
> > --- a/include/uapi/linux/thermal.h
> > +++ b/include/uapi/linux/thermal.h
> > @@ -14,6 +14,8 @@ enum thermal_trip_type {
> >   	THERMAL_TRIP_PASSIVE,
> >   	THERMAL_TRIP_HOT,
> >   	THERMAL_TRIP_CRITICAL,
> > +	THERMAL_TRIP_COLD,
> > +	THERMAL_TRIP_CRITICAL_COLD,
> >   };
> >   /* Adding event notification support elements */
> 
> -- 
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 

-- 
	Ansuel

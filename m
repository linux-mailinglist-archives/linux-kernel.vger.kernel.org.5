Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A6280FA5B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377756AbjLLWQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjLLWQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:16:55 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6F5AC;
        Tue, 12 Dec 2023 14:17:00 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c3984f0cdso47326275e9.1;
        Tue, 12 Dec 2023 14:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702419419; x=1703024219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mMdH27R0nN/kULVb9qDYym6teaR7gKvUH7s4Uj8Xhzk=;
        b=XBEqpIysjMlPITg+9VrSdvec9/FPZFZQS2POFtZ4LQJNJHbcvM/NwWnqP+Z+LY8gYR
         VMLMXMV7qhavqanbvEFLF5odbenSTaHxaGc781lRB2nABjXqJodNruNOuWwcRHx0UZLa
         ppc+YKw9tzEbcOziaGbf+p6mN4/DbbziV/ntngRbyQgjJWG3CDv0XLtXqW2plFDnpSqT
         alSrIxo/8jG7ZHJkqNTa7bnY/KSXp9sEkM0ovkyktnb5wJick8jA9LK1G6UVmxjwKDkN
         CtgD2x9GdIBjgezQewPk1i4mmPVmmsfBVfK3wj4ZT9kNzX0gTnyCBymdTiqxgyTB9sxp
         tG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702419419; x=1703024219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mMdH27R0nN/kULVb9qDYym6teaR7gKvUH7s4Uj8Xhzk=;
        b=izs6Q++Md9Ry4nwbyB6ey/r01jk/3FS/uxLWswLcywGMS5NAjiSuJxZaudzLqLox4r
         Y7QX1m1IDfvpKdM4BsvAsTNSSgPM+Kgjolb9sh0h8VOl2ppDee4WFEocari02vrUMNHv
         phefhhfckqIlsL00awEyqpx4pCKWytGwjKGveCqS1VhAhd3jhm0mMYxA35o5pAmhmfNa
         50FtW4oToTLET441PbHbEv/1iV4j3g8DOOBR++nZyX+S7xdCdGRCvVwGZJ5h2/N8VEue
         x1TegDGSfENQ3eJAZu0fbL7KGKDt6AxtIIkiJeI+19rK6ktqy723yFEPqk8LU76hDiL2
         iXeQ==
X-Gm-Message-State: AOJu0YzgwxneTUWHmcm1PCxzz2IXBbRZIx1i/vlZWY7xowayqS6NTjYk
        N+4IbWEfJoXR62kRsqH20MM=
X-Google-Smtp-Source: AGHT+IGpWMvk3w2WBsjvLTwqd8+znDQJoZvzBhblaodMLhpprF0VQCaW10TN1H0hYQMf1FSfjnzhbQ==
X-Received: by 2002:a7b:ce13:0:b0:40c:311d:c676 with SMTP id m19-20020a7bce13000000b0040c311dc676mr3727486wmc.137.1702419418813;
        Tue, 12 Dec 2023 14:16:58 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id m11-20020a056000008b00b0033332524235sm11669113wrx.82.2023.12.12.14.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 14:16:58 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] thermal: core: add initial support for cold and critical_cold trip point
Date:   Tue, 12 Dec 2023 23:13:00 +0100
Message-Id: <20231212221301.12581-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support for cold and critical_cold trip point. Many if not
all hwmon and thermal device have normally trip point for hot
temperature and for cold temperature.

Till now only hot temperature were supported. Add support for also cold
temperature to permit complete definition of cold trip point in DT.

Thermal driver may use these additional trip point to correctly set
interrupt for cold temperature values and react based on that with
various measure like enabling attached heater, forcing higher voltage
and other specialaized peripherals.

For hwmon drivers this is needed as currently there is a problem with
setting the full operating range of the device for thermal devices
defined with hwmon. To better describe the problem, the following
example is needed:

In the scenario of a simple hwmon with an active trip point declared
and a cooling device attached, the hwmon subsystem currently set the
min and max trip point based on the single active trip point.
Thermal subsystem parse all the trip points and calculate the lowest and
the highest trip point and calls the .set_trip of hwmon to setup the
trip points.

The fact that we currently don't have a way to declare the cold/min
temperature values, makes the thermal subsystem to set the low value as
-INT_MAX.
For hwmon drivers that doesn't use clamp_value and actually reject
invalid values for the trip point, this results in the hwmon settings to
be rejected.

To permit to pass the correct range of trip point, permit to set in DT
also cold and critical_cold trip point.

Thermal driver may also define .cold and .critical_cold to act on these
trip point tripped and apply the required measure.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/thermal/thermal_core.c  | 13 +++++++++++++
 drivers/thermal/thermal_of.c    |  2 ++
 drivers/thermal/thermal_sysfs.c |  4 ++++
 drivers/thermal/thermal_trace.h |  4 ++++
 include/linux/thermal.h         |  2 ++
 include/uapi/linux/thermal.h    |  2 ++
 6 files changed, 27 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9c17d35ccbbd..3c5ab560e72f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -344,6 +344,17 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 		tz->ops->hot(tz);
 }
 
+static void handle_critical_cold_trips(struct thermal_zone_device *tz,
+				       const struct thermal_trip *trip)
+{
+	trace_thermal_zone_trip(tz, thermal_zone_trip_id(tz, trip), trip->type);
+
+	if (trip->type == THERMAL_TRIP_CRITICAL_COLD && tz->ops->critical_cold)
+		tz->ops->critical_cold(tz);
+	else if (trip->type == THERMAL_TRIP_COLD && tz->ops->cold)
+		tz->ops->cold(tz);
+}
+
 static void handle_thermal_trip(struct thermal_zone_device *tz,
 				const struct thermal_trip *trip)
 {
@@ -365,6 +376,8 @@ static void handle_thermal_trip(struct thermal_zone_device *tz,
 
 	if (trip->type == THERMAL_TRIP_CRITICAL || trip->type == THERMAL_TRIP_HOT)
 		handle_critical_trips(tz, trip);
+	else if (trip->type == THERMAL_TRIP_CRITICAL_COLD || trip->type == THERMAL_TRIP_COLD)
+		handle_critical_cold_trips(tz, trip);
 	else
 		handle_non_critical_trips(tz, trip);
 }
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 1e0655b63259..95bc600bb4b8 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -60,6 +60,8 @@ static const char * const trip_types[] = {
 	[THERMAL_TRIP_PASSIVE]	= "passive",
 	[THERMAL_TRIP_HOT]	= "hot",
 	[THERMAL_TRIP_CRITICAL]	= "critical",
+	[THERMAL_TRIP_COLD]	= "cold",
+	[THERMAL_TRIP_CRITICAL_COLD] = "critical_cold",
 };
 
 /**
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index eef40d4f3063..e1e69e0991c2 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -106,6 +106,10 @@ trip_point_type_show(struct device *dev, struct device_attribute *attr,
 		return sprintf(buf, "critical\n");
 	case THERMAL_TRIP_HOT:
 		return sprintf(buf, "hot\n");
+	case THERMAL_TRIP_COLD:
+		return sprintf(buf, "cold\n");
+	case THERMAL_TRIP_CRITICAL_COLD:
+		return sprintf(buf, "critical_cold\n");
 	case THERMAL_TRIP_PASSIVE:
 		return sprintf(buf, "passive\n");
 	case THERMAL_TRIP_ACTIVE:
diff --git a/drivers/thermal/thermal_trace.h b/drivers/thermal/thermal_trace.h
index 459c8ce6cf3b..0a4f96075d7d 100644
--- a/drivers/thermal/thermal_trace.h
+++ b/drivers/thermal/thermal_trace.h
@@ -11,6 +11,8 @@
 
 TRACE_DEFINE_ENUM(THERMAL_TRIP_CRITICAL);
 TRACE_DEFINE_ENUM(THERMAL_TRIP_HOT);
+TRACE_DEFINE_ENUM(THERMAL_TRIP_COLD);
+TRACE_DEFINE_ENUM(THERMAL_TRIP_CRITICAL_COLD);
 TRACE_DEFINE_ENUM(THERMAL_TRIP_PASSIVE);
 TRACE_DEFINE_ENUM(THERMAL_TRIP_ACTIVE);
 
@@ -18,6 +20,8 @@ TRACE_DEFINE_ENUM(THERMAL_TRIP_ACTIVE);
 	__print_symbolic(type,					\
 			 { THERMAL_TRIP_CRITICAL, "CRITICAL"},	\
 			 { THERMAL_TRIP_HOT,      "HOT"},	\
+			 { THERMAL_TRIP_COLD,      "COLD"},	\
+			 { THERMAL_TRIP_CRITICAL_COLD, "CRITICAL_COLD"}, \
 			 { THERMAL_TRIP_PASSIVE,  "PASSIVE"},	\
 			 { THERMAL_TRIP_ACTIVE,   "ACTIVE"})
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index cee814d5d1ac..d6345c9ec50d 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -84,6 +84,8 @@ struct thermal_zone_device_ops {
 			  const struct thermal_trip *, enum thermal_trend *);
 	void (*hot)(struct thermal_zone_device *);
 	void (*critical)(struct thermal_zone_device *);
+	void (*cold)(struct thermal_zone_device *);
+	void (*critical_cold)(struct thermal_zone_device *);
 };
 
 struct thermal_cooling_device_ops {
diff --git a/include/uapi/linux/thermal.h b/include/uapi/linux/thermal.h
index fc78bf3aead7..7fa1ba0dff05 100644
--- a/include/uapi/linux/thermal.h
+++ b/include/uapi/linux/thermal.h
@@ -14,6 +14,8 @@ enum thermal_trip_type {
 	THERMAL_TRIP_PASSIVE,
 	THERMAL_TRIP_HOT,
 	THERMAL_TRIP_CRITICAL,
+	THERMAL_TRIP_COLD,
+	THERMAL_TRIP_CRITICAL_COLD,
 };
 
 /* Adding event notification support elements */
-- 
2.40.1


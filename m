Return-Path: <linux-kernel+bounces-45316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB13842E6B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 492F1287605
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E7A78B7A;
	Tue, 30 Jan 2024 21:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYeLN6qN"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EBA762DD;
	Tue, 30 Jan 2024 21:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706648816; cv=none; b=Bh3uZIiI0rkCCgoVRrDzMzB+q+V09rbuhDgyskfbd/E0ilSkbp5fGLyT8+QhPvvBxNjeK4lKessL7CX6Mln/hi+8O2xUPRMXKK0rd2QI/Ce8EVPVdYAibjHd1usYJghiJEFibk08Gy1+mrTvQKQhrXbZNUXIdkcJxonHs/aqgeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706648816; c=relaxed/simple;
	bh=uLF/Qmue1+Wzk3XhIihfzQTCEXmbPTvk9jP+cW/SKMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MxMUlQZiefJw0TQP2iWcgTzQnNg4yzUmATM53Hq3pzf4kuZmYlY0QbIagh4PYRak2YrEdaXpgmjAMLNoGTlFH7Zq6zY7CrYD/sLOyMDtiv2/7SgC2b9+c1e8CGMNVJPcXKTr5fpnOIrAWneaoBlvPXRUzswkV9G3MJyVz9kd1HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYeLN6qN; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a34c5ca2537so499045566b.0;
        Tue, 30 Jan 2024 13:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706648813; x=1707253613; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQtvJUU+OqNUf9TfCmUtoX2TLTtaGeLRFukm+fQ1w2U=;
        b=MYeLN6qNjVVNybaJRV9FGYXqcsbFl/yr0Xz3BVO6n4UbecLHUpYtUn9/c4JDpjBVkk
         EjDTfZh9E0a2pvI/IBK3Fg9pX2aeUuieHVqHZa86RbC6Xs1QQqLr5cCaZl9S5LRB0dO9
         z0MntVlI3oBxp6eVUdCqOC2MhdwYHeNupbZir/Yo/oWNxbLMrMkb2DJhHKK0DW9Ojqq0
         OvXBOk0CQO2ztSiGO3Hn28bjWjbr2JrPaWuJI8NDwfbIUlSlfdqOUrjfd+d0zvCPj7Vt
         rThhsWL3x48uyNProxlNl1CwjFqPmMB2BVrWY63GPpUA8N4eOMtvhRV6X/P3aPwdbEh/
         K5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706648813; x=1707253613;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQtvJUU+OqNUf9TfCmUtoX2TLTtaGeLRFukm+fQ1w2U=;
        b=F3dwt5kIxl3SZdugev3FoOUgyWb5QJJ/Zjpam5S7Y37tRXgbrk59+I5UMKn67BksGt
         IdFOmU2IP2J2wcrb4y88UloJRrzSZ8fsbMfB6ZfF5P8bNoheg2NfQYe0FP8TbSLB/K+X
         08FO1Exh1Ycscga5uYEMh5xT5+yqTDyFKTUckrEeJY0oJSxrJgBDPuTZcOqejCfICyVW
         alzxrYgNuaxJRAiTjIyjZKIhS1c5OgzouynfCV4zSLwTIe67k8oFUUtRfkXRO5TaGlWw
         JzSBsy/pPczmJySWYXyIIH4yOIrfgtzGKOfm9B6050P1M6l0UU5EY1mYchstTZPLYy8Q
         ZFvQ==
X-Gm-Message-State: AOJu0YxLST6uR1jEhOuZbwmi4RT2vIO45vBgAkoXI0SSry4RrIhz9lXa
	o4N8+J3QYmtpRmJrU8rPUrMGiNpfEUHclQ8ilWQyuQZzmEIm3zql
X-Google-Smtp-Source: AGHT+IE7jIrmgeOq4vCSI0+9AQSg9oLjTu6kevG43kjrQUqhj1DyGkMA7jqRnBAGjEF9+kaQM9OzeA==
X-Received: by 2002:a17:906:1703:b0:a28:2165:7c74 with SMTP id c3-20020a170906170300b00a2821657c74mr6714400eje.13.1706648812450;
        Tue, 30 Jan 2024 13:06:52 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-7400-ff68-7ab4-4169.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:7400:ff68:7ab4:4169])
        by smtp.gmail.com with ESMTPSA id vv9-20020a170907a68900b00a354a5d2c39sm4177658ejc.31.2024.01.30.13.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:06:52 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 30 Jan 2024 22:06:45 +0100
Subject: [PATCH v6 2/5] hwmon: (core) Add support for humidity min/max
 alarm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-topic-chipcap2-v6-2-260bea05cf9b@gmail.com>
References: <20240130-topic-chipcap2-v6-0-260bea05cf9b@gmail.com>
In-Reply-To: <20240130-topic-chipcap2-v6-0-260bea05cf9b@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706648808; l=1810;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=uLF/Qmue1+Wzk3XhIihfzQTCEXmbPTvk9jP+cW/SKMg=;
 b=Rw6EQWW4CWmGJ3m9Vp1Pt2qAtCMUx4XzR/QlV8oumy6at0oar4qK3QBRzng+inKt/Z1oYG3ID
 VYxEk5A8TEQDCtZQdVQnSHcvwqidbJiqEa6tbENi5lPscRlVarkpvwv
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

Add min_alarm and max_alarm attributes for humidityX to support devices
that can generate these alarms.
Such attributes already exist for other magnitudes such as tempX.

Tested with a ChipCap 2 temperature-humidity sensor.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/hwmon.c | 2 ++
 include/linux/hwmon.h | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index c7dd3f5b2bd5..b51d13f08d27 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -586,6 +586,8 @@ static const char * const hwmon_humidity_attr_templates[] = {
 	[hwmon_humidity_fault] = "humidity%d_fault",
 	[hwmon_humidity_rated_min] = "humidity%d_rated_min",
 	[hwmon_humidity_rated_max] = "humidity%d_rated_max",
+	[hwmon_humidity_min_alarm] = "humidity%d_min_alarm",
+	[hwmon_humidity_max_alarm] = "humidity%d_max_alarm",
 };
 
 static const char * const hwmon_fan_attr_templates[] = {
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 8cd6a6b33593..f553f8cd6946 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -293,6 +293,8 @@ enum hwmon_humidity_attributes {
 	hwmon_humidity_fault,
 	hwmon_humidity_rated_min,
 	hwmon_humidity_rated_max,
+	hwmon_humidity_min_alarm,
+	hwmon_humidity_max_alarm,
 };
 
 #define HWMON_H_ENABLE			BIT(hwmon_humidity_enable)
@@ -306,6 +308,8 @@ enum hwmon_humidity_attributes {
 #define HWMON_H_FAULT			BIT(hwmon_humidity_fault)
 #define HWMON_H_RATED_MIN		BIT(hwmon_humidity_rated_min)
 #define HWMON_H_RATED_MAX		BIT(hwmon_humidity_rated_max)
+#define HWMON_H_MIN_ALARM		BIT(hwmon_humidity_min_alarm)
+#define HWMON_H_MAX_ALARM		BIT(hwmon_humidity_max_alarm)
 
 enum hwmon_fan_attributes {
 	hwmon_fan_enable,

-- 
2.39.2



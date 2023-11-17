Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D1C7EEC51
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 07:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbjKQGku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 01:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbjKQGkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 01:40:45 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217E9D51;
        Thu, 16 Nov 2023 22:40:42 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5480edd7026so1829375a12.0;
        Thu, 16 Nov 2023 22:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700203240; x=1700808040; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJxvgI9i9l4IaqoW7P3lNFiG+zzz8tjNlzjKlxr/b2E=;
        b=LVYJxwC3q5LbsLzR7h6+6EeT+UoN9uuVzr3DgTasGNXdw7s+80w6PbOsrkd137GhXY
         93cZiJubnuxpwoSGxF0pDSYADufBXBFFaAIJBVfkSKU17iF4re8orhtXsF9zW+a4icJE
         ya81PXSpS+31Eta3FQlnQjXqvSSguT61Fn37xP8RIKJdRCMZ7o852id2bDUq613DmSpk
         KCACtklKs3kQJ/NKYiJD6vEVRLOuM/WOKlwd9K4ol/rkY48FSVl2i4P/0uf8wlyYZr6s
         qSvgxI+NZjDdTZ/G8MrGr8B35xZxNWa3mJiQMkL/b9U899P54z8gQL9cjb0OqHNW4NCQ
         f5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700203240; x=1700808040;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJxvgI9i9l4IaqoW7P3lNFiG+zzz8tjNlzjKlxr/b2E=;
        b=R15Vs9uwOp0Z0x/dfqbddoa1PjB485uAgHBgzREIYVEwXTaVeWZneLzK2I1VRiZId+
         9CuDZUT3F0dJqsd+R2UrG+sMuCchedNpfvqQHKW1/0vpuQF7ng5spjK91N1m+oGMZfAq
         tfW61gUPnQa4j8mnb471PbB2GjdWUlBYDJPw5tzCvPSsHVcGmqcWB1y+Dpm6oYHwCFYV
         8sklIPd107tJkXmm0PNPJGsU4CRg6o5blgAHqdNkcixrPK/mRcCMNypA7dvEiQCcYFH8
         aYndRXz2r8Sb7fOIv/qfAtxJNdnQ9kqYJpi6SS2zhLA9y0lP6jYKBTJ1RhMDglKsZAHj
         fnyA==
X-Gm-Message-State: AOJu0YyjqQNp0GMvuPmqabDongBmDJLQ6etRkJGNZcZ5w8Ka3voF9JZ4
        jbAZlsURIUbORp0AcSiDsEU=
X-Google-Smtp-Source: AGHT+IFOrpU25XrNR3nupY/bjkhARm3+EwaICdUnXky/72dd0BPMuOx3hAcLXpBntM1uVwobzCaRfA==
X-Received: by 2002:a17:906:18e1:b0:9e0:2319:16f0 with SMTP id e1-20020a17090618e100b009e0231916f0mr3941019ejf.65.1700203240514;
        Thu, 16 Nov 2023 22:40:40 -0800 (PST)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id v27-20020a170906489b00b009d2eb40ff9dsm447514ejq.33.2023.11.16.22.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 22:40:39 -0800 (PST)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Fri, 17 Nov 2023 07:40:35 +0100
Subject: [PATCH 2/4] ABI: sysfs-class-hwmon: document missing humidity
 attributes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231116-hwmon_abi-v1-2-8bfb7f51145a@gmail.com>
References: <20231116-hwmon_abi-v1-0-8bfb7f51145a@gmail.com>
In-Reply-To: <20231116-hwmon_abi-v1-0-8bfb7f51145a@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700203237; l=2753;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=Cz+uGSmEvNxYiJra9hc4k5xY8AQoDk7mM0es6NtamR4=;
 b=+58ZzPaTZ2R5I5UWBrwjTwtE5eyOF2ev+T+eTDKkDmU10zs+FameNPN82EcVYp8W8gxFSpfOs
 rxoDZPG3jBuA12wKokQpeHXVGrME2gZhFqleiDFixoLDULBZPxuWKat
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All these attributes already exist and are used by the hwmon subsystem,
but they still must be documented.

The missing attributes are the following:
- humidityY_alarm
- humidityY_fault
- humidityY_label
- humidityY_max
- humidityY_max_hyst
- humidityY_min
- humidityY_min_hyst

Add the missing humidity attributes to the ABI documentation according
to their current usage and access rights in the hwmon subsystem.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-hwmon | 69 +++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-hwmon b/Documentation/ABI/testing/sysfs-class-hwmon
index b998a42add95..dccbcdc2dad8 100644
--- a/Documentation/ABI/testing/sysfs-class-hwmon
+++ b/Documentation/ABI/testing/sysfs-class-hwmon
@@ -887,6 +887,15 @@ Description:
 
 		RW
 
+What:		/sys/class/hwmon/hwmonX/humidityY_alarm
+Description:
+		Humidity limit detection
+
+		- 0: OK
+		- 1: Humidity limit has been reached
+
+		RO
+
 What:		/sys/class/hwmon/hwmonX/humidityY_enable
 Description:
 		Enable or disable the sensors
@@ -899,6 +908,15 @@ Description:
 
 		RW
 
+What:		/sys/class/hwmon/hwmonX/humidityY_fault
+Description:
+		Reports a humidity sensor failure.
+
+		- 1: Failed
+		- 0: Ok
+
+		RO
+
 What:		/sys/class/hwmon/hwmonX/humidityY_input
 Description:
 		Humidity
@@ -907,6 +925,57 @@ Description:
 
 		RO
 
+What:		/sys/class/hwmon/hwmonX/humidityY_label
+Description:
+		Suggested humidity channel label.
+
+		Text string
+
+		Should only be created if the driver has hints about what
+		this humidity channel is being used for, and user-space
+		doesn't. In all other cases, the label is provided by
+		user-space.
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/humidityY_max
+Description:
+		Humidity max value.
+
+		Unit: milli-percent (per cent mille, pcm)
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/humidityY_max_hyst
+Description:
+		Humidity hysteresis value for max limit.
+
+		Unit: milli-percent (per cent mille, pcm)
+
+		Must be reported as an absolute humidity, NOT a delta
+		from the max value.
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/humidityY_min
+Description:
+		Humidity min value.
+
+		Unit: milli-percent (per cent mille, pcm)
+
+		RW
+
+What:		/sys/class/hwmon/hwmonX/humidityY_min_hyst
+Description:
+		Humidity hysteresis value for min limit.
+
+		Unit: milli-percent (per cent mille, pcm)
+
+		Must be reported as an absolute humidity, NOT a delta
+		from the min value.
+
+		RW
+
 What:		/sys/class/hwmon/hwmonX/humidityY_rated_min
 Description:
 		Minimum rated humidity.

-- 
2.39.2


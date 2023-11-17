Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0ABC7EEC54
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 07:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbjKQGkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 01:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbjKQGks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 01:40:48 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372ACD53;
        Thu, 16 Nov 2023 22:40:45 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9e2838bcb5eso230434866b.0;
        Thu, 16 Nov 2023 22:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700203243; x=1700808043; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2dLWB4TJdmX3nxO89fsn3dhr9nJ0AUMxfWGRU8bttDU=;
        b=RpZPtz3G8SEcCweho9deFUd5Fn435b2pxzJDNCR9xRgWPZ47OAdDZiho2K6xS4JJ98
         hHwRqnjKKYRoeRA1hDuUwfQrxqDcPXzF9JbbSIRp5zqx1Q/Vp4LTIEAg9BRStArVV57O
         Nr22MTO3zT0GrecvnoVblCwn03N+Ab8RwEyyOxKNmffWx5B/LzaHsQVJDihgWASrd8P0
         Fj6/NzSfV1nYkddF4Mwki14hsluGnHkzcNDfdohtzqz3pVfK5oFNrxzaOePCkP0Qen+b
         7x1GiaOSK+4M/n3uaDPPCnFGbVW84GJufn6DauhUyWGjkYiOA3mVvHTYWkfagLek5aYm
         DM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700203244; x=1700808044;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dLWB4TJdmX3nxO89fsn3dhr9nJ0AUMxfWGRU8bttDU=;
        b=ChgL8Sh9A1PbMvLIqNYJ/XXf4DM7vdaLpTEbQnMqsrNdh/uGx9jbCIsxg3bV1PLOcY
         0EPd2X2BgED1YGYsZAGyrCuWbLLEnXw3cm2fyTLydUIhd7C/pUnBVY0EwRAHPWR9ls64
         TcSa1M4qAp7jM5yLoo7+UKeAIIvszSsi0OEaTGqEWpB7PJpVqZDVWhwbQalR5Cd0JL/V
         3sZlph3oGGEZl9vxVm+Bg1Hz8OKAn9cuRefUsw83TE410TSuMKwQQJnZb71yPfwtteVL
         3TgZ0ILzTlny8+MK1/fXtW03O2dzjjookYpRufGeUYXyuwpGtk8++x/ep1w+yHJQq3Fn
         P5cA==
X-Gm-Message-State: AOJu0Yw1nFl9kFWWMtcu7cyGQG86NfV2KEqGu+CgjHsVTQFFZa8MeaUk
        isMDIXIkcPS7aZzNvRffG2Y=
X-Google-Smtp-Source: AGHT+IEKw7KYfOCKyRNhrlh7MbrkD1uStIMlwBFq5y8eJmTBJCIpSoK6WrsCfOROQvePB4g/9BvBvw==
X-Received: by 2002:a17:906:3049:b0:9bd:f155:eb54 with SMTP id d9-20020a170906304900b009bdf155eb54mr11432595ejd.6.1700203243693;
        Thu, 16 Nov 2023 22:40:43 -0800 (PST)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id v27-20020a170906489b00b009d2eb40ff9dsm447514ejq.33.2023.11.16.22.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 22:40:42 -0800 (PST)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Fri, 17 Nov 2023 07:40:37 +0100
Subject: [PATCH 4/4] ABI: sysfs-class-hwmon: document emergency/max/min
 temperature alarms
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231116-hwmon_abi-v1-4-8bfb7f51145a@gmail.com>
References: <20231116-hwmon_abi-v1-0-8bfb7f51145a@gmail.com>
In-Reply-To: <20231116-hwmon_abi-v1-0-8bfb7f51145a@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700203237; l=1707;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=XY0nbZ8q1oMfM8UbOjc+Jj6bmU6olGeD0jPvrO16Ex4=;
 b=gpZ6fWnvWcSF5WMBQQPAbLGUSQiLsKt7w+itnCHhJ6+wYF5jzUS3z26Qyb8HWvFjY6ytARHm+
 oc5X/ExoONVCGttoGl2hrmWHAEPIJNcdaglklMiYsHkQnc4WDApqm/7
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

These attributes are widely used in the hwmon subsystem, but they still
must be documented.

Add tempY_emergency_alarm, tempY_max_alarm and tempY_min_alarm to the
ABI documentation according to their current usage and access rights in
the hwmon subsystem.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-hwmon | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-hwmon b/Documentation/ABI/testing/sysfs-class-hwmon
index 3d5e6142ef0c..3dac923c9b0e 100644
--- a/Documentation/ABI/testing/sysfs-class-hwmon
+++ b/Documentation/ABI/testing/sysfs-class-hwmon
@@ -381,6 +381,15 @@ Description:
 
 		RW
 
+What:		/sys/class/hwmon/hwmonX/tempY_max_alarm
+Description:
+		Maximum temperature alarm flag.
+
+		- 0: OK
+		- 1: temperature has reached tempY_max
+
+		RO
+
 What:		/sys/class/hwmon/hwmonX/tempY_min
 Description:
 		Temperature min value.
@@ -389,6 +398,15 @@ Description:
 
 		RW
 
+What:		/sys/class/hwmon/hwmonX/tempY_min_alarm
+Description:
+		Minimum temperature alarm flag.
+
+		- 0: OK
+		- 1: temperature has reached tempY_min
+
+		RO
+
 What:		/sys/class/hwmon/hwmonX/tempY_max_hyst
 Description:
 		Temperature hysteresis value for max limit.
@@ -457,6 +475,15 @@ Description:
 
 		RW
 
+What:		/sys/class/hwmon/hwmonX/tempY_emergency_alarm
+Description:
+		Emergency high temperature alarm flag.
+
+		- 0: OK
+		- 1: temperature has reached tempY_emergency
+
+		RO
+
 What:		/sys/class/hwmon/hwmonX/tempY_emergency_hyst
 Description:
 		Temperature hysteresis value for emergency limit.

-- 
2.39.2


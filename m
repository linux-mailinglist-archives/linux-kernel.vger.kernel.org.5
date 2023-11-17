Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76AB7EEC4D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 07:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbjKQGks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 01:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjKQGko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 01:40:44 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B355D50;
        Thu, 16 Nov 2023 22:40:41 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50a6ff9881fso2416659e87.1;
        Thu, 16 Nov 2023 22:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700203239; x=1700808039; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/sCa8Bm+oY1XaUfCpz6tqc6AYL6sOvOOzJItSekXLU=;
        b=lN/JORR3f77j1TQ/YbdHtElLV0LvIRS+Nj7BV38JtrHlHRwldeVXRzaq4dXxx9iFpQ
         giAWiLWjhyb3QB+S/6dfBkMoXDrookAdm1fBN3pKkSIW30evGK6Ka3vExWkst0500Paf
         J2h07XpFYvEB7iiu7/8LR4TSkdGZAUPWzmJ18InT8LmesXc0bXZxiVahCP5850W1nYTQ
         24xHzPP/ku8gJFpc4nYJEERBKzzVbYsGg4CaTCTOwxB8aBtAWUFSRob/0m0HDPeAPz1I
         7oxG15SkU4ttuW+wokz4rtWZHDqmEc1OuHoIpJfvWCC5b03aE6E7Cdc6X8fG1ejLAw+3
         20Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700203239; x=1700808039;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/sCa8Bm+oY1XaUfCpz6tqc6AYL6sOvOOzJItSekXLU=;
        b=Mi9AlCcYRlDCclipGGi5fgS8hAKG+JT42ch5MgEhN3bgCiNN+cYXCpvrvYKV64JBPA
         RURbC8mHXPBO7kPxXo6DOQxqs/Zpk8Z4xiYCQodEC1NVB5wAS4j6rF+T95Iy/l9hWGnC
         LwtZuLJzQKpbjxZZhArMnNI+MdtyUXVUQk3XT+HfwZ85v8Yhy41XAhGd9LlX3V0NmxUn
         XrSs0GOmz2d4N2tdJRZhggyoBxn72OgZFdX/EwCey/ldPOcd1CNCNl7ZxTTjglM0V/l7
         VdoDtwaGTmNSV+ywKV6GsGvA0SR8LoHxb+JDOQcO2W9UF824d7Q+47fTJGCmc+OwMH/4
         25pg==
X-Gm-Message-State: AOJu0Yz9hhjcUno1Dv8cDIKOYsQwfLl8rp14elsN3QlhuMkjVmXnMPgp
        Nf+81iUR3Da+KVkQ6HHn/TU=
X-Google-Smtp-Source: AGHT+IHgKxDDTh/Gqo+grMp01RdHJlHAiHR1jupvfKOtSnSE4+LreZ/kyhsTc7acW+25nkTfWgpKfw==
X-Received: by 2002:ac2:5475:0:b0:507:9b70:1f0e with SMTP id e21-20020ac25475000000b005079b701f0emr12110426lfn.24.1700203239269;
        Thu, 16 Nov 2023 22:40:39 -0800 (PST)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id v27-20020a170906489b00b009d2eb40ff9dsm447514ejq.33.2023.11.16.22.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 22:40:38 -0800 (PST)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Fri, 17 Nov 2023 07:40:34 +0100
Subject: [PATCH 1/4] ABI: sysfs-class-hwmon: rearrange humidity attributes
 alphabetically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231116-hwmon_abi-v1-1-8bfb7f51145a@gmail.com>
References: <20231116-hwmon_abi-v1-0-8bfb7f51145a@gmail.com>
In-Reply-To: <20231116-hwmon_abi-v1-0-8bfb7f51145a@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700203237; l=1384;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=AUAGi/qOoExr3Pui4zFOuuEaMbHFWY7lD1IotDyo1SU=;
 b=Maru+tzEBZzNL8Sf5c/1lQzvtEyadue6xnFarIEWDQKRbolBAWkONQI6AjBpFCYHEqtUQHAJ1
 F1Vchf8whMbA327hPcmloNxDnYMBRMRodjgGyZtep1wLWQxYl/I2w/d
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

Preliminary step to add the missing humidity attributes in the ABI
documentation.

Adding new elements alphabetically is a common practice that has been
loosely followed in the sysfs-class-hwmon documentation. Since most of
the humidity attributes must be added to the file, a single attribute
needs to be rearranged to reinforce alphabetical order.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-hwmon | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-hwmon b/Documentation/ABI/testing/sysfs-class-hwmon
index 638f4c6d4ec7..b998a42add95 100644
--- a/Documentation/ABI/testing/sysfs-class-hwmon
+++ b/Documentation/ABI/testing/sysfs-class-hwmon
@@ -887,15 +887,6 @@ Description:
 
 		RW
 
-What:		/sys/class/hwmon/hwmonX/humidityY_input
-Description:
-		Humidity
-
-		Unit: milli-percent (per cent mille, pcm)
-
-		RO
-
-
 What:		/sys/class/hwmon/hwmonX/humidityY_enable
 Description:
 		Enable or disable the sensors
@@ -908,6 +899,14 @@ Description:
 
 		RW
 
+What:		/sys/class/hwmon/hwmonX/humidityY_input
+Description:
+		Humidity
+
+		Unit: milli-percent (per cent mille, pcm)
+
+		RO
+
 What:		/sys/class/hwmon/hwmonX/humidityY_rated_min
 Description:
 		Minimum rated humidity.

-- 
2.39.2


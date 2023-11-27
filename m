Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D727FA811
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjK0Re3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjK0Re1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:34:27 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F9DBF;
        Mon, 27 Nov 2023 09:34:33 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b2ad4953cso31187565e9.0;
        Mon, 27 Nov 2023 09:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701106472; x=1701711272; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PyJvKifjCksa9ZtBNafx8NGbx/DvHUPSdg3ul1e3Sf4=;
        b=juvTSLRlrh0oBcF6skbrzI0/xDhJe0tkyNGvf9L/a1psJQF9mwIj9tL1NcEiVv037A
         K69QfaB5EtNCEd0ykfdy3XX8QR4I6x6fhA1/MJQysXVUDp1BfIpKLMw+qtYEjSPGreXk
         kYnMFUiSFk0FMfJELPFGLWJeIntEW7kQ1OrzQsXXqKPZ24+vh3K7FpLUHP/1GLPTWfP8
         0L0dI0QmZLRNy0ioi7OTqX32ZhnbHThv44G/QdPJZj9kTNw3DGUxhHyQ1Fbcgf4jib+7
         Z/DdIxtPYA3ZgbrKeCdAh/jssaO4ma2EZ8VbTPGiGZ/rH1EQ5nUz1EBrOx6fbiJbciJY
         uIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701106472; x=1701711272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyJvKifjCksa9ZtBNafx8NGbx/DvHUPSdg3ul1e3Sf4=;
        b=tIt+sJAcjzlEWSw50cEIiEdNXfRvVn7+EiiV21xEDjANv/aCHM+SoSrcUCmR4SrEtU
         7lr/YWhS+B9Fd6mQtlOXN+sPXZ5vL1TPrhTtOzRPLa8bmxeZ6T+0gnCFPhAl6kPpvpH5
         PZBqADPxPdK0JXZeq/77uZJASf3HH2V68GMzHIIt03V7eV6xwK9CjiUn60Ul188VAyOn
         4hd1LDMzaalgAqFJ2NzxKA6z/35TXHcAzSjWBJ5foV4WWO0iCMP60RrD14gVlk6KU803
         mJaedPU5fwg/C9UmULvGDO/37Bk/SVb9g+npZ0R6SoiXaLLOrBIj2+jqhqV4Codo4HlL
         KwLA==
X-Gm-Message-State: AOJu0Yzg9EHajr+GG0AGxyYn2n612No49ij5b4fLknFUQtogvtg/Mvuw
        D3inuNkEgwTZ0TdweFiZJayVhPyJB7VW4Q==
X-Google-Smtp-Source: AGHT+IEDXeBVGyDsaXqFqY6+2j0yunabt588PWXxO+iWCwcu54PRS9kw5NpOj3urOI2157Z+TfLysw==
X-Received: by 2002:a05:600c:4311:b0:40b:3de0:8e1a with SMTP id p17-20020a05600c431100b0040b3de08e1amr8818528wme.8.1701106471769;
        Mon, 27 Nov 2023 09:34:31 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-aa01-5533-a7bc-788c.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:aa01:5533:a7bc:788c])
        by smtp.gmail.com with ESMTPSA id je19-20020a05600c1f9300b004083729fc14sm15139626wmb.20.2023.11.27.09.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 09:34:31 -0800 (PST)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Mon, 27 Nov 2023 18:34:28 +0100
Subject: [PATCH v3 1/3] iio: add modifiers for A and B ultraviolet light
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231110-veml6075-v3-1-6ee46775b422@gmail.com>
References: <20231110-veml6075-v3-0-6ee46775b422@gmail.com>
In-Reply-To: <20231110-veml6075-v3-0-6ee46775b422@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701106468; l=3539;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=nymkBqy1zy5W1DkFZRCIlPpGK++jMxfNLk6XrJLr6Js=;
 b=h12Af9aReHwXBlM3aaq1w/sc4T+TrrTLPXOY99BCW8d4DKjbk3MLJWF//2bDf4yli7nGrA1VB
 l6v3ww3QOqqBNb1IiOI3z9eWcz+AjkyR4kmRC/dFrSD/YKtkcoDaqvc
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there are only two modifiers for ultraviolet light: a generic
one for any ultraviolet light (IIO_MOD_LIGHT_UV) and one for deep
ultraviolet (IIO_MOD_LIGHT_DUV), which is also referred as ultraviolet
C (UV-C) band and covers short-wave ultraviolet.

There are still no modifiers for the long-wave and medium-wave
ultraviolet bands. These two bands are the main components used to
obtain the UV index on the Earth's surface.

Add modifiers for the ultraviolet A (UV-A) and ultraviolet B (UV-B)
bands.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 7 +++++--
 drivers/iio/industrialio-core.c         | 2 ++
 include/uapi/linux/iio/types.h          | 2 ++
 tools/iio/iio_event_monitor.c           | 2 ++
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 19cde14f3869..e2a9937be99c 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1574,6 +1574,8 @@ What:		/sys/.../iio:deviceX/in_intensityY_raw
 What:		/sys/.../iio:deviceX/in_intensityY_ir_raw
 What:		/sys/.../iio:deviceX/in_intensityY_both_raw
 What:		/sys/.../iio:deviceX/in_intensityY_uv_raw
+What:		/sys/.../iio:deviceX/in_intensityY_uva_raw
+What:		/sys/.../iio:deviceX/in_intensityY_uvb_raw
 What:		/sys/.../iio:deviceX/in_intensityY_duv_raw
 KernelVersion:	3.4
 Contact:	linux-iio@vger.kernel.org
@@ -1582,8 +1584,9 @@ Description:
 		that measurements contain visible and infrared light
 		components or just infrared light, respectively. Modifier
 		uv indicates that measurements contain ultraviolet light
-		components. Modifier duv indicates that measurements
-		contain deep ultraviolet light components.
+		components. Modifiers uva, uvb and duv indicate that
+		measurements contain A, B or deep (C) ultraviolet light
+		components respectively.
 
 What:		/sys/.../iio:deviceX/in_uvindex_input
 KernelVersion:	4.6
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index c77745b594bd..65f567e4ff2a 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -117,6 +117,8 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_LIGHT_GREEN] = "green",
 	[IIO_MOD_LIGHT_BLUE] = "blue",
 	[IIO_MOD_LIGHT_UV] = "uv",
+	[IIO_MOD_LIGHT_UVA] = "uva",
+	[IIO_MOD_LIGHT_UVB] = "uvb",
 	[IIO_MOD_LIGHT_DUV] = "duv",
 	[IIO_MOD_QUATERNION] = "quaternion",
 	[IIO_MOD_TEMP_AMBIENT] = "ambient",
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 9c2ffdcd6623..5060963707b1 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -91,6 +91,8 @@ enum iio_modifier {
 	IIO_MOD_CO2,
 	IIO_MOD_VOC,
 	IIO_MOD_LIGHT_UV,
+	IIO_MOD_LIGHT_UVA,
+	IIO_MOD_LIGHT_UVB,
 	IIO_MOD_LIGHT_DUV,
 	IIO_MOD_PM1,
 	IIO_MOD_PM2P5,
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 2eaaa7123b04..8073c9e4fe46 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -105,6 +105,8 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_LIGHT_GREEN] = "green",
 	[IIO_MOD_LIGHT_BLUE] = "blue",
 	[IIO_MOD_LIGHT_UV] = "uv",
+	[IIO_MOD_LIGHT_UVA] = "uva",
+	[IIO_MOD_LIGHT_UVB] = "uvb",
 	[IIO_MOD_LIGHT_DUV] = "duv",
 	[IIO_MOD_QUATERNION] = "quaternion",
 	[IIO_MOD_TEMP_AMBIENT] = "ambient",

-- 
2.39.2


Return-Path: <linux-kernel+bounces-26454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 593BB82E127
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9CAA1F22C97
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DA619BD6;
	Mon, 15 Jan 2024 20:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfKqIOQc"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5467B199CF;
	Mon, 15 Jan 2024 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e7e2e04f0so8165515e9.1;
        Mon, 15 Jan 2024 12:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705348949; x=1705953749; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h+VcwsO3OlfK5Hp3uhRyspjZBcwCEAsB1Mu1l8CtFcY=;
        b=hfKqIOQcP3XMg4SKxUQf18UR3IbX8P7z/8f20WNn9UUzss83wbbqThepTHKoQgfz+B
         rIaPjLxbKuBzawL09s9Q5zjEXgU6fxxacVN/oU79Lp6zC5CDCVdUQ1rb/58OG/cjpGVG
         FFPOL6N8VnOr6TCdO5tysVQbAgdai9lJ0WDJ1dVikazKxCmWQqnCjbmX7Gap586k9QSX
         BwUsb9UTw2hASfQpcg1Tl0WZmzyofDaMq3gBG3GctmGVooDGu5UP9uoi9BZ6uCr1+hbr
         ODtva+ivzjn9JI35y6XNbLAHIoad9aI4fDxQddIySzVyWAyM3Q999yehyl63TzhBA26E
         vEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705348949; x=1705953749;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+VcwsO3OlfK5Hp3uhRyspjZBcwCEAsB1Mu1l8CtFcY=;
        b=leAZvuC0UBCSSf9uia9ti7Pgj7k2MiHlzE7jrGx2rVcM6nSQL7z2D1yXClXuPAcUvf
         gXG2mWC0t34a7z7FVDp0LRD3Fy6NrL+AHsHWjdjyQUjIET0Afy3urp8cOoiAK6X4rKWP
         GGp6s/h6G9IiiZymDIlgXeRsiqTf+AOB1mJh/XaQ9Exu3sTlMaQy49fKLFvKYVpxLLcS
         P5CymQy3bzQZCmwiE5Hi9VqYt8jO9xsoQJ69+Jc8HShZhNkSAYbXPXKIHxxj96vR2+pi
         U2TWTNvcM8Gn+uCp9pJhgXmw8EAd9CjGCWkSd3bpO2xHijJ7n7WrV3D+WTEuMF0tbAKo
         TFrw==
X-Gm-Message-State: AOJu0YxEO81OaISmq6Mo3D1rUDY2GU2SwHC+P4BKeZMIrqgtnud8+pOM
	uaeHXVB/u/uLtNdUTzG6ahs=
X-Google-Smtp-Source: AGHT+IEj7kn8yj+uCyzMDuyUq8gUdWIDgV9nZOCyq+tJKnttedWgGUmsoiWeNUHeifeJd6OLelr+Mw==
X-Received: by 2002:a05:600c:c8:b0:40e:597c:99cd with SMTP id u8-20020a05600c00c800b0040e597c99cdmr3175087wmm.79.1705348949050;
        Mon, 15 Jan 2024 12:02:29 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-bf32-c470-1874-c1ad.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:bf32:c470:1874:c1ad])
        by smtp.gmail.com with ESMTPSA id m26-20020a7bca5a000000b0040e54381a85sm16377924wml.26.2024.01.15.12.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 12:02:28 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 15 Jan 2024 21:02:23 +0100
Subject: [PATCH v5 3/5] ABI: sysfs-class-hwmon: add descriptions for
 humidity min/max alarms
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240115-topic-chipcap2-v5-3-0cc7a15aeece@gmail.com>
References: <20240115-topic-chipcap2-v5-0-0cc7a15aeece@gmail.com>
In-Reply-To: <20240115-topic-chipcap2-v5-0-0cc7a15aeece@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705348943; l=1006;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=THjML2ZdEMhAgD4H3dSikGyikzlsdusSvlgcKoBaOeo=;
 b=PCTTw9HNoniSzTSxL4Ihkiy6hGIo2EMNd8+hWAyTq3mnEx6oImM0mryVymXUaQWgliYZ5HizO
 Hy2d38/OOV/DMb8si9c+vRwRT+s73UldSWZOqdmbRanJiJGRO4xcegE
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

This attributes have been recently introduced and require the
corresponding ABI documentation.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-hwmon | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-hwmon b/Documentation/ABI/testing/sysfs-class-hwmon
index 638f4c6d4ec7..af94c1f373de 100644
--- a/Documentation/ABI/testing/sysfs-class-hwmon
+++ b/Documentation/ABI/testing/sysfs-class-hwmon
@@ -908,6 +908,24 @@ Description:
 
 		RW
 
+What:		/sys/class/hwmon/hwmonX/humidityY_min_alarm
+Description:
+		Minimum humidity detection
+
+		- 0: OK
+		- 1: Minimum humidity detected
+
+		RO
+
+What:		/sys/class/hwmon/hwmonX/humidityY_max_alarm
+Description:
+		Maximum humidity detection
+
+		- 0: OK
+		- 1: Maximum humidity detected
+
+		RO
+
 What:		/sys/class/hwmon/hwmonX/humidityY_rated_min
 Description:
 		Minimum rated humidity.

-- 
2.39.2



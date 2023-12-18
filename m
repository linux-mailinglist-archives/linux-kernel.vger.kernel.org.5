Return-Path: <linux-kernel+bounces-4279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 548D2817AB4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3A31C2333D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D7873490;
	Mon, 18 Dec 2023 19:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xxr12qNT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD527145A;
	Mon, 18 Dec 2023 19:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5532b45c286so2337777a12.0;
        Mon, 18 Dec 2023 11:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702926640; x=1703531440; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h+VcwsO3OlfK5Hp3uhRyspjZBcwCEAsB1Mu1l8CtFcY=;
        b=Xxr12qNTGJcNuf8h2i2hHqRzR7GUeDa91Vwy0ikslAqItZuqxH7zsmjGQwbVhcXkgl
         JEX5BVgbOBOkDIW23SwOWuIr11HGT1O9f8V0VtEcaQF1H8f2soV/9wA3DLMYBQJrK+jZ
         Nw/K2pwfF0IuEKMq4/9xzwy0o06QWhvlKDhSVSvI89z/MoM4UYvxfO8cJKKtMS4mceY2
         a9VKfakRyPyj1Ek9w/YDdPLkFH6ope7tdTKL7N8EROh/3qPuLm6xjn9NJpRlwVcMIpZ5
         ZA7UKZWsX1DY4w8UMRkdDgS1Z7Wu1TuBeQ4AyXWzkBic+rmttce6tYQ7+qdS8h1n3GPj
         w9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702926640; x=1703531440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+VcwsO3OlfK5Hp3uhRyspjZBcwCEAsB1Mu1l8CtFcY=;
        b=fetXTA/dwj9YuaQvh/JMMgxtHSIouiWNNigZcBbziTl+ZdZXH8ybxUhpzyXaJ7W0qr
         GhM/o4fnOzt2jMPR10hymCn7azsIXhMzffh4xUxNLrjntVAZjs1mIICqQICWOfrIFahk
         ZSEyyHlvKaaNrzqmXun7GmePPL8S9JAX9DzRXm3hFkiGmkGB9l5XqFsGOvlcEzYd0pAa
         puzLEE5Xig/e8qfHMOAuRATETiA3irumIzknPaOjkQAE+h6OLzFxxaDO8AeThCANUR/R
         8fLV0ZWwbNKiq5Yvqhq4YPwtmkQ5VrGRrBXtaxxNmgjmmXFYTBnkGmP+3zaCekWi3qzw
         +Dpw==
X-Gm-Message-State: AOJu0Yyx/tzye8xwN+pfkaSl8Y00sgC7nxFfUHcMgRIoEXq+h6WjeixD
	7AlAmQU2rfq9sy/ELOELCbE=
X-Google-Smtp-Source: AGHT+IEuYkEwImJWsR9DmlPzyUC7vLBlvyw9Hh1Dma06swsGYJ05wT9QSFhI7DKs7QDe/jmBQfhTxg==
X-Received: by 2002:a17:906:7fda:b0:a23:4954:3106 with SMTP id r26-20020a1709067fda00b00a2349543106mr786531ejs.107.1702926640667;
        Mon, 18 Dec 2023 11:10:40 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-339c-9917-d041-4030.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:339c:9917:d041:4030])
        by smtp.gmail.com with ESMTPSA id vw6-20020a170907a70600b00a1d80b665dfsm14398956ejc.26.2023.12.18.11.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 11:10:40 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 18 Dec 2023 20:10:31 +0100
Subject: [PATCH v4 3/5] ABI: sysfs-class-hwmon: add descriptions for
 humidity min/max alarms
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231020-topic-chipcap2-v4-3-7940cfa7613a@gmail.com>
References: <20231020-topic-chipcap2-v4-0-7940cfa7613a@gmail.com>
In-Reply-To: <20231020-topic-chipcap2-v4-0-7940cfa7613a@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702926633; l=1006;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=THjML2ZdEMhAgD4H3dSikGyikzlsdusSvlgcKoBaOeo=;
 b=Kc+jEQ4HbcocMogEOouMmSfet9tNCZBk2UffS0CzxDuNHaU1dp/HrKSvHzJ7ccRly5N0NZCJI
 MATU3d8X9ErB8W+JnD6JnrwNi7g3Vnqp8A1TsSOkJLYFpFd2mZPTH5c
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



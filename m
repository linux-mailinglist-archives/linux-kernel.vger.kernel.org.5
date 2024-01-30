Return-Path: <linux-kernel+bounces-45317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C53842E6F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355DA1F24AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2DA7AE50;
	Tue, 30 Jan 2024 21:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYvzlZeU"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17D078B4C;
	Tue, 30 Jan 2024 21:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706648817; cv=none; b=aqJaSm6brfJFvqpMX5TEfR/BtpQ1LzDU+FjplUscYds5jZEtTzMsn9tCEpnjasRwrTNtVjbtZzRCU0qmyTi5aMP204JPBCpM3/5/tKSDMNCxmVM8WdZ2EH1sx69FSwrP6UYP97xdcyLVffth16GqzLpOh4rc9fXDy+dzwjZW1UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706648817; c=relaxed/simple;
	bh=o3nT/glgE9OrStOuUiwSZUfHVTS4KfV9GDtahhSGb3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MCoD8l5HOHzgnkyakMj0SPke5Hf+iqCYvFSjGjWOtv/f6LzUDcQ3+B6Ijl1ReZ2PPhNXvp2pRKXB3Fb/JETcfsZKKoyLYPErkIQIrPcfenrQ3KmyZM1k7mC+8AN9/patQCVai5sGHkn3LOt5Qg6yy/VntANn7mxUoEoW7AodWTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYvzlZeU; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55c33773c0aso4690350a12.1;
        Tue, 30 Jan 2024 13:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706648814; x=1707253614; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOeyQrTpUXsRQpxgsiXlfqixsQT8OxPjhvcSfqQoa6Y=;
        b=TYvzlZeU6byz3MILGl6PsjKlUobWM6oRGsg4uCZVU3i3VJOmd3CRqYKlTJqHfBF6xD
         IVGvu0pwpJgg0EWW0/j379Bz99DSdF1hmiGyfcvisezv+apFXPcEb8UtV7gM6H4OjT2L
         dV0/NaO4Kleas+8+z/qzwDnR2IOCe//QUJgz8trbI72Wdc3pEE4I7ismtqrm8+bvYFZE
         UkWO9w0ZskP5HnCA75o9CUqc3xg2okL9nKz32y6yl4XwhIFKO7O+wUCoJH7sRNNt5GrS
         H1QWSVabSezUrtaenQ9eUqUz996cC55ItQ5soYcRDk+H1fmJLf4rIyC5Hfse+zC656tT
         9jqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706648814; x=1707253614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOeyQrTpUXsRQpxgsiXlfqixsQT8OxPjhvcSfqQoa6Y=;
        b=czutG/NjE5XgZOYTMdKeC+FF+WwPoQIECH0dP/XGj8YPEGRrijKR5YJwaIaUJWVjBk
         HEOgEYO84IC+zRv5vHtQddhHlo4pp9kusiIor+Bf+xiK9Vru0d3bZe0xidoVv4x4zBfe
         ixeaCqcElcC2ll8zEAyEv6SNkf2k175lueEcf6gZ1AzLa7PDZv7g6pV/AywMusmNhVv5
         MSFYY7693rWiZ/mdhxJYPHCwgXfWqVzn8Di0cShg6ZVxS5V80QCCtej4MUlOO4af8dlK
         qxLzDc/KFZtfBd+isK9dRAlush/g/DfPbHUJYLyvn6HyExkn6KuSiwrfwg3rbXLTaEf/
         YCWw==
X-Gm-Message-State: AOJu0YzNMsx+3DsSt9MYI1Xcj1wG0ldYQ/q60lg/HkB7RtZ1mRpzYceo
	8RtYnGpNHCWYNY2ssAn4Sg2MeNTnpI2QYUIU0TyRMdg0SoJhNVJl
X-Google-Smtp-Source: AGHT+IHtgaSfofm4Uz1ULKZyzmTNLRaRTlatfudObUCDNuBU0Kvdb1Kl8VbkLY4gy6MlTmbc2g1Eyg==
X-Received: by 2002:a17:906:c78d:b0:a28:f8d2:7897 with SMTP id cw13-20020a170906c78d00b00a28f8d27897mr357989ejb.20.1706648813935;
        Tue, 30 Jan 2024 13:06:53 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-7400-ff68-7ab4-4169.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:7400:ff68:7ab4:4169])
        by smtp.gmail.com with ESMTPSA id vv9-20020a170907a68900b00a354a5d2c39sm4177658ejc.31.2024.01.30.13.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:06:53 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 30 Jan 2024 22:06:46 +0100
Subject: [PATCH v6 3/5] ABI: sysfs-class-hwmon: add descriptions for
 humidity min/max alarms
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-topic-chipcap2-v6-3-260bea05cf9b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706648808; l=1182;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=o3nT/glgE9OrStOuUiwSZUfHVTS4KfV9GDtahhSGb3M=;
 b=NQPUHdmz8bnHf+lrgBvR0GnjgcuD+5TTJ15c126eMhap9gv3WNm/8AxPnZdD6xbimgixQabfv
 ZJ2OboeSoDLAEVeujJOlHmlc1oO/pgWXM9/phnye3ULjMV2a4UW2CZI
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

This attributes have been recently introduced and require the
corresponding ABI documentation.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-hwmon | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-hwmon b/Documentation/ABI/testing/sysfs-class-hwmon
index 3dac923c9b0e..8446e95f23b1 100644
--- a/Documentation/ABI/testing/sysfs-class-hwmon
+++ b/Documentation/ABI/testing/sysfs-class-hwmon
@@ -968,6 +968,15 @@ Description:
 
 		RW
 
+What:		/sys/class/hwmon/hwmonX/humidityY_max_alarm
+Description:
+		Maximum humidity detection
+
+		- 0: OK
+		- 1: Maximum humidity detected
+
+		RO
+
 What:		/sys/class/hwmon/hwmonX/humidityY_max_hyst
 Description:
 		Humidity hysteresis value for max limit.
@@ -987,6 +996,15 @@ Description:
 
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
 What:		/sys/class/hwmon/hwmonX/humidityY_min_hyst
 Description:
 		Humidity hysteresis value for min limit.

-- 
2.39.2



Return-Path: <linux-kernel+bounces-55010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 853A084B637
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 374571F24071
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5459A12FF97;
	Tue,  6 Feb 2024 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vzqgb0zg"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1061312EBD6;
	Tue,  6 Feb 2024 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707225717; cv=none; b=BBgAXwafqLacaQ6ODLf+ZMy3KkWrk3/1nF9oqOHVU9+afZZUdzlnt8wES7rjyNTiGF5BSQpgBhhcsNEwzl8QvUkcKpfDgoLbneNfEJDLR889xj6ubHKLFLwSfDj8PBiqIzPmuWNU6TjTn5AEuLqLXg8PYC5i5brce0TmmMEAtbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707225717; c=relaxed/simple;
	bh=wSWjtqqjivUoa0CG3qdFK79yHE097JXhev5z205E/nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HZ1V28bqx0T/4I507/daq181E8vwKW/gZN+Tw1WiH+YpEpCEPeWh3xJ+jUgOeVm6qE5gViMBvVVeRh5JIZAV9eA64J5rjiFGZEW4a7DN8jrp9hbQvwWIOU6hW45nSa+cvduNmvea79iOCf/P8ccCxuOZniM5EJUaCbMZvCy4vPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vzqgb0zg; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a34c5ca2537so764806966b.0;
        Tue, 06 Feb 2024 05:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707225714; x=1707830514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xt2AM3jB+7aIDuoutfkr3xbhDhpMe4Sp5icdbuMaEx0=;
        b=Vzqgb0zgo87YdC2P19qBl56Tl2NKwjlpxyi9L86OSWPtuw70F9KiDE22vqHavrj0JA
         aPbu9P2Aw5q6IyfaLz8bS3/6DQ/8SZgGe6GYKqt14+EQJMoDd/rupZHDToR34Bf/ecKR
         PtDuONihut42AygT0NhaK4cqMy926JXMCUj5t+8pzRhO/hw0L+d9NsmqEauoLYjkbZqr
         5ZHz0C1mT7piKNOrBje1fTMdSIb0aVBreQHGBpb1UPYH5g4QVzOrkkDXteRCgPJaUFOR
         UzixM2ym/qalQYRm3iSSG9X8C81GCgUnfcyn8hpu1Po5uk7jCuer/G+VUypsJlHbLEcp
         bTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707225714; x=1707830514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xt2AM3jB+7aIDuoutfkr3xbhDhpMe4Sp5icdbuMaEx0=;
        b=UzWuGgzNr/51yP/dYCbTLZTkqnqRIAfQIRipvFdoQsvyboN8Lww2ogaM7gR1QeTnkP
         oN+VPWDiqpVfCEIAY6YxURpA1Z7Htx0O9VIt7BFlO3sfhRgC5gLQrdCw2BViJEsGasqK
         GBfRv7g1Vngh7Qx28iz+84UezHwIEf3nXhKd1bTzWsxgKfaqATCxPla2Y9toVez/iD0e
         PqRmD9pZkEuxN1BqdnyVmvR06RmjcLFhiNBkjoAukVwwjdlmaV8v25Vz6TnVKk6X5VO0
         DTUw7nOc5dKRcwvagHUsKapQ96XOg6w70nVxeswiHvoly4Geeyq1w4wljKggNHs469xt
         lU4A==
X-Gm-Message-State: AOJu0YxxeuSc0CWyeMrjsg89Ilq+zOEk3mkVMiw6t9iOFhix7th5pl/S
	fXM3hjPepuRINa6/xTVtzKB0TBkP5AvrPW5tyYz3a/hzg4ActkU=
X-Google-Smtp-Source: AGHT+IFJw+4SBTi+R5DKuxC03GF1O4wOugIW2lEICA03wRZnEmo42vW2LCWLCF52KKqKKJVOm5//OA==
X-Received: by 2002:a17:906:53d4:b0:a38:15ba:32f5 with SMTP id p20-20020a17090653d400b00a3815ba32f5mr1585096ejo.56.1707225714041;
        Tue, 06 Feb 2024 05:21:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU4rAg9QgsmazXfYYhcTq9zgajQTc57l9Lo7Ip/zdPBbotdyI8C/MjIslwkRmyZR3I7BoTMfzY0XenTO0Or16XGMoqbbhKHXjYpkcKBOWzcdY/ygkzKIG+3og2XZbzu4JpsEqI4ApbMcspD/IEo7a9IoT2OX6zuiVta31jjskLs3gBt7CfcFhNgYZDV0Q8RPkaWoP8Tiyagz3dt8ySobBTO9KTg3ZHxj5iuJlUK9RliPmOoi1c5I5aHm8q1pNBHJU9XQHKZ0BhW4I3TQt2aYg/nIb/3ZydRM1hOjr3PPXZoYmPiQbnZ/UFOmCxrJLdgSbDyMN0LFZoFNqjbzoOJa4VmgQA7KC6WJfmJa/f3lToP+7i5i9jN0An8U+NVE2up8c5rfXLeDPqG8/R8U2oRZXXZ1FBaYa2e3o9igUVWVgUoMrtpQajsTMo401dnxcKezA1T8yGFz816MpX/VxkVlY9Ka2iFEZENZilasrkCH063TY638/ttEVxy6KyrkzUwNzgGLyEs+Ncg0ZJCeOq9ze8O95Xyza/GxZeThaamr9BsX74FT8tdcMiVs7Tp0I1zZ7iiPGHZxS7li9xfhi0PYbsJ2IxOLAowfhDM/5kaBWvzWEri
Received: from frutis-latitude7490.lan (public-gprs393011.centertel.pl. [37.47.166.116])
        by smtp.googlemail.com with ESMTPSA id st6-20020a170907c08600b00a37210f1e92sm1147096ejc.205.2024.02.06.05.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 05:21:53 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>
To: Rob Herring <robh+dt@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Peter Yin <peteryin.openbmc@gmail.com>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andre Werner <andre.werner@systec-electronic.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Lukas Wunner <lukas@wunner.de>,
	Fabio Estevam <festevam@denx.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: trivial-devices: Add qca,spidev
Date: Tue,  6 Feb 2024 14:21:04 +0100
Message-ID: <20240206132111.1772867-1-frut3k7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add Qualcomm QCA4024 to trivial devices.

Signed-off-by: Paweł Owoc <frut3k7@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 79dcd92c4a43..50efbdf2a735 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -309,6 +309,8 @@ properties:
           - plx,pex8648
             # Pulsedlight LIDAR range-finding sensor
           - pulsedlight,lidar-lite-v2
+            # Qualcomm QCA4024 Multi-mode Bluetooth and 802.15.4 SoC
+          - qca,spidev
             # Renesas HS3001 Temperature and Relative Humidity Sensors
           - renesas,hs3001
             # Renesas ISL29501 time-of-flight sensor
-- 
2.43.0



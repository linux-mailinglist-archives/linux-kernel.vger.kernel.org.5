Return-Path: <linux-kernel+bounces-26452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B8682E11D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551DC1C220C7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC16199AE;
	Mon, 15 Jan 2024 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZ3t/+Z9"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC0B18EAD;
	Mon, 15 Jan 2024 20:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e7fb927a3so7179475e9.3;
        Mon, 15 Jan 2024 12:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705348946; x=1705953746; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1EnS+pRSTO4R91TDbHHpG803uRr+ViRWAjg2k0SmyRQ=;
        b=WZ3t/+Z9Rmk4/kPoFdkJlzH3YQXKUMe5DkOmko9aEYTaQTN+GYB+8dziIeriWND27I
         NCaHbCT5uCaS6TzOe+eiH/pO97rh7W6DAw9tyzJYddCbYy38VdM9laUc5Vvd/cO9yJzR
         PJBrUDg6z1ITXCVKmCTdSxVpQlpsq61xPuHpgwO0LpFN3biCnRJpoyY4/BB8qpmFDpfp
         gkmWi+52Ha7jmXhb00DJDqVlsfGoYxnZkSN9ftVR3jlRFolBePSTmypbYV8gEbUOzUg2
         w3vsruOplh4L0jHT1dp1gs7cxLig/B1HUAw1HjbpqRItwqDoKFZP9qDlODVYU6TRg8S9
         zDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705348946; x=1705953746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EnS+pRSTO4R91TDbHHpG803uRr+ViRWAjg2k0SmyRQ=;
        b=Ask8Dgihhd1Qd/tEnJJQCpBxR7h4dYQPj/51aeQX5WJ4N43M+zMUtgfsiHky5D7ero
         jh6RDazu6IxceYTUpMBb4aGVatNZCEBltX/6rvIxczjRGPvfj/oPBGta5h0qXpTLk9Sm
         OusnN+TwBEv8WaMw2m9roHPMqoByAbtKZZEc7JDNjoQCaqn0n8t31b99wxFb1ksGpuFV
         spLkW3qBI+bTgPiNS8+ZpmqheaA659QShzmM5wlJGO0/DH1/9Tvofe7gSfNwSSU9R5lt
         5O+3Jr/1dqKpsAM/U8WTTqOTOPoJaZTGQs8LwEM/eVt483DsPuFh0TKypaOH2uxq8oFC
         0Fqw==
X-Gm-Message-State: AOJu0YzGf/3KIu5ZTcQ7rY6SB3iO0e3J4DJJfCoU3Wdt5ntPeQGqE6Kt
	ZpZNRzwIPsvqid75RyFYk6Q=
X-Google-Smtp-Source: AGHT+IFF2xzmoB7X5Gh4HF4VKYUfu1gqI5j/Gn/eCZweUhgkv8eMkCF/olPIO75dnA988cyZ10A/Cw==
X-Received: by 2002:a05:600c:3512:b0:40e:7485:daee with SMTP id h18-20020a05600c351200b0040e7485daeemr1516543wmq.90.1705348946163;
        Mon, 15 Jan 2024 12:02:26 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-bf32-c470-1874-c1ad.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:bf32:c470:1874:c1ad])
        by smtp.gmail.com with ESMTPSA id m26-20020a7bca5a000000b0040e54381a85sm16377924wml.26.2024.01.15.12.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 12:02:25 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 15 Jan 2024 21:02:21 +0100
Subject: [PATCH v5 1/5] dt-bindings: vendor-prefixes: add Amphenol
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240115-topic-chipcap2-v5-1-0cc7a15aeece@gmail.com>
References: <20240115-topic-chipcap2-v5-0-0cc7a15aeece@gmail.com>
In-Reply-To: <20240115-topic-chipcap2-v5-0-0cc7a15aeece@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 linux-doc@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705348943; l=874;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=PCidHchbaiTdlYu+9md1vtBsSrbu0tUQ7foLUj3NqoI=;
 b=Dyz/xAhEYcBUhWWZxZcAkiGMKzOk3KfvxQPI9D85lmxE0O6XsR52uItVaQg+9+nWIjP7o07Lv
 NpjErivZ/tqDHUa8NKlBpjiVpXhUXXMNNBbDX7M/fGwbGwgAascMfN2
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

Add vendor prefix for Amphenol (https://www.amphenol-sensors.com)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 309b94c328c8..4a49f24b906b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -105,6 +105,8 @@ patternProperties:
     description: Amlogic, Inc.
   "^ampere,.*":
     description: Ampere Computing LLC
+  "^amphenol,.*":
+    description: Amphenol Advanced Sensors
   "^ampire,.*":
     description: Ampire Co., Ltd.
   "^ams,.*":

-- 
2.39.2



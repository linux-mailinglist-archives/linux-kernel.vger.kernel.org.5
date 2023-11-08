Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6326D7E563F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 13:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344653AbjKHMaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 07:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344638AbjKHMaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 07:30:04 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C70F1BEF;
        Wed,  8 Nov 2023 04:30:02 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9becde9ea7bso154215366b.0;
        Wed, 08 Nov 2023 04:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699446600; x=1700051400; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/hVzV74APEMY5g+/MNKD+uN6zoxDwYDvKFgVNjOiD8Q=;
        b=SS+9ysQndXD9EE3Rd7dC7u29Tj4nB4B+NbPK3V8u0tWfpek61WRQQo1OgC4P5LbRLx
         jStddYKyQEuxhfHCyZXxgiEeWamAJlqPE79ZPfyeQ3r7GTic2piFTA2TLTQuSQ3H11Bg
         0gTRTzBu51lm/g/wcSDg/XBKKJi74YjyZS1XUBVX3hHZM9vmkehSHA9Zo/zLPP56Fsly
         w0qUOtbS8TPh3/IeIr82WDEDLnS9fun7Y9h4Nf8z+m660nG1SZBmI+qjOWxZSph/OdAW
         w4vdMg+iUwOBfQxDYi4ZOgyyuIgW1Tc21/rODeRdrtCZQAJB5lne4JhVMgZKs83u0AK3
         h2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699446600; x=1700051400;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hVzV74APEMY5g+/MNKD+uN6zoxDwYDvKFgVNjOiD8Q=;
        b=Wa+dTMqWIrZHVL8V8UU+4JiqImC6VhpSFh7DZcPlmhwn4ft/eLVwL65nUrs1rsrJSG
         qVz2WUW7QUhhqxPDGLXcL+8PQHTip+LrCUPfkljijVV5aIxoHAKoiMZ7GZ/lUe6kpbLx
         3CML5717SuzXjhh2u8ZZKp4KPbk7snKKTqfe5sOeM22DTufgJUDwNClzemW6bCX3943q
         5i1I9iLZhXZeTzzRq/gfodYNG6vaDxJ+KbEsf4HgmJJe0wYayVqKYlKtTZuduIp1gcVk
         fY3Kob/AzI9Xf7wluwj+TS8qefnsk6zu8nW23PrRizJ0PIDXDBVD273uZHqcNPb/zQjU
         mjNQ==
X-Gm-Message-State: AOJu0Yyk4dw4uJ0t85EbKLs9EOV+hjm9O87sYRe/UjG5+aI0VIfLS7dO
        jLHEzBikPEvJDLnNdP/+NgI=
X-Google-Smtp-Source: AGHT+IFzQbY/IbHkdL4pN6G7KhqFLgX8V2Op0vbWkYvboQPbgHV0USwBbsCDxR8N8idnn7hkK7usrA==
X-Received: by 2002:a17:907:2d2c:b0:9b2:be2f:e31a with SMTP id gs44-20020a1709072d2c00b009b2be2fe31amr1723424ejc.31.1699446600608;
        Wed, 08 Nov 2023 04:30:00 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-8f74-d45a-3701-05b6.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:8f74:d45a:3701:5b6])
        by smtp.gmail.com with ESMTPSA id n22-20020a170906841600b009b27d4153c0sm971065ejx.178.2023.11.08.04.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 04:30:00 -0800 (PST)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Wed, 08 Nov 2023 13:29:56 +0100
Subject: [PATCH 1/4] dt-bindings: vendor-prefixes: add Amphenol
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231020-topic-chipcap2-v1-1-087e21d4b1ed@gmail.com>
References: <20231020-topic-chipcap2-v1-0-087e21d4b1ed@gmail.com>
In-Reply-To: <20231020-topic-chipcap2-v1-0-087e21d4b1ed@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699446596; l=793;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=O3vBag9qb0UXGx1zpokmfCFPd5e33XpxPN8DaGZv7pE=;
 b=atsPuN2nBwMaDKaR/9WCCsbdrXqRyRxIgPNA2wDKrEJkxvVc+g7ZJRrpZiPa9xxRY/mqZ36Jw
 Fxru4bwIu3pAu7OiqlgCMvdzW9vp+zcoC5q08uw0gBdD/1OqhpQLS4E
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Amphenol (https://www.amphenol-sensors.com)

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 573578db9509..5911c2feb353 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -103,6 +103,8 @@ patternProperties:
     description: Amlogic, Inc.
   "^ampere,.*":
     description: Ampere Computing LLC
+  "^amphenol,.*":
+    description: Amphenol
   "^ampire,.*":
     description: Ampire Co., Ltd.
   "^ams,.*":

-- 
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624288091B0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjLGTo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjLGToy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:44:54 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004DE10F7;
        Thu,  7 Dec 2023 11:44:59 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a1e83adfe72so131606166b.1;
        Thu, 07 Dec 2023 11:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701978298; x=1702583098; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1EnS+pRSTO4R91TDbHHpG803uRr+ViRWAjg2k0SmyRQ=;
        b=VzUETL61rh/E1scygTuCbd8UETn+cDNFSoG7On5AbJyuDmi8r7WjC8Qbv/5KuyJM4Y
         Q5GKAkJahooM4dZqu11Um4n6jFmWzNNZHwlxB4unU9RtECJ1eOY8jkLSfmifGAvNccTT
         h8jdYgQttQ56ZqBaNEtNk3lXih2wEIy/ZyDoNMsQ0BNG7QV3vUwdbp7CPVqMgD63Pb26
         8xGoSuD7ZrjhntJeIxZRcMkrRd+mOnDkxqEPcyAQvdaAi7x7XHcceNiCzjnTUOhv/TwB
         8MFS9XbKJ9N1MwpFjL8EbUmHulDa7NBImqaE5x6Okr6jaeDHsAXpXP5E0vzTIScW6eWz
         Harw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701978298; x=1702583098;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EnS+pRSTO4R91TDbHHpG803uRr+ViRWAjg2k0SmyRQ=;
        b=LPzQh5sfngUWhBWR/TAcSRSY9GFSBKNom1J6bl8Uls2VLBO6m9zQHnJJK5GpBIzV5k
         3owaaWWicwwfhdz3Qdvjzmcm054vn22i6Rmz8qQ5pOm9F7Y5STXHuQi1el6uNFyApnJJ
         TUFa56IDHVS5eUyreKAltC4F+amqIByvVsGMFNZ47+0VQaMEcW6rJ5NWUwiMXVSfOkFK
         uRdvXN7yeMako9PwjoMg3NiRFMgr5NmddWNu5iKNnxsAbdsCDqwI00tLYHCVMWElzrjO
         vKIG6onkKDLEEYS5s+YTVQ/rQxSx9bSvXuHEpxoNRrrvwE74faYPPMiO2G8xqmQBPXP/
         8eZQ==
X-Gm-Message-State: AOJu0YyMo8UaIUqEqonuXTuoTk8mGJMjEzOUgidLpHy60dDUzVXlOgza
        AlzfFoFMjooqsG2hwlbwTpUs/jLoaeW58g==
X-Google-Smtp-Source: AGHT+IED03EnQ1EsA7gayURbpr7Ndp7aS+552NA4iDyL0Kh2YUGMD4fhTyP5uW3YdYFVmWXM0j2Vcg==
X-Received: by 2002:a17:907:cb06:b0:a18:3001:6003 with SMTP id um6-20020a170907cb0600b00a1830016003mr1745883ejc.71.1701978297794;
        Thu, 07 Dec 2023 11:44:57 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-1de9-f6cf-eef8-174f.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:1de9:f6cf:eef8:174f])
        by smtp.gmail.com with ESMTPSA id rr17-20020a170907899100b00a1d457954d6sm127364ejc.75.2023.12.07.11.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 11:44:57 -0800 (PST)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Thu, 07 Dec 2023 20:44:51 +0100
Subject: [PATCH v3 1/5] dt-bindings: vendor-prefixes: add Amphenol
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231020-topic-chipcap2-v3-1-5b3bb50a5f0b@gmail.com>
References: <20231020-topic-chipcap2-v3-0-5b3bb50a5f0b@gmail.com>
In-Reply-To: <20231020-topic-chipcap2-v3-0-5b3bb50a5f0b@gmail.com>
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
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701978294; l=874;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=PCidHchbaiTdlYu+9md1vtBsSrbu0tUQ7foLUj3NqoI=;
 b=7VBrQr3aL0lWdVkCZ996XknBABearyTwa/Etg4qigiFfnFLpHHFGKz9RO+9+Vj7lMgZOyR/WQ
 NQZSGgEx3rnDddXloOeQfozrgJDyeb1VBp4Crr+AemoQQN46A3OGG/d
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


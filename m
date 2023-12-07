Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD89D8091C4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443571AbjLGTpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjLGTo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:44:56 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780CA1708;
        Thu,  7 Dec 2023 11:45:02 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-548ce39b101so1864740a12.2;
        Thu, 07 Dec 2023 11:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701978300; x=1702583100; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h+VcwsO3OlfK5Hp3uhRyspjZBcwCEAsB1Mu1l8CtFcY=;
        b=EqkdsZNolLBkcAgU+ENIEAqz7BomVsZDEp4iChIx4OffrT7YZPotlhfdFws65owU+k
         LVYjuG6kQVIuVP8P2RG+SSilX98J/htvMn1msMF+Vi4x4S4TAuqwGhorLBVEShZsLxkG
         NmRUwWFoZGsa1JtK6O3412YQ/g2X0txv4fWFjnKQHPLSRrJ//yCcIL75OxDymtP9rfle
         zRn8R7VPHBjstVK3gn63DtSyhvWSeIrDGr4SjjSMER8s+ODLfSJX0joqbOT2nOcMrP/+
         pPlik843n295Bj6ke+OvInToTcKipTWIz/phgcxlpdkyUjVhCVI/cls8Cy9va3yCvag1
         NbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701978300; x=1702583100;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+VcwsO3OlfK5Hp3uhRyspjZBcwCEAsB1Mu1l8CtFcY=;
        b=kWw2EPT4NENHnvW+xuXZWYiCxetKj2y4jJRFX8ByPoLCO30mtYFTyPeygFDdtCaV/O
         fhVDZg0bXKW2+dvoqqV0LCKo/I+ZP5GnBCrj1omD0nGSIf1DxqV41gDEVgDNCuJBIxfi
         yLdY6x3quscIMvbRYk/lXIVs05tvXixU+fdH4Or/CjY3re2wQBszcWUEZ7+7p8e3KiNr
         qpaA18xOMfK7TKZr7hvvATk8prGzSq6gmcAJT+XOJFMUjh0RAxrru5COxlloMrHH0Qwo
         YOFOdQ9VtVojWIBgeQ1udNSQgBoZj6l/UfTD+1VH712WManLnQ14/1/J+jln6Q6CM8md
         +Uwg==
X-Gm-Message-State: AOJu0YzrfSt5AqXL4GT4yZ8kxHpolQvnzwnUGpGEz5x8sSDt4twEkyf/
        CUpo4EoLwwuZqYohCzckdaym8JpVSTeOUw==
X-Google-Smtp-Source: AGHT+IGKqzKpbIsnCksG/kahaPc7nbc7oh4bA1CZPfeqWcQmKywyzdjLJZlOpqSMbA2xBTvpWim2FA==
X-Received: by 2002:a17:906:260c:b0:a1a:c370:2218 with SMTP id h12-20020a170906260c00b00a1ac3702218mr1344265ejc.83.1701978300554;
        Thu, 07 Dec 2023 11:45:00 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-1de9-f6cf-eef8-174f.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:1de9:f6cf:eef8:174f])
        by smtp.gmail.com with ESMTPSA id rr17-20020a170907899100b00a1d457954d6sm127364ejc.75.2023.12.07.11.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 11:45:00 -0800 (PST)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Thu, 07 Dec 2023 20:44:53 +0100
Subject: [PATCH v3 3/5] ABI: sysfs-class-hwmon: add descriptions for
 humidity min/max alarms
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231020-topic-chipcap2-v3-3-5b3bb50a5f0b@gmail.com>
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
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701978294; l=1006;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=THjML2ZdEMhAgD4H3dSikGyikzlsdusSvlgcKoBaOeo=;
 b=mEOH75y2ZLTNzWqqh+yZ+o74f3Zs3fe6EWnMyfEZKbLj572fs8BukBH8sYdOTYzvswIs5SMpi
 +HMkiDQIrgxDwykgp6SM6FxejNGGJqCvSS+FILOhYajOOvRc8bgqv9r
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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


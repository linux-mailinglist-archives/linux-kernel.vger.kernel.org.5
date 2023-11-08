Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0887E5A3A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbjKHPhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjKHPhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:37:36 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BD91BE2;
        Wed,  8 Nov 2023 07:37:34 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53d8320f0easo11672208a12.3;
        Wed, 08 Nov 2023 07:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699457853; x=1700062653; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BPWkh5aB5IOo2Y3MUSfYk8DBookJZmUKLH1njZPisds=;
        b=TsTaknTvHl/N1ZHFuIP4dl34DSd+GRO7/Z9ZmomHQepH83eqDAwy1yTi6Qt0F0HXon
         F2QxeDwU4C/1n81TY6mRZXF+PQlcLJhJku0JcZZ4suDP6ZEVRarCte+maPtSCL/aQoy3
         G2nVetQOGER53m2gG3sawfGf+YgdP8QmP7Iy2KS0qEfXSH1M7dHLC8OfkUXy5f4vHTIu
         j+0ZX4NH5t0/fIl8oAoJxeWFkF0RwAhEyfNJhdaOvfVfyHrdsIIc9nhbXCLvcp1NkYcg
         iRPRcFzQ/ChaGcMMiNAB8SYtDuoitKGBMDfMTPwcssH6oi64ZPH/vL1fT5uUcZN5vxFp
         GZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699457853; x=1700062653;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPWkh5aB5IOo2Y3MUSfYk8DBookJZmUKLH1njZPisds=;
        b=vJCsqqNcGI962pW1psdCI/wue6PfVoA7eUGeT9MCKz+OiPsVZS+tQPor9XoOisbfzt
         607rUGHUZEygDFp+3Phcgy84Z0zlTe73eXht9JpZkL4BxDvmAuN15rtsDECLojkEzhDg
         bYnD3y2kWJWEbGboxcMrAm3rrzGfnLVOmkMzJ52ODqK2FQdTjbEnbmW6/0UTrexrGxmj
         niBNDa5oXXDixAqSovnHhHxzpPuerPk7iIgsNVCzAChq60yfZIp6B1w9ROWkWIJKhX8c
         Z8RXwJJ+9uP5mWQZic3Ike0wlBpsWHJTkJ/FWvk3xqq2bP1UiUR+Ou9ukxhlF6xVeVi9
         6DhA==
X-Gm-Message-State: AOJu0Yx6UoMIiB6vbOB4+9Kq49Qh3Iqxdppq4UJqQ/oqCTPhghbm8Iw/
        3Bv+xPwrxIGYPluVVG5yO/Y=
X-Google-Smtp-Source: AGHT+IEUtbbWxyUydAs/aXp1AP0bpOrag+qrNh8g0FiWBu0pT2KTBXKTMVVEtDrTS2KvDwxVO3qjxA==
X-Received: by 2002:a50:9f4e:0:b0:540:ccde:5 with SMTP id b72-20020a509f4e000000b00540ccde0005mr1735257edf.37.1699457852760;
        Wed, 08 Nov 2023 07:37:32 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-840c-82c6-68fb-9a49.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:840c:82c6:68fb:9a49])
        by smtp.gmail.com with ESMTPSA id j28-20020a508a9c000000b0053e3839fc79sm7009966edj.96.2023.11.08.07.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 07:37:31 -0800 (PST)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Wed, 08 Nov 2023 16:37:27 +0100
Subject: [PATCH v2 1/4] dt-bindings: vendor-prefixes: add Amphenol
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231020-topic-chipcap2-v2-1-f5c325966fdb@gmail.com>
References: <20231020-topic-chipcap2-v2-0-f5c325966fdb@gmail.com>
In-Reply-To: <20231020-topic-chipcap2-v2-0-f5c325966fdb@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699457849; l=810;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=t2HXxBm7icJQeziWXWBSO7trIqSmEesTGrPC9BNCkBk=;
 b=JilNYrIBbLukAa31Zbd1sJAJWlUCyfeQPmA5UMi8Y1aSchSOwPNbcQf7sohY1eb3ELqX9Zw9t
 34JrISbCC0gBwWxJ7ZXbgsGMhzWoMoXBcZinoe2P/iodhnoqUMZKQLt
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
index 573578db9509..f12590e88be6 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -103,6 +103,8 @@ patternProperties:
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


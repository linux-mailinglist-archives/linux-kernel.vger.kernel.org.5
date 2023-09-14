Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAEA7A09A8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241229AbjINPsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241218AbjINPsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:48:13 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF93DD;
        Thu, 14 Sep 2023 08:48:09 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso960116f8f.0;
        Thu, 14 Sep 2023 08:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694706488; x=1695311288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=173yD9VjwXTBKZr7qMJ/4Ufdnz2W816dljbeIsZNNJE=;
        b=WrnzjoC33WeYGdNGgn35Wh6m92DaACtpZ69Q1tOCE7koxOhwL817R5DHaocmBqkuYt
         /2FGU/wAh9Bjy+0dXTf6U2ii8jCtRUEZA1Z324W0L0XADiO+uHBELM8aushwVrOglcZ8
         VO52KogniC0yGEtWtEBK5Q+oJNdkSQWg6b2/n5UCZySqJzQllA1n1Q4gwDfGsYpLSiGq
         LVH6AzF9cz2jOR9/Kwr4cLMFHDv4Vzd+aeEQET95H2DZ9f7MqRNMNT8NGimk7+HzTpuR
         ZrOrr7Z+zRd6gxsCy7K5fIm/moeJwPQ9L6ebD4S2ml0oPbGVK8AEi9AeawE1XhYFe+u6
         jN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694706488; x=1695311288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=173yD9VjwXTBKZr7qMJ/4Ufdnz2W816dljbeIsZNNJE=;
        b=ef6h1lx2GVKOKga97c6/PJFe7VWUji7JMkFeKsdY9CS7u327JngqgSspqOpIWc+jdt
         pXx2A4Yv0589X1aE5XHS67hA50rEM6FNpdSIjT15kZDP008UJUec9Bzh7Zo/v2FMI/b+
         Ej/KjbOYOCPqOKomIpQo11CgWm7hAMfx9JVolp38Ns5yDdrNo1AZUskuMosVMdcsiTFH
         KYiW3/W+9ldu1k/dp+WF0uM8YQGylCovNYJzKUSZNh1ugMfXvcBdMdiF3XtN8Fwh3Htb
         q7NQSU8ePMY4v62x9v7Ipr7zh/3wVKcgzWqBRLlSV/3kNu1rsVFwZKMrvIDeqj1jYVYx
         x9hQ==
X-Gm-Message-State: AOJu0YysHXWc5JF9rT2MxK2f54ahAwCmFDfd07uZPlA+qeZIu8i5d5y+
        dRQJgX3pqcOxVhJ5PBgiejA=
X-Google-Smtp-Source: AGHT+IExFJBi9Q/weXMg9QbYK5aU/ZB8UO7tgl1uqyFTBjDeP5xJo3SlFUOuek25Ef8mJ+0llrnpzA==
X-Received: by 2002:a5d:5587:0:b0:315:a17d:dbc6 with SMTP id i7-20020a5d5587000000b00315a17ddbc6mr5250564wrv.14.1694706487552;
        Thu, 14 Sep 2023 08:48:07 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-54-79.cust.vodafonedsl.it. [188.217.54.79])
        by smtp.gmail.com with ESMTPSA id f13-20020adff44d000000b0031c79de4d8bsm2071169wrp.106.2023.09.14.08.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 08:48:07 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        linuxfancy@googlegroups.com, hdegoede@redhat.com,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Martin Hecht <martin.hecht@avnet.eu>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Yang Xiwen <forbidden405@foxmail.com>,
        Icenowy Zheng <uwu@icenowy.me>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v8 1/3] dt-bindings: vendor-prefixes: Add prefix alliedvision
Date:   Thu, 14 Sep 2023 17:47:53 +0200
Message-Id: <20230914154758.1795663-2-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914154758.1795663-1-tomm.merciai@gmail.com>
References: <20230914154758.1795663-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a vendor prefix entry for Allied Vision Technologies GmbH
(https://www.alliedvision.com)

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes since v3:
 - Collected tags from LPinchart, CDooley, KKozlowski

Changes since v7:
 - Fix company legal entity from Inc. to GmbH

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index af60bf1a6664..0a1d75c5a302 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -77,6 +77,8 @@ patternProperties:
     description: ALFA Network Inc.
   "^allegro,.*":
     description: Allegro DVT
+  "^alliedvision,.*":
+    description: Allied Vision Technologies GmbH
   "^allo,.*":
     description: Allo.com
   "^allwinner,.*":
-- 
2.34.1


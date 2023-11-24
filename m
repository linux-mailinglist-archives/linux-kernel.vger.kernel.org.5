Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAF97F6FC0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjKXJaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjKXJaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:30:17 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08367D71;
        Fri, 24 Nov 2023 01:30:23 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9c41e95efcbso233662666b.3;
        Fri, 24 Nov 2023 01:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818221; x=1701423021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlD1L1Blhuj7LYCi9p/96xfAYg47OV7zJ/+QMDlhceM=;
        b=GIL62tk7Wk5UwBCQdP0DRtSmJgJI0/iWr9YxAkFs3PcqfhJXydWee3a8nZ4+McVc6T
         UrepW4CFXeqxRusKb5OQTZDDbjaL5IafIIuR8B9tZcSv2Pu6RNBHsSC/pr/vrrxsKEPb
         cjKOxg05Ab+vrDuaLRO/Qs9llyBelhSFOtV7ShSQwRj/VrNfQ4rQB5xxIGJ45kJvauAJ
         Kqf0SA5zF0jLmGaAz9Hrb/DoMInQW0dobQG3BfwcYe87Q8mnpA3nYibLrOUZigQeScLD
         koEBD1Il+bfAt0BQT1V6h8/8FnSiRvrWWQOjM4pUxWhDf6Z6ZEkrekqZTofQXyo1Ph1w
         KpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818221; x=1701423021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dlD1L1Blhuj7LYCi9p/96xfAYg47OV7zJ/+QMDlhceM=;
        b=hacSil+rKYz7kzh+00hDlhg7eBdRj2WltsXDyP18AHtaUtWpKWR4HVxMCsHJ0rrnvV
         l9TG9ED/Mwtty6ZL/I6kTr4C5BLUH65EuPgDNh7Fi+SF9SMlOOODzC8g2M9zm/CYy6x7
         v5ltMVJwyyOWkbfpggmG3ZdDBMXhlH9kr2v6DGMshXkLAufMuC99W26FuMuSDVBmCLVg
         KBINcl5Mu5iz/HFyTjbZtIDRUG8ppkGczBBY6YxZ7NzcYdSbTRYZPk/E+ImlHrmdhE2H
         ab6yNseyGp8jCpzIiX0jErHwTrZMf0my4kjEYb+/JuXrh8evikY5YjVYzSK+0HnLdhPJ
         G6Zw==
X-Gm-Message-State: AOJu0YwNcDOQ22Wa++giEAZlok3NC4/wSUnzrrodmi7Bc6omehcs2CpD
        2whw2LhLDFDgPQSUQ7N3aDQ=
X-Google-Smtp-Source: AGHT+IF8NZLVv1DMiaMh6D/GGpI2K8eqISYSTtQum5S48E2/5ZNlIFTlclxI7yX+dKVjWkEiyqTQ4w==
X-Received: by 2002:a17:906:c41:b0:a02:89cf:e8fd with SMTP id t1-20020a1709060c4100b00a0289cfe8fdmr1492277ejf.57.1700818221322;
        Fri, 24 Nov 2023 01:30:21 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-2-39-142-131.cust.vodafonedsl.it. [2.39.142.131])
        by smtp.gmail.com with ESMTPSA id k9-20020a170906578900b009fee12d0dcdsm1856307ejq.15.2023.11.24.01.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:30:20 -0800 (PST)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     laurent.pinchart@ideasonboard.com, martin.hecht@avnet.eu,
        michael.roeder@avnet.eu, linuxfancy@googlegroups.com,
        mhecht73@gmail.com, sakari.ailus@linux.intel.com,
        christophe.jaillet@wanadoo.fr,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Nicholas Roth <nicholas@rothemail.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Bingbu Cao <bingbu.cao@intel.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v14 1/3] dt-bindings: vendor-prefixes: Add prefix alliedvision
Date:   Fri, 24 Nov 2023 10:30:05 +0100
Message-Id: <20231124093011.2095073-2-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231124093011.2095073-1-tomm.merciai@gmail.com>
References: <20231124093011.2095073-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 309b94c328c8..841da69aeeb6 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -79,6 +79,8 @@ patternProperties:
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


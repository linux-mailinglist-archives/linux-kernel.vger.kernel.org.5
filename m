Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FEE7D114F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377541AbjJTOOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377534AbjJTOOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:14:40 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89C7D46;
        Fri, 20 Oct 2023 07:14:37 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ba1eb73c27so142985666b.3;
        Fri, 20 Oct 2023 07:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697811276; x=1698416076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaiRdQ1c+DDVs4Z20fjdvqfJxBU+ISFg2fzCunWfAwA=;
        b=JvQq5faiVARHGSEZ84tL8AiaAYryrrU24pqXgc+0840vY2u3BjriJYo5tE6HfSGRap
         QwN4PnoJbsID/dikgFp9/URfecgUFLRKvjWj3mdzn/L4FH3+WlNhJhJ8xyGvld6l8Vly
         Xft+M4mRFtV6/lj3+6nOKV3TuSa1Bg8/fCUluIlRt3yTxqoee2Y1+j307JXdHB5SG/Rj
         gY5XpoS+C0NYxD58eXe8NqBy+ZK6/IWOnmtolZIGCO39ncxuq5KkndbOMI8q7V9USPol
         II/VZcQ5e8+N+VMv0NBs6vqV9nKimtLe2vEe28iYvTW1l/kOFRNUR/H7enKx+QdY5tpT
         oy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697811276; x=1698416076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaiRdQ1c+DDVs4Z20fjdvqfJxBU+ISFg2fzCunWfAwA=;
        b=S0CEhibCr2CQZnWWGCP/N3cbKY4F6YsJXizXkqKLJCMk0GIU2qQDyMtaEFsSuUw+nK
         7we69Jgy7+XQAafjcXCWvzrafCIIt1f2tJuLTz/AfabbpnpaCj2QIuAqZeF8Vxr9E6EJ
         Fv7DgrMTWxHOZ24/FB8VB0uQXOtz7DajI6duQthnu7Hi6kEJa1H8506d1TEXJHhfQp2c
         GXEyIdgtUxHTggaE4cYMarNezyfgzIWu9Bm/pppDK/+6r0QgkTYiwX1ecorpOk435u3E
         gSDqZyLWRNVEmtThtYro95fbYEoFC9AhgCDLflhKtqR+4mAh+/icfO8MUcYXJ2aDx5Ku
         lfhg==
X-Gm-Message-State: AOJu0YwOR6LdwlW0hiHXyzhXvJvMeA6gga6B9Pr2xk5nUQFERO/1OaRd
        ajZwV0otF7VcmEKIwVgQZ3k=
X-Google-Smtp-Source: AGHT+IHR0X3u/Lbyo07w6Jx32eb+PZQwfMG19HST6HIpe4TXegFLEwWa5aV4M0UGlOfcV0KdaXv+QA==
X-Received: by 2002:a17:906:fd84:b0:9ba:8ed:eab8 with SMTP id xa4-20020a170906fd8400b009ba08edeab8mr1622389ejb.45.1697811275595;
        Fri, 20 Oct 2023 07:14:35 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-59-109.cust.vodafonedsl.it. [188.217.59.109])
        by smtp.gmail.com with ESMTPSA id i6-20020a17090671c600b009ada9f7217asm1562914ejk.88.2023.10.20.07.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 07:14:34 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     sakari.ailus@linux.intel.com, martin.hecht@avnet.eu,
        michael.roeder@avnet.eu, mhecht73@gmail.com,
        linuxfancy@googlegroups.com,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>, Icenowy Zheng <uwu@icenowy.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v10 1/3] dt-bindings: vendor-prefixes: Add prefix alliedvision
Date:   Fri, 20 Oct 2023 16:13:49 +0200
Message-Id: <20231020141354.2500602-2-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020141354.2500602-1-tomm.merciai@gmail.com>
References: <20231020141354.2500602-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 573578db9509..4763fbfcd936 100644
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


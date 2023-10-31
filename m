Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F4A7DC75E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343724AbjJaHee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbjJaHeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:34:31 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06A2C1;
        Tue, 31 Oct 2023 00:34:28 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9be3b66f254so785970366b.3;
        Tue, 31 Oct 2023 00:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698737667; x=1699342467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaiRdQ1c+DDVs4Z20fjdvqfJxBU+ISFg2fzCunWfAwA=;
        b=JI+kM589L0PPkuhMRUeomEeRDB5sYzG74h+OOF0oPJuI1d6+cju5Gmke3lD04o4pdj
         Ke1d1fGI4Fehiymy/9M/r1OMQ47sNgbgJRbOD2ingZZljJVfwjyh7QV9YNidtIOHtSBs
         xiJCVxczGD6aN0X96tNcg9h9GeG7R2K63skldisf4wl50rwy5dlapHFrb1kQd40mIniT
         U1AfY3rQM5wyAX7Ww1rfir6q0/i3ujsCeuwDWSA52+PMSlGuRi/IzARyswGQjwhCS+Wb
         l+pRt6bobkqrrnTjg1bBz2O2C2PmwgLqVdWgBouAhk1JmHcfrlw5uYjSyaO1P1zV+TSW
         lD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698737667; x=1699342467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaiRdQ1c+DDVs4Z20fjdvqfJxBU+ISFg2fzCunWfAwA=;
        b=jtMl5fGgdBymVbLzJq+8dsRmj4LpwVbB63x21UzTjftd7Vw33GZ0umAfB9gn2pGsYi
         JDY/SP4Y/R7cPCn+R7rZL0fF7gGUcGLHcySFdRsNRa+UIk5e0/B60MJ0kP7x2cQtAZvJ
         K+Jyo8ulophAuxzxr0/ajCkAqpOjWFC/CMuPn2ick31LGIYxOq6GePSC28ilfSydmx+M
         8Crpyy2bOA8jTmc1f5/FI3kdNTHIA/9u8anbsN0frglsCDG/9cGm0oLGTeI4/agUyLTw
         VKpFcKCefIg8Bmy7DbKriygD/YzstYEwS4KOhMDdB0RZmCnXjs/HCR8cAOv0W6zjNotB
         YDog==
X-Gm-Message-State: AOJu0Ywllbm3mtRGHCS5muSl6VRha7zoOMAc7FDAhGVJ9yrbAg0NqBVA
        aXki1q/G9Jg+HlNUpJTkzKg=
X-Google-Smtp-Source: AGHT+IFRnJwlt4jfCJeK/JlYyYRhoZ7FYb/4ga7Vff4anXgGHDAddPNvbI9KlDs0XYs+4Z0fQL6qug==
X-Received: by 2002:a17:906:57c4:b0:9d3:6040:cf05 with SMTP id u4-20020a17090657c400b009d36040cf05mr5078257ejr.31.1698737666962;
        Tue, 31 Oct 2023 00:34:26 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-59-109.cust.vodafonedsl.it. [188.217.59.109])
        by smtp.gmail.com with ESMTPSA id jj13-20020a170907984d00b009d51f9d54edsm486845ejc.126.2023.10.31.00.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 00:34:26 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     laurent.pinchart@ideasonboard.com, martin.hecht@avnet.eu,
        michael.roeder@avnet.eu, linuxfancy@googlegroups.com,
        mhecht73@gmail.com, sakari.ailus@linux.intel.com,
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
        Bjorn Andersson <andersson@kernel.org>,
        Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Yang Xiwen <forbidden405@foxmail.com>,
        Icenowy Zheng <uwu@icenowy.me>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Nicholas Roth <nicholas@rothemail.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v11 1/3] dt-bindings: vendor-prefixes: Add prefix alliedvision
Date:   Tue, 31 Oct 2023 08:34:12 +0100
Message-Id: <20231031073417.556053-2-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031073417.556053-1-tomm.merciai@gmail.com>
References: <20231031073417.556053-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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


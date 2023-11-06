Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5797E1BD8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjKFIVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjKFIVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:21:16 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89027100;
        Mon,  6 Nov 2023 00:21:12 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53de0d1dc46so7039637a12.3;
        Mon, 06 Nov 2023 00:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699258871; x=1699863671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaiRdQ1c+DDVs4Z20fjdvqfJxBU+ISFg2fzCunWfAwA=;
        b=QfSJq4OdRjjyGEApLEquTzMlT9+zB8YKfzrh7PwB1CAgL5wp2+YNNZG2yiQjBegNTG
         YYVdrzcjbCxXYuzGyswwICnR+EfQw+MmkpYmMKHVdpfokYPQq85Cjtn91hbAO1pBHtlw
         Q+KCf13dfv5f6LwRnVCf063/Uex7fwVdqhdgh7h8ZdZGwlaCGiOeCuMLCHRZN8/k6qDd
         bTHwc1IWzppMtC3PGg3TYuetuk9vOzoSMrH5pPLy/SaacnegCFobGZIGzGZsAiEmfZ+f
         cyqP5MeP/1lv8i6wk1/OCZO1bZJGvSRoSliaGDgAMAZ2LCyIBi9uz+rsdT0ZzwO93Oo8
         1PGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699258871; x=1699863671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaiRdQ1c+DDVs4Z20fjdvqfJxBU+ISFg2fzCunWfAwA=;
        b=PgHaTts3BfA8K2Hrx6QA7BR5tLhLviqadAGxYtkYbYM6C3BR3U//uH/Xindc2nagXv
         CImVcOp7xBZzV74VfdR9acbbu152VTa85y3Pc4OrZdKkeZMZkJRJZEtKMzsaYl91i88T
         tO5LlWTkrtNkIq72IYxtdxTk2zgsFM/s21k049C4dCZkI4LO8vNyo+yLg8W2UNx4KzS8
         Tc9j0lHNHEYq6gAgxKicLrxm3Ez97FDfmQa1p43/JIy4B00Sk8P5xRAtAdtns0EXt0FE
         jR++iHqMs7ME3zA9rS+g+cio6dz6uAugs8xvIgNuduutgjXfQ49IFlvfetxDyfLKXl+W
         XiTQ==
X-Gm-Message-State: AOJu0YzLJGtpOc8cToFyvKq85gIocdgxrSQGsxhgcqWDTlVMjLHLinzw
        4JPZj6tYvD+v5S5VC8yyFEY=
X-Google-Smtp-Source: AGHT+IEKtqsrKB1kb71jbhsBeqfKpuKEo8Mpz0qgW31whm9CYTmPVCnOab2ipxX4HfKaenFakbVAlg==
X-Received: by 2002:a50:8e5d:0:b0:543:c50c:cacc with SMTP id 29-20020a508e5d000000b00543c50ccaccmr10881395edx.41.1699258870749;
        Mon, 06 Nov 2023 00:21:10 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-59-109.cust.vodafonedsl.it. [188.217.59.109])
        by smtp.gmail.com with ESMTPSA id x1-20020a50ba81000000b005434e3d8e7bsm4221884ede.1.2023.11.06.00.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 00:21:10 -0800 (PST)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     sakari.ailus@linux.intel.com, martin.hecht@avnet.eu,
        michael.roeder@avnet.eu, mhecht73@gmail.com,
        linuxfancy@googlegroups.com, laurent.pinchart@ideasonboard.com,
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
        Shawn Guo <shawnguo@kernel.org>, Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Icenowy Zheng <uwu@icenowy.me>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v13 1/3] dt-bindings: vendor-prefixes: Add prefix alliedvision
Date:   Mon,  6 Nov 2023 09:20:56 +0100
Message-Id: <20231106082102.368937-2-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106082102.368937-1-tomm.merciai@gmail.com>
References: <20231106082102.368937-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDC976A367
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjGaVw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjGaVwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:52:25 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E21CE7;
        Mon, 31 Jul 2023 14:52:21 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3175f17a7baso4494091f8f.0;
        Mon, 31 Jul 2023 14:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690840339; x=1691445139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LgpOpS8zPiMqsk7e0dzu/7DJUbx/2+7u802O0JxbEFU=;
        b=j9/na9J/IBRpLUmvKS2qVcLRYaHgOiOoVAVGyNW4LiHJQPz/vJiOFosZi4eXivz/HZ
         h6Knd33uYpyoLsr+5B0j24rQZ/sY4DY49h4L0Gz78wCz5KLyRKSPfEUCnyfdcHVLgAi1
         trIDXt6IwyJtJE3r5W36skOjI0sEdERY+eJIi+1Hlj2DUug6gMp75tpD+HcnvxEg2cE4
         xlmTpHuK9CrfQG2o1G78oBlwxo+K0B544ZOUNZcBaIJQIEGK4wUIOmpiDTBpJPhppyxw
         FTfm3v27OLir9Cii64rjzyIgq8PAHq8J7BD85jTCAQMQbHXGYIZLHDEJhK7MdE5/hVG0
         lUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690840339; x=1691445139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LgpOpS8zPiMqsk7e0dzu/7DJUbx/2+7u802O0JxbEFU=;
        b=GrLhNN0NBeMOqIEpWooM5O2anG/xlAPJ7ywVI4LNO7V2X+6eUEPuVv4nDZ9pr2ppBd
         FMrvhPQjtPGmMcT2XOCisRrrkVzltVYT51oGfUs9kHNrzdoRLjM6jBwc3WExv3Z3i1tr
         /kCzz4IH7vVVTplR+dmmh+n4eweW73o7f94hlL0THWbJ+LK9688NIMTovag7LKOX9xbI
         MZaQ/896vNjHZhbzSh8G0SySlv5sQQyrnwCRpefc+i7VZUjHOB4CDdPxK9sw1Ob89UMS
         YF9zwodWb+o2LM6sv0ncGXsNLsxx3Zk8Cc63UdNl/i/BecvpqDo8ufIZwg15Z7seb4q9
         jbPA==
X-Gm-Message-State: ABy/qLbDBg61PHPXDtGsgITXb0mNBgwdpXcWWZWageLQ4m6efqaIQ9iC
        ddNyzG3eZcP07gtbvq4lHgCuYC6uc2A=
X-Google-Smtp-Source: APBJJlHzrakuoVmqaVDMP5XX3A7XiukrqeVKsSpvrDgq2ptFhGBlv2rfpe6hvj8AANvXW1CXzXFZwQ==
X-Received: by 2002:a5d:5259:0:b0:313:ee2e:dae1 with SMTP id k25-20020a5d5259000000b00313ee2edae1mr689304wrc.18.1690840339311;
        Mon, 31 Jul 2023 14:52:19 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-59-106.cust.vodafonedsl.it. [188.217.59.106])
        by smtp.gmail.com with ESMTPSA id q20-20020a1709060e5400b00992b3ea1ee4sm6858783eji.149.2023.07.31.14.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 14:52:18 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     sakari.ailus@linux.intel.com, linuxfancy@googlegroups.com,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: dt-bindings: ov5693: fix maintainer email address
Date:   Mon, 31 Jul 2023 23:52:15 +0200
Message-Id: <20230731215215.3045794-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Switch my mail address from a company mail to a personal one.

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
index 359dc08440a8..d3df4fde34ba 100644
--- a/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml
@@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Omnivision OV5693 CMOS Sensor
 
 maintainers:
-  - Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
+  - Tommaso Merciai <tomm.merciai@gmail.com>
 
 description: |
   The Omnivision OV5693 is a high performance, 1/4-inch, 5 megapixel, CMOS
-- 
2.34.1


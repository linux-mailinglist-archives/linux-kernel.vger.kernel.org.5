Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FED769533
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjGaLtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjGaLtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:49:02 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BE410C;
        Mon, 31 Jul 2023 04:49:01 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bf1f632b8so458485166b.1;
        Mon, 31 Jul 2023 04:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690804140; x=1691408940;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5s6A5U4bCqKX9zBuGy2auiAAIIEUq3nqLvJzYU+MjM=;
        b=CZm/FDbhbT2gtRX0cyfSNirUX3IGYeFEjHSlmMNJNdM3Mjw+W2QUrKNgz7W+vyrKbF
         sDbRyhw5IJ7uZxuVwZ+zo6vT9HQTskf31r5gtuQR09BW6KIcwftHuGtR767pXl8IINm5
         VFycAGKxYXwiAv2WDsuCTAhkxJJcHtAhnpZMSfxAdk8VWsNuNmBrpNtzFe6CAGBN++mw
         eCTwN+bHj1ihSPEakyB1pYQMjUUlmhTkR90fnpiiGiLF6pXdgN9eIgrzqGm+6gWd9oz2
         QLw0vLxDz7pjyVvPdYbj/xDRrZit4fCt7fh9IhIqxn3ThV3lsaU25/rWXR1erELuBr7V
         mf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690804140; x=1691408940;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5s6A5U4bCqKX9zBuGy2auiAAIIEUq3nqLvJzYU+MjM=;
        b=JfXQnN4MunyqY+8V5ckmu8U2I9mBEQyASg6mHKnPFqkzyFeor67qiV9u4wVAjQqUdC
         KeSApTYfMqrP1Axl1luSlIhPPa1FZVqGszyztjFkcwuNskgjz9b8Iko+42tAu3AnRL3H
         79kAIUUmYh4Th38CyDvZAbfKutMby51FhYLXJ7YukljOAOrCFVfaFKopwKmqDiK9VGGi
         wHsivAydbeYau6xaPasCZDFpo+qV65LWB8u80698jaYppdmBeAeJs99Bm/30qNMOwwds
         etzcO9VHxRLKw45QXgm6W3b+iaFXh4VUguzgpSW9gkvRu9RQR/OhZk+QT9QK2piUSkuA
         eOzA==
X-Gm-Message-State: ABy/qLZnImMboa6QEZsVAA5FE9VbDbb3RxbD8JfL/c/QHW8jn21VfTkw
        IZe6pxv8GJE4KLzharks/m9IQFzG6/Q=
X-Google-Smtp-Source: APBJJlEsLpE4SAtgI8XtELoIQrcSZV/UEognZflSa0wsKia9wLHj9xFS7H+FYXArdZykU1DH3gxFKA==
X-Received: by 2002:a17:906:3192:b0:99b:66eb:2162 with SMTP id 18-20020a170906319200b0099b66eb2162mr6513637ejy.5.1690804139752;
        Mon, 31 Jul 2023 04:48:59 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:7172:435e:e8bd:2cf])
        by smtp.gmail.com with ESMTPSA id k13-20020a170906970d00b009893f268b92sm6063734ejx.28.2023.07.31.04.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 04:48:59 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jack Zhu <jack.zhu@starfivetech.com>,
        Changhuang Liang <changhuang.liang@starfivetech.com>,
        Minda Chen <minda.chen@starfivetech.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-phy@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: correct file entry in STARFIVE JH7110 DPHY RX DRIVER
Date:   Mon, 31 Jul 2023 13:48:56 +0200
Message-Id: <20230731114856.14401-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f8aa660841bc ("phy: starfive: Add mipi dphy rx support") adds the
MAINTAINERS section STARFIVE JH7110 DPHY RX DRIVER referring to
'phy-starfive-dphy-rx.c', but the file actually added in this commit is
named 'phy-jh7110-dphy-rx.c'.

Correct the file entry in STARFIVE JH7110 DPHY RX DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 733bcfa0209a..003b0461641a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20345,7 +20345,7 @@ M:	Jack Zhu <jack.zhu@starfivetech.com>
 M:	Changhuang Liang <changhuang.liang@starfivetech.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
-F:	drivers/phy/starfive/phy-starfive-dphy-rx.c
+F:	drivers/phy/starfive/phy-jh7110-dphy-rx.c
 
 STARFIVE JH7110 MMC/SD/SDIO DRIVER
 M:	William Qiu <william.qiu@starfivetech.com>
-- 
2.17.1


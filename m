Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F369975417B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjGNRwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbjGNRwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:52:22 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF0F173B;
        Fri, 14 Jul 2023 10:51:47 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-345fcf8951fso9673875ab.1;
        Fri, 14 Jul 2023 10:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357022; x=1691949022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1rucALi6oAv2chldSxXwAIScTfciNmzHu3E9+4nv0w=;
        b=ANZLQPrT9uP74q4HOgMjCHTOwfJtF54K8CfN5rM6Z3PgdCi4kyTHNqgR/9R+1RPZnN
         iwYXuODuhvo7Eu5kUhw9mVQDt4EtTkQEuoQtNHibveJBuQOT8eXS8qCOj6SRN8Xd3TbL
         I/064pZZxOSzro56qEaLNcDw6B5DgzEqPUUG8tDoLnqB7autIu1sHpbH7ZZ9gXwnWzXq
         4r0icddM4euB/am5PWkJ6/d7LqhnGY3dgV9Y8xP5NewaShBBeyRwUU+cBEmtkDRcysbH
         SGxfmHbh4eiks6K08pNDhxdztTofTjEMmhXEk5UifWGXCtPdFLPcAiLzRwdX95Kjx/TY
         rDEg==
X-Gm-Message-State: ABy/qLb3GNTZSwlcXCW12PoLcxLMBjytEVgSBuXpVnjICpe9l1zUUdLH
        uwY5eg/M+iNMkQ/TuNwZXw==
X-Google-Smtp-Source: APBJJlEx91G3Ibvbj8NwM5kn+7hG/vmpw5UnHj5DwKMzDI0mzZ/2XKJHg12dJh61mT/2CnOPqAy3Uw==
X-Received: by 2002:a92:d28c:0:b0:346:420f:2bb7 with SMTP id p12-20020a92d28c000000b00346420f2bb7mr5771848ilp.16.1689357021983;
        Fri, 14 Jul 2023 10:50:21 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id x8-20020a92dc48000000b0034607609251sm2874160ilq.87.2023.07.14.10.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:50:21 -0700 (PDT)
Received: (nullmailer pid 4064131 invoked by uid 1000);
        Fri, 14 Jul 2023 17:49:52 -0000
From:   Rob Herring <robh@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soundwire: Explicitly include correct DT includes
Date:   Fri, 14 Jul 2023 11:49:46 -0600
Message-Id: <20230714174946.4063995-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/soundwire/qcom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 7970fdb27ba0..d178a0dc0918 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -10,7 +10,6 @@
 #include <linux/debugfs.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
-#include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
-- 
2.40.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBA0784A41
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjHVTUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjHVTUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:20:48 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704DDCF9;
        Tue, 22 Aug 2023 12:20:44 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4ff88239785so7418113e87.0;
        Tue, 22 Aug 2023 12:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692732043; x=1693336843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvhKaI6r0W1C4+RBLU7eU9dAwMmpGblkvdENLHIwoXM=;
        b=XwXRtQuESHoRRBwsl+qTeocp9IXB8p5jE1UN8dmHTWB3eZVQlJuweDMRDdD1yQV3lB
         N5LLtGMsShkOrlNTFmLhylL1p5ia3759MJ0eofGAz1TUOte8voW6xdkCoom/DiMNdke4
         kYtBP5Lzokp1Z/7T+kxYCIC81bRU7dtn1DilWr10HGNzrEMX/rvkf8H1BvAgCwGfElMI
         oKuE3eYUeVLD0MqQBLqFxS2py25l98cSabvGh68BVO/CzJO7X+Yr3s+8VpBn7pycP1Gy
         h/zRAHh6P1KPecMWHZWn+XScPqGQ86hYeZufsle/Meu87Tx9m3VE156mh38SzfJG5x8t
         wTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692732043; x=1693336843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZvhKaI6r0W1C4+RBLU7eU9dAwMmpGblkvdENLHIwoXM=;
        b=ECg2l9oReyXfMxYusCp9mRoa10PGP5XEjQnImlBBe5Ld6LxpRwHGmtDMqTllhIDoi+
         20EWO3Z74WHD4mtEHFW0begFwhc4wbS6jOPC6+Cyam0KB+vRbTWRZXk2uhkitoo48VKe
         KoRkNfvdSi9AOSvmbAc0FUm6HhYow+iz1sens1qvvrH8a4tZNosUUQ8qEXfBi97v67Uc
         NJxyAJMMm5JaQuGU5mSBr3BVSoWPV0e2gpqtCwkQ6sGDpQJVbj7oWyvPSz1jdLsa/E18
         MLigk6K9MwI9dXjdXAf9PAm5yicq9ljhEPeSXo1u7i0f7EqUSUJQbYNyEEEHZji1R6sY
         pHdA==
X-Gm-Message-State: AOJu0Yywz5OJsibeHyXE0/Cy4UlfwwBZuP7zkUZSRyTQEIxfASQ3sBtF
        1O+NW23Kg6u6hQGn3QtFzbs=
X-Google-Smtp-Source: AGHT+IG57EiyjkatLWfKp7u4QEA2FTRjnjI6F652/hZM0wMeS6znDsoUBJBVS1/gPjThe1gHO4sd8g==
X-Received: by 2002:ac2:48b4:0:b0:4fb:c028:d76f with SMTP id u20-20020ac248b4000000b004fbc028d76fmr5706358lfg.35.1692732042309;
        Tue, 22 Aug 2023 12:20:42 -0700 (PDT)
Received: from localhost.localdomain (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id b12-20020ac2410c000000b004fe89735f1asm450586lfi.34.2023.08.22.12.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 12:20:41 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/6] Add support for the whole MCP39xx family
Date:   Tue, 22 Aug 2023 21:22:53 +0200
Message-ID: <20230822192259.1125792-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main goal with this patchset is to add support for all similar
MCP39xx ADC chips.
During all patch iterations we ended up with a few cleanup patches.

See version notes in each patch.

Marcus Folkesson (6):
  dt-bindings: iio: adc: mcp3911: add support for the whole MCP39xx
    family
  iio: adc: mcp3911: make use of dev_err_probe()
  iio: adc: mcp3911: simplify usage of spi->dev
  iio: adc: mcp3911: fix indentation
  iio: adc: mcp3911: avoid ambiguity parameters in macros
  iio: adc: mcp3911: add support for the whole MCP39xx family

 .../bindings/iio/adc/microchip,mcp3911.yaml   |   6 +
 drivers/iio/adc/Kconfig                       |   6 +-
 drivers/iio/adc/mcp3911.c                     | 562 ++++++++++++++----
 3 files changed, 462 insertions(+), 112 deletions(-)


base-commit: b320441c04c9bea76cbee1196ae55c20288fd7a6
-- 
2.41.0


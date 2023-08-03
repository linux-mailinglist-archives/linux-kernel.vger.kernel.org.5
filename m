Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5008B76E8E5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbjHCM4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjHCM4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:56:42 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E1E1712;
        Thu,  3 Aug 2023 05:56:41 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-523108efb36so499163a12.1;
        Thu, 03 Aug 2023 05:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691067400; x=1691672200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9w2kAX5SuWXUcxUMa/7advq5QKHG60UYwE5l01L0SL4=;
        b=H3ibOCOUojy7D5f0/dMAe08rOL8nXB9zx2LjkJkv0CoLWmyo+cZ2sdjUQex7XzzUjZ
         GecP/NbvZQKWjg6MQpUhv9XVWB3Uc6evWDnBRFhxjO74HMmaGZG83Q81VVRfenURPVcN
         bvfyHXlmjER5lmnD2CFFRlt4WdixwvtMJGJh2I8OaMi2xVx9o6HU7WyjPuv3yAw15JAV
         lJmYyR4WikgXhitDWGMzYC8Ihm6SfSomNBetyrrNJY4pnsQthav6IfZ53zn4Hbehgmx2
         7LoX6BUIDIZHyK81SDQDRvAOtllsF1/RAfl9ak7JpQQsvcjeNVkNavDtRA3nU7B4XmuE
         Ar0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691067400; x=1691672200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9w2kAX5SuWXUcxUMa/7advq5QKHG60UYwE5l01L0SL4=;
        b=aevDG4PV8dJNvxl/rLBRSqPqVyok7Ksnav3zrr/988Jv6SxJB8qoXeBQibcCQejFtA
         o6/ICP4CXiIw0oY20NG2tLd8KNFNKKYIrL/2JXQkSToDanKVY0Z8gDbla+QeIoB7bqf9
         A0v4oAh12SE19vlMINxhvGbVdADLmZVl/NB5kz4F2teUCTwx5LD3xsEmk3ne3d8uL8/5
         MseDy9XMQJafAR5Iegy+h8BjtChPy5F12Ck6ahAy4Qp0GGp8+hx8W0AwQSBjN9UpsYow
         lp78m+v4CT3gvrkQFLMXYsfTlwr/kZf1NGi7DYwLNVcvWPit3k/xPcTQqT6R5WfCHvBM
         i/Fg==
X-Gm-Message-State: ABy/qLaLz0gb0004nCTobYcrupGErdhvzq03G44f8z0TBlZKgw5GIy9y
        J/ZUvJIrdkeYd+pxEfu73s8=
X-Google-Smtp-Source: APBJJlGDtIbCvMmKx/Bm1ASPtAVgVnQMJIdWxxexX0nBxEAKPzbyqADWOguSCp1E5vLkt+biTy0Iww==
X-Received: by 2002:a17:906:3cb1:b0:99b:f08d:a390 with SMTP id b17-20020a1709063cb100b0099bf08da390mr6778946ejh.26.1691067399651;
        Thu, 03 Aug 2023 05:56:39 -0700 (PDT)
Received: from colla-nuc.fritz.box (host-79-26-241-62.retail.telecomitalia.it. [79.26.241.62])
        by smtp.gmail.com with ESMTPSA id ci18-20020a170906c35200b0099bd682f317sm10378877ejb.206.2023.08.03.05.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 05:56:39 -0700 (PDT)
Received: from colla-nuc.fritz.box (localhost [127.0.0.1])
        by colla-nuc.fritz.box (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 373CucRs207731;
        Thu, 3 Aug 2023 14:56:38 +0200
Received: (from colla@localhost)
        by colla-nuc.fritz.box (8.15.2/8.15.2/Submit) id 373Cub6h207730;
        Thu, 3 Aug 2023 14:56:37 +0200
From:   Andrea Collamati <andrea.collamati@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrea Collamati <andrea.collamati@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: =?UTF-8?q?=5BPATCH=20v4=200/2=5D=20add=20MCP4728=20I2C=20DAC=20driver=E2=80=8B?=
Date:   Thu,  3 Aug 2023 14:56:33 +0200
Message-Id: <cover.1691066050.git.andrea.collamati@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes v3->v4:
- sorted includes
- driver name inlined
- used FIELD_PREP() / FIELD_GET() to define/access regs
- fix comment style
- removed infrastructur form multiple support devices
- wrapped up custom ABI in the standard ABI of _scale
- used dev_get_drvdata(dev) to cleanup code
- used devm_add_action_or_reset to cleanup code

Changes v2->v3:
- fix wrong i2c_device_id array indentation
- removed double blank line in Kconfig
- added description in dt-bindings
- use uppercase letters for device name

Changes v1->v2:
- fix mcp4728_remove prototype
- improve indentation
- various fixes suggested by checkscript.pl
- removed unused of_device_id.data field
- removed unuseful mcp4728_data.id field
- various fixes suggested by dt_binding_check

Andrea Collamati (2):
  dt-bindings: iio: dac: add mcp4728.yaml
  iio: add MCP4728 I2C DAC driver

 .../bindings/iio/dac/microchip,mcp4728.yaml   |  49 ++
 drivers/iio/dac/Kconfig                       |  11 +
 drivers/iio/dac/Makefile                      |   1 +
 drivers/iio/dac/mcp4728.c                     | 626 ++++++++++++++++++
 4 files changed, 687 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml
 create mode 100644 drivers/iio/dac/mcp4728.c

-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F351A786D6F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbjHXLKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240890AbjHXLKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:10:25 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F9D170C;
        Thu, 24 Aug 2023 04:10:22 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52557cc5e7bso8457587a12.0;
        Thu, 24 Aug 2023 04:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692875421; x=1693480221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jkbDacAVIJc3SIkD4/CeFSCfR5j09z6rk6bW+uWaELg=;
        b=l6xFIHlGOS++G+HbWws9y3CRTUxtsCfW5hVXr0+Ue8lMVNvAuCSbGnKhRr0gEoiO17
         Ok1QJQ3J2v8TBXPH/rUV/1nc3fAoykL+86qJG2tJcW78nKVKzKnCl9qYCv0PaphyLY6m
         Uf0XX7KRxNRTrs9RYhQHSMrvlbUrh/6iirxeQ1XNX4qxQt5alFD7IIGdPqX3fVJJJvtW
         VjPWDjJbDcQd3lx3TILwcE/mmoTuS4+niLGvIXXJmor/m8O5N/yBmCFSAYFt+G4mMk+M
         Lqf3m7GcEmr5tHaklw4qUuqVQek9H63qK+CHOBd6x4PauBoKfa+JA6C0VFzUzkfyLS7y
         76Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692875421; x=1693480221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jkbDacAVIJc3SIkD4/CeFSCfR5j09z6rk6bW+uWaELg=;
        b=Qhukaxnd8hFPu5klHmg1WH0ZzW8BoHyCKX4QpIE2TMbhMKzsvZVHZzCoIxdmNXJ9W8
         DIzTAmgbcBqHdUE140QLCrQmvLVqPxER8lw0ejXs4iMenwDgOBKgoYWakT3tK29R8nFx
         RW8gcC1p6q/rX6cqjVuf8deD/mX4ec4u5dUMA81roy1nNwui2VxR7q3DM0tp1CF3uJDs
         Wf6zoD22vyBY7iAcAzZnODRYCZwFXwuJkNsksD5o361yY5EJRZMDm/I10nM5pPsti9HE
         EpEKg49eY+QAaK+YOpOoZaVsXKP+UINAVjw8SbgPU69wWbYVzd7E1x0p0xq7QE27CuR/
         c2WA==
X-Gm-Message-State: AOJu0YwgvNzpJUQA6qs5YXrjzY7lz6Pb6krlk+Er/0HTikJdhtbANqWi
        EKF8YSJdwqLaL2ievN4T44CLc4WMSDlS8g==
X-Google-Smtp-Source: AGHT+IF/TCg21ubHIejT7x56T7iYzKw7dF3iKQ4SNBMAqe23yyLPKnLxCnVTbkg647VMAg9J/rztHA==
X-Received: by 2002:a05:6402:1502:b0:52a:1d9c:83f2 with SMTP id f2-20020a056402150200b0052a1d9c83f2mr5721749edw.23.1692875421004;
        Thu, 24 Aug 2023 04:10:21 -0700 (PDT)
Received: from fedora.dev.tbscz ([85.93.123.158])
        by smtp.gmail.com with ESMTPSA id l8-20020a056402028800b005232e637c24sm972876edv.84.2023.08.24.04.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 04:10:20 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregkh@linuxfoundation.org,
        linus.walleij@linaro.org, quic_jhugo@quicinc.com,
        nipun.gupta@amd.com, tzimmermann@suse.de, ogabbay@kernel.org,
        mathieu.poirier@linaro.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, linux@zary.sk, arnd@arndb.de,
        yangyicong@hisilicon.com, benjamin.tissoires@redhat.com,
        masahiroy@kernel.org, jacek.lawrynowicz@linux.intel.com,
        geert+renesas@glider.be, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com,
        =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Subject: [PATCHv5 0/4] Wiegand bus driver and GPIO bitbanged controller
Date:   Thu, 24 Aug 2023 13:10:11 +0200
Message-Id: <20230824111015.57765-1-m.zatovic1@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have fixed all the pointed out issues and I present the next version
of Wiegand bus driver and Wiegand GPIO bitbanged controller. The most
noticable change is the change of the input data format, which is now
ASCII hex string. Please let me know, if you see any issues.

I have also included a brief information about Wiegand in the commit
message of the commit adding the bus driver, since there is no official
datasheet that I could link.

CHANGELOG:
wiegand.c
- kernel symbols are now part of WIEGAND namespace
- added includes for conatiner_of.h and types.h
- made IDA static
- removed redundant null checks and error messages
- added overflow check for memory allocation size
- used devm_add_action_or_reset() for controller allocation
- fixed comments according to kernel doc validator
- avoided dereferencing fwnode in struct device by using device_set_node()
- fixed fwnode format specifier
- removed the overly complicated system for getting timings and replaced it
  with a clear and easily understandable one
- unified the goto label names
- removed static keyword from struct bus_type
- used bitmap_parse_user() function to parse the user data, which also means
  that the input format has changed to ASCII hex string
- removed input length checks as they are not valid anymore using the new input
  format

wiegand.h
- removed unnecesary mod_devicetable.h include and added container_of.h and
  types.h includes
- added fs.h header for struct file_operations
- removed underscores in some variables names within macros

wiegand-gpio.c
- fixed some error codes
- used fsleep() in the wiegand_gpio_send_bit() function
- edited the loop in wiegand_gpio_write_by_bits() so that it doesnt check for
  the last bit in each iteration
- used the devm_gpiod_get_array() for acquiring the two gpio lines
- imported WIEGAND namespace

wiegand-gpio.yaml
- dropped devicetree bindings

Martin Zaťovič (4):
  dt-bindings: wiegand: add Wiegand controller common properties
  wiegand: add Wiegand bus driver
  dt-bindings: wiegand: add GPIO bitbanged Wiegand controller
  wiegand: add Wiegand GPIO bitbanged controller driver

 .../ABI/testing/sysfs-driver-wiegand-gpio     |   9 +
 .../bindings/wiegand/wiegand-controller.yaml  |  39 ++
 .../bindings/wiegand/wiegand-gpio.yaml        |  46 ++
 MAINTAINERS                                   |  14 +
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/wiegand/Kconfig                       |  36 ++
 drivers/wiegand/Makefile                      |   2 +
 drivers/wiegand/wiegand-gpio.c                | 192 ++++++
 drivers/wiegand/wiegand.c                     | 590 ++++++++++++++++++
 include/linux/wiegand.h                       | 148 +++++
 11 files changed, 1079 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-wiegand-gpio
 create mode 100644 Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
 create mode 100644 Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml
 create mode 100644 drivers/wiegand/Kconfig
 create mode 100644 drivers/wiegand/Makefile
 create mode 100644 drivers/wiegand/wiegand-gpio.c
 create mode 100644 drivers/wiegand/wiegand.c
 create mode 100644 include/linux/wiegand.h

-- 
2.40.1


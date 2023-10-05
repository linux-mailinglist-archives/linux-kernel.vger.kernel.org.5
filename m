Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB20E7B9FB2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbjJEO1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbjJEOYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:24:50 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0E293CF;
        Thu,  5 Oct 2023 01:52:07 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3af5b26d599so514069b6e.2;
        Thu, 05 Oct 2023 01:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696495926; x=1697100726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=14DahahFkQoOWdX47n8G7u6PeGawD3QEfTn/cdN7xE4=;
        b=dPHLynF6KzACCjRiQPP5uf3F31Uz5UrsNK98j0GNbYl9vLSo1wyRhCQ5g4biA9pBv7
         JN+j21Nry6XIST/rp9h3cWUJshlwy9Th7aGfLFpSZxY+OF7dowSdt6IdwDhzTIYk7x5I
         NzesNXqac8gDZSEmX6+OBkxpvOGClVMI/Etw/A/PFr2zk6zc9t1LTTg+WShHKtFXmegG
         tJZ0G0nFsJ5VsxbmIMjqt3ccwUZ/bJLZdInYwEH2PO/vw8T+w+VD+aVBkS5pviMYFI55
         V3nBBvqrUjp+LPjG9CKIeEkTxl+XZ6+8thLThFnvm7mAvZDRi67CqshyKsIYbBhy8PR4
         hjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696495926; x=1697100726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14DahahFkQoOWdX47n8G7u6PeGawD3QEfTn/cdN7xE4=;
        b=XLuKkxqfKRGpw7na9K9wQzFXyO99X8tgznM7nGByJxgb3/qiMP6Tlz0vkziNZCLwMt
         wJL5KgbxGLbM+MbBVCSu0U5jsr7HvzedZU/bfWnkly6UGqyj6EGCPNotlWT1uk0hx2Os
         +g95Jind8S75lZC2h4q5wtme26tApk3pIJgD6VCscyP4ZWhn96b4JqP8+08+mWS24vna
         s2VRmNEBXn673UWe09aWix0/GLVIAPNRMNC4kfCVoCJGIQHnN7Mh/Ps+M4DT5VH/e9jU
         LybQG0J8NWob4QTDxNgufAwrDoNAX/cDWxekdFELtt1wcbW+nWOHEFZD2+RcEXuDQdtl
         SLgA==
X-Gm-Message-State: AOJu0YzQfI0EcxPwoZeAjC5k0xwVMQS+gdO+oLKR6nr4+Y9DL4mswbmO
        ibvE7QKutgmUFe1sbuBLxpvLFHEzHqym6A==
X-Google-Smtp-Source: AGHT+IHO8zLha/0xfhHNk1JVmXIZSf1rn1EFvZhUelMtoLLYh8NBFNZlR/QCH5KYSfHX8ZEYUTNVug==
X-Received: by 2002:a05:6358:e49e:b0:15c:e2c9:d1ca with SMTP id by30-20020a056358e49e00b0015ce2c9d1camr5664689rwb.1.1696495926581;
        Thu, 05 Oct 2023 01:52:06 -0700 (PDT)
Received: from wenkaidev (118-163-147-182.hinet-ip.hinet.net. [118.163.147.182])
        by smtp.gmail.com with ESMTPSA id z8-20020a17090a014800b00262eb0d141esm1092591pje.28.2023.10.05.01.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 01:52:05 -0700 (PDT)
From:   advantech.susiteam@gmail.com
To:     advantech.susiteam@gmail.com
Cc:     wenkai.chung@advantech.com.tw, Susi.Driver@advantech.com,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH 0/5] watchdog: eiois200_wdt: Add EIO-IS200 Watchdog Driver
Date:   Thu,  5 Oct 2023 16:51:18 +0800
Message-Id: <cover.1696495372.git.advantech.susiteam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenkai <advantech.susiteam@gmail.com>

This patch series aims to add support for the Advantech EIO-IS200
Embedded Controller's watchdog timer to the Linux kernel. The EIO-IS200
is a widely used embedded controller, and this series introduces a
native driver for its watchdog timer functionality within the Linux
ecosystem.

Driver Features:
- Complete support for the Advantech EIO-IS200 Embedded Controller's
  hardware watchdog timer.
- Seamless integration with the Linux Watchdog framework, enabling
  standard watchdog functionality.
- Flexible configuration options for watchdog timeout and event types.
- Module parameters for setting default timeout and event type.
- The EIO-IS200 can select special event output pin such as PWRBTN
  (Power button),SCI (ACPI System Control Interrupt), IRQ, and GPIO

Driver Dependencies:
- The driver relies on the Linux Multi-Function Device (MFD) framework
  and related dependencies.
- Assumption of the presence of the Advantech eiois200_core MFD core
  driver.

Wenkai (5):
  watchdog: eiois200_wdt: Constructing Advantech EIO-IS200 watchdog
			  driver
  watchdog: eiois200_wdt: Add PMC support with eiois200_core.
  watchdog: eiois200_wdt: Implement basic watchdog functionalities
  watchdog: eiois200_wdt: Enhanced watchdog functionality and pretimeout
  watchdog: eiois200_wdt: Enhanced IRQ trigger behavior

 drivers/watchdog/Kconfig        |  14 +
 drivers/watchdog/Makefile       |   1 +
 drivers/watchdog/eiois200_wdt.c | 658 ++++++++++++++++++++++++++++++++
 3 files changed, 673 insertions(+)
 create mode 100644 drivers/watchdog/eiois200_wdt.c


base-commit: 9aab92bc3a8922d4b2e24d10271dfe3034cbf5c2
-- 
2.34.1


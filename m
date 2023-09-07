Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FC9796F31
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 05:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbjIGDN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 23:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjIGDNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 23:13:55 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B533010F1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 20:13:50 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c337aeefbdso4670545ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 20:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694056429; x=1694661229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wzzn5c+wGaxzdVDiJkZ08cQ4VCYCBemnCgzCxcgnFeE=;
        b=GuMLRWqg2uUZTeD6fu8NT6XQ2mTHdIzhFE84bVtoDwX4TYW7TXxpAztfFmqF0b0042
         iEulYCRE3JzDQLR9RGiKpuGKbr/HGUE5KzUGlyl7w0uRoZ9dI8qW1d8GHhF3wL2DjoK4
         BQmmAv14PZyaJJSxkUWHISa/ai6WWAxr8XPpPYFEKPCDcoIhYnl1JIX04Ye2JKkJFjQu
         V+qjP5NC7Q565ds2elMpkR4V935E4SIGUdQTm3DmbZeKhJtoKQTVHzm5KShwWbM3GMHu
         iDXRdSflykR+VcLRDKE3IY7kxLqZa/TWmI1abIQFuKs1F3RDbahVgkIX9NH6CtEpf7oT
         bnnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694056429; x=1694661229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wzzn5c+wGaxzdVDiJkZ08cQ4VCYCBemnCgzCxcgnFeE=;
        b=dKniByU4WgMx+xsJRjDF8GZdmmhZLf4IxktK15IEaS9KL+yyNxp3d62z1nH6fZx7ii
         tQjCsxfYEs8wve1y1Jj6vHQJQG6nrN/i7W85Y/bHNtF3qeTo1BCVdvrmDP0+h45C7fFi
         RO91bzLlYxgDhzajarnUO4AI+/c8BQBhWmRNpFQ/TftnVzK9SHHuR4h4KKNV4kFrmN7E
         iMlZRoqO4qfhUKEhuUc5WmDcAAbPr5aeMFuw+Xgdd3gmPukL7AJWDrFso7tDwu7OY0m0
         fB8+8eDKYINCdy1Zz1TCVS+t9iYLaLl4bbkNaN5qfefoRIghS+BezFdKWyPE6vj48F3a
         oczw==
X-Gm-Message-State: AOJu0YxFzPP9jYEEXmxOU2R3QN3u6mCzmDXbZwcGK18g0DRvBfgwKqz7
        Z2Y8QTnSKnAaFKk3xl8uMVHrK7GGb7U=
X-Google-Smtp-Source: AGHT+IGVD+gPT+HuhJ1CBjIf14duHTChMhHko7WflLKuHSwIsZgca6pcx6CT5ht87fPtYLmDtaXsXA==
X-Received: by 2002:a17:903:1107:b0:1bf:25a1:9813 with SMTP id n7-20020a170903110700b001bf25a19813mr20496760plh.6.1694056429564;
        Wed, 06 Sep 2023 20:13:49 -0700 (PDT)
Received: from wenkaidev ([123.51.235.123])
        by smtp.gmail.com with ESMTPSA id jk6-20020a170903330600b001bbb8d5166bsm11764505plb.123.2023.09.06.20.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 20:13:49 -0700 (PDT)
From:   advantech.susiteam@gmail.com
To:     advantech.susiteam@gmail.com
Cc:     wenkai.chung@advantech.com.tw, Susi.Driver@advantech.com,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] mfd: eiois200: Add core driver for EIO-IS200
Date:   Thu,  7 Sep 2023 11:13:14 +0800
Message-Id: <20230907031320.6814-1-advantech.susiteam@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EIO-IS200 Series is an embedded controller (EC) used in various
Advantech hardware products, including embedded systems and industrial
computers. This patch series introduces core support for the Advantech
EIO-IS200 Embedded Controller (EC). The EIO-IS200 is an EC designed
for LPC (Low Pin Count) bus communication, equipped with its own PMC
(Power Management Channel) for communication with its firmware.

The EIO-IS200 EC provides a range of functionalities, including GPIO
management, watchdog timer control, hardware monitoring, I2C
communication, and thermal management. This core driver establishes
the essential infrastructure for interacting with the EIO-IS200 EC
firmware, enabling subsequent child drivers to access and utilize
these features.

This driver is essential for Linux support on hardware equipped with
the EIO-IS200 Series IC. It enables users to access and control both
firmware and hardware features, improving system stability and
functionality.

The patches have been tested on Advantech hardware platforms, and all
functionality is verified to work as expected.

---

[PATCH 1/4] mfd: eiois200: Insert EIO-IS200 core driver to Kconfig
[PATCH 2/4] mfd: eiois200: Insert EIO-IS200 core driver to Makefile
[PATCH 3/4] mfd: eiois200: Add Header for EIO-IS200 Core Driver
[PATCH 4/4] mfd: eiois200: Add EIO-IS200 Series EC Core Driver



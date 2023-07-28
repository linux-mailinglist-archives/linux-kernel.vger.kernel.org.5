Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766D576769E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjG1TvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbjG1TvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:51:19 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165FD4211;
        Fri, 28 Jul 2023 12:51:04 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-78bb3ff7cbcso100357039f.3;
        Fri, 28 Jul 2023 12:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690573863; x=1691178663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=rymMyaz/tEO/RhFy4g7EUhn/jNcpUU3jphmtUAtVjE4=;
        b=RbYlRDF5khh10VirmROUFh6AP6hjXWj5rZzPSnUTcO0kU6kTaxdur8CHVBE0kqqoY6
         uPl7FPy58SvgOkegiqZUWWg593mI+8saKQHaS0K0L1m1JiyVWFkHfZMYx077ISuDlb6X
         ftf3MxIt25hBoy0XNO0LvTF8K9Kinz9K1HznqDy2GmYJhUMVUPXEm4D6zTZ9168gPShk
         La9HgwHWRUxeedyoRixD6sYcOlALTId72NVJbG7ksTceMkJ8+EY53ioRqyB/wmjCu/oM
         wfKnG6C0+7ZFlDrB3EpR0gXu957Ps3IXw68gXkl2DvaAavUv/0Iw8Hn3IEWiiMC6IANj
         t2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690573863; x=1691178663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rymMyaz/tEO/RhFy4g7EUhn/jNcpUU3jphmtUAtVjE4=;
        b=VSUJDgCyrGhzhLbgPVU2bN80BppvRxXpluQvAS7IHUG00tzrRBD5eYmKqNRb0ncfME
         RRxNxTfXeKLZCK+alRijxc5vfW5gv89BDoxp6VYTwS5C437AFiVdRlMFFOtsU5Ro0hXC
         qTdLit8b0Jko7mWuyYyENXiR0Xrr2/MvqlLt1fdECj0xCSAVkoiv1ffgJ/YuaIoIljuZ
         t8bTd24RDATAQSP8q+0zPxz6Fmo2uO7uRuG8aqi/G9zJIHvTAEk9X1QelEh3qBvKAKiC
         ry8TxVFKMNoSyZoKTBuqTqaNdfGStZWaYLEJdXD3oz5PYZLQYi2rWxLc2PHKmlj90nmj
         cVMg==
X-Gm-Message-State: ABy/qLZggMBb/oUpGGSxZdlbjo9AV1/UmlSDVBCm5WbrzumLGeHXqqvt
        /LyaplbMeq8kTFy249LD5m/fSs+lEWs=
X-Google-Smtp-Source: APBJJlHh+hXljmLHO87vi/M246LAByo1q4c6NHRxAWTacFCb9Au7k21tkrmOcYK7NsHtLeDlglOe0w==
X-Received: by 2002:a05:6e02:174e:b0:347:5ce2:b996 with SMTP id y14-20020a056e02174e00b003475ce2b996mr699169ill.20.1690573863294;
        Fri, 28 Jul 2023 12:51:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b14-20020a92ce0e000000b003488d15c5adsm1385625ilo.22.2023.07.28.12.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 12:51:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v6.5-rc4
Date:   Fri, 28 Jul 2023 12:51:01 -0700
Message-Id: <20230728195101.3112946-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon fixes for Linux v6.5-rc4 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.5-rc4

Thanks,
Guenter
------

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.5-rc4

for you to fetch changes up to e146503ac68418859fb063a3a0cd9ec93bc52238:

  hwmon: (k10temp) Enable AMD3255 Proc to show negative temperature (2023-07-27 09:41:07 -0700)

----------------------------------------------------------------
hwmon fixes for v6.5-rc4

- k10temp: Display negative temperatures for industrial processors

- pmbus core: Fix deadlock, NULL pointer dereference, and chip enable detection

- nct7802: Do not display PECI1 temperature if disabled

- nct6775: Fix IN scaling factors and feature detection for NCT6798/6799

- oxp-sensors: Fix race condition during device attribute creation

- aquacomputer_d5next: Fix incorrect PWM value readout

----------------------------------------------------------------
Ahmad Khalifa (2):
      hwmon: (nct6775) Fix register for nct6799
      hwmon: (nct6775) Fix IN scaling factors for 6798/6799

Aleksa Savic (1):
      hwmon: (aquacomputer_d5next) Fix incorrect PWM value readout

Baskaran Kannan (1):
      hwmon: (k10temp) Enable AMD3255 Proc to show negative temperature

Gilles Buloz (1):
      hwmon: (nct7802) Fix for temp6 (PECI1) processed even if PECI1 disabled

Guenter Roeck (1):
      hwmon: (pmbus_core) Fix Deadlock in pmbus_regulator_get_status

Joaquín Ignacio Aramendía (1):
      hwmon: (oxp-sensors) Move tt_toggle attribute to dev_groups

Patrick Rudolph (2):
      hwmon: (pmbus_core) Fix pmbus_is_enabled()
      hwmon: (pmbus_core) Fix NULL pointer dereference

 drivers/hwmon/aquacomputer_d5next.c |  2 +-
 drivers/hwmon/k10temp.c             | 17 +++++++++++++++--
 drivers/hwmon/nct6775-core.c        | 28 +++++++++++++++++++++------
 drivers/hwmon/nct6775-platform.c    |  2 +-
 drivers/hwmon/nct6775.h             |  1 +
 drivers/hwmon/nct7802.c             |  2 +-
 drivers/hwmon/oxp-sensors.c         | 38 +++++++++++++++++++++++--------------
 drivers/hwmon/pmbus/pmbus_core.c    | 20 ++++++++++---------
 8 files changed, 76 insertions(+), 34 deletions(-)

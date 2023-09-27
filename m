Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2E97AFDE6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjI0IMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjI0IL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:11:27 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D2C10C0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:11:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPdB-0007vG-BZ; Wed, 27 Sep 2023 10:10:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPd8-009I6o-6t; Wed, 27 Sep 2023 10:10:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qlPd7-005BQ3-RS; Wed, 27 Sep 2023 10:10:45 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Zhengkang Huang <zkhuang@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Xing Tong Wu <xingtong.wu@siemens.com>,
        Tobias Schaffner <tobias.schaffner@siemens.com>
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 00/27] platform: Convert to platform remove callback returning void
Date:   Wed, 27 Sep 2023 10:10:13 +0200
Message-Id: <20230927081040.2198742-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5634; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=CkQYBvT+RjYSeuBxLifLnQnCV7loC85YyRlSkgTCnoo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlE+Nc3ySxbkAMbVir3avLWIvv+j8dE/y7LWJhR q1HA1yTUjGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRPjXAAKCRCPgPtYfRL+ Tr9SCACAy5RNt5WC7iGAFgRqNKrSMNzc/TR6DesoaU1qa/jKzgVteCTh9l0RUVxtF+JPAijQ+qt nbRYV/s2aVt7Eb2Mmp9nrwAG5xIez5JPiNSU9ud2G7w4LSiyC/8Z9iBFMmIWAd4DDF7dMxux4mK xR2ZthSLehKdDqQM+8POgCjhtNshR/2wvuDjyfXOb8aWU6JmFhjqw434KsrKcnOiQIZ2+hUhA7g I+PFaZit3oXXflxc2vSXPtkjSuWUhrToUi2r2vqIRsxisYGqBI5NUUev1TBIBVxRWAsf//kFhI6 tz187eQfss+315FtoaibLT+oER3Jp+pYuu9gfjpyydc/n0yQ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series converts all platform drivers below drivers/platform to use
.remove_new(). The motivation is to get rid of an integer return code
that is (mostly) ignored by the platform driver core and error prone on
the driver side.

See commit 5c5a7680e67b ("platform: Provide a remove callback that
returns no value") for an extended explanation and the eventual goal.

As there is no single maintainer team for drivers/platform, I suggest
the individual maintainers to pick up "their" patches. The only
inter-dependency in this series is that the patches #24 - #27 depend on
#23. Otherwise there are no inter-dependencies, so that should work
fine. As there are still quite a few drivers to convert in other areas
than drivers/platform, I'm happy about every patch that makes it in and
there is no need for further coordination. So even if there is a merge
conflict with one patch until you apply or a subject prefix is
suboptimal, please don't let you stop by negative feedback for other
patches (unless it applies to "your" patches, too, of course).

Best regards and thanks for considering,
Uwe

Uwe Kleine-König (27):
  platform/chrome: cros_ec_chardev: Convert to platform remove callback
    returning void
  platform/chrome: cros_ec_debugfs: Convert to platform remove callback
    returning void
  platform/chrome: cros_ec_lightbar: Convert to platform remove callback
    returning void
  platform/chrome: cros_ec_lpc: Convert to platform remove callback
    returning void
  platform/chrome: cros_ec_sysfs: Convert to platform remove callback
    returning void
  platform/chrome: cros_ec_vbc: Convert to platform remove callback
    returning void
  platform/chrome: cros_typec_switch: Convert to platform remove
    callback returning void
  platform/chrome: cros_usbpd_logger: Convert to platform remove
    callback returning void
  platform/chrome: cros_usbpd_notify: Convert to platform remove
    callback returning void
  platform/chrome/wilco_ec: core: Convert to platform remove callback
    returning void
  platform/chrome/wilco_ec: debugfs: Convert to platform remove callback
    returning void
  platform/chrome/wilco_ec: telemetry: Convert to platform remove
    callback returning void
  platform/goldfish: goldfish_pipe: Convert to platform remove callback
    returning void
  platform/mellanox: mlxbf-bootctl: Convert to platform remove callback
    returning void
  platform/mellanox: mlxbf-tmfifo: Convert to platform remove callback
    returning void
  platform/mellanox: mlxreg-hotplug: Convert to platform remove callback
    returning void
  platform/mellanox: mlxreg-io: Convert to platform remove callback
    returning void
  platform/mellanox: mlxreg-lc: Convert to platform remove callback
    returning void
  platform/mellanox: nvsw-sn2201: Convert to platform remove callback
    returning void
  platform/x86/intel: bytcrc_pwrsrc: Convert to platform remove callback
    returning void
  platform/x86: mlx-platform: Convert to platform remove callback
    returning void
  platform/x86: sel3350-platform: Convert to platform remove callback
    returning void
  platform/x86/siemens: simatic-ipc-batt: Simplify
    simatic_ipc_batt_remove()
  platform/x86/siemens: simatic-ipc-batt: Convert to platform remove
    callback returning void
  platform/x86/siemens: simatic-ipc-batt-apollolake: Convert to platform
    remove callback returning void
  platform/x86/siemens: simatic-ipc-batt-elkhartlake: Convert to
    platform remove callback returning void
  platform/x86/siemens: simatic-ipc-batt-f7188x: Convert to platform
    remove callback returning void

 drivers/platform/chrome/cros_ec_chardev.c            |  6 ++----
 drivers/platform/chrome/cros_ec_debugfs.c            |  6 ++----
 drivers/platform/chrome/cros_ec_lightbar.c           |  6 ++----
 drivers/platform/chrome/cros_ec_lpc.c                |  6 ++----
 drivers/platform/chrome/cros_ec_sysfs.c              |  6 ++----
 drivers/platform/chrome/cros_ec_vbc.c                |  6 ++----
 drivers/platform/chrome/cros_typec_switch.c          |  5 ++---
 drivers/platform/chrome/cros_usbpd_logger.c          |  6 ++----
 drivers/platform/chrome/cros_usbpd_notify.c          | 12 ++++--------
 drivers/platform/chrome/wilco_ec/core.c              |  5 ++---
 drivers/platform/chrome/wilco_ec/debugfs.c           |  6 ++----
 drivers/platform/chrome/wilco_ec/telemetry.c         |  6 ++----
 drivers/platform/goldfish/goldfish_pipe.c            |  5 ++---
 drivers/platform/mellanox/mlxbf-bootctl.c            |  6 ++----
 drivers/platform/mellanox/mlxbf-tmfifo.c             |  6 ++----
 drivers/platform/mellanox/mlxreg-hotplug.c           |  6 ++----
 drivers/platform/mellanox/mlxreg-io.c                |  6 ++----
 drivers/platform/mellanox/mlxreg-lc.c                |  8 +++-----
 drivers/platform/mellanox/nvsw-sn2201.c              |  6 ++----
 drivers/platform/x86/intel/bytcrc_pwrsrc.c           |  5 ++---
 drivers/platform/x86/mlx-platform.c                  |  5 ++---
 drivers/platform/x86/sel3350-platform.c              |  6 ++----
 .../x86/siemens/simatic-ipc-batt-apollolake.c        |  6 +++---
 .../x86/siemens/simatic-ipc-batt-elkhartlake.c       |  6 +++---
 .../platform/x86/siemens/simatic-ipc-batt-f7188x.c   |  6 +++---
 drivers/platform/x86/siemens/simatic-ipc-batt.c      |  9 ++++-----
 drivers/platform/x86/siemens/simatic-ipc-batt.h      |  4 ++--
 27 files changed, 62 insertions(+), 104 deletions(-)

base-commit: 18030226a48de1fbfabf4ae16aaa2695a484254f
-- 
2.40.1


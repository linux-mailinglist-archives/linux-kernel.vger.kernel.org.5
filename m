Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04857DB3D2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjJ3HFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJ3HE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:04:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927B0B6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:04:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14446C433C7;
        Mon, 30 Oct 2023 07:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698649496;
        bh=TF+SLoURtOuEiBScTKlNLOOVWyED1T/jjnE8GQmfRt8=;
        h=Date:From:To:Cc:Subject:From;
        b=osq+AvqBit+/Jk6GkA/MMeX1S+ZULi0fszSM/7k4fDeJ0RoTzGa2PUJq2KKSd9HMF
         Rrogs8ATWJgCUEVjVNkmEQPRhhASsRPTl0mRTkhJ6OlyAwIr9w9PC6zqdYEJt5TzZY
         ElhdPr/9L08wpYRhblzAFWkCSsyCs7Bq5DK/tsNxz1Mdtp5TBWjabszW/O3erxPdub
         iLBmqDWoKsjVjdNaK67oVnz79IJX/mKgNix956Fkp0mM1uHcuMH+qqagkUJk8mTw5v
         SymqVlwkEoVsAeQJdMGZ9J8kqaLmbs8F3AlqaJaAjHdWH9HoCI+ZHDse4NNRpHI3OJ
         Yi1hfadW8Ccaw==
Date:   Mon, 30 Oct 2023 15:04:52 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     pmalani@chromium.org, bleung@chromium.org, groeck@chromium.org,
        tzungbi@kernel.org, linux-kernel@vger.kernel.org,
        chrome-platform@lists.linux.dev
Subject: [GIT PULL] chrome-platform changes for v6.7
Message-ID: <ZT9VlLol-dGK5JtE@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Drij9VBv3K0eFLzJ"
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Drij9VBv3K0eFLzJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull chrome-platform updates for v6.7.

Thanks,
TzungBi

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git=
 tags/tag-chrome-platform-for-v6.7

for you to fetch changes up to 47ea0ddb1f5604ba3496baa19110aec6a3151f2e:

  platform/chrome: cros_ec_lpc: Separate host command and irq disable (2023=
-10-28 11:13:25 +0800)

----------------------------------------------------------------
chrome platform changes for 6.7

* Improvements

  - Annotate flexible array members with __counted_by.
  - Convert platform drivers' .remove callbacks to return void.

* Fixes

  - Avoid MKBP event timeouts by disabling/enabling IRQ later/earlier.

* Misc

  - Minor cleanups and fixes.

----------------------------------------------------------------
Kees Cook (1):
      platform/chrome: wilco_ec: Annotate struct ec_event_queue with __coun=
ted_by

Lalith Rajendran (1):
      platform/chrome: cros_ec_lpc: Separate host command and irq disable

Stephen Boyd (4):
      platform/chrome: cros_ec_typec: Use semi-colons instead of commas
      platform/chrome: cros_ec_typec: Use dev_err_probe() more
      platform/chrome: cros_typec_vdm: Mark port_amode_ops const
      platform/chrome: cros_ec_proto: Mark outdata as const

Tzung-Bi Shih (3):
      platform/chrome: cros_ec: fix compilation warning
      platform/chrome: kunit: initialize lock for fake ec_dev
      platform/chrome: kunit: make EC protocol tests independent

Uwe Kleine-K=F6nig (12):
      platform/chrome: cros_ec_chardev: Convert to platform remove callback=
 returning void
      platform/chrome: cros_ec_debugfs: Convert to platform remove callback=
 returning void
      platform/chrome: cros_ec_lightbar: Convert to platform remove callbac=
k returning void
      platform/chrome: cros_ec_lpc: Convert to platform remove callback ret=
urning void
      platform/chrome: cros_ec_sysfs: Convert to platform remove callback r=
eturning void
      platform/chrome: cros_ec_vbc: Convert to platform remove callback ret=
urning void
      platform/chrome: cros_typec_switch: Convert to platform remove callba=
ck returning void
      platform/chrome: cros_usbpd_logger: Convert to platform remove callba=
ck returning void
      platform/chrome: cros_usbpd_notify: Convert to platform remove callba=
ck returning void
      platform/chrome/wilco_ec: core: Convert to platform remove callback r=
eturning void
      platform/chrome/wilco_ec: debugfs: Convert to platform remove callbac=
k returning void
      platform/chrome/wilco_ec: telemetry: Convert to platform remove callb=
ack returning void

 drivers/platform/chrome/Kconfig                    |   6 +-
 drivers/platform/chrome/Makefile                   |   5 +-
 drivers/platform/chrome/cros_ec.c                  | 116 +++++++++++++++++=
----
 drivers/platform/chrome/cros_ec.h                  |   6 ++
 drivers/platform/chrome/cros_ec_chardev.c          |   6 +-
 drivers/platform/chrome/cros_ec_debugfs.c          |   6 +-
 drivers/platform/chrome/cros_ec_lightbar.c         |   6 +-
 drivers/platform/chrome/cros_ec_lpc.c              |  28 +++--
 drivers/platform/chrome/cros_ec_proto.c            |   2 +-
 drivers/platform/chrome/cros_ec_proto_test.c       |   3 +-
 ...cros_kunit_util.c =3D> cros_ec_proto_test_util.c} |   4 +-
 ...cros_kunit_util.h =3D> cros_ec_proto_test_util.h} |   0
 drivers/platform/chrome/cros_ec_sysfs.c            |   6 +-
 drivers/platform/chrome/cros_ec_typec.c            |  18 ++--
 drivers/platform/chrome/cros_ec_vbc.c              |   6 +-
 drivers/platform/chrome/cros_typec_switch.c        |   5 +-
 drivers/platform/chrome/cros_typec_vdm.c           |   2 +-
 drivers/platform/chrome/cros_typec_vdm.h           |   2 +-
 drivers/platform/chrome/cros_usbpd_logger.c        |   6 +-
 drivers/platform/chrome/cros_usbpd_notify.c        |  12 +--
 drivers/platform/chrome/wilco_ec/core.c            |   5 +-
 drivers/platform/chrome/wilco_ec/debugfs.c         |   6 +-
 drivers/platform/chrome/wilco_ec/event.c           |   2 +-
 drivers/platform/chrome/wilco_ec/telemetry.c       |   6 +-
 include/linux/platform_data/cros_ec_proto.h        |   2 +-
 25 files changed, 166 insertions(+), 100 deletions(-)
 rename drivers/platform/chrome/{cros_kunit_util.c =3D> cros_ec_proto_test_=
util.c} (98%)
 rename drivers/platform/chrome/{cros_kunit_util.h =3D> cros_ec_proto_test_=
util.h} (100%)

--Drij9VBv3K0eFLzJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQS0yQeDP3cjLyifNRUrxTEGBto89AUCZT9VlAAKCRArxTEGBto8
9L+HAQCPTJUsJFJCwWzRmviIvzEBcBERLBrbJkktABjbWBZx8wEApJMBc2BzaZ+w
16W+MsLS6+xCYhuoUb428bT1bLDxCQs=
=N365
-----END PGP SIGNATURE-----

--Drij9VBv3K0eFLzJ--

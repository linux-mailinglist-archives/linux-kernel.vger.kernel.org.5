Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275487F452A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343921AbjKVLy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343577AbjKVLy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:54:26 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAA1197;
        Wed, 22 Nov 2023 03:54:21 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc29f39e7aso43823055ad.0;
        Wed, 22 Nov 2023 03:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700654060; x=1701258860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a10ZROSDEtxlQw4IsFc3/+nXW+oIGFnGrpcDSypg+zg=;
        b=V1fbCIhuJChqwBFoCW0IKmwrt2wZwqYoIktZoUGEiJLowDU0jg8Wt0IsL6Dqbcyl6D
         rw0+qIP/W5LZcH8BKi4YTcY6d5nkJ5VlxQfAgb42xIOz5J1uXNmWpftt+JHPq2V3MRD+
         o5qO029FQR7nkfqYTvTrpvTyhOgpX8PUKeb/bphBTC6TJzeG9JXgalmT+/Iv4BUoMb6k
         y1lKUMFrwilbR2MLfYw3EtCTXJAK0syTyDjukqobTLsAXhIiTtkJ2VQQKIDbS6nMcZR6
         RBPOvMTf5qYr2vdyL7jevcw7il8im769XU7MUw7upaZw/3Gz5mImphz7YOmJw3lgaXxm
         qLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700654060; x=1701258860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a10ZROSDEtxlQw4IsFc3/+nXW+oIGFnGrpcDSypg+zg=;
        b=vYvfAcQgG1+qOFT1omjXOAj77YJrfzPBQs9cbeGjMauoLgMJouyOruKTeNa9WwtUsW
         bG+zylnBbPYTUEUe8gHYiPGc9MKdfQn6PWzK2sQdSEfGNs0Nl4FILZWDpMpwt0vBEryM
         W7hVAfCHtEqsoSu47HWIW56kI8Acli9Jbj3U4YuwHOwKnVzFogILZg8ZQ8CWFsjelFli
         Yd6e1uMG5yh+HaCePU9ddaBJ9lnkTo/0ZndVJr8xCH6A7nF3H/d3l4Z8XOd+UePv3lWS
         k4v0FCoIYjAXoIS/LfU+P81lyAplQ5CcGTryMEecCro8PbCoovOWUhyc5V+81+FrYbH9
         Z7rw==
X-Gm-Message-State: AOJu0YyRndbtwdDJLHHsIp2yZXI4Oa8bBGeSZ2/AAZyxGmUj9Brh1lB+
        SztOx9veNlZJmR2kLfOfPsY=
X-Google-Smtp-Source: AGHT+IHQTEOlnCbV1EcJiVZ0O5AAsEW9+Sp/+HQQvg/JTLNzw4rro7n0IgEn1EZN7rSKayavEyCmdQ==
X-Received: by 2002:a17:902:d384:b0:1cc:4559:ea with SMTP id e4-20020a170902d38400b001cc455900eamr1914526pld.3.1700654060292;
        Wed, 22 Nov 2023 03:54:20 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id w13-20020a1709027b8d00b001c61e628e9dsm9590660pll.77.2023.11.22.03.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 03:54:19 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id D4E8610207134; Wed, 22 Nov 2023 18:54:16 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Subsystem <linux-media@vger.kernel.org>
Cc:     Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Wei Chen <harperchen1110@gmail.com>,
        Zhang Shurong <zhang_shurong@foxmail.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Baisong Zhong <zhongbaisong@huawei.com>,
        Ruan Jinjie <ruanjinjie@huawei.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniil Dulov <d.dulov@aladdin.ru>, Su Hui <suhui@nfschina.com>,
        Hyunwoo Kim <v4bel@theori.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        YongSu Yoo <yongsuyoo0215@gmail.com>,
        Lin Ma <linma@zju.edu.cn>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Ma Ke <make_ruc2021@163.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [RFC PATCH] MAINTAINERS: Drop Antti Palosaari
Date:   Wed, 22 Nov 2023 18:53:58 +0700
Message-ID: <20231122115358.36142-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16498; i=bagasdotme@gmail.com; h=from:subject; bh=N6LVDY25auLZ+EuTNEVsfjMsw5FezIL2HrwkDIKNQh0=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKmxr8X+CheW35g1udxmlpqY67+D6k5JskIP7NWi7/no7 zn1+9z7jlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEwk9THDX9nbsorHFDSTevot U3z/7ipwkezWT1mq9f6mFgOH2KoJxowMO6RXCW1S+Cw7ef6mOMNgceG/O3nzoyMr1IuDg3x71k3 iAQA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
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

He is currently inactive (last message from him is two years ago [1]).
His media tree [2] is also dormant (latest activity is 6 years ago),
yet his site is still online [3].

Drop him from MAINTAINERS and add CREDITS entry for him. We thank him
for maintaining various DVB drivers.

[1]: https://lore.kernel.org/all/660772b3-0597-02db-ed94-c6a9be04e8e8@iki.fi/
[2]: https://git.linuxtv.org/anttip/media_tree.git/
[3]: https://palosaari.fi/linux/

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Antti, if you still have time to maintain your drivers, please let us know.
Also, I have Cc'ed people that touched the same subdirectories as Antti's
drivers from get_maintainer.pl script. Please let us know if you'd like
to maintain one or some of them (or all).

 CREDITS     |   8 +++
 MAINTAINERS | 179 +++++++++++-----------------------------------------
 2 files changed, 45 insertions(+), 142 deletions(-)

diff --git a/CREDITS b/CREDITS
index f33a33fd237170..81845c39e3cf37 100644
--- a/CREDITS
+++ b/CREDITS
@@ -2944,6 +2944,14 @@ D: IPX development and support
 N: Venkatesh Pallipadi (Venki)
 D: x86/HPET
 
+N: Antti Palosaari
+E: crope@iki.fi
+D: Various DVB drivers
+W: https://palosaari.fi/linux/
+S: Yliopistokatu 1 D 513
+S: FI-90570 Oulu
+S: FINLAND
+
 N: Kyungmin Park
 E: kyungmin.park@samsung.com
 D: Samsung S5Pv210 and Exynos4210 mobile platforms
diff --git a/MAINTAINERS b/MAINTAINERS
index c5029341b1d698..13a9a4b2e0fa3b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -171,13 +171,10 @@ S:	Supported
 F:	drivers/soc/fujitsu/a64fx-diag.c
 
 A8293 MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/dvb-frontends/a8293*
 
 AACRAID SCSI RAID DRIVER
@@ -576,23 +573,17 @@ F:	drivers/iio/accel/adxl372_i2c.c
 F:	drivers/iio/accel/adxl372_spi.c
 
 AF9013 MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/dvb-frontends/af9013*
 
 AF9033 MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/dvb-frontends/af9033*
 
 AFFS FILE SYSTEM
@@ -650,13 +641,10 @@ F:	fs/aio.c
 F:	include/linux/*aio*.h
 
 AIRSPY MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/usb/airspy/
 
 ALACRITECH GIGABIT ETHERNET DRIVER
@@ -5605,13 +5593,10 @@ F:	Documentation/driver-api/media/drivers/cx88*
 F:	drivers/media/pci/cx88/
 
 CXD2820R MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/dvb-frontends/cxd2820r*
 
 CXGB3 ETHERNET DRIVER (CXGB3)
@@ -5724,13 +5709,10 @@ F:	Documentation/devicetree/bindings/input/cypress-sf.yaml
 F:	drivers/input/keyboard/cypress-sf.c
 
 CYPRESS_FIRMWARE MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/common/cypress_firmware*
 
 CYTTSP TOUCHSCREEN DRIVER
@@ -7320,53 +7302,38 @@ T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/pci/dt3155/
 
 DVB_USB_AF9015 MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/usb/dvb-usb-v2/af9015*
 
 DVB_USB_AF9035 MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/usb/dvb-usb-v2/af9035*
 
 DVB_USB_ANYSEE MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/usb/dvb-usb-v2/anysee*
 
 DVB_USB_AU6610 MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/usb/dvb-usb-v2/au6610*
 
 DVB_USB_CE6230 MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/usb/dvb-usb-v2/ce6230*
 
 DVB_USB_CXUSB MEDIA DRIVER
@@ -7380,22 +7347,17 @@ T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/usb/dvb-usb/cxusb*
 
 DVB_USB_EC168 MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/usb/dvb-usb-v2/ec168*
 
 DVB_USB_GL861 MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/usb/dvb-usb-v2/gl861*
 
 DVB_USB_MXL111SF MEDIA DRIVER
@@ -7409,23 +7371,18 @@ T:	git git://linuxtv.org/mkrufky/mxl111sf.git
 F:	drivers/media/usb/dvb-usb-v2/mxl111sf*
 
 DVB_USB_RTL28XXU MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/usb/dvb-usb-v2/rtl28xxu*
 
 DVB_USB_V2 MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
 W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/usb/dvb-usb-v2/dvb_usb*
 F:	drivers/media/usb/dvb-usb-v2/usb_urb.c
 
@@ -7467,13 +7424,10 @@ F:	Documentation/devicetree/bindings/input/e3x0-button.txt
 F:	drivers/input/misc/e3x0-button.c
 
 E4000 MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/tuners/e4000*
 
 EARTH_PT1 MEDIA DRIVER
@@ -7489,13 +7443,10 @@ S:	Odd Fixes
 F:	drivers/media/pci/pt3/
 
 EC100 MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/dvb-frontends/ec100*
 
 ECRYPT FILE SYSTEM
@@ -8112,13 +8063,10 @@ F:	drivers/media/tuners/fc0011.c
 F:	drivers/media/tuners/fc0011.h
 
 FC2580 MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/tuners/fc2580*
 
 FCOE SUBSYSTEM (libfc, libfcoe, fcoe)
@@ -9249,13 +9197,10 @@ F:	include/trace/events/habanalabs.h
 F:	include/uapi/drm/habanalabs_accel.h
 
 HACKRF MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/usb/hackrf/
 
 HANDSHAKE UPCALL FOR TRANSPORT LAYER SECURITY
@@ -11329,13 +11274,10 @@ F:	Documentation/hwmon/it87.rst
 F:	drivers/hwmon/it87.c
 
 IT913X MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/tuners/it913x*
 
 ITE IT66121 HDMI BRIDGE DRIVER
@@ -12688,13 +12630,10 @@ W:	http://www.tazenda.demon.co.uk/phil/linux-hp
 F:	arch/m68k/hp300/
 
 M88DS3103 MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/dvb-frontends/m88ds3103*
 
 M88RS2000 MEDIA DRIVER
@@ -14590,20 +14529,16 @@ F:	include/asm-generic/tlb.h
 F:	mm/mmu_gather.c
 
 MN88472 MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 F:	drivers/media/dvb-frontends/mn88472*
 
 MN88473 MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 F:	drivers/media/dvb-frontends/mn88473*
 
@@ -14691,23 +14626,17 @@ S:	Orphan
 F:	drivers/platform/x86/msi-wmi.c
 
 MSI001 MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/tuners/msi001*
 
 MSI2500 MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/usb/msi2500/
 
 MSTAR INTERRUPT CONTROLLER DRIVER
@@ -17775,13 +17704,10 @@ F:	drivers/bus/fsl-mc/
 F:	include/uapi/linux/fsl_mc.h
 
 QT1010 MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/tuners/qt1010*
 
 QUALCOMM ATH12K WIRELESS DRIVER
@@ -18834,33 +18760,24 @@ S:	Maintained
 F:	drivers/tty/rpmsg_tty.c
 
 RTL2830 MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/dvb-frontends/rtl2830*
 
 RTL2832 MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/dvb-frontends/rtl2832*
 
 RTL2832_SDR MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/dvb-frontends/rtl2832_sdr*
 
 RTL8180 WIRELESS DRIVER
@@ -19670,13 +19587,10 @@ F:	drivers/media/platform/renesas/sh_vou.c
 F:	include/media/drv-intf/sh_vou.h
 
 SI2157 MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/tuners/si2157*
 
 SI2165 MEDIA DRIVER
@@ -19688,13 +19602,10 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 F:	drivers/media/dvb-frontends/si2165*
 
 SI2168 MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/dvb-frontends/si2168*
 
 SI470X FM RADIO RECEIVER I2C DRIVER
@@ -21205,33 +21116,24 @@ W:	http://tcp-lp-mod.sourceforge.net/
 F:	net/ipv4/tcp_lp.c
 
 TDA10071 MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/dvb-frontends/tda10071*
 
 TDA18212 MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/tuners/tda18212*
 
 TDA18218 MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/tuners/tda18218*
 
 TDA18250 MEDIA DRIVER
@@ -22155,13 +22057,10 @@ F:	include/uapi/linux/serial_core.h
 F:	include/uapi/linux/tty.h
 
 TUA9001 MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org
-W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
-T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/tuners/tua9001*
 
 TULIP NETWORK DRIVERS
@@ -24102,20 +24001,16 @@ S:	Orphan
 F:	drivers/net/wireless/zydas/zd1211rw/
 
 ZD1301 MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org/
-W:	http://palosaari.fi/linux/
 Q:	https://patchwork.linuxtv.org/project/linux-media/list/
 F:	drivers/media/usb/dvb-usb-v2/zd1301*
 
 ZD1301_DEMOD MEDIA DRIVER
-M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	https://linuxtv.org/
-W:	http://palosaari.fi/linux/
 Q:	https://patchwork.linuxtv.org/project/linux-media/list/
 F:	drivers/media/dvb-frontends/zd1301_demod*
 

base-commit: 3c9202e88ffad78f57a418bace2d25f7824a7e4b
-- 
An old man doll... just what I always wanted! - Clara


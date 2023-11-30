Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDE97FEAF8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344981AbjK3IjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344954AbjK3IjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:39:16 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2917010FF;
        Thu, 30 Nov 2023 00:39:20 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6cbc8199a2aso699235b3a.1;
        Thu, 30 Nov 2023 00:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701333559; x=1701938359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=orwfrJWJ5VfdUAsO3z0ZgYwfVFofvmk7ajaKHM7YZCA=;
        b=M3uu/Y6l6JBoLdH24eH0a3bP8rBQr+XsPYws0JqTHsp9pICqI0KdGIt7/ld5RkbN3/
         aiyfIk5sRmF6qXheHbqF/CDdLcg6QY55VZSSQ3uO4DKNojLvXcbELDdb1Vv9ZIIG6R2f
         4kr0nyKhjSnXpcRMGNeZnGfL85xG+R71tFcFp+9OO68BUqkrKKCp+OLSBtcHfydzrxDQ
         b9bgOxZ0oKD6mhVh6Ykvf+LctnNOY54Oqm7UDydvt4JR0upY9YxdrqujMYgnAmpy8Gd0
         PZJZY7Dv33sebl7FVT92yhoomC9M3KgFL640LL7jbsaWwR71Z40QrCye8WhgyM6d1Ks/
         pUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701333559; x=1701938359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=orwfrJWJ5VfdUAsO3z0ZgYwfVFofvmk7ajaKHM7YZCA=;
        b=sTTLBpfhO8YU20jjap0RdEcq1fgyHU4MhelfFY/2azjb0Pynej4CAoQZF3Uv1pbPh+
         GDh46i0LuHbAsRzYZyVjckoVXFRuKJukWn3y6k4279WK0CXEe3U1iKF3n1IvSmDBbuWx
         DGRlxhlVjVreiNYeENOpVkNqX2CSAaC8Tsfroin+C8vZdMJYrqbvKV89CalrURw1pKVv
         EXw1s2r//YSKAMuMjZ3vJW+XHx5rjKfK69/gjb3qjKGq6F8a8NrYQ6+hUqFLAIcchFaf
         nNKFs53wrAlbKyrfy1jwpqrBWFolE5vtsiqeddOYZjM0xA9/AF5lQUPZ74BM8xoafey+
         6mug==
X-Gm-Message-State: AOJu0Ywnw7gsHtP8MldSBLWDAbwiUoiVBheBIivXXTIcIp0Puk1OxckT
        6eQIXlCk9LmDF4Kt61f2/Jo=
X-Google-Smtp-Source: AGHT+IGnx4GebGczzxqLfvz4W3m7DubHdfc7yYBcNQCY0aAV12HS+QHHf13WmPH2EE+ua3EuQqNAtg==
X-Received: by 2002:a05:6a00:891:b0:6c4:d5ee:c6 with SMTP id q17-20020a056a00089100b006c4d5ee00c6mr25555977pfj.1.1701333559360;
        Thu, 30 Nov 2023 00:39:19 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id du15-20020a056a002b4f00b006cbef269712sm684615pfb.9.2023.11.30.00.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 00:39:18 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 18C5910211B8A; Thu, 30 Nov 2023 15:39:13 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Subsystem <linux-media@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>
Cc:     Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] MAINTAINERS: Drop Antti Palosaari
Date:   Thu, 30 Nov 2023 15:38:48 +0700
Message-ID: <20231130083848.5396-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16480; i=bagasdotme@gmail.com; h=from:subject; bh=vAl7V+Oy4lLHXE3AQsJJGx3hI0Xp8V1ByVt3qAse94k=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKkZHgds9X8v3Ppp8cN0y0erWvkdu+yUOlIPB7+ZuXbem kxbtzK2jlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEyEbQvDX4nu1vyVzhor7qib t3tfclOrizvs8UtjyYJOc77176/9VWT4K/eJR9uc+YLpt6YDU00eVrD9+NEYbGxzRChGKSy9On8 OCwA=
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
Essentially no change from RFC [1]. However, since there is no response on
RFC (including from Antti), let's drop him so that Cc: lists can be
a bit shorter.

This patch is based on media_stage tree (master branch).

[1]: https://lore.kernel.org/linux-media/20231122115358.36142-1-bagasdotme@gmail.com/

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
index 10a981abd6ec98..d0ff3abddd2098 100644
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
@@ -9248,13 +9196,10 @@ F:	include/trace/events/habanalabs.h
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
@@ -11328,13 +11273,10 @@ F:	Documentation/hwmon/it87.rst
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
@@ -12687,13 +12629,10 @@ W:	http://www.tazenda.demon.co.uk/phil/linux-hp
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
@@ -14589,20 +14528,16 @@ F:	include/asm-generic/tlb.h
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
 
@@ -14690,23 +14625,17 @@ S:	Orphan
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
@@ -17774,13 +17703,10 @@ F:	drivers/bus/fsl-mc/
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
@@ -18833,33 +18759,24 @@ S:	Maintained
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
@@ -19669,13 +19586,10 @@ F:	drivers/media/platform/renesas/sh_vou.c
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
@@ -19687,13 +19601,10 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
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
@@ -21204,33 +21115,24 @@ W:	http://tcp-lp-mod.sourceforge.net/
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
@@ -22165,13 +22067,10 @@ F:	include/uapi/linux/serial_core.h
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
@@ -24125,20 +24024,16 @@ S:	Orphan
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
 

base-commit: 3b8551e73271fc375b15c887db54ad31686eb2ea
-- 
An old man doll... just what I always wanted! - Clara


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469687ACC90
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 00:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjIXW0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 18:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjIXW01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 18:26:27 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E857EFE;
        Sun, 24 Sep 2023 15:26:19 -0700 (PDT)
Received: from p200300ccff1ebc001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff1e:bc00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qkXYA-00492B-QT; Mon, 25 Sep 2023 00:26:02 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1qkXY9-008YMu-1H;
        Mon, 25 Sep 2023 00:26:01 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bcousson@baylibre.com, tony@atomide.com,
        jean-baptiste.maneyrol@tdk.com, chenhuiz@axis.com,
        andreas@kemnade.info, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH 0/3] ARM: omap: omap4-embt2ws: Add IMU on control unit
Date:   Mon, 25 Sep 2023 00:25:56 +0200
Message-Id: <20230924222559.2038721-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Contrary to the IMU at the head, a bit needs to be set to
make probe of the magnetometer successful.

Andreas Kemnade (3):
  dt-bindings: iio: imu: mpu6050: Add level shifter
  iio: imu: mpu6050: add level shifter flag
  ARM: dts: omap: omap4-embt2ws: Add IMU at control unit

 .../bindings/iio/imu/invensense,mpu6050.yaml    |  2 ++
 .../boot/dts/ti/omap/omap4-epson-embt2ws.dts    | 17 ++++++++++++++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c       |  5 +++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c      |  3 +++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h       |  1 +
 5 files changed, 27 insertions(+), 1 deletion(-)

-- 
2.39.2


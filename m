Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B46C782F34
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 19:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbjHURMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 13:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236989AbjHURMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:12:30 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7475DEE;
        Mon, 21 Aug 2023 10:12:28 -0700 (PDT)
Received: from p200300ccff3fc7001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff3f:c700:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qY8Rm-002tQP-6v; Mon, 21 Aug 2023 19:12:10 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1qY8Rl-002KPc-2f;
        Mon, 21 Aug 2023 19:12:09 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, rydberg@bitmath.org,
        andreas@kemnade.info, u.kleine-koenig@pengutronix.de,
        Jonathan.Cameron@huawei.com, linus.walleij@linaro.org,
        heiko@sntech.de, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/4] Input: zforce_ts: standard properties
Date:   Mon, 21 Aug 2023 19:11:47 +0200
Message-Id: <20230821171151.555091-1-andreas@kemnade.info>
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

Accept standard touchscreen properties to also enable specification
of touchscreen orientation.

Changes in V2:
- correct mail address in .yaml

Andreas Kemnade (4):
  dt-bindings: touchscreen: convert neonode,zforce to json-schema
  dt-bindings: touchscreen: neonode,zforce: Use standard properties
  Input: zforce_ts: Accept standard touchscreen properties
  ARM: dts: imx6sl-tolino-shine2hd: fix touchscreen rotation

 .../input/touchscreen/neonode,zforce.yaml     | 72 +++++++++++++++++++
 .../bindings/input/touchscreen/zforce_ts.txt  | 34 ---------
 .../dts/nxp/imx/imx6sl-tolino-shine2hd.dts    |  6 +-
 drivers/input/touchscreen/zforce_ts.c         | 36 +++++-----
 4 files changed, 94 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/neonode,zforce.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/zforce_ts.txt

-- 
2.39.2


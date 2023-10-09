Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B207BE0DC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377458AbjJINoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377428AbjJINoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:44:44 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCF0A3;
        Mon,  9 Oct 2023 06:44:41 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4B42CC000B;
        Mon,  9 Oct 2023 13:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696859079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3jhpCvsya+E2eGbigp8XihjymSXHP4xEBq7kko3/DmU=;
        b=DSPt4iLu/HcnjbvtPQ0AC4c9yuKUKXmxAcXyFXorCIuFf/TOdT3pW/iINXnFcpfvDwdYkX
        gKyBn5e0Uwe2WOdSMUDjO/gQ9n1g2p3rAo7WADpPnKNEQZp+pAV3YQ7Wfy/SMCrgN1fUBG
        ntb5ZxB6XHHezFFDO8BK90ZorMjx0F8YOQQWtyARooSOZOnBgxxugSjwcsBDKyBdVdoRAx
        mFgbo4YtPYqQ+gTqTQAMMXKC6ovhHBhw4o1krOpCClqR5b6m9v442fLRla+TQ34zrGIhXX
        u29FH1S7LkgwpROCjGcBbj4qHGwNLo9z53MNGqsPeQWJ4XfwHEoKMWSn1iscbg==
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mark.satterthwaite@touchnetix.com,
        pedro.torruella@touchnetix.com, bartp@baasheep.co.uk,
        hannah.rossiter@touchnetix.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        bsp-development.geo@leica-geosystems.com,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH v2 0/3] Input: Add TouchNetix aXiom touchscreen driver 
Date:   Mon,  9 Oct 2023 15:44:32 +0200
Message-Id: <20231009134435.36311-1-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kamel.bouhara@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new driver for the TouchNetix's aXiom family of
touchscreen controller. This driver only support i2c
and can be later adapted for SPI and USB support.

---
Changes in v2:
 - Add device tree binding documentation
 - Move core functions in axiom_i2c as we only care about i2c support now
 - Use static function when required
 - Use syntax dev_err_probe()
 - Add an hardware based reset

Kamel Bouhara (3):
  dt-bindings: vendor-prefixes: Add TouchNetix AS
  dt-bindings: input: Add bindings for TouchNetix axiom touchscreen
  Input: Add TouchNetix aXiom i2c touchscreen driver

 .../touchscreen/touchnetix,axiom_ax54a.yaml   |  52 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/input/touchscreen/Kconfig             |  13 +
 drivers/input/touchscreen/Makefile            |   1 +
 .../input/touchscreen/touchnetix_axiom_i2c.c  | 751 ++++++++++++++++++
 6 files changed, 825 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/touchnetix,axiom_ax54a.yaml
 create mode 100644 drivers/input/touchscreen/touchnetix_axiom_i2c.c

-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508A67B8578
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243365AbjJDQjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbjJDQjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:39:35 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1610295;
        Wed,  4 Oct 2023 09:39:30 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E5EF240003;
        Wed,  4 Oct 2023 16:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696437569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OwinnMEh9kb+/6pTGYavBujahwO6cl+5NQfporXHEEk=;
        b=N764hc6BUMKfDD4eWHJiija+HENBxryR3BvX7ZUBz98Zwc3vVAt1aYAHIdIzJ5fhttn5bK
        IuwZ0D4FFaA1ZnGU8yzZ/9UisFlIt3BESkbI4p5lMT0k2duxG+qblfRiB834xnDDP5nzsO
        X5WnvWB56jDjrzkYip5G1u3DVGmHirMHBXhr08ekG71yNPO5QszWf5wmSQo+nxYNjhOun8
        k6AR8v20YGLgcX+EeSGF+v5DJ0ynu6CIab6bclDRbDbVrsH97Zw10IJHSHRZ6BqFVJxeM6
        JihqKe2tBJA90bB2+BnVVmc7D7Diuh/bhxpsM/x25LB4yCqDUjjNkVav6uPrlQ==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH 0/2] mxc4005/mxc6655 OF improvements
Date:   Wed, 04 Oct 2023 18:39:26 +0200
Message-Id: <20231004-mxc4005-device-tree-support-v1-0-e7c0faea72e4@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD6VHWUC/x3MQQqDMBBG4avIrDswiZHSXkW6CPG3nUU1TFQE8
 e4Glx883kEFpij0bg4ybFp0nirco6H0i9MXrEM1efGtEwn831MQ6XiocQIvBnBZc55t4SARnXv
 G4PGiesiGUff73n/O8wL8alMWbQAAAA==
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: luca.ceresoli@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This small series fixes the compatible string of MXC4005 in the bindings
and adds support for OF-based autoloading of the mxc4005 driver.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Luca Ceresoli (2):
      dt-bindings: trivial-devices: Fix MEMSIC MXC4005 compatible string
      iio: accel: mxc4005: allow module autoloading via OF compatible

 Documentation/devicetree/bindings/trivial-devices.yaml | 2 +-
 drivers/iio/accel/mxc4005.c                            | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)
---
base-commit: 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa
change-id: 20231004-mxc4005-device-tree-support-40ae517a42e9

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


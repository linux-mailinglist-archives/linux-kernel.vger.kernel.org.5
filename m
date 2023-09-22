Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589757AAC43
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjIVIPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbjIVIP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:15:26 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE6FCC2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=k1; bh=HYnYPuxdZs3MNI
        I4Fa0REwLR5gs9DGxnJZt2OC9uI0w=; b=Z37C/Mbz1yuLH3Sd+/iGfRFYRv5z3t
        Mfcnzg5P/3oDaklV/uyRxb4wBI2B9aXUREffvpMVWc3pd/qgXPhJp5mHuYp+WYdA
        WOADqCmPD329BU4KFxTDdNjAX2prf3v7ZQ3TEgqv45dmRZKKOLN6oO5tovy/l8or
        sOHmOZLrLA8lZOEa/iJrYx32lshekvujBXB7IstaTe5UrRf/qb1D1oESLua2SP3n
        q7Oq5AvLy6LrYgbbjznwWfwVMQZFl+uL6FUxhxX+Fc4qjCJ28q5Ch5qqx3vvjEsc
        i8unfd3eMV5WsWVGRCslcWFttxLI2mvH5eo4Jx/D7uPxf+xhSYWg378A==
Received: (qmail 1310858 invoked from network); 22 Sep 2023 10:04:27 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Sep 2023 10:04:27 +0200
X-UD-Smtp-Session: l3s3148p1@AXiyDu4FVsIujntX
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 0/3] treewide: drop check because i2c_unregister_device() is NULL safe
Date:   Fri, 22 Sep 2023 10:04:17 +0200
Message-Id: <20230922080421.35145-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the few drivers missing that i2c_unregister_device() is NULL safe.
One is left, but this needs discussion and refactoring and will be
sorted out independently.


Wolfram Sang (3):
  usb: typec: drop check because i2c_unregister_device() is NULL safe
  media: i2c: drop check because i2c_unregister_device() is NULL safe
  media: dvb-frontends: drop check because i2c_unregister_device() is
    NULL safe

 drivers/media/dvb-frontends/m88ds3103.c | 3 +--
 drivers/media/i2c/rdacm20.c             | 3 +--
 drivers/usb/typec/anx7411.c             | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

-- 
2.30.2


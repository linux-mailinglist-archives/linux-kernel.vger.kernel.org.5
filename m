Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3457AA0D4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjIUUtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbjIUUsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:48:31 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B6D73ADE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=k1; bh=I7NSZPgvRGTTc2
        riAVIRP/TQHhIimIiHu/O4XMZmGlA=; b=cfZPJFOminR2KHwOu24XI0gELNz3Yt
        HNSc2iB6gs1xSTeUMyeuiZCBJS4aYVff5a02+pLU+A+HbWgf67/kSq9zcGzl4qDR
        VrYp1F4kMOJy0hdjofGk5cLI5Xf4utO37MaeYjncNwcGKL5E49k5dBT3SFg+aJ6a
        hZt1WqZF+tKPIE4IrBtUSj+ORn0YFpXOqEPtx3H0BvdKVWloN5IBIMVIsLE7BrkJ
        9v19Q2FyZ1IJdWQafzem/w6GBSrjIz1oUjZbknW6bTvoGd42fPXvzkcbcbeSbNdP
        RhbmZtM72UBwafBuz3+6KzhQllHxNJvszYovztE9S99cNuX+kGSQrd8w==
Received: (qmail 964352 invoked from network); 21 Sep 2023 15:32:10 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Sep 2023 15:32:10 +0200
X-UD-Smtp-Session: l3s3148p1@xrnXhN4FsEQuciJ+
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] gnss: ubx: updates to support the Renesas KingFisher board
Date:   Thu, 21 Sep 2023 15:31:58 +0200
Message-Id: <20230921133202.5828-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
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

For that, we need "reset-gpio" support (patches 2+3). But first,
simplify regulator handling with a new helper (patch 1).

Changes since v2:
* rebased to 6.6-rc2
* added tags from Conor & Geert (Thanks!)

Wolfram Sang (3):
  gnss: ubx: use new helper to remove open coded regulator handling
  dt-bindings: gnss: u-blox: add "reset-gpios" binding
  gnss: ubx: add support for the reset gpio

 .../bindings/gnss/u-blox,neo-6m.yaml          |  5 +++
 drivers/gnss/ubx.c                            | 35 ++++++++-----------
 2 files changed, 20 insertions(+), 20 deletions(-)

-- 
2.35.1


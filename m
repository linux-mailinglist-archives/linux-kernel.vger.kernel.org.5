Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD737D25ED
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 22:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjJVUxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 16:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJVUxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 16:53:31 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A8BE9
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 13:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=k1; bh=LOuWi5SoYFF9kG
        o5fhGgFu4WQlhNarSy0u1SSM70AD0=; b=jWERYBoB9qTSaKPh70AOIr3UKSUF8W
        6ujFBSmV0BxdTL7X1HPgdRASO6urdT1aAI3SvSgsuPKzW9MYHT6DDPyxxM1q9JtW
        +jB0nvkOS5d/jcepDwkJVCAbExIJcfI6xhiknVIhuAomDbRKgFrWJzda7ap33AH9
        C07AkcyML060leR9Vy28jhWaOlZqXVsI0HAw6+VxfOlSfItDe/G88o4gCh3PLJg6
        fmI6Qji1lJtUUcX+SU6c2bH6lxm/5S9HyZWdgQfhFhg+Kpf478JZZRw3a2c0xNo+
        Bh6MIdmOC2Gx0UlUq6vQ6c3dOea5EsCVKd+2ckO6obRL5hkTUC4kDrxw==
Received: (qmail 1741642 invoked from network); 22 Oct 2023 22:53:24 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Oct 2023 22:53:24 +0200
X-UD-Smtp-Session: l3s3148p1@FZK8S1QInscujnvq
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net-next 0/2] net: ethernet: renesas: infrastructure preparations for upcoming driver
Date:   Sun, 22 Oct 2023 22:53:14 +0200
Message-Id: <20231022205316.3209-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before we upstream a new driver, Niklas and I thought that a few
cleanups for Kconfig/Makefile will help readability and maintainability.
Here they are, looking forward to comments.


Wolfram Sang (2):
  net: ethernet: renesas: group entries in Makefile
  net: ethernet: renesas: drop SoC names in Kconfig

 drivers/net/ethernet/renesas/Kconfig  | 9 +--------
 drivers/net/ethernet/renesas/Makefile | 4 +---
 2 files changed, 2 insertions(+), 11 deletions(-)

-- 
2.35.1


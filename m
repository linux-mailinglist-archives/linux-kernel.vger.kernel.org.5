Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC857A881A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbjITPVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235332AbjITPVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:21:04 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB70A9;
        Wed, 20 Sep 2023 08:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:subject:date:message-id:reply-to;
        bh=mZPLDcMaUIExqCo4DAdpXSfLndLye8GLI4DHLWOnM7c=; b=WAKkO6VscDyUqS0PqSmAgqUxgn
        6OMWzZ5mQMXzHoaUfzzW6QerSuaagmXyc0kdUhK7wmhvhnR61vZPIEGT/CfuLflFFiW154DJetJ2L
        2kqO+56nvgA3bctMQZKxKGDtYrp2tXSxEtBf9k/hUvu/IbtBXVpW2lto/54nEc1sL7rM=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:43190 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qiz0Z-0008Co-9W; Wed, 20 Sep 2023 11:20:55 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hvilleneuve@dimonoff.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, hugo@hugovil.com
Date:   Wed, 20 Sep 2023 11:20:14 -0400
Message-Id: <20230920152015.1376838-4-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230920152015.1376838-1-hugo@hugovil.com>
References: <20230920152015.1376838-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 3/4] dt-bindings: sc16is7xx: add vendor prefix to irda-mode-ports property
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The NXP-specific "irda-mode-ports" property lacks a proper vendor
prefix. Add "nxp," prefix to comply with DT best practises.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 .../devicetree/bindings/serial/nxp,sc16is7xx.txt          | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
index 1a7e4bff0456..d89815c5c562 100644
--- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
+++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
@@ -21,8 +21,8 @@ Optional properties:
   the second cell is used to specify the GPIO polarity:
     0 = active high,
     1 = active low.
-- irda-mode-ports: An array that lists the indices of the port that
-		   should operate in IrDA mode.
+- nxp,irda-mode-ports: An array that lists the indices of the port that
+		       should operate in IrDA mode.
 - nxp,modem-control-line-ports: An array that lists the indices of the port that
 				should have shared GPIO lines configured as
 				modem control lines.
@@ -80,8 +80,8 @@ Optional properties:
   the second cell is used to specify the GPIO polarity:
     0 = active high,
     1 = active low.
-- irda-mode-ports: An array that lists the indices of the port that
-		   should operate in IrDA mode.
+- nxp,irda-mode-ports: An array that lists the indices of the port that
+		       should operate in IrDA mode.
 - nxp,modem-control-line-ports: An array that lists the indices of the port that
 				should have shared GPIO lines configured as
 				modem control lines.
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D385C7FAFA9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 02:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbjK1BiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 20:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234336AbjK1BiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 20:38:04 -0500
Received: from mail.rnplus.nl (mail.rnplus.nl [178.251.25.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA95D45
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 17:38:02 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.rnplus.nl (Postfix) with ESMTP id 6615737943A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:33:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at rnplus.nl
Received: from mail.rnplus.nl ([127.0.0.1])
        by localhost (mail.rnplus.nl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id S1qR0gA8LpEW for <linux-kernel@vger.kernel.org>;
        Tue, 28 Nov 2023 02:33:47 +0100 (CET)
Received: from werkpc.lan (87-101-2-254.dsl.cambrium.nl [87.101.2.254])
        by mail.rnplus.nl (Postfix) with ESMTPSA id 16404379432;
        Tue, 28 Nov 2023 02:33:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=rnplus.nl; s=dkim;
        t=1701135224; bh=81KwltVxZAuMaWLnYPGe+jkgwQiKXhiV7pP19DaDTdw=;
        h=From:To:Cc:Subject:Date;
        b=i3198qmdu53X0lp5Stk2jvnw9k2rIjPPev7I0lZAzFHXk9+mVKhYtr3FKe+HNRAkW
         I/L/bghaqwsLHnpp5gMKNBEb6/jvwprHj0w4GAcb9SNQFuuH1SPCi4umFQdKDJdpGC
         GVDOwWS1/3IrJ/ZS58HmQewCJaeu0oUNIAGjSTyY=
From:   Renze Nicolai <renze@rnplus.nl>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au
Cc:     Renze Nicolai <renze@rnplus.nl>
Subject: [PATCH 0/2] ARM: dts: aspeed: asrock: Add ASRock X570D4U BMC
Date:   Tue, 28 Nov 2023 02:30:15 +0100
Message-ID: <20231128013136.2699317-1-renze@rnplus.nl>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

These patches add a device-tree (and a bindings update) for the
Aspeed BMC on the ASRock X570D4U, so that it can be added as a
supported OpenBMC platform.

Greetings,
Renze Nicolai

Renze Nicolai (2):
  dt-bindings: arm: aspeed: add Asrock X570D4U board
  ARM: dts: aspeed: asrock: Add ASRock X570D4U BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-asrock-x570d4u.dts  | 344 ++++++++++++++++++
 3 files changed, 346 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts

-- 
2.43.0


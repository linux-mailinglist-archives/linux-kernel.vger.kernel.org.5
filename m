Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2427854E7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjHWKIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjHWKHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:07:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCB146BF;
        Wed, 23 Aug 2023 02:03:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCF2965957;
        Wed, 23 Aug 2023 09:03:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED780C433C7;
        Wed, 23 Aug 2023 09:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692781412;
        bh=cBA8LS1Y1PWRmdPmwFWha1Slu8mL5WLDumH/lb3Wq00=;
        h=From:Subject:Date:To:Cc:Reply-To:From;
        b=p7ERIvaGwsPAgIB7Ug9zMNgrNdzS2de6l6WnOo4Uc8hogma7QNcpFDbKvxfQeg9Hg
         Xriz5lqt+MO8nbtsIDOkoXzTuGTO1mecOZCFQ+cZXfW6vwIoCVp4mEv7g0dXqAgNz0
         yNZFR9JXpWYo2TE6y6NLsLV5X0gkAKhQm8FqfGObbu4H6bFtMZ9QMdh0fN5DEltv/s
         olHRGlFG+NMEC1MGOCcmz04ftmcrFUBdUtvG/ZUc4prq/1VBbN6LYM6k+k3kYhMCUK
         KqfDt1sSg4byhG/Zh2VJLmsVXGVlIXoSvU6xmULNZYQWUtCWHgmJ5YQbISG7xbtU3W
         wcctWwvm7+L7w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id C5A0CEE49B2;
        Wed, 23 Aug 2023 09:03:31 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Subject: [PATCH 0/2] device tree support for ST M48T86
Date:   Wed, 23 Aug 2023 12:03:13 +0300
Message-Id: <20230823-m48t86_device_tree-v1-0-240023b435ac@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFHL5WQC/x2N0QqDMBAEf0XuuQEbRWN/pRQ547beg2m5C6Ug/
 nujj8PssBsZVGB0qzZSfMXknQpcLxXFhdMLTubC5Gvf1ME3bm1DDt04l23EmBVw3Hsw+6Hth0A
 lnNjgJuUUlyNd2TL0EB/FU37n2/2x73+1k/ArfQAAAA==
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692781413; l=702;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=cBA8LS1Y1PWRmdPmwFWha1Slu8mL5WLDumH/lb3Wq00=; =?utf-8?q?b=3DLXAbPcv1J0we?=
 =?utf-8?q?kD7/fEVbVWnPffGhP0mOmiNjuWFhlj2AFOPjtkZNN/bX43+mISssLNFXFj0z4Ou7?=
 goLNQ4sQCyGjIKQFMnYzGxq5JuHMbCqGiM5FgElvV56j7TNIPedg
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree support for ST M48T86.

The reason it can't go to trivial-rtc.yaml, is that it has 2 registers
instead of a single one. The registers are 1 byte wide.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
Nikita Shubin (2):
      dt-bindings: rtc: Add ST M48T86
      rtc: m48t86: add DT support for m48t86

 .../devicetree/bindings/rtc/st,m48t86.yaml         | 38 ++++++++++++++++++++++
 drivers/rtc/rtc-m48t86.c                           |  8 +++++
 2 files changed, 46 insertions(+)
---
base-commit: 89bf6209cad66214d3774dac86b6bbf2aec6a30d
change-id: 20230823-m48t86_device_tree-a72eaa294798

Best regards,
-- 
Nikita Shubin <nikita.shubin@maquefel.me>


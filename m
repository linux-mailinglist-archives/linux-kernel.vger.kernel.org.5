Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EDB7AC7C0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 13:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjIXLic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 07:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIXLib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 07:38:31 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E839100;
        Sun, 24 Sep 2023 04:38:23 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-27752a1e184so169440a91.3;
        Sun, 24 Sep 2023 04:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695555502; x=1696160302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JhhTXSXah4I7JqQq7Z8mOSYxnO2RCWDRvV8O3bTDHb4=;
        b=gouDfJoG5TKSbPviPZmi0oXZ+ZDYUBjNRQzBW8aCtZ07LgjFh5G82o3f9jg1uTc6hF
         HTchtxNiaWT7iPxBawTkSbCsg38e06dV943VsTxUOGuj02nbHmx9nEsCxrbPotqFygSS
         dNnpWK9n/S2mmb8Q/4+ck06NuyGDnLmYoXMSDiQGT7jNMV0PUOUCErveQViRCPt12oO+
         /GgjE+9wE2eu2hoilMxxheM6Q4kfvFvLB5tcuKTHVKjWCDQZlHTn7TvXfINNI2vTYez7
         pA41Vx7edUL9S/rM9lk8VfNrcCFMkUxwR0YMOQkZjuhLQQqFOuJ0Z+bOWHK/q7Cz52D0
         v7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695555502; x=1696160302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JhhTXSXah4I7JqQq7Z8mOSYxnO2RCWDRvV8O3bTDHb4=;
        b=sV0fE4ASJbS4lzttAiHaCg9qRnK20oUShtsC7NvhS6Bt3YP7tz1waVlkkQbcxlMqX0
         5tLw55EHXZm+jYXLPEHDGenpsckrrkBkyiUxnnz/XoDJipIcHeuctNpHjxfYmfSRGOKV
         1qW/c8Uu5ePRcKJQQDBUVJykjQGCU4tgfJDPPRf9UUeBRc0n6viv2c92YLagoBv8isSh
         QkX59IGjw1quHPnD8JibzudeSrEYC4NsSKJAgmhJOtyCG/AGmR4TTabDvfxlNnHP1ALN
         9NGJmQzHiTM2kA0nQMrL3j8lVr76toCWVeY6HGIrT9IP13vMJ3nqunJhNs2GhpaPKBzj
         k5Gw==
X-Gm-Message-State: AOJu0YxtLXGFWMKa99r+ufW3pt59FKXTmr1hA2Y25PkRwfEHEbh+Ebxp
        ckeVo5Oz3Sr8V4+QeXRww1Y=
X-Google-Smtp-Source: AGHT+IEmNQ8d7khOcZNLgbWh7MZLvEZkY2z1beZ234hDYMipdxze0OUT12np9WnjPFun/M/AImGT2g==
X-Received: by 2002:a17:90a:5384:b0:262:d6cb:3567 with SMTP id y4-20020a17090a538400b00262d6cb3567mr3760678pjh.26.1695555502440;
        Sun, 24 Sep 2023 04:38:22 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.93])
        by smtp.gmail.com with ESMTPSA id s2-20020a17090a6e4200b002775281b9easm422376pjm.50.2023.09.24.04.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 04:38:22 -0700 (PDT)
From:   Ayush Singh <ayushdevel1325@gmail.com>
To:     greybus-dev@lists.linaro.org
Cc:     Ayush Singh <ayushdevel1325@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        vaishnav@beagleboard.org, jkridner@beagleboard.org, nm@ti.com,
        krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v5 0/3] greybus: Add BeaglePlay Greybus Driver
Date:   Sun, 24 Sep 2023 17:06:56 +0530
Message-ID: <20230924113725.164948-1-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BeagleConnect is both a technology concept and a line of board designs
that implement the technology. Born from Greybus, a mechanism for
dynamically extending a Linux system with embedded peripherals,
BeagleConnect adds two key elements: a 6LoWPAN transport and mikroBUS
manifests. The 6LoWPAN transport provides for arbitrary connections,
including the IEEE802.15.4g long-range wireless transport supported
between BeaglePlay and BeagleConnect Freedom (the first BeagleConnect
board design). The mikroBUS manifests provide for rapid prototyping
and low-node-count production with sensor boards following the
mikroBUS freely-licensable embedded bus standard such that existing
Linux drivers can be loaded upon Greybus discovery of the nodes.

This patch set provides the Linux-side hooks required for the 6LoWPAN
transport for BeagleConnect on BeaglePlay. Also adds required devicetree
additions.

Tested over `next-20230825`.

Link: https://programmershideaway.xyz/tags/gsoc23/ GSoC23 Blog
Link: https://git.beagleboard.org/gsoc/greybus/cc1352-firmware Zephyr App
Link: https://github.com/Ayush1325/linux/tree/gb-beagleplay GitHub Branch
Link: https://lists.linaro.org/archives/list/greybus-dev@lists.linaro.org/thread/GKOFWZ5IJMNXIWVDOM3WRNU2B2S4244G/ Patch v4
Link: https://docs.beagleboard.org/latest/boards/beagleconnect/index.html BeagleConnect
Link: https://docs.beagleboard.org/latest/boards/beagleplay/index.html BeaglePlay
Link: https://github.com/Ayush1325/linux/tree/gb-beagleplay Github Repo

Changes in Patch v5
v4 -> v5:
- Move DT Bindings to net
- Rename compatible to `beagle,play-cc1352`
- Expose CC1352 as MCU
- Remove redundant tracing messages
- Fix memory leaks

v3 -> v4:
- Add DT Bindings
- Reorder commits
- Improve commit messages

v2 -> v3:
- Move gb-beagleplay out of staging

v1 -> v2:
- Combine the driver into a single file
- Remove redundant code
- Fix Checkpatch complaints
- Other suggested changes

Ayush Singh (3):
  dt-bindings: Add beaglecc1352
  greybus: Add BeaglePlay Linux Driver
  dts: ti: k3-am625-beagleplay: Add beaglecc1352

 .../bindings/net/beagle,play-cc1352.yaml      |  25 +
 MAINTAINERS                                   |   7 +
 .../arm64/boot/dts/ti/k3-am625-beagleplay.dts |   4 +
 drivers/greybus/Kconfig                       |  10 +
 drivers/greybus/Makefile                      |   4 +-
 drivers/greybus/gb-beagleplay.c               | 526 ++++++++++++++++++
 6 files changed, 574 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/beagle,play-cc1352.yaml
 create mode 100644 drivers/greybus/gb-beagleplay.c


base-commit: 6269320850097903b30be8f07a5c61d9f7592393
-- 
2.41.0


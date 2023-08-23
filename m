Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083F778549A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbjHWJvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236164AbjHWJtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:49:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95642101;
        Wed, 23 Aug 2023 02:47:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24BA36211F;
        Wed, 23 Aug 2023 09:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57752C433C7;
        Wed, 23 Aug 2023 09:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692784058;
        bh=krhBKvq/7yPmNk8KhXgmxPtGwbeLJ0wWfNZMNkB+FyY=;
        h=From:Subject:Date:To:Cc:Reply-To:From;
        b=fwRzH/lWWLYwwJ5gHFzcTKmH9rKezRrjsBMzYVzmuIPiZcQwZlmoV1rhMHbTYlesG
         /9Cdu1bvxZMSfrHk75Li9LinWInmWVjb6Z38C781OrpjsGMKV+4KbBWdSq781wwHnZ
         /jaO8bpz0afDswFnq1QJ+5RlLXEdXshZUlNTb8Ei5bdFP7LAzLDSPB1tQPvAT+PRew
         1gsg+c3e7q4k4N4eF6qHfsWQpB8t3m3ItByMrU0sQfVoa3U97FDxl6Esw9aewtAHvH
         rat6Twz1y/sG6+gk2F8YZuwOWKWtX1s7TI3Hy0zTGJEvCEVfglGZtkKQdMIF3Ld85P
         a65k3qfZOAsaA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 2C616EE49B0;
        Wed, 23 Aug 2023 09:47:38 +0000 (UTC)
From:   Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Subject: [PATCH 0/2] ata: pata_ep93xx: dt convert preparation fixes
Date:   Wed, 23 Aug 2023 12:47:26 +0300
Message-Id: <20230823-ep93xx_pata_fixes-v1-0-d7e7229be148@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK7V5WQC/x3LUQqDMBCE4avIPjegCU1tr1JE1jjWfWgaslIC4
 t0b+/jP8O2kyAKlR7NTxldUPrFGd2korBxfMDLXJtta1/bWGaS7K2VMvPG4SIGaq4f3tz7Mfum
 ouokVZsocw3rKN+uGfB4p4y/q+hyO4wfSwjdCfAAAAA==
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692784059; l=769;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=krhBKvq/7yPmNk8KhXgmxPtGwbeLJ0wWfNZMNkB+FyY=; =?utf-8?q?b=3DR1E0ShJVgJ6+?=
 =?utf-8?q?6M5JL8czSJJXXgcXGRt7mmcphEarVt02Mxf78/HoG4PiPHg3Aes8zSORUrvu2k/o?=
 jPQZMvG+DgxQIpAoqr7qUCOcuhAfGoary9BGk2rr9lANs5zi8ygA
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

Sending some fixes in prior to "ep93xx device tree conversion" series,
as per Sergey request:

- simple replacement s/-ENXIO/-ENOMEM/ as it suits better.
- second is s/ep93xx_chip_revision()/soc_device_match(), so i can drop 
  ep93xx_chip_revision() entirely in later series.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
Nikita Shubin (2):
      ata: pata_ep93xx: fix error return code in probe
      ata: pata_ep93xx: use soc_device_match for UDMA modes

 drivers/ata/pata_ep93xx.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)
---
base-commit: 89bf6209cad66214d3774dac86b6bbf2aec6a30d
change-id: 20230823-ep93xx_pata_fixes-56e6678cd6f1

Best regards,
-- 
Nikita Shubin <nikita.shubin@maquefel.me>


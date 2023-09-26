Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D222F7AE9BB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 11:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbjIZJ4s convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Sep 2023 05:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbjIZJ4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:56:44 -0400
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA5A126;
        Tue, 26 Sep 2023 02:56:37 -0700 (PDT)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=8647860101=fe@dev.tdt.de>)
        id 1ql4UJ-008Nk3-1J; Tue, 26 Sep 2023 11:36:15 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1ql4UI-008Ngh-2b; Tue, 26 Sep 2023 11:36:14 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 996AB24004B;
        Tue, 26 Sep 2023 11:36:13 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id ED4C4240040;
        Tue, 26 Sep 2023 11:36:12 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 9B33532747;
        Tue, 26 Sep 2023 11:36:12 +0200 (CEST)
From:   Florian Eckert <fe@dev.tdt.de>
To:     Eckert.Florian@googlemail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org,
        kabel@kernel.org, u.kleine-koenig@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: [PATCH 0/2] ledtrig-tty: add new state evaluation
Date:   Tue, 26 Sep 2023 11:36:05 +0200
Message-ID: <20230926093607.59536-1-fe@dev.tdt.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Content-Transfer-Encoding: 8BIT
X-purgate-ID: 151534::1695720974-520A685C-EFD57BF8/0/0
X-purgate: clean
X-purgate-type: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-up patchset, based on the mailing list discussion from
March 2023 based on the old patchset v7 [1]. I have changed, the LED trigger
handling via the sysfs interfaces as suggested by Uwe Kleine-König.

[1] https://lore.kernel.org/linux-leds/20230306093524.amm7o4ppa7gon4ew@pengutronix.de/

Florian Eckert (2):
  tty: add new helper function tty_get_mget
  trigger: ledtrig-tty: add new line mode to triggers

 .../ABI/testing/sysfs-class-led-trigger-tty   |  54 ++++
 drivers/leds/trigger/ledtrig-tty.c            | 272 +++++++++++++++++-
 drivers/tty/tty_io.c                          |  29 +-
 include/linux/tty.h                           |   1 +
 4 files changed, 339 insertions(+), 17 deletions(-)

-- 
2.30.2


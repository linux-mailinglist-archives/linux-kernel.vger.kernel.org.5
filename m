Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA757D3DCD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbjJWRcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjJWRc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:32:26 -0400
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Oct 2023 10:32:16 PDT
Received: from out.smtpout.orange.fr (out-18.smtpout.orange.fr [193.252.22.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8098110
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:32:16 -0700 (PDT)
Received: from localhost.localdomain ([89.207.171.96])
        by smtp.orange.fr with ESMTPA
        id uyfSqiNV2aLS1uyfTqByU0; Mon, 23 Oct 2023 19:24:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698081884;
        bh=t7dPTH86r3T7OE/Hsg6Sc2j1I/GQSk2tQP+zV+h/AG8=;
        h=From:To:Cc:Subject:Date;
        b=MFBZI8p7FmZLlPFCzeqUapweAH47vcCK4oyUBogCqv7EhD1XnR6I6QzcFo4tbNaM/
         9WoAIH9zWCABgwlyw+DoowNcv/UinyDoP2xX86rAW77+CpXkm6NCGxaBmrHi+t02W0
         qeh4Ax+YLsbjbn2Pc3gqcgu60E+eySej/jW/0rKCUhEcrCCywNj8RS2QgOjXdptSkz
         syd+ioJdbyJRyBluDc3kBs7PIoC1ScZYf137hks9+/XjQcboh4MP1dLRwA06HkKc7S
         6Vx+Rg552JZnrz1IrgcHC3ocgZXZGNCq2GiHYAZRkQDdrVYfzm2tK5d1qjMPL0cmyV
         YNOkBT5NZZB2A==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 23 Oct 2023 19:24:44 +0200
X-ME-IP: 89.207.171.96
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/4] ACPI: sysfs: Fix some issues in create_of_modalias() and create_pnp_modalias()
Date:   Mon, 23 Oct 2023 19:24:37 +0200
Message-Id: <cover.1698081019.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All issues have been introduced by the same commit, 8765c5ba1949 ("ACPI
/ scan: Rework modalias creation when "compatible" is present")

The first 2 patches fixe some issues related to string truncation checks
and to computation of the available space in the output buffer.

The 2 others are just some clean-ups.

Christophe JAILLET (4):
  ACPI: sysfs: Fix the check for a potential string truncation
  ACPI: sysfs: Fix a potential out-of-bound write in
    create_of_modalias()
  ACPI: sysfs: Remove some useless trailing NULL writes
  ACPI: sysfs: Remove some dead code

 drivers/acpi/device_sysfs.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

-- 
2.32.0


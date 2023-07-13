Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A35751A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbjGMH7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbjGMH7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:59:14 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5852D5A;
        Thu, 13 Jul 2023 00:58:47 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4DBD240003;
        Thu, 13 Jul 2023 07:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689235126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CAcdgMe2/s9IbGFcplUxzsGXDAg2SeY5YUX5I1fIs5A=;
        b=oi0J6CpOPXfLfbUneqPDi+zoXuN+iEyY9u0jowSSMSWYbreVvFKHkkdRDWfhy9P0OV6LY3
        KgZ3zaRuCipq1Mi2G8yn5IuyVvlE37zaejQnJ7hlEsUUAGKFhAhH8UYd06z8v3zcDRblyh
        aq4hqCeXMEZumvN6SgoIuruDvy+SGU4bM/ezDS+Cu3iLTVcSCPnqRrQnDoiLyGXo+hQM+1
        29rq9KQbnJIDKit8Ru6c5Am+mDaz8/D0buwg2jIKZbrdR1+XESgHkfZTZIF0O9TYaV37St
        52EUNblsUHDaBFKWVO0gIObjJEcNtefbnOUE1N+o2gIo4ZkCPYnWi3DDRDrBZA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     William Zhang <william.zhang@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Linux MTD List <linux-mtd@lists.infradead.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>, f.fainelli@gmail.com,
        rafal@milecki.pl, kursad.oney@broadcom.com,
        joel.peshkin@broadcom.com, computersforpeace@gmail.com,
        anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
        tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: Re: [PATCH v4 2/5] mtd: rawnand: brcmnand: Fix potential false time out warning
Date:   Thu, 13 Jul 2023 09:58:43 +0200
Message-Id: <20230713075843.486536-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706182909.79151-3-william.zhang@broadcom.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'9cc0a598b944816f2968baf2631757f22721b996'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-07-06 at 18:29:06 UTC, William Zhang wrote:
> If system is busy during the command status polling function, the driver
> may not get the chance to poll the status register till the end of time
> out and return the premature status.  Do a final check after time out
> happens to ensure reading the correct status.
> 
> Fixes: 9d2ee0a60b8b ("mtd: nand: brcmnand: Check flash #WP pin status before nand erase/program")
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Cc: stable@vger.kernel.org

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

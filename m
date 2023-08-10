Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7724777A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbjHJOWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235682AbjHJOWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:22:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336F1270A;
        Thu, 10 Aug 2023 07:22:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2F4E65DA6;
        Thu, 10 Aug 2023 14:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85856C433C7;
        Thu, 10 Aug 2023 14:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691677335;
        bh=kWqVuzsH0Q6jtQzYrNt8dLcMGh1ZeB95zyVRAeHztoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GNv0vjpVBSzAY0o+k/QbC/U9e6pdOuyj3VtnNWS+y0pG5p9v/7OPK9ufUKCeCk1vJ
         6WztDoeLGqhPGJFQnjJG8Ri0WGCguaujdnWlSNLZDqIIR7MIeT1SMdT0kGqkyK5XlW
         HxoPY2a0HX6A76QKL6uKiR1c3dGXx2oXjRAMRlj1D7+nCgw0tLr/dJ4LNZotk2xQ7a
         hNZsZd2KRVfE9n8T0Z8O1mY8epSqvi3Il85a9tC6Z7S7+Jky96VwOD4Mbb3Zc5M+xP
         FMl1gY9Hfz5bbzXb7E4sNXgRG4DoJAIq0wkrtIpsHcfE1XhO0kLFoRR4jQbOKsCuvI
         9KFQR9JKhfBlQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-parisc@vger.kernel.org
Subject: [PATCH 09/17] parport: gsc: mark init function static
Date:   Thu, 10 Aug 2023 16:19:27 +0200
Message-Id: <20230810141947.1236730-10-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810141947.1236730-1-arnd@kernel.org>
References: <20230810141947.1236730-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This is only used locally, so mark it static to avoid a warning:

drivers/parport/parport_gsc.c:395:5: error: no previous prototype for 'parport_gsc_init' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/parport/parport_gsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/parport/parport_gsc.c b/drivers/parport/parport_gsc.c
index 5e4475254bd0a..c7e18382dc014 100644
--- a/drivers/parport/parport_gsc.c
+++ b/drivers/parport/parport_gsc.c
@@ -392,7 +392,7 @@ static struct parisc_driver parport_driver __refdata = {
 	.remove		= __exit_p(parport_remove_chip),
 };
 
-int parport_gsc_init(void)
+static int parport_gsc_init(void)
 {
 	return register_parisc_driver(&parport_driver);
 }
-- 
2.39.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515F07574CC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjGRHAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjGRHAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:00:01 -0400
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1667E7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:59:58 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202307180659566b2c664270d9c460b3
        for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 08:59:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=dsqOsTbu6ItfSQgdDQ9vQvzE5kO/E/YSJ1AX3jl3+I4=;
 b=b0sh/73dxpJ5z48g0KYd7PK1ggLAlq2Zp+unEjLDZ3SDbp7w6kl02kAewCAggNuLBe2ycv
 PjCWLZsl443vujr1F6jHY2ZhDPDf4gJ4Z43wbl9oHTH7iqcpDge3NCBwjc3pwQdLJeic3W1f
 cm9Ib02hd20Awwf6ExbzFtM01pj38=;
From:   "M. Haener" <michael.haener@siemens.com>
To:     netdev@vger.kernel.org
Cc:     Michael Haener <michael.haener@siemens.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH v3 0/3] net: dsa: SERDES support for mv88e632x family
Date:   Tue, 18 Jul 2023 08:59:28 +0200
Message-ID: <20230718065937.10713-1-michael.haener@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Haener <michael.haener@siemens.com>

This patch series brings SERDES support for the mv88e632x family.

We have backported and tested the patch series with kernel 6.1.
With the current kernel it was possible to build without errors,
but not to test on the HW (due to a vendor kernel).

Changelog:
v3: rebased onto main branch
v2: rebased onto Russell Kings series dsa/88e6xxx/phylink

Michael Haener (3):
  net: dsa: mv88e632x: Refactor serdes read
  net: dsa: mv88e632x: Refactor serdes write
  net: dsa: mv88e632x: Add SERDES ops

 drivers/net/dsa/mv88e6xxx/chip.c   | 35 ++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h   |  5 ++
 drivers/net/dsa/mv88e6xxx/serdes.c | 76 +++++++++++++++++++++++-------
 drivers/net/dsa/mv88e6xxx/serdes.h | 33 +++++++++++++
 4 files changed, 133 insertions(+), 16 deletions(-)

-- 
2.41.0


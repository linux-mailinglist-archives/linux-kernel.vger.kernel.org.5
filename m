Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD60A7E9AAF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjKMLHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKMLHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:07:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C06E10D0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 03:07:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B44C433C8;
        Mon, 13 Nov 2023 11:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699873636;
        bh=LOxeX+UITP7Q9EMFXfOWnEfl7vySqq501b5Bmi7TWxs=;
        h=From:To:Cc:Subject:Date:From;
        b=OIHfP10cxjLlEAG/lFBprQv9qyUl5hAePRX09MAq3bXb6LdqmMGTDT2Fd43rNRbN4
         bWRdSYjYK+8dgR6cJ/gMNhmgtsGxxRgNZ9qPriYha58VwzIgFl7h3TPL8xd26UM7LC
         sflf6WDkcxuPQmqjM4nWZNNxCPKAJfKHl7wDJNoKXIlbGkkYUAh0UDsOU+E1TvO0TQ
         1bm/HiAW6kIKdyAmoPBe2ViNu8iyczM6frz0NtSuQ30dkrQSkfTb4rbgOs4RV/GhlW
         ndAUCuqy/rQRlISWmbeDrbnAnwJkaKl64Oh/d+XpmE2YxcoiYIh3weeFX4D1QFFEmE
         bW0UCtbPrngDA==
From:   Roger Quadros <rogerq@kernel.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     vladimir.oltean@nxp.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
        srk@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH net-next 0/3] net: ethernet: am65-cpsw: Add ethtool standard MAC stats
Date:   Mon, 13 Nov 2023 13:07:05 +0200
Message-Id: <20231113110708.137379-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Gets 'ethtool -S eth0 --groups eth-mac' command to work.

Also set default TX channels to maximum available.

cheers,
-roger

Roger Quadros (3):
  net: ethernet: am65-cpsw: Add standard Ethernet MAC stats to ethtool
  net: ethernet: am65-cpsw: Set default TX channels to maximum
  net: ethernet: am65-cpsw: Error out if Enable TX/RX channel fails

 drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 26 +++++++++++++++
 drivers/net/ethernet/ti/am65-cpsw-nuss.c    | 37 ++++++++++++++++-----
 2 files changed, 55 insertions(+), 8 deletions(-)


base-commit: 89cdf9d556016a54ff6ddd62324aa5ec790c05cc
-- 
2.34.1


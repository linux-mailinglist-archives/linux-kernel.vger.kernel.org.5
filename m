Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45757EDF32
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344985AbjKPLJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345094AbjKPLJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:09:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E500D71
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:09:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89199C433C9;
        Thu, 16 Nov 2023 11:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700132979;
        bh=AQ38LoocJGoRF+gIiYEf6xsuX4n1NAqE6Sh/zFnSIo0=;
        h=From:To:Cc:Subject:Date:From;
        b=nESFa4bF3BGTqlqH/tn28UCpGTS/ogaOhDk0t5Cue62Jb5rEKEHFr7iMwarfC9QqR
         g/JsU8DYR+jrYziT8RoPtx9on3NKhjooYRlLeJRBpPKQ+c+VlM2JCmp7ra5md/w2mZ
         2OIF8s61d4Oal/5+rPzxxg1IMswi3QK2UFPHUPiHyZOmHr/pb9oUUyQuN1lQHxhOvw
         2Sfg0GINXxojJo5cnIyyZ/0t+cjvnZZFj+imv/SFc8EANhAA2G/iC1iyfYo2yjlnOI
         FDFMYthsKWByznxaMfJKx4vi//xtBK5KqFQTIvi08I1Y8mkG3FKJ2FJUmtTk9MxGUi
         4Fq7VKS0+UuVQ==
From:   Roger Quadros <rogerq@kernel.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     vladimir.oltean@nxp.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
        vigneshr@ti.com, srk@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH net 0/2] net: ti: am65-cpsw-nuss: module removal fixes for v6.7-rc
Date:   Thu, 16 Nov 2023 13:09:28 +0200
Message-Id: <20231116110930.36244-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series fixes warnings during module removal.

cheers,
-roger

Roger Quadros (2):
  net: ti: am65-cpsw-nuss: Fix devlink warning on module removal
  net: ti: am65-cpsw-nuss: Fix NULL pointer dereference at module
    removal

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)


base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9947AA0A0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjIUUnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjIUUnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:43:18 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0952CF4D9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=k1; bh=/hGi7nKY0ZCz5n
        gHoRP4Dnsm6cwPVYQ6ullUHHK9G/U=; b=FSgnuyf9iJJY3eix3OUaTTB7WoR3RL
        Qw8D9JBqrJTfaObsLpr9iGr1zfjqIhAZlD2EJTcRtKzxQ/oL9qlFvwQySdR6OCxV
        xvJNPdXpBpQux5aaw76J+BP+q3y+rr2zxCCVSMMavi5M97ivNoxC3vbHB0B/slzk
        rJhwE1jCsPiYD+edKd8vjVSXFlUTop0ilWvMRKF8aFkp6qG6gk2PrgTyKx1Cp2mO
        oHKwBIy3gkrIWNMx7xWJuTBw8R2eJmk/liFow5/UqoBLzhBzt8gVo1/NEQ0bAq7e
        5jAFI/qyL8IhuHynvzEs/FcotWalL7w9Cc4fxPU18Mib2Ed46PTjAC1g==
Received: (qmail 953722 invoked from network); 21 Sep 2023 14:54:02 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Sep 2023 14:54:02 +0200
X-UD-Smtp-Session: l3s3148p1@yGh7/N0FzUQuciJ+
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] i2c: rcar: improve Gen3 support
Date:   Thu, 21 Sep 2023 14:53:48 +0200
Message-Id: <20230921125351.3954-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a series paving the way for Gen4 support. This time we properly
apply the Gen3 specific features. See the patch comments for further
information and changelogs. This has been tested on a Renesas Falcon
board with a R-Car V3U SoC at various bus speeds. Because the
calculation formulas are crucial, testing on board farms would be much
appreciated!

Thanks and happy hacking!

Wolfram Sang (2):
  i2c: rcar: reset controller is mandatory for Gen3+
  i2c: rcar: improve accuracy for R-Car Gen3+

 drivers/i2c/busses/i2c-rcar.c | 157 ++++++++++++++++++++++------------
 1 file changed, 103 insertions(+), 54 deletions(-)

-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73718129AB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443393AbjLNHoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjLNHoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:44:11 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3E1A3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=k1; bh=S56C6/etkE5Dil
        9FeOPVPcU3W2R+6vc6EhGV0L1qNYk=; b=b7lwmwBJ2f99vI6zdDBUIIv9QoczwR
        yltCsmW3JVNpZOVW+d5H4zgDCSCSTlFndgInrLDUc6guVfao+lQtCNxxTJRufpl3
        3VQW+di3sJAe1q9jZP7LSSQ4sNKwySLNYQsfh+aQszcxI3sSlt6aI8LogR8A37yu
        g4DTowLda65vNymzAb7ho2QMJwBjRoDHHzRWA5NNTbsSHcd9XnFlnijRWJrGYa8Y
        tcsrWYS4b7oH68kVDVAZSBNwZKVmyHbczt8lMcPg87C5YYLCSQuKQ3ZspUjwHDEf
        NCiOjV7OHak4MIebqSsvDKxSaAdN6mtqmcWZrdx0VcSZWHX26ChP2UgA==
Received: (qmail 826951 invoked from network); 14 Dec 2023 08:44:12 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Dec 2023 08:44:12 +0100
X-UD-Smtp-Session: l3s3148p1@yOjUcnMMytoujnuR
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] i2c: rcar: add support for Gen4 devices
Date:   Thu, 14 Dec 2023 08:43:56 +0100
Message-Id: <20231214074358.8711-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newest generation of Renesas R-Car SoCs support FastMode+. This
series enables the driver to use it. Changes since v1 are annotated in
the patches.

Looking forward to comments and test reports etc.

Happy hacking!


Wolfram Sang (2):
  i2c: rcar: introduce Gen4 devices
  i2c: rcar: add FastMode+ support for Gen4

 drivers/i2c/busses/i2c-rcar.c | 51 +++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 17 deletions(-)

-- 
2.35.1


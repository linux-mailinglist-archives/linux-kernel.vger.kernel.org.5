Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D917E0B61
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 23:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377890AbjKCW4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 18:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377292AbjKCW4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 18:56:19 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF911A8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 15:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :mime-version:content-transfer-encoding; s=k1; bh=//vHDdaoI7preO
        uPzu7V9aDR11Gy4yS0cSesSqxf2j0=; b=iUsvARtHMQcT4RqRHG3CyfHdzIQLTO
        00wA9s8kq25uXsxptGsrlKrEnjC0DrdXjTqlNuUQg/g8N0hFG6a8zP9feAtbR7dX
        H+Fljee9ydaw6hnaVPCIK5swcplWBJF+YptGWedubw67RQThYox878WWQF1FQEtT
        B4wNIEKb47xziOVr3dkC9MWq6qWUCcx3peSJBtVZwuOz4+K0zIWiJO7bN8JDeTZg
        vV3WPUGjSzqlcgN5vCdK3QHnDAuU0hDFfNJRf30dn+DDfsSRNiFl2P2lZmbKP/uY
        vVGUXZD4Qm3aZtQlZh1j3/CPH1um8nfzWzRdxtSmWh8taQWEN2+QgAhA==
Received: (qmail 1327833 invoked from network); 3 Nov 2023 23:56:11 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Nov 2023 23:56:11 +0100
X-UD-Smtp-Session: l3s3148p1@/tAgaUcJ8s1ehhrK
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] gnss: ubx: support the reset pin of the Neo-M8 variant
Date:   Fri,  3 Nov 2023 23:55:57 +0100
Message-Id: <20231103225601.6499-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas KingFisher board includes a U-Blox Neo-M8 chip with its
reset pin wired to a GPIO. To support that, we need "reset-gpio" support
(patches 2+3). But first, simplify regulator handling with a new helper
(patch 1).

Changes since v3:
* rebased to 6.6
* improved commit messages for patches 2+3


Wolfram Sang (3):
  gnss: ubx: use new helper to remove open coded regulator handling
  dt-bindings: gnss: u-blox: add "reset-gpios" binding
  gnss: ubx: add support for the reset gpio

 .../bindings/gnss/u-blox,neo-6m.yaml          |  5 +++
 drivers/gnss/ubx.c                            | 35 ++++++++-----------
 2 files changed, 20 insertions(+), 20 deletions(-)

-- 
2.35.1


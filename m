Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788167F33C2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjKUQau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKUQaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:30:46 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5C4CB;
        Tue, 21 Nov 2023 08:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1700584228; x=1701189028; i=wahrenst@gmx.net;
        bh=S02d0LpoaxYbVXdkNYddTYpdeZjfrmY2E0FoJic6qbc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Ukx3ySE62hk+lkblYSRiHbPWiGZJCYu/T5X6Ydk4FM2MPCPdXejMVj5y2LHI4T1L
         gdBaBR3VqSjBsqZhBSjDuuqIxtNMOFZWqll0gbSWewBqVRJJsJ0CWXZAYUG3OjD8Z
         fPrp7IhWqpcLlEgVfvFZZJtsX+vVbsH2lSfbIrfjV1T1z6M9/VxvKtRQhlNg/jSpE
         fZTKRlLd61ke9uojRpwFbsvKqPyYdrdLnJM6u65dnbHow1Db88H740KH5DPS4v+kM
         oOZrS+9YKisAduIGPa/GWrmlZ9siFk064npDmnbnP2BqX5Zl74FVoBE4PsYkWrUld
         luBb0cc5gs8JrVNH5g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSKy8-1quR2340Ii-00Sjav; Tue, 21
 Nov 2023 17:30:28 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 0/4 net] qca_spi: collection of major fixes
Date:   Tue, 21 Nov 2023 17:30:00 +0100
Message-Id: <20231121163004.21232-1-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VNnea3i9p0ZZHidLTaFt5yhjJh/22PQZCf8ShbJNrQQjLKHx6Cl
 4HXaUDrUJnQSnhxxMU4ZbCJRW2XPczMPPdinOUukKUlR5luSWYUWX+tYt3jhZTPXT4EgeVw
 tSVt7NU8W7rjsBTrxCSQw8Ge9m+5rdHqG7WuuUhxuSjiHweB3hg5R8xI1S3X0BUdl1OTr0F
 ecbWuiL8zcb1fZmBa0NDQ==
UI-OutboundReport: notjunk:1;M01:P0:RVDoPulWi8Q=;hl3THpf2XvUDj8ESzV+8Ksu/u6C
 Iy4V75TmNss/sqZ7/q9aj5NgbjTyITnXntwJ6D28pEJhAXaVsqDPyMXcOYVC5Kr7jpJ/sa0cA
 2ZR6D/Da72T8IbTo3xYcIb+ACAYYkdxdDV6kLSpAqKy+OYVVSQKKi1AyjOOupm4yVHoNQIY5a
 OPZykMt2vKaGBBQmYywfFCK8xm8pSp2g7rSLkPYlwAuYyGQd6oMH5uf+7gg8mW2pFHAaliVWg
 xb22s1uFXSBkm9335iCt8Q1mMuHVYZzyI8FyLPgNQYbm55GjeoJve+U5/CdiZV91W7MepLmin
 ct57ZP9OYQ5EPDgxja6NXBkxatyNN5o8sfw7TvXYR/Wg2moT4pU6E6wH9fN1DnzfsO1YWHCre
 ZNLCDuw2VwzNsFtYVtZzD0nwRZhcJKmMiEEqsbKMsmub/RrwQaAnRCLw1iYxJVqwomdPXUhXL
 oB5Mf/JT4DhFsIUEhkIPqHLtUTJiIfw+N6r75Q+w/vv1ysHcAbzALkf5OCufJ23qcH/aLTRMb
 kG8ZiogHH8/SLJCOx4NFV8dAYkXb3tqWb7NicF7U+LK4sVJwdDfm0DmiGFuDOZY73GD6U3SZs
 pFBaPoTnaXxafHdX2ueRevXvknm80xUYPoIb6LtP5HW6cnvmGNkwXIkvAO9F1wpi6SuoGYS78
 FTwN01GNiBA7qovwBo9+hcPDfNX2HnLTWeQlJXgoH63pyWxEzIx4QxPQ/F5DNFxzFmMLzi4FT
 qsAWx5T7d/mhrdjloWjEWugxNl3AbrGkh0XmAx0eLb4WszBdcRaqZ4ie23Ct8GhTAfOEupOy+
 v9cRJD359mKyRPP62RGQ/NUwHodAJYto0UjCDzkr+K2uHHes4jedMlYlYN2XkHH76IMHW+5NX
 VL2acSmE+O5HFmOTurY/TWbw2t8cMgPtBxeIqkEvZkwY83puLlMpNaNzVF9NuVI54JW8XRXoW
 nMiHwg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains a collection of major fixes for the qca_spi driver,
which has been recently discovered.

Stefan Wahren (4):
  qca_spi: Fix SPI thread creation
  qca_spi: Fix SPI IRQ handling
  qca_spi: Fix ethtool -G iface tx behavior
  qca_spi: Fix reset behavior

 drivers/net/ethernet/qualcomm/qca_debug.c |  2 -
 drivers/net/ethernet/qualcomm/qca_spi.c   | 63 +++++++++++++++--------
 2 files changed, 41 insertions(+), 24 deletions(-)

=2D-
2.34.1


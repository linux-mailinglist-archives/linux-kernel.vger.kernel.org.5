Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45327FF32E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346110AbjK3PGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346053AbjK3PGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:06:09 -0500
X-Greylist: delayed 200 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Nov 2023 07:06:15 PST
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97486137
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:06:15 -0800 (PST)
Received: from 002.lax.mailroute.net (002.lax.mailroute.net [199.89.1.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by 011.lax.mailroute.net (Postfix) with ESMTPS id 4Sgzvh3FqSz1XdYXD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:02:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by 002.lax.mailroute.net (Postfix) with ESMTP id 4Sgzvf3vHNzm3q6J;
        Thu, 30 Nov 2023 15:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chelsio.com; h=
        content-disposition:content-type:content-type:mime-version
        :message-id:subject:subject:from:from:date:date:received
        :received:received; s=mr01; t=1701356573; x=1703948574; bh=Y/fMi
        DXa5sURyzjs6O9Vo3P39Gz+yobrzKNnFmeVZ4Y=; b=BSx/P1Kle1YntJEqPfgyD
        6lr99IXLXQxtHRX5d2fpo8VehobnVCcxhP7G0ciS7t7FGktFVqcEJwLissfJxvrL
        TCgRF0wAa7968aVvhh5G3YSlqT1iVpywdSakyIND5Ua3oa+ixHVAImn0Ve7uKwbM
        +skxfLB7lBBK5dSmkI3aCn/upuwQb5SugIjMSgPScA0aHdPt8aGjE4NgN5CxZkxU
        xoevWlAEOixnCHPSyUBmgAvOYvVG75w9Wy4lm48KCpWiFFPn8oSH3v0g2A9Ls0hD
        OzIYUFqKzYDTVwvOr8iWSsBArDWpejuwkNyd1klWW4bLveuAYYQ+KCh9S78qrd2B
        g==
X-Virus-Scanned: by MailRoute
Received: from 002.lax.mailroute.net ([127.0.0.1])
 by localhost (002.lax [127.0.0.1]) (mroute_mailscanner, port 10026) with LMTP
 id WwRgO_F0bDoC; Thu, 30 Nov 2023 15:02:53 +0000 (UTC)
Received: from stargate.chelsio.com (stargate.chelsio.com [12.32.117.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by 002.lax.mailroute.net (Postfix) with ESMTPS id 4Sgzvc4Qtszm3q6B;
        Thu, 30 Nov 2023 15:02:52 +0000 (UTC)
Received: from localhost (indranil-pc.asicdesigners.com [10.193.177.179] (may be forged))
        by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 3AUF2kwk026537;
        Thu, 30 Nov 2023 07:02:47 -0800
Date:   Thu, 30 Nov 2023 20:32:46 +0530
From:   Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To:     linux-firmware@kernel.org
Cc:     linux-kernel@vger.kernel.org, jwboyer@kernel.org,
        ramaraju@chelsio.com, rahul.lakkireddy@chelsio.com
Subject: pull request: linux-firmware: update cxgb4 firmware to 1.27.5.0
Message-ID: <ZWikFs6ZxaxyDMZc@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the new Chelsio firmware from the following URL.

 http://git.chelsio.net/pub/git/linux-firmware.git for-upstream

Thanks,
Rahul


The following changes since commit 034e24b835d1f8b8e8266f766d610683aefe14c3:

  Merge branch 's5p-mfc-v12' into 'main' (2023-11-29 17:05:38 +0000)

are available in the Git repository at:

  http://git.chelsio.net/pub/git/linux-firmware.git for-upstream

for you to fetch changes up to dbf82492ca9000ad794dc8fac6feda1179cd5216:

  cxgb4: Update firmware to revision 1.27.5.0 (2023-11-30 14:11:49 +0000)

----------------------------------------------------------------
Rahul Lakkireddy (1):
      cxgb4: Update firmware to revision 1.27.5.0

 WHENCE                                         |  12 ++++++------
 cxgb4/{t4fw-1.27.4.0.bin => t4fw-1.27.5.0.bin} | Bin 570880 -> 570880 bytes
 cxgb4/{t5fw-1.27.4.0.bin => t5fw-1.27.5.0.bin} | Bin 678912 -> 678912 bytes
 cxgb4/{t6fw-1.27.4.0.bin => t6fw-1.27.5.0.bin} | Bin 730624 -> 730624 bytes
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename cxgb4/{t4fw-1.27.4.0.bin => t4fw-1.27.5.0.bin} (99%)
 rename cxgb4/{t5fw-1.27.4.0.bin => t5fw-1.27.5.0.bin} (59%)
 rename cxgb4/{t6fw-1.27.4.0.bin => t6fw-1.27.5.0.bin} (76%)

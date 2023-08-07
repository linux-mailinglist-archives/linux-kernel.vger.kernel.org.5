Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910197728BF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjHGPJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjHGPJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:09:08 -0400
X-Greylist: delayed 187 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Aug 2023 08:08:36 PDT
Received: from 001.mia.mailroute.net (001.mia.mailroute.net [199.89.3.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2F21BE3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:08:36 -0700 (PDT)
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by 001.mia.mailroute.net (Postfix) with ESMTPS id 4RKKPj07vLzlhbpk
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 15:05:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by 013.lax.mailroute.net (Postfix) with ESMTP id 4RKKPh1sX4z7tVc;
        Mon,  7 Aug 2023 15:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chelsio.com; h=
        content-disposition:content-type:content-type:mime-version
        :message-id:subject:subject:from:from:date:date:received
        :received:received; s=mr01; t=1691420726; x=1694012727; bh=kI5MP
        69iBa6cLoIh+BRtC0HvlKLI0Kv4MN7Oqj7TiT0=; b=BAViq3QbfCJgGSJRre8+u
        J7OgvD+UmGywSbZ2obFdMR2sdUUE0MuuI8WVAlkD39yfSK7dZuZEtVTuplgLg6hc
        Bg0l5/UtoERBSKwqN4x6Cf1dFYC3I75WZCyHsAH5deLNnUec8c0bJYg9AsvNmBEp
        KFaxaJL9lJR5gh68mbIWbjIxtCBZqw2ylJrAd7ynwKSi52/emP2E7v2w3ZQzB2UV
        Ew6qdccP1T1s9YRr0+k/XTitHy+CvtgPZr3HGsoiSDJ4BBLTou5nqTFPCSk+aakD
        SEyH3bjwBIsZza6LZB+fZpym6uA6V/BLmkDNEeLx0cXlum2CEx9bMmBceiaF5+9y
        w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10026) with LMTP
 id 4wGAoa0JItkF; Mon,  7 Aug 2023 15:05:26 +0000 (UTC)
Received: from stargate.chelsio.com (stargate.chelsio.com [12.32.117.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by 013.lax.mailroute.net (Postfix) with ESMTPS id 4RKKPd5f4nz7tVb;
        Mon,  7 Aug 2023 15:05:25 +0000 (UTC)
Received: from localhost (arunbr.asicdesigners.com [10.193.177.142] (may be forged))
        by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 377F5Mkk012003;
        Mon, 7 Aug 2023 08:05:23 -0700
Date:   Mon, 7 Aug 2023 20:35:21 +0530
From:   Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
To:     linux-firmware@kernel.org
Cc:     linux-kernel@vger.kernel.org, jwboyer@kernel.org,
        ramaraju@chelsio.com, rahul.lakkireddy@chelsio.com
Subject: pull request: linux-firmware: update cxgb4 firmware to 1.27.4.0
Message-ID: <ZNEIMX97ze8lEz9Y@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the new Chelsio firmware from the following URL.

  http://git.chelsio.net/pub/git/linux-firmware.git for-upstream

Thanks,
Rahul


The following changes since commit 7be2766de1f45a494a3e913f2e9fb77191a8ddb5:

  Merge branch 'rb3-update' of https://github.com/lumag/linux-firmware (2023-08-04 06:33:54 -0400)

are available in the Git repository at:

  http://git.chelsio.net/pub/git/linux-firmware.git for-upstream

for you to fetch changes up to 06fa7dd2046343ecac54b75b9541cffd6dcc64ae:

  cxgb4: Update firmware to revision 1.27.4.0 (2023-08-07 12:32:53 +0000)

----------------------------------------------------------------
Rahul Lakkireddy (1):
      cxgb4: Update firmware to revision 1.27.4.0

 WHENCE                                         |  12 ++++++------
 cxgb4/{t4fw-1.27.3.0.bin => t4fw-1.27.4.0.bin} | Bin 570880 -> 570880 bytes
 cxgb4/{t5fw-1.27.3.0.bin => t5fw-1.27.4.0.bin} | Bin 678912 -> 678912 bytes
 cxgb4/{t6fw-1.27.3.0.bin => t6fw-1.27.4.0.bin} | Bin 730624 -> 730624 bytes
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename cxgb4/{t4fw-1.27.3.0.bin => t4fw-1.27.4.0.bin} (99%)
 rename cxgb4/{t5fw-1.27.3.0.bin => t5fw-1.27.4.0.bin} (60%)
 rename cxgb4/{t6fw-1.27.3.0.bin => t6fw-1.27.4.0.bin} (76%)

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3720C78635E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 00:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238622AbjHWW2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 18:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238617AbjHWW2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:28:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF9410D7;
        Wed, 23 Aug 2023 15:28:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23903635BD;
        Wed, 23 Aug 2023 22:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A515C433C8;
        Wed, 23 Aug 2023 22:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692829700;
        bh=UDRNUnmx3NfgEHk31XjOvSoANhGH/ROeRPOHH8LioZA=;
        h=Date:From:To:Cc:Subject:From;
        b=PeaBZ6ixjMfaN8Z+HgjfVybo8dKHDQb/LZnXzgOvdfX/h4NzwH9RvjuNI9EYcPcet
         TqRZWE3iP/yYQtuv7ucJMblaEdwvtIHN3e0hsgwHJb5TdU/2iOgsKBS0bpFz2bUVYi
         gMfpZhg2Cv3tOmPKa+Pog3LiLEUPid0sHVc4qQHuI2i7cOW4EB8Zi3P1YsNcjKYABC
         pbSePDK5XcrsdSI78wMjRncPTcKWqQWJXXQ2ZZGg+caIdY2FvZbciVSzXM6Msctu0t
         DkttmMFcHiYaYIVxb6Pi+RdRDQ33LTkY5NIaT/p80Bw9He9sk9HC40m3soU92RCKTX
         xq2CUqz+tRvLg==
Date:   Wed, 23 Aug 2023 16:29:19 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@kernel.org>,
        Amitkumar Karwar <akarwar@marvell.com>,
        Xinming Hu <huxm@marvell.com>, Dan Williams <dcbw@redhat.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 0/3] wifi: mwifiex: Fix tlv_buf_left calculation and replace
 one-element array
Message-ID: <cover.1692829410.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

This small series is aimed at fixing a bug in the tlv_buf_left
calculation, doing a flexible-array transformation, and adding
a couple of sanity checks.

Thanks

Gustavo A. R. Silva (3):
  wifi: mwifiex: Fix tlv_buf_left calculation
  wifi: mwifiex: Replace one-element array with flexible-array member in
    struct mwifiex_ie_types_rxba_sync
  wifi: mwifiex: Sanity check tlv_len and tlv_bitmap_len

 .../wireless/marvell/mwifiex/11n_rxreorder.c  | 22 ++++++++++++++++---
 drivers/net/wireless/marvell/mwifiex/fw.h     |  2 +-
 2 files changed, 20 insertions(+), 4 deletions(-)

-- 
2.34.1


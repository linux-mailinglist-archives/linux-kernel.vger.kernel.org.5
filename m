Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597B6785675
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbjHWLJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbjHWLJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:09:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3C010D0;
        Wed, 23 Aug 2023 04:09:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39E026470F;
        Wed, 23 Aug 2023 11:09:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED48C433C7;
        Wed, 23 Aug 2023 11:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692788946;
        bh=xlokbwy5AnReUi5HAX8ojrTBAr8hRcsPhhw7S8VCoqE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=CVRHHdTAVKNHcZvmerFqH6NkB/pjBosn6RcR5+6Ur8WNSRvNow5MPw8d+AM9YZ76m
         ISpl+L7IYYn8ILcK6bGKX1y9Cg23vZ6QVzDOHV2ds2Jgd9v82JRoOVHlUizSAn59l1
         t4l43nwFepQBxtu1QEWd3RytmYMEDPDpb8CCvzzeugQgigQFDzBnptFsxg1qmMw5MG
         +JEJD+9b6yGPDZftorJgNSoT420uj6DmF/yYusG7QJKIDVdkNflx7/WXDVfY42EJkb
         BvRktk3Va3y1LrHL9X7Y/1sNoohHfv/nNPZl+7U9oqDXGCCe+GpUE+/3U9yuXIIVwh
         uFI79aMkJheuw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next v2 1/9] wifi: rsi: rsi_91x_coex: Remove
 unnecessary
 (void*) conversions
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230803073440.3666204-1-yunchuan@nfschina.com>
References: <20230803073440.3666204-1-yunchuan@nfschina.com>
To:     Wu Yunchuan <yunchuan@nfschina.com>
Cc:     yuancan@huawei.com, simon.horman@corigine.com,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Wu Yunchuan <yunchuan@nfschina.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169278894246.1133515.6568305086508315511.kvalo@kernel.org>
Date:   Wed, 23 Aug 2023 11:09:04 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Yunchuan <yunchuan@nfschina.com> wrote:

> No need cast (void*) to (struct rsi_coex_ctrl_block *) or
> (struct rsi_common *).
> 
> Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>

9 patches applied to wireless-next.git, thanks.

5f48e91624b3 wifi: rsi: rsi_91x_coex: Remove unnecessary (void*) conversions
148924e537df wifi: rsi: rsi_91x_debugfs: Remove unnecessary (void*) conversions
52424e0c49d6 wifi: rsi: rsi_91x_hal: Remove unnecessary conversions
6d5d2dbd00bf wifi: rsi: rsi_91x_mac80211: Remove unnecessary conversions
db2be1a01fc5 wifi: rsi: rsi_91x_main: Remove unnecessary (void*) conversions
f9bf6e729f4e wifi: rsi: rsi_91x_sdio: Remove unnecessary (void*) conversions
361beddbfb7c wifi: rsi: rsi_91x_sdio_ops: Remove unnecessary (void*) conversions
f543235c3948 wifi: rsi: rsi_91x_usb: Remove unnecessary (void*) conversions
7d8473c799be wifi: rsi: rsi_91x_usb_ops: Remove unnecessary (void*) conversions

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230803073440.3666204-1-yunchuan@nfschina.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


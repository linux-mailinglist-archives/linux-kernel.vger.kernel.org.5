Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69287AEAAB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbjIZKpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbjIZKpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:45:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD635E9;
        Tue, 26 Sep 2023 03:45:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C46EC433C8;
        Tue, 26 Sep 2023 10:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695725108;
        bh=Jr19cp7yaOhQeqgjjuOGhureNw6Qt3kSFYQrp6ys3gM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dmpSq5h+4p12H+CMfVLWGr6ETOYNhl3F6Sk3hs5OTdZaCgxg9vXopsoT8+iBApq4X
         BVCDUlNVkY5y4xOAwrLaE2L8WChSIa8aZpfpJTIbw0ABQVSgPZ0QP8Vh2QYOM4F98B
         7M1FAFV4042aYxcHwDZllNMcsluHKgmogCVm9e9xvV3NJB+C54aIGl8no7cVXRq5DJ
         vJNcXWYxkTDnNE0unGYbhe2eH2KRopax6YE61l8RGtt97NU5D1XTOdbvIpHP0f/hTW
         /g5Z5Dkp080NoP6XJfXiFgb7SEDZ6bYBHex0spKL/7E4zCEaUVBnmvS4S8/6TZUZeD
         WPfDzWJBCI2TA==
From:   Kalle Valo <kvalo@kernel.org>
To:     roynatech@gmail.com
Cc:     johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mac80211: fix station hash table max_size config
 dependency
References: <20230923032834.9694-1-roynatech@gmail.com>
Date:   Tue, 26 Sep 2023 13:47:08 +0300
In-Reply-To: <20230923032834.9694-1-roynatech@gmail.com>
        (roynatech@gmail.com's message of "Sat, 23 Sep 2023 03:28:34 +0000")
Message-ID: <87bkdpjjo3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

roynatech@gmail.com writes:

> From: roynatech2544 <whiteshell2544@naver.com>
>
> Commit ebd82b3 ("mac80211: make station hash table max_size configurable") introduced config
> MAC80211_STA_HASH_MAX_SIZE, which is defined unconditionally even if MAC80211 is not set.
> It doesn't look like it is dependent of MAC80211_DEBUG_MENU either, as its only user is sta_info.c
> which is compiled unconditionally when MAC80211 != n. And without this config set somewhere, compile
> would error out.
>
> Make it depend on MAC80211 to correctly hide the config when MAC80211=n
>
> Fixes: ebd82b3 ("mac80211: make station hash table max_size configurable")

The commit id in fixes tag is too short, more info in the wiki link
below.

> Signed-off-by: roynatech2544 <whiteshell2544@naver.com>

Please use your full legal name, no pseudonyms please. See wiki.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

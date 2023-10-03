Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FFA7B6AF4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbjJCN6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbjJCN6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:58:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C6EA9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 06:58:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9876FC433C8;
        Tue,  3 Oct 2023 13:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696341486;
        bh=ai0DuCjyGD2l5/5x0bHJ1YHAv82RmsrUbrt1jRnZTg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s5DHY/Bd3kZXCEjaIPEt2SwmpqwWwvYTldQMIFYaHPuqcAGIjl9YiewtjWuFBng6e
         m4ML72IHWC6+DjzZJnISnRzECzC1M9fdAxtA8bMbRvVd+y/zmNGOcbmxRsRJpKI0we
         gKaIv9/d8/KyiJLOuq1Nh8KMtVdX8Yfp7lG1RU5NBfQZGA3BPaCEIEyoE4qLURNJ13
         0NIBfVlZAFvx8U1Yf/DQJpH925DBfIQNJ+VnvcYlz6sJAXaqcO4vbGwLGdhHshyN4A
         IxXEEkPy0C6FU1K9cjRutjx7FzFk3oyJfhPEy40rV24vuIwd4qw9EijSa95afACZ7M
         +i+IUjTHLoFKQ==
Date:   Tue, 3 Oct 2023 15:58:02 +0200
From:   Simon Horman <horms@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Bryan Whitehead <bryan.whitehead@microchip.com>,
        UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v2] net: lan743x: also select PHYLIB
Message-ID: <ZRwd6r3GnSUgxwwZ@kernel.org>
References: <20231002193544.14529-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002193544.14529-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 12:35:44PM -0700, Randy Dunlap wrote:
> Since FIXED_PHY depends on PHYLIB, PHYLIB needs to be set to avoid
> a kconfig warning:
> 
> WARNING: unmet direct dependencies detected for FIXED_PHY
>   Depends on [n]: NETDEVICES [=y] && PHYLIB [=n]
>   Selected by [y]:
>   - LAN743X [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_MICROCHIP [=y] && PCI [=y] && PTP_1588_CLOCK_OPTIONAL [=y]
> 
> Fixes: 73c4d1b307ae ("net: lan743x: select FIXED_PHY")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: lore.kernel.org/r/202309261802.JPbRHwti-lkp@intel.com

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested


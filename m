Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27450794195
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbjIFQlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjIFQlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:41:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE911724
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 09:41:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F76C433C8;
        Wed,  6 Sep 2023 16:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694018480;
        bh=Sp0/mnRPXAwYptFsBN7paUPyr28E4thRdJ6CJ/lv3lM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dO3qgwDAs2zTRQpBHQyCEYEXOuO/1VsurxWEepZqVKgfKENnd9FNNkrHKWDo4isiI
         lFzaWoY6Ds6EFieZAAQlunL39qOZ6CTmfta4War09QbIhJDS1EnEtgkFip3jhD4JtB
         6O0/GEJvGFBPOdeYrJBqW274HaDvwC0ZQQoTF6Psgcvoq8XA3HY5dZ8nmmwQGIX712
         PFwLeQw7UaK67OAOhd17m32+kRXYO1RMsxqxy0yYJnrj6yq8WgIc0USHH7LUInlHYR
         P2sPznSye/C4p7DKS8PqOH/odfxIlgHj/uZevvCFbmeb7wPNEUKqCRGA5+Tmk9aBxQ
         sx4SRyZDENCfw==
Date:   Wed, 6 Sep 2023 18:41:16 +0200
From:   Simon Horman <horms@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, Claudiu Manoil <claudiu.manoil@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH net] net: enetc: distinguish error from valid pointers in
 enetc_fixup_clear_rss_rfs()
Message-ID: <20230906164116.GB270386@kernel.org>
References: <20230906141609.247579-1-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906141609.247579-1-vladimir.oltean@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 05:16:09PM +0300, Vladimir Oltean wrote:
> enetc_psi_create() returns an ERR_PTR() or a valid station interface
> pointer, but checking for the non-NULL quality of the return code blurs
> that difference away. So if enetc_psi_create() fails, we call
> enetc_psi_destroy() when we shouldn't. This will likely result in
> crashes, since enetc_psi_create() cleans up everything after itself when
> it returns an ERR_PTR().
> 
> Fixes: f0168042a212 ("net: enetc: reimplement RFS/RSS memory clearing as PCI quirk")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/netdev/582183ef-e03b-402b-8e2d-6d9bb3c83bd9@moroto.mountain/
> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>


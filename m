Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E543C777FB6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 19:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbjHJR7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 13:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjHJR7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:59:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6ACE7E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 10:59:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CC9466535
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 17:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E22C433C7;
        Thu, 10 Aug 2023 17:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691690383;
        bh=zMZBAlIYuXts1JWarKGJe9B8Z9TCqF4od1Y1jiyno/w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BF5r4c4gIvQFQi5eUZ708LH7BFjr3WyT+hyC1REdcPPuTAW7OBAXNiU+0dZRyfWYY
         iGlOJcRModXhO9DfwIHXq139mTNMhZfD88YUCcuPd5lN3d6ZZ6h/cgHWpwyI6P5sPG
         opRssifeP7s6KjRaSh7ZQUbMBtpyDAWe+c2H/K9Pah/N7JUleVIzbyqlRmnBo72X+t
         iFwsfM/dlZIryHHh8/K/O+TEeatLGt72ib6xLEe4h7/cVfMbbWMENJWlMZ7Q7Wn0NU
         fQ93VyfrtlsLo62E4d0teVy0ONmlL+sLJvGX93xEVtNpoUcfpiyTQAWZCpnAQu7uts
         U3zEIQ0FlFkMQ==
Date:   Thu, 10 Aug 2023 10:59:42 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     Ratheesh Kannoth <rkannoth@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
        <lcherian@marvell.com>, <gakula@marvell.com>, <jerinj@marvell.com>,
        <hkelam@marvell.com>, <sbhatta@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>
Subject: Re: [PATCH net] octeontx2-pf: Set page pool size
Message-ID: <20230810105942.2bf835a6@kernel.org>
In-Reply-To: <5e481c98-bf82-283f-e826-82802a2bd7d6@intel.com>
References: <20230810024422.1781312-1-rkannoth@marvell.com>
        <5e481c98-bf82-283f-e826-82802a2bd7d6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 19:09:21 +0200 Alexander Lobakin wrote:
> And if the ring size is e.g. 256 or 512 or even 1024, why have Page Pool
> with 2048 elements? Should be something like
> 
> min(numptrs, OTX2_PAGE_POOL_MAX_SZ)

And someone needs to tell me why the 2k was chosen as a value that
uniquely fits this device but not other devices..
-- 
pw-bot: cr

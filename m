Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6988A79D9BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbjILTp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjILTp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:45:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF90115
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 12:45:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9DFC433C8;
        Tue, 12 Sep 2023 19:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694547922;
        bh=4iroGb+H8hWQx0SA7FdXQ78q/JfXbfPgai/e9OcB/mk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EiXKdH2NLcIvKce6hICwQyF+HnF6aLYIve/zcthYTzfD6ezy4jL3OZUEhllfQDgOm
         5/4UOOj2zGz9LGCl7je7U97WoTFtqKDq9IWXedHGGwmxPyg8ntrb+lczOuSehvoKSw
         4feVarKeFxJ6hqBQAjU/lEx1mHkgGGhHEs7j4LVNhywBqE/o9mBCPtrrKtSusu8GQp
         14TlU2pTuuBMgmnQcEiUz52ZgiPouIdSXJuSPtlUHQlGuL1wt2aygiGVY09dC9iYXn
         cTqEo9jx+8Z/Zcmy3IAzVOwOf8+Z7K8VDsorXuhgnAdSrkBnSFGTyK4agyPdd71uGl
         9SSS5cgN9W6IA==
Date:   Tue, 12 Sep 2023 21:45:16 +0200
From:   Simon Horman <horms@kernel.org>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haseeb Gani <hgani@marvell.com>,
        Vimlesh Kumar <vimleshk@marvell.com>,
        "mschmidt@redhat.com" <mschmidt@redhat.com>,
        "egallen@redhat.com" <egallen@redhat.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh B Edara <sedara@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Satananda Burla <sburla@marvell.com>,
        Abhijit Ayarekar <aayarekar@marvell.com>
Subject: Re: [EXT] Re: [net PATCH] octeon_ep: fix tx dma unmap len values in
 SG
Message-ID: <20230912194516.GN401982@kernel.org>
References: <20230911092306.2132794-1-srasheed@marvell.com>
 <20230911180113.GA113013@kernel.org>
 <PH0PR18MB473404EA35ADAC222C9EB68FC7F1A@PH0PR18MB4734.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR18MB473404EA35ADAC222C9EB68FC7F1A@PH0PR18MB4734.namprd18.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 06:37:46AM +0000, Shinas Rasheed wrote:
> Hi Simon,
> 
> This change is required in octep_iq_process_completions, as given in the patch, since the scatter gather pointer lengths arrive as big-endian in hardware.

Hi,

yes, I see that. And sorry for asking such a silly question.
But what I meant to ask is, if the change is also needed in
octep_iq_free_pending()?

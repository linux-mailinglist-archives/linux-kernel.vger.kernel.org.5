Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB41E7FB08E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbjK1DCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 22:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbjK1DCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 22:02:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC9F10CC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 19:02:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E42C433CA;
        Tue, 28 Nov 2023 03:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701140543;
        bh=jjjxMjmEbU3Pkl9GYKm1Qg0uq2791T4WlUMI7FS8u0k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KGS5RBhhvx2O298BY1FJCYbxlmRZfbtr1cJKj1PFJxuKzWSFPlNde1pKOFYQEDFR/
         j6umy5bIzl068wZBopv30maHFqAoIM6qRYEl6rksm4adz4/huIMhCtJ/la4a6luiwY
         rZfoHIxXZTKMoAqLkOoRVNNI1BXDbvuwdfxg9KZlOaFHdOmNpHCcEE2P55jO3XzwkF
         0OrwJXvA6GNzPf/KoNjNoKR7JLPbKbjOsUZJbJmeLncR7pFyqvUA9IIWW9t8fHbvlx
         trKDmy/RR/lHYWSmIgsJdJrYeu+b1+N7qEZI9Za8UF5w08qV69ntDdvJYjOADIzhmC
         /EcZGRzgi+eNQ==
Date:   Mon, 27 Nov 2023 19:02:22 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Subbaraya Sundeep <sbhatta@marvell.com>
Cc:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <hkelam@marvell.com>
Subject: Re: [PATCH net] octeontx2-af: Check return value of nix_get_nixlf
 before using nixlf
Message-ID: <20231127190222.293afaec@kernel.org>
In-Reply-To: <1700930098-5483-1-git-send-email-sbhatta@marvell.com>
References: <1700930098-5483-1-git-send-email-sbhatta@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2023 22:04:58 +0530 Subbaraya Sundeep wrote:
> If a NIXLF is not attached to a PF/VF device then
> nix_get_nixlf function fails and returns proper error
> code. But npc_get_default_entry_action does not check it
> and uses garbage value in subsequent calls. Fix this
> by cheking the return value of nix_get_nixlf.
> 
> Fixes: 967db3529eca ("octeontx2-af: add support for multicast/promisc packet replication feature")

You need to run the patch thru scripts/get_maintainer,
here you missed CCing Naveen, who authored 967db3529eca.
Also lcherian@marvell.com and jerinj@marvell.com
LMK if these people are no longer at marvell, I can add their
addresses to our ignore list.

Same goes for the pauseparam patch, you'll need to repost the two.
-- 
pw-bot: cr

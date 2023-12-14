Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532928123DE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 01:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442766AbjLNA2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 19:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234121AbjLNA2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 19:28:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BFD10A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 16:28:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92049C433C8;
        Thu, 14 Dec 2023 00:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702513736;
        bh=tQFwrDCOk2a2q/qZ8qSubMnw90hcJ8c+fZRXDcJTQnQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BOrmA2DETPhEo6BqgDyhgelgOXer2LOk5wlznPX5fq2pKPtg/rOzY95+ywP/lofbD
         XA/fl4wEoI/vI18t9RiZ7FRG/OtxjrN1ao+WEEeTWUt7gA9R7FUxk//dHeQrs9vqWX
         0TmIgQQq1fYZU0vW17gfI9r42EKYlRMWhTe1QLxzAJcaR4bzGCJRhx5glQlEPA+sc9
         bbXrxMSWfOa6Fjq103NsnxU8AfxU01wHfjyDWoILJPYd63Z0BpYkSeddJhVBpk0FXq
         iVLtzKf2GQwP1p2dNLFwTP/uMhym2lgb4zFlucctpjIHHPhRxXf8AqK1fUB3zaI8q5
         8JrCl/zH62+og==
Date:   Wed, 13 Dec 2023 16:28:54 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Tony Lu <tonylu@linux.alibaba.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Ahelenia Ziemia'nska <nabijaczleweli@nabijaczleweli.xyz>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH RESEND 06/11] net/smc: smc_splice_read: always request
 MSG_DONTWAIT
Message-ID: <20231213162854.4acfbd9f@kernel.org>
In-Reply-To: <ZXkNf9vvtzR7oqoE@TONYMAC-ALIBABA.local>
References: <cover.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
        <145da5ab094bcc7d3331385e8813074922c2a13c6.1697486714.git.nabijaczleweli@nabijaczleweli.xyz>
        <ZXkNf9vvtzR7oqoE@TONYMAC-ALIBABA.local>
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

On Wed, 13 Dec 2023 09:48:47 +0800 Tony Lu wrote:
> Please add correct tag, for this patch, IIUC, it should be a fix, and
> you need add [PATCH net].

I was wondering who's expected to take this. We (netdev/net maintainers)
didn't even get CCed on all the patches in the series.
My sense is that this is more of a VFS change, so Al / Christian may be
better suited to take this?

Let's figure that out before we get another repost.

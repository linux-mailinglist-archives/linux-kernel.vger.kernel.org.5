Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9667FF737
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345784AbjK3Qyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjK3Qyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:54:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D9ED7D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:54:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499A9C433C8;
        Thu, 30 Nov 2023 16:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701363290;
        bh=49qhqgGAf1il4MSpBynBgZFH+miXfZEwpG76uLbPmaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Np6BJ4vxXm6HT8i2fZ9urPkjpE7U+PZf1nbMqbgnst4FDTsNisnm6s8tLoje2SPQJ
         qMgzClrZSmMcq99U6JT0NDlzBr9Sb+wPbjaZwcPVLKoLEPLxKQfWate2/Uj51/wp0O
         q3u+kP0EwP+JVZqi0L/q1ake8Nl7g4Nor5E+QjjlCX6yAmEcdsOiGtyxomt2Nhr9JE
         lcC+AldJJLiMdMWt+pIcimlgAyOPfX5FkopqSC6Ykntf0ih4rAt7PmTKqjd5/mEZmo
         aybKPIfqCQbttV/SHLkdAHFsER7sfu31yRAwnKGUMrvlfqIHdozZGZY15fqPlP5pl6
         kAy+zh7PIKeAA==
Date:   Thu, 30 Nov 2023 16:54:44 +0000
From:   Simon Horman <horms@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lcherian@marvell.com,
        jerinj@marvell.com, wojciech.drewek@intel.com
Subject: Re: [net-next PATCH v5 2/2] octeontx2-pf: TC flower offload support
 for mirror
Message-ID: <20231130165444.GF32077@kernel.org>
References: <20231130034324.3900445-1-sumang@marvell.com>
 <20231130034324.3900445-3-sumang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130034324.3900445-3-sumang@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 09:13:24AM +0530, Suman Ghosh wrote:
> This patch extends TC flower offload support for mirroring ingress
> traffic to a different PF/VF. Below is an example command,
> 
> 'tc filter add dev eth1 ingress protocol ip flower src_ip <ip-addr>
> skip_sw action mirred ingress mirror dev eth2'
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


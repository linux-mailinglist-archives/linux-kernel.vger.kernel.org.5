Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9D377F198
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 09:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348662AbjHQH6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 03:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348642AbjHQH6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 03:58:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB55A6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:58:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C24B760E06
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FD5C433C7;
        Thu, 17 Aug 2023 07:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692259081;
        bh=r+ro+CqKpsAgFNKHrNlF2OCrl6EMwVsVdSb3bupxn1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oXf6OOPh1GRQOzq0QXfA2v+iTS1wiLjB8lWA7c6azvJbyao2N3mgg938d5Mwi+9Ba
         FoJjHkGZq3Xe4Rz/REAZ0IPfOKcWv4jrLJlvi2aXAZi+ePcbLmPpsLGgDkXZ3nOjZf
         wMVKohY7Mj1aLxaJ0gYl7MiAif1WdwAc6PmlgE+yoPmIwLxm4hTBxMJMef4Jgu1W7A
         WxKVuxy9jQr2mRz4YgbodHP3lIB4hdluqbVcGGtJJYzVxSe8Wb3d3yw/DfLgOHGdD9
         y3HM47eYmyJhm+YgilEODLGaJnXguGKPolOIjBgRPrv4LUfe8Bu5W7O3Sm5lZTJyL0
         Vbny0qbB39eFw==
Date:   Thu, 17 Aug 2023 10:57:56 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Hariprasad Kelam <hkelam@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, sgoutham@marvell.com,
        gakula@marvell.com, jerinj@marvell.com, lcherian@marvell.com,
        sbhatta@marvell.com, naveenm@marvell.com, edumazet@google.com,
        pabeni@redhat.com
Subject: Re: [net Patch] octeontx2-af: SDP: fix receive link config
Message-ID: <20230817075756.GC22185@unreal>
References: <20230817063006.10366-1-hkelam@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817063006.10366-1-hkelam@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 12:00:06PM +0530, Hariprasad Kelam wrote:
> On SDP interfaces, frame oversize and undersize errors are
> observed as driver is not considering packet sizes of all
> subscribers of the link before updating the link config.
> 
> This patch fixes the same.
> 
> Fixes: 9b7dd87ac071 ("octeontx2-af: Support to modify min/max allowed packet lengths")
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7093F7A99AB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjIUSQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjIUSQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:16:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200518610F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:37:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E63CC4E752;
        Thu, 21 Sep 2023 14:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695305437;
        bh=8DU895BVITKTTvymEWRzE9Sk1uN+QLlJTB0x6HTf/VI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X8E1MnvB3YYqlO4zctA/yPpB7HqtuhDkokA/y2B7rIrdWklp2mJJ4Al7isgvuuEGh
         czxP5Mm9G+nf3dUk529m5qXcFz7vBCPbdGuhQaR8D8FERL5meV8wZlTfFXbJtnAiwC
         zmZlstf/6HvMJsmzXezjbnY8HR9dj7RPS9eIWG0z47lPFOOMs+G0iGDt0gXOX0YKt3
         gyy9aax9HME8cahkQkhOohXz4qVR/rRdmw5TVWdyTZjOEPokFdasDSoMRFh1q3bRh9
         D/uiuyKSpASrH3xzJEcfrnkG7Lw+VhTyvRUJ/Kmz5i2SSHlK8h8QcEKh6MepwNMnxD
         gLO2mmOesFSXA==
Date:   Thu, 21 Sep 2023 15:10:25 +0100
From:   Simon Horman <horms@kernel.org>
To:     Hariprasad Kelam <hkelam@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, sgoutham@marvell.com,
        gakula@marvell.com, jerinj@marvell.com, lcherian@marvell.com,
        sbhatta@marvell.com, naveenm@marvell.com, edumazet@google.com,
        pabeni@redhat.com
Subject: Re: [net-net Patchv2] octeontx2-pf: Tc flower offload support for
 MPLS
Message-ID: <20230921141025.GN224399@kernel.org>
References: <20230919141832.5931-1-hkelam@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919141832.5931-1-hkelam@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 07:48:32PM +0530, Hariprasad Kelam wrote:
> This patch extends flower offload support for MPLS protocol.
> Due to hardware limitation, currently driver supports lse
> depth up to 4.
> 
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> ---
> v2 * instead of magic number 0xffffff00 use appropriate mask OTX2_FLOWER_MASK_MPLS_NON_TTL

Assuming this is for net-next, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

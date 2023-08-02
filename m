Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB1876D1DE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbjHBP0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbjHBP00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:26:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14B6423B;
        Wed,  2 Aug 2023 08:23:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E53E6186B;
        Wed,  2 Aug 2023 15:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81936C433C7;
        Wed,  2 Aug 2023 15:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690989837;
        bh=Zu3eb4D+Sy8IqrzR6uy0ZGNkiAJzPj6+/YJRPNDNgrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gQvFB1gGB11rznAsCy+ANpuFzhCOrDwnKHDicTZqM3N0Dk1rcex2NgY6hiClsM8iM
         wVx45gdDSVbeYVkRq4sVhqOTqMLrulQzT3EhXMW0dtbWBHcI2hLlC5eZOniDg4Sjpr
         PxbKifbw9y0B8lw+hNTtPyKOi2WNjTWsj2qaZoMu0fWlIdmzApUlXe2J/8YI5i4rf4
         NAxFaNqTyM3sSg+z80PWxPjGbyuKtyreyCs+dcLitoz0y6DyR1/CPQFkYKbCre7I8Q
         8372h82JoQ+Kuc/aqZeOoxPsCQR8zsEq6PXHzl0d46OT6/WMu6xtZk3ul/8LjIVyyM
         9BlS1bvasXslA==
Date:   Wed, 2 Aug 2023 17:23:53 +0200
From:   Simon Horman <horms@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/4][next] i40e: Replace one-element array with
 flex-array member in struct i40e_section_table
Message-ID: <ZMp1CdK04+VYip0R@kernel.org>
References: <cover.1690938732.git.gustavoars@kernel.org>
 <ddc1cde5fe6cb6a0865ae96d0d064298e343720d.1690938732.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddc1cde5fe6cb6a0865ae96d0d064298e343720d.1690938732.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 11:06:30PM -0600, Gustavo A. R. Silva wrote:
> One-element and zero-length arrays are deprecated. So, replace
> one-element array in struct i40e_section_table with flexible-array
> member.
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/335
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


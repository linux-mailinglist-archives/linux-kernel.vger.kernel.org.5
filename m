Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A249801DDB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 17:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbjLBQsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 11:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBQsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 11:48:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE3C11C
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 08:48:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD44C433C9;
        Sat,  2 Dec 2023 16:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701535709;
        bh=DnZEzNXP9hV68Bv4xg8L4T2Cgy7MhrlHkGJzKWd0Rog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SZoOTDXNOwfGy+XbS4lGBQnlNtfStPpSe6XOuqQbxnbXDAUBoZaxsBOXb2D0e9dmu
         C7p8JBEBYJRi0f0bK+IiWqwRZivi4i7Yep2WYel8lRjn8pg/WNx16abD/9vaSwAyAR
         k4GatGF7Xw7DiyvOAZMGPkwt6A+K+y//RaCLR9ncjQMGdaNL+aqaolGYgZJKoIem/6
         fMHcyTIbpba7xUZLqzio6tpm7HN3f4iXQsM8BLAQs6HGWp7wxz0PXN6ghbQEEtNMDe
         NZa3CQKerGMXmPiMF4YfSgJAGp7mYigBA8NEINbq3X72XTGMZRY5/a/Q6TV9VTNUxc
         NDJVm2GW1LVYQ==
Date:   Sat, 2 Dec 2023 16:48:24 +0000
From:   Simon Horman <horms@kernel.org>
To:     Ivan Vecera <ivecera@redhat.com>
Cc:     netdev@vger.kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH iwl-net] i40e: Fix ST code value for Clause 45
Message-ID: <20231202164824.GA50400@kernel.org>
References: <20231129161711.771729-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129161711.771729-1-ivecera@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 05:17:10PM +0100, Ivan Vecera wrote:
> ST code value for clause 45 that has been changed by
> commit 8196b5fd6c73 ("i40e: Refactor I40E_MDIO_CLAUSE* macros")
> is currently wrong.
> 
> The mentioned commit refactored ..MDIO_CLAUSE??_STCODE_MASK so
> their value is the same for both clauses. The value is correct
> for clause 22 but not for clause 45.
> 
> Fix the issue by adding a parameter to I40E_GLGEN_MSCA_STCODE_MASK
> macro that specifies required value.
> 
> Fixes: 8196b5fd6c73 ("i40e: Refactor I40E_MDIO_CLAUSE* macros")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Thanks Ivan,

I agree with your analysis and this fix looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


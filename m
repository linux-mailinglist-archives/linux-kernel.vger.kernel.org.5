Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24EA7D7174
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 18:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbjJYQIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 12:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbjJYQI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 12:08:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843D7B8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 09:08:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0623C433C7;
        Wed, 25 Oct 2023 16:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698250106;
        bh=qujSkRF7+AONGoOyzL5iEs4HyhHB1A7/KwcVxpI/2zg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hhe4jh7N3pSu+gEqdcyo7MNZVayhegtdhvTp999RtA/HrfW08chTo4Jn4dOi2LsGE
         V6BeYiJ12107KrejTtMO4sqS+Ggb+/Mv3Cqs2bKxy4JUDJ7/RHXr1xFsMKHd+cuOKN
         JEbdfCMnY+ipAb6YmSB9DIA+5NTYXYE4ho6tXpX4wRm2LaoUqCdBrX8SuyMmWslUqV
         cM2NX5WohOLtXxOVHn4uOrbHOl/zIUasH2D1G4libVed1KbRiFdRv7Wkr5BlTfTjLg
         cpGWVBwkPc/NczjX/MQ+xHLReVfTXxZeib+Klzj1PqYBrnrIqs9ob7sKG2pzZaqOti
         2nva9RTu3q+qg==
Date:   Wed, 25 Oct 2023 17:08:18 +0100
From:   Simon Horman <horms@kernel.org>
To:     Ivan Vecera <ivecera@redhat.com>
Cc:     netdev@vger.kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Catherine Sullivan <catherine.sullivan@intel.com>,
        Anjali Singhai Jain <anjali.singhai@intel.com>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] i40e: Fix wrong check for I40E_TXR_FLAGS_WB_ON_ITR
Message-ID: <20231025160818.GJ57304@kernel.org>
References: <20231019135342.1209152-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019135342.1209152-1-ivecera@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 03:53:42PM +0200, Ivan Vecera wrote:
> The I40E_TXR_FLAGS_WB_ON_ITR is i40e_ring flag and not i40e_pf one.
> 
> Fixes: 8e0764b4d6be42 ("i40e/i40evf: Add support for writeback on ITR feature for X722")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Thanks,

I agree that I40E_TXR_FLAGS_WB_ON_ITR is consistently used
as a i40e_ring flag, other than the case that is corrected by this patch.

I also agree that the problem was introduced by the cited commit.

Reviewed-by: Simon Horman <horms@kernel.org>

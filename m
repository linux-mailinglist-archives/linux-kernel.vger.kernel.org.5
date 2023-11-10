Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091E67E7E4A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345860AbjKJRnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbjKJRl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:41:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6988446EE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 09:31:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01DEC433C7;
        Fri, 10 Nov 2023 17:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699637517;
        bh=9S4+7npXA7Vr3v5S6ByF8ht9SKpSkLnhmp75JHaFpDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A34D4Kg3ovovfu7SLkzb/2JvAWSCHLPdy5z5OH0rZ35L8xuVt5DuDqHtxuHZ4jG7A
         KaXeUhfeT2wqmwhVsk0+/yalpiapqEU6zGSQNa5FzJqZveevon0j0nlFOEWrWH6QHD
         6+0gtoNzyM1/g1sZU58GjtIUmQZr1ZNI0iBz0i35MsZe80hlGm7Sy9mXrSX0lA7PO1
         TYwbPPvf38XUZWow2Pv59xd9vaxG1wxLZBn2ZNC+UKiwt9gZazeta6Z765kC5j6kKN
         XuG1JQpi3sJ4V0sPFtAUDF77WyGHd80sTJArqvjV3F09DmhqLj46uu62+EqJNZ7IHX
         oQok3IuJFQEVQ==
Date:   Fri, 10 Nov 2023 17:31:51 +0000
From:   Simon Horman <horms@kernel.org>
To:     Johnathan Mantey <johnathanx.mantey@intel.com>
Cc:     netdev@vger.kernel.org, sam@mendozajonas.com, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] ncsi: Revert NCSI link loss/gain commit
Message-ID: <20231110173151.GA649059@kernel.org>
References: <20231109205137.819392-1-johnathanx.mantey@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109205137.819392-1-johnathanx.mantey@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 12:51:37PM -0800, Johnathan Mantey wrote:
> The NCSI commit
> ncsi: Propagate carrier gain/loss events to the NCSI controller
> introduced unwanted behavior.
> 
> The intent for the commit was to be able to detect carrier loss/gain
> for just the NIC connected to the BMC. The unwanted effect is a
> carrier loss for auxiliary paths also causes the BMC to lose
> carrier. The BMC never regains carrier despite the secondary NIC
> regaining a link.
> 
> This change, when merged, needs to be backported to stable kernels.
> 5.4-stable, 5.10-stable, 5.15-stable, 6.1-stable, 6.5-stable
> 
> Fixes: 3780bb29311e ncsi: Propagate carrier gain/loss events to the
> CC: stable@vger.kernel.org
> Signed-off-by: Johnathan Mantey <johnathanx.mantey@intel.com>

Hi Johnathan,

thanks for your patch.
Some minor feedback from my side.

1. The correct format for the tag above is:

   Fixes: 3780bb29311e ("ncsi: Propagate carrier gain/loss events to the NCSI controller")

2. I think it is usual to format the subject and commit messages for
   revert commits a bit like this:

   Subject: [PATCH net vX] Revert "ncsi: Propagate carrier gain/loss events to the NCSI controller"

   This reverts commit 3780bb29311eccb7a1c9641032a112eed237f7e3.

   The cited commit introduced unwanted behavior.

   The intent for the commit was to be able to detect carrier loss/gain
   for just the NIC connected to the BMC. The unwanted effect is a
   carrier loss for auxiliary paths also causes the BMC to lose
   carrier. The BMC never regains carrier despite the secondary NIC
   regaining a link.

   ...

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C3A7BDE7B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346544AbjJINTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376982AbjJINNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:13:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D84010A
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 06:13:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D33C433C9;
        Mon,  9 Oct 2023 13:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696857223;
        bh=LKHwPe31kWon9Rwjc97tFZkPtm2/8aB5Mh5don3lBPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q1s1ld40p5RgJPzabs1hrNV3D/sRHtWaqMNF1Da4ircj0KXYuIogoISIzihL/ZknS
         pFGrf9Gc5/v7psrcI8cTCYG1xfKbTTBr7rf0vd5UR4OPr8HlTgKFu8cYFIoi+pR8gt
         UZccyUDy9+ZslEb/iL25VDSu96NEW1Cf2e8VcKpXTbp2ZMB0R00uPjTFR9xpMmblry
         xJkcEGyqDdLpRwZLQTmg4UDaKSYYBi4989c7af9+tnVK9b91O/s4iFf6vU3XBIZlRe
         NUZZkkKenIwtSUn/bePfhltXDJi7aYILx46dDj/Kdc3PEe1YY/GLch+ixFL1eiIjIa
         GKZPfA4N5tXsg==
Date:   Mon, 9 Oct 2023 15:13:40 +0200
From:   Simon Horman <horms@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Chas Williams <3chas3@gmail.com>,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atm: fore200e: Drop unnecessary of_match_device()
Message-ID: <ZSP8hDuWuJg7qUSf@kernel.org>
References: <20231006214421.339445-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006214421.339445-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 04:44:21PM -0500, Rob Herring wrote:
> It is not necessary to call of_match_device() in probe. If we made it to
> probe, then we've already successfully matched.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

I agree that the check is redundant.
And that with it removed, the forward declaration of fore200e_sba_match
is no longer needed.

Minor nit: I assume the target tree is net-next.
           Ideally that would be specified.

	Subject: [PATCH net-net] ...

Reviewed-by: Simon Horman <horms@kernel.org>

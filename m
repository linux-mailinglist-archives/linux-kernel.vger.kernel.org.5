Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729C8800ACB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378805AbjLAMWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378790AbjLAMWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:22:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62997D48
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 04:23:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B293DC433C7;
        Fri,  1 Dec 2023 12:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701433380;
        bh=h06/4p1GZzaajczTIM5HZpG3PzVjvySvL9yjyPOr2No=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PDpsz72tyQHBZLXGkq3eKdNAOh3JKY370uKvEIiI97rNlCWa1YvUVyHIXgZUfJSJu
         R6TvgsEW9a+lDZRm1+GvG0h9mm+MvB7bbs1jFTj6/Kov1Rs5aVPddZulGfRnmXDDIj
         Y9+dXvYDmwyjGKqxO5Ob4wD/S3+SiZfZONOAJnC4=
Date:   Fri, 1 Dec 2023 12:22:57 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jorge Ramirez-Ortiz <jorge@foundries.io>
Cc:     ulf.hansson@linaro.org, linus.walleij@linaro.org,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCHv3] mmc: rpmb: fixes pause retune on all RPMB partitions.
Message-ID: <2023120139-untried-unholy-456e@gregkh>
References: <20231201100527.1034292-1-jorge@foundries.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201100527.1034292-1-jorge@foundries.io>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 11:05:27AM +0100, Jorge Ramirez-Ortiz wrote:
> When RPMB was converted to a character device, it added support for
> multiple RPMB partitions (Commit 97548575bef3 ("mmc: block: Convert RPMB
> to a character device").
> 
> One of the changes in this commit was transforming the variable
> target_part defined in __mmc_blk_ioctl_cmd into a bitmask.
> 
> This inadvertedly regressed the validation check done in
> mmc_blk_part_switch_pre() and mmc_blk_part_switch_post().
> 
> This commit fixes that regression.
> 
> Fixes: 97548575bef3 ("mmc: block: Convert RPMB to a character device")
> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> Cc: <stable@vger.kernel.org> # v6.0+

Why only 6.0 when the "Fixes:" tag goes back to a 4.14 commit?

thanks,

greg k-h

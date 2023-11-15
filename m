Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67767EBF5D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 10:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbjKOJVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbjKOJVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:21:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31BA116
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 01:21:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FABC433C7;
        Wed, 15 Nov 2023 09:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700040088;
        bh=YSG65mEwUsCzKp+XWir268MP8D6kMHKJTS4saUD+Jn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NmJpyZYGAGemaFpCxUSUHh1i4xfKqtEFvhp6NkPsroYrkJhbeOqtuLnGsdnlw6I3l
         EruFYLCLblejqHVsPWY1KuJsm1pQCLVEMlU/HacH+vOYm1GSUpPM61LR8aT8AoVzI2
         6iWySZCwbEwSpz6v7MDz4TG2lUM5TN4lMpDybsk+ySXrGOGax+MAts+Lhf41FCjdwM
         7GYAVRhevwZMpTFu1aIsUAxpWgtUcIYekl5WDk7S7pHIZ1jZeoVCIYnHFFbZb1BsJZ
         gIgeznV9fI/C0alZfSd0QVNNlT4j30PWYuuwqzPj1OKUkexjmf/KPJHR7a6nF6f6ZW
         BAaAQyBY7IlaA==
Date:   Wed, 15 Nov 2023 09:21:23 +0000
From:   Simon Horman <horms@kernel.org>
To:     Kunwu Chan <chentao@kylinos.cn>
Cc:     anthony.l.nguyen@intel.com, davem@davemloft.net,
        edumazet@google.com, intel-wired-lan@lists.osuosl.org,
        jeffrey.t.kirsher@intel.com, jesse.brandeburg@intel.com,
        kuba@kernel.org, kunwu.chan@hotmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, shannon.nelson@amd.com
Subject: Re: [PATCH iwl-next] i40e: Use correct buffer size
Message-ID: <20231115092123.GI74656@kernel.org>
References: <20231113093112.GL705326@kernel.org>
 <20231115031444.33381-1-chentao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115031444.33381-1-chentao@kylinos.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 11:14:44AM +0800, Kunwu Chan wrote:
> The size of "i40e_dbg_command_buf" is 256, the size of "name"
> depends on "IFNAMSIZ", plus a null character and format size,
> the total size is more than 256, fix it.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> Suggested-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for the update.

There is no need to repost because of this, but in future please keep in
mind that revised patches should:

1. have a revision number, e.g. v2

   Subject [PATCH v2 iwl-next] ...

2. Have some of revision information below the scissors (---)

   v2
   - Updated size calculation to use IFNAMSIZ and izeof(i40e_dbg_command_buf)

3. Be a new thread, as opposed to a reply to an existing thread.

Link: https://docs.kernel.org/process/maintainer-netdev.html#changes-requested

The above notwithstanding, this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


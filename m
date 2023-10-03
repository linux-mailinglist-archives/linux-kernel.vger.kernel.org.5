Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D9E7B6814
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240499AbjJCLgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240493AbjJCLgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:36:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48B1A7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 04:36:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C18C433C8;
        Tue,  3 Oct 2023 11:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696332997;
        bh=EOAx/Sls7moMrznZ9XdCubZYS0GeC4469Z6iTVQkG5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hTR/wtxgPnnv4AkPLphIGAtsECUWlhwWMSdwuyYIMpOqWTZIl53yxziqz7gmjoH9Y
         own6UBMKcIUYzONnRgwHodskvkx0qYnK62qwSKHVYpv8jlin0Ew1+7rw3BCo96XUCG
         FSzq2/6osEjrlnpIVpViibYxo5xuvVVYNh2lxFwoci9BF2fGUVux9Qvo/VpiBbZDO7
         m3q/jyXLWVNpeEklgVl7SRmQXY8bwhvh+YFOi7Lm637RaMFsca2Cj0iP3mCGcJuPzw
         n8jnh14xm4KdKPjr+qAwboSEFshe5jou/z/gj8H8PntmOU4UbiKm8amAdTIvAg/+W0
         Cva8UlIRXxbrw==
Date:   Tue, 3 Oct 2023 13:36:33 +0200
From:   Simon Horman <horms@kernel.org>
To:     Moshe Shemesh <moshe@nvidia.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Jiri Pirko <jiri@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] devlink: Hold devlink lock on health reporter dump
 get
Message-ID: <ZRv8wZwVLbdrUafr@kernel.org>
References: <1696173580-222744-1-git-send-email-moshe@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696173580-222744-1-git-send-email-moshe@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 06:19:40PM +0300, Moshe Shemesh wrote:
> Devlink health dump get callback should take devlink lock as any other
> devlink callback. Add devlink lock to the callback and to any call for
> devlink_health_do_dump().
> 
> As devlink lock is added to any callback of dump, the reporter dump_lock
> is now redundant and can be removed.
> 
> Fixes: d3efc2a6a6d8 ("net: devlink: remove devlink_mutex")
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


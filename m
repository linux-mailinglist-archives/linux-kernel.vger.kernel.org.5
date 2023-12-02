Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6018A801C74
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 12:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjLBLdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 06:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBLdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 06:33:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D705FF0
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 03:34:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25429C433C8;
        Sat,  2 Dec 2023 11:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701516840;
        bh=KEUGCLOiwFkgMJXRlyG+oUNJO9xiK0lczX8NYwcUXKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FyXjgZb6IG9Y+hcPdzsjFrlRltKq+ibpmj8imqwkpbGixvOngMaMtkzv+u4cZZbl4
         nVIeDGSiwZeK0DACYYSJYLvrmeuXoU6Cp4mfA99Pfv4FfnJsK7rs1YG+diwxv7+X36
         zmw/ge/00UFcbNOIVux0naVpiaZosX9UFqWTQ2ME=
Date:   Sat, 2 Dec 2023 12:33:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] Revert "debugfs: annotate debugfs handlers vs. removal
 with lockdep"
Message-ID: <2023120226-cytoplast-purge-bf13@gregkh>
References: <20231202114936.fd55431ab160.I911aa53abeeca138126f690d383a89b13eb05667@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202114936.fd55431ab160.I911aa53abeeca138126f690d383a89b13eb05667@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2023 at 11:49:37AM +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This reverts commit f4acfcd4deb1 ("debugfs: annotate debugfs handlers
> vs. removal with lockdep"), it appears to have false positives and
> really shouldn't have been in the -rc series with the fixes anyway.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  fs/debugfs/file.c     | 10 ----------
>  fs/debugfs/inode.c    |  7 -------
>  fs/debugfs/internal.h |  6 ------
>  3 files changed, 23 deletions(-)

Looks good, want me to take this or are you?  If you:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

thanks,

greg k-h

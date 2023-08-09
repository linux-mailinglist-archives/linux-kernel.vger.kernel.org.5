Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941E5775ECA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjHIMV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjHIMVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:21:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FF21BF0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:21:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9F38635CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 12:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80DDC433C8;
        Wed,  9 Aug 2023 12:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691583714;
        bh=8/mp+c8K0ueF8LcnfsS29bvzQH+bohf0vQ2LRiNZ/oE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NvOewq2c3RaqpBcnY1w7/A8jCAFL2pX8aZYY4dvF7sU+vX7g8Qg5vhuBpRAbrZbn9
         BdSS4//1QZu7FQf6Sdz+UxAHVKRu4FwR6yv7SelLg2TzOXFycKsRmWA6q7pLZU3xHJ
         eRfzIhL6XHj+kelK5XHO5GAAjLxmtxPu59tPqYf8=
Date:   Wed, 9 Aug 2023 14:21:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mingzai Sun <szp2017@gmail.com>
Cc:     forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: Change camel case variables to snake
 case
Message-ID: <2023080933-customs-undercoat-ba4d@gregkh>
References: <20230805035739.376502-1-szp2017@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805035739.376502-1-szp2017@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2023 at 11:57:39AM +0800, Mingzai Sun wrote:
> Change camel case to snake case.
> Issue found by checkpatch.
> 
> Signed-off-by: Mingzai Sun <szp2017@gmail.com>
> ---
>  drivers/staging/vt6655/srom.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/srom.c b/drivers/staging/vt6655/srom.c
> index ee5ca4db74dc..812964ab68c5 100644
> --- a/drivers/staging/vt6655/srom.c
> +++ b/drivers/staging/vt6655/srom.c
> @@ -49,7 +49,7 @@
>   * Parameters:
>   *  In:
>   *      iobase          - I/O base address
> - *      byContntOffset  - address of EEPROM
> + *      by_contnt_offset  - address of EEPROM

Why did you keep the unneeded "by" prefix?

thanks,

greg k-h

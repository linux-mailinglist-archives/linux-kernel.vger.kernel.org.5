Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B6E7D2295
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 12:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjJVKY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 06:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjJVKYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 06:24:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27CC97
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 03:24:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8D9C433C7;
        Sun, 22 Oct 2023 10:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697970291;
        bh=rocEYGXI/G9okpJsJE4vyG5wyCbThbR7bpXwTaR8FhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U+vuhcxP3ETlx3q42gJfPFqDUbIFHHddIqCkL3O1kk8C1lB66NWtIiVKORS2ny9WU
         MVa2Vg09sUBLZgqyOwGTW/v+yCXd0FRlX2mjoudtIsg/7N2EmUAGOYCNdzWLezSRin
         p0D2WJuvQCHq1nB6hdZe946Fu0o2lK9zoaV0xyrc=
Date:   Sun, 22 Oct 2023 12:24:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumaran.4353@gmail.com
Subject: Re: [PATCH] staging: greybus: avoid macro argument precedence issues
Message-ID: <2023102210-undead-pucker-a1f2@gregkh>
References: <20231021214840.GA6557@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021214840.GA6557@ubuntu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 02:48:40PM -0700, Nandha Kumar Singaram wrote:
> Adhere to linux coding style, added parentheses around
> macro argument 'gcam'.
> CHECK: Macro argument 'gcam' may be better as '(gcam)' to
> avoid precedence issues
> 
> Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
> ---
>  drivers/staging/greybus/camera.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
> index cdbb42cd413b..ae49e37a87e9 100644
> --- a/drivers/staging/greybus/camera.c
> +++ b/drivers/staging/greybus/camera.c
> @@ -180,9 +180,9 @@ static const struct gb_camera_fmt_info *gb_camera_get_format_info(u16 gb_fmt)
>  
>  #define GB_CAMERA_MAX_SETTINGS_SIZE	8192
>  
> -#define gcam_dbg(gcam, format...)	dev_dbg(&gcam->bundle->dev, format)
> -#define gcam_info(gcam, format...)	dev_info(&gcam->bundle->dev, format)
> -#define gcam_err(gcam, format...)	dev_err(&gcam->bundle->dev, format)
> +#define gcam_dbg(gcam, format...)	dev_dbg(&(gcam)->bundle->dev, format)
> +#define gcam_info(gcam, format...)	dev_info(&(gcam)->bundle->dev, format)
> +#define gcam_err(gcam, format...)	dev_err(&(gcam)->bundle->dev, format)

Sorry, but checkpatch is wrong here, this is not a problem at all.  Look
at what you changed and think about if the macro argument could actually
be anything other than a pointer.

thanks,

greg k-h

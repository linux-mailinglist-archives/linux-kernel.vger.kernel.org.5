Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30D67B458C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 08:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbjJAGMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 02:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbjJAGMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 02:12:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D4BA9
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 23:12:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93810C433C7;
        Sun,  1 Oct 2023 06:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696140758;
        bh=BtweuTP2ebz518qYDdqy+lEdbw9lopsAOZ3LV703vvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rrLILoeTTldQvNVlrbae0oASW9ag099oZqfzFO8AZtq+qmiJo5xrmR5TG83ll7AFd
         ge4vPxelee/TYf2wqbz+KW9sGWqQ7whSkRQD250qqlcePtbaaN3TSAhsupJl64qzt1
         ztrSNY83VInXIhH4oB9ZGBKGckezGjB7xoz4LH4g=
Date:   Sun, 1 Oct 2023 08:12:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Bergh <bergh.jonathan@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: usb: Remove unnecessary whitespace in function
 pointer declaration
Message-ID: <2023100116-headscarf-dreaded-cf8e@gregkh>
References: <20230930204136.62015-1-bergh.jonathan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230930204136.62015-1-bergh.jonathan@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 10:41:36PM +0200, Jonathan Bergh wrote:
> Fixed a formatting issue flagged by checkpatch where unnecessary
> whitespace was included before the parameter list in the function
> pointer declaration.
> 
> Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
> ---
>  drivers/usb/c67x00/c67x00.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/c67x00/c67x00.h b/drivers/usb/c67x00/c67x00.h
> index a4456d0fffa9..3673357818b4 100644
> --- a/drivers/usb/c67x00/c67x00.h
> +++ b/drivers/usb/c67x00/c67x00.h
> @@ -193,7 +193,7 @@ struct c67x00_sie {
>  	/* Entries to be used by the subdrivers */
>  	spinlock_t lock;	/* protect this structure */
>  	void *private_data;
> -	void (*irq) (struct c67x00_sie *sie, u16 int_status, u16 msg);
> +	void (*irq)(struct c67x00_sie *sie, u16 int_status, u16 msg);

Same comment as on the other patches, subject line is incorrect, and why
do this?

thanks,

greg k-h

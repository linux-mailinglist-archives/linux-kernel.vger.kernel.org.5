Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CC57C6DD8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378674AbjJLMUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378604AbjJLMUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:20:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D702B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:20:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BCDC433C7;
        Thu, 12 Oct 2023 12:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697113208;
        bh=KxIO25mMnPGJiXUcEDe0q2UaKNB69a2V3bV315+yHlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hA+0LODc91SqAk39seF2yW57FG+QuIbH0kqO62tYwJMcqGlN+c717Q/nKjUNRr09v
         Q9glzmkUqJoRn5vOLyFnCWoffpX+wKp0NSSbFGnKpA/NUSJcHWH+CYCEsYFrURkHsK
         lQlIIAQeW9Qmc7O1oc0xHZyCRDCR7JEipG5Ctmro=
Date:   Thu, 12 Oct 2023 14:20:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?Q?Bart=C5=82omiej?= Konecki <bartekkonecki97@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: Alignment should match open
 parenthesis
Message-ID: <2023101250-shading-skintight-28f7@gregkh>
References: <ZSfi8nPauVatDm3E@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZSfi8nPauVatDm3E@localhost.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 02:13:38PM +0200, Bartłomiej Konecki wrote:
> Fix 2 checks reported by checkpatch.pl in axis-fifo.c
> for alignment should match open parenthesis
> 
> Signed-off-by: Bartłomiej Konecki <bartekkonecki97@gmail.com>
> ---
>  drivers/staging/axis-fifo/axis-fifo.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Any specific reason you didn't cc: the staging mailing list like
scripts/get_maintainer.pl suggested you do?

> 
> diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
> index 727b956aa231..ab758a527261 100644
> --- a/drivers/staging/axis-fifo/axis-fifo.c
> +++ b/drivers/staging/axis-fifo/axis-fifo.c
> @@ -381,8 +381,8 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
>  		 */
>  		mutex_lock(&fifo->read_lock);
>  		ret = wait_event_interruptible_timeout(fifo->read_queue,
> -			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
> -			read_timeout);
> +						       ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
> +						       read_timeout);

Does this now go over the max line length limit?  Does this patch pass
checkpatch.pl?

thanks,

greg k-h

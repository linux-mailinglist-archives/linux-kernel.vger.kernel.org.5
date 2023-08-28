Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C141F78A894
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjH1JLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjH1JLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:11:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBCCEC;
        Mon, 28 Aug 2023 02:11:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2745610A5;
        Mon, 28 Aug 2023 09:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2364C433C7;
        Mon, 28 Aug 2023 09:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693213896;
        bh=eUqeVQREvamINg0qpOLldb9GpOoBTq89jsyCq2h3JCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fbOYFG75Xe/LvyM98CE188KL/eq3TxV6V1hfnbwruqa1nrelJIyqr+W0C7tOyjXsn
         MumRrZ66hAOFnjHIonngnSQ699P9J9bBjWl/1Y4slm6UNoIfEKe+nuPO7rExm2wDVs
         eagRs4KonA1jk7mg9EpCAAbRC/nryYgpVROXwYgc=
Date:   Mon, 28 Aug 2023 11:11:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Anshul <anshulusr@gmail.com>
Cc:     richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux-alpha@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fixed formatting issues
Message-ID: <2023082801-cost-radiance-95fa@gregkh>
References: <20230828071829.64366-1-anshulusr@gmail.com>
 <2023082827-craftily-citric-06fa@gregkh>
 <CAPwwkU7+zHo2jpt+ovJDE1ca=K8AKyowyA5Z9pOFAy6iifVEwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPwwkU7+zHo2jpt+ovJDE1ca=K8AKyowyA5Z9pOFAy6iifVEwA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 01:54:41PM +0530, Anshul wrote:
> Hello Greg,
> 
> > - Your patch did many different things all at once, making it difficult
> >   to review.  All Linux kernel patches need to only do one thing at a
> >   time.  If you need to do multiple things (such as clean up all coding
> >   style issues in a file/driver), do it in a sequence of patches, each
> >   one doing only one thing.  This will make it easier to review the
> >   patches to ensure that they are correct, and to help alleviate any
> >   merge issues that larger patches can cause.
> 
> I believe that splitting the patch is not necessary in this instance since
> the changes are localized and trivial to reason about.

That's up to the maintainer to decide.

> > - You did not write a descriptive Subject: for the patch, allowing
> >   everyone, to know what this patch is all about.  Please read the
> >   section entitled "The canonical patch format" in the kernel file,
> >   Documentation/process/submitting-patches.rst for what a proper
> >   Subject: line should look like.
> 
> As per the feedback, the updated patch has incorporated the changes.

Why are you changing coding style issues in this portion of the kernel?
Do you have this hardware to test with?

Normally coding style cleanups like this are only allowed in the
drivers/staging/* portion of the kernel.  Unless you get approval from
the maintainer of the subsystem you are changing, I wouldn't work on
this as it's generally considered bad form.

> > - It looks like you did not use your "real" name for the patch on either
> >   the Signed-off-by: line, or the From: line (both of which have to
> >   match).  Please read the kernel file,
> >   Documentation/process/submitting-patches.rst for how to do this
> >   correctly.
> 
> I have verified that the Signed-off-by: line and the From: line contain the
> same content.

Your name is only 1 word?

thanks,

greg k-h

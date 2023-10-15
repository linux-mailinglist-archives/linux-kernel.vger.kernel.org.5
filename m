Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783837C99CF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 17:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjJOPim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 11:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJOPil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 11:38:41 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CFCAB
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 08:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LhxJfPnQdDLA1pwf55OjKcjy9RE5WkjM3OkEMcxoyfg=;
  b=VtXvNYIfchdFqk9ttxMwFA7AHY4rmL3jhvMH9vGZm8gxZeDB5Q57UxYA
   QBACfbHbW0wWWWXwMS3ErE7TvUtLh8fYw/DH0qrqL4Mu9hbDULUOl5Lli
   SBTBSxaDAuVWgUVXvlJMF96+xx8HrXG8JkBAFWQVVi/gIQf71QtWydZjo
   A=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,226,1694728800"; 
   d="scan'208";a="68757064"
Received: from unknown (HELO hadrien) ([87.129.180.234])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 17:38:35 +0200
Date:   Sun, 15 Oct 2023 17:38:03 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Andi Shyti <andi.shyti@linux.intel.com>
cc:     Gilbert Adikankwu <gilbertadikankwu@gmail.com>,
        gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8192u: Align descendant arguments
In-Reply-To: <ZSulKrvrrLyfnzND@ashyti-mobl2.lan>
Message-ID: <b771397b-30a0-dccd-6f4a-cf16ad2e8de0@inria.fr>
References: <ZSuhYpyYfZz5EhDB@gilbert-PC> <ZSulKrvrrLyfnzND@ashyti-mobl2.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 15 Oct 2023, Andi Shyti wrote:

> Hi Gilbert,
>
> On Sun, Oct 15, 2023 at 09:22:58AM +0100, Gilbert Adikankwu wrote:
> > Adhere to Linux kernel coding style.
> >
> > "...A very commonly used style is to align descendants to a function
> > open parenthesis" - (Excerpted from Linux kernel coding style (#2))
> >
> > Reported by checkpatch:
> >
> > CHECK: Alignment should match open parenthesis
> >
> > Signed-off-by: Gilbert Adikankwu <gilbertadikankwu@gmail.com>
>
> I don't like this commit message. Although it's correctly
> written, I think it can be improved in order to be more
> immediately understandable.
>
> Write what you did in imperative form:
>
> "Adhere to Linux kernel coding style" doesn't mean much, you can
> write
>
>   Align descendant argument to the open parenthesis as per the
>   "Linux kernel coding style" in
>   Documentation/process/coding-style.rst.
>
> Yuo tell immediately what you did and where to find the
> reference. Citing the document in the commit log, in this case,
> looks to me like an unnecessary information.
>
> Copy pasting the output of the error is a very good practice and
> you can write it as:
>
>   Mute the following checkpatch error:
>
>     CHECK: Alignment should match open parenthesis

In this case, it seems fine, but some of the checkpatch messages are a bit
verbose, and anyway the specific fix is a bit different than the
checkpatch message, so you can use your judgement about this.

julia

>
> > ---
> > v2: In the first patch I changed my commit title in the
> > email and sent it before amending it in my git tree which then changed
> > its SHA ID. I felt it might cause an issue so that is why I did a v2
> > of the patch.
>
> It's not an issue, you can do that.
>
> But I'm going to give you another piece of advice that I already
> gave in this list. Do not send patches between versions too fast.
> Reviewers need some time to review... wait some time before
> sending the v2, so that the v1 gets enough visibility. Sometimes
> reviewers correct each other, but they need time to read the
> e-mails.
>
> This way you would also avoid unnecessary noise.
>
> Andi
>
>

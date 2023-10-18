Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17BA7CD4BA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344479AbjJRHBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjJRHBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:01:01 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E23B6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 00:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TbkZi1aV2qkvgFIIp74fucItTC7Ec1qzreVXXTLwOvA=;
  b=j9jiww5bvubw9jqoHooV23bPWKXw9s3ddslRE4jgupAJGj4hUnWvemeP
   U0byhM/z4qnLiwM/4lvFd1Qtb9ZBdznsrwvlQ50sbf0fWTwgHQUh5QpII
   iJs+PRC2zzrBRMkD4d0KJKJ/rNSwJbRaV4PrKUcX7As3wE+sy20dj1A03
   Q=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,234,1694728800"; 
   d="scan'208";a="131809070"
Received: from dhcp-138-246-3-50.dynamic.eduroam.mwn.de (HELO hadrien) ([138.246.3.50])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 09:00:57 +0200
Date:   Wed, 18 Oct 2023 09:00:57 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Soumya Negi <soumya.negi97@gmail.com>
cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 1/2] staging: vme_user: Replace printk() with
 pr_*(),dev_*()
In-Reply-To: <20231018063038.GB1868@Negi>
Message-ID: <82dc1055-521d-e4d-9d91-b4cc7d8d9d3e@inria.fr>
References: <cover.1697601942.git.soumya.negi97@gmail.com> <a0579eeda5ce70f69b6bfdcbe534b9d37138096c.1697601942.git.soumya.negi97@gmail.com> <19637f96-40bc-a46b-8e7a-fa59e5e9e16@inria.fr> <20231018063038.GB1868@Negi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Oct 2023, Soumya Negi wrote:

> Hi Julia,
>
> On Wed, Oct 18, 2023 at 07:47:29AM +0200, Julia Lawall wrote:
> >
> >
> > On Tue, 17 Oct 2023, Soumya Negi wrote:
> >
> > > vme.c uses printk() to log messages. To improve and standardize message
> > > formatting, use logging mechanisms pr_err()/pr_warn() and
> > > dev_err()/dev_warn() instead. Retain the printk log levels of the
> > > messages during replacement.
> >
> > It's not possible to use the dev_ functions more often?  The pr_functions
> > don't give context information, and the message don't seem to give much
> > context information either.
> >
> > julia
> >
>
> Yes, I think there can be more dev_*() functions.
>
> Most of the dev_ that can be added are error/warning messages where the bridge's
> 'struct device' instance is accessible & can be fed to dev_ fns. Although I went
> through the VME subsystem docs, I wasn't sure if the bridge's context made sense
> to be printed with those messages. So I wrote them as pr_ functions.
>
> Should I add them and send a v2 for review?

Maybe wait a bit and see if someone else has a comment on this issue.

julia

>
> Regards,
> Soumya
>
>

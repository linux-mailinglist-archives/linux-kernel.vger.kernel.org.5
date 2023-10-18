Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EF27CD3D3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344444AbjJRGGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjJRGGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:06:50 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC54EC6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:06:48 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6934202b8bdso5614072b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697609208; x=1698214008; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0V5q09wBAssZNTSnPI9VwZLnGSrKz4v21dohqlLwCKM=;
        b=mnKOEYmiF9debi5oF1gSgKeDC6c91xCYAdSo/2+R7Zs2uO1OnpDRu32lqz3qjGSGTr
         4ICQc5D0v+RDKsXCMhtLHkubemGa+aINkRPIuoah53xow2zhJ/+D1q7E/9KA4nApWHKO
         5hCm+ZDKZT13pTP2ojmQJBOk8SyfeKtNOSsoEoRN/gmgxzhwYwgC8vzLLxdrH/v1lRc+
         rwAjboPP9pzJhi7VGlME/kWvD9PwoAmht4qXQ6vlHoj4HJfj7vHAe///F59ycPO4nqZ8
         I78pSQeGLF5KpRWt3HYCTBDag/y3vGBl5K/TvR5jkmf5O34feL0iUkTMdiXoF0ayuk+/
         yjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697609208; x=1698214008;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0V5q09wBAssZNTSnPI9VwZLnGSrKz4v21dohqlLwCKM=;
        b=qEoSZbXqT0MKZjrctkC1IVyuKHe0LqK3VTM6COx2dMM3PHFui4S37Ir8CPFnKSc7Kc
         4znkILJ/NlddRm3m9SofOYtLRJzryqqO6LxoJTeoCzOCfz95DIlhht81MVrly35aDfrE
         iMWr1cCcvYtzVHypiaLVsabXfJuH1a2YJv2ELxq0AIBm9Sd8DVYpobrMrlxTiPDOk2rJ
         8lMavyg7f6U2cfi6feD4ty1nYF8Ol/pbQMD38HA/cbDsQyRVvwOT/zve66uO5wdTMhjR
         klGXbTvnb1/gPnHrOrCavhVjsLCDVSiuzjaqqa0541x90phnf+4uLc3SqcQsNLz7AdlK
         BiWw==
X-Gm-Message-State: AOJu0YzZu7eX7Toq0p03UOJipBHoP35uZbx/Zm2hiy6vVATZAiNmq+qM
        6XY/dKIo2AMzk0yYqACzwlc=
X-Google-Smtp-Source: AGHT+IFUPRKjHqUD+X8en3uArtC/c70An4KHv4Tcz1oWSq2BhC9DYf3VVMqHEObhnsgdxtJ5b9M06A==
X-Received: by 2002:a05:6a00:15c4:b0:68f:f741:57a1 with SMTP id o4-20020a056a0015c400b0068ff74157a1mr5520627pfu.7.1697609208349;
        Tue, 17 Oct 2023 23:06:48 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id e10-20020aa7980a000000b00690c52267easm2470087pfl.40.2023.10.17.23.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 23:06:47 -0700 (PDT)
Date:   Tue, 17 Oct 2023 23:06:46 -0700
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 0/2] staging: vme_user: Replace printk's & cleanup log
 messages
Message-ID: <20231018060646.GA1868@Negi>
References: <cover.1697601942.git.soumya.negi97@gmail.com>
 <85af8b2d-6246-46c5-c6dc-582807010fa@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85af8b2d-6246-46c5-c6dc-582807010fa@inria.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Oct 18, 2023 at 07:49:22AM +0200, Julia Lawall wrote:
> 
> 
> On Tue, 17 Oct 2023, Soumya Negi wrote:
> 
> > Staging driver vme_user has a bunch of printk() calls in vme.c which
> > triggers checkpatch warnings. Remove all printk's and change them to
> > the appropriate logging mechanism i.e pr_err()/pr_warn(), or
> > dev_err()/dev_warn().
> >
> > Also, cleanup the messages further by using __func__ in the string
> > instead of function names.
> 
> "cleanup" is not actually a verb.  It's a noun.  The verb would be clean
> up.
> 
> julia
>

Hi Julia,

Will update the commit log.

Tanks,
Soumya

> >
> > This patchset fixes all checkpatch warnings like:
> >
> >     WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then
> >              dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
> > &
> >     WARNING: Prefer using '"%s...", __func__' to using 'vme_lm_get',
> >              this function's name, in a string
> >
> > Patches must be applied in order.
> >
> > Soumya Negi (2):
> >   staging: vme_user: Replace printk() with pr_*(),dev_*()
> >   staging: vme_user: Use __func__ instead of function name
> >
> >  drivers/staging/vme_user/vme.c | 175 ++++++++++++++++++---------------
> >  1 file changed, 94 insertions(+), 81 deletions(-)
> >
> > --
> > 2.42.0
> >
> >
> >

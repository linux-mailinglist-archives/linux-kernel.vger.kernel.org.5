Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A145C787DFD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbjHYCu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236404AbjHYCuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:50:22 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B441FCE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:50:20 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-34ca2fcdf9fso1699865ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692931819; x=1693536619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y07oxKzyD6NouQNFuvP7iMeRumD3C6SmckUNPVdKHuI=;
        b=Uvn0tCpDS7x4CpqXBSraVlmBEZseQr0pQXSHG+VSJNKTtYYykh44u0IY4cI18f+6iO
         ET2BOvuye9QdRqesi7FAufkxT4FYMQNd28iDXCMStKdSD8p1MLO91HNiAlQwGf2IstLQ
         8dObiLX1f/R57wEuNHjH6805Jt9ZXvPv6EmVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692931819; x=1693536619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y07oxKzyD6NouQNFuvP7iMeRumD3C6SmckUNPVdKHuI=;
        b=KrpNPrL5P4bss1YnbcfmSdmKxOjiIHKyM+s17x6iHFvgpki92jZ35m0ZYL4YvKFHVh
         BgPPSKsjxEugG0IedonaFvVcArrmGGuffdVzmrI8iuVHd5IW61v2d3fF7aIe4BgEQrYj
         HfSmJIdzbuNbGRvpDOWmn28LOawFapkFStnhg29VhkiAS6W/CObxKvBzwUBvBI9ZQNkV
         JtyVwcsHvPvpUSbGFnHDXkAnS62b2GxLkEXf1KIbqm27i1RPRX+CtiUs8rHr3JmYIZ+V
         F4Aj9hqTYn8hyrLVvZd2Ieqbaj7hiKQ2YPTGW+n1XmCFf27PLFnGnka738JXoEvn+7r3
         Gs7g==
X-Gm-Message-State: AOJu0YxAsQubh4E5VenomWAaVGLHuSmUjq7VW4czd/X8m+HBKUxlQziE
        xnsCYZV6CYKM25e0ysS3tIjoGw==
X-Google-Smtp-Source: AGHT+IG1y7uufh0ZqghTjwd9fOJmupY196QtHzD1FH3ku/72RUHiNwHSxQVydE0d+2Mb92Q7YhpX8w==
X-Received: by 2002:a05:6e02:c74:b0:34c:b3aa:b0aa with SMTP id f20-20020a056e020c7400b0034cb3aab0aamr6926435ilj.23.1692931819566;
        Thu, 24 Aug 2023 19:50:19 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id go7-20020a0566382c8700b0042ad887f705sm249214jab.143.2023.08.24.19.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 19:50:19 -0700 (PDT)
Date:   Fri, 25 Aug 2023 02:50:18 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Z qiang <qiang.zhang1211@gmail.com>
Cc:     paulmck@kernel.org, rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: rcutorture: Can not Disable RT throttling
Message-ID: <20230825025018.GE4008060@google.com>
References: <CALm+0cVvHb=Fe8kseVLesjS1d=579c7Bn5hxdiqyzBp5Z7SugA@mail.gmail.com>
 <CAEXW_YScFnFG0Y1NgFS7KGS6s9CoXJ3ZQB++6udyK38mcJ=1xg@mail.gmail.com>
 <600e1ab4-059b-4b4e-9db2-2c56ac557d3b@paulmck-laptop>
 <CALm+0cUrwYAQ=frj+S=N8s8Q4KYV6JWoU0+2E-NvaqEoFcMC7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cUrwYAQ=frj+S=N8s8Q4KYV6JWoU0+2E-NvaqEoFcMC7g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 10:30:37AM +0800, Z qiang wrote:
[..]
> > That would be difficult in built-in rcutorture testing due to the fact
> > that there is not much in the way of userspace.  I suppose we could
> > invoke the sysfs handler so as to mock up a userspace access, but that
> > might not be the most robust approach.

Yes.

> Does it mean to use filp_open() to open sched_rt_runtime_us file and
> write -1 through kernel_write() ?

I am afraid so but that might become hard to maintain in the long run. I
prefer exporting the necessary functions from RT to the kernel and just
calling those.

thanks,

 - Joel


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE73785BF8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237143AbjHWPXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237135AbjHWPX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:23:29 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C248F1733
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:23:07 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68a56401c12so2387697b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692804185; x=1693408985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4jcjq5tQMjyXZ4EekHKM/b7uQYtJc57vmlwhbh+CZDs=;
        b=ZwRBeOagas9M9sXgaQrbrm+skvTJvLhNu69cLPRzcgsfIpv1NOzgqS0jh3k5rxP+nB
         qP6nafMwRquXr33jXe7/4agKa0IaYc4wd5WQMB+zc8orq9fkOj6+8GCz36MwChD9vNkv
         G82asc5wfwJVFgCpv9ZMHcROFuJOXop99JA3doQC2109PcD471fzoudvNs4h95LjUev1
         F3qW3gLluQV6Ns8yl4ZpnK92vyJC+gxXRroCP8TrYcOKvUOww5oSI1nkhUoAyW856ipV
         vEkJYbT+gMM9nzA9LA7w4YwjVq3t+10ZhtlADNqoHWcnywXLgn4iO4LRWpJfGWH/2S6W
         0q+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692804185; x=1693408985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jcjq5tQMjyXZ4EekHKM/b7uQYtJc57vmlwhbh+CZDs=;
        b=j36irR9MyJleGNd5dWDF8r86IKpRiKzxzUMUNm0Bs6cIT7q2SE2zyJdwbfLvT7kutG
         OmDN3v6OAm4/aF/XOwLcHO8SKYnyPin2BoDSTzng0xCRRtGb+aEQvM0zrHUdPPkUVYLv
         T1XU1txCUBURiZhetYjC1TyeWAl2AVgaBxfeI0gxrUTAQqmtagAYWTH4gm6cgLYbV1jY
         +TVFDg1fe1c4Y/dLsuxn+POpUoa9QMmYr1OSF6ad4M2xJxGvrREO96hTS0wR5QagXkft
         VQ5eiwOTzvNdglWw71rUca93/3SlTJbo1YbZVHv+kkKAXF3/RcnhStHgQhQHGuq4QmDi
         iP0Q==
X-Gm-Message-State: AOJu0YxdTAqEXA40qT61HEOUeI3VtAL2tdS73YbrtjGk7k+Lguo8UaDd
        SjTE6arTwUdt76tg3gD6gz1j0Q==
X-Google-Smtp-Source: AGHT+IEiD/SBgLnjm91uUIfm5P3nzoyFIsHOxISHiMUMBgJfnBwYTYUx+bDZpBCVefCGz4SCm+RsYw==
X-Received: by 2002:a05:6a20:431c:b0:13e:1712:4c01 with SMTP id h28-20020a056a20431c00b0013e17124c01mr12683630pzk.42.1692804184763;
        Wed, 23 Aug 2023 08:23:04 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:3ae3:a477:fe1c:f18c])
        by smtp.gmail.com with ESMTPSA id i3-20020aa787c3000000b006877b0b31c2sm9889234pfo.147.2023.08.23.08.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 08:23:04 -0700 (PDT)
Date:   Wed, 23 Aug 2023 09:23:01 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Robert Nelson <robertcnelson@gmail.com>,
        Kevin Cahalan <kevinacahalan@gmail.com>
Subject: Re: [PATCH] remoteproc: core: Honor device tree /alias entries when
 assigning IDs
Message-ID: <ZOYkVec/aQSiCWxh@p14s>
References: <20230807140247.956255-1-nm@ti.com>
 <ZOULmFR51C+9kEhZ@p14s>
 <20230822201205.4csoj4kym2yhuyrf@decrease>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822201205.4csoj4kym2yhuyrf@decrease>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 03:12:05PM -0500, Nishanth Menon wrote:
> On 13:25-20230822, Mathieu Poirier wrote:
> > Hi Nishanth,
> > 
> > On Mon, Aug 07, 2023 at 09:02:47AM -0500, Nishanth Menon wrote:
> > > On many platforms, such as Beaglebone-AI64 with many remote
> > > processors, firmware configurations provided by the distributions can
> > > vary substantially depending on the distribution build's functionality
> > > and the specific remote cores enabled in that variant. Ensuring
> > > consistent udev rules mapping remoteproc nodes to constant remote
> > > proc device indices across distributions (yocto, ubuntu, debian and
> > > it's variants, ...) on a board basis can be challenging due to the
> > > various functions of these distributions. Varied device node paths
> > > create challenges for applications that operate on remote processors,
> > > especially in minimal embedded systems(initrd like) that may not
> > > have udev-like capabilities and rely on a more straightforward bare
> > > filesystem. This challenge is similar to that faced by I2C, RTC or the
> > > GPIO subsystems.
> > >
> > 
> > I'm puzzled by this patch.  I can see how using an alias can help in boards with
> > various HW configuration.  That said, and as written above, FW files for remote
> > processors can vary based on the build's functionality.  As such "remoteproc3"
> > will reference the same HW device on all distributions but the functionality
> > enacted by the FW may be different.  As such I don't see how an alias can help
> > here.  Can you provide a concrete example that highlights the benefits?
> 
> Correct - *if* remoteproc3 is the constant node reference.
> 
> To take a trivial example: We ran into this issue with:
> https://github.com/kaofishy/bbai64_cortex-r5_example/blob/main/Makefile#L28
> 
> remoteproc18 apparently changed numbering in a different build.
> 

We are going around in circles.  In the above link using an alias will
guarantee that "remoteproc18" is available but won't guarantee the
functionality enacted by the FW loaded in that remote processor, which is distro
dependent.

> If remoteproc18 remained the same between different distro builds that
> would have probably kept the userspace constant. but it does'nt. it
> dependent purely on probe order, which does'nt let userspace remain
> consistent.
> 
> Same reason and motivation to do the following:
> https://git.beagleboard.org/beagleboard/repos-arm64/-/blob/main/bb-customizations/suite/bookworm/debian/86-remoteproc-noroot.rules
> in one technique to do it - but that only works if all the distros
> follow the same udev rules - and there is no reasonable way to enforce
> that across distributions.



> 
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

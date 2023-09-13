Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCAB79EA24
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbjIMNzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbjIMNzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:55:50 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1790C19B6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 06:55:46 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-450f977a2eeso136387137.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 06:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694613345; x=1695218145; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bHOWKgoMJ5vIrHEwzYhikdH8Nfh2BsBh7d3nokFVIcY=;
        b=ZhDhUZW+KAOy7nhtesM/OAkVHi6jVsaHK+Lf9pYb5iLIuz7zqOnT8eb05mMv1OazHv
         O9zwtdABqQAYASIi9OKdfpDbYwousKroJ7QJF2nZURwpF6hD6hemHv88OIe037Irq+L2
         Dr88e4gsPHzHr0RqiyFefV14m/tVJ8z50rSDLLheOv8eI/akRLmUEqaXxRzMBy8F2Uen
         9Q72/wtOjYCYs8l6BVoBsCHN3OTZ9Ow0N9KyZjmj9EYbZiso6qah8TXNVp28j9km5Ixu
         Bs9XPMLFw94lC1xpCgKGBJdFaX4SBd5TOf8BW4tWrk18eCFmkVhzfFD6c+s7jEYjctMu
         VmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694613345; x=1695218145;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bHOWKgoMJ5vIrHEwzYhikdH8Nfh2BsBh7d3nokFVIcY=;
        b=gQ7tLKEDp0qfwLN+m3aE/teZrjXmGW3+JgT42hPyceG639CerkbLQ8/z+hsbZ03OEu
         LgIMDRKGYhXocXVeH9l8FPnte/Jgi26rndPaPtPk4DaKZ0pDDkPjo1bDrL1WXXKrExDP
         fuHvYYh++Lk2cUg0ByunFwccMue6ZNw3SpjHD7EQI3NZCUPrMtE1mj7pNtrKWSU7uoXU
         D5dnMSZxArmppwbTRK9tU6CafJP2B0Nm2IbcGxWuIapfoS3SxELY1clqhVjSMU7T0cIl
         CVWkJo2OYgrA//xwW4f/H8Ra2yE/adEBbiv0J9FeS92kNbDKVVp9xV6NRnyvCa52Zs2P
         UqGg==
X-Gm-Message-State: AOJu0YyGC3D8r9GBB/zZukttK7b6sRYIze2Q9SBEqi+Xg4I8Jabhqmg9
        ezpP76aCI1mgzdqCBh8bJzKrPXOWf+3bzX6lLALIeQ==
X-Google-Smtp-Source: AGHT+IFf5imTqug/zcRG1beR5iQXSQEFra9TlGRP6+/+gjc5RTxdHFSFJ3q0U7S4Vcw7LNDBmZUTS5F2jEkEzXHOm+M=
X-Received: by 2002:a67:e203:0:b0:44d:3bc0:f1ba with SMTP id
 g3-20020a67e203000000b0044d3bc0f1bamr2601874vsa.26.1694613345099; Wed, 13 Sep
 2023 06:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230911134633.619970489@linuxfoundation.org> <1ffe4f64-f238-859a-ab14-7559d03c4671@linaro.org>
 <CAEUSe7_XA16yZAHA+YTbJygwaUYkU5gs=FnV9BAmQRYzwgVjvQ@mail.gmail.com>
 <CA+G9fYsiWEKSV0EeU0cXsJZ3U75fbdGyCmDx07ksFMUW5jouyw@mail.gmail.com>
 <2023091233-boots-line-a3d4@gregkh> <CA+G9fYt2Jnxwvpzcd66HCqkPi6CNistHfmxQYAzX22OWHUoUSA@mail.gmail.com>
 <2023091213-awning-driveway-4671@gregkh>
In-Reply-To: <2023091213-awning-driveway-4671@gregkh>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 13 Sep 2023 19:25:33 +0530
Message-ID: <CA+G9fYtY7_-JgVizZuVJZ3RX0e3eZ3ri8AxDpkkPdP-uYfZ1ig@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/600] 6.1.53-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     jack@suse.cz, stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        Tom Rix <trix@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> > > > > For what it's worth, bisection points to 903b487b5ba6 ("udf: Handle
> > > > > error when adding extent to a file").
> > > >
> > > > I see the following commit is fixing the reported problem.
> > > >
> > > > commit 6d5ab7c2f7cf90877dab8f2bb06eb5ca8edc73ef
> > > > Author: Tom Rix <trix@redhat.com>
> > > > Date:   Fri Dec 30 12:53:41 2022 -0500
> > > >
> > > >     udf: initialize newblock to 0
> > > >
> > > >     The clang build reports this error
> > > >     fs/udf/inode.c:805:6: error: variable 'newblock' is used
> > > > uninitialized whenever 'if' condition is true
> > > > [-Werror,-Wsometimes-uninitialized]
> > > >             if (*err < 0)
> > > >                 ^~~~~~~~
> > > >     newblock is never set before error handling jump.
> > > >     Initialize newblock to 0 and remove redundant settings.
> > > >
> > > >     Fixes: d8b39db5fab8 ("udf: Handle error when adding extent to a file")
> > > >     Reported-by: Nathan Chancellor <nathan@kernel.org>
> > > >     Signed-off-by: Tom Rix <trix@redhat.com>
> > > >     Signed-off-by: Jan Kara <jack@suse.cz>
> > > >     Message-Id: <20221230175341.1629734-1-trix@redhat.com>
> > >
> > > Wait, where is this commit?  I don't see it in Linus's tree either, nor
> > > in linux-next.  Where did you find it?
> >
> > Can you find this commit id ?
> >
> > Commit id: 23970a1c9475b305770fd37bebfec7a10f263787
> > subject: ("udf: initialize newblock to 0")
>
> Yes, that is in 6.2.  Where did the id you used above come from?

While looking around for the fix commit i found this on Linux next,

$ git log --oneline next-20221226..next-20230106  -- fs/udf/inode.c
e86812bfac97e udf: Detect system inodes linked into directory hierarchy
453bc25de0a55 udf: Preserve link count of system files
6d5ab7c2f7cf9 udf: initialize newblock to 0

>
> confused,

Sorry for the confusion.

> greg k-h

- Naresh

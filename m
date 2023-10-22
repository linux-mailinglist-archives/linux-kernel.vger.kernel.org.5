Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D677D230E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 14:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjJVMDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 08:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVMDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 08:03:49 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887B9F3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 05:03:47 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-27b22de9b5bso1379795a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 05:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697976227; x=1698581027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p/eE2iwjhBbOe3VZZ3RYTaBbrjxq/R/X+GGySVAzau0=;
        b=XngoalEeX23K8ppgALXHEO5UV9tdNUIyrClZGlYQlh5aSBl+5OiB0BSVkEmV0ip/yy
         aAdqFUvGzcLrgQA5buiFLT4MRlFLwyF7CXn3Ka7myzj6r794SyxcwSW1Jr9NAWw7Z+Om
         i1mBFoxhrjehYm/9cREz7z0rMKqregu6OWgx9XmfrjT0OglZzhNqEzdSEoHFiDaGRx03
         vvDpniZarI/s+IgJeJ8aB/Mn2HOUzozDLXSCvcXtVvfkagzXBiZctMwUZDzpmUejQ08b
         PHYFd3/MKhFQatRkEDRqexkH57f8fH6V1Igy2gHeWhU7eVsRKNogEHCxaXk3u/jxQCX5
         o9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697976227; x=1698581027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/eE2iwjhBbOe3VZZ3RYTaBbrjxq/R/X+GGySVAzau0=;
        b=a9wl7v3zAjxKCNG/fyPUZEJ218RCxG7AKD4kwWrwhLca2kr/rwJLbbnJJzXiy889aF
         5fy5iQxK9CKEUR4Uz8c0yFvMmSJBNGZjUb7rGtQw4+UVMAJagSWtd9OESqpbFY7+6NZp
         Q9rKAZvw59i+ebZHhhFofvp8XWuhHPMTjidmmbQ4rmqtlmSYmZ7PR8IbtcRQrGelC+44
         R5WFPow6FIpZvJkrrNobLjrgdRHCUr27DHHRZmMXrNIOWJ5caAkVskVH3CpazZk+auu6
         KyW8+B3+dPJP1Kql/756YM6Yx7p7KqXgxmEkVKxACHM9/ySH+3SP7faazgugTXDU52Kh
         NpNQ==
X-Gm-Message-State: AOJu0YyMqxY9cQd7qv23HnfUcHkZlUBXXVuxvwimGxM4NrmDLLKcgs85
        DaahBqwhlHtKQzkiFapvV1Y=
X-Google-Smtp-Source: AGHT+IGRFz9ZInmubBn8DZsC49Gxsp+1AuFYvUY87+ZRzwqgsgTlaeyx7ImsdMRhqntoNGx1a4wq7g==
X-Received: by 2002:a17:90a:55cf:b0:27d:ba33:699b with SMTP id o15-20020a17090a55cf00b0027dba33699bmr4572377pjm.2.1697976226880;
        Sun, 22 Oct 2023 05:03:46 -0700 (PDT)
Received: from ubuntu ([122.171.143.200])
        by smtp.gmail.com with ESMTPSA id t3-20020a6564c3000000b005ac384b71cbsm3587393pgv.60.2023.10.22.05.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 05:03:46 -0700 (PDT)
Date:   Sun, 22 Oct 2023 05:03:31 -0700
From:   Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kumaran.4353@gmail.com
Subject: Re: [PATCH 3/3] staging: greybus: fixed prefer using ftrace warning
Message-ID: <20231022120331.GA3552@ubuntu>
References: <cover.1697969950.git.nandhakumar.singaram@gmail.com>
 <cade10d4b94127900a015e0b2ab94da5dd8c2c63.1697969950.git.nandhakumar.singaram@gmail.com>
 <2023102219-boat-shaky-f491@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023102219-boat-shaky-f491@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2023 at 01:19:33PM +0200, Greg Kroah-Hartman wrote:
> On Sun, Oct 22, 2023 at 03:42:26AM -0700, Nandha Kumar Singaram wrote:
> > Adhere to linux coding style. Reported by checkpatch.pl:
> > WARNING: Unnecessary ftrace-like logging - prefer using ftrace
> > 
> > Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
> > ---
> >  drivers/staging/greybus/bootrom.c | 2 --
> >  1 file changed, 2 deletions(-)
> 
> Again, subject line should have "bootrom" in there somewhere, right?
> 
> thanks,
> 
> greg k-h

Will update and share the patchset again.

Thanks,
Nandha Kumar

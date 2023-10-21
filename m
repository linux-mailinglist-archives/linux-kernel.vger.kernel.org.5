Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B647D1BEB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 11:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjJUJI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 05:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjJUJI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 05:08:28 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD1AD65
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 02:08:24 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507a0907896so2296278e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 02:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697879302; x=1698484102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4TngtiJ8wslPT+ncrEtZTiHmjc1NZD6oqFjXqbFwvgk=;
        b=bjVx3euRK9EHzn48AQArGxy1LNY34TdNcfZoP8lvGTXVAnqf/YPBcOn6vXE7cz8324
         qle4xOTAZN8UhvzkcwpSBdjmH+u4NePC9vkb9tPwr3Jqaw+Gv3tiD1hBX+tDyyFSicjc
         W3hI28a+as8Eh2cufMeidtibvQ0TXAPE/xlagUU6pClfWg4u2TdCc/AaYvwHLBB2yWvq
         2kV+HCyiH3zOuByzUZdSzmLxaqFtw6LJLsDrpk+xwinTG3iX7sWG9gLDz25J05iPeY9S
         4ujyIuFh1MX8xQGoFKItUCZXD8iapXu124Nh8jjizLr4dEAu2VmsTP6YGAHeG4O0lJMs
         IKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697879302; x=1698484102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TngtiJ8wslPT+ncrEtZTiHmjc1NZD6oqFjXqbFwvgk=;
        b=iT+/geKzpano7OeNdYwYG70FCkkPsG23YFaHEODyIlU5WK5Gakj+hfNX6BcEkc+q70
         z4Q8fwhDlp4LKcgUXynrmPh7S2X2mvZ8QEhHIqQOmlsnUZeO2EvuMDuWVpMxpeOB/Nzu
         DZHFQCsEqQFO8/xcK3BADqWxQyT45CHtg+pmmLeqHY5hC6b4uTAlTddBAjWTXRIoJOnb
         z7ejVwfZNs9aWoqkQ5h2mC6/FaSBiY4jeJzead9zNtDeelVyOePvF4vIb5bQHveGXHYJ
         axwYZgYG0Bv8MTybzEgJwrWQVbJVl6TNGSPi9iK3fAYHLX2EY/Nw/X3TU7ny8WJVP7Uv
         ZTWw==
X-Gm-Message-State: AOJu0Yy5dMIhDpu8RwfXeCVPXrz5juwjtnxnRfHKCZzJC5PeDxZwkuG4
        MJY2iibhrnejjxbXPRMQQ0yDnXZjGCM=
X-Google-Smtp-Source: AGHT+IGwh9dkJ93rMbNs/y7d88eS+miSCrd5rygw7KlZmDQTUrVXM5OwjwrvRWzac8BNKOjhfTZRTg==
X-Received: by 2002:a05:6512:3b8e:b0:502:ffdf:b098 with SMTP id g14-20020a0565123b8e00b00502ffdfb098mr3878804lfv.6.1697879302468;
        Sat, 21 Oct 2023 02:08:22 -0700 (PDT)
Received: from HP-ENVY-Notebook (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.gmail.com with ESMTPSA id o14-20020a05651205ce00b005032ebff220sm774692lfo.103.2023.10.21.02.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 02:08:22 -0700 (PDT)
Date:   Sat, 21 Oct 2023 11:08:20 +0200
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: octeon: Fix warnings due to introduction of new
 typedefs
Message-ID: <ZTOVBE4skMCbKjdr@HP-ENVY-Notebook>
References: <20231021081409.67570-1-bergh.jonathan@gmail.com>
 <2023102111-sneak-abreast-8061@gregkh>
 <ZTOS6eaygOA6nRKD@HP-ENVY-Notebook>
 <2023102108-trend-unfeeling-9b15@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023102108-trend-unfeeling-9b15@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 11:05:38AM +0200, Greg KH wrote:
> On Sat, Oct 21, 2023 at 10:59:21AM +0200, Jonathan Bergh wrote:
> > On Sat, Oct 21, 2023 at 10:32:29AM +0200, Greg KH wrote:
> > 
> > Hi
> > 
> > >  This looks like a new version of a previously submitted patch, but you
> > >  did not list below the --- line any changes from the previous version.
> > 
> > This patch is a *new* patch which replaced a previous *series* of patches
> > so it was considered a *new* standalone patch, rather than a new version 
> > of the original series. 
> 
> Not really, it's a version 2 as you are doing the same thing.

Ok, thanks
 
> > > - Your patch did many different things all at once, making it difficult
> > >   to review.  All Linux kernel patches need to only do one thing at a
> > >   time.  If you need to do multiple things (such as clean up all coding
> > >   style issues in a file/driver), do it in a sequence of patches, each
> > >   one doing only one thing.
> > 
> > This patch only addresses removal of typedefs from the declarations 
> > and fixes up the implmentations that relied on those typedefs. The previous
> > advice was to not make breaking changes across patches, so this patch 
> > represents code changes which are as atomic as possible in a single patch
> > without breaking the build. It does not mix formatting / other changes
> > with the code change. 
> 
> Please fix up one typedef at a time.

Ok
 
> thanks,
> 
> greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C96179E714
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238876AbjIMLrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235749AbjIMLq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:46:58 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD2319AD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:46:54 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c3bd829b86so25608545ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694605614; x=1695210414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t8G7CBFVeKBYWJi3/h4tOeDyucqZ1aEGQkR5n5w67CE=;
        b=etArX+lWomyHFetQeDw5gb58YLlU3OdF/Xpw1h8LwrgWiuboqrIzyNeQIeMVNuro4V
         vVkd4rhtpGSmLAUcVmADTYQbbltVvbh4d8jDV8LJQAqxtbNb0pSKiSa2gi4VWdhN+ofC
         tcRx7ej+k3ODMvoHJC1WGAl2lM9mxfKlWaDfDAYdTnreVMWXvAz659PLYHvhm66Au/Tg
         LvgjNyoJ/ADoyZLwXv63wdpQwSm2Sp+IQPmeFHU7zdZ6kfENPdvHd1R/eemEIbEzGVAT
         JfFNkL8/YCXBpY4X0tvP2D7Ix5m+SCO7081IgbypeaE6JsMy0yP33lyXhbmLxRzWKGH6
         Boaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694605614; x=1695210414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8G7CBFVeKBYWJi3/h4tOeDyucqZ1aEGQkR5n5w67CE=;
        b=kRc+Z7efzbDtSdg6r5ORukLIY6jQPaXXjMkPnG7yZHGoWkPycremienhywpDvvNM2Z
         hlTk1NZFi/79FrFZysSGyhy1Iner8AaFW0taspOYcwzWB7Ge17Yf+EdU2d/K4BVRoEso
         LE6bAbItOs5ut1gXedq5m+wT3oH/t2w7TW7Rka54BFjCFJ+kduQEc5AWGh5B4tMIq//h
         YVGoZvPT9hI6W1lA2x38H4B86VyJQgtNCZXsXmUjAYS6C9VRaEaZ39oK6gxui3Ig04dO
         OfFSTXtYy8M+heW+ODNJFKBnzn3+XV2Rk6XNo/DH0+1C88oU5oSSdeAUZKBrcrNRYH3y
         ZKcg==
X-Gm-Message-State: AOJu0YxCG6CcPpnKin66CA+5dwPUIt2VNUvGZds2LOivvPuF9Xw3tFFB
        8FsvzoKoxkMUP7o75YxBqdvgI4FR2G8=
X-Google-Smtp-Source: AGHT+IEuFaFLKsJwuEVKSOqqT8tBBTn1CG95mnBnNPn5WZFZi74cXWpTD+xF+pEYnzAuND8luPllBg==
X-Received: by 2002:a17:902:ecc8:b0:1bf:22b7:86d with SMTP id a8-20020a170902ecc800b001bf22b7086dmr3001733plh.3.1694605613617;
        Wed, 13 Sep 2023 04:46:53 -0700 (PDT)
Received: from ubuntu.myguest.virtualbox.org ([106.205.101.29])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902c3cc00b001b869410ed2sm10220458plj.72.2023.09.13.04.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 04:46:53 -0700 (PDT)
Date:   Wed, 13 Sep 2023 17:16:38 +0530
From:   Pavan Bobba <opensource206@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: vt6655: Type encoding info dropped from
 array name "byVT3253B0_"
Message-ID: <ZQGhHj0q5ISLkfzN@ubuntu.myguest.virtualbox.org>
References: <ZP8Iu+Hh8YD+VhYH@ubuntu.myguest.virtualbox.org>
 <2023091210-wok-laziness-b64e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023091210-wok-laziness-b64e@gregkh>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 03:58:32PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Sep 11, 2023 at 06:01:55PM +0530, Pavan Bobba wrote:
> > Array names starting with "byVT3253B0_" updated like below:
> > 
> > a.type encoding info dropped from names
> > b.camelcase names replaced by snakecase
> > 
> > Issue found by checkpatch
> > 
> > Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> > ---
> > 
> >  v1 -> v2: Name of the tool added in the body of explanation,
> >            which found this issue
> > 
> >  v2 -> v3: subject modified to more specific detail
> > 
> >  v3 -> v4: changelog modified as per patch submission guidelines
> > 
> 
> I see 2 v4 patches on the mailing list, sent on different days.  Which
> one is correct?
> 
> I'll drop both and wait for a v5.
> 
> thanks,
> 
> greg k-h

apologies for the confusion greg. second v4 patch i sent since 
in first v4 patch mail , you are not there in mail receipents.

anyway, i will send v5 to avoid confusion

thanks,
pavan

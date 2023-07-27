Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEAF7645BE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjG0FiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjG0Fhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:37:47 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A8F3C15
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:36:59 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbc244d307so5875385e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690436151; x=1691040951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ftumy01F0Ko1xW2hs0crQpUrNaDf+ViDOsglCguDcFA=;
        b=o209E11dTN46mx03WZNxUbOse9BjutpAW3039IRt/ufJPO3Y7r+6uX88D8cgUdon+C
         AIS1hOrTVAeyd0+477aaCPFGfgtem38oEjl+WRqT3nny8hjTe0MA7EF32bENY744LfW8
         tiq+VG6FWm4UCZmIxnVEpXfdkgMLmhfBrnKUwqmSkY5CmUYPcMuHxShbtIAhk+WiaG39
         MwHQp/EJDm7Z2BxRWu7FYZ5C/JrUf7SJ612B39gGWlB2utQ4xPqZOPSKgbtGBrht79Dj
         HagP6RPEAdgmm/gtaN5TsADrsuKApe1iO48bsb44ZI6VSmrUlwUuMa5Fel45Vk6aGBfc
         oCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436151; x=1691040951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftumy01F0Ko1xW2hs0crQpUrNaDf+ViDOsglCguDcFA=;
        b=HAxNyS2BgDSdQqr+3q4j514saG3V1dZWRpj1K5/D06T8967cLSP9RZRmZR8HoZzmrT
         7cDxCwzO8FvIN/RCHdtzwN6y6CkA/CP8kslAjcrXW9Zu/p/9ogelbJzl19aDPFVw+ZaW
         Z4CmM6MOiOhg9gURAxfL1gXpLGPl363T5Zq61TYfco9pt6fkIzvVS1mOrU1Jhz4eWU9P
         wd7pS2Ur5xKaJLh5B2A1KDwdCKj6bQR12daY3oClsIMadZepCl0ibZgZCwSxSnDoM3Ao
         8CL9Y2DGDzFDSWCpZ6LfUE8TWjbisNi2QsD6OV78Owo1dAyzS+ncyhKkBwauNwudX0VM
         0T9g==
X-Gm-Message-State: ABy/qLaqpHp7wo+HQJj8uIkMOOXS6xj7kfP9EjYuVAf2mKEg+SVlcZr0
        1Cvezw+dCwsrfljrz+8isrdZ5g==
X-Google-Smtp-Source: APBJJlEsJPQjvGo+rB2dJPNqvRvmfx49TydEw+OzOTWp5o/8mQYZWXfSc54kYmYKpjEgzau4Qg/y2A==
X-Received: by 2002:adf:ff89:0:b0:317:6b16:497e with SMTP id j9-20020adfff89000000b003176b16497emr710486wrr.42.1690436151569;
        Wed, 26 Jul 2023 22:35:51 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t4-20020a0560001a4400b003176053506fsm833310wry.99.2023.07.26.22.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:35:51 -0700 (PDT)
Date:   Thu, 27 Jul 2023 08:35:48 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Helge Deller <deller@gmx.de>
Cc:     oe-kbuild@lists.linux.dev, Marco Elver <elver@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: mm/kfence/kfence_test.c:287 test_alloc() warn: use 'gfp' here
 instead of GFP_KERNEL?
Message-ID: <7f9f8c77-044c-4c20-85ba-3c1ef4e6a358@kadam.mountain>
References: <9e72b7ea-9598-415d-bc55-f2f42b7fcb3b@kadam.mountain>
 <fea8677b-348a-dd67-4eac-12c547afa00d@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fea8677b-348a-dd67-4eac-12c547afa00d@gmx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 07:23:23AM +0200, Helge Deller wrote:
> > bc8fbc5f305aec Marco Elver     2021-02-25  282  			alloc = kmalloc(size, gfp);
> >                                                                                                ^^^
> > 
> > bc8fbc5f305aec Marco Elver     2021-02-25  283
> > bc8fbc5f305aec Marco Elver     2021-02-25  284  		if (is_kfence_address(alloc)) {
> > 8dae0cfed57357 Vlastimil Babka 2021-11-03  285  			struct slab *slab = virt_to_slab(alloc);
> > 588c7fa022d7b2 Hyeonggon Yoo   2021-06-28  286  			struct kmem_cache *s = test_cache ?:
> > 588c7fa022d7b2 Hyeonggon Yoo   2021-06-28 @287  					kmalloc_caches[kmalloc_type(GFP_KERNEL)][__kmalloc_index(size, false)];
> >                                                                                                                      ^^^^^^^^^^
> > I feel like using gfp might be correct but I'm not sure?  This code
> > is from prior to this commit.  Let's add Marco to the CC.
> 
> Since this is a test program, I assume that "GFP_KERNEL" is used intentionally
> instead of "gfp" here to check if the "kmalloc(size, gfp)" above gets the right kmalloc_caches[].
> If so, is there a way to silence the smatch warning ("mm/kfence/kfence_test.c:287 test_alloc() warn: use 'gfp' here instead of GFP_KERNEL?") ?
> But I'm not sure either, so adding Hyeonggon to the CC too...

Instead of silencing warnings, I prefer to just look at them one time
and move on.

Old warnings are included in the emails if someone touches the code
again.  The other double free warnings are an example of this.  (Except
that I never have forwarded them before because they're intentional as
part of testing kfence.)

regards,
dan carpenter

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11AD7AEA91
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbjIZKjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbjIZKjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:39:22 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1E511D;
        Tue, 26 Sep 2023 03:39:13 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c328b53aeaso74503735ad.2;
        Tue, 26 Sep 2023 03:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695724753; x=1696329553; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DqkfgDw2PK66GKZCRSP4E6cVu5Z/Fe5/oZEh2SKe/Uk=;
        b=Kay06YvlT37L2ZOGBJpObMtyMfp/X+iBIAfwnEgXWqmViJPTluWv5JZE0MBwj2+i7E
         OfFI+F9vbOb5YW4fJIYrMSq2SCHw5jpr6rsKMxVT+d92w2PGgAbkgbvWz6rEpI0dkj5q
         J2j6gNm/hKPcdGo6QAS36UVjR+1sgblhd5PJaxWd/thxsDLLEvA6WVb0+FVkTTcn1Ow6
         Ar01Czp8MYK6ueaQfMGmalTbT4zmjsDMKYgDMWmEJWt0i2nLgLHUxDvAX8/7h/L//G4d
         GDsvT4yLozZ6oeUpeHDMBsti+yJYEpu7Sp0oN40xmXG1Ip/aUPs42jCzgDtE7wTJgSct
         ooCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695724753; x=1696329553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqkfgDw2PK66GKZCRSP4E6cVu5Z/Fe5/oZEh2SKe/Uk=;
        b=H/eiZ4oUqqL9N8xM6oYK9LYvtC3KKJlgtGzG9z7uBGzF8KWQJowKMBwrGB58d6UPsg
         6OQXE7GR5hCJQVZWXTdx2TZ3yZ3M1MhRINkHAmkZPsnlaSjF+ujljfbjcXjeF+AZ5Jsm
         5bkMJJu2uULK8TmKIRFLuqPPLwIXOBGiH0ZFNoewzWZMn1wHSGQIzORAq5Pth3/Ij7We
         9vKv8WXV2UromFyO4ByGfESD8G++o0k3PetrhnQhO8F7dwrPqgUzwWnHzE756Cii3/25
         sETXh58NPGLsV+HPjjbYkABZSEHS8gHYe8sVz/OMMR5Ph+2VcHiFeCQIvfPsnu/rS8Vn
         06eg==
X-Gm-Message-State: AOJu0Ywsrd7Wj1b/tlZ8QcnYlsxQLqgHhNzwAi9UAgR0ZVVCuD+2G68t
        8H486otzjInPBgttmkckdQ8=
X-Google-Smtp-Source: AGHT+IHmt/OtGw/gPKEbf/bxmyKVUqTK2AMmKRi90DpjP8Bvziiio5AuV7mTpjjPuvBArBZUrhkKuQ==
X-Received: by 2002:a17:902:82c4:b0:1c5:f4c7:b4d5 with SMTP id u4-20020a17090282c400b001c5f4c7b4d5mr10698300plz.34.1695724753178;
        Tue, 26 Sep 2023 03:39:13 -0700 (PDT)
Received: from sol (14-201-140-18.tpgi.com.au. [14.201.140.18])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902b28500b001c62b9a51a4sm1702079plr.239.2023.09.26.03.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 03:39:12 -0700 (PDT)
Date:   Tue, 26 Sep 2023 18:39:05 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Yury Norov <yury.norov@gmail.com>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH v1 1/5] lib/test_bitmap: Excape space symbols when
 printing input string
Message-ID: <ZRK0yfXf/XPazxm4@sol>
References: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
 <20230926052007.3917389-2-andriy.shevchenko@linux.intel.com>
 <ZRKz/G8y397MmVoc@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRKz/G8y397MmVoc@sol>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 06:35:40PM +0800, Kent Gibson wrote:
> On Tue, Sep 26, 2023 at 08:20:03AM +0300, Andy Shevchenko wrote:
> > test_bitmap_printlist() prints the input string which contains
> > a new line character. Instead of stripping it, escape that kind
> > of characters, so developer will see the actual input string
> 

And "Excape" -> "Escape" - didn't notice until my reply was sending.

Cheers,
Kent.

> Grammar nit:
> 
> "that kind of characters" -> "those kinds of characters" or "that kind
> of character" or "such characters" or ...
> 
> > that has been used. Without this change the new line splits
> > the string to two, and the first one is not guaranteed to be
> > followed by the first part immediatelly.
> 
> immediately
> 
> And the second "first" should be "second"??
> 
> "the second part is not guaranteed to immediately follow the first" is
> clearer (and hopefully what you mean), IMHO.
> 
> Cheers,
> Kent.
> 
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  lib/test_bitmap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> > index f2ea9f30c7c5..1f2dc7fef17f 100644
> > --- a/lib/test_bitmap.c
> > +++ b/lib/test_bitmap.c
> > @@ -523,7 +523,7 @@ static void __init test_bitmap_printlist(void)
> >  		goto out;
> >  	}
> >  
> > -	pr_err("bitmap_print_to_pagebuf: input is '%s', Time: %llu\n", buf, time);
> > +	pr_err("bitmap_print_to_pagebuf: input is '%*pEs', Time: %llu\n", ret, buf, time);
> >  out:
> >  	kfree(buf);
> >  	kfree(bmap);
> > -- 
> > 2.40.0.1.gaa8946217a0b
> > 

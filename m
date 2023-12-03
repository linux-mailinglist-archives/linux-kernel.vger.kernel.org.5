Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25577802638
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 19:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbjLCSZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 13:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjLCSZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 13:25:31 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27F8DA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 10:25:37 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5d3758fdd2eso33138677b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 10:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701627936; x=1702232736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2VVLLIlLkmNI0mv7eEUR+9w9xY97OpPTAaLk8ksTAds=;
        b=EIwjxkVypr9gsdUbZY+2+CuKXm2DiTdSy8qtemtIAnMUMXLU6qD+5tXL80HBd+rWpj
         mLEutcdUtyGhZia5ga/VeIIdetNk7FuuvRmsVVCpWLvDdIvZAdev3BSqHMfVo8No7BUF
         WYqVgmLPJBqwCPzIkZ0oGKULBn1PpVz4C0zjgCKhN96nz2vavicomjmVIBjcBe/qmeuo
         /r8iAobtynJX0d2XhrIFyHfxmG9j8RzzjJU6JjSeQ3y2BCaFFOV94tL4EgXGbB7j33Ht
         LNqIk//YckENa464gBaTY5oYyMzmxq626gV+o+OHT40nOFLvK9+Gn4IbChMv/cnvgPD8
         kwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701627936; x=1702232736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VVLLIlLkmNI0mv7eEUR+9w9xY97OpPTAaLk8ksTAds=;
        b=HPwWJns7B11Ks/PnG7ttedR7grrUd3tal783FUdIpcYRPiri2otjPC6drcZow9chM9
         AKo4RqSlXvqYLaUVh9UpN1o2wpNb/0sDGPQ7+QWMpprSdsgo5mxU9qIKzLAeJNVkdAr5
         ptnFes3HzNf26krYm4C1AHGq64Jv8X+GVJiXuYVYEMw8yXbsXjobDNKa8jat4lAvETDT
         ZjaGL56Ynds8TVs+YPovAvdonemT+PmAcdo6XupOJH1D8wa3mBMTvqN8cHfeR3e4U4lg
         jLIDGElErtUJ0zAjtCvHI9bo+KUlpWAoVzAbgjPgzhPm68JwgmuPhxaREfB35IW7h67j
         97qQ==
X-Gm-Message-State: AOJu0YyNAF41OaY4ysBaoiNmj2hrW1PaY7d7uXtTigHpEBLsQL6K15Pz
        Es+K3BIiQ8iQqE8dJOdSL0wqM0BZGWQ=
X-Google-Smtp-Source: AGHT+IEoIWR7LaPGZbq6G1NF01GwM9q59uaQWXlL7reyrRVwAl/YZmgMS+GscvwC2D+FyxsPAvj/5w==
X-Received: by 2002:a0d:cc53:0:b0:5d3:464d:18d0 with SMTP id o80-20020a0dcc53000000b005d3464d18d0mr8208914ywd.22.1701627935984;
        Sun, 03 Dec 2023 10:25:35 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id g190-20020a0df6c7000000b005d4229e8fb9sm2033921ywf.30.2023.12.03.10.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 10:25:34 -0800 (PST)
Date:   Sun, 3 Dec 2023 10:25:33 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] lib/find: optimize find_*_bit_wrap
Message-ID: <ZWzIHRqj1h9VaLSA@yury-ThinkPad>
References: <20231028190530.286300-1-yury.norov@gmail.com>
 <ZU2Tmav832NIeJQk@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZU2Tmav832NIeJQk@yury-ThinkPad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, taking in bitmap-for-next

On Thu, Nov 09, 2023 at 06:21:18PM -0800, Yury Norov wrote:
> Ping?
> 
> On Sat, Oct 28, 2023 at 12:05:29PM -0700, Yury Norov wrote:
> > When an offset is 0, there's no need to search a bitmap from the
> > beginning after the 1st search failed, because each bit has already
> > been tested.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  include/linux/find.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/find.h b/include/linux/find.h
> > index 5e4f39ef2e72..241b6d028eda 100644
> > --- a/include/linux/find.h
> > +++ b/include/linux/find.h
> > @@ -405,7 +405,7 @@ unsigned long find_next_and_bit_wrap(const unsigned long *addr1,
> >  {
> >  	unsigned long bit = find_next_and_bit(addr1, addr2, size, offset);
> >  
> > -	if (bit < size)
> > +	if (bit < size || offset == 0)
> >  		return bit;
> >  
> >  	bit = find_first_and_bit(addr1, addr2, offset);
> > @@ -427,7 +427,7 @@ unsigned long find_next_bit_wrap(const unsigned long *addr,
> >  {
> >  	unsigned long bit = find_next_bit(addr, size, offset);
> >  
> > -	if (bit < size)
> > +	if (bit < size || offset == 0)
> >  		return bit;
> >  
> >  	bit = find_first_bit(addr, offset);
> > -- 
> > 2.39.2

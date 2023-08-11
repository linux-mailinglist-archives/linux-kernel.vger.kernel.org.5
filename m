Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DA7778FF9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 14:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbjHKM4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 08:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHKM4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:56:20 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E61109
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:56:19 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-765a7768f1dso147741085a.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691758579; x=1692363379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vd9PuNDDB5l50cP1R/+PbsYF74Lz0Yr6WRlkE61tRqs=;
        b=cqVVkn9dOI/B4sW2RDGaroC0b5b9L64lBjCezVyQj600fm4E7TAG8g9lr01MLSmdVZ
         HumohLd8dkWd/6Qh1Z/OyT9nNN6p4HMVxEXu/DirjVWYFGNNBtp+HJ4yKbU7pGMyiXBa
         3IzQkTox8cHLvttvD59/xiXTZN+AxIRrC5SfTFsORZE8GPkzLYmAeH4mYp3Nr4sHS0/r
         +JYdzqNKGqd3P2LIN67y3QutLDg0RJclc3RFQJuvFjKER4WTwf4/ov/jPV7ZbW795veb
         gZ2ohB3CfN0lWWr2Ci0sZd2XkFSCYXKc7auk6zsqGflc8FNkcCjcWiq7gd7Mqq3B2C23
         Dj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691758579; x=1692363379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vd9PuNDDB5l50cP1R/+PbsYF74Lz0Yr6WRlkE61tRqs=;
        b=TbJRG23raawvDdHV63qlx6EzQOO7DpKX48uWh2mVN2jwYEzQyky5YkrLTaQiWmo447
         l649fTPSm6JIq/rMh8MCbmFGh6GyGsgkWwJGIUGQUBSiYDM3DUFulTiyeJs2nQzYJfN5
         fsSgwnLbWHY8+pvLEW3Xbjh0mZliAcUJlYfuwi2p8yHGrPoSex1Dvf20JvNhy+XzlOYu
         QeY7hm640OxI1hVFUooM5o6ccnXHVJkuaC1tmEDioLHNMgYifEiG0sQol7ZYsHevLLcr
         S5HRqf5WB36VbpcSyScUpKCH3w7PNLXuYaQwfU4Hr50jZswiyRaSfF3/Tn3ghknGmfw+
         Xc+g==
X-Gm-Message-State: AOJu0YxxqZlGUAB6JQ4oQTpev78YU4DhTc2Pv+VcfN0eHqBalGPq0Ai4
        dmP3VD+qFJVpM/XxcpxcUHNtBfg7q/k=
X-Google-Smtp-Source: AGHT+IEziCwY2x6cM1fYXwbU41ai2wnP19jnfkuJLLbxE3QIdMBFJqLtv/vX7ycbA6O/PnKWkqJitw==
X-Received: by 2002:a05:620a:2807:b0:76c:6f89:e5f1 with SMTP id f7-20020a05620a280700b0076c6f89e5f1mr1968307qkp.18.1691758578845;
        Fri, 11 Aug 2023 05:56:18 -0700 (PDT)
Received: from localhost (2603-7080-3d03-3cb9-d639-a70b-9607-2020.res6.spectrum.com. [2603:7080:3d03:3cb9:d639:a70b:9607:2020])
        by smtp.gmail.com with ESMTPSA id d9-20020a05620a140900b00767b4fa5d96sm1176082qkj.27.2023.08.11.05.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 05:56:17 -0700 (PDT)
Date:   Fri, 11 Aug 2023 05:56:02 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/6] bitmap: replace _reg_op(REG_OP_ALLOC) with
 bitmap_set()
Message-ID: <ZNYv4pt4HBUBZA60@yury-ThinkPad>
References: <20230811005732.107718-1-yury.norov@gmail.com>
 <20230811005732.107718-3-yury.norov@gmail.com>
 <25deb65e-a8f3-957b-9e4f-759604111d50@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25deb65e-a8f3-957b-9e4f-759604111d50@rasmusvillemoes.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 08:21:33AM +0200, Rasmus Villemoes wrote:
> On 11/08/2023 02.57, Yury Norov wrote:
> > _reg_op(REG_OP_ALLOC) duplicates bitmap_set(). Fix it.
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  lib/bitmap.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/lib/bitmap.c b/lib/bitmap.c
> > index 3a589016f5e0..c9afe704fe4b 100644
> > --- a/lib/bitmap.c
> > +++ b/lib/bitmap.c
> > @@ -1352,9 +1352,12 @@ EXPORT_SYMBOL(bitmap_release_region);
> >   */
> >  int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
> >  {
> > +	unsigned int nbits = pos + BIT(order);
> > +
> 
> That really doesn't sound right. Have you added self-tests for these
> functions first and then used those to catch regressions?

When bitmap_allocate_region() is broken, almost every arch build fails
to boot. Can you explain what exactly looks wrong to you?

Thanks,
Yury

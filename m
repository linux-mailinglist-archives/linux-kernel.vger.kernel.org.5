Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2782277AF16
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 03:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjHNBDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 21:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjHNBCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 21:02:54 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4058F9D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 18:02:53 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-40ff82320a7so22775911cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 18:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691974972; x=1692579772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mrsb4KiFb9kjlFBhu8KxyvaFo91HmXg0SAvuFG6vRHM=;
        b=gvie8nTEtxBgmWchL7aTJj91bPsjaWPuR2VublKylUdejyaljPpqcnanC9cV+jYAeq
         PFa0DRW8CrQJ+yG+ZLSDiJ49ZY+GRJco6NaYZutc3dkL/Y1JtMdHjrhn/RnwrNWvjk3k
         j6X3nCWHnbh0Tzr5UV2Q/s0GI32hkr2POdgZIq5fm2TtLcLCa9igI3dLUTfT5+Iq7Z6e
         e3DveNMi1fhqKl1cBi8RSrYP3cJ6YvBBnArYd6F4eNisCxpj6hn/YBGsiHG7rG/mVA0s
         scggVStyPeAGZP/KgpwdDmO1IkVWAw2UMqlMfOOgUm8gqOMBHnm6j0DBXX8A/RgzbjeN
         GGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691974972; x=1692579772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrsb4KiFb9kjlFBhu8KxyvaFo91HmXg0SAvuFG6vRHM=;
        b=hqqqncJlaFseNaWMNNbBTRUEV+9zK73QDWiZYIpcNU8Vyhey8ttNYlckUeuJkTAgNN
         owyizKDBz1GxwhVWtTt0t2nVDyO/O/awNJUn4zcWdmdPcwmcLdNFd7DUole9IyumwUJw
         qYY14nQ8yvyzu5H51TtinZQc4nNwPAf4AQlBJOHupYmlkZbLJdukVL1KrN/effmed47d
         ZpnkHnyRV0Mlfcs5E0CYD4FyuKCeJEd0HzxvIJYrxTtKnvQ/Bc2HHo2l+ByUJ7/EMyP9
         biJh9JTbPa5fkiVhN2SqECMpRUM41VRcG7zVYefVgm7dXxdXrp1/vP1C1+C+8W+0Jilr
         19AQ==
X-Gm-Message-State: AOJu0Yxhnk5kuGRVibXchYKeQWZ3iZv42xiM+e9fyBX7EDWBMUznyjuZ
        lRqfxqLd+XMJCQCvtGhjsfj6NX2OSFs=
X-Google-Smtp-Source: AGHT+IFfYieihrqDEbgtLP63kSu15Mjoa1aSl/1PX+1nvs8L63NWrmBNj2KBu4kP3sCkCW0NhtU1cA==
X-Received: by 2002:ac8:5a96:0:b0:40f:ea3e:777e with SMTP id c22-20020ac85a96000000b0040fea3e777emr9954514qtc.21.1691974972292;
        Sun, 13 Aug 2023 18:02:52 -0700 (PDT)
Received: from localhost (rrcs-108-176-112-203.nys.biz.rr.com. [108.176.112.203])
        by smtp.gmail.com with ESMTPSA id g3-20020ac870c3000000b0040f200feb4fsm2716727qtp.80.2023.08.13.18.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 18:02:51 -0700 (PDT)
Date:   Sun, 13 Aug 2023 18:02:50 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 3/4] bitmap: define a cleanup function for bitmaps
Message-ID: <ZNl9Ok0JsI+S0Apx@yury-ThinkPad>
References: <20230812194457.6432-1-brgl@bgdev.pl>
 <20230812194457.6432-4-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812194457.6432-4-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 09:44:56PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add support for autopointers for bitmaps allocated with bitmap_alloc()
> et al.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  include/linux/bitmap.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 03644237e1ef..6709807ebb59 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -6,6 +6,7 @@
>  
>  #include <linux/align.h>
>  #include <linux/bitops.h>
> +#include <linux/cleanup.h>
>  #include <linux/find.h>
>  #include <linux/limits.h>
>  #include <linux/string.h>
> @@ -125,6 +126,8 @@ unsigned long *bitmap_alloc_node(unsigned int nbits, gfp_t flags, int node);
>  unsigned long *bitmap_zalloc_node(unsigned int nbits, gfp_t flags, int node);
>  void bitmap_free(const unsigned long *bitmap);
>  
> +DEFINE_FREE(bitmap, unsigned long *, if (_T) bitmap_free(_T))

bitmap_free() is a wrapper around kfree(), and kfree() checks against
NULL, and returns immediately. Why this tests again?

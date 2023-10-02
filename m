Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E237B5962
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238584AbjJBQ6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238557AbjJBQ6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:58:06 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74FFBF
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:58:02 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c735473d1aso188375ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 09:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696265882; x=1696870682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OmqTcPALB5Fa2231OIyxzbdzfqXkdnOxzqNeS9x4hgs=;
        b=IWzQ12f1FmtSa5xm350ayLL0Msu8ZKS6hNwlapwOkWQ73CdIBBhQNxNcdjVGkIjNc8
         DuVr1RZVcJ2qFK+HkCNMWjE+FoUUNz6R/A9M8NlKIJJvrLKqmrSAI5ok9g0l3xknfeo4
         pUw96U41+khQ0DeQyhvnq8SebmJxsRF3p1zao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696265882; x=1696870682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmqTcPALB5Fa2231OIyxzbdzfqXkdnOxzqNeS9x4hgs=;
        b=g87yJh6hwF5wwbGO6qZGyTSheAgtynomLQ/suSNT1CNyJHxBKOsB9mnNE8j539iA0p
         8jhX5tWJtzGeRRJPSbqjbaCydjkpHK37O3oPoiAKjRd6q3SGYp7egxO7RjCmXtmjHQgU
         yxcqWvu+UCsGmcIfhyUimA2Oeu0wlae3ptxS/KmGEebQOaVbItloeEJKL3XJXQZt/eW8
         TWS+hY9RrkxtXS6wcY4oXHa7x3/tlucJEklWQveQ1QyMQMbn8k+LV6J/CPCHfWrOoekK
         vT/8lITmh0JTUbKo0vTkQM2FJhIv67ZKRuHqKRvNwnGlK4SPNKeD7uOVcyVeuTro5kng
         ePRg==
X-Gm-Message-State: AOJu0YxY/0qgqVNz9kJDVfHL8prc1KAswC5LGzhGHs6f3xk6DdzZpfF7
        zOSD2y//XL5k46Qx3YvkFSIW7g==
X-Google-Smtp-Source: AGHT+IFbiFrmNXAcBqoD21bFKcMD0lXjlNKJVvMM6NyfF786Ran5xugt2TBoWfWxH0Mge86oU9T5HA==
X-Received: by 2002:a17:903:22c4:b0:1c1:f3f8:3949 with SMTP id y4-20020a17090322c400b001c1f3f83949mr11623836plg.1.1696265882236;
        Mon, 02 Oct 2023 09:58:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ee8500b001c62d63b817sm13050708pld.179.2023.10.02.09.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 09:58:01 -0700 (PDT)
Date:   Mon, 2 Oct 2023 09:57:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/5] params: harden string ops and allocatio ops
Message-ID: <202310020957.022F9047F0@keescook>
References: <20231002124856.2455696-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002124856.2455696-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 03:48:51PM +0300, Andy Shevchenko wrote:
> A couple of patches are for get the string ops, used in the module,
> slightly harden. On top a few cleanups.
> 
> Since the main part is rather hardening, I think the Kees' tree is
> the best fit for the series, but I'm open for another option(s).
> 
> Changelog v2:
> - dropped the s*printf() --> sysfs_emit() conversion as it revealed
>   an issue, i.e. reuse getters with non-page-aligned pointer, which
>   would be addressed separately
> - added cover letter and clarified the possible route for the series
>   (Luis)
> 
> Andy Shevchenko (5):
>   params: Introduce the param_unknown_fn type
>   params: Do not go over the limit when getting the string length
>   params: Use size_add() for kmalloc()
>   params: Sort headers
>   params: Fix multi-line comment style

Seems like a nice bit of clean-up.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

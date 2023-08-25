Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0BE789068
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 23:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjHYVcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 17:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjHYVck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 17:32:40 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C692CE59
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 14:32:35 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bf1935f6c2so10002555ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 14:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692999155; x=1693603955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1m0We/QAA4bFlLvCtmSKD6+YAm7eq6zVv5AOYCjTXaY=;
        b=MD0v9mnq5+jh/hdt9FGeSVC6ddK6V1lXXuzgHpftg4TO0eTA0rxNUCGV8uAAH4jp5r
         zdP53cAAGRqGflCgANRdLLRR9EEcNXCtujUpxiTIFOvBe4yfAH/IPjEqwEdRx6FBsYIb
         Px3/CcXTDnWyHRH2IOU/u5ysDJlOucStNwCBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692999155; x=1693603955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1m0We/QAA4bFlLvCtmSKD6+YAm7eq6zVv5AOYCjTXaY=;
        b=PBXFtgyqZv1jDjT4BSkmZ+Z5kX8R/yVz1Tav4JRZn/hQ4ISGi1wd+TNzTJUiloSLWd
         PrQPFgeoDj5xlxf0GjK6DQK+YUKUQ3aVuC6BSFEcnOjN2LK2hVxabFRUram9LTxolrD5
         vf481hswN7db/LNChogO0+65kSLXHT9TjUoa+bwMyy/fwyrNFZ3UPazFIi4yArIPcB4p
         uX3fEuMobbGcnMvKnveyGc/x5h5cFpzJG2bvlR9wvFYmDlqn59kxTfDRkGdowTD1hrlR
         tipaC/6O3tbJsimsctnzIHXgTf40gEtwMuVR4sbjG7boAL1FYW8oXoRNgTxJNddohRV3
         bNSg==
X-Gm-Message-State: AOJu0YxPf7XR/TQ6ZVSuFw+sXX9RkxgLFHBlBpNItZtsdS1FWS8SRdhm
        bTSXaxMCWUfkZn7ard0YIjQBvw==
X-Google-Smtp-Source: AGHT+IFsAHLNa8Gh9Bds899eVcYt7j1gKgx8ArYRgxeMxNAvCgMFa4Ir2cXJQg1AiKL9zd2jVPSgaw==
X-Received: by 2002:a17:902:db09:b0:1bf:8132:d19f with SMTP id m9-20020a170902db0900b001bf8132d19fmr26111253plx.27.1692999155330;
        Fri, 25 Aug 2023 14:32:35 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902ed4400b001b8943b37a5sm2216722plb.24.2023.08.25.14.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 14:32:34 -0700 (PDT)
Date:   Fri, 25 Aug 2023 14:32:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qing Zhao <qing.zhao@oracle.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH] mm/damon/sysfs: add __counted_by() annotation
Message-ID: <202308251426.94092475C3@keescook>
References: <20230825020441.65431-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825020441.65431-1-sj@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 02:04:41AM +0000, SeongJae Park wrote:
> Commit dd06e72e68bc ("Compiler Attributes: Add __counted_by macro")
> added __counted_by() annotation.  The underlying attribute for the
> feature is still under development, but adopting it can improve the
> readability of the code.  Apply it to four dynamic arrays in DAMON sysfs
> code.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/sysfs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 808a8efe0523..36a176f38726 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -93,7 +93,7 @@ static const struct kobj_type damon_sysfs_region_ktype = {
> 
>  struct damon_sysfs_regions {
>  	struct kobject kobj;
> -	struct damon_sysfs_region **regions_arr;
> +	struct damon_sysfs_region **regions_arr __counted_by(nr);
>  	int nr;
>  };

Unfortunately this isn't supported yet for non-flexible-array-members:

mm/damon/sysfs.c:96:14: error: 'counted_by' attribute may not be specified for a non-array field
   96 |         struct damon_sysfs_region **regions_arr __counted_by(nr);
      |                                     ^~~~~

We'll have to wait a bit before we can add this patch. Thank you for
getting it ready, though! This support is next in line. :)

The FAM support is likely ready to land, though[1]. I just tested it
today.

-Kees

[1] https://gcc.gnu.org/pipermail/gcc-patches/2023-August/628459.html

-- 
Kees Cook

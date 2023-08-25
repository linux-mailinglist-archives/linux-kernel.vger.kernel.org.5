Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055877891BA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 00:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjHYW2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 18:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjHYW2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 18:28:31 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1832120
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:28:30 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68a56401b9aso1165905b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693002510; x=1693607310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h8jUx7iw70g3n6oT1VXilWUTdEYZ99rx0FoJBfC0hcQ=;
        b=LAD89c+gGUDuT5PjcCMIvYuA1c3LCQ7U5nJbYQU6HlJzlNM7GtUP1bfqNd3yeeA8mf
         CxGhvvVZD/o9rYVKZJ+5sTWZECxzqjro3ZHPsepwwRectEAGU9GJEPrkwgIogFf9F9JX
         JxCtvSELwDLmc0QZELEXlvzx8UQZ6rT5MYfOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693002510; x=1693607310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8jUx7iw70g3n6oT1VXilWUTdEYZ99rx0FoJBfC0hcQ=;
        b=O3a6njHhVDZuoQzkJDVXakSQT4K/7Jhquap5O6Y8CMar4/E+4vnzh5Tf6CklfZ/fpJ
         1wkSlcb3QYjiLqn790F6TzFadajAWSSXugvKAwRCgzBF3qZMEJgemB3aOp6Z3mjjHuxq
         liE09zMJnvFqalTelhtvgrpIGFnqGv8+t2Gb6aWMjkx1MSjueKHyVIjbViPCnPElokeR
         6Lxl7N/lnVcjz7c4R7aGF+ZFVDdv+o/cvKAIYLvPs3pRE29VHyjd3uaK5WR9eO9PCAFl
         G6rEvb7ltK7z+jcA5Z6s/zr4BNJDzAVML515OjDeU3XCPKuJKFIEDRe2qqTn8IEMlQBK
         Ns9w==
X-Gm-Message-State: AOJu0YyB9Ss+zqMpTDS8liwxSIcm6hYMFQX4g9rpxdGdTPkOiL7ksmL+
        RqlbHsu5UiWNFbnSuxTi0e4wKg==
X-Google-Smtp-Source: AGHT+IHe3WDOcAo8v3TLTNHzQM/dioBQeEFsUIGCrxTbXjYQRVduwZsvHc2uqIQMogZMTr5uBPntzw==
X-Received: by 2002:a05:6a00:1a52:b0:68a:586a:f62 with SMTP id h18-20020a056a001a5200b0068a586a0f62mr15300829pfv.4.1693002509735;
        Fri, 25 Aug 2023 15:28:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l4-20020a639844000000b005651c9351e1sm2144974pgo.64.2023.08.25.15.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 15:28:29 -0700 (PDT)
Date:   Fri, 25 Aug 2023 15:28:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        david@redhat.com, peterx@redhat.com, izbyshev@ispras.ru,
        broonie@kernel.org, szabolcs.nagy@arm.com, kpsingh@kernel.org,
        gthelen@google.com, toiwoton@gmail.com
Subject: Re: [PATCH v3 2/5] kselftest: vm: Fix mdwe's mmap_FIXED test case
Message-ID: <202308251526.E350861ED@keescook>
References: <20230704153630.1591122-1-revest@chromium.org>
 <20230704153630.1591122-3-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704153630.1591122-3-revest@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 05:36:26PM +0200, Florent Revest wrote:
> I checked with the original author, the mmap_FIXED test case wasn't
> properly tested and fails. Currently, it maps two consecutive (non
> overlapping) pages and expects the second mapping to be denied by MDWE
> but these two pages have nothing to do with each other so MDWE is
> actually out of the picture here.
> 
> What the test actually intended to do was to remap a virtual address
> using MAP_FIXED. However, this operation unmaps the existing mapping and
> creates a new one so the va is backed by a new page and MDWE is again
> out of the picture, all remappings should succeed.
> 
> This patch keeps the test case to make it clear that this situation is
> expected to work.
> 
> Signed-off-by: Florent Revest <revest@chromium.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Fixes: 4cf1fe34fd18 ("kselftest: vm: add tests for memory-deny-write-execute")
> ---
>  tools/testing/selftests/mm/mdwe_test.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/selftests/mm/mdwe_test.c
> index d0954c657feb..91aa9c3099e7 100644
> --- a/tools/testing/selftests/mm/mdwe_test.c
> +++ b/tools/testing/selftests/mm/mdwe_test.c
> @@ -168,13 +168,10 @@ TEST_F(mdwe, mmap_FIXED)
>  	self->p = mmap(NULL, self->size, PROT_READ, self->flags, 0, 0);
>  	ASSERT_NE(self->p, MAP_FAILED);
>  
> -	p = mmap(self->p + self->size, self->size, PROT_READ | PROT_EXEC,
> +	/* MAP_FIXED unmaps the existing page before mapping which is allowed */
> +	p = mmap(self->p, self->size, PROT_READ | PROT_EXEC,
>  		 self->flags | MAP_FIXED, 0, 0);
> -	if (variant->enabled) {
> -		EXPECT_EQ(p, MAP_FAILED);
> -	} else {
> -		EXPECT_EQ(p, self->p);
> -	}
> +	EXPECT_EQ(p, self->p);
>  }

This is just validating the MDWE doesn't block a MAP_FIXED replacement?

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>  
>  TEST_F(mdwe, arm64_BTI)
> -- 
> 2.41.0.255.g8b1d071c50-goog
> 

-- 
Kees Cook

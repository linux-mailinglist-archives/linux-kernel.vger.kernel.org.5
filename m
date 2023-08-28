Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F2278B782
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjH1SqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbjH1Spx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:45:53 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01EBCC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:45:29 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68bed2c786eso2414548b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693248313; x=1693853113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a9FmJgU29HqgZJibCVuOZN9LKZYzqMQxeDDjAb+fuvE=;
        b=RIEOp/wOdBXAue03fFc5wfbeo3NhauXVPmOHkinrJCWMDd2m8pKPMpw26obXrQyh3O
         WVGw1FQIwDT+mev4AIuu400qB50T3C1uvVgiNld7OtHf9xdHjLEG5rOczt1HXmETZmGT
         RRP8NJHKBolMc/M285awaYl7mVl6epN0yDXVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693248313; x=1693853113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9FmJgU29HqgZJibCVuOZN9LKZYzqMQxeDDjAb+fuvE=;
        b=TmOT0Uab9Fac4vbriio2Rod/OzU9DIDTYDjIZlKgJXm1evw2VbvqQ5KoEzsYWrLVYi
         EWxlQw5g/fqPEZPyeVbmp2KBjD0AG3+0GWZEMa1ssAzgvcaAvGxQf/vHqVPoIctJZtmg
         NvsCAuwxyaGIcDccCr8i51WIV64q8clCOYH/aXcIr78QgTiQupq4BltmvWkJaQEAiYIj
         6AhWX3gGURem3eEewQfBstYZzP4n1KfavZuVUH4vNeWrJBa8Uc1JrVWS6NBPXfS2ZEzt
         sMXQ/zQOFmMsMSByGFCPu1wqQ6ZF8NeK0Fv0lwrCMycK5Pq9TnBFPPgKl+q9q4P3O6o4
         eXGw==
X-Gm-Message-State: AOJu0YyF8h2dCWLYPhuIWmuqQHPR6TV+KHC1Glsw/rklfBDj2KJVqEXo
        mIIsiV9VJAsgoa01y9AqxglA7Q==
X-Google-Smtp-Source: AGHT+IEz5SxwDArL+Cob6j1IF+IMKwlhxa0KqGnQdRBQcSpyhkxXh47si5beEg0McuWEyhnJCrZxHg==
X-Received: by 2002:a05:6a21:3290:b0:14c:e8d4:fb3e with SMTP id yt16-20020a056a21329000b0014ce8d4fb3emr5455874pzb.43.1693248313126;
        Mon, 28 Aug 2023 11:45:13 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j5-20020aa783c5000000b0064d47cd116esm6978854pfn.161.2023.08.28.11.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 11:45:12 -0700 (PDT)
Date:   Mon, 28 Aug 2023 11:45:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        david@redhat.com, peterx@redhat.com, izbyshev@ispras.ru,
        broonie@kernel.org, szabolcs.nagy@arm.com, kpsingh@kernel.org,
        gthelen@google.com, toiwoton@gmail.com, ayush.jain3@amd.com
Subject: Re: [PATCH v4 3/6] kselftest: vm: Check errnos in mdwe_test
Message-ID: <202308281145.D3C859D@keescook>
References: <20230828150858.393570-1-revest@chromium.org>
 <20230828150858.393570-4-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828150858.393570-4-revest@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 05:08:55PM +0200, Florent Revest wrote:
> Invalid prctls return a negative code and set errno. It's good practice
> to check that errno is set as expected.
> 
> Signed-off-by: Florent Revest <revest@chromium.org>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

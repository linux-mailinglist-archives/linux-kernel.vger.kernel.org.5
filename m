Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99277A28EC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237700AbjIOVEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237753AbjIOVDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:03:39 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFFD1A5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:03:23 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68fc081cd46so2481526b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694811803; x=1695416603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=APHJKdyAi/Un1XPHZn1Z1pQZW4vCCHalitDLmyiouTQ=;
        b=dx8DPTvbuSlh9TpzZol3/Gyx4GRxRBcPwEjUuOrFdZrrcIkqYUyXgAfBmgY4WsF03M
         hPSwrZPbIXM6+8W2CTfEJ/r3EcWQ8DnB2VTdZ8+5HDZ62Fj5w4nHKOruLoJ9uNXREkya
         nkJnIDPHkznSwrax0w/JCkGyXb1kCiTaYYts4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694811803; x=1695416603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APHJKdyAi/Un1XPHZn1Z1pQZW4vCCHalitDLmyiouTQ=;
        b=q0HV7s4noxs4uXbyft7ph8Ci+YGSv5BwhGS9kLhHNtTvC/fSa4KO4VkJUd870oxYsU
         7f2AxKVLZ+AKNaX2rQxp2Od7rw6vg+2wudVAX/w/b5uWIS/EA5em3ggYBvEXdzoTSguH
         sBXUvO1zEi3hQE9T+UbIXaHeSlTK7qv08lf8cKTuPUnvvUsfsHfFojxBFb4nAeryQVpF
         8JgDB2pg9im1NFp+YRZ/wqONR1s+tBDfmCNHX1ngYH7i2lPrIryufEBQWEJX9gjgo3TQ
         x3S8buuIvqM79y/A3o5+PVZ80ewFQ8nX1j+gwthbymd01ojqxLy+tg71ylZUYNnlnAaQ
         Le8w==
X-Gm-Message-State: AOJu0YyY1epgu2V9XAkiAtURGxRcJ6Cn/p7tMnUZOqU9Rg2PYf0R9Ntk
        SmrX8V/h4DXlcY7Fs/QS4f2vPGZNWe1/qLkaBSF74Q==
X-Google-Smtp-Source: AGHT+IH9giN0oiNJip6NSPrpp8FYJe9UYAjCNYEhPQYuBGuLm0ngXdsbwkHYQMIrzQrQbvKrNld2xQ==
X-Received: by 2002:a05:6a20:320d:b0:14b:8023:33c8 with SMTP id hl13-20020a056a20320d00b0014b802333c8mr2834160pzc.2.1694811803227;
        Fri, 15 Sep 2023 14:03:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bv6-20020a632e06000000b0056001f43726sm3098867pgb.92.2023.09.15.14.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 14:03:22 -0700 (PDT)
Date:   Fri, 15 Sep 2023 14:03:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matteo Rizzo <matteorizzo@google.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, luto@kernel.org, peterz@infradead.org,
        jannh@google.com, evn@google.com, poprdi@google.com,
        jordyzomer@google.com
Subject: Re: [RFC PATCH 06/14] mm/slub: pass additional args to
 alloc_slab_page
Message-ID: <202309151403.49D5C3CB@keescook>
References: <20230915105933.495735-1-matteorizzo@google.com>
 <20230915105933.495735-7-matteorizzo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915105933.495735-7-matteorizzo@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 10:59:25AM +0000, Matteo Rizzo wrote:
> From: Jann Horn <jannh@google.com>
> 
> This is refactoring in preparation for SLAB_VIRTUAL.
> 
> The implementation of SLAB_VIRTUAL needs access to struct kmem_cache in
> alloc_slab_page in order to take unused slabs from the slab freelist,
> which is per-cache.
> 
> In addition to that it passes two different sets of GFP flags.
> meta_gfp_flags is used for the memory backing the metadata region and
> page tables, and gfp_flags for the data memory.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

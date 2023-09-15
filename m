Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BE07A2902
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237587AbjIOVJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237154AbjIOVIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:08:52 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D646A0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:08:48 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c434c33ec0so8613185ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694812127; x=1695416927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1USzWYUGvvuIEVJkYh5wRYXrAoKFGs+D9zdSuXXuGko=;
        b=CHZ4Br4anGAQsDYK2xv2w0WNa+PxFhcQ03z08OEERDJPkjtUDddOwcXa1qvUcwyiBd
         vg6LTimDbaww50419WFegtYr+cH89uLG+2DsIMGnLgGIDaoTfUZYqjShLLNstUNTGueZ
         RpBQk1jHcBV8J7e/EI8PRgWu0Ux513cCOiAYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694812127; x=1695416927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1USzWYUGvvuIEVJkYh5wRYXrAoKFGs+D9zdSuXXuGko=;
        b=JcJ9whCHOMT2NXea4YE5PaqvmUYLn/BT/A2JMd33e7KOxHWgSSgZwxPBSclNffIuW8
         /AScb8xcQcbbmx8kTD4eNYJhQ7klxVjAogZVjcDGTF44KYWndLhTnVCzTesOohE/0nWN
         B7s4e0VOL8HXL8UuMPkbePBdtS7Nugwark5hTWMmp/a77Z1A3IKO5rw72a+r6lgXEk/5
         ijJVjHRNw5Dw4mdjzg/yfcwz8dIG41BbS1XA0NJtXNWbRCHxA7JIP6OwljoBD8EMgtBC
         GZUr6YfLdf8ON3IZy7Fl5icRz8KR3qMPJERGRFCbHZoIQyO1JDOdwDP36SKRkFuKiHM4
         y7WA==
X-Gm-Message-State: AOJu0YxAPvyXQjGoJ66/oHc69BtVd6eOq1PoS64JmNU1OPYlhP0BD2/y
        01a58DG7nMKe9migldsAIqGd+A==
X-Google-Smtp-Source: AGHT+IGdp49LjyrMmSykt/SWt4KND8jRB/On6dOS8iyiloyE00YR/5G95sS67INYP4RtGEqyBEYS7w==
X-Received: by 2002:a17:902:64d6:b0:1c1:fc5c:b330 with SMTP id y22-20020a17090264d600b001c1fc5cb330mr2308796pli.12.1694812127548;
        Fri, 15 Sep 2023 14:08:47 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y11-20020a1709029b8b00b001b9e86e05b7sm3916537plp.0.2023.09.15.14.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 14:08:47 -0700 (PDT)
Date:   Fri, 15 Sep 2023 14:08:46 -0700
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
Subject: Re: [RFC PATCH 09/14] mm/slub: add the slab freelists to kmem_cache
Message-ID: <202309151408.A419BEAD15@keescook>
References: <20230915105933.495735-1-matteorizzo@google.com>
 <20230915105933.495735-10-matteorizzo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915105933.495735-10-matteorizzo@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 10:59:28AM +0000, Matteo Rizzo wrote:
> From: Jann Horn <jannh@google.com>
> 
> With SLAB_VIRTUAL enabled, unused slabs which still have virtual memory
> allocated to them but no physical memory are kept in a per-cache list so
> that they can be reused later if the cache needs to grow again.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Looks appropriately #ifdef'ed...

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109597CC77C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344347AbjJQP37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQP36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:29:58 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAB89E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:29:57 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a7c7262d5eso73414797b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697556596; x=1698161396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=huSrvmUAinpe5ZVkiT6rdHtWLpQkr9Tgyph1d2wopGo=;
        b=EENnRZ3TyYz+J/+pHE6aFXdHWAcdQ1+F5A47h03PgbhJWAHjD3nM7WGNJOiekj988z
         0FNeaRSBN02UJS+Zc1xxcwpAU6uEWcHDWNRY+aBs5Uyu5gMcwZY4sWivnB07BNNEBsmK
         wFs6ZJjFr9s26a4gg81rA06r20EyK0HjJJLkfnMw2B0TYH1ZIa/OQHPOBq3YHu6T7Ysd
         tg8NSTLXZCvIUGvwtubtNyeSDVQEocg3YchLTtCSHvoHJT+XyNVnEQxcAscRSOx+Y695
         Rjd3p9GynRLKqGUkio6zTemksiv9wE+bxKMZJqVfO5/ghkkJOM37giGNGn5lv9lq+2qM
         myaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697556596; x=1698161396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huSrvmUAinpe5ZVkiT6rdHtWLpQkr9Tgyph1d2wopGo=;
        b=N+Fp4XT27a05eOCNP2UH3TGI5lC16p91yBMw/Bg9pB3sYH7EEYOvOQ1kqbj0qZ2vJm
         KZVzyC9OJ3rViX67G/plhlxpcWZTebuGpVqkXN61p2b28di22tXTXJ6bNbqKse15345+
         d3PQQduadSEQv4k493kCGRTLrNA2n8SdbrhpFLt7oTMLTtnm2e0vMtjZfzpiaiUx7+kL
         GkIe/gVR14SF3KyC0Z8mEfxiTP9JGFt6fQZIxvagQ04S91zfGJSMzkmGpgpvNXpdMPx/
         3r9g1z6AnOYL/FMHG1E+u3zKoY/jozkUjlqkC0zRE3GwYTsOctOSoIYSARn+yC+KJmKP
         +MAQ==
X-Gm-Message-State: AOJu0Ywp/EE+hbbNPNm+cPCNZx6507LaTbvaPWdxc+NeZeAnBwnCV1Ik
        3XVVN6hJU9PjITwZI3aiVaw=
X-Google-Smtp-Source: AGHT+IGpTZgZds9pIUVC3SiDk409pSZCcxEG8kWBlwj1Ff/yb6bVVIxidfd+dduIYcx02WwknFfsKQ==
X-Received: by 2002:a0d:ea53:0:b0:5a7:d133:370d with SMTP id t80-20020a0dea53000000b005a7d133370dmr3025032ywe.16.1697556595930;
        Tue, 17 Oct 2023 08:29:55 -0700 (PDT)
Received: from localhost ([2607:fb91:18c6:8621:66cb:3372:2688:cd41])
        by smtp.gmail.com with ESMTPSA id x9-20020a0dd509000000b005a7be94585bsm690642ywd.96.2023.10.17.08.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 08:29:55 -0700 (PDT)
Date:   Tue, 17 Oct 2023 08:29:53 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] buildid: reduce header file dependencies for module
Message-ID: <ZS6lxxmGDy1eRWoh@yury-ThinkPad>
References: <20231017143408.2876181-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017143408.2876181-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 04:33:58PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The vmlinux decompressor code intentionally has only a limited set of
> included header files, but this started running into a build failure
> because of the bitmap logic needing linux/errno.h:
> 
> In file included from include/linux/cpumask.h:12,
>                  from include/linux/mm_types_task.h:14,
>                  from include/linux/mm_types.h:5,
>                  from include/linux/buildid.h:5,
>                  from include/linux/module.h:14,
>                  from arch/arm/boot/compressed/../../../../lib/lz4/lz4_decompress.c:39,
>                  from arch/arm/boot/compressed/../../../../lib/decompress_unlz4.c:10,
>                  from arch/arm/boot/compressed/decompress.c:60:
> include/linux/bitmap.h: In function 'bitmap_allocate_region':
> include/linux/bitmap.h:527:25: error: 'EBUSY' undeclared (first use in this function)
>   527 |                 return -EBUSY;
>       |                         ^~~~~
> include/linux/bitmap.h:527:25: note: each undeclared identifier is reported only once for each function it appears in
> include/linux/bitmap.h: In function 'bitmap_find_free_region':
> include/linux/bitmap.h:554:17: error: 'ENOMEM' undeclared (first use in this function)
>   554 |         return -ENOMEM;
>       |                 ^~~~~~
> 
> This is easily avoided by changing linux/buildid.h to no longer depend on
> linux/mm_types.h, a header that pulls in a huge number of indirect dependencies.
> 
> Fixes: b9c957f554442 ("bitmap: move bitmap_*_region() functions to bitmap.h")
> Fixes: bd7525dacd7e2 ("bpf: Move stack_map_get_build_id into lib")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Yury Norov <yury.norov@gmail.com>

Would you like me to add this into bitmap-for-next?

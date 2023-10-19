Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F977CFEDE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346466AbjJSP63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346427AbjJSP61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:58:27 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B7993;
        Thu, 19 Oct 2023 08:58:25 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7c011e113so108724797b3.1;
        Thu, 19 Oct 2023 08:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697731105; x=1698335905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7jb7cVwz7xelM4+sJnE1FJPyDzq0ARx8q1t+hCEl6P4=;
        b=fxdoIhCVxOmqlycuBzp05lAt82uD8dvNtqOLLX1u2d9kAj+YXeIGgc4o4fXZ0nHMPW
         3fvloCoDl5u8VDFEK9xesdYmEtZntxEzL3xVtPA0RiMXngf6UjUEXPIZfSVOzFy5kV8y
         5jh7elFwN8TAXnO/+fUzWv9hyTU4SmM4L+mEdnvt5ZByyCvGKQH1/FvuvoxmHFkyULrY
         VBrDxTH9d4bY2NsLli7EMJ+CKDRzsWoE2mIuvtZkfm/ugbrlEOB7ffNjeKPTFZkvmz4H
         5Q1ycfPRWCr4wdpQxMhN+omLAGCjZ4BeBucOD0HM0Q+dzDikrQ9GyZ2897jxpfwJoU77
         QmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697731105; x=1698335905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jb7cVwz7xelM4+sJnE1FJPyDzq0ARx8q1t+hCEl6P4=;
        b=HM2+8RUCgn/Tvck+DajDkhWsS8DQ19trHD9iX38epSYNymt4CiCz8tluQYc1IgmPjr
         V7MNw6PhvwbLixZHm2txEk2GrqdMjV679HrfYtS05rxlifau6+UjKxxdW3lhMb1ALXil
         U+aBjH0jm2Br+jHG23OBRT5pYJXs4Xo1ADE1hGeg+eof9w/z9Idvn63hjfT3Rcg8jMdN
         9HFEq7faRudJ1AdYCW2y2bMCF0pzOakfCDdrGtbdkP7EUn3TqVuXxvm/7OozZLlkDEic
         N1uqA/f6XS7Ou7XWfUjuC9EuB8i+Sy7WT2txNzTN7u2q0HCYXBGGxASEkcuRu+eatgMs
         IW2g==
X-Gm-Message-State: AOJu0YwEU7uxbZuY3v29ABtFP4WBTE39lrQiALntu7SVtrqJl6vVowAm
        sw0OKwlmmRpT824dMuawlnyVas9Rdp+d6A==
X-Google-Smtp-Source: AGHT+IGDu+aE+ue7JW/hGbmDvvQMifgSbMmwHbCyYnoCWuWdSEcUw2tVUhh4HjszQKCnItYcP2tmPQ==
X-Received: by 2002:a0d:e60a:0:b0:5a8:1d44:256 with SMTP id p10-20020a0de60a000000b005a81d440256mr2810943ywe.7.1697731104773;
        Thu, 19 Oct 2023 08:58:24 -0700 (PDT)
Received: from localhost ([2607:fb90:3e1a:8bc6:3ebc:e0b2:cf57:8294])
        by smtp.gmail.com with ESMTPSA id t70-20020a818349000000b0059b4e981fe6sm2494749ywf.102.2023.10.19.08.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 08:58:24 -0700 (PDT)
Date:   Thu, 19 Oct 2023 08:58:22 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bitmap tree
Message-ID: <ZTFSHqjkHLM5iAqH@yury-ThinkPad>
References: <20231019170106.4159eac5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019170106.4159eac5@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 05:01:06PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the bitmap tree, today's linux-next build (native perf)
> failed like this:
> 
> In file included from /home/sfr/next/next/tools/perf/util/header.h:10,
>                  from /home/sfr/next/perf/pmu-events/pmu-events.c:3:
> /home/sfr/next/next/tools/include/linux/bitmap.h:5:10: fatal error: linux/align.h: No such file or directory
>     5 | #include <linux/align.h>
>       |          ^~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   ed46ac8199f0 ("bitmap: introduce generic optimized bitmap_size()")
> 
> I have used the bitmap tree from next-20231018 for today.

Thanks, Stephen. I'll take a look and let you know when it's resolved.

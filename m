Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EED80C183
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 07:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbjLKGu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 01:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjLKGu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 01:50:57 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEECED7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 22:51:03 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b88f2a37deso3295116b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 22:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702277463; x=1702882263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YctzTYntyd51jqXxmWwWW3nRDYDfU3b8oocrWrVlruk=;
        b=PbmooSSiw9uJ4wc+pUMLVMJ+tzGzc27nYJ6LbWqBlcYDkBuvMvj+9xItsnmqrY9n7L
         /E6O7XMaASy4EWQT6CgjHt/1XZ0MJyP3dv41v2IGdGkHiUbR2cidGgVgiD/Dk2opEgb+
         VdONGiDy5Xhii9oOF44DW2jNY9voV4VAGJR5+GsjZICyy6YFb8ix+RYWh/DeqoeDFUUs
         StyPig433YmVHsvpH4ghxeGQXhVx0PvImf90XEKy+KHsc9Ts5V+lL0mbAC0vpfyLzt3w
         6WQ/ilF31Sp6I8zIMP1/fICUEus6WeYh72wqhLG+Fq2fMR3f6isMOwmck7n8qP0Lcl13
         ufMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702277463; x=1702882263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YctzTYntyd51jqXxmWwWW3nRDYDfU3b8oocrWrVlruk=;
        b=MYUhceb6XGX2QsNCOl7Gx/+PZGyNLv9MwdrQVOppuhw7EcaXaaADJcOrBkGyWRk0iI
         rnYVFHSJDhKid1lpAEZi7nEeBZdFy0cMjC3pXEG2YDqHT9tFUfsnJZ1rypb4kolEJCLy
         2AKuD6h4iUtArZSV8ZnlTMEiJl1akpe1456eIwJdiPguTOmv7mHjtlYni6SbWtZlDdCz
         YnS0IJlAkuukGgdHxpYKbDIRBhurXjOK3Ct+6GPC9yCMHYSGbnBZ+WYi3iauCApuXiwd
         yJHg6mDl4k5nS44csy0XKzdwBOM9eMJYRu74qmO6/mK/H0EnltrNGDbsiKRGERugc/+v
         U7GA==
X-Gm-Message-State: AOJu0YzoIn5k3MwN1WkHyHOHRvYXmBD2dFpL51Inspf7P0ssRWMZBkTH
        j/rcSA1Hl1AbYCTl8rcm7Bs=
X-Google-Smtp-Source: AGHT+IGeRQ1ftbcejenpH4uWLA+egcIaOW1gMT6Mg14LZVgPoMPZGIReGmd8m7mRuhAK6i30LrPfhQ==
X-Received: by 2002:a05:6808:208a:b0:3b9:f08f:6846 with SMTP id s10-20020a056808208a00b003b9f08f6846mr5059593oiw.18.1702277462917;
        Sun, 10 Dec 2023 22:51:02 -0800 (PST)
Received: from localhost ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id 64-20020a630043000000b005c65d432119sm5533968pga.67.2023.12.10.22.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 22:51:02 -0800 (PST)
Date:   Mon, 11 Dec 2023 14:50:57 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        huyue2@coolpad.com
Subject: Re: [PATCH 0/5] erofs: basic sub-page compressed data support
Message-ID: <20231211145057.000067eb.zbestahu@gmail.com>
In-Reply-To: <20231206091057.87027-1-hsiangkao@linux.alibaba.com>
References: <20231206091057.87027-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Dec 2023 17:10:52 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi folks,
> 
> Recently, there are two new cases so that we need to add a preliminary
> sub-page block support for compressed files;
> 
>  - As Android folks requested, Android ecosystem itself is now switching
>    to 16k page size for their arm64 devices.  They needs an option of
>    4k-block image compatibility on their new 16k devices;
> 
>  - Some arm64 cloud servers use 64k page size for their optimized
>    workloads, but 4k-block EROFS container images need to be parsed too.
> 
> So this patchset mainly addresses the requirements above with a very
> very simple approach as a start: just allocate short-lived temporary
> buffers all the time to keep compressed data if sub-page blocks are
> identified.  In other words, no inplace/cache decompression for
> the preliminary support.
> 
> This patchset survives EROFS stress test on my own testfarms.
> 
> Thanks,
> Gao Xiang
> 
> Gao Xiang (5):
>   erofs: support I/O submission for sub-page compressed blocks
>   erofs: record `pclustersize` in bytes instead of pages
>   erofs: fix up compacted indexes for block size < 4096
>   erofs: refine z_erofs_transform_plain() for sub-page block support
>   erofs: enable sub-page compressed block support
> 
>  fs/erofs/decompressor.c |  81 +++++++++------
>  fs/erofs/inode.c        |   6 +-
>  fs/erofs/zdata.c        | 224 ++++++++++++++++++----------------------
>  fs/erofs/zmap.c         |  32 +++---
>  4 files changed, 169 insertions(+), 174 deletions(-)
> 

Reviewed-by: Yue Hu <huyue2@coolpad.com>

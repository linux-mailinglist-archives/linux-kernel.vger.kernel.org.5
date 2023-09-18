Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7517A5247
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 20:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjIRSpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 14:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjIRSpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:45:36 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B26F7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:45:30 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c1e3a4a06fso37661955ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695062730; x=1695667530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbv6kYF5LAnBAKfQVCXWbWgoEDd6+dn0k6YSe4iFkVc=;
        b=Di/0d3bU9RLhwtZcLEupgy/Zc4xtQ9gYQnS+evvdrJgdlyg37iWcD0rG+esF2bEAeQ
         f6NwPPQHBaQQq6pru2CCC6g4O+GnnRmNgLFinBFlaVdmNkAGWHZjQRMyhy/i/HBh9eWt
         EagbsOOSOGbsdeOTD+mc1AVooT7z5G+poyrU7nEUiGDYebkdxXrGi/lodAsJFQ8W+VbH
         DeZF29SkKHT0Tk0gMj72tNBaRDAz7hBp0NZLrtMyhqc59Fb9wcLbJXIb/phz1baX13iT
         A/HvsNYpCS2RP7O32y2ytvcF7gcQ+tCukWTIbPTXPSFusBu5TG/noX8Lw9a4opitkwig
         N7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695062730; x=1695667530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbv6kYF5LAnBAKfQVCXWbWgoEDd6+dn0k6YSe4iFkVc=;
        b=lfmfHPhIB2m9SE+qd9O3MTMrMIkZcY9IPAZo/eF6fbKhLrX8AZB6f4k+s/zDaTwT9s
         yRqukREFu66l+Ax2hQs8NtA8UFg+3W68Lkwpq+THHxyguN6809znZDMnze2NOqB54hB3
         +AfN4vq/d2f3nkUtnTukwyWX+ukJ0U+5nvag6JwrJ6L1nYIgO33dKBvwtogMPQYPcSSl
         7i0giMqKbPd4G53rsWdx+X4DJWZM09GBX1Ka/1ARQtC0v7B/2poQeMRAOE3a3AAudyzS
         an7jVhc+nt1EAZoZClK79sjhtFLfHl2lJdLEAX8zAfWitlzacLkWxzykl8+lM1rdA3mx
         wTeQ==
X-Gm-Message-State: AOJu0YwVVEgUjKk+flxqY6496XyV20WFoWUVayUnMZ/xJrcjQiWzhOjh
        wrz40RBnHbuiiQl4gVbN77s=
X-Google-Smtp-Source: AGHT+IGUV+snAQ6I+fWfYugR+mHtc7WKVQg38GNKD89+yrJapDUlB6WKJ7W1y+MlJfSGRp7BWH4l5Q==
X-Received: by 2002:a17:903:11c8:b0:1c3:e30f:6c82 with SMTP id q8-20020a17090311c800b001c3e30f6c82mr9408861plh.53.1695062730362;
        Mon, 18 Sep 2023 11:45:30 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id f15-20020a170902ce8f00b001bf6ea340a9sm8598702plg.159.2023.09.18.11.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 11:45:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 18 Sep 2023 08:45:28 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, dhavale@google.com
Subject: Re: [PATCH] workqueue: Remove duplicate worqueue attributes
 allocation
Message-ID: <ZQiayAKAW6sjseiR@slm.duckdns.org>
References: <20230906173904.475722-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906173904.475722-1-catalin.marinas@arm.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 06:39:04PM +0100, Catalin Marinas wrote:
> Commit 84193c07105c ("workqueue: Generalize unbound CPU pods")
> inadvertently introduced another call to alloc_workqueue_attrs()
> overriding the pointer returned by a previous alloc_workqueue_attrs() a
> few lines up in workqueue_init_early(). This leads to a kmemleak report:
> 
> unreferenced object 0xffff000040015000 (size 96):
>   comm "swapper/0", pid 0, jiffies 4294892296 (age 163.956s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 03 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000004cec0d50>] __kmem_cache_alloc_node+0x1c4/0x288
>     [<0000000083361c2a>] kmalloc_trace+0x20/0x2c
>     [<000000005ca61f11>] workqueue_init_early+0xe4/0x538
>     [<000000004e6ea358>] start_kernel+0x23c/0x5ec
>     [<00000000aea9761e>] __primary_switched+0xbc/0xc4
> 
> Remove the first allocation.
> 
> Fixes: 84193c07105c ("workqueue: Generalize unbound CPU pods")
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Tejun Heo <tj@kernel.org>

Another version of this patch has been applied to wq/for-6.6-fixes.

Thanks.

-- 
tejun

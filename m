Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9487C6517
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377222AbjJLGFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347056AbjJLGFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:05:41 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE12FB8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:05:39 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9ad8a822508so95415166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697090738; x=1697695538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6+tUEwF6pcJYAqf/O6p5eFLhqtxhgC28nH250Kt/jw=;
        b=NPljBLvpTUo2XtlGj3Ykeg6HRrOK/u3joXiiLw2s6U+wPhdp4y+TSNC0trBT8n0I/6
         slBu93zifAYvmYSiw+jlz9PvlO+AqWdsIJHPGokkRTFnFp4DVhEh8+A24iUI6YjDD9h7
         ulmI5rbp7daSt9cLZ3zzrCvSMaNgytmHvZa/sbUt5WjhxcEneZoVfwWCQdIlvlvfOlXC
         SEmWrckPCBBxote5OnZE2UUNKVnz341Db1aF7lgCKB7rUJH5a87Z+V4MmVcSUYz6Z11H
         cuK7Qz5bB87sB2XREgDyqzogkcq60XTdCGQ6eJaNCv9Klhq+QA6DNzYxHYKPuAZwGEZG
         nyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697090738; x=1697695538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6+tUEwF6pcJYAqf/O6p5eFLhqtxhgC28nH250Kt/jw=;
        b=Hdg3BWKZ0KWGw2SM7gyZSL190YRATSHktBYjTCTNBLJepTseExLfDZqBLD5DtpkufI
         iKnlSPqXX+f8Y07q0ZsLGx6KDTjqkI8SNUdugnbux25+3qZ87LbOTVEbkwF3sYC5ECUg
         nw50pHwO083B1qPBecE9JkiGvSbsCtpX6w0vCRNmSrxHPicCeHnBQF54/vG+LkgsMx7o
         oNGAIXYFKk3uQbYVpc984l8gNiWm/WuR1zjSX1xOGLphM6fzjeQ0OKVjrEOnp16qiG/0
         zr0FsxnTvD2wDP3BFjMbIwbKxnKp1tuVyAGopZBgpCr9tc/kL7ZYzih9bsHPap1ORd6r
         stAg==
X-Gm-Message-State: AOJu0YzaAjzB8ZAqDlN+6AP2+6JJx8a0G5q8IFxSSoPkAPjpDy9oCFsM
        1n7QBsBU31djtLDplm+DpAM=
X-Google-Smtp-Source: AGHT+IFyQ6YCC6lvsh6nJgg1h6Fm+pdRmGGsjEg0YKoVU2Ucn9f6dqQuFuoCpxFWvGOrK98ZgBNtWQ==
X-Received: by 2002:a17:907:75f7:b0:9a1:c9c5:5fa1 with SMTP id jz23-20020a17090775f700b009a1c9c55fa1mr20807055ejc.4.1697090738286;
        Wed, 11 Oct 2023 23:05:38 -0700 (PDT)
Received: from gmail.com (1F2EF405.nat.pool.telekom.hu. [31.46.244.5])
        by smtp.gmail.com with ESMTPSA id t27-20020a1709063e5b00b009a168ab6ee2sm10619139eji.164.2023.10.11.23.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 23:05:37 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 12 Oct 2023 08:05:35 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        tj@kernel.org, mingo@redhat.com
Subject: Re: [PATCH RFC 1/5] mm/numa: move numa emulation APIs into generic
 files
Message-ID: <ZSeMr2BB6odoWrg+@gmail.com>
References: <20231012024842.99703-1-rongwei.wang@linux.alibaba.com>
 <20231012024842.99703-2-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012024842.99703-2-rongwei.wang@linux.alibaba.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Rongwei Wang <rongwei.wang@linux.alibaba.com> wrote:

> In order to support NUMA EMU for other
> arch, some functions that used by numa_meminfo
> should be moved out x86 arch. mm/numa.c created
> to place above API.
> 
> CONFIG_NUMA_EMU will be handled later.
> 
> Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
> ---
>  arch/x86/include/asm/numa.h |   3 -
>  arch/x86/mm/numa.c          | 216 +-------------------------
>  arch/x86/mm/numa_internal.h |  14 +-
>  include/asm-generic/numa.h  |  18 +++
>  mm/Makefile                 |   1 +
>  mm/numa.c                   | 298 ++++++++++++++++++++++++++++++++++++
>  6 files changed, 323 insertions(+), 227 deletions(-)
>  create mode 100644 mm/numa.c

No objections to moving the x86 NUMA emulation code to mm/numa.c, as long 
as it stays similarly functional:

   Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo

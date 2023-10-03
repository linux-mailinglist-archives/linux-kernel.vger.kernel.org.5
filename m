Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F214C7B6DE4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjJCQBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240359AbjJCQBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:01:22 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D8CEC;
        Tue,  3 Oct 2023 09:01:10 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DBEDE381;
        Tue,  3 Oct 2023 16:01:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DBEDE381
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1696348870; bh=EpyLs4lsrZHJbC0qMYKz8v34Lo8wvUXgTn477O0Szvo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=g3Vu4iGbl2cYpJma4oSsql3OoZDPYRrxvGVMg41VJjv+pQHYPKrrY1+ke9WKjJAXd
         yPdLpHMN2ugzsFFyfL9Fvc+/mc/129l5gDnsYF1BXR3b5dQ2SIL2xoBrArhZ9LQsou
         CaS5AYl7s5uddJ7hLRb3ZcM2pvncB4N8K42794Qg9joYFrp57GHkwDTkvHZF0sreyr
         gJdcOKhJcCRJFsDQUNyGAz9oY9AUirRJpeF4uZ9PF8OFwCR5oDSWrcfqHQItcNPjo0
         LKhQd3lz5T3kAccFmGWmOA+wN95QFQsBJjozpuDZFatcWkq1Ew3vl+TemPx/ulpgQr
         NM8zujZjHcLHA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mike Rapoport <rppt@kernel.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3] Documentation/page_tables: Add info about MMU/TLB
 and Page Faults
In-Reply-To: <20230904180111.GG3223@kernel.org>
References: <20230818112726.6156-1-fmdefrancesco@gmail.com>
 <20230904180111.GG3223@kernel.org>
Date:   Tue, 03 Oct 2023 10:01:09 -0600
Message-ID: <87h6n7elve.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Rapoport <rppt@kernel.org> writes:

> On Fri, Aug 18, 2023 at 01:19:34PM +0200, Fabio M. De Francesco wrote:
>> Extend page_tables.rst by adding a section about the role of MMU and TLB
>> in translating between virtual addresses and physical page frames.
>> Furthermore explain the concept behind Page Faults and how the Linux
>> kernel handles TLB misses. Finally briefly explain how and why to disable
>> the page faults handler.
>> 
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Ira Weiny <ira.weiny@intel.com>
>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Mike Rapoport <rppt@kernel.org>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

I've applied this, thanks; sorry for the delay,

jon

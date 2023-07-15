Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6296D7546BE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 06:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjGOEH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 00:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjGOEH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 00:07:28 -0400
Received: from out-55.mta1.migadu.com (out-55.mta1.migadu.com [95.215.58.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D42835A9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 21:07:24 -0700 (PDT)
Date:   Sat, 15 Jul 2023 13:07:13 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689394042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U2Q7rt32186jYQFvLUEX++gzKm12n7FO2FEO9lwjWmk=;
        b=DT9marXLx4M1KVinOFTWRRs5dX/E24SD5s4hwxm+uHKeuIyMfuNOmRK5HwMF1kHveBDm/N
        ibJyvwV8VZD2jd9WyRIXHobeWUJ4P1YNav1dsyFMLcpveLmDEKUIrzIM7p2WKVdE7bYj1r
        YDPx0NaI6zxR+0xRytxg5LwS/Z43dEU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Jiaqi Yan <jiaqiyan@google.com>
Cc:     naoya.horiguchi@nec.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH v1] mm/hwpoison: rename hwp_walk* to hwpoison_walk*
Message-ID: <20230715040713.GA2352837@u2004>
References: <20230713235553.4121855-1-jiaqiyan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230713235553.4121855-1-jiaqiyan@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 11:55:53PM +0000, Jiaqi Yan wrote:
> In the discussion of "Improve hugetlbfs read on HWPOISON hugepages",
> Matthew Wilcox suggests hwp is a bad abbreviation of hwpoison, as hwp
> is already used as "an acronym by acpi, intel_pstate, some clock
> drivers, an ethernet driver, and a scsi driver"[1].
> 
> So rename hwp_walk and hwp_walk_ops to hwpoison_walk and
> hwpoison_walk_ops respectively.
> 
> raw_hwp_(page|list), *_raw_hwp, and raw_hwp_unreliable flag are other
> major appearances of "hwp". However, given the "raw" hint in the name,
> it is easy to differentiate them from other "hwp" acronyms. Since
> renaming them is not as straightforward as renaming hwp_walk*, they
> are not covered by this commit.
> 
> [1] https://lore.kernel.org/lkml/20230707201904.953262-5-jiaqiyan@google.com/T/#me6fecb8ce1ad4d5769199c9e162a44bc88f7bdec
> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>

Looks good to me.  Thank you.

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

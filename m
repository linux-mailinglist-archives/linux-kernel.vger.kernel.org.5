Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713087CD1D4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 03:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjJRBd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 21:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjJRBd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 21:33:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0269F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 18:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697592837; x=1729128837;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=dcthwkrgfbwxnN6CG1f1RDJ8t57qqEiy/CPaImoH/4U=;
  b=Z+h6bbsVgDcUSLoyQdgvnblxVRz85ak914FL2zGriF2ND3KOWp5gqWq6
   pV6ZQRlylZsqlfcXjPfGGdlpgI4YJNZHnhc7Boh1ri++r16uRm8R+9t4z
   V4Uf+N+WX6PkJf6VB4Nefv1AYEjwLJuwT9kauXzlkK++7+cbHEBVNcaQI
   V63pG/u8IGXXgX01zyuDeajelKfj9yknQBUmt3KqoaIR3WUiu3YO/omED
   xntYCA0B4wLC1/DYD9btpGGqhm/MIZ8NeFJiGuvqz+mWsJlWglwRvRYTV
   Au/pCC+uwAnVVhucYf4QCTsFQe6R2rCpj4UU84yVSY9I8n7vPql+hjLXd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="7467808"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="7467808"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 18:33:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="4150163"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 18:32:41 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Zi Yan <zi.yan@sent.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH v3 2/2] mm/migrate: add nr_split to
 trace_mm_migrate_pages stats.
In-Reply-To: <20231017163129.2025214-2-zi.yan@sent.com> (Zi Yan's message of
        "Tue, 17 Oct 2023 12:31:29 -0400")
References: <20231017163129.2025214-1-zi.yan@sent.com>
        <20231017163129.2025214-2-zi.yan@sent.com>
Date:   Wed, 18 Oct 2023 09:31:46 +0800
Message-ID: <871qds90n1.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zi Yan <zi.yan@sent.com> writes:

> From: Zi Yan <ziy@nvidia.com>
>
> Add nr_split to trace_mm_migrate_pages for large folio (including THP)
> split events.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>

LGTM, Thanks!

--
Best Regards,
Huang, Ying

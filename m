Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD70980950B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 23:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444043AbjLGWFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 17:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444011AbjLGWE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 17:04:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C1910F9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 14:05:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51111C433CA;
        Thu,  7 Dec 2023 22:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701986704;
        bh=VF0YghL2e/It2h2ApBiu9rYOAhcMD7QfN4kDlgcdsy0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q7g/yzRmKS/evTNuSMWY933klLoiOzH9buF9+E4U6C4SyfQu9tME6ZdXS/WYufNg8
         sXj2dUuBnWymH2oMrT0EyfV+WScjIhEjpgSNy8eEVZY1jqQP+l0HTYQ4J8y/ISQoB6
         0ySrJ9S1PEQY2XDilFHHeU+ZKttStOAOSAMrhR4U=
Date:   Thu, 7 Dec 2023 14:05:02 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 00/10] Multi-size THP for anonymous memory
Message-Id: <20231207140502.e7dff5d1cfb195b1644b61a5@linux-foundation.org>
In-Reply-To: <20231207161211.2374093-1-ryan.roberts@arm.com>
References: <20231207161211.2374093-1-ryan.roberts@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Dec 2023 16:12:01 +0000 Ryan Roberts <ryan.roberts@arm.com> wrote:

> Hi All,
> 
> This is v9 (and hopefully the last) of a series to implement multi-size THP
> (mTHP) for anonymous memory (previously called "small-sized THP" and "large
> anonymous folios").

A general point on the [0/N] intro.  Bear in mind that this is
(intended to be) for ever.  Five years hence, people won't be
interested in knowing which version the patchset was, in seeing what
changed from the previous iteration, etc.  This is all important and
useful info, of course.  But it's best suited for being below the
"^---$" separator.

Also, those five-years-from-now people won't want to have to go click
on some link to find the performance testing results and suchlike. 
It's better to paste such important info right into their faces.




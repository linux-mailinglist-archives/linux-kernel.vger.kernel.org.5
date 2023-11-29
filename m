Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3479B7FD134
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjK2InV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjK2InT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:43:19 -0500
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36E0DA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:43:24 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701247402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D53Eo7p+I9EijT/8/6lRPHIUmhfVvlI4ciXwep/Pox8=;
        b=Es3apN6EVFzZ+ZqxwH+3CZGzMCDGnJ+4oIB26zIKYBm7+hKtdKbqOMMi3YdIX5ZPci0qnK
        5jdpZx/sQV6pD5H7Sv5s6odyhd6mj47mOq3ER8Hj9VOfyKqMCAjO55yWPo5QghsCCNVuRg
        rszvPMiHWe/uni8Y9l4q2jrs+gpH1uw=
Mime-Version: 1.0
Subject: Re: [PATCH v1 1/5] mm/rmap: rename hugepage_add* to hugetlb_add*
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20231128145205.215026-2-david@redhat.com>
Date:   Wed, 29 Nov 2023 16:42:41 +0800
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Transfer-Encoding: 7bit
Message-Id: <D65284E8-7201-4D20-B7B6-06E9AB9DD9F1@linux.dev>
References: <20231128145205.215026-1-david@redhat.com>
 <20231128145205.215026-2-david@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 28, 2023, at 22:52, David Hildenbrand <david@redhat.com> wrote:
> 
> Let's just call it "hugetlb_".
> 
> Yes, it's all already inconsistent and confusing because we have a lot
> of "hugepage_" functions for legacy reasons. But "hugetlb" cannot possibly
> be confused with transparent huge pages, and it matches "hugetlb.c" and
> "folio_test_hugetlb()". So let's minimize confusion in rmap code.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.


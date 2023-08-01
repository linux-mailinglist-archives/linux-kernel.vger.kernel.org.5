Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACB776A6BD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 04:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjHACHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 22:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjHACHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 22:07:13 -0400
Received: from out-95.mta0.migadu.com (out-95.mta0.migadu.com [91.218.175.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E302D103
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 19:07:11 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690855630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PqpRqCpJRXVYgSygnznRVukNjegrIqGs1yZ4E0QRWF0=;
        b=EiK4EzOoRJDRGuyzpeBS3GmvJdD4ZszfrlOj1Vig82cKRQ9Z9LmHThWq4CAN0g5IeCvRGf
        uIJspmrFEXJgya2VW9nRT3Vm0zhlUDFDTITZJ2kggph5je1Q+KoS2tQqMo9dwqR535mFV1
        aejHWka5QY9YWspOn0b/bj4hrggcYuI=
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] mm: hugetlb: use flush_hugetlb_tlb_range() in
 move_hugetlb_page_tables()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230731074829.79309-2-wangkefeng.wang@huawei.com>
Date:   Tue, 1 Aug 2023 10:06:30 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mina Almasry <almasrymina@google.com>, kirill@shutemov.name,
        joel@joelfernandes.org, william.kucharski@oracle.com,
        kaleshsingh@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F5B7D95C-50C3-4DFF-B412-D8FD0894E9C9@linux.dev>
References: <20230731074829.79309-1-wangkefeng.wang@huawei.com>
 <20230731074829.79309-2-wangkefeng.wang@huawei.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
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



> On Jul 31, 2023, at 15:48, Kefeng Wang <wangkefeng.wang@huawei.com> =
wrote:
>=20
> Archs may need to do special things when flushing hugepage tlb,
> so use the more applicable flush_hugetlb_tlb_range() instead of
> flush_tlb_range().
>=20
> Fixes: 550a7d60bd5e ("mm, hugepages: add mremap() support for hugepage =
backed vma")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Acked-by: Muchun Song <songmuchun@bytedance.com>



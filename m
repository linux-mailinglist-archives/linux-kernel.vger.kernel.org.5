Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0707F63AC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344958AbjKWQKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjKWQJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:09:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D7B1B3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700755805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lyyvUshat2fP97k91On5bJICBhysTXujJ3DjXRepMqQ=;
        b=HM7aL4UdaJPN9kzsTjsx5lIWD5RI+bdsfJ8UVtsa8f+UdCQWXZAvDCN7gCK6wA1arHTo7u
        O6dUWlo0lBbECk7axSFZGdDzO9ElZQdu5z4VIXojQHSMjySUtMxvU15bCUadoSWD9adxdL
        GhOUaWj24Drwyw90iMUzhifIUqJt0J0=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-c2vJVXAvP1yB1jlI15ITpA-1; Thu, 23 Nov 2023 11:10:03 -0500
X-MC-Unique: c2vJVXAvP1yB1jlI15ITpA-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-58737e284f4so175283eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:10:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700755803; x=1701360603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyyvUshat2fP97k91On5bJICBhysTXujJ3DjXRepMqQ=;
        b=iGn7UWcf1rgqSv+W0mvdPjGdh2dix3jjF8Ys8O92FRmjAiWbCWAJlbUTQqq0Z8adsZ
         aPNB03ZAKKshwe4yjNcqUbyoF75yGMYag7uQ9+5qAfBkvQU4q0rF5RKE/OweAg4JSyOQ
         gwu83td5hXlFls3ZnAdOzQpR+1tlrI8bnE2jW4gNIw5fDoa5/ko6lynEV5vCmhvRt/hy
         +7I+wdBJmz1xX6aL6jcrC7yLyO11rA/gHFpA2GHLOfLEfKJUygRkTjifZFlMZ6VUfTe0
         ujYkTIcljqx/mP0WaK8c9351DzsmPYbDC/Wv3lqfKyBGuhog6vwbMwxATpDr6nb3cWE7
         q+Dw==
X-Gm-Message-State: AOJu0YzbQ3OE/7kNpJhXCglQlSezevFKCZ/8LTxlnmfWFtzgXa9dnWZM
        5Ex6bInmmIlPCFu1MlzPBpZ8Y0o984u64TTiXTvsM2Gu1NTmS/bDvRADFfyz7cZ7rHAGv8+aghE
        NXt8mmZgu1cAhN47pbsyloz3N
X-Received: by 2002:a05:6820:e83:b0:58c:ec4c:fcac with SMTP id em3-20020a0568200e8300b0058cec4cfcacmr101160oob.0.1700755803128;
        Thu, 23 Nov 2023 08:10:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmNivlTtEAEu+zMS1dFz7ndggAjtVDuraohs+wBqkFwHApZkIGKcw15xm/6f8/7NUn+ypweg==
X-Received: by 2002:a05:6820:e83:b0:58c:ec4c:fcac with SMTP id em3-20020a0568200e8300b0058cec4cfcacmr101137oob.0.1700755802907;
        Thu, 23 Nov 2023 08:10:02 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id a24-20020a0ca998000000b00677a12f11bcsm625712qvb.24.2023.11.23.08.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 08:10:02 -0800 (PST)
Date:   Thu, 23 Nov 2023 11:10:00 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, Mike Rapoport <rppt@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH RFC 06/12] mm/gup: Drop folio_fast_pin_allowed() in
 hugepd processing
Message-ID: <ZV95WMqoZzchrcBY@x1n>
References: <20231116012908.392077-1-peterx@redhat.com>
 <20231116012908.392077-7-peterx@redhat.com>
 <ZVsYMMJpmFV2T/Zc@infradead.org>
 <ZVzT5_3Zn-Y-6xth@x1n>
 <ZV21GCbG48nTLDzn@infradead.org>
 <ZV4co7wcI-_wK91F@x1n>
 <ZV79jpaeiiN2tGm/@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZV79jpaeiiN2tGm/@infradead.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 11:21:50PM -0800, Christoph Hellwig wrote:
> That alone sounds like a good reason to not bother.  So unless more
> qualified people have a different opinion I'm fine with this patch
> as long as you leave a comment in place, and ammend the commit message
> with some of the very useful information from your mail.

Will do, thanks.

This is what I will squash into the same patch in the new version, as the
current plan:

+/*
+ * NOTE: currently hugepd is only used in hugetlbfs file systems on Power,
+ * which does not have issue with folio writeback against GUP updates.
+ * When hugepd will be extended to support non-hugetlbfs or even anonymous
+ * memory, we need to do extra check as what we do with most of the other
+ * folios. See writable_file_mapping_allowed() and folio_fast_pin_allowed()
+ * for more information.
+ */
static int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
                unsigned int pdshift, unsigned long end, unsigned int flags,
                struct page **pages, int *nr)

-- 
Peter Xu


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F6F7F32F9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbjKUP7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbjKUP7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:59:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3DD192
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700582381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JLQMSJj5cT+I2UqS+X9OetiKtxPgKmgg9Mky3rgL5p8=;
        b=CrAFxo+ydw8C6CbTxUbBIaihHmYR6ig8k/MtfOpRtrd0RljEr+Ya2KItvfoyWQHbsGdFtN
        h2noGDl4792ZLDm2wOTIapJbDdaB7q9k1gDawGnwsUJY0g1HMu2vLOKe0bGvy8PMMPFRSu
        2THHOi/MDiY/3nxa2HMeRhO6qNkJ++A=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-Oi8ycVwbPAKbbjhtboo03g-1; Tue, 21 Nov 2023 10:59:39 -0500
X-MC-Unique: Oi8ycVwbPAKbbjhtboo03g-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6716c2696c7so15014396d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:59:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700582379; x=1701187179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLQMSJj5cT+I2UqS+X9OetiKtxPgKmgg9Mky3rgL5p8=;
        b=SvUKpvbJS+u7HYSrHK5/3L+uf5aBTfXEzyM4QJHKorBDNSyBGR/SAySWuP5IcbjmrX
         aZQXz9GCNHPd4uhswaVdXbdSh85kKyfRYvdDzC2wLMiZpvqFPQT9cGFSS2FQcfcD16I8
         Vqtz913x82/xoDTW2Pg7N7930PWxwjdmtPqu6iI51a4gPVT/rsCzMWDwObJ0S62AnFlw
         pXOz3pC/y1Y7RAo1jvOEVMo6iX9KN0WyqwrM07HCnTi39sxIxvR/Cf20nScg1rs9GAWp
         qeYRijnrU51dcphavmh1ci2sP7ypb9m8ZusC5ZwGCAskv+L4K5S5Xw9Ts791C7PAYFyw
         PeBQ==
X-Gm-Message-State: AOJu0YwnHxyfVVG8LzQTLOqd2qeF70gwhR4oTAmcCr9jLAoMDgyXSN3J
        F0Mex+vmjDzcfcRR5vQNWB5mmu6pdsLDira+UtXJVIIRnLy5rd8+CfldvLCKm8g7NwAJFsgfzQY
        2ESyIb5ceED2FKYREy9SW597W/U+rzOz7
X-Received: by 2002:a0c:c582:0:b0:66d:1012:c16a with SMTP id a2-20020a0cc582000000b0066d1012c16amr10534463qvj.1.1700582378837;
        Tue, 21 Nov 2023 07:59:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9jPSayCUuCFnqS3WxavS9ST6O5WwQE1cldTJjdWqW9XI/Aaj5okJ+Mn7wuuqXunOLRSa0AQ==
X-Received: by 2002:a0c:c582:0:b0:66d:1012:c16a with SMTP id a2-20020a0cc582000000b0066d1012c16amr10534438qvj.1.1700582378610;
        Tue, 21 Nov 2023 07:59:38 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id a12-20020a0562140c2c00b00679d9547310sm2051153qvd.31.2023.11.21.07.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 07:59:38 -0800 (PST)
Date:   Tue, 21 Nov 2023 10:59:35 -0500
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
Message-ID: <ZVzT5_3Zn-Y-6xth@x1n>
References: <20231116012908.392077-1-peterx@redhat.com>
 <20231116012908.392077-7-peterx@redhat.com>
 <ZVsYMMJpmFV2T/Zc@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZVsYMMJpmFV2T/Zc@infradead.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 12:26:24AM -0800, Christoph Hellwig wrote:
> On Wed, Nov 15, 2023 at 08:29:02PM -0500, Peter Xu wrote:
> > Hugepd format is only used in PowerPC with hugetlbfs.  In commit
> > a6e79df92e4a ("mm/gup: disallow FOLL_LONGTERM GUP-fast writing to
> > file-backed mappings"), we added a check to fail gup-fast if there's
> > potential risk of violating GUP over writeback file systems.  That should
> > never apply to hugepd.
> >
> > Drop that check, not only because it'll never be true for hugepd, but also
> > it paves way for reusing the function outside fast-gup.
> 
> What prevents us from ever using hugepd with file mappings?  I think
> it would naturally fit in with how large folios for the pagecache work.
> 
> So keeping this check and generalizing it seems like the better idea to
> me.

But then it means we're still keeping that dead code for fast-gup even if
we know that fact..  Or do we have a plan to add that support very soon, so
this code will be destined to add back?

The other option is I can always add a comment above gup_huge_pd()
explaining this special bit, so that when someone is adding hugepd support
to file large folios we'll hopefully not forget it?  But then that
generalization work will only happen when the code will be needed.

Thanks,

-- 
Peter Xu


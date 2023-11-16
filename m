Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7F07EE79B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 20:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345473AbjKPTkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 14:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjKPTkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 14:40:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B4F1A8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 11:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700163627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bzv535wMnAruLzQr/48/AxY7g2OnZub15Z3F0evMKPM=;
        b=Bc7Xkzk6fXiIDJypPVZ0TRP0Qejqwc8R95elAVcTDfjw3Aafawqshj1Y0SxgrjD2BzGhme
        XoNkYCLkVCzcrTSIpkd9rnTWWy4BKwwEBTUn/8q3yN+Tn4B6XDcCnU/ADOj4VBXGbI5VAf
        iiWNqwp52kUdNJAC+Dn7NwvuB4ytxIE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-CY_CXqb5MKuTEwYLUBBd2A-1; Thu, 16 Nov 2023 14:40:25 -0500
X-MC-Unique: CY_CXqb5MKuTEwYLUBBd2A-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7789a2b35f1so12997585a.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 11:40:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700163625; x=1700768425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bzv535wMnAruLzQr/48/AxY7g2OnZub15Z3F0evMKPM=;
        b=dAhYNc71MrEd3vmfMdbfEKlSwXbqyetW0FP3AgyKJhUCaUNCteVvUil924joytJE4C
         4/MpviXqnrykdD39Z6zM4tr8iUSjqRuivKg7NXtv+WAAkShFkvS9BTlt7VcFzpB7Dykw
         xAPZPJMuFOGZyFz6tpvKZPID7e7zI2Uk7jvcGB+Y8Kv3pQZkV2oNa55iBOJ0mKTe5Rp2
         PMb/CvQJ1mxczT0uBnvki7Gtj273S2HyrqkWLsKw7HhTiMb2P+KtkCY/sATvwvinn5GD
         kub/MwHsTpnUTNVX9FmGupyF+HV4wpJihRuIgEy39rATh7cgIBdE3IXdJSMgsC5mxe/R
         W+wQ==
X-Gm-Message-State: AOJu0YxO7hHz3N8M/3pXtl+EWkvo6pyUDMu9jKqmb1ZgrPa5H466uwvs
        g4j1gymWmgEW/RJdeaKjrwk1G6bIoiUQX13EltvSICFtLhcoVePx4PBSvfQANTTNnl1clb4hxq9
        vyX+eSFKcgOasZAk8J8sRsavr
X-Received: by 2002:a05:620a:3715:b0:77b:dce8:737 with SMTP id de21-20020a05620a371500b0077bdce80737mr9794667qkb.7.1700163625224;
        Thu, 16 Nov 2023 11:40:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0acypG3gt3orkwfZpo4/rFmSKRN5T9/huxRFJZfE/B/7060gtATTOv/cMrwGWBcYdUNwnHQ==
X-Received: by 2002:a05:620a:3715:b0:77b:dce8:737 with SMTP id de21-20020a05620a371500b0077bdce80737mr9794659qkb.7.1700163624980;
        Thu, 16 Nov 2023 11:40:24 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id rv4-20020a05620a688400b007756c8ce8f5sm44204qkn.59.2023.11.16.11.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 11:40:24 -0800 (PST)
Date:   Thu, 16 Nov 2023 14:40:21 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        James Houghton <jthoughton@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RFC 07/12] mm/gup: Refactor record_subpages() to find 1st
 small page
Message-ID: <ZVZwJSRYWInodpjO@x1n>
References: <20231116012908.392077-1-peterx@redhat.com>
 <20231116012908.392077-8-peterx@redhat.com>
 <ZVYsiNxXGJCk0EYs@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZVYsiNxXGJCk0EYs@casper.infradead.org>
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 02:51:52PM +0000, Matthew Wilcox wrote:
> On Wed, Nov 15, 2023 at 08:29:03PM -0500, Peter Xu wrote:
> > All the fast-gup functions take a tail page to operate, always need to do
> > page mask calculations before feeding that into record_subpages().
> > 
> > Merge that logic into record_subpages(), so that we always take a head
> > page, and leave the rest calculation to record_subpages().
> 
> This is a bit fragile.  You're assuming that pmd_page() always returns
> a head page, and that's only true today because I looked at the work
> required vs the reward and decided to cap the large folio size at PMD
> size.  If we allowed 2*PMD_SIZE (eg 4MB on x86), pmd_page() would not
> return a head page.  There is a small amount of demand for > PMD size
> large folio support, so I suspect we will want to do this eventually.
> I'm not particularly trying to do these conversions, but it would be
> good to not add more assumptions that pmd_page() returns a head page.

Makes sense.  Actually, IIUC arm64's CONT_PMD pages can already make that
not a head page.

The code should still be correct, though.  AFAIU what I need to do then is
renaming the first field of record_subpages() (s/head/base/) in the next
version, or just keep it the old one ("page"), then update the commit
message.

Thanks,

-- 
Peter Xu


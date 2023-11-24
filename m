Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E2B7F7891
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjKXQHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjKXQHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:07:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADF719A3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700842077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=suN3V9rM6JohMwlCsG7PmWxd2SZ7oRR+3sWHfaA95QU=;
        b=aIHiIM15NTT9T9qSPGtHyNmKHbZ951tQHgdH/TMWA534tG4jke0tKqBi63kdKEaRqYFCit
        Dty6Skd+31n3JdTnN6dxwct2fr+R2mYG1sheU3yMDnPM37ZCjypr77kd9CDxPzRcmCzBFP
        OPbBNdGy2QTgQzvppZ1OjghmrwHqWXI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-pweq2ToSNYqgvye9WYTjpA-1; Fri, 24 Nov 2023 11:07:55 -0500
X-MC-Unique: pweq2ToSNYqgvye9WYTjpA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-41e1d5557a9so4174921cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:07:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700842075; x=1701446875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=suN3V9rM6JohMwlCsG7PmWxd2SZ7oRR+3sWHfaA95QU=;
        b=DKvP0BVYd9Zt2zkNjkjzgyE5/1N9SwjlQbSvqpOzYqfdgbG/CPdtuMMSlr9UFiP3Hx
         qfbzoJXL1hMlKrVHJSaI26uf1jo+o/CDDwMJjjzaoSs+Pjpmq2wiVSrUGI6OG7D38dsw
         1ZjsnHPYGpPOYp7OOUE1MySfqsHZvPrgS9N8UOwkNi9vq29fE7WOB9KIz4/kLPYmRf50
         WCF3/cENYgnmtjyezU7r0Pzut038Ejl9JtGsQrZm5eTB8x6G+yba1u9Omx2rqUC92ZtU
         PK2uFGE63ySQYdhGR8cJez49FJ8Fot+CYbtDBbGAdNmU350nZnb2CLhWzRHD5WKiKc81
         ntng==
X-Gm-Message-State: AOJu0Yz1j0bz6vK0gRcHU1QQJ+okjxf3mDKIJ6WgcoNkI3FHmLsuX8g1
        2My52W4e1TxUf06FhsLtPsCKM2U6Fh+slCsCI3AbrO0/l+l2rfz4Li4TTxgUyx78k+DrG/RxbyF
        0hz+IT0ZUzeZhQbQep/fWKByH
X-Received: by 2002:a05:622a:199a:b0:421:aed7:d588 with SMTP id u26-20020a05622a199a00b00421aed7d588mr3709081qtc.5.1700842075384;
        Fri, 24 Nov 2023 08:07:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOd7ZcfkjfEnW/YGYpjdepTXsBQmefBUFY1Iktas3x8VnzCdZbnMDFzkUAABAl6vehhFBtZg==
X-Received: by 2002:a05:622a:199a:b0:421:aed7:d588 with SMTP id u26-20020a05622a199a00b00421aed7d588mr3709008qtc.5.1700842074459;
        Fri, 24 Nov 2023 08:07:54 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id cf9-20020a05622a400900b0042380fb7ba0sm275601qtb.7.2023.11.24.08.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 08:07:54 -0800 (PST)
Date:   Fri, 24 Nov 2023 11:07:51 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, Mike Rapoport <rppt@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH RFC 06/12] mm/gup: Drop folio_fast_pin_allowed() in
 hugepd processing
Message-ID: <ZWDKV0XNjplc_vUP@x1n>
References: <20231116012908.392077-1-peterx@redhat.com>
 <20231116012908.392077-7-peterx@redhat.com>
 <ZVsYMMJpmFV2T/Zc@infradead.org>
 <ZVzT5_3Zn-Y-6xth@x1n>
 <ZV21GCbG48nTLDzn@infradead.org>
 <ZV90JcnQ1RGud/0R@casper.infradead.org>
 <ZV-KQ0e0y9BTsHGv@x1n>
 <d2313c1d-1e50-49b7-bed7-840431af799a@arm.com>
 <ZV-sJsdFfXiCkylv@x1n>
 <510adc26-9aed-4745-8807-dba071fadbbe@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <510adc26-9aed-4745-8807-dba071fadbbe@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 09:06:01AM +0000, Ryan Roberts wrote:
> I don't have any micro-benchmarks for GUP though, if that's your question. Is
> there an easy-to-use test I can run to get some numbers? I'd be happy to try it out.

Thanks Ryan.  Then nothing is needed to be tested if gup is not yet touched
from your side, afaict.  I'll see whether I can provide some rough numbers
instead in the next post (I'll probably only be able to test it in a VM,
though, but hopefully that should still reflect mostly the truth).

-- 
Peter Xu


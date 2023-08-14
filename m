Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B792B77C112
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjHNTwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjHNTwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:52:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D611702
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692042693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z3GMXV7GTzcJ+82kaOlpqrV7YZHoDUobedKGKqfR/zk=;
        b=OjEfwfmpZ5O4fIMXwSgnU2AboccohDYlR1LuUg6nDEKC6SHHcTCtWbCveOLe8wzJnMWLX4
        Mo/Kb1Anroe/wdZhjpGZXBVTQGnwVRDgTsahrABf0QSiZxQ2JC+j7oyWYqaAnKXmVq+G9t
        P4fON25Z1QhIhUzm7or7iyv+uVDSsHU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-WOpT0owTPRGHeXtnijxvNg-1; Mon, 14 Aug 2023 15:51:32 -0400
X-MC-Unique: WOpT0owTPRGHeXtnijxvNg-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-40559875dd1so8877401cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692042691; x=1692647491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3GMXV7GTzcJ+82kaOlpqrV7YZHoDUobedKGKqfR/zk=;
        b=eoj2MzODzFNu6anDWa0BRgeEEJbXwdacPmU9/vJ5i3o+fj7BvQUtoHH1b5o95dZEHO
         9zKRxcIE9DEPQQbnB4DwDpkXvyiV4J/rOxtVLFU85SeembdHlMhP3qdd+Vo+WVB8+Y8R
         evEeitBu7rHQz2g0xlPWq82pM9LYmK19lDbATZyk+ZJl0VSzEkQrd4ncNBdVQKt2cBVy
         v4slrSQkFD8iv3gIreVF8odCaPznGzbO3j8gflvBzXbIyiYAEBTPvUIZ3CL8IGwrAAI6
         X5A3WLV0OvHaCKWKPpztHWp1H4+D9MSewZ+wEJUjcsSfuCXyCzaGRQ0v5a1M9Lz9CmC0
         ZANA==
X-Gm-Message-State: AOJu0YyAiEw3OYOI0DLzhRLl28Z7KIuKslt4zsoVhIiCS53LP1+FrtQ1
        30WUgWcflSDnx1lsYft38wjk2YIIJqJv965S7aDh8Tz1YCnPlkKz9y3tc4ISulScVgyFhZFomIE
        J9dL8W6GoZu5rgd2pAi+4IjzI
X-Received: by 2002:ac8:5b91:0:b0:403:a7e9:4734 with SMTP id a17-20020ac85b91000000b00403a7e94734mr17927794qta.3.1692042691707;
        Mon, 14 Aug 2023 12:51:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoOYDXyp3OCrLyoSlgXrvvYg3HOUe46ftneM+yqYEwQC6l8RfEarunFbw7s0drf5CTyAQ2hg==
X-Received: by 2002:ac8:5b91:0:b0:403:a7e9:4734 with SMTP id a17-20020ac85b91000000b00403a7e94734mr17927781qta.3.1692042691429;
        Mon, 14 Aug 2023 12:51:31 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id g2-20020ac87d02000000b0040331f93ee0sm3323969qtb.77.2023.08.14.12.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 12:51:31 -0700 (PDT)
Date:   Mon, 14 Aug 2023 15:51:27 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH RFC v2 1/3] mm: Add TAIL_MAPPING_REUSED_MAX
Message-ID: <ZNqFv0AwkfDKExiw@x1n>
References: <20230814184411.330496-1-peterx@redhat.com>
 <20230814184411.330496-2-peterx@redhat.com>
 <ZNp7yUgUrIpILnXu@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZNp7yUgUrIpILnXu@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 08:08:57PM +0100, Matthew Wilcox wrote:
> On Mon, Aug 14, 2023 at 02:44:09PM -0400, Peter Xu wrote:
> > +/*
> > + * This macro defines the maximum tail pages (of a folio) that can have the
> > + * page->mapping field reused (offset 12 for 32bits, or 24 for 64bits).
> 
> No, don't say how many bytes into the structure something is.  It'll
> only get out of date.  If somebody needs to know, use pahole.

OK.

> 
> > + * When the tail page's mapping field reused, it'll be exempted from
> > + * ->mapping poisoning and checks.  Also see the macro TAIL_MAPPING.
> > + */
> > +#define  TAIL_MAPPING_REUSED_MAX  (2)
> 
> More importantly, I think this is over-parametrisation.  If you start to
> use extra fields in struct folio, just change the code in page_alloc.c
> directly.

One should at least also need to change __split_huge_page_tail() on the
BUG_ON() with the hard-coded "tail > 2"?

I wanted to link all these pieces together, and the use case is when anyone
would like to e.g. reuse tail page 3 of a folio, hence put the macro here.

-- 
Peter Xu


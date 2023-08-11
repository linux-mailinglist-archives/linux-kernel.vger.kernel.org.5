Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4677792D5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbjHKPUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236598AbjHKPTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:19:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D547B359D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691767127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jo0mEcRfDjKXk0toT3MA/an0CZ6PSxrp9vF9M+Za+G4=;
        b=gT/3bqAtUYHPFY0GHuQ6400y11MWRkLp/qxf41Yw+wBQWSyFfH3z76quC7BTLgGLAfDRar
        eo99AMrWBNgMOLMtU8Tt+pzGQ8gjXMlKhByTX3hVrtXCGcxgoqxViBwpf3qlbCm/OSmZyl
        uF31k7J3Sgz9DMSpF5UC8AUn5QKrfqk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-osis0m39N1OuOyg6q_iGHQ-1; Fri, 11 Aug 2023 11:18:43 -0400
X-MC-Unique: osis0m39N1OuOyg6q_iGHQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4059b5c3dd0so5527761cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691767121; x=1692371921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jo0mEcRfDjKXk0toT3MA/an0CZ6PSxrp9vF9M+Za+G4=;
        b=NM8/RIlQNHepwxj7R+9Fjl/WZcsqwbCD/5CQI+APsODrjv3WOuoZz1O0EfODxIIr+Z
         5peKIQhW/lZZ1s0ibtyBuWX/F3zoHwFxUy38aOTNrUHXZdfeedQ8rtTpaizWfFI2zn0c
         shbcjLQMYiqVW2DFvMbWVjB6qSHsmZeN9Ns9Zh1iNtMcplXcHuPx0HmFPdfQSNz74Y8f
         dpC+QNDNjHHftUvjPWF/GsJf7x5Rsp5NxSwkAutrFVPYanRty1LjVk6YgPvgkgFCCa6K
         Z0SK+kBr3+Uubiou9yj6dA2UGg9ribINjNoA4VamKtCse5YXb4DAMJNv3/NahktV9koL
         XYHg==
X-Gm-Message-State: AOJu0YxaKrBPynxnO28y9tbcgOoAXPEFsviyLOuhMKgcGCR8nEKYIxDo
        wOz82nPhjnLqUPhAkvXioxXLVcFeyZ+qVW3YbhNgbkWLuqxwQfFwotRdHzQ4/8qhsOtePSfQkK1
        oACiC+Vnc+7H6ZiF0Arom9/FT
X-Received: by 2002:a05:622a:1a06:b0:40f:dcda:ea10 with SMTP id f6-20020a05622a1a0600b0040fdcdaea10mr2733828qtb.3.1691767121008;
        Fri, 11 Aug 2023 08:18:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu3sq9QlwOyun+Cer+VeBozeAoyni7P5APQeEkVKQ5+NJw6tsiiA41v7qX2wELRvM3P8bl9w==
X-Received: by 2002:a05:622a:1a06:b0:40f:dcda:ea10 with SMTP id f6-20020a05622a1a0600b0040fdcdaea10mr2733810qtb.3.1691767120739;
        Fri, 11 Aug 2023 08:18:40 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id g3-20020ac870c3000000b0040f200feb4fsm1229705qtp.80.2023.08.11.08.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:18:40 -0700 (PDT)
Date:   Fri, 11 Aug 2023 11:18:38 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH mm-unstable v1] mm: add a total mapcount for large folios
Message-ID: <ZNZRTmvkAlm4yeAd@x1n>
References: <20230809083256.699513-1-david@redhat.com>
 <ZNQD4pxo8svpGmvX@x1n>
 <e5e29217-11d3-a84b-9e29-44acc72222f3@redhat.com>
 <155bd03e-b75c-4d2d-a89d-a12271ada71b@arm.com>
 <ZNUbNDiciFefJngZ@x1n>
 <db3c4d94-a0a9-6703-6fe0-e1b8851e531f@redhat.com>
 <ZNVPJ9xxd2oarR3I@x1n>
 <ZNVbObUGbos73ZJ5@casper.infradead.org>
 <8222bf8f-6b99-58f4-92cc-44113b151d14@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8222bf8f-6b99-58f4-92cc-44113b151d14@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:27:13AM +0200, David Hildenbrand wrote:
> On 10.08.23 23:48, Matthew Wilcox wrote:
> > On Thu, Aug 10, 2023 at 04:57:11PM -0400, Peter Xu wrote:
> > > AFAICS if that patch was all correct (while I'm not yet sure..), you can
> > > actually fit your new total mapcount field into page 1 so even avoid the
> > > extra cacheline access.  You can have a look: the trick is refcount for
> > > tail page 1 is still seems to be free on 32 bits (if that was your worry
> > > before).  Then it'll be very nice if to keep Hugh's counter all in tail 1.
> > 
> > No, refcount must be 0 on all tail pages.  We rely on this in many places
> > in the MM.
> 
> Very right.

Obviously I could have missed this in the past.. can I ask for an example
explaining why refcount will be referenced before knowing it's a head?

> 
> One could theoretically
> 
> 1) Move the compound/entire mapcount to page[2]
> 2) Make hugetlb stop using the entire mapcount and only the total
>    mapcount.
> 3) Then leave total_mapcount and nr_pages_mapped in page[1]
> 4) Make page_mapcount() use total_mapcount for hugetlb.
> 
> When (un)mapping a PMD-mapped THP, we would go to page[2]. Otherwise, only
> page[1].
> 
> The entire mapcount, similarly to nr_pages_mapped, primarily serves to get
> memory stats right; well, and to implement page_mapcount() for THP.
> 
> But I'm not 100% sure yet if the overhead from having nr_pages_mapped in
> page[2] is significant enough at this point.

Worth trying.

Besides the cachelines, cmpxchg should also lock the memory bus and
meanwhile affect the whole processor pipelines in some way. Maybe that
effect is amplified too when it runs in a loop with one more counter.

-- 
Peter Xu


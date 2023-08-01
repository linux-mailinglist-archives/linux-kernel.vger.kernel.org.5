Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C8876B970
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 18:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbjHAQIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 12:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjHAQIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:08:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C569310B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 09:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690906045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yWOPkGc2VQ+gyDNVe+LM0eiFFyEn/D0a9ZnSdC5vf9I=;
        b=LujBYkGp7N0remQ0v3PNI7Bs6S40YgFAts4o3lkeHrnPveT5KIG8wO2nvXEszMEviib0GN
        6OUErY/JQv6GHQb/NTnA5HRl6P0WKuj8SrMa6wwddxCkcG2P3VMgnqEedDsJJnBzT6Q2o+
        ChY3Pdn0NWFfBiYybZOLlsYgLJj2Ht0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-kUUTac03Mqqoa-iXq1jXFA-1; Tue, 01 Aug 2023 12:07:24 -0400
X-MC-Unique: kUUTac03Mqqoa-iXq1jXFA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-76cb9958d60so38541785a.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 09:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690906044; x=1691510844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWOPkGc2VQ+gyDNVe+LM0eiFFyEn/D0a9ZnSdC5vf9I=;
        b=OpZcQ0NOWkRI+AFm/qdNyMEFV4wGaE5JbuT0RGCkJbRH36B/lMA8ioLo3csL4kGmhe
         2TDY7CFUqtyxgh67p+fkdvq/n8+iZRdt8EgAvPcnLi896z14tyxw5NbMMj+Yuq5zwRl4
         Id8UTjEx2WJEjmbpqDuaNcvWsSOzVFv4AISKCun+teL3nKMD763Ku5tp/EBVREMdj1Hp
         df4S97vWdXCTemXtQGxjznqIW/r7GF1GzFkATx37jjqkozehW0tA+bp7kjSbiTtVg+87
         8dxwaJ0PW+tMTxaruPh4rxr1gEh36b7+YmJLZ5JHfjO6U0M9pFhcTopHebozTrea/WZx
         rriw==
X-Gm-Message-State: ABy/qLZhslrQun9MxFinmMXADEwrLBXjXdFKZfMIskNUwRHUL5TJbsV2
        8AXqrwEjAbTs1DXSuuwvjMVKJSxSAQbrRCNOSRtzg7ROTrmWBZdprYSv+DkP6et7p1Dsim/96LG
        XBfRyLH5eezzi9bjJFDXt4mVW
X-Received: by 2002:a05:620a:461f:b0:767:170d:887a with SMTP id br31-20020a05620a461f00b00767170d887amr11729613qkb.2.1690906043914;
        Tue, 01 Aug 2023 09:07:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHqB7mU+Qbt0x6u8wDG4VYEiiNsMIxzWprLKmcc5Zc3mCLE/Anc8W8CylOrTkOpU586dh/Caw==
X-Received: by 2002:a05:620a:461f:b0:767:170d:887a with SMTP id br31-20020a05620a461f00b00767170d887amr11729595qkb.2.1690906043654;
        Tue, 01 Aug 2023 09:07:23 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id z5-20020a05620a100500b00767cf5d3faasm4237042qkj.86.2023.08.01.09.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 09:07:23 -0700 (PDT)
Date:   Tue, 1 Aug 2023 12:07:20 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>, Shuah Khan <shuah@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 6/8] mm/huge_memory: remove stale NUMA hinting comment
 from follow_trans_huge_pmd()
Message-ID: <ZMktuATuYhHdAW6M@x1n>
References: <20230801124844.278698-1-david@redhat.com>
 <20230801124844.278698-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230801124844.278698-7-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 02:48:42PM +0200, David Hildenbrand wrote:
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2cd3e5502180..0b709d2c46c6 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1467,7 +1467,6 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
>  	if ((flags & FOLL_DUMP) && is_huge_zero_pmd(*pmd))
>  		return ERR_PTR(-EFAULT);
>  
> -	/* Full NUMA hinting faults to serialise migration in fault paths */
>  	if (pmd_protnone(*pmd) && !gup_can_follow_protnone(vma, flags))
>  		return NULL;

Perhaps squashing into patch 1?  Thanks,

-- 
Peter Xu


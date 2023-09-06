Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F6B794187
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243270AbjIFQ3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbjIFQ3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:29:38 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A11199A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 09:29:33 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50091b91a83so6394892e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 09:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694017772; x=1694622572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xt74OUm6mXGe6ONc5vzMIVlJ1a8JtseT6g4gQMDvneo=;
        b=n1jbgjro/9xFjodnNccR4UBAuo7pFPz1YkjJCNcjTRcXNYM8jr8yw0VwD30mTzFJpY
         HqMU/hFD7T+wSEgfFbYUmdSrH43dn1a6aCKaVH+t2vIk/dakD6zXjQrUgMZIu28fJ3nA
         X8HCNrjDS4JU7UR9QOO6RmJh5PncYf1lCJwO5pbzjEwfJAOkkbnpqbAWeOj54KuwQNuK
         vCfKTGuwtpK3b8C0zgOrUK8A5C4icd3czdUPtG7tC1xYRM0vsrGZyCIVeC924eNnX7sD
         WdNz67C58SlUAoacEl55ylWow3Sj2WJV+6pBw9tGRJZBFBH4GxmhUB3qru+jEGVQRRxS
         3MsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694017772; x=1694622572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xt74OUm6mXGe6ONc5vzMIVlJ1a8JtseT6g4gQMDvneo=;
        b=A3tFxAnhpBbzUbGgyJ7xx4lxEsUt3J3o499zbTMcYJMhAblDUe4oFsLF0UEmptMMqT
         gjHvvkJojni0nY5GQnnXqt1rlDY22hsm6FOpGaLzwqf6LduBthYBahPsBkqKPq4up9N4
         UVnvcsJuAjyBQ+glVDBCE2JkAYGrPVsD2f6imXEdjYtTUVoHqSKbuKz2wySx0V+1FmP1
         WFQVhdsk9G/OGYij42RdABeyvSiLw3PVNOvhRCQYQyp/ufHLV/4h2p5DIBnnZDri65ye
         3gEuvlKRV1hP/7TDsuwFkuX3OI4AmDSEGinJrzFO2stK/IjQ5vhPBns6NCsDVETKed3e
         4tMA==
X-Gm-Message-State: AOJu0YxvTsGzCdIZhmlIZ5J2TOcM7VQwSvw4P4v7Nln0LRAvotSGoOhu
        mAuidcBbEp2PXGeoPOlZj6s=
X-Google-Smtp-Source: AGHT+IE782HP7mYnEUI6Gy5MiSkzRhmUBtE+OICSihXHHrCrIfc0lgF58YfkqNY9IcAsnO8QmVzW+Q==
X-Received: by 2002:a05:6512:3c84:b0:500:b891:779b with SMTP id h4-20020a0565123c8400b00500b891779bmr3245543lfv.51.1694017771652;
        Wed, 06 Sep 2023 09:29:31 -0700 (PDT)
Received: from pc636 (host-90-235-20-237.mobileonline.telia.com. [90.235.20.237])
        by smtp.gmail.com with ESMTPSA id e3-20020ac25463000000b004fdb85646f1sm2817812lfn.201.2023.09.06.09.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 09:29:31 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 6 Sep 2023 18:29:28 +0200
To:     Baoquan He <bhe@redhat.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 3/9] mm: vmalloc: Move vmap_init_free_space() down in
 vmalloc.c
Message-ID: <ZPio6FIIcqxDMdQq@pc636>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-4-urezki@gmail.com>
 <ZPgTiCoJIjYpN+ak@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPgTiCoJIjYpN+ak@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 01:52:08PM +0800, Baoquan He wrote:
> On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> > A vmap_init_free_space() is a function that setups a vmap space
> > and is considered as part of initialization phase. Since a main
> > entry which is vmalloc_init(), has been moved down in vmalloc.c
> > it makes sense to follow the pattern.
> > 
> > There is no a functional change as a result of this patch.
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 82 ++++++++++++++++++++++++++--------------------------
> >  1 file changed, 41 insertions(+), 41 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 09e315f8ea34..b7deacca1483 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2512,47 +2512,6 @@ void __init vm_area_register_early(struct vm_struct *vm, size_t align)
> >  	kasan_populate_early_vm_area_shadow(vm->addr, vm->size);
> >  }
> >  
> > -static void vmap_init_free_space(void)
> > -{
> > -	unsigned long vmap_start = 1;
> > -	const unsigned long vmap_end = ULONG_MAX;
> > -	struct vmap_area *busy, *free;
> > -
> > -	/*
> > -	 *     B     F     B     B     B     F
> > -	 * -|-----|.....|-----|-----|-----|.....|-
> > -	 *  |           The KVA space           |
> > -	 *  |<--------------------------------->|
> > -	 */
> > -	list_for_each_entry(busy, &vmap_area_list, list) {
> > -		if (busy->va_start - vmap_start > 0) {
> > -			free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
> > -			if (!WARN_ON_ONCE(!free)) {
> > -				free->va_start = vmap_start;
> > -				free->va_end = busy->va_start;
> > -
> > -				insert_vmap_area_augment(free, NULL,
> > -					&free_vmap_area_root,
> > -						&free_vmap_area_list);
> > -			}
> > -		}
> > -
> > -		vmap_start = busy->va_end;
> > -	}
> > -
> > -	if (vmap_end - vmap_start > 0) {
> > -		free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
> > -		if (!WARN_ON_ONCE(!free)) {
> > -			free->va_start = vmap_start;
> > -			free->va_end = vmap_end;
> > -
> > -			insert_vmap_area_augment(free, NULL,
> > -				&free_vmap_area_root,
> > -					&free_vmap_area_list);
> > -		}
> > -	}
> > -}
> > -
> >  static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
> >  	struct vmap_area *va, unsigned long flags, const void *caller)
> >  {
> > @@ -4443,6 +4402,47 @@ module_init(proc_vmalloc_init);
> >  
> >  #endif
> >  
> > +static void vmap_init_free_space(void)
> > +{
> > +	unsigned long vmap_start = 1;
> > +	const unsigned long vmap_end = ULONG_MAX;
> > +	struct vmap_area *busy, *free;
> > +
> > +	/*
> > +	 *     B     F     B     B     B     F
> > +	 * -|-----|.....|-----|-----|-----|.....|-
> > +	 *  |           The KVA space           |
> > +	 *  |<--------------------------------->|
> > +	 */
> > +	list_for_each_entry(busy, &vmap_area_list, list) {
> > +		if (busy->va_start - vmap_start > 0) {
> > +			free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
> > +			if (!WARN_ON_ONCE(!free)) {
> > +				free->va_start = vmap_start;
> > +				free->va_end = busy->va_start;
> > +
> > +				insert_vmap_area_augment(free, NULL,
> > +					&free_vmap_area_root,
> > +						&free_vmap_area_list);
> > +			}
> > +		}
> > +
> > +		vmap_start = busy->va_end;
> > +	}
> > +
> > +	if (vmap_end - vmap_start > 0) {
> > +		free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
> > +		if (!WARN_ON_ONCE(!free)) {
> > +			free->va_start = vmap_start;
> > +			free->va_end = vmap_end;
> > +
> > +			insert_vmap_area_augment(free, NULL,
> > +				&free_vmap_area_root,
> > +					&free_vmap_area_list);
> > +		}
> > +	}
> > +}
> > +
> >  void __init vmalloc_init(void)
> >  {
> >  	struct vmap_area *va;
> > -- 
> > 2.30.2
> > 
> 
> Reviewed-by: Baoquan He <bhe@redhat.com>
> 
Thanks!

--
Uladzislau Rezki

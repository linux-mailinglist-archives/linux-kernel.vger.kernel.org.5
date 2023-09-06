Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF846793FEA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241982AbjIFPGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237523AbjIFPGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:06:33 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A2810F8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 08:06:28 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so59592011fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 08:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694012786; x=1694617586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=md6yvbIaCY1wIEZej5F+EGAA01mvLh1YX5R7yH3UNb4=;
        b=IsvwZatcpoUZMJJpBncDDl7aQ4c9zGkviBAnzT1JjF6Aj1yhZ0dI+APq4wvdM/hmn/
         j81Fidczug9eavCUnRxy2dxQ6fcQa8Bhu4PfMUI+L9SPEbJ4qzRRnG5LmrBcVg2eo16m
         QHsly9Dp7OUnGZE2oqnKSiEG+7vjazfYcZ2KtJqTuk00igSutdk594UHqloW5HW4SPB0
         mQckf7iNyjtvJpiagF/zTRcPM6d5ap2H9KyRxBSm6fT8eyx36kHpVYN0je5iI1kt5q3l
         LsyhfjYPAqqMojkQLL1rnT5jr6kAUTfwJVN5iUPM9FV/do0lVNleSJ4tui5OEYPXmlsP
         jj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694012786; x=1694617586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=md6yvbIaCY1wIEZej5F+EGAA01mvLh1YX5R7yH3UNb4=;
        b=WJJUxICNEuyv/3TNRyK1cb2Zc2G/rOPgvPDXQ7kNHOXTZGaH5mAHfEfWSiPLjl5Vwj
         juEzwjUvaPnI85fj2aWPed5yk/XrVbH4hthxWQPQvnVuypJ0Q3H9l14trEu4t9JeejTC
         hU07uE8yYa4YTNiZo508R1ekVnfOxcwvfyqQhnaTYDMR31UZHY5MzgxIC0VwJJkLwi6p
         WhIQxDaLF/hahxOlNEl9Wu7V0q6VLs7k9/rTDuGiRc90hFBSENYtKwKSvd64zCntKnjG
         XisbfJf73shNtmzgTjLnGFvX+MkVsgHNepHxmA3V2fyBjmU0SXNL2A727tEPnvY9sHEk
         5T6Q==
X-Gm-Message-State: AOJu0YwDHwZs6e3QSfgb17Z8WiK5RA1qQSA5Dc6eV4FnOW5YTAeK0K0a
        jzFrv29jP6ab12/Njv5xIHQ=
X-Google-Smtp-Source: AGHT+IFP5O3nhoAfZwg8+CxRZ3wuOldaX2B3xbaRfAFF13oHHH3QoHKizP8eph+zE53aW9DQbvTU3g==
X-Received: by 2002:a2e:b16e:0:b0:2b6:e283:32cb with SMTP id a14-20020a2eb16e000000b002b6e28332cbmr2290270ljm.23.1694012786033;
        Wed, 06 Sep 2023 08:06:26 -0700 (PDT)
Received: from pc636 (host-90-235-20-237.mobileonline.telia.com. [90.235.20.237])
        by smtp.gmail.com with ESMTPSA id j12-20020a2e800c000000b002b9f0b25ff6sm3430004ljg.4.2023.09.06.08.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 08:06:25 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 6 Sep 2023 17:06:22 +0200
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
Subject: Re: [PATCH v2 1/9] mm: vmalloc: Add va_alloc() helper
Message-ID: <ZPiVbvdtoDob7fA+@pc636>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-2-urezki@gmail.com>
 <ZPgTR19GX9EI8J0d@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPgTR19GX9EI8J0d@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 01:51:03PM +0800, Baoquan He wrote:
> On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> > Currently __alloc_vmap_area() function contains an open codded
> > logic that finds and adjusts a VA based on allocation request.
> > 
> > Introduce a va_alloc() helper that adjusts found VA only. It
> > will be used later at least in two places.
> > 
> > There is no a functional change as a result of this patch.
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 41 ++++++++++++++++++++++++++++-------------
> >  1 file changed, 28 insertions(+), 13 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 93cf99aba335..00afc1ee4756 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -1481,6 +1481,32 @@ adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
> >  	return 0;
> >  }
> >  
> > +static unsigned long
> > +va_alloc(struct vmap_area *va,
> > +		struct rb_root *root, struct list_head *head,
> > +		unsigned long size, unsigned long align,
> > +		unsigned long vstart, unsigned long vend)
> > +{
> > +	unsigned long nva_start_addr;
> > +	int ret;
> > +
> > +	if (va->va_start > vstart)
> > +		nva_start_addr = ALIGN(va->va_start, align);
> > +	else
> > +		nva_start_addr = ALIGN(vstart, align);
> > +
> > +	/* Check the "vend" restriction. */
> > +	if (nva_start_addr + size > vend)
> > +		return vend;
> > +
> > +	/* Update the free vmap_area. */
> > +	ret = adjust_va_to_fit_type(root, head, va, nva_start_addr, size);
> > +	if (WARN_ON_ONCE(ret))
> > +		return vend;
> > +
> > +	return nva_start_addr;
> > +}
> > +
> >  /*
> >   * Returns a start address of the newly allocated area, if success.
> >   * Otherwise a vend is returned that indicates failure.
> > @@ -1493,7 +1519,6 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
> >  	bool adjust_search_size = true;
> >  	unsigned long nva_start_addr;
> >  	struct vmap_area *va;
> > -	int ret;
> >  
> >  	/*
> >  	 * Do not adjust when:
> > @@ -1511,18 +1536,8 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
> >  	if (unlikely(!va))
> >  		return vend;
> >  
> > -	if (va->va_start > vstart)
> > -		nva_start_addr = ALIGN(va->va_start, align);
> > -	else
> > -		nva_start_addr = ALIGN(vstart, align);
> > -
> > -	/* Check the "vend" restriction. */
> > -	if (nva_start_addr + size > vend)
> > -		return vend;
> > -
> > -	/* Update the free vmap_area. */
> > -	ret = adjust_va_to_fit_type(root, head, va, nva_start_addr, size);
> > -	if (WARN_ON_ONCE(ret))
> > +	nva_start_addr = va_alloc(va, root, head, size, align, vstart, vend);
> > +	if (nva_start_addr == vend)
> >  		return vend;
> >  
> >  #if DEBUG_AUGMENT_LOWEST_MATCH_CHECK
> > -- 
> > 2.30.2
> 
> Reviewed-by: Baoquan He <bhe@redhat.com>
> 
Thanks, i picked it for V3.

--
Uladzislau Rezki

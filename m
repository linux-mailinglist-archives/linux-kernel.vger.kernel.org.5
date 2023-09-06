Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7ACD79417C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243140AbjIFQ2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239317AbjIFQ2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:28:12 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A041BC3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 09:27:53 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so811931fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 09:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694017671; x=1694622471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KQUJGsaeOMbl6qMMpIZHhehLszW3RKPl2I1rjdhDUEc=;
        b=NeLGSQpkXVhlbCMsmKQugwTgmUGesc2oi67NWcHEd6ykDs27LigA5E/CRPBXfe3HqO
         qbjrgxPFvcRqv7PgYaiEd9KibH7XxaFpCloUhYMtBxnFRWgP/nlZkqrFmmPu2MHuecGB
         PBhRyklFzV7fbfiVn50NKTReHtAaOIMrB0Qz0TDifVoFRN5Nm5nDoQ1wKO9zlMmJcTye
         S16+HtlavH7l4Rtg0MGaY2Jfe8AoM92JuPm9YBG7DVV+N4ci+qIt2RYuH33aNdg4LgLy
         nTbAE5nOUg+72gKuXCN3SpG6qtccCJagLmjrbvgeTyppE+CUnsAVmVO40PlScYqbmm4L
         bI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694017671; x=1694622471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQUJGsaeOMbl6qMMpIZHhehLszW3RKPl2I1rjdhDUEc=;
        b=huqBZN4AXBSa4388No8Dxufn89E3COZzd+KB7vIod0UKwjdBjCtK6vfQDK+OoNPmlI
         WAtOAJW7TQxgP28UP3PZP/xAoDF3h/fmi+rTxE3NpRfG5eb/IumDE587J7bZs7/I19HA
         HKp6ehi3KdJque3kBu6kNkOiJdcr01srwayJCiQc7fe4c28BvAAcVg2J2RgXjf3yGb5c
         KdLouPh+TcBYPxEtZshsuQeH0zNEi5D8BvdEERxIKvWeggaIsITp3z5tlLtOB6YqNcGV
         Ics66l4xZq9tPkWctJPIcsGnDdLvaIFq13eYj3bHOu1hwDBqXQ6aBhyucwmkN7SUHN4v
         95SQ==
X-Gm-Message-State: AOJu0Yzft7FDAqsPlEO6+4GlgYFNg0IcPf/YOpAcgEUzADi4zfwGXbZ1
        vMOe1e0JwwQoZQv2dB2LE2Y=
X-Google-Smtp-Source: AGHT+IEpHqMyLdhZtcT4lemXIkiKYTsPGbY2zZdPT1tHOfKzfGZp4ZO2HiFFCKcLFBfh1ximufsj7A==
X-Received: by 2002:a2e:9dd9:0:b0:2bc:c004:cc22 with SMTP id x25-20020a2e9dd9000000b002bcc004cc22mr2732460ljj.33.1694017671028;
        Wed, 06 Sep 2023 09:27:51 -0700 (PDT)
Received: from pc636 (host-90-235-20-237.mobileonline.telia.com. [90.235.20.237])
        by smtp.gmail.com with ESMTPSA id n15-20020a2e878f000000b002b6eb5db863sm3501421lji.43.2023.09.06.09.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 09:27:50 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 6 Sep 2023 18:27:48 +0200
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
Subject: Re: [PATCH v2 2/9] mm: vmalloc: Rename adjust_va_to_fit_type()
 function
Message-ID: <ZPiohI5R7wFsKi/J@pc636>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-3-urezki@gmail.com>
 <ZPgTbrc9R+KoUQtF@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPgTbrc9R+KoUQtF@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 01:51:42PM +0800, Baoquan He wrote:
> On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> > This patch renames the adjust_va_to_fit_type() function
> > to va_clip() which is shorter and more expressive.
> > 
> > There is no a functional change as a result of this patch.
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 00afc1ee4756..09e315f8ea34 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -1382,9 +1382,9 @@ classify_va_fit_type(struct vmap_area *va,
> >  }
> >  
> >  static __always_inline int
> > -adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
> > -		      struct vmap_area *va, unsigned long nva_start_addr,
> > -		      unsigned long size)
> > +va_clip(struct rb_root *root, struct list_head *head,
> > +		struct vmap_area *va, unsigned long nva_start_addr,
> > +		unsigned long size)
> >  {
> >  	struct vmap_area *lva = NULL;
> >  	enum fit_type type = classify_va_fit_type(va, nva_start_addr, size);
> > @@ -1500,7 +1500,7 @@ va_alloc(struct vmap_area *va,
> >  		return vend;
> >  
> >  	/* Update the free vmap_area. */
> > -	ret = adjust_va_to_fit_type(root, head, va, nva_start_addr, size);
> > +	ret = va_clip(root, head, va, nva_start_addr, size);
> >  	if (WARN_ON_ONCE(ret))
> >  		return vend;
> >  
> > @@ -4151,9 +4151,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
> >  			/* It is a BUG(), but trigger recovery instead. */
> >  			goto recovery;
> >  
> > -		ret = adjust_va_to_fit_type(&free_vmap_area_root,
> > -					    &free_vmap_area_list,
> > -					    va, start, size);
> > +		ret = va_clip(&free_vmap_area_root,
> > +			&free_vmap_area_list, va, start, size);
> >  		if (WARN_ON_ONCE(unlikely(ret)))
> >  			/* It is a BUG(), but trigger recovery instead. */
> >  			goto recovery;
> > -- 
> > 2.30.2
> > 
> 
> Reviewed-by: Baoquan He <bhe@redhat.com>
> 
Thank you for the review. Picked it up.

--
Uladzislau Rezki

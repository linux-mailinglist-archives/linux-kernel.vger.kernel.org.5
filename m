Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2977943A8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 21:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjIFTQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 15:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjIFTQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 15:16:34 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511A0185
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 12:16:30 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-501bd7711e8so211938e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 12:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694027788; x=1694632588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1isv7HeloaiAJI2agIZVc+2h9VVYfJCr8q7rsrwe9zI=;
        b=k8FVKYI1jkRzIRPvPnMhhyATggIwivoJNng1L73vkTuShoZOID2ajIefvOHA3GSBiz
         ocfT81iv92KO3NqrPPw5Pt8020kvGn/3LzDDH5wFwKjlzcuxM/chtuwb8j9fXYpjW/dL
         SlBigx7y11l0ecP50TJwnHsmetMnNG92EEexBcQZDFKkOMYBs7ELQtme0uk8I0DiZ7Cb
         w1ajCaKZMuSaklqItua1+3bR2mN6UywxXH0sd6i/dY7zTNiFKHXWKE4zYC6QPa8s9U8d
         XOaNadmEkDK07rZrQ04eD/C1YzCGL+Cz+gmQex3HWY9fLJGnq7lukYIsu5MKj+aM04Jl
         UHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694027788; x=1694632588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1isv7HeloaiAJI2agIZVc+2h9VVYfJCr8q7rsrwe9zI=;
        b=MB/Aj1Ux27PHRm+puHa1hHZf6s2Qnqyuq2TNUoW6ENiWbNC0rr7o6g7JWg7dEZ69uP
         VfigRRtm1FFz7O2+FuZHP/9tPschnf1tjiknyYTxqDw0iW0P1XYj9IVQZhpFCnhynzRy
         7PQ0oppoRNySa2P0qKDjnT40Xc/CRKCPhICODeS6VBNkoKCzLGC33dOOg7NKHa6bVF+g
         9mgUuxAIBk+UOcBTipPpYyP0yiLOBBNkjqVKHDg3c7Sz7RjCa/5brASxRfOEFzX1gqEi
         va8SBHPpr+EEUG7jRmzW48fJ8nPyfROr6rjUvyN/mVQYdgqMC7m10vxiaS7i0qAY4FXX
         AdmQ==
X-Gm-Message-State: AOJu0Yw6EJAqJauxgfMjTiiXHmm1FrKUCjbsMeDvjfwwHWuPkFAO/yK5
        +bkwVZSrEjIvGO7V/t/TUvU=
X-Google-Smtp-Source: AGHT+IGJGdoq1Q/AEvIuNHd2zyEEzGW6CpNIadi/V/3BHoyrQr0zByFy4AAAENTqzjvspx81/JbcKg==
X-Received: by 2002:a05:6512:104d:b0:500:95f7:c418 with SMTP id c13-20020a056512104d00b0050095f7c418mr3890196lfb.39.1694027788110;
        Wed, 06 Sep 2023 12:16:28 -0700 (PDT)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id b12-20020ac2410c000000b004fe8593b67fsm2838050lfi.107.2023.09.06.12.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 12:16:27 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 6 Sep 2023 21:16:25 +0200
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
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v2 6/9] mm: vmalloc: Offload free_vmap_area_lock lock
Message-ID: <ZPjQCSkKesWmWdB8@pc636>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-7-urezki@gmail.com>
 <ZPgWXgL1nLASjx8O@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPgWXgL1nLASjx8O@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >  static void free_vmap_area(struct vmap_area *va)
> >  {
> >  	struct vmap_node *vn = addr_to_node(va->va_start);
> > +	int vn_id = decode_vn_id(va->flags);
> >  
> >  	/*
> >  	 * Remove from the busy tree/list.
> > @@ -1594,12 +1629,19 @@ static void free_vmap_area(struct vmap_area *va)
> >  	unlink_va(va, &vn->busy.root);
> >  	spin_unlock(&vn->busy.lock);
> >  
> > -	/*
> > -	 * Insert/Merge it back to the free tree/list.
> > -	 */
> > -	spin_lock(&free_vmap_area_lock);
> > -	merge_or_add_vmap_area_augment(va, &free_vmap_area_root, &free_vmap_area_list);
> > -	spin_unlock(&free_vmap_area_lock);
> > +	if (vn_id >= 0) {
> 
> In alloc_vmap_area(), the vn_id is encoded into va->flags. When
> allocation failed, the vn_id = 0. Here should we change to check 'if
> (vn_id > 0)' becasue the vn_id == 0 means no available vn_id encoded
> into. And I do not get how we treat the case vn_id truly is 0.
> 
> 	va->flags = (addr != vend) ? encode_vn_id(vn_id) : 0;
>
Yes, vn_id always >= 0, so it is positive since it is an index.
We encode a vn_id as vn_id + 1. For example if it is zero we write 1.

If not node allocation path or an error zero is written. Decoding
is done as: zero - 1 = -1, so it is negative value, i.e. decode_vn_id()
function returns -1.

--
Uladzislau Rezki

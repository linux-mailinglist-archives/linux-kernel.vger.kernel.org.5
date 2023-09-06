Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13BA793508
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 07:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbjIFFwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 01:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjIFFwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 01:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AB21A7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 22:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693979514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fryIiZhy06QnkHy7STq692w/bK/pSon6VbynMKbTiPI=;
        b=MP9UWtM0X929Yqr/68wVPaQfkg504DegheB7zH826CDPhvXeqob0GJuVQyR8p+FbEbYaTt
        3T8DUZXqoIOIaBqjcI2LemKmteaXKcjtJqpvn49F1jf0xZniGJw6NAuNj7+zhMWrMMwrL6
        8PGl26ZM5P4QT7Ky0RfGUlBI1lsTu5U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-ZC3w-hl7O5ujKHrTwp8pgw-1; Wed, 06 Sep 2023 01:51:48 -0400
X-MC-Unique: ZC3w-hl7O5ujKHrTwp8pgw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51287101A529;
        Wed,  6 Sep 2023 05:51:47 +0000 (UTC)
Received: from localhost (unknown [10.72.112.85])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 09CE120BAE72;
        Wed,  6 Sep 2023 05:51:44 +0000 (UTC)
Date:   Wed, 6 Sep 2023 13:51:42 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <ZPgTbrc9R+KoUQtF@MiWiFi-R3L-srv>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-3-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829081142.3619-3-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> This patch renames the adjust_va_to_fit_type() function
> to va_clip() which is shorter and more expressive.
> 
> There is no a functional change as a result of this patch.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 00afc1ee4756..09e315f8ea34 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1382,9 +1382,9 @@ classify_va_fit_type(struct vmap_area *va,
>  }
>  
>  static __always_inline int
> -adjust_va_to_fit_type(struct rb_root *root, struct list_head *head,
> -		      struct vmap_area *va, unsigned long nva_start_addr,
> -		      unsigned long size)
> +va_clip(struct rb_root *root, struct list_head *head,
> +		struct vmap_area *va, unsigned long nva_start_addr,
> +		unsigned long size)
>  {
>  	struct vmap_area *lva = NULL;
>  	enum fit_type type = classify_va_fit_type(va, nva_start_addr, size);
> @@ -1500,7 +1500,7 @@ va_alloc(struct vmap_area *va,
>  		return vend;
>  
>  	/* Update the free vmap_area. */
> -	ret = adjust_va_to_fit_type(root, head, va, nva_start_addr, size);
> +	ret = va_clip(root, head, va, nva_start_addr, size);
>  	if (WARN_ON_ONCE(ret))
>  		return vend;
>  
> @@ -4151,9 +4151,8 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
>  			/* It is a BUG(), but trigger recovery instead. */
>  			goto recovery;
>  
> -		ret = adjust_va_to_fit_type(&free_vmap_area_root,
> -					    &free_vmap_area_list,
> -					    va, start, size);
> +		ret = va_clip(&free_vmap_area_root,
> +			&free_vmap_area_list, va, start, size);
>  		if (WARN_ON_ONCE(unlikely(ret)))
>  			/* It is a BUG(), but trigger recovery instead. */
>  			goto recovery;
> -- 
> 2.30.2
> 

Reviewed-by: Baoquan He <bhe@redhat.com>


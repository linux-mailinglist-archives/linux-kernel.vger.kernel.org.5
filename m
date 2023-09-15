Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3307A28AD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbjIOUvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237863AbjIOUus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:50:48 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D73E35BB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:50:02 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c09673b006so20653085ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694811001; x=1695415801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pixcN5Y1AubjMBamu4r0/OjVDhrvJd2jJgNFr0zPGBA=;
        b=HuODhYelyacRY9HlytTsIm4B7wz8OazwsD1/3T8eipUeYOw7pRmK87nYD+La4M2ERL
         c+7i0KKd0WStxwghrx1gk/tXpFGLX6oCJQ8XsXYFkD4z/28YqyucPyx/EH8c5tVvxeQ4
         l6Cr7hN2AKgTyDnzeP4hXi1kaJYFNVGjzbZTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694811001; x=1695415801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pixcN5Y1AubjMBamu4r0/OjVDhrvJd2jJgNFr0zPGBA=;
        b=knTZ3Kcqy3xx4nbERuHY8K0SpG0EtRveuLba4zMRGFeJuv9MboqsPtr0bRIZkyE9yH
         1ZISl+KGZgtZJP2vWdS+ByzDz0nSh1NRsdfrrcrt4OVg1mMf6pv4vqWjbSFwqO15nW1W
         9PbSGaJNBORhIY0BuNYuDQB49b+YOdmfcFFab9lxHA0Hml2GFbiYS2CbZaJqzlkpy8BM
         wPe/jA6AJiz5UiDDeC/bKW/F35/9N1YRyTk3XyqVHv7oHYKHoLBSCbZqzcewx8brwQJk
         kyqG4LaA1tAB6oSt0rgdTIt4ItdFIyUl/SUygr8no8dAgywmPXTzAlncYhl8r2Cy4oxN
         jA1w==
X-Gm-Message-State: AOJu0YxVZbNPY+BLbSFL4Ryx/6Q8wE9+zgSP03tp/2vDdlh3/iaU1gb8
        uZ/xnjO8UZfe/Mp/YnrY0RDrGA==
X-Google-Smtp-Source: AGHT+IFG5RbkUmAUyhtbRZ65uLoK2tgVIeCtTHS/dvTIeIuGjUg4Cs9dHFp2ggbnq+0cI4RujnJy7g==
X-Received: by 2002:a17:902:d4c7:b0:1c1:e52e:49e3 with SMTP id o7-20020a170902d4c700b001c1e52e49e3mr2611409plg.36.1694811001209;
        Fri, 15 Sep 2023 13:50:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q22-20020a170902bd9600b001bb9f104328sm3876566pls.146.2023.09.15.13.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:50:00 -0700 (PDT)
Date:   Fri, 15 Sep 2023 13:50:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matteo Rizzo <matteorizzo@google.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, luto@kernel.org, peterz@infradead.org,
        jannh@google.com, evn@google.com, poprdi@google.com,
        jordyzomer@google.com
Subject: Re: [RFC PATCH 01/14] mm/slub: don't try to dereference invalid
 freepointers
Message-ID: <202309151349.BEBA203D@keescook>
References: <20230915105933.495735-1-matteorizzo@google.com>
 <20230915105933.495735-2-matteorizzo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915105933.495735-2-matteorizzo@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 10:59:20AM +0000, Matteo Rizzo wrote:
> slab_free_freelist_hook tries to read a freelist pointer from the
> current object even when freeing a single object. This is invalid
> because single objects don't actually contain a freelist pointer when
> they're freed and the memory contains other data. This causes problems
> for checking the integrity of freelist in get_freepointer.
> 
> Signed-off-by: Matteo Rizzo <matteorizzo@google.com>
> ---
>  mm/slub.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index f7940048138c..a7dae207c2d2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1820,7 +1820,9 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
>  
>  	do {
>  		object = next;
> -		next = get_freepointer(s, object);
> +		/* Single objects don't actually contain a freepointer */
> +		if (object != old_tail)
> +			next = get_freepointer(s, object);
>  
>  		/* If object's reuse doesn't have to be delayed */
>  		if (!slab_free_hook(s, object, slab_want_init_on_free(s))) {

I find this loop's logic a bit weird, but, yes, this ends up being
correct and avoids needless work.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA6579E52C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 12:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbjIMKrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 06:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjIMKrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 06:47:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6949319AD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 03:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694602000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/+0qvkYwtrcO7faarFMzFVDao1vw9b8jVL6GtDEUP0I=;
        b=WTj01NCVWSGr4hCEntOAiPsOv6ibY7Q0x0ch/m/587cYcMxE5lBpzpJaJ1MljkCgtDORqg
        6+GrNcfcd8q3wzA8ZSef8CH3sAeko44OL/mlgAqPdl53qkWD/BR/ms1vXNWFjY9y4HrMVR
        ghcLuav+fiyCJNjSxEwVvWoCwQb7YOQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-ZzJ2EiniOcmqFAl0bZmDzA-1; Wed, 13 Sep 2023 06:46:39 -0400
X-MC-Unique: ZzJ2EiniOcmqFAl0bZmDzA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4120b583ab4so69874311cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 03:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694601998; x=1695206798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+0qvkYwtrcO7faarFMzFVDao1vw9b8jVL6GtDEUP0I=;
        b=NETXjvJ5N4V/FJVN7Z1WK8dv70ULqvbGRmM6DpdANeS/0NORFkGxgbOD1gRkg6Ijfu
         nwiOw33SZnt8GemO9a0YJQHvTlTcdhKsgXhpizYjJ0L/o953PoHZ0GCVstxQm9gPHBfy
         QIZvkWkxc3EJFpR7b9s14873TI906OIrMo4qB9+qFbez4/CEIT8tnCocIGQ7NlUzr50d
         zvbtTAVzPzd0IJqVM9V5g/UCDm6Oz7XArO6/yapyL/T4OO8/1tDhtDmqs9wsXWTnCHxs
         tQuyslhYD60m6eon+kihHY7oDuacVT4knYlnAdfxIhJ5HJ0xFEGdd1GN7wQh83yj74M9
         BtpA==
X-Gm-Message-State: AOJu0Yz6s1kizgClALR7ahnikm6cgh1ZHN0BkghcARWiW5q88TN/RorF
        1UOTIUrTTupvtojoAOf1ieWEiCHGMmo3GJQP755UwejJuBuph+ut3RtwS2ggsDOjIZef8jIXJ02
        Q9nMEXeu1z1xEnuBqMLxfRtn/ju5VdGmo
X-Received: by 2002:ac8:5b4b:0:b0:410:aa40:e8f7 with SMTP id n11-20020ac85b4b000000b00410aa40e8f7mr2169642qtw.33.1694601998662;
        Wed, 13 Sep 2023 03:46:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9nyWwUy1CH3HJQRTdKOYwxVUjUhlXskTR/aVLu8Suwo13+Oim4pqSh5PsL8p6XGj5kL9c/Q==
X-Received: by 2002:ac8:5b4b:0:b0:410:aa40:e8f7 with SMTP id n11-20020ac85b4b000000b00410aa40e8f7mr2169630qtw.33.1694601998388;
        Wed, 13 Sep 2023 03:46:38 -0700 (PDT)
Received: from bfoster (c-24-60-61-41.hsd1.ma.comcast.net. [24.60.61.41])
        by smtp.gmail.com with ESMTPSA id h20-20020a05622a171400b00411fcc18cc1sm3905003qtk.64.2023.09.13.03.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 03:46:38 -0700 (PDT)
Date:   Wed, 13 Sep 2023 06:46:49 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] bcachefs: Remove unneeded semicolon
Message-ID: <ZQGTGV0LRqkKBF6p@bfoster>
References: <20230913005756.6827-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913005756.6827-1-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 08:57:56AM +0800, Yang Li wrote:
> ./fs/bcachefs/btree_gc.c:1249:2-3: Unneeded semicolon
> ./fs/bcachefs/btree_gc.c:1521:2-3: Unneeded semicolon
> ./fs/bcachefs/btree_gc.c:1575:2-3: Unneeded semicolon
> ./fs/bcachefs/counters.c:46:2-3: Unneeded semicolon
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---

What produces these warnings? It would be help to add a sentence or two
of such context in the commit log.. even just a "XYZ reports the
following: ..."

Nit aside, patch seems fine to me:

Reviewed-by: Brian Foster <bfoster@redhat.com>

>  fs/bcachefs/btree_gc.c | 6 +++---
>  fs/bcachefs/counters.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/bcachefs/btree_gc.c b/fs/bcachefs/btree_gc.c
> index dac2eb76c985..56c671638c43 100644
> --- a/fs/bcachefs/btree_gc.c
> +++ b/fs/bcachefs/btree_gc.c
> @@ -1246,7 +1246,7 @@ static int bch2_gc_done(struct bch_fs *c,
>  			copy_dev_field(d[i].sectors,	"%s sectors", bch2_data_types[i]);
>  			copy_dev_field(d[i].fragmented,	"%s fragmented", bch2_data_types[i]);
>  		}
> -	};
> +	}
>  
>  	{
>  		unsigned nr = fs_usage_u64s(c);
> @@ -1518,7 +1518,7 @@ static int bch2_gc_alloc_start(struct bch_fs *c, bool metadata_only)
>  		buckets->first_bucket	= ca->mi.first_bucket;
>  		buckets->nbuckets	= ca->mi.nbuckets;
>  		rcu_assign_pointer(ca->buckets_gc, buckets);
> -	};
> +	}
>  
>  	bch2_trans_init(&trans, c, 0, 0);
>  
> @@ -1572,7 +1572,7 @@ static void bch2_gc_alloc_reset(struct bch_fs *c, bool metadata_only)
>  			g->dirty_sectors = 0;
>  			g->cached_sectors = 0;
>  		}
> -	};
> +	}
>  }
>  
>  static int bch2_gc_write_reflink_key(struct btree_trans *trans,
> diff --git a/fs/bcachefs/counters.c b/fs/bcachefs/counters.c
> index 442a9b806a3c..26eb3d82b1cb 100644
> --- a/fs/bcachefs/counters.c
> +++ b/fs/bcachefs/counters.c
> @@ -43,7 +43,7 @@ static void bch2_sb_counters_to_text(struct printbuf *out, struct bch_sb *sb,
>  		prt_tab(out);
>  		prt_printf(out, "%llu", le64_to_cpu(ctrs->d[i]));
>  		prt_newline(out);
> -	};
> +	}
>  };
>  
>  int bch2_sb_counters_to_cpu(struct bch_fs *c)
> -- 
> 2.20.1.7.g153144c
> 


Return-Path: <linux-kernel+bounces-15714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBAC8230C9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1652C285CC5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A901BDFB;
	Wed,  3 Jan 2024 15:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9A/EMsT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2320B1BDE3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cceb5f0918so46120751fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 07:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704296845; x=1704901645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hhrsogcA78u+i7VN1yFSxBLITouejwykBZ4THZ1vf8s=;
        b=I9A/EMsTKRwzLN+AkQrngzfmllaOi2wtFXuw8tcGBlTRLzqJsm35qHauSoHpTk4fh3
         ZDfT1jigGem9DnIbkMOcAvCOggdZw0CoEaqNlJg9HhQgb4/ISywRFHvS8Bg7ALkKinim
         eM+BBqTgosEteRSmjm7tQZ9ezxHJfc0cpm7lMxPLDP2wJZRFc915uRK726iypPoos+4K
         jEJlgxyQ/1ptO5bh4VvDA1EbLf97LGVQgYWE/rAnkC60+pZ9JBl4NCvuN0vQL8i3dxVl
         GqNYyrUz14vUXec3r4keePmNxLhTz8FQcYRyDpatKjz/htAtJf/ZgfzGIlG8arsmCMgh
         E8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704296845; x=1704901645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhrsogcA78u+i7VN1yFSxBLITouejwykBZ4THZ1vf8s=;
        b=rCQ12JnofJKosiBJI2wy1vhuu5pY80CZ/ZAu9WLL1byqlzkCuItstwoPwlN77LJejx
         HiMKrykZyiIk32SsyIiGjrAS16nWRi3W5iEXMmO411vqiNa9lqL6YNXSw70ZLH2yqvyW
         7oab+YiwAsH6wN97um5YAEp4OuHe+C25RiMakO/9Y7WeD4ZfXDFFsoe7ayls1OZDw6y/
         iUJaQhhheuwNECFiVo+MBdAbOwHLd8TUQnbtqpk1f5f/jVpzuxMJQLkL9oEeL7Bsw7y0
         k+NWB2+MSeZAl0B+ySMMukD7MUQjEvO8m/C3vp9V0vHkeLa1U5+D5E15feaIv6mCnC0Z
         8X5Q==
X-Gm-Message-State: AOJu0YzyjOp0i/sWP7vJokJecTO8sfVv+qw6sZ1bay81i474uWxKGmQw
	clRARwnmWbUebiquV3ns+77EMIg5uk4=
X-Google-Smtp-Source: AGHT+IGDiz1q2l0RgIIbnA0a3DEiX6deZvkBeqr650S9Hmp7190zH254RFaKVwJ0jLkllJcG8sGeoQ==
X-Received: by 2002:a2e:a585:0:b0:2cd:348:94a6 with SMTP id m5-20020a2ea585000000b002cd034894a6mr1551015ljp.92.1704296844737;
        Wed, 03 Jan 2024 07:47:24 -0800 (PST)
Received: from pc636 (host-90-233-200-64.mobileonline.telia.com. [90.233.200.64])
        by smtp.gmail.com with ESMTPSA id s10-20020a2e81ca000000b002ccd39eeae4sm3518354ljg.100.2024.01.03.07.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 07:47:24 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 3 Jan 2024 16:47:22 +0100
To: Hillf Danton <hdanton@sina.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	LKML <linux-kernel@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 07/11] mm: vmalloc: Offload free_vmap_area_lock lock
Message-ID: <ZZWBiiX69HQFkUlB@pc636>
References: <20240102184633.748113-1-urezki@gmail.com>
 <20240103110832.2711-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103110832.2711-1-hdanton@sina.com>

On Wed, Jan 03, 2024 at 07:08:32PM +0800, Hillf Danton wrote:
> On Tue,  2 Jan 2024 19:46:29 +0100 Uladzislau Rezki <urezki@gmail.com>
> > +static void
> > +decay_va_pool_node(struct vmap_node *vn, bool full_decay)
> > +{
> > +	struct vmap_area *va, *nva;
> > +	struct list_head decay_list;
> > +	struct rb_root decay_root;
> > +	unsigned long n_decay;
> > +	int i;
> > +
> > +	decay_root = RB_ROOT;
> > +	INIT_LIST_HEAD(&decay_list);
> > +
> > +	for (i = 0; i < MAX_VA_SIZE_PAGES; i++) {
> > +		struct list_head tmp_list;
> > +
> > +		if (list_empty(&vn->pool[i].head))
> > +			continue;
> > +
> > +		INIT_LIST_HEAD(&tmp_list);
> > +
> > +		/* Detach the pool, so no-one can access it. */
> > +		spin_lock(&vn->pool_lock);
> > +		list_replace_init(&vn->pool[i].head, &tmp_list);
> > +		spin_unlock(&vn->pool_lock);
> > +
> > +		if (full_decay)
> > +			WRITE_ONCE(vn->pool[i].len, 0);
> > +
> > +		/* Decay a pool by ~25% out of left objects. */
> > +		n_decay = vn->pool[i].len >> 2;
> > +
> > +		list_for_each_entry_safe(va, nva, &tmp_list, list) {
> > +			list_del_init(&va->list);
> > +			merge_or_add_vmap_area(va, &decay_root, &decay_list);
> > +
> > +			if (!full_decay) {
> > +				WRITE_ONCE(vn->pool[i].len, vn->pool[i].len - 1);
> > +
> > +				if (!--n_decay)
> > +					break;
> > +			}
> > +		}
> > +
> > +		/* Attach the pool back if it has been partly decayed. */
> > +		if (!full_decay && !list_empty(&tmp_list)) {
> > +			spin_lock(&vn->pool_lock);
> > +			list_replace_init(&tmp_list, &vn->pool[i].head);
> > +			spin_unlock(&vn->pool_lock);
> > +		}
> 
> Failure of working out why list_splice() was not used here in case of
> non-empty vn->pool[i].head, after staring ten minutes.
>
The vn->pool[i].head is always empty here because we have detached it above
and initialized. Concurrent decay and populate also is not possible because
both is done by only one context.

--
Uladzislau Rezki


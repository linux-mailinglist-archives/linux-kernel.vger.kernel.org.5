Return-Path: <linux-kernel+bounces-84835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654CA86AC45
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1760B216E1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFB07E782;
	Wed, 28 Feb 2024 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4RHgKta"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2EC7E57F
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709116779; cv=none; b=ZdITXrMubwM61o+eFEXyOjbiJBQWwde7J04PY/fvogL+EZPw3ErMwRYPTNDkFnzN3+991Tnl1NM0FxGkjaL6JnAGLltlQpjETNzSM4Ejlw6CcLXPKr6WrlpLiNatKJYQxWI0ksn4Wx7AgW/SVO/c0re9bFD2SkQAyft8JX4kC1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709116779; c=relaxed/simple;
	bh=vsp7J7sX0/IQCiho0HvRaRQEuc1nMmYaeUWz1XcGg6E=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4YFvgldpw5xLdtJlPF3RaE8hTOt1ce3oqJQYKIpGz/0/wG3UYNslNGY3mI1O2azrbzF6RK2k6KACvaU8zW611zfygNtczj2PheWFCPLo4/vPriH/uHppOmgLfvrJk9O2Pox0aZDvBju7RHKT/E3tEJuh4FwOxRN5D2udyPVOjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4RHgKta; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512f54fc2dbso3958126e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 02:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709116776; x=1709721576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XWpPSCtbSYio+DeT18wpsPlKpR4iiukyGBwdAsdEBKI=;
        b=Y4RHgKta1LJ4Y0tLkqyx42UiAkSgLSPggYbifOdvPML630/qAuT1hxRmQ7U+X8+Lgd
         cBJJDtJurdK9J26gVTLmA48Oen5gvhOHR/w/DkBmM+LVp18VWu54mJcwHQ1/e025ampr
         w6FpR14ZWfcDgpWOqc/FJN6Caxpgjg3CehYJYdsZ/2scBrGszl65OtWyCn8YHFjHs0ex
         ugf6n42cLpMHEUvUAXr+vw+s5AZ7fBEcxzbw69N7asvplKKM5KtY1O2tebZmhYpQpFWm
         mgUJM/zoY+gietwYLDrJbHxJCU5hgamVzKrgNghH3DgsieNhq40USoyP6w0GNPAraJNm
         d9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709116776; x=1709721576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWpPSCtbSYio+DeT18wpsPlKpR4iiukyGBwdAsdEBKI=;
        b=gLWfAnh6pPdE79cSa56FT1I7DBZiYOtCVrTjXxSQs6aSk19YowYKTY7DqRSzmQGFga
         FRoS8jfW9W4NaUsoN84bCmyuJkxwrw/6yMB0ciZuCL5Wl2bGgnDlKwOlxLf5WE6yOEf/
         2VNxrrMwsfqQ1pex1YGhRx1oY5pKZ0OrOQfzhtSfA2WkIJoHS8uNdMAXYSfdXnxzY3yW
         HpU1KSYDdg97M5G4zdF74NwyIMBzNIFBGx7AkzgCACkvt/lrYd1thl29uKHgYUsLjujl
         I403iHmNtdnMBGHV7lSMT4Fyeg5CbH0fEbNwbn84/ozkljuBf17vjuF3tF/9WSvb3p06
         hSeg==
X-Forwarded-Encrypted: i=1; AJvYcCWCQAae57pT7I21psOur1+pLccRdagynpnkVmfXJJPEIylG5F3RhJrTDGNNGmXhR2tf23fqM1/W7VzUiBmju2liEglivmit+8aOjGgR
X-Gm-Message-State: AOJu0YzHBUERRk1mAA65p+3x05NTp2vWUKC6bFEOpl+FEDsvT0Y9m6Rx
	c1mzFYAQSi5CUKDIzGHQkK2yd32iLBguBpmDDpgVCzHGTcP0MjyP
X-Google-Smtp-Source: AGHT+IEO0aDTAScUzF/jCj4fdB9+Oyc79SOTodc+CbxayXL5+glrJszgUAGAdDhYwYX9zPLQ2H1TjA==
X-Received: by 2002:a05:6512:a91:b0:512:ed78:a840 with SMTP id m17-20020a0565120a9100b00512ed78a840mr10150412lfu.61.1709116775968;
        Wed, 28 Feb 2024 02:39:35 -0800 (PST)
Received: from pc636 (host-90-233-206-150.mobileonline.telia.com. [90.233.206.150])
        by smtp.gmail.com with ESMTPSA id u3-20020ac25bc3000000b00512dfa19983sm1490824lfn.50.2024.02.28.02.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 02:39:35 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 28 Feb 2024 11:39:32 +0100
To: Baoquan He <bhe@redhat.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
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
Subject: Re: [PATCH v3 07/11] mm: vmalloc: Offload free_vmap_area_lock lock
Message-ID: <Zd8NZFcNn5oekda4@pc636>
References: <20240102184633.748113-1-urezki@gmail.com>
 <20240102184633.748113-8-urezki@gmail.com>
 <Zd8BhUsh8sggG/RH@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd8BhUsh8sggG/RH@MiWiFi-R3L-srv>

On Wed, Feb 28, 2024 at 05:48:53PM +0800, Baoquan He wrote:
> On 01/02/24 at 07:46pm, Uladzislau Rezki (Sony) wrote:
> .....snip...
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
> 
> This isn't true if the pool has less than 4 objects. If there are 3
> objects, n_decay = 0.
> 
This is expectable.

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
> 
>                                Here, --n_decay will make n_decay 0xffffffffffffffff,
>                                then all left objects are reclaimed.
Right. Last three objects do not play a big game.

--
Uladzislau Rezki


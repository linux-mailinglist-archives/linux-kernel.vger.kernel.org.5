Return-Path: <linux-kernel+bounces-14166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB2A8218A7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5A511C216A6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD1E6139;
	Tue,  2 Jan 2024 09:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O7juPMa4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F5D5672
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704186017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7hTQmZh5y3zaYz7umyfdjLpp6zXbUTP3L2zYpMTvo6c=;
	b=O7juPMa4XvRpglj4WLzcKDeuM5sNSAmfOnwR+iL+zU5WyArwC02KO1T32Dc6VvghGVNZGq
	l2XK+ICvnr8xn/JXBVNSocrNPjxv9GIoLgMEhJIJWQxirgpvR7dQT6853RZFqf5MvdwDHJ
	cdwrskNCsxmiBiEdXnZb+BO3pyFGGY4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-X3d9sFLbO0qfZB6pvGCa7g-1; Tue, 02 Jan 2024 04:00:16 -0500
X-MC-Unique: X3d9sFLbO0qfZB6pvGCa7g-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28bd331cb57so2766249a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 01:00:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704186015; x=1704790815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hTQmZh5y3zaYz7umyfdjLpp6zXbUTP3L2zYpMTvo6c=;
        b=fUkoc7hGBBzCIa7rNlRDS9BhMbIZQRypd+Bo7frk+n7h6UVj6e1ilDU94umxiPZlD/
         nztDeRinY+28Y6e7e40dEJfQ22Ev/hjLL4DMmxJkqUhRUBrWFftzG3tQ+KSS8OXPfi0q
         /wylS3ZmzKjMlQRPD0HauUf3oPhQnx13vYwBIXUj77Y/xu4IqIlZl3HvF2FZWjSiIZge
         tWnkYdgDu157IkeAs+RHY14SzBQ0MbUzhTjg+tVWvC7h/3FOaKRcaWLZdIRZJ+dyS9rF
         0XALnJ48sIFV8zi0rd63J4aNUHlSI6BKXOx1Lb7/77xkM0eu6X/Kz5wtEQuAuAPRaSe2
         H6cg==
X-Gm-Message-State: AOJu0YxfZg+WabTOMHJ/gjtOJtDQBMJdirGouvlbKvBwhRi47S8litLT
	y8t6HlmKHzJ8GYmDeGk0Fd3wFWOzUsb85oH4KgK1Vk1v9EWu7yYlO1Jjl9AeLjgHQqSJhG0XXe8
	+XIWX7yQAyERGmVoytm99gLiWEJaRNI4E
X-Received: by 2002:a17:90a:bd17:b0:28c:113a:9678 with SMTP id y23-20020a17090abd1700b0028c113a9678mr23773678pjr.4.1704186015104;
        Tue, 02 Jan 2024 01:00:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrXpLdU+hn5Ohkn+pL4MWX99S7hACEAUpLWxDWVhqo29Z1a8GD0ci/X/NzUkbZnrDM1DPA+g==
X-Received: by 2002:a17:90a:bd17:b0:28c:113a:9678 with SMTP id y23-20020a17090abd1700b0028c113a9678mr23773618pjr.4.1704186013844;
        Tue, 02 Jan 2024 01:00:13 -0800 (PST)
Received: from x1n ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id w5-20020a17090a6b8500b0028bd0a43bc9sm24391031pjj.2.2024.01.02.01.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 01:00:13 -0800 (PST)
Date: Tue, 2 Jan 2024 16:59:56 +0800
From: Peter Xu <peterx@redhat.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	shuah@kernel.org, aarcange@redhat.com, lokeshgidra@google.com,
	david@redhat.com, ryan.roberts@arm.com, hughd@google.com,
	mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org,
	willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com,
	zhangpeng362@huawei.com, bgeffon@google.com, kaleshsingh@google.com,
	ngeoffray@google.com, jdduke@google.com, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/1] userfaultfd: fix move_pages_pte() splitting folio
 under RCU read lock
Message-ID: <ZZPQjO91fvB66z1s@x1n>
References: <20231230025607.2476912-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231230025607.2476912-1-surenb@google.com>

On Fri, Dec 29, 2023 at 06:56:07PM -0800, Suren Baghdasaryan wrote:
> @@ -1078,9 +1078,14 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
>  
>  		/* at this point we have src_folio locked */
>  		if (folio_test_large(src_folio)) {
> +			/* split_folio() can block */
> +			pte_unmap(&orig_src_pte);
> +			pte_unmap(&orig_dst_pte);
> +			src_pte = dst_pte = NULL;
>  			err = split_folio(src_folio);
>  			if (err)
>  				goto out;
> +			goto retry;
>  		}

Do we also need to clear src_folio and src_folio_pte?  If the folio is a
thp, I think it means it's pte mapped here. Then after the split we may
want to fetch the small folio after the split, not the head one?

-- 
Peter Xu



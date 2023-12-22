Return-Path: <linux-kernel+bounces-9245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A91B781C2D1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 02:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491201F2598D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD13566D;
	Fri, 22 Dec 2023 01:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YIGN3i3U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2116E5390
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 01:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703208959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2akJnTxfKkE9MplltMUxeeJDEmgi/IaQGIuEfCeumQQ=;
	b=YIGN3i3Ud3EPgN/1HeZsnfkSnyuKZ9BjyPcaTp7K544XYFN8h6sC27DUXhkz5RQlgagpGv
	s3MQimlXFR5rRiBLOPevHRrRBxHy1As1yglULOqPV7BLAebrywmxa8VjVh0sKvrhlVZCY1
	i1DidW3OynKFMp8Sigo5JLqn7flGdeA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-QQCudm3DM_-tJcR74Y6RYg-1; Thu, 21 Dec 2023 20:35:58 -0500
X-MC-Unique: QQCudm3DM_-tJcR74Y6RYg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-28b49899812so415488a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 17:35:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703208956; x=1703813756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2akJnTxfKkE9MplltMUxeeJDEmgi/IaQGIuEfCeumQQ=;
        b=vjxLuNREE+MOy+3+Lh/7jRAlfTwc26N6mpCrZt6BjfgIcUoOOHf+AnQS+NQDF82Bun
         U7dtHNzc6w8TeXhtW12gWznyTVz0PiRx7hQhnc+/BQgk8p6Syw9cEhIsP7UrHzt1zW6E
         Y7jMiwAb3IDhz+oPaGep1mNWBLzvmyGrwDW0dmNfRVpm6NNTjzjWKpxEfEPDhGbPwGkC
         OLjWJj9imF10DDsTTIAYE1qT+cDQvH9ctI+IRzS+3jhtMadNyu01FvEqXH12rgdG5p1j
         eb9NQnoRljH6fD40SlPh6LcBYTlSVARwhCuk6vrPph3x4ogo7HPLX7lwuwNv8uiGYsQO
         PtVQ==
X-Gm-Message-State: AOJu0YwLCB8Z+13zEsRUzFQGTIdRTLtbOoy9U4+8889dj8bt5Nt6uFhB
	d/Cr18wnJk5r51eSu+z1Z3bgKCvP8H4DTzXZ4aKwN/F0B7yCNNdlaMIku4AMO0MUPzpGRF9hQ8I
	j/hekhCiJa/18CGTmTQZtZXHKVISw3Ph8EREALWRvBnqaczBModH7e2/+TFB1GbvbkyOjaBVkZh
	k31Kld6BhpIIu6PnO0
X-Received: by 2002:a17:90a:4b8f:b0:28b:c1ad:9cef with SMTP id i15-20020a17090a4b8f00b0028bc1ad9cefmr1137555pjh.3.1703208956332;
        Thu, 21 Dec 2023 17:35:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1CdzSSxO6gL0EU6CjYH72GBwDyRwTpiPtorA3Dx6OQ9XzFAqCTOZ2ez8iSmfN4CA4vPwFxQ==
X-Received: by 2002:a17:90a:4b8f:b0:28b:c1ad:9cef with SMTP id i15-20020a17090a4b8f00b0028bc1ad9cefmr1137522pjh.3.1703208955962;
        Thu, 21 Dec 2023 17:35:55 -0800 (PST)
Received: from x1n ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id qc12-20020a17090b288c00b0028b6f522fedsm6308509pjb.43.2023.12.21.17.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 17:35:55 -0800 (PST)
Date: Fri, 22 Dec 2023 09:35:43 +0800
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Muchun Song <songmuchun@bytedance.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Andrew Jones <andrew.jones@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	linuxppc-dev@lists.ozlabs.org, Rik van Riel <riel@surriel.com>,
	linux-riscv@lists.infradead.org, Yang Shi <shy828301@gmail.com>,
	James Houghton <jthoughton@google.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH 00/13] mm/gup: Unify hugetlb, part 2
Message-ID: <ZYTn70CDVeNMed0f@x1n>
References: <20231219075538.414708-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231219075538.414708-1-peterx@redhat.com>

Copy Muchun, which I forgot since the start, sorry.

-- 
Peter Xu



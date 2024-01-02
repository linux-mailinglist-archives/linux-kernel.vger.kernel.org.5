Return-Path: <linux-kernel+bounces-14056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 371B082176F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB014B21447
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FED137D;
	Tue,  2 Jan 2024 05:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VSi8N1Hl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A84210FC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 05:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704173990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bbq0KObq2f8j+82pUN4AGj7eg3qIjhtUEVS9ATEV+Oo=;
	b=VSi8N1Hlec/TepJlaoQRz+NuUZH16sm1efSRNwEAa/HbBvNmy6+MLfKOzdAQv/8cJKOo0L
	ge4KTeeIBCTGPMtHscApBLxomVXGOqnIPAydpGzwWQ+QMRwg54Z34ft5KEPnYIVmJHlg5w
	dgbj5y8lXW/sIEmDP+sQYGBeRTKspiA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-fBY9ca7mP5CxrC-rfxtvEg-1; Tue, 02 Jan 2024 00:39:48 -0500
X-MC-Unique: fBY9ca7mP5CxrC-rfxtvEg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-28bd331cb57so2730269a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 21:39:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704173987; x=1704778787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbq0KObq2f8j+82pUN4AGj7eg3qIjhtUEVS9ATEV+Oo=;
        b=VBi5H1NzAEKj3aMzQyBdqz4+7LeyGONayZBM8s75cXkK7meee2vga2zajIUuxDZ5WA
         aUSpNonhf2S0B352G0Ky75aMriuP1wH0QFPuXe08WynZPwIiGV38I57gfhFj4Il3TueO
         jj5/viKtw8Q1YTHj8wyIbZYrO33Nu5kmIYChbG5aAn4eI6R+dBvuQOVDhoD5ou86/lv4
         8YKYoQnWd8Har5kAyDrTmmsRqbro7i+ATXpotXK5zfFokcobr+pHtxWIVVUBN1ehcIpK
         7M90yZsiXTv0BfAoNNLhKMjmHmAlblB7d8Y9F85jATPEDBhrMDQ/+0Bss3Z4EHHp9VG7
         bbdA==
X-Gm-Message-State: AOJu0YzSq9B1xDLxwszmSCj+kHRDjwdt3Sxn4MoT59776P4C0Zf6+itz
	AbIb0mnUDdTQhwjy4iw9ttBKqrUe8QqQkqaj0bxCMDyxWE0Bz4+S3dYOLMSrUgtbNCM0/a7OHsw
	aRN1hANuhhS126x3rqW8MKylh7+t8AgvV
X-Received: by 2002:a17:90a:a589:b0:28b:bd2d:f924 with SMTP id b9-20020a17090aa58900b0028bbd2df924mr24809543pjq.2.1704173987589;
        Mon, 01 Jan 2024 21:39:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuR1t3QCDF99soHy376+nbiN/c3MDqPEKDqcI+XWwTDxY2xbRtvWRrTvKfEHzNP7Fpwq1DzQ==
X-Received: by 2002:a17:90a:a589:b0:28b:bd2d:f924 with SMTP id b9-20020a17090aa58900b0028bbd2df924mr24809540pjq.2.1704173987309;
        Mon, 01 Jan 2024 21:39:47 -0800 (PST)
Received: from x1n ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id lt24-20020a17090b355800b0028cb445ade2sm6857199pjb.16.2024.01.01.21.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 21:39:46 -0800 (PST)
Date: Tue, 2 Jan 2024 13:39:32 +0800
From: Peter Xu <peterx@redhat.com>
To: Muchun Song <muchun.song@linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
	Matthew Wilcox <willy@infradead.org>,
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
Subject: Re: [PATCH 05/13] mm: Introduce vma_pgtable_walk_{begin|end}()
Message-ID: <ZZOhlB-KK4hF3PgY@x1n>
References: <20231219075538.414708-1-peterx@redhat.com>
 <20231219075538.414708-6-peterx@redhat.com>
 <0D9E28F4-AFA8-479C-8311-093DAFD9DF41@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0D9E28F4-AFA8-479C-8311-093DAFD9DF41@linux.dev>

On Mon, Dec 25, 2023 at 02:34:48PM +0800, Muchun Song wrote:
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>

You're using the old email address here.  Do you want me to also use the
linux.dev one that you suggested me to use?

-- 
Peter Xu



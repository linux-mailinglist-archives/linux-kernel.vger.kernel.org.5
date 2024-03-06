Return-Path: <linux-kernel+bounces-93327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73FD872E0A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34D96289A33
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FD41757A;
	Wed,  6 Mar 2024 04:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="MihSQD3n"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41054D502
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 04:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709699922; cv=none; b=YSaeiOMW1ji7ynjHmro/aHfDg7aFW/Fo6MbGPfX6riKX4Zy45ELxF4bibwsaj+uKQcjQxUCB7kKFr35F1qr821JOq6Eu7OuIlw57rHxlXJAbc1oXgiLlBc+uVqOMk61RL+kDwYeOkL1qwCFoCcGcOg/VyRzTjvEu0YZQo3HtEWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709699922; c=relaxed/simple;
	bh=H5Cs0WgN4HGxfefS4RsQQ7ok2rioEczgmMWuHda6CP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPN1w4Ov1Oqksp+Erh5bodheizkUQB4J6YhNmipEgyJNBNHJwTLMxvo9xs0ysFEA/ptKPOP8TlWRIF36wj0CXsPYwXXufD1rxVmB65UgdN7RcTuwG4B6lYDrX9+zK6VgLS31gS70RvJsrBZ0GbyWcTfq1zC6zIjigJfv6iLkmIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=MihSQD3n; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7882c4a259bso122697985a.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 20:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1709699918; x=1710304718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H5Cs0WgN4HGxfefS4RsQQ7ok2rioEczgmMWuHda6CP4=;
        b=MihSQD3n2XSzWh4bf45SPmln+RR+us3qstjAxOEQSkYcGrkKIgs51sy1jlgzInww+G
         1wYOknP4Awqv0/ZoSb2RHEPL3vS9CntM45AcG7tQJo6u16d468n+Y2C+gIT3AUZfYmUB
         BTCCWFe+HZ9IhpDuoIyhrBoRYcExuRcQ1amEwa3+2v2N44VlHcndWWaHKHE2hX7SpRDX
         ciF7HNDB/29ItzEVgdQoKADoUCKFht3a6rlbI/khLT0S0Sw85WDANMdbrCHw7mmuUDcT
         qRlZJkRcmbT2gaEulzZIYehj1rQ3EFuk/sQGE3UCGFTG5TfIqS44OpB4aII1W6BvxZTE
         s0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709699918; x=1710304718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5Cs0WgN4HGxfefS4RsQQ7ok2rioEczgmMWuHda6CP4=;
        b=Z3AQfd/HOAmcCN2Q5rhyGSB4h5UTfYkLsCjrwtKmYtSgsMu3LHPtMQcbIxNn0/91Rn
         wJR+sq+kL6t3jlXhcOD956uCVoueQXDl41LAIRSi21Mydw4i/snn/kzwED8Iwb3p/CI4
         wi6yKtvcsgQKzj492T0YXh8w2ft0zfnrIJhj6WSn4NNPQF8hgDfGatbziD1BBamDo72Q
         4rPODMDJMq0kkHX3VKRYwYXMBspCl0Jkgk9wuWLopwOotAZYlY2s9MeRXpYh30nUHXyb
         VB9gyuhetSYKhLuPT+XRj3DOPlBYeP2BoFGAOOFrfXXF2AncLaDNzZDW3HWlvRw4JXw5
         CslA==
X-Forwarded-Encrypted: i=1; AJvYcCXPHzXW+7BRt+ov1TxtWG2mCRQvdyH2ndEwwpyQm8A6NbBnLyCO/itQs/CCjAv4R3LndIg8pwlhEKhi+DxIKGKgNJQfJRFevgiVsYud
X-Gm-Message-State: AOJu0Yx36y1QGxiBZThTrqxWi+mHmvHtzxdEjuVWKFqlC3wIUmalvbVz
	hjuEeZmZvmjBciaXsplPHGpA39dVJpXGCwonFFLr/wsX11yvKZ/dQ+U4o7u0tTkUDIvwUDJAqCZ
	J
X-Google-Smtp-Source: AGHT+IHcgDuex73i1sb6eOmPxRVTfio+RyI58EfzQ8jAaxQ1lVw7tZwGtq5iU1jrypr0r/MmYj8uGA==
X-Received: by 2002:a05:620a:171e:b0:788:3e25:7c55 with SMTP id az30-20020a05620a171e00b007883e257c55mr1358358qkb.49.1709699918042;
        Tue, 05 Mar 2024 20:38:38 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id pe23-20020a056214495700b00690766cd5b5sm2883876qvb.141.2024.03.05.20.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 20:38:37 -0800 (PST)
Date: Tue, 5 Mar 2024 23:38:36 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>, Zi Yan <ziy@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 01/10] mm: page_alloc: freelist migratetype hygiene
Message-ID: <20240306043836.GA891917@cmpxchg.org>
References: <20240306041526.892167-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306041526.892167-1-hannes@cmpxchg.org>

I didn't realize Mike's email address is defunct. Be sure to remove it
when replying to save yourselves the bounces from the Oracle MTA.


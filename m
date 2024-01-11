Return-Path: <linux-kernel+bounces-23673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D619382AFE2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E8E28C242
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333C532C87;
	Thu, 11 Jan 2024 13:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="xRyN36Us"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C4632C6C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 13:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-429b76f129eso8423261cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 05:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1704980619; x=1705585419; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1KFXDERr3pDZlcRyum1ggEXEmpPYyroR1nfySc9tJl0=;
        b=xRyN36Us2k1drP4z7QYI4RJxYcksrPfWfuDsMMmp4VhKa5wg9Na4cBfxpvoggiq8lZ
         6Kd8zU4ydcxkcteL55+G2bNs6nDZQYxUKKoChCQf2/nWxJ/bTo1hFA2IS9hKPPtuc8CH
         wh6ws2P8mbAtd5x7kXArEbS92ovqg4I1PVDllDItWblDI9MkgS8M1mJBsVlyTqlnnhZE
         GGFo8UUwlLuUFU0f4zuwZGLDo6Y33mjhIy1eqKsCJQyVv9rz/2B8x62LcTxAbW2fexsW
         EvZNDwW74/3FTHJej6dOJXplb7BxmTBI0ocevDv9ZUPo+C1bOfwWEQClJUiud9tEU6in
         cNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704980619; x=1705585419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KFXDERr3pDZlcRyum1ggEXEmpPYyroR1nfySc9tJl0=;
        b=Kn2r91zypcdnlGiTIvYIEoNywXH/csDDIoE10mcvFX0WbRNWNjDdSNOnFCYPqIyOGN
         6MKzpSmfZ35g1k7F0i6qO9Wes85SvvPnek5NIS61X6Xx1lx2PM0oa61+0NFioL2EnZ21
         Xn02mapz0y4vZhW+UF+HA7bvyQC7PfiKcw/jiN+MxrcoygL7w0aJaPoRouXc2+2rSa3C
         FMC9YKYEmvWC3eOLtKqv4qmmJjo/pA+33DternYM3ftz967M2pDYMrqxt5dM66R3KxRM
         Ir6CfDv03ETuctQ7rOGFaOBURbDwLz7ieQw270RR8j6ybjlB59e1vgGRkqxCmgddy4xg
         NOdQ==
X-Gm-Message-State: AOJu0YzT2IqoQm/2ss13YzcmDuPXLQeTTWXRvuslAkLi2oHqi1am+zfp
	mOsuRbeli1Gz0WSfQhFTHDb5+FHITPHvOg==
X-Google-Smtp-Source: AGHT+IF1SDgwokzxyx1Lo9I3aSo2nbw9Nk3i7W+ba4rDycvJdrMVL4Kmi9FdBM0vduMgOwrl+YPC2g==
X-Received: by 2002:ac8:5945:0:b0:429:be1b:fd8e with SMTP id 5-20020ac85945000000b00429be1bfd8emr701915qtz.33.1704980619331;
        Thu, 11 Jan 2024 05:43:39 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id wa6-20020a05620a4d0600b00781de2da438sm341939qkn.107.2024.01.11.05.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 05:43:39 -0800 (PST)
Date: Thu, 11 Jan 2024 08:43:38 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Zhiguo Jiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, Chris Li <chrisl@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>, Yue Zhao <findns94@gmail.com>,
	Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1 2/2] mm:vmscan: fix shrink sc parameters issue
Message-ID: <20240111134338.GB390292@cmpxchg.org>
References: <20240111122451.682-1-justinjiang@vivo.com>
 <20240111122451.682-3-justinjiang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111122451.682-3-justinjiang@vivo.com>

On Thu, Jan 11, 2024 at 08:24:51PM +0800, Zhiguo Jiang wrote:
> The values of struct scan_control's members obtained by
> prepare_scan_control() are always from root_mem_cgroup, rather than
> the memcg where the shrinked folio is actually located, such as
> sc->anon_cost, sc->file_cost, sc->may_deactivate and so on. This is
> an inaccurate sc values for the actual situation of the current
> shrinking memcg. so we need fix the values of struct scan_control's
> members are corresponding to the current shrinking memcg.

You don't seem to understand how cgroup reclaim works.

Nacked-by: Johannes Weiner <hannes@cmpxchg.org>


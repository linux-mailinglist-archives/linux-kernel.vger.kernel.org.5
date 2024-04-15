Return-Path: <linux-kernel+bounces-145716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD448A59F2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44D01F21122
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AA1154452;
	Mon, 15 Apr 2024 18:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzCIWI7Z"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A11B656
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 18:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713205984; cv=none; b=s9oYskThAXiFWZhoBPZNbotbE7pIcjAVQBNXJH7TSSXIRAGT9p10Y/Ef185EPc5oeRJHIk4CSirr2E7KUrubhIp2NWOsK1UlxWUT2K8zkVV6IARjXEDiWDY62kZz1MNgZKu5xVJHYvgVcj2ZVrcHNfFBtsBuUATrusWWkeuq/xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713205984; c=relaxed/simple;
	bh=4+g0QffiScKf3lteB8iMkNUtNjxVHUDjNh9QfRjrXec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nupg4g67oCRMzk8RUy5gUVV2fABv7cW7widBuz53jbtlFC+vVlwYYzsUCrsGfaPuuUF3Rv3jEAiJqwVGQoOoVZ9jFJDIHpOEbGZQ3adrvJwnSxdR+Uz0In1bMPjE1ziY6yc0fzRy7cnu/FXwOTUoFp/uyhvA9vXnOQMW3qi9tJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzCIWI7Z; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-61149e50602so22989777b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 11:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713205982; x=1713810782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eNcHy+TzPeXZ42fji6L7sScXpSVOyjoITtnKJA+IyQI=;
        b=DzCIWI7Zc48A4+zR1ijw1k8ub0tF2rS8nE/vvAoSreJmb1Y7htWR1PnEgFzivwtyra
         Wj+w1+wL+kaa2C/pgT8BUaKJTlF+0UztJQUdSdRhTtcg/YL7Hed9mh14vM01pxnhWl77
         w5coZNTlOv/qBjQmvAnWbVvPYfi+MLNN52c9oqx7yEhHL+6Bsq1GXVdLXYURpJh/FU3Q
         iuxLNJU49AjDwB8XolJzjX8MLhDnMAIWjIwuxToKca88mgK4SHTAo/ksipT88xJx9hgu
         qDRNcmSuhiz+6hKbPEdZClwTf6sWIxQ+KHDrfj6O1jbKjM0BihSr/chQb4ml70/U5kON
         eKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713205982; x=1713810782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNcHy+TzPeXZ42fji6L7sScXpSVOyjoITtnKJA+IyQI=;
        b=WVFgKcKiDz3ulfFM054rTDiJbyaKJGKSx19YuwmbXSReUBmIzDvoi5s0RRGTYTptpU
         M5ZtFVwgVkXQBGdc+5N1Dc0y3X6Twe7TMXdAee9SWC2np/4NqgSLwHEhrNMBltYHKS8e
         erNo0qqY7+pl+1NF18HexrwLYBjUVCblZbK5ubuKLR4L8oQVE9iiBRi3YLl2Q2WYgpnx
         wrAuOPPjcGY1jEzDOWw8lm6EQOyUXDkN3UEZyw9bLwiJrv04QxtHXtEArs01qQTDsg5s
         kbnIpnQoStqffAQ2Zw+H03ra0trHl3dwU+zg5xw1yp2m7O9t/JLCw4JZNC9pEmm1JdT8
         JIbw==
X-Gm-Message-State: AOJu0YwhDhs3dbs9SKVgJ3/ejDS4OHuDOQLhKGpzx0bXymbx9mn8s48Q
	doBDD67vdft2My7cDgihCRGyOiIxmofuPwMpetqSPp68Zss+I//A
X-Google-Smtp-Source: AGHT+IFd41E0xJdFEcj79NR6aKf7SidRiPcSVcgBmo4FP5MGfmt/Q2iLAkLuDmynUN7XhOfNcDBFtA==
X-Received: by 2002:a81:bc4d:0:b0:61a:db4d:5f16 with SMTP id b13-20020a81bc4d000000b0061adb4d5f16mr436941ywl.15.1713205982014;
        Mon, 15 Apr 2024 11:33:02 -0700 (PDT)
Received: from fedora ([2600:1700:2f7d:1800::23])
        by smtp.gmail.com with ESMTPSA id i194-20020a0ddfcb000000b0061ab49c04e9sm1016739ywe.76.2024.04.15.11.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 11:33:01 -0700 (PDT)
Date: Mon, 15 Apr 2024 11:32:59 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, willy@infradead.org,
	linmiaohe@huawei.com, jane.chu@oracle.com, muchun.song@linux.dev,
	nao.horiguchi@gmail.com, osalvador@suse.de
Subject: Re: [PATCH v2 2/2] mm/hugetlb: rename dissolve_free_huge_pages() to
 dissolve_free_hugetlb_folios()
Message-ID: <Zh1y25IizELqexR2@fedora>
References: <20240412182139.120871-1-sidhartha.kumar@oracle.com>
 <20240412182139.120871-2-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412182139.120871-2-sidhartha.kumar@oracle.com>

On Fri, Apr 12, 2024 at 11:21:39AM -0700, Sidhartha Kumar wrote:
> dissolve_free_huge_pages() only uses folios internally, rename it to
> dissolve_free_hugetlb_folios() and change the comments which reference it.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  include/linux/hugetlb.h | 4 ++--
>  mm/hugetlb.c            | 2 +-
>  mm/memory_hotplug.c     | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index f4191b10345d6..9ad7b97069cda 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -862,7 +862,7 @@ static inline int hstate_index(struct hstate *h)
>  }
>  
>  extern int dissolve_free_hugetlb_folio(struct folio *folio);
> -extern int dissolve_free_huge_pages(unsigned long start_pfn,
> +extern int dissolve_free_hugetlb_folios(unsigned long start_pfn,
>  				    unsigned long end_pfn);

Same comment as the prior patch.

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>


Return-Path: <linux-kernel+bounces-119804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CCB88CD25
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39951C66854
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5ED13CFB7;
	Tue, 26 Mar 2024 19:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvV2daFp"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C21113C9AA
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711481111; cv=none; b=Ii4haU9P9VCRSJ54IaWMGSbSMLILSe5bHsxd/+P/ZvGp/HF9HeP/A60U0bO4xvraKuNoDAZC79pllw8zwj9Ki9oIEvF++kbqGFngGICmTjVLt6O/UAP82KCI0UoRYWWF2ElRdCCkzC5FuW/FvHetEpRD83cJoECrB2LiV8QuWeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711481111; c=relaxed/simple;
	bh=qlgCCF65Mdz/26INtET157LBM37ltIjjtKd9mQ06vck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaYh0UvxlPuzu7Ri4ur3odASWHdnephiZeslCdC1x5IIM8UU4SunD7WHokvXIhOiK3pB8k6bGb9x1EnadGevhMnUbgTskGTsFfL1oU9m4TwxzO6y3d7GYzNDpVCPh+PEsU6x1avx6vac2psXNH6oa+6C4W0zXHYYLDM6/YE7wYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvV2daFp; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1df01161b39so47883435ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711481109; x=1712085909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1xHcSlRlsL2MMtbELEV9tvcgwC1xTcE9YjZjsSqQUc0=;
        b=UvV2daFpeovCevb1Jga4yU5b4qnNz6/qE96aOIm7C7k19iq+tu6jvvGcKPoiOrXkjg
         KYps+AbRcygXizljAtOnOY1pfEs1Pf67h5/Kxe+vUXBZscJZ1GsjkbfOI8Pp+hfiT9Bf
         +UhrkMuqSBLD9uuLroBoFMaeLsCIIWTqsILi2jMHkxeeHKw15eE2VERJ0dKkVm9Q048O
         PxrRG4KbgunR6Q8d4sKbZhTBN7SjBfc7lHCXxGVXPxD79HqEaE9gg2QYz3UaNKObAldu
         /4DHkOth25Uy3YzdTknAf0WQsAXwjZF0FVl8j60Hr0mPuh7NnJiJiXil5vJcpstqVVxx
         DhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711481109; x=1712085909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xHcSlRlsL2MMtbELEV9tvcgwC1xTcE9YjZjsSqQUc0=;
        b=g8IwOJNGxp5QT5lc4OZo86svagicqm7aS0NbMtIEJAo6bYYf3gp9lK594jI6Pprq9s
         ozWj7JKjuJLqac7TNanGzYepH+wIFkncmgq5uYi8S26pBXkesKX7clCe2ATTqaxDQDb/
         Yji/nHxv0xKNGyU19j/cVCThzWdRHxSZMdzl/uKowWcS9q4ezc6CwH+4Q/4eCyhSgnWk
         EkxeGFy8BRdljybnTJrNQAZLxF7/jZ8LbH+8iWEX7SQ6lkIPTahQQzQBu6SL87ZXiuca
         8zKB2dgPSHL1QdUtSGdTZTvwbMAYyOhxRc74Hi0bZXf2kC+gtg6cLgHRCcW3rBtrET2n
         Ye7A==
X-Forwarded-Encrypted: i=1; AJvYcCXaESzWHNSKRdTEm6/3BzzQod1rj3V58V/NEwpuATiZTExVE3AzhA3hbNWTzkiw29AvKB1Xycom5/F7k+P0DjH8hjJWwnnsaBU2sIho
X-Gm-Message-State: AOJu0YzgyQKK6f3L7p++a8W1DsBvfKl4OMp7pphBDZvD0qP+qN/UU1ae
	F+/J2DzS5Y2QZVhRapPMXaGtJ5ps2v/7xG+Iy67LElOgnG0/3MQh
X-Google-Smtp-Source: AGHT+IEFNXe6M/FjjmkT+Pzey2UZvruczwOvB08e5gQq6a7X+FamiRz1uFsQyhIOpxd+4UlBnKbPtA==
X-Received: by 2002:a17:902:e807:b0:1dd:8c28:8a97 with SMTP id u7-20020a170902e80700b001dd8c288a97mr721240plg.6.1711481109313;
        Tue, 26 Mar 2024 12:25:09 -0700 (PDT)
Received: from fedora (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902eacc00b001dc3c3be4adsm7205550pld.297.2024.03.26.12.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 12:25:08 -0700 (PDT)
Date: Tue, 26 Mar 2024 12:25:06 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: akpm@linux-foundation.org, hughd@google.com, david@redhat.com,
	rppt@kernel.org, willy@infradead.org, muchun.song@linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: pgtable: add missing pt_index to struct ptdesc
Message-ID: <ZgMhEp4R7de8oeAA@fedora>
References: <cover.1709541697.git.zhengqi.arch@bytedance.com>
 <283624c2af45fb2090b41a6b1b5481bb0a45bad7.1709541697.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <283624c2af45fb2090b41a6b1b5481bb0a45bad7.1709541697.git.zhengqi.arch@bytedance.com>

On Mon, Mar 04, 2024 at 07:07:19PM +0800, Qi Zheng wrote:
> In s390, the page->index field is used for gmap (see gmap_shadow_pgt()),
> so add the corresponding pt_index to struct ptdesc and add a comment to
> clarify this.

Yes s390 gmap 'uses' page->index, but not for the purpose page->index is
supposed to hold. It's alright to have a variable here, but I'd rather
see it named something more appropriate to the purporse it serves.

You can take look at this patch from v5 of my ptdesc conversion series
for more info:
https://lore.kernel.org/linux-mm/20230622205745.79707-3-vishal.moola@gmail.com/

> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  include/linux/mm_types.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 5ea77969daae..5240bd7bca33 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -425,6 +425,7 @@ FOLIO_MATCH(compound_head, _head_2a);
>   * @_pt_pad_1:        Padding that aliases with page's compound head.
>   * @pmd_huge_pte:     Protected by ptdesc->ptl, used for THPs.
>   * @__page_mapping:   Aliases with page->mapping. Unused for page tables.
> + * @pt_index:         Used for s390 gmap.
>   * @pt_mm:            Used for x86 pgds.
>   * @pt_frag_refcount: For fragmented page table tracking. Powerpc only.
>   * @_pt_pad_2:        Padding to ensure proper alignment.
> @@ -450,6 +451,7 @@ struct ptdesc {
>  	unsigned long __page_mapping;
>  
>  	union {
> +		pgoff_t pt_index;
>  		struct mm_struct *pt_mm;
>  		atomic_t pt_frag_refcount;
>  	};
> @@ -475,6 +477,7 @@ TABLE_MATCH(flags, __page_flags);
>  TABLE_MATCH(compound_head, pt_list);
>  TABLE_MATCH(compound_head, _pt_pad_1);
>  TABLE_MATCH(mapping, __page_mapping);
> +TABLE_MATCH(index, pt_index);
>  TABLE_MATCH(rcu_head, pt_rcu_head);
>  TABLE_MATCH(page_type, __page_type);
>  TABLE_MATCH(_refcount, __page_refcount);
> -- 
> 2.30.2
> 


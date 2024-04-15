Return-Path: <linux-kernel+bounces-145710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 883D18A59E7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B8601F2269C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E318286A;
	Mon, 15 Apr 2024 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmgyfuC1"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E1B74416
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713205688; cv=none; b=CAg2pY61PATPdRkyfOhYMvvmKSvs7q/4gV7fAlea/y5H2FQf0gfVRvozmBWdaf2eBJmRfLOv+/kE3mAWyfdUW4CosGpfLXom0SnqZJE3k+QzHyi+VCku4j8Q997T93olBKfiWD+WojruNUmjw2j2NxyVkbhUgHdRGKFOCbrThqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713205688; c=relaxed/simple;
	bh=yGckecM7nkvF3DdzkM8ETKHZuGBv7a5askO74zHWEvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sroWyGwaEExAb8SY0FtpBe7Zscl4yOnZVWhBGTu3oWlqKYibKXZTufT1iliPE9r1wj30/AIGkuB0ZzMVOw08KaetzliCQYkiYYnwyrWTm1YSvk5pUsoZoQHwF/+jOpTGqR+4RvAHcuiJ+7PujI4tUOIB3VGnuAlEPtJi7ldIqrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmgyfuC1; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-61ae4743d36so7091537b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 11:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713205686; x=1713810486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gzpn2mqeQXvBfqEE8KRrKxdSsji4vYUEQ7aPRX98tS0=;
        b=NmgyfuC10DljioU+wrJT+em9vn+PSk7VspOUKXRLURLBkV7kED4Zpzsbbpsl/8vXcS
         LtyS0X8kqt8emW68qYYL80CPa2CtSZIXDnOyH03JubWHU7bfpTq85cyU4wBuco2B6/JL
         iCTCORCEa0ckANXTDssPgpxaEDFjY75uPk7EYzaXr0cMaIxS6o/l7N77mw0pNuh6yoD9
         HzfjDeGMwLg04nvL/oCOmMTzr0wzg+r2nBqJvxLgV878JNavftDLQXdfEIgWZWLAtoak
         IwACpc3DgrdCFu1kHm68GCrPVGJE7aS4iVFehOf4jxYTLTYMuvaHOkZEcykkTzIt5dOW
         TxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713205686; x=1713810486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gzpn2mqeQXvBfqEE8KRrKxdSsji4vYUEQ7aPRX98tS0=;
        b=gnjUtjIo/enS7HmOZeJxjYlBkI98Ap8Pet2oxEsovRhnMRrRbPhdUPjE9WXqpYeS/A
         aJrGMvK4b6B5JoZMOtpxW4cTTMJ4fD689U92NVywGetrHRMKW7/r83S6gGoH3886zQ0g
         eI0ITXV8DGM3B1PLJX55LEXAKryIUMAI6Cfu5QqLv2D2cRsH76uBfrVf+VZ3una8+wFA
         uFb8NqKqr2B9yN2ESjvP+DxGJWANAE1dsk8JPxoLrBX5vHlJSs1cbv/wuYv2hesR/uTX
         NtnPJtHW6lBsYy07GQpresDSKl9dEyJWcUdmi4pT943ov6VG1RXk2KCflUpJ+6v3Ivk4
         Gn/w==
X-Gm-Message-State: AOJu0YyzDK6FajRPRlAbkpu5uzOsufIQTWA8IV7xQq+W3Vx8y70FVKeZ
	16TGOybZu124ArtuCUfgwyb93OWEvs1obfjG9D18X1UG3CSQSlxF
X-Google-Smtp-Source: AGHT+IHCFw2fCgotXxAD9pFn9CQpn+mNHke37zPPOoQGGqkFVjBFZeisk/EqoUiYbmPkNLuTriL6UA==
X-Received: by 2002:a0d:e6cd:0:b0:618:9470:bb2f with SMTP id p196-20020a0de6cd000000b006189470bb2fmr6114961ywe.30.1713205686294;
        Mon, 15 Apr 2024 11:28:06 -0700 (PDT)
Received: from fedora ([2600:1700:2f7d:1800::23])
        by smtp.gmail.com with ESMTPSA id y15-20020a81ca4f000000b0061ada21ac4dsm324395ywk.25.2024.04.15.11.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 11:28:05 -0700 (PDT)
Date: Mon, 15 Apr 2024 11:28:02 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, willy@infradead.org,
	linmiaohe@huawei.com, jane.chu@oracle.com, muchun.song@linux.dev,
	nao.horiguchi@gmail.com, osalvador@suse.de
Subject: Re: [PATCH v2 1/2] mm/hugetlb: convert dissolve_free_huge_pages() to
 folios
Message-ID: <Zh1xslaqduUr4MHF@fedora>
References: <20240412182139.120871-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412182139.120871-1-sidhartha.kumar@oracle.com>

On Fri, Apr 12, 2024 at 11:21:38AM -0700, Sidhartha Kumar wrote:
> Allows us to rename dissolve_free_huge_pages() to
> dissolve_free_hugetlb_folio(). Convert one caller to pass in a folio
> directly and use page_folio() to convert the caller in mm/memory-failure.
>
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> ---
> 
> v1 -> v2:
> 	- Change additional comments which reference hugepages to
> 	  hugetlb folios per Miaohe Lin. 
> 	- introduce patch 2
> 
>  include/linux/hugetlb.h |  4 ++--
>  mm/hugetlb.c            | 17 ++++++++---------
>  mm/memory-failure.c     |  8 ++++----
>  3 files changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 3f3e628802792..f4191b10345d6 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -861,7 +861,7 @@ static inline int hstate_index(struct hstate *h)
>  	return h - hstates;
>  }
>  
> -extern int dissolve_free_huge_page(struct page *page);
> +extern int dissolve_free_hugetlb_folio(struct folio *folio);

You could drop the extern here as we don't need it anymore. Aside from that
LGTM.

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>


Return-Path: <linux-kernel+bounces-119772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F337D88CCD6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDC5328C52
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DAA13CF80;
	Tue, 26 Mar 2024 19:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDJmojkZ"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01802481A3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480366; cv=none; b=R8+1wutDySnUg9fk0mzbjwtvW9pZOu7u9hQqrfJ8n0qsLtoGOWfSUqaeSHJC2ejQi3DyBkyHCe9g/+p/9YOd2H+8mqNxFj52QIrcqdXfj6FJ7+FRuYxt4Do0yL1l8a/vzB5FAF0IyxBaS1wnGT1pCa2mddqdV0ujuygKnoavURc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480366; c=relaxed/simple;
	bh=mBKTouHzDAjPzaOdaBR7pu1EJg6mN7Co3yaNZGIAC+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKTNNLnucG0gPT9Zkwtz7r/PUybHPYvHUS95/B8Kc5v+6oGB/Hvbh89RG49VaSBqHXyMQW1e/9o7QnXFYTztAqE70u0ujIWf7OlDwIxtcP8VsAroZM4Frd/g9c/pgVKO+PnY5dtMji4duNpkb+yPptp1Hs+fQYCfDf/KQsrw+sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDJmojkZ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e6a9fafacdso4537141b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711480364; x=1712085164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2mGGrWWfny8vxYTsDd25f9lyrs9ggkVdG3oXeLlTXYM=;
        b=SDJmojkZUXJv20wnA0RA5bNwYGvCFhcZmYCBbvSnEsBboG5jZxctm3SMRl/bchu0MF
         68zidrCG5YeBfQZcaOUJ9JKmed2/q7rQaaDocse6KPguomEHbUJ+0du6RIHB0zQodbTq
         TRPvQvQWpXPbx8fmQvTulZ+6hydbKQJM21oByWzdKqUrsCQRyHS1qat6S3Vdl0SaQDMX
         iep5fUXjPKI4eBtfx6EGyr6ST/Jgr6tSaRYNOLvTIoh4+9T977Tqtp70EhGDCKh4zYF0
         N9QqFO0B/zJd5znlnwgMMx2y+/lZN8y+4a+vNJ4dYKfoztpxgvD9GBcExsqp1lIsJsoZ
         99Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711480364; x=1712085164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mGGrWWfny8vxYTsDd25f9lyrs9ggkVdG3oXeLlTXYM=;
        b=TN72yJN94otoVOPEFEo9FVm64h7L7duS7YtnnpBqncRjdv8EPtSNh0l+nF8buXCRIa
         5hwUF3Y1obNUKIgBDIBMJ8AwUB92U4eEm4GFlJ7sTGnBc/7MlLzuKxZMhepU+z++h6ey
         Tn7H0PcPXzsVMHJA3N38PzAl/d6BJBo9R9Z07+C12N38lOHh27JqRPOcFwh+VMWXVuxY
         xxKfi5ex08ON+PddwindwuDKf9L4uGLIKCyFjeQHVQdKN4VI9o7ksbk3x3HrtIC376Tf
         pkq0nhDzVTi3B6/SjJzjCmihUmwRLTOa24MHQyrDSXP+e/N9dBl0zYMicg9xciM3VMdC
         Un6w==
X-Forwarded-Encrypted: i=1; AJvYcCXYl3XlOJDHEQGzdGNluWWoy408PwplIFUb/8aRlr3NDnocWRKMhgA3QVCSxL+Ki28335ZiLyBV0KoFtPF9kg7axC5ZUSTFUkq05aDk
X-Gm-Message-State: AOJu0YxA6tlnDiNhvbvV5bb25S53uxJ/gMNwF8fXdpPnbvR6OryfQjDr
	BqnpcbiaEQmqu/Bv29qxzqQYf3rpzdT1Fs8U0uwTsb9m8eiANcky
X-Google-Smtp-Source: AGHT+IFHfMiy74Z+cK5cBKPwRlRvYXQIhGOGa27FmCmkRGifSL+EkOPIKIVsrTTgU5r8UJwYJlp9Dg==
X-Received: by 2002:a05:6a21:3414:b0:1a3:6ee9:305 with SMTP id yn20-20020a056a21341400b001a36ee90305mr684773pzb.2.1711480364175;
        Tue, 26 Mar 2024 12:12:44 -0700 (PDT)
Received: from fedora (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.gmail.com with ESMTPSA id fa4-20020a056a002d0400b006e53cc789c3sm6336352pfb.107.2024.03.26.12.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 12:12:43 -0700 (PDT)
Date: Tue, 26 Mar 2024 12:12:41 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: akpm@linux-foundation.org, hughd@google.com, david@redhat.com,
	rppt@kernel.org, willy@infradead.org, muchun.song@linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: pgtable: correct the wrong comment about
 ptdesc->__page_flags
Message-ID: <ZgMeKa3ee7oHrkq5@fedora>
References: <cover.1709541697.git.zhengqi.arch@bytedance.com>
 <cc42d5915fd98fd802f920de243f535efcfe01db.1709541697.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc42d5915fd98fd802f920de243f535efcfe01db.1709541697.git.zhengqi.arch@bytedance.com>

On Mon, Mar 04, 2024 at 07:07:18PM +0800, Qi Zheng wrote:
> The commit 32cc0b7c9d50 ("powerpc: add pte_free_defer() for pgtables
> sharing page") introduced the use of PageActive flag to page table
> fragments tracking, so the ptdesc->__page_flags is not unused, so
> correct the wrong comment.

Thanks for catching this!

In regards to naming, we're trying to prefix unused variables with
__underscores so I'd prefer to see the __ eliminated from the
ptdesc->page_flags field here as well. This doesn't warrant a fix
as it is already in 6.9-rc1, but is something to keep in
mind for the future. Aside from that, LGTM.

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  include/linux/mm_types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index a7223ba3ea1e..5ea77969daae 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -419,7 +419,7 @@ FOLIO_MATCH(compound_head, _head_2a);
>  
>  /**
>   * struct ptdesc -    Memory descriptor for page tables.
> - * @__page_flags:     Same as page flags. Unused for page tables.
> + * @__page_flags:     Same as page flags. Powerpc only.
>   * @pt_rcu_head:      For freeing page table pages.
>   * @pt_list:          List of used page tables. Used for s390 and x86.
>   * @_pt_pad_1:        Padding that aliases with page's compound head.
> -- 
> 2.30.2
> 


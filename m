Return-Path: <linux-kernel+bounces-152685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E7F8AC2CB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 04:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C027728138A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 02:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612204C7D;
	Mon, 22 Apr 2024 02:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dapfjYMZ"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95F133EE
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 02:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713753903; cv=none; b=PpORESVUwcZBctWen9pwgz2IrevTjWfdstNAOeBKxqclffJq+ZIMH3kVUHqV+R3Xqe3YqotDY/zVUhuuejll3NFjhpFG6ZNqbmXMOIQoU8FBW8RR/K2HR4lMDpXKt5uyEGl1Clp+mjua3YXZc6IEOwOw/4jAVplQnJ7G7DdH6/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713753903; c=relaxed/simple;
	bh=cDw11cIBcxmL95D6Hy2+ZjVaz9KsSCqVuZf4OLrMgdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=een6xmxlGrZ6ZML/98qUBWiNXK3SkPaa9Ibs1HEecv82evmPF19BTGGR7E9iwgixUst4QQo6TmiZBHDlrXdz6cMkqkgSt8AznRGQgQPRtffuCphBMHpbShoxlw4NYzxp7PLQN+hQQXpmCtJRohQ/GnlQ9osYSd1MAeS4Tn24naA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dapfjYMZ; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-22ed075a629so1523815fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 19:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713753901; x=1714358701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XIK5vML3v/bdvHLH+Cj3KR7pbajmQ/BzdHOwU1URj74=;
        b=dapfjYMZZXg+86yPPniOh47hqtkMefB6W3TeBvsPNyzMQbszjOhL9Amy7MRQlMwyjE
         nP/KkhiS8wxbytH3TFtdn4CQ2ZixZRhfuGReerkW4hAG1kFWIHKiccr78zsXX52i9Z9R
         IKOAymbCnBKgCZcz+/YnJKzSfjX+dQbejOBYYPs/lTjnrF4nMThbnTbawRPhaL3Xs+X0
         vQntFSuOKkK3e+QbjFuU9cun/PH/pRLXCSKq4XnPjW8sxH0PtcCheoxIrcdSLKZOG/z8
         H2HBxn93nc8lw2APSHD7W6DnmdhW2Oj27BJehY05bal37zy1mpi27vk+xzZ8HJqXPWuR
         uLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713753901; x=1714358701;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XIK5vML3v/bdvHLH+Cj3KR7pbajmQ/BzdHOwU1URj74=;
        b=UlbMXNfwf7XMElMFTiIKtlQUTPvp0YFvLPaBZNauDnqbEAV1CrNgm2P9igvUbckzSA
         NeeVH6ZQMqm/zunW3Xeb2mvqzUohdmrNUkXVWcqoQ6xqRsOLIQEOpFTVc5l4zZBklC94
         c9rEM4gZt0BDtGZI9VEt0KsxjWbzf15sDvF9svESiziMLldGYOcEjPpVgqS5qs3XIoUt
         5xnseJ/6r74qAZtSIankzRvvnj70ImO1LzoOqT92d0pQRX2CnFYKVWjDdHvj82E2Gjid
         oC6H5eIpMFoAc8vFm8ClA+Xy7GJGTs7iusqGYMKeAt8BhPOJgBbhLFruy4xlqAYYr9Iq
         rSXA==
X-Forwarded-Encrypted: i=1; AJvYcCURG7DlZ9FNa/7QSBl7JGlm4+FQOKuk0LKEBJdmXiYgUvjpOujQSd59pNjfS3LpRcZYqjuKsnwRtaz6dZI2iwTv3gvcxh8B3j/0QiYe
X-Gm-Message-State: AOJu0YxKmuRYO9/TSokxA4MIoFxm0mzj+4xbjYlojuRVIcuX6mv4DCTC
	CwYyH0EYkx0oOfffruYYqqEdhd843966W1ifxyvMqyAU3Kh+DA0xuacaHQ==
X-Google-Smtp-Source: AGHT+IGkBmtuPIUiHaIrw/eJvrHXlIVu/NGRlJVQlLQ4F/CkBYTO08Qe20JzQAxnHpRo0GgDZuk+Kw==
X-Received: by 2002:a05:6870:ed98:b0:239:88f4:45d4 with SMTP id fz24-20020a056870ed9800b0023988f445d4mr9166514oab.2.1713753900725;
        Sun, 21 Apr 2024 19:45:00 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id fq9-20020a056a0060c900b006e6b3c4e70bsm7026267pfb.171.2024.04.21.19.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 19:45:00 -0700 (PDT)
Message-ID: <1dd938aa-3066-4e3d-a7eb-e1dd83ebbf25@gmail.com>
Date: Mon, 22 Apr 2024 10:44:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/ksm: remove page_mapcount() usage in
 stable_tree_search()
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Alex Shi <alexs@kernel.org>
References: <20240416172533.663418-1-david@redhat.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240416172533.663418-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/17/24 1:25 AM, David Hildenbrand wrote:
> We want to limit the use of page_mapcount() to the places where it is
> absolutely necessary.
> 
> If our folio has a stable node, it is a (small) KSM folio -- see
> folio_stable_node(). Let's use folio_mapcount() in stable_tree_search()
> instead, which results in no functional change.
> 
> The mapcount > 1 check is a bit confusing, because that's usually a check
> for page sharing. Looks like the reason is that we are guaranteed to not
> exceed ksm_max_page_sharing for the tree KSM folio when merging with
> that. Let's update the documentation to make that clearer.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alex Shi (tencent) <alexs@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/ksm.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 486c9974f8e20..159604ad47799 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -1909,12 +1909,15 @@ static struct page *stable_tree_search(struct page *page)
>  			if (page_node) {
>  				VM_BUG_ON(page_node->head != &migrate_nodes);
>  				/*
> -				 * Test if the migrated page should be merged
> -				 * into a stable node dup. If the mapcount is
> -				 * 1 we can migrate it with another KSM page
> -				 * without adding it to the chain.
> +				 * If the mapcount of our migrated KSM folio is
> +				 * at most 1, we can merge it with another
> +				 * KSM folio where we know that we have space
> +				 * for one more mapping without exceeding the
> +				 * ksm_max_page_sharing limit: see
> +				 * chain_prune(). This way, we can avoid adding
> +				 * this stable node to the chain.
>  				 */
> -				if (page_mapcount(page) > 1)
> +				if (folio_mapcount(folio) > 1)
>  					goto chain_append;
>  			}
>  

LGTM

Reviewed-by: Alex Shi <alexs@kernel.org>


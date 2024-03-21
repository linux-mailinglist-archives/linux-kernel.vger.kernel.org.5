Return-Path: <linux-kernel+bounces-109543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1EA881AB4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7D61282FC3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AF71C2E;
	Thu, 21 Mar 2024 01:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iY6ebiun"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6053E370
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 01:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710985652; cv=none; b=YIJ1dY9Ba6wkKYtW4OWlpHAaTSgKp6f56RnWO/bn3Eg8uT3C9SRbARj11WOhOahVMU8KKibYGEUENL9yov+aeY4sagadk5T5KDo588hkx7q1M3tXLnk9hMG4dAJDRpescEjipa5w5D6c2wQHj+9a51q4CQY2qrZuzKL67Y3igqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710985652; c=relaxed/simple;
	bh=3yffF7vBmofXAlEr63Jn2oR9H4cVLjxiNPDdSR/FG4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TuJqz9SmaxUEYF44juqWRhXdmyU4jliUloSVjGdrLGP9gPVT7be+GA8sKxdHiFHNTQxRLFrP8P5P/07KUXn3lmEiejpewyryPdw+R0jSdIybfZRDSa6i+2h2gjsMWwokrm11gpeEXiA05IAkCFwd7NdYAWr8yNI4qqh7vB785LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iY6ebiun; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1de0f92e649so3111765ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710985651; x=1711590451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uwwXtXCvbSQVnkT5BGfOsi+2LxDqXEltVUJKwHfmTtQ=;
        b=iY6ebiunOd7PmvEk2cwUTHPsenmdCj9iCPmJDpK+78+qwK3L/fp5JnAHCZ9jZ1xW25
         2/enZYNPcWiOpE6LlC2C21nIaN9UKgbsQvPvIohybWIdM9Q5aeo4MZsnhHGpG/ZmwZQS
         eQHQEzFSE4tiQ5RrQGJ2K4dRhqCK/D/wIdZQ7aKMkqtvLv8BhAx0RmCFVAIllzIiiLEg
         w4x+ImDAicreJ6aL+159fuZrxaLzvS3fKivZOc0ldYimCjxaYsoI3Girag0kgQz0PrtR
         X3SlrfeXNgRsepTYSl/0AHZhjCro4hxcQMKMmXUcDas4DeQwMcLjfPddc4J2EX/48DfV
         yG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710985651; x=1711590451;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uwwXtXCvbSQVnkT5BGfOsi+2LxDqXEltVUJKwHfmTtQ=;
        b=gpxx4CyZjnnyi7xcm9odrZPlje+AINSb5CnjBZrkiuNyen4EWRv7fxWmlSC/2menP1
         O9CtFjpvI2ctVHhbNbapz0V3DoDyK7x/ndKhhXDUC3sZiPevJlLb92NbajEWd7GGTjIA
         ayvctjHih1tae85NxFkX2CqRH1QlizIgxpCykoxnWbVs235GPGxPRtHgZzQujBsPZ1b5
         3IM7ZnujtaW2iwneQcfo3KIjVqcjQ5skwm1OkIQsS+VOlkXp6m4KQqMjkh+HzFf0TuYG
         JhEMH8Rx9PxbWVZ+ngO1CGqi3i9N3z+LlqluRFhyxG84lyu3FGb4Q07CRtDl5Crmf2xV
         InKw==
X-Forwarded-Encrypted: i=1; AJvYcCWnwkBxFUUkFCC0mdlewCA4YyaYSp0Qv56oNYXk6LrNFNPA9iKtfc6uNf9eFgXyez7mvADxo+h4r5gvx7uySlezab34tNLUPMa9ZTDP
X-Gm-Message-State: AOJu0Yy0HYMPtCJ8zi5D2HelfaR4OTjSPV7+EO63AmpTJ+fxvfc1QUJM
	FB0J5i1YDJRWEoC68BtZHcZbBVViumLYRNYC7o2j93jhl1oloKAs
X-Google-Smtp-Source: AGHT+IETbDCXSfnyDw4E7ZxgsR0AeuF9hqGIzboQZu3z4KQzKauZvY+l6Tsh2CopSifk1TuSpOFVUA==
X-Received: by 2002:a17:903:1cc:b0:1de:f569:cf41 with SMTP id e12-20020a17090301cc00b001def569cf41mr21259195plh.26.1710985650634;
        Wed, 20 Mar 2024 18:47:30 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id z5-20020a170903018500b001ddc83fda95sm6121927plg.186.2024.03.20.18.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 18:47:30 -0700 (PDT)
Message-ID: <1c8e6fbc-ef1b-49fb-9d3e-b163a58cee10@gmail.com>
Date: Thu, 21 Mar 2024 09:47:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] mm/ksm: Convert stable_tree_search to use folio
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, alexs@kernel.org
Cc: Izik Eidus <izik.eidus@ravellosystems.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Hugh Dickins <hughd@google.com>,
 Chris Wright <chrisw@sous-sol.org>, kasong@tencent.com,
 Andrew Morton <akpm@linux-foundation.org>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240320074049.4130552-1-alexs@kernel.org>
 <20240320074049.4130552-10-alexs@kernel.org>
 <ZfsAEl5nipppfeLx@casper.infradead.org>
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <ZfsAEl5nipppfeLx@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/20/24 11:26 PM, Matthew Wilcox wrote:
> On Wed, Mar 20, 2024 at 03:40:45PM +0800, alexs@kernel.org wrote:
>> @@ -1820,28 +1820,30 @@ static struct page *stable_tree_search(struct page *page)
>>  	struct rb_node *parent;
>>  	struct ksm_stable_node *stable_node, *stable_node_dup, *stable_node_any;
>>  	struct ksm_stable_node *page_node;
>> +	struct folio *folio;
>>  
>> -	page_node = page_stable_node(page);
>> +	folio = (struct folio *)page;
> 
> These casts make me nervous.  Remember that we're heading towards a
> future where struct page and struct folio don't point to the same
> memory, and part of that will be finding all these casts and removing
> them.  Please, unless there's a good reason, just use page_folio().
> 

Hi willy,

Thanks a lot for all comments. Yes，all of them are very right. I will rewrite and send the patchset.

Best Regards!
Alex


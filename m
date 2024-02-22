Return-Path: <linux-kernel+bounces-76135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0436D85F357
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE725284567
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDD5376E6;
	Thu, 22 Feb 2024 08:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MR09gmqc"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BB0364B6
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708591445; cv=none; b=HdKMv0aXmH/tWxN6/LgPdh6X+YrwzknXyQzW6F1JCGvcPeb58sIrev+49mVlohCqB89h4UqyyJEpyq87VPAuJLC0Yj/rxG4/hveDqQHaSXlu7ag7txIEtUiEK0ZMeIPm4XmmEJi4yfmBY48zPffHIAsVgwz8Aujf/ywzjoUrVtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708591445; c=relaxed/simple;
	bh=ExkF3M7o16fq3CekFhwboy4rKgcKrVkSVcelu60MJTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ykk3wDBZndG5IOf7qXSuk9HM0np1h5aw0kPzO2434jCSKtddn7EZ47e9VY3Y+QTBqts/yX40qXWS5AqRXtrA6AnX/5cfalG9gPN1EIVMuVZbrQWhGEih6IjJalzKuM5+W/ZkozaPEIA2ejML7hDUoBmHts1jpxJRKzH2MeiOZ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MR09gmqc; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4128d15ae56so455205e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708591442; x=1709196242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ExkF3M7o16fq3CekFhwboy4rKgcKrVkSVcelu60MJTE=;
        b=MR09gmqcnLMUJ/pTYEk9Uh0UDKpMcvc0FraWBQisxLTxt2GKeUedQyrAp6lwqp76fj
         6PhZokPTrDGdb4tKnEAJTzQCHr2eneQchIoVfcvx971hiE7NxZDQCNLYjarFvgoV1Lv8
         vluhytyKtaWkcoY5x87ichUVhNMTLjrZNX+gN8tABoGRB93w2YMDFJfpBt2poGLtPIV6
         6iUgZt538vKoio2O35nK43Pr7gCuRs35Ljf3rNGjpR1GYkowV6mPreG4Iz3zs9qbuTP2
         5Vq9UVo+1TjHOk9+aTmCaScMdLQBOidL4AV6S/eBgI5fxBXoQbKVh0ywCfhBpGBPTvFY
         Xk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708591442; x=1709196242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExkF3M7o16fq3CekFhwboy4rKgcKrVkSVcelu60MJTE=;
        b=GQae5RkakWRAGxnz3Xm2zLGcZwR/zgDdJU5NoFFqNf3zMwbDKBFz3HRnWGgebfsGwj
         w8jTAEIxi6JtxA9Pi5tGICSrdnwqKs2aBUyJmQV1HpdlPf+EfLPv7BDGwPBJubU9LzR2
         M4kL+cFK7CV5NZxSq28341h6DAluMnzesEvhY5JYr9ob8SGwGNItQcRuPG0uyubBDsXj
         USzX2m4RvkTJA9tcZ6VTDIKN/nc6Pa5vzezYV2jEmzqr9kzcwMK2R2wTXgDBFrS9t2DU
         7E3b14NUSpVlbjxgL3uh4Wsl/wH9Q8EGsgrEBBsGwkiYTp9Ohf3OCyzOk2RGHm5JzSzA
         /z/w==
X-Forwarded-Encrypted: i=1; AJvYcCXEsd4rM85sByAQ5wJ3PFhggS3ZmIuhQk34rofwUdliWv2L/pjQaI7ILiD1ZvKB2j2TCKyXXinDhBwIR5mAV68OpKa5yhej2hP2HTSm
X-Gm-Message-State: AOJu0Ywoq7RIiesc/KM0m41E2WgVE1g4dm7j1polMLcWKFPduUToJ1zf
	9sgOHWyB8BWHgPOaavQTnqJUFPPePpS0t/RADLp3x11ZOU4UoAbO
X-Google-Smtp-Source: AGHT+IEGgTpaQ64LlhF6lAFNfAR5MqM1C2w4n13QdaKBvSX4+8OUUrWeXYTfXEa7hOIXU76H+3xVlw==
X-Received: by 2002:a5d:4742:0:b0:33d:6c37:3aa7 with SMTP id o2-20020a5d4742000000b0033d6c373aa7mr5154156wrs.18.1708591442130;
        Thu, 22 Feb 2024 00:44:02 -0800 (PST)
Received: from localhost (host86-164-109-77.range86-164.btcentralplus.com. [86.164.109.77])
        by smtp.gmail.com with ESMTPSA id bn7-20020a056000060700b0033d3ff1cb67sm14380608wrb.66.2024.02.22.00.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 00:44:01 -0800 (PST)
Date: Thu, 22 Feb 2024 08:41:47 +0000
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org,
	vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/mmap: return early if it can't merge in vma_merge()
Message-ID: <fe790bd0-dcc9-48f2-ae66-7ebd74dcd3a4@lucifer.local>
References: <20240221091453.1785076-1-yajun.deng@linux.dev>
 <20240221153827.wkmjnnwsf6lyxatc@revolver>
 <f3847dd7-5564-4d7e-951e-1a9d8f55fb78@lucifer.local>
 <082fed0a-8489-37d1-f990-067976260659@linux.dev>
 <b4232b44-083a-42d4-a245-7eb4382f7329@lucifer.local>
 <d3be7a90-b186-a8fb-678c-f06ef950d942@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3be7a90-b186-a8fb-678c-f06ef950d942@linux.dev>

On Thu, Feb 22, 2024 at 04:37:44PM +0800, Yajun Deng wrote:
>
[snip]>
>
> Okay, I got it. Thank you!
>

Please do keep contributing though, you have really raised something
interesting here and I know you have a maple tree patch going also, it's
all very much appreciated :)

Thanks, Lorenzo


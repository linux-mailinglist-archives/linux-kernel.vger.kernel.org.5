Return-Path: <linux-kernel+bounces-94475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7577874059
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A612823C7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FD013F00F;
	Wed,  6 Mar 2024 19:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sh8ou+MO"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B86692E6
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 19:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709753090; cv=none; b=Ql+Zra/RRjOFZckYUljZXLUMxlL/5LtnR1Z7EWqO3HTHMBRN2pK8j5hlq85PR29qmDgTLa8pH6pZ9iT6vRqLRAP9uk3is5MutffKGjrDOr24Q8n/hLoSXAJ6cp/VrUKnCTz3Hs/k3ZTzIFsW1vVBgkfaXXBFZY/cj7hcrI00fpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709753090; c=relaxed/simple;
	bh=6d8vcqw9Ex8kUiGeGC/RqDz3r89GsW3GSQfUp45rYYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqiEvDQwhx0VADyEXttG71yzKxBXTqLWNA5gQ7GDpbFDGoqV49Am8fWB0ROJlqH5lK3/XmbFITQK1PZWIBt3SGyvzOOUeQG89OirC1P2lG+s7lTF/3+kRtdQugTg9iQ/zf333VYv4eWN4ojY+6klsO7bPFZEOaRbhRO8MvC7gU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sh8ou+MO; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3122b70439so15935766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 11:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709753087; x=1710357887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N65jgDu3ti3gtYqmJ12S4T+NovAzqaL/FHird0FuvNM=;
        b=Sh8ou+MOdSDv8qe2Irmf2bCKYzAfjn6ofqurMDhRIk9s5RDk30ENBx9n2qaB3jIjDq
         /gHwr2sgPEFU/UjJ38vcXPWmgzWzVBTl54z/t7feckHedKKfa6QxjRkSCHqkFYB5X0Zt
         8yNIt6YUOfydh7jBI2DSXw0QRfqPj19fo9buPfsq/LCP0W/A/HoeWQOkWqqnq8XFNYaS
         Iwhe7K1KPAhpMGlfpI+MCMmJ3SRkgjC6S6CJwF1JyrmE3GTO5X4SHK17B5xgjn7DyjDj
         CNNlDNv0VijuP8tP4hmnN1l564VKYBCVyiHJy0DwNy5i8qj4ZcydiHD9kngXJ93zlR49
         IEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709753087; x=1710357887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N65jgDu3ti3gtYqmJ12S4T+NovAzqaL/FHird0FuvNM=;
        b=m964BUiRgyVvulKmvjgRh29ToksbALmTq+5GjH5tpIQsrt0C/4NRie+T8afQWMcZTy
         R243hTQrzGDABgyhXoAhDtMsTfN2CbqDnhviDJpsmY5XZyMZ0uxQNIfgfPvgocIV03dS
         rF7PQzXh0PMFn5G9ffaRY0VHvU8U7UNfO8rzhPRv9Fd7CVzZNWCJSPpQoz7fiNFlRGJk
         2LtDVAg0iT/THnO+Y/gQYJ4SAEDOkNgdt8RlhEWr02j83OT/rr3rtP+y3+uKAKaxMYVZ
         vcri7LGZHxbv1aZVU6hbupT4CwCplJ5RbGCVX/8eHIBJBEcw6gsGZvQB7CrVp4Dcbcu9
         MMvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS4viuH9SeAlWEVy6ShOC4v7ZqI3ZEfmXKNQIZ9XkTBkaC5BOu5raOhKqSLZv28PAnFlMNrCCDXY0akfzMi+A8HjgjMp1lPsg6rpEB
X-Gm-Message-State: AOJu0YzokTgTWwkS6fAuek2tnlIQ+XfsUfaB4NZF/NgdCWvV03MR/9tU
	q+3yXEBpsxeMP19bjZsKt2jFq9h9QdqC46fnAopxW6GYO4lDrya2
X-Google-Smtp-Source: AGHT+IEhVIGDd06hPVlwxMS5IA03jXUpAheIpZY+6kaI3kOpFZe8c1Zq6BlIhLbwOhwUtVzJW9f5Ug==
X-Received: by 2002:a17:906:3c4f:b0:a44:a5a:30be with SMTP id i15-20020a1709063c4f00b00a440a5a30bemr10252850ejg.2.1709753086635;
        Wed, 06 Mar 2024 11:24:46 -0800 (PST)
Received: from andrea ([31.189.122.3])
        by smtp.gmail.com with ESMTPSA id s23-20020a1709062ed700b00a450c790080sm4547711eji.156.2024.03.06.11.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 11:24:46 -0800 (PST)
Date: Wed, 6 Mar 2024 20:24:42 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kenneth-Lee-2012@foxmail.com, linux-kernel@vger.kernel.org,
	paulmck@kernel.org
Subject: Re: Question about PB rule of LKMM
Message-ID: <ZejC+lutRuwXQrMz@andrea>
References: <tencent_C5266B7D6F024A916BCA7833FDEA94A74309@qq.com>
 <Zedd18wiAkK68Lzr@andrea>
 <tencent_744E0AF832049C200F96FD6582D5114D7F0A@qq.com>
 <ZeipiSVLR01jmM6b@andrea>
 <e05fa6a9-c810-46cb-b033-b91ae7a5c382@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e05fa6a9-c810-46cb-b033-b91ae7a5c382@rowland.harvard.edu>

> Later on, the file includes this paragraph, which answers the question 
> you were asking:
> 
> ---------------------------------------------------------------------
> The existence of a pb link from E to F implies that E must execute
> before F.  To see why, suppose that F executed first.  Then W would
> have propagated to E's CPU before E executed.  If E was a store, the
> memory subsystem would then be forced to make E come after W in the
> coherence order, contradicting the fact that E ->coe W.  If E was a
> load, the memory subsystem would then be forced to satisfy E's read
> request with the value stored by W or an even later store,
> contradicting the fact that E ->fre W.
> ---------------------------------------------------------------------

TBF, that just explains (not F ->xb E), or I guess that was the origin
of the question.

  Andrea


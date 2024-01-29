Return-Path: <linux-kernel+bounces-43488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0128414AB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA14D1F249AF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A196A7605F;
	Mon, 29 Jan 2024 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgVQu1gf"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAE97605A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706561473; cv=none; b=AB9QdHXKJpaDC5RJdcbj7fnFnC5pgkQM67+FxREt+RcogO9xauiU450SfFETG2KKl/FzThE5mGK7H6fe12vXgpnxThAE/kwOUqxwjAUdquLOmR9nPEt5Su2bxV8LISpuKhAUc8k19RdWnIWkmBTfzEDGefvcpthNVPWD7M7qe3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706561473; c=relaxed/simple;
	bh=XHFFOcVsvei7OHlbR7aOEcvc1LdOaBxMV4TRXupNclg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvJ01Wsfzywoq4ICksMvqbIqDD9S+XBaKWgqs0qY7ESvOhwjIzw9qZaCJmTlsBskxZV8/7jnmTtifdJ7YPVPaFIRC8zTqJCiHMAY96EHmLImlgFcmMwk9QbY5juCor1ImavFcYzznFowb/M0I+z88ijts/v6kg9PSrNpxWpF+fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgVQu1gf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d748d43186so15830405ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706561471; x=1707166271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p86Sj1okiYD5BpE8rfcnwW8PaHwkNg+ue5x/UV7Kk1s=;
        b=YgVQu1gfYm1IwdKOXU1yYdN13veDqtlm6AutpG5k5SpGvyqrQ1yfUcmmYHz2ZerHfa
         BtToSmQ28sBfB0rIdy4S2AiSjq+cEsYMthTgLUjdiv7pRhfLufoTEYgrZoBUOiV3iMO2
         4NQZfSuYSNbNUBk6SXo/Q2gaTcaI0Y/UwkctRMzsBrrnSyOahHzoMV03mpcTI3Ky2zrU
         yyksmuwAl+Pn0RsBNxa2xVCgl6DcCBRL4iR/EovChGlhUGmquVovvSIXeKVC1fv9vPYF
         yHFTZzpEsSW1psn5UqCVwNTADoGU41ApxqRVqXMJPC9FivXJhY7hS7WlJ+kohYl62H8c
         PQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706561471; x=1707166271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p86Sj1okiYD5BpE8rfcnwW8PaHwkNg+ue5x/UV7Kk1s=;
        b=bqoVrQao2h/QrbEADyrAfyasbRw+rWepNfPImOvTZQDSh2MnYpNOZyHb87JUzk1zbG
         kXtogOgRRU6aVqBM2rR+Klqp7bWGayGTbJTgWDj49ZyAd0dEuopPUH9WBnV7azis79J+
         U6mCOD2QIyj2YvEWt2n6mF8+isi9+9vqmo9Ox1zVI9LrUGrQdwFIbBXCXSDGB+0daPeH
         LsVIkgEEumiKJ05MnkoauRoDWLZpa2O9tLtkHMTNyf2U8caqYdgDB2knd8xNjuM39rvk
         /lMPuAUirj2lf3OUVesBmFPSfT/zahQPeBzn9KYm4Mem6lnUUOS6Uu43XwdqgBpylwPP
         bZwA==
X-Gm-Message-State: AOJu0YyihGTh5qzbqonZrHsZB3uG44aPQsVRR98a0gK7sHeJjVcKyd2m
	dhfeivJsZ0VwXfYdxLmdvINx8X4UBmfglNVK+9XWCxbupGt+7BdrQW5BsBy0
X-Google-Smtp-Source: AGHT+IEUqYrz37SaFuhzLaPJMefkNoNYYVxOR8001MXFIvRA4lFYP+6sKGf7lsS18WL4/gtA3kM4Cw==
X-Received: by 2002:a17:90a:ac0e:b0:293:e9b2:3d52 with SMTP id o14-20020a17090aac0e00b00293e9b23d52mr2718956pjq.40.1706561470656;
        Mon, 29 Jan 2024 12:51:10 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id p1-20020a17090ac00100b0029065f70565sm8838882pjt.41.2024.01.29.12.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 12:51:10 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 29 Jan 2024 10:51:09 -1000
From: Tejun Heo <tj@kernel.org>
To: Leonardo Bras <leobras@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] wq: Avoid using isolated cpus' timers on
 unbounded queue_delayed_work
Message-ID: <ZbgPveDBk8ysmF8a@slm.duckdns.org>
References: <20240126010321.2550286-1-leobras@redhat.com>
 <ZbQozqY9qOa4Q8KR@slm.duckdns.org>
 <ZbQsr1pNSoiMbDrO@LeoBras>
 <Zbfr52x97-tLP66t@slm.duckdns.org>
 <Zbf8AVZaXwmExroX@LeoBras>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbf8AVZaXwmExroX@LeoBras>

On Mon, Jan 29, 2024 at 04:26:57PM -0300, Leonardo Bras wrote:
> > Isn't that still the same number of add_timer[_on]() calls?
> 
> Yeah, sorry about this, what I meant was: If we are ok on calling 
> add_timer_on() multiple times, I would rather go with the above version, as 
> I think it's better for readability.

I don't know. It looks more verbose and less clear to me in that it isn't
immediately clear that every branch ends with timer being added. But this is
really minor, so unless you have a really strong opinion against the
suggested structured, can we just do that?

Thanks.

-- 
tejun


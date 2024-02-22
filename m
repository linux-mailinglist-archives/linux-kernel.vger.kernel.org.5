Return-Path: <linux-kernel+bounces-76094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0366585F2D9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B285128298B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC5637167;
	Thu, 22 Feb 2024 08:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WelMir/z"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458FA37166
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708590182; cv=none; b=ekzPZo0c3CEW+gerrBfGRd+mPSzNJoeFQsokjfKXVZg514zHNiPG7ZqOdYT9L8FOkeOHfaD6LGAA3SYPqz/bsjxTSGsnCgsEgMSrgdBbny2ipqSEXLDwE5Xy47g96eOPYu7t3JQ3VFb1a8hYLnNMkST8hS4HP/qNT7Z9ouskXpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708590182; c=relaxed/simple;
	bh=mvW/5WaZevGnkx+70YSEavfaTGqjxsH0H00Hq3TASoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZV+aBJ+F2oqoTPo/squZy1cUyditl9uaTGzvkOcVsKeVCSS2CQ6Weol/9qfqOjLMRbRcqzoW/CpQOEqSxG9Hp6+YAP3GSpeg3KDzq6wLGNSnpfbz0pfXeRrPkNL7Dp1yYj0RhQQd5KNKLKd3lkCtkMinL+JcAHtYNoyb59WjdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WelMir/z; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d71cb97937so75437745ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708590180; x=1709194980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dT241s+zCFwt2AS+5CN5DGq/aZ9jQSU4A5XFnpNe8YQ=;
        b=WelMir/z0S5r8YNmAwv/Glh1Y2T9+BN7kF1GueGD03BWq7AD88+QtG5sinC1LVxVQk
         ksF4jmNjZfqbdBI8ZPiP6hP+qnaLwamku7y/8h5WqtvLlis0EnXJoQT/ctErBdGsDWl/
         oGNYZb2jTFs5CuDuzYYU1LZQFvXax57gHREk0djEFgYre+YZaALrpfQl9mRO6X+GvIIt
         OBulkwKzq9ollIHyJwpdOw6rCLwVUufMQUYkp/d7aRvu66wZJknuQa5+OapVimsN38+E
         AwbXcgZIG0zpuarQieIKdmpIJlYTeyk7dwnCRD0qywna0cRG18d/DaOQlRhasNOsxZ58
         ZDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708590180; x=1709194980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dT241s+zCFwt2AS+5CN5DGq/aZ9jQSU4A5XFnpNe8YQ=;
        b=dvPj1jtdjsXFNiIGNaxItQvDBm/Hsn0AzgMEewNkR4qH/ONMnkCPMsVte0SyKztjNF
         7x0pzu6nbrZe+UXj2NwWgkG+2hGAzZMMz+EZZEXfcy92weKNvVXk/UHbm1uCFDzPK1WR
         +ptRvqoZOzhbf0VtkcWUB2/nFNW9ct1s1uuzqEZfE6lVEPgZhcqTrLVZRZxjEUFKRctB
         2X7s0O3Mx1SjkYbUMT4y6XH0LhU0DQnyBd0uBCEBXGzf/8srIH9to+oYyOAXCTQS363Y
         VviHXbeadvMcOFNO1J+hPbw++eLXOGtWql7DZv1EYdTXvlBFCgr62l8H50EqYJsjOTG5
         NjHg==
X-Forwarded-Encrypted: i=1; AJvYcCXf/rPMgWwr43tmY+QAuddDWVEKQl3t6mPr/y2+EzninOuJchQRaVPTZiDinFNMMsZUoC1KL1aPHiCqRErirEd2JO0y2RarzxhxwZrJ
X-Gm-Message-State: AOJu0Yx72OwvP1pUgoWTeSJwbmx9B/SUKvZePmgZjxRdk2yLJQcsNQzU
	u7KZo/n4lef69D9HU/dW0SB9151OmH65NvTXfj7oKOEtwJVubELh
X-Google-Smtp-Source: AGHT+IEt3dd/ehlHtMnQqgCLwSJrDxN6w98wNRn2gb+Zxf3v3QfRyauwhkq+CQhLGtfEHcACtIlCkQ==
X-Received: by 2002:a17:903:22cb:b0:1db:bfea:3657 with SMTP id y11-20020a17090322cb00b001dbbfea3657mr15494077plg.22.1708590180297;
        Thu, 22 Feb 2024 00:23:00 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090276c600b001da1ecb05f9sm9323449plt.240.2024.02.22.00.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 00:22:59 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 21 Feb 2024 22:22:58 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH 2/7] workqueue: Implement disable/enable for (delayed)
 work items
Message-ID: <ZdcEYtr4I6HADjm9@slm.duckdns.org>
References: <20240221174333.700197-1-tj@kernel.org>
 <20240221174333.700197-3-tj@kernel.org>
 <CAJhGHyDJAUt8hSJNf91vosOK5TMRykudUZdiKvYYaU3co3T=6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyDJAUt8hSJNf91vosOK5TMRykudUZdiKvYYaU3co3T=6w@mail.gmail.com>

On Thu, Feb 22, 2024 at 12:34:52PM +0800, Lai Jiangshan wrote:
> It can use local_irq_restore() directly or the next patch needs to be fixed.
> 
> The next patch making enable_work() able to be called in any context
> forgets to change local_irq_enable() to local_irq_restore().

Ah, right, thanks. This should have been irq_restore.

-- 
tejun


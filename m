Return-Path: <linux-kernel+bounces-57065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1204B84D39A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A634DB26E54
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3472127B65;
	Wed,  7 Feb 2024 21:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFWhAlhu"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BEA127B53
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 21:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340708; cv=none; b=sBVPWFeA8nLlhmMGxCGL+WqLpmKUut0tAMGfyo4PR5k747urNErfeLRDjRdh1aj/53Gd/wT+8O6B6znFK+aHvRMfpesJYmYcVtEaRmv5u3hUTNsm84QxzwhIQUb5+WM93td+DTAjW43lIXV1seftoPYPiOlxviV0W/NEYyBMCeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340708; c=relaxed/simple;
	bh=v/tbiEhd6d3woV++MGfM78ZSiQjrvJ4846+q02eizRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rK8EPPUv6PsQULwAcCK6DNI+KK3vmlkxRJXDLpGoot6iSl3beMcr7fvj9Q8opN+Rt7aDV4Wzr2Z0kT0tjq6JHyV5ylJ9k7BNWXSBT+XJ+U2JpgLpvxnxL8u68nSXFzIQUmeA0ZRJx0ZcNOY6yw28z3WN4svG+/V/M+WJMq2MRxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFWhAlhu; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d8b519e438so941526a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 13:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707340706; x=1707945506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wuIewXo8+/aFBIfZWseX/3b/AEq5E4umujJ5IeKyNY=;
        b=YFWhAlhuCKU5jhDXA1H31M9zwTi1awKIb7fgcSKiSnONFnSiR1Y+UpBnxmWr5AyJ8S
         9dRk/UPUeIwFKJCEU25xCQW88/xdQzOO+VJgD59vhjbBezHWBwblJaifZ2PwbErxlux/
         I3rVepX46XVIwvuIqAx0EJoLdeLWaoWlN/xLWuI+D3AGu1QqE8cFLLYw5u6yF6MppGUb
         Eq0Sq/PuhBm6XgfouG1m9cM+0FEJvv1LDjI3KgLcwxvAgjVHfxcNuGuoJDDjcLoTzVQ9
         oo2uByVLry/GW136GDZKHJebeTh64ITIbLq6fO7PR5W3QpitZfRFNrVK/RJAtwYdz/6n
         hz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707340706; x=1707945506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wuIewXo8+/aFBIfZWseX/3b/AEq5E4umujJ5IeKyNY=;
        b=LbwSg3QBlZ/wAaQbOcA8pn5Ebo0dnSXSwJQCXTYOLqEPkyXW21pigWp27/rCbjg3/d
         Wkd9A0fbKiFFHedWYLRbG+1dHCdbvi1OLbM+a8C5o2yyeDlUogRqn9oKnsnPLivVcsox
         od6JsWPAmwNAp8/FJQ1OwhnOG+srjXC7rmKIDYcaDqdm5j6FSwjo0zxiGRWqIG2m4R2v
         6m3qLP7uv26P4xEl2I57vRg2/FEmQIGdIL5M2a7CzNAex68TjErUHSbnFHi9E6KmQfzQ
         VS8NjqWqdk5R9sYLvDr5wiyJ8wGX3iiM98CqtcxE6el81D9Z3WU6ATe/VQT20+P6E7Sc
         xF3g==
X-Gm-Message-State: AOJu0YxwIr+HhsbCJnEgmftcmdMJMRkqLVzm6D5TxuuZNcldh1jX+c2/
	/hjmcNDnOhmTTbyyVluOJGjfME/mTiVmcFgyjFDcQrBY+ApKIXVMUie7q0QJuTM=
X-Google-Smtp-Source: AGHT+IGs0rO6y3EhNUBFIw/OeS+hQ44NlFmkkIW9YWquZKlgIRP5Wkgkz8Y7XLLxX8mknCmvoHlUvQ==
X-Received: by 2002:a17:90a:db93:b0:296:4177:6404 with SMTP id h19-20020a17090adb9300b0029641776404mr4264355pjv.11.1707340705947;
        Wed, 07 Feb 2024 13:18:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQL+e9ohiAXXHYDVVWeNysSGdde06dDQPD7+rCTlOQu9O90PArzCZ39coi6GZfJitJcc3K5H1OnL5YhFynfGHi5+Mrr+kINMHkZ4pC1vXoL7l2TNINWPC5W0kwPO3xWK+nz3vB2rhxPczRVAmdMEhwwwz6s4aFYsrZpDhCONLq2m7JlB9vV3RXJINitfQ7dLBT9KdwW1S1PgOEgoDaIwnGn+KxYTE8DGkhYqTScFhaxP2CeTWJN+5/Hk+ErvJi7BumZI7N6g==
Received: from localhost ([2620:10d:c090:400::4:3c45])
        by smtp.gmail.com with ESMTPSA id cu6-20020a17090afa8600b002962f35fb42sm4429175pjb.48.2024.02.07.13.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:18:25 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 7 Feb 2024 11:18:24 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Alex Gladkov <agladkov@redhat.com>, Phil Auld <pauld@redhat.com>,
	Costa Shulyupin <cshulyup@redhat.com>
Subject: Re: [PATCH wq/for-6.9 v4 2/4] workqueue: Enable unbound cpumask
 update on ordered workqueues
Message-ID: <ZcPzoHmcaC6242oM@slm.duckdns.org>
References: <20240207011911.975608-1-longman@redhat.com>
 <20240207011911.975608-3-longman@redhat.com>
 <ZcO8-JDXkoDeMFVT@slm.duckdns.org>
 <69641d8a-8f1c-4a57-81af-0b26c8b1d2cd@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69641d8a-8f1c-4a57-81af-0b26c8b1d2cd@redhat.com>

Hello, Waiman.

On Wed, Feb 07, 2024 at 03:59:06PM -0500, Waiman Long wrote:
> > But why do we need this? Isn't all that needed to call unplug_oldest during
> > workqueue initialization and chaining unplugging from pwq release from there
> > on?
> 
> Yes, it is possible to just do unplug_oldest_pwq() in pwq_release_workfn()
> and don't do it in apply_wqattrs_cleanup(). As said above, I just want to
> reduce the latency when the old pwq to be retired is idle. I can certainly

They should retire as soon as all the work items are done.

> update the patch to just do it in pwq_release_workfn() if you don't that it
> is necessary to do that too in apply_wqattrs_cleanup(). That will eliminate
> the need for the extra arugment and simplify unplug_oldest_pwq().

So, yeah, let's please keep it simple for now. We can add optimizations
later if this becomes a problem, right?

Thanks.

-- 
tejun


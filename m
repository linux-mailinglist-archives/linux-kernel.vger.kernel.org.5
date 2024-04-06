Return-Path: <linux-kernel+bounces-134061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3F689ACAE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 20:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191541F21FA7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 18:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E67144C87;
	Sat,  6 Apr 2024 18:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pCMnijP8"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC1D4596B
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 18:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712429300; cv=none; b=T8kMMjxwN/PWjVf7gWybnuS+xpdGdMctKGoaqaxtt0TAvxyylLA8lPd4pSLxyu/7QQsyYDwHJdYYw39oIlMYLXcuBlaIx9VHBF2/A71zREtmRtlzceBgPiF3XBZjDDm8H1uJAmySd0tSCoEkw7BZlM2ZvqQ23I7wfXp76c0DXNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712429300; c=relaxed/simple;
	bh=JkJ7awgyjocGhExtmI0IDac+uVE+RlqQYYJBf5DuZq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWQU1vF+ecMXfFlXavKQYBcqc6V3vWQEEfRU5G9JcDZJlWadQhEs4LkeU6mqcBzPz3CgxuQc4ey+O/JGI91jnAczMVjEQubZO19O92UtKngBQta4QL4y0qWIGKzt6tqRqnQWqqSc+r6c30h8caTCPfQBq9g/RVAObovnsK1RC8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pCMnijP8; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 6 Apr 2024 14:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712429295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JkJ7awgyjocGhExtmI0IDac+uVE+RlqQYYJBf5DuZq4=;
	b=pCMnijP8skWXiWntA/2D771ghSaPHh5ZwlBPv314cVMEzn1ZDgz8AUVguO2f2aQL/J0RF7
	NrC+tsBQev8vsoIwm74bxaqFaVc5kid9MQ+x61BJprgAkCXIIyigmhoKZcBXOybdiUmp94
	AGBIIOyth5YoNU+D9CeOhezBB6KNWFY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcachefs: Rename struct field swap to prevent macro
 naming collision
Message-ID: <wvui43l6pcfexoglhyy4xfdjs4mrjzmbcwupnb4djlgvrebn7s@l22gudock5d6>
References: <20240406141919.248148-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406141919.248148-2-thorsten.blum@toblux.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Apr 06, 2024 at 04:19:20PM +0200, Thorsten Blum wrote:
> The struct field swap can collide with the swap() macro defined in
> linux/minmax.h. Rename the struct field to prevent such collisions.

Same as in lib/sort.c, so what's the actual reason?


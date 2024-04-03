Return-Path: <linux-kernel+bounces-130493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5A98978E5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF068B26BC8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAF8155303;
	Wed,  3 Apr 2024 19:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="T8spDLwx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65990153BF0;
	Wed,  3 Apr 2024 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712171812; cv=none; b=m3AhZxYnfMf1JBnAySw5PLcMOU7jgVrl+jDm0AnRAdFLcylS7BGZkuBAA//wfEGdbbHxzWG8+HYSqFMOZy43n3DDxb0S8d+n4j8uNeoEmOq9Pn30aHgZCjp1rHBNwG3bHwPPOQf8wOTw1Ie+a0WsANfWVP8hUoOG71rHD1jF8Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712171812; c=relaxed/simple;
	bh=2+Hh0DtpKdkFvQeR0/Dapttfab7P68cFqEBadYGE96g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Xjt66xaoq1kvERDLvnOAuieEoHCLDaEnh1III+qLG1W7V5s0xrYjsiOXX5NwEP8b49zdNyH0bmH9prXnPqrQDbWlbLzc6NZMERL/itfvS6HpfqFoL5Xe03GZS5ZuDFnHsjjDVrA+dgAnTkbFBpinnoNsZd0awfTnVrJuLE2QWi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=T8spDLwx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46E9C433C7;
	Wed,  3 Apr 2024 19:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712171811;
	bh=2+Hh0DtpKdkFvQeR0/Dapttfab7P68cFqEBadYGE96g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T8spDLwxHip5kja/W6ilduRkii3vZ++NweZsReHPIwvp3VV0YwIMz5Y7EoAdE3O+j
	 T3+awvHodraEaeTMKxIAP7BaIlFsrrsVkDf/wXLNPJiIHBOiRC0zOxtKFUafCFmrva
	 exQxg6e5nSuXAnue+CJ3y9NjIIH+4cal1BqQQs1U=
Date: Wed, 3 Apr 2024 12:16:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/4] Use folio APIs in procfs
Message-Id: <20240403121650.d0959d09add5e2066761844b@linux-foundation.org>
In-Reply-To: <20240403171456.1445117-1-willy@infradead.org>
References: <20240403171456.1445117-1-willy@infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Apr 2024 18:14:51 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> Not sure whether Andrew or Christian will want to take this set of
> fixes.

This set has dependencies upon your series "Remove page_idle and
page_young wrappers" and I normally do procfs, so I'll grab.


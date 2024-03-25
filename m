Return-Path: <linux-kernel+bounces-117937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFAF88B17B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7464320181
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4075C612;
	Mon, 25 Mar 2024 20:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="c9z7R7tV"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055E96EB6B;
	Mon, 25 Mar 2024 20:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398731; cv=none; b=UULRqT7yCOyl8A0+uILeUGjg2CA/TftmtvS/xg2WRVq5k2wYTf1/0tXY8Kvn+nFy1ujt7fJ7D5iiaJsWh4/f8VDtgv58BZGD4okFJ4X9j+MqfWVMych4ewBERRaYs1KN8xuTbKZ0E+WCbIDiEHpbsWlFCF+DjjrxLCY8skywY9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398731; c=relaxed/simple;
	bh=xzmv6mMlpEvMbgJTSPKZHb8+EwGBFqHQ3B0+1clv80c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASGkI26x5NBclVhWPEhTduojc7DvJFjQGf3lZ5tiZBXAD9XQ8At9mq7JnjBBkx0enHY5OUpb+04e0NEsfhvTa8VxWC5AGpknU+9gk34Xzgg7yxCrxvP/La0w1kbrnBsS9aBrnWitVzMiAu7Xqv6FdxktIijnP1CDvUW0WWDnJVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=c9z7R7tV; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BF24540E02A5;
	Mon, 25 Mar 2024 20:32:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3IP2q03BPLWA; Mon, 25 Mar 2024 20:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711398722; bh=SnlvwgSIk2dpptmvoQXPfmM6xt7tigcQgumtG0mbaUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c9z7R7tVpBAi94OueSsAr540glmaYKXEZgp5MTX/E5gToU6/rj8OsXbglcYSz3BDf
	 DG81EMzdZY8LnpvV0xPvjAEbt/mXfN6eLGXqUuWe4J3sjf2kUyD9u5dic8LvivgB1T
	 sb+mxnGRpe5nKjVJS7khzU/75jJ7LMHza86bb5r7syKFPA6UR0xCF6XMQLNAsRnWr5
	 OvF/zzvXW+UnWLXgf0qMvnsSBPpIg2DBD7C5RsWKnns2fSEEijKFbOJ5HZgiDd16rT
	 ViutTQsXwKsSKlSRP9I3hneKDlrPJSEjPz8JleiZE8AMtLgcnVbR7vynDC8hGM+77H
	 ILq+Utw+CWD+m0r04om0RJhtjJupD5CEiLXU4OPxcPu2dU/Oen3RZUSX9PKxPViIHE
	 IMYYzwWNu6n/lnm8bYgFWC2FBkkKUCrRBVN8UohiEhf5mMY8mpc+/v1yNPmU8oRJfA
	 J/05+8YhazYIh9eD7UoNEfnkSsWed9gwxTDPDu6GU5C6Qb5q1P9rJElzbDjEmdmu86
	 itZ9Me8QhOSJiLbsYFQccEbrQiTs7VV8Hui1ejNZ4U20F2G44VRLMAEkcHpV7fBte8
	 /R19gJfT3scu3eSWRz7bmBhLTXaAH65YWj4Bf5cUx83WLgmjWu0YLsoo68yk3WOCp0
	 EwMfHLRgxIDH+ViXHzpaD7EE=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8D22F40E024C;
	Mon, 25 Mar 2024 20:31:53 +0000 (UTC)
Date: Mon, 25 Mar 2024 21:31:47 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
	yazen.ghannam@amd.com, Steven Rostedt <rostedt@goodmis.org>,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH v3 0/2] Update mce_record tracepoint
Message-ID: <20240325203147.GIZgHfM6yqPbK2YLOl@fat_crate.local>
References: <20240126075800.1174583-1-avadhut.naik@amd.com>
 <20240208121013.1946ef7f@rorschach.local.home>
 <9e68a369-2667-4dd4-b715-ca1e13948a8f@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e68a369-2667-4dd4-b715-ca1e13948a8f@amd.com>

On Mon, Mar 25, 2024 at 03:12:14PM -0500, Naik, Avadhut wrote:
> Can this patchset be merged in? Or would you prefer me sending out
> another revision with Steven's "Reviewed-by:" tag?

First of all, please do not top-post.

Then, you were on Cc on the previous thread. Please summarize from it
and put in the commit message *why* it is good to have each field added.

And then, above the tracepoint, I'd like you to add a rule which
states what information can and should be added to the tracepoint. And
no, "just because" is not good enough. The previous thread has hints.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


Return-Path: <linux-kernel+bounces-132908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FE8899BE0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F0A1F228E7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7098E16C691;
	Fri,  5 Apr 2024 11:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="W0lLN19B";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Zh7bpjv4"
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289CD1649D9;
	Fri,  5 Apr 2024 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712316668; cv=none; b=GZHPDPR5E0co9DsxkXE6TfsXl+LNNT0GaePcbnLZhn6jMxTf/SxGcrP3I/acm+7031KK11D2EkzyjtgRvyh66RnrVYPemtl6v+GSgOHtpO5xaQocwu2ldty6qcUZD5yZMAE3Ah1iqtqTDnFbLhxWCB1HTTNufRFP55NRqOuGfBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712316668; c=relaxed/simple;
	bh=m7K3xrh7Wz99GlOaVIqzX1ncJYiBtyR+jSDbU435dqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwMfVa0k26Bp78U01KzF9hHWxHoqenhWk2ejVgc9BlcO80aaoL6pX7D0dvNNJrjsRGfZR59575EQw+g0xH0eL7QTX1xRo/8IUO9RUGf7PCYPkkQGb5EXhA3FPWTTPDzXBibuGYGPTZ1q4L/WPBT0Xe/2OkSDgJnzZ+iF6LcvI0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=W0lLN19B; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Zh7bpjv4; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 5C646C01B; Fri,  5 Apr 2024 13:31:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712316664; bh=mFIx+8k+ANOQ8BYwuRQQCSBqlnnopffUpvUlwuxTisk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W0lLN19Bu1rxXBdVWoqZ98P3vVLkxIDL5sun5z7ZP1c01h+b36BllepjYp+ZXMDxF
	 pJxQtxa8POrNEKW77JZtPynMo9mCgxlUwznE444NW2uB13ZE2v+hjl4Hvbq+wP6HNR
	 eJLJLtu1sVjT+JrmlSgykChDlAPxiLiirErjWlFZterHEC8pcD5SDFgi4WVzCwTGnL
	 mQVIx7swRLbicwtahrypx3888xbaJa/SXt8o6s/zHnrPz0It27DDGr/D27AIXLSj79
	 r/5uY7/PNXuBR7rI2WpwmTMAXZK+tPnkonCcM0Ry9YWcG6TmnIbUSObTIYvJ495372
	 rDFxrJWVUKnVg==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 71DFBC009;
	Fri,  5 Apr 2024 13:30:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1712316660; bh=mFIx+8k+ANOQ8BYwuRQQCSBqlnnopffUpvUlwuxTisk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zh7bpjv4FEj5oKlmEmYpdSD03U8Ortgvc7N5juSJ4S0p/rLp3UB/ZyBIPx42RiGO7
	 6ya6kHjJVNdWY2g3sUy15wIG95eXLd9cbsNAQ3GJpiAgxu5HnSFjbw6P/vn49SPYz1
	 GVZGfwIMIj5vOrVTcga9iLb1BcKHFE1bs0A9EFuSeRI0tw3jacCx7SV/GrCUxM0n3J
	 atM9fyfQFA164g+RQ3qQR7KZVEOpV94YwtIXKKkLg3OO4zUbBbLcicIobLzP0wMxFy
	 S6KpK1YC0sk3w3z4Nb5FYSDC1K3d1SUX6Es+zlH1ehGCkkUU9EM3IJGcF0AwBSv2I0
	 WWicSBtpHMF9g==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id a8448ac7;
	Fri, 5 Apr 2024 11:30:53 +0000 (UTC)
Date: Fri, 5 Apr 2024 20:30:38 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Brauner <brauner@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the vfs-brauner tree
Message-ID: <Zg_g3usopd3KWtF0@codewreck.org>
References: <20240404101038.11486a24@canb.auug.org.au>
 <Zg3tWULD56chInTG@codewreck.org>
 <5f56a81b-ac8a-417c-85ad-149f9f64649b@infradead.org>
 <Zg4F9SAGNcmKIa1v@codewreck.org>
 <20240405-entkleidet-performanz-2f46c4f67751@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240405-entkleidet-performanz-2f46c4f67751@brauner>

Christian Brauner wrote on Fri, Apr 05, 2024 at 12:57:08PM +0200:
> > Given this I'd favor keeping Randy's older commit in my tree, so I'll
> > send it to Linus as soon as Christian gives his ok on dropping the
> > patch (or I guess it doesn't really make that much sense to wait any
> > longer at this point?)
> 
> The patches are part of David's larger netfs-writeback series afaict.
> So what patch do you need dropped?

This one:
 528aa74c091d ("9p: Clean up a kdoc warning.")


I'll take this as an ok, I've just sent Linus my patches, thanks!
-- 
Dominique Martinet | Asmadeus


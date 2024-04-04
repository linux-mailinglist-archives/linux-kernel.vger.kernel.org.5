Return-Path: <linux-kernel+bounces-130830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 562F3897D9A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 04:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B57BF2891A0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A961B299;
	Thu,  4 Apr 2024 02:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FZw63Zba"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772547492;
	Thu,  4 Apr 2024 02:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712196568; cv=none; b=W04e/hLNl5GOd0XYRen4upP+/4BBh7gE+AsZEibExHuW8xPYYYGw0GyZmAsJm/2qeTBdNlok8tZqrxRNwhkVUZkdaza0vfFty0RbnWRk/ApiPzNtPRlx3w0dgI1EqHgTiTsZ1g+1Zo+aSq1CWrbRgmrD3L+P6KoqcnDHHBPtANs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712196568; c=relaxed/simple;
	bh=1y5vhXjYDVBU8HIXvpndczGvyFhFNkSSDoEAl+EmPZk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JY7/oWwVEEbo24jdeD2+Ya3fhW8LOArhaXcIG8foeVizWoYIqkwMyTyOJXSfw2gcFZqTK05RJ6oeaVmmAtHV4Of0Wh+8KWjtBsRgdfUW8A+NmX2/IoP/WnR0FcC5uqec4fqjOHGkyvESpKaFGd5t2tlR115q53Vw55DUe6OldtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FZw63Zba; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69D1C433F1;
	Thu,  4 Apr 2024 02:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712196568;
	bh=1y5vhXjYDVBU8HIXvpndczGvyFhFNkSSDoEAl+EmPZk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FZw63ZbarRQL99KabPVB8+9r6fa45xNvyZAsOax/nmQYvJNdwJcfFbCxJP2A/lqcr
	 5/ote4/n05Mcrc9g29whLQMTaX6TUF+C6IzQWtrQ4NXT33wOiHjQnuEjyViOjb7dlp
	 fddUa+sIVasyFqImuz37Cvg1dwtegX9EQfiJl6S4=
Date: Wed, 3 Apr 2024 19:09:27 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christian Brauner <brauner@kernel.org>, Dominique Martinet
 <asmadeus@codewreck.org>, Arnd Bergmann <arnd@arndb.de>, Randy Dunlap
 <rdunlap@infradead.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the vfs-brauner tree
Message-Id: <20240403190927.d2ba31d56f140982eba1435a@linux-foundation.org>
In-Reply-To: <20240404101038.11486a24@canb.auug.org.au>
References: <20240404101038.11486a24@canb.auug.org.au>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Apr 2024 10:10:38 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> The following commits are also in the mm and v9fs trees as different
> commits (but the same patches):
> 
>   0e74485c814a ("nilfs2: fix out-of-range warning")
>   528aa74c091d ("9p: Clean up a kdoc warning.")
> 
> These are commit
> 
>   93df85cc09a2 ("nilfs2: fix out-of-range warning")
> 
> from the mm-non-mm-unstable branch of the mm tree

Thanks, I'll drop that patch from mm.git.


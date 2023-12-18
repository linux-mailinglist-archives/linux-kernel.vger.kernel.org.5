Return-Path: <linux-kernel+bounces-3826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F64817369
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096681F23826
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DA21D13A;
	Mon, 18 Dec 2023 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="nZKL1jqy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E618129EF9;
	Mon, 18 Dec 2023 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0480B37C;
	Mon, 18 Dec 2023 14:18:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0480B37C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1702909123; bh=rzUM8jupmmDIGLuiq7yJvkLlnNlEw6pMqLL+bnsZaQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nZKL1jqyb1b6omfyiOQd/n6RiJjSRAWXQDuV9BtFbwzX/6khfuUL268M2HQ7Bq9Jf
	 YSH+NGTIkF3Ac7Fa9ZHVgMsiN9TnQEoGO+UI3nUA9mu9th4nCA82LA7Z4quTVqGy5w
	 SfiWuHgTfX6cr4SiR96LrEJ2PsnafiAwy03v2t2W/4KpcuqjYLhLBRLPVUKkyYCRER
	 6TLDSTLIWI/KUqs1uJvQ78yafM/sRY/rolc1hfs2mCA5HKjx/ZhV9uy81q25vZU549
	 UQMSPWgpA/N4w+F6NVBK8Oy8T4TnQ/kx/T/Yd9xcwe4Aqlc6DPB8B/DogC185kJbVF
	 t92pb9cNPNVpw==
From: Jonathan Corbet <corbet@lwn.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Randy Dunlap <rdunlap@infradead.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the jc_docs tree
In-Reply-To: <20231218182825.39a6562b@canb.auug.org.au>
References: <20231218182825.39a6562b@canb.auug.org.au>
Date: Mon, 18 Dec 2023 07:18:42 -0700
Message-ID: <87r0jjmw59.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> After merging the jc_docs tree, today's linux-next build (htmldocs)
> produced this warning:
>
> include/crypto/hash.h:248: warning: Excess struct member 'digestsize' description in 'shash_alg'
>
> and 636 new similar warnings :-(
>
> Exposed by commit
>
>   b77fdd6a48e6 ("scripts/kernel-doc: restore warning for Excess struct/union")
>
> I am not sure what we should do about this ... last Friday I only
> got about 18 lines of warnings.

The warnings were expected, of course.

The alternatives are to fix the docs or to revert b77fdd6a48e6,
pretending that all those kerneldoc errors don't actually exist.  The
fixes should be pretty easy to do (and there's far less of them than it
seems from the number of warnings).  I can't get there right away but if
nobody beats me to it I'll try to toss some patches together.

Thanks,

jon


Return-Path: <linux-kernel+bounces-8635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4346681BA72
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C98D3B251D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566D24F1E9;
	Thu, 21 Dec 2023 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Z58dPuY6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7BC539E4;
	Thu, 21 Dec 2023 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 198847DA;
	Thu, 21 Dec 2023 15:20:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 198847DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1703172015; bh=M5C3Amum1S0G/drP7vUNUyz31la15iZxUnl93TvSwgA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Z58dPuY6bDCSdpULMcvf2KAM/zh0Tbd23dXMxLow6IEZzdI67MaFxWKIR/OZOLXqm
	 HXpfXEnoVOUJFWMka2soRTu02/eXPZT1vgLO9ZHgDlWnS3eojZmYcPICgc8Y4ZC6nT
	 0Pc2NvGy48PalQjFrR7C728h4E3q9iP0Ll9pBznDjfTfsuF2TWEjoUnDsSJwi7pivG
	 rhaw00HMW7WskzZMWUUif9MNFSi9x+hBjks2bHoA8VVvHMw1Pi7ASjg8sQ49u3XaZL
	 7eQOoviOMcI6CeZA+T2hd8/o8ZfAW6cmEMuNBdUcMx+ZyzqwLEDWd6Bx8W5vR2tbsh
	 UUwOagYyy5q5A==
From: Jonathan Corbet <corbet@lwn.net>
To: Vegard Nossum <vegard.nossum@oracle.com>, Randy Dunlap
 <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] scripts/kernel-doc: restore warning for Excess
 struct/union
In-Reply-To: <93e1b9fa-c447-4f7d-9dc7-825ebe9e1cde@oracle.com>
References: <20231214070200.24405-1-rdunlap@infradead.org>
 <875y0zqvjr.fsf@meer.lwn.net>
 <93e1b9fa-c447-4f7d-9dc7-825ebe9e1cde@oracle.com>
Date: Thu, 21 Dec 2023 08:20:14 -0700
Message-ID: <877cl7a8gh.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vegard Nossum <vegard.nossum@oracle.com> writes:

> On 15/12/2023 17:28, Jonathan Corbet wrote:
>> *sigh*
>> 
>> This adds nearly 600 new warnings.  Anybody gonna help fix them?
>
> I think in the vast majority of the cases the fix will be to just remove
> the offending line from the kerneldoc, so it's not particularly
> difficult, mostly just overhead from the patch preparation/submission
> process.
>
> I'd be happy to take a stab at it -- I think we could even script most
> of it. Respond here, I guess, if anybody else wants to do some so we can
> split it up.

It's mostly done; I've gotten it down to under 200 and sent patches to
make the changes.  Randy is working on it too, I know.  It's not always
just deletion, but the fixes are usually pretty straightforward.

> On a related note, it might be useful to have some kind of "status page"
> somewhere on the web for the docs where you can see a list of unresolved
> documentation warnings in mainline/docs-next/next without having to do a
> local build first (as a way to solicit contributions).

I suppose, but how do you know you've properly addressed the warning if
you don't do a build afterward?  I don't see that saving a whole lot of
effort, but maybe I'm missing something?

Thanks,

jon


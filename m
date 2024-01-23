Return-Path: <linux-kernel+bounces-36102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F51839BA0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E641F23EC5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA74B4F61B;
	Tue, 23 Jan 2024 21:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="dtuXTYpG"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25FC4E1CD;
	Tue, 23 Jan 2024 21:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047101; cv=none; b=A0L7hYfg3f6QGVeQEHtb5aNvv8JgVJeNxIrcHnJ1fY68pFU8Q3jC4p7KzfGOgMKpQqsthWTrykLPwQZqm+qMtXiBi33vPhL/QLxG8tONEzB5FUTh1arBjyme+vK/sQfuY3p7b3JG1xyJQglUGxwg98S60WIzZ//KP9WX/zQbNWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047101; c=relaxed/simple;
	bh=Ndega+sIAkIq1YFNOA0L1EWMuFio0gyq0Wio7QvD9wI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ULMacQrVizq5aNsqaShIN2Jls58azRDmul5QI6nAc0qTCcUifU/96QODzv7Ac/GvYIHX3RkAoAoBma56YiRSugHMrbM0lLn8hF545lTKru0XgJfOFknaLANNB9X3pRC1XtsYmbbWF7w5g3Dw2ikb8SzlY1xfp/PmuAtmCW68Ifs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=dtuXTYpG; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (c-98-53-138-11.hsd1.co.comcast.net [98.53.138.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 11D037ABF;
	Tue, 23 Jan 2024 21:58:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 11D037ABF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1706047099; bh=cOSWOI6kz4AsfGTEdILlw4SPtuYI5N874fprPojluJw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dtuXTYpGX+sLT38a1XQ2kHia94Fv81/IcD+AXCuQ/FYF3kpyS/FWig4mio9NihnqC
	 MelEaaWjFy2AjKszWNbxQbuXUGPWHStcJ79hgvPipLc4HhLIr8h8sTFr5VzWyuZfbR
	 UeRthCMbk+UiB1Y+KRNfOrGHIUoVlDgEe2aHKubs7Lq/NSbWExtD86mCyr94pvdNAe
	 oZ3Phlm82aZYv2hQ4qBKdvd6KuFQRHzYjQKw17IoM0nsx+xXxQdpd6q2kn/PSVw4G+
	 p5y84JnOuytowvza9ty84vv9e5Fz3zMml6cVKoslBkSyqC1bPnyIMhRVhKklsgx4Iq
	 ndhDKBmuTV77Q==
From: Jonathan Corbet <corbet@lwn.net>
To: Vlastimil Babka <vbabka@suse.cz>, Lukas Bulwahn
 <lukas.bulwahn@gmail.com>, linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: admin-guide: remove obsolete advice related to
 SLAB allocator
In-Reply-To: <f0353b3e-9cb3-4009-9c2e-4e0912f28dc2@suse.cz>
References: <20231130095515.21586-1-lukas.bulwahn@gmail.com>
 <f0353b3e-9cb3-4009-9c2e-4e0912f28dc2@suse.cz>
Date: Tue, 23 Jan 2024 14:58:18 -0700
Message-ID: <8734unk8zp.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vlastimil Babka <vbabka@suse.cz> writes:

> On 11/30/23 10:55, Lukas Bulwahn wrote:
>> Commit 1db9d06aaa55 ("mm/slab: remove CONFIG_SLAB from all Kconfig and
>
> Note that's a -next (from slab/for-next) commit which might still change at
> this point.
>
>> Makefile") removes the config SLAB and makes the SLUB allocator the only
>> default allocator in the kernel. Hence, the advice on reducing OS jitter
>> due to kworker kernel threads to build with CONFIG_SLUB instead of
>> CONFIG_SLAB is obsolete.
>> 
>> Remove the obsolete advice to build with SLUB instead of SLAB.
>> 
>> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> But due to above, maybe it's best to wait after the removal goes through.

That has definitely happened, so I've applied this now.

Thanks,

jon


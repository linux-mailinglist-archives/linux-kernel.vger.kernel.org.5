Return-Path: <linux-kernel+bounces-71991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4677085AD8C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0163228719C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558B453E12;
	Mon, 19 Feb 2024 21:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Y8BYTRlM"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B0653816;
	Mon, 19 Feb 2024 21:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708376933; cv=none; b=YnijqK9IOaLqEac+rwHwo43XTr0n6k7nadVlVqaYl+cohJQRjWtiIMY2UCc/2f1SRscj0nDQ9hxfVzVI1M8wUBqCI2fVumVIxxrVQD6D8hZglyyqbde9Ka9Ijc+3nT5FRdpMrLs989U3/e3RDx6ZjgrtrEcyhThx1Cs32ePITFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708376933; c=relaxed/simple;
	bh=jZz8KgXb3MMiE44ES83oiRGJcepcSHs8+QmOme+7rII=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c4sKiVqf83UvRi5wx55cnY8SB+AmLzpcagpyYIp1nWLdVyYenzmKtUb2EQqsnERCh9L4OgHsoqsIRyTjC38hjQHaidnm/EpJAtgTRmgMpnBZehwE+VJAg+JKxCAyrDwgfcp202sd0DxOcRZrbhvOyLpKhxcAOcf+o4dsKFbJRew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Y8BYTRlM; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9FC1D47A99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1708376926; bh=X4TLb0vzjzBC557Ey9iVpTzSDbc+UN7a92OV2AEYVvQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Y8BYTRlMJd3qN1g5BOgQXGLP1hvrb79t8A0tNq6L2T1YyAumdwOPrgqFoT0mH9XyL
	 22VRTtkMCWvIQPhYi8Y6di595RoMfhATt6emMEdWEJbR+W16fHi8iVauBu2vfjeJ/p
	 6M9sR8HrTurKrMJeeKWfYCu/vT031PtCOo8EwJHTo/q97Q7DbuQK59KHv765Rfyu+6
	 rWa2PlqQUdD0D7I5kb6K4gZBdsZ+WjEeFkFLDOdgNNLXJ8xavlb35w/SqbUuldmD/I
	 UlUny+vS00SqspI1BxSNuJs2nIHffD1gDEcfAffZW8Cb4S4K1aWwPVeiO5nS0Nz8mf
	 8JauXVlBn62Rg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9FC1D47A99;
	Mon, 19 Feb 2024 21:08:46 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Federico Vaga <federico.vaga@vaga.pv.it>, Akira Yokosawa <akiyks@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: it_IT: remove references to original documents
In-Reply-To: <20240216221024.7oqlosmy5yemqum4@numero-86.vaga.pv.it>
References: <20240216221024.7oqlosmy5yemqum4@numero-86.vaga.pv.it>
Date: Mon, 19 Feb 2024 14:08:45 -0700
Message-ID: <87h6i4nov6.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Federico Vaga <federico.vaga@vaga.pv.it> writes:

> Hello Akira,
>
> On Fri, Feb 16, 2024 at 11:15:12AM +0900, Akira Yokosawa wrote:
>>On Thu, 15 Feb 2024 22:45:46 +0100, Federico Vaga wrote:
>>> A relatively recent improvement to the document building process added a
>>> functionality to point to documents in different languages. Hence, it is
>>> not necessary to add an explicit link to the main English page.
>>
>>It might be true as far as htmldocs is concerned, but please remember
>>there are other targets such as latexdocs, epubdocs, etc., where the
>>translations extension has no effect.
>
> You are peferctly right. However, I do not see a significant value in these
> references if they are not hyperlinks in a browser.
>
> The reader of a translation might use the reference I'm removing in this patch
> to quickly access the original document. But in theory it should come back once
> clarified the doubts. (Otherwise there is no point in reading a translation if
> then you stay on another language)
>
> This easy way to go back and forth is offered only by using a web browser.

Remember, though, that we aim to keep the plain-text docs as readable as
we possibly can; the translation extension isn't helpful there.

My inclination would be to keep the references in place.  That said,
you're in charge of the Italian translations; if you want to take them
out I'll apply the patch.

Thanks,

jon


Return-Path: <linux-kernel+bounces-72043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E8285AE2F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C81A01C2245D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2B255E59;
	Mon, 19 Feb 2024 22:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="flDMcufA"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733A355E47;
	Mon, 19 Feb 2024 22:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708380446; cv=none; b=k3EnC5z+0nhCry2v7Djt7ysLJirIW0PGOeqk3GCHp28nJH3KwTi4f9+NNDSVVeN+pRPrOwbEcnZyumX5Rodn7mKJ/6zG/62nLviDOrrcxJ04Gbik05kk2iwdCbuzSFLTLAYLQgeZ8tKb+TwMUz9w8Ikma6TvHv5zQzZ37psqWAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708380446; c=relaxed/simple;
	bh=vPx+i4YZu6acCeEWwBUL2nNSMhYkEmcB/Msn/Zpo4bs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YaddbvOV4X9b4aeQDRtO6MIExVHT8Kk2w90WjV0HQebypk3LIysj9I0vPrhVcu3lLZ0p8gnknISz7SKHii+8kRKFZ0cHvyw3nsW8SAvm4RYmw+Eygl+IGvYR063XXHttXFN9J0kTpLMwWGzyW1BvyjIxkuGWWLdLyAuC5W+naJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=flDMcufA; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9727A47A99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1708380444; bh=WQNrF1tBn1L+1P+pwGgLFmtvTUbb66/8AuK0cY3LefU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=flDMcufAUFMoNKNheRkxzhUKkvLtaagrWXIjvfHPJlFflZlZV4YiJnP0GU9ulLl6i
	 PKpj9STlaVHFdBE2b97fNkYkj9QegKbXsoLqvZIwzn0LGzfEZOEdJFCl2n5r68lLMT
	 frWcxVnpkk+vu5COq3bCXOizDPxbPZ0LAmocUuJAvcIlYMaJJQatKc1E7QHbOdv4U4
	 frCZIYxR4RrOMDsNL4x+OttX/VI25PzbVBDh1bQr/yKcOEegHLUUVvRnGcmt5TRs+A
	 d7d2k5y62oGjGDbdGNCgAyqXC8dgEcvFa4LjjtWpHUI0Fa9W8Pl4laYkFwugCW60Wc
	 r6hPyiVxsGjNQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9727A47A99;
	Mon, 19 Feb 2024 22:07:24 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: regressions@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>, Nathan
 Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v1] docs: new text on bisecting which also covers bug
 validation
In-Reply-To: <bf1d2eba0d291ff583e01b5985a0dec248eaf27a.1708072870.git.linux@leemhuis.info>
References: <bf1d2eba0d291ff583e01b5985a0dec248eaf27a.1708072870.git.linux@leemhuis.info>
Date: Mon, 19 Feb 2024 15:07:23 -0700
Message-ID: <87edd8m7l0.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Replace the existing brief explanation on bisecting regressions with a
> text describing the whole process from beginning to end -- while also
> describing how to validate if a problem is still present in mainline.
> This "two in one" approach is possible, as checking whenever a bug is in
> mainline is one of the first steps before performing a bisection anyway
> and thus described. Due to this approach the text also works quite
> nicely in conjunction with
> Documentation/admin-guide/reporting-issues.rst, as it covers all typical
> cases where users will need to build a kernel in exactly the same order.

I have scanned over this; don't really have a time to do a detailed
reading at this point.  My overall impression is: it's useful
information, but I think we're going to overwhelm people.  I worry that
we're replacing a one-page file on how to do a bisect with a 1,900-line
beast.  I suspect there are whole classes of readers who want the new
stuff, but there are others who would be better served by something much
more terse.

I'll repeat a question I've asked before: should we create a separate
"tutorials" book for this kind of material?  I honestly think that the
readers for this kind of documentation will be a different crowd, and
everybody might be better off if we put the tutorial material in one
place where they can find it easily.

Regardless, thanks for doing this,

jon


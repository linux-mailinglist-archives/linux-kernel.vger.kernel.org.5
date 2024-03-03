Return-Path: <linux-kernel+bounces-89805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E3486F5EB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF3C1F213CE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56BD67C53;
	Sun,  3 Mar 2024 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ls5L7mHc"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A791BE5B;
	Sun,  3 Mar 2024 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709480106; cv=none; b=BN9OqbpI/aV26SuQPec3sugjM/v747tgoYITKLeGzAt6FvpOWO/aOo7GGsiVIWwaN/Nl/78BrRYdBAqi41PEpywB7b67WDGEaBLq7fTGd2dBarNbpFtGjbq0rRF0XKaNZMj8vOLR4iZsiGMKS6p2s1YVANYlUVcjPlbGDqUhZ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709480106; c=relaxed/simple;
	bh=3MKVBHEu0N6EzRncaRdIJP+pdeGSMCtu9w+rZsprsZM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tHoUX8Fsc6mIxSQO0eykqJfVoL2Sfilg+cpQCAp5JDQ+Ut1AJI7qmlJtWSx9QiJhnvJilbftaiilqw5xPYJWoUT6YKZbxbXOebd8hxRl5n47tAELXgdEaXl4+DMmaaorDK4K7DZeJkCW3Jqxae61K3W4oTSMypHwnNGb3wQvb7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ls5L7mHc; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8B26C418B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1709480102; bh=IqZO9YkoE1oQJOVKbcqklngw16HV175A5ImJkkZYBMY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ls5L7mHcAScYICDNrQxaIaXLcKi03oJVmOPhckNxdJ4l5tHNcHa3U7nXX3L1UoSCh
	 Ob1oUAekmTkE2EWCDBotPFws5os2UDbDl78ySX/RQCo5jPDT00JQqjd+kJVjV2eFHK
	 YFUTTwMag6uJgVBHPHiHq3WjlQKB89lUaSocabVy6iUngL3nBhi32moan47eUOqhVO
	 ADz2h9eeBEv8NvyzKoFlIMhOJ1A6HS9/RID+4kahuwPngHDeDV6yAN66UnTXVvpdd3
	 AYXdV45tVEhMgRbD+ZFtnnlK+j86gQDa/dJmgI0FjGwbKE7NnVmL4g3bkl4bV+i48l
	 CcGZw8hxXBp/g==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8B26C418B6;
	Sun,  3 Mar 2024 15:35:02 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Vegard Nossum <vegard.nossum@oracle.com>, Thorsten Leemhuis
 <linux@leemhuis.info>
Cc: regressions@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>, Nathan
 Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v1] docs: new text on bisecting which also covers bug
 validation
In-Reply-To: <99b7841b-62d4-404e-815b-5eb5cccd2580@oracle.com>
References: <bf1d2eba0d291ff583e01b5985a0dec248eaf27a.1708072870.git.linux@leemhuis.info>
 <87edd8m7l0.fsf@meer.lwn.net>
 <99b7841b-62d4-404e-815b-5eb5cccd2580@oracle.com>
Date: Sun, 03 Mar 2024 08:35:01 -0700
Message-ID: <87frx7z5ui.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vegard Nossum <vegard.nossum@oracle.com> writes:

> Something I really like about the current set of books is that they are,
> at least in theory, roughly divided by their target audience
> (user/admin, userspace dev, kernel dev).

That's good, since that was one of my primary goals when I took on the
docs maintainership :)

> I'd worry that "tutorials"
> as a top-level book would unintentionally end up as a very mixed bag of
> documents that don't have a clearly defined target audience.

Could be.  The thing is, there's two axes (at least) that can be used to
describe an audience.  One is who the readers are; that's what we have
been working toward over the years.  The other, though, is the type of
information they want, traditionally divided into tutorials, how-to
guides, explanations, and reference manuals.  Mixing those types (as we
do now) tends to lead to not doing any of them well.

Perhaps the bisection doc is more of a howto, now that I think of it.

Anyway, that is a problem that we're not going to be able to solve for
the 6.9 merge window, but adding this document is.

Thanks,

jon


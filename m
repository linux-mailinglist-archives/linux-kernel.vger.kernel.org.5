Return-Path: <linux-kernel+bounces-89807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C932486F5EF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 734901F22CE0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D700B67C58;
	Sun,  3 Mar 2024 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="iW5D5N8O"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ADA679F8;
	Sun,  3 Mar 2024 15:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709480367; cv=none; b=hppNIzHjVcNfPoWNDAZxJnAUB/kwLDKdA0chOSP9wipEsz5bVve3hxUxMLjhaBdttNPW4GeIl93TzKGSe+IFxnqlP1cMek3chPk96z9XQtfR2NYBEYP+MYWWhmbkU37OohwUF7MSVz2jO00LhsW5kazypm043H+4pqEti2V2P8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709480367; c=relaxed/simple;
	bh=XplKrTH6YCJ0IDOk3BxUgRV0HbH1Oa6kx9jBhsTY1uo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZLzJzt+5eU9DdLh1WS+/h1J+Zpbba+vC9XjG/yWMiD3D+BuhX7Izn0dShKFxutRdNBm//NTfa/rXSHPmqb89bi9fk/T9N2Ynfs+eFYjjqptiHYdsaTfx95HvDc1AEeLkkanAD2pFk1AmsqcoNp0TisDEq6RdkN9ZIBD3bGbt2Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=iW5D5N8O; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 14842418B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1709480365; bh=2x/tLZ3JXMv1iZzytZCA40HbTYsn9biwz7yj7+QKAfI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iW5D5N8Ozt603G6lHabiIUwnENIUKvd4XgYYIXGyjb9WNOq3wYg/8QwWcaratpdc6
	 QHSDf2B1Yol6VPLqti27g3rjFCs/qj7SunnOqt3X6skEVNT4Y5KCsPgtdlB/00wD6n
	 uAO0TZ9jZwV/XzeZNFFmENYbvFt2e4s3fYcgflNzZdmD/Csxvxn+/CrQbmob7BTqun
	 xdvcCD5sXUIJ6VoQsRgnwhBkaQtlE5Dr7HZP5rjfk4eh3fVvGrDhRdDAJpypXGNms4
	 c+jFWsOL0MieaGC1BaJ6LQRUqGflDwFVC7sNPFzWTF8fmJrHqbKXV3870kcN7NPyO2
	 77ImQyoqJ1NfA==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 14842418B6;
	Sun,  3 Mar 2024 15:39:25 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: regressions@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>, Nathan
 Chancellor <nathan@kernel.org>, Petr =?utf-8?B?VGVzYcWZw61r?=
 <petr@tesarici.cz>, Vegard
 Nossum <vegard.nossum@oracle.com>, Jani Nikula
 <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2] docs: new text on bisecting which also covers bug
 validation
In-Reply-To: <6d282271-25fa-4ed9-9748-df3705f9d5fb@leemhuis.info>
References: <02b084a06de4ad61ac4ecd92b9265d4df4d03d71.1709282441.git.linux@leemhuis.info>
 <6d282271-25fa-4ed9-9748-df3705f9d5fb@leemhuis.info>
Date: Sun, 03 Mar 2024 08:39:24 -0700
Message-ID: <878r2zz5n7.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Linux regression tracking (Thorsten Leemhuis)"
<regressions@leemhuis.info> writes:

> On 01.03.24 09:41, Thorsten Leemhuis wrote:
>> Add a second document on bisecting regressions explaining the whole
>> process from beginning to end -- while also describing how to validate
>> if a problem is still present in mainline.  This "two in one" approach
>> is possible, as checking whenever a bug is in mainline is one of the
>> first steps before performing a bisection anyway and thus needs to be
>> described. Due to this approach the text also works quite nicely in
>> conjunction with Documentation/admin-guide/reporting-issues.rst, as it
>> covers all typical cases where users will need to build a kernel in
>> exactly the same order.
>> [...]
>> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
>> index ed8a629e59c86a..c53bb6e36291b8 100644
>> --- a/Documentation/admin-guide/index.rst
>> +++ b/Documentation/admin-guide/index.rst
>> @@ -1,4 +1,3 @@
>> -=================================================
>
> Just saw that, that line obviously was not meant to be removed. Sorry.
>
> Jonathan, in case you consider merging this "soon", as suggested
> yesterday by  Vegard, could you please fix this up? Otherwise I'll fix
> this with v3.

I've applied the patch and undone the little change, no need for a v3.

Thanks,

jon


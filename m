Return-Path: <linux-kernel+bounces-75473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEA485E92E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D35F1C2187C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CD254F93;
	Wed, 21 Feb 2024 20:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="RdY8yQQK"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A4DEEB3;
	Wed, 21 Feb 2024 20:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708548009; cv=none; b=LEQ2EQ19i+ECfo6W6rXB8TPWqCNzRi07lUpwfwPze7vvjE3D5DrhgEw77sDV3bO+Dx5obXuCdL1XHKM+2jSrBSKXBrphM+lkn2odK7bjrtjHBF78eP7QOJ2Z0rOhD9E1uHHZdesOIqD5GGLuLtRtkYFLQr3zWrc6w6Fjzl0ZdzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708548009; c=relaxed/simple;
	bh=E/x3+oe39HZF1Bh6XdNdOApkobf1vRfLqS229DNUEnM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H1lLsd4XMTiS8ZQXnjEj0JNpVMAxi2uHyN977Jcu71BLjfyCidDoalHkROg7cfvRE2TZQFvKpbxy5L37tWHWTj7k2O21F1r6Rbedit48knw6LsQpIeb3k+8SkkCjtbeL6Me4BoQE8dy/lh5aL6s7gcvW5VbolRa9maCJ5tDFzLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=RdY8yQQK; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 634FE45306
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1708548001; bh=y8VAbAaDri8AQyPpLQNF35/zJbeU1wOfCns87s/gO7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RdY8yQQK+Vm3OMiQZIPw7eIxFUfVILWNMpL0VyOxwzontcDWPceYATEl9WWZEkZ6C
	 ka6sBAvIYPjkhOmcUhPUqX8kzQyCxWtbyCcp9sKtVT+r5hrVNUBk83SwXBhgkXbjAs
	 jY82gAr4ehCpSzjSdBUmkyzUWqI8cN6X9y40uVCu3ncXfN8Meoy30GVXOP7Z0rn1Ad
	 qFQBp18UkkrQX1kxDERYuYv9B7FGrweNtVTa6IBnM6XoD+xzHgeINvCLfhDp5J0xnp
	 29HZdUe5HH2l/GdWYKspZbyxSCm98ccmPzizBuY8suVB8xcY+lx0hBNX66MMfqqYsH
	 XLcCMthx39Bew==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 634FE45306;
	Wed, 21 Feb 2024 20:40:01 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Carlos Bilbao <carlos.bilbao@amd.com>, rdunlap@infradead.org,
 vegard.nossum@oracle.com
Cc: bilbao@vt.edu, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] docs: Include simplified link titles in main index
In-Reply-To: <6314de0b-a69c-4e72-9538-8b133fc50047@amd.com>
References: <20240109155643.3489369-1-carlos.bilbao@amd.com>
 <6314de0b-a69c-4e72-9538-8b133fc50047@amd.com>
Date: Wed, 21 Feb 2024 13:40:00 -0700
Message-ID: <874je1d00v.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Carlos Bilbao <carlos.bilbao@amd.com> writes:

> Hello,
>
> On 1/9/24 09:56, Carlos Bilbao wrote:
>> The general consensus is that the documentation's website main entry point
>> and its sidebar leave room for improvement. Something we can easily fix is
>> that there's too much duplicated text.
>> 
>> To that point, consider the titles "The Linux kernel user's and
>> administrator's guide" and "The Linux kernel user-space API guide." We get
>> it, it's the Linux kernel. It's assumed that everything listed pertains to
>> the Linux kernel, given the overarching title, "The Linux Kernel
>> documentation." Constant repetition of "Linux" and "kernel" (45 times
>> each), "documentation" (21 times), and "guide" (18 times) are excessive and
>> affect UX.
>> 
>> I propose simplifying without altering actual document titles, the text
>> linking to these documents on the main page ("link titles"). For example,
>> "The Linux kernel user's and administrator's guide" could become "User's
>> and Administrator's Guide," and "A guide to the Kernel Development Process"
>> could be "Development Process". This is what my patch does.
>> 
>> Also, I send a patch fixing the formatting of the title of
>> admin-guide/index.rst (The Linux kernel user's and administrator's guide);
>> a detail I noticed because the link title would not work otherwise.
>> 
>> Thanks,
>> Carlos
>> 
>> Carlos Bilbao (2):
>>      docs: Correct formatting of title in admin-guide/index.rst
>>      docs: Include simplified link titles in main index
>
> Is there a reason why this patch set is currently on hold? It must to be
> feeling a bit lonely by now.

It's been sitting there because, as I explained in response to the first
version, I'm not really convinced that it's the best idea.  We're
trading off the readability of the main page to make things better for
the sidebar, and I think there are better ways to improve the sidebar.

That said, I've not managed to get around to experimenting with any of
those better ways, and I don't see that happening anytime this side of
the next merge window.

So I'll go ahead and apply the series, but I do still intend to revisit
this area when I can.

Thanks,

jon


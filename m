Return-Path: <linux-kernel+bounces-89812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8490F86F5FE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14CFCB223D7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B659E67C7B;
	Sun,  3 Mar 2024 15:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="aUld6k3M"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E4067C52;
	Sun,  3 Mar 2024 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709481355; cv=none; b=SMfVN+B/rXs5AqEiWo2HKY2wl5FDOhJDabWD+xoUTHo2a4lMeYJBqXIT1QqxfDQWAaSKqI9cz/HJJYiRNEGKkAGjVx6BJuNTSIBE2ysNh8osnkqb/DIUu1lYlJ9vGkMNixhBHQ6QaIv2MqTg5l0hcrszxjgUIVhAmoBSlPzi2+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709481355; c=relaxed/simple;
	bh=A4oTZLMFkOenzCOJ/988jBNt6yXBVrkt33H6ar9BUhk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ILRCkgzysEOe0Q+Ru5CzUvGgjHhDNhP8dViRTM8Ff03Iuh3jA+JgNtwR2dZztEVmUg3T/FcrJrI3d4BCsiBIbMOeu21Guub02tC/k9Dc6bYEhiiOTHQdKC8Jwp0P+SnEFD85GxIskYtAHLYc7Vf/A/egYfIvWdRewwGmVMpkZVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=aUld6k3M; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BC716418B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1709481352; bh=MYNtKSCO59wyJH3h0SJ4lWAQ9OF6yT+pyl7GmiHG76M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aUld6k3MOhNiW5SOakY4A89povdbxKwn1JO1ZNRdO5Py2S63GQVylVdBBbmqPlBGa
	 qWMm4ZGEDKgCz4VjXsnhpG0K4NjrrAsxEqehtY1SPGV3D/EZ5CQ6XmdgQ/Lko7nope
	 ma3jqMrXbCb6jWtj7mU1DhYNfZZtXMXXq5nSpKDJRumuFvpJ6enMX05qIRCHUPCLdU
	 3XRz02qFomIX1SJp4HxZ881qZH33vF4JNRgW0mT6XdMHUAL96QDRETbUoYFTJCAEu2
	 io/uWaSHISTdu3qiyDb+QhCyQ1YlI0+MTasOr6yZdvrRdxIC+95CzGVaFQOpvN4+rd
	 DotcBLla2n73A==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id BC716418B6;
	Sun,  3 Mar 2024 15:55:52 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Akira Yokosawa <akiyks@gmail.com>, lukas.bulwahn@gmail.com
Cc: jani.nikula@intel.com, kernel-janitors@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 rdunlap@infradead.org, workflows@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH v2 3/3] docs: submit-checklist: change to autonumbered
 lists
In-Reply-To: <8df0c587-8f5b-4523-89d7-dc458ab2c1df@gmail.com>
References: <20240229030743.9125-4-lukas.bulwahn@gmail.com>
 <8df0c587-8f5b-4523-89d7-dc458ab2c1df@gmail.com>
Date: Sun, 03 Mar 2024 08:55:51 -0700
Message-ID: <8734t7z4vs.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Akira Yokosawa <akiyks@gmail.com> writes:

>> -1) If you use a facility then #include the file that defines/declares
>> +#. If you use a facility then #include the file that defines/declares
>>     that facility.  Don't depend on other header files pulling in ones
>>     that you use.
>
> Wait.  This will render the list starting from:
>
>     1. If you use ...
>
> In patch 1/1, you didn't change the ")".
>
> It was Jani who suggested "#.", but "#)" would work just fine.

So I'm a little confused.  Is the objection that it renders the number
as "1." rather than "1)"?  That doesn't seem like the biggest of deals,
somehow, but am I missing something?

A bigger complaint I might raise is that auto-numbering restarts the
enumeration in each subsection, so we have a lot of steps #1, which is a
definite change from before.

That, of course, can be fixed by giving an explicit starting number in
each subsection, partially defeating the point of the change in the
first place.

I honestly have to wonder: does this document need the enumerated list
at all?  We don't refer to the numbers anywhere, so I don't think there
is much useful information there.  How about just using regular bulleted
lists instead?

That said, I don't have strong feelings one way or the other, and can
certainly apply it as-is if that's the consensus on what we should do.

Thanks,

jon


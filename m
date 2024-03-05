Return-Path: <linux-kernel+bounces-92401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 577F8871FB5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8811E1C21513
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2889E85933;
	Tue,  5 Mar 2024 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="lZwpFR0O"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAC929CE3;
	Tue,  5 Mar 2024 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709643581; cv=none; b=XXTgQBPwqRaDFzfckTZDhCoRHQy6DQfohm6bKftVK5YuBOLCLyBy8vgaVKkyXXP+scG8Ff+ipMgYmHZaeAhyZaTILiDTcKBfm3sfORyCZ5BXfhJtV+nJKH/DIbXe0yJq+yL1alAfNvq3Ll/Vk+nlwf8oFm4pPp1bU+SOgJa5dfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709643581; c=relaxed/simple;
	bh=UryY+s5i3BNkNhieIX611oJwoioT2U3ZfifU36LgoAI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XNBQ4h1CYuCzUVvKo/vQ+MChLdL6XZ0MiUlLFd2Xr0mk+ZGEJd4ENVqKz4+02mvEx1JPtNfYpaKaaCloy9auo+J4USIWAqfncJhHE1XNRYHdOrEcC7a0ct4qTaWOFu+m4yJchi3x1/Y77TeeHzr81lKf/J9eDq79YTPUjB4JP10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=lZwpFR0O; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A34AA418BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1709643578; bh=s6P8g/Yd4J9bSRPzRFoeAslw1QUDBefVV1bcHRgXetM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lZwpFR0OwSuQ0lhVi8Mk2rPHTvo+Irq35iceiO9WKH1wMgSIjgEaPBrdd1chXTVbj
	 k9SeBYEoyaIVnRfaXbQ1w16+bFRhv/q0ib5r8rAp41UyeDAknO60ZStjvRtJxfUZ85
	 lFRMKy4BeRbIPLb9a1Ns4tpTk/V9NLWUDC5ogrCif8zY4dh7qHVm+U5uJriifFj/Ua
	 MdyJH3e+kbiIhXVzkB8fhdd4f8DuXvyUBoxe4tNjfWfRUDcPWyWvMQhXhyosrlCD83
	 j3/6UGy+U5vznvDMQawYhxy9Tv8XpJlyCFvywW3/+aMlnKQ4kiIvFrnjvS1dyACNS2
	 RgH4I0oqShaVQ==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A34AA418BF;
	Tue,  5 Mar 2024 12:59:38 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Leemhuis <linux@leemhuis.info>, Lukas Bulwahn
 <lukas.bulwahn@gmail.com>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Towards a re-organized submitting patches
In-Reply-To: <57b07ec5-586a-46e6-9ba2-26be2372c1c2@leemhuis.info>
References: <20240301134637.27880-1-lukas.bulwahn@gmail.com>
 <87plwbxon7.fsf@meer.lwn.net>
 <57b07ec5-586a-46e6-9ba2-26be2372c1c2@leemhuis.info>
Date: Tue, 05 Mar 2024 05:59:37 -0700
Message-ID: <87edcorg06.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Leemhuis <linux@leemhuis.info> writes:

> On 03.03.24 17:31, Jonathan Corbet wrote:
>> Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:
>>> I wanted to clean up the development-process documentation. There is
>>> however no easy way to break the ice here:
>>>
>>> The elephant in the room is that there is some unclear relation between
>>> 5.Posting.rst, 6.Followthrough.rst and submitting-patches.rst.
>>> (Yes, I know each document has its own history...; but let us put the
>>> history aside for now.)
>> 
>> FWIW, the objective of those two documents is quite different; one is a
>> high-level overview of how the development process as a whole works, the
>> other is a detailed guide to submitting work for consideration.
>
> Sorry, I'm slightly confused here, so I have to ask: which is which?
>
> Due to the "*essential*" in the headline of submitting-patches.rst and
> its "For *detailed* information on how the kernel development process
> works, see Documentation/process/development-process.rst" in the intro
> make it sounds to me like submitting-patches.rst should be the one with
> the high-level overview. But...
>
>> Again, let's remember the different purposes of these documents.  The
>> development-process document is an overall description of the process,
>> so it doesn't need the details.
>
> ...this makes it sounds like you consider it the other way around. And
> for me that feels the wrong, as why describe the overall process in
> detail, but leave the most important part of the process to some other
> document?
>
> /me wonders what he is missing

The series of files starting with Documentation/process/1.Intro.rst was
meant to describe the whole of the development process to a wider
audience; I originally wrote it as a project for the Linux Foundation.
It covers far more than the business of putting up patches for
consideration - development cycles and all that.

submitting-patches.rst, instead, covers the details of getting code
considered for merging; it is intended to be read by the people actually
trying to do that work.

One document describes what the pieces of the car are and how they work
together to get you to the pub.  The other gives all of the steps for
working on the brakes without causing accidents.  They both fit as part
of a larger body of documentation, but they are definitely not the same
document.

Make sense?

jon


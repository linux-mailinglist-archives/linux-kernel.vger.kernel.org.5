Return-Path: <linux-kernel+bounces-66083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2317285565F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD62628985F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9770643AC2;
	Wed, 14 Feb 2024 22:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="EZNhP7Jf"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73341250F6;
	Wed, 14 Feb 2024 22:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707951293; cv=none; b=jGy5s7fcD4lMzVk35iNrJ4xih+v9EJS3l6yPoqbOb0hR/MN03SI0j3ORW/C9BEHf3eLgxt0kY+46yXfW/r7BbUpGNM9f/9kMLYigJ09m+fQM4al8GOafni/BSiPnqRwH/PMwXAOuSFiBu+1bd/0E0/qFlCi6ENnydbcGS7UYgAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707951293; c=relaxed/simple;
	bh=7UGtC2H28NfuSgzMUjD40FYXRN5lZAJ5/6gNdEIw0/s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b4yvXZ9t8sspltwdxklsYjmlSyt5bDnCqXQ0IOG6ktgGC/mTwRdJ1z1+OVi6fmqiIyBEAlWivIGtquzyqWthzn22HZCI5BjEsGWzzERB7EFitGbJ+V45OoJynT1s9NmBCLysEMadpfNUK4csEs3Catu5cnEAdVXp9w1y5vJjvRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=EZNhP7Jf; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B017E42A45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1707951291; bh=qddysXSunH36onRN/NzbZE/iiwDPZQOl5+ef+QeNKu0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EZNhP7JfboupDbNJP74e/jAjDa3DzsecLhGtYlLQ0b39ASEnj+TSUWAkaGOOsY8QQ
	 2ZeVpqquIkaDqiRWPfKok2EPHPj8XrVdNT24OAprVFC3tN/WvNOVH0wtHhwv3r4Vh/
	 jAtIiOFOl8rYLNR2Oi2+/iLbJIgR4OA8tTvvzC9n6Fyv0J6AvICRXfl8gYZh0UJs8d
	 l1awb6uVhSsNaClw9PX7Tn1znEgMUl6vsZqbMw/NGaTVpPf+FXN8BGrzryEYTZ9uv0
	 GkN1O9vcPLNWk/dTVYzsp8TJkNtcCrTGYW9R7miRpCgVNqCnKK0VYPKNCFJ/IUtCX6
	 +gAZ+iSHKJdVw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B017E42A45;
	Wed, 14 Feb 2024 22:54:51 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Hunter Chasens <hunter.chasens18@ncf.edu>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Hunter Chasens
 <hunter.chasens18@ncf.edu>
Subject: Re: [PATCH v4] docs: admin-guide: Update bootloader and
 installation instructions
In-Reply-To: <20240207171007.45405-1-hunter.chasens18@ncf.edu>
References: <20240207171007.45405-1-hunter.chasens18@ncf.edu>
Date: Wed, 14 Feb 2024 15:54:50 -0700
Message-ID: <87zfw2y7ut.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hunter Chasens <hunter.chasens18@ncf.edu> writes:

> Updates the bootloader and installation instructions in
> admin-guide/README.rst to align with modern practices.
>
> Details of Changes:
>
>  - Added guidance on using EFISTUB for UEFI/EFI systems.
>  - Noted that LILO is no longer in active development and provides
>    alternatives.
>  - Kept LILO instructions but marked as Legacy LILO Instructions.
>    Suggest removal in future patch.
>
> Signed-off-by: Hunter Chasens <hunter.chasens18@ncf.edu>
> ---
>  Documentation/admin-guide/README.rst | 69 ++++++++++++++++++----------
>  1 file changed, 45 insertions(+), 24 deletions(-)

So, I have applied this...but I got some warnings:

> .git/rebase-apply/patch:45: trailing whitespace.
>  - Booting a kernel directly from a storage device without the assistance 
> .git/rebase-apply/patch:46: trailing whitespace.
>    of a bootloader such as LILO or GRUB, is no longer supported in BIOS 
> .git/rebase-apply/patch:47: trailing whitespace.
>    (non-EFI systems). On UEFI/EFI systems, however, you can use EFISTUB 
> warning: 3 lines add whitespace errors.

This is something checkpatch should have warned you about.  I've fixed
it up this time, no need to resend.

Thanks,

jon


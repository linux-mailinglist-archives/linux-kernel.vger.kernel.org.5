Return-Path: <linux-kernel+bounces-45308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC4A842E54
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF0E51C24042
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4DF71B58;
	Tue, 30 Jan 2024 21:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="cMaKpw1i"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6876A00F;
	Tue, 30 Jan 2024 21:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706648588; cv=none; b=mXWWhj+1pWzr5kDesvfTpA8+gwE5mmt7GxtmQ9XUf3D97H8oa8QYhrxhDUREGuCLm/HBFzVijP5mYkPkEHzrdr0BLQAEGAOgbhpZWQ5NYZIMyuzRnybxrDf1kaCskJiwQlfK1fEXK7qD7nBkn+3OqyLWeLb2Xvz6XDTqGtTFrcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706648588; c=relaxed/simple;
	bh=1wml5qZATOLDrZSnA22Q+ilAe4MrWL7cXP94wAwMiJ4=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hxN/D2w8PzfIAnz63GwLSbxpsIDgZfwfAmG+UH2a/OqYFo3sGTOqUZUCeSihRlQBZ0e5ePOKrz5urLIY/TN10yKkd5TZGr/5I7nzWMCBaehqjVLkN/tIiXkSrcgrHdSzdSK8dMHk9asm/7t2wgsRR3eVEGY2iNMW7tiHvDTXWdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=cMaKpw1i; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D6FD741A47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1706648586; bh=BPdpuv6gJn1WpCJti7r7qszP8TqzbTL0zmPIjDHmLVA=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=cMaKpw1iJWxkmBulHi0d1a2XYFLxWTIL3wqCpyDpMbtqFNTYjw0cwEQIugMApc5Iy
	 M1k/jndzSc7zsR2vkT6jje7Gah9viukCfcLtwEhcyoUdgdA+kGqRfA2GBYNQaGJC5g
	 /1sSbaoQt3FYKMnJvMuxMpyczUF6k2EyTkzAQclfuApbKYG4ppZwu11w1wnLLnxrMR
	 DKkuz3ithP+Jk9W7+ORqr4ftsrW3jgJSG1zFix5yNTSYKU4uN9xCDhBfezeRM24vpF
	 BTzPs1nmA7Vb7WJM9Vd5J6Dkw9fqohxX4QDVmlHDVaGfDN2P656JFmBfrizCFJMjPQ
	 YpBF3/eewkPxg==
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D6FD741A47;
	Tue, 30 Jan 2024 21:03:05 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: mhklinux@outlook.com, costa.shul@redhat.com,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/1] docs: Fix subsystem APIs page so ungrouped entries
 have their own header
In-Reply-To: <20240125045941.123297-1-mhklinux@outlook.com>
References: <20240125045941.123297-1-mhklinux@outlook.com>
Date: Tue, 30 Jan 2024 14:03:04 -0700
Message-ID: <87jznqa60n.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

mhkelley58@gmail.com writes:

> From: Michael Kelley <mhklinux@outlook.com>
>
> The kernel subsystem APIs front page currently has four top-level
> groupings with headers, and then everything else that isn't grouped.
> But in the table-of-contents, ungrouped subsystems are indented as
> if they were part of the preceding grouping (currently "Storage
> interfaces"), which is confusing.
>
> Fix this by adding an "Other subsystems" header for the ungrouped
> subsystems.
>
> Fixes: 3c591cc954d5 ("docs: consolidate human interface subsystems")
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  Documentation/subsystem-apis.rst | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

jon


Return-Path: <linux-kernel+bounces-49456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF82846A8D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179701C25849
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D191863B;
	Fri,  2 Feb 2024 08:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SieaC4nr"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A90618628;
	Fri,  2 Feb 2024 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861793; cv=none; b=DrarRMzYj95efsZJehtwUSqzJ5DJiNklx9eaMXNjeA4z9aBpBJLT1iTS9xGl3ptHR27wlEGlgrbaWCYdJ4Gd/GK9itFOwcGXTrgm5ajAfayYLu49Tojlt/tDqd/iJ/EHHcFyEoQNSd7uta2c2u3F0j2MYz1KN5QoDa9hrk3a5Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861793; c=relaxed/simple;
	bh=FXuZCdbTnTvt3fLOxA1iEZtu+D4augzBlua9BOnW8gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alHofRInZ2g1xjAGjKfVEOoeO+qF73VnAGIwNo/7TBfIna11fyZUZ1uJ9xM/ZcUeIwywfANU9Bf4S2GA+oLx5brKhrp6dl/tzZj1ZUW97kZGs1KFDBDAnolambsUvBS4onwhnfW8YyV3qC8bUyUSVHHQiK5LXYSnQygs5Zeb+p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SieaC4nr; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706861789;
	bh=FXuZCdbTnTvt3fLOxA1iEZtu+D4augzBlua9BOnW8gA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SieaC4nr1uBh/9hdSqc2QKcCejdq0LofEo4CFU7ZWAGfHk01G4F9DQGV5huEiGk3Q
	 7A/0Ui1fXdhsTWOIeqyIm3M/8WI5+UK/U9t7ZdOF4UXhTWOa3K1AUnq5GBJ/cRf58T
	 k6vptQaOFLqpIXAWh++DAjkMvv1MAeYniuZtfYs1UuWFHLcx4kk49odkUgFYyP2mJW
	 922kaBWSmPxrvILn3Genr0kIrdbgr4ctcJgrEP80XfIhZ1O6fxjUcwuC+/zj+azhpD
	 dVs7rtuy3Uxzrx6S5iYN/iMlDVSXOE0pl/R1Vdp82GoJ3P7swzMjUYCEYrd/sw0wgR
	 KVGNguNCCSfyw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 59B9C3782078;
	Fri,  2 Feb 2024 08:16:29 +0000 (UTC)
Date: Fri, 2 Feb 2024 09:16:28 +0100
From: Sebastian Fricke <sebastian.fricke@collabora.com>
To: "jackson.lee" <jackson.lee@chipsnmedia.com>
Cc: mchehab@kernel.org, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, lafley.kim@chipsnmedia.com,
	b-brnich@ti.com, hverkuil@xs4all.nl, nas.chung@chipsnmedia.com
Subject: Re: [PATCH v1 0/5] wave5 codec driver
Message-ID: <20240202081628.bgadpzrgnl3cku3p@basti-XPS-13-9310>
References: <20240202070352.14307-1-jackson.lee@chipsnmedia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20240202070352.14307-1-jackson.lee@chipsnmedia.com>

Hey Jackson,

thanks for sending the patches!

I would advise to not send the next version of a patch series with
multiple patches too quickly. So far the patches only got a single very
minor review comment and others might already work on a deeper review
and test. There is no hard rule but I would say give such a series at
least a week or two to gather some review comments before sending the
next version, as it is always a bit of hassle to adjust to a new
version and you don't want to spam the mailing list.
Should you not receive any more review comments, then please go ahead
and ping some relevant people (Hans Verkuil, people from Collabora that
developed the patches, etc.) to review, either per mail or per IRC on
the OFTC server on the channel #linux-media.

Greetings,
Sebastian

On 02.02.2024 16:03, jackson.lee wrote:
>The wave5 codec driver is a stateful encoder/decoder.
>The following patches is for supporting yuv422 inpuy format, supporting
>runtime suspend/resume feature and extra things.
>
>Change since v0:
>=================
>The DEFAULT_SRC_SIZE macro was defined using multiple lines,
>To make a simple define, tab and multiple lines has been removed,
>The macro is defined using one line.
>
>
>jackson.lee (5):
>  wave5 : Support yuv422 input format for encoder.
>  wave5: Support to prepend sps/pps to IDR frame.
>  wave5 : Support runtime suspend/resume.
>  wave5: Use the bitstream buffer size from host.
>  wave5 : Fixed the wrong buffer size formula.
>
> .../platform/chips-media/wave5/wave5-hw.c     |  11 +-
> .../chips-media/wave5/wave5-vpu-dec.c         |  86 +++++-----
> .../chips-media/wave5/wave5-vpu-enc.c         | 157 +++++++++++++++---
> .../platform/chips-media/wave5/wave5-vpu.c    |  68 ++++++++
> .../platform/chips-media/wave5/wave5-vpuapi.c |   7 +
> .../platform/chips-media/wave5/wave5-vpuapi.h |   1 +
> .../media/platform/chips-media/wave5/wave5.h  |   3 +
> 7 files changed, 253 insertions(+), 80 deletions(-)
>
>-- 
>2.43.0
>
>


Return-Path: <linux-kernel+bounces-57871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D74884DE6A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD8D1F21F0B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC02A56B6A;
	Thu,  8 Feb 2024 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="idwWE5Wt"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9661DFCE;
	Thu,  8 Feb 2024 10:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707388568; cv=none; b=KPUI0eeiqlew9JJMrnGUJU66NeWzhuLaqHpBsDnnS1no7Jb4X5ErrPkhPfQNcH97dyvcroempNULNrqFcAx2kShkdinss8jgn4mUQ7zJIi0RxtNutqq3CB7F1Zqb+FDGP+JUn2E03fLyGXOfKap7JS+brDl2KSbMVCkRFBrbvaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707388568; c=relaxed/simple;
	bh=0zNRXF4ORDisC/Kb4dNM9tOYTW/WUJ5hS2ia3vIjIlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmQIZRcBa9QUxQec2qJxY+JtCpah2sAQ5i5wo4agYhzYu2O9FVNo/L9mc/E7zhXNmi52+7eGvEL9Up+xoLRYM+DfokWti9xAlZZ5iyg+uBoo+Zbi7ZeVzLn5VTzIUPOqw4OllOxoch1ado9NWwIl26QIuSCtZstvX1vYAcj9nZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=idwWE5Wt; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707388564;
	bh=0zNRXF4ORDisC/Kb4dNM9tOYTW/WUJ5hS2ia3vIjIlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=idwWE5WtYmYgXTKLjEZvSDEqRvpwz7lGhOsDQ0QGI5H/q3KXfTTjW7fDvfAqUgLYP
	 Rv5GqSJ1kjBSyDcU9ae9hrB9ur2m+jwtW/O8lywICCXxpWBsoa9iH3LYphNzHFh2jz
	 +bVNSJHzM8GBALLauuNwAKBgoPOyvMNcHP6167FcevXaDdCn3G89eodkwg6ocdM/y8
	 gwVSK3W38QnLwt+tQr0cRJYxtJ5GqO2p8mc+JmtvFg/kbeJJC4R+u3XY41fZSlbheD
	 qPsrgG4CB11CC/izWa80apElV6jPO8JDK6e+kWWNaGSU4fBV8GRngSbRwohBYRNtja
	 2PF3Zs4PCUxXg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D5210378134F;
	Thu,  8 Feb 2024 10:36:03 +0000 (UTC)
Date: Thu, 8 Feb 2024 11:36:02 +0100
From: Sebastian Fricke <sebastian.fricke@collabora.com>
To: "jackson.lee" <jackson.lee@chipsnmedia.com>
Cc: mchehab@kernel.org, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, nas.chung@chipsnmedia.com,
	lafley.kim@chipsnmedia.com, b-brnich@ti.com
Subject: Re: [RESEND PATCH v0 0/5] wave5 codec driver
Message-ID: <20240208103602.bnkhvoy5jnzns44i@basti-XPS-13-9310>
References: <20240131013046.15687-1-jackson.lee@chipsnmedia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20240131013046.15687-1-jackson.lee@chipsnmedia.com>

Hey Jackson,

On 31.01.2024 10:30, jackson.lee wrote:
>The wave5 codec driver is a stateful encoder/decoder.

You don't have to re introduce the driver here.

>The following patches is for supporting yuv422 inpuy format, supporting
>runtime suspend/resume feature and extra things.

Could you provide some test scores in your next patch version?
Interesting would be your score on V4L2-compliance and also the fluster
score for the decoder.

Greetings,
Sebastian
>
>jackson.lee (5):
>  wave5 : Support yuv422 input format for encoder.
>  wave5: Support to prepend sps/pps to IDR frame.
>  wave5 : Support runtime suspend/resume.
>  wave5: Use the bitstream buffer size from host.
>  wave5 : Fixed the wrong buffer size formula.
>
> .../platform/chips-media/wave5/wave5-hw.c     |  11 +-
> .../chips-media/wave5/wave5-vpu-dec.c         |  86 ++++------
> .../chips-media/wave5/wave5-vpu-enc.c         | 159 +++++++++++++++---
> .../platform/chips-media/wave5/wave5-vpu.c    |  68 ++++++++
> .../platform/chips-media/wave5/wave5-vpuapi.c |   7 +
> .../platform/chips-media/wave5/wave5-vpuapi.h |   1 +
> .../media/platform/chips-media/wave5/wave5.h  |   3 +
> 7 files changed, 255 insertions(+), 80 deletions(-)
>
>-- 
>2.43.0
>
>


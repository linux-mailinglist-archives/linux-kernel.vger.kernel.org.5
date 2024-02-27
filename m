Return-Path: <linux-kernel+bounces-84242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CB686A41C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D5B3B23A4F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CADC22338;
	Wed, 28 Feb 2024 00:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="rHh4bTQi";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="u4s7fxyU"
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AB456751;
	Wed, 28 Feb 2024 00:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078415; cv=none; b=Udn4+W4t8kwWRBrXqCFZaUgU6wN56sE75Wrpa5NZQDY/Xger4w7eNiJLh2rBZ6MV6Wem1962lk5vizJUljrANhWir6CIFq0fre0H8S0XdKv+NG1beTbNeX33a3+x6yYaEfBCLx1T9N7aNbVth+zB0ERzaHU+oA2oVV6AVrVoTbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078415; c=relaxed/simple;
	bh=XMvSEHgj6FQQX4NJYV38kUge5WnC01AhhZdR4QqmNxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JL9/1IIP/jUA3CrmJirR6WEPZpZF4rUoh21t+1OC9F+5rP49gMoijD7ZnGYP8X8CwPK/9bH2TaaGfttFpkJWx+2OYLHnkud1ZR7b+LTHl2BzI379epbS5eHYFeUQFEauct2H9o0y90vpBn/gE2g0c8SnJTw79Ivnja5nEsZeZBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=rHh4bTQi; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=u4s7fxyU; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id CD1FEC023; Wed, 28 Feb 2024 01:00:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1709078403; bh=oCAghHCq7o9/mLKl8vCyRB9FOEm/PiJ08Ap1ZVGb68I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rHh4bTQiCzBMFvXnVLp6OtOhZIoMihbGmxJBh+BS5m8sC/LE6XNXVoAhXXPp0St3Y
	 YgEAzOHRQdTsAXvQm83At5wLADiPIOi/9dAgFwSGmx7TZ/Ut/hnH74tVkl7R5RWe0c
	 ODGuMBqc4v1yy6g8FtO1AYjmy04QcV61iKu8Pp4elXZCzHSbkbgu6XeaJH19BpQ5h3
	 5GgbWt6DjbBhEQXuFX0I9Pf2EdByJNsTm3ZuDR10e1WSdH5eGHTqlg1yb9qYWuuG4B
	 Lb3QptenCLXoW3gsCuTLlYu8dAVlF+pBWhJ/Qloe4ycJrWY2i9UVtb57HtY67GjtWV
	 lQMJfH631hG0w==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 1A12FC009;
	Wed, 28 Feb 2024 00:59:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1709078402; bh=oCAghHCq7o9/mLKl8vCyRB9FOEm/PiJ08Ap1ZVGb68I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u4s7fxyUSwVq1NFrwlLciyYj/9RaHErzURUU7S/vphtyffEPZSA4WLxfeWelC8OX8
	 pUQOjLP4KYQKDY/RFlHG/t+N9MuqrpGvV4zkybPrfZE8XlAJnrv2gQMoejBlVItUCs
	 VSYGckN6TQ1l77pg4MzwSIIAEtArx6Q/Sf1W2gnyIWZ5XuT5wFapdHrnkoJmpZDoFn
	 3wuJED/8VJU4hkrxDNXqoLHAGrKYMU5yhW4bGajc8AR1APHafikzaonU05arqQHWmp
	 TLc5A2gLUVs3i6izt/DYDQt0i8dM8RgSW7sHLM5iBb3s9/ZSUWOdGR9iSwDFYSqu4d
	 runJGul2yVivQ==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 9661d174;
	Tue, 27 Feb 2024 23:59:51 +0000 (UTC)
Date: Wed, 28 Feb 2024 08:59:36 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 5.10 000/122] 5.10.211-rc1 review
Message-ID: <Zd53aNc1aFrCYxFd@codewreck.org>
References: <20240227131558.694096204@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240227131558.694096204@linuxfoundation.org>

Greg Kroah-Hartman wrote on Tue, Feb 27, 2024 at 02:26:01PM +0100:
> Kees Cook <keescook@chromium.org>
>     net: dev: Convert sa_data to flexible array in struct sockaddr
> (ca13c2b1e9e4b5d982c2f1e75f28b1586e5c0f7f in this tree,
> b5f0de6df6dce8d641ef58ef7012f3304dffb9a1 upstream)

This commit breaks build of some 3rd party wireless module we use here
(because sizeof(sa->sa_data) no longer works and needs to use
sa_data_min)
With that said I guess it really is a dependency on the arp_req_get
overflow, so probably necessary evil, and I don't think we explicitly
pretend to preserve APIs for 3rd party modules so this is probably
fine... The new warnings that poped up (and were reported in other
messages) a probably worth checking though.


That aside no particular problem actually running this, so--
Tested 5d69d611e74d ("Linux 5.10.211-rc1") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

-- 
Dominique Martinet | Asmadeus


Return-Path: <linux-kernel+bounces-105543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B9387DFEF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 21:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01CCD1C20D66
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86170200DB;
	Sun, 17 Mar 2024 20:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="LSsc4gL0"
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5125B1EF0D
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 20:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710706129; cv=none; b=Ck5RKvW0h3S1RmGlQ9WUanyzgPyriFXbLH/eTxn3G8mPBaeW0e5gxMbhMuPjaoJVqNeW3geUnwux+SehuyXDiuPCu/562buJJsuTEKDqtrF0dbYQX2KXMkG640JuIHzxh0h2nYQunhu4v4B/KJgTYCcqy8GXB01uMiq/OdKLluE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710706129; c=relaxed/simple;
	bh=e1fAaQ1BnGo0n5TgxuvIOkjN1kKDYARzhfblmTAoYr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lp/dAxrQrVcCvP4GgOVLlm9dPQ+aIq1uuyDUNAMwgW4YoylXCx4rer2nwHBbCTjnFYIVtx+Igmbrlekn0UvtKy75zTTcF/pAEShv7t3wipJVS5hVfvbwg7ODLkvpRVQkMi2wNcwAS3k1cDaJPX68Gvf0KJ2zTPgDxVipi/pDkb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=LSsc4gL0; arc=none smtp.client-ip=35.89.44.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id lrFKrYGlwDI6flwmmrQ91n; Sun, 17 Mar 2024 20:07:12 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id lwmjr3IfZeZE3lwmjrUEjk; Sun, 17 Mar 2024 20:07:09 +0000
X-Authority-Analysis: v=2.4 cv=INcECBvG c=1 sm=1 tr=0 ts=65f74d6d
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=UtBFqMlDG83dypD0sxEoAQ==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10
 a=fZdvlV4EY4FlDATLirAA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=e1fAaQ1BnGo0n5TgxuvIOkjN1kKDYARzhfblmTAoYr8=; b=LSsc4gL0gwHtAPiIOgy3QVhhBj
	V7JLeP72AEugq+dHJ2Cc8br4ROlHOEh5M8DGtttdN6JVt1iRbobx11Phhv9TvpT47BGG0dcM920wj
	TGoNoFEovgExAgkNOdrro7ExI/L98xr3k3hoNv88KtOIDeErKDT5FdyIUaldEJaotBkjHW5kvJA7c
	Rf4D0JdTJzpWGqFLeTGteqFjfsSImRaExP8gwiJeuNmUdBWOlIV15rPLZX7v4N0vMzYk5q/qBRBly
	6o0Qu7SR9HH0iVD6Dcwa7VjQuP34re33CD3BXpkPhRhr4R06TaeweNaNz5i9sC46fN2Vsr8VMwzWF
	Na1VnW4A==;
Received: from [201.172.174.229] (port=50598 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rlwmi-004BoJ-2I;
	Sun, 17 Mar 2024 15:07:08 -0500
Message-ID: <264f7b4c-d711-4f47-9297-79a9ab60999c@embeddedor.com>
Date: Sun, 17 Mar 2024 14:07:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mwl8k: Avoid overlapping composite structs that contain
 flex-arrays
Content-Language: en-US
To: Erick Archer <erick.archer@gmx.com>
Cc: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
 Kees Cook <keescook@chromium.org>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240316150712.4633-1-erick.archer@gmx.com>
 <cfc4c4c0-83f8-437c-8146-6b86968db67b@embeddedor.com>
 <20240317152225.GA2850@titan>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240317152225.GA2850@titan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.174.229
X-Source-L: No
X-Exim-ID: 1rlwmi-004BoJ-2I
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.174.229]:50598
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfM/0ozP1FQgOj1YtRUsWr3Gr5jJdpbEYmX366HWEWxdIzZIPrUWhDAcUykKLJr3sCOR7GYy/zgn87hDBoHSOylnXjWJuehh4mrw7cLTqOB1HuqwSEEO7
 uNTnVTKuxBhg6LyI2amh4Zsxl4EwyHRqyTJZIynWL01wmPRmX+nHobz4BWexYLx340caKLQuyMm7mVJ6FdDL5ejrej7BoQStuJPRu2RKboH4iNyMtVE1XqdI


> So, are you working in a patch for the "mwl8k"? Or do you prefer
> a v2 of this patch based on your proposal?

I'm working on multiple different patches to address the whole thing
across the kernel.

I think it's wise for you to wait and see how those patches are received.
Once the best approach to fix these issues becomes clear and widely accepted,
it will be easier for you to join us and help address the rest. Meanwhile,
we want to avoid any possible overlap or stepping on each other's toes.

Thanks
--
Gustavo


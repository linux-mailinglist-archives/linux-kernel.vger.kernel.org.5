Return-Path: <linux-kernel+bounces-127691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77C0894F88
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601A62828FC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30805914E;
	Tue,  2 Apr 2024 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fGRRghoq"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD2F57876;
	Tue,  2 Apr 2024 10:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052433; cv=none; b=rg16DFbYsakceXX8h+Y5YaRSJF+gnqbpRJK5aEmGoORU2cDn2iyy9E+LFaKkovAIatVOZgDxOFmftWlKTUOIoO5S+c/iMZi3CcaMP4yLyoY/915hgWKScND3r9I1xYZYYQiWPV5cMHROtpE6Q4hgFW+PwLGttRNfxkluUU4NRrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052433; c=relaxed/simple;
	bh=k7uSL7rD78kbpZ93B360CvxyeepNDwKB6sm5+q46zMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C+fL5vbUpx+fyhOv0uAV+AmRRezUhVKDiQ3c4hBkCFEq0EGgDXS2+yC1SdGJslI5XFWGTzzbtoZ2uaZCYMHc8ESmwIFa3CY/fiRzpky1NCIdXu/YmeUUsWVPxzNG1nkgW95H/lzJ21pWyRsN158eXMaWJxCQkWq7zezvxmUsYnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fGRRghoq; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712052429;
	bh=k7uSL7rD78kbpZ93B360CvxyeepNDwKB6sm5+q46zMQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=fGRRghoqSOpQK/+xrlyxkH/kM1jDxzL7k7wClqL2MjXLGF274xgbCPBesHeXAosO5
	 LKkEyvrhEUS4eQmUqljuDSBssqFfPvsWErgLPnWPWLUSy9u1eoxwEc4DL+pmpRo7ID
	 ia5X8vO2ywsjwwBr/y/5fEiDq8QwEmcXjrrb11fArXTy2XKwfFrjhO2+q9ZDLHdAb0
	 Y+g0uxW8qe0+5AgiOlu7h3j42GOfGfsD78/k1JFTN3mxZ4Z6GFymlbnNexxokWZARW
	 aBuUJ3EqqbDUElPE5D7hfDynueLgpxhy31x++AVpd4yLiVVS4WFJX0MyNC5jUzAfza
	 6PQqWKnblowWg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2B13737820EF;
	Tue,  2 Apr 2024 10:07:09 +0000 (UTC)
Message-ID: <ccf74cbb-a487-4392-9b2e-35c0d007ba79@collabora.com>
Date: Tue, 2 Apr 2024 12:07:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: mediatek: scpsys: drop driver owner assignment
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240330211036.100956-1-krzysztof.kozlowski@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240330211036.100956-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/03/24 22:10, Krzysztof Kozlowski ha scritto:
> Core in platform_driver_register() already sets the .owner, so driver
> does not need to.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>




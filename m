Return-Path: <linux-kernel+bounces-70790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7455C859C6B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B6E1C213D2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E6520320;
	Mon, 19 Feb 2024 06:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qX1ee+f2"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF7C20315
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708325793; cv=none; b=W9KF5P/67iBXkpArubIlhmi3Bkr85HQc93C+o7Q2yr2fLTEFwq1Cu+26jROP0HwocMwogmpfShcfJuQtVELONnsdAoTmMAqlN3fNHEUoaJFxa2uXEDBN4gBVvM3zKIUySdaM5abj9gCHd38foWd0KDOmZGL7H6LyZOOhnjHkEZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708325793; c=relaxed/simple;
	bh=Qe1lR2pJ1INXCADwt8seUCxS+XU+jomfwLz/t49KiWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DqsJ+uf/pGrCl9FsDVT5c+kOHCk3qfniqiWzvCVDqBYJwy1mhZBL4lvNLn0AQVVvCrdVT2tqhXUSYrZP7AdEHN/tWRVJNBvvIT9p1XhBkYwF5erePJ20a4TVQcX73CHwkDhL3vxv/3Fg4wLa5ARaCKD9kAbA8i7l2XwgclDXt/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qX1ee+f2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708325789;
	bh=Qe1lR2pJ1INXCADwt8seUCxS+XU+jomfwLz/t49KiWM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qX1ee+f2T5UsVk6fyRxRVcRU9pczuy2aob0XMxJp87kjT0Wy/HH6SqPcwMyznqVB+
	 4iZteQU+qBoJqI6EBl7VanhHUB5VdnfSD589BnOXUwde2cfvw+NTg9hFYa0APko5d9
	 5/qQxJ+lfU0PBKthFPULy8FkqJH2nKk1hCZpbIHG28CA/xHE1WAqNzOzBdwEOg/O1x
	 wHIct33rL3R+vjO98r9T1eU3ojwKdCOjbmNZRyUpxfrNaXqaCMTdFyZLc3W9LLbvmt
	 WylfiAYNmdgQSEwjVUW5JIQF6s/s4xo8bIkF7gMd/cNQbkPOAVyPES/52cgmgh1SfM
	 L87IsJ2H3mtlg==
Received: from [100.66.96.193] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id ECBBE3780BFE;
	Mon, 19 Feb 2024 06:56:25 +0000 (UTC)
Message-ID: <b835f964-d224-b240-4c21-bc2140b43e9c@collabora.com>
Date: Mon, 19 Feb 2024 12:26:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] drm/ci: add tests on vkms
Content-Language: en-US
To: =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>,
 dri-devel@lists.freedesktop.org
Cc: airlied@gmail.com, daniel@ffwll.ch, rodrigosiqueiramelo@gmail.com,
 melissa.srw@gmail.com, hamohammed.sa@gmail.com, robdclark@gmail.com,
 daniels@collabora.com, helen.koike@collabora.com,
 david.heidelberg@collabora.com, guilherme.gallo@collabora.com,
 sergi.blanch.torne@collabora.com, linux-kernel@vger.kernel.org
References: <20240201065346.801038-1-vignesh.raman@collabora.com>
 <792d46b8-675a-4f5b-8db9-1c3dfa66bb92@igalia.com>
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <792d46b8-675a-4f5b-8db9-1c3dfa66bb92@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Maíra,

On 10/02/24 23:53, Maíra Canal wrote:
> Hi Vignesh,
> 
> On 2/1/24 03:53, Vignesh Raman wrote:
>> Add job that runs igt on top of vkms.
>>
>> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
>> Acked-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>> Tested-by: Jessica Zhang <quic_jesszhan@quicinc.com>
>> Acked-by: Maxime Ripard <mripard@kernel.org>
>> Signed-off-by: Helen Koike <helen.koike@collabora.com>
>> ---
>>
>> v2:
>> - do not mv modules to /lib/modules in the job definition, leave it to
>>    crosvm-runner.sh
>>
>> v3:
>> - Enable CONFIG_DRM_VKMS in x86_64.config and update xfails
>>
>> v3:
>> - Build vkms as module and test with latest IGT.
>>    This patch depends on 
>> https://lore.kernel.org/dri-devel/20240130150340.687871-1-vignesh.raman@collabora.com/
> 
> Considering that this patch depends on that series, I believe you
> could include this patch as part of that series. It will be easier for
> us to review and land it.
> 
> Thanks for all the great work with the CI!

Sure. Will add this patch as part of that series. Thank you.

Regards,
Vignesh


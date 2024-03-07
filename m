Return-Path: <linux-kernel+bounces-95459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A24E8874DE1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42519B23284
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FCE129A79;
	Thu,  7 Mar 2024 11:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="OWeKb9op"
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185B384FC8
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 11:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811861; cv=none; b=vDwymm/8OGftETfh8nCsX6vt3e9Jp2mUP9uRdDW3ZcuX5DG2Hv/8lEvDMdMaBDnnLC/K1+qXcKq99A5ZgG3TXxm4EzET6u+GVIVd1XYagfJNxQeeMXWp/IlaXZ6hdCGdLn7tgDguGJMpDMgQTN3oeTw14Q0lBCVngdM9WG94XMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811861; c=relaxed/simple;
	bh=D625r6cfP0p1lb5l+YhbA6ASW/Qc6RMFoEYDsOtbUSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WTflFhZMGFHbHN1hDyzOquOSJ4/fvXGY4ZYlZUY9Po8gu41ei0g0MDcqFDG1Anb7TgerBlKemdV4Nqyi41/WoeJIRUneNdTyqFH7KFYMteWClLpZhGVu1nFb+anVMud4DXeEiagtUVC39BWS1JwhGmK63eaiQLg547mjdIv8dQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=OWeKb9op; arc=none smtp.client-ip=198.252.153.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4Tr6sH0tx7z9twc;
	Thu,  7 Mar 2024 11:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1709811859; bh=D625r6cfP0p1lb5l+YhbA6ASW/Qc6RMFoEYDsOtbUSs=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=OWeKb9opJ4m1eMCQv3QAzacCPMsyQRaJMyAmMBDlqB52BXbNZfiozMtPWxncsmD+b
	 NlTsa5/yhxTDUhxZwq8XCmW0iSK8hFQGJBnvgV8wgeTWU0sCWDMNSP3XpFFc1sEjoJ
	 bL8k70mZ8oaFiwI5p4JmYV5Y6AGOZgT8WevDRUXU=
X-Riseup-User-ID: E37B07F314684546F80F69AA524124761C502CB8EE3BD3046F66BEACB7AD38CC
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4Tr6ry01HMzFtJD;
	Thu,  7 Mar 2024 11:44:01 +0000 (UTC)
Message-ID: <86e6f025-150d-4f02-b405-ebfcd4771aa3@riseup.net>
Date: Thu, 7 Mar 2024 08:43:21 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 4/7] drm/vkms: Fix compilation issues
Content-Language: en-US
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mairacanal@riseup.net>, Haneen Mohammed <hamohammed.sa@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 pekka.paalanen@haloniitty.fi, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com
References: <20240306-louis-vkms-conv-v1-0-5bfe7d129fdd@riseup.net>
 <20240306-louis-vkms-conv-v1-4-5bfe7d129fdd@riseup.net>
 <ZekEVT_HNmZbFWNG@localhost.localdomain>
From: Arthur Grillo <arthurgrillo@riseup.net>
In-Reply-To: <ZekEVT_HNmZbFWNG@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 06/03/24 21:03, Louis Chauvet wrote:
> Le 06/03/24 - 17:03, Arthur Grillo a écrit :
>> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
>> ---
>>  drivers/gpu/drm/vkms/tests/vkms_format_test.c | 2 +-
>>  drivers/gpu/drm/vkms/vkms_drv.h               | 4 ++++
>>  2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/vkms/tests/vkms_format_test.c b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
>> index 4636b013602f..3522ecee960f 100644
>> --- a/drivers/gpu/drm/vkms/tests/vkms_format_test.c
>> +++ b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
>> @@ -113,7 +113,7 @@ static void vkms_format_test_yuv_u8_to_argb_u16(struct kunit *test)
>>  	for (size_t i = 0; i < param->n_colors; i++) {
>>  		const struct format_pair *color = &param->colors[i];
>>  
>> -		const struct conversion_matrix *matrix = get_conversion_matrix_to_argb_u16
>> +		struct conversion_matrix *matrix = get_conversion_matrix_to_argb_u16
>>  			(DRM_FORMAT_NV12, param->encoding, param->range);
>>  
>>  		argb = argb_u16_from_yuv888(color->yuv.y, color->yuv.u, color->yuv.v, matrix);
>> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
>> index 393b76e7c694..3d62578499ab 100644
>> --- a/drivers/gpu/drm/vkms/vkms_drv.h
>> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
>> @@ -47,6 +47,10 @@ struct pixel_argb_u16 {
>>  	u16 a, r, g, b;
>>  };
>>  
>> +struct pixel_yuv_u8 {
>> +	u8 y, u, v;
>> +};
> 
> Can I move this structure in the test itself? As discussed with Pekka, I 
> think it's not a good idea to have such specific `pixel_{fmt}_{size}` for 
> each variant. Leaving it in vkms_drv.h give the idea of "for each new kind 
> of format we have to create a new structure".

Sure, it makes more sense.

Best Regards,
~Arthur Grillo

> 
>> +
>>  struct line_buffer {
>>  	size_t n_pixels;
>>  	struct pixel_argb_u16 *pixels;
>>
>> -- 
>> 2.43.0
>>
> 


Return-Path: <linux-kernel+bounces-110253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBE6885C22
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96FD1C2198D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD82C86628;
	Thu, 21 Mar 2024 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E3s41Xaa"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29D88624C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035242; cv=none; b=cyMCl8rCn753rAP/ux7+UMPBEFLG98XTzWbvdrlrMSxDGoiLMZ7QcYG4nk1Xli7PsjyCkppqSMcoFrKJ8F0lDGF7OeN4EYvwCEc6WQqYTWpRd0yYuWxzGHDd3ke11jAYXMS0UWaAUL5cghe6aadHLQhdvO4knVcChyrlG2NJXzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035242; c=relaxed/simple;
	bh=11R+SzgEQ+nRo4cF+wHX4BeHS/CSRZ/WfDarIFy1ZWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5LTnTXgu4hlQewBjBRoOZSdPYP9aNxRSLWj3y9M/BIelOtoZTH8an1LKecgiLOSagrqBHctIfA+DXUtqpRXX27mE3TEfZdDfqaTsp+NAeBQH7hW+gbKBCh8AU3W5JlH/bhJhwDFgII8uSV4Hq6VRL7VMtDT3YgiOuuMJ9U0nT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E3s41Xaa; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2c38ac1c-cc0e-43b3-86d3-5b6a2f00f9e7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711035238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XcnhGHIAXVuRsv4I7TSZ/EDA+Yw6Y/dChRxdQ571Ims=;
	b=E3s41Xaaumg9Q3b3HHjrJAk+X6nZFsmGTFFJijUT4my3g35hQDUK4Dy6V6Uv+DSeQJ2nlM
	g/Fe36s3KsD2tF4r2fe/ROT2RF/Y0xqsdijJZo6Wm/ozQKbzJK8+yrCmC0EJI/4Y00gWGa
	/NUb+IB+brWq0eM+xTZqXw5VovE6+kI=
Date: Thu, 21 Mar 2024 11:33:52 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/8] drm: xlnx: Fix kerneldoc
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Michal Simek <michal.simek@amd.com>, David Airlie <airlied@gmail.com>,
 linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 linux-arm-kernel@lists.infradead.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
References: <20240319225122.3048400-1-sean.anderson@linux.dev>
 <20240319225122.3048400-2-sean.anderson@linux.dev>
 <e2eba421-cba1-4dd5-837c-6be5f07ed402@ideasonboard.com>
 <d4072aa1-47e4-45d3-9e04-2cd9d782b593@infradead.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <d4072aa1-47e4-45d3-9e04-2cd9d782b593@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/20/24 02:05, Randy Dunlap wrote:
> 
> 
> On 3/19/24 22:42, Tomi Valkeinen wrote:
>> On 20/03/2024 00:51, Sean Anderson wrote:
>>> Fix a few errors in the kerneldoc. Mostly this addresses missing/renamed
>>> members.
>>>
>>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>>> ---
>>>
>>> Changes in v2:
>>> - New
>>>
>>>   drivers/gpu/drm/xlnx/zynqmp_disp.c  | 6 +++---
>>>   drivers/gpu/drm/xlnx/zynqmp_dpsub.h | 1 +
>>>   drivers/gpu/drm/xlnx/zynqmp_kms.h   | 4 ++--
>>>   3 files changed, 6 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
>>> index 407bc07cec69..f79bf3fb8110 100644
>>> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
>>> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
>>> @@ -128,9 +128,9 @@ struct zynqmp_disp_layer {
>>>    * struct zynqmp_disp - Display controller
>>>    * @dev: Device structure
>>>    * @dpsub: Display subsystem
>>> - * @blend.base: Register I/O base address for the blender
>>> - * @avbuf.base: Register I/O base address for the audio/video buffer manager
>>> - * @audio.base: Registers I/O base address for the audio mixer
>>> + * @blend: Register I/O base address for the blender
>>> + * @avbuf: Register I/O base address for the audio/video buffer manager
>>> + * @audio: Registers I/O base address for the audio mixer
>> 
>> Afaics, the kernel doc guide:
>> 
>> https://docs.kernel.org/doc-guide/kernel-doc.html#nested-structs-unions
>> 
>> says that the current version is correct. Or is the issue that while, say, 'base' is documented, 'blend' was not?
> 
> Hi,
> 
> I would do it more like so:
> 
> ---
>  drivers/gpu/drm/xlnx/zynqmp_disp.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff -- a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> @@ -128,8 +128,11 @@ struct zynqmp_disp_layer {
>   * struct zynqmp_disp - Display controller
>   * @dev: Device structure
>   * @dpsub: Display subsystem
> + * @blend: blender iomem info
>   * @blend.base: Register I/O base address for the blender
> + * @avbuf: audio/video buffer iomem info
>   * @avbuf.base: Register I/O base address for the audio/video buffer manager
> + * @audio: audio mixer iomem info
>   * @audio.base: Registers I/O base address for the audio mixer
>   * @layers: Layers (planes)
>   */
> 
> 
> but in my testing, Sean's way or my way result in no warning/errors.
> 

The specific errors are:

./drivers/gpu/drm/xlnx/zynqmp_disp.c:151: warning: Function parameter or struct member 'blend' not described in 'zynqmp_disp'
./drivers/gpu/drm/xlnx/zynqmp_disp.c:151: warning: Function parameter or struct member 'avbuf' not described in 'zynqmp_disp'
./drivers/gpu/drm/xlnx/zynqmp_disp.c:151: warning: Function parameter or struct member 'audio' not described in 'zynqmp_disp'

I don't see the need to document a single-member struct twice. Actually,
maybe it would be better to just lift the .base member to live in
zynqmp_disp. But I think that would be better in another series.

--Sean


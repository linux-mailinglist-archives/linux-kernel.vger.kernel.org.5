Return-Path: <linux-kernel+bounces-108475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78293880AFC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33AC9282F11
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0986D224C6;
	Wed, 20 Mar 2024 06:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uYZSuycr"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FA222309
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 06:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710914720; cv=none; b=uVRFwjpS55fX5wQeam6YobtmoXJ/RN0IbfnAs0Gnjcshwls33rSuun48p2EFQ8NKUvdUilU4g2fpUUhRR1Q6RcSG66rka9vlQFtSpFmE5PZhH50mj0r6tyWsdq18oUQx6Vj1yJ+xUS15F/WtKAZqTP5WD5exOlIIK11obC3kRpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710914720; c=relaxed/simple;
	bh=rAeoupFGtti/3Dvzkwv8f3C5pz+fmOK/k9qfeI9F5KQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dNEWCpt2Q059K5KF7+kMiNKxDDyl1cDpMlaSAU1Nx4mKLZcw5TNlis1yykIKCI5lQabCRMaeuW5ihR11MvOpjH41wWiG2QLgkbI3xjcCDtEaTG+42NS/8IiIbATIc5HxTArjQTjNuuiYLCQyKlcqP1Ev2hUO0LY3kxUQS+J0gac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uYZSuycr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=a0P5TIt0Qos8BCXptSUzVUPMQQILLLRWlv1q937+UBw=; b=uYZSuycr4Wa58UZ4VTstiJx2ef
	g63HNwxpSn1M2h3gPOt45Gg3bIwWAV7eeSjyUIqnnYsQl4XWPM5CBYMikreSH+CqyyruNy+eFAFhQ
	/FlMCjg6Cb9DtdMGmWkSIGls4YCicYq68eKaLLEsEobjldb2LVcqQPiNyZdcQA8iqAe4yE1VGlOHo
	T6EsAfLyV7P7Yku/0l8Q0LGw/6QTsWSSFkF9wz0N/gt36dWOzD+8g8AAQvpSIZahxC5V8CJKTI4JO
	gEwg9lbSIrNXxb4Ot/JioOP19f05u6eoTm5yFflvMoRDY+7mPbk6Kncm/92Lyi3IY2CiUyQSE8Bjy
	FDLTxhXA==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmp4c-0000000Fbdo-1xoi;
	Wed, 20 Mar 2024 06:05:14 +0000
Message-ID: <d4072aa1-47e4-45d3-9e04-2cd9d782b593@infradead.org>
Date: Tue, 19 Mar 2024 23:05:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] drm: xlnx: Fix kerneldoc
Content-Language: en-US
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Sean Anderson <sean.anderson@linux.dev>
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
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <e2eba421-cba1-4dd5-837c-6be5f07ed402@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/19/24 22:42, Tomi Valkeinen wrote:
> On 20/03/2024 00:51, Sean Anderson wrote:
>> Fix a few errors in the kerneldoc. Mostly this addresses missing/renamed
>> members.
>>
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>> ---
>>
>> Changes in v2:
>> - New
>>
>>   drivers/gpu/drm/xlnx/zynqmp_disp.c  | 6 +++---
>>   drivers/gpu/drm/xlnx/zynqmp_dpsub.h | 1 +
>>   drivers/gpu/drm/xlnx/zynqmp_kms.h   | 4 ++--
>>   3 files changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
>> index 407bc07cec69..f79bf3fb8110 100644
>> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
>> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
>> @@ -128,9 +128,9 @@ struct zynqmp_disp_layer {
>>    * struct zynqmp_disp - Display controller
>>    * @dev: Device structure
>>    * @dpsub: Display subsystem
>> - * @blend.base: Register I/O base address for the blender
>> - * @avbuf.base: Register I/O base address for the audio/video buffer manager
>> - * @audio.base: Registers I/O base address for the audio mixer
>> + * @blend: Register I/O base address for the blender
>> + * @avbuf: Register I/O base address for the audio/video buffer manager
>> + * @audio: Registers I/O base address for the audio mixer
> 
> Afaics, the kernel doc guide:
> 
> https://docs.kernel.org/doc-guide/kernel-doc.html#nested-structs-unions
> 
> says that the current version is correct. Or is the issue that while, say, 'base' is documented, 'blend' was not?

Hi,

I would do it more like so:

---
 drivers/gpu/drm/xlnx/zynqmp_disp.c |    3 +++
 1 file changed, 3 insertions(+)

diff -- a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -128,8 +128,11 @@ struct zynqmp_disp_layer {
  * struct zynqmp_disp - Display controller
  * @dev: Device structure
  * @dpsub: Display subsystem
+ * @blend: blender iomem info
  * @blend.base: Register I/O base address for the blender
+ * @avbuf: audio/video buffer iomem info
  * @avbuf.base: Register I/O base address for the audio/video buffer manager
+ * @audio: audio mixer iomem info
  * @audio.base: Registers I/O base address for the audio mixer
  * @layers: Layers (planes)
  */


but in my testing, Sean's way or my way result in no warning/errors.

-- 
#Randy


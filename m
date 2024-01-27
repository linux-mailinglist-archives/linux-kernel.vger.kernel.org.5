Return-Path: <linux-kernel+bounces-40971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4E483E923
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 02:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32641C209B1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB0DB66C;
	Sat, 27 Jan 2024 01:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1bMYiW8P"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFDC8C14;
	Sat, 27 Jan 2024 01:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706320277; cv=none; b=J/2RrfqIRhXs5ybmCthzze6ZDqJ/cKAjennNnK0hrv2CWBX0X4a6v4uWA6R/14D7SoZBT/5mnbtqMgdwKARRhNhDRt0NE9+5pdqnZfTgRGu3+mD5Xxr5zzB6Lf4naCWzfnA8ZSoLjIkta6LuSp9SBXBRIK+AbrZegv6FQXwtOnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706320277; c=relaxed/simple;
	bh=KZpDU/PEAGyFwGtY9AhJRKxcH3CF40SmBvZ9Xq2HTvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kmPxyjYstJb9ncLIY444V4NRq6yUeby3OZH2P1wjqxzRsAxoSxWmBMobEp3YHsI0gGF7QEQZyW1rmzgELMpf890QHdZIeOuUUJ9vz/R8Qh3E6xTzzaSv2wsiAuFBZVpE2Ode3Owh++eeK6oLv+WWpcvUgBVZ6z6hqaBI5IbJXz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1bMYiW8P; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=lxYFxs/8WK1pTjOIC0n7A2x231owOnOSLs3pwAFP9f4=; b=1bMYiW8PDwIA/3MpD5Mm8+w+B0
	4HPN+fwJNQjcSaprS2W8q9+6vfk42Gb3sTsDNQ+pIabWuHzsqkf+98E96uvPutlmyddM+L/2qoMbC
	NRpDaTwop0LKEeGTwntNwgBk2rSDpH2wGpjGjYhAlFzIEgmQ21ZJa+5nkOMlGFvsiJq+zMPrV7tBY
	04hs3cdz9Xv5yNANmbKaCgEp4k5ZFkhxSN9PADo9l2iMGgP69sPl5nOYSRfLn2zNzmqgD0vY9LY0k
	wxpO4av5GvnO5h4PVFD7WUt6tHeMBewPRm8f1NBGaTXuxJl4jvsXNNRyI01rOxD8P0/SttTdwfp9j
	bxAUHJfg==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTXqe-00000006Alx-2cQm;
	Sat, 27 Jan 2024 01:51:08 +0000
Message-ID: <e6b72dff-911e-4923-9996-b3b7db36fb8e@infradead.org>
Date: Fri, 26 Jan 2024 17:51:06 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] media: media-entity.h: Fix kerneldoc
Content-Language: en-US
To: Ricardo Ribalda <ribalda@chromium.org>,
 Tiffany Lin <tiffany.lin@mediatek.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, Hans Verkuil <hverkuil@xs4all.nl>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Bin Liu <bin.liu@mediatek.com>,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Bingbu Cao <bingbu.cao@intel.com>,
 Tianshu Qiu <tian.shu.qiu@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-amlogic@lists.infradead.org
References: <20240126-gix-mtk-warnings-v1-0-eed7865fce18@chromium.org>
 <20240126-gix-mtk-warnings-v1-3-eed7865fce18@chromium.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240126-gix-mtk-warnings-v1-3-eed7865fce18@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/26/24 15:16, Ricardo Ribalda wrote:
> The fields seems to be documented twice.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  include/media/media-entity.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/include/media/media-entity.h b/include/media/media-entity.h
> index 2b6cd343ee9e..c79176ed6299 100644
> --- a/include/media/media-entity.h
> +++ b/include/media/media-entity.h
> @@ -337,10 +337,6 @@ enum media_entity_type {
>   * @info.dev:	Contains device major and minor info.
>   * @info.dev.major: device node major, if the device is a devnode.
>   * @info.dev.minor: device node minor, if the device is a devnode.
> - * @major:	Devnode major number (zero if not applicable). Kept just
> - *		for backward compatibility.
> - * @minor:	Devnode minor number (zero if not applicable). Kept just
> - *		for backward compatibility.
>   *
>   * .. note::
>   *
> 

I'd say that this is correct based on
https://patchwork.kernel.org/project/linux-media/patch/20231223050707.14091-1-rdunlap@infradead.org/


Hans, can you please explain this message from you, on 2024-Jan-22, that I cannot find in the media patchwork:


Subject: [git:media_stage/master] media: media-entity.h: fix Excess kernel-doc description warnings



This is an automatic generated email to let you know that the following patch were queued:

Subject: media: media-entity.h: fix Excess kernel-doc description warnings
Author:  Randy Dunlap <rdunlap@infradead.org>
Date:    Fri Dec 22 21:07:07 2023 -0800

Remove the @major: and @minor: lines to prevent the kernel-doc warnings:

include/media/media-entity.h:376: warning: Excess struct member 'major' description in 'media_entity'
include/media/media-entity.h:376: warning: Excess struct member 'minor' description in 'media_entity'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 include/media/media-entity.h | 4 ----
 1 file changed, 4 deletions(-)

---

diff --git a/include/media/media-entity.h b/include/media/media-entity.h
index 2b6cd343ee9e..c79176ed6299 100644
--- a/include/media/media-entity.h
+++ b/include/media/media-entity.h
@@ -337,10 +337,6 @@ enum media_entity_type {
  * @info.dev:	Contains device major and minor info.
  * @info.dev.major: device node major, if the device is a devnode.
  * @info.dev.minor: device node minor, if the device is a devnode.
- * @major:	Devnode major number (zero if not applicable). Kept just
- *		for backward compatibility.
- * @minor:	Devnode minor number (zero if not applicable). Kept just
- *		for backward compatibility.
  *
  * .. note::
  *



Thanks.
-- 
#Randy


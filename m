Return-Path: <linux-kernel+bounces-41409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AB183F063
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FAB01F22E41
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAD31C281;
	Sat, 27 Jan 2024 22:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SQaArEZ1"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3251B7FC;
	Sat, 27 Jan 2024 22:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706392847; cv=none; b=lWvJTR2KYSf62nwmZtWFZ5g7f8rZCEhlwuTPW/Uhidnq+yBqyAfTBs/JU23OLgVGBCPvGKFnLq3NRCuZIwX1qG1bpcTnfGQNLvCaNzHEA7iwgYUEtvDZweEVPNjQH1PhGSKSxVsnqkXLqpnlu0x/D4GzjCm9Wn2mPWtW7WgWXMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706392847; c=relaxed/simple;
	bh=BH807ZEe4kzGh8q6q/wKTV9roDmT0MIWgqFOcAqr9rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cMkKhWBpUI0nnBECxjXb4nbO2ZWfVe7peogBbSLZaabLSv1j6h49WhLF6f23byWUwdVkcZKbtCRZt4VRJjarG60lNiC8333T3SfFxcGYkSM0OO//HuQjkLB5RRGXmiV40hHUUWLQKQgThaiIp3xxwi9WyuCDMxUXx+WUjV/nFMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SQaArEZ1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=UgXaJTakI/jnOXOUGRxa2gNJYjH8EmRpQFzJ2NpWJBw=; b=SQaArEZ1SrmSba/8hhmR59xxF4
	9+u+uZcTcgyKfNGWwgKkmb+s211o6z2GnjhdSlzLw5vUCsrUh/HOb+99FF0zIJ5ho2hLlF1aECAwO
	wA6wiCfGcex810HMIvfLsA8ViG6pXc4IcNFBx1pDb9XoYztJji0PbYPRL//zTTPqfwKShYKMYRJF6
	LjVni5mjGr7wdnKb+vuMnbLbHS2cALSuD/tkkK/jwCaNRfFa0S1OX+IviOY3vWV+34rx8P97HqOFW
	pu8mSt/hk1DfzMl35N85/wCnQ/fXtliiUesiPHg8Ivrjlil9YVArGxGxMx03YuJuF74OZyofMbVj1
	Eg7+extw==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTqj6-00000008FnG-0a1X;
	Sat, 27 Jan 2024 22:00:36 +0000
Message-ID: <d757c5a7-bb3c-4dd9-bac4-e43ee7685a18@infradead.org>
Date: Sat, 27 Jan 2024 14:00:34 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/17] media: i2c: css-quirk.h: Fix kerneldoc
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
 <20240126-gix-mtk-warnings-v1-6-eed7865fce18@chromium.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240126-gix-mtk-warnings-v1-6-eed7865fce18@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/26/24 15:16, Ricardo Ribalda wrote:
> Kerneldoc does not seem to understand that embed doc:
> drivers/media/i2c/ccs/ccs-quirk.h:50: warning: Excess struct member 'write' description in 'ccs_quirk'
> drivers/media/i2c/ccs/ccs-quirk.h:50: warning: Excess struct member 'reg' description in 'ccs_quirk'
> drivers/media/i2c/ccs/ccs-quirk.h:50: warning: Excess struct member 'val' description in 'ccs_quirk'
> 

Correct. It's never tried to understand that AFAIK.

> Convert into a standard doc.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/media/i2c/ccs/ccs-quirk.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/i2c/ccs/ccs-quirk.h b/drivers/media/i2c/ccs/ccs-quirk.h
> index 0b1a64958d71..392c97109617 100644
> --- a/drivers/media/i2c/ccs/ccs-quirk.h
> +++ b/drivers/media/i2c/ccs/ccs-quirk.h
> @@ -28,11 +28,11 @@ struct ccs_sensor;
>   * @reg_access: Register access quirk. The quirk may divert the access
>   *		to another register, or no register at all.
>   *
> - *		@write: Is this read (false) or write (true) access?
> - *		@reg: Pointer to the register to access
> - *		@value: Register value, set by the caller on write, or
> + *		-write: Is this read (false) or write (true) access?
> + *		-reg:   Pointer to the register to access
> + *		-val:   Register value, set by the caller on write, or
>   *			by the quirk on read
> - *		@return: 0 on success, -ENOIOCTLCMD if no register
> + *		-return: 0 on success, -ENOIOCTLCMD if no register
>   *			 access may be done by the caller (default read
>   *			 value is zero), else negative error code on error
>   * @flags: Quirk flags
> 

-- 
#Randy


Return-Path: <linux-kernel+bounces-41416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 370EE83F08C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68FBA1C2406C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1061BDFE;
	Sat, 27 Jan 2024 22:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gRZfMtd2"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA97B1D68B;
	Sat, 27 Jan 2024 22:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706393676; cv=none; b=VcD7wGsPK8/ZtMbIQZjLSNbYpCrRWlBOU85vRl29Fa6Y1lytRXQWVAg4cXgH6Dynek+e3UEiokXaJP/nAwZ24gF6MUAmZ568CWGl+j6XrK/H7aCoYWRTMh4THL44rEwcLg0GYNhoVKhJWfxx/+sHCYGY32vv6Jml5r/0aaPt4Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706393676; c=relaxed/simple;
	bh=yizRFIqENOO2daasMLXq9PLvUs357wQNRrWs11fnGp0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=L4XROYBBhm3nE2z82UltrbRwkQpsPJ2qXB0tnWQwqjcXGU9aDuhGGBvszZvVoEeOsdXEuq2vGpy5tvv03igGTe++YRkOK91RFjYfRJL+zBexFJ7rPkubfk3GJcsBWUgySo9yBguPkA8Is6WXHmXyZr8jUi1S/3qK1bFIWAigdLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gRZfMtd2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=gMoCQQl45Gbi1uEtvlYyB3A3iBkjLKBOyA0Qq2xUnPQ=; b=gRZfMtd2goco+qpRCpGi1SB815
	CunkgS3pwMd/5OoH96hCxHzoHB9/G4N8r2bgzsyZSuDCT4ooGpapaNHZ06TG6m6Ettw025LMtR95D
	d0bChLGZiNpfN+G+54+Fg6fbwSZCVZMomfFTWE1mTl7F+Yf6oEEArGH4YLLWvJSocr+beMN+67nqC
	4oDjX3vWVexvqvXq8Lzd3Sn3IVgRAeNwAPI8x+WSXoMB9ETsy/Sz1UX6D5xxun9HiTxEGUahIo52B
	RMO5C4S9R11caH20gZeT008oleM8Yy0L13vsiXjHCjARI+3QHamE9J/DLauQtWmSM06Vusy5tRFHp
	oAyiZqYQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTqwX-00000008HOd-1jF6;
	Sat, 27 Jan 2024 22:14:29 +0000
Message-ID: <39fdc99e-e9d6-4aa2-b751-f9b2bf0814cd@infradead.org>
Date: Sat, 27 Jan 2024 14:14:28 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/17] media: qcom: venus: Fix kerneldoc
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
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
 <20240126-gix-mtk-warnings-v1-11-eed7865fce18@chromium.org>
 <c8795543-c8b0-4860-8cf2-b5680ba3e5d1@infradead.org>
In-Reply-To: <c8795543-c8b0-4860-8cf2-b5680ba3e5d1@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/27/24 14:13, Randy Dunlap wrote:
> Hi,
> 
> On 1/26/24 15:16, Ricardo Ribalda wrote:
>> Remove doc for missing field.
>>
>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>> ---
>>  drivers/media/platform/qcom/venus/core.h | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
>> index 4a633261ece4..a39986ce79f1 100644
>> --- a/drivers/media/platform/qcom/venus/core.h
>> +++ b/drivers/media/platform/qcom/venus/core.h
>> @@ -428,7 +428,6 @@ enum venus_inst_modes {
>>   * @error:	an error returned during last HFI sync operation
>>   * @session_error:	a flag rised by HFI interface in case of session error
>>   * @ops:		HFI operations
>> - * @priv:	a private for HFI operations callbacks
>>   * @session_type:	the type of the session (decoder or encoder)
>>   * @hprop:	a union used as a holder by get property
>>   * @core_acquired:	the Core has been acquired
>>
> 
> I don't understand this one. I do understand the patch above, but the in the struct,
> I see:
> 
> 	unsigned long enc_codecs;
> 	unsigned long dec_codecs;
> 	unsigned int max_sessions_supported;
> 	void *priv;
> 	const struct hfi_ops *ops;
> 	struct delayed_work work;
> 
> I'm just guessing, but maybe scripts/kernel-doc is confused....
> 

Nope, I'm confused. The patch is correct.
Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

-- 
#Randy


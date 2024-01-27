Return-Path: <linux-kernel+bounces-41411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46F483F06E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0769284E2A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C086E1BC51;
	Sat, 27 Jan 2024 22:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VDhhLbul"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE17B1B7E4;
	Sat, 27 Jan 2024 22:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706392949; cv=none; b=iKsjURgPrsbXrKpc7Cgs62e3/b46LhlLkEiZY5qSyUBMA3ICSuLakkwlXMwsmjuI3CB4qS6eXgptpur0hfESVsiFhom2+tx1nULm1U0ACEOecttgkbUozIakYfQqW6Xrr8rlPyEqtzHq/qRxG2BE1Yyz1Qchn4HO+9FlpVDPBPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706392949; c=relaxed/simple;
	bh=i8GFf7OAlwgVY44JfhJtuMDA8+tW0p280lWf6EsMa0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fmz2jozCXX8tuyjrTukMvUspXr0YBBqRH0qDlM+XRiSq7wf9bTlzmhRO0SYUHJg8xfBQpxiDL8sj93NgdIBbvCftIlHEbUcb2BGEEvhG8cWuxMAN/dRBbHEzAUDvClZpgkRJpxfc/TgHpMcEAO/RzTrFm4uWWRlPErBIatPWYkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VDhhLbul; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=jYMzBg65ur09cPf+WCiWU8IpVG08dwj8iwg1UyDuYvQ=; b=VDhhLbulRyxShqtBGqNz1r/Y4L
	aviccdIH/0C+9WFnVPmpaoAyOenxwmTzibgcFueNzKEYeYg/ZtjDgSzO/OzckXasb5HBU4E6jMxUF
	ZzZNJA+j+eKnxwuVcULH7BZrR1u8rgG6nuXIweV7K9wqYCZCLTmZxbH/LqmT0/GpYqELNTQXjO7N8
	Q32z04W2Dar4kjcO70GpEbWkEI3vFm6P5fmteD5l//WxOyLWFgJ9lYozq1WRDvTsAFXwi3M7gzkXI
	oVAzf2LspY5t7PCV+1ykjGXWhzmEya0luDGrgAy3SfpXXL37bjTHzap4E6pcez0o9cbQmHUSVV1Vv
	dA3oiBUg==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTqko-00000008G8i-10Rk;
	Sat, 27 Jan 2024 22:02:22 +0000
Message-ID: <0331b70a-ee6b-4654-8c55-235545dce4e2@infradead.org>
Date: Sat, 27 Jan 2024 14:02:20 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] media: i2c: adv748: Fix kerneldoc
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
 <20240126-gix-mtk-warnings-v1-7-eed7865fce18@chromium.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240126-gix-mtk-warnings-v1-7-eed7865fce18@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/26/24 15:16, Ricardo Ribalda wrote:
> The field is gone, remove the documentation.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  drivers/media/i2c/adv748x/adv748x.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/adv748x/adv748x.h b/drivers/media/i2c/adv748x/adv748x.h
> index 6f90f78f58cf..d2b5e722e997 100644
> --- a/drivers/media/i2c/adv748x/adv748x.h
> +++ b/drivers/media/i2c/adv748x/adv748x.h
> @@ -173,7 +173,6 @@ struct adv748x_afe {
>   *
>   * @endpoints:		parsed device node endpoints for each port
>   *
> - * @i2c_addresses:	I2C Page addresses
>   * @i2c_clients:	I2C clients for the page accesses
>   * @regmap:		regmap configuration pages.
>   *
> 

-- 
#Randy


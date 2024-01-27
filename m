Return-Path: <linux-kernel+bounces-41419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64E383F09A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81BBC28829D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E771E4A3;
	Sat, 27 Jan 2024 22:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BMwsj3zs"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952531DFC8;
	Sat, 27 Jan 2024 22:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706393985; cv=none; b=d2ZEMAwUr2BCLDjua7JMg2n1n/1pWdE0fW8ogTM8MMAhr/UAWfn5hBZDCMlBR4bMOz0SI75rWQ2L1jm608CidUzkolf8CLD7gXZYdQ7KDbpoh3ub7wEU2a+IOKtF15ayJ9bjMpgOtp2egj9+KkN1RiR7TVERZ6SnPiigq4ktoS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706393985; c=relaxed/simple;
	bh=nQ1xietWciESW3ZD+wZ/IGGEwR7Ic5r7kq16Ik4rikA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1hgRpE0bnq6iW6Drwh+0LXo4Xl4/0JuJOUmjQrJD4/nnR7an36ZC+KzUhlbaeJi0o7cYqIhVwRHGrXXBDSwlb6Dp+Jnj3ngllIrQ5ZaH0P4AUh5Gzahah6Ve05iGydm2dttQuxvbKxiujNv1oS2jO2H3kSzYcwnYvAhe5l55vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BMwsj3zs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=D/vqb6f9idq8XGRxX/lJbr23ZxHIajzyh2ez40Zw8iw=; b=BMwsj3zsRMzlvcoi1WrIAH0zKj
	rDoMyJNXjq5JjWNdtwsNCRXJga6LVmiShjSru85DvkMsuGomlhe4o+yvP4BxOAJJxHput9zN2+0m2
	fhyCHxeugEV0h4lbEZZ6++QCxUaoXlyTyg8doSxC+FCrm5cZw+5Y2S9rZ4w656UnGOtnVSoXEvEXs
	5JHrc+Q3k8jwiZuSI/olL4IBB0wqyL5ylsXQQsx+zvd2SIYXCWR2eYILBiT+/sQBXLkmWRPILdMuy
	D1qwO7G2/ffRTiHLqX4l8gNRm2GCxr+ocufU7PYlryqVrT6jgS0mF3xmMscjEN8OT/OplESA2Gf+i
	qkbVPZQA==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTr1W-00000008IG6-068G;
	Sat, 27 Jan 2024 22:19:38 +0000
Message-ID: <bf319e05-5023-465f-88bb-434d8d8dd545@infradead.org>
Date: Sat, 27 Jan 2024 14:19:36 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/17] media: dvb-usb: Fix kerneldoc
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
 <20240126-gix-mtk-warnings-v1-14-eed7865fce18@chromium.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240126-gix-mtk-warnings-v1-14-eed7865fce18@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/26/24 15:16, Ricardo Ribalda wrote:
> Remove kerneldoc from missing fields.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  drivers/media/usb/dvb-usb/dvb-usb.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/media/usb/dvb-usb/dvb-usb.h b/drivers/media/usb/dvb-usb/dvb-usb.h
> index 0990aa4a17bb..cbb0541d4dc1 100644
> --- a/drivers/media/usb/dvb-usb/dvb-usb.h
> +++ b/drivers/media/usb/dvb-usb/dvb-usb.h
> @@ -126,8 +126,6 @@ struct usb_data_stream_properties {
>   * @caps: capabilities of the DVB USB device.
>   * @pid_filter_count: number of PID filter position in the optional hardware
>   *  PID-filter.
> - * @num_frontends: number of frontends of the DVB USB adapter.
> - * @frontend_ctrl: called to power on/off active frontend.
>   * @streaming_ctrl: called to start and stop the MPEG2-TS streaming of the
>   *  device (not URB submitting/killing).
>   *  This callback will be called without data URBs being active - data URBs
> 

-- 
#Randy


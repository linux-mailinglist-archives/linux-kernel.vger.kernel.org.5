Return-Path: <linux-kernel+bounces-41396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4785B83F01B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02396285BEF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 21:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58611A731;
	Sat, 27 Jan 2024 21:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ibM3Qz6B"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC93418EA8;
	Sat, 27 Jan 2024 21:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706389379; cv=none; b=KM/sSUoDRKlJZ5KAh+eT+wfv356BvDsv8BAlo27bQlgRDKh/++grA7ggWrGJ4QiJ6qOJItZ3DtGqYQf9tN8b8ZzeqsO6deEofCY6kp435Jrf6pWBbXV0KJsvU8ezft68EP86gV9AqOA5a1hYL+9koyJub9+P+619jIxFTy5ReOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706389379; c=relaxed/simple;
	bh=HMjywx9YgDjqee2LdbCwGdobVt39SnJFpWmiRKOYguo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZbLcwTtMjhRldphfg2eoa/PtlaVV7ddldzoyy7ML+rfs5DxJuL0DHjUC7aXq0moiH/dvFmI00JUqrAcO2jemUYRWV9fzMjUIL10rvT4Cn7/iDWV3LJ9sK0XGbGdSRfrlhpVxEzZaBRg2Rnhp7wz278P2aI7RAd7q4DrbiKXGUzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ibM3Qz6B; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=LHqW8kH7shctWwwB3SlliSPu5mFAQXdBMQK5ohwulNE=; b=ibM3Qz6BFjxEmRqv4SkKaQ+8ln
	u4xprfF6WrJEnDSBlDOqWj21QabdevMpN9d7xLpt1hweM3nT0RA2VLZ8mvzMyypEOrGdA9RRn6Dnq
	rJEUbPm8XUu7fY4RXO0NYKYenIBOxtojKZXYp0tE4Ulm493jfturrc3f7lF6CIlainboSs1IAn+RX
	hS5piWSzx3zUmNnXw5FGlbgnRqu7tBFoE8THav0APkfqAx52nP7a9yikeBupejxHwp9JzV8dhhhIf
	5n+QjwLULWl1Mn5muQQ4RfAkgWw9Pp4lGNoGYCbz2qaTJ4SlvjVkTRO4chcDGneL8tk4UC3xe5pDx
	GegliW+A==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTppC-00000008CEz-3sDa;
	Sat, 27 Jan 2024 21:02:52 +0000
Message-ID: <70bf533c-fd77-4e4f-819c-8299ac764ca5@infradead.org>
Date: Sat, 27 Jan 2024 13:02:49 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/17] media: cec.h: Fix kerneldoc
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
 <20240126-gix-mtk-warnings-v1-4-eed7865fce18@chromium.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240126-gix-mtk-warnings-v1-4-eed7865fce18@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/26/24 15:16, Ricardo Ribalda wrote:
> The fields are gone, remove their documentation.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/media/cec.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/media/cec.h b/include/media/cec.h
> index d77982685116..10c9cf6058b7 100644
> --- a/include/media/cec.h
> +++ b/include/media/cec.h
> @@ -224,8 +224,6 @@ struct cec_adap_ops {
>   * @notifier:		CEC notifier
>   * @pin:		CEC pin status struct
>   * @cec_dir:		debugfs cec directory
> - * @status_file:	debugfs cec status file
> - * @error_inj_file:	debugfs cec error injection file
>   * @sequence:		transmit sequence counter
>   * @input_phys:		remote control input_phys name
>   *
> 

-- 
#Randy


Return-Path: <linux-kernel+bounces-41397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6CD83F022
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71BF5286270
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 21:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4040C1AAA5;
	Sat, 27 Jan 2024 21:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DUIO8APS"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D701774B;
	Sat, 27 Jan 2024 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706389443; cv=none; b=vFN82k9mAxDN2rWaRHjUuQV/8F4IXm/G7rRN5ExMxehQ9225FxMcdrfaSQGPMAYEXONAjSceMLRAwFEAJXPlE3ACKIQy6jGXYkFp5PRq/dMVYihOpa4mNLS6fnfq2dIXRg4yC34xWAQWnkXQyn+YtJ5+MnbfMLEZmzYXKG+8uRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706389443; c=relaxed/simple;
	bh=1LFn8fP92vZ+FiNhj2fAma0+oND2LVGTGYNWYwU8wrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HeBTDcSTLR/ZgHLOS12hyzhTxO6N4Zphg3VF0l0RzmQfOxPYq07N6sEdE+Gizd7pSJubQFXfR4CulcY51cfMMKoPEWJ2ywtYZZ5Ge5Q42Pm+mFEHGd+zPPVtJ3DmdVJn3Hd2tGnTUB+27EXCCBf+1PvWGHdti6pJ0zwJ9AakGsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DUIO8APS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=o2qMCLVTADfJ6fB50r+bipM7dIFRLMPccc6A3oE+288=; b=DUIO8APSbGUZYWrHDbpK9Ffxab
	YWzfGaNY64URWCOlsSVr7HrAhsORN4gHnBvj/uIj2/8llJLiQWiYYyHXp3eFsCRRRPqxYY/k6utpi
	CSAPP99E7QXq4WCtB6msnzggHRsroZuZ4DeB84G8XneVCDP0rfGv3SamhW3LTqgDeUdaU1nq7Ce4o
	977IdPyPQk0Nnm1lr2vXJ6H42Ou93R3TENHNIsdMr5U1CreE3T2/f8f2e8MdiY4XTd7nFKbn1zocd
	RaaJQh/hOrEM5xBO2h7APENpS1z3lhZyY3z2fWlxmBgOsEbkAvRd/0ptsWW088rLszi9QoSMSRwK8
	XEe248Mg==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTpqG-00000008CEz-2lDd;
	Sat, 27 Jan 2024 21:03:56 +0000
Message-ID: <4a3150da-b71f-4d86-a69b-d72a8baef252@infradead.org>
Date: Sat, 27 Jan 2024 13:03:55 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] media: pci: dt315.h: Fix kerneldoc
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
 <20240126-gix-mtk-warnings-v1-5-eed7865fce18@chromium.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240126-gix-mtk-warnings-v1-5-eed7865fce18@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/26/24 15:16, Ricardo Ribalda wrote:
> The field is gone, remove it.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/media/pci/dt3155/dt3155.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/pci/dt3155/dt3155.h b/drivers/media/pci/dt3155/dt3155.h
> index c9ce79cb5566..ce1835d9691e 100644
> --- a/drivers/media/pci/dt3155/dt3155.h
> +++ b/drivers/media/pci/dt3155/dt3155.h
> @@ -162,7 +162,6 @@
>   * @height:		frame height
>   * @input:		current input
>   * @sequence:		frame counter
> - * @stats:		statistics structure
>   * @regs:		local copy of mmio base register
>   * @csr2:		local copy of csr2 register
>   * @config:		local copy of config register
> 

-- 
#Randy


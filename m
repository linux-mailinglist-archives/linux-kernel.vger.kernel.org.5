Return-Path: <linux-kernel+bounces-41138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5097C83EC66
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 10:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066661F22EBB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 09:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69701EB2C;
	Sat, 27 Jan 2024 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="bu8mtCyp"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED751DDFF;
	Sat, 27 Jan 2024 09:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706348913; cv=pass; b=Qbe9U+Hcn0++uXT+8zruqWoXEZL7URLn2QUIWVthm7nSytR4N2I5wPEqsuPrUaj9igrTXdIWxIPWZFLLX74yWkC1dSrBgZwX2cs9cDp6NlGH+FYqf1Nroq1AX3ZFjMxS+T6qYStix0WnzOrvt6GaHB5KPUalogb0DKFQgnj2V+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706348913; c=relaxed/simple;
	bh=rjRtZZUKE6ZM+lpRpDG0+4ezXXpnQzD6t9nnlPgHn14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsaG7eMMMcYZ/3ac4Df6pkpt9rSt056Pkm0k6tl8DW2bpLN/08ll5eYH5hkwwTt/ANhV6lvv7LfkR32vjMlwERMjU4d5ahqHGUkUmXN7Xzfc/N+CL60TYWkZZHt1evillyc5KR9FpKcLa/+oKaDA03wPM6jW9JkoCtFPFiDYeDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=bu8mtCyp; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from hillosipuli.retiisi.eu (80-248-247-191.cust.suomicom.net [80.248.247.191])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4TMV9q1pKtzyVX;
	Sat, 27 Jan 2024 11:48:15 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1706348900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h3j1f2nFT/FM+fCIzcmVTXPL1EIRhYTbwlMX2+s7BIA=;
	b=bu8mtCypj3iKYSK8u3lAX+QQ250DLbOWZj32mwDctcU2VEdE8P9xjEsSnmFGusE95DZD+M
	nZ09JcB1/E79Bse6Dw3zkgw9S+IWYqR4+46NLBBvPUUPQNSdOngS3k6SQfGZmXvBiVv430
	gPhxxOaSpZvgBpeDOfqJL8Dh7lp8L1g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1706348900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h3j1f2nFT/FM+fCIzcmVTXPL1EIRhYTbwlMX2+s7BIA=;
	b=h4ZTQ+TfYqtfZOmMzVQYGWDkCYo25ZZ22GwkWSAK1uv0CNwQuyLIoDMtVulEbeY0XRi1am
	VilpHrGEQ5EO/WBpH0t56i57nuTXNInYwJ6AQbe1CPU/aRoRrIUy1B0MHRnA74IYX6HIdk
	jEVxFlf9SUZNxajkpivFC6iSjR9X/Tk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1706348900; a=rsa-sha256; cv=none;
	b=uWyNSJYVd7TmfFi961ft1zXeW02/wtihzLSqbhgIJCjkTgT2g3uMjhC5F9d9he4mYO7Avj
	MzjcJNVmHEgiu2R7OCRlHlHMTW9qGuIXKq8WEkLy1y2zX53xsdRqpr5zp3KYFZZEFizv9L
	zrug8y9uME9az3LvAvLOb8qMkl5VuJw=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 7C8FB634C93;
	Sat, 27 Jan 2024 11:48:14 +0200 (EET)
Date: Sat, 27 Jan 2024 09:48:14 +0000
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Tiffany Lin <tiffany.lin@mediatek.com>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Hans Verkuil <hverkuil@xs4all.nl>,
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
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 03/17] media: media-entity.h: Fix kerneldoc
Message-ID: <ZbTRXgnBnb-hHKK_@valkosipuli.retiisi.eu>
References: <20240126-gix-mtk-warnings-v1-0-eed7865fce18@chromium.org>
 <20240126-gix-mtk-warnings-v1-3-eed7865fce18@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126-gix-mtk-warnings-v1-3-eed7865fce18@chromium.org>

Hi Ricardo,

Thanks for the patchset.

On Fri, Jan 26, 2024 at 11:16:02PM +0000, Ricardo Ribalda wrote:
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

A similar patch by Randy Dunlap was recently merged. You can drop this one.

>   *
>   * .. note::
>   *
> 

-- 
Kind regards,

Sakari Ailus


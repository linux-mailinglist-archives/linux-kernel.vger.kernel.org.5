Return-Path: <linux-kernel+bounces-41144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E82D83EC82
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 10:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637C21C21B2E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 09:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721E81EB32;
	Sat, 27 Jan 2024 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="NhI2acQ1"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E5D1E86C;
	Sat, 27 Jan 2024 09:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706349430; cv=pass; b=oZJjePR3Gp7yfLfe97N+B8dXMAe/U23JT8BOmftyBc8YBsAscqKcw6aMbfr6onK0ALw+2sBNDqr+iKxVMoepxwX7PkByHSGcXPKBdE4jKZvLfawtum2EyydmOqwlMktvHjzQorKg1U/Qq9X5kkZsdXsl7WPxzGDqBbl332OC3po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706349430; c=relaxed/simple;
	bh=BYB6jC3aI2xiPrDsSv3GPmsr+ClEbamMjWpzzNbk00E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEdLMv6RW3cZk1Hu1JG63O62T1CRK1Nj+urC7JDyEbKDB7XusxbHL0lmTMrf1fzh+v3Cxxn+mRQ2qplrdy4sydX6xA5Wu4toAxqOXglcKh2aKt6rcNimtanKKequXeEgUI/GgjS23gEoNwzjJOgBwQGW9aBdlLi19HlqS4FPDqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=NhI2acQ1; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from hillosipuli.retiisi.eu (2a00-1190-d1dd-0-c641-1eff-feae-163c.v6.cust.suomicom.net [IPv6:2a00:1190:d1dd:0:c641:1eff:feae:163c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4TMVN020rqzyPp;
	Sat, 27 Jan 2024 11:57:04 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1706349424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UAj93A+QldIc2BlOVJOBkygnNhIiKNVEocFWLbjrq44=;
	b=NhI2acQ1O4J7xZMn0vxDy8AsXgy5iOSZLbslZXaEFG7Lm3WiP4d9HQgxKlv9pKIZXqfitW
	JX54ndZ8TEsE+QpN/C6fy01whRVK9LqnhbRyzMZUQO5WFLzLYxisKWkTDJx/d8rmHa8Gvi
	TaVyx/W7YDoo8w1ZFsPJSIGVTE0b6Bg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1706349424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UAj93A+QldIc2BlOVJOBkygnNhIiKNVEocFWLbjrq44=;
	b=m5Afe8MEqZqYfQ7DsoCfsbTinjVAmnmLBU8rNzuv9udyXlHrhZXaS3mEOQHJOqcmiewyzF
	fRgYXOHQjzUTOWlujiymp1Wte6IdetR83dQuN86Ib4/u8wHyoha75sp28/u+e7dkWZFHBk
	fj/dpnp2t7MzQU1oXNFueKAnW3dOws4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1706349424; a=rsa-sha256; cv=none;
	b=cuM4Wm24bJ+zli7jFhPml/vGiMkLf7Mx4y1JSql7NWzDMObPe8xmwGI1sk58uB95Yih6lJ
	AFsCph2L2PqQDvxd3l2qDs9GVbhsaUZRTB28h1qM7+iUeEJhxm0LUcY0hRcw/XsV+j8DYu
	NZ/tFKPGsRG853g4AKokaRvVeYY6DdI=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 9319C634C93;
	Sat, 27 Jan 2024 11:57:03 +0200 (EET)
Date: Sat, 27 Jan 2024 09:57:03 +0000
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
Subject: Re: [PATCH 17/17] linux: v4l2-vp9.h: Fix kerneldoc
Message-ID: <ZbTTb-SdK-EubGdc@valkosipuli.retiisi.eu>
References: <20240126-gix-mtk-warnings-v1-0-eed7865fce18@chromium.org>
 <20240126-gix-mtk-warnings-v1-17-eed7865fce18@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126-gix-mtk-warnings-v1-17-eed7865fce18@chromium.org>

Hi Ricardo,

On Fri, Jan 26, 2024 at 11:16:16PM +0000, Ricardo Ribalda wrote:
> Kerneldoc cannot understand arrays defined like
> v4l2_frame_symbol_counts.
> 
> Adding an asterisk to the name does do the trick.
> 
> Disable the kerneldoc notation for now, it is already ignored:
> https://docs.kernel.org/search.html?q=v4l2_vp9_frame_symbol_counts

Wouldn't it be nicer to fix kerneldoc instead? It might not be difficult at
all.

Feel free to, but I can also give it a try.

-- 
Regards,

Sakari Ailus


Return-Path: <linux-kernel+bounces-140194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3348A0CAE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8CD91C21AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DAA145FE6;
	Thu, 11 Apr 2024 09:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="j7nV2JTt"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0BD145357;
	Thu, 11 Apr 2024 09:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712828547; cv=none; b=gaeDhut5hSQTCAWs6sLNRzMVFIKQKkIhf1/x5/Cov1s85VmKlwzds5fsJIo5RaVdN/ys8bPlA93gjGW2o1Ydu6cm0ZKxyCo8gmmM/5HjDIvIwrpym6xHxRttycD1/xMLgdyzz4lTiOPN3+Zs+DJm6vI3bUhCZhnfT6pAQfn5jf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712828547; c=relaxed/simple;
	bh=V8R9fkgyimeoVkPMlASX7iK8V0uOUDT/i1En1+rhSGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uL0kX5bZyJqql9hFG9dhwCBr3QhglWBtqAEe4pRZVJpzLPHipJ7O22xl+QBC9Ssg+0GNFOrW/8FvizM7HJ/lUSCHS9uSUW961CRQTjGY8ef39hci00UgPd0Vx1Syu9owW9AG/sAUWVvol4Bz+vbFVVEC7DzMt99A7Beaq4ZqHC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=j7nV2JTt; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712828544;
	bh=V8R9fkgyimeoVkPMlASX7iK8V0uOUDT/i1En1+rhSGs=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=j7nV2JTtFRFDoe55/cqaTLUAYGBaUQqgJp8iyOyERH3iEwVToQcRRXQ2xEWj7Do4d
	 LYbHMIvHXOhzWt+sISp7dkuL3zFZFHv4tqDdQ685cnQokNyiT2z8oApoj/K0yIOl7p
	 pxz3D7R/335KRnYQLqh5y5M88eRu6YjVflzRWqfpwOFEcm9xIhROxXFkwt3UCsj64x
	 OSeiJWkVo+A4+GkfHpTO5IkRotje5WBD4Wmmkj3SHRFuzJWhWSmddRnS1q461rxEEJ
	 kshUc99aQR2eu2hUa8KNfkI18O97E3zVBMhKGYx/zL1LwGF2LlbkW9YpXttDeWwBuG
	 jeim3z08d6Vlw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6AD6E378212B;
	Thu, 11 Apr 2024 09:42:23 +0000 (UTC)
Message-ID: <21d9e0d3-5e37-4e08-862a-df463c945919@collabora.com>
Date: Thu, 11 Apr 2024 11:42:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] pinctrl: mediatek: fix module autoloading
To: Krzysztof Kozlowski <krzk@kernel.org>, Dong Aisheng
 <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Linus Walleij <linus.walleij@linaro.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Sean Wang <sean.wang@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 zhanghongchen <zhanghongchen@loongson.cn>, Yinbo Zhu <zhuyinbo@loongson.cn>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, linux-gpio@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-msm@vger.kernel.org
References: <20240411064614.7409-1-krzk@kernel.org>
 <20240411064614.7409-2-krzk@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240411064614.7409-2-krzk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 11/04/24 08:46, Krzysztof Kozlowski ha scritto:
> Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
> based on the alias from of_device_id table.  Pin controllers are
> considered core components, so usually they are built-in, however these
> can be built and used as modules on some generic kernel.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>




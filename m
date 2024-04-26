Return-Path: <linux-kernel+bounces-160344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE1A8B3C37
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 482D6283643
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AB7152539;
	Fri, 26 Apr 2024 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="uGlfKuSL"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDED149C4B;
	Fri, 26 Apr 2024 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147254; cv=none; b=Rr9h6IG+xVHopPOnI4+AzDdeE5mbAPWHiZrzl9Xm5t/4zP5jSnjngr3d9MZXnVzzajFKd0cnCkbOKLG7FxcF7jIvN1setzSjevmsgMW8+z1iBam7ASV1itJo4VNR7HZxOz9jIalLAznJP7AUphRtFxTiNZqDH5XCIWoJrGzjnJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147254; c=relaxed/simple;
	bh=PFmO1GjsH3ZnbXjVv4QA0fj5fCj+YtjfQKAlIFclL5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQrpT6iHRUqRB2+w/GVskFSEjsgkz2UWzYQJy5sc/zi+3H92xo8/MjsfD3fuGRK82nuzLTEdc2BBblv1aZ/jWbAX54vj4TC8Astudx5dkBZfjuT3/dAGFOruChcjo5vztMTV7xGn6D4s4hfnY2CWBVc0Smj5NurP10Rs5cdHbEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=uGlfKuSL; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id D36B588221;
	Fri, 26 Apr 2024 18:00:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714147246;
	bh=MbBx9Y1hMfZdkFnfEVCvE/hOTF3f77wjPkbrDnF6OaA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uGlfKuSLMpDsGs/aW46lZfoPSnPPN9ijCRIEy+VBNcNpuD7hsVmf+/gAHVuRx3iRK
	 9xnLuq/ijpWbrlfmnokZ8WGNLBB9GSs5yt2QeFwfgW9Dl7OV7+LKZBTWc6XVETiif9
	 tHm5L1onuijzcxUvykagrn6i4WI03Kt/IH/2w29fYy7GzTkk5QW2vgHhxjEJ2XMiAq
	 rZsv9lFU58dqkgXFBrkfOSpT2cpoz8JY6am80tgsXcjrXWF6z5VSNGR2BevR2eTZON
	 Ub45GvVtpGoia+tmRatERcxGYTs2SOeRMy5K+npgubrMfStbabmZ4159bRWekKpyBO
	 zE4EYNejYy7+Q==
Message-ID: <2ffaad98-8b43-444e-a4a0-985bee5e6a04@denx.de>
Date: Fri, 26 Apr 2024 16:46:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] dt-bindings: net: add STM32MP13 compatible in
 documentation for stm32
To: Christophe Roullier <christophe.roullier@foss.st.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>, Jose Abreu
 <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240426125707.585269-1-christophe.roullier@foss.st.com>
 <20240426125707.585269-2-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240426125707.585269-2-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 4/26/24 2:56 PM, Christophe Roullier wrote:
> New STM32 SOC

Which New STM32 SoC is that ? Please add type/model/...

> have 2 GMACs instances.
> GMAC IP version is SNPS 4.20.

The commit message should describe what does this patch do, and why does 
it do so, something like:

"
Document support for STM32MP13xx. This SoC contains two instances of 
DWMAC 4.20 IP. Because this is <somehow special>, document <some 
difference>.
"

[...]


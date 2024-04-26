Return-Path: <linux-kernel+bounces-160346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C22378B3C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39681C23335
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9264C1581F4;
	Fri, 26 Apr 2024 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="GawWdYvG"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7883215253A;
	Fri, 26 Apr 2024 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147256; cv=none; b=NVW3HYlKD7HrallZMNetPRFzf55OYygJ4gEN3XYySaabI5NEafLKjBdUAZ/S0Sp521Ctth7tAUzT75a5vo/wMAPegfQxCSaX38RlA+nOA4nZD0ox8bB8EJkNLXR/UwmgMLHRFPqu3RcZqhkKQb2RYKIt8CXwfsn3P9+MRDs+0T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147256; c=relaxed/simple;
	bh=9drFnhHve1eoDnzDm5wZyIL+KmFVskjFe01L0XIwe+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f0INsv0yx0IQJePOcEJbkht2ZOSTeX3JW8OjfCol/hhQyTCaORf51wy0VUX9oWAFKn9x14ZpRR+PICoyfIvszVUlHulgpD/KUWJ+7OmUtCV99YLgH7M02nlqx8FLBbry11QxPdHRfd9pde0/34PfFP74LbvOBnpWtwY5gJwy2a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=GawWdYvG; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id C9C98883D9;
	Fri, 26 Apr 2024 18:00:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714147247;
	bh=6TmpYt1Y+k14rCvdyd0x8WlMRrxMW9ySTfGrm+UopZM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GawWdYvGVOKd6hhZdBfejKQhPR27v5KT8dKKa/t5OKvHgDvZvcmP407jq5zkEm46R
	 SOZGaRIEernamyi3EqtOIqI4TvxtHdNKMU9z/NFmSkCyhLmU3SQTlDpqUKDoeQSEnC
	 ZMzg/16GR5UJE2jaEYYNxxU7nWPs8I6cx/vl0O7URNvWxRb76OskSLH0HDh3uHt72B
	 UFnNaBhrZX+lTPdZexQcbSy4HJdS4dxrJn/mvtyeCyL1p6ZpU1P9mePLWbN8fI+s/v
	 8z32YSYeEyh+TvNDC7wRdf47LBF9XzuLzKO6iYzTvhoypexp9AREcMyIpQEPWSIM56
	 IrzZcofsFxkjA==
Message-ID: <4e03e7a4-c52b-4c68-b7e5-a03721401cdf@denx.de>
Date: Fri, 26 Apr 2024 16:47:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] dt-bindings: net: add phy-supply property for
 stm32
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
 <20240426125707.585269-3-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240426125707.585269-3-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 4/26/24 2:56 PM, Christophe Roullier wrote:
> Phandle to a regulator that provides power to the PHY. This
> regulator will be managed during the PHY power on/off sequence.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>

Maybe this entire regulator business should be separate series from the 
MP13 DWMAC ethernet series ?


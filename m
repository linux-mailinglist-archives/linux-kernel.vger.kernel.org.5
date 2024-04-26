Return-Path: <linux-kernel+bounces-160349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7398B3C46
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5B41C247AF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE28168B06;
	Fri, 26 Apr 2024 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="FDYTfffN"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB07215A4BE;
	Fri, 26 Apr 2024 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147260; cv=none; b=DpgFe/8exPKqlOEm64IWCR1qhRm/0Gw9KuiKYehKVfnX//LqT3gpD7Z4Qm7Z7Cf+rVztlO3KKnwRtWxOEfRdcDcpiM1y6i5ALdoR7waNvl+fh/1vys51/HwIz7aBRlawZweQmrbz/1nR6KSz7fZpraEAP6RqOP/jdjItsN3FyWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147260; c=relaxed/simple;
	bh=fCADD2dHSi+1tKZaQFs2hqkpmbPHOa9MHnJF49LhTq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PuL+pgcK7TzLhRNL+FbgjaVyr98Gt5AO2OgOFwV0Skqec4j4VmUrizL6y0W+XVa6optUHlAPtCEuAKcl9KJ+GPpQQ3wbi1xFt3zoagDTYyc+Ui9lO6SX6pYhtdE07j4F8Zrikwg+h7DkWB/MjIJIgw9mA9TNalSs+npdJl4sfqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=FDYTfffN; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id D1A33885B4;
	Fri, 26 Apr 2024 18:00:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714147257;
	bh=5qHEEgpwiFG2miTn8xs8E50XdPfGPzJ7ckT/98Ml6KI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FDYTfffNnOsIYfIN/TAx3FFrkDQnw1I8GBbZWMvr2/CplSFxq/wLQrKT56lNi3K77
	 FmqOYxSUeX6GFs3ACYcGFuiXr+Nht2FaYMS1mfIOq7RVUyeUSaViJGzayhX4xfh9Is
	 QywbKZ0B1AvIQJcF2yswf37FBgrQ3REALG8CnSwMogGqMOncWyISYFYM2/OqnAEZr0
	 CYdXhRHO/CFjhkHGRCfc1W+N/JbNJPAYvgn2UjfQS2KqWQoXFxkKNVu7+Ab4DvrNf+
	 5xahBNU8S1ajBZAQkmf90vqYDKiB23J0OWFHDHumcFe3oLP2bPe4RDA0nc/jPDh3rj
	 J6uv3NNmNZDXw==
Message-ID: <efee3462-e72b-48c0-81ee-a1f38f4791c7@denx.de>
Date: Fri, 26 Apr 2024 17:48:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] net: stmmac: dwmac-stm32: support the phy-supply
 regulator binding
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
 <20240426125707.585269-8-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240426125707.585269-8-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 4/26/24 2:57 PM, Christophe Roullier wrote:
> Configure the phy regulator if defined by the "phy-supply" DT phandle.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>

Maybe this should be separate from this series ?


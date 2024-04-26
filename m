Return-Path: <linux-kernel+bounces-160345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E338B3C3A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235492832C4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39FB15687B;
	Fri, 26 Apr 2024 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="OlxJiBA4"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DE714AD26;
	Fri, 26 Apr 2024 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147256; cv=none; b=ezGVwY4X0u+AsZS8vgIPVpiXaxypaCdv4A9N8pVXxiubYT6J208K9p1gqWSDf66oQtfjDUsjbENs5hGNpg239kR212dWIUf8tJNQadDRJUlnzU3w3bqH/ibbWAe1HVTsnV0VqlZVZaXlPses9gqR88yDRSh+TjSrhyAJptddONM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147256; c=relaxed/simple;
	bh=e/e/CkS2lyAv5dcyu8k8+s7I4g7ycYx06SZTbh0t75k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dt5LptFg8rk9xenoiocMy1GVrIsJ1dYPjVaJFPO0nl+VdXUH19d8UoD9rSbDz/UXJpqbu1vYs/1RI2AhXnQlWdC0kV2Fxdnavew6Dk/bj6S5zsX1QXhtbxBqqAnE68ZRwG0plNy9S0hiXvC0QJOlVZpwy7fKkFAqQ5isUyd/5Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=OlxJiBA4; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id F101F885A2;
	Fri, 26 Apr 2024 18:00:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714147253;
	bh=KntFSRKKJlXDI5nElDgSk47qflI7G4WWVDhKzJ36saw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OlxJiBA4JqiSkPep5+//Fab0HwkAzF4JpRmBY7MmnztFaBs1CPhfiiJg0ggs186tS
	 FUPEmouTIVHsld25mVu1cdwPn6C0rqtoPLMk+EYPLrP4ynWAXJuYgAsk7V+AS8/p/O
	 lQzAOvhn6cmgSjN1NDjb3KFLd27GSD7fp54cDaBx7GfSLF3d7/W5Bthlr66buqjQKX
	 AtWFuDl14vhYxmjFdnSsEa/4q0BwZp/MfnRAlMtMwF0Hjm35xnePRM2FnAKfRiUvnz
	 SLFwOy2aphZnlwRhiXWW5PtwXL/WXKdqAWyqe/bx5cR8CBugtQGiJb3WDHRm3kGsYN
	 FZuYqDTShKRjA==
Message-ID: <5b8b52cf-bd43-40c0-962a-c6936637b7de@denx.de>
Date: Fri, 26 Apr 2024 17:40:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] net: stmmac: dwmac-stm32: clean the way to
 manage wol irqwake
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
 <20240426125707.585269-7-christophe.roullier@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240426125707.585269-7-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 4/26/24 2:57 PM, Christophe Roullier wrote:
> On STM32 platforms it is no longer needed to use a dedicated wakeup to
> wake up system from CStop.

This really needs more clarification.

Why was the code needed before ? Maybe because it was used by some of 
the older STM32F4/F7/H7 SoCs ? Is it still needed by those SoCs ? Will 
this patch break those older SoCs ?

> This patch removes the dedicated wake up usage
> and clean the way to register the wake up irq.

[...]


Return-Path: <linux-kernel+bounces-105130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F7A87D979
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC231C20DF2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 09:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152F313FF5;
	Sat, 16 Mar 2024 09:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="SEqZ88Ec"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EC5125B9;
	Sat, 16 Mar 2024 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710580931; cv=none; b=ZYbMjVxz1JBbkTHlD8aue+sC7uXlr8k9ogpPfjH4g6akDvZu3rGcGhezTsgqc1vEO0/taygGyKgldl2US1N7d4CBZHy8SYxPgtSRfNU6Ot6NuQzFBwK1NU5Ii5V4vrn+cHB+7sOzlbP5ihm3PguYc3eWB/8+Q+z0ex7uJ93KLKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710580931; c=relaxed/simple;
	bh=D/KMnYMksA1DHQQMkJFwtuT89OWoH7wS4mxP6olMy1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iuX11jdwIvsCV+pQYOCaVxNF2yP9A2Fodtz7EfmVSvjm1BPix7IAoxhj0z55yZb9wQy910+30bi4M1eH+GgOi1W6C8OaXkVpR/liyKLB7yUDNeH5ES6jqkNicNNlhGsAhAbYHlmR0MTdKI2AWekzdxiXDq4tszYSTdoonGz7+9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=SEqZ88Ec; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3371820004;
	Sat, 16 Mar 2024 09:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1710580927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8QIHCmNx7i/YQHcmrZytkPV0r8PHOyaKNLruF6ZVFk=;
	b=SEqZ88Ecred72uF5zEPxsjxIjDZ9nsdBQm1nsbxu4WQ1NuoBxJ+QWuS5leLg2V7QK5YTok
	SmEYKza0fRtj+c7YEEdVfZvZ5/58zg/ZIRvUtI6eqvnmB+6aApk9zGldWNfw1POn5cMWfe
	PYLeDQpu32VOgKuMzVo42XVa4qJhHNmEZQYBVoEE/6dghyvPIOvbnX7cQZIAGZIQEetPy9
	cPAr+TNWpMA37z6HZyaqWyMl8X2CvvIHq1qEE8SzrjBO6EEuQPo3ltREFpEfoc2oKSx6T0
	xBL/PMaEs2oYBINPU3SvGf64cScui2Xg1USo3R7XlIJsM13pzgcJoRNeVgut+Q==
Message-ID: <4e8bcb9b-8df1-40f6-a0ad-6ef4ff4339a5@arinc9.com>
Date: Sat, 16 Mar 2024 12:21:50 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] mips: dts: ralink: mt7621: reorder i2c node
 attributes
Content-Language: en-US
To: Justin Swartz <justin.swartz@risingedge.co.za>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240316045442.31469-1-justin.swartz@risingedge.co.za>
 <20240316045442.31469-7-justin.swartz@risingedge.co.za>
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240316045442.31469-7-justin.swartz@risingedge.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: arinc.unal@arinc9.com

On 16.03.2024 07:54, Justin Swartz wrote:
> Rearrange the order of the i2c node's attributes so that they
> are inline with the DTS style guide.
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç


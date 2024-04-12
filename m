Return-Path: <linux-kernel+bounces-142037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFFC8A269A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A15E11C228D0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3032340BEE;
	Fri, 12 Apr 2024 06:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="I4TntV39"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6DC3FE5B;
	Fri, 12 Apr 2024 06:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712903290; cv=none; b=uF2/oOx7skK9SF3SstkB15evn9GstrLKcR5mjhIJyr/NKi5KqbywvvExykVDE4HaKPLhve5nSGgDLBmcSc+bnxnlIQ8KLdjCPOYazFmUaHbcVUg29AJ+N0TCPBM89xuOqA/uvRYy8shYdfgdry4AJ/8Dpw5S3QrAPQluaKoAr+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712903290; c=relaxed/simple;
	bh=s25N0TuD2mKVnak326HEWl8NP4R38SQt9FxwJaCaMSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UWZP2E6hRCZdOc97r0MEKlzqEqmCMwQ37uwt3Rm1JjoUinttGhFU5deGjhKZCl4KcTVvuJX/cxnw+WyovhIaP4U72tyQyy5aamMbzZ5ym5Vu8NXa/i6oM0V1IVWefHw+7i412RsYHH3cTSbwDOY0wBByQw6bGICJN18yWi9OkM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=I4TntV39; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C0RJ5o014097;
	Fri, 12 Apr 2024 08:27:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=s25N0TuD2mKVnak326HEWl8NP4R38SQt9FxwJaCaMSI=; b=I4
	TntV39qdNvna/x0r4lkyP4NzQgLHdtb5KRXZXhmRYLAHBxfbGILwiOlyQySw7/N2
	brRLGppXPHoQPVfMk5e/FG+PE33r3WSI8mW2L/ciNJnEmlcVMlfSDH23kfRWnWAZ
	Gy7P+uAg7k9G+/BPY+njfs6w2OSnvfevI8hb6f+90goDO3hRxUStsMmt/Y2/1pxp
	lazHYhTpaAKiJ20VUadXbsXn+DjvET9aKobGeawDuOa6r0lqBK7cnbJU9TUEYCmV
	qDiHXAsL9uZixO/nwRo91Q2FoDHgIhMu/Fx5zke78HLfGI+dEA5A+KiLj/b9plTL
	38vWRqK8d5os4zSm2cew==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xauh5fnqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 08:27:45 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8E8324002D;
	Fri, 12 Apr 2024 08:27:42 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B0AAA20DD96;
	Fri, 12 Apr 2024 08:26:53 +0200 (CEST)
Received: from [10.252.29.77] (10.252.29.77) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 12 Apr
 2024 08:26:52 +0200
Message-ID: <82b2a672-ecd9-40e6-83fb-c469498230af@foss.st.com>
Date: Fri, 12 Apr 2024 08:26:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/4] clk: stm32: introduce clocks for STM32MP257
 platform
To: Stephen Boyd <sboyd@kernel.org>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240411092453.243633-1-gabriel.fernandez@foss.st.com>
 <20240411092453.243633-4-gabriel.fernandez@foss.st.com>
 <7efb8858995d0c97ad2deccb24318353.sboyd@kernel.org>
Content-Language: en-US
From: Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>
In-Reply-To: <7efb8858995d0c97ad2deccb24318353.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_03,2024-04-09_01,2023-05-22_02


On 4/12/24 08:22, Stephen Boyd wrote:
> Quoting gabriel.fernandez@foss.st.com (2024-04-11 02:24:52)
>> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>>
>> This driver is intended for the STM32MP25 clock family and utilizes
>> the stm32-core API, similar to the stm32mp13 clock driver.
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>> ---
> Applied to clk-next
Thank's Stephen


Return-Path: <linux-kernel+bounces-127441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB0F894B62
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF29D1C2265D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBB01D6AE;
	Tue,  2 Apr 2024 06:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="e3Al1ZUW"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC1217588;
	Tue,  2 Apr 2024 06:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712039199; cv=none; b=NGJmGy4A0IDJ1ri1K0t28DW1/1wEJtcH62hRVSOCH+8alUQRKUOb0HojqHTrUZvJNfDnEDtuc6qCtI2WE3CzVm1OpWpFMaoQvLbpNq3Nktr5hdIdONEq6+W1gzfXYcHwrHYNfLMrhc0V/gpTpxNIpMnQ5QZYkytoRcmg80A87w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712039199; c=relaxed/simple;
	bh=DS5ltK4FI00bnAWy3ZQyDKApdhuUWF1Ck+SFpGKbj9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Hf1Am7RYDVdXfdVTj/GDxQnDmDpPUAeBjQJ89ufaPn3bmXYcLdtWQDTYw6krMoZ9ZXqipGNt/s2lOfXcUufSzkyv3FtOpVC+sQRZA5Hp9YNeR/pj3V0YvF377VNdCJszaeF0wBAzW0jl5INcKkWR5txYzA3d31MgJIQ9NS0Tx6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=e3Al1ZUW; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4324Y9qi002614;
	Tue, 2 Apr 2024 08:25:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=CcHHM/KryYZsBrWCT1i/gA0cscKu+WS8QKGpJmnNtqc=; b=e3
	Al1ZUWIfAl4zB6kK+OA/GK+Y8yj4OGmyfDWO0asVmBBNf6K6QwhqlUUeOjXlFfeu
	It1AeSUJ28+ANgHNTV+sPRhy5w4vtw7atgeItaiL0MJJQyOXU4dJ+6hdBndg2Ro5
	qQ2H0aOKo6TtW6XgYw8bTXppdT1HfeqijYq3zyGZduRcV2p2DMhq+gpD/KGApJNp
	rRqnfVwEe3kOWWGokwZQLDN9QGCvo91E79V8921VF9YsQBLkmSPl7ThS45LlH8Hc
	A8TZ6nwGioznpn0rzmknmZue6PZWvA49jKgJVtRUGYyTrlX+9k9z0qmC1EzGtg+9
	NPjyJgkTx7aQIIwZt/mg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x6wsu792t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 08:25:58 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8E79A4002D;
	Tue,  2 Apr 2024 08:25:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D603420F2C1;
	Tue,  2 Apr 2024 08:24:37 +0200 (CEST)
Received: from [10.201.21.128] (10.201.21.128) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 2 Apr
 2024 08:24:36 +0200
Message-ID: <514c9f18-1ab8-425c-b78d-d13c30a25049@foss.st.com>
Date: Tue, 2 Apr 2024 08:24:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/1] Add property in dwmac-stm32 documentation
Content-Language: en-US
To: <patchwork-bot+netdevbpf@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <richardcochran@gmail.com>, <joabreu@synopsys.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <marex@denx.de>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240328185337.332703-1-christophe.roullier@foss.st.com>
 <171175263052.1693.263504657362042828.git-patchwork-notify@kernel.org>
From: Christophe ROULLIER <christophe.roullier@foss.st.com>
In-Reply-To: <171175263052.1693.263504657362042828.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_02,2024-04-01_01,2023-05-22_02


On 3/29/24 23:50, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
>
> This patch was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:
Thanks
>
> On Thu, 28 Mar 2024 19:53:36 +0100 you wrote:
>> Introduce property in dwmac-stm32 documentation
>>
>>   - st,ext-phyclk: is present since 2020 in driver so need to explain
>>     it and avoid dtbs check issue : views/kernel/upstream/net-next/arch/arm/boot/dts/st/stm32mp157c-dk2.dtb:
>> ethernet@5800a000: Unevaluated properties are not allowed
>> ('st,ext-phyclk' was unexpected)
>>     Furthermore this property will be use in upstream of MP13 dwmac glue. (next step)
>>
>> [...]
> Here is the summary with links:
>    - [v6,1/1] dt-bindings: net: dwmac: Document STM32 property st,ext-phyclk
>      https://git.kernel.org/netdev/net-next/c/929107d3d2a3
>
> You are awesome, thank you!


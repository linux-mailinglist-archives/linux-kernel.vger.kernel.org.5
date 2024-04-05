Return-Path: <linux-kernel+bounces-133025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F0F899DA6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01AFFB22538
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E8B16D334;
	Fri,  5 Apr 2024 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="K7859fcm"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5208328DB;
	Fri,  5 Apr 2024 12:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321766; cv=none; b=VfXqRRa6WRPoJgDxe0PufTcfmJzyPUxpSVyqRgCUBgyaqdxIEu10BDml2rAtV3Njy8bG8pWTDVi9BhkmqAsgOgvOGCDw6+bmc5O4YWtF2i3gg5fgMiXvCY0RXPF851rT8cYiQc+o7WJarhiADIe65ZLI9EUMBrmQB3VdUGr5Mm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321766; c=relaxed/simple;
	bh=y25Qs+ww98t759JfT/W+t27yNTnSAUjHxcGz1gXUrNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eRigTT6t7o98nrIpRUEbRTkKGSAr7yHqQj4wriGFw/CA+X7GeLswSh5Vo8LbD/aRgRJwkftkm+DaQ+OvVHthGcjK5N0eM7xzScXSYAN0CY9q7L297jiz88bPfUgE2Uw9dHKulX008D8JRpS9ZKr93/+UjvpaWS0PDUMITv8lmPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=K7859fcm; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4359V9ot028899;
	Fri, 5 Apr 2024 14:55:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=0cFdPsY/Q1AlffEt+XiVO9DUsg6Cv8uI4Ru07BMd9WQ=; b=K7
	859fcmksebHtW/xO2+6NxWbrCCId7k51+4xo//Bl9iBNh8FNCiuwp8oWviToA3+a
	zu22CzuYfIsHcoYhwyTH/qDjVhisTQhG0mWYz81pSPxBtilDspGBMCQbAoeM6Hs0
	FjnFSKocVrRqWEikFItsjLbCfCDLmHeHSwYrdCp53GMt7NY0ueHw3XT8XTCg3qF7
	hW7+PlP2NKvUeFtLkucs5R7kZrNGsn/eJvw9iCxD8zUUGgK9BFt5OyAhOtIg92us
	teOjTL7Gn0bGEo7jXZdXDUbNdbkv2MQrhx56uA0+9eHWO6rGDltio+CVfOsnRXMD
	wzTrBJBbE2Fr9a6p+EYQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3x9emuyjyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 14:55:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 788154002D;
	Fri,  5 Apr 2024 14:55:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2174C216833;
	Fri,  5 Apr 2024 14:54:38 +0200 (CEST)
Received: from [10.252.8.38] (10.252.8.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 5 Apr
 2024 14:54:37 +0200
Message-ID: <285f2f64-58b0-4dd0-9f1a-89306a79d572@foss.st.com>
Date: Fri, 5 Apr 2024 14:54:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v9 2/4] dt-bindings: stm32: update DT bingding for
 stm32mp25
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240402125312.277052-1-gabriel.fernandez@foss.st.com>
 <20240402125312.277052-3-gabriel.fernandez@foss.st.com>
 <e70dc513-df9f-4b99-b9d9-7ebaf83e8f3e@linaro.org>
Content-Language: en-US
From: Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>
In-Reply-To: <e70dc513-df9f-4b99-b9d9-7ebaf83e8f3e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_10,2024-04-05_01,2023-05-22_02


On 4/5/24 09:12, Krzysztof Kozlowski wrote:
> On 02/04/2024 14:53, gabriel.fernandez@foss.st.com wrote:
>> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>>
>> Now RCC driver use '.index' of clk_parent_data struct to define a parent.
>> The majority of parents are SCMI clocks, then dt-bindings must be fixed.
>>
>> Fixes: b5be49db3d47 ("dt-bindings: stm32: add clocks and reset binding for stm32mp25 platform")
> And except what Rob said, this does not look as a fix. How ABI break
> could be a fix and what is even to fix here? Please describe the
> observable bug, how it manifests itself and what is exactly the fix for
> that bug.
As I replied to Rob, there are no RCC STM32MP25 drivers already upstreamed.

However, in my series, the DT binding was merged even though Stephen 
made some

important remarks that needed to be taken into account.

That's why I proposed a fix to update the documentation.

To be sure, how would you like me to proceed?

Best Regards,

Gabriel

>
> Best regards,
> Krzysztof
>


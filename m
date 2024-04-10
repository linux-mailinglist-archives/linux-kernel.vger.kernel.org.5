Return-Path: <linux-kernel+bounces-138106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E8E89ECB4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ECCD1F22A20
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E5E13D29B;
	Wed, 10 Apr 2024 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="SAV3xkHL"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A29D13D26E;
	Wed, 10 Apr 2024 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735566; cv=none; b=f/ziTSeeGfPS0GHY2LMKJrFstZD6qAWXl+RvLAkZBPB2UOUxs/DHEC3lxde76yO23UwaxbRuvFwc4FqPuIznB4b0bwRaEit9IK81Q/3UTujakNY8edOkLyyRndR+zmIiyWE6qbjarz0QsyeXe1oNEFC6D1Ma0rAXO2y87KOS27k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735566; c=relaxed/simple;
	bh=SrAP+nZjs4TA16chdAEetnXZNIN0oKv90/wM2AEutRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DEikEimthM0Z9brWK49Q9srL2yOzoGnpNhC8GAJkOMCjHY4MEYnUSt7H479cVohKLJg4Xx9l51s6jiuAm2er4k7i6pWbTQf3LZVkGM3tIhUdlB0RHnFMJG/M19mwqzd5IEixzSYQjW6mScfLaYVbcZK8/e2pCcZIQVMjQyhbzVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=SAV3xkHL; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43A7EafS003712;
	Wed, 10 Apr 2024 09:52:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=rMYpD05cp2Dgf5jUrorLWhuaT2GKlTcovx9+xdL8a+U=; b=SA
	V3xkHLSYG9l9cKfiEQO1OFktaeA9tHlvj9no6sZMCStQ3sPl3Q1dGdw22hNsWHmp
	I4ghwx0+JJ0P7WrrRpkqSW8hhAewwt2k/GgGTTUiykz0quaR2Xsluz+pcNuk8cJ9
	PZfVqu4I7QJsvl97gltrpnq5Doxq2zxy59j6lO7uO5uNxFJIX6HD9twZGQ/7cZ3U
	qfTn30bLxhHxkQEFGYRCjQeiMs/z6XQtq7I+Vbbe71SlCyqva4YmXK/DdIlKrb6k
	fJjZXsXbTIw99b2KkyvPH0gppi4ACePK+tZG8JGeVh337zJydOK9eM7r4ICFYPta
	C8MJPrVcAnW5wzy0o51g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xautfy33v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 09:52:25 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8C68E4002D;
	Wed, 10 Apr 2024 09:52:21 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1DC5C211609;
	Wed, 10 Apr 2024 09:51:28 +0200 (CEST)
Received: from [10.48.86.110] (10.48.86.110) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 10 Apr
 2024 09:51:27 +0200
Message-ID: <4ad98109-9440-4331-b49c-141cc2e08498@foss.st.com>
Date: Wed, 10 Apr 2024 09:51:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/4] dt-bindings: stm32: update DT bingding for
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
References: <20240409171241.274600-1-gabriel.fernandez@foss.st.com>
 <20240409171241.274600-3-gabriel.fernandez@foss.st.com>
 <0fd8811a-03ea-4471-a72d-7138aeb319f5@linaro.org>
Content-Language: en-US
From: Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>
In-Reply-To: <0fd8811a-03ea-4471-a72d-7138aeb319f5@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_02,2024-04-09_01,2023-05-22_02


On 4/10/24 09:06, Krzysztof Kozlowski wrote:
> On 09/04/2024 19:12, gabriel.fernandez@foss.st.com wrote:
>> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>>
> A nit, subject: drop second/last, redundant "DT bindings". (plus a
> typo...) The "dt-bindings" prefix is already stating that these are
> bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
>
> Subject: Everything is an update. Be specific.
ok
>
>> RCC driver uses '.index' to define all parent clocks instead '.names'
>> because the use of a name to define a parent clock is prohibited.
>> This is ABI change, but the RCC driver has not yet merged, unlike all
>> others drivers besides Linux.
>>
>> Fixes: b5be49db3d47 ("dt-bindings: stm32: add clocks and reset binding for stm32mp25 platform")
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>> ---
>>
>> Changes in v10:
>>    - cosmetic change (add change blank line)
>>    - rename USB2 into USBH to be compliant with last Reference Manuel
>>
>> Changes in v9:
>>    - Update DT binding documentation according S.Boyd remarks on RCC driver:
>>      Don't use '.name' to define a parent but use '.index'
>>      Then:
>>        - remove 'clock-names' property
>>        - Add description of all parent clocks used in RCC driver
>>
>>    v9 was Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Please avoid putting full acks somewhere in the changelog. You confuse
> people's filters and maybe tooling as well. "v9 was Acked-by Conor
> Dooley", so a proper sentence, not "fake" ack, would work for everyone.
>
>
> With fixes in the subject:
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thank's

Best regards

Gabriel


> Best regards,
> Krzysztof
>


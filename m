Return-Path: <linux-kernel+bounces-9522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AEA81C6F0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D641F2577D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D19D2E7;
	Fri, 22 Dec 2023 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="6G1tEDCP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E00FBE2;
	Fri, 22 Dec 2023 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BM2PZdm029359;
	Fri, 22 Dec 2023 09:55:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=6K7EDgRoPeNIU6pGeEY5sDhAR+XpZ5VVTKmSc5bq+Rc=; b=6G
	1tEDCPhk8pbY2YBJT2Uv+BV0qhciaE1wl9Fy44m8TqHk3Em7lZLefgoDSHSrZyXS
	wZMfRrSNPvuxNlG08DKfBAFhk3Rzg/NO+/Kh0PmBqiYaptt6q3cO19qx4fMvAg5y
	vS9E4Gc9zSQO26dNpb9lBWKHpQyRJou5vknC12ZocDDD9mPM5CNSf2u7MILgpmfL
	pTcWGwKJ8QaqIxjh/bVZK1rZAyY2h12bHWKKPgEApOdDEVJ5U2H0FqJB3mn1qQDp
	uaICui3Fqp3th65GACnQi1jtIZepj2uRxqXPnXY2isywfMoFmCr9YD6KOKATqQWU
	UBBVBHXsvLz9LSCD6IlQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3v11w9bbx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 09:55:39 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 13F57100069;
	Fri, 22 Dec 2023 09:55:37 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B562120B63A;
	Fri, 22 Dec 2023 09:55:37 +0100 (CET)
Received: from [10.252.15.82] (10.252.15.82) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Dec
 2023 09:55:37 +0100
Message-ID: <024f56fd-6fe2-4a6f-a5a0-2ef06faa653a@foss.st.com>
Date: Fri, 22 Dec 2023 09:55:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v1 2/8] dt-bindings: display: add dt-bindings for
 STM32 LVDS device
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam
 Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Yannick Fertre
	<yannick.fertre@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thierry Reding
	<thierry.reding@gmail.com>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20231221124339.420119-1-raphael.gallais-pou@foss.st.com>
 <20231221124339.420119-3-raphael.gallais-pou@foss.st.com>
 <88834783-5aea-46d2-82cc-dd22cb4473f5@linaro.org>
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <88834783-5aea-46d2-82cc-dd22cb4473f5@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-22_04,2023-12-21_02,2023-05-22_02


On 12/21/23 21:36, Krzysztof Kozlowski wrote:
> On 21/12/2023 13:43, Raphael Gallais-Pou wrote:
>> Add dt-binding file for "st,stm32-lvds" compatible.
>>
>> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
>> ---
> I don't know why this was resend, nothing explains it, but I already
> commented on other version.
>
> Please respond to comments there.
>
> In the future, unless it is obvious resend over 2 weeks, say why you are
> doing it and what changed.

My proxy tends to block every patch after a batch of 4 or 5 patches. Since it
splitted the serie in half I resent it so that the serie could be entirely read
without problems. This explains the resend. I was not sure about putting a short
explanation in the cover letter since it was not related any change in the
serie, but next time I will do so.

Best Regards,

Raphaël


>
> Best regards,
> Krzysztof
>


Return-Path: <linux-kernel+bounces-9517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB9581C6D4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD98281A73
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C338D295;
	Fri, 22 Dec 2023 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="19jzXM/c"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE61BF9DA;
	Fri, 22 Dec 2023 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3BM8gWRR020437;
	Fri, 22 Dec 2023 09:46:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=geMwC/2ntrBKDmWRx2A6oK+EjPDa7RQe5GUkgEu5yMA=; b=19
	jzXM/cdHYRiNxPeaXV9jlu54ksQqvS/HkDVNh9fbrMOGaGAv3jpGrybJL+HhrVuc
	ocFnig6wO69DtuqybcCbfaOs+AF/JAxXEP7PZLRhVpDNOjd9t9yqJUuiqZy57XPF
	qZJUes8XzS+jMRr0K6pm9+dLrV3RQUaYaT6nhGlsdWG9o85usXvA1KdLR9/IOf5A
	AAV39EcbTHmyRo9r962D7sGIy7h9WakKLgeB0OFWPstsbcK4ndsaIHSfH9ZXhE0g
	YfDNeq0WSYQrzHYRfxeARZhE0hTrDrIzcrMjcb35barCTBO+L5sMLgL0ki1sAJQp
	H+H+Omhfylvf2wOt6hPw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3v1442bj0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 09:46:04 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BD515100060;
	Fri, 22 Dec 2023 09:46:00 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6C53A20B23A;
	Fri, 22 Dec 2023 09:46:00 +0100 (CET)
Received: from [10.252.15.82] (10.252.15.82) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Dec
 2023 09:45:59 +0100
Message-ID: <5c5fde3c-8073-430c-b9e6-b3e6d84eddee@foss.st.com>
Date: Fri, 22 Dec 2023 09:45:59 +0100
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
To: Rob Herring <robh@kernel.org>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Jessica Zhang
	<quic_jesszhan@quicinc.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Rob Herring <robh+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        <dri-devel@lists.freedesktop.org>, Conor Dooley
	<conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel
 Vetter <daniel@ffwll.ch>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Thomas
 Zimmermann <tzimmermann@suse.de>,
        Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>,
        Yannick Fertre
	<yannick.fertre@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        David Airlie <airlied@gmail.com>
References: <20231221124339.420119-1-raphael.gallais-pou@foss.st.com>
 <20231221124339.420119-3-raphael.gallais-pou@foss.st.com>
 <170316995910.3869238.14321525013510097521.robh@kernel.org>
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <170316995910.3869238.14321525013510097521.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-22_04,2023-12-21_02,2023-05-22_02

Hi Rob

On 12/21/23 15:45, Rob Herring wrote:
> On Thu, 21 Dec 2023 13:43:33 +0100, Raphael Gallais-Pou wrote:
>> Add dt-binding file for "st,stm32-lvds" compatible.
>>
>> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
>> ---
>>  .../bindings/display/st,stm32-lvds.yaml       | 114 ++++++++++++++++++
>>  1 file changed, 114 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/display/st,stm32-lvds.yaml
>>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/display/st,stm32-lvds.example.dts:18:18: fatal error: dt-bindings/bus/stm32mp25_sys_bus.h: No such file or directory
>    18 |         #include <dt-bindings/bus/stm32mp25_sys_bus.h>
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/display/st,stm32-lvds.example.dtb] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1424: dt_binding_check] Error 2
> make: *** [Makefile:234: __sub-make] Error 2

This is because I forgot to remove this line from the example. I'll remove it in V2.


Thanks,

Raphaël


> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231221124339.420119-3-raphael.gallais-pou@foss.st.com
>
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
>


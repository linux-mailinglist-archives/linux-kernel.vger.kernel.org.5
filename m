Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712E379C9DA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjILI0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjILI0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:26:36 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E172610C4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:26:32 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9a64619d8fbso677003366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694507191; x=1695111991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5o3LzkBLyHb7ofP84O3T9xGsTdDKL8/j5FWm25zteFw=;
        b=PR+YgU3N4yCxY9j0rbS2pJXeLCgdATc58OEc1Em1eSPIAxvS1v670JtG1v9qP1j7lQ
         YzAOBGlRwFQTlC2L7jiE95vvNjhVHD1DvEnIx8OMFu4HB60rQ0Mx0tdeaRVpFaYX4TYg
         pcUAyoNSJlOeo8rxX8yNiNFQeV1SnZoCMdRCFRGS4CGHY918abdEsl9+UtLtlCJixTAD
         ylMeroebflx0TjXp1NZVNxG0TKMxIc93UPNiMcScrhLWRYkAMP/9GDqRCIH9QRyf7Fwp
         WiV1L8VzpyAFObOT9ARzr6uq+zsz09cKezrC8L/ZLpNhi2NAYgH+YRB3HS+IX5rUpeg/
         BApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694507191; x=1695111991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5o3LzkBLyHb7ofP84O3T9xGsTdDKL8/j5FWm25zteFw=;
        b=jk3bJI1pW8JA1Sp7TVDBKqnccJXh6KxJHZc8m/ZNHivSNqoMc+O663Fj6iwMykCaoI
         ikjQh1hl9TDDmHJD9NyI1QNYmD+z3jL5U2ib4DsNzQl/ZbVZ/2qmC+by++fysgmaR/nY
         jSoyeL4/MzU4LCOVgFBwRa/dG868uWAY2PgMBmo6b9VNL4yz6B9N68Wbks/xgNhHGpao
         XYHSH+8EO9w889oLjP8Q7UYOLP61mmHSETzfRSPERMjZtnZ/IW0OiAQdvJ9TOmgwjvQC
         55DzJirtYMG5G1tk3187By7ko0yy0UZSiLLn/Zi19WJQh21jtEpI1iuwOPUvhyF8yFKp
         aMHA==
X-Gm-Message-State: AOJu0YyRe5UGayzXQ//dzvkuG26raor7Arfml5pNXQSDIS1V+F0ubcDf
        RvTf0k8GzC5Y9VGqxsNluragGQ==
X-Google-Smtp-Source: AGHT+IHqm7STNNiZ6wKB/kmgoKnEIxaz707SIPonvtSj0mzlXB6e/6srpKoKgHR5Q0AbiyKegYvMuA==
X-Received: by 2002:a17:906:300f:b0:9a1:b43b:73a0 with SMTP id 15-20020a170906300f00b009a1b43b73a0mr9631960ejz.20.1694507191390;
        Tue, 12 Sep 2023 01:26:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id m5-20020a1709066d0500b0099bd8c1f67esm6485920ejr.109.2023.09.12.01.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 01:26:30 -0700 (PDT)
Message-ID: <32287c0a-e3c1-e474-3c90-913fe2c79879@linaro.org>
Date:   Tue, 12 Sep 2023 10:26:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] arm64: dts: imx8mp: add reserve-memory nodes for DSP
Content-Language: en-US
To:     Iuliana Prodan <iuliana.prodan@nxp.com>,
        "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>
Cc:     linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>
References: <20230911224452.15739-1-iuliana.prodan@oss.nxp.com>
 <20230911224452.15739-3-iuliana.prodan@oss.nxp.com>
 <67de5706-d966-dd71-85c3-c95bc1b72733@linaro.org>
 <c0b32f41-46b4-81ad-9718-5f0856e42cb1@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c0b32f41-46b4-81ad-9718-5f0856e42cb1@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 10:13, Iuliana Prodan wrote:
> On 9/12/2023 10:07 AM, Krzysztof Kozlowski wrote:
>> On 12/09/2023 00:44, Iuliana Prodan (OSS) wrote:
>>> From: Iuliana Prodan <iuliana.prodan@nxp.com>
>>>
>>> Add the reserve-memory nodes used by DSP when the rpmsg
>>> feature is enabled.
>>> These can be later used in a dsp node, like:
>>> dsp: dsp@3b6e8000 {
>>> 	compatible = "fsl,imx8mp-dsp";
>>> 	reg = <0x3b6e8000 0x88000>;
>>> 	mbox-names = "tx0", "rx0", "rxdb0";
>>> 	mboxes = <&mu2 2 0>, <&mu2 2 1>,
>>> 		<&mu2 3 0>, <&mu2 3 1>;
>>> 	memory-region = <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
>>> 		<&dsp_vdev0vring1>, <&dsp_reserved>;
>>> 	status = "okay";
>> Drop this example from commit msg, useless and not really correct.
> Ok, will drop it. But this is a correct example, is just incomplete.

No, status=okay is redundant, thus it is not a correct example.

>>> };
>>>
>>> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
>>> ---
>>>   arch/arm64/boot/dts/freescale/imx8mp.dtsi | 12 ++++++++++++
>>>   1 file changed, 12 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>>> index cc406bb338fe..eedc1921af62 100644
>>> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>>> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
>>> @@ -210,6 +210,18 @@
>>>   		dsp_reserved: dsp@92400000 {
>>>   			reg = <0 0x92400000 0 0x2000000>;
>>>   			no-map;
>> Please test the patches before sending. This does not build.
> 
> I've tested on remoteproc tree, but it seems I missed a bracket when 
> sending upstream. Sorry abut this, will fix it in v2.

No, this is not how testing works. You must test this patch. This means
you tested something, then ported patch to entirely different tree,
resolved conflicts in buggy way and send it without testing. Nope.

> Should I test this on other tree(s)?

You test the patch on the tree you send it. What is the point to test it
on some old code, cherry-pick with bugs and then send?

If you have cross-tree dependencies between subsystem, isn't linux-next
for this?


Best regards,
Krzysztof


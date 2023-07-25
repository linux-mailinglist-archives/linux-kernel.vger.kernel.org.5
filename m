Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E979761F85
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjGYQu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjGYQuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:50:52 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A99268E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:50:04 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36PGmdLC073194;
        Tue, 25 Jul 2023 11:48:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690303719;
        bh=6NLlphFmeLHoLFVU7zhvhvxMb2R93F3Pi/0abu0Rxww=;
        h=Date:Subject:To:References:CC:From:In-Reply-To;
        b=hOQBLEzxFrd1ysTxeJmVwYPHyV6FtbWNU6CaMS5sg+TRNHT7gbGvrlo+FgUPHXlnm
         azrZLbm4ufskp3wk3uCUnIF2yl5QLRhvqcz6jkkjHsWSFqr8KIESXt5hzJ5mljj/Bb
         /vM6czCyzdAFXBkiBYkU9DnwzcUMzwM5RKKETzRM=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36PGmdeT051831
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Jul 2023 11:48:39 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jul 2023 11:48:39 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jul 2023 11:48:39 -0500
Received: from [128.247.81.105] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36PGmdcx065509;
        Tue, 25 Jul 2023 11:48:39 -0500
Message-ID: <de2dbef2-928e-cfcc-cce6-8528f92f26d9@ti.com>
Date:   Tue, 25 Jul 2023 11:48:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/7] arm64: defconfig: Enable MCAN driver
Content-Language: en-US
To:     Udit Kumar <u-kumar1@ti.com>, <vigneshr@ti.com>, <nm@ti.com>
References: <20230725105346.1981285-1-u-kumar1@ti.com>
 <20230725105346.1981285-6-u-kumar1@ti.com>
CC:     <john.garry@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <will@kernel.org>, <linux-kernel@vger.kernel.org>,
        <peng.fan@nxp.com>, <rafal@milecki.pl>, <nfraprado@collabora.com>,
        <catalin.marinas@arm.com>, <onrad.dybcio@linaro.org>,
        <geert+renesas@glider.be>, <quic_bjorande@quicinc.com>,
        <krzysztof.kozlowski@linaro.org>, <arnd@arndb.de>
From:   Judith Mendez <jm@ti.com>
In-Reply-To: <20230725105346.1981285-6-u-kumar1@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Udit,

On 7/25/23 5:53 AM, Udit Kumar wrote:
> From: Judith Mendez <jm@ti.com>
> 
> Enable CAN_M_CAN and CAN_M_CAN_PLATFORM to be built
> as modules by default.
> CAN is used in AM68 SK, J721E EVM, J721S2, AM642
> AM642-Phyboards.
> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
>   arch/arm64/configs/defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 28c03799d1e0..743c165e31a4 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -180,6 +180,8 @@ CONFIG_NET_ACT_GATE=m
>   CONFIG_QRTR_SMD=m
>   CONFIG_QRTR_TUN=m
>   CONFIG_CAN=m
> +CONFIG_CAN_M_CAN=m
> +CONFIG_CAN_M_CAN_PLATFORM=m
>   CONFIG_BT=m
>   CONFIG_BT_HIDP=m
>   # CONFIG_BT_LE is not set

Was about to send this patch as well. Thanks for sending!

~ Judith

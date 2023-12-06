Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383668074BE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378547AbjLFQSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjLFQSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:18:50 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593DA137;
        Wed,  6 Dec 2023 08:18:56 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B6GIJLx088042;
        Wed, 6 Dec 2023 10:18:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1701879499;
        bh=o8k7eGFtoMezBwtUBHQy6rA3Wv33CQWFzU0yo+yPsxA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=bInn8XiCOl6vXU6gl5/6mdK5fdPl3opo+vo08f+YhoVB+pK0JtgE2s4mRoCzBrPCa
         sOunxrdtEsSYxiSjb6mWJv8oXJGjnV4fivycMZWuV1yaTUQalMMfbD+pOXRO8tqrdd
         dy5JpUbmkLzAi/17SpxyHVjjBEakk5MMBVUyFeN4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B6GIJk6023441
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Dec 2023 10:18:19 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Dec 2023 10:18:19 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Dec 2023 10:18:19 -0600
Received: from [10.250.36.90] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B6GIIQx029108;
        Wed, 6 Dec 2023 10:18:18 -0600
Message-ID: <b3064dfc-5420-4868-89f6-bb962cf9e7c9@ti.com>
Date:   Wed, 6 Dec 2023 10:18:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Enable PowerVR driver for TI AM62x
Content-Language: en-US
To:     Donald Robson <donald.robson@imgtec.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <frank.binns@imgtec.com>, <matt.coster@imgtec.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <quic_bjorande@quicinc.com>, <geert+renesas@glider.be>,
        <konrad.dybcio@linaro.org>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <m.szyprowski@samsung.com>,
        <u-kumar1@ti.com>, <peng.fan@nxp.com>
References: <cover.1701773390.git.donald.robson@imgtec.com>
From:   "Etheridge, Darren" <detheridge@ti.com>
In-Reply-To: <cover.1701773390.git.donald.robson@imgtec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/2023 5:39 AM, Donald Robson wrote:
> These patches enable the new open source PowerVR driver for TI AM62x SoCs,
> currently the only one supported.
> 
> Changes since v1:
> - Added patch 1 for arm64 defconfig (requested by Nishanth Menon)
> 
> Donald Robson (1):
>    arm64: defconfig: enable DRM_POWERVR
> 
> Sarah Walker (1):
>    arm64: dts: ti: k3-am62-main: Add GPU device node
> 
For the series:

Acked-by: Darren Etheridge <detheridge@ti.com>


Thanks,
Darren

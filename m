Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A128109CC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 07:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378544AbjLMGCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 01:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbjLMGC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 01:02:29 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7305F91;
        Tue, 12 Dec 2023 22:02:34 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BD62Ulh099471;
        Wed, 13 Dec 2023 00:02:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702447350;
        bh=JVaOET4SJOg/lLNlV+MYLanlmdf9jNBPsHy38R8wKQI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=NVR/z3Y5O5mbF2Lxm/VlDBcjaaOqJvdjiHYN+hluP5X/kCO+3x9sGfIVFKrKz6iIa
         hUZgsB4ps5VM6wHPi6p0tH0f0AZ8XBhLfeStlypQK8hH1IoRk7GLDCc7HLWgSd4+I+
         NvzlTgzi4JWSZdlIYSDYSBasY6siQUzIQpMUddPE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BD62TDf004116
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Dec 2023 00:02:29 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Dec 2023 00:02:29 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Dec 2023 00:02:29 -0600
Received: from [10.249.138.31] ([10.249.138.31])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BD62Qn6130056;
        Wed, 13 Dec 2023 00:02:27 -0600
Message-ID: <1f4bed4e-12e0-4c82-a4fe-a8dee7053a1b@ti.com>
Date:   Wed, 13 Dec 2023 11:32:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Add PSIL threads for AM62P
Content-Language: en-US
To:     Bryan Brattlof <bb@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Vaishnav Achath <vaishnav.a@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DMA Engine <dmaengine@vger.kernel.org>
References: <20231212203655.3155565-2-bb@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20231212203655.3155565-2-bb@ti.com>
Content-Type: text/plain; charset="UTF-8"
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



On 13/12/23 2:06 am, Bryan Brattlof wrote:
> From: Vignesh Raghavendra <vigneshr@ti.com>
> 
> Add PSIL and PDMA data for AM62P.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  drivers/dma/ti/Makefile        |   3 +-
>  drivers/dma/ti/k3-psil-am62p.c | 196 +++++++++++++++++++++++++++++++++

Does this also include J722s data? I prefer if we could introduce both
SoC support together as one is superset of the other. Vaishav?

Regards
Vignesh

[...]

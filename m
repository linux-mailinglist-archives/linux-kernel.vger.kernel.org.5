Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379AB7880A7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239368AbjHYHKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243014AbjHYHKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:10:01 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5D91B2;
        Fri, 25 Aug 2023 00:09:58 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37P3aE1u014750;
        Fri, 25 Aug 2023 09:09:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=MDkalMNBjUowOXiPQHgwxlnVRmYOYGag+qE9vvVRST0=; b=ky
        3GDz677qACDSvjVCC4/BauiwA4RCBzaiIWIHCHP2dao5n4Zu9x6rrNLcFj2qUno7
        o5YmvWPwhfx5hRWA6nwxkRm8jxHtTpPpRu2aA/DIqctdKAHhWkqvKwocpEd3xb9e
        CFFJ0OqT25n0vbL7ZzduuWqKAfDlNav4QgmidALKD8CD4MNMJn1sN3E73DXly1Ph
        jPZKtuLyrWIQ2ukSkPCDztGfxnrNYFel3WLPz/8pagSkRfyDur1Kbg8b+wFS0zNG
        amCSzpkrnmkHm6ehkAnYoxauB0fd6LjsLgu+qGmSCan2FZnzg5qQI3DixVFGaZc+
        8Z6XjQIuXwM0nx6f0r/Q==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3spmhs8m88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 09:09:29 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E5D9B100059;
        Fri, 25 Aug 2023 09:09:28 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D1F88214D36;
        Fri, 25 Aug 2023 09:09:28 +0200 (CEST)
Received: from [10.201.21.122] (10.201.21.122) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 25 Aug
 2023 09:09:28 +0200
Message-ID: <dbf33e7f-92e0-71ec-3bd4-ffa150c80e71@foss.st.com>
Date:   Fri, 25 Aug 2023 09:09:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 9/9] ARM: dts: stm32: Add Octavo OSD32MP1-RED board
Content-Language: en-US
To:     Sean Nyekjaer <sean@geanix.com>, <l.goehrs@pengutronix.de>,
        <a.fatoum@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <dantuguf14105@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230816122435.3153513-1-sean@geanix.com>
 <20230816122435.3153513-9-sean@geanix.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230816122435.3153513-9-sean@geanix.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_04,2023-08-24_01,2023-05-22_02
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean

On 8/16/23 14:24, Sean Nyekjaer wrote:
> Add support for the Octavo OSD32MP1-RED development board.
> 
> General features:
>   - STM32MP157C
>   - 512MB DDR3
>   - CAN-FD
>   - HDMI
>   - USB-C OTG
>   - UART
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> Reviewed-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---

Series applied on stm32-next (Queued for v6.7).

Thanks

Alex

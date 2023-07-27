Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819747653E0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbjG0M2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbjG0M2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:28:10 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06C1B6;
        Thu, 27 Jul 2023 05:27:52 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36RCRVmG096167;
        Thu, 27 Jul 2023 07:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690460852;
        bh=IWBlGzgI1L9ao+widI/hYD7CbAqUuNS9xLpskj1aBsg=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=jDAjwdJA2fRfCqdJw21QVAE7gN8Ca4euPmT708t7pHMBGLrWDQqW4Bzxw8MwrJ0JB
         +Pm6/jgI9js2tyk0ku+NmFKlf0SWkPfIQk1OPTknJ4wF03qbn0+VjB8dcx9c6bAeQJ
         nw7JJEK7iFU7ZJzmhlpjd2iBigX7rYMPzaijEuPs=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36RCRV7a051564
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Jul 2023 07:27:31 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jul 2023 07:27:31 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jul 2023 07:27:31 -0500
Received: from [172.24.227.6] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36RCRO4b011975;
        Thu, 27 Jul 2023 07:27:25 -0500
Message-ID: <afa6bb31-6ffb-32e6-a56d-783f613af84d@ti.com>
Date:   Thu, 27 Jul 2023 17:57:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] dt-bindings: media: Add bindings for Imagination
 E5010 JPEG Encoder driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hverkuil-cisco@xs4all.nl>, <laurent.pinchart@ideasonboard.com>,
        <eugen.hristev@collabora.com>, <ezequiel@vanguardiasur.com.ar>,
        <u.kleine-koenig@pengutronix.de>, <sakari.ailus@linux.intel.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <a-bhatia1@ti.com>, <j-luthra@ti.com>, <b-brnich@ti.com>,
        <detheridge@ti.com>, <p-mantena@ti.com>, <vijayp@ti.com>
References: <20230727112546.2201995-1-devarsht@ti.com>
 <20230727112546.2201995-2-devarsht@ti.com>
 <d6217fc3-e5f8-b629-2eac-4a778452ce74@linaro.org>
From:   Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <d6217fc3-e5f8-b629-2eac-4a778452ce74@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for the quick review.

On 27/07/23 17:33, Krzysztof Kozlowski wrote:
> On 27/07/2023 13:25, Devarsh Thakkar wrote:
>> Add dt-bindings for Imagination E5010 JPEG Encoder driver which is
>> implemented as stateful V4L2 M2M driver.
>>
>> Co-developed-by: David Huang <d-huang@ti.com>
>> Signed-off-by: David Huang <d-huang@ti.com>
>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>> ---
>> V2: No change, just sending this together with driver and cover-letter
> 
> So all other comments get ignored? Yeah, I see.
> 

Sorry my bad, I somehow missed to notice you had replied already due to some
bad filtering of emails. I will check your comments and get back.

Regards
Devarsh

> This is a friendly reminder during the review process.
> 
> It seems my previous comments were not fully addressed. Maybe my
> feedback got lost between the quotes, maybe you just forgot to apply it.
> Please go back to the previous discussion and either implement all
> requested changes or keep discussing them.
> 
> Thank you.
> 
> Best regards,
> Krzysztof
> 

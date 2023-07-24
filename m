Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B3275FBFC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjGXQZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjGXQZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:25:25 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6681BC;
        Mon, 24 Jul 2023 09:25:24 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36OGP7M2010507;
        Mon, 24 Jul 2023 11:25:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690215907;
        bh=U+pPuX5Coef6/bKDGzORFYj5omAP9JcFhBNBXz4nHEY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=zB4CKsEyPbZ8GKhcSKoN1ndD8tNLXoFyNTzD5HWu30mcgy9tnPxEm35QjSPElvikm
         RnxfCkdoyySOPJDUGtiRh0QDSAdfy0i0PiVMBh/Aj8rp5w7+uMPTSG/f8Hxuh4ppLO
         oYyhZpiIUMJVn9Mln2eUgUgBRlb5KVx4RCUu455g=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36OGP7RY077525
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Jul 2023 11:25:07 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Jul 2023 11:25:07 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Jul 2023 11:25:07 -0500
Received: from [128.247.81.105] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36OGP7DB040911;
        Mon, 24 Jul 2023 11:25:07 -0500
Message-ID: <b48858f4-2904-fddf-fe9e-61100ba1a122@ti.com>
Date:   Mon, 24 Jul 2023 11:25:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/2] arm64: dts: ti: k3-am62: Add MCU MCAN nodes
Content-Language: en-US
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
References: <20230724133612.37366-1-francesco@dolcini.it>
 <20230724133612.37366-2-francesco@dolcini.it>
 <42044653-cc22-131a-bf1b-e68ddfa0ff9d@ti.com>
 <ZL6lVGklNclkVu58@francesco-nb.int.toradex.com>
From:   Judith Mendez <jm@ti.com>
In-Reply-To: <ZL6lVGklNclkVu58@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

Hi Francesco,

On 7/24/23 11:22 AM, Francesco Dolcini wrote:
> Hello Judith,
> 
> On Mon, Jul 24, 2023 at 11:06:24AM -0500, Judith Mendez wrote:
>> On 7/24/23 8:36 AM, Francesco Dolcini wrote:
>>> From: Judith Mendez <jm@ti.com>
>>>
>>> On AM62x there are no hardware interrupts routed to A53 GIC
>>> interrupt controller for MCU MCAN IPs, so MCU MCAN nodes were
>>> omitted from MCU dtsi.
>>>
>>> Timer polling was introduced in commits [1][2] so now add MCU MCAN nodes
>>> to the MCU dtsi for the Cortex A53.
>>>
>>> [1] b382380c0d2d ("can: m_can: Add hrtimer to generate software interrupt")
>>> [2] bb410c03b999 ("dt-bindings: net: can: Remove interrupt properties for MCAN")
>>>
>>> Signed-off-by: Judith Mendez <jm@ti.com>
>>> [fd: fixed labels to match datasheet numbering, revised commit message,
>>>        fixed reg/reg-names order]
>>> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>>> ---
> 
> ...
> 
>> Thanks for sending this patch, will also send for AM62ax.
> 
> Please have a look at the couple of changes I did:
>   - corrected the label to be coherent with the datasheet and the other
>     peripheral names
>   - inverted "m_can" and "message_ram" regs/regs-names to fix a binding
>     checker error.
> 
> These might be relevant also for the AM62a.

Yes, already did. The changes look good to me, tested and everything 
works on AM62x. Did the same changes to AM62ax MCU dtsi. Thanks!

~ Judith

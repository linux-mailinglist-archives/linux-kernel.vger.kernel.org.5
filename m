Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6D7772CD1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjHGRZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjHGRZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:25:56 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DAFE67;
        Mon,  7 Aug 2023 10:25:54 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 377HPl04011321;
        Mon, 7 Aug 2023 12:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691429147;
        bh=LfENCgN+IImSktt1Uhld80rys0xsgjA5RPZ6MWSRcik=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=bA+Vuv9Sm8N5FcIUhjoWfwRecpu+iov+HlfO9U+7Q+LAG9zNwWyMQpdmcK64b/SE+
         f5CIZRGSQFpUruuPptsLRenk68ZuQd0R2783gKjVsF6HW0F/rSKvSHO7MzdewPquyM
         Yj8CQyyDliAuwRRzwZhiC2YsMDdYusFoszKYZKsQ=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 377HPluX059546
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 12:25:47 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 12:25:47 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 12:25:47 -0500
Received: from [10.24.69.34] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 377HPh4X002900;
        Mon, 7 Aug 2023 12:25:44 -0500
Message-ID: <ef020531-e7b9-4666-0ea2-dd5c4803234b@ti.com>
Date:   Mon, 7 Aug 2023 22:55:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-j784s4-mcu-wakeup: Add
 bootph-pre-ram property for SPL nodes
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     "Kumar, Udit" <u-kumar1@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hari Nagalla <hnagalla@ti.com>
References: <20230806164838.18088-1-a-nandan@ti.com>
 <20230806164838.18088-3-a-nandan@ti.com>
 <3a2d1880-10aa-ac19-24e1-b2f697bc1a73@ti.com>
 <ef834d0b-b13a-5c3d-6c1d-088006fdfa32@ti.com>
 <20230807172132.7e4qux3f72zyfd33@mocker>
From:   Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <20230807172132.7e4qux3f72zyfd33@mocker>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/08/23 22:51, Nishanth Menon wrote:
> On 22:43-20230807, Apurva Nandan wrote:
> [..]
>
>>> mcu_timer0: timer@40400000 should be part of your list.
>> Maybe you are referring to mcu_timer1. mcu_timer1 will be a part of
>> u-boot.dtsi as we need to edit
>> the node for removing k3_clks and power-domains properties from it. So we
>> should add bootph-pre-ram
>> there itself in uboot.dtsi as the node will be already there.
> a) you need the timer even before talking to anything - u-boot needs it
> for basic delay - so add the pre-ram property.
> b) what you are doing in u-boot currently a hack - am625 in u-boot got
> it fixed the right way - follow the model then you dont need the hackery
> with deleting clock and power-domains properties.
>
Okay, thanks!

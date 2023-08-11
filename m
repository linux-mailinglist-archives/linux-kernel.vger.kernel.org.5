Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6ED57796A2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 20:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbjHKSFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 14:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbjHKSFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:05:40 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5B930D0;
        Fri, 11 Aug 2023 11:05:40 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BI5UZ4055481;
        Fri, 11 Aug 2023 13:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691777130;
        bh=0ip2uvqMwMwA+IpTP06n3f3fb7xVBAnrvfzUfhX/ezA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=OwHo5a/B1JrS6ez8MtMOHabWjZVix0lajc0BjxIlCmtEKzxq7G2Gi5F8U45Mtm7CL
         HGAw9mjHQNHaQP3rzeNOBZC2e91B2P7omYOwwXhcJKLOkct4iBCuV6ZzheK90yV+GB
         opRV9EmUMIAn9I+VgqOjKBR5GBcS6ypS/riccoKg=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BI5UAx018256
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 13:05:30 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 13:05:30 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 13:05:30 -0500
Received: from [10.249.141.75] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BI5QSE008841;
        Fri, 11 Aug 2023 13:05:27 -0500
Message-ID: <f41102bb-134a-50cc-bb98-7950260c7aa6@ti.com>
Date:   Fri, 11 Aug 2023 23:35:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 3/3] arm64: dts: ti: k3-am69-sk: Add phase tags marking
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Apurva Nandan <a-nandan@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hari Nagalla <hnagalla@ti.com>,
        Dasnavis Sabiya <sabiya.d@mistralsolutions.com>
References: <20230811151644.3216621-1-a-nandan@ti.com>
 <20230811151644.3216621-4-a-nandan@ti.com>
 <638d5883-5b95-403e-ecb9-8122d8774675@ti.com>
 <20230811175459.nxi65bu4bbjki5xe@duller>
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230811175459.nxi65bu4bbjki5xe@duller>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/11/2023 11:24 PM, Nishanth Menon wrote:
> On 23:05-20230811, Kumar, Udit wrote:
>> Hi Apurva
>>
>> On 8/11/2023 8:46 PM, Apurva Nandan wrote:
>>> bootph-all as phase tag was added to dt-schema
>>> (dtschema/schemas/bootph.yaml) to cover U-Boot challenges with DT.
>>> That's why add it also to Linux to be aligned with bootloader requirement.
>>>
>>> wkup_uart0, wkup_i2c0, mcu_uart0, main_uart8, main_sdhci0 and main_sdhci1
>>> are required for bootloader operation on TI K3 AM69-SK EVM. These IPs
>>> along with pinmuxes need to be marked for all bootloader phases, hence add
>>> bootph-all to these nodes in kernel dts.
>>>
>>> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
>>> ---
>>> [...]
>>>    &wkup_uart0 {
>>> +	bootph-all;
>>>    	/* Firmware usage */
>>>    	status = "reserved";
>>>    	pinctrl-names = "default";
>> I am not sure, if you want to treat wkup_uart in same way as you are
>> treating secure_proxy_mcu in patch 1 of this series.
> You should'nt. wkup_uart0 or what ever peripherals are specifically
> board dependent. This patch does it the right way. I do have other
> platforms on other K3 SoCs where the TIFS uart logs are actually
> disabled.

Sorry, if i was not clear in my previous response.

This node is marked as reserved, adding bootph is not adding any value.

We can drop bootph from this node here.

>> IMO, where we are making this node status is okay, mark booth-all at that
>> place only.
>>
>> Otherwise for rest of series
>>
>> LGTM
> Do i take that as a Reviewed-by: for the series?


With above change,

Reviewed-by: Udit Kumar <u-kumar1@ti.com>

>>
> [...]
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A43E7A87FC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbjITPOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbjITPO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:14:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDDEA1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 08:14:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E69C433C7;
        Wed, 20 Sep 2023 15:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695222863;
        bh=US0SAylhHjSsU0gUBHB9ewTD8IhR8dxZrCpzZnZdmLY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oNh/bV0QG0mjI0qPwdgdG2wlEXxpspFr4gZxZepZPL3s5/gVDLewwq2zb2YtxjM73
         wktaPVc0X3GTV+jRb8HsYAVQrPFu2o2dAkQlpWRsWW4gzK8Q52Z56U9F9lj4dTHJxw
         aAnN9i+8o1JQ1bJKHuuwNK1W3t4bjUtYD9RhSsmoM2SjQVNfZTtMCpxJTw29olNrP4
         xhJSnJ0KePDsKyB09ZW1JmuDfuoT7/8WDHoSSje2WXnJP7+HC5MqGYfhvMIKTbZJob
         HEX/EU+t815piZPlN1Tpo+8diWtYyGlq9TkAaNhVrRXCpi/c/WfI5EU5eiHVNZrrxL
         SntHls165iiNg==
Message-ID: <2c179d6e-7427-46a1-ae31-d0a48b0c2723@kernel.org>
Date:   Wed, 20 Sep 2023 18:14:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: ti: Enable support for overlays for
 relevant boards
To:     Nishanth Menon <nm@ti.com>
Cc:     vigneshr@ti.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, srk@ti.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230920133450.54226-1-rogerq@kernel.org>
 <20230920133450.54226-2-rogerq@kernel.org>
 <20230920135722.tl2yupwpffa3ryfy@jaunt>
Content-Language: en-US
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230920135722.tl2yupwpffa3ryfy@jaunt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/09/2023 16:57, Nishanth Menon wrote:
> On 16:34-20230920, Roger Quadros wrote:
>> Enable __symbols__ in board DT files for which we expect
>> overlays to be supported.
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  arch/arm64/boot/dts/ti/Makefile | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
>> index e7b8e2e7f083..06d6f264f292 100644
>> --- a/arch/arm64/boot/dts/ti/Makefile
>> +++ b/arch/arm64/boot/dts/ti/Makefile
>> @@ -72,8 +72,16 @@ dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
>>  dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
>>  
>>  # Enable support for device-tree overlays
>> +DTC_FLAGS_k3-am625-beagleplay += -@
>>  DTC_FLAGS_k3-am625-sk += -@
>>  DTC_FLAGS_k3-am62-lp-sk += -@
>> +DTC_FLAGS_k3-am62a7-sk += -@
>> +DTC_FLAGS_k3-am642-evm += -@
>> +DTC_FLAGS_k3-am654-base-board += -@
>>  DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
>> +DTC_FLAGS_k3-am68-sk-base-board += -@
>> +DTC_FLAGS_k3-am69-sk += -@
>>  DTC_FLAGS_k3-j721e-common-proc-board += -@
>> +DTC_FLAGS_k3-j721e-sk += -@
>>  DTC_FLAGS_k3-j721s2-common-proc-board += -@
>> +DTC_FLAGS_k3-j784s4-evm += -@
> 
> is'nt it better to do it in context of the changes introduced?
> 

Do you mean I should just add for the particular platform when
adding an overlay for that platform?

-- 
cheers,
-roger

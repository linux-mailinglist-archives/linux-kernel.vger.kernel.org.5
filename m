Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F187AD06E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjIYGql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjIYGqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:46:39 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6101A2;
        Sun, 24 Sep 2023 23:46:32 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38P6kGkP120342;
        Mon, 25 Sep 2023 01:46:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695624376;
        bh=QoIgG0V0wPf7ta+/gsqph37FoO472Qkc4LqHrLL8lrg=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=VF2wz+aqJVfXLcTapBVsKGiBIS2sWULmWJLNVPefO4rbwwG9r4f1FxbxrZzqF6T50
         x9Fi08ZdwoKvoDesNaz2XZcKCfAh57AvbgDDqB6coOGOG9Fkplgd0SGPlK2EFxggT8
         PPm14KM90AF/AjOA+n508M/ghXNHUR9EOhH8gJAY=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38P6kGcb052218
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Sep 2023 01:46:16 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Sep 2023 01:46:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Sep 2023 01:46:16 -0500
Received: from [172.24.227.112] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38P6kB68004744;
        Mon, 25 Sep 2023 01:46:11 -0500
Message-ID: <427dc37e-1bf5-d3d7-f4af-1a0ee980f28b@ti.com>
Date:   Mon, 25 Sep 2023 12:16:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v9 3/5] arm64: dts: ti: k3-j784s4-main: Add DSS and
 DP-bridge node
Content-Language: en-US
To:     Maxime Ripard <mripard@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        <r-ravikumar@ti.com>
CC:     <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <rogerq@kernel.org>,
        <s-vadapalli@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <a-bhatia1@ti.com>, <sabiya.d@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230803080441.367341-1-j-choudhary@ti.com>
 <20230803080441.367341-4-j-choudhary@ti.com>
 <aqfx7fj446gkyirhsiwijiuilhoao4hexmpjfxu4gojpujhbib@2wqzjuh3yz46>
From:   Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <aqfx7fj446gkyirhsiwijiuilhoao4hexmpjfxu4gojpujhbib@2wqzjuh3yz46>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Maxime,

On 17/08/23 16:24, Maxime Ripard wrote:
> Hi,
> 
> On Thu, Aug 03, 2023 at 01:34:39PM +0530, Jayesh Choudhary wrote:
>> From: Rahul T R <r-ravikumar@ti.com>
>>
>> Add DSS and DP-bridge node for J784S4 SoC. DSS IP in J784S4 is
>> same as DSS IP in J721E, so same compatible is being used.
>> The DP is Cadence MHDP8546.
>>

[...]

>> +
>> +	dss: dss@4a00000 {
>> +		compatible = "ti,j721e-dss";
> 
> As far as I can see, this compatible limits the (DPI) pixel clock to
> 160MHz, but the TRM seems to mention that it's 600MHz?
> 
> Is it expected?
> 
I am unsure about why the max DPI pixel clock was set to 170MHz for
videoport bus type DISPC_VP_DPI.
Bus type DISPC_VP_DPI is used only for tfp410 bridge which can support
min 6.06ns pixel period (165MHz pixel clk).
I think the max value however should still be independent to what the
bridge can support.
We can look into this issue independent to this series.

Tomi,
Any comments here..
There should not be any issue making the max pixel clock for DPI bus 
type 600 MHz as well????


-Jayesh


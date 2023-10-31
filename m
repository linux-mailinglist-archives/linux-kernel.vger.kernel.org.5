Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BB47DD25E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345498AbjJaQmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346703AbjJaQlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:41:42 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB9330E5;
        Tue, 31 Oct 2023 09:39:27 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39VGc99a004710;
        Tue, 31 Oct 2023 11:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1698770289;
        bh=rMxQobL2C9Ih5ynT2fDAXkMqW1vSAxnXsdaxx4aMauw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Gl3UBQWyuntZv13eEWHDFlxwPnMUlvRRiMdggQvN7fwlmJcG+djBrJlocN1yp3H8e
         YWqPV7e8WPpeX0ZIWxjzp2aLh4ff9/lr10HdPwdcO55nBoDs+aXQA4SGhoCtIsYwXc
         21hV586kBu/5irnQAcKG6muKXMyp9P/qIRi1Yur4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39VGc9I8127636
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 31 Oct 2023 11:38:09 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 31
 Oct 2023 11:38:09 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 31 Oct 2023 11:38:09 -0500
Received: from [10.249.132.69] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39VGc5E6011960;
        Tue, 31 Oct 2023 11:38:06 -0500
Message-ID: <5d251b55-7050-c212-c262-49127f86f32c@ti.com>
Date:   Tue, 31 Oct 2023 22:08:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] scripts/dtc: Allow ports to have a single port@0 child
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     Frank Rowand <frowand.list@gmail.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20231013085424.7137-1-a-bhatia1@ti.com>
 <20231025193113.GA994152-robh@kernel.org>
From:   Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20231025193113.GA994152-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26-Oct-23 01:01, Rob Herring wrote:
> On Fri, Oct 13, 2023 at 02:24:24PM +0530, Aradhya Bhatia wrote:
>> Exempt 'ports' from the rule which asserts that nodes with single child
>> node having reg = 0, should not have the '#size-cells' and
>> '#address-cells' properties.
>>
>> Ports of certain hardware do need to be described as only having a
>> single child node 'port@0', especially when hardware has multiple ports,
>> and the other ports 'port@x' are planned to be added subsequently. In
>> such cases, just using 'port', would be an inaccurate hardware
>> description.
>>
>> For example, Texas Instruments' DSS (display-subsystem), which has 2 or
>> 4 video ports depending on the SoC. Describing the first video port with
>> just 'port' under ports would be inaccurate and even slightly
>> misleading. Simply using port@0 (when other ports are not added)
>> produces the following warning, while making dtbs with W=1 flag set[0].
> 
> There's a reason this is behind W=1.
> 
> In general, if you only have a single 'port' it should be just 'port' 
> which is equivalent to port 0. There's exceptions to that, so the 
> warning is off by default.

Thank you for reviewing the patch, Rob!

I had a discussion offline, and I agree that the patch may not be needed
after all.

Moreover, upon looking at the tests provided in upstream dtc tree, I
also realized that the check is exclusively limited to port@0, and does
not include any random 'child@0'. This makes the patch make a lot less
sense too.

Regards
Aradhya

> 
>> code-block ::
>>
>> 	Warning (graph_child_address): /bus@100000/dss@4a00000/ports:
>> 	graph node has single child node 'port@0',
>> 	#address-cells/#size-cells are not necessary
>>
>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>>
>> [0]: https://lore.kernel.org/all/570903b6-8239-d44a-5fac-71700804cb5d@ti.com/
>> ---
>>  scripts/dtc/checks.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> This is a copy of upstream dtc. We don't take patches for it (except in 
> emergency). Look at the commit history.
> 
> Rob


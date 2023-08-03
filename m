Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A1A76E060
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 08:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbjHCGhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 02:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbjHCGhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 02:37:37 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA9BE7D;
        Wed,  2 Aug 2023 23:37:31 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3736bHYX037654;
        Thu, 3 Aug 2023 01:37:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691044637;
        bh=XTJHQTX9oTSDJbXWxKq+IbGES7RZW2UA3rcyNMb1hcg=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=JfEFqPGHU+OY6XH0IdXjOlFc2FZkb1PfC83BfNbNS6BvsFpW2prjqxCM1FUighTra
         dXUls1oQFlZ2Njz9urTbUDX9vjNs8tsaqNaiHjSttX5KLV+50aC/7KrvSmzxD9cCFN
         E34z8rODsezRpaAYEpXp+cEPjyUF5x7LYhYrDgJc=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3736bHBK129550
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Aug 2023 01:37:17 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Aug 2023 01:37:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Aug 2023 01:37:16 -0500
Received: from [10.249.128.142] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3736bBqQ014193;
        Thu, 3 Aug 2023 01:37:12 -0500
Message-ID: <0b7b6632-9c0c-2dd1-287a-bc1be72f9446@ti.com>
Date:   Thu, 3 Aug 2023 12:07:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 6/8] arm64: dts: ti: k3-am625-beagleplay: Add DSS
 pinmux info
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20230728173438.12995-1-a-bhatia1@ti.com>
 <20230728173438.12995-7-a-bhatia1@ti.com>
 <20230730163323.fp62ehguxz4u4s7l@manhole>
From:   Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20230730163323.fp62ehguxz4u4s7l@manhole>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30-Jul-23 22:03, Nishanth Menon wrote:
> On 23:04-20230728, Aradhya Bhatia wrote:
> [...]
> 
>> +&dss {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&dss0_pins_default &oldi0_pins_default>;
> 
> Same - 
> pinctrl-0 = <&dss0_pins_default>, <&oldi0_pins_default>;

Thanks! Will fix this for both the patches in next version!

>> +};
>> -- 
>> 2.40.1
>>
> 

Regards
Aradhya

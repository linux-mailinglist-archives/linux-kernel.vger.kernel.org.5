Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D587E7D156E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 20:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377976AbjJTSGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 14:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377925AbjJTSGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 14:06:08 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C61CD55;
        Fri, 20 Oct 2023 11:06:05 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39KI5gRV001704;
        Fri, 20 Oct 2023 13:05:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697825142;
        bh=Tt/fIyWx2eVjmIhHw49aSnaSV1HhVIsOz95Owu+KIcw=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=eSLjZ+TKBH/7J8GgW7943gSNsFfqyqyQ0aUX9mlYjT9MhdjKYlXojZuz0/kJ1o+dO
         1BtEyD/l4c4GpijdPlGc8KXn7FzzzjOYjlYfVfwQkiwQFCAQkgFKwAnGhIvPxJmWhx
         8+IbBYbp/cwM9cvnJNI+wred6fKKo8/ZJX7QJZ4A=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39KI5gPG102663
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Oct 2023 13:05:42 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 20
 Oct 2023 13:05:42 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 20 Oct 2023 13:05:42 -0500
Received: from [10.249.130.150] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39KI5ZCX072364;
        Fri, 20 Oct 2023 13:05:36 -0500
Message-ID: <2046f9ad-b5c2-bc42-03de-6254d6ed92d3@ti.com>
Date:   Fri, 20 Oct 2023 23:35:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v2] net: ethernet: ti: davinci_mdio: Update K3
 SoCs list for errata i2329
To:     Nishanth Menon <nm@ti.com>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <rogerq@kernel.org>, <andrew@lunn.ch>,
        <f.fainelli@gmail.com>, <horms@kernel.org>,
        <linux-omap@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>
References: <20231020111738.14671-1-r-gunasekaran@ti.com>
 <20231020122359.vwia7sxrcjyeo3ov@pushover>
Content-Language: en-US
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20231020122359.vwia7sxrcjyeo3ov@pushover>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/2023 5:53 PM, Nishanth Menon wrote:
> On 16:47-20231020, Ravi Gunasekaran wrote:
>> The errata i2329 affects certain K3 SoC versions. The k3-socinfo.c
>> driver generates the revision string for different variants of the
>> same SoC in an incremental fashion. This is not true for all SoCs.
>> An example case being J721E, for which the actual silicon revision
>> names are 1.0, 1.1 for its variants, while the k3-socinfo.c driver
>> interprets these variants as revisions 1.0, 2.0 respectively,
>> which is incorrect.
>>
>> While the work to fixup the silicon revision string is posted
>> to the soc tree, this patch serves as a fail-safe step by maintaining
>> a list of correct and incorrect revision strings, so that the fixup
>> work does not break the errata workaround for such corrected SoCs.
>>
>> The silicon revisions affected by the errata i2329 can be found under
>> the MDIO module in the "Advisories by Modules" section of each
>> SoC errata document listed below
>>
>> AM62x: https://www.ti.com/lit/er/sprz487c/sprz487c.pdf
>> AM64X: https://www.ti.com/lit/er/sprz457g/sprz457g.pdf
>> AM65X: https://www.ti.com/lit/er/sprz452i/sprz452i.pdf
>> J7200: https://www.ti.com/lit/er/sprz491d/sprz491d.pdf
>> J721E: https://www.ti.com/lit/er/sprz455d/sprz455d.pdf
>> J721S2: https://www.ti.com/lit/er/sprz530b/sprz530b.pdf
>>
>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>> ---
>>
>> Changes since v1:
>> * For J721E, retained the incorrect SR ID and added the correct one
>> * Add AM65x SR2.1 to the workaround list
>>
>> v1: https://lore.kernel.org/all/20231018140009.1725-1-r-gunasekaran@ti.com/
>>
>>  drivers/net/ethernet/ti/davinci_mdio.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
>> index 628c87dc1d28..25aaef502edc 100644
>> --- a/drivers/net/ethernet/ti/davinci_mdio.c
>> +++ b/drivers/net/ethernet/ti/davinci_mdio.c
>> @@ -516,9 +516,11 @@ static const struct soc_device_attribute k3_mdio_socinfo[] = {
>>  	{ .family = "AM64X", .revision = "SR2.0", .data = &am65_mdio_soc_data },
>>  	{ .family = "AM65X", .revision = "SR1.0", .data = &am65_mdio_soc_data },
>>  	{ .family = "AM65X", .revision = "SR2.0", .data = &am65_mdio_soc_data },
>> +	{ .family = "AM65X", .revision = "SR2.1", .data = &am65_mdio_soc_data },
>>  	{ .family = "J7200", .revision = "SR1.0", .data = &am65_mdio_soc_data },
>>  	{ .family = "J7200", .revision = "SR2.0", .data = &am65_mdio_soc_data },
>>  	{ .family = "J721E", .revision = "SR1.0", .data = &am65_mdio_soc_data },
>> +	{ .family = "J721E", .revision = "SR1.1", .data = &am65_mdio_soc_data },
>>  	{ .family = "J721E", .revision = "SR2.0", .data = &am65_mdio_soc_data },
>>  	{ .family = "J721S2", .revision = "SR1.0", .data = &am65_mdio_soc_data},
>>  	{ /* sentinel */ },
>>
> Looks like every device is impacted -> so, why not just flip the
> logic to indicate devices that are NOT impacted? is'nt that a smaller
> list?
>

At the moment, the list of unaffected devices is small. But as and when we
introduce more devices,
this list will need update. Also I feel that few years down the line, when
someone looks at the code,
a list of affected devices provides a better context as it is easier to trace it
back to the errata document.

Regards,
Ravi


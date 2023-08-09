Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699EA7752F4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjHIGig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 02:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHIGif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:38:35 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2086.outbound.protection.outlook.com [40.107.22.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6827710CF;
        Tue,  8 Aug 2023 23:38:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IN6AFbzYribLEZec4abH0eLnDjborAri1063g5sByA+tCWEfeHr+nfIqyf3kqNDzzWl1I/MKRsLG7NvDcsXBEbaOKvuEmDeQWZNS3VQYz/OMTKMdaNgPpVH1e3rHd6Afhw0m4NUHIo3786p/uuDc95ffj4xbV00FIce/PKXeQ8ZUzs/JN3gu0qKb3DiNZBRLASIwBuvIpx3OqujZUK+ma6E5usQYm5ytszwrI8ZUk7FPmd1dePmp+GWaZIy3cOa/RIsPQEwgPAb05zLNXrbTbL/6YzRGN9LKBiBy5INqd6Wl2MZsrAWreW1EK8Qd+NzK2EzFHW3hjuO7gKqTCN4pwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXPREfVea3KIRSg1pxvO6wJvu8FSO9qcSikQRZ2ZbWE=;
 b=fb3+Xe+5QZKzK6HmZHlefUomSGCrb2ZbOeKhBEVdNikRARErYBTpCt4grqcpATlEo3R59XVYlmh0N1Tyoj51uVZh2TgA9QUSlGSSsK67MyQHIbQNSBtOBAX0+2JYJ68p9sftdDDYixJ7V0/5Qv6js3Pm6d54opVC6Y15yUD8va3MfDkBgFCpnxNorV1F7wnSlRT/0OHsoT5Fw2vaDdkUoBYaDGvI7cj4nj6pcMU0ZaYkaE4vfSs0wH84uk9E/IDTeG7qW4EhpR6NdPRsaXtN71q5b+EYl/qvyPtu8MoT5Awvc9mroxXQbUK6cjpHoOOqIrgBSyfm5ibIDvQumZJyiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXPREfVea3KIRSg1pxvO6wJvu8FSO9qcSikQRZ2ZbWE=;
 b=fTTYm78RN5ZRmU/m1AgCvE7ScqGexOORnFam5RjDbSnNXOZoS1PeA8lhYZBL6KMQNoLQPcOYsy0gvASpEtAKW78JMxC3mGxg6lSZTNGmo2lbvkaG/fTEzQZT8zE8AKQJLxY2bGtmgta4plUr+qKEmv0u+TsSn8Kz7KD228Lg1ao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by DB9PR04MB10067.eurprd04.prod.outlook.com (2603:10a6:10:4c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 06:38:29 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50%4]) with mapi id 15.20.6652.022; Wed, 9 Aug 2023
 06:38:28 +0000
Message-ID: <b33195b3-aa6d-defa-97c4-280da7e5e6d6@oss.nxp.com>
Date:   Wed, 9 Aug 2023 09:37:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: Re: [PATCH] net: macsec: use TX SCI as MAC address
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230808141429.220830-1-radu-nicolae.pirea@oss.nxp.com>
 <ZNJdo6bow7uK8bTn@hog>
Content-Language: en-US
In-Reply-To: <ZNJdo6bow7uK8bTn@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0052.eurprd04.prod.outlook.com
 (2603:10a6:802:2::23) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|DB9PR04MB10067:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d7fba66-8b6f-4d4e-3671-08db98a33da8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KKszF/ptHX3VsQ4JMZ1o1w8cIum81KylwjUKOxjDj9myvBekhcRXvByGVKVA4pHD+Ot54xyFoAELpxsfRHOV7bCIhOPQWy8MrdqqPeHJeVqi+tcRLLSivj4CTIgnvb0wla+VgGzpsYBaWEVVEloIecBO7KyFzU8XXnfaXYklRVWNd4qQK51I/DL6ej1IeM3KGIfEHFvGOxZ3IK+UpYGanobTUJR717K5f24n7BTZW91IQTMA8MornG71v/RdKd/8AjFgCTs4MMCX/4TA4UQtnWRGWrBU0p90fCjC51pl2cnWcFBKSmQE3ZihwHyIh/5CHWAJ6BGlFGBt3DA6C2htnXTzKCJ0GBRujzZabvts00cX3O6s+llOLSX9emYX6qYSsZJz1PBWeAJm0DgVeQviivGVGaM9cJbZQWn/QdfODl7+AyprSQ+MrFsykgRxQdGGXc8oEepf0syzn2u9jrMfTM+snZEtaakEpAdsOPtabxh8ru3F0VFG1eZqZiI7+wVEaeTHrVrsGcXA9/Sd9yMHJG4aFebbdyTXZQH5S4esUc0hQoV/fW5MZuc9n81do8Sx1Pww/Qyz7M5v2LZYnYa4xm+UOFI2DX0R1xuXSqtgVXzSzr4pojBTdfluTH3q8dSE851C2MyLxmbYq8DR1o+KOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(1800799006)(186006)(451199021)(6512007)(26005)(6506007)(53546011)(38100700002)(5660300002)(86362001)(31696002)(2906002)(4326008)(6916009)(66476007)(66556008)(66946007)(8676002)(8936002)(41300700001)(316002)(6666004)(6486002)(478600001)(2616005)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mi9KbEgxcTlrWVVuL2FSOEYyK0hZY2swMm11NUo1RTliS1d5eDI1a3g5TWVq?=
 =?utf-8?B?SlNLK0NIUVI0cjg1cCtlZVVVSU4rZ2owVTNwNG1BS0NKNms1ZE5jcDVQNHh4?=
 =?utf-8?B?N1NxUjRLUlFIUFlWdEl5c2QreEZKVGpaU3ZtcjBCb1NlOVVodGdlcnN5cDJV?=
 =?utf-8?B?MmZMVVJLOVY1bHVuR1JuMnlPRmpleFVWK3U0azd2QVhOZ0t1MzdtRU15RDJM?=
 =?utf-8?B?b0ZlN0FZbG0wYi82M1RiNlJaYnZWekZxdmVWNzZrZWxhQ2xkSVhsV28xWGZX?=
 =?utf-8?B?K2tZUHREMG82SnNwUVRNeWNWbFV0MXdpQ2dKaElwNjBmVDZDUFAzQkMvOExN?=
 =?utf-8?B?dkpyaTh0cWpqRWY1d21vS24vazJEMkhteE9xYTZqU25nd2VXdUN5L0MyZmlo?=
 =?utf-8?B?YjFxc2gwazZMaDFoR0dKOS9wZHYxODExamdTOFppV09uMXdHdzlER2p0R2Vv?=
 =?utf-8?B?ZmJPenYyT20wU3ZMNjBibklsNWh6eHFtT09jNVlxUktWbUZ3citkYm91T1BM?=
 =?utf-8?B?SVJvc1BsZVRMWGlUNE94MTFydjF5Y096akQwem5jejlmU28wMVZ2WW5ocUFu?=
 =?utf-8?B?RXozNkphbGtYbUJCWVhxMUpYOENlN2FlUlFzbE9kcVVzRzB3Mlc3Qjg4MVh1?=
 =?utf-8?B?Z25POFU5dm8zZEcrYkovR3J5STdaZTM5Q2ViRTdET0pZUjhodS9RTzFlVDdT?=
 =?utf-8?B?MzJmZjcrZnZJK2xlR3E2Q3E0THNMMXpQZzE3eGpZSERNc2tVRy94Sk5lTmt4?=
 =?utf-8?B?eXRGaW5lWWl1ZkJzTnE1UThFZ1JCWUkrZ0VZUVBlSW8zK0ZublFBMkxmeVAr?=
 =?utf-8?B?bldhMHIyOHlFOWxFTzNIRHJKb2cxMU93QVVSd1pWU0plRldwY0pEYTg3YnM5?=
 =?utf-8?B?cHhKczNGalU2TjVmdVl0WXA4ek9OWlY3OE91QXJueld2aWUyLytidUhQZkNO?=
 =?utf-8?B?QjNoMHYvT1pGcS9BdVByVU90V3hCY2FFTERwTUpTUmlwa0lQU2tqMm80QitL?=
 =?utf-8?B?VmEydldJTGhJTzJnRVh5NmtVbnhtTGNzYXoyOCthUkhobmEzQ1dSVnpFRlNk?=
 =?utf-8?B?MkpSMWtEaEM2eGIweU1rS3lxQTFra2xyN0xDZy9iNWxQcFNUTTV2eVpxNENG?=
 =?utf-8?B?TytGb1dlV09kM21NK0E3U2FiNGt4YUc1NTNXc3ZjSmRNVGtkenFhMEJjM0t1?=
 =?utf-8?B?RlYvakY3cXB3aEZJcXpONDBEaE00R1FKQmdnckxyRlBsUjFFZEdFMjRLWmhp?=
 =?utf-8?B?MG5ZM3NqRkRnSGk1YjhZK29rRTFsTEwwM1FGMkxVNlRaWTJjS2RBUmNBWXBS?=
 =?utf-8?B?MXV1REVqRXlCMGk1MDlqNHh4cDBrTjB5U0Zlb0FsNUo4VlVzbUc4SDAwRTRF?=
 =?utf-8?B?L3JHVGx6V1lJMTVWcVhYVWU5Rm10UTNoVURnWlhKbWJVRlc4ZkpBTDcvQXpQ?=
 =?utf-8?B?YzFVSWRMQWpGWjlvQ1NLVHovZ0o0NEEwRE52Q3pETzAxYUt4M3BkUGtrQnlQ?=
 =?utf-8?B?cWNMRlcvaXlmRGdBOXVKQml1dTFkQi80S3hWQkhlUHVDTklPWDNnTnY4SXFR?=
 =?utf-8?B?NHhWcDE1YTQ0aWNKZmR4Q0JlSjQrZ29Qd1ZtM05yUEdxTWxMQ1FsdzNmREFP?=
 =?utf-8?B?UHNzV0NjZFJkMUFNR094cFhaWHhBdkdBSFY4cVBsK0F4L2gzZVhFeXhvY20z?=
 =?utf-8?B?Ny9OVXc3NlJZdUkzQkkrQWFTeUJaM2c4V0hxVHRmZXFxakZUMzlrYnBGdWUy?=
 =?utf-8?B?amFVYm8vZXVidTB3ajdrNGVBTFQrLzNOZUo2Mzl1Sy9YSmw3bVJKTDlkTTlr?=
 =?utf-8?B?aTJ2a3EwWU1UdTNBTXhSZVdHNjcxMXljaEpOaVBOUWJ2SjF1SXo5Y29RZ0FB?=
 =?utf-8?B?N2dTK09tN25JanR5ck9VYzh1MER5eWhJd3A4SUlCUmlBbEZiZWI3VlEzU3lu?=
 =?utf-8?B?WGZrVm8rVnZ6WVVVelR2ZlJ6c1BGdzFTeVhlOVMrektiV1pLZFRUQkliK2VU?=
 =?utf-8?B?cmcwQnI1cFIzT055eTJhRzdOMHZhWDh3a3BjRUsxUW5LejNPdmNQSlNLSDEw?=
 =?utf-8?B?SFliaEdHS1ZNOWJObTlremJBYk1obUFNTElWQjE3cVlCVGkvQzFUY240UUdW?=
 =?utf-8?B?WjF4em0yRkJMTGt1WitFUGR6SDlwdW5WU1lPMnYzcjg0ZEJGdEZCRGxHQmZm?=
 =?utf-8?B?SVE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7fba66-8b6f-4d4e-3671-08db98a33da8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 06:38:28.6687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1EkCbOu0u6SCI+5d1Qkd+05PUjPj9mJBFjSaFm8ywFpAZ+8RPf0ECabL999l1BePrEkDIyYhBOxEPtj05mQhoUr/cfIaT+ndwEDHIC0SKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10067
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08.08.2023 18:22, Sabrina Dubroca wrote:
> 2023-08-08, 17:14:29 +0300, Radu Pirea (NXP OSS) wrote:
>> According to IEEE 802.1AE the SCI comprises the MAC address and the port
>> identifier.
> 
> I don't think the SCI needs to be composed of the actual device's MAC
> address. 8.2.1 says that the MAC address *can* be used to compose the
> SCI, but doesn't mandate it.
I used IEEE 802.1AE-2018 as documentation and the text is slightly 
different. However, the purpose of this patch is not to force this match 
between the MAC address and the SCI, is just to have different MAC 
addresses when the interfaces are created with an specific SCI.

For example, the following command will not set 00:01:be:be:ef:17 as MAC 
address for the new interface. Would you expect that?
ip link add link enet_p2 macsec0 type macsec address 00:01:be:be:ef:17 
port 1 encrypt on

> 
> If you want the SCI to match the device's MAC address, why not use
> IFLA_MACSEC_PORT instead?

In this case, if no MAC address is specified, it makes sense to inherit 
the MAC address from the real netdev.

> 
>> If a new MACsec interface is created with a specific TX SCI, use that
>> SCI to set the MAC address of the new interface.
>>
>> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
>> ---
>>   drivers/net/macsec.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
>> index 984dfa5d6c11..6db69daf880d 100644
>> --- a/drivers/net/macsec.c
>> +++ b/drivers/net/macsec.c
>> @@ -4103,12 +4103,14 @@ static int macsec_newlink(struct net *net, struct net_device *dev,
>>   	/* need to be already registered so that ->init has run and
>>   	 * the MAC addr is set
>>   	 */
>> -	if (data && data[IFLA_MACSEC_SCI])
>> +	if (data && data[IFLA_MACSEC_SCI]) {
>>   		sci = nla_get_sci(data[IFLA_MACSEC_SCI]);
>> -	else if (data && data[IFLA_MACSEC_PORT])
>> +		eth_hw_addr_set(dev, (u8 *)&sci);
>> +	} else if (data && data[IFLA_MACSEC_PORT]) {
>>   		sci = dev_to_sci(dev, nla_get_be16(data[IFLA_MACSEC_PORT]));
>> -	else
>> +	} else {
>>   		sci = dev_to_sci(dev, MACSEC_PORT_ES);
>> +	}
>>   
>>   	if (rx_handler && sci_exists(real_dev, sci)) {
>>   		err = -EBUSY;
>> -- 
>> 2.34.1
>>
> 

-- 
Radu P.

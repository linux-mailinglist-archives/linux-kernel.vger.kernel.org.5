Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4917D17F9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjJTVW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjJTVWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:22:55 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2102.outbound.protection.outlook.com [40.107.7.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFA410D4;
        Fri, 20 Oct 2023 14:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8yhThw+p6u0KPcmFStlJ+NQNXplElGUwYOpP2Tvf6JCG0h8tPLik4YR2xr7mWDotZJ/OVwU4zJn8iU5352Yho1v2eymRMuLsvzpnfwVsqhS/hxlZ9qDHcu4ndol4E0FDsPDhZZMUO7L/ruOHhFW73Q/FjrXg2MqixBW0AYd4aKba1F3Ccpo5f12SCmg6fFfXcsImPGmFUL0hfvigAUPEJcHeNJepfmGVYyjoiJK9tXbXIn2fpGcbECFTjRYVKJfwkznOn4rXyPn7aBk1vsFt9S8MV4D5nyiV2oHSkUtJ4BWWlxySAU8UlHlNyWEn1E6QaVeV5x6isOyjjcI9MooRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJC/EBkQnCpkbEWjUP1lFC8569JE/U/RWAz2HdiPlMI=;
 b=lbVG45zwS6IMWH9yJzQss1fnlAbpXV9D0xA6XY1J/44+MQAr0jv68UnpcB9RTzZRab9vCj/Ur4OlBTtFfuzKWefr+EXuVKX2KElhZtQPha0plned1PJGc/nqLRVqi9ov1ectxEh8pnznAXALLtJHwR4nKvC1FMFg55uwHRqt91uAm9Ap+cAAzM3Vy3ZCiXFR9uasKhTcv301OpS/pKoajAYY5c6/xmX2toW4u4NSupHA6IhPTLXRLZBaZABAzwikQOo4LGimYbaGWin6aS6iIEbUBNvTNrHFUxNRAoV6uaT89QRVEZ2dgeM9i3nXZjQrZ+Wgir5VSv6R9UtVNA61IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJC/EBkQnCpkbEWjUP1lFC8569JE/U/RWAz2HdiPlMI=;
 b=F++knjmgktYNfGX3wTnrLrJLnYjvc7tcfW34FVG8Zlr6fBXoaswgE7MgHoY57px0ugqK8XfSx/GOkTdN1ar8dI1bzL308ie87KVdm9PvT6KHW+HlAOlh6KNwcH8jHglOPAN4htvsycHX2rQ3kM/VODknLRxInNidA514DVuz3G8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by VI1PR02MB5888.eurprd02.prod.outlook.com (2603:10a6:803:13d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 21:22:27 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::4ba4:83a5:e60c:3a5d]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::4ba4:83a5:e60c:3a5d%7]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 21:22:27 +0000
Message-ID: <38d3582f-c2d6-3d1a-5706-84fccd22a2ac@axentia.se>
Date:   Fri, 20 Oct 2023 23:22:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] mux: mmio: use reg property when parent device is not
 a syscon
Content-Language: sv-SE
To:     Andrew Davis <afd@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230911151030.71100-1-afd@ti.com>
 <0cb645c7-f3c5-e4bb-7686-2a83d32274bb@axentia.se>
 <ab1c4929-0d7d-45eb-ab70-7680dbebcdbb@ti.com>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <ab1c4929-0d7d-45eb-ab70-7680dbebcdbb@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0005.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::35) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|VI1PR02MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: cee5270e-d468-4e96-07d8-08dbd1b2a90b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k9/dolUGkaYE4tpgU69Qx1wkEb1FkebzzT+lVGLzT4AyTZKgYiC0n6ewRzKU+3y0n1j5kFYhK1JIeefHO1LOwRwS5PGNKSeFQl4LUXZzxw+el7nVLo3Dz5eKRco1WdR71ME5VBQvghxqMaBTunIMk1FsNhzNo4EgaJd0kcf1+pTgM1s1jSK7txS34F4hSQRh11EcUPf/HmdMimrNoDLAWeMOhZZIc5AxdqLDRCiXXsJCHZJd5CUsBQFfslfAXH15vLU3zwP2QWXRH08zCHTVxkgp6N4YTU7+SQbzbwy/MSwlNVfSesKYbnD0iM5MfN26VOPsprU0mQVVz0NdoFGGLNQgcG9ZaBIjSLQD/0pG+aaiUJWkfL01868g1jdwEzKa0AfX348VWemAsLGzI85eWWua2mOzTxHQwXk+i522jiHOa1QaTWVN9QVBUWzz+m2PniUmhinGczDtSjAVr2fu2WbTNDpWuG/1c2dH4sFznrR/a1tLwQz5u61gh683WDKAUIDRanWLM22/ozoTChLnuzLXIO838PXI9ZYBSNKumzafErB/xrEW+00N8PoYfZ+No6b6ru0uuwWs09dLlV4C2E8Q+PhjGnT0tvzEXHRS4RkXduK7ls9IJ3gxLXNmGxaZ6fMckjlePd9cNhrDkQzqKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39840400004)(366004)(136003)(396003)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(31696002)(66899024)(4001150100001)(86362001)(26005)(36756003)(2616005)(83380400001)(6506007)(6512007)(53546011)(41300700001)(38100700002)(2906002)(5660300002)(6486002)(478600001)(966005)(8936002)(8676002)(31686004)(4326008)(110136005)(66946007)(66476007)(66556008)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWhjVHlBZUQ1N2NWZXM0ak0vVjFLYU5FU2hRb2JWS1BJeVZIdWhHd0NvWWc3?=
 =?utf-8?B?QWQxSkdmb05XekFuOUM0a0FHNEtoSkJkMkZVeHlMcE0rVVpDZVhQeWNKMHNv?=
 =?utf-8?B?ckFOcWRMMTQwYUNlZmpjYU9MQWpIdVlKOWlidDllWkQ1Z0d5ZW9DUWJBT09M?=
 =?utf-8?B?MmJSd3JHNnBkMmVjbU13bWdVcTIvMGUzZjlwOVNTM09senVGT2V2ZjlORTRo?=
 =?utf-8?B?dFZKV241UjR4QlhySFBMVXhBd1orTHpsOTNGbkcrTGtHMTFNSXJ3UDcyanJB?=
 =?utf-8?B?M2p4VytCaUhRVUUzQTgycTZJK3JjNjZsMC9UUC9uZzFTRGRVMzdQNUlSWGYy?=
 =?utf-8?B?TkVNSXFOMUYvZmtQMlhPREw2OElDZHhnNEFUbm1mZEtuSlp0ME9RR3hUZ3NZ?=
 =?utf-8?B?NFhsZkZqL1VCYjlOT0RBUnhUazllRkpqdW9vYXVYMEx0VnBuRkY2aUZUK1cz?=
 =?utf-8?B?K0JjMXNOZDlEYUZiTnUrRGEzNFpjajhpaWNuRXBUeWZ6VFA4aEEwTXQ1Zzln?=
 =?utf-8?B?MDdueFM3ZDVFb0xFMmlwemFQcmJvME9IUTZMSWY5V1BwaFo0alBHa3A0Z3M0?=
 =?utf-8?B?aGNFVUprVUNkRlQ0UjFKaFJJTElFSGxrS2tYZVFWcms2RGtaNnhNc3J0anNS?=
 =?utf-8?B?eEdjZk0zN3RUZThNY2dqRklTaG94ZUUvSWJFU0llcXFpa1hkdkVISHllZ1ph?=
 =?utf-8?B?SzJCckNwVHhqcFMwNmhnMEVzMEZ3dEJidXhhYVluMmVSeEdEZkZsWit4VDR3?=
 =?utf-8?B?TXdhUlEzcVhuT0NOTkNyQTY0OENMeWpMelpUdXQ0aCtBUm5TZlg4ejVzRzVP?=
 =?utf-8?B?UVUvdytncVFJNWMvREdPODZQWHNTVE9zUE1iMnJkS2FNVGIzZlQ0MkxPdm1D?=
 =?utf-8?B?eDNOWmhYS09kWXFidUFQWVhTTTNOWTJlRTJab1lRYVRQSFhKb2tra2pkK0hp?=
 =?utf-8?B?QXhGa2lnMzhkL2Z6SnB4eUVKQldSZWVJYkJuaUhKQ0xzUTF4Skd6Sk0rM1Bq?=
 =?utf-8?B?dERNTXJlQy8xaEpTalVaOUNSWHh5K1NuWlM0eVVud0NKQlVOUzU5Y0pYN3Fq?=
 =?utf-8?B?TGdiK243a2hYSThQT3RDNmtVb3c4dHN5ZWp6YWtIVTB5Zk1xYTk4Mmgzemls?=
 =?utf-8?B?dW9zemFhbFFjbTRyRXFGOXEyeCtPdHhKRnNrc2RlNzc2WlVJMUtETXlHWkdz?=
 =?utf-8?B?RktGcVo2d3kwSUd2NjR3cXlCVlpMNUZDS3lqc0hmOHl3eDZHS1ZiVUxPbTlJ?=
 =?utf-8?B?dVFJSWtNTTc4VFV2eGttZjNDaDd5Y0VHekdtR3ZubDBEakRpU29uMWZXRjVh?=
 =?utf-8?B?UnMrekdJSnNFTklvSHFQRjR0YXJoblRLZG4xYmttSkdubWlVcitoWUx0SUhZ?=
 =?utf-8?B?d3k5anpaTjJXc3dLQ1dWdUZkaGx5enJqMEk3Y2tQWURNV1o5WEVHT0ZqREVK?=
 =?utf-8?B?NU1oRmRnOTB2VXJNYmhVNis0dmJzRmdDVHp4YnliN3NKWWhKcTFWMnhqeTQw?=
 =?utf-8?B?WWR4MWxaajJ3b1E1OS9SWkR4K2FXOFNmUmZpR3Vic2RrNHBWY2dGRi9SOFJK?=
 =?utf-8?B?eFNDc2xDdlh2VVpLUVJFTkJodXNCMkwrRzFqb0ZaN05HZUoyYktBWmlkNGJO?=
 =?utf-8?B?cXRSd0J5RlRzYVRTZTZKdU5oLzY5YzJqemlHdjhLcCsrNmR2U1hHTDB0Y3Vw?=
 =?utf-8?B?cXUrVkVmd3FBZDNsS3BTYVdvbVNTRnlCZTRPQ3VKQlZTaElJc3NuRXduUElR?=
 =?utf-8?B?MHFYa2psc3R1UGpOV3JENkFra2htenorM3NPandXMUZWSUtrcXk4cFk1NDNB?=
 =?utf-8?B?MmM0anI1a3o5RzVuU1ZsZXJPTUtqZUhPN04zWUY3REVudVdiUmgzc1hOLzho?=
 =?utf-8?B?WDN5R2NOa1RaNHdxOGoxY2J0Rmc3UEsxQWRKcWd0aTZCRUhOYWI5WVVidlNj?=
 =?utf-8?B?MkFOMjYwZlE0aUE4K2FOclBqSE02aVFIM250c2JOclhjbEV0L1R0Rkp6TGFB?=
 =?utf-8?B?VGhROGp0VWlBN3JzR2JDcFdjQjhHbDVpc0g5NGd6VG5HcGxmN21razREcldG?=
 =?utf-8?B?V3ExS1FMb0pTb0RvdjZDMVBCcjlVeEJmYnRweG9iUVNoUDlRMzlLL3U1UHN2?=
 =?utf-8?Q?RmPfoyrtzovQc4pwMsojfEpbW?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: cee5270e-d468-4e96-07d8-08dbd1b2a90b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 21:22:27.4862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNkhLGWKVscjN777DaNKS79GcbVzz4wQwe0Klp6ySY4WgK471JbS9FIQHOfcSMcd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB5888
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2023-10-20 at 18:43, Andrew Davis wrote:
> On 10/20/23 9:28 AM, Peter Rosin wrote:
>> Hi!
>>
>> 2023-09-11 at 17:10, Andrew Davis wrote:
>>> The DT binding for the reg-mux compatible states it can be used when the
>>> "parent device of mux controller is not syscon device". It also allows
>>> for a reg property. When the reg property is provided, use that to
>>> identify the address space for this mux. If not provided fallback to
>>> using the parent device as a regmap provider.
>>>
>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>> Reviewed-by: Nishanth Menon <nm@ti.com>
>>> ---
>>>
>>> Changes from v2:
>>>   - Rebased on v6.6-rc1
>>>
>>> Changes from v1:
>>>   - Flip logic as suggested in v1[0]
>>>
>>> [0] https://lore.kernel.org/lkml/1c27d9d4-b1cc-c158-90f7-f7e47e02c424@ti.com/T/
>>>
>>>   drivers/mux/mmio.c | 9 ++++++---
>>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
>>> index fd1d121a584ba..b6095b7853ed2 100644
>>> --- a/drivers/mux/mmio.c
>>> +++ b/drivers/mux/mmio.c
>>> @@ -44,10 +44,13 @@ static int mux_mmio_probe(struct platform_device *pdev)
>>>       int ret;
>>>       int i;
>>>   -    if (of_device_is_compatible(np, "mmio-mux"))
>>> +    if (of_device_is_compatible(np, "mmio-mux")) {
>>>           regmap = syscon_node_to_regmap(np->parent);
>>> -    else
>>> -        regmap = dev_get_regmap(dev->parent, NULL) ?: ERR_PTR(-ENODEV);
>>> +    } else {
>>> +        regmap = device_node_to_regmap(np);
>>
>> I started digging in device_node_to_regmap() to try to find an error that
>> could be used to trigger if the failover to dev_get_regmap() should be
>> tried, instead of always doing the failover on error. I got lost fairly
>> quickly, but it seems device_node_to_regmap() can return -EDEFER_PROBE.
>> While I'm not certain that it is applicable, that case should probably
>> not fall back to dev_get_regmap()...
>>
>> Are there other error cases that should prevent the failover? I would
>> guess that it's perhaps just a single error that should trigger trying
>> the failover path? But I don't know, and which error if that's the case?
>>
> 
> Ideally the only error that will be returned is ENOMEM, which happens when
> this node does not have a 'reg' property, and this is also the one case we
> want to do the failover. So all should be well.

The ideal working case is usually not much of a problem. When I look at what 
device_node_to_regmap does, I find, appart from -ENOMEM, possibilities of
-ENOENT (because no clock), and the clock may theoretically fail to prepare
for numerous reasons hidden in clock drivers, but the clock core can
trigger at least -EACCES and -EINPROGRESS via runtime PM.

And it definitely looks like the -EPROBE_DEFER case needs to be addressed.
I.e., why is this call chain not a problem?

mux_mmio_probe
 ->device_node_to_regmap
  -> device_node_get_regmap
   -> of_syscon_register
    -> of_hwspin_lock_get_id
    <- -EPROBE_DEFER
   <- ERR_PTR(-EPROBE_DEFER)
  <- ERR_PTR(-EPROBE_DEFER)
 <- ERR_PTR(-EPROBE_DEFER)

As far as I can tell, if device_node_to_regmap() fails with -EPROBE_DEFER
with your patch, then mux_mmio_probe() misbehaves. It should have aborted
and failed with -EPROBE_DEFER, but instead throws that error away and
goes on to try dev_get_regmap(). That, in turn, is probably futile and
will likely error out in some way, breaking a system that might have been
ok, if the probe had been retried some time later.

As long as the above is not sufficiently explained away, or fixed, I
consider the patch broken.

>> How much badness can be caused if syscon_node_to_regmap() fails for some
>> random obscure reason and the failover path is taken inadvertently? It
>> certainly smells bad for -EDEFER_PROBE, but do you have any insight in
>> other cases?
>>
> 
> If we take the failover inadvertently then we will check if the parent
> node is a syscon, if it is then our offset will most likely be wrong
> (parent will not match child 'reg').
> 
>> And after getting to approx that point a while back, I had other things
>> to take care of, and this fell off the table. Sorry!
>>
> 
> No problem as long as we can find a way to get this in quickly (lot of
> DT warning need cleaned up based on this patch).

Hold your horses, I need the above explanation first (and perhaps an
updated patch).

Cheers,
Peter

> Thanks
> Andrew
> 
>> Cheers,
>> Peter
>>
>>> +        if (IS_ERR(regmap))
>>> +            regmap = dev_get_regmap(dev->parent, NULL) ?: ERR_PTR(-ENODEV);
>>> +    }
>>>       if (IS_ERR(regmap)) {
>>>           ret = PTR_ERR(regmap);
>>>           dev_err(dev, "failed to get regmap: %d\n", ret);

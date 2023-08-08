Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67956774B3A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjHHUng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjHHUnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:43:19 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E404C30BD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:58:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+YK89jRM/ho5X+Ay23ydF7GI6uU0hITcq+O7FbB/ablwQM9hWKAxfLokOgTs9rCpCpVzoospionSuxma0JeoQuQ/FgGCH5XDnUsNKrr3lMpsBTT0NuTTaYqaq5YxZAu/vDs9aOKRW2fdcS25REQgb50Q/A7d4P5LK0RGI5/12ADxsy651hn/C/fiaAXO8cHyuhEQ2Eqm1EY/+pdzrGoABSk0DChmObkUZjtqDDgWJNLlJSYoYqtXB+oYtl/82o+7IK4dYQ3KrIREpJw51gbBhZnhHfhhUzfNQxXRH7I/da9VqyhDAafQJjYk16wtDSkJi/H7rN7cPaiEnp+niC4RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0ZfcanlcUa7T2Acm6YqoLKiKUPmcUGorXOFZUnCGgA=;
 b=GOp0b3bkqiCtBnh08hcdHqrm2rxwFb0mkL1j+52dS1HnVV/pkLY1Y2ZODKpZmRtE8o6Hm1OOKktSCXdJgj31effptNugmG8K+Pnf9NOfYzD1nY/EtuOjpKUn0lmy3yMzKxJXOppfPwYNdV2pvgt6nGlsR8puSNXJk9hFG1ZDPeEgG2MX9fcqy5tdgCq8G9L7HOJui/5s/TkcsPCAITCjOj+MGSEcM0f0m6u4AyBM5nubbEXFrZlfyFo0btSKIP4gopuNdEYJyCuwUqmgXDLc7nwJT+zmMePbFzZ8g/A9Ei8NKxsmSU3NhSFwJwcSHmc1OBrvNrGNUSc3RR4NM9K9Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0ZfcanlcUa7T2Acm6YqoLKiKUPmcUGorXOFZUnCGgA=;
 b=aDUnTfvG3mo1dt+Ai9gjNdb8+oz8pvupLixHHQ6Avhl3ciU2ffvD50j3aFfd+6cAMHNhmgaonbHMzRsSRsGxHPss4K5M9UTCo49ucTBRCPyQ7zWmAXvyuowXICa5p7xo136GVTzaFu8P7y1biP9wCkSi4h3Poywg6u3UkCDR5KA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ni.com;
Received: from SN6PR04MB4879.namprd04.prod.outlook.com (2603:10b6:805:9b::29)
 by DM6PR04MB6764.namprd04.prod.outlook.com (2603:10b6:5:24a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 17:58:40 +0000
Received: from SN6PR04MB4879.namprd04.prod.outlook.com
 ([fe80::c738:ef27:97ab:fa11]) by SN6PR04MB4879.namprd04.prod.outlook.com
 ([fe80::c738:ef27:97ab:fa11%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 17:58:39 +0000
Message-ID: <9ccd49a2-5451-1f02-e03f-849e2f87d5ac@ni.com>
Date:   Tue, 8 Aug 2023 12:58:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] include/uapi pps.h: drop not needed PPS_MAX_SOURCES
 define
Content-Language: en-US
To:     Rodolfo Giometti <giometti@enneenne.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230630071826.105501-1-giometti@enneenne.com>
 <20230630071826.105501-2-giometti@enneenne.com>
 <2023063017-traverse-accustom-97f4@gregkh>
 <56e461b4-2cd8-ec89-86b2-68544826cf73@enneenne.com>
 <2023063015-immerse-broadside-3dab@gregkh>
 <ca137a28-28a3-f563-52e9-4ee0ef1daa9f@enneenne.com>
 <2023070327-gangway-comic-6e15@gregkh>
 <a743ab0a-fd45-2cd1-2546-44cf4547266f@enneenne.com>
 <9bac379c-c482-e52b-f7bb-33ed4ef49b40@ni.com>
 <a2754968-de3e-4442-ff7b-394193422128@enneenne.com>
From:   Charlie Johnston <charlie.johnston@ni.com>
In-Reply-To: <a2754968-de3e-4442-ff7b-394193422128@enneenne.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:806:21::21) To SN6PR04MB4879.namprd04.prod.outlook.com
 (2603:10b6:805:9b::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4879:EE_|DM6PR04MB6764:EE_
X-MS-Office365-Filtering-Correlation-Id: 057db02f-28fc-4803-06b0-08db98391819
x-ni-monitor: EOP Exclude NI Domains ETR True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7B7/9kNtD3B3STCarJSTxQcgfyaIc5dWowSYyYoLJIGDgn+cYOpOTB6nWkl/GYPiwKy+9xCRn5BCSBz70+1o9NZZ+XnxF3ZBpHRBgroTntXLoOwppT+dtuuFITIUUYB6DRNqNXNIeeYsKK4k4X9FPFuGwMPfJfHrDoEkyNHnP0SbX+HtmffsJSaiFd578GG8zJCwiZ5eR1O2X0qeKrptgw8hM3jdm3F/d3eUIcBDtLjjfizN4Hn62c/65c9m1HIJ4IQ2zhiKZpKG+NywT3KjnuiFd3+fVR4XOcYMt0ktWEZV2NL4IhwKMuuKA1DIMSjmxaidJqhSkEqB6mVUuSRwdWnSC7dguhjjOj9gtUB9jteoQrOXS6t1aLLq0VK/dfeVqwwhIJCd0ZrtPEsdmf4zo2DgIXqous5KvdmpWNdaMG34+hy6qX8d63z48aen2xrEfFLKcuXPeZb8mHk6kE4dhptGU4BJFjO9eSCjgE6nAF1YMnd3OvPBaJW+E9/WHTqTUPC+InzQHzcepz9aDw9rApbrVtulJd5JCNnEgnvvI70dGHg9UiqB4jIZTTDGciUBLiBDsLQazyaG2mozt7bIYCRoS0EO9jxWYjHGX0tOe14PUUZK192YEzMam9t8D1ZPq+LLAtGBaaCGr7GNtqjcOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4879.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199021)(186006)(1800799003)(2616005)(6486002)(86362001)(478600001)(31696002)(26005)(6506007)(36756003)(53546011)(41300700001)(6512007)(2906002)(8936002)(8676002)(44832011)(316002)(4326008)(6916009)(66556008)(38100700002)(66946007)(66476007)(5660300002)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk16ZWZjUjlSNGZqVFhsU0Z3N2dUaHBhMWdpMEx4bHdsUDJRaERzUERjcG0x?=
 =?utf-8?B?VG9WalBjRk1jb28xeStHK21ROWJSVy8rK2dQRXhSVjlkbkdWVEY5ZDhzMnJh?=
 =?utf-8?B?bXd0VDg0MkE2TDErdTJXM3JsNjEvclpYVVJvbEdpNVZyUE5GRjAvY1hPSkw1?=
 =?utf-8?B?ZFBKeVJPMUxraXVyb2tNZU5kdDNNYWdIMDBXamdPaElzc3dZU3lCaVhGTFdp?=
 =?utf-8?B?dmpTWGd6WUljOWhxU1hMRTRyK1JtUFNqSnVyUU0wbExjem1Qd2JKVHdJbE4w?=
 =?utf-8?B?OWthc2ZkQUpyREhCSXphMDFnb1lFY1p2SFFRMG02b2Uvb1BZVEx4eEU3QnNO?=
 =?utf-8?B?R1BMR0dsQWVQU0NqQUR0RjRPbmRmQUZDQTlpdWtkTHR4dW5qNGxpN3BoN0Ux?=
 =?utf-8?B?SG83ZnZzS2h2d1M1a2E1K2ZESXFkR1BDYlpGN3QrcjR0TWZLaEdCUlpVang2?=
 =?utf-8?B?MXAyZ040U2dYQUJXUDFIUmVTYU9QMDE2VHFtVTFuMGxreGg3ZThjS1ptajd2?=
 =?utf-8?B?emh6VDZvb2tyOFJzWmM4d3NDSEVnUmZ5Q1gzQWJoZXpSRGdLdFNCK1duNEQy?=
 =?utf-8?B?ODlLb25CN000ZjFmdUVYcmNLMktNUXp0bnlYZTJXT0Z3ZFZKU3k5TjFoZGxa?=
 =?utf-8?B?cFJXdXpqN2dsMWZ0Tnl4V2Vic2dlR3dpcVdRSzVEdDNlVVE0Y1RlemN0YVJZ?=
 =?utf-8?B?S2Nkb2JYNkZYbk4xVWJLZGVqMVJwNi9mMzJTczdlUzdGU2tBdFBiMHlIdm1v?=
 =?utf-8?B?RVFvbFV5d0RWdXI1cFprQ29UQXUvTmdPNFFYdkRpcjJwL09UUWp3aW5ENDRs?=
 =?utf-8?B?UTBaaE9lUjhDZWhNdkhsL25ERnZaTThOUzgvUng1TEVTSmQ0SVV5KzU0T2xH?=
 =?utf-8?B?UjJ2WlhiN29Rdnp0VHAvR0kwajE2N1RKOGkyQ3M2TDV2OHVjaHI2My9ncjVy?=
 =?utf-8?B?ZXB2RXEyMUlScnYwcXN3bGpYZkhIZzF6UmZTUk5hbnBqQ0VSUFM5OFJLUUJW?=
 =?utf-8?B?NXpWUFhrbWZzMS9lSXNOaXRMT0dpclFHN1lFUE0raHFGS05nOTk3SkVzc2lX?=
 =?utf-8?B?TXo4SHZKc081K0ZveU9sT3R3YVN4MHFFL3dnMENyQ25QYWFtLzdzZFo5QUVm?=
 =?utf-8?B?eFJtelpXV0JLSnVnUTB1eHo1d1dSL2ZrWHgvWlhnU0NYSk52bFdFZlFkT09V?=
 =?utf-8?B?SEplbzE5Z2hLU3FNWVo1YXlWZTJOQ1Blc0ZnREZVSHBpdG00YjZhVzdqWWZH?=
 =?utf-8?B?WmpzVjBRRmdyNWF6WWd0RHh2WkpINVJVOWJJN0NJUjJzU2RvcHlkbVhXWWQ3?=
 =?utf-8?B?d2JPd1o0aGR2UVpBVEVzVDJNUDRMb0FnZDNoREdTSXBmVjVNcU5zRXM4cmtH?=
 =?utf-8?B?ZlQvR2h3UDlQV1dzWWVFTkI4dlNNZ0hIUmhxTVFETStaUjMxbHFBUjVQRSts?=
 =?utf-8?B?aHlXVWI2TmpLRXUwSitIZmdUcG5RWkZKckNQWDlzU2Nhdml0SlloZmRGOFVM?=
 =?utf-8?B?MW81RkYxdHFRZHEzNWRUT1RhZ21Pb0k4OEtLdFphd2hKMFM5STY2NDdBS3lF?=
 =?utf-8?B?MElOSGx4bENqYUlidzQ3eFFjR0hLUy9sRGVZN1lqRWpZVEhNNlF6cGRaYzJk?=
 =?utf-8?B?eVBkRlV0ZkorS29rR3pJWEpuSURkWUJzMzBCYUo4REpQTDVIRExzUEZZMnhk?=
 =?utf-8?B?VjdCQS8zQjdmeDhKSEljQXp6OU9aMXVXN0FVeUtsanhkVnZQTWkvbzBHVnpB?=
 =?utf-8?B?cFQzVGZMZE53cndxSUJ6SGZQNGIxRjB3ZjBiSGJxTFJNUXlqZEFvbE41SVB1?=
 =?utf-8?B?LzMwNkVFRStSTkxoZHo2c2trdVpHWFFPc3lKU24yK0JnK0VUQ1RKbk9KM3Fy?=
 =?utf-8?B?emhuZFdNQVFKSW96RHNFTDdSWjE3dHcxaXhianU2N3JJUmYxSEdJbFBYZG5I?=
 =?utf-8?B?ZGxmMkxWMmJRclkvaE4xTDFZclhSQ1pFcWtLeXdOVERzNFM1MlBJQ0pMaFdJ?=
 =?utf-8?B?elhVclp0Y3FxVGdmZWlCdVR1eGZaTGMyNUNDanNGY3duZlAyYW9sTS9qMjY5?=
 =?utf-8?B?cE1iWDlxTW5tTU5qVzcxem5mL21Uc0FXYmhKT0kwYzBrT0pjeUdreEF0a3Mz?=
 =?utf-8?B?SmY1SWI4ZEVmR3RXczg2Ty9yS0F2NnhBQzhFcThlTjVzMlM2aHRvVWxOa3d5?=
 =?utf-8?B?aGc9PQ==?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 057db02f-28fc-4803-06b0-08db98391819
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4879.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 17:58:38.9370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HI7/aJr1PGW8B803aXAQyLadzJ9siHD5KQA1mf5TpP4l+KhAlUbM6QEmwSfJptdHDUH//R3DuMJYRBsWXLdow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6764
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/23 02:47, Rodolfo Giometti wrote:
> On 17/07/23 17:52, Charlie Johnston wrote:
>> On 7/3/23 09:47, Rodolfo Giometti wrote:
>>> On 03/07/23 15:38, Greg Kroah-Hartman wrote:
>>>> On Fri, Jun 30, 2023 at 03:29:50PM +0200, Rodolfo Giometti wrote:
>>>>> On 30/06/23 14:53, Greg Kroah-Hartman wrote:
>>>>>> On Fri, Jun 30, 2023 at 09:50:33AM +0200, Rodolfo Giometti wrote:
>>>>>>> On 30/06/23 09:31, Greg Kroah-Hartman wrote:
>>>>>>>> On Fri, Jun 30, 2023 at 09:18:26AM +0200, Rodolfo Giometti wrote:
>>>>>>>>> Userspace PPS clients should not known about how many PPS sources can
>>>>>>>>> be defined within the system (nor the rfc2783 say so), so we can
>>>>>>>>> safely drop this define since is not used anymore in the kernel too.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
>>>>>>>>> ---
>>>>>>>>>      drivers/pps/pps.c        | 6 +++---
>>>>>>>>>      include/uapi/linux/pps.h | 1 -
>>>>>>>>>      2 files changed, 3 insertions(+), 4 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
>>>>>>>>> index 5d19baae6a38..1a6131608036 100644
>>>>>>>>> --- a/drivers/pps/pps.c
>>>>>>>>> +++ b/drivers/pps/pps.c
>>>>>>>>> @@ -354,7 +354,7 @@ int pps_register_cdev(struct pps_device *pps)
>>>>>>>>>           * Get new ID for the new PPS source.  After idr_alloc() calling
>>>>>>>>>           * the new source will be freely available into the kernel.
>>>>>>>>>           */
>>>>>>>>> -    err = idr_alloc(&pps_idr, pps, 0, PPS_MAX_SOURCES, GFP_KERNEL);
>>>>>>>>> +    err = idr_alloc(&pps_idr, pps, 0, MINORMASK, GFP_KERNEL);
>>>>>>>>>          if (err < 0) {
>>>>>>>>>              if (err == -ENOSPC) {
>>>>>>>>>                  pr_err("%s: too many PPS sources in the system\n",
>>>>>>>>> @@ -449,7 +449,7 @@ EXPORT_SYMBOL(pps_lookup_dev);
>>>>>>>>>      static void __exit pps_exit(void)
>>>>>>>>>      {
>>>>>>>>>          class_destroy(pps_class);
>>>>>>>>> -    unregister_chrdev_region(pps_devt, PPS_MAX_SOURCES);
>>>>>>>>> +    unregister_chrdev_region(pps_devt, MINORMASK);
>>>>>>>>>      }
>>>>>>>>>      static int __init pps_init(void)
>>>>>>>>> @@ -463,7 +463,7 @@ static int __init pps_init(void)
>>>>>>>>>          }
>>>>>>>>>          pps_class->dev_groups = pps_groups;
>>>>>>>>> -    err = alloc_chrdev_region(&pps_devt, 0, PPS_MAX_SOURCES, "pps");
>>>>>>>>> +    err = alloc_chrdev_region(&pps_devt, 0, MINORMASK, "pps");
>>>>>>>>>          if (err < 0) {
>>>>>>>>>              pr_err("failed to allocate char device region\n");
>>>>>>>>>              goto remove_class;
>>>>>>>>> diff --git a/include/uapi/linux/pps.h b/include/uapi/linux/pps.h
>>>>>>>>> index 90f2e86020ba..8a4096f18af1 100644
>>>>>>>>> --- a/include/uapi/linux/pps.h
>>>>>>>>> +++ b/include/uapi/linux/pps.h
>>>>>>>>> @@ -26,7 +26,6 @@
>>>>>>>>>      #include <linux/types.h>
>>>>>>>>>      #define PPS_VERSION        "5.3.6"
>>>>>>>>> -#define PPS_MAX_SOURCES        MINORMASK
>>>>>>>>
>>>>>>>> Why change this in patch 1, and then delete this here?
>>>>>>>>
>>>>>>>> That makes no sense.
>>>>>>>
>>>>>>> I did it in two steps to be clear that the first step is about a better
>>>>>>> redefinition of the PPS_MAX_SOURCES define, while the second step is about
>>>>>>> the fact it's now that define is useless.
>>>>>>
>>>>>> Better to just convert everything in patch one, and then in patch 2
>>>>>> delete the .h #define.  That way, when userspace breaks, you can revert
>>>>>> just the last patch :)
>>>>>
>>>>> I'm puzzled since I did as you say... patch 1/2 increases PPS_MAX_SOURCES
>>>>> value while patch 2/2 drops PPS_MAX_SOURCES define.
>>>>
>>>> Ah, I thought patch 1/2 renamed it.
>>>
>>> No, patch 1/2 just safely increases PPS_MAX_SOURCES value as other drivers does.
>>>
>>>> But why increase it if you are removing it?
>>>
>>> As I said I splitted the modification in two steps just to highlight that the first step is a better redefinition of PPS_MAX_SOURCES, while the second step drops it since it's useless for userspace. As you noticed this last step is not trivial since it may breaks some userspace programs, but it's also true that RFC2783 doesn't define it, so well written userspace programs should not use that define and then they should not break at all. :)
>>>
>>>>>>>> And if this is exported to userspace, removing it should break things,
>>>>>>>> right?  If not, why was it there in the first place?
>>>>>>>
>>>>>>> In reality such define is not stated within the PPS RFC2783, so userspace
>>>>>>> programs whose relies on such define are broken.
>>>>>>
>>>>>> RFC's do not document Linux kernel apis.
>>>>>
>>>>> It's true, but well written PPS clients should relay only on PPS API which
>>>>> in turn doesn't states that define. :P
>>>>
>>>> Are you sure?  Have you audited the clients?  if so, please document
>>>> that in the changelog text.
>>>
>>> OK, I'm going to re-write the changelog text adding this information.
>>>
>>>>>> So if any userspace code breaks, you have to put this back, sorry.
>>>>>
>>>>> If you think that patch 2 is not good, no problem, just drop it, but please
>>>>> just consider applying patch 1, since increasing PPS_MAX_SOURCES value is
>>>>> good.
>>>>
>>>> You can't change a uapi value either without breaking things :(
>>>
>>> I see, but in this case what do you suggest to do? Keeping 1/2 and dropping 2/2?
>>
>> I'm confused here. Is the problem just that the uapi value cannot be dropped (since it is part of uapi) and only patch 1 can be applied?
> 
> Yes.
> 
>> Or is it that the uapi value cannot be dropped OR changed so neither patch can be applied?
> 
> No.
> 
>> If the latter, how would one go about raising a value like this to allow a higher limit without causing issues for existing uapi users?
> 
> My opinion is that both patches should be applied since, the first one just increases the value of possible PPS sources, while the second just drops a define that userspace tools should NOT use since RFC 2783 - Pulse-Per-Second API for UNIX-like Operating Systems doesn't define it.
> 
> Is some userspace tool breaks, it should be fixed.
> 
> Ciao,
> 
> Rodolfo
> 

Hi Rodolfo,

Is there any other testing or help I can provide for this patch set?

Thanks!
Charlie Johnston 

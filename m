Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEF07BC6DD
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 12:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343822AbjJGKi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 06:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343792AbjJGKi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 06:38:57 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2114.outbound.protection.outlook.com [40.107.21.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A15592;
        Sat,  7 Oct 2023 03:38:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrZ7Eny4Xr0BX3Nb5qleGpZrn1YC4RSFUNr2eAcv1t4l0fC+RewzBj6g2zg83b/rWkhdPX4+z2WKZ0xhlbLdqyVALZMvCGs5hUt4+kN0kjC7EEqmOHs0zeAKUoQ/izc5Y+MGlmAfVBp8Sw1rXSByOpMUh/iHng5elrY7LJGASDfenlbefYam9kYHzVw9/aGZHlqrof4U+RzcrWac9JWc4Vsj4khnSz0oSC5NECxGLGytjXoU5mGdO1+oTSwFQ6Ffvnz7137DB+lmO6Z2adV57yd8ckuzmMMA78nlSrxVNNZCWXMpu7dO/boyoUTJCK3q2vkL/EM96fI8MiL5deki8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1H7JI4AKvUPZ3wxXYduHII370WaXS8KzIVp4/HxfOpo=;
 b=MzM26CDRDFheEzfcOpBGvjfFCpIya1WflkB5oJlUrxPj2IMj5q3n8C7chuxHSM+d9uC/84K8BTtvImDCf7ib2ex15XLQtAgAEQOm3zZ5JpAyZ8yvZgJQyKXvSDAgt5JcZL2gsKskSsh0JW18YrDWVw1FSw8yBlhfzb2T0srvtsaxYN6uCf5OgEabtGyqb4z5XJorESgo44NkTITbDlNYnvFc6rR5gyadiSah7qVl96pKo4g7CbEUoJf5mJc+6Dh0oYrWFlF3BdjsqoqnLSl8P2Ga87al6tvUVqA92keiSh5D4zvs5ww4wbZF+6FujCr96czbl7DgIBksTMVSjWQTzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=student.tuwien.ac.at; dmarc=pass action=none
 header.from=student.tuwien.ac.at; dkim=pass header.d=student.tuwien.ac.at;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tuwienacat.onmicrosoft.com; s=selector1-tuwienacat-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1H7JI4AKvUPZ3wxXYduHII370WaXS8KzIVp4/HxfOpo=;
 b=DzK9uxc7kVS84iQef7N4iCuDgHGjqTtsEI5e92tDSLY8bc18ALd4H/70QSV2vmpXcPdXzyrEIjcvTNKvDr5npPIIAQk5Al1xjXDkdFjbFpRoc3m+TeEBhD5qojnyL9qpWduDngRmO0nXAULyg644q4FHBASb11Pp8hTNFYX2+cQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=student.tuwien.ac.at;
Received: from VE1PR08MB4669.eurprd08.prod.outlook.com (2603:10a6:802:a8::23)
 by DU2PR08MB10107.eurprd08.prod.outlook.com (2603:10a6:10:46f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sat, 7 Oct
 2023 10:38:51 +0000
Received: from VE1PR08MB4669.eurprd08.prod.outlook.com
 ([fe80::34ad:5b82:1c4e:a377]) by VE1PR08MB4669.eurprd08.prod.outlook.com
 ([fe80::34ad:5b82:1c4e:a377%5]) with mapi id 15.20.6838.033; Sat, 7 Oct 2023
 10:38:25 +0000
Message-ID: <91b28627-c3e1-4b56-bd7d-ed8b607add39@student.tuwien.ac.at>
Date:   Sat, 7 Oct 2023 12:38:28 +0200
User-Agent: Mozilla Thunderbird
From:   Lukas Loidolt <e1634039@student.tuwien.ac.at>
Subject: Re: Missing cache considerations in randstruct performance feature
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Marth <daniel.marth@inso.tuwien.ac.at>
References: <f3ca77f0-e414-4065-83a5-ae4c4d25545d@student.tuwien.ac.at>
 <202310062111.809AB4E56@keescook>
Content-Language: en-US
In-Reply-To: <202310062111.809AB4E56@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0119.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::48) To VE1PR08MB4669.eurprd08.prod.outlook.com
 (2603:10a6:802:a8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4669:EE_|DU2PR08MB10107:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c11a980-9392-4e1f-ea0b-08dbc721893b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kBdGy0jfizv7SyTjvZw7pzoP6mnqilT+IPJGCnropGiEpJaqUZYpAA9k6xlon5KSHZo7WNIyWqYii/LgUSEpQQuBIFZ9oc9e6Bv1pbE6ocDvDWFuMCaOJPaQ+Ezyfs4LQhgMlic1xxAjylTgRwdRffQps9M7xd/z9PUNrVvXa4+4fwn8o8YhsCc+iaaAxo1J9eqDIlXvU2jvHAgT4eHXmO6ndfbbVL2XgOrNxgsIhlMvlq9RT3Bz84YUwUlijcjdbpUunqap2c1+2aP5P1h0MRc0/hzg3oxxNikoqYVb/JN78Otkxs9TirvNjo+UJNXq+y2WGqlGPUHUOxNQP1up4Iu/ROnvq9B5Y62HSkRIsGGRrRCpfICMtlvl5wIHhEchZYDELMebaq9YeE8O7KbCa3nH0QI4EY1yUr5Bu02Ye4Rr9DZW/jTJxDJrTNnsIHSVm0DTQmgGJAEZNW2FJ8rhLtUo6ibL8pqiGeo81A6SHWns3ZdApif970Q/rV9gX4yW7NylckMUpsKkWApgl1RA5r7BUjiGfyyDYTrikGDUcXmsy6Ky8/XB9VtWfyvnJJA9JD86OG7EisizCUQ5vc2ouBmTCAkhBc85Al7kR6FUrzSiy1KwtOEAZ0OnMyBVUhzyDroJr7yhzwn9mNlPTRUqgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4669.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(346002)(396003)(376002)(366004)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(2616005)(83380400001)(53546011)(66946007)(26005)(66556008)(66476007)(41300700001)(316002)(786003)(6486002)(6512007)(6506007)(966005)(478600001)(38100700002)(31696002)(86362001)(31686004)(6916009)(8676002)(2906002)(8936002)(5660300002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFBheFYvQk96Z1lRMnpWYTN2Yk12QklTclZOQnJBbkJYUkJESC9FTXVyb2p2?=
 =?utf-8?B?SlRNclg1MlV2UDZVQkhSdVV6aFRtK3oxSTdCVmVLazJTRlZ4SWxFNDR2cGJm?=
 =?utf-8?B?MkcyNjhONmhTRU5LTSttUjVmYnRBVzRZYXAwdjdoYmhDM3RiN1VkQll2TVRD?=
 =?utf-8?B?TXJDazU0SCtkN092aks4ZmpRbDBCZXdVb09pRkVuYldlSjIwUytrQjljUzVi?=
 =?utf-8?B?YUp5ajc2ekQrZG1FYUJLM3Y1RmNyQmZ1cnFzYXJYYzM1bUdwRHpYRWE3VENY?=
 =?utf-8?B?NEQ1QnpuSys5QkZsTUVEaG1RZ3FvQ2dobGxiTXlSc3p1akR5M042T3dJdURh?=
 =?utf-8?B?TzBYeEpobjVaZEI0cDdpL2FSTk54NTYybFNjQ3B1TFppOWlLeFVXWjZPQmpm?=
 =?utf-8?B?SFJzbFNtdFRnMEtVQmg1UFRzb085ZkdxR24wQ2tDVE5iSStGSlI3b0dzK0tD?=
 =?utf-8?B?ckh4TEx1cERuWHAybDUxNklJSHRPSjJDOE95V2tZd3B6RWNQYmxWaEljeFdX?=
 =?utf-8?B?aDE0WlNTaDZsdGg3ODBpR3pLdGtoQ2gyTko0VEwrT1pSa2hCc0xkcFF3Qlht?=
 =?utf-8?B?Vzc3WkdreG5nR0NzRDBIRE10c2JuZWQvNnEwQ3pWMHgxUVVNcFZuWHFGdXVE?=
 =?utf-8?B?SE1YdlhldmgrYldLeTQyODIyMk9qOUNhMldKUWhqZng2dDllOFFWVUtvN093?=
 =?utf-8?B?ZWF2TFJRUXArWUp3cVpnOXZ1aFFuRzJzODVjWHlzT0JEWXd0K05tM0huWGhl?=
 =?utf-8?B?M2xxWEU0OFhqL0JmV3BJRlhuc1dEa3YwVHJncFE3SHpFSitwWk9paTVReDBK?=
 =?utf-8?B?YkFlS0tuVnBWeVFYTDNlcTE3TWtLUjBBR0RVQjVkYWxyek12UlhILzBWY1VB?=
 =?utf-8?B?K29WNnFMb0FydGhDUjd5Qk0wRkYwT3dFMEZPQ284NHhvbmtjVU81dUREYVcv?=
 =?utf-8?B?K2lKR1JXbUN3MXlnRHBaRE5PTXdmZGVUNXB0WUpnS2FGUW5PVngraENPK2dP?=
 =?utf-8?B?cG1rRE9IVE5tY2UveS9FYzJQNGhPalpraTIwRnp5OFEzK0huVEtsVTZRbHkz?=
 =?utf-8?B?ZUR5d3V0Z1EwSFVnV1ZWejF4N0l6cnBPQk9pRXRnakVxNm1zV3B4UU5WSVF6?=
 =?utf-8?B?RERpcGx2blc2NERyRGhmdzhDYUwvS2sxNHNYblJSMjhPQWtMM05rVStCcHBU?=
 =?utf-8?B?TGMwRWpnbWh2bGI5eldMSHgxQjY2UTd3ZmVuQWNIT3RybVJLc3kxbjZwTnJC?=
 =?utf-8?B?c3k3cmt5aTRQMU1BZFYvTmtvTmVydXM1YnF4UTVuYmlSeU5DR042WWtYK0RQ?=
 =?utf-8?B?dWc5WGlBQ1ZYTm9RT2RUZHFudVBoK05BNWxaZlpKTk9udWtNS09WeWQxTDh5?=
 =?utf-8?B?Nk84ajBnVjVZVWcrdFIxZFZ4NUZmVXUzSVQwaVdDRm5xdzViUGxFNHFXc2Mx?=
 =?utf-8?B?dWxsSTBMdGlBQy9YOTErOWh3T1RjaC9Ybm85NS9LU2NXTXM4Wml5VXlPSUZZ?=
 =?utf-8?B?c0RwN20wdkc1NW91WlcxaXpmY0kyRjBDWVZJRG5pakFHMWhMVCtTRlNhaGw3?=
 =?utf-8?B?NlkzdnNYc0lwUVF5RzdsNi9obHpWWTNwZkJCb0JKekh5Y25aUlNtdmdMaDh5?=
 =?utf-8?B?Z2M5TWlibTMrRC9weGdUWk1tOHo5ZU1DZzJOQWRKK1F5aXRDNytuWEM5NlBP?=
 =?utf-8?B?TFkraXZraUNKUFIxTWJhV2JGaTM1LzVaVXdrNnErNytlY2htbGtXUmdzaHp5?=
 =?utf-8?B?bGszR1VMUXVqMHowR0JXMlNLR0RmZk1HZW5jSksxUjBKS0hwY092YzloVDBz?=
 =?utf-8?B?ZTdDNkJEY1NtTDk4eS9LS0ZMclNsclJPa1ZxT296VUh6a1I1OWNHbVRTazJP?=
 =?utf-8?B?cTZHVXJEZ2paTHE5cGx6dUV0ZXBjTENteHdrUzRZU1JZNWZZSm45WkNnVHFj?=
 =?utf-8?B?OFAySU9TaXk2a0oxdmlDK05PNDFpajFWRW81eUh3b0dLU1MrbG5zNmZWZTVh?=
 =?utf-8?B?QzNzM2ozTDNFY2trVERkNkdpWG1TYUxzdm4rMkZ2UEtndCtLdStoVloyaVhi?=
 =?utf-8?B?NDdwMXJRQm5Tc0dJQmtabnl3K2RkL2hCaFZTMmp5dDBNMVJwd243TTh6T3lB?=
 =?utf-8?B?eXJHVXpTc25JNUE5N3NCd3VTbW5UZTBlelcrTTdIYnYyZTFNVDdPWWhiM0tE?=
 =?utf-8?B?Unc9PQ==?=
X-OriginatorOrg: student.tuwien.ac.at
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c11a980-9392-4e1f-ea0b-08dbc721893b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4669.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 10:38:25.4670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: dffdfdd4-77f5-445a-9dc0-1f5c6d259395
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HK+M6bgsQOSDDRRUJJrbq3SDEmSy2ZTTXz0DXpbO2Q+Ygw9MapyO29MCKpntAFHMftjt3oUBZbkdTVahz7gm3LzCjmaBRowq+5/0IUcK/zE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10107
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.10.23 06:12, Kees Cook wrote:
> On Sat, Oct 07, 2023 at 12:30:01AM +0200, Lukas Loidolt wrote:
>> In my tests, however, the performance version behaves more or less like the
>> full version of randstruct.
> 
> Can you try this patch?
> 
> 
> commit d73a3244700d3c945cedea7e1fb7042243c41e08
> Author:     Kees Cook <keescook@chromium.org>
> AuthorDate: Fri Oct 6 21:09:28 2023 -0700
> Commit:     Kees Cook <keescook@chromium.org>
> CommitDate: Fri Oct 6 21:09:28 2023 -0700
> 
>      randstruct: Fix gcc-plugin performance mode to stay in group
> 
>      The performance mode of the gcc-plugin randstruct was shuffling struct
>      members outside of the cache-line groups. Limit the range to the
>      specified group indexes.
> 
>      Cc: linux-hardening@vger.kernel.org
>      Reported-by: Lukas Loidolt <e1634039@student.tuwien.ac.at>
>      Closes: https://lore.kernel.org/all/f3ca77f0-e414-4065-83a5-ae4c4d25545d@student.tuwien.ac.at
>      Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
> index 951b74ba1b24..178831917f01 100644
> --- a/scripts/gcc-plugins/randomize_layout_plugin.c
> +++ b/scripts/gcc-plugins/randomize_layout_plugin.c
> @@ -191,7 +191,7 @@ static void partition_struct(tree *fields, unsigned long length, struct partitio
> 
>   static void performance_shuffle(tree *newtree, unsigned long length, ranctx *prng_state)
>   {
> -       unsigned long i, x;
> +       unsigned long i, x, index;
>          struct partition_group size_group[length];
>          unsigned long num_groups = 0;
>          unsigned long randnum;
> @@ -206,11 +206,14 @@ static void performance_shuffle(tree *newtree, unsigned long length, ranctx *prn
>          }
> 
>          for (x = 0; x < num_groups; x++) {
> -               for (i = size_group[x].start + size_group[x].length - 1; i > size_group[x].start; i--) {
> +               for (index = size_group[x].length - 1; index > 0; index--) {
>                          tree tmp;
> +
> +                       i = size_group[x].start + index;
>                          if (DECL_BIT_FIELD_TYPE(newtree[i]))
>                                  continue;
>                          randnum = ranval(prng_state) % (i + 1);
> +                       randnum += size_group[x].start;
>                          // we could handle this case differently if desired
>                          if (DECL_BIT_FIELD_TYPE(newtree[randnum]))
>                                  continue;
> 
> --
> Kees Cook

I think, this is still missing a change in the randnum calculation to use index instead of i.
Without that, randnum can be larger than the length of newtree, which crashes kernel compilation for me.

diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index 178831917f01..4b4627e3f2ce 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -212,7 +212,7 @@ static void performance_shuffle(tree *newtree, unsigned long length, ranctx *prn
                         i = size_group[x].start + index;
                         if (DECL_BIT_FIELD_TYPE(newtree[i]))
                                 continue;
-                       randnum = ranval(prng_state) % (i + 1);
+                       randnum = ranval(prng_state) % (index + 1);
                         randnum += size_group[x].start;
                         // we could handle this case differently if desired
                         if (DECL_BIT_FIELD_TYPE(newtree[randnum]))


The patch seems to work after that though. For the previous example, I now get the following layout:

func1 (offset: 0)
func3 (offset: 8)
func4 (offset: 16)
func6 (offset: 24)
func7 (offset: 32)
func8 (offset: 40)
func5 (offset: 48)
func2 (offset: 56)
func10 (offset: 64)
func9 (offset: 72)

Regarding the shuffling of groups/partitions (rather than just the randomization of structure members within each partition), I'm not sure if that was intended at some point, but it might be worth looking into.
I'd assume it would improve randomization without sacrificing performance, and it's also what the clang implementation of randstruct does.

Lukas Loidolt

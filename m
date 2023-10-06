Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE6B7BC23B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbjJFWac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjJFWaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:30:30 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2110.outbound.protection.outlook.com [40.107.8.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD74283;
        Fri,  6 Oct 2023 15:30:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUD1rMtLkdCGGMYc/tcfovT4mXik6YmOBY9T5nh1aUXTATioTPQ68Zz9hDS0XMMatgTSaTClmrNUwXbPqGvzRlto/q+4FxcXL3hD7HeI6l6H5nMCG6hsWsCBGYu3QfREvVyBmYHRo4pUwuikRPrubpjrpgdtAmpxEsqmxqjrSb1ACGfpJ/PnQuPfyl/T+H9DIeyCw+r85nqnoH11poqU+6ANKDQoCC/ZCbffYKy1HlbrwYK2iZjX9pgHco8CBSW3dTV0mLf8E4/gpKreuZPQzZ2xt0pvqF0H0fZr7IewiPX965ZNdJsRt2AsBJFWruWbYPPKnfhakkFDKog334+AfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RX10GFvtLBVuTroFNxcIxFhuPwiW2mcOUFz+K/8Tol0=;
 b=Iji20x9X90P5X49hrO20mLThcQyPSybuCA0fO0/iqrZZJ4cekRBlRmLuEwao0LFlYHmMFarjE5gI1q6fXzdsxZ3j9V7IOZ1CWORN4TQexF5n87dCoQ+yd/wCND3gOxzw/o3lWBZAuErpaaCFO/dqdbQCAXXcMI2J2U4L0UAlgVjm7MMVqQadkwKmctiaHscq4XOiadLq+XaVSrhdRzLKyMi2rM2mQUJjDEMysU366hGuYrQYyHqrNlAUs/g45MbNm4DgHABIyQP/GRDOwM2ud5BYIT2CegbGw9xctJjCBYIkgT6JiJ8M8cPo3ckrR3Dv7gxaCnG6K52Hz1RXArPJsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=student.tuwien.ac.at; dmarc=pass action=none
 header.from=student.tuwien.ac.at; dkim=pass header.d=student.tuwien.ac.at;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tuwienacat.onmicrosoft.com; s=selector1-tuwienacat-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RX10GFvtLBVuTroFNxcIxFhuPwiW2mcOUFz+K/8Tol0=;
 b=WHOVaemK73ugY+/4IyX23H/Uj7727gryW39L/ZptZxffgPemVZvVSCOpooZXryxeXHvKR0LNJ4UwXT/Y3hqjS1Y/UB1gQtx5VYqe+SywC+ejlscRQUWlaESX1sVvu68f8Ks6FoiHH5a1y0nA4XJ5uMKGHt5zx3ZO/laPg3SxtT4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=student.tuwien.ac.at;
Received: from VE1PR08MB4669.eurprd08.prod.outlook.com (2603:10a6:802:a8::23)
 by PR3PR08MB5851.eurprd08.prod.outlook.com (2603:10a6:102:85::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Fri, 6 Oct
 2023 22:30:22 +0000
Received: from VE1PR08MB4669.eurprd08.prod.outlook.com
 ([fe80::34ad:5b82:1c4e:a377]) by VE1PR08MB4669.eurprd08.prod.outlook.com
 ([fe80::34ad:5b82:1c4e:a377%5]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 22:29:59 +0000
Message-ID: <f3ca77f0-e414-4065-83a5-ae4c4d25545d@student.tuwien.ac.at>
Date:   Sat, 7 Oct 2023 00:30:01 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     keescook@chromium.org, linux-hardening@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniel Marth <daniel.marth@inso.tuwien.ac.at>
From:   Lukas Loidolt <e1634039@student.tuwien.ac.at>
Subject: Missing cache considerations in randstruct performance feature
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0110.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::39) To VE1PR08MB4669.eurprd08.prod.outlook.com
 (2603:10a6:802:a8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4669:EE_|PR3PR08MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ce13cb7-ad5b-4403-6d60-08dbc6bbc625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Gvi0Np6KDy7nq0/dCpARbEWAi4AoAJgUXnyiGNLUknjfyuHYzronMVFRAUbAlMu5RtwgpZkvl2gjJGLjhp8rFwH6UWlS/BHLw4SkPIli2koFHKMdD59bBTL4/LpYwUn1YyCpnFKX4X7TdInDWuvhDDv0BhbACEEM7zCplN52/boF7Qr3ItUlBFPnnZP2Ew00WRwqlfNKeVNk/UVi15g7pvjakRi4JqQtchwU4g5TxqzZwTKko2Hf+dZ/4AZVnqAj8Zw37CtCXiho1sG6W661mOofzDKBOYSwQRC3LvMVI255EUuZJx2BJAouggvswmtJ3fnJJZdhI43yq85wUhNd75i8Oo0mYDZfrnD9hRKGTfVWngknEvxi28zaR5nRQVzE/iBJJ72IoC1Jv7mPodNchhmxGrxnPGhceIPl6ZIcLt597o0LGm8WywHsEY/CCf2WgJTYXZw4+KDwTf68hsbIIVkYhraxK8vhtgLvzQJ5PeFB5iAO6BMKWGXP4Hq35l1i7UyonQc2dVCikw1QOvZwD4HPHP1JAdOr9w3Ew/ktw5RYIAYVFWqo5TC3MppETU8aZXdEzUvWKwNJqyNlf6zWDowBeVHC3cz3PrRxWkv7lwVnwC1akD1jiqivocmhMHqiMIq5qwmsse5TaqTckSg8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4669.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(136003)(396003)(376002)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(316002)(966005)(2616005)(6506007)(6512007)(8936002)(6666004)(478600001)(83380400001)(2906002)(6486002)(8676002)(26005)(66946007)(41300700001)(5660300002)(66476007)(4326008)(786003)(66556008)(31696002)(86362001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFJ5S2tuM2daMnF6SjljbXlDS3QvbmlnRFF5c1ZqaTdneTF1MkoyT01vYlFm?=
 =?utf-8?B?ZUhpVlVrd3laN0ppZ1puTmdKTytoQ1hkOW9qKzVlM0cwM3M4VWhYeC9HSUsv?=
 =?utf-8?B?aElkMERVMWNSMC9NSHYyck5WVHM4eGszVGhrOGlqb2dwTnowVlZqQytFUW91?=
 =?utf-8?B?alVXQlJEYXhQVFRpbFJGQUQzS0lLZ3FISVBsWGlBZHB6SWRxZkdWRHpScEhX?=
 =?utf-8?B?MXR1VXRKRlo0Rm1ZcGRtZGlLaHNlR0dpTFhSS21VQUgxS0tjak5ET0VvMHQ3?=
 =?utf-8?B?UVpUaXFzVWJlN2dKQWVwSzJXczJjUDAwZHl6MGRyaEorQW1FNWxwRnlpaHpz?=
 =?utf-8?B?WlkzQk9LbmwvOWJzSmFqRU9xeXNqVE4xU01hMDl0RDN6WlZ2c3diSXMzQ0g3?=
 =?utf-8?B?bWhXdTZGeXVLSjNRaXZmTmFzR1FTVHMxcXJ1M0JpWVMzbUhuajFBUS9XZEF5?=
 =?utf-8?B?ajRXdU9hdXZZVDI1SVZYTXFGRnV6TnBvQ3JlbzE0K0ZvU3JWMm9BOW03Vis2?=
 =?utf-8?B?WkFGd2JheTNsdmF4TGwrRjF1ODZzT3dTVkVVVVIxbnBCQ3pBRzVhaVNHR3Bw?=
 =?utf-8?B?RzVnRk9UZVAzMTViWGtKUXVUV1dMTTlRejAxQkNXNC9RcDRCOHZRWUxCWUJY?=
 =?utf-8?B?R1N0TjNvemw2NHc2TXYyL0RoU010a255WUNiK3lIRGZqODhYK1pYaENnSDBV?=
 =?utf-8?B?Nm9xd2Ruc1RaOGd1am9VQk9HME9ZTjkwT3NjOWVTbzdwN2lYTFo1dThPREM4?=
 =?utf-8?B?WmcrMEh1ckg2R3plRHlDYnhmOG9EeFVnWTZjVXpQQlE1bXlMeWpWczV5NGJl?=
 =?utf-8?B?WmdUbHRWRys2SlQ2T3RRTHFtODY3OUxCcUZudUM3bmIyZUNONUxLbmdrN1U5?=
 =?utf-8?B?b21EMjZJcnErLzdFSnhjWXF0aDFHUUVrQ0VYeUlha3FJMGErZkdGTzFRZ0xR?=
 =?utf-8?B?QzY2dkdvRDhvYnlSMDZLVjZ3OVI5YkxZSHhkTXUySGNkZHZhb01Ra2hSOE9O?=
 =?utf-8?B?ZTNPWUVJb2FiOGNZYzhPWGcxZ2c1Q1dXL05pNllUOWNmaXo4VkNkRElLVnVl?=
 =?utf-8?B?c2ZHSmFubnl4ak41SnVsbmxLRzYwcDlSYzJoNVY1eFJ5WGhSamQ5MlR4MWJQ?=
 =?utf-8?B?alY5b2xYQ3BwdUgzQnNpWmE0MnIxV1YrNXpXNktvNGZrYlVXa1N4MFVxd29k?=
 =?utf-8?B?Z1dCbTROVlNkREQ2andSSU9RRFBEWk5PQmQxdGhnam9BNXBpTXpGOTZqL0ZT?=
 =?utf-8?B?RDJEMmN3bkd6UHZ0R29qRnljTk9WSitEdSt1WWxKMTdEakpud1pJUk9YN0NT?=
 =?utf-8?B?alppM2k3dHkwTEx5c0VDdC83cE5yOE83aGd5cVZJY2pGekhYY1FmNGpwUml5?=
 =?utf-8?B?aWJ4UEMzNko4TDZhYzBQbE5WL0dWU1lRemdLcTJmQUVpOU91Vk1DWFgwOXR5?=
 =?utf-8?B?ak9RbUc0cTR1U09wa25sTVlMTCtnaWsxLzBxNy9VM0VMYXMyZ3FoTk91M3Vq?=
 =?utf-8?B?c0tNclZLOGwrNW9heTFPL2VIVEFVZnBXejVOR2ZkTGJSekhOV0x3SmNsa2Jn?=
 =?utf-8?B?WTVnWGg0RlZwdmdxK2dvVDVHSXdmYVowL2tHN3R4SzJVdkZMNHBWVTZoZC9M?=
 =?utf-8?B?VHJHS21KL0NqNnc3ZFk2NGU1SWRvalhGdTc3THMyTEU3OW0rUUJpaUVxdkRr?=
 =?utf-8?B?V1Fqd0ZWQ0h2Ni9xangzRksxNC83NXdLenFvUVhNSWtpWGpqeEVuWC9qUUpI?=
 =?utf-8?B?UjB2azMzeDZpdnEvS1ZTbExrd0U0SU8zb1QveXBONklmenQ1QXNCenpLUUlQ?=
 =?utf-8?B?cjNZM3YwQVpJSGdxRzR1dm82b2FtZGJSZTI5SWxKK1hZVU91V2tzVkhQelJx?=
 =?utf-8?B?aDdQOU9DY05kaERwWkJTK2RZekxjZlM0ajR6ajRwclhvQUlXemVuekFhWnFP?=
 =?utf-8?B?a2ZyRVJEOTdjcFdpNWkxR1RWb0NZdnIzUGtqNjVQOGw2T3diQzJIYXVYZVpB?=
 =?utf-8?B?VlFjOTBSSWhGcW02bURIcGpIc1lTM1VHbTVmWkVSS3k0bUxMREFWamtPOW1w?=
 =?utf-8?B?VVBacWJaZitIOWxFVzc2VkttVmRGY0FoMlFEanY3TjFBMUIvT25NYTRoS0Er?=
 =?utf-8?B?U05mODNwVDNPNnA2MGFDcEpHZG56MEwxcERoMTJ1TjlIR0hwbm1STGVONTFk?=
 =?utf-8?B?TGc9PQ==?=
X-OriginatorOrg: student.tuwien.ac.at
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce13cb7-ad5b-4403-6d60-08dbc6bbc625
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4669.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 22:29:59.1541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: dffdfdd4-77f5-445a-9dc0-1f5c6d259395
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5j2qsfwYawG64IUmnl2aLhSm+LTO5USsFd7ZW+Us6V3UpDCNd72lcYEFt/BtGvCDvYIG6hwYKDSqTo4Hv8L5KG3AiSP6Kxm36EBeItZ5cFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5851
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I have been looking into the implementation of the "randstruct" 
gcc-plugin and noticed a potential bug in its performance version, which 
is supposed to limit randomization to cache-line sized groupings of 
structure members.
I haven't been able to find too much documentation on this version of 
randstruct, but my general understanding of its intended behavior is as 
follows:

- in performance mode, randstruct groups structure members into cache 
line sized partitions of 64 bytes each
- the order of these partitions is randomized
- the order of structure members within each partition is also randomized

In my tests, however, the performance version behaves more or less like 
the full version of randstruct.
For example, testing on a struct of 10 function pointers:

struct test_struct{
     void (*func1)(void);
     void (*func2)(void);
     void (*func3)(void);
     void (*func4)(void);
     void (*func5)(void);
     void (*func6)(void);
     void (*func7)(void);
     void (*func8)(void);
     void (*func9)(void);
     void (*func10)(void);
};

resulted in the following randomized memory layout:

func3 (offset 0)
func5 (offset 8)
func10 (offset 16)
func2 (offset 24)
func1 (offset 32)
func6 (offset 40)
func8 (offset 48)
func7 (offset 56)
func9 (offset 64)
func4 (offset 72)

I would have expected cache-line sized partitions of (up to) 8 pointers, 
so that func1 through func8 are adjacent in the final layout, but these 
partitions are seemingly not preserved.
Assuming that this is indeed not the intended behavior, the culprit is 
line 213 in "randomize_layout_plugin.c"
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/gcc-plugins/randomize_layout_plugin.c?id=f291209eca5eba0b4704fa0832af57b12dbc1a02#n213

where

randnum = ranval(prng_state) % (i + 1);

should probably be something like

randnum = size_group[x].start + ranval(prng_state) % size_group[x].length;

After changing this line, cache-line sized partitions are created and 
preserved as expected.
However, while structure members within each partition are randomized, 
the order of the partitions themselves is not randomized and remains the 
same as in the original struct declaration.
I assume that the for loop in lines 200 to 206 is intended to shuffle 
the partition_group structures

for (i = num_groups - 1; i > 0; i--) {
         struct partition_group tmp;
         randnum = ranval(prng_state) % (i + 1);
         tmp = size_group[i];
         size_group[i] = size_group[randnum];
         size_group[randnum] = tmp;
}

but the order of the partition_group structs is not written back into 
the newtree object, so the randomization from this loop is not reflected 
in the final layout.
I would be interested to know if this is an actual issue with the 
implementation or if I'm misinterpreting how randstruct is supposed to 
work here.

Thanks,
Lukas Loidolt

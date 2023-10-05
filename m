Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C577BA2D0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjJEPs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjJEPrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:47:43 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B93D5259
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 08:05:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=id/eqDEcqQ+adXaNFlAnushUnXE/KyoHpzBbuHsAKFe1XjE5u+B3yCVxY2Z1nx9xC9jYBUUFUEimGMUHifabZgDmkoSZI3DXu7Wgib1YrqBJjkrQ6vTqCenNmm5SO8T8XSeYktp7Cs8DZOOdpfYIgwptPeYSPyPkpisjVBbEumgPDuOeTGmL6AAeMnuaY/TrT8owzUe+ViSZbz5/MNAopCblgKKBDt1aUD05Wwap/3Ie8nDon9grrpuViGMq+2/ApNhrIwl9mzDkKQNP7tD34v65m98Y/bxuHxBcwUy1CjHDlsw1fJUZDk4BB804lLyWUg76RtSZFwKXhHUdAkQrLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Shxd3te+WcLJ7XLJ92NfGiYijl9svoF7tmY0meL2RY=;
 b=BfDHJ/29sdJGHnoN591fGVdRlF7bbKc17MvS40MVSO9KRfS1Hgbbo/7iyW3lHJ6DNTtAFST5j46Eb56IvmhGy6qmdJLLUR1KNNqnHh1Exfg92x2+PGDOMhTCteiKGrPSUXOlVC1U4FlTrAp4S+4DS4r4lmLt7YRCPGol6AC5hAZTTcKodYpCRkw0yRSsDk3SvK4XYgUZM+nJtpPXARdAC0s70kiSVrXaNNfOZs5piDn3lem/422v/PCjsKYFiCHT9M5gWI9m2F6XCUTg4JPBBUuINHcWOvMk8xhw/T0tJ38fKz8y0Ns1NlN4p6WDC0npn4KywFJToHfos5fJqG/ZSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Shxd3te+WcLJ7XLJ92NfGiYijl9svoF7tmY0meL2RY=;
 b=yu+99clG0aCAkTqVK6dCNqGhAaLy/L43bbnf5CaBKKYwU7znVpyqQn/Yko9eWOHb9pAZ56Q7dO7qVsmXvZGPbsGpGOp3Fh4hLV6yLgNCbxRuH7zlv0NiZqvVqpkq7BFlyG+td1LIuoNEjGGapqRwnRmbctqvohB/6/8ksloGH1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by LV3PR12MB9094.namprd12.prod.outlook.com (2603:10b6:408:19e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 15:05:44 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::a652:eb45:86f0:f68f]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::a652:eb45:86f0:f68f%4]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 15:05:43 +0000
Message-ID: <99d707a3-5274-1603-d0ed-f67ce83b7e29@amd.com>
Date:   Thu, 5 Oct 2023 20:35:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] cdx: add MSI support for CDX bus
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, maz@kernel.org, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, git@amd.com, harpreet.anand@amd.com,
        pieter.jansen-van-vuuren@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, abhijit.gangurde@amd.com,
        srivatsa@csail.mit.edu
References: <20230911135259.14046-1-nipun.gupta@amd.com>
 <2023100531-matron-oversold-4a73@gregkh> <87wmw1p4g5.ffs@tglx>
 <2023100547-retool-chamomile-d581@gregkh>
 <51b6606a-fdc1-de11-2260-863ac08071fd@amd.com>
 <2023100531-stick-cupped-78f6@gregkh>
From:   "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <2023100531-stick-cupped-78f6@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::16) To CH3PR12MB8308.namprd12.prod.outlook.com
 (2603:10b6:610:131::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8308:EE_|LV3PR12MB9094:EE_
X-MS-Office365-Filtering-Correlation-Id: 21fa99ce-c2f4-4aee-de9b-08dbc5b48be8
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WAfQKGG1DVnpqM+98q/cX9wHF7UOUPZXQq14fn64kvZzQOiLYyD5/kIK8dvdqMpUpW/Pv2i4Z4xDq+XHHxXGvWWnn5X59QY+PkDUvFlP5RDrTlGTglTH7rnuygyYnnZcLK374Fd8mtQNSyK0XQ7C9XGsnc+4axBbdyNEvszQtMO1HAGFsJ6oF2i77/eYmmcIshCMIFJomXoxwF3rPcA4H1XWIHNXvT7Xr1fdYBsXnERTo438qV/EUzaUKkhdHvXH7SHIC7atIi6lXs0amE689uPfdaSgjqu4veSSGUJDmTe7KvBOBS70wBiKW2MrOugVaUcO9fbWSzSwaCQLZoANM7KDWoALWH7fBBngfuLWW3MDWcz25mOKrrkvo8Cck1vCw5cZdj8nGbimOo8te34DEZOR9tbSlLi2V4PYkdSkI7JQzNBSOVddsNa3wmlM79P9Ouza8lwnOuXkJQfKBFqLPXeXvnTjwDxQN0evJxxW1iJYe2LyyjsbIbv2w1Rr7qs0rzAhUmar1yS9+TaCAvLl42CkCFoh0S374nj7xhb/58ANTu5hxaV9/fBTJ2G5P4Q6k2L/24GrLVQUdMiwQADqV6S7Ae3PbPNG4MWvJ+RczyDvPfQuLXY3JrUxieRcUGG55ncUwnolScsTpOJStMmsgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8308.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(136003)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6512007)(53546011)(36756003)(86362001)(66946007)(66476007)(66556008)(4326008)(41300700001)(38100700002)(8936002)(8676002)(5660300002)(83380400001)(6916009)(31696002)(316002)(2906002)(26005)(2616005)(31686004)(6486002)(6506007)(6666004)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzQvTTJUUXRhcU5vMm5MM0RkVlM0V2grQ3Rnc1JyeWdWcnloYzBsSVpWdEdG?=
 =?utf-8?B?T1JXSjlhenYrd0ZVRkdHUnMyaWFKaE4ySUw1TUlUeDMvTWEvOHphUUpOeGJ5?=
 =?utf-8?B?R2Jyekw0bXNSMm00d0VQMEFGdW5oaUl2Yk9TbGFxSGtYVlRjRm1HNXJ5NHBv?=
 =?utf-8?B?ZHNnejc4YkVqRHBqRUsyNEV6ZVoxMWZrditDb1o3WnJFL0haM1pnUFJIZHUx?=
 =?utf-8?B?Wm1adXJVdjlrejNDZmVyQ3hWRkd4Tmx0bEVOV1FNdlZCNFVZZU8yeHI3a2p6?=
 =?utf-8?B?QTNiMmhyN2IrQzhsaVRyN2hhYUNxc2ZhQ251STd4dFRIQk9qUHdhd3pqdCt3?=
 =?utf-8?B?S3cwWjIvUFJoOTBaYmtNZVVqL21wSjBwTVVwSGFRaTA4c0hJZ3ZTOXY2YXc0?=
 =?utf-8?B?ajNhRU9kcE5mRnhHOXJwb1ZBb2JaUzJab0tiU2NkSmFxRzZreHRnL1RIT2FI?=
 =?utf-8?B?VzB4cHZ5dTN0TjBndWF0akwxMUF1Rjl2d0JsellyZFdoWHRMdG92Z0ZRdVhD?=
 =?utf-8?B?SVZNUm9LekcxcDdmZXdQSFJKeWpGNmpJTUh2TUVlNmVDdTdWaVBWaUwyZkVH?=
 =?utf-8?B?V1JGN0U2bWR3MEtVNjhBU0lmRWluc1RCRGNPTVhLQ3hhVUMybG93NG1xU2Ru?=
 =?utf-8?B?UWNmdG5aeXE5Y1ZNc2RZN1A5OVJ6RnV1dSthMDRWNEk4YmJscDBaL0ZKbS9S?=
 =?utf-8?B?MEcyajUzNU9qcGNkblNhd0VncTlMVEJNWGpjUzlvU25jaGJNQW1LSDhkVi9u?=
 =?utf-8?B?anBxOExYd095Y04wM1pSSmwranM2dHVCZjlyR3N3NGtobHN6T2RhdXdDQXZT?=
 =?utf-8?B?elFBMjJuYTc1ck1Tb0psYnRrcXNlS3NVNHMzRDhYNDZiTnJxeURpM0plTDlx?=
 =?utf-8?B?Z3RlYTkxem4zRUtVanVkVUpYM0p2UmpJUVAvTTJZcDlMTGsxQ3RteVVuYTlC?=
 =?utf-8?B?TThCNVp4U2wrZ2Y1cE9MODhJOG85U3R5aXcyT2dLSkF5dnZmTWI0Nk5hNDBz?=
 =?utf-8?B?WWd0VXNvOXpyTnFyTWRSQXFLRHBJeGxHdFp4T0hHWkVWSEhTWStnNThlQ2dn?=
 =?utf-8?B?MlAvamcrTUxhb0s3VExnWjYxQ3ZRakNJekxwdldpaHRXV3crcFFkU09GR2Iv?=
 =?utf-8?B?aGkrTHNyRzd2eXkzVFJwZkovamRDUkh1RDRCSHlRcU5XRGF1aittMVZ4a3Fm?=
 =?utf-8?B?R1lLTmpkejZ4eHkzMW9PaFRERVNOeEpiNWdhSnQ4ZjVmYVdHS2p4dXcwbVBI?=
 =?utf-8?B?a1FGblJ4OG1OSmtIVUhsZ1VUTGR3MUlMU1ZZVVFsblVhNlBROUVHd21uTFAw?=
 =?utf-8?B?L3g3ZnJRZnRyYjlLSHEzSTdPL2xoWlM4RXNjS2FKdmVrdkN4akVUOEZ5KzBj?=
 =?utf-8?B?c1BYL1hrc2JQZW9BZDdxeUNWODhUa043Y3Vod1pPLzdhbEIxNjUrSER6a1cv?=
 =?utf-8?B?WmMySFovMTlSZGNCeW04Ky81QlNmWkM2VDNtYlV1R0Q0MXlKM3U0WC9NVzNH?=
 =?utf-8?B?Z1lORElNREZCeXJwRjVuam1vSVNRd2oza2RidlVjQWpvSkVwNXI0aTNnTjJn?=
 =?utf-8?B?RUdOVGRDVUxrZzVqUFdQam1kZUtqZ3JCU3VidXBtQlZRU2FtTUVGa0dnYXZq?=
 =?utf-8?B?V0ZyRVlFSU9VWDJ0NFpBTjZXTXJDeWMzalViVS9Hd20vK3ZCSXFJaGtzRmRq?=
 =?utf-8?B?cVNMNXRFZk8xcWRKc1FsbmRwUmFSSDliMCtrMC9xVUN1aTZLZXZzN1YwdHRp?=
 =?utf-8?B?NVN0eG9JOEkxWEVMU0hlOHo4VGxKNy9xcjFsQ2ZaWURYNFFZSWJPOFJzVk0z?=
 =?utf-8?B?YTVCUTNtR0Y2cnVXaFJzOWNpVXpMQkMxQnM4ZVFtRDdTMFpWMFpJcUh5ZTM5?=
 =?utf-8?B?R1dwUWFVdjJaVFVEOExxc3Bhd1ZqV0p4ZkVHOGJ4TXVnRnkyTllRa1Z4VE5N?=
 =?utf-8?B?K3JQVTEwcFBNMVprZVlKbkh5WXk5bm5tbzh3cXZvYVVWb2pDejk2RXZmUnM3?=
 =?utf-8?B?TUNqOG5UZHdnZmw0VDczcktWdTFNUytWaVJydFNqNk1Ld3gzZXhuaWN2aDRY?=
 =?utf-8?B?R1NHanVrYkFSRmU0bXp6T0xGemJPU3NnVnJWM085bHloRG9OZWVLY2IwRm13?=
 =?utf-8?Q?EMjmhVyn17HtRIcHhI0fu14vJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fa99ce-c2f4-4aee-de9b-08dbc5b48be8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 15:05:43.8686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 69quzlWIze5EjIKWkjrF6YXedeQRC4rG8heNN1ubU63tS6HxqKTMvWgnE57OrX/+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9094
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/5/2023 8:24 PM, Greg KH wrote:
> On Thu, Oct 05, 2023 at 08:07:35PM +0530, Gupta, Nipun wrote:
>> Hi Greg,
>>
>> On 10/5/2023 7:30 PM, Greg KH wrote:
>>> On Thu, Oct 05, 2023 at 03:46:34PM +0200, Thomas Gleixner wrote:
>>>> On Thu, Oct 05 2023 at 12:24, Greg KH wrote:
>>>>>> diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig
>>>>>> index a08958485e31..86df7ccb76bb 100644
>>>>>> --- a/drivers/cdx/Kconfig
>>>>>> +++ b/drivers/cdx/Kconfig
>>>>>> @@ -8,6 +8,7 @@
>>>>>>    config CDX_BUS
>>>>>>    	bool "CDX Bus driver"
>>>>>>    	depends on OF && ARM64
>>>>>> +	select GENERIC_MSI_IRQ_DOMAIN
>>>>>
>>>>> This config option isn't in my tree anywhere, where did it come from?
>>>>> What is it supposed to do?
>>>>
>>>> 13e7accb81d6 ("genirq: Get rid of GENERIC_MSI_IRQ_DOMAIN") :)
>>>
>>> Ok, so this hasn't been tested since the 6.2 release?  Wow, I think
>>> someone from AMD needs to take a deep look at this and verify that it
>>> actually is doing what it is supposed to be doing...
>>
>> The patch Thomas mentioned renames "GENERIC_MSI_IRQ_DOMAIN" to
>> "GENERIC_MSI_IRQ"; and in our testing "GENERIC_MSI_IRQ" is also selected as
>> 'ARM64' is enabled which enables 'ARM_GIC_V3_ITS' which in-turn selects
>> 'GENERIC_MSI_IRQ'.
> 
> Ok, but that's not what this patch "selects" at all :(

"GENERIC_MSI_IRQ" gets enabled because of enabling "ARM64", and you are 
right that what we are selecting here does not have any meaning now 
(after 6.2).

> 
>> The patch is tested for MSI functionality on 6.6-rc1. We will re-look into
>> the config dependencies to avoid such issues, but please be assured that the
>> patch has been validated.
> 
> How has the dependancy been validated as correct if there is no such
> thing in this kernel?

Apology for the confusion. By validated I meant tested for MSI 
functionality in CDX. Agree that "select GENERIC_MSI_IRQ_DOMAIN" needs 
to be fixed here. Will update in next spin. :)

Thanks,
Nipun

> 
> confused,
> 
> greg k-h

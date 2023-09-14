Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A886B79FE92
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbjINIim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjINIik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:38:40 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B1D1FC4;
        Thu, 14 Sep 2023 01:38:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B1wL28qs8wNv9ZUvI9nZQSLi25+1O9ZkCvVBEj8H0vfWpkn2b6OgrcbZARKhoB/1v10bILU1KyCo6BhBuxFS3PI+hn7RxvaQNBKnThMHaTpW+i1DBBuo7euIrTB/ZoVC5j7H04e53kAIAbNEdERzZP0p3adxowwKd0lJxJLbkoHATxrYqND3Nh2DOtwZrdGUJTTNI3O1CkfLq8zUvEbae3SQYhZi3sil7R0kX3DdDSW0XLeyqW1ccEr1IkuH9Wh9ulccrMamgmNCNEZZoeegzp6Nxa0y/lsLrFwmbsB6xLa6dj4pXRpuHqJPXFCMNENtrx6A176+SQkVtWmcZba5NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YERWMJ30B91l/sSfp9V6W9satlDcewaEx3lnE3+EPJw=;
 b=ZNwo7ejB9/7opFhpo0qNfmqce+C7SpHRDvguxENC/ELLQcRnzTshBdzWRM/SOhcwhs8sCOwVi4WZFiQ6sFhavlhHtwOxA3vAE7BP0LqafRU9GZE8spkuPk/A8B0O9XhadHjSqTpKWl15ctBW35/Kcoioc8n8a6dAYBs7t8sSKyxLVB0WU4lc/2br8a+TwyLHau1E4+WYPxnIB8Qmn9p72s6bj+iKcUe51hf3fDu2zPtn56E7GVyLDb2RfRvnpMHdPS+p+Ky0RgWDYM223fATn+ugs0mukxCR5MLx/fBTEqFzI6DEx/+RCJA5RoY4bAjxQqIey5/rfpBLAIa7E3CWdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YERWMJ30B91l/sSfp9V6W9satlDcewaEx3lnE3+EPJw=;
 b=n20O/7WJmxEIXu9uttFxEkBnLn9lkvqk9Qgw5RjvJcIBQCxxlnDCXxYu+FhQzfaUgTdha9jh969KbqLy4GeA7Axm8tsbRQpzaUmLbNw9zOnyLRI5EemhyrZcAxLHGU6hMGMeEmPfard4FDT3UOfqV8zKzY8mtT+vqk+rYZ2dSn4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5346.namprd12.prod.outlook.com (2603:10b6:610:d5::24)
 by PH7PR12MB5760.namprd12.prod.outlook.com (2603:10b6:510:1d3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 08:38:33 +0000
Received: from CH0PR12MB5346.namprd12.prod.outlook.com
 ([fe80::b009:6291:f87a:33b6]) by CH0PR12MB5346.namprd12.prod.outlook.com
 ([fe80::b009:6291:f87a:33b6%4]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 08:38:33 +0000
Message-ID: <9d4e175b-b8ed-85df-31a2-6bfb4a3616d9@amd.com>
Date:   Thu, 14 Sep 2023 14:08:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/5] Add new platform support for DBC
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     john.allen@amd.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230907184846.47598-1-mario.limonciello@amd.com>
 <5d9af84b-59e8-385e-5dff-0f12651fab52@amd.com>
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
In-Reply-To: <5d9af84b-59e8-385e-5dff-0f12651fab52@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1P287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::15) To CH0PR12MB5346.namprd12.prod.outlook.com
 (2603:10b6:610:d5::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5346:EE_|PH7PR12MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: 993a939c-7444-4b4c-6adc-08dbb4fdfacf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P5pue92VosRRRm+5S0MRLcx1RzCnPukgn88uZxLEQPcgYwgTkE7oTqrZTbiiuaMLAAGXsw+NpKKqbyVSa5r+hbKjkfHdge+G1E+4DrZhFQh03HOeNnf35VBfl/p6qu/ktTyMQ9F/ZjYUKT5f+sJEd3u7tRnr7RSaI5Ne32sJa9YFFEOSGrTM3ac+a4WvW82UTytGydCzyhSOyUe/n0feArtaFkPXFpsH0LJ5B2jqauBqy7p3YxSvit9M+7I9cQ7Bt7SjobfE7r6M3PR5ZwdPT9pzpH1wH/ekGtV1K5BFLsBUe9NpilxfSb2EjCezrENt+fj+FmHI63XV9PTCa4wG/M9kt4H+NokTE7vgbfMw2W46YMeyYuMwTCTJFmY8t0FIieSKstI6O0MV3B9h8s2/jvx6CO8oSHg7wb+v6hG7WziLDRzVwt+UhCWHsFqAfsCY9k8BCEPM47Km0vNifWRpq4VNjKLtYEZbtxqEw22QwdD6xAyyY5MGAdITB7nWUAsc8Ca4ZcHb3wvw8yYLsBEiFefHG5ajL76kjsHxxwD0QhB6XZTuqapaLYnaWZ0Inx3kQGMM7f7CDnQ4+UiZTge7mzS74ErplC/okUPvtkDQ/WE7Sxj+t83pOfUP94kwzLaH9vHSI5MXoFzruTMZCGtA+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5346.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(366004)(396003)(186009)(1800799009)(451199024)(41300700001)(83380400001)(316002)(6666004)(53546011)(6486002)(966005)(478600001)(6506007)(66476007)(66556008)(26005)(2616005)(66946007)(110136005)(6512007)(2906002)(31696002)(38100700002)(5660300002)(8936002)(86362001)(8676002)(4326008)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW80Rnp0YTJvaG8rMHFYL1gxTm5nOGd4RXY4UUFJM2F6b3dHU2JINXBHNzI1?=
 =?utf-8?B?MDkvU3BUWHEzekpaOHFTbE9QUW1YZzVZd3Q3T0h4TDlKWENYTUQxMjROd2s0?=
 =?utf-8?B?WW02Ynhzd3NzUXVjZlBLZGkzY0pZSHZUckdacDhHeTF0Zkl0UnhiSjFaMFl4?=
 =?utf-8?B?VEkxMDlLZWV1OW5DOGNZVitGMTBBRGI4d3RmVEQ2cHo2QUhOWnJlZkJKMW0w?=
 =?utf-8?B?U1BxN1JoN3gvamxCZ1NTUEk3bHdPa2xOUXdSc00zRUpsSi9NUi8yMzQwOExK?=
 =?utf-8?B?TENKRGp4VWNmT3U0NHFJa25OVzNjSmRrT0x6M2ZkbHFJTTdDVnVhbzd4L2RQ?=
 =?utf-8?B?WmQ5REpRL1BJaUd4TDJ5WlFDNEptNXRZWWVsdWpDWklWMlo4dkJLZndaLzV6?=
 =?utf-8?B?S2Q4QVV2ejE1UC9NZ0dVb1diQ1pEWEF4cjNXRXVBeDJTSFFrc2NQWEwweEl5?=
 =?utf-8?B?dzNhS2MzRkFXT0xZejVFWStQbk81aUZEMnlaQUlHQ1F3ZFA3cjRXZ0oyWnVj?=
 =?utf-8?B?aEpmTjNDL0tPNVE5WXEvcjZ5V3M4QmtHbXJjMENueHVVN2FQNysrbnlxVUlJ?=
 =?utf-8?B?RGtnSlFUOEJSWHFiQUhQOTNWSFpQK1NjRWcvQmwralo2bkJNV1QrUldHMzJ3?=
 =?utf-8?B?K0hObnNUeFhjTE9WMmlrNVRsblhCY3hNMWozbDUxM0hoNzJDbDhnckhYMmN6?=
 =?utf-8?B?Rm1OeGxKT0RJbnVUWnk0SlFHMjNVd0ZIOG45ZWNNNXJPOGdlQ2VkNTIwTHZS?=
 =?utf-8?B?UkVsRXBrdlZpRE5GYVFLVEtUQWVmYVBFUzRPcmMyMDVSODFmVGxKS2hxYUN3?=
 =?utf-8?B?STFQSjRvd1c0M2cvMW1HK3RNdWdob2FwOGhDR3FGY3lPMzdHcHcyOTNCQXY0?=
 =?utf-8?B?OElJWW9ObW5JVlFjL0xSRUkvRDBiTGkzWE9ROG1ZNHJHV1ZxOFpiQlNUUTZr?=
 =?utf-8?B?bzQ1RndKdEl0RU9oTkp5KzRSMlJ1cVppWjdNM2hVOTVQRlZaMWtDRWdpT1hj?=
 =?utf-8?B?SGJuTCtRclNmQ2l5MFhxYmxTRlFrZ1hKeWhYR2plOFFzQmJKaGZvL1Rsd2ta?=
 =?utf-8?B?c1JkbTJxR0dEQ2NZSG1KOVRXeDhvcGhyK0NES3FGNXBYTGEyR3RHc21yVTEz?=
 =?utf-8?B?a0ZkcDV2YUtGT3F1aHgxd1B2NzljT1pQbnI5MjZFdkdPZXF0dElCNXhZeDdS?=
 =?utf-8?B?YXJDcGYrZFBDWGJreEt0NlcrQ1E2R0VEWnJlY3VEMXgxR0VsalhRUS9TZW5W?=
 =?utf-8?B?MFBURlVGZnlnT05lRll4VW10alJRU2ZkOXBEbHZraUFXUGZRSUxCVXl5dFBB?=
 =?utf-8?B?RW9Ec050dklqdWE2SFIvRG01amxlemRic09HVzdubVlCS3ZBdHR0THUwQUVI?=
 =?utf-8?B?MEZtakZMbis4RU1OUUVkRnA2ZmpKZm1CTVRhTmhtTmtwRm56aVVDdW5haU1O?=
 =?utf-8?B?SW45TWVxR0ZGTXBteGF1Z3FhY1hJT2lZcGRWT2cwVmpwNlJYa2wvWHdrSUxJ?=
 =?utf-8?B?enhFeGdWQ2wya3I1eWI3SjRqOTVBQnNCUFNyOE9TdWFsbkxGRjBhNVUyZUZK?=
 =?utf-8?B?U2hxSURkdXIvRXg1VUZtdEVmRTBoNFZjU0FPS1VtaWtmTXAyanVMamxIOHJv?=
 =?utf-8?B?MlR6R3hybko1WFc1eUFMVThuZVgvWHpld1dUd0c5WFgxVmwrSlJPRVBEcnQw?=
 =?utf-8?B?MEI5b2FEVjBsUVZvaXlyaTMxZi9vaXlrTGNKSzQ2eWNrNDJ4bVBYKzhXQ2d0?=
 =?utf-8?B?UlNjcitKWjFGVEcvcTF3VGNCQmV1V1lqTG54TjZ6c0pzaEhpaWJvb01jbkJY?=
 =?utf-8?B?UkFvd0V4RHpReVBRMzNjNFQ2S3h4M3dLTFlOaWxnckZHSmVnZFBRcnpUbTRv?=
 =?utf-8?B?ZytQR1BkODY1WHpqZ08yeU9oOU9Rc3dvM1NTQ01LWEFucmNqYThVNFA3NldW?=
 =?utf-8?B?MkhPQ3dXQ3pIY1I5Z002Y1YxbThQSldhcDNnUkNrRVp6TDlZbTdDVWE3YlJs?=
 =?utf-8?B?ZGRFMXdRZDEvZVFLcHR5d0ZJcXg1RVFaWW0zb0VRUElUUFNURWRRR0dyeG90?=
 =?utf-8?B?UDR4K2IveGhNbGxOdnFDNHQrZWt3RStzTFVtTTB4MUdMY2pCQVFDcmxMOXB4?=
 =?utf-8?Q?mQvkqeOaUd5OGnWGFIv/noxjg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 993a939c-7444-4b4c-6adc-08dbb4fdfacf
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5346.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 08:38:33.4612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLAUI686uB35LCnnTuCAPuFkI2ydR4agnUET+xzp+bag9OUwtxo60HCGpeXUV0RNiOItmcxkTqvfWGOTjYg24Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5760
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/2023 2:58 AM, Tom Lendacky wrote:
> On 9/7/23 13:48, Mario Limonciello wrote:
>> Some platforms that support dynamic boost control (DBC) support it via
>> a different mailbox than the platform access mailbox.
>>
>> This series adds support for those platforms.
>>
>> It is tested on top of the fixes series. The prerequisite patches refer
>> to that series.
>> Link: https://lore.kernel.org/linux-crypto/20230829150759.156126-1-mario.limonciello@amd.com/T/#m47782729377f6fe5d62130cc701dae7f15306726
>>
>> Mario Limonciello (4):
>>    crypto: ccp: Add support for extended PSP mailbox commands
>>    crypto: ccp: Add a communication path abstraction for DBC
>>    crypto: ccp: Add a macro to check capabilities register
>>    crypto: ccp: Add support for DBC over PSP mailbox
>>
>> Tom Lendacky (1):
>>    crypto: ccp: Move direct access to some PSP registers out of TEE
>>
>>   drivers/crypto/ccp/dbc.c     |  72 ++++++++++++++-------
>>   drivers/crypto/ccp/dbc.h     |  29 +++------
>>   drivers/crypto/ccp/psp-dev.c | 122 ++++++++++++++++++++++++++++-------
>>   drivers/crypto/ccp/psp-dev.h |  55 ++++++++++++++++
>>   drivers/crypto/ccp/sp-dev.h  |   4 ++
>>   drivers/crypto/ccp/sp-pci.c  |  22 ++++---
>>   drivers/crypto/ccp/tee-dev.c |  48 +++-----------
>>   drivers/crypto/ccp/tee-dev.h |  15 +----
>>   8 files changed, 241 insertions(+), 126 deletions(-)
>>
> 
> Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
> 
> But I would like to see a Reviewed-by: or Tested-by: from Rijo-john for the TEE changes.
> 

Done.

Acked-by: Rijo Thomas <Rijo-john.Thomas@amd.com>

Thanks,
Rijo

> Thanks,
> Tom
> 
>>
>> base-commit: 7ba2090ca64ea1aa435744884124387db1fac70f
>> prerequisite-patch-id: 4bcf7f3ea21472e4e28c2457cc9827f6023ec6ca
>> prerequisite-patch-id: 903be53a20306f0188e52015dbfe5196738bb2eb
>> prerequisite-patch-id: af396bafb6acaa9c203c1a2c5f4665171cb45e4f
>> prerequisite-patch-id: abe450d4bf1de4a5664a41dbf84e72b1d4bfdae7
>> prerequisite-patch-id: b0b9cf55fcb73a11de6f3da73412fb090562857a

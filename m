Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBC976C3F1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 06:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjHBELa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 00:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjHBELX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 00:11:23 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20D226AA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 21:11:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHG+a98zc23tdCCZppjrZGxK4W2Uaqx7EM/PrpKwwFYroUbc3fe8NIff08NnK+tb5N+rkPQeqbxvM9nQsTT+woCJvo/6KwVhIq6I52W643bTtNmr7uzzgUygAn+JvIaW6/gax3MlQMAI3/hzd8nReQAUXYbqjTKdeRRqZM7qv0Lj6J8/a5h6FuQgzzQl44Ac+EDK/GNJ+vBMZj2WixGIvabxmgKl2JVwackrdP+IlKDrX/Z1vri9aTkfMW8S0dwabXneTZJyNJyfkjGduy66NrNvVdi7epsTk7iDPKbo2MSHkgZirhQK/yf4Dbd2oj1H4hRidMEEV6J0TQldeeuTqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxfWaOllZQzq38briSCNbt1rlnf5PSuxJ8ytjihi6x4=;
 b=ZECGVZnK2/y/fyh4w58wDybqqD88KJL2k0D91C6opeq5dkC+1sfclD8/hhErU/uvtBsupWSLLEa5z+qN4g+6a8zQKwsdrbpSxgU6An4gOdZFJxBsbiO4kAcUe7FND4QA6/qaUrw6pFIYFMOxFCVSXQiSPVRlJCVTxYQ+dvX8A4rD3mEQF0hJGFaHiyOce+Zhmv9iUvohK7XYyq9F/+mS0YERGHo52f217ChLHEuuIWetd1oQ4RlRAlOde1baTv6tbVWbFLusUm9hMv+feJXCKJfOUgKy0/UnOkMRmNoEwskj6sGcnBHbw1UlXM+dPV+y1JySbMxJbQCBuapeUtUmMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxfWaOllZQzq38briSCNbt1rlnf5PSuxJ8ytjihi6x4=;
 b=Gek4PLtWvLo2B4c3HOMa7jUt8tNpQrpigRtmaMpJXCHpzf1AEdDI6yVa9bnJ8kudnLFfnZyaq+eRGjs1e6uj3EFAnUmxhgvCUWNkPh3lbLNocwNuffoNp9uV7wMGYsmPatcZ26WyEJfyJjeqLt0GxzRsqlZcXmOtNctN9Zxc8nE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 CY5PR12MB6059.namprd12.prod.outlook.com (2603:10b6:930:2c::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.45; Wed, 2 Aug 2023 04:11:08 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::9ade:451:96c3:7b54]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::9ade:451:96c3:7b54%3]) with mapi id 15.20.6631.042; Wed, 2 Aug 2023
 04:11:08 +0000
Message-ID: <9c988372-41d2-7dce-0e9d-be9301791a8b@amd.com>
Date:   Wed, 2 Aug 2023 09:40:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: nikunj@amd.com
Subject: Re: [PATCH v3 04/14] virt: sev-guest: Add SNP guest request structure
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     bp@alien8.de, dionnaglaze@google.com, pgonda@google.com,
        seanjc@google.com, pbonzini@redhat.com
References: <20230722111909.15166-1-nikunj@amd.com>
 <20230722111909.15166-5-nikunj@amd.com>
 <b01a4948-0632-f899-2357-3bba6bc358ae@amd.com>
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <b01a4948-0632-f899-2357-3bba6bc358ae@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0208.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::16) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|CY5PR12MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f2c1c7-60f1-4e01-6150-08db930e7fb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2T3aoNnf+QiWi+hqsZPimLR3W/ldT9Lk0ELp96uugPPvL9bfAfTtvfcKCNZiCjLplCg94XSRSIsZ5sqdv/uviZxvIqM35geJW+q1DW6bKzp2KLmRUHA0hkPLLZP4LecfyHWIe5+U+qQ5w9zssIv/v9nx4AXzoFbKcrouj6q8xfBeOODlOklgHVpAB76ZKSzPJoF0jpM83BzZ6qqOG/jaSVQFjM8EDISo6RXr9OiBHat6VikJxEkfd+fdZ+doP08wwHCvoEApNcJ4A36ePqMMsSB0emyhxYLGnjIaX/9hFgxM4APKPNXpv7FTuCSSlxduHEouYJgQGtoqEHagfJj4rwipfvYAuScjLy8Mnsfegh0x24j85OlLJ0TGXZvktcL4pZkys9xrEUrYUTY0rejryPa3OXxmoj/QtPaTA8Hj1QqDLGlffsKHQUxaKI4IhapuKHam2Wjhwb7zamX0+3/fuO3wec7Hnso+E2pYjCsXh3Q7Rx0T3Uyo61PcfR8Dr/8+aZrhR+tdbxvvp69QTe1zzIR85zuCS8YFGeSTHbPAmN2cdeqZ9Ah7uxXCzF24US5Ck2ykZfOIv/VILxMlPH6N0/L7hhLQXVKF1QLAvKJvWdh0eaKwfWmxQf62UJflZCzCuWcPLScx8V58idNugblAfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(2616005)(186003)(6512007)(316002)(478600001)(38100700002)(66946007)(66556008)(66476007)(6666004)(6486002)(4326008)(31696002)(6506007)(53546011)(36756003)(41300700001)(26005)(8676002)(5660300002)(3450700001)(8936002)(2906002)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzA0M3MzZnpXdFVzM0dudk9jdjlWS0R5aXhwRWZUbXRXUkZyRGZrc2RLQnFZ?=
 =?utf-8?B?QXhxVGpqZWhCNDREZ2VtWWtERHRTdEpJRkdQTUFJazc2cHVObFluSHpWWVUz?=
 =?utf-8?B?Sjh2RHp6b3NPU3BJTk15c004NVpEcWU2K29VQUNQSlpjSDVxN3JVOWJTRGJo?=
 =?utf-8?B?a0oxbk13K0NzK1lBTjNBKzQ3R2syTGtRdDdUbXFOMXFaRlhqWXVCai9Ic0th?=
 =?utf-8?B?UENTL24wbThadHVsK2t4NHVuZ0dBVmdWbW9OazVCanhudGlYSEJDSVFaRlNE?=
 =?utf-8?B?bm1TT1dPNHROQldSZHh1NGFVcWlVQ1JGRHRSY1ZDRlNjb3BobUt2cGJzMU1y?=
 =?utf-8?B?ZDZjVy9KcXMrUC9Bam10aU0yWlNyaEpCKy9sbGcySkNnajZGM2s4VHV3RXhE?=
 =?utf-8?B?Y3k0NXBJTm1uN1FvMTFHREg1eDNiZ2pYS2F6TVpudUlzUCszZ1lDUUxVWFlX?=
 =?utf-8?B?ckthdnFweXRRVHNJZTBXTmMyRk1PbUE1elhiQWZGVGZqN1BhdThReHEvaTE3?=
 =?utf-8?B?S0F3T2NtbjBscVVFR1N5cTFYNXB1d0l3a1hyWWJoRFFkdHlmOWRpUCtQOEZu?=
 =?utf-8?B?RjdUNzlKQjlwTitNU2RJSlJSNXhVdGRnVzZuSlNzOTIwUTZ6YklQRHh0cFRN?=
 =?utf-8?B?RUdhaXAwaHNXQVNWRC9WdjZDc0svSmMyckxOdVVzY3V4WjNFTzFUNVhlSnBm?=
 =?utf-8?B?RlRSUDE5VVZ0YlhvY0tkNEhEa2oxZ2pRazVIeTZ2ZDdLYVhjMWE4bDdlUzhU?=
 =?utf-8?B?WDVINmpXVDA0UkdHNkI5M1FIQ2RFSmpneTFkREZDNCtQanlUc2RZb1NrQlBo?=
 =?utf-8?B?MU5ZSGNkcy84emkreXJ4UWtUQkd1NStGalBCY2lvT0kvbTBKdHI0T1hGVEJC?=
 =?utf-8?B?NmpJbEtzdXNOQ0duY3pWWC9VQ1NLYm1Ta1VTekVEOFl2djNySURVYUtaQlVq?=
 =?utf-8?B?NW83U3AvOFl3Y0hjcFFKWkgwVHppRU9heTk0SHlLSW5wQVl3ejdIWHBqbUNL?=
 =?utf-8?B?SGhDZ29ialVsdVZCaEczRXRVMWk0YkNHV0hKQVB1YXk3ZndlWHErUWNMV1NH?=
 =?utf-8?B?NGU0eHBHTGphUHRNMWpkVUNCM0pYL0J3YS9FN0paS0pPQjFrUTZUU2xDTmJ5?=
 =?utf-8?B?S0RvTFpvNkpLenByNGwyMGpLcm5peTVyYklId1l3Y1R3aUYyeDZyeFdXNUtX?=
 =?utf-8?B?RHpHWU1kL2ljRGJRRjkxdW5PUnNiRHJmR3lVK1VPYUZuQ1o0QzBYRGtYeE5D?=
 =?utf-8?B?Z1QzV2lyWGNVbjRCWWdFazNYM2lFdEZHR3hqNC81d1l6Y2VseGNDNEh5T2F3?=
 =?utf-8?B?MjQwUStnaTJWSE8zSlFxbmtWcklDUFlIVnFqRmwxWmpBZXhLaXM5MHhiQUJX?=
 =?utf-8?B?LzNMMDdkSnpIWFdyUzZMVFRKNWNVUWt6MTVoMGZoKy9Nb0xzNkJiYmQxWUJo?=
 =?utf-8?B?Slg5RUo5cjJ2dSttdnhGa1E4VVlQbmVWaStXMTI0SVQrdVJMNVFGRGRyWE1I?=
 =?utf-8?B?NkZMbnR0OWNkcVc4TW9NcElzdnFxZ21naXZ5RlNSTnY4dUg0NkNVb2s2RzBP?=
 =?utf-8?B?TGVNTlFxdG9vZVlCVzlJbmdvcW5PKy9reU1oY1c3LzJUYnpvQmc3Z0dHdnFW?=
 =?utf-8?B?MVlEZjhha0JTVzNWR2VSUjhRSnlRMFZTcVhUNVlEMHRqRDZ1TUJHRXkxTitx?=
 =?utf-8?B?eUdxMHlLTVRXS2QvSWY2M25hd3RjNjNWaUNHSEUvcWlVK3BydmRiOHk3aVpk?=
 =?utf-8?B?S0x4SGxudDQxQ3V2bzg5WmVTaFlkaE1VZHd3WHEvcjVPSTY5bWQzdlR6U0U0?=
 =?utf-8?B?d1F5Z2ladGRTN0xDRHBiN3h1c2NKK3cxL29RMk1ybnZPM21adm50SFVxTm1S?=
 =?utf-8?B?MklUdXN5V1BBL0pWb0NlYWo5OXo0d3ZNblVQZ2pqL1ZZSzlRQjVVTjk4SHlq?=
 =?utf-8?B?VzNyOTF2cHNjZm1DQ21xdTdrMG5CcE1OYVVmZmdVc3I5aDVQeUgzakdzaVZE?=
 =?utf-8?B?OWtIbE9iSU9QL09WUXFJVFZQQTNkS0xMWit4VEFtSG1ld0FDNkNHUTVOWUw2?=
 =?utf-8?B?OWxZUTl4ZGNodUpXQi93b2pKZC84T1RSTzJ0bmtrbG9FaUsyMzcvUUlzV0RZ?=
 =?utf-8?Q?LfmrAZkuBu+VJTDuhieaz4WwU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f2c1c7-60f1-4e01-6150-08db930e7fb1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 04:11:08.8254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCJ87Z+/M5pf58RlDXk09IVYvGp4fnbZYQ2cRisJwrM1H0J20jt37IEhmjqpgt7/gzH8osPor7FEeqKGuvDfPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6059
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/2023 9:19 PM, Tom Lendacky wrote:
> On 7/22/23 06:18, Nikunj A Dadhania wrote:
>> Add a snp_guest_req structure to simplify the function arguments. The
>> structure will be used to call the SNP Guest message request API
>> instead of passing a long list of parameters.
>>
>> Add two helper functions for filling up the parameters:
>> handle_guest_request() and handle_guest_request_ext(). GET_EXT_REPORT
>> queries for certs_data from the AMD Security processor.
>> handle_guest_request_ext() provides those extra parameters for
>> receiving certs_data from the AMD security processor.
>>
>> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
>> ---
>>   .../x86/include/asm}/sev-guest.h              |  11 ++
>>   arch/x86/include/asm/sev.h                    |   7 --
>>   arch/x86/kernel/sev.c                         |  15 ++-
>>   drivers/virt/coco/sev-guest/sev-guest.c       | 107 ++++++++++++------
>>   4 files changed, 93 insertions(+), 47 deletions(-)
>>   rename {drivers/virt/coco/sev-guest => arch/x86/include/asm}/sev-guest.h (80%)
>>
> 
>> @@ -398,6 +393,46 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
>>       return 0;
>>   }
>>   +static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
>> +                struct snp_guest_request_ioctl *rio, u8 type,
>> +                void *req_buf, size_t req_sz, void *resp_buf,
>> +                u32 resp_sz)
>> +{
>> +    struct snp_guest_req guest_req = {
>> +        .msg_version = rio->msg_version,
>> +        .msg_type = type,
>> +        .vmpck_id = vmpck_id,
>> +        .req_buf = req_buf,
>> +        .req_sz = req_sz,
>> +        .resp_buf = resp_buf,
>> +        .resp_sz = resp_sz,
>> +        .exit_code = exit_code,
>> +    };
>> +
>> +    return snp_send_guest_request(snp_dev, &guest_req, rio);
>> +}
>> +
>> +static int handle_guest_request_ext(struct snp_guest_dev *snp_dev, u64 exit_code,
>> +                    struct snp_guest_request_ioctl *rio, u8 type,
>> +                    void *req_buf, size_t req_sz, void *resp_buf,
>> +                    u32 resp_sz, void *certs_data, size_t *npages)
>> +{
>> +    struct snp_guest_req guest_req = {
>> +        .msg_version = rio->msg_version,
>> +        .msg_type = type,
>> +        .vmpck_id = vmpck_id,
>> +        .req_buf = req_buf,
>> +        .req_sz = req_sz,
>> +        .resp_buf = resp_buf,
>> +        .resp_sz = resp_sz,
>> +        .exit_code = exit_code,
>> +        .data = certs_data,
>> +        .data_npages = npages,
>> +    };
>> +
>> +    return snp_send_guest_request(snp_dev, &guest_req, rio);
>> +}
> 
> I'm not sure these intermediate funcitons are really necessary. Can't you create/build the struct in get_report() and get_ext_report() and then just call snp_send_guest_request() directly from those functions?

No particular preference, for tsc_info in sev.c I have build the structure directly and called snp_send_guest_request() directly. I will remove the above helper functions.

Regards,
Nikunj


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB6676D466
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 18:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjHBQz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 12:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHBQz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:55:57 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96320119
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 09:55:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XodG7Gdv0V5j91EeHQCeV+HxJSWeJBkVXzJf0p5c5UA4J9qZiokiPKvvnhmnXNhAXfSmLopaqTLTH5G7OALXgC8yjvcoWBO9uhmX8b04A27xF1TSDGITglo81D+O3khyvFj4HqAMBBC5PazxVCLFZumRrGVni8ZJa9lPaVEqpZr7djCZHI3n7zwWXbTRFMKMx7Imn5+QVrdVKFS+lglUj3IOJl1ODRQ70RaEMe89XBbFUvs0Bt7lUBG+APIQKZcDIMDLb3nX5i04rjqWLQ/ollgqzZGbQzF5kmAqeeu6y4L/LnJPOj62+vZSwLJOOpHR6MF44VPgvWKHxxcT9mw38g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etViYgLM8FG48PTQHKkTZjVm/2S1UdTJr+wq0WuFk1A=;
 b=gv8SzGhdfZFsNkPbD0fh4gcnTNQ7C9EdS9TBGFEI4zWCuigm0Ym2jvskCVOjPu20usUMzapu+HUH6RPGilf3mCT/6UoQ8ORrlobBk9CfROvOd7ePe+xRHhiOSG1OBmpcWoJVwgoX0J11xaL2iAtJeJplaqTHs+0LwVg+T8VG5KuzoQ7Cma0rjOpYbP4TZGIQy5Ab4pXqjf1a21ougPrJKlKW3GwE6lq49hxs/KL0movjm1s2iK7TQLWBOneAM+5lrDKN6LjVTmNwmeCGlowTVK616VkfiJkTVVUBxzDzuLyXdcr6tcWZdAaIT9edzDb7DPbysBebCDJl0x5OzWHNBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etViYgLM8FG48PTQHKkTZjVm/2S1UdTJr+wq0WuFk1A=;
 b=HDOYdqGudxgA80jngqxTrzZMUX+FwsDXk06sD317rI8QgVVLL+mV6wC3bam+VMN8g21eGUU0bAvVULm4BuARIwE7urSi45hqsTadiuwCBLxuV51HJcFYSbwkDl2lbpEUBLGQXDvHDguVFGOfXlJOiTrT0bP30SQ63OXmduz4DOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 16:55:53 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 16:55:53 +0000
Message-ID: <cae0b2e9-12e6-9d2c-506e-0dc6f72988a4@amd.com>
Date:   Wed, 2 Aug 2023 11:55:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 05/14] virt: sev-guest: Add vmpck_id to snp_guest_dev
 struct
Content-Language: en-US
To:     nikunj@amd.com, linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     bp@alien8.de, dionnaglaze@google.com, pgonda@google.com,
        seanjc@google.com, pbonzini@redhat.com
References: <20230722111909.15166-1-nikunj@amd.com>
 <20230722111909.15166-6-nikunj@amd.com>
 <1a4e6652-2e24-955c-5332-da84cced68e4@amd.com>
 <100d7145-7307-20fc-2cc9-0c2edd08f3ef@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <100d7145-7307-20fc-2cc9-0c2edd08f3ef@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR01CA0022.prod.exchangelabs.com (2603:10b6:805:b6::35)
 To DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|SN7PR12MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ff9a849-ae20-469b-b6cc-08db937954f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K44HrZwTE43r2743lasKyO8yO+yRMZh1MjN8Whqy7JzKp5yj8DZNwS1fNk1G/LNIsfZ8RDpfu6AUpFoLl3FziK+Qh9DZXUY0tCW9qQvvbEpuFDuYT64LYMWs/5pOlLZTWJafJet2MlgJqfkxBGC7UdWf3/EVoNPOfAlTgd8OmjOuV+M5KL3IAKuHMc1K45U9cW+82cqrSpexdCYzgGvCnpBoxIKHPeB5hPBA2IJXTyVnR8Av+xc6ZaTHJyFQwYRw2DLk/E7oeQIKAG5RuUzlmXDQ+Z6G1JdpSVuLyX5KNFzrpcQtb50PDZosd2vy6SSmurtO6zqXArtwazogdT12ghSqyvNZdGbYTV6WNDnAyQXuNkSFKPtrE+a/ayZpfBqNzfaN9fAE/Xz7IvwWly1E2xYKo/+yKCx6B4Ore7QZD/BEeXf+o1TqN5HdjrBB85dWVL/dmYnNoye5BP3wclvdjLsgslm7l7YT5WCAYECxyUiNxDz/KHwytCBn0iCbdQJx5SIST1AF9sODB1h8SjiycL7si5/ZMuWd/DVAilYQ4Mb5jqGr7DpR2xJw0E/WJwQZXy2MxAnIaGDm+M2kcx6bM7XdGFhbdffEHpohoOSHxTOUtVkTC5/6utH95DCbHMe3VrpRqRK/6XgsS1Udmadfqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199021)(8676002)(5660300002)(83380400001)(2616005)(38100700002)(41300700001)(316002)(186003)(8936002)(53546011)(26005)(6506007)(31686004)(4326008)(86362001)(66946007)(31696002)(66556008)(66476007)(6512007)(2906002)(6486002)(36756003)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlhVOERrQ1g5di9WaGJIQ1A0K0tTdjRXUEE3THAwT3NNTHRyczNveWVCOGd0?=
 =?utf-8?B?c0l0b2R4RFY2UEQ1ckcwNXFzcVdqajM3RkJtTzZtcUQzazIzekVmQmhLSi83?=
 =?utf-8?B?ZmlQQ3VzemlReHByMW1YRjlSTkNydks1R0UrbzluemJDWmJJQnpqOXE4dlhs?=
 =?utf-8?B?WGl2UC91Wll1Nkx6blh4WDFUMFV3MGNaU2tjaks4VFV3YnBOS2VvNk45dFpi?=
 =?utf-8?B?bHNnWEl3bFl2N0Rma2lveC9YVWdnUk1iS3JpYW1ZeEVleDZzelZjbmtGQjNO?=
 =?utf-8?B?YXA5eHloTmI3WDdBYW1hWklqNVJuLzFlSGppd0tpekxOeDVsMjd1b0taQWZ1?=
 =?utf-8?B?a1ZhSlVWZXZoUHJEb1BFOUVRZk5sRjNudWo3YzdmVE1uUVZnNzArTzZoWml5?=
 =?utf-8?B?YVZnQk9PY1NpUE1UN2dSQ290UnMxZHlMRERqdk0razQ0RmU5TkFQa1pzcWVQ?=
 =?utf-8?B?V2dmZDBoME1xbDZvOUNnaFlWZ0dXL21EdkVvYWxQS0FWbGtkTllHWEVuejEr?=
 =?utf-8?B?ZmZaRlRpaW8xcnJ5M2x6ZkE4WkNNSy9ZY01rb0ZUY3NhQkhmdmZYWkxtSG9q?=
 =?utf-8?B?M1l3VjlkdEZFNDRDL2c0aUIrZGlHQXFSZ3JFcjFYNUk2QUpncE1yVlhPNkU2?=
 =?utf-8?B?b2tVajZWTUFwb2ZNemVxd0YzK24vNC94VjliYVNrbUJ6cFJuUCtMY09oWlpS?=
 =?utf-8?B?RVBKUlQ5cSt4T1c5YnJmbE1FaWdUOHdpZWE1NEpydFFSVUZnT2tYR2pWMXlS?=
 =?utf-8?B?ckJWUFJGNnFnano2T0JMMHlCUkNGRzhhN3k3VEZkSEtZUjV1eWppK1BSYUNl?=
 =?utf-8?B?aWhJK1RvOGFEbkU2OFFCV0ZOZURaMHpTRnVvbmUrMHk4cHp3YUh2QkZhck5u?=
 =?utf-8?B?Y0U1bVJCUldsYTdIVTdPcUJJM0ZudnBHY093ZHFNcWI2VXdrekMrbDg3LzBE?=
 =?utf-8?B?K3ZRd1RHVWpCQ2d0eGFwQWkra1pZSTZQT0YwTmhXdktNZGZpeUhIbkMyUDdq?=
 =?utf-8?B?VlVwSVo0Ykw2M29tQk5ELzZlZGRMYlFsbEVJRzlhMFh1d3VrT0RtSnd3bStv?=
 =?utf-8?B?Uk9iR1kvdDBaZ2hiM2NMZVFJQnpyRUxUUlI1azNrZm1HUWprdHRBUUJnZWcv?=
 =?utf-8?B?UUsrS3VMRDdiOXlFaU5tcFBWd1VML1BiQWZlUnJLRFBPQzdwakN6NFJBa3Bl?=
 =?utf-8?B?Rnlnem9pSThaNmRkalBlaUNtemw3WDYvVnBmMyt2Vi8rRm5zZ0xrWU04alpp?=
 =?utf-8?B?QzVBaUdTcVBJSFdsRkVtejhMdnp0NkVzOUZ3R1hrOWVkZHA0T09mdmxPUXBv?=
 =?utf-8?B?aW5DZVVrQmdyblB3cjh1aFl3dm0ydEJTNlRqWWVreDA0b095ZE5sRHhCTC9w?=
 =?utf-8?B?cWVnWnQza2ZreFVHTHBwTVNLVUFQdHFIVzY5YVloOHRoT1NLMnBpZmRPN3Bs?=
 =?utf-8?B?dC9BMHBONmpYU0d1K1hyMG5SbjF3cFNVajVqWUdubkJCUjE0TDl6UCs2RlJs?=
 =?utf-8?B?Yjl5M1I2Y1hRTWRxWExmUGZmWXlKdS9rQ2thanZRNkV6MU4yREN3QlpzRlVp?=
 =?utf-8?B?dGR5NHpyWkNXS3FPUGxYWjRLTmJobXcvOGIycFp4WWNrMmNOTTZHSldUdUZZ?=
 =?utf-8?B?NVJzVGIzRmlGNTFrVzNaTzFmOU1PaC9rTjd6ZzFFNlBKc0U1SkhMcVh2SmdL?=
 =?utf-8?B?VUYydVlrRlVzeTEzSTdwYXB6WVFzWnEwczhpd2w0V2hyZjdxTk8xNkh2dytj?=
 =?utf-8?B?SDFlL1BDMlptVU9rdlNLZWJtajEyaUNYUTJ1WEFNWGQ0ajVHQy8vYWh4N2RX?=
 =?utf-8?B?cER5T0dQNU8zaW9uRUFRVW51SjZWSm9seGwvZEIzczJmUkh2RW9ZTGh6cW9I?=
 =?utf-8?B?VUFCSWRaeHkzYUU3S3VsalpxeDlBWTEyQzZYZEhLdzRwQ3FGWWR2WXByQUhk?=
 =?utf-8?B?M2U5UGxXT3d6R2JVU0szV21qMGY2MU5TVER4WEFwOXdNN2N4UkZjOXphZDVF?=
 =?utf-8?B?OUtoeW1ObldqdnVpT05LRXlaR0JFMkUvUDBkQkY3ekRWWVdFZUIxaWRvYmhk?=
 =?utf-8?B?djN4T1hqdDBjUFJBdHFDbnJVNTVvOTNOQWpaMURQaFp5UFpoVENUNEY3cjVI?=
 =?utf-8?Q?6LVDpBG5MyG82zd0V7vXXTbH0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff9a849-ae20-469b-b6cc-08db937954f1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 16:55:53.0134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5M7+Q/k5Vk6OmSVIj0h6WUerc+eatQ3CAk2WZp8z2PBdABayiHrSG934xLoDOClZS0opWJlTJeJ8HUofHGEiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8101
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

On 8/1/23 23:12, Nikunj A. Dadhania wrote:
> On 8/1/2023 10:00 PM, Tom Lendacky wrote:
>> On 7/22/23 06:19, Nikunj A Dadhania wrote:
>>> Drop vmpck and os_area_msg_seqno pointers so that secret page layout
>>> does not need to be exposed to the sev-guest driver after the rework.
>>> Instead, add helper APIs to access vmpck and os_area_msg_seqno when
>>> needed.
>>>
>>> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
>>> ---
>>>    drivers/virt/coco/sev-guest/sev-guest.c | 84 +++++++++++++------------
>>>    1 file changed, 43 insertions(+), 41 deletions(-)
>>>
>>> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
>>> index d4241048b397..8ad43e007d3b 100644
>>> --- a/drivers/virt/coco/sev-guest/sev-guest.c
>>> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
>>> @@ -50,8 +50,7 @@ struct snp_guest_dev {
>>>          struct snp_secrets_page_layout *layout;
>>>        struct snp_req_data input;
>>> -    u32 *os_area_msg_seqno;
>>> -    u8 *vmpck;
>>> +    unsigned int vmpck_id;
>>>    };
>>>      static u32 vmpck_id;
>>> @@ -67,12 +66,23 @@ static inline unsigned int get_ctx_authsize(struct snp_guest_dev *snp_dev)
>>>        return 0;
>>>    }
>>>    -static bool is_vmpck_empty(struct snp_guest_dev *snp_dev)
>>> +static inline u8 *snp_get_vmpck(struct snp_guest_dev *snp_dev)
>>> +{
>>> +    return snp_dev->layout->vmpck0 + snp_dev->vmpck_id * VMPCK_KEY_LEN;
>>> +}
>>> +
>>> +static inline u32 *snp_get_os_area_msg_seqno(struct snp_guest_dev *snp_dev)
>>> +{
>>> +    return &snp_dev->layout->os_area.msg_seqno_0 + snp_dev->vmpck_id;
>>> +}
>>> +
>>> +static bool snp_is_vmpck_empty(struct snp_guest_dev *snp_dev)
>>
>> I noticed this name change from is_vmpck_empty() to snp_is_vmpck_empty(). Is that in prep for moving, too? Is so, maybe call that out in the commit message.
> 
> Yes, will add to the  commit.
> 
>>
>>>    {
>>>        char zero_key[VMPCK_KEY_LEN] = {0};
>>> +    u8 *key = snp_get_vmpck(snp_dev);
>>>    -    if (snp_dev->vmpck)
>>> -        return !memcmp(snp_dev->vmpck, zero_key, VMPCK_KEY_LEN);
>>> +    if (key)
>>> +        return !memcmp(key, zero_key, VMPCK_KEY_LEN);
>>
>> I believe key can't be NULL, so this check isn't required.
> 
> Sure, will update.

Ah, although I noticed that when the various functions are moved over to 
the other file, the key return value can be NULL, so probably not worth 
changing here.

Thanks,
Tom

> 
> Regards
> Nikunj
> 

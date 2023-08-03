Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6F276DF82
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 07:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjHCFDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 01:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjHCFDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 01:03:07 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123BF1702
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 22:03:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9sFtkpyRWYdQWPZy5K+xC7JICiNylB8Fh5AamT35lhgQaAhjQ6roN6TnrZG15Zm6MXkevv0yxrWOCuz/3zuc3BWuJTlK+bSamoAKb87HzlMwn4DWw3pw4xwLCyQ0lxowWJk7ekImRGU/2UHu5TnevMfTxrwU8FTYbDXYCBa0NYjN6fs4DReaUhjxatLlEjly4aHmEY57wSRbDDy05OkfItCj83NymG6+q+0/6BTJKUW+mwRN7N5KPtsGMyV6sTvtqt46hum3xK7m/ZDxktX1SWZOIBR2MzgfgLmPHI8r6KzWYKFK/qxr8MIZUwtDaNWfEKVJc55LQSIkB6eb199ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Orute6lRI+Up8OEkAWN6awrW69lmRASadk0j2PC2820=;
 b=AGW8m3uErAhCE60+R2Ozin9qd8BnoPxwcvgNw4PRF0TEMf0bl0noAdoV1Awz8N2w99qpM5LAhcqYY8DdxRg9pAzqfSQtxqvpAI5mB26NTOsBZfBQqfSp/T/U21/QVAeQFf5F1C5e7kExROSJbjmK8QJwXHlSI3VmqJO/lvBQcRxum4Vqp3/JwPCUSgWYb69GpzTZBEc2qmUio0enjgAn3gcn2BdGegw21BLuVBMwcHPLesHGHm2/YNINPnsAi8qvyg7UIn3pK6+/lvm7BU0RWntcgA78zZlUIfAeJnQXmcbJEIYcN9wzp7IMqVklP6782oWpWZASX/KEL00bO9HFBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Orute6lRI+Up8OEkAWN6awrW69lmRASadk0j2PC2820=;
 b=IgI7dnH9LQs7ZAJ6ljLGKUm2lnC9+oRHWvODoWwVlPrYsmyKDwoST/L6HBEdz0egrbITuQ/MjRmLui4CFe8p5G935N78oJykQcOvz13pdwuFfHCZgqctNUnJgO7G6WMufWkzbr6IYl97wWZDgXEaBDanmzswx3ltL68MYiFIkzc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 DM3PR12MB9325.namprd12.prod.outlook.com (2603:10b6:0:46::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.47; Thu, 3 Aug 2023 05:03:03 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::9ade:451:96c3:7b54]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::9ade:451:96c3:7b54%3]) with mapi id 15.20.6631.045; Thu, 3 Aug 2023
 05:03:02 +0000
Message-ID: <0057973e-28fa-0dd2-421f-6af0fbe260a4@amd.com>
Date:   Thu, 3 Aug 2023 10:32:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: nikunj@amd.com
Subject: Re: [PATCH v3 05/14] virt: sev-guest: Add vmpck_id to snp_guest_dev
 struct
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     bp@alien8.de, dionnaglaze@google.com, pgonda@google.com,
        seanjc@google.com, pbonzini@redhat.com
References: <20230722111909.15166-1-nikunj@amd.com>
 <20230722111909.15166-6-nikunj@amd.com>
 <1a4e6652-2e24-955c-5332-da84cced68e4@amd.com>
 <100d7145-7307-20fc-2cc9-0c2edd08f3ef@amd.com>
 <cae0b2e9-12e6-9d2c-506e-0dc6f72988a4@amd.com>
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <cae0b2e9-12e6-9d2c-506e-0dc6f72988a4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::30) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|DM3PR12MB9325:EE_
X-MS-Office365-Filtering-Correlation-Id: 41559f84-0ea9-46cb-c7d8-08db93deea3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +27wOa39AK4v+USlG+Wt9ME6A0cAxiTWzivU2xOUd7ql6+juZKeAUPmnwIGvzuv0X7h0hxOsHC+UBEUshdswyxCIlz4dR1t1UV4KvjGyUa/FzFrXVI3j5ZQ4AfocFfHbuSVbxoDq9GRD9hd0fLcL6ZAyfPF5rQq8CsjRWgHggQGtPkK3T2qgz/9ISQxp8dKFnPAdn1qgacLaBqg3ATrDWfihPnrETVz27Z5yIn8ifJfpFr/iSE8A3+ItJ/1QQmeWvC4mH4WNqsCqO/CxI8gI1Uikj4Euf0PO9oiTkZin6LVw3JlKxk9IDQDHO02fsxg4pTFJUoD0BR8+V/C7+c/a/FvLQPxioHreXNOjy3g8qN3jMRKD2DhhUZwgxeQK5gaIFGUYfaeGOJ33U8KXEPowzoNv88UjSFEQXckVY6bvaNUENG6xWJKTjLknNnqYvY0POmTCamfyNXHBLgPY2P93ZZ5qT0hzJmak6R5eG6oZvS+XUHRMkaz0SDzpsnHBr9VjjIqtxLgVdhShU1RHTVE1ibx6tXYMg7Hv1nW5hVtsJHbtjjzKYKpG/yNlmLtwDDMTFZVH5A6FAeQzRFjiHKAq9lQs/k+x/Jq+/d0CbWiFSqhkkh1j/taomrLsFsIbhP9NNDLN60H5EQMVZA/B8Ak3Ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199021)(2616005)(53546011)(6506007)(26005)(186003)(83380400001)(316002)(3450700001)(2906002)(66946007)(4326008)(66476007)(66556008)(5660300002)(41300700001)(8676002)(8936002)(6666004)(6486002)(6512007)(478600001)(38100700002)(36756003)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmRwMHlDeXM5RUpaYTN1dmJFOXNGYWhQcy80R3FLNWZBbkh6MHg5S1UvYWlt?=
 =?utf-8?B?cllnVm9ZZW14amFrZzl1aDJUVDNERU5ZbmZWSk9hMjVOV2ptU3EyMXVFSXZm?=
 =?utf-8?B?cVFodnRwak5MUGc4dk1pNzdmRDB5SERKakYrTnM4N1RKaFVzbTJyd2xOWis5?=
 =?utf-8?B?em5LVGVQMFFLZXVoWjd2cVM3UkFGRnlBM2FtVGFWM3JqZ0YwL3luTmFkMDU1?=
 =?utf-8?B?VjlNNDNXK1EwUGZLK1I1dTMxUzBndTZCNTBmUWNvaGhkeFRsMnA0U1kvdlVm?=
 =?utf-8?B?ZXpVdldGR1FFdys4M0NZMVN4K29FQWkwR3AzSFVxazVpQmVWS2xZL3pEVHNV?=
 =?utf-8?B?T3U5TDlHNlBVTWw4clVIT0NKSUxSeEIyWm81OHlWSXU0cTUrMFhnQ2ZzU3pk?=
 =?utf-8?B?NUJIaEtRMURkd3YxZmFMdDBwRkFRdGhRSnRsemdiWFNSMlRVOXc2MU50TXMv?=
 =?utf-8?B?UGJyd1VyWm5WRnk2NDNXQzI2ajJCMGZTN0ZTM2YzNzMwQys1SmIwZVZjT3RB?=
 =?utf-8?B?MkVrYWtROFFBdDY0V0loNDJMSGxDM1EzaHJxcUpFcVp6bG9pNTYzSzNOWUhQ?=
 =?utf-8?B?VDNQZ2xQTnU3ZTdiMG9zT3FtNEk0M245UlJrMWRnbE5kblFLRmtYOGNUQm5Z?=
 =?utf-8?B?UHBxelBwNGd1bjBjNVBPdk9hZnFKZ3VJSnVYaHB0c1JoUWE3a2JkeE5pY24z?=
 =?utf-8?B?Sm94VzJtVnJlVWZEZ1dSSmlXek94SVlGUk9CL0trUWJtUmhrRDNmYzVBUjlB?=
 =?utf-8?B?YmVDQVYyaGw1c0FDUDVOMVNrZEpPaEpGaEdmd0cwVjFDTFpPQjdUdXRDY2Er?=
 =?utf-8?B?b0p5YzFDMUJLK2N6RkIwTkFnMUIxZmhtYVM1Sk9wemF4QktOdTBZUGZXNFhu?=
 =?utf-8?B?cGhVSjdSZ3lvengwUEZ3STRkL1JSaHdaV0xSMjhDTlRES3pIeUlGVXNWNitI?=
 =?utf-8?B?WDY5NmtubFBrd0ExV2Z2SzBaVVVOUGtzNWh1WGtxVmU5bzY4VUZIT2preXNC?=
 =?utf-8?B?MGl0ZUJTN1JpVis0YXlSdXQ3TlB3ZDRxNGt3RTdoUG90aHR5cEl4UjJkeVZN?=
 =?utf-8?B?d3oxWEhtNEJLN0daWG5zTGdKcEhycFd0bzBRYzBaN21ZdnBMSVdNVGxYbDY4?=
 =?utf-8?B?Q3d4ai9ad1FieTJ6QUNJUTlLN0xVRUIxQ2ZYVHBDTUNZK2RoTWFlNzZscXFM?=
 =?utf-8?B?Z1FtR3dPNW9LNnUyc0xNc3hsUmsvQ05HZUhWS21qSzJzTEFRL2tCQ0c5MEsx?=
 =?utf-8?B?RjhFMFBBNFFuQzJPNUc3dnlISmVwYXZuS1pLN1RtWHltUGdMOVFYZHVwVGU0?=
 =?utf-8?B?MzZYTzdUVjlNWFF3blp1VVREWW03V2gya1llU3ZaRHAyc1RJcmNHRGp6OHFh?=
 =?utf-8?B?L0pWTERURWJvYXI5RUxCbWw1dER5QlJWRHhsbExlWWlwZGdtUUtxaWFiT3Js?=
 =?utf-8?B?VWxaWjlIdU1NTjFJVXl3bVNUUzVkSEx0bHoyWUZycTM1MnBiQVd4bVNubUxh?=
 =?utf-8?B?REVCOFpUODNacFpYalBzdnlDVlo4VFN6N0p2KzZoK0VPbDZSMXd2UnBvMVlp?=
 =?utf-8?B?Q3Y5eDVhcjF2RmFMcGlzQ09DZ3Rwc1VuSmlSY0hHR09wSHJ1OHQ5b2xRZzBs?=
 =?utf-8?B?bjkybjc4K2F5a244WnJNTU93UjVwZTZpSjd3WUpSdWZlZUJER3ZRRjllUko4?=
 =?utf-8?B?Rlk4dVd5OGRtZFduSC90V2wweE9JaFI0YkkyTlhzSmZLZjNMdVRFK2RZQWho?=
 =?utf-8?B?bFZkQURKNFNHTVBvUVFOUUpnb0V5SU9QcEtBS0pxeVViR0txeWFoZWZmakNz?=
 =?utf-8?B?YTRxbjk2bzVURmVrSThVS2RWcEN0aHN6cE10Q0ZEWnZ4akxnamlxWEZjc1Nk?=
 =?utf-8?B?ckFyWVFaRldSYWNBV2VrQlpuRkEvbDJ6cHFsNHY5ekZVbUdDS3F3elpzS1g5?=
 =?utf-8?B?Ui9KQThRaWJJOWV6OGNtc3ZwQXQ5aUx6R3F0eUlodm5RODZMWURiTDh0TTN2?=
 =?utf-8?B?ZEZKa3hSVldYQWhFOGtUcy8wbEx1ekVmaU9sVHpXa0VzUDlOYzUzV3lXRlpE?=
 =?utf-8?B?YjBmUGZFeUdQZU5OSmpBQW82aXZyZGdIODRaaXo4WFd5MXFNV2VzRnp4ZStB?=
 =?utf-8?Q?3+xFetWOFMA0r73h3FqEoQEvA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41559f84-0ea9-46cb-c7d8-08db93deea3a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 05:03:02.8785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /OEguZF5r/O3p7IjZ96VdZTeqXIbl0vYktX2+Lo9pWRK+WqWWTjuBrRuaXA3G5zXBpx2Waazn/zcIrWm8iB5QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9325
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/2023 10:25 PM, Tom Lendacky wrote:
> On 8/1/23 23:12, Nikunj A. Dadhania wrote:
>> On 8/1/2023 10:00 PM, Tom Lendacky wrote:
>>> On 7/22/23 06:19, Nikunj A Dadhania wrote:
>>>> Drop vmpck and os_area_msg_seqno pointers so that secret page layout
>>>> does not need to be exposed to the sev-guest driver after the rework.
>>>> Instead, add helper APIs to access vmpck and os_area_msg_seqno when
>>>> needed.
>>>>
>>>> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
>>>> ---
>>>>    drivers/virt/coco/sev-guest/sev-guest.c | 84 +++++++++++++------------
>>>>    1 file changed, 43 insertions(+), 41 deletions(-)
>>>>
>>>> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
>>>> index d4241048b397..8ad43e007d3b 100644
>>>> --- a/drivers/virt/coco/sev-guest/sev-guest.c
>>>> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
>>>> @@ -50,8 +50,7 @@ struct snp_guest_dev {
>>>>          struct snp_secrets_page_layout *layout;
>>>>        struct snp_req_data input;
>>>> -    u32 *os_area_msg_seqno;
>>>> -    u8 *vmpck;
>>>> +    unsigned int vmpck_id;
>>>>    };
>>>>      static u32 vmpck_id;
>>>> @@ -67,12 +66,23 @@ static inline unsigned int get_ctx_authsize(struct snp_guest_dev *snp_dev)
>>>>        return 0;
>>>>    }
>>>>    -static bool is_vmpck_empty(struct snp_guest_dev *snp_dev)
>>>> +static inline u8 *snp_get_vmpck(struct snp_guest_dev *snp_dev)
>>>> +{
>>>> +    return snp_dev->layout->vmpck0 + snp_dev->vmpck_id * VMPCK_KEY_LEN;
>>>> +}
>>>> +
>>>> +static inline u32 *snp_get_os_area_msg_seqno(struct snp_guest_dev *snp_dev)
>>>> +{
>>>> +    return &snp_dev->layout->os_area.msg_seqno_0 + snp_dev->vmpck_id;
>>>> +}
>>>> +
>>>> +static bool snp_is_vmpck_empty(struct snp_guest_dev *snp_dev)
>>>
>>> I noticed this name change from is_vmpck_empty() to snp_is_vmpck_empty(). Is that in prep for moving, too? Is so, maybe call that out in the commit message.
>>
>> Yes, will add to the  commit.
>>
>>>
>>>>    {
>>>>        char zero_key[VMPCK_KEY_LEN] = {0};
>>>> +    u8 *key = snp_get_vmpck(snp_dev);
>>>>    -    if (snp_dev->vmpck)
>>>> -        return !memcmp(snp_dev->vmpck, zero_key, VMPCK_KEY_LEN);
>>>> +    if (key)
>>>> +        return !memcmp(key, zero_key, VMPCK_KEY_LEN);
>>>
>>> I believe key can't be NULL, so this check isn't required.
>>
>> Sure, will update.
> 
> Ah, although I noticed that when the various functions are moved over to the other file, the key return value can be NULL, so probably not worth changing here.

I have removed the check in this patch, but the check is retained in the later patch where key can be NULL.

Regards
Nikunj


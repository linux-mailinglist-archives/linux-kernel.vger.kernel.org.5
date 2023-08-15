Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D0B77CEB6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237596AbjHOPJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237839AbjHOPJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:09:13 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A301986;
        Tue, 15 Aug 2023 08:09:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/eCZqzhkaSsCI5y4Zpa/pWRe0Q86agEMGKzVeGbgFfUIX1irhisq5B5VHwf0JTC/eKoBLPwBiLJ3napUWWZJ2+rNN4g/HOC8bn0u84IvCIL11MmZ7SZ7BOnMwoDPpvML06aZOBcP+QKhsd5Vpq0Kf7LCA0Pt3gaVBH8ttBCny6mX7Za614e370USDlwN9suA2lM+JfvR7By9wQDHGp+qc+lptJca0zjr5YUEJji43uYKDOki/QyiKWmzueWMDjph3KPGSALiYkUw2cB6E8Gvfip/7FOEXm/n3F4dxR+mh+u8NRxuLJAV+yF+4mUWkEFEc7DEJLwlZXHHKbbgebGUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVN6Lh1OzCct/pmmPUfcrfHmgJKfG2veEmVL0TODDW4=;
 b=JS5nbEJXiCjUgAbhwSRWPJTRCSgW4t6kgb1Q10Zd9ofD9V1z58GxDbvuGor8e1GSwbyVRw6ZhPxpstTSLVpdqq1yN5gJgYaPkTTCe5Q5ip6IQJrJ65kXB50KGN/5qVA2Aj5gv+Tc2IXcKTyVbKUeB8Fsqw5hn6K4w9JC981QSSfRCW/aBIaAqKYRJEWdA8cPqbiY7BNR59DCaRnqnwLwFYXnSKzqh1r7Lr3NOy65i4H+7h9xBywVRLgQqIGAId5tNrpvURmLrFqOXbktvF9ckwBtw5WdG1ZozlbjQ2Qm9hnPCHk8LRyvoLnL7xPkZ2wRuPJRg+1RqvVyMAmjWx+qTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVN6Lh1OzCct/pmmPUfcrfHmgJKfG2veEmVL0TODDW4=;
 b=tyK3BeRqLg+zbQjz1q7ejZxtOs51Grpps1jxTqcb8J7a3/oBbctsKuURvgL4iNtomVj8s2WIU8vqdb/CdcB0xCWfhWadpI195g3kUOOq+jjHRs/2B/gUWCCfRaOpBFtxZKV4gtYtKQ4fF1Xd3FdmJlAamUicO1y6vI8T49slcZEt4c/ob+HNboupciCLbmHKtpgDV5529ytPYnL23N6whqS0+vBTT0zxNYgwqIa062I1cBRPci9xYialyMuXYSoTyvMss9/nYP6xX96Df4uUEAQj2NqxNumEyTRNZn9apX+kjBDrgB92yIjtrChHPEyX3a30CVW25x0dFRPgMqVPFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 15:09:07 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::87fb:3736:7ec4:b260]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::87fb:3736:7ec4:b260%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 15:09:06 +0000
Message-ID: <05348d62-586c-4b1f-40bd-5541caca0947@nvidia.com>
Date:   Tue, 15 Aug 2023 11:09:02 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH net v1] virtio_net: Introduce skb_vnet_common_hdr to avoid
 typecasting
To:     Simon Horman <horms@kernel.org>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Bodong Wang <bodong@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
References: <20230814171845.65930-1-feliu@nvidia.com>
 <ZNtYpohWyjnb883M@vergenet.net>
From:   Feng Liu <feliu@nvidia.com>
In-Reply-To: <ZNtYpohWyjnb883M@vergenet.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0167.namprd04.prod.outlook.com
 (2603:10b6:806:125::22) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf9321e-a5c2-4315-6898-08db9da191ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GkbQe6p1EbjUwZGn98spfUvHHj3Q3MnrLDHQWrEp3/I3YiTKHGs29g2mPO/pLYTSgMRFrppzJs3IYFq4/MPhvQcQZQPQaWY2HwvHbYcqyEf0csZjC7nFhuh9vsAT0qM+uRCdOLGtMxs4i5XlofP3/kRyIc/AQFHQVPlenbTPMUCVccal5cNV+sclXmKSLlkXC8064oXRR1rcHBJGv4FQlFdWgqg9gp6GzA2J/6yUl8++TGKMOyoEDBdEbTR2aRuuKT//Czi9dHEJTcmTddco0kgSJse9K5EZRpz2gabNoOPxDCqcZGuQdHam3obgPXo0dMzDl76xJ8GdxpqxVDqaowVWoXXHAoNaYMInAjqXMmPq6YU/ExYsapR1s8IavTpp7mytSk1QEVhHWi6GVFKwCfljR3qzlC9KS7tztEWtBnefQik0XU/v0uT4K4LvUA62PB0GNHKqligY1cyUuD+1OTjzEMUEyTGje76rRzRmkh0Sb52mu0mfqGjlcv91+W887gxHoIYi006zo5vXMLM5bDP2/CZQ/jKHPm4XTZG7rkQyk+O2qF2K6b4xlJsVTLR6MSMitdoWdMDd/13FwQf4LbkZhHZ6D5HgLdZOlWT786EepTNIcFmgdBOW9wwB9sMLItjhWvfP6JxO1MJhlFdd5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199024)(1800799009)(186009)(66899024)(6512007)(26005)(66556008)(2616005)(31686004)(66476007)(66946007)(4326008)(316002)(54906003)(41300700001)(8936002)(83380400001)(6916009)(8676002)(86362001)(31696002)(2906002)(36756003)(5660300002)(6486002)(7416002)(6666004)(38100700002)(478600001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHhjaEh3Yk8wTngxMklLNm92V3hVamN6RTBYcGhIci9YVXp1eEhpa1ZuODNI?=
 =?utf-8?B?b1g3WXRQaVBGczNmaGdKQS80S3JzT2ZJQ1hoaVE0bmxkTy8wOGhRUG44c3hn?=
 =?utf-8?B?c1pmQVVIejYvZllucC9TWmlYbmVQRkxzdTd4bzJXblpBQ1A3eStqMjBMWE5M?=
 =?utf-8?B?ZHJLSVN6VlJJNXV4ODlpbzJmcCt3Y2Z2Vi80Z2lsRmFOWEZKbWxiV3pHcFdZ?=
 =?utf-8?B?dHZCOS9SWmtKYUxnRENoMTR3L00vSmRlMzlNeU05ajNhZlliY3ZUeDZhUng1?=
 =?utf-8?B?RE5vUGtRU24zVDRrRVpTWEZFUHZpVnIvWHZLUWJVQW5CaldxUmpic0FEUTkx?=
 =?utf-8?B?Sit2SUR6OE4vVlVVOTFQdkRCNzVlMkRrVmdnVTdTQTExalFMcGJHM2dhYUIr?=
 =?utf-8?B?dVpsRFJhcU5DWEx1T296ZnFnN1pGOG1MQVJSN2pIUllrVjZvRERTbWRPWWN1?=
 =?utf-8?B?QnJqcSs4bWMzUVh6QzZxbkp0a3E4cExHZWhuYnlUc2VINFdqTjFiOFhvOWZu?=
 =?utf-8?B?d1Q1bk1yajVoT3lWN0p4NTR1cFh1emtCdS94b0hraUQ5eVZXOGZ6bldMdXV0?=
 =?utf-8?B?c2VPNndacGFWSGlNc05oc1B4K0VwL3ZqQkxMZnE4enJHMEpHOVhoN1F4Rk9G?=
 =?utf-8?B?SGw5OUo5aHBOWHkxK1k0R0JXbWlGM21tbVh3cCtxd3pCaCtWUU9yT3NqSjRP?=
 =?utf-8?B?NDNQNUUvMjF3WTU2R2dHK2JYSTh6QmJBLytqb2NmUTZ5S2lJbmVocTJHNm9V?=
 =?utf-8?B?aVJ1L0RocENMNHpLbi83NmdMVHdlNjNLdnZDZHNUMkxKVnlYMjFJaElyTE9a?=
 =?utf-8?B?dUJFeFFNVFRQcnRaM1k1clR3WjJYeWZzTkl1bFo0Y0pHQVVXTXBvOTl3c3Zn?=
 =?utf-8?B?TzlvY2taK1lsS2pRa05vTHhnNHhxemo4cjg3alNJbUtCSUxPU0dKd0JXSGZ5?=
 =?utf-8?B?dWEzdjZhVWY0ZTBGYzNBWnNUbFRBOE1RcUt4bDlSemNMdFlpb0wzQU9Xem5Y?=
 =?utf-8?B?ZDZGYVBBWkt6T3g4YXFCakt3b1hYOUF3YWltOU1zQmVUNEMxL1lTeHdxamZn?=
 =?utf-8?B?NzhLOW5FT1lpOE5uSFFVN3VGZXJzSEhKejJDZ2JHTzNISkNnbjBNdG5LVE0v?=
 =?utf-8?B?WTZQZDl2Vnp3RGs2WUR5RUV3WExRYjNkM2hCTHdmRDY2a29XV013ODYrdnlM?=
 =?utf-8?B?SzFLYW5yWXU1ZHZ3bG9NUTBINUh6c1cwSDkyTFRHU2V1TVMrWkhxZzRYV3lj?=
 =?utf-8?B?RWxlOUJFOVVPaWQybGFCU0pSSmpxdHc0SmVuWXpwOWkvdHNEcGtEeWdjamxo?=
 =?utf-8?B?T2sxS1FmZUppNXFZOFY5WUZqNDA5OStqKzVlcTg1Z3F3U3FnNEl5cnkvNjFh?=
 =?utf-8?B?RGlWTURKN3E2bUdPcHVITGlaMzdjbjVZanlabFFyL2tXTlAyajlMTUdFcElQ?=
 =?utf-8?B?bTBoNlFNMjluRkJ6TGw0MjBMeVExSms3T2FiVldKY3piNzVNMHVVcGIzeDdL?=
 =?utf-8?B?bG1iS1I5VHlUUVNUR0QrWlM2anZNZytrSlYram0xQnFpVGNPTDRHcCt2alBu?=
 =?utf-8?B?K0Q0NGdjM1oyRHBQeWVTOU5ncDAvbFJzd0VlaGdtUEFwTW9JYVo1aXV4OEg3?=
 =?utf-8?B?M0l1S3dwZld6WXN1d3RaQmxoUDM1Ymc1dDg5OW52QWJRSDVXS0hOa0F0ZllR?=
 =?utf-8?B?MVU2YThJbjczNndkdFVidGxUTDAxc1ZnWThjN29BN1RmSjJkRGRwNjllc3hv?=
 =?utf-8?B?bWtlbEZGZHFzRHJNVHZuK0o0c0hmYkFDeGk0MTZPSldmZkZjbmk0bjBCbGxp?=
 =?utf-8?B?eFU3UUFoemJTUS9FbXdjTzFXMWFoVmVsQjUvbTNFZTJpUkR5d0xRSEZjNXdQ?=
 =?utf-8?B?cmJlNkFTTDZNVkF3NUlYM1BySFN1dnluSURpakVtZW8xWjM1ditOSTk1MkJT?=
 =?utf-8?B?dTVZY1hIcjJTSzFCbEpOeElSNFMxS1E4VEo3RnV4ZSt6SzJOWDlvWGNrSzhm?=
 =?utf-8?B?TGxadFZLWnVNdExONnNmOW4xQlRQK2V5bHBQSnpHVllPYkxIN3VGNjI3bzFZ?=
 =?utf-8?B?M0hscG93cTM3MGZnT2RiL0xFQTJiVFVmZHRubDdqdlF3ZmQwNXpCY2NrN0hO?=
 =?utf-8?Q?CLr4Jpb8CVb2CsdGKZjsDr/pE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf9321e-a5c2-4315-6898-08db9da191ee
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 15:09:06.8226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5q8VMglgOk/Nuy/NiWTgGSFQGpEBhkXRSEkN0dhjdLEYEfXH8soXnNvRu8Q4DvsdA/uo4ZanilHc1ksww7ZbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-08-15 a.m.6:51, Simon Horman wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, Aug 14, 2023 at 01:18:45PM -0400, Feng Liu wrote:
> 
> + "David S. Miller" <davem@davemloft.net>
>    Eric Dumazet <edumazet@google.com>
>    Jakub Kicinski <kuba@kernel.org>
>    Paolo Abeni <pabeni@redhat.com>
> 
Thanks for adding David S. Miller.

>> The virtio_net driver currently deals with different versions and types
>> of virtio net headers, such as virtio_net_hdr_mrg_rxbuf,
>> virtio_net_hdr_v1_hash, etc. Due to these variations, the code relies
>> on multiple type casts to convert memory between different structures,
>> potentially leading to bugs when there are changes in these structures.
>>
>> Introduces the "struct skb_vnet_common_hdr" as a unifying header
>> structure using a union. With this approach, various virtio net header
>> structures can be converted by accessing different members of this
>> structure, thus eliminating the need for type casting and reducing the
>> risk of potential bugs.
>>
>> For example following code:
>> static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>                struct receive_queue *rq,
>>                struct page *page, unsigned int offset,
>>                unsigned int len, unsigned int truesize,
>>                unsigned int headroom)
>> {
>> [...]
>>        struct virtio_net_hdr_mrg_rxbuf *hdr;
>> [...]
>>        hdr_len = vi->hdr_len;
>> [...]
>> ok:
>>        hdr = skb_vnet_hdr(skb);
>>        memcpy(hdr, hdr_p, hdr_len);
>> [...]
>> }
>>
>> When VIRTIO_NET_F_HASH_REPORT feature is enabled, hdr_len = 20
>> But the sizeof(*hdr) is 12,
>> memcpy(hdr, hdr_p, hdr_len); will copy 20 bytes to the hdr,
>> which make a potential risk of bug. And this risk can be avoided by
>> introducing struct virtio_net_hdr_mrg_rxbuf.
>>
>> Signed-off-by: Feng Liu <feliu@nvidia.com>
>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> 
> I'm unsure if this is 'net' material.
> 

It is about the modification of the virtio_net driver. I think it should 
be regarded as `net` material.

>> ---
>>   drivers/net/virtio_net.c        | 29 ++++++++++++++++-------------
>>   include/uapi/linux/virtio_net.h |  7 +++++++
>>   2 files changed, 23 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 1270c8d23463..6ce0fbcabda9 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -344,9 +344,10 @@ static int rxq2vq(int rxq)
>>        return rxq * 2;
>>   }
>>
>> -static inline struct virtio_net_hdr_mrg_rxbuf *skb_vnet_hdr(struct sk_buff *skb)
>> +static inline struct virtio_net_common_hdr *
>> +skb_vnet_common_hdr(struct sk_buff *skb)
>>   {
>> -     return (struct virtio_net_hdr_mrg_rxbuf *)skb->cb;
>> +     return (struct virtio_net_common_hdr *)skb->cb;
>>   }
>>
>>   /*
>> @@ -469,7 +470,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>                                   unsigned int headroom)
>>   {
>>        struct sk_buff *skb;
>> -     struct virtio_net_hdr_mrg_rxbuf *hdr;
>> +     struct virtio_net_common_hdr *hdr;
>>        unsigned int copy, hdr_len, hdr_padded_len;
>>        struct page *page_to_free = NULL;
>>        int tailroom, shinfo_size;
>> @@ -554,7 +555,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
>>                give_pages(rq, page);
>>
>>   ok:
>> -     hdr = skb_vnet_hdr(skb);
>> +     hdr = skb_vnet_common_hdr(skb);
>>        memcpy(hdr, hdr_p, hdr_len);
>>        if (page_to_free)
>>                put_page(page_to_free);
>> @@ -966,7 +967,7 @@ static struct sk_buff *receive_small_build_skb(struct virtnet_info *vi,
>>                return NULL;
>>
>>        buf += header_offset;
>> -     memcpy(skb_vnet_hdr(skb), buf, vi->hdr_len);
>> +     memcpy(skb_vnet_common_hdr(skb), buf, vi->hdr_len);
>>
>>        return skb;
>>   }
>> @@ -1577,7 +1578,8 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>>   {
>>        struct net_device *dev = vi->dev;
>>        struct sk_buff *skb;
>> -     struct virtio_net_hdr_mrg_rxbuf *hdr;
>> +     struct virtio_net_common_hdr *common_hdr;
>> +     struct virtio_net_hdr_mrg_rxbuf *mrg_hdr;
>>
>>        if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
>>                pr_debug("%s: short packet %i\n", dev->name, len);
>> @@ -1597,18 +1599,19 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>>        if (unlikely(!skb))
>>                return;
>>
>> -     hdr = skb_vnet_hdr(skb);
>> +     common_hdr = skb_vnet_common_hdr(skb);
>>        if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
>> -             virtio_skb_set_hash((const struct virtio_net_hdr_v1_hash *)hdr, skb);
>> +             virtio_skb_set_hash(&common_hdr->hash_v1_hdr, skb);
>>
>> -     if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
>> +     mrg_hdr = &common_hdr->mrg_hdr;
>> +     if (mrg_hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
>>                skb->ip_summed = CHECKSUM_UNNECESSARY;
>>
>> -     if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
>> +     if (virtio_net_hdr_to_skb(skb, &mrg_hdr->hdr,
>>                                  virtio_is_little_endian(vi->vdev))) {
>>                net_warn_ratelimited("%s: bad gso: type: %u, size: %u\n",
>> -                                  dev->name, hdr->hdr.gso_type,
>> -                                  hdr->hdr.gso_size);
>> +                                  dev->name, mrg_hdr->hdr.gso_type,
>> +                                  mrg_hdr->hdr.gso_size);
>>                goto frame_err;
>>        }
>>
>> @@ -2105,7 +2108,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
>>        if (can_push)
>>                hdr = (struct virtio_net_hdr_mrg_rxbuf *)(skb->data - hdr_len);
>>        else
>> -             hdr = skb_vnet_hdr(skb);
>> +             hdr = &skb_vnet_common_hdr(skb)->mrg_hdr;
>>
>>        if (virtio_net_hdr_from_skb(skb, &hdr->hdr,
>>                                    virtio_is_little_endian(vi->vdev), false,
>> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
>> index 12c1c9699935..db40f93ae8b3 100644
>> --- a/include/uapi/linux/virtio_net.h
>> +++ b/include/uapi/linux/virtio_net.h
>> @@ -201,6 +201,13 @@ struct virtio_net_hdr_mrg_rxbuf {
>>        struct virtio_net_hdr hdr;
>>        __virtio16 num_buffers; /* Number of merged rx buffers */
>>   };
>> +
>> +struct virtio_net_common_hdr {
>> +     union {
>> +             struct virtio_net_hdr_mrg_rxbuf mrg_hdr;
>> +             struct virtio_net_hdr_v1_hash hash_v1_hdr;
>> +     };
>> +};
> 
> Does this belong in the UAPI?
> I would have assumed it's a Kernel implementation detail.
> 
The existing codes, virtio_net.h is in uapi/linux/, I added the new 
structure and followed existing code. My modification is related to 
Kernel implementation detail now.

>>   #endif /* ...VIRTIO_NET_NO_LEGACY */
>>
>>   /*
>> --
>> 2.37.1 (Apple Git-137.1)
>>
>>

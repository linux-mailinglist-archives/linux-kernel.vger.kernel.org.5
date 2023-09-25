Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEAA7ADDB4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 19:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjIYRQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 13:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjIYRQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:16:49 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2119.outbound.protection.outlook.com [40.107.223.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F104610D;
        Mon, 25 Sep 2023 10:16:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwkRlg5AItGAWHlIkhgfwB1yOpz9Uy+wnNeAtD4Km3zieqEfia4EcJomkbRIwyjqAmUU+5XPAenBDPipbeVYK5HQHR6hBLqWTQ8r7vQnzFkowvJomftMyJ6A2Gwj41gKSePRx0D0V+FURih/idxt+QfUU+3LmwgDYAkhqwgRw3omgW+VK/DC/35AUAZKWkhg8iQSvz/Fp5cfGE+xMT4CHjtKdE7GDZM9NGCyjrOLGxz/qiHqP1WLmlpe2UXbSSAPN417Sfhe3OfWEUjIHjSW0AySKBDWk3KRoV5dh5fSxnNLjkpsZDjk4NzH5f8nuq2dOcYruCxpfN/3X+YPPVQ7rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUK63M/m8rXjDhw9fUK7Eu4YyUjH4zQ9jUkaH/ratsk=;
 b=k7as1uzuiJ62akuLWhZVi7+yP/bwUaiDf+1UxqpwWgyxr2Ao2O/43j2EoNF/frot/AqoEK6W2LpPM1WYWULPNRCnTZFVffVHdVrolHLAzKOATEhoZ5aMl08F8RRX7Xv8t6BZuax/ip88AWyJoBSI0YZz2QzKIg60BFd/H9evbnlZn9uGw3GZ5nSMghN69WOMAGd9Pt+bsoEA9TgBpSlGjpLFozJtddl72xbX2Gz8jIO8psN7OjH+psqtby+3QGnFX24hAe7zLH0qkJzwOQysiCSSNOiOeU655ARNNv3y3ftGVX8HhRbWbFCBYX6RjLH61T8nw58Ey8+QqPMuTbQMug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUK63M/m8rXjDhw9fUK7Eu4YyUjH4zQ9jUkaH/ratsk=;
 b=ilU1Exmhj80xupPtn/Zlcpo9AnBUxPExcIuBTKLDusEq/VOr4MIkNRT4en3g/ONjVQzn8lCCqbc9z9ULdBb1BGTFNAbNNw/LeWeVkWjukkKg6kLdW2oC6+YH+/pc14EQs7CUTvqaXjYmcVCyR6CZ6y1YakRuq7I0KC4Uk22u8Ls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN4PR01MB7485.prod.exchangelabs.com (2603:10b6:806:201::19) by
 MW6PR01MB8320.prod.exchangelabs.com (2603:10b6:303:23b::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.20; Mon, 25 Sep 2023 17:16:40 +0000
Received: from SN4PR01MB7485.prod.exchangelabs.com
 ([fe80::91a0:8411:d0db:cc67]) by SN4PR01MB7485.prod.exchangelabs.com
 ([fe80::91a0:8411:d0db:cc67%6]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 17:16:39 +0000
Message-ID: <90fc0e8d-f378-4d6f-5f52-c14583200a2e@os.amperecomputing.com>
Date:   Mon, 25 Sep 2023 10:16:32 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] mm: mempolicy: keep VMA walk if both MPOL_MF_STRICT and
 MPOL_MF_MOVE are specified
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     hughd@google.com, surenb@google.com, willy@infradead.org,
        mhocko@suse.com, vbabka@suse.cz, osalvador@suse.de,
        aquini@redhat.com, kirill@shutemov.name, rientjes@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20230920223242.3425775-1-yang@os.amperecomputing.com>
 <20230925084840.af05fefd19a101c71308a8cf@linux-foundation.org>
From:   Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20230925084840.af05fefd19a101c71308a8cf@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0036.namprd18.prod.outlook.com
 (2603:10b6:610:55::16) To SN4PR01MB7485.prod.exchangelabs.com
 (2603:10b6:806:201::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR01MB7485:EE_|MW6PR01MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f65b33-7bb7-478e-f8a7-08dbbdeb2e68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UJSVHVvhTptD4K3rboeX7wXzYwg1kdRm4X0MexbMuT3SSBLu2Iwsr2kLEfE9Vr3dpc3aa5Rh/2s7mwyBdDwiR9Fux/7yaywfMbIr+Jn1raWtatvblSOfoIsQihZqq4HuqJ93vwTr6vkGCXvRlpinHi11o8HIUHnBBv7Y24b/ZVfjX4cxqz1VyCbb66H/d2grig9zyZR3pIqzk0gNppviB/451GK+GMzBuJJY4PSlSTAsd1CqAxD2fvUe450PWWSCYnwyIC7L9ZWQe9+/uO3kbsXloM48+Hr8PAPwTTXpmLh7cIgRBHUGGS0iDVaVUkP+MX+4YgCXPWfW1D49Pe92VWrqfJG8m/vbZbWm+qgHwxL70F7Zh4AzZo0uGxaHzVdGhsihJR5oGlM3O2PxesQsP2Lv1kYyLrxAi6bbXQqxoj5yY/Kw8blQw+jnEF9GiZCxBQw7FqDgfu1xq9pts27iamOMhXweHVDzdRZZpE/igjhO/YfSwhkXv46WMf9nY60cjn00nHIMfw6TQjvpXJTM95UgftglG3dJsmzS3zzKuCK860TB3tQbSQ1hgYP9sZzEQrlsKaRoT11C5bD0D/XCqiiyRE7Lj5qbU5ug7hemjyif2ccVDxZgirX+tncScQi5wrMYpFEDOP5nwA7hm9Db8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR01MB7485.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39850400004)(346002)(396003)(366004)(230922051799003)(186009)(451199024)(1800799009)(2616005)(38350700002)(316002)(6916009)(41300700001)(38100700002)(66476007)(53546011)(6486002)(52116002)(66946007)(66556008)(478600001)(6666004)(6506007)(26005)(7416002)(6512007)(2906002)(5660300002)(86362001)(8676002)(31686004)(31696002)(4326008)(8936002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWpSTTBnZ2VhZEFRZ0JRQkIvRkw4RFBCd2hKVEFVNVdFYndIWnJoV1l4M2VS?=
 =?utf-8?B?UC9VcWVwQlZkcGpQcUpwV2lUSXJaWCtDMHhkVjdrb1FUL2hNQjdNRXE3N0x6?=
 =?utf-8?B?VU0vU093cTN2RXRwL0VnMngyblZMV2ltYzUvQlpJRHVGUUpyZkFwb29qbDhZ?=
 =?utf-8?B?TVVjNms2QWpBQThJMWpMbVlja0thOGJmcitGN2p2djgwSWxyM1g2RVhDdVBR?=
 =?utf-8?B?dEpuR3dkZ09ZZm84cUgycFRGb2NVTnN6OFN0QWIxa2EvNHd2TXVmR3lseWUw?=
 =?utf-8?B?T2ZlZU9GK0I5aVJrQmxOYmxBT09nRGlYVCtLTHZYUjdUU1FyMHFBellQeVF0?=
 =?utf-8?B?OFhDSG16YUd2NjZGSTdENUtYak1DL09McjhKSjUzSUt5L05WMlB5UzIyQWNL?=
 =?utf-8?B?NGRmRmw3cTgzQTk1eXlPYzBPNDEweUdhemRiOVNsekVzOVRFZmVaU2lUd1JT?=
 =?utf-8?B?QXlLck90eWFlSjBwU1UwRDhSazgxYWwveDlRNGtvYWdhbjVJU2kzeFc2Zk1h?=
 =?utf-8?B?ZmNkcG9kcjAxY2ZkbGFkcWpQT1E5bnZ0VFVoYlhtMmNnaUdSSXp2S05JbXJN?=
 =?utf-8?B?enFjOHo0K2lVYXlqMkk3V2ErTjl0VjZmTlNwNkZsWDRic1NjNDJxR3hBS25H?=
 =?utf-8?B?dmdqNDYrS2p0UHJrK281YWVBZTNTSzZ1Ym5BTC93dk8zamtZbHcvWGExQldU?=
 =?utf-8?B?U3NsNWFnMEtHbzZwNzZ6WVl5Mm1mQlZ3MCs3N3NiNzA2NVpqUE5FOUVlaVBV?=
 =?utf-8?B?TUxUa3dLL0hUaEhjb1FZUVQ5ajBURENyeW9ZQkNNZ0FDY2p6L1hlMEFBUHlU?=
 =?utf-8?B?N0dTYXdzVFlnUktUUEZXTU1zZml0RStNV2F1T3htSkgxQkwveFl2L3lTVlJ6?=
 =?utf-8?B?cUJuSDA2NUlndlBIdHpxdGVjcnpiTUF1OWpvSGxCUE9MdTVaTkZIbWg3OURh?=
 =?utf-8?B?WEV0YzNJSWN2S29sVHNFYitCN3ErUG9EbDlhS2RKWlJCT1VLb1ZQbmxJYUN3?=
 =?utf-8?B?Y1JLdnZGSWdTeWJmbG8rNnZ3c29FeDk1SXR4b1cxNzFPcUpCVy96eE91NXYx?=
 =?utf-8?B?aGpJZXkxYVRucUF1MUxJTkJWR1VEdlBRMlFmVjBoOFQ1d0tzZzcyZDdXME15?=
 =?utf-8?B?Q1BVYmFycHczcWM0Vy9BdVZZZ1ByVjBjZ1NXWDlqaEpjSGFPQjB2cUVnRlls?=
 =?utf-8?B?elUzQmh1NngzYkVEQTY4MElSWndaajhjUC9BMVp3MDJ6YStHNjRiYmdDaCtR?=
 =?utf-8?B?bGtIRWNvRkZKWXNPQ2xYK0NUWGNGaVpITjNkc3FwRkszc3Vid1puNWJnRDdy?=
 =?utf-8?B?SE1qWW1scjB5TDBWQ0ZzbUR5eG53Znkva2s3WWtCZkVnMm56ZTYyTGl6NGYv?=
 =?utf-8?B?OWxnWFVlNXdMK3NiSzl2Sm5JWGw5MzB6c3JLNkZHTG1iTWtGMDVRVFBJRmpr?=
 =?utf-8?B?Sk4vNzBTRC9JeDIyajJJVml2cCtiaXJoM1l3dmNvM1hOTWxVTFRGb3NFNDdX?=
 =?utf-8?B?V2VvaXlJaitEbW15TnNpdjlHYXI5em9qSGpiL3pMRzlyZytUdm5wcGtyTW90?=
 =?utf-8?B?TVM2YzVHUlU0eXJCZ2doUUtNOXVseGZTV2VvWjJEMElWYWdkU2c3OGJqUVBE?=
 =?utf-8?B?emJhSk4rS2g2aklBRVZPZ3BydDFUQjY2dGVjakVjWVJCZmYxQml0bHZqempX?=
 =?utf-8?B?UnJKamRzdXJUQ2NpaFpJRUEvT3J2OEJaK1VTVFNJVVlYL3QyOGhET09HYko0?=
 =?utf-8?B?M0xOdC9EK2dBTUMyUys4WnlGaVM5WG5KaWxNYVV1WnB2TmxsdElDMzJYY0dt?=
 =?utf-8?B?by9nQmZnQ3VzUVdKNXpVeTdKc3FsVkt6d3hCNk0xVVNIRnQ3NmdXK0w0MUVP?=
 =?utf-8?B?ejBCTlJaZDFrWVV1Y01ESEF6TU4zYzN5bUlmTHhabmhJNjJ5OVBKVHpLdEpQ?=
 =?utf-8?B?VklFMFZQVlc5Yy80bS9hS25MMm5zam5CUzlKR0FyNmtIelJQYnFKQTBSS0lB?=
 =?utf-8?B?VmdKVjhXWHNBNUNPbzExK3VRQTdUbEp0cEVjZ1pYL2hnbGlTVDhQb1VJTElH?=
 =?utf-8?B?NlBIeHU2UURKU3RnSTRmV1VTbDhTQ1J0RUhQMW9tM1hLYS9HSHZ6T1BGREow?=
 =?utf-8?B?SVFjOFlJUWgvcXRoNk1BWG1jU0NwclRwRFIrOFBCcmxPeEZFeTkvV0FyOWk3?=
 =?utf-8?Q?TJaYd4/F66arwGmqa83soWU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f65b33-7bb7-478e-f8a7-08dbbdeb2e68
X-MS-Exchange-CrossTenant-AuthSource: SN4PR01MB7485.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 17:16:39.8277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYJuIZPOGxHNx8bfFfzZ+ue0KOk27bR3UfBg2cPYLeL6QT2/I0rrjpYstOv1b3IwGdzJZjgmOUmxfaf1n9ACuxtMDTixkSJrj4z97NSKgrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8320
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/25/23 8:48 AM, Andrew Morton wrote:
> On Wed, 20 Sep 2023 15:32:42 -0700 Yang Shi <yang@os.amperecomputing.com> wrote:
>
>> When calling mbind() with MPOL_MF_{MOVE|MOVEALL} | MPOL_MF_STRICT,
>> kernel should attempt to migrate all existing pages, and return -EIO if
>> there is misplaced or unmovable page.  Then commit 6f4576e3687b
>> ("mempolicy: apply page table walker on queue_pages_range()") messed up
>> the return value and didn't break VMA scan early ianymore when MPOL_MF_STRICT
>> alone.  The return value problem was fixed by commit a7f40cfe3b7a
>> ("mm: mempolicy: make mbind() return -EIO when MPOL_MF_STRICT is specified"),
>> but it broke the VMA walk early if unmovable page is met, it may cause some
>> pages are not migrated as expected.
> So I'm thinking that a7f40cfe3b7a is the suitable Fixes: target?

Yes, thanks. My follow-up email also added this.

>
>> The code should conceptually do:
>>
>>   if (MPOL_MF_MOVE|MOVEALL)
>>       scan all vmas
>>       try to migrate the existing pages
>>       return success
>>   else if (MPOL_MF_MOVE* | MPOL_MF_STRICT)
>>       scan all vmas
>>       try to migrate the existing pages
>>       return -EIO if unmovable or migration failed
>>   else /* MPOL_MF_STRICT alone */
>>       break early if meets unmovable and don't call mbind_range() at all
>>   else /* none of those flags */
>>       check the ranges in test_walk, EFAULT without mbind_range() if discontig.
>>
>> Fixed the behavior.
>>


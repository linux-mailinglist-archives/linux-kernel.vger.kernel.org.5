Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577287BC3EA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 03:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbjJGBv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 21:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbjJGBv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 21:51:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B33FB6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 18:51:55 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 396LNtS4001710;
        Sat, 7 Oct 2023 01:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Och4IsZc16HLlU5u5N8RuVxlt+wCDuDiY1Cr2MN/iJo=;
 b=tNcFEM+Gqp9S70u1V5AxRmo7xabRTTp/+vZhpDMv4kl/MyzoZ4aM+mv9vKI9L2xVDOYx
 xTm9tB79q9niNC6hdXoL8PN6trarY5mOiej5o28DNBfH/zb1VvHt3kcG2y4AiWJjZ3Ni
 5DGFZugkACOQruwYjnCdgPeyDcYhKRm0XclYwmxOjWnDkS0K0RTrbyJP8+XaCRvyNp+n
 BU53UCzOvMyso7HAmQXEz1qAsw+OxPB8Tt/j9+huP0if9/oZ6AcZ0RkmqfHpUsoGh9ye
 VNYCvLbUdYr0bQ1ytMnwXlbTK9ODX7sGJCpogEEb4lVtEgxdVYzFR487w5Z8dQbBrN16 3g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teaf4d2x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Oct 2023 01:51:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3971X4WM004632;
        Sat, 7 Oct 2023 01:51:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws2g969-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Oct 2023 01:51:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUzr4KmqvrjT5i2GAwI6gPQ6w0Fe0QaKT+7ZKSYcabSdCoUn5ALWn3YYpiF56y7k3Eg7qjsXVch+90HMpM2h7ubpoH6rXRfO/6gBcPRWxlr3gc53i/QKAt5pmIQUucgVdvBN4bTn4Oons/db0b7fS2KkLcxJ1No3n91T1dY+aosOUwu1wzusiXrn/03pJAXxmimMk4wEKnHTf8mm21xNaD0AHjFMi7naLk2c9dP6livMjNYUi9MyttJF3QH/YJOl49FEDD4JMrsDJFGtfF4qDOUCzRvsduM62ZEkOZBlWHBI8W98ceRO4dQk0uWMj3th2SKwJyySRTs42HzvuZlVyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Och4IsZc16HLlU5u5N8RuVxlt+wCDuDiY1Cr2MN/iJo=;
 b=J3CMZq005aTGt02QlmhOEFXNxOjbRE6Pe0kK0MCA1CAR07SiNZyD64VYbSzCTNqVWf7VqCfbTvvGF+WTLtlhp8WS2awqPiWCGx6tEm0Hq/SMQHHLSo6DqPdpMZPUuLrfsAERLe4dcU4PmDS9/38q2VRwV3UKi5akRIaanzLUJCJL8x6g9VfvIXAtdpX9/12AhOfk/KzWz6gt5tK0tAFtotHiptnOeEbshiHFLnXaZLVse6iE2oE8HYQW/rMFylMn2ScfA6ZnK6q5pixO46HhIhPIbXNwps6ngSQ/u9T+T3+1Z/NfVZ83IA/TFLaKkBUgQAHOJEOIfO6OZufROSISeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Och4IsZc16HLlU5u5N8RuVxlt+wCDuDiY1Cr2MN/iJo=;
 b=uA08ETmihRuERTgI8gheXbFDYr4/RGwF3eK9LEvU+UvmmM6Sn2bQy0MDxMVSKuFeVieyptqDecpZWuUgsuA4d/dzHH6FzoQBiFL6YGUbdUOBUsFd40FxB/ARvIcuyS7nNk+F/2hLhw9GxMFwpiD9+gTjsyYRrtGPNgcUpuOwpxU=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BL3PR10MB6259.namprd10.prod.outlook.com (2603:10b6:208:38e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Sat, 7 Oct
 2023 01:51:12 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::31aa:ee40:5f7d:2c7f]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::31aa:ee40:5f7d:2c7f%6]) with mapi id 15.20.6813.027; Sat, 7 Oct 2023
 01:51:12 +0000
Message-ID: <ffc9ace3-377e-27ef-2f48-ddeef2a27529@oracle.com>
Date:   Fri, 6 Oct 2023 18:51:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v6 2/8] hugetlb: restructure pool allocations
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Barry Song <21cnbao@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Joao Martins <joao.m.martins@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org
References: <20230925234837.86786-3-mike.kravetz@oracle.com>
 <ddc10c41-515f-48c9-966d-4ae7756d208c@kernel.org>
 <20230929205731.GA10357@monkey>
 <ba5a528d-7e85-77a2-5096-5a143a3b1606@linaro.org>
 <20231006030836.GC86415@monkey>
 <5d14b681-a2c9-4210-a0c1-bf38708b7998@linaro.org>
From:   Jane Chu <jane.chu@oracle.com>
In-Reply-To: <5d14b681-a2c9-4210-a0c1-bf38708b7998@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0346.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::21) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|BL3PR10MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 43eaccf6-3d81-4d18-f78f-08dbc6d7e1cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qqQelkrRrQz9GbT5Bn6ELP4+ry5Bhbi70LuMQ1m5/8HVNGmEsV/W10qnvCAGi7PwaueEkzhzDjki3pXspPJ286/TOQ0EkA7jWai29/1n4Af3z+ThgQoXGtvoXsK4W7nbum4Srp/DzkDTjj8WCRkiZtHqOYYA+Ma0CYTKNkOLSnypkMXXfeyFOfUisCzTAovsB5uZxkJ81A0L50yt3mG2JBlI6OSOOOoBO8VHMBV9eEn1d1ELtVjOftTFHZAA3Ox3sykZprt785LmUZHD1Sr8ZiujGrGaNTHd7jldqUtmqnE+WNCwkNyyeVf0846bNOckdMRftMX5jj6VU8/4Zfob14uSqapBMhQris+3ZnBz47GHqD0/8YW7esidUIRYUob37qVF3c7rztRXBH9guTTgzg0Zrn90XjJhDqQvWVw5JY9W1POFVA9hOuVHU2IWZv6hQ/JidXE1sSRcNcuAR/IgvAANdlUKEifsotA5Mpfha4bGR8JoFE7MQ+H7lNnkvTA4TA4yUIzSMFM8gF1oviNIYkL+JbXmJGTA5NLVxFc3ZVDVLVeubklBwjCy0BCDzwwXqDymQpRVnO0K/5g8mvqAPu+fxP22vaxHVDyBZUAUYFuhltbUM0UVAn2MYPcgrNWUXW78Pt3xlwop9DQTsuF6OQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(346002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(31686004)(53546011)(2616005)(6512007)(6506007)(38100700002)(36756003)(31696002)(86362001)(2906002)(44832011)(7416002)(6666004)(966005)(478600001)(83380400001)(6486002)(4326008)(8936002)(41300700001)(4744005)(316002)(8676002)(26005)(66476007)(66946007)(54906003)(5660300002)(66556008)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1hqRGN3MStxbWNib1ROMzBBV3dPVHU5VUYzdmdvdCs1c3M5SWJCakJRd0w3?=
 =?utf-8?B?aExOdjdaOUtGZFBvZmxOaTJWNEx0VzhwcVdFdi9XNW9YQit5QVV5L1UxWXhC?=
 =?utf-8?B?L3ZIL2ZWeDRvd1JRN1RkbjV5dTB4WVpuQ0dvWWZuQzY3QnR3ZmlYZ3czQm96?=
 =?utf-8?B?QjQzUWN2R0k4NzVxUUNoSXB1Q3BCdWlLeHRtcEZlSiswYVJjN2RlaG8zRHR5?=
 =?utf-8?B?VEtRRzdwSmV2NU0zY3kyb2E4VGpBUThTeTB6ZGxoSFl1OGdrdHJ6dlhuTXd6?=
 =?utf-8?B?OFVkVEdveGE4M0krWER6Y2pLYzNndTExS0ZsTktRdENNampqVEJOcHZ5WFo0?=
 =?utf-8?B?NU9pTGQrM1NyR1U1RnQvRVNvUnJpU0s0R2F5WjIyQVNuZTZMSWo0R0VVZUl5?=
 =?utf-8?B?bGRPazd2RnRDS0ZLVDNFVFlmOW55MkNBMndKOGNnM1Z6MDFpd2h2Skc1U0RP?=
 =?utf-8?B?MEM1TjduVWtzSkNHMy9ielZIZHBFY0RISDNIZ1lIL0xVMHlLUWVUYzJYdDRq?=
 =?utf-8?B?U3RMdXZjb0hjQnowSjVPcFVaUjN4eXNaLzRHMkhLNUNKV2VYYUovajFCVmh4?=
 =?utf-8?B?WlFjYktIVDBJY2tmVlowWFFDcFhsSlk3c3kwZUF4TjZzVEsyK1M2Y1FVWmFN?=
 =?utf-8?B?L0xmc0xiZVZvQlNsbW15NGVpUldlUnVmVWZzR3k5WkJWTG5pVVV5ektLV1Vh?=
 =?utf-8?B?QzNIOUh5M3BsLzdiZzVCQkNwRWdKNmVvTTNWYURRNUpELytvSW5BVFZrczd1?=
 =?utf-8?B?SjVNZ2U3U0YxR2ZHdjBsMjY2TDA3a1ViUWxab2JFVk9mb3FIeTIwZHJpZjA0?=
 =?utf-8?B?NnExVGJURlJPUFZoeXRwQ2ZUa3EvSjdibGZVc05pSlNjTmZqYkJERzJtUWZH?=
 =?utf-8?B?Ti9WaW5RUXpFWHJ0TEpIby9MZkJRbXhRcjZCQWR5Vlc4TEdRallmVTZYU2pn?=
 =?utf-8?B?UTdhV0cyUlIyZXNQTUthamdZWjc5UldxUHkwRU95SzVoZzVUTk1EaldxZFFU?=
 =?utf-8?B?RjRTazJXTVJlR09hRnRzaW8yVCtGelFNNjdBYjJ0VWpIbDlDYzVzek1RVTFt?=
 =?utf-8?B?VjZWQ0VVYW1KYmhEK0p4elY4TGlMT2JrYVFNNnp5YmRmK2dscVFVK1cvazlI?=
 =?utf-8?B?bnZFVzFFRE5RdEZ1cWVQWW1NWEwvQlQxRmNIOWF6NU1ldUdyaHJ1RjVUM3Ir?=
 =?utf-8?B?R3ZXamhZeHNLK0N2Vk9hT2VnNWVEWDhwTFgzaWJpM2RKUlBrUldsRUpDaXpl?=
 =?utf-8?B?VjJ5RFNtb2E4N3VDZUc1dFllaEVwV2RSK09NQW8yelFyYmk0UlNreVR4MnQv?=
 =?utf-8?B?SjE0eVFsa2cwa3ZzN3hTWmpqUlZpTWFFcjVZZzZsK3dCRjE4WmQ2bDROdHVm?=
 =?utf-8?B?M2lMM3ovenIwWFFPMU1pMldaYzhaalErbzRSYzdTbzdYUjNSWEZIcEVsY1Vm?=
 =?utf-8?B?NUFXelAra2w3NG1OQ25DclZSV1FEV2VrMisxdnBhak9qcklybTNwVEJhYnNh?=
 =?utf-8?B?aEZWdFA3eVJIeTNNcnBiaWkxQ1pVOHozYlAybHVUYlVCZGt5MjI5ZUxJU0M4?=
 =?utf-8?B?bGE5dVpaeHdhWFdjcHJjbk01ZDUvTzgxWXlVZlZLMkU2S3hLL1ArNVFMQjdO?=
 =?utf-8?B?Y0dsbHgvUlJDdUgwWTRsRmJhNUJYNUE0Z0x5eVdYdWxjb2M4QTNxTXIwMGhZ?=
 =?utf-8?B?ZkI0RzY3a0p1dnRlYzIzOWVWS0RiVEV1OG1od1RzRHA5R0huT0VaanU1TXBy?=
 =?utf-8?B?SjZHZlVONmJNRElZb3p0ZVRQUVVCK3p5UFdmSjlWVkdCWm14S3lrRnJPQ1BP?=
 =?utf-8?B?c2x5RElSZmJHbnptT2ZkRG52WXV5SkRrcFVkRFltSEs4TEZ5SlNZaVM3TEhK?=
 =?utf-8?B?VEE0TGlEY0s2N3QwejZoN0c0MWxiWldKSFU5ejJPMmtxWlQwN0lnUWFCL3dY?=
 =?utf-8?B?THA2ekRoY0p4aWdUU1ZQR2F5ZmR4dE1NQWUxb0dRZXE4QTJSZEQ0SWtFSEcz?=
 =?utf-8?B?THdJMnkybWdhaDZOQUc3MDlOY29zd1d0S3FlbEVBeE5kNkZBNWZKZy9BVS9S?=
 =?utf-8?B?MUtlT2REUXp5SldJc1hEZHdPWDdsV0xUQVFFcUhkZ0tIUmtBN3JqQzA1b3BX?=
 =?utf-8?Q?MpOjyoNGrCE65mdDJWCC3WqUU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UFI3RUtheXJDalZ1b0N6MlRKdjd4NFNpeTVramlIbVFwWGNOSjNrNndwWGNs?=
 =?utf-8?B?SlBpSkFKWC8yWGEveVZ0RzNWMk8zY0FkZkt2MjdDWDQzTlZRTHdxOUFQd0kz?=
 =?utf-8?B?KzkxemlBaTNDQVlHRmwzbzNBc0xsSTBrYUZYTnFpQkhYNzQvS2lHUERjaE9j?=
 =?utf-8?B?cjdFUXBqbzNPNTJDQUFVdFU2b1FsZStwYkw1VkxNVnlaUkg1VC93MlJMUkdD?=
 =?utf-8?B?ekhWZmF1cTcwVVNGWVBKWGtVeGFMNytDYUNKVjhSSlpPZnFwcUFnUngrS0s5?=
 =?utf-8?B?bGVDTGwzYVpnM1FyZEJIL0xraVAzWTBjb3N0bGUyOHcrSENKU3Z6dTNZNCtU?=
 =?utf-8?B?Sy9GR09jMmx6QW84U2RnSGZVcGFQMnplWVdaMU5CUjVrNFRRa1p0MG1PN29L?=
 =?utf-8?B?U1VqQk9ua0dWL1ZoZTBOeWEybEV2TlNHUmJTYnc0YllrL1pibkl3QzFEQmhm?=
 =?utf-8?B?b3g1YWVRWjJXYVRYWTZpQmdRazJuMkJzaEtqQ0lDbElHZkN5MWM1OERtZHR1?=
 =?utf-8?B?SG9qMmwzRjA0djhsa2RsS0pORGdWeXh2THk5VTZsN29nT0c3YWJzOVNkVDlp?=
 =?utf-8?B?a2NGUzJBT0pseCtJeHdjSEJBNXRaUWFqZmlNRWZ2RlZqNGQwdko2YXNnK0tE?=
 =?utf-8?B?QWcvWTQrcHpnUGxPN0xnK3YyaEwxUEkzTEQxSW5Zc0haSms4Um1rSzZIUXI1?=
 =?utf-8?B?ZmhNWXc3TnJzYjNmejZzNlhIazVra2p1TjdIVjdMR3BuQWhTUGdzbmlnZFc5?=
 =?utf-8?B?ZlNvRjJveGZhRnF6WVQrL2RzREZqenF4M2lXemN2UkM5REF6T2RrNjBtVkdJ?=
 =?utf-8?B?RVFIZjRRcVFaWUhPUmhTZGZXSmJhUnRqV3g1SGVNTEN0UlFEeGFiQU5hVnZz?=
 =?utf-8?B?d3JVMEYvOTlvM2hXVTRId2w2VkR4NW9NQjFYQStaTnNvaWV1T3NCTGVESW1H?=
 =?utf-8?B?TzFqRjRzNlBESUhVdUx3anZTcm5zWkYveDkyMS81WXFaRkM4WFdRWU1RZElT?=
 =?utf-8?B?SzhKV1A3cTMyVGtDWkxLbTk4a1VrZHNWU1RHa2crSlJkY3dId3YzcTQ2T0x2?=
 =?utf-8?B?aVptekRaVW9EQjJCYU1HbUl4cnFTWEo2RFRFSklPeUxQSFBPeTgrdnVyaTdi?=
 =?utf-8?B?Z0NVVHhXdktrclRiTWxEUmRBUy9ndzBlVWxpYVFSMVNFamdDd3lRT29mOFBy?=
 =?utf-8?B?RHBBS2ZsVFVZZUNIVjVkbHdLWHFkaU8vamUyVkY4dUJCbC9tOUNOaXZSWFpP?=
 =?utf-8?B?RWozTHFWQmNqSHBEOUdzTm1pb0xMeHpWVnowVTNqUURiQ21TMFhkZERpYnAx?=
 =?utf-8?B?YklrclZMZlFkczhXN0tKVXFyZHZ5TlM0QUtxL1dUMDdjOEp0MUhHNWJQWHpn?=
 =?utf-8?B?dm9kYm1xUlBKSUpEN2ZBZ2pBOVVFT3BKbnVRa0tCOWNUdjVpd3kzOW8rWisw?=
 =?utf-8?B?Rng3VXQ2VVRXTmM4VU9FUkFvekhMRk5rL0VWa1NTMGh1QUI0cUtSbTVjQjZm?=
 =?utf-8?B?cFdDYXNkR0x0dUVYemVpRDR0SGF0N0VCWHJFbHlWdEVNbW1IOFErVjlGWmQr?=
 =?utf-8?B?WFN0dz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43eaccf6-3d81-4d18-f78f-08dbc6d7e1cf
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 01:51:11.9207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R13wC+f2c1KJ2BowM937axlgIn3icvWLRjRm+34NVD5AP0nCMzWzpfY9q/7o351E3SFrXZRgXktH14fzPtul0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6259
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_15,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=899 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310070014
X-Proofpoint-GUID: B38xda6Lkx50owysfqcVfmDRTqojNhe5
X-Proofpoint-ORIG-GUID: B38xda6Lkx50owysfqcVfmDRTqojNhe5
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Konrad,

Just wondering, is your arm64 system a VM instance, or a bare metal?

thanks!
-jane


On 10/6/2023 2:39 PM, Konrad Dybcio wrote:
> On 6.10.2023 05:08, Mike Kravetz wrote:
>> On 10/02/23 11:57, Konrad Dybcio wrote:
>>>
>>>
>>> On 9/29/23 22:57, Mike Kravetz wrote:
>>>> On 09/27/23 13:26, Konrad Dybcio wrote:
>>>>
[..]
>> I will send out an updated version series in the hope that any other
>> issues may be discovered.
> I'm pushing the "later this week" by answering near end of calendar
> day, Friday, but it seems like this patch in v7 still prevents the
> device from booting..
> 
> You can find my defconfig at the link below.
> 
> https://gist.github.com/konradybcio/d865f8dc9b12a98ba3875ec5a9aac42e
> 
> Konrad
> 

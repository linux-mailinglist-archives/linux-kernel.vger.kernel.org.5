Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4AC7E482B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344060AbjKGSWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344074AbjKGSWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:22:19 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3D1D79
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 10:22:16 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7GeR9K024973;
        Tue, 7 Nov 2023 18:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4Y0I8W5lcuja+puXF5a5dK8MF8a6Aw275NEWU5MdzeI=;
 b=DAPM48a+49vCQcSdRWzH8fVJ30+4sCB7JkUK8aoZ49yCi+RlxjU72oVy2dJh7nK3CWmn
 sto9XJ42M5LbWtvVOMF5t+U7jC6fvBNk20Vlp3s7t82VoXOQbsZJiC5XpGsdcbBIoJpx
 dD7zAC/dLTHoMM1DHUGXvLAVP9yfKsV/8W71zMachs32Xbe8qd0+nGTdwEwZgYmVkNRM
 w3fbANGO1K7xIwEae4FERctkh5mg9pzHRIs3vQ0LIWBTkPUO+o+r2WABcMpS1ZRSWwIn
 eB759stDY1Nr3hcZ0R2/+Mlf5mppT7YRnFJoyVsEfcE+GZ3FrZG6YGUZHY6hAf7I/1SU 2w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u5egvesp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 18:21:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7HXTrj030438;
        Tue, 7 Nov 2023 18:21:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u5cd713qn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 18:21:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lzw/EK7KG2B2Bm9NgLWY4apUiakvTG6eODkIGAy51dXksB1S+vEPmCZ8ju1fbZJaaGnmxdU1B1WWULoIH39RYuCH2YgCjdWHt/ia2DuLyiKjS0Dy0YGszWEN0QAMfMRX2g233v6rSj47fLphGG8h9lzFcGbRot9iqZ/p4V9xOszgAz90DE4k9H36UY3FGf6gAmGYnKovnhSxX3IVDG4OiIN38HroWY2UozCTnIOj3dSh9BixMWACQ0jQ48JXxfwjpkdvUc6v5BA/S5a6Kotv7AVUOKSZpZFlB9sOsZu6VGVXA1s/t46mkg0e6XND7yEP0JcNUdwZf5FVQZvIacKAUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Y0I8W5lcuja+puXF5a5dK8MF8a6Aw275NEWU5MdzeI=;
 b=mdFtdS5Epv99A0/S8FagqAFlUeZl3UEC/a4sFeSUaPPafnYswVC7ZdO6VlrR7xZ/+AbpqMb+tvNQ93LN9w8AN6+ZHAIjRMatW91Ln8mzBzWgnE9SYN9g2Ul437lp171Ql3b2tl1ZjCl8JF0T+L69X8FQNcoHN0yKnpupvdBKVhqoKhHo0oOafXI+RPCmlQ64/DVIZs0o2LnFkNWUS7NPlZecgty4scWH7d6rMRFh+Zx8+7QaBXCollnh1AjUU36RYDvXyYjIn5UgLQPhNJmPDc3wVyB+BrwTT77g01tUrKY3rKljZbvdX5G69ZNAh70brOyjdeBUWfH9PITEjh9BGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Y0I8W5lcuja+puXF5a5dK8MF8a6Aw275NEWU5MdzeI=;
 b=JelhaLJ/DxGykr2C/qf1jlM7+m9kwjtKe2qfPfySH2Q9Gj3vyiF13AV2utvP5zIZH4zt2Q7H3/SiMepAfJxKCV/L6IbHJkuqueUd650b2GFwWwX2g5SyRcVCFLhIeZ+8UIv4Az9jA43ltEYkR2UJKD6oLK7oQmDgWNJAHAFTLOc=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SN7PR10MB6285.namprd10.prod.outlook.com (2603:10b6:806:26f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Tue, 7 Nov
 2023 18:21:55 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::1530:5eee:7ef2:f0ef]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::1530:5eee:7ef2:f0ef%6]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 18:21:55 +0000
Message-ID: <c08a67c7-4506-990f-b051-8fcab682042c@oracle.com>
Date:   Tue, 7 Nov 2023 10:21:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/6] mm: memory: rename page_copy_prealloc() to
 folio_prealloc()
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
References: <20231107135216.415926-1-wangkefeng.wang@huawei.com>
 <20231107135216.415926-4-wangkefeng.wang@huawei.com>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20231107135216.415926-4-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:40::18) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SN7PR10MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ee3839-a5bc-42da-51aa-08dbdfbe6bd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mDECPw5UIiXP9gziQsoYje1wCF/Xl8rFzcNuJ13T/rHpqVQr+iDj3HvjXwCINYUelzSLfpP5ZD+iOdt0J7cwlYgDPHKZxiNMieayyFybCMg6QFXz3bh+WCgf3UkSwaCA9lwslc/3tO0m6iyDjr9UtYzRncNomsTj5+M7qJarC+MvJOYEddTO0vq0jRv3Hnr30P5RI5ATQmM1Sk5RA74iYDdNCz9pVF5NpdtrvTMqIB/aHbElIbK7l7QHbpgKQQfJdjw56Mc15D0MrL69PwcMbLrdwppC0bqprPXHHT1EiUggZuM4mHAybJ+YDn/NJ6k7JAyfBPrVfZsHVvBJg4JX0bfxXvsdXIxAXqlRAG7lAIxD44ZMIQxSPXoLlnIsqg0zjqeuYsGQK7lu6THPg3BR1dgto/2zRU8DV7VGZc79Lek16FgYztXB4zmWc31SktJGZWAHpsHJIXx+860tGYYORWIfgP1x+q1HDiN85hFDsqlVq9P8IlVpj4qgYrHRpEajcg26tphl0O4oH6KxM9JArEu4JlXaf47IGTJdedSJzvQzTxhPkKTzh8GoZYIApLfsIeF4DzZfPlomOqCW0ElZoxK3vssS9NzhGWIQsy6Xg0Emw2+KAgHXYeABGBIsu/0fmltPRNtiBMa6HZsQ2HkFQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(396003)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(41300700001)(66556008)(316002)(8676002)(66476007)(54906003)(4326008)(38100700002)(8936002)(110136005)(36756003)(66946007)(6486002)(31686004)(478600001)(31696002)(5660300002)(44832011)(86362001)(83380400001)(6666004)(26005)(6506007)(2616005)(53546011)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzJDdE5GN3BrQ1dXaEYrNUZLUFU4ckFCTmIrYm00OE43aCtVNkRZSThNTDky?=
 =?utf-8?B?SEhLM3ZTNFA5aEFWazZaMHBGSDRia2cxN2JORnpRa2ptelQvNFN2RGgxYUQz?=
 =?utf-8?B?SEZGMzIzTGYyQ0xEL29UR3p0WHBpZCtpUGVCZTJEcVlQeDE4azllZm9YRFpz?=
 =?utf-8?B?ODNGVWhxYTVLWVNvZ0RBWU1hVmt5TjJ5ZUZHNWcvQzNKU2Q2eWRCOGtWU0lK?=
 =?utf-8?B?SVFzVDgweERPMC9WakwwbWgzRWhmZWFTN0ZSMWszYTJEdm4yMGZ0QlFiQyta?=
 =?utf-8?B?K0Y3a1d0TmVkYjhoMk02bmtnZE44cjBGWWp4Z2dsU2YzT1NNd1hrZ2cvOHN0?=
 =?utf-8?B?ODJETkFuK1FUWnlUbGJqMFdmWVV3N0pLcVVvTXVhYnFiQ2hlNlZDd1ZDZlNE?=
 =?utf-8?B?aHJodUZ0NEE5eXNTcGVKNGxBSUJkMFdsVDBpQmoyNUV3N1NJSTVqS3BsdkZS?=
 =?utf-8?B?MEVSWE5sUTU4YmZuT1FEaitCVnpVR0xmT0xGcUlvUVkwN0NqQzIvVENZZ2lj?=
 =?utf-8?B?Y01uZ0kxR2psL0N0enZWSHNkcUJKVU1VYzY3cngzQzZDcFBSVENJNXVrejNC?=
 =?utf-8?B?bXBTaWg4akNnTkNVZFVlOFk0QWUwbWlUWTVwRDJWakczU1FtcWdYQ3RhaWRP?=
 =?utf-8?B?RTBPYmRmMWYzV3NDS0E4cnI4aEpvZ3VoQ3d4akg3RG1Cc29QYWJTK3J0MzdN?=
 =?utf-8?B?eUVkOWg1cHV5aGNHd1l4M1NubEY1R1JvbDVWUkhrRmNBVWFiU3J6Z3VDTnZG?=
 =?utf-8?B?T0ovSDU5VlJGY0FMMWtCMnVFOURkVVFxVlNmYnJUenNXL3crc2txMUlTT3Bv?=
 =?utf-8?B?WE1WNFYybU5MRS9uellMMkM3MVJyenpHK2RnVlNGYjIwLzQ2c0RrN1hycE5Y?=
 =?utf-8?B?dVNYeDBBNStqRzV6U1NCbVErU05QZ2p1NEdzb1I5R1k3dlFwdzM1amhxZEVW?=
 =?utf-8?B?dG1TQng3QURkMHNMTlp0bXVnTzRnanpxZllwV05wWGFWWWJpMG8xLytuV0Fv?=
 =?utf-8?B?V1Q5R2FZMEtSUzZJWmNWcnphd0hQc0MwWXN3NHVacVk4Rm03VHRoR0dkUXN1?=
 =?utf-8?B?dU9hWEJmbklnTlFTZStHSkpmd095OWJRaWNnSjNveE05Q1dvcDBjVng3SVpZ?=
 =?utf-8?B?ekFycGh3K0h0N0wyelNvVTNEQTdwYkFjbjZBT0JIY1NLa0dzR1d5TVJPYnZv?=
 =?utf-8?B?Y0wwYmFQVkFqQ3lXYW11MWVTd21Xa0JsZEtRclQvdXdhUzVvTEIva3Rtc0gw?=
 =?utf-8?B?QUJJcVF0YTl4RS9haVFwNUtKWVdYY2I5RWFFSXBVekxpczBoZVV6alpuejRl?=
 =?utf-8?B?MURQRU9tQzlNVU9hQkprNm0vcFlSOElCTWRHT0tnTys5dzgweWVIUWljYnAr?=
 =?utf-8?B?RVBGWmFtTktycWFWUnJXS1pxa3RiTWo0ZWhyeVV6c1dxUmhseERwekNGS3pN?=
 =?utf-8?B?aXhhbUF1UlA4TUNSMlpEYlNWaFVuZExMNkdWZmdkZzlURXYwWHhBbXB5Zi9E?=
 =?utf-8?B?alordGhYcG05bHRsT1JNLzJ5YXQ4anMwSmxiQVJrcG55aGlUMGk4VEZuWWxT?=
 =?utf-8?B?MDc2SFJIMGkxejF1eHY2cStpYlA5eUtuZ2xkWHhsSllTUDVWUEdzeDVtTzVQ?=
 =?utf-8?B?NGJGQ1VCblJkN1FucUJJQWQrYlcyTWNFYkMxeTFFMTRBU1hua2JBR096TXlU?=
 =?utf-8?B?YzlRY3hvOEFEc21Eb0pnT0IvR2M5MzV0cTJFVWc2bit5YzNiZWkyOSs5czFx?=
 =?utf-8?B?am1Ya0E2VmI1RUkyLzl4ZklzVUFHQXdNOHhWRmZraDByWXNJcjFHeFF1eHND?=
 =?utf-8?B?aTByUTJDY25lbkZuaCtTd0c0dzVtMVdRQXpYWlJJYWFnL3RaYi8vVnFTM1BC?=
 =?utf-8?B?bHl1QmVrbXlLVEJxQXZMbzJDYVNhSG4yR3RHRnp4RDVybHpBODQ1UkVDNlVs?=
 =?utf-8?B?NllQTzI1WmgwYmw5Sm9NRzkxOEc0STFUa01aNXZ6ci8raDdPb0Ezd0lkNjFy?=
 =?utf-8?B?cGVyYnlCQWliZEw5V2NXZ1B6Mlc2Sy9oS3VpOXlJSUNOVjk0c01XNnk5aHJq?=
 =?utf-8?B?L3pycnVWdkZDSUNxbXJIdTdwa281MmM3LzRGbEwydzdoeGtoSVI5UEFlZnho?=
 =?utf-8?B?TVBjdGZWbGVnaThUbSs3RVZuNHJUU1dkZ1AwREpMMUhCVmtpdndFQkwxakFU?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?N2ZFL2NFbXpOZTRHeDgweGs2LzlMNjJkd0V4MERpUFJsaFpIS3BqZWx5RGd1?=
 =?utf-8?B?ci8zczNZRk9tWmhtL04wQ29mOUtVOEZzanVDUzNUWmhKOCtPN2VnUFBYdVBU?=
 =?utf-8?B?d1Y5TDk3VnpVd1BQWE52S0lXdDQrK1ROSTlXVWl1Si9MYTJrS3V5RnhMQml2?=
 =?utf-8?B?OGx4TTZheFpVNE1rSGw5WWtBUG4zenY0NW9XdHJ2bmxUeFoxS0hrZ3FJS1lR?=
 =?utf-8?B?djBjUCtyalo3aHI0N1h2bFhhL3AwYmVGMStRSkNPS1Y4a0tYOWYxRS9ZTDFZ?=
 =?utf-8?B?ZkF1SFBibzg4VWlVVXd3YTVrUEowQXUxLzNCK3U5MEF0V0tmblM0cUtJTHMw?=
 =?utf-8?B?WTJwL3FETEtXemlodGN6d3A3K3k2ZzlQQjF3MVN4MGRHMzZMYlQwRU1kWnk1?=
 =?utf-8?B?RVVOK0IxYWhyQ2QrcCtSMG1DNWlXUGkyMjZjeUpndTZDdDYwTHBSRmJONXMz?=
 =?utf-8?B?aVFCZk9HbHRKcm9DT2FjQ2lVT1lDOEE3UGZnM3VESlZ2Y05wMkJxanRlTzAw?=
 =?utf-8?B?Ym1xbXJkazJVMzVOd2tFajhPUXlrOCtXQjNrZ1JxaU1pYnV6Z3N6ZkJpK0di?=
 =?utf-8?B?RVQ4ZGt1T1liQk5VTHFlTmxSYk5HNmx6VkhtRkpOT3hMcXRNN3lab3NwZy92?=
 =?utf-8?B?WlF6NkQ1ZXhxL3ZnSzRNK21Cem43TWQ5VUNjOFczYXJRaEhmc1YrNmtLams0?=
 =?utf-8?B?R0lBSEtwZDB2dGJmQ2F5YjVjd1hoUjJYclN3UTFEbTlzL1pxNjM1b2NRSU5R?=
 =?utf-8?B?OGhpVHZVQ2xOWGNzRUEyK1lJZWV2M0F3Zk5PMjBhT09VVDY5Y3dBMjVPQTd4?=
 =?utf-8?B?WlBNSlRWZ1RWemhyVU1qd2VDa0o2QlczWjBTcE0vWW9Xc3VIeHFXNXRYOVBY?=
 =?utf-8?B?QWRxNmVXMGxRZVorazVSNXlXSmwvbU0vdFM4ZE1zckQrOFBMTzVvZ2xEVWVq?=
 =?utf-8?B?MHVQOFI0eU9CZWhPejdKMVAyNlJFMldrK29JeE9EL2JvRkhZZ0pIdHNTUW9l?=
 =?utf-8?B?c0VXSGdkcnJPRWRBbWJJQmVYUThZR2Fzc094Q2pLakwySmQ1ZUNIcEFxS3pC?=
 =?utf-8?B?MDVNU0ZPWHpPUGN2ZjY1R1diT1FGQWhjckZRTmxDZDE1alhlQ1F3TDVMZmZz?=
 =?utf-8?B?UWZQYmtDZjF4M01SNllyY21NVnV2SEZpSkVqeThsa3dGZG1tcHpuSDAzd1Bp?=
 =?utf-8?B?RzcwMzV3VFZDV3YxWWNRT3k0M1piVUcxbGlpYWc0TThQMUtMQ2QvOExtRWFx?=
 =?utf-8?Q?UH4gzpUu1uED7TG?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ee3839-a5bc-42da-51aa-08dbdfbe6bd1
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 18:21:55.0417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/q3VxGbsmatQx2vNKGNwYEaxlFqXzRcUaDVDTU+faDD/yTpltRffCJuaqHypCxwL3ztPsQsy/S6kyEan3v1FVf75IBDxmbeh4DiurRR68A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6285
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_10,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311070152
X-Proofpoint-GUID: XPYOqWk_Mgz7G1xMDv-mChDEj4O5sgtC
X-Proofpoint-ORIG-GUID: XPYOqWk_Mgz7G1xMDv-mChDEj4O5sgtC
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/23 5:52 AM, Kefeng Wang wrote:
> Let's rename page_copy_prealloc() to folio_prealloc(), which could
> be reused in more functons, as it maybe zero the new page, pass a
> new should_zero to it, and call the vma_alloc_zeroed_movable_folio()
> if need_zero is true.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>   mm/memory.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index b1bff4d245da..062136d25da3 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -988,12 +988,17 @@ copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>   	return 0;
>   }
>   
> -static inline struct folio *page_copy_prealloc(struct mm_struct *src_mm,
> -		struct vm_area_struct *vma, unsigned long addr)
> +static inline struct folio *folio_prealloc(struct mm_struct *src_mm,
> +		struct vm_area_struct *vma, unsigned long addr, bool need_zero)
>   {
>   	struct folio *new_folio;
>   
> -	new_folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, addr, false);
> +	if (need_zero)
> +		new_folio = vma_alloc_zeroed_movable_folio(vma, addr);
> +	else
> +		new_folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma,
> +					    addr, false);
> +
>   	if (!new_folio)
>   		return NULL;
>   
> @@ -1125,7 +1130,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>   	} else if (ret == -EBUSY) {
>   		goto out;
>   	} else if (ret ==  -EAGAIN) {
> -		prealloc = page_copy_prealloc(src_mm, src_vma, addr);
> +		prealloc = folio_prealloc(src_mm, src_vma, addr, false);
>   		if (!prealloc)
>   			return -ENOMEM;
>   	} else if (ret) {
Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6696B793808
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbjIFJXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbjIFJXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:23:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AD3E6D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 02:23:10 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3868p6uA018722;
        Wed, 6 Sep 2023 09:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=v9o0ql6zEcvr3JavE4lPpdX96Yg0Cj2AYRaxPfZxdfc=;
 b=t//U0nSvkh93jUPg5KJgZoCClRkgYT1p34eq1e104ki66RInAdhr/oEzz8uLoaqCjMIB
 w5wmkZVQBDf/zKt0WjE7/dbAHA3wyAfiFsary/RPlmvO+Nxj58no/9JakqU34jv6g10V
 H7TsNRQS5TkuEIGzJZMZBZGH8V3oMIwYo20xLU1oXBeq9wxbwB8g/TlRTGxXHHYyT10J
 5pxISQ/h+xDec7HGtb7+brhKSTt+6bk2lrlHPF/uj42U6A9pESlA59D5tP/kt/nLcLQq
 BZ5qEanez/2yE7mlfP3Ja6g/ILr0MPZDzYqACoRxkuB1x72ooVzLiyPoSqkygPUEXuZX Rg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxp8y02jk-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 09:22:09 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3867f8Kt028130;
        Wed, 6 Sep 2023 09:13:46 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug5y41p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 09:13:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXZUSU3fJgbW0bPNJMHxTOPeFJhPGTdaLp8Wim+UBQiSS8JURmeON/vTikH6E4OgaAaTNvLIwT73Tq0A4JmTimeBihwGdJCM1AVjdCqdtVvB6vB22wJR6Uq5fvqmvBkjWnexZAeKHEeBZXvuJ0WCCHFDNUxz6Gee/ZuP9G/3D4ZLYT3GlhFR8UMuLS3+NMhDPuZ5ol3rr7xjOa+lStglI9TIs4kp4SOGlpXzRouJhftPaoC5qu2ia5dYAjvx5NJQIlLZFVBjpmhzHpm6zeVwadlFGbJzDKPa28o6V+UqbQNQhsE7yXP3pDGaUoR195M0Ldvv358Nq1X6DWM/zi1uCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9o0ql6zEcvr3JavE4lPpdX96Yg0Cj2AYRaxPfZxdfc=;
 b=U6KKv9efpwKhnKqTeSjtgmixSqzbGVAu3pQV9x/mtO2aR1ONIk39P6SXc3v7UTt7xengb0ZdT45xNB5IbhYoJnXgF1f9QY4be6Q/84yQDrf/x46Rmb56ByifM8vYgB8uGH+DvsTPBxUeE1BXTLjlXR0LtoklxATmYfCGpnEWZ70Wm/qLWFug/Qc71/u5IGZeZydvcadrO8qU68pJXfmkGBe1TrDVl07nWuds74s/QJShs8ODnsYd38VRi3crHcjhdLyxkVE0vztkSnk7Lc3iu/koylDlace0HhavGT6nPyWvXz93T0K17Ehv03P0k5mCbKNk96D0ItoIk/HClU8Vjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9o0ql6zEcvr3JavE4lPpdX96Yg0Cj2AYRaxPfZxdfc=;
 b=ECaWycRRMe1ePmnRhQagdq4sLbtVKXkcubtb5Y58WJnMKpA/69RLfPGGPhgMa1XrPRc5RpLQ6XjWChw0yES96s89pKMpE/YQzj6vNyN4xQMijhDjztY8EHxAdDDtNHdywrE+Vervmt8AqLUkddxQblmM2ukPehOfmfYsp9IstkI=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by IA1PR10MB6074.namprd10.prod.outlook.com (2603:10b6:208:3ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 09:13:10 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::2867:4d71:252b:7a67%7]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 09:13:10 +0000
Message-ID: <1e20f8da-0a4e-78a8-4d2d-8d5a95a5adda@oracle.com>
Date:   Wed, 6 Sep 2023 10:13:04 +0100
Subject: Re: [PATCH v2 09/11] hugetlb: batch PMD split for bulk vmemmap dedup
Content-Language: en-US
To:     Muchun Song <muchun.song@linux.dev>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
 <20230905214412.89152-10-mike.kravetz@oracle.com>
 <0b0609d8-bc87-0463-bafd-9613f0053039@linux.dev>
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <0b0609d8-bc87-0463-bafd-9613f0053039@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P189CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::23) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|IA1PR10MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f928a3c-310a-4290-f0e7-08dbaeb97dbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6vmK3sHPrxqn0Tm99/HdV3tnhx/bw85J7iH6/qpqhXQw1ZWENqr33WxuJIpheoB9x/a70Yg86B6Yy5DF+s4mqvk41f3ZEJztDPHiQ+2hDGm3GwB3aqzzBodJhxZio8kC4rOOjDtdmVo0tk1KvNl4X60AaZuvTHApSQAmqk2VuFKO5NmdgqlGlLMQHsdGLUEwEaPjQAo7xQEtqxUtfmfTX/3ilSmPJeVFLU257Eq6Rl+4bTGJOezba0ztKC+faKidk3sSY4b8TZz/9mGIPA0jrwFN8UMLmPNZVOxJs3GufUtOMM8VkzI6KG3QyUs9avI5Src2nlxT8mq4WVVU3p+lymrOzEnx0P6sIit7L+yHzAyPSe0sn9dgmlLnpzmOgYdfqZC3d90iqGN319F+H4j12AhwYlarqWSo5/eI39bpnOluyTpLi2w9wjVsYfke5VlwqED8/wA3Iqp1OWTI+iarACBPcyJGdj2Jl7RYxe6w0cSh09tj0NL+qBlAuU+NHKRZMG9PTCgcadoUq8pqsk68cLL83Q7gT5j8LF8BF/KF4q3HjxT1m6rujaA3MfMcfKQIr1z6DZtM7+jtjx3kcaGHfI8XJiZod7vttpUJt2fQ+W4B2EDAhfLEn3KZo8HvzsME
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(346002)(136003)(186009)(1800799009)(451199024)(53546011)(6506007)(6486002)(6666004)(6512007)(110136005)(478600001)(83380400001)(2906002)(2616005)(26005)(7416002)(41300700001)(54906003)(66476007)(66556008)(316002)(66946007)(4326008)(5660300002)(8936002)(8676002)(36756003)(86362001)(31696002)(38100700002)(31686004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjNPN29TSDBNTnAxUHpXSWJqTEFzcjRRMVdEdVNqTUR2czlpK2l0enBlQTVa?=
 =?utf-8?B?U2ppdysrYkl3NUZVYUZTcHpEQ3ovQVpHdDh2MGtEMnZhUm5QODk5cG53YzJr?=
 =?utf-8?B?bXpoSmtKTGJPS2lGYWRIdFlxUEdnaHBVN04yaVp4T0pLM3gwUjBQa0xwZG9Y?=
 =?utf-8?B?UjFkVUdlNWV5Njc2Zys3Kzk5RjF4RmtuaGhURWdQR29qWmlGLzJ2ZnZaWHU4?=
 =?utf-8?B?Ty9EazUrdUJLK1U1TXRqL3owR05KSU1zeHI5dW9VSXdOajA3dzVtRnpDQVNG?=
 =?utf-8?B?T2djMGpuMnN3VHJBUko0Ump6KzYxc1ZIV3VzVkdBYzY3ZE95VUZvNHJma3l4?=
 =?utf-8?B?QnZaaXlpOXNicWV0OHVDQUR6N0dVa3RiTWVlSWE5ZkdFYTBhbzlUaVZ5RW1M?=
 =?utf-8?B?T1lxbGRPR1hoVlVIa0R4alNWbU45cE1kbUhTWUZKcDdzQ0Z0dklrbWRlUFVl?=
 =?utf-8?B?eERpbmlCbGZuRklxcThTU1NsUHpVNXhBcUNxNzNwdnlCOGlVNWhHVENpSW9E?=
 =?utf-8?B?QWQvYnVSOVBNSlhlTTEwSHRBakthQUVHd0Iwazh5dVphZGtNalA4Mkh3ZHhL?=
 =?utf-8?B?aXVjS3FybXNiV2FZa21hM2NjdUFHLzFHR2VIaCtKeE1lZTdYL3l4Y245dzR3?=
 =?utf-8?B?Nk83OFpjcjlhUDJ1bGV1Sm8rSW5tcGVtSldPN2V4MnJINGdzSm9yYjlXZFFx?=
 =?utf-8?B?SVhKNXUzVVBtRDMweForMW1mQWFOTmNVNjNRbUh3SCttdnNtdkFaUjRYeHRM?=
 =?utf-8?B?QWN1SVdoc1BwUFF0WXQrUWZPbytucHdmcExBRExyZ2dSZ2E1LzBtTmREVys5?=
 =?utf-8?B?Q3lNQ0JQNXpsL0JOVkVtT2wzTlRUbkxYR1FLYkVFeTBVT20vdWs5aFE5Ykda?=
 =?utf-8?B?UHVDazhLUUN4dmtmUGpCNWxMVVJDMVN0YURLamovbWlCd1llcnpRdDl2SEJY?=
 =?utf-8?B?SjRDTWZ6bFo0cmpuU1Z6UWdCYlFhbm14WWZ1VnZld0kwd3hCMmV2NGErWkZW?=
 =?utf-8?B?VWJCRDBSNTR0M0gvN0U0UmVZeWJkbUlSRXRzM2RGMFU3MDg1NDQ0MWNIM3Ba?=
 =?utf-8?B?OEpJcWlSVTBXaVFFb2hHSk9PeVBoamRLUm0yRk1UNnZHUTcyL25waXYxVlZW?=
 =?utf-8?B?UTIvWHUwcDkrWlc0ZFlkOUl3UWZYZEZFQzFNVHpWaXRzNE9vb2krVVVEc3hI?=
 =?utf-8?B?dWpaMEtJbytxMU9VSkRxRXB1NWZoejMwT0tCSk15K3VabnhrK2FBZTc1Q3FH?=
 =?utf-8?B?VWEzTkpwQnNFT0VzRVJyRmdRd2xaQ0Qzd2JYMXNGdkVMSkEvNGJHV2VZVVVP?=
 =?utf-8?B?bGQyOTRkLzkxWjQrWTBzUTA3eFU4ZkVpV3JnOGtvRU5qaXc4UlAzL1htVTVK?=
 =?utf-8?B?RVhDaE00b2xqUHgzMFFBaERjNnFoYnJYY01lN0RZeGhtNitlcEhDUVM5WEJr?=
 =?utf-8?B?clZseGV5WEg3c0dESGJNZllCYkxsZmNTdTZ1VitBeENreTJReU00cDZsdkly?=
 =?utf-8?B?M0xJdStudVpsQUtTQ05pNTUzcVJhc1Y2ZWhYRG0rZEJZU1dQbllqSTREbHpv?=
 =?utf-8?B?UDZNUjhTYk9qUjRYTitDNjhzYjUwWWRrOFRmeUsxeDk5eFBzY2xrL3hwZTFY?=
 =?utf-8?B?ckJkZFVtbGdtc29wN3BWOW0yZEh1SDJJaDduT1Q3ck5ybE8vTjd4N1pyS0dj?=
 =?utf-8?B?SFZMbWpnbDZPcWQxVkNGT1RvdUprZ1VvZCtVUVNJTlc4Y2prK3E3SnFwbDMw?=
 =?utf-8?B?QWVldDRBSjRzaWlOQTNuenFlMFV4SzhxWWlPOWFpUTBwWTJpb3hCZGV3OURD?=
 =?utf-8?B?V0Ezd3RCSk1rVnR6ckFoWWpnZ2RWV0RaYmZQaXRjdEt5MzhONUIxaTFHTVF2?=
 =?utf-8?B?eC9NUUJKaTFoanFSeTluVlJJV2xWT1cxck9sNXNkZFZJOXlzek1JcTIzd3k5?=
 =?utf-8?B?NmtlcHJDMzlMVUVVaEMxYzhsK0tETE1CMUtmSDN1TTNQOGNEYTlNb2JKNmJr?=
 =?utf-8?B?Y25tVDc3c3lWUVRFUkxLTU9TUXBPa0VnNElKOThCRjNoWVJZV01rNlhobEJE?=
 =?utf-8?B?aFhWNTY0RGdmTUZpWU1QNFdDYW01SEJ2a2swQmd5eDE3dXRXaU1LY1E4Q2xS?=
 =?utf-8?B?NVFBREdRVDFuV1dYS05CdTZyVktwOVpieUd3WmZ3WTNHSE5rUndKZ1QxaDJE?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Ym5tWE1odzlBY3ZoTEREL0R0ZHhlU0tvZjBaNzM2UnkvdTVvU2hIbnhYQlJv?=
 =?utf-8?B?S0l2VXEzdnRSRzFVZVBDOVJoQndOUUw3VzBTQ21UN2FWNVpFVGoyMmVhYlVY?=
 =?utf-8?B?L0hKc1pHS0ozVXMzV0w5UkVhSlJYZHU3d1dzNFUwNTBzczIvanFUTi9ZbXJi?=
 =?utf-8?B?eGpUU0RGemlDeldIamNNNGFKYUtSbmJuUWQzbUlNVm96U1BuZ2lrN0JISjdN?=
 =?utf-8?B?U2h6aGZvYnZpNmhnVW9TMmtCTWF5dFU5dG9OZG9BbFNmRDBwekMySE40b2da?=
 =?utf-8?B?Q3ZnRk40ZWRMOFYxaG05QjNKVERHeEwrQUtVcFlTNG90b0pwbXhVbVVCelNz?=
 =?utf-8?B?US9WVXYxOGhmekdIeG1aUWFyZ0w0UE5jMmtjUnFzb3kza3NWL0cvM3FYVEYy?=
 =?utf-8?B?bUdjNFd3Q3VQR21hWHhRLzd3UjhHM2tHM3FGMmFhQmN6TU51M2tuOWN5WHU1?=
 =?utf-8?B?VXpkSkxLTlkrLzNTM1M1QXhISHRYOEFmbW01djBaZXpIM3llWnF0Q0NzWDlI?=
 =?utf-8?B?KzFmUWNQb25YbkxZVWlIbzl6VytRWHlnSGZ0aGszdHdacHhIV0QrUHJpT2Ew?=
 =?utf-8?B?TUlWUEZiNFpjbWJzN2J5RjNCVHFVcStJeWNkRWFOYVdqYlJGRGROKzQrSmF1?=
 =?utf-8?B?S3JGQU9Sa3U4RzlvSUpXWENBNVpwOXozc0pDUkFIaG9MOFhrMVNzNXltcFMy?=
 =?utf-8?B?RVkweWdteTI5U21UazVrMVVBY2NEZlYyQWtyOVdtaVVuU0h4WVZZWVFvVjBI?=
 =?utf-8?B?dHVKZmxFdldoYkdPUEN3Mk5rOU82bGYrcEUxZitWY0FTaUd5dGJEaHcyWTBP?=
 =?utf-8?B?RjFQRlE3K1VVSHFNMVArQXE3TWkrZnF4dEUwNy81T0dnWkM0aUd2T0gxUjIx?=
 =?utf-8?B?TTdHWWZTQm5OZDZOdEpUMjZiRVNzQUswSUtLajlQZlh1SmI5VjVubG80WDFY?=
 =?utf-8?B?OW51U0ZRV2FNN0lEdDBRYUltS01ya0RHam9mYXJlanJvRHFqaHVYSkhtQU80?=
 =?utf-8?B?VDd2R2hpTW9NaUV3WUM2RElJbjlZOWd0RmpXeFpEZ1kwcitJeXJLVjN6NXdQ?=
 =?utf-8?B?a05tNjJQOVMza3YwNkhVc0pUTjJTVGN4aGdIZDZXS0dsZlZDU0Y4VS9vMGVm?=
 =?utf-8?B?ZHFVTG00VU5pQU1PQTNibTFQWFg5TzZmSFkvWEp0TkdWZ2x5VGl0V1dvb1c2?=
 =?utf-8?B?TzJSWUMrb1NPTkRWSEowTjY5SkhWaGlaK25sN2ZRZzYxaTk4QUJKTkFUTDh0?=
 =?utf-8?B?Nldqd3l1Y216ZWEwbXVsUmk3NWdNbmJRTEVQYkx6QTZHd3oxalY4VGNMNXlK?=
 =?utf-8?B?WkZzWTVmQlBCM0toOGRUUnpEVjdhelp2T3ZrU29OWlYrODdJL3RraVl0aEpF?=
 =?utf-8?B?M2pOYU93cXpweVQreGRDb2V0L3VpV0Z0R3BSdnFMRUhyeUt4ZHNHVDVldHB0?=
 =?utf-8?B?cysyd3R4eGJ3Z3dhNEd2eTJaL29Xb215cm14bGZHQ21sUWF2NXhQcHpxVlN5?=
 =?utf-8?Q?pxJ+L+irNeWTeg4JhVrZmlXYtn4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f928a3c-310a-4290-f0e7-08dbaeb97dbf
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 09:13:10.6828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4sYR1GrApMrgmU04XvjRnqtdEN0W8HWokXKG4YhcJNgPa8S0NWXUNnzZRjSvMDx1TUPZuGeb+7GWbuGMtg0Je/jKaeJK+KgWEExcQ2dL2BI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6074
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060078
X-Proofpoint-GUID: EsMMuGj_X57edGUWEqpsM4tnpvgGlprk
X-Proofpoint-ORIG-GUID: EsMMuGj_X57edGUWEqpsM4tnpvgGlprk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2023 09:24, Muchun Song wrote:
> On 2023/9/6 05:44, Mike Kravetz wrote:
>> From: Joao Martins <joao.m.martins@oracle.com>
>>
>> In an effort to minimize amount of TLB flushes, batch all PMD splits
>> belonging to a range of pages in order to perform only 1 (global) TLB
>> flush.
>>
>> Rebased and updated by Mike Kravetz
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>   mm/hugetlb_vmemmap.c | 72 +++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 68 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
>> index a715712df831..d956551699bc 100644
>> --- a/mm/hugetlb_vmemmap.c
>> +++ b/mm/hugetlb_vmemmap.c
>> @@ -37,7 +37,7 @@ struct vmemmap_remap_walk {
>>       struct list_head    *vmemmap_pages;
>>   };
>>   -static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
>> +static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start, bool flush)
>>   {
>>       pmd_t __pmd;
>>       int i;
>> @@ -80,7 +80,8 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long
>> start)
>>           /* Make pte visible before pmd. See comment in pmd_install(). */
>>           smp_wmb();
>>           pmd_populate_kernel(&init_mm, pmd, pgtable);
>> -        flush_tlb_kernel_range(start, start + PMD_SIZE);
>> +        if (flush)
>> +            flush_tlb_kernel_range(start, start + PMD_SIZE);
>>       } else {
>>           pte_free_kernel(&init_mm, pgtable);
>>       }
>> @@ -127,11 +128,20 @@ static int vmemmap_pmd_range(pud_t *pud, unsigned long
>> addr,
>>       do {
>>           int ret;
>>   -        ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK);
>> +        ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK,
>> +                walk->remap_pte != NULL);
> 
> It is bettter to only make @walk->remap_pte indicate whether we should go
> to the last page table level. I suggest reusing VMEMMAP_NO_TLB_FLUSH
> to indicate whether we should flush the TLB at pmd level. It'll be more clear.
> 
Part of the reason I did this was to differentiate between an explicit split()
from a split() occuring during a remap of a page. So we would batch flush on
split, while flush on each PMD on a remap. But OK, maybe this doesn't matter
much if we end up returning earlier down below as you suggest

>>           if (ret)
>>               return ret;
>>             next = pmd_addr_end(addr, end);
>> +
>> +        /*
>> +         * We are only splitting, not remapping the hugetlb vmemmap
>> +         * pages.
>> +         */
>> +        if (!walk->remap_pte)
>> +            continue;
>> +
>>           vmemmap_pte_range(pmd, addr, next, walk);
>>       } while (pmd++, addr = next, addr != end);
>>   @@ -198,7 +208,8 @@ static int vmemmap_remap_range(unsigned long start,
>> unsigned long end,
>>               return ret;
>>       } while (pgd++, addr = next, addr != end);
>>   -    flush_tlb_kernel_range(start, end);
>> +    if (walk->remap_pte)
>> +        flush_tlb_kernel_range(start, end);
>>         return 0;
>>   }
>> @@ -297,6 +308,35 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long
>> addr,
>>       set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
>>   }
>>   +/**
>> + * vmemmap_remap_split - split the vmemmap virtual address range [@start, @end)
>> + *                      backing PMDs of the directmap into PTEs
>> + * @start:     start address of the vmemmap virtual address range that we want
>> + *             to remap.
>> + * @end:       end address of the vmemmap virtual address range that we want to
>> + *             remap.
>> + * @reuse:     reuse address.
>> + *
>> + * Return: %0 on success, negative error code otherwise.
>> + */
>> +static int vmemmap_remap_split(unsigned long start, unsigned long end,
>> +                unsigned long reuse)
>> +{
>> +    int ret;
>> +    struct vmemmap_remap_walk walk = {
>> +        .remap_pte    = NULL,
>> +    };
>> +
>> +    /* See the comment in the vmemmap_remap_free(). */
>> +    BUG_ON(start - reuse != PAGE_SIZE);
>> +
>> +    mmap_read_lock(&init_mm);
>> +    ret = vmemmap_remap_range(reuse, end, &walk);
>> +    mmap_read_unlock(&init_mm);
>> +
>> +    return ret;
>> +}
>> +
>>   /**
>>    * vmemmap_remap_free - remap the vmemmap virtual address range [@start, @end)
>>    *            to the page which @reuse is mapped to, then free vmemmap
>> @@ -602,11 +642,35 @@ void hugetlb_vmemmap_optimize(const struct hstate *h,
>> struct page *head)
>>       free_vmemmap_page_list(&vmemmap_pages);
>>   }
>>   +static void hugetlb_vmemmap_split(const struct hstate *h, struct page *head)
>> +{
>> +    unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
>> +    unsigned long vmemmap_reuse;
>> +
>> +    if (!vmemmap_should_optimize(h, head))
>> +        return;
>> +
>> +    vmemmap_end     = vmemmap_start + hugetlb_vmemmap_size(h);
>> +    vmemmap_reuse   = vmemmap_start;
>> +    vmemmap_start   += HUGETLB_VMEMMAP_RESERVE_SIZE;
>> +
>> +    /*
>> +     * Split PMDs on the vmemmap virtual address range [@vmemmap_start,
>> +     * @vmemmap_end]
>> +     */
>> +    vmemmap_remap_split(vmemmap_start, vmemmap_end, vmemmap_reuse);
>> +}
>> +
>>   void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head
>> *folio_list)
>>   {
>>       struct folio *folio;
>>       LIST_HEAD(vmemmap_pages);
>>   +    list_for_each_entry(folio, folio_list, lru)
>> +        hugetlb_vmemmap_split(h, &folio->page);
> 
> Maybe it is reasonable to add a return value to hugetlb_vmemmap_split()
> to indicate whether it has done successfully, if it fails, it must be
> OOM, in which case, there is no sense to continue to split the page talbe
> and optimize the vmemmap pages subsequently, right?
> 
I suppose that makes sense. hugetlb_vmemmap_split() already returns the error,
it's just testing and break the loop into flush_tlb_all()

> Thanks.
> 
>> +
>> +    flush_tlb_all();
>> +
>>       list_for_each_entry(folio, folio_list, lru)
>>           __hugetlb_vmemmap_optimize(h, &folio->page, &vmemmap_pages);
>>   
> 

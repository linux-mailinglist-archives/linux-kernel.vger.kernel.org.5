Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA0C7A5D18
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjISI4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjISI4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:56:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D29102
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:56:07 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38J6T0cU012051;
        Tue, 19 Sep 2023 08:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=PTfnI97FU6pjXcevY49Jx8tFbYEUPjw/3Pm4JJkxdbs=;
 b=k2CWA5aey8sHe8bV/ueVaFfMBGE8UI0PmbVYK1umcBREcHBzi45/cmP3Q73pgoj8vKlU
 I22bVXIp+KxL/mHbNE5nocmo51hFeC3lYzKzO0D6sMLczuET1HDC89+V5ftW2rcwhFtR
 DZ3OvN94dPSvjYiXz+xlms3AEDI2I1J5jB8+0Upl2eqGALUCiITmNxgWgZPu8Qpkg85W
 65Ngx+YjdXIPvcQuNphpLuzFgNM7944UCuTCO8sF0QmdSw2qrqTjTeIZ/nkOVsXn8kx6
 hClugRlj3fOJwKq4skVzRcZpgqS1Ffl0QhegmUWaHx4RT2Ef2e52HHCZBesB1X08BDQw YA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t53yu4c7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 08:55:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38J8InAk015866;
        Tue, 19 Sep 2023 08:55:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t544pb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 08:55:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmvkOzXysh3JZS2/qPxuoZW0qjYgI0DN+rmktxbRq7nQpQLDEFOMuCL1KnCwi8BsWv2L7mGW6WFDEnaUIElipPaJKc/o/w/a1zp9WmA4d3FIpqMmcDApyQeTp+I0zyXs4wych/eINvsnroFT6f6qb+HolL9Eo1mCH+uIgQNu5nhLmYHXdi254yYfS5Vr2suIU+ko41hSqjUE89HugRaXwbT7Ufi0PNnJfky6HLeXOZQvdVolde07meaex7JxG3iW7WpuMQB9zJxB2cuifqoG6Vk9AXj/IjKHqjn2YTJhgng6WsGSTek1FCL5dQK61GLjdJRZ3ToqaSQIx3LwRWWx5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTfnI97FU6pjXcevY49Jx8tFbYEUPjw/3Pm4JJkxdbs=;
 b=JPojA77/cPR5op7KTYqICfz5/KKVD7BQ1tHvC77lUa/OzwWSgT8AqaCQgRmoN9qm+45imccgAy+/hqUEzZfUNhsgAZbBzUdHqyKyLxmkDgT8C4ymWaETVJGaX1mlJ5vgtFKhs3Yif+TXOwG4IswvtOTEqw2Alc/XaPEuXxT0NtDo685+t9TTPn19FOx5qIwcYPy1uVDaCQZTZzDsDAYjf+4FuNSWbW+LlO7BADN4wPzEI9FwlV0BqQxcln1FdsWaXOYS1kE4bROinmlVy/DJ1cUpFaszzBYA+XOj5P2gpGGi+/qvMzrYl3LJwjhEm0OMojI2yvnLtRI/HJDDQGsGQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTfnI97FU6pjXcevY49Jx8tFbYEUPjw/3Pm4JJkxdbs=;
 b=XEBJPeRutmDTDdW/OFigH2dYXyHehKXI6MdpAMlUk1A9LZ/poR1n/0zSm6fj9dNzG3V/wocKE5OnZIsSTFXCIu6qwiKYbEPEvq5QcYTp1RWI5i8pr8EzSWhr70YZnqd1NL+lfMRvmqryz1dLLgrrYHgUxL3Qd6KLsKzQ0vr5Oec=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by DM6PR10MB4394.namprd10.prod.outlook.com (2603:10b6:5:221::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 08:55:28 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::8adc:498c:8369:f518]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::8adc:498c:8369:f518%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 08:55:28 +0000
Message-ID: <d1c4ee80-2096-4949-af9f-d55dcac071cb@oracle.com>
Date:   Tue, 19 Sep 2023 09:55:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] hugetlb: batch PMD split for bulk vmemmap dedup
Content-Language: en-US
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230918230202.254631-1-mike.kravetz@oracle.com>
 <20230918230202.254631-7-mike.kravetz@oracle.com>
 <9c627733-e6a2-833b-b0f9-d59552f6ab0d@linux.dev>
 <d8ca9ff5-3160-49a1-947a-de4998887dce@oracle.com>
 <07192BE2-C66E-4F74-8F76-05F57777C6B7@linux.dev>
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <07192BE2-C66E-4F74-8F76-05F57777C6B7@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0204.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36d::7) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|DM6PR10MB4394:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1ed1e8-4461-49d1-7e3f-08dbb8ee2c1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MgI9pNuVcHhYk+5fUG1gRCYKColRSvLCSsyhLsdjnC3UyZyDmNvnmueL9s7/+q0davM51nGb3AY/kN5b7/FhAeadArL3mUqYSww894DUZQWwM+TxA5DHoHRKUk24wYjx+4+txogYEXN54hR7FjEGHk0BRD1zNi6mclJfaZc+xQ18yd/Gy7y8Pc2ooIVIvVeJ7O6BUH2rY2rJLCAttMuR64jZ3SGLsrOrHliYW5joWxkDwEHDrSIxb6qCYO2COI7iZW5bxzIPxq7csXXQd3WF08mGkxULYyZB/f+iQolZ7BmnfiyBwg83QmPgxHkEgLg+opkLGVFMTs+yAOxpmDvXXEr/lfZr0EAKo0zDz7Jqp2gnK0vwKxKUC2SdE5bfvODvlUWQMzye0t0SXKanwaMtfaemX80z8IK2yS1SymM+dYukFccVH+OuZu/jUUibIGvk4LAH+MZkZ3rIKtBw5LzNOhJeKM+jcoi7sxJlt/ZQNY4n+0NuYBzFLXeyCZqndRmtUI6gHxr4C5pErcQ1UgdpbP+Mj4DpHlr/IWjR3+89XwoLbgg6hH1Fo5Tm98978g6qoA3BTmPBebkaQ25+7Yy/r5vxr7eQo/zogHOW33+Qp7mv5Ob0rWcOsveZWz/st0ccNRD2b/aQZTJMXtxHzW7cMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(1800799009)(186009)(451199024)(38100700002)(36756003)(31696002)(31686004)(86362001)(6486002)(5660300002)(53546011)(6506007)(6666004)(478600001)(54906003)(4326008)(316002)(7416002)(83380400001)(6512007)(66556008)(2906002)(41300700001)(8676002)(66476007)(6916009)(8936002)(2616005)(26005)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmJpY2F1WXJZcmNFcjlQMld5QXpwR2ZXc0I5QU1nTWYxOGNpSDdCTmlaU3FD?=
 =?utf-8?B?OVVGUkFuZEhEaC95TTBjVDNyUVJCSDRUaU0zdFdidHYySzUrK0NxZHhrV0xK?=
 =?utf-8?B?QTVEUGR0eDQ0R3pmT2I3dWh6V3Z2Q1l6bVc0L2ZDRFllSExFdE9UWUVQbnhy?=
 =?utf-8?B?YTF6U0g5SzVkQlFvbW8rbXR1TEhtd0ZWK3A3RDRZckJkaVhmM1gzaFh6V3di?=
 =?utf-8?B?UUYyWm8yZ2NaZ0xwUnM1em51V0lUUVhScXRWMjFMYnFhTWNwbzJaRkFPbmZs?=
 =?utf-8?B?RkR6STc2UDJuR1loTjAvU3NQcGhZTy9KR21zcmNsbytqazIrNWF2QXoxTHVR?=
 =?utf-8?B?V2ZOeUo0V2t6eUZoQi9yaUc4amJ4bEtpL3pIUWVESTVtVkkrM3hwdmU3ZlhE?=
 =?utf-8?B?c1FMd1M3N1dMckZvYmpsaVJVU0d5ZzR3SnpPcmlhRVFlaHd1cklnUS9walpy?=
 =?utf-8?B?S1dtY294amJobmZPYU14eW5pY1Y5OTNVVlBkR1BoSnFjLzNPM1pTdHRVL1pz?=
 =?utf-8?B?c3RxRGI5K1BERDBjSzhpblRRWWp0TXJ3ZHlLU2tldGFyQlp6ZW1yZklhRFJG?=
 =?utf-8?B?MXJZTFRaa1U5eGRnMVZkL2tCZVNDNWhsV0dZWFZqOWV2VVJmcDFDeUVQc3Jn?=
 =?utf-8?B?Y3g0V2VHK2RXcXV3bWdLYTBwRnpqeVhBeHhrRFltamdsRkhPZ2llY3VFVHBx?=
 =?utf-8?B?c3Bjb29xdE84RThwYk9YM3JrRGl1UUV6T2pvMzFseUZCZ2dUOGVwazdvdjVD?=
 =?utf-8?B?TVB1TTJZMXFGaE5VSUFRRTgyR1ZoMC9rUGJ1QjY3ZUdGLzBSOUdJMUxwdmV4?=
 =?utf-8?B?bWRkY3V4QWNXRTNDTXpiQ2pBOHc3Nll1dk8rZFFRcG1ETE1wclk4ZHVnTnBK?=
 =?utf-8?B?MkVENDRTTVJPL1dIMDdiMFhlb0svVVhEZGdBUnZjcUdoYWFoUWhpTTYrOERL?=
 =?utf-8?B?NitvdXk3QWhOM2Q2T3MrQThpM2gzQmRITjUrV2lKVjY0ZjRXc2RDZjE0SU9m?=
 =?utf-8?B?SUkzUGR2OG91RXdOeWcyZkgyNmZJN2R6ekdBTWlHZ2EvYUw0K1czOG8rNUNr?=
 =?utf-8?B?eWVGTndpSldaTlJXSFREMTIrVlJtMVl0WDQ4aExyZnFLcFlLUTExNW93MW50?=
 =?utf-8?B?MDJGRTBWcDZvNENCMUdoVlNhR3pLQ2ZwbnhsSTRsdzM1OG1QbFFHRWNyMjlE?=
 =?utf-8?B?dzg3MDkzdGtHNkp6UkdqWnMvd1dOU3dvaUp3bmpaQjRoUUovdkt5YktoeStP?=
 =?utf-8?B?eldxN1l3am1HbU1EZkNVUWJ6NWJnN2Z6cGIwaUNhaXg0dVNFaUVRS2VLZmFn?=
 =?utf-8?B?eEN1OExBdEl2M0VwTTFqK25VOC94SlFxSCtlaldhVmZzSVRPUjFLRXZNMDlw?=
 =?utf-8?B?dlRNb3FIcEMzd1Zoang4dVg0OGdzK1FHdG8ydHZyUXp5QlNCTElQRkdkMTNF?=
 =?utf-8?B?VEQxQTNhbkhwZ1ZINlpvR3Z5VzA2a25pWERoSzd5QWtOTTJWYk9xSDc4QXZJ?=
 =?utf-8?B?K0lidWFzbDJ3R1hjZWozZE1WRDNKSG1XT0VNTUlVK29UaWo2MUZYR0s1OGxK?=
 =?utf-8?B?S1hqdkVTZE10bGV1QmEzSjZyUHRUSTRNUVZiNFdwQ3VKcWs4aTJXL0V3Y096?=
 =?utf-8?B?WFpWd1lTa1ZYcTY1dUZwU2tUNmJCRk1mZ0lKbFBrUEFIdFRGNURMR3dsK1VK?=
 =?utf-8?B?bjdaWTVPbVhpTU9ZNU5xK0JJOVlkakU5SWNBd0oyWjNKd2x6N21LM3Ztdysr?=
 =?utf-8?B?eTBSbVFBK2QzME1wdk9aTjdNdFVmdzNtcGxsYWN5M0hkZk0yNVJCYzgzanQ0?=
 =?utf-8?B?ZWRNbnVwQldrd1NMTkVreTgrMDBBR0R1bmk0M0YvelpMdFBncDFwR01yNjY2?=
 =?utf-8?B?WGxWYjkrby85dkE0eE83MVN1MWJSS0lBOWVQZU84cUI5SFJhaU4vZGdsRzZX?=
 =?utf-8?B?ckRQZ3hSWVRhREhxRE9BMFNCYlBWQjdMcWp0aDhaZGorQUwvR0VvRTdCSXNE?=
 =?utf-8?B?SWhXNDlBZGV4WmtmQjJjT3U4dFdubnF6TEdrdzhtems3VStRQVJBOWxNZGx5?=
 =?utf-8?B?Q2hURk9hSUxOa0FHKzFqK1VGOGZVRlZ1UjMxWmFhTnUwRVFIUXUwdXIvbFp5?=
 =?utf-8?B?TEpaV2dLR1lLUWJ4T1lQVGpHYUd3bXdaUTQreVR5a0k4b0s0NGZUSmplNUFo?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?L2xQWmg3aDI5V1hIU3dFN3BTZ2dtTWxzYTJLbStIbjJtdHRXbmVSZnI1clhF?=
 =?utf-8?B?WjA1ZUdCUm41R282QzJjTUhpK2ZRMXZlelhEV2NpYi9ib0RWTUR1NmRRYkZN?=
 =?utf-8?B?dytEcVpub0JkdDF1M0VEL01Lc29oSTFGV0lwdWtWOGQ5YUV6K0J3U0dPRWo4?=
 =?utf-8?B?eG9ZUGdXdEQxNWJFeUZkdXI2Szd6WDlUQWdDNFZmSnJYOEtzNFM5MnQ5U2E4?=
 =?utf-8?B?bzFRYVZrTG1KUWFnZGNPaXJSUG9CUVVBQ1lOZmdWSWdONVdxMCt6L1NsUmJ5?=
 =?utf-8?B?NHZPUnRuZ1lETlUxOVJuTTdIRGdoekFIbEJGRDNjcm10bDN0VThlcDlqaDlQ?=
 =?utf-8?B?SHQ4YitScXpJYzBGMUNlRDZJS0hjRDhLMCtUWEd2M0pWRGN3elJVV1VoSUla?=
 =?utf-8?B?cm5PY0hOaHFSeVJtWmZwRGJYaDZKZURyTHpmbG9BMjhsNEk4K25rcWtYZHRC?=
 =?utf-8?B?N3dsb2Z2QTNVd1RKUkpzSWd4M3VqeVl2a1FDMFdoTkdaN010Tk9reWtNYzhW?=
 =?utf-8?B?WndHc3Zyd3J4OUJVaWFjVy9Qdjl5TXMwMTcrcU9vbWQxZzNxd3czNEIrRWF4?=
 =?utf-8?B?ajdESWRmdlY0Ny9ITUd3UnlPQU0vSGZxa0hIdzJuVnVsUE92RS9RMkdHeWli?=
 =?utf-8?B?aXU4QWp2VDJsQkV5SC94bFEraTdPYXBhRG9IcVduZGxHY2JEaDhDWlNZUTY3?=
 =?utf-8?B?bGlvUE1nWVBXUmViQThNeTBuSWpFbjB0bjNKZXM0bHN5RThMSzNlTG9RNlY4?=
 =?utf-8?B?eExyM2dSMnNkSzRiam5nWnh5UVQ2MHgvakErZHk2dEFaK25Nc1dxOGw3d0pu?=
 =?utf-8?B?bGdaUXFra2x1RFQwNkFucGltQktQcXpVcThIUU95bEJUaWJqZXk1OEs5b2Qz?=
 =?utf-8?B?VTRkY05RUW9ScTkyVURVVW1nRWdCUElLZHFvSHpPK2hLZlowbVgraXhKY2NZ?=
 =?utf-8?B?ZEZjbGtmZEpCUGlzdjRJUTU5Rjc1QlhoV1JhNkVpY2NvZjl5L21aMGlNODFI?=
 =?utf-8?B?TWhVajZtUnZ1akphcU0wTVZUZkNUa0d1eFROdW90T1V5ZlRXZU5oTWdTMGY1?=
 =?utf-8?B?V3h2TGV1NWl1ZHRmblNRQ2taVlJvMmNoQ3J5bXB5ZThOakh6di9ycmNRQjJK?=
 =?utf-8?B?QVIwM2FNakYxc2FFOXFjd2lNMk9MbkY0NlhEOG9ERDM2bFFqRlBRd0UwdDZp?=
 =?utf-8?B?STZFYVlZTVVWdXloVmZHSVhtak14WmxoTUhod3N4OGZWNElVWDJSb0JFNUpV?=
 =?utf-8?B?MTE1OW1qdVFBSjJnTnk4MndxK0ZjdytPRmtBa2NBUnZLVTlZVlZncE85ejht?=
 =?utf-8?B?TlpidDU0SGpKeDJxeXU1VWdFRjBVSTRMTXh6cVAyVDRvMU44QnVTUjJMTUo0?=
 =?utf-8?B?TExSaU1qQ3BtZkJsMU5EU2VyVFh6Sm5ZZmJ1S0s5aHNwWGdDcUJMdTduMURo?=
 =?utf-8?B?QzA4ZnowNjdEUEVsNVE2WEJ2djdCVEV3dWhpYlFjVGN0NzFNYXhRWXlrdXFw?=
 =?utf-8?Q?AzvWEpakc5V2wA9jex3DaM5tVOT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1ed1e8-4461-49d1-7e3f-08dbb8ee2c1f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 08:55:28.7145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FciwoGntyjH0Q++4u4p6T4Vk7Blder7sJ7rB4eDVWnCuHIljeIh1A9OGtfzjpBNoP8SonY3S43C16O8bA2tLZUS7Xk4S44jFVpTrS7Wmzkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4394
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_03,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190074
X-Proofpoint-GUID: -fUmmEuT2WrZG-zNQCNJ9F1A8INi82IK
X-Proofpoint-ORIG-GUID: -fUmmEuT2WrZG-zNQCNJ9F1A8INi82IK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2023 09:41, Muchun Song wrote:
>> On Sep 19, 2023, at 16:26, Joao Martins <joao.m.martins@oracle.com> wrote:
>> On 19/09/2023 07:42, Muchun Song wrote:
>>> On 2023/9/19 07:01, Mike Kravetz wrote:
>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>>
>>>> In an effort to minimize amount of TLB flushes, batch all PMD splits
>>>> belonging to a range of pages in order to perform only 1 (global) TLB
>>>> flush.
>>>>
>>>> Add a flags field to the walker and pass whether it's a bulk allocation
>>>> or just a single page to decide to remap. First value
>>>> (VMEMMAP_SPLIT_NO_TLB_FLUSH) designates the request to not do the TLB
>>>> flush when we split the PMD.
>>>>
>>>> Rebased and updated by Mike Kravetz
>>>>
>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>>> ---
>>>>  mm/hugetlb_vmemmap.c | 79 +++++++++++++++++++++++++++++++++++++++++---
>>>>  1 file changed, 75 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
>>>> index 147ed15bcae4..e8bc2f7567db 100644
>>>> --- a/mm/hugetlb_vmemmap.c
>>>> +++ b/mm/hugetlb_vmemmap.c
>>>> @@ -27,6 +27,7 @@
>>>>   * @reuse_addr:        the virtual address of the @reuse_page page.
>>>>   * @vmemmap_pages:    the list head of the vmemmap pages that can be freed
>>>>   *            or is mapped from.
>>>> + * @flags:        used to modify behavior in bulk operations
>>>
>>> Better to describe it as "used to modify behavior in vmemmap page table walking
>>> operations"
>>>
>> OK
>>
>>>>  void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head
>>>> *folio_list)
>>>>  {
>>>>      struct folio *folio;
>>>>      LIST_HEAD(vmemmap_pages);
>>>>  +    list_for_each_entry(folio, folio_list, lru)
>>>> +        hugetlb_vmemmap_split(h, &folio->page);
>>>> +
>>>> +    flush_tlb_all();
>>>> +
>>>>      list_for_each_entry(folio, folio_list, lru) {
>>>>          int ret = __hugetlb_vmemmap_optimize(h, &folio->page,
>>>>                                  &vmemmap_pages);
>>>
>>> This is unlikely to be failed since the page table allocation
>>> is moved to the above 
>>
>>> (Note that the head vmemmap page allocation
>>> is not mandatory). 
>>
>> Good point that I almost forgot
>>
>>> So we should handle the error case in the above
>>> splitting operation.
>>
>> But back to the previous discussion in v2... the thinking was that /some/ PMDs
>> got split, and say could allow some PTE remapping to occur and free some pages
>> back (each page allows 6 more splits worst case). Then the next
>> __hugetlb_vmemmap_optimize() will have to split PMD pages again for those
>> hugepages that failed the batch PMD split (as we only defer the PTE remap tlb
>> flush in this stage).
> 
> Oh, yes. Maybe we could break the above traversal as early as possible
> once we enter an ENOMEM?
> 

Sounds good -- no point in keep trying to split if we are failing with OOM.

Perhaps a comment in both of these clauses (the early break on split and the OOM
handling in batch optimize) could help make this clear.

>>
>> Unless this isn't something worth handling
>>
>> Joao
> 
> 
> 

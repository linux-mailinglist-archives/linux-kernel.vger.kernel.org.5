Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682247A67A9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 17:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbjISPKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 11:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjISPKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:10:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9634138
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 08:10:45 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JE7Ko2002186;
        Tue, 19 Sep 2023 15:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=HEFHCeLtH1z0VDClV2EUEO+qU6u6l1ETlZoyYezGN40=;
 b=rHh8W3xupA5P1/KitlBWsYDmFqx5k6KsLn75bPsFSRzKOy6PoJyBsLs/8+pXcK7CYtlH
 6rCax0v9ekFL3UuFO8IGngKNO74/z1O+c1zy/tFq4mjlHuIZSwY3Wp1gs2I+taeWoN5C
 PAWMkY5WTilaNu5NwEjW2FT0HDeO22zydTszZm1rrMsxkgxmZyPcTUIazKhBAuL7lZH5
 CN4KYdpV5B7LNrfvdEsWu7ykQNhsxKTmtq501dH4O7aC9w3F658U55LZdvXHebQhIWs2
 UFy3VI/4coE+5dS9zWBVTOs5YxNZPHcw9tgHJOzUSadrGh+C1wv1RliabRY1HFm6oJNv SQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t54wun2w9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 15:09:41 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38JEcouf030875;
        Tue, 19 Sep 2023 15:09:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t5swj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 15:09:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GT99UDEyHV7nD2hyHB4NgmlMlYcxc/U5QeiILlCwGB8EL3QMOi092Kre9im/ATUrhL/kN7fe8QvKZ3hFaMmjSVuq9lITOVSXILCuAgdYRJu1XLmYp02D1aqWFnt/EFWRaxNRN0f9oyz9lZEwlxb3hN9Cecgp3IB73M/W76DPCooy7RDl2PQtG2Qhso0OtFJuZRceSNukZFWAyardiNcLleJ4aW6ww7835tNcdntBIWbfz0vgjbv3RsDle6ddfCAwODcSdCYm88Pb08mWhBYklRGse+6cCNl5RjjjEm010LrrBFf5pZwXcso6W8h6MbTB3bebcjz3/8jFir9S0vlTWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEFHCeLtH1z0VDClV2EUEO+qU6u6l1ETlZoyYezGN40=;
 b=e0DS9eYr37S8THIeECy7WzAFL9W4Mve92ATsxoYWPfLSiGGOkGiKUcR9milMw/l46YnEy1UEf0mbDNSi9voW1G9vhRlW2Lx8Cl8hjakX0E240rgtsJgpLqgE7lJJDn/K2qgo+HN1h7D5rS5m9zw7VJChdgrRLxnPFUuexeTbcCpJwI+FHWa8rtMvwDNU0wtWuxPLA33hPFHNTCDeuhbhC5TW/5cbX7F7cER5zxMSNPDN+Eg7HY0RJI0yDC+1u2e2aUMNLY6Wv1s4Kdk0qhYnRK8ajbdmPNmdfYZjpswMOC+Z2Y0ivGVIoZ+yHY82de/2z6CusBjxpatT6hftp29iQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEFHCeLtH1z0VDClV2EUEO+qU6u6l1ETlZoyYezGN40=;
 b=kgkNwwXP0/E9w51Gj+uDBzJo+yBPzf2FoZLv7obaHPvH2iCJLqxcFV334sxeNfwMPvUnFTePbtBaw0V/hwi7+rtT2d0QDu1qcwuH/9c7Jt3T5gXwPIv7W7H0iN1tefqiD2Xq5KiEA2Zh/dir3vJfsydhUwUM1nBUabmiKEtnAiU=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by IA1PR10MB6073.namprd10.prod.outlook.com (2603:10b6:208:3af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 15:09:21 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::8adc:498c:8369:f518]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::8adc:498c:8369:f518%3]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 15:09:21 +0000
Message-ID: <5bd9c4f5-3411-4327-a495-ce6672150977@oracle.com>
Date:   Tue, 19 Sep 2023 16:09:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] hugetlb: batch PMD split for bulk vmemmap dedup
Content-Language: en-US
To:     Muchun Song <muchun.song@linux.dev>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
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
 <d1c4ee80-2096-4949-af9f-d55dcac071cb@oracle.com>
 <83B874B6-FF22-4588-90A9-31644D598032@linux.dev>
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <83B874B6-FF22-4588-90A9-31644D598032@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0346.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::22) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|IA1PR10MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe81510-67b5-46cd-c748-08dbb92266cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q6l6jqxIDWn4WBEwrPk946DsGs1idc6G5h+on1XW9BUr7aeIQqRabrmKC6QpJFEY0jLClTxPkyVUKAvHNS96/ahyDhwxPzH9w3S26MvW7uSG9uT8LMuJIdZF9Xmm92lTkES+SNt4DReQefQqeFl8kVlyKWxJAfawsrQ7vleibdVnnuM3D+s/Yytgo7DULp4rW8rpf/mmJv43aq05lccjjv7gQFeozSaOSVXIH+vB5VF7K8c0sh1Hwp20BvatD1NHTY9YIJiIoBB0EHQ1nnH6cxxmzRKOv7k3ClceF2U+Z3Ogr9EdFH79If0g3tRMPLi6ov1B3yZKJgew7Dl7Op3bvnZmzYcUOZjS234camt5fFW3UCZcDK0FhCm5kYG23n3bkrFSu0FluywUhKYm4aPXrboSVbGSWUCoOMhTUdPnmhUdAdXpnNKPQL5Q+ORMB2PX7vZbinQViU9ur6NHYy8LD6KbpLCTUFOjVe/g/5qDN/lwlJIrel5e0VEBCE0AieLN5ytRopMhD1xNBXidT8aAtmsatQPTu7DQFBnQdg8pxJRmlMpqBEOJsR2CdTEDnjuL413fwC352cPDF10lO2vWjqhGi+djLNUvCndBkGTR3tF4fvABHbiqh7rj+QiF9e7H6tEwRcoh00FKCDyrsWSzJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(366004)(346002)(1800799009)(451199024)(186009)(7416002)(478600001)(41300700001)(5660300002)(6666004)(316002)(2906002)(110136005)(66556008)(66476007)(66946007)(8676002)(4326008)(8936002)(54906003)(6636002)(31686004)(6486002)(6506007)(53546011)(6512007)(26005)(2616005)(36756003)(31696002)(86362001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3Z2T0wvaTZLQ1huRUhPR0NwclZ6MDhrZmF2V2JmWEMyeUtDWXgxYnlXdkFt?=
 =?utf-8?B?NDErWEh3aEk2M1Ard2pyZGhXTTFXSEZpR2tQTkRFaSsvNS9PRjVqbzRZZ0Fz?=
 =?utf-8?B?bUcyM3RmUVAwUzlkeSt5MUkwVnJ6M3lRclZBa0dGemtmMkFNZG5OTlZ4OFgv?=
 =?utf-8?B?K2gvWlFWajloS215QkpvTENvcmNST3MvRGpzc2FydXRQWE5KamFNbGVVR3RU?=
 =?utf-8?B?QWx0MUF4VGYyR2ZvSnVKUEhtN0w2Y3VneENDYyt3NlQ2cVc0b1Zoak1VSzVz?=
 =?utf-8?B?cC9YYVhqSVBlOHhuUWxqNkpQeThWVlhuK0hYKzdmNTM0MFp6RVh1bGNIOHBP?=
 =?utf-8?B?YlNNUHk3TW5zQXhENDdvcXBTckFzL3ZQclNXOVEzZXJ0Q3pFa0l4U1V5R0ha?=
 =?utf-8?B?Mi9xY0oyK3o0T2ZzcFRyVXlBNksyNW03VUF1d2tTWjJIanhRWUo5alh2WnNZ?=
 =?utf-8?B?UWliS0xZN2NtYkM0c1AwZzNMdzZPYVU2UnNiV2ZkT0hkZW9zZzh5YTEyY2hh?=
 =?utf-8?B?L0x4dnowd2tEK3VlWGJoYnlvRVJSTTFOd3pYdDd6QjZYMXhkSXZuY0REYzR4?=
 =?utf-8?B?VG5Wb3J5aW5VcU5qZVowMXkweHVQcjloOW55LzR4Q2l1Q3pyOXI1L0d4RHZq?=
 =?utf-8?B?dWI3cnFjWG4wK29KVS9sSnpCV3pSVnIvbFlkWGR1N2pzZitQdkNxYVB3a085?=
 =?utf-8?B?bUdqRzk0WXNiVUJkcS9VcXFweXovdklvQThkeGxJM3B0TFpnbE15UkM0ZjZh?=
 =?utf-8?B?VFhZbG9tRzcrWnVDL1NCcmQ4M2hNNTAwUzYvejQrYlFob3B5L0dHeXh3YkZJ?=
 =?utf-8?B?a1NHdHR3OVpyZU1PNXJ2U29wT1F3THZyUU9mTlYySzZvVGdOMFhKdzZldHov?=
 =?utf-8?B?TWFWWXRxa1RreWZxYXp1aE9OQzRGZFRtakFtYWcyR2EvekY3bmxyR1FsZEla?=
 =?utf-8?B?K09pOUFhT0FHTmh1N0prU2dvMTVnUmJNZGl5VUxXdVNlODJKQ0syK0h1ZWtt?=
 =?utf-8?B?anFVR0p3V0tJbjdNZlZjOFF6QXkrV29VYUVyK2FGblkzRjlMdDd1TmJ5T1h3?=
 =?utf-8?B?L1kyM0N4Rm9XdXJJb3ZZcXY4N0FPUXViQ3QwNzR6OEsyMEI3ckh2WjFhSFRB?=
 =?utf-8?B?bXplbkFoRE9vd0xSdWdpTTJTYTZnZXgzc3BCU2pUVzVtRGtoNGNZaldDZzNh?=
 =?utf-8?B?R05RV0FoVDF5TGZsTDVqT2k3OXpZajVnbXJ4RTZVMnhENWlHL0Vidml1bmV0?=
 =?utf-8?B?Tk8xUUpwQnpkbHNGZlBHbXVhVDZMZVdFTEs3L2RHOVJRbUhLUFlvQmNSczFK?=
 =?utf-8?B?V05iRmJlYjJRUFNTWXcxWUF1NE85b2ZKbWhGc3YyRnNLNFZWbndjRU1Ka2NG?=
 =?utf-8?B?OERDV25SalFwcVhOT2FhL2dvUkVHZW1NQ2dzQ1lHV0Z0VEFZbVNzUDNvcWF5?=
 =?utf-8?B?SnVnQlB4RTBWY29Db3IzSlI4TEZLWTN6VXZxVk9BODFiNElFaTNMQzZNc1Rp?=
 =?utf-8?B?Q3U0bi9IaUtzdUh2VDlobStGZDgzZ1hjMWtrM3JDV0NFMVZmOHgvY2JyZHV3?=
 =?utf-8?B?TXdvN1FMemZXR2hUeFA3QWd0SG9xaG5OMDJaN2I3bllCWW5xQVNuOXAwK000?=
 =?utf-8?B?bGZ5b1FTd2VGTVpFc1pWTUgyWTVxR1BFTmZRSk1tYURUR1FPTDErd3E5eEdz?=
 =?utf-8?B?M0NwVzhocW9teHlSYzVDVk53dW5SSTcrczM2Y0lINExFMzZxUGdkMkVtcXQ0?=
 =?utf-8?B?SG80OG8zcFIvREZTbGRuMXRxTm83bHJQbkxHS0YwMGp3MmQ0ejRtNG96a1RT?=
 =?utf-8?B?Z0hXOXE5QlJhWE5WcUcxWjMrT0hzOGZrNmF4V1d1SlpiMis1R0E2Yy9JQTEz?=
 =?utf-8?B?dDdEQ0pZakxwOVNCWmJkZCs1TEVHU2pHUUcvelRYZlM2NWZGUHdUU0d6R1pm?=
 =?utf-8?B?VkoyU1hTSFc0Y2hrWWZkTHlnZ0ZhbXFpakIrdlc1VjUwNEhDNEhyblduRHg5?=
 =?utf-8?B?Yno5Mm1ROEd2eXh1bUk4UjNZM2dCd04yNnpleUFxcTdsYm45TzQ5aXVwYlFm?=
 =?utf-8?B?WFFLbVozeGRXR0lQVlR1M3h2ZGJIeXQzRzZuV01xYS9aeVZzM2RwUmYveWRl?=
 =?utf-8?B?QlJLUzJjYVV0bFVRSzk3T012ZFkxemZUOTgzanhMMURHRkxkL0RZQy8xTm5V?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VWFmS1JHSVN1S0thSU9HQ3dxbi9QWDNSZEkyMDJLZ0wyS2ttSTNYVkYvcUln?=
 =?utf-8?B?MTQxb01FUlBQREFJUGFiYnFaSlNyRCtza3JaUGdEU09yclE0VlEyTSt2bU0r?=
 =?utf-8?B?VEdtWDRVWjJVeHNQV0kzdEF1Ris1RWtRMm9PRVlWSUh5Nzd2RlJ1WTMwVTBv?=
 =?utf-8?B?MzkvckgxOUVvdGtnRlVVSGVVcHBMVDVDK1pjSFMxemF3alVoVFNaa1FXUTV4?=
 =?utf-8?B?MWlvN3RvbUYvZWZyQ2JGWUQ1MTF2UjBCZVJtZEh5RXM5L25MT3hnTjhGeG5z?=
 =?utf-8?B?c0xBRExqajJENDFxRDIzcXhoR2ovZkZPS0xxeE5kUVkxSEdCZDgzRFJ3RTR5?=
 =?utf-8?B?M3AxYWhtN3hwT3NyZml1SWJkYW9NVVdJdktuTVRocm9WNzlwNDNnSkwzVGZk?=
 =?utf-8?B?eHlta2xrZHBIcnNTaWVHejJnQ1lVYTRtYWUzSTBUNDQraDU1NEIyMmtZd2JR?=
 =?utf-8?B?aG01elFiVFRmc2Rza1F5dHBJUXY4Ri9aVHhwZmtzU1pQS3FWaFZzS1haU1gx?=
 =?utf-8?B?MzJSb2pvWExFc2hNbFJFckFWRk41N1V1MUpCZHJiMkRYOXBCcFdZa3gyRFNP?=
 =?utf-8?B?Tlp6R0NaUGFzQmRQMHNFTGxwY21OSGlrcFNXTzd3Y2daV0w4U2xzOVV6cHdL?=
 =?utf-8?B?ODNzQnBDOGtLa242TkVPSXNaWXE5SWFYL0lsZjVoczZMei9XY2ZWZ2ZnNjVP?=
 =?utf-8?B?WGl2SFJNYTZRNVBBZmZrdTBYZ2hOY240bDNXVnZ2RDZlWFZGdzNVVnVsa2lJ?=
 =?utf-8?B?akplU2FYa0ZESVpxOFpmM0VNWTg2UzNhcFFROHpwUW1CVjg5Z1o4ck1RNnUr?=
 =?utf-8?B?Y0pNYndEbVJZQUk3TUw4QzlxYlpaa1hocFVEN2VDOFJEblZuRy9WRytJSmpt?=
 =?utf-8?B?b2NqNy9rd3dxME5GNE1JUDVCMHRzYjU0WUd4RzNSNXlzYnIybXNwa05tWFAx?=
 =?utf-8?B?cEFrcVhtaW16cUdNRGdWMk4yWGFqdGdpZURlcTc2MFd3UUZzTXZ5UXkxYnM4?=
 =?utf-8?B?TzlyTVNtck1BanFvQk56bWFiYitoaHdXM3oyWkZSVW44NUxyUjA1THAvRThN?=
 =?utf-8?B?dU1ucHV4ditPTmEzVmFaVldIOHUrZi9RcHIzY3pLWUM5dWdSZ0V6eHc5K2Nv?=
 =?utf-8?B?TDNvL3d3SGdHdzkrY2ZFNWNzVEh0cVVUK1JVdzdjYmJyM0piQjJTNlRXK2FT?=
 =?utf-8?B?anVKaUZzMnROQUZxQUtEeWRramNnSGtGSWtmNVF5OXlsbkV3TjRzZWtyQzhU?=
 =?utf-8?B?WGNBYjQ5TEpzWDhUa09BNktLNEJ3eHJqbS9FT1pXUVYyV1JpT0dhTVpDQldS?=
 =?utf-8?B?UDZzK3MwejI0Y3ltdjVwcWtpTTR3aEZMN3E4VXpiak0vOUM1c3FnUW1sYVJE?=
 =?utf-8?B?YW5wamRaUkxKOGFNeWdYYmR4T01ESXdXWmV6dmFUSmFTK29JalkwaXhwRmIx?=
 =?utf-8?B?VlZpR0dMQnB4V29QeGNUNkVyNnRyTG0yWlBHLytUb3E1OU9YUzd5bDBDZmJo?=
 =?utf-8?Q?aKv5cRVVwHPfFL5wnnPVBqKLHnd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe81510-67b5-46cd-c748-08dbb92266cd
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 15:09:21.1714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xdof7v4CNgyMNOvizvjgqM29+yA9v7XjYTZ8yS4ZXzQtf/P4H1sEptU9H853miH13AyCVZceMtJfkLMTzhByhfGt5tCFLJ3dwBbfVNzk30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6073
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_06,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309190130
X-Proofpoint-GUID: VpwpKekGVBhS3GNLiFpkJXaEhyLW1cs0
X-Proofpoint-ORIG-GUID: VpwpKekGVBhS3GNLiFpkJXaEhyLW1cs0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2023 09:57, Muchun Song wrote:
>> On Sep 19, 2023, at 16:55, Joao Martins <joao.m.martins@oracle.com> wrote:
>> On 19/09/2023 09:41, Muchun Song wrote:
>>>> On Sep 19, 2023, at 16:26, Joao Martins <joao.m.martins@oracle.com> wrote:
>>>> On 19/09/2023 07:42, Muchun Song wrote:
>>>>> On 2023/9/19 07:01, Mike Kravetz wrote:
>>>>>>     list_for_each_entry(folio, folio_list, lru) {
>>>>>>         int ret = __hugetlb_vmemmap_optimize(h, &folio->page,
>>>>>>                                 &vmemmap_pages);
>>>>>
>>>>> This is unlikely to be failed since the page table allocation
>>>>> is moved to the above 
>>>>
>>>>> (Note that the head vmemmap page allocation
>>>>> is not mandatory). 
>>>>
>>>> Good point that I almost forgot
>>>>
>>>>> So we should handle the error case in the above
>>>>> splitting operation.
>>>>
>>>> But back to the previous discussion in v2... the thinking was that /some/ PMDs
>>>> got split, and say could allow some PTE remapping to occur and free some pages
>>>> back (each page allows 6 more splits worst case). Then the next
>>>> __hugetlb_vmemmap_optimize() will have to split PMD pages again for those
>>>> hugepages that failed the batch PMD split (as we only defer the PTE remap tlb
>>>> flush in this stage).
>>>
>>> Oh, yes. Maybe we could break the above traversal as early as possible
>>> once we enter an ENOMEM?
>>>
>>
>> Sounds good -- no point in keep trying to split if we are failing with OOM.
>>
>> Perhaps a comment in both of these clauses (the early break on split and the OOM
>> handling in batch optimize) could help make this clear.
> 
> Make sense.

These are the changes I have so far for this patch based on the discussion so
far. For next one it's at the end:

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index e8bc2f7567db..d9c6f2cf698c 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -27,7 +27,8 @@
  * @reuse_addr:                the virtual address of the @reuse_page page.
  * @vmemmap_pages:     the list head of the vmemmap pages that can be freed
  *                     or is mapped from.
- * @flags:             used to modify behavior in bulk operations
+ * @flags:             used to modify behavior in vmemmap page table walking
+ *                     operations.
  */
 struct vmemmap_remap_walk {
        void                    (*remap_pte)(pte_t *pte, unsigned long addr,
@@ -36,6 +37,8 @@ struct vmemmap_remap_walk {
        struct page             *reuse_page;
        unsigned long           reuse_addr;
        struct list_head        *vmemmap_pages;
+
+/* Skip the TLB flush when we split the PMD */
 #define VMEMMAP_SPLIT_NO_TLB_FLUSH     BIT(0)
        unsigned long           flags;
 };
@@ -132,7 +135,7 @@ static int vmemmap_pmd_range(pud_t *pud, unsigned long addr,
                int ret;

                ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK,
-                               walk->flags & VMEMMAP_SPLIT_NO_TLB_FLUSH);
+                               !(walk->flags & VMEMMAP_SPLIT_NO_TLB_FLUSH));
                if (ret)
                        return ret;

@@ -677,13 +680,13 @@ void hugetlb_vmemmap_optimize(const struct hstate *h,
struct page *head)
        free_vmemmap_page_list(&vmemmap_pages);
 }

-static void hugetlb_vmemmap_split(const struct hstate *h, struct page *head)
+static int hugetlb_vmemmap_split(const struct hstate *h, struct page *head)
 {
        unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
        unsigned long vmemmap_reuse;

        if (!vmemmap_should_optimize(h, head))
-               return;
+               return 0;

        vmemmap_end     = vmemmap_start + hugetlb_vmemmap_size(h);
        vmemmap_reuse   = vmemmap_start;
@@ -693,7 +696,7 @@ static void hugetlb_vmemmap_split(const struct hstate *h,
struct page *head)
         * Split PMDs on the vmemmap virtual address range [@vmemmap_start,
         * @vmemmap_end]
         */
-       vmemmap_remap_split(vmemmap_start, vmemmap_end, vmemmap_reuse);
+       return vmemmap_remap_split(vmemmap_start, vmemmap_end, vmemmap_reuse);
 }

 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head
*folio_list)
@@ -701,8 +704,18 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h,
struct list_head *folio_l
        struct folio *folio;
        LIST_HEAD(vmemmap_pages);

-       list_for_each_entry(folio, folio_list, lru)
-               hugetlb_vmemmap_split(h, &folio->page);
+       list_for_each_entry(folio, folio_list, lru) {
+               int ret = hugetlb_vmemmap_split(h, &folio->page);
+
+               /*
+                * Spliting the PMD requires allocating a page, thus lets fail
+                * early once we encounter the first OOM. No point in retrying
+                * as it can be dynamically done on remap with the memory
+                * we get back from the vmemmap deduplication.
+                */
+               if (ret == -ENOMEM)
+                       break;
+       }

        flush_tlb_all();

For patch 7, I only have commentary added derived from this earlier discussion
above:

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index d9c6f2cf698c..f6a1020a4b6a 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -40,6 +40,8 @@ struct vmemmap_remap_walk {

/* Skip the TLB flush when we split the PMD */
#define VMEMMAP_SPLIT_NO_TLB_FLUSH     BIT(0)
+/* Skip the TLB flush when we remap the PTE */
#define VMEMMAP_REMAP_NO_TLB_FLUSH     BIT(1)
        unsigned long           flags;
 };

@@ -721,19 +739,28 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h,
struct list_head *folio_l

        list_for_each_entry(folio, folio_list, lru) {
                int ret = __hugetlb_vmemmap_optimize(h, &folio->page,
                                               &vmemmap_pages,
                                               VMEMMAP_REMAP_NO_TLB_FLUSH);

                /*
                 * Pages to be freed may have been accumulated.  If we
                 * encounter an ENOMEM,  free what we have and try again.
+                * This can occur in the case that both spliting fails
+                * halfway and head page allocation also failed. In this
+                * case __hugetlb_vmemmap_optimize() would free memory
+                * allowing more vmemmap remaps to occur.
                 */
                if (ret == -ENOMEM && !list_empty(&vmemmap_pages)) {

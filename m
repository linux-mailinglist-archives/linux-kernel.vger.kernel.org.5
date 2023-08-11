Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4617795F7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbjHKRQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbjHKRQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:16:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2039030C1;
        Fri, 11 Aug 2023 10:16:53 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BDWkgR006004;
        Fri, 11 Aug 2023 17:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=nzRV14++otVndSwVB+1G/mr3lkF0WE/1BXi1lJrpkqg=;
 b=prmivchnhn6jyjq2irk5MHAYNpKpJZGj1zBE4sOTXcoGxT4qcL9qeIWmtsGFXpMaGQzy
 K+mkRkhsb5VY4CGeZ0//NWENI2lbT6JfdC9jUMJ4sdZ67glV2x/LmOa/1oD5S34kEfmq
 YY4PLJWuQgV0fXKm6qTFKZm76XxqR7PxoYKEmqp6UNhbdCb4enPKIp1SwDd6UPrYntsx
 Mzr9slSXKX4mQdjQIPFsbgmnlfy/UBr5c6p03YlCXRRtk/pNzgQnfPApIIDaHtIMpi2L
 YY2Kbfv7GFE2k2+0ZfFUd/1swmUYV72MWiNu7EN5CSTPIe6Ms+zkDklM1CrktVLN2B4/ fQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sd8y49hhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 17:16:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37BGUFHO011143;
        Fri, 11 Aug 2023 17:16:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvh2r9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 17:16:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9uHBwZk+3DSBiIG4TetUqe15JbApPoWSmDJQJtDksKZkEpqk4eGeSQ/+eHFhFvp1kiM0RFBJ4vVAHL18yYDtmJFvtff77rOo79iwmKvq/RnIpRACLfGuNDkoWQUZsHiBSrIUyegUO3BnLI469whKSal0fd5oJX8K49GxiKzf/QRum8Q/vjZbn5qALOPEdBKcYcHGw/rsu1LAHzlqHIDE8KTgOZkiZZhLDw/T1tOBdZceC5vEmR9OrLV1bmAN70yXjxypS2xoZKpxmqJHS2IEMXIAdMNMhpowPCaqLvj02O3krX84VuvsGBU/YNZNVwtB6lAYicLkIhyniw+noLbyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzRV14++otVndSwVB+1G/mr3lkF0WE/1BXi1lJrpkqg=;
 b=ECwcp70iQMj4epNUqDTf83Dtz4HqGijxFbbZYQu5PIRRfCS5kQbe79dwkbUiZEHJXJAwKnJbfQxkQSZdLaIW7xI/mwex5Tz2Y2gtYoHxHdtqZB9M+0RZjM/yCivQ/2NQFQeYkQWtxq5ucklq8mOsIwmwgP0pCZJCVx5K6T+Pf+an1QwESJtWSqOTbAOoZeHl8/zW2KMpxsGCnwmMylRGZToFzC4hks7o4n6Ho5OO25L2bB19C6cKmSzc2PubJo9e6mJqcJ2yunqz1IeTgmOJWjq3JDL2RStCJ72fQ4AJ8TOoqhPRG1yj6NyoskQTEUXVMjCLJVILiXQaihTlVJlF/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzRV14++otVndSwVB+1G/mr3lkF0WE/1BXi1lJrpkqg=;
 b=u4YC6bOuQXcWQSSuPg3Dl4yN9+DNrc8mzaXW9+IvtOv2BeMoRGOe4myZrO5lKikCtBAeibKEktQSzD0wdrajWcOBeoN6FWICyGK1SH+vnqYfD9EkPc1EolDINBxWNdoYArrXGFZNjCe5gfw04OJLjzAz+2tIbjgSqz0P9taF4kY=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by IA0PR10MB6867.namprd10.prod.outlook.com (2603:10b6:208:433::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 17:16:33 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57%4]) with mapi id 15.20.6678.020; Fri, 11 Aug 2023
 17:16:33 +0000
Message-ID: <f4b77f3c-86cd-e061-a110-2e8b47655f0b@oracle.com>
Date:   Fri, 11 Aug 2023 12:16:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: linux-next: build failure after merge of the mm tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sourabh Jain <sourabhjain@linux.ibm.com>
References: <20230808144020.538cdab8@canb.auug.org.au>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <20230808144020.538cdab8@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0073.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::14) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|IA0PR10MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f2282a8-a3e1-44e8-e739-08db9a8eb5ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3RELLTZfMtfIHzpgDYs2cHoKh+X7qJnzsarCm6xmx9qm523eEdRDAIndHUb16ZTKJw7Vxo9WGs2QCk6sj/QZMPX9bFoIZ9gqs+j4RyJMmfviVwniX441uLXFELb51kiyP1P45oWmtw8W1GkEAMcEq5VkPEfeP9GZvIatzMCA3G5xTibAzSsPrvKQnLxoM5flYoOz6jRLpknISgSqN51GbZ6h1c5j/Cn5+k4BMywtmoreSa92q1PM0ZRbGZJ5+oGBBhBlJ0QD/CS0GKU+z3MlQIl12mwSJuGJUtL+bfTcs0N1ZdJHF2zK1L3jlPQ5lvrCHvkXdvZmFl+YK8/vsRWTRQKecF70VqD96qRYQKAHn2dMRVu+xARX0nY/N7hj3a0Wf/pfN7yfo5ySPKI3mIcKirv3+Z64C19UYtFlZ8viFr7C5+BsTV9TKHFdFlRclwMFelyXO2slTNFem7MpG+nsGWXRYTzD/48MZ6imXCOJrDb04IMxgwaaO0vs6A8hrezrAOBvjtyoXryDRuxf/wE3jrEceiEaVBzyyD7nlfKgScVP+nkJ7mR7UKwji+RS4BmKjpC6o5zi+A1d8PQI5GokA4W7XgCvBEkyr/L3ukqy0pryb6g4sixieSnen8qER5N5BVDRo+oco43TrkfZeeNq2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(346002)(136003)(39860400002)(186006)(1800799006)(451199021)(4326008)(6512007)(31686004)(54906003)(478600001)(966005)(66946007)(66556008)(66476007)(110136005)(316002)(6486002)(5660300002)(6666004)(41300700001)(8936002)(6506007)(26005)(53546011)(86362001)(31696002)(8676002)(36756003)(2616005)(38100700002)(2906002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkVqeEZ1UDNpK2t4NW53YlJHWnpLSnZQUHQ4Q0w3WXc1Q0U1QWE3QUxZanEy?=
 =?utf-8?B?R0I2ZHNYdnBFa2tRWWRuaWNnbnZ6QTRwWU9rZjlMRSs2dVlRUk81WnU3eWls?=
 =?utf-8?B?d2RjbXI1YzVCNGd2LzU2Wmhuc3I0SDlmakpRU1ZjYXJXWDg0d1NKOVFQYThS?=
 =?utf-8?B?enkwNXhQUGordmZKUncwWUVnVHlTZVZWa3FlVzdud3VWUk5YQi8rVTdhbTlQ?=
 =?utf-8?B?RXQ0TW1UVDJERTRLdnYxNDljaWo5ekcwZjhxMnlUTEV3NTZaQXZvUkRYWTNE?=
 =?utf-8?B?dU95SURmZ1JrZGlrKzl6NHAyWHhHVFVaQ2s5R0Fxd2Y5bDg4WGs1TFJlbXBi?=
 =?utf-8?B?YmppTmUrWDlGL1VHN2lqSERXc1lGVFROdW1BRDBKVnJQOFpFbmpJV0JpRFdo?=
 =?utf-8?B?Z1ZwNUhJcE5EdFBQZE02WUd6YUdLaytDOGMxbVREdGdUbE5TUm1VZCtkUjIz?=
 =?utf-8?B?aEFwS1BieGV2Tk1kVElDVUpoWkJrZGFqU0lvTGV0RWJEdkNsYUxmUkZDZFhG?=
 =?utf-8?B?QUF1elArc1NMbmhKaEcwWCsyK2FxSFQ2YWY2VXI1UTJaMHhlczdKeGRiT0VK?=
 =?utf-8?B?WE55VTRHN2lWZ2lQVTRydmFyRnZ3UFNmdlZ5RHMvNGk3d1RNQms0ZjhtaVdN?=
 =?utf-8?B?WkYxT0gxMVNTM1RYOUtYdFU4RVVlMVl3Q1p3VGR1UnFqdUc2ditSSWlzNG4v?=
 =?utf-8?B?ZkZMN2Z5R2pmS3Y4MHlSQlZ5cFFPTFhWeDltWVBsWVdUWmw3b1l0bHo0c3VV?=
 =?utf-8?B?ZHlGdUwrVm9HMTBEVWp1RmlCVGsvMlh0N2lZQnUrVjk4K2pwc3BDa3c4THBQ?=
 =?utf-8?B?bVJPSHI3SzJxVkpuUHIycGxXckpVcndrM1BTMFFKeU5nb3V2a29YdE1LR1B4?=
 =?utf-8?B?K0xzK2dIKzRCRWVlVmx3R3B4Smo4Zk9XNEtkZmM5RjBYYzg3MStYSnhLTTFj?=
 =?utf-8?B?ZFQ3OC9rRTVPS3FJV0xZMHV1WDh6ZFA4bEw2dE1mU09QRis5Z0d4dHRWeTVs?=
 =?utf-8?B?Mlg2OWFLR3BFRVBJbGhabGllNTBCamZid0NnS1h6Y2tIcDJmOVluY3BTL2dN?=
 =?utf-8?B?OXZKWk5Md3Y5di83SXpNd0FDQ2pTeW9jMFROYXZkQTNBekdIbEg2a3Vpa0t1?=
 =?utf-8?B?TFBwdUdOU2dsU3dwTjhxeU9XZCtTeTVmRS8vOEkwSmZIa3kxTERDUWVxQld0?=
 =?utf-8?B?TjBML3c2S24rZzM1N1BudDAwMGtDVG45VTAxc3lDK204WGlEZmNWb1U2YnVD?=
 =?utf-8?B?cDYrSjQzdVA3aWV6NWV3bU0wSUJnQW5jOHBNSlNKaTljM1pLNVRyamJ0SDMw?=
 =?utf-8?B?WXFXUHJuR243Tld3bS9HWFRkVUlrdEQvTzdQQmQ5S2hGS2ZqQzhhb1kzOTln?=
 =?utf-8?B?M1BGaTBsL1I3dUtLcEhIbGthaWtyR0o5d0FGdFY1aXY5OUdIUHBTNTZtQ0Mv?=
 =?utf-8?B?S3VpM2VNa2NyN3N6MmdOQ0kyZ1REeGdzRGFkeVd3TGE3eWdTSEZmNElSMHY0?=
 =?utf-8?B?L1Vpc2NMZlUyNUFGS1hmOTdVS3FWOUFLb2lCT21HZHZqQzF5NHpkNFpxTncv?=
 =?utf-8?B?QVpab0NBUE5yelVGcW5RS0tsMlV2UmR6RytTek5uSnNhQWFubzExSzM5R1dR?=
 =?utf-8?B?OGdhaWFYWW9aUTVHeXZsd3FjZzE4cVJkRG9RZjlmQlMvQUp5djFoSTJsbGFs?=
 =?utf-8?B?TnJWMVBKQ1IxWmFNdWtMQWtlNkMwa21pdDcwNC9hbXJGN0QydmlaV29DSFF3?=
 =?utf-8?B?YmpKcXNUQTA0K2NWZ1B2R1ZEaGoybTVnT2M4aVlUazZmcGVMUDdSVXhPOEdh?=
 =?utf-8?B?djNHTXJVQm9iNHN6OHRyU3lQTmJFbGc0aDdXbFJhdXJidlhWc0hBU1RjaTkr?=
 =?utf-8?B?Y0VRSjJ2RkxLSVljUTVHdHQ2NnA2bmFURmJodURXODF4MjEvbmRKVFJmanJ2?=
 =?utf-8?B?L0dTOUxHNjVVSStJQzBMaUJNbzlaVkNsSUd2T1hnSXJxSzFEU0h2RG9wbjgr?=
 =?utf-8?B?bk9kUnpkT2hwTEI1RlNHVGpYNU1ZV1FjOGwvNzZ6aCs5eXNaMGdGTzBaUWt6?=
 =?utf-8?B?dHdtdzNTTTJldWlDNHZJR3l6VHZ3VG0xeXdObXh3Ty9kbHc5YlVKNW5aR1BM?=
 =?utf-8?B?cStsTG55RXpEQWVlcFVBUHZla1kxRUp3WG9CUWMrakdlR3VhTnZEblJXR1Jx?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HCqI+hT6aMZOZpjIH6RM4X1DweZExz7vYZpFaJbaDjm+xe9S/o26wGNyHdASK4GqyVthaKcxlLCXUMcYZ/BXXp8nOaKOFp+iX0uddX+8avbYoqMolRBXyj4JU0DtmNxyhADuEOJeZgOBV+J1ROYbxrjNOtcpndDfZmafiHp7hlgrn/zhzIeurGYYuXnrfCIS7kP6Upb9Pzh8Sl+PKfl28lVeU5UAtxVM13juS54wwxCVCCvLj6Ne9d+DtoZo215OI1Z5Yl8di5NoEPYagPorCiXZujKDoU6VbjLXpNEcNKon3P6bmLHfw1DHPwGkTHWikwUynuZeITDA0IImp7M9yCB4hMMzrt3xO15R1owGfILxkgT6VrOrarxg/GcxBGUaH0RgPPUrp6A2ldVpoBWYWXH8AARQiESiWgD9JWmcxaYWWCQa/NlooQVaYXF1e77ZLkiBUWkionDOhAI4VvbWZ+SY5tPQ33iQxdZZ1s8ktfnSuWSbC9jebSXiE5yaf+h5VLxYVHkQ3mOPUOYg/oF/bzo+1lmZUUOy/HAmbxS1cla/OGjpLNlhySu3OJyl0pTEWBIAIU2GFgbgIuihiE5bMDCjEUdwqUk2aj66Ixe3fY8ehZsyKP2Tig6nqdwGxliqKE8MLBTu5uUKcTVIr9npE8Dtqc9dBolU/M0OTaiZ4cnJA2BNZB6XUpSBjhowwy5Yh20AO3nd9nhWkhyqIDU2FPcZfevw0+TGIWKFnUgClSTP8SpcQWkYuzrFs7qt2RElSWTecUp0OkLKkyHxdd4QRonYKwHDWV1pqU+hGY/6squON04F1vk1vlAruq7Ri4VDZjK24uQ7ZGIrrRIe/1Y8y8bHKiTI8UHlvRFwic67EHSx8tt4QCSlU7xXILqAxz3mUN9ipUhMoxizQaUFq737UA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2282a8-a3e1-44e8-e739-08db9a8eb5ce
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 17:16:33.2642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7pTAlFPk8v/W5l/wDJXyioCBLI+f3tgWoybzHZqeRHiiLkwpIVhXyoh7VqNSeqADJhLVaRZGZN84qzwO+dX05wzVTY1RglFK7Gr7rOTKjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6867
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_09,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110158
X-Proofpoint-GUID: ftGctVePsWEga3YNtGX759RU3HwLg3to
X-Proofpoint-ORIG-GUID: ftGctVePsWEga3YNtGX759RU3HwLg3to
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The build problem has been reproduced and solved in v27. Specifically the builds that fail are 
because only PROC_KCORE has been set, which only enables CRASH_CORE by itself. I had to move a few 
items to obtain the needed visibility.

"[PATCH v27 0/8] crash: Kernel handling of CPU and memory hot un/plug"
https://lore.kernel.org/lkml/20230811170642.6696-1-eric.devolder@oracle.com/

In addition, I've spot tested/built a few other architectures and do not encounter build errors.

Thanks!
eric

On 8/7/23 23:40, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mm tree, today's linux-next build (powerpc
> ppc44x_defconfig) failed like this:
> 
> In file included from kernel/crash_core.c:23:
> kernel/kexec_internal.h:11:54: warning: 'struct kexec_segment' declared inside parameter list will not be visible outside of this definition or declaration
>     11 | int kimage_load_segment(struct kimage *image, struct kexec_segment *segment);
>        |                                                      ^~~~~~~~~~~~~
> kernel/crash_core.c:321:40: warning: 'struct crash_mem' declared inside parameter list will not be visible outside of this definition or declaration
>    321 | int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
>        |                                        ^~~~~~~~~
> kernel/crash_core.c: In function 'crash_prepare_elf64_headers':
> kernel/crash_core.c:334:23: error: invalid use of undefined type 'struct crash_mem'
>    334 |         nr_phdr += mem->nr_ranges;
>        |                       ^~
> In file included from include/vdso/const.h:5,
>                   from include/linux/const.h:4,
>                   from include/linux/bits.h:5,
>                   from include/linux/ratelimit_types.h:5,
>                   from include/linux/printk.h:9,
>                   from include/asm-generic/bug.h:22,
>                   from arch/powerpc/include/asm/bug.h:116,
>                   from include/linux/bug.h:5,
>                   from arch/powerpc/include/asm/cmpxchg.h:8,
>                   from arch/powerpc/include/asm/atomic.h:11,
>                   from include/linux/atomic.h:7,
>                   from include/linux/mm_types_task.h:13,
>                   from include/linux/mm_types.h:5,
>                   from include/linux/buildid.h:5,
>                   from kernel/crash_core.c:7:
> kernel/crash_core.c:346:32: error: 'ELF_CORE_HEADER_ALIGN' undeclared (first use in this function)
>    346 |         elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
>        |                                ^~~~~~~~~~~~~~~~~~~~~
> include/uapi/linux/const.h:32:50: note: in definition of macro '__ALIGN_KERNEL_MASK'
>     32 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
>        |                                                  ^~~~
> include/linux/align.h:8:33: note: in expansion of macro '__ALIGN_KERNEL'
>      8 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
>        |                                 ^~~~~~~~~~~~~~
> kernel/crash_core.c:346:18: note: in expansion of macro 'ALIGN'
>    346 |         elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
>        |                  ^~~~~
> kernel/crash_core.c:346:32: note: each undeclared identifier is reported only once for each function it appears in
>    346 |         elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
>        |                                ^~~~~~~~~~~~~~~~~~~~~
> include/uapi/linux/const.h:32:50: note: in definition of macro '__ALIGN_KERNEL_MASK'
>     32 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
>        |                                                  ^~~~
> include/linux/align.h:8:33: note: in expansion of macro '__ALIGN_KERNEL'
>      8 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
>        |                                 ^~~~~~~~~~~~~~
> kernel/crash_core.c:346:18: note: in expansion of macro 'ALIGN'
>    346 |         elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
>        |                  ^~~~~
> kernel/crash_core.c:396:28: error: invalid use of undefined type 'struct crash_mem'
>    396 |         for (i = 0; i < mem->nr_ranges; i++) {
>        |                            ^~
> kernel/crash_core.c:397:29: error: invalid use of undefined type 'struct crash_mem'
>    397 |                 mstart = mem->ranges[i].start;
>        |                             ^~
> kernel/crash_core.c:398:27: error: invalid use of undefined type 'struct crash_mem'
>    398 |                 mend = mem->ranges[i].end;
>        |                           ^~
> kernel/crash_core.c: At top level:
> kernel/crash_core.c:420:36: warning: 'struct crash_mem' declared inside parameter list will not be visible outside of this definition or declaration
>    420 | int crash_exclude_mem_range(struct crash_mem *mem,
>        |                                    ^~~~~~~~~
> kernel/crash_core.c: In function 'crash_exclude_mem_range':
> kernel/crash_core.c:427:28: error: invalid use of undefined type 'struct crash_mem'
>    427 |         for (i = 0; i < mem->nr_ranges; i++) {
>        |                            ^~
> kernel/crash_core.c:428:28: error: invalid use of undefined type 'struct crash_mem'
>    428 |                 start = mem->ranges[i].start;
>        |                            ^~
> kernel/crash_core.c:429:26: error: invalid use of undefined type 'struct crash_mem'
>    429 |                 end = mem->ranges[i].end;
>        |                          ^~
> kernel/crash_core.c:444:28: error: invalid use of undefined type 'struct crash_mem'
>    444 |                         mem->ranges[i].start = 0;
>        |                            ^~
> kernel/crash_core.c:445:28: error: invalid use of undefined type 'struct crash_mem'
>    445 |                         mem->ranges[i].end = 0;
>        |                            ^~
> kernel/crash_core.c:446:36: error: invalid use of undefined type 'struct crash_mem'
>    446 |                         if (i < mem->nr_ranges - 1) {
>        |                                    ^~
> kernel/crash_core.c:448:52: error: invalid use of undefined type 'struct crash_mem'
>    448 |                                 for (j = i; j < mem->nr_ranges - 1; j++) {
>        |                                                    ^~
> kernel/crash_core.c:449:44: error: invalid use of undefined type 'struct crash_mem'
>    449 |                                         mem->ranges[j].start =
>        |                                            ^~
> kernel/crash_core.c:450:52: error: invalid use of undefined type 'struct crash_mem'
>    450 |                                                 mem->ranges[j+1].start;
>        |                                                    ^~
> kernel/crash_core.c:451:44: error: invalid use of undefined type 'struct crash_mem'
>    451 |                                         mem->ranges[j].end =
>        |                                            ^~
> kernel/crash_core.c:452:60: error: invalid use of undefined type 'struct crash_mem'
>    452 |                                                         mem->ranges[j+1].end;
>        |                                                            ^~
> kernel/crash_core.c:461:36: error: invalid use of undefined type 'struct crash_mem'
>    461 |                                 mem->nr_ranges--;
>        |                                    ^~
> kernel/crash_core.c:464:28: error: invalid use of undefined type 'struct crash_mem'
>    464 |                         mem->nr_ranges--;
>        |                            ^~
> kernel/crash_core.c:470:28: error: invalid use of undefined type 'struct crash_mem'
>    470 |                         mem->ranges[i].end = p_start - 1;
>        |                            ^~
> kernel/crash_core.c:474:28: error: invalid use of undefined type 'struct crash_mem'
>    474 |                         mem->ranges[i].end = p_start - 1;
>        |                            ^~
> kernel/crash_core.c:476:28: error: invalid use of undefined type 'struct crash_mem'
>    476 |                         mem->ranges[i].start = p_end + 1;
>        |                            ^~
> kernel/crash_core.c:485:21: error: invalid use of undefined type 'struct crash_mem'
>    485 |         if (i == mem->max_nr_ranges - 1)
>        |                     ^~
> kernel/crash_core.c:490:20: error: invalid use of undefined type 'struct crash_mem'
>    490 |         if (j < mem->nr_ranges) {
>        |                    ^~
> kernel/crash_core.c:492:29: error: invalid use of undefined type 'struct crash_mem'
>    492 |                 for (i = mem->nr_ranges - 1; i >= j; i--)
>        |                             ^~
> kernel/crash_core.c:493:28: error: invalid use of undefined type 'struct crash_mem'
>    493 |                         mem->ranges[i + 1] = mem->ranges[i];
>        |                            ^~
> kernel/crash_core.c:493:49: error: invalid use of undefined type 'struct crash_mem'
>    493 |                         mem->ranges[i + 1] = mem->ranges[i];
>        |                                                 ^~
> kernel/crash_core.c:496:12: error: invalid use of undefined type 'struct crash_mem'
>    496 |         mem->ranges[j].start = temp_range.start;
>        |            ^~
> kernel/crash_core.c:497:12: error: invalid use of undefined type 'struct crash_mem'
>    497 |         mem->ranges[j].end = temp_range.end;
>        |            ^~
> kernel/crash_core.c:498:12: error: invalid use of undefined type 'struct crash_mem'
>    498 |         mem->nr_ranges++;
>        |            ^~
> 
> I am not sure exactly which commit caused but I have revreted these
> for today:
> 
>    6a41fd4665e6 ("x86/crash: optimize CPU changes")
>    add3b7e011e9 ("crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()")
>    4a7eed40a7bc ("crash: hotplug support for kexec_load()")
>    8ce41bc6b147 ("x86/crash: add x86 crash hotplug support")
>    2b765af0c14f ("crash: memory and CPU hotplug sysfs attributes")
>    36d2b573329b ("kexec: exclude elfcorehdr from the segment digest")
>    ccfe0040500f ("crash: add generic infrastructure for crash hotplug support")
>    626775922a57 ("crash: move a few code bits to setup support of crash hotplug")
> 

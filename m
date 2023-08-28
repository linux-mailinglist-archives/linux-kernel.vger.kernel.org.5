Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F9978BBC3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 01:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbjH1Xqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 19:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbjH1Xqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 19:46:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522F8B0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 16:46:30 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SHxPBr020337;
        Mon, 28 Aug 2023 23:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=g7NPSqfSxf6i5xuNL+C6+8bCPotx5gmCy9RZmMTVeMI=;
 b=Ly0N9EfXfiXpCgk2URyqP183+z0qDJX3kZprigK7HoYRW0dRon3NVzDunX6B0YfkHAy4
 LTOck4LteJgs8zc5wQYE5Bi5YevypTWGTE5AULPScPTcfYCNSVqmjMvarWYv1Ow1luxy
 TZ2hVlojOScptZOd4i6af4KSGbtFfSIoI5dqzZBJkOtQ5qxf2Nd8QyiZAmKZEutXaNqR
 sM1DO4E0fakgx3l6Rhlom5j0tVHuFsYkRG6YXI9GLgYlFE27A5rew7zIO4foo7QNNckE
 +3XO+dLIJr9g237YTrsUuAm4TKOsg0oj0bbkcg3UXJLwZ53ltkklAZa+TtN9dPqfgsWh ug== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9gckt0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Aug 2023 23:46:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37SMdGbR033258;
        Mon, 28 Aug 2023 23:46:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6dmv91y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Aug 2023 23:46:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlFhY+hMl5cH0GF7EC4LDrGoSLWQ3coM2K8OOzR9injWsXEjDDpAtO1b1k3E1qr5PJGChKCHmqu0cglq9iJF0NsdSM87dtvRY8HfQyaeU4JKE/VuWkyGrzRWt1HJte1EAfxBL9Ratwt9O+pyypm1BfGcZwveyTpIKVfOokDk3WnQJQBuXiNjNSYdQLUa0OOkUZE96nU934UzlwedMU8gTQSUTf+Ly1vexfOGtW1e4Fs9W2uKd0VD1IiKcq+/qN/Q/0D+P525Fdmi0dD14Ho+tUawOaXHxsL0bh2JdPTCJNIQQYv2ON9mCIbvfOH084+6zfTvGHRNuaqhYxFh3oobag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7NPSqfSxf6i5xuNL+C6+8bCPotx5gmCy9RZmMTVeMI=;
 b=N9usBX+JXOqYAzrDTR8pnW9x6/GV9YuOlDefTSKGKb+mDK4y0fZdYZg3afI0EGRwc2Xzurm8bxUxzo3f9IeGyQuZ4RGIFc+DfyOTPOjt9h+HvbVO+94g5ypgajNap9QtJ5e9rmpGNS7G1IdsfaebEcviO0zOSd1L7OWFQA9io/j+2aHwp+fstTKXOYoLQybu+9u/MyIczYRMDyAFo0S0T8MZaAYInXAN920lUfkxFOIoHoKQU8CGtK76fJiiAkhoaPFITWpxJCMvcKrSBcgzIJ49UFQcOogiSALLzoS91jtFB6blAZN9KybUtYg6XjzsvxJZxg/f+4nTCgB46cZUsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7NPSqfSxf6i5xuNL+C6+8bCPotx5gmCy9RZmMTVeMI=;
 b=Kls8ZRhic9MxBwdfETE/g8drcjgKVVzQmGGHeaMGjwcEViTOgI8j8DMdmH5acdpfamMFJz0yrqw+2/Fu92bjjl4MERruDQDr2L8qmIaIIPZsV2UNqdBPbAl10EytgvSg1MKgwM8X/cRCVsYotaH37bx1FH6/NGcN/ftxQxccBaI=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SN4PR10MB5558.namprd10.prod.outlook.com (2603:10b6:806:201::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Mon, 28 Aug
 2023 23:46:17 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::afcc:c8ba:7c2e:350b%6]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 23:46:17 +0000
Message-ID: <3364adfd-1eb7-8bce-41f9-bfe5473f1f2e@oracle.com>
Date:   Mon, 28 Aug 2023 16:46:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RFC 4/4] vhost-vdpa: introduce IOTLB_PERSIST backend
 feature bit
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>
Cc:     eperezma@redhat.com, gal@nvidia.com, linux-kernel@vger.kernel.org,
        mst@redhat.com, virtualization@lists.linux-foundation.org,
        xuanzhuo@linux.alibaba.com
References: <CACGkMEseKv8MzaF8uxVTjkaAm2xvei578g=rNVzogfPQRQPOhQ@mail.gmail.com>
 <1692063807-5018-1-git-send-email-si-wei.liu@oracle.com>
 <1692063807-5018-5-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEuCDN7U2ANYvRa1TuhH5iR5rb2cdHVixwE_C9zgP__9GQ@mail.gmail.com>
 <ea6ecd2b-5391-3820-d3fd-411b60a5a2ec@oracle.com>
 <CACGkMEvEpAsAA_kP=rgUfyeoq_Kj+rpZxEsxmPEZD5braxcT+Q@mail.gmail.com>
 <9f118fc9-4f6f-dd67-a291-be78152e47fd@oracle.com>
 <CACGkMEtNZnGw+O2PkZkCgOd+NiU3kw7asYsGH3EkuOHd=GvCnA@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEtNZnGw+O2PkZkCgOd+NiU3kw7asYsGH3EkuOHd=GvCnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR01CA0026.prod.exchangelabs.com (2603:10b6:805:b6::39)
 To MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SN4PR10MB5558:EE_
X-MS-Office365-Filtering-Correlation-Id: 04ba8f50-36a7-41da-799d-08dba820f8bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GtEe6gCCU/N9hKDnNXVpSTfBrzYJqRznSLVfWvZnfJlTPK2AVFfW3kW+HB9noP7/AYoJOaKj3sWO7gxSxWPK2MCrPxcUjkHp4jP83XqtKNcBZzehKeBxw0QuimQ03tzf19douqfyx8zld/Rlqfo63TybDvlDyAK+9zJt2BKwLTOgdcFSKJD5ydTzzZbIt7Ohw6sIF0HTtzkX7QoJBsE9fa2tEKwffOHiDD7TgEmchuOD34zYzvk+j++0lzpb51TCH2tWoFocU2xEkEdskhHjhNylhdrZ5eCk6TG1HAcqOUJMRS3x+wiQtSdLiANknGhMrqpMEwO6BQdmbN+iXh9zh80J6fuEBsQs0O81h9ZoIVZddm0RWbWzul33yGbF5Eu31ZSDafjP6Fk+DVFhME8z5BB1DVZLKolIGmw/G4UcRZXWVGslgnqRWbV2um0KbK2T6GMkhDL0LSbzFccpCM3mmUhWojwamsahFmRlsZoM9HRKSV+37sQ1LubS3Pb8KpoWmAi9fdgAGj5tlxAv3d+7+o8Dx2e7CpgzuuAnt/MOnQ8bNkpThZe+nCjbkFw403VR3JSxKsp2j00dN4Uzug25SKBbT1n5qfvQeisLLLoqvFRXOCKkaTuTBoyzitBgQFsslikd54zeDapdv1MAMx5hQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(396003)(346002)(186009)(451199024)(1800799009)(6666004)(6512007)(6506007)(6486002)(36916002)(53546011)(478600001)(83380400001)(26005)(2906002)(2616005)(316002)(6916009)(66476007)(66946007)(66556008)(41300700001)(8936002)(5660300002)(4326008)(8676002)(36756003)(38100700002)(86362001)(31696002)(31686004)(66899024)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU9TcllDSVVNRHRjdUV6ejBjUlhkWTFuVXpHaGlnbGp2RW5SaTRjSFpoTElX?=
 =?utf-8?B?eXlubmFBRmx5MUdVdlMxTGZkS3NicGhxYWRuRUZZWWt3T0Q3WGlqS2hucDZT?=
 =?utf-8?B?S215ZHNIUjZsK1c3MEIreGMwdXJ6VTQyWXBMYTRJR1h5MWEzTUpRSXJOa0cz?=
 =?utf-8?B?V1p0Y0EvdTRiSWpFT3pRd3R0bTNaVEJDdzVsYXRXUXk1Y3dFNEdZUHhxWDl1?=
 =?utf-8?B?T0hkeVA2TlBOQW12bnpibVFLczRvUjdDOHEyMmw5QWpuY1R3VHBEWnRFMjl0?=
 =?utf-8?B?eS8rNURNNFBJMVNZYko4Uk5GbnNpRlNBYWRwV2ozdkVGVlBOb1N4NEwwT21i?=
 =?utf-8?B?REpvZGZPdTVsc0ZRaURSTk5oZW9TRjRsdDBVQmR0ZnBMUE5tTnZwTzRmNXh5?=
 =?utf-8?B?NTRiRWR4a1NmM2JNWkZmZUtNMmRWZEVsbFpFRnNSbEhMd2VHRWFlaU5lK2g2?=
 =?utf-8?B?MTJXWU1HUWhJZmh2a09FcURGeVJvVHRTeDRLZCt6MjBPZlJkSVhaMURjTEt4?=
 =?utf-8?B?aHNjSG9PbkJXSzA2ZVNuWm8xQmNtVkh3OG4wdlhtb1k3TjVrajEzZWZzd1dP?=
 =?utf-8?B?WEhGdWZvMTlMOEpoQ2tUODdIajFSVDQzWXNTQUtXbHAwQldiVVZGZ2ZrcldP?=
 =?utf-8?B?cTgwdzFZK05NbGNrb1gzMGFXTFp0dzd4dEdoV29JcWRsRXVmK25pMWJzdnln?=
 =?utf-8?B?aWwwVmxIbVVnbURZSnFHbmdIdDM3Zk1xZjlPRVVpeHk1eFV6RjVaY3JNUVF0?=
 =?utf-8?B?VnlJWlJMK283YXdwSHJhdi93MHlFTDYrOFU0d0l1bVJZWnEramZxMkU4WGhL?=
 =?utf-8?B?NG9wVWhSTEMyMWVDR2wwbEJBblArZ3AvSFp1SHJRYU5hK0Voenp2SXMrVSt4?=
 =?utf-8?B?REFBYVM0aHZEOENqM1NxZ1RXellCdm43RCt5YXVONUd6QU9WaFdqYlk4RXdj?=
 =?utf-8?B?dFVkaHBMYnl6OHNpKzBTcnAwSlc2QnlzaXd3VUd6WjZlQ3N0ZkM4eG91QXlh?=
 =?utf-8?B?VVZsMDkyaVc4WThDUzV0QkV6bEVtaXhOOHNhWEwzelJVY2xnUVhuS1pWV0lZ?=
 =?utf-8?B?UDVEc2NCUTM5R0EwSGZrNENLVUZxdkNHQS9iTFhZbDhxYUZKYXBreDZ6dVBN?=
 =?utf-8?B?Z01zN0Qwa0ZIcEZtOTFoYkNDNUozZVo2ZmtBQ2ZwR2RDK1E4ZGwvTDEra1RL?=
 =?utf-8?B?U0V0K1hHNHFYNkpVMEJHc1RmVCs1VjFTUkw2bXc0c0Q0NnFqM3dUbm5hSW9W?=
 =?utf-8?B?aUpIQUw0OVY2alVaZTNTSUJFMlNPMVhiME5LalBHWHNCekE5aVRBbzN1a28z?=
 =?utf-8?B?cktESVlxSHZXOURPS2pObHlkZlN6eXNXV0FSVWh0c3JsekMxaGwxekRFNmRN?=
 =?utf-8?B?VDVLRkdiZ09KTlcwWHQxSmc3R1VEZi9Rdmx4MTAxVHBsdmJDMERCeVJPamlO?=
 =?utf-8?B?V1hOamt4T0J1dWhscDBoMWs3c1lRaTZPdXB2c1JMVHM3Q3o3dXAwREVKWTJx?=
 =?utf-8?B?dGxGZWNPN2piVWlkQmp5cVcwZWhydEdXZkNqeTRYR3Yxa252QzB3S1ZTSHBt?=
 =?utf-8?B?ZFBLcytrbkcwdjhCZkdxTkdYZzdhalV2RWRkT2ZEdFBuaU5CUU53dmtaeWYz?=
 =?utf-8?B?Y1Y5TnNDeW4wM0c5TkNpUzhwUGwvdWVNVWZkeFE2Njd1bnh4VnF6NlJsenlY?=
 =?utf-8?B?N3NMU1dVeTNQTHE1eWo2cnN1ajRnaGNHcTVZcURqQ0VDckI2ZC8zc2l4Nmlj?=
 =?utf-8?B?dkpqU2ZWa1VnOWdvMGhzUUlMSkhyY2s5c05RVUQ4RlJjRXdjTU9uZGUxTnBo?=
 =?utf-8?B?NHZKNzFEQmlYYytQL1hBQTZyczNpekQ1N1p5eWNFdkxIY3JOMzZpZ2c4a25T?=
 =?utf-8?B?KzhJbXU1OWtyMFFUNDNhdXZSQ2tJVlc0cElGRUxxSjhrQXkrZk1HQzQ3Vmph?=
 =?utf-8?B?SXcvUDZhZ1lIaXcrRnNmb3JQVjZaa1VTdm1BdzRMU3hlQlpacVFPZTFmZ1FC?=
 =?utf-8?B?eVFuN2dQQ0sydGhoK1IxaUZLcWhlbnU5T2pGbTdTY1ZoTy8wUGVLK0ZPNlJq?=
 =?utf-8?B?YTJxY01KUkdNR1RkemJQUWg2czIyZE13VklkejlRdE9KYi9EOXlRU1NmTkwv?=
 =?utf-8?Q?k8yuw9yMNFTQHK9G3BCc68E9E?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RHcxMVM1a2lDNE9iUmFMdUFLSW9WbkhxOTFzd2tQbFhuR3d6UzNSeERCZ05s?=
 =?utf-8?B?Z3B4dFNET29CQzBRQ0duMFlCUlNPWVdhSHVWcUtnK2l0YW5JSDh1WVNoVjl2?=
 =?utf-8?B?WGt5dDBqbzlacllGMlJlb1NaVmQ2TWxQdWZxMGk1WHAxTmJiT1A5TGI5RE94?=
 =?utf-8?B?NEs4UEJha1dMZnp4SDUxUWlCUFhtQmc0WkJEaWh1eEd2Y002MHk2L214Z3E0?=
 =?utf-8?B?bEFzUXRUU0lNUkVXMHpNS2hQeXFZWTQvd0FDL0QrSEZETjNwbGM2YTU4czhW?=
 =?utf-8?B?RGI3bmVOb295N0YxUm5kYlpKVDcvRWExSVBQczRmOHBxNFpxcVNIYlRVMmhu?=
 =?utf-8?B?cFBXazlZNngxalhTMjEraERGSlBtQ0k0a1ZjaDBkQXBWeVo0bzhyNHk3YmFC?=
 =?utf-8?B?RXRMSkVIc3RLOXJTL2dBRFh0RmhjdE1RU2s1dzk3dTI4OWVOWUR1QzlwMHdn?=
 =?utf-8?B?WWJJZkhiLzVPMEgwVThNNUI1RkF4Y20rV25zcEUvekM5RkduWlp6U2l1ck5n?=
 =?utf-8?B?bWFBcmp3UWtPK05pRHU2UHFSbFV2MWR1YjZTSWY4d3hWVHo4TERlVnVZSHRl?=
 =?utf-8?B?NUhZdFlQbHVwMFovTlR6aXlnZ1ZBdTJCYVhRZ1N1YlcxeGtYaUhTeldXUGxm?=
 =?utf-8?B?RjlZTnRDSWRDalNJVmtRanYvSEhWZWU5RnoycExVdmt6OFA0a1luUi9OUkU4?=
 =?utf-8?B?MXZNdjgxb090SEZCOHFBL09nVnlpaURuZGpyd1dmU2NQTnhjRFdRdjNqRURS?=
 =?utf-8?B?MnBqc2IyWWlNWWZJejZ6RzU2NXlpdTBPaGRVS2VzeUNhTm9WZzliUHI1czlO?=
 =?utf-8?B?VDBjazArUUFtaU1EQU95RGFOUFh5SVBWSkYwb0RoY0JRTmFpVWRnWVh3bnNs?=
 =?utf-8?B?eWtFRHlUMm1UYUxqS0UvdDN5UmF5N254Zm14d0ZSQnVnSlJ3RzZQNjdxaFRH?=
 =?utf-8?B?aDRUeUMrTmtrWmlxUG5jbkhuenVyd2JsaHdzWmluaFN6R3RHVmFpTHlyTE9h?=
 =?utf-8?B?bG90UVk0VGhQM0ZIZnNJdElYRVV5c2tNWEF3aC90VDZ2c0lJRkJSNmNEcGxZ?=
 =?utf-8?B?MGtJRzdMY2MzSjI0bFE5NUZSdzRjZUJUN2xJTUdZbzFhWXpNRGl5U2NRdnR4?=
 =?utf-8?B?L2EyaDlNZTJ6N3BzY2JPREh2UVIveEQ0MnRRdnlyM1hsc2pESkdtRU1aVUd0?=
 =?utf-8?B?V3Nwc1d3WDlobEpKMVlEVTNVVGZjYndkOTA4S2xvbE1BRlRhbzRBWVdKalV6?=
 =?utf-8?Q?XfHgMVw6KT+K7qQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ba8f50-36a7-41da-799d-08dba820f8bb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 23:46:17.0710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8R4gcOjgTaujaRioNWkviuKVpEQgFCQ9/LE6DlZsBL0mT16HefyLMlfL9W4morjU8EBE33DGtySEm4XbOOeQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5558
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_18,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280203
X-Proofpoint-ORIG-GUID: y8MkRWsUQhmZo97ODn3DOka2cp-MVmVf
X-Proofpoint-GUID: y8MkRWsUQhmZo97ODn3DOka2cp-MVmVf
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/2023 1:54 AM, Jason Wang wrote:
> On Thu, Aug 17, 2023 at 7:44 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>> On 8/15/2023 6:48 PM, Jason Wang wrote:
>>> On Wed, Aug 16, 2023 at 6:31 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>
>>>> On 8/14/2023 7:25 PM, Jason Wang wrote:
>>>>> On Tue, Aug 15, 2023 at 9:45 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>>>>> ---
>>>>>>     drivers/vhost/vdpa.c             | 16 +++++++++++++++-
>>>>>>     include/uapi/linux/vhost_types.h |  2 ++
>>>>>>     2 files changed, 17 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>>>>>> index 62b0a01..75092a7 100644
>>>>>> --- a/drivers/vhost/vdpa.c
>>>>>> +++ b/drivers/vhost/vdpa.c
>>>>>> @@ -406,6 +406,14 @@ static bool vhost_vdpa_can_resume(const struct vhost_vdpa *v)
>>>>>>            return ops->resume;
>>>>>>     }
>>>>>>
>>>>>> +static bool vhost_vdpa_has_persistent_map(const struct vhost_vdpa *v)
>>>>>> +{
>>>>>> +       struct vdpa_device *vdpa = v->vdpa;
>>>>>> +       const struct vdpa_config_ops *ops = vdpa->config;
>>>>>> +
>>>>>> +       return (!ops->set_map && !ops->dma_map) || ops->reset_map;
>>>>> So this means the IOTLB/IOMMU mappings have already been decoupled
>>>>> from the vdpa reset.
>>>> Not in the sense of API, it' been coupled since day one from the
>>>> implementations of every on-chip IOMMU parent driver, namely mlx5_vdpa
>>>> and vdpa_sim. Because of that, later on the (improper) support for
>>>> virtio-vdpa, from commit 6f5312f80183 ("vdpa/mlx5: Add support for
>>>> running with virtio_vdpa") and 6c3d329e6486 ("vdpa_sim: get rid of DMA
>>>> ops") misused the .reset() op to realize 1:1 mapping, rendering strong
>>>> coupling between device reset and reset of iotlb mappings. This series
>>>> try to rectify that implementation deficiency, while keep userspace
>>>> continuing to work with older kernel behavior.
>>>>
>>>>>     So it should have been noticed by the userspace.
>>>> Yes, userspace had noticed this no-chip IOMMU discrepancy since day one
>>>> I suppose. Unfortunately there's already code in userspace with this
>>>> assumption in mind that proactively tears down and sets up iotlb mapping
>>>> around vdpa device reset...
>>>>> I guess we can just fix the simulator and mlx5 then we are fine?
>>>> Only IF we don't care about running new QEMU on older kernels with
>>>> flawed on-chip iommu behavior around reset. But that's a big IF...
>>> So what I meant is:
>>>
>>> Userspace doesn't know whether the vendor specific mappings (set_map)
>>> are required or not. And in the implementation of vhost_vdpa, if
>>> platform IOMMU is used, the mappings are decoupled from the reset. So
>>> if the Qemu works with parents with platform IOMMU it means Qemu can
>>> work if we just decouple vendor specific mappings from the parents
>>> that uses set_map.
>> I was aware of this, and if you may notice I don't even offer a way
>> backward to retain/emulate the flawed vhost-iotlb reset behavior for
>> older userspace - I consider it more of a bug in .set_map driver
>> implementation of its own rather than what the vhost-vdpa iotlb
>> abstraction wishes to expose to userspace in the first place.
> That's my understanding as well.
>
>> If you ever look into QEMU's vhost_vdpa_reset_status() function, you may
>> see memory_listener_unregister() will be called to evict all of the
>> existing iotlb mappings right after vhost_vdpa_reset_device() across
>> device reset, and later on at vhost_vdpa_dev_start(),
>> memory_listener_register() will set up all iotlb mappings again. In an
>> ideal world without this on-chip iommu deficiency QEMU should not have
>> to behave this way - this is what I mentioned earlier that userspace had
>> already noticed the discrepancy and it has to "proactively tear down and
>> set up iotlb mapping around vdpa device reset". Apparently from
>> functionality perspective this trick works completely fine with platform
>> IOMMU, however, it's sub-optimal in the performance perspective.
> Right.
>
>> We can't simply fix QEMU by moving this memory_listener_unregister()
>> call out of the reset path unconditionally, as we don't want to break
>> the already-functioning older kernel even though it's suboptimal in
>> performance.
> I'm not sure how things can be broken in this case?
Things won't be broken if we don't care about performance, for example 
reboot a large memory VM (translated to device reset internally) will 
freeze the guest and introduce extra reboot delay unnecessarily. If we 
want to fix the performance by remove memory_listener_unregister() 
unconditionally and we don't have such a flag to distinguish, we will 
break network connectivity entirely after reset - as all mappings are 
purged during reset on older parent driver.

>   Or why it is specific to parent with set_map.
As if without the .reset_map op and corresponding driver implementation 
(in correct way), there's no appropriate means for on-chip iommu parent 
driver to persist iotlb mappings across reset, isn't it? If the driver 
deliberately removes it from .reset, they don't support 1:1 DMA mapping 
for virtio-vdpa on the other hand, for instance.

>
>> Instead, to keep new QEMU continuing to work on top of the
>> existing or older kernels, QEMU has to check this IOTLB_PERSIST feature
>> flag to decide whether it is safe not to bother flushing and setting up
>> iotlb across reset. For the platform IOMMU case, vdpa parent driver
>> won't implement either the .set_map or .dma_map op, so it should be
>> covered in the vhost_vdpa_has_persistent_map() check I suppose.
> Just to make sure we are at the same page.
>
>  From the userspace point of view, the IOTLB persists and vhost-vDPA
> doesn't reset the IOTLB during vDPA reset. But we have are two levels
> of the coupling in other places:
>
> 1) Qemu level: memory listener is coupled with DRIVER_OK/reset
> 2) vDPA parent level: mlx5 build/destroy MR during DRIVER_OK/reset
>
> If I understand you correctly, since we've coupled in 1), Qemu can't
> be aware of whether the mapping is coupled with reset or not?
I suspect it had been already noticed by someone who wrote this QEMU 
code since day one, just that there's lack of a comment documenting it. 
Or any other reason why QEMU had to decouple it in the first place? It 
affects performance across the board for platform IOMMU vdpa providers 
as well.

>   If we
> simply decouple in 1), memory mappigns might be lost during vDPA rset.
I would tend to say 1) is an inadvertent artifact or side effect of 2), 
as I do not see memory listeners are used like this in other QEMU 
subsystems, e.g. vhost, vfio. Consider this coupling in 1) had been in 
the play since day one with neither advanced vDPA features like SVQ nor 
equivalent deficiency in platform IOMMU vdpa providers, it's suspicious 
that mlx5 build/destroy MR during reset was the curlprit then.

Regards,
-Siwei

>
> Thanks
>
>>
>> Thanks,
>> -Siwei
>>> Thanks
>>>
>>>> Regards,
>>>> -Siwei
>>>>> Thanks
>>>>>


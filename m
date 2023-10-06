Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7458E7BB07F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 05:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjJFDVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 23:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjJFDV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 23:21:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17ADD8
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 20:21:24 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3962NnXV013405;
        Fri, 6 Oct 2023 03:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-03-30;
 bh=0PD4vlgJAdKErK+1u+V7qL2tgRPWKs4djduFTe1PTBY=;
 b=Dp8hy4H0Uxc/AsSfNzfVZ/LHVoNMjnnbBHN3WPeOvO/iEwzr2LzNhNpl04Y2P9FDOtl9
 j8bvXj3PL/5eqG8JhiISSQQa2qm5PXsBBiNFfbRmtC90bkDyVYt1kiqsKae8uErHHKN9
 iGiq4OjJpH9b9X9FeiNrILbsGhrxlS2r6kBZUAfPjEu/VG46Cj9wXcVWzvcdnzZlLswd
 KOi8KcGs4G2QlqkmHohaCwBpj7ed55AORebuLa6MNOQUydD3U5ay/p4dmYOtGuOUeYcY
 dOuEvMm+eDkBEbaWNF3wWEMny+OTJOW0ZNHiuH9yh4VblhiOqm0tpM7IKcI38I2RqX9o JQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebqe31sb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 03:20:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3960jbRI002843;
        Fri, 6 Oct 2023 03:20:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea49ypm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Oct 2023 03:20:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9iHaSxvnNQvuVcTGaoaeDPnfQiJ+h3wH2aknVu0H0wxJaBmXtH1gwQ7AQfhzZLJiLjsMXNXzMjhJfQorllaeiMGPU8MaN2akQYHcy1KRlw0NegFoJdWHKypHlIVCxAK7VZuRDv+jPexR8sjz5YVfqUCv+KSPvdFgUq/3jHjxU38WkCL41N+7E8ID5NL7i1l2hZhzHMnAf+LYilzfojheVL0VdUl4tnvkuuJAUhrz49ng/W1rXj9Gn/kDcyZNPr/mzrdME2OfU4y6y8O3gCs3BYwCXr4QWeB3PegU9QnOP31OJNr/8JaqIAsjvYfCmBeDIEF2+wed/QST4HfcxgRoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PD4vlgJAdKErK+1u+V7qL2tgRPWKs4djduFTe1PTBY=;
 b=eF/jzjqh3tsru4z/Lw8OQRtpV4pAIcgPxE6onkngAM5J6DAfKetAz4L95jEMu/ZLCZ33KU9VnKdSLUguJ1gEobI05EBxM1JGnRR9H7vMRYCcNBSsGypsrooMxXtg2iYNERQTWQ5/t/y6PHgPlOqdUPakMtOGszCeQ43u2j6o0/ABjuf9L6biQV65nxFyoHZYIgv977ta1R1spRRDBoFw1VJ8R3ef7zXRZJ+hImLFh59oCq2ogs1BgKTSIfBs3GjOhghgfmyCr56lnBSXRSAWcFItLKyr8dFaeIZFmssI/m+GKxpIAOXIcszwPt3FNBBxzp1LMI38injQu2+dfcXLzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PD4vlgJAdKErK+1u+V7qL2tgRPWKs4djduFTe1PTBY=;
 b=Kr2Bd2iXCmOLgPlTUncNZp0rwcXsAwMHJWLHj1/5nvt3dyHSxQMWwx7P2uiT9rl8qOEJzzThbJemY0fTGPyrrjfCKNmvMbco8VES8VUYEPHMmIdipymtShuT0eJQvMoBgULAJSdhkArSpIifOqM0TfBO3I2p8FrWeWHHz2GpkHw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA1PR10MB6615.namprd10.prod.outlook.com (2603:10b6:806:2b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 03:20:19 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 03:20:19 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v7 0/8] Batch hugetlb vmemmap modification operations
Date:   Thu,  5 Oct 2023 20:20:02 -0700
Message-ID: <20231006032012.296473-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:303:b7::6) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA1PR10MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: afc09440-6ded-494c-74f2-08dbc61b2b14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NEaPOfZz7bKAk6NN2XxPhcrWswco+ThfsUjFhWKoP0oRylHbqEzQ2DzlOoYizKvddd6EsnbBLbBJ/7Q09Tqgq0SrjlNdonhn4tprd7BHvU3/mujX5MzZXDxAExiLYz8PUqjfXIP+qkXOgLAXlekCELSqpFAKWW0RLLc1h3BB8Qdxh2qqMt9uAZZ3q8n5Fb2j8PJ2vNaT4n9zMdtZAf8Ngb1uazvdRkV7Nh/7dFa93ayBPTi0Cc6QDjd/4+K2IJNO17+d9tMtdo05ZXFNBOyRm9vBrPULRKZZBman48y1wHUizGkLO3v+fFeq7auC6KssHcxp46JF7XDTBL1UK45hcXnoA1LTTLslobyboHXm3rVTfknn+FMJ9F9cjwm41Y9U6g8Y02Uv4LwUeVyokBLKyIBgrNkOrXVBezSkc+IDO9CXlcyu51jf9/CNMVhRITmnwPG0GwqAEQGkkznFBS+e42vqe86Fl678scpZsQOzfV3uKcV2QBCg2bkePas1M0FTvdNmXLyW3tIzt4hr2KDNLMEzSxlsHT/ks0oolHm5RSkVXGIgP+nH9FxNTe0Ksw6n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(316002)(54906003)(66946007)(66476007)(66556008)(66899024)(41300700001)(1076003)(2616005)(86362001)(6512007)(107886003)(6506007)(26005)(6666004)(36756003)(6486002)(478600001)(38100700002)(83380400001)(44832011)(7416002)(2906002)(4326008)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cERXMmh2YXlvMzVRdTVTYnpqVU9VV2ZFZzBJbURJNEt0WEQ5V1hXYkhKaVM4?=
 =?utf-8?B?VWlUb3UrWEcraFFVL2tYM0thdmJqTXBpWlZsUWsxZmVaRW41QmtkMmE3Y1NV?=
 =?utf-8?B?Q2RBTmFHaEZJN3pPOXdwYXJobDFUS3RIVVpuRHVnT3lseDkvdkpYMUpvWTUw?=
 =?utf-8?B?YXV3ZU53YUNsNVpvRmFJb0dZMVJVajJYbHQxenhpZnZ3d0p3elM4dVFnWWdo?=
 =?utf-8?B?VDd3MTFEL2x2WEVpSC9INjdqQ3ZnZTdrVVVYUDVvTDVxNDlIZEhDaHlFL0pI?=
 =?utf-8?B?WTVBdi9kYzF5c0JRWXVmc2xIejJ0SFBld1JJKzdmRXZaYXpUWmdoT2g0OG1j?=
 =?utf-8?B?dTNEM3h1dTRjd1FXVmE4SlBKdllrc2dVN0gwK0NueSszZWV1Zk4wV1JzKzNQ?=
 =?utf-8?B?Q0p3dWQ0L0hmS1V5ZkhnM0l4S2JMMU4vWG82WVVoTnlsc1d1QWFhMHhWOWM5?=
 =?utf-8?B?bjFTd3lmeHZEVVRucmRNK2xDMWQ3QWIwMkgyV2QrRGRoTmpOa21sand0MXZY?=
 =?utf-8?B?UXQ2Vm15eWYxTVhBQU9vTDJlenZ4MnUvZFhCSExHYnZheXJ3WmZ1Z21VZGNo?=
 =?utf-8?B?Z2FLS2hrL2VzOWlHNkVnZ2dMUk1TckVKaVJnWjZSMWkveTRiaGZpSWVtNlFJ?=
 =?utf-8?B?NlNlWUYvYmRoWGQ3cjVkTEc0OTY4SFQxSHFMU0VDY2V5dDBEQWZvM3VwZnZT?=
 =?utf-8?B?K1FocytaUEpCSzVRb1JYUXpJWnY5MmNCSy9lVWwyeHlldk5VdFU4cFBkNjhI?=
 =?utf-8?B?U01xRHR3WlVxSG9vcTF4M1BVN3FxY3RMY2d2bU9IYWE4aVhyTWNaTDliNjlB?=
 =?utf-8?B?MThNN1NWbUdwNEFrYzRSYU4ydlYxSkRpeGN5K2oxM0JKaUlicy9OVk40YVh5?=
 =?utf-8?B?bGgvZE9lU1JmbXFGMXVQMVcvdG1JWDJvSGdmbFZKSFg4a2JGZUd6T1pMdVFq?=
 =?utf-8?B?bnkvQWVPZVZDM3BFVDd4UGJSb3o0V1kvZHVIeFBHalFWb1RkZmdNdWtlczU0?=
 =?utf-8?B?d09LWUxUVFlTMUh1dHlGc01OREdiS3ptRlVQSVZlSHBtQysvZFBhazQvaE1R?=
 =?utf-8?B?dnBqOEtOWnRZa054djlwZStQemhMaXQxTi9PcnM4RnZEd0gxRXZ6TkVkditR?=
 =?utf-8?B?Q0xXQlVJb0E2akZZbzhydGNDbXZCYnNxZUxDSmcxQ3V0ZTFES3pDMUFZZFVo?=
 =?utf-8?B?cVRJMmFrenNlYVJsUWc1SS9FVUtndWxGdHQwYWdrWmJnNEZ6M0twZ1UxQith?=
 =?utf-8?B?VE1pVFBLZzhPVE1HbVRtVnZyUGZjbjlsM0V2VldSOGlKa08wNkpsdjVvcW1w?=
 =?utf-8?B?c0RnVGpGdXJIV3N0TE9lUm9OYWQzNkZVRVpUc2RzVHdab0hVVE5XaXBpc0xq?=
 =?utf-8?B?YnJpdG15VEVXaGZyaEQzN29pb0VtNWtRaER4OFB4U1pxUkZLRkU3Uis5ZkRK?=
 =?utf-8?B?OG5nQzVGU0JzK0FjeHVkZkllR2lieERxMHpqVytHRDM4N2dyaGZmS2NwSE95?=
 =?utf-8?B?SFRSZmcvTnRRVlF1eGdTUjRZSXFYU3Z3bVoyazQzSVMxQytqUjd3b0Nlb09N?=
 =?utf-8?B?Qnd5amFBRXVMcmdsQmI3L29UQ0lBUFB3S2hLUDBTKzRnTERIVkZ2N1o3VTli?=
 =?utf-8?B?Q2FNZTBGM0hoSFp1UmhhNHVWdFhrMFRJWTJnWXVIcVcrUnFxOUU1ME9GYzZo?=
 =?utf-8?B?K1ZzNTVtc01qWVlkRnVBYjlJZ2V4T1B3ZjNxV01aWTZsbUlhWUZqRlM1Z05l?=
 =?utf-8?B?eHJ1c1pRNXR4SW5GRkR6ZEl3L2hYUXBiTUhwcmZsMHNiNnJCQjNmWTJtWDUy?=
 =?utf-8?B?TjgwQnVzZ0huR1BYbi9QTGE0bUxpY2JLeXNrQWpDSFFSTzRBUzNsSUlJZkRJ?=
 =?utf-8?B?Zk5lekNwbDBUWE00ejlZNlhVV01RWjA1WW9KN3pzdzhORCtzTWlOTDJ2c01S?=
 =?utf-8?B?a2FqaFhKcVN0dExNK09pY01UQ0YvVW0rdUdNWUdRY1licjcvQ1dGWVdrc3lq?=
 =?utf-8?B?bkhHbURxRy8weE51TFRBUnB6c3R0QlFjQjBHQ2dHWkw2TFZ0R202YjJ6c3Bx?=
 =?utf-8?B?ZDBhWnpoN3gxU3Q1VGZxVEVMQUR2aGdTUHFxc2o4NUZGa0VQSjl4L0tkbTQ0?=
 =?utf-8?Q?UH8Y0MvgwLttFdwNSKxdI0A22?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?alJtdmNZdnVCK0hFUmZGdWFSSHNyK3NlZEU3cy9rd0JqUU1ReHd0NWpTVU1R?=
 =?utf-8?B?TmtDT1VQYlBXN1lsaGRDWjYxVVBJT2w4N3lldUcvVEJNcks1M25qVXduQzJh?=
 =?utf-8?B?Q0JmNllqK2FHMGdDUHBWalB3YVV6RHRsN1lDQ0FvMHQvYXVzNy9RalNVZzQ4?=
 =?utf-8?B?aUxzL1cxekYyUDZaSEd3Rm5IWFRGSG4xMWxvckJFUUpyUHRPV2s0ZnFhYVVY?=
 =?utf-8?B?ZnRNd0FYb1doRWN2ajdLM21QY09RVWk3dzE3MHliNHJrVUZ6RFpEdFMrdWJT?=
 =?utf-8?B?dENMSWxLSHJSSmRjeWllWjk1TzJSQWg2bFE5N2V4V1NGakVMS1RaWW5KeW54?=
 =?utf-8?B?bllCdVE4SmdJZnM4eG5URFNoOHBXU1k0bENMb0NLcVBYNy9URGU2bUlQY0xh?=
 =?utf-8?B?dkJqVGhBRC9raUJDWE5ZZURWUGsyS2dzWDRiZTVZOURMeHBKTHJ4ZHdOenAx?=
 =?utf-8?B?SVV0NzZEMVNRczNwbXhCS0JJYjBKNHFXcU1iblpTdCtydDI0Y1JaNU9FdnhV?=
 =?utf-8?B?M21jUUZVWUZHZUY4YUdLS2VKQVlMdTBMbER2RXVWTFdPSVJRNHQyYUZzMzQ1?=
 =?utf-8?B?TXFpSEJHKzl6ZkNMclZxM3BPcS9jYjJka01rVDdTMnE1cVlwZDVVdTBqanBh?=
 =?utf-8?B?NnVwTW1acmpVU3VtT0dHdG02d0xiSk5aWW1VeUpHNnFwT1JqL3NrQ3VFMmVk?=
 =?utf-8?B?RWx0b09EK3pPTFkxbUhmNUlaeWpabUU0aStZQjM2N3ZLbDh1TmdmMVU0U08v?=
 =?utf-8?B?WE1WUnNLemhwMTMwZUcwMWtTZm15TjBodEh4ZTBQVjhKbE1DWkNOWmFva0Qr?=
 =?utf-8?B?d3JPaXFyWHZFcTRMcDNUS3M0WFJCTVJIem5DaGwxcTAvZCs1d3VVVWNqWUp0?=
 =?utf-8?B?ZmxOYTNPSjdjTnRwTGJ3VHgwc2FoeE9ZdGcyVERqdWFXLzlEeStlKzRnMEZN?=
 =?utf-8?B?RXNwRlVkQzM4Mzl3QXFnY1NsYVBnRHRzaFZkQ1F1WXpBSUVMdGlzUytIQTJt?=
 =?utf-8?B?RG1LUGd0SDhpM1FIUXRmcCtCRjMvZDd3Vyt6dkF6cHY3MDVHTTNjR000U01s?=
 =?utf-8?B?TVBQNytpWkl0RHBCSWxDZDgvM24wNzlDVDd0aUJtM045MWwxV2JLZklPZENR?=
 =?utf-8?B?c0Nxd2c5LzljRDhRVXN0WS85dUdMQWlEejFoYWp2M0VaVW9QSVpFK2RiMFdV?=
 =?utf-8?B?SzJwbHVxYXdEVEtGR2RML296MVl3dzZOSCt0c2tKdWllbzYwSDQvek43Zk1q?=
 =?utf-8?B?VTZyVWM4VUdmSDNFclFrZFp6MXpyZUZQeVJucDZNWnNIRm9veDVBc2ZPMmlP?=
 =?utf-8?B?OVZuMlgycURCenpLVm5rd2NIVFJXVnpnakdPQkM4RnVVZk52RE1BNVFxZjBw?=
 =?utf-8?B?eG42RFp3eW55dDFSU3Qya2R4QVBPVlo5TlZyNktxT21RMlBJSEE1dXhVaWZE?=
 =?utf-8?B?S2hEN0RzNlhQV1QwOTM4YmVpWTFIMmxsT3FzcnZkVUZOQk55ZkhHdmVhSUxs?=
 =?utf-8?B?QnlzWVJXSlZxNENvV2NQSFZ4SDZOdHdxZmZpQWlnZ2kzZmhkUU82WEtkUmR5?=
 =?utf-8?B?UWduQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc09440-6ded-494c-74f2-08dbc61b2b14
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 03:20:19.3489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4nKYXT4LI64LkTgOhix9K/LmoyAv+csFLQmlImpdkuNymj+4WHfIfhJz/HHyd1Q6MEGCmMIHZGMN/whVKs9t+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6615
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_18,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310060024
X-Proofpoint-GUID: zo8A4dgky_ArOSntpFMnNDkKU6qPXpLf
X-Proofpoint-ORIG-GUID: zo8A4dgky_ArOSntpFMnNDkKU6qPXpLf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When hugetlb vmemmap optimization was introduced, the overhead of enabling
the option was measured as described in commit 426e5c429d16 [1].  The summary
states that allocating a hugetlb page should be ~2x slower with optimization
and freeing a hugetlb page should be ~2-3x slower.  Such overhead was deemed
an acceptable trade off for the memory savings obtained by freeing vmemmap
pages.

It was recently reported that the overhead associated with enabling vmemmap
optimization could be as high as 190x for hugetlb page allocations.
Yes, 190x!  Some actual numbers from other environments are:

Bare Metal 8 socket Intel(R) Xeon(R) CPU E7-8895
------------------------------------------------
Unmodified next-20230824, vm.hugetlb_optimize_vmemmap = 0
time echo 500000 > .../hugepages-2048kB/nr_hugepages
real    0m4.119s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m4.477s

Unmodified next-20230824, vm.hugetlb_optimize_vmemmap = 1
time echo 500000 > .../hugepages-2048kB/nr_hugepages
real    0m28.973s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m36.748s

VM with 252 vcpus on host with 2 socket AMD EPYC 7J13 Milan
-----------------------------------------------------------
Unmodified next-20230824, vm.hugetlb_optimize_vmemmap = 0
time echo 524288 > .../hugepages-2048kB/nr_hugepages
real    0m2.463s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m2.931s

Unmodified next-20230824, vm.hugetlb_optimize_vmemmap = 1
time echo 524288 > .../hugepages-2048kB/nr_hugepages
real    2m27.609s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    2m29.924s

In the VM environment, the slowdown of enabling hugetlb vmemmap optimization
resulted in allocation times being 61x slower.

A quick profile showed that the vast majority of this overhead was due to
TLB flushing.  Each time we modify the kernel pagetable we need to flush
the TLB.  For each hugetlb that is optimized, there could be potentially
two TLB flushes performed.  One for the vmemmap pages associated with the
hugetlb page, and potentially another one if the vmemmap pages are mapped
at the PMD level and must be split.  The TLB flushes required for the kernel
pagetable, result in a broadcast IPI with each CPU having to flush a range
of pages, or do a global flush if a threshold is exceeded.  So, the flush
time increases with the number of CPUs.  In addition, in virtual environments
the broadcast IPI can’t be accelerated by hypervisor hardware and leads to
traps that need to wakeup/IPI all vCPUs which is very expensive.  Because of
this the slowdown in virtual environments is even worse than bare metal as
the number of vCPUS/CPUs is increased.

The following series attempts to reduce amount of time spent in TLB flushing.
The idea is to batch the vmemmap modification operations for multiple hugetlb
pages.  Instead of doing one or two TLB flushes for each page, we do two TLB
flushes for each batch of pages.  One flush after splitting pages mapped at
the PMD level, and another after remapping vmemmap associated with all
hugetlb pages.  Results of such batching are as follows:

Bare Metal 8 socket Intel(R) Xeon(R) CPU E7-8895
------------------------------------------------
next-20230824 + Batching patches, vm.hugetlb_optimize_vmemmap = 0
time echo 500000 > .../hugepages-2048kB/nr_hugepages
real    0m4.719s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m4.245s

next-20230824 + Batching patches, vm.hugetlb_optimize_vmemmap = 1
time echo 500000 > .../hugepages-2048kB/nr_hugepages
real    0m7.267s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m13.199s

VM with 252 vcpus on host with 2 socket AMD EPYC 7J13 Milan
-----------------------------------------------------------
next-20230824 + Batching patches, vm.hugetlb_optimize_vmemmap = 0
time echo 524288 > .../hugepages-2048kB/nr_hugepages
real    0m2.715s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m3.186s

next-20230824 + Batching patches, vm.hugetlb_optimize_vmemmap = 1
time echo 524288 > .../hugepages-2048kB/nr_hugepages
real    0m4.799s
time echo 0 > .../hugepages-2048kB/nr_hugepages
real    0m5.273s

With batching, results are back in the 2-3x slowdown range.

This series is based on mm-unstable (October 5)

Changes v6 -> v7:
- Fixed hugetlb_vmemmap_restore_folios stub for the
  !CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP case
- Added Muchun RB for patches 4 and 8

Changes v5 -> v6:
- patch 4 in bulk_vmemmap_restore_error remove folio from list before
  calling add_hugetlb_folio.
- Added Muchun RB for patches 2 and 3

Changes v4 -> v5:
- patch 3 comment style updated, unnecessary INIT_LIST_HEAD
- patch 4 updated hugetlb_vmemmap_restore_folios to pass back number of
  restored folios in non-error case.  In addition, routine passes back
  list of folios with vmemmmap.  Naming more consistent.
- patch 5 remover over optimization and added Muchun RB
- patch 6 break and early return in ENOMEM case.  Updated comments.
  Added Muchun RB.
- patch 7 Updated comments about splitting failure.  Added Muchun RB.
- patch 8 Made comments consistent.

Changes v3 -> v4:
- Rebased on mm-unstable and dropped requisite patches.
- patch 2 updated to take bootmem vmemmap initialization into account
- patch 3 more changes for bootmem hugetlb pages.  added routine
  prep_and_add_bootmem_folios.
- patch 5 in hugetlb_vmemmap_optimize_folios on ENOMEM check for
  list_empty before freeing and retry.  This is more important in
  subsequent patch where we flush_tlb_all after ENOMEM.

Changes v2 -> v3:
- patch 5 was part of an earlier series that was not picked up.  It is
  included here as it helps with batching optimizations.
- patch 6 hugetlb_vmemmap_restore_folios is changed from type void to
  returning an error code as well as an additional output parameter providing
  the number folios for which vmemmap was actually restored.  The caller can
  then be more intelligent about processing the list.
- patch 9 eliminate local list in vmemmap_restore_pte.  The routine
  hugetlb_vmemmap_optimize_folios checks for ENOMEM and frees accumulated
  vmemmap pages while processing the list.
- patch 10 introduce flags field to struct vmemmap_remap_walk and
  VMEMMAP_SPLIT_NO_TLB_FLUSH for not flushing during pass to split PMDs.
- patch 11 rename flag VMEMMAP_REMAP_NO_TLB_FLUSH and pass in from callers.

Changes v1 -> v2:
- patch 5 now takes into account the requirement that only compound
  pages with hugetlb flag set can be passed to vmemmmap routines.  This
  involved separating the 'prep' of hugetlb pages even further.  The code
  dealing with bootmem allocations was also modified so that batching is
  possible.  Adding a 'batch' of hugetlb pages to their respective free
  lists is now done in one lock cycle.
- patch 7 added description of routine hugetlb_vmemmap_restore_folios
  (Muchun).
- patch 8 rename bulk_pages to vmemmap_pages and let caller be responsible
  for freeing (Muchun)
- patch 9 use 'walk->remap_pte' to determine if a split only operation
  is being performed (Muchun).  Removed unused variable and
  hugetlb_optimize_vmemmap_key (Muchun).
- Patch 10 pass 'flags variable' instead of bool to indicate behavior and
  allow for future expansion (Muchun).  Single flag VMEMMAP_NO_TLB_FLUSH.
  Provide detailed comment about the need to keep old and new vmemmap pages
  in sync (Muchun).
- Patch 11 pass flag variable as in patch 10 (Muchun).

Joao Martins (2):
  hugetlb: batch PMD split for bulk vmemmap dedup
  hugetlb: batch TLB flushes when freeing vmemmap

Mike Kravetz (6):
  hugetlb: optimize update_and_free_pages_bulk to avoid lock cycles
  hugetlb: restructure pool allocations
  hugetlb: perform vmemmap optimization on a list of pages
  hugetlb: perform vmemmap restoration on a list of pages
  hugetlb: batch freeing of vmemmap pages
  hugetlb: batch TLB flushes when restoring vmemmap

 mm/hugetlb.c         | 301 ++++++++++++++++++++++++++++++++++++-------
 mm/hugetlb_vmemmap.c | 273 +++++++++++++++++++++++++++++++++------
 mm/hugetlb_vmemmap.h |  16 +++
 3 files changed, 507 insertions(+), 83 deletions(-)

-- 
2.41.0


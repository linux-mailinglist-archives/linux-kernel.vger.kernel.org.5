Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59F1797C72
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjIGS6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbjIGS6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:58:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A936990
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:58:09 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387Ip4UL003967;
        Thu, 7 Sep 2023 18:57:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=zxbSauN/nKZ3bSPYK3gh8rRGAYC8ogcpyMftKup8zcU=;
 b=fQ9qxMAnmqRRjSg32gB1hgQs6U+jE2rOj8IpOP4ga+adp9SzJfxtMkVOdrlQyv+bKXAe
 p92pOfc0SLlykyKCHvh4xYXwxhWMquBd120GepTJ+CszzB2ws274dLu4PmyV1k1ctdVi
 TGR+BXtFloob0BjSDLjsK2wuhtiiO2KJ+VpbHJVvKu0oqhYyYnfGCQd2OifYWz4M7h2E
 8hQEHE/lbke00T7unT0P4bXvfdyf3auD8C7o9G+sxo6LxzJeXlvtywBj+OqJ+womsvEV
 rEXxv+qNDvtaZwWoQksurGtrSfw9V/07Wuszw/3T/DLiNo3rhj1b1iJB3ombq2mIwO1o /A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sym51g0ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 18:57:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 387HDV5R005097;
        Thu, 7 Sep 2023 18:57:17 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug8462c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 18:57:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EI2NejBGQ0ziINk3oWQ/Ltqksxgfo0ct+2hyq1a4BcdB30cSpP9XKRk7T0yT77+G4P0esUhd9qBYVtGYDhy8kG5rsBXI8TaianTHc3ED5sq436wqhZqZxxw5o9/BOakxmwtXwXfw+8iKeE3UpwdjuMbLum+ssJIPoM3HbKjGZZX4gM0Z8tzg3o/ocAYnH4Sjw3+tJRdAM/agTrKU1WV7yCuetP3G1U0pR5E2B5q+XPS65JGtqiX9kJCSbCpAjx+AdLC/mF9664881Nx0kvDrSUg0skZuCchZHy4j1IqZClnO4DiYr5oKc4JbrvBiXSuJh8ePmAQaCLjXVWzC16aAdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxbSauN/nKZ3bSPYK3gh8rRGAYC8ogcpyMftKup8zcU=;
 b=G+QQ07IH4jTqMTE4pKzMgCs6QNKXabPkbtUvZboRvA/+eTC54pTxSHRGl9sjKqtWk8SF/gM9vaLSmJnftUeeVqKgNuwbJhFv+vl6KYpgKFuhlphI/C+Xq6FD0E2uTvkv4gWc7al9vmNCNpkvEVTF1OoHBvwBCAOPn57kY22j/OckjGMYxGuwaKNBBcbWx2U4Wl7d524Qr/6aq0O0wPaB4/nt1bh+tby8Pb35QoxpQZ0jNz8ivJZO+GCvJg+74sMIxRyDcaoGAdVlh9cRyYRUtjrJYOtl6y1IG07n/FtDPSnZn4j+P2W8ZacClmH3gievvVldJbwFKOpiDJhAPUJuZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxbSauN/nKZ3bSPYK3gh8rRGAYC8ogcpyMftKup8zcU=;
 b=TRSSNq9dh57IZdEJ7MJN1hHIIy8yZp2x/qCYs5OyDtqDmkqiekjGTbtpagyAZng2N4SClWlKB5NxonGYn8ubKuFw/k7cKOCJuA/cgxxub5+d7y/mAMM6eJvlL0Wb0WEP/xKYQj7lJ3Chl0uSWBA6kmq7LzcrU+5c6ed5vT2vbqU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA3PR10MB7095.namprd10.prod.outlook.com (2603:10b6:806:31e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 18:57:14 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%4]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 18:57:14 +0000
Date:   Thu, 7 Sep 2023 11:57:10 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
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
Subject: Re: [PATCH v2 10/11] hugetlb: batch TLB flushes when freeing vmemmap
Message-ID: <20230907185710.GE3640@monkey>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
 <20230905214412.89152-11-mike.kravetz@oracle.com>
 <77060d35-a6d9-73e2-28a2-e736df00709a@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77060d35-a6d9-73e2-28a2-e736df00709a@linux.dev>
X-ClientProxiedBy: MW4PR03CA0110.namprd03.prod.outlook.com
 (2603:10b6:303:b7::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA3PR10MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: c49d4a4e-82b3-4dd0-b938-08dbafd43fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W1a9nmq4KUX3EHYagXro611MI21KsC8g4asBNJ+5usk7bn7coFnW32vaVR2rjHT+QwRDZT5+jXVv281+qFNtYJDFO+fUKRtVIzqUTq4c3NXW0Xdcq5Kd+DrV3wKues8EE/b5XhL2plMhCAt0EsaqNDirv7XwXGwUsJnztK2A0Kdp9ugQQRiUuMh/4gSXWVUE+wq1y1YRJn/CC/6GpT9GxRLAbDtaeooQFtTcjxcS62miGVH+koIETDVnU5gK703e/mHD2Y93ox6OG0IeE2vCq4xOTj4Kdzh784hARtiX4UfNmu5U+eWfi/YA+37SZBAWzzgUQK6J2GkScCUjbQc3sdagFCueOYsk3WW9UhrJ1Bbhuq6JeyIyM8nHxBB2xGWd1DoXSChfxMIF/tCXqgp2dntzyZHH6DdSm4nIJ+x9uVls+dQvcNmIKmBesREBZnnvBtbCABcn+00cZpvlAuEcdcJ2vQlcHuypYt+PA2jFVNNhQbXHsr2B+GGeGFqLwGP7tC7DL1FKlDMBS9QLUF2gbH83UDAIs0vKS70yOmDR8uF7nEK00cedg6gXX6tH4CFY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(366004)(396003)(136003)(376002)(186009)(1800799009)(451199024)(26005)(38100700002)(1076003)(53546011)(6486002)(6506007)(6512007)(9686003)(33716001)(83380400001)(7416002)(4326008)(478600001)(8676002)(8936002)(44832011)(66946007)(66556008)(5660300002)(66476007)(33656002)(316002)(86362001)(6916009)(54906003)(6666004)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0415bA4FhU5g01j8FCs+WHbyH3Oxx/UXpYQb3kFNGRyioMJ5sxhPM2h/rT+N?=
 =?us-ascii?Q?0DrfoloORMWQIUV/stvIidvSkJoBM12wafoiolr3N66CW0ip2OcwlLf1BgiU?=
 =?us-ascii?Q?suGnXk5t/RsfBrmnAH9ocyhpgy016QBEEng+c+Cbf/KPmCCfyH4pLPsH6jCf?=
 =?us-ascii?Q?IgE9nHaBZUg1TBYS4LcnR5/aSx3vwi1SN6SeQ8qJT/UZVaLpg2xBkkDD0w8E?=
 =?us-ascii?Q?zhgh1lW0QYmCEEODm4xVrUXAJWRyBebLiQvOd1hqsErUwX01nwnzWhk7A4UX?=
 =?us-ascii?Q?sn3vYzfw/G0wdF3KD+XsjHRZYiuK7CQIOOOyMWUTOGSOuBht1VZuufGn82D0?=
 =?us-ascii?Q?B6ETdUzClx5ohX6bBKWC/kGaTcTJjZIO7oP3egE/mtiwQVDP8WUiubl4GE+A?=
 =?us-ascii?Q?4PxScfT/nF/Us8crrOYg3d7tc4Kc7+o4/baJsZUzT+eR9NJ/QFvrT5Rz8eBT?=
 =?us-ascii?Q?crFOY8A7bhxgsH7lPqEfEBhWuUMJhjroplECfJAWxTSej+aNAYliglcTKX+1?=
 =?us-ascii?Q?CzGW3Zc8I+VV31uwrdMWBTKhrF2mJ6F+K/gpv2PK+chzlo3SjYXrb7R21b3s?=
 =?us-ascii?Q?g0eAMlegGHyVXnyPu0OqhVyqRPf7sITEOg6J6tRl1ULRW0z6riIhykzUZo+9?=
 =?us-ascii?Q?epG2o/Yt1rnOWWtrGycClPRi2+iZNvJW/M1eEPo0ia8QCyN01+6+iuuElhKy?=
 =?us-ascii?Q?dVde39P4bAw/hEsAVT0OShGUtzYKrINTN7LIwcmC9w6mzhxo0ZF4l0jDZkRw?=
 =?us-ascii?Q?ThyWxwD2BcRQ5jtTOzGamcMs4wUgTUwGCf0gvxeaOhZ6hih8AE3wRw8XQ/jc?=
 =?us-ascii?Q?SlCzrLhLqPIAEZ/TQ7sQ3YI4t2ZCB0pu3fRBJDI/o1fA+yaJKyOSWeI2YoZE?=
 =?us-ascii?Q?B7Hz+vMbhY/gKKUr5SdiOipNN6pmwu+gunUEE/B/pOXa+1HehHRJNLQLpnim?=
 =?us-ascii?Q?KYyc/QUzKldZZqg+az44F76NaKF+RMv9k+ClCfUrMYRKiZBjvxNpTWkY2z8n?=
 =?us-ascii?Q?hbJNXQTnduJzO/wPiQhB4u0wKzEJt4QCJfVfVJD70T/EYf+9eI3fD7RYvG3L?=
 =?us-ascii?Q?BPlSt89BxJV5hwiNBqH7TJX1W2C7rEUH4R8QVN5QIKG7DdpzAhcOqGc27Kdb?=
 =?us-ascii?Q?jzDFT1g3ZXFQShsFWp7i8q7eaBCVPAKGZx2Ss/BTI3mIUgx/hcMVmpFx17ax?=
 =?us-ascii?Q?OFD/ox/eP5Sodg8hYt/4FI2CcWAqAPIm0eqAcoNTQEw+blTYUlmUwGoYiRDk?=
 =?us-ascii?Q?YA8T3lMpRneu0YV4YDE7x8mT8nbSJvBJcV9T6uZ0QUzMOK+4RXu2L0biqCO0?=
 =?us-ascii?Q?K3S6EUD/PvuAuXuqsE8z0ZHcPf/gL4LUsrUC0GfOB+J4TUuOi7MniL1W4iIr?=
 =?us-ascii?Q?JFFGEsRYmQhVO+iwbODtAZcZVFo6zE8NRiji+R0ugFidI9S6hEVyDr0/kASg?=
 =?us-ascii?Q?ixXZ2VrXUohaxpiUlGp8/NC6kcuCq813BQh9G0LqIwbhl7yLZrX/IPJhqrK1?=
 =?us-ascii?Q?li2x82U/YUUQAmGNnwbq1Lkwp/S+FOpXMHhjQzK9OJdz4DqhcYKIGD4YzdJU?=
 =?us-ascii?Q?rkUjPurEGAmrPPDcZ6uhYBCPLMZW/2l5XReWrw8dsV6Mz2Ppb8cTbs5s4NvN?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?KQIWiwzppy+mD4OY04xmZA76+TD8JuQULdhCLyublUCtPp3qbHCojOtJ8RrK?=
 =?us-ascii?Q?+ZIxpT/pQ/SWy3uW03r/7lmcVhsG7IXgyy4SdpHtyKVhhzQ0vKzUFms1VCmX?=
 =?us-ascii?Q?NyN8r+8Kus7rUZkm75/hr8k5F2kfdYkeAiiW7Q5wJQdPaGZkYCq74Kqe376n?=
 =?us-ascii?Q?YiyT9X9QbKNPa8q1MkQILApaiApFycyA6b3GXLQ3ruX+nRT9PqTViAqv8Ef3?=
 =?us-ascii?Q?9kQJrZ46vsSMV3KSKFyNBSL3BPtLibQwkl1FKnRD7P4zdTPAj6jnOsyUWbLb?=
 =?us-ascii?Q?I1vmBHAvUqJFfoJ542Xql9yU74d4QUTRYoWay/4A3mHd9e9yxLIjDrCtao59?=
 =?us-ascii?Q?i2t/HP52udutx3TTLAD6W1r7hZeQEyfj7Y99TDBeu7s16a7X4N+2NR4fPOX7?=
 =?us-ascii?Q?ZbF24OiCecgKXvOup5gva0t+nIb23FgZnOdqUdWM9QUKoBPo7B7Bbci4mfNw?=
 =?us-ascii?Q?5MlrP4svZaRBmvKxCR0DqkyUqhMenW5F8mDRHdPDdAkgA8XyXrluYndhTBRr?=
 =?us-ascii?Q?+kQN/IeC5O34dJAx4kp1PpqnDoxz9HBgkX0pmuC8tUBvPNh+qk/lGL4zjs+u?=
 =?us-ascii?Q?lxq3GcAK/0U/xdkzOGJwITR4z6cyBqWIx1TsAGsLww2P/4MtVoorBdcr9abF?=
 =?us-ascii?Q?5zYcoIS3705TC+bdnCGNfBvoISV1Ckxp6Vfu9uvGjF9s5J1e1Eg+ayrwt3ct?=
 =?us-ascii?Q?TOH38hxmkvV8YqX6ZuPosWH50ADiqxJdA5h4opEvxDHkXuv39zfGd/qsiNOb?=
 =?us-ascii?Q?sxDs2ygwvO0CutHHNsqjTmCAuRrtGH9HaNTNzh69UGaRn9BbSp2+TC8CnTap?=
 =?us-ascii?Q?mz+LB84ailJDy+AViJ/hAWhTWi7FUvXxAWnn01P9skReP4sFMTX+NMMN4/4z?=
 =?us-ascii?Q?oHwdOWlGEmo+YBRHWJPJoSKsCXBEn/ArTSPBt91Pia4sUQCsPkcAJ3Z8ghOh?=
 =?us-ascii?Q?W7z3GY63iLiNR3M9JQs8PC0Z7Nh1HBseqJupe3AmdrFkkBqXQ+4fRKKjl7sy?=
 =?us-ascii?Q?vblvaH6Fj1abUp6roCkZN7o1JFLUlyWJhW2gXJT5P9mQZ1Vh7GdaLpHqD5wt?=
 =?us-ascii?Q?YAX3iviWIFJl/0ICWhSvutUJdCHtBVfBTyrUMiHqnZ4gBnQ8QvDxNcahO+nH?=
 =?us-ascii?Q?K6g/S8s1PA3O?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c49d4a4e-82b3-4dd0-b938-08dbafd43fdd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 18:57:14.4364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxoDAakqc2tSt/WMxemXdtcf1DoPfwLSmD8Qe5SfvqEOmBAr5emda0O8uKX0WWB6QDFq9Rvwbgm7BlWCc0DR7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7095
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_11,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070167
X-Proofpoint-ORIG-GUID: oCmo6hqTEFFaR7qKZUi93dubzLbGSerb
X-Proofpoint-GUID: oCmo6hqTEFFaR7qKZUi93dubzLbGSerb
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/23 14:55, Muchun Song wrote:
> 
> 
> On 2023/9/6 05:44, Mike Kravetz wrote:
> > From: Joao Martins <joao.m.martins@oracle.com>
> > 
> > Now that a list of pages is deduplicated at once, the TLB
> > flush can be batched for all vmemmap pages that got remapped.
> > 
> > Add a flags field and pass whether it's a bulk allocation or
> > just a single page to decide to remap.
> > 
> > The TLB flush is global as we don't have guarantees from caller
> > that the set of folios is contiguous, or to add complexity in
> > composing a list of kVAs to flush.
> > 
> > Modified by Mike Kravetz to perform TLB flush on single folio if an
> > error is encountered.
> > 
> > Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> >   mm/hugetlb_vmemmap.c | 38 ++++++++++++++++++++++++++++++--------
> >   1 file changed, 30 insertions(+), 8 deletions(-)
> > 
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c

> > @@ -638,7 +658,7 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
> >   {
> >   	LIST_HEAD(vmemmap_pages);
> > -	__hugetlb_vmemmap_optimize(h, head, &vmemmap_pages);
> > +	__hugetlb_vmemmap_optimize(h, head, &vmemmap_pages, 0UL);
> 
> UL suffix could be dropped. Right?

Yes, it can be dropped.

> 
> >   	free_vmemmap_page_list(&vmemmap_pages);
> >   }

-- 
Mike Kravetz

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B2E757112
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 02:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjGRAue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 20:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjGRAua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 20:50:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59BC10E3;
        Mon, 17 Jul 2023 17:50:28 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HKOMtW026841;
        Tue, 18 Jul 2023 00:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=tT5JR7OwlptdMOMpxbuk0zZhbMiMcLEjli2VWIuDKaQ=;
 b=q1HFfJbrz/FdCFR/hRyyA5D1ZnH3yOohzEc02qkN/pbmTyBjQrzIMKVlKr3O5aeaEQDI
 J33WlTilHn/1pFXkLDPvWWwLgCb1ALy+Quy0f1Wc70YyuxEWUroPoqlUjVk0J0+5IkfQ
 EVO1g6dWJGlrk5VRjYDKFnWL5w8i4PaYIK9xSwnYqovQuhkCjmVLiPwrdHA7SUX2Cyxn
 GaoZbvAlIkEBa/567zLL6tNvxo1qhk0Y8OB9YXnLqYxpF2jW9QvB739CHwKUtRgd58Gs
 oim76LEJEgsuHdypNUIt7OT0ePeEtUQnPbdOriNwUuxjDCrqwPgfsu9wlnoYsB1ObNDx Hw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run783w7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 00:49:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36HNt2OH000934;
        Tue, 18 Jul 2023 00:49:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw4dbfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 00:49:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmucW9KiYab4lI6MzLMuvVs9v2IWamfFkHC0EJU4aoAVmOTSi7u3TlLZ3xu9Kn+duL3JbS1R8cLjSKawvxGdrqWaq+e8NQrbj8Iq0EPlljaQVMUfTwL7PhZ2srtWjoa8NKCPiElzvsjBOPrQ0jGGOjMnLwxBR3XzqZOGZAno3KtQk2WrHEcqwAztBF9gB+qjeVqJyVJFvhrxYlbz2XSC9fqVaWogjy6IobwqZ9mfKIXqZ9FdNhPOV2X3fphPytL5RJInKjskGYXBXx2yylGciXUxthVYbvD58JQWDkxeklRKnhePggBl58xXeO4d7rRqEoBkqt/EtIPd+80Flnt6Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tT5JR7OwlptdMOMpxbuk0zZhbMiMcLEjli2VWIuDKaQ=;
 b=naW7CoTnVyR+Xo9qNoKZTWKQlUGP2h1L5x/nnAqDMJTZT3DDAQ8Z0opDMaZbZ8zpZaGBttldcGxnD9uy6M4WW+w6/mmbpgJ+Bvlxlh7FRhwLjwUlZz2geoUXnJL21aXCfo7AlWQjKcMfE2oRICpt2TDmzahrCcEMIx8QwxSXNkt3WP+Q3g+PvoM8urc5pQec9zrMpVlKrO8g3ugFLXi93kR5CUxkZQHpRKQkg9vOsZk/9V5B4xK46+HaY0A7xhWWSbEP7LjuqoSl+fIBwl/Zaqvex6hPY+10Qjh5xylL3Sfh9ZsACBulpJp7vlcyse8jMK8kbV5eLTzJh+OSTFphxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tT5JR7OwlptdMOMpxbuk0zZhbMiMcLEjli2VWIuDKaQ=;
 b=BH7ASMRSSaDemXQv1jWEpjyIs974Nja0vu8yZEtsNGghUzpVB45kBz71HYBdXG0pr5tHDwNq0K6ERyrQIBCK5PeprCXsuqJDIfFLiFBziSGINY3lPVL56xAypjmc4o4E4cmHeI1FIUF524jSaHnrJ/bGxlwsO8/vhMh6IjKwJOA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA1PR10MB6193.namprd10.prod.outlook.com (2603:10b6:208:3a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 00:49:50 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6588.017; Tue, 18 Jul 2023
 00:49:50 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jiaqi Yan <jiaqiyan@google.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>, stable@vger.kernel.org
Subject: [PATCH v2 1/2] hugetlb: Do not clear hugetlb dtor until allocating vmemmap
Date:   Mon, 17 Jul 2023 17:49:41 -0700
Message-ID: <20230718004942.113174-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718004942.113174-1-mike.kravetz@oracle.com>
References: <20230718004942.113174-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0120.namprd04.prod.outlook.com
 (2603:10b6:303:83::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA1PR10MB6193:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab88ceb-2a52-4419-6e5c-08db8728e490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GBg9FEGhgBAXxC4Gx9Jrynj0thSCmA6UW75IgmhDfsIbthBsxGONxHa5VffS+w57Q2qDY1bPUKmgGM4/AILbNBLV2ycPGftl1f/M8VZu+0UGkh4S94Im4oboDHFQHUcLWuHL6YneNK4udAwiDRD77G+ILfwDN2mW5FKUqzpGexcDfIkNI3x8vk6zw62IL4QwtGNiixUNh8n6CBG7RF48dvypam28IHA6e8IDQWxoolbDQ+4J5RjO/6n0D/PzfyB1RyyGgAtVL4LKpO6jakT80LdiSscGNwg38PlFUk6ynu0HpNO24+9r2agIMiPAipxrpGqzjZk0hb6HtnPdpT46NvNgdouDMyz+MIxYlKoureuN8ikzZLnlzY/X3ngPQjV38NGTDZonCcHGWLUPBr5JqTmHo+BzHhfOx5egyl87aFzLHuOWzRgavAj4tbcLl8ZvEn9g6ROBHLBlJ0k5icvZKNJM2OWZV+T5pGh9QjFYoAC43nLQP+vXd6KXneAzgFJmghXeptpBVHyZScPIyZYp3DGYKgTkFfvHBLyDhYzW+ridH+Wl9rHCe/ERlXV2AxT2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199021)(54906003)(6486002)(38100700002)(6666004)(41300700001)(8676002)(8936002)(5660300002)(66946007)(66556008)(66476007)(316002)(478600001)(4326008)(186003)(83380400001)(6512007)(2616005)(26005)(6506007)(1076003)(86362001)(36756003)(44832011)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xm5PQryyaKrFgg/4O9Bt4azqAxh4xChnJrX36auv8d/ryjsNaeJgp5wpiERY?=
 =?us-ascii?Q?YWj0KzLx0+v7g3nGT9a5f1MpZ8Gjmx6FFhyuOPucVbQfdFMPY9TWF7J7qBuG?=
 =?us-ascii?Q?w1etDv/Kyxo3fU7hKx5gtP359SGU/EriSAlCWre7pTn82pTSmE4OqU3+bXqC?=
 =?us-ascii?Q?TP4wbYRCrk+DWENxTMAMEtDfYCiC1/T60V8AP3hsQQKcSDfGTcDRke+9ppRg?=
 =?us-ascii?Q?eM499wZOqjtxrzQERSWi2otF2aSh+7hFBgokanKsRr/6PRARU4sE61mMt4qi?=
 =?us-ascii?Q?yKGw93umIhmTWmIN8MgADjMhLePZ/vkK2BuaL+y6o8ZFDG6boCWViTYq5Cnq?=
 =?us-ascii?Q?B+SyPCogUvRbZgCRgcZmZ3ZJZgVWPoZUkCu9sdWttVGeFvEG1HBJbH+a2/Es?=
 =?us-ascii?Q?J7c8+2T/PGf3hVWvPbA0NtzoctT4wtsMdRuKfiN0ArahmsoOTLyhQB3El0WS?=
 =?us-ascii?Q?WfMueWStBNiqB0Fz9yk8AnJmWHusxJHuF0UZm3zwBZH337ZqpR6xck9aJMDv?=
 =?us-ascii?Q?D8779i9n+1Hnha8lygm/eUYMxKLZJnFrkoUmwRL/futlGImJR80pHirwwmLy?=
 =?us-ascii?Q?jshgliOWpf+IJ3CSb5kEZxbE24TeBLS4BrIup3e2U4WFNAA8aoydgPkX4fsk?=
 =?us-ascii?Q?fZfuqZiJ69j92w6JncHZWsPKI8jKWgfAQEl36vJA+4yqGpmfxjUUA/cEgZO/?=
 =?us-ascii?Q?8QyKfiwo8Z56SMA3V73h4favqPG/SyNCXcTXf+dlwz03+PHmzt8D8VQroZSv?=
 =?us-ascii?Q?RZp3RkYa6Gt8r7GUv8FGHWLhIK9Lx44LEzAO3aQolYvjhdZZ0y3bB9VHRbY7?=
 =?us-ascii?Q?wZHyGXAQSb/WYxYR0S3XnmCmnqcCb/33E2WDIpKDRbU24kLOKAL3cxjqNUGw?=
 =?us-ascii?Q?PYJWHfEYLznss/WCli7AbKtk8uu0VLdiRTegUliu3uWfDblas/Qz0Wq4RLuf?=
 =?us-ascii?Q?7jpbk1Co6P8i0plI/l0oC9t+/hLmZyLvHIZNlZAg28ryw8AArNtWn0jA49HW?=
 =?us-ascii?Q?F53S5SY1wqehpXHsENxLYg3Dz+AOCGfYlGJqIE4JVXF/dUjevKs0jCMmWfFw?=
 =?us-ascii?Q?cXAhbAwMXPt1Pak9/wgEYXgueDVcfaVr8MZ/AGTCa5GDz3bsX0ufU/tt34u4?=
 =?us-ascii?Q?R6J/4zp6XWcFLbPgiKALd8lK/jC2A1dB4YYmW1balNp++Ll1UvkR4TKcAYoj?=
 =?us-ascii?Q?+yv2UllQAf2fuOcwhNZvqGPBTA0Jog97ipTh9jlU1G5vldS9vi2cYKVrM/QN?=
 =?us-ascii?Q?/Pz1jr052PaRLNM5fCAwaj+w1awlv3R1rgGEaDI6Qc7UGJPnlJY/kmaI5z03?=
 =?us-ascii?Q?/OvHUO0ePFC7IgHInUUktcFEn+PF/rRs2vmPjQL5b+2hfuiHoTQhFZKe/KtO?=
 =?us-ascii?Q?Xdk9A3RPXhoAxryL6XI8Mznm2fHOYchjLam83RmSRQuJdPaUG8p7RHLpBNsr?=
 =?us-ascii?Q?zcYAz00Our13maBmktTc2xaobcxjNCPagduDL+4qu/SCu/zBIXmvSDfk9WOg?=
 =?us-ascii?Q?WUYLiO1f6WRZNshWtCP2j9jFN33oriuGz9byvMQxGfP87i6SZ1+obKwjkqkH?=
 =?us-ascii?Q?wUzWa5g4sVTMbMLW3mAqSg55q9jyPogazBIhh7qq6xnvgixR1Q67KVWm+TRf?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?3NYU9MoVc34rAiv8s32eq0zZyn8IMLfAdJG8IEY+Bx5cQpbW9Udq3OxRHz2h?=
 =?us-ascii?Q?W+hewLT7cxsU/g5of5cJ/GK8/iByC+I+bAr/N9J71z+VF8Ls6O6T2oceoh8P?=
 =?us-ascii?Q?Js5YwiF4S9uaN7VBcQVLXxqBs3ci1hnFXE2Hpr3DuN7Oiud8ikIquA49hNsd?=
 =?us-ascii?Q?NTpIl5cNOGeGxz01jkttcxl4L+wgJ4SNcQ47tOsmdE9GJcwVbVAmpYd+WVyo?=
 =?us-ascii?Q?Yj13DlprOzJX7FYoR32Nq8YYjEp8nVVLkcFBAFzi74PK/o6SXDpOdQNlDzM5?=
 =?us-ascii?Q?LiH71HX/1keFgx51vkWxF47UBRP++R+DdT+eew48ytrCDjcOYnh7Pkj5xcw/?=
 =?us-ascii?Q?PNhMaImJyjW9KTJsaNIh9kZ2LoGhThBCe+eg8b7huP7oK/Q3lTEEczLWHEwZ?=
 =?us-ascii?Q?U/muKb4TOy3G0c9xiXzIOPupcY9lIG7/OQ0VrGFWyEMVVm78itgTxk5gyc3W?=
 =?us-ascii?Q?6u4uGEVliQF/wgj9byoCVO6rRGOjIneQLwsOI1bG+/doS4z3oBcLMx+KUDWg?=
 =?us-ascii?Q?NYjwQ5z1Wcq9vMeuFLxNLgbw9WWk9eelqpweW/OYvyUl0ExnYfHatZCDZrgS?=
 =?us-ascii?Q?g6rlVMppAvhEWUr4nJRapjeuCSJdzpnYrrDWTwO+EdwGFeGgcTTRLgebhiJz?=
 =?us-ascii?Q?SuyHc91B5VlRE61oV9PXrK5TUUvLMY0teaMHRtIu1cZ1HACaMGZPXTX00cN8?=
 =?us-ascii?Q?umAU+adVC1AGS7Uc135cqbWYsV8bEjkoTrDJkeKHsgxJxv3fiesB7TzSH5Au?=
 =?us-ascii?Q?VbdwX+La2Q5JLhtVCZq0dqJtLH6jh9VqAtS8zul6kuqnKmuHSSjyQ5YXXUOJ?=
 =?us-ascii?Q?DkvJ10KtT1mtxjSWmN3lA12KkH+2FC1YwH9jvj4pNnX+veen7K0LMUZu2taW?=
 =?us-ascii?Q?RcMsiKBJM1IVqDEGF7B2fFpnuYqiviqnjTd3cucs21QyWuWc+4LwK9CQnYyw?=
 =?us-ascii?Q?tCr1/3J02od284xqF5QL3zneg0hT3ba0IGReyVnTlpQ4BONDJgb4msxAf18y?=
 =?us-ascii?Q?i+6l?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab88ceb-2a52-4419-6e5c-08db8728e490
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 00:49:50.7363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwkMwT5NJ9vQHz0x5AALAC36tVXZLu4eZ2wQA9WkGAD1pmUh2uW//GmYdSCUtmK6dX2fvB98kZLyOXwVdqKXxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6193
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180006
X-Proofpoint-ORIG-GUID: 5CrmmDV1sUbe8Y5OZeWmg-5FqrMKGG0J
X-Proofpoint-GUID: 5CrmmDV1sUbe8Y5OZeWmg-5FqrMKGG0J
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Freeing a hugetlb page and releasing base pages back to the underlying
allocator such as buddy or cma is performed in two steps:
- remove_hugetlb_folio() is called to remove the folio from hugetlb
  lists, get a ref on the page and remove hugetlb destructor.  This
  all must be done under the hugetlb lock.  After this call, the page
  can be treated as a normal compound page or a collection of base
  size pages.
- update_and_free_hugetlb_folio() is called to allocate vmemmap if
  needed and the free routine of the underlying allocator is called
  on the resulting page.  We can not hold the hugetlb lock here.

One issue with this scheme is that a memory error could occur between
these two steps.  In this case, the memory error handling code treats
the old hugetlb page as a normal compound page or collection of base
pages.  It will then try to SetPageHWPoison(page) on the page with an
error.  If the page with error is a tail page without vmemmap, a write
error will occur when trying to set the flag.

Address this issue by modifying remove_hugetlb_folio() and
update_and_free_hugetlb_folio() such that the hugetlb destructor is not
cleared until after allocating vmemmap.  Since clearing the destructor
requires holding the hugetlb lock, the clearing is done in
remove_hugetlb_folio() if the vmemmap is present.  This saves a
lock/unlock cycle.  Otherwise, destructor is cleared in
update_and_free_hugetlb_folio() after allocating vmemmap.

Note that this will leave hugetlb pages in a state where they are marked
free (by hugetlb specific page flag) and have a ref count.  This is not
a normal state.  The only code that would notice is the memory error
code, and it is set up to retry in such a case.

A subsequent patch will create a routine to do bulk processing of
vmemmap allocation.  This will eliminate a lock/unlock cycle for each
hugetlb page in the case where we are freeing a large number of pages.

Fixes: ad2fa3717b74 ("mm: hugetlb: alloc the vmemmap pages associated with each HugeTLB page")
Cc: <stable@vger.kernel.org>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 90 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 66 insertions(+), 24 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 64a3239b6407..4a910121a647 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1579,9 +1579,37 @@ static inline void destroy_compound_gigantic_folio(struct folio *folio,
 						unsigned int order) { }
 #endif
 
+static inline void __clear_hugetlb_destructor(struct hstate *h,
+						struct folio *folio)
+{
+	lockdep_assert_held(&hugetlb_lock);
+
+	/*
+	 * Very subtle
+	 *
+	 * For non-gigantic pages set the destructor to the normal compound
+	 * page dtor.  This is needed in case someone takes an additional
+	 * temporary ref to the page, and freeing is delayed until they drop
+	 * their reference.
+	 *
+	 * For gigantic pages set the destructor to the null dtor.  This
+	 * destructor will never be called.  Before freeing the gigantic
+	 * page destroy_compound_gigantic_folio will turn the folio into a
+	 * simple group of pages.  After this the destructor does not
+	 * apply.
+	 *
+	 */
+	if (hstate_is_gigantic(h))
+		folio_set_compound_dtor(folio, NULL_COMPOUND_DTOR);
+	else
+		folio_set_compound_dtor(folio, COMPOUND_PAGE_DTOR);
+}
+
 /*
- * Remove hugetlb folio from lists, and update dtor so that the folio appears
- * as just a compound page.
+ * Remove hugetlb folio from lists.
+ * If vmemmap exists for the folio, update dtor so that the folio appears
+ * as just a compound page.  Otherwise, wait until after allocating vmemmap
+ * to update dtor.
  *
  * A reference is held on the folio, except in the case of demote.
  *
@@ -1612,31 +1640,19 @@ static void __remove_hugetlb_folio(struct hstate *h, struct folio *folio,
 	}
 
 	/*
-	 * Very subtle
-	 *
-	 * For non-gigantic pages set the destructor to the normal compound
-	 * page dtor.  This is needed in case someone takes an additional
-	 * temporary ref to the page, and freeing is delayed until they drop
-	 * their reference.
-	 *
-	 * For gigantic pages set the destructor to the null dtor.  This
-	 * destructor will never be called.  Before freeing the gigantic
-	 * page destroy_compound_gigantic_folio will turn the folio into a
-	 * simple group of pages.  After this the destructor does not
-	 * apply.
-	 *
-	 * This handles the case where more than one ref is held when and
-	 * after update_and_free_hugetlb_folio is called.
-	 *
-	 * In the case of demote we do not ref count the page as it will soon
-	 * be turned into a page of smaller size.
+	 * We can only clear the hugetlb destructor after allocating vmemmap
+	 * pages.  Otherwise, someone (memory error handling) may try to write
+	 * to tail struct pages.
+	 */
+	if (!folio_test_hugetlb_vmemmap_optimized(folio))
+		__clear_hugetlb_destructor(h, folio);
+
+	 /*
+	  * In the case of demote we do not ref count the page as it will soon
+	  * be turned into a page of smaller size.
 	 */
 	if (!demote)
 		folio_ref_unfreeze(folio, 1);
-	if (hstate_is_gigantic(h))
-		folio_set_compound_dtor(folio, NULL_COMPOUND_DTOR);
-	else
-		folio_set_compound_dtor(folio, COMPOUND_PAGE_DTOR);
 
 	h->nr_huge_pages--;
 	h->nr_huge_pages_node[nid]--;
@@ -1728,6 +1744,19 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 		return;
 	}
 
+	/*
+	 * If needed, clear hugetlb destructor under the hugetlb lock.
+	 * This must be done AFTER allocating vmemmap pages in case there is an
+	 * attempt to write to tail struct pages as in memory poison.
+	 * It must be done BEFORE PageHWPoison handling so that any subsequent
+	 * memory errors poison individual pages instead of head.
+	 */
+	if (folio_test_hugetlb(folio)) {
+		spin_lock_irq(&hugetlb_lock);
+		__clear_hugetlb_destructor(h, folio);
+		spin_unlock_irq(&hugetlb_lock);
+	}
+
 	/*
 	 * Move PageHWPoison flag from head page to the raw error pages,
 	 * which makes any healthy subpages reusable.
@@ -3604,6 +3633,19 @@ static int demote_free_hugetlb_folio(struct hstate *h, struct folio *folio)
 		return rc;
 	}
 
+	/*
+	 * The hugetlb destructor could still be set for this folio if vmemmap
+	 * was actually allocated above.  The ref count on all pages is 0.
+	 * Therefore, nobody should attempt access.  However, before destroying
+	 * compound page below, clear the destructor. Unfortunately, this
+	 * requires a lock/unlock cycle.
+	 */
+	if (folio_test_hugetlb(folio)) {
+		spin_lock_irq(&hugetlb_lock);
+		__clear_hugetlb_destructor(h, folio);
+		spin_unlock_irq(&hugetlb_lock);
+	}
+
 	/*
 	 * Use destroy_compound_hugetlb_folio_for_demote for all huge page
 	 * sizes as it will not ref count folios.
-- 
2.41.0


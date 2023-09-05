Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD85793136
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244701AbjIEVqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjIEVqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:46:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A41CE9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:45:40 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385Le1Vl020747;
        Tue, 5 Sep 2023 21:44:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=/QCcumSTTIVe6iwff77MVSYTnNhMPc0aiSwQbQ0i2e0=;
 b=PHeGAo/BUfvzfdEC6WXZvOlGru5zcQoHcdFHigcYEZB7w7l0AUlfmcQIHFR/Cp0X/88U
 m1OdES3Cu7yfFEBsEljAFH5pdwV2252vKErLBtHm1cpacAyDYByHybZbacLDM/meY3DS
 xGOkjOd45qjJdmmh8QlwPTSSFLH2DjPr054Q1VW92QEDF9Iyj/mgDt3P8CPgk3ueXHhf
 Lzq0v+Th6gbxMMIR07O3H0uvovB1jzJ4bJXXo7AsmwoPPaJGDQqtEG7Cl3f0VmYB5pPY
 GHhUezNgW+txVWGQp4f6LOcbwwrzpLgqouRPRWN8sgXpUiB8XQTMe7fNEQy1KLdk2vWC qA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxcem807c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 21:44:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 385KMTvF006626;
        Tue, 5 Sep 2023 21:44:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug5u9a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 21:44:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Teku9pawNoHPPbNZLS5wfxOuakd7GWHeoeq+lzed7emcdTY+Kz/dx8rzPzt1xvPbser/+gbsXUeDC4ifigO8kaZI/7gciqbJ2B7UJk4+pe1VqsD2GVimq5dTKBlpqlhJ3j9utYg94RGebW7LXi20Wmi0SM1FGUhCxeCAwdH5YQxC2y6ub1IE32CGzzY0Eq6hqUlvF3nM6UJ4Bhhmc3xo7JPfIcyeFwLLcjCGgpaNMMjl7CyLUhNlvnGYAiXWGf94vu4ivD13Gy5cX+Ddnmh2ZzQD/kQ/PmbSy/F0LaF2Wtv0abCdSTjx+Q1x6dWSpc7aYuG50JrgMRBiZkUvm1UgfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QCcumSTTIVe6iwff77MVSYTnNhMPc0aiSwQbQ0i2e0=;
 b=EZrd7y7SSDSH/ktjCq2+RGAJKjhjdhFz5+sJWxp3e/phkr/x/jxLTHX1tFhOnFebJOZ/Du1ASPG3YF+ktMeEfoN6WqF7eJmDDjw0lEXNKj7NhmQUvZkn8vr9LNRI3IUT9esqkQs/kY/Bkypkz7BTVprcP7jvO1qLKpLhDf+Yc/2jPVzbMPrT6LJbhnXavG846vd4BmTU2RFGo2ZZ1AreAGC2lyEbhrI6OcSRwKRUF+Fam41LJ/j9kuzWsYFDoiKsIbK/o3bhIKfaXMSk3Rxo5KHxOXGRccvE0krzNw8FFlqwWD/GHF3PCVhSRiqwFAwWiVxKSI8xHdt9PdxCAPZ3/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QCcumSTTIVe6iwff77MVSYTnNhMPc0aiSwQbQ0i2e0=;
 b=xSWN3PSzeoWC9YBxMV+QQnYTzjPUQK2MV3KltIc4dvm1gxxB7ycApG1ZlalBKIeZ2+kQb1hD0FmvJAKAlTJMulVuq21KbS3KNr30Sa2b0LIsoOZgNCJJqu4BzpEjkKu718fyxW+4/aBKoNaUer0v1Sdpb9zMURFV6Ow++0z7qyc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB6395.namprd10.prod.outlook.com (2603:10b6:303:1ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 21:44:38 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 21:44:38 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
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
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 06/11] hugetlb: perform vmemmap optimization on a list of pages
Date:   Tue,  5 Sep 2023 14:44:05 -0700
Message-ID: <20230905214412.89152-7-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905214412.89152-1-mike.kravetz@oracle.com>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MWH0EPF00056D0E.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:12) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aab66e9-b30e-4c54-95eb-08dbae594d8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F/JrOFE92/y6R3qVjFKG7eoTkPAcJQ4yeGvZTHKHOqPqlFtoGGlPv00X5cUgiVvtR7hp71njZxFwRXIaxTOrle0XBvaNgElSuJsbX7ZP4/w40IHU1/I40I4zJOpI7h0a+PbfbCTvGsvM6wpo9kM6juVpB4HMpBzj0j/RXbQ/ORoVYMcYrwhHhwvvSatt/Nd+miiJTxX0w52ZF/KX34bhQb6s9VZESJ9mMsjlnzsiH49fX9uwNAv1QDpZDLaIKi2LW9f/n2E0IKXu6hJI6JJXuMN/Fg/sio6HdunyxRHy7h2bPa2yixxUJkHZoliNM33hucadFdKUkKO+Fxp3NslNaegD5jJu+1k1LcHhaXcNPSn8FBpRgOiqgoBn7XlpZcsjx5ewHk1KlNOzL+Y2A010y/ANpzQh2lY/JVtyjsk89FYs/z0YQiI6Xs7VHWUAcBdb4AaDeWwvEi/R31hQlzpSpsvJN49TMhBzqDO72YxNu8iOr8zrxz9JuZ4r3wUzOYZnxrWn0DQjsJYuXAQwUwc7tPhVots/6RPGuu7FCNwda0OYSLB2jfssqGT55WzIe8Ee
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(396003)(136003)(186009)(1800799009)(451199024)(6666004)(6486002)(6512007)(6506007)(478600001)(38100700002)(2906002)(7416002)(107886003)(1076003)(2616005)(26005)(83380400001)(86362001)(36756003)(66946007)(5660300002)(54906003)(66476007)(66556008)(316002)(44832011)(8936002)(8676002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8eoITRbrIOfpfXi1aWgOcy6CDdQXndHuGnijwrXeFUougMfDG0ju11SNSTu6?=
 =?us-ascii?Q?I19W4EToCO1n0TNoZq0xBENuNFPKYh2qMEoynrDP33y746uvmENTDct3BfmD?=
 =?us-ascii?Q?TEWA0cGJEULo+PdtKYGBrnVfMc0RcIA21YjE2GR/gF1A/1QmdcU5cz+EpUuH?=
 =?us-ascii?Q?jUybE60FWkQiv+DOFuXJRfoHKF1ILDThNuSgaj4Iu0vG0NL1OrCf7+daGGaf?=
 =?us-ascii?Q?cGc5/O8Oe/hQa4vaf1WJC26rLbkQdoT4TYl7Sf/lG+sjAueV/Gq+cU850crx?=
 =?us-ascii?Q?LiwRHrNiR5LdU5ohXECXHaosONMpxKc4gg5gLA5d/RWYGIbyyNzAj4dnh0xV?=
 =?us-ascii?Q?Fl5Twh7qLcQIsCaty/wnyZZlV+8bLyoRPgO6H/Ov7KXztbQZKyCpXi6OUOS0?=
 =?us-ascii?Q?okLn/HHNwFvvx7RDyI0dU21WFHon+n4mO2mFc4/vSVaupXqT8XZHbd+YK5O4?=
 =?us-ascii?Q?UGAsgGM7J84IFzN+fDlktWYaoqU6Zq/stJTkZJlEi1P00+wdoANEBhbCHpH8?=
 =?us-ascii?Q?38/QuQUEdn5egWqpkkOzB/QPGS8VlRplePndtHFjoTJtD+k4Vz71Hpp3F/Vn?=
 =?us-ascii?Q?vHZiiyD32x0AqoBPO322qBIxSMu+p5U6XR1vdZX3EWPXF8nczk78fqHl8l+K?=
 =?us-ascii?Q?qconP/98ViKvuj5dKI9hJwA5ut7DbJ+119x+7qHH1ed2P9BPTHb68ByCNkOc?=
 =?us-ascii?Q?XkzR3/JNvkHjZ8JqcFbfhsvDczgT8sKffEejl/rh80s9f7XwhDs/r8uLv0Dq?=
 =?us-ascii?Q?ACdrhKbFB9U1uJzJarjxGoqoKiQ5Ed9m0p6WWfHji5yBW3IPRifKgyHPr2iu?=
 =?us-ascii?Q?HAKpmguYCikLkqfx/c7VCfdyKyT37T/1BrJJBxWM577KPdfWhp6Fx4IWZNas?=
 =?us-ascii?Q?vzT1ob1QG14gAwc54zy9SYcW4V1Hd8VVWS4cHf5Ql8nsm/DOI0Yz8Gq6Yf+X?=
 =?us-ascii?Q?DQBB4QYplDCdLFEIEcQ+wQNMwUzh/LpScmnaLH/a8xMojCC2B7qc1iEh2kYd?=
 =?us-ascii?Q?AsEdbps3xthVMyXMYfJAWAKjY2ZZiB3mb+mGEFsziUCxvM9LzIKGsKyPBYa4?=
 =?us-ascii?Q?l9OFqgC80ab90f7HfyYyevv8B27Yx58bkrHbJIcqfoAMI58AEtBTXOsggDO9?=
 =?us-ascii?Q?ZS75qdNS0Z7s9OXt0yTu2IZqtDJNNUqcabW2R07CP5cb1AlHWZeE/3NVvxPX?=
 =?us-ascii?Q?oekdR+mzWt5sFcikJ+S+hyb2jTUPyJKzzcQMyBK2TBOs6PIFfuxp3+rDArdl?=
 =?us-ascii?Q?6bHHWxHz0MdeBp8yznLiu86wEpZk0HKCYnTboDtsBTVDFKbfxh+GezMR2/zC?=
 =?us-ascii?Q?A2fBTemE56+5MlEjOUAa6m4vld9nUN1YFAaVf1CDF0jUWPNOFZFxn78UFUcG?=
 =?us-ascii?Q?8VN5mSMrmJjFO0Ti1zlXOPiK3Ip9/WuRqHlOuRTtGZ/d319AEAhtoivyWUbt?=
 =?us-ascii?Q?4tOrYpPgL4tYcEUxV/q6a17c30MMsJah+24TdPkQRW/rT1cTNz5cQ9uw60wG?=
 =?us-ascii?Q?PT/HRIAiJEGEZbVR6M4sYp0nW8dsDw4CPZ4ZcgxyqmXnh0mj5ztrHkdpVOad?=
 =?us-ascii?Q?rPUi3o8LT1g2qcyKI84SQuu9rrBMvJNFNAVZRsVOk0iZ1htKTVhlIUyO5/Hg?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?3InvulxbifxhVpx65aDDyQGX6vxAI2x5oGsl7eqIOXjkDboRP19YoIWYly0/?=
 =?us-ascii?Q?g1HHDOFtFbYblRG1yZDChm01Cjr5ThuKTbG1vLjKWXggIQPKbkKtDuxZ7Wcm?=
 =?us-ascii?Q?ja08obUr+Suo/yCCa7OlMnzXV6gNleWQ564E4wMSRz8I9C8XqjjaXoRASpHj?=
 =?us-ascii?Q?/uqb1+8WIw+CWlX+qZspr2S//fZhlDNN9TGBcq9N7mwaiqv4RL9p/DedBwRQ?=
 =?us-ascii?Q?Xp7MrbM0TT32k3iUHCkYKUANfX0ROnhb2jkQ3psgQOvbI5+/HWcBzi5bERh/?=
 =?us-ascii?Q?f4mYSOAzk8tKm9drcBTxwt95fGf2KIXExLNBA6iNpYDhBS2HDJXZFT+yKaTp?=
 =?us-ascii?Q?uR/xGWGj2A9jC0uUJGbEdrj3c2k4BicYaGSCWN9YKEDfZGW1HcZ1FGCXbRXr?=
 =?us-ascii?Q?6b45q/FNQKgiPJOOsQnAg2ssO0+gEF3GJeJEhf3/veTfq9VfbDjcPtWbeiF6?=
 =?us-ascii?Q?mIZolm1uNv7pmuz4PJ7S/Vjf4yvWxb1FwthLYJooBOg2lq5jJ1kkeGQUUX9O?=
 =?us-ascii?Q?R38iMnot8YpuDARw9atg9HF6d6aJ9g38Pz55m/cEvncqpYvmmfmKqCbFaR0D?=
 =?us-ascii?Q?XD2p/fddn28jb/lf1nshgaOTQGTvzv7UYqM4W8zURRNYAWORYT017+/IVqRs?=
 =?us-ascii?Q?cGlMLBamfLseNhi2VbFUmS4qtW1ap5sUtc+ZBESqK6cAN789H2cFYUKDRCGm?=
 =?us-ascii?Q?GHh8ocRkDNwLnITE4IiguPnPsPwOcbO8hTMhEG0+eeJdSjXOX9305NwB6Pb+?=
 =?us-ascii?Q?AleFNpw74AdxMgiVEb6CJ7kDow0Nf7hVrkncMydgg4q89tOn1fmS7Yt0W/RO?=
 =?us-ascii?Q?YH0VhaYriROZbOPN0gCc+mi684vAgocvsATa0aZQecRfq2UpE4jXUXWUcegi?=
 =?us-ascii?Q?ZfQwwzHJNGtl9dwyOlLVQrvWcdkhxEmjY7zItCuWJVNpifJKDLc5UJyx9cKg?=
 =?us-ascii?Q?1p1C6cV9XexuTn23fAX5Ieesjh4XGgHlSSTmGy2u8kDP9fFeHFL9MqryCT5D?=
 =?us-ascii?Q?Gx2sdTpswvIEUp//ZLtpdnB85JsKfekvJWBRGwWlXaZl3ZgCEVCX7Lj3T78K?=
 =?us-ascii?Q?ZhNVkznT4/YEa7cNsMsLnr3SYmalApzpggUz3TppHCoUkIlMfxIN+IJUYVV5?=
 =?us-ascii?Q?W379kAsVnwWw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aab66e9-b30e-4c54-95eb-08dbae594d8a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 21:44:38.0931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQwZrMWiLBro5bYwl98TwlpYCr9xyUhHc7Dunot+jAHBpOzQuZGtxQiQwPa8VfjRSr9PBsM6DGsDGKhsD0q8yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050189
X-Proofpoint-GUID: RJDh7pq58084jrsK0vboPqbAWoc1unDB
X-Proofpoint-ORIG-GUID: RJDh7pq58084jrsK0vboPqbAWoc1unDB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding hugetlb pages to the pool, we first create a list of the
allocated pages before adding to the pool.  Pass this list of pages to a
new routine hugetlb_vmemmap_optimize_folios() for vmemmap optimization.

We also modify the routine vmemmap_should_optimize() to check for pages
that are already optimized.  There are code paths that might request
vmemmap optimization twice and we want to make sure this is not
attempted.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c         |  5 +++++
 mm/hugetlb_vmemmap.c | 11 +++++++++++
 mm/hugetlb_vmemmap.h |  5 +++++
 3 files changed, 21 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d1950b726346..554be94b07bd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2230,6 +2230,11 @@ static void prep_and_add_allocated_folios(struct hstate *h,
 {
 	struct folio *folio, *tmp_f;
 
+	/*
+	 * Send list for bulk vmemmap optimization processing
+	 */
+	hugetlb_vmemmap_optimize_folios(h, folio_list);
+
 	/*
 	 * Add all new pool pages to free lists in one lock cycle
 	 */
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index aeb7dd889eee..ac5577d372fe 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -484,6 +484,9 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
 static bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
 {
+	if (HPageVmemmapOptimized((struct page *)head))
+		return false;
+
 	if (!READ_ONCE(vmemmap_optimize_enabled))
 		return false;
 
@@ -573,6 +576,14 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 		SetHPageVmemmapOptimized(head);
 }
 
+void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
+{
+	struct folio *folio;
+
+	list_for_each_entry(folio, folio_list, lru)
+		hugetlb_vmemmap_optimize(h, &folio->page);
+}
+
 static struct ctl_table hugetlb_vmemmap_sysctls[] = {
 	{
 		.procname	= "hugetlb_optimize_vmemmap",
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 25bd0e002431..036494e040ca 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -13,6 +13,7 @@
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
 void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
+void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
 
 /*
  * Reserve one vmemmap page, all vmemmap addresses are mapped to it. See
@@ -47,6 +48,10 @@ static inline void hugetlb_vmemmap_optimize(const struct hstate *h, struct page
 {
 }
 
+static inline void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
+{
+}
+
 static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate *h)
 {
 	return 0;
-- 
2.41.0


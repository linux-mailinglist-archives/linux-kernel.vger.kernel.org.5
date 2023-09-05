Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9154D793133
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237969AbjIEVqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjIEVqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:46:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AEB172E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:45:38 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385LA20k007098;
        Tue, 5 Sep 2023 21:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=65VawqEObe3ud0azxInS6sVwyPtLcLotMrZynBuz84M=;
 b=3gZYo+M3S2ZHKHQyEN/9V5zt2jLzLA3lahK2soGCZalQybTA/7oTf5hYQr0S4065LWzS
 gvRAzlCnjMgk9ybO41yjd96naP8gol30RfhaXOiJpn68BaRSe+60xqbbYUHamcJ7nWmP
 cVaUt9AFQIwzlQg9Lc+hou1194XzW02dLg6WeISU0XJBbHkquPnLVxhcTycIPsuaSpQt
 2Fdzl/oNAOsFKNlvGQFdP1wuTqSVpRGpDRZvj+DI2HhZAgBJpWYXlm7DJGVzD1W+n7yI
 lkQTf1edvi6QfxBysPMfL8qFEb3i9tito10KsAjjE58BPdmOBoMmmCDwDcuVkIDM45BB 0g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxc0g82tp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 21:44:55 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 385K1v9i037100;
        Tue, 5 Sep 2023 21:44:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugbkn9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 21:44:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmXFOctDdZPfqXEnx1mEXqCLAFRitN9/fg/jKFIdV8736dtaQfjQAKFmQ3dQdoDLDmCpvIHeo8HZbuR7zfTSCghy38fB1PCBTZbQG+8zsJT5PnuXAWKOCGhVlTq0EqQpY9dsMEMg7LjIGhE1+Mb2qC0JX3Yk3hNcMCsrlM9LXzeSMTaL5VypTf91hKh/f++sS3RiQT9R1zoJIGfQ8RlD8M1QSbnrO5u6Ktcwq/OiP/UOa6iGM/QZ5nU2IqNE3LrJV3xtuWbHoBHuPUqjboa1ofAaeQgWIdearLl6bWPvbWbPDc5RjjhJX0yXA90SlYqb5DH88wPw3u3K4XVrzi5n6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65VawqEObe3ud0azxInS6sVwyPtLcLotMrZynBuz84M=;
 b=MzbrvRypVf84n+Tt+LGfwsdOJgnfY4Rc3FG1cfDileCDQ3wlMomszwhEwLALfL8Tshk825jlWAGrowOG0ikmiWqj/UEZ4+75g3lHPohb635qsgogofP0+n1QCE2fFkIZ1ZDGbyNTpLeVv3JVsj/R4ByPxDgnthmE8pxGf6cUfpgy/cXsfWl7+CSQq8EVq3D0HjiQfGxE0bEE6Q1vMaHIlDY/kiE6nprxIPv7gSno7W4hFOzLgO9WhsZsnDvYpysT3E5jmTeLcE6en8khwoLZzPx501Vfx1eXNnZCsMwfEvaQRDAkrvndRpzGPy23fh8pF5Wgng2seVqgqcsesJM6xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65VawqEObe3ud0azxInS6sVwyPtLcLotMrZynBuz84M=;
 b=n1swxgOFK9wtd0EXaGeqztOX7a+e2pocAzuq9tuyOjWiHmTyY+FtpoGdtu3RQRgSQl7YrECBUssDJk6mit1f9qfBxeAc6YbbUTLLD8NSJnErqtSvsYNX7rS8YCQApFoVAWakngHr1VluAilBuP0nA+4GD3Sx6Ak4tjcYyDPRbig=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB6395.namprd10.prod.outlook.com (2603:10b6:303:1ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 21:44:52 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::58d8:cf97:ae4b:1715%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 21:44:52 +0000
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
Subject: [PATCH v2 11/11] hugetlb: batch TLB flushes when restoring vmemmap
Date:   Tue,  5 Sep 2023 14:44:10 -0700
Message-ID: <20230905214412.89152-12-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905214412.89152-1-mike.kravetz@oracle.com>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0302.namprd04.prod.outlook.com
 (2603:10b6:303:82::7) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 31f78125-a4c6-4a12-02d4-08dbae59563d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s6mssAv+T6t7N3e57Tpv4QZJYrbeCZc192hl1jP+foO2hGveDwn3cSJ54ut879HspZio3rFMyMivve+24UAsH8cHQ2OtKuSCnO9YoUzF0rv/5hNOgpvjs6hwNYxvwv+VCsdopw0OpDu788XRieFv/C0+qTLyPj1JrJ+ZyHoK+NMgOildMbS/oR7Wwf8GfzIiYA9fcjtlgINadS1W20rEmcB1LrN7sJcH6S9BvPEbvhpPmGZUDoYo8OzG+zzOjqCDPKkLrwwCxfJaZxmo6PduI5kaHSYtvu6zF0srY8JZ388r7dAUfezzpF5iiAuu6bk4tlL9NzXIJ34W/J8H8tyeUJGIBiIfxhCUoOJxB8DmYJAKHBH8Ipba8Z/4vNLOxztAh5yZ8AXLcSfton84JThVXG2y/8yCab4D3BQKezn7ovCiBxCoarC3Q5VCjEqekI82SgHToy3lq9P7SspHgdY6ZInb4aa4vx5cvDYdSH7EmKY4PCXwbLEwkM1fo3yd+4lg3v5Z5YO7LkGcprHeKW0vJaC+e1UwB6LuzK3q2CF5jXHEWGKXDvrifJ55cdNUVmJD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(396003)(136003)(186009)(1800799009)(451199024)(6666004)(6486002)(6512007)(6506007)(478600001)(38100700002)(2906002)(7416002)(107886003)(1076003)(2616005)(26005)(83380400001)(86362001)(36756003)(66946007)(5660300002)(54906003)(66476007)(66556008)(316002)(44832011)(8936002)(8676002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W4pYRwXTm7p0/vd9hnQ0pBL9sQLW3CQoBGvzZbRpT/CdAtUMu1UQNiIm0ROF?=
 =?us-ascii?Q?cqSEtRK0FgX5oFgnl+yuPZ+3wz6inJ5VPPD0eW7Zw8Y5n/iGltPTLIhqsQzf?=
 =?us-ascii?Q?ejiVxAIt4+w+hAT6oGWlYvB60fM+InpkzH/qP2FEb67Nk9TBT021prvrFYnK?=
 =?us-ascii?Q?9ggwWXHpldu/OBbjlf9KEQ74ptuWg6fTYD5hFlsVg+gJjDcRs/uULI81H8qa?=
 =?us-ascii?Q?taB8twmDubVf9miJ0ZYfU6HLKx39m+CRYX/7dft347yELgnxkQ2WgK/+e+9T?=
 =?us-ascii?Q?7DfK8GXsKFS/YXAVfTox6c5M2BDvuEmdnDPH/VdYUb+I/cjYmbxjsuAvhgLv?=
 =?us-ascii?Q?PDMyftDaroD+8LhBHFCXnksqVmduqGqnGQBvNkeBwIqYk90T+b5xzWSMSyx1?=
 =?us-ascii?Q?ECKZ6L9EqRWdQqPwpt+O5XD+Nz7hirvLECZ2TD2JJlQFXO8/gxniJv+VPrwx?=
 =?us-ascii?Q?KZO+ucax3b50QPfpD3499/2pO0YOp77enzITiRW0fFjIyy5rl48HcRtS78Zx?=
 =?us-ascii?Q?4Dj1rGLY2kIIRHvZCT4TqVmCN1hNalDrwc/5kxY2iL6kXLBmT4J9FXQF1E6T?=
 =?us-ascii?Q?TtZvkRrUqCpZS62hmg3ZXh+Sc6Dswi9+HA81+Ueh1vheXRMONJWUV6y3M9fk?=
 =?us-ascii?Q?lXD/4crGGB7LRsmTaCjkCGxOtoxG0kl048nPFAfilFn2knPCyD7dGOiKbyH1?=
 =?us-ascii?Q?W5eyotO2dNmt8iy5+zENN1MGGX1VX3Ji6wQQePNMUoV307Tg/xDh7MxDLNk0?=
 =?us-ascii?Q?LWRN583q31xEXHoUUqrx1Sa5Uhn0rsUY4qhfw4FKeMF2WdECeJfcO91LJV63?=
 =?us-ascii?Q?3x/TyzE2cQffQgrn4o6WxCMxcMdeWDdScOJZEYypjOgRJkdL3KLZm1r9P/co?=
 =?us-ascii?Q?DfYimv6K5ctjl4lunQjV2jqT1oqDdrT5un9Qz5fXPWFp4Nr7qlT8dEeKXpyy?=
 =?us-ascii?Q?n4GQZogdQnVSa5UtrW3BUPY4DuBp0KnmdcMohf4WZQNkvtuV1WHy09eePSSF?=
 =?us-ascii?Q?SofWiDnW6aXWpi6WXoxNfSVzc6gf/G1Aycd0XqC//wa+q//5LHfkYMV8dxPi?=
 =?us-ascii?Q?sPOFWqK47h7SBtXfpH89P77h9R61zEcfFeMADIWyn+Ehx/k3XycQad/gCrU4?=
 =?us-ascii?Q?y5meeFW3JJsoXnTOWnNVWj45ZZz1teykRJ+i5wNOV77iwBFZdLv9pOyTIsNl?=
 =?us-ascii?Q?Jg70zVX/U7Fe7OvK+66STDt6d6izG0fsBj7ZcmM9t135Xo2+Gk9z8eYNLSOh?=
 =?us-ascii?Q?jghSehgWkwbnQLcKg5nS+Q1m+Sx0ExLXH96zw/6WA2dmBp6BXkxM4tZT075O?=
 =?us-ascii?Q?yrK3QZyCOgLRxROucleEF2Ix1xU+6JC3wkfPL/7475L46KVTMJvL9hvG1k6R?=
 =?us-ascii?Q?I9l2i21K1+B//XASJs3xNEg1F0vvuHMPnjzkYE4aWUgSWnauSqn2NN1fmVW3?=
 =?us-ascii?Q?GtfR5slpJrqjOeI7k7ibF7OdwTqKtzzk73wKe9slYO2YiF3B2H+hsrANDLUy?=
 =?us-ascii?Q?yKkbDkb1iG4NxEMpRViJJ3NBXRqvH8UN6V4FFAFBM04+FhGBFjAi7eZASwAE?=
 =?us-ascii?Q?EpoZTf0v0UjRE/6D9g2dOZIphDmYl2YAuwQ0ZeuxyzcNZKgsiSBuCO4RakoD?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?D3qZyfPXygtt7xGMjxVu3WLXm8JD4jhBT9xbDsKO82u2pexUpliIcB8aBfmw?=
 =?us-ascii?Q?ZVRpPz9DKb6OLTiApq5GZ/WIRIpiLV97SyVdolBENTzLgDJ5O7Wmc8/sDl2w?=
 =?us-ascii?Q?UQFB3m5QQcegrKSnh98DmgVPIu+w4GQkVXGfKvqjGuVKDBiMVU8UkRAx7DYs?=
 =?us-ascii?Q?K+dHr8D376TD63ZcipxTJ1dVPwbAcig6GkhNyac+txk06eR8q0hJjHmL4+Nq?=
 =?us-ascii?Q?9ihKtHfnaIEPDHm/bgMWEooBLNawmAA/fAcdmflCGFifN0/+Q9JFeOKBr7tS?=
 =?us-ascii?Q?1XnWVNIyg8rIoZ62vz2gEC/fq4rmcz/Nd5w9CVoOWDyGjC9I4Ng39gF1dVKq?=
 =?us-ascii?Q?hyXZBmj1cZRrqLlpVnYgDdhtPkePSPzYKyF4zpyiL7SF9VMZaWJssUioMNIQ?=
 =?us-ascii?Q?4X2bwNtua0CbyrXUJ9kmdjJsQMPV3fEOi5AIUcfWpfw74rXNafBWrQBY5slK?=
 =?us-ascii?Q?ppwjQRePRqpz95gP05rPzDRq9QQHpgyVgBtJKHzQUNfjhhcYJtgPyNGsVp+v?=
 =?us-ascii?Q?YeTrM3ScTvWPUDbvbMxu2v/02Yn/YTycBIPSN5cOHTItB+O9fHQsB4LD8zwe?=
 =?us-ascii?Q?/342BwIYT4MHIH28VvbBPPnGsQ1DO5q/fr+gOVnS+XBfRw2fGTW8Z0naH+EY?=
 =?us-ascii?Q?I09nrCnngAaQalLtDTNcGMp6/SgN92vd8xCkIZhBxhrgau5/9TnIkBHJMNz/?=
 =?us-ascii?Q?Tn+c5oltRo8PicEbR0NoSsqrze6BuHUvz26dQRlu0tPITMSeEd+x0lUZsgRs?=
 =?us-ascii?Q?M/H7HATkEUJq1Exb4SLiVrSDyCGtdVTO2nvU12FIzJheXGt8GwPddSgcDoM9?=
 =?us-ascii?Q?FNKP3wZKizSmmJ7m2Fpp1twoooXigK7y2U27ud3v55YW5RPM8etsFeIIeXtn?=
 =?us-ascii?Q?ilS6lhWM3l00iuppbGmGuHwRVVaG2DIjP5fFTVmuXNKEbXjI0/LvIoBaxnrM?=
 =?us-ascii?Q?YnkNvNk9dHcKOklmaomQzkIVO71z/DLhG3i9I8rxIDzD8eJCc8v1T5gCn4+s?=
 =?us-ascii?Q?dIuCEflV+2guY2hbX/ivY3OhdcMYuq8VOTk94brE/ratof/XQoGo+IcPD7Q7?=
 =?us-ascii?Q?7OCB4QKRhCCWuXEyPY2w5uBPmrcR8ClBJ40SxX4MAJ+ogIs8q6VSj4DnhBBJ?=
 =?us-ascii?Q?hCfRj4ZAl9dS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f78125-a4c6-4a12-02d4-08dbae59563d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 21:44:52.6340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IcGPDIz++ivtslhqJHdGTUImehjDF6EjjsJwMyB6eG01+BvPqvdsDufovCYAYI8UPNBSB/64XvVo0l/QvCUtpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050189
X-Proofpoint-GUID: RFDLOWTO6skv1qnA9hIr00iahrAWKeCQ
X-Proofpoint-ORIG-GUID: RFDLOWTO6skv1qnA9hIr00iahrAWKeCQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the hugetlb_vmemmap_restore path to take a 'batch' parameter that
indicates restoration is happening on a batch of pages.  When set, use
the existing mechanism (VMEMMAP_NO_TLB_FLUSH) to delay TLB flushing.
The routine hugetlb_vmemmap_restore_folios is the only user of this new
batch parameter and it will perform a global flush after all vmemmap is
restored.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb_vmemmap.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 8c85e2c38538..11fda9d061eb 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -458,17 +458,19 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
  * @end:	end address of the vmemmap virtual address range that we want to
  *		remap.
  * @reuse:	reuse address.
+ * @flags:	modify behavior for bulk operations
  *
  * Return: %0 on success, negative error code otherwise.
  */
 static int vmemmap_remap_alloc(unsigned long start, unsigned long end,
-			       unsigned long reuse)
+			       unsigned long reuse, unsigned long flags)
 {
 	LIST_HEAD(vmemmap_pages);
 	struct vmemmap_remap_walk walk = {
 		.remap_pte	= vmemmap_restore_pte,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= &vmemmap_pages,
+		.flags		= flags,
 	};
 
 	/* See the comment in the vmemmap_remap_free(). */
@@ -490,17 +492,7 @@ EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
 static bool vmemmap_optimize_enabled = IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON);
 core_param(hugetlb_free_vmemmap, vmemmap_optimize_enabled, bool, 0);
 
-/**
- * hugetlb_vmemmap_restore - restore previously optimized (by
- *			     hugetlb_vmemmap_optimize()) vmemmap pages which
- *			     will be reallocated and remapped.
- * @h:		struct hstate.
- * @head:	the head page whose vmemmap pages will be restored.
- *
- * Return: %0 if @head's vmemmap pages have been reallocated and remapped,
- * negative error code otherwise.
- */
-int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
+static int __hugetlb_vmemmap_restore(const struct hstate *h, struct page *head, unsigned long flags)
 {
 	int ret;
 	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
@@ -521,7 +513,7 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	 * When a HugeTLB page is freed to the buddy allocator, previously
 	 * discarded vmemmap pages must be allocated and remapping.
 	 */
-	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse);
+	ret = vmemmap_remap_alloc(vmemmap_start, vmemmap_end, vmemmap_reuse, flags);
 	if (!ret) {
 		ClearHPageVmemmapOptimized(head);
 		static_branch_dec(&hugetlb_optimize_vmemmap_key);
@@ -530,6 +522,21 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	return ret;
 }
 
+/**
+ * hugetlb_vmemmap_restore - restore previously optimized (by
+ *			     hugetlb_vmemmap_optimize()) vmemmap pages which
+ *			     will be reallocated and remapped.
+ * @h:		struct hstate.
+ * @head:	the head page whose vmemmap pages will be restored.
+ *
+ * Return: %0 if @head's vmemmap pages have been reallocated and remapped,
+ * negative error code otherwise.
+ */
+int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
+{
+	return __hugetlb_vmemmap_restore(h, head, 0UL);
+}
+
 /*
  * This function will attempt to resore vmemmap for a list of folios.  There
  * is no guarantee that restoration will be successful for all or any folios.
@@ -540,7 +547,9 @@ void hugetlb_vmemmap_restore_folios(const struct hstate *h, struct list_head *fo
 	struct folio *folio;
 
 	list_for_each_entry(folio, folio_list, lru)
-		(void)hugetlb_vmemmap_restore(h, &folio->page);
+		(void)__hugetlb_vmemmap_restore(h, &folio->page, VMEMMAP_NO_TLB_FLUSH);
+
+	flush_tlb_all();
 }
 
 /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
-- 
2.41.0


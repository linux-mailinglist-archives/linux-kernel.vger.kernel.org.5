Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A32788F1D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 21:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjHYTGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 15:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjHYTFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 15:05:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28B12689
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:05:52 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PIEo51009220;
        Fri, 25 Aug 2023 19:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=IaKcsxb0rORIYwEUogPfq5hXZgITbUVS8py0jJm+tS8=;
 b=xGHrmpjRHuI4SZC9aEhUGA0vOyePfNynrPdGtR5O0oCvqwmF1se1t0bEu/rm77E7cJ0Q
 Dl2geZMi6P1Hndvel2G7wrecV1P/xxvrzo4gPLFm7d2lCjYP0O9/a5fBwl0qLzFMcnVr
 46b5RqXXZvFvmjSVc2SvQcWWimQi5jC6tslA5TMFcsZEjcspRuiUWSQzWp8qhz7Ek803
 MdFSacYj2DrrKolaH09A6XX82XG7eEVahUE/z3WPwmReyRy+GZSGPMPdlTWm6h3zhk0F
 6HQZ1h0v5G/TVjo9Q+YnBSmRhoUNKJZl2NUox7KkpK+Jc7O6rTFhZ2Afr5cqT2ecLjx0 6Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn20df0ss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 19:05:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PINZgD002154;
        Fri, 25 Aug 2023 19:04:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yyg87c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 19:04:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iW5DcikoTA78u9+ccEbN2VYVGLJbVFfbRtNzag6Bn0qxGSX0BImdca8IAyt29D3U30Bzr5QdySfm6auaFFeATCnKcixEskHtCl7WrixtdLbW+PYUo8aHl1rlZmSGQEA5Koud39YBtzRwQdOYvXiHg3m0qhOU3Yuv3QFzG67f6u8EgE4jEuc8nmDFsYVuOtMivwYibViUsPYSRupTgPAuY0VynyLnCDhXoS8de8eHxJB1SuTrLuHHZWRXNcplOStxkx9fm0a2/zECzmPbpIMkMrfABVbG99cUde/XvRz3sUMfpHUpVecvyzj24SXF+MWKj0CvJNS/eWNF6tcV9QIEVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaKcsxb0rORIYwEUogPfq5hXZgITbUVS8py0jJm+tS8=;
 b=K1CkCPj7lh5kQlLA1ihj4um3wmpx9DY5RwYNs/zuxHCKE2EU4OBdr36QTgcnwghzqI1jESm0v3LE36BZkWZUrQM+h2LjIvavWiF3/iBt61voGUhvaokWvjb/UfVhWeaMESz+Irwu/2WAij4uhYPEjkHj2A9zfm9gJaPu7cyFWIfKDJ84gCPUNBkuuP/NQC66lK9C89jjRE6nxtiFuAJK0iC+hp7z9PU/DlWJVxTb2uuzCrkFdnyAgw3bG+vjwMeCycxAxCmdjxX1rHtc3ees235Dr0C71zapuWgA9UTQjfFzCDdyVQslOobyXYo/X9nQIPlLs0Um04Yi52JCg3dEmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaKcsxb0rORIYwEUogPfq5hXZgITbUVS8py0jJm+tS8=;
 b=hI4Y/O0qALFameayMJqP+ScXqE2PGpVnVUhrxPui+6KD7R+U5NFoSFrBxfluErZ7Wv9si+q6ElZiT5GQU3Revv2c9wMpi6uDWbHaL2+ttIJroKfAKItWVeCysoAQW8T9B7B7Oey132R0QqPrbqPyQl2alYiQwtJl6lMPvAeR05Y=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by DS0PR10MB6895.namprd10.prod.outlook.com (2603:10b6:8:131::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 19:04:47 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::8057:a3e9:cbd1:252a]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::8057:a3e9:cbd1:252a%4]) with mapi id 15.20.6699.022; Fri, 25 Aug 2023
 19:04:47 +0000
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
Subject: [PATCH 01/12] hugetlb: clear flags in tail pages that will be freed individually
Date:   Fri, 25 Aug 2023 12:04:21 -0700
Message-ID: <20230825190436.55045-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825190436.55045-1-mike.kravetz@oracle.com>
References: <20230825190436.55045-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::13) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4201:EE_|DS0PR10MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: 95a40a7c-5363-4624-817b-08dba59e2671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yP3DnUyfzMA4oTljGSq/AmrA+/3u0aNjm14qs89BR7Mz6d3/040LqmaqMne8G1kl8fqgFqFXFGbiKTEBU2QmnQigbydAc6orUkFlIpGP9EAj7l+4Iuwem3lOc4xAxxorrdQQzqJ6T5gcSdHQxSTRO7xHaK344ZN1AALSCXXz1Pw+Ei8P/uCH3sDbNX92ODvGNgFq0cp7sez75JHfB38TFvIAJIypBO3GAvbmgZFnCIyX0Hh32Ih56pJCltPKbBVACituLkmPpIU0z+DTe4rRohWVMaGXN3yvkiwhbrEoUFk4cVmbNVdefEIHAlMFm5Ycxs3s9iOUKSRjFhoO3dFTXsv/bGJJHK71UYdq+RyBdid9+mjI0kn3BeTvfjLhVefFnXoJ7j8crNsvO9OOCRb3oDGQzoQVM6aTjZEVd/ZVKyPfYor98jnpfuMqibX/DiU5qtVDfJRVgpfn/jwGYUlPsXebI6hdrxa0Q5eNcWIOfxMfUyiwfrzF+9Oi+sb2M43gV+efRSRBiCkq/wcOctc9Em2Q9xyOtxQjO5kjPh9Ww7zHsRlm5KKL5rchdcPRYNKY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(186009)(451199024)(1800799009)(54906003)(66476007)(66556008)(66946007)(316002)(478600001)(26005)(38100700002)(6666004)(41300700001)(6486002)(6506007)(86362001)(6512007)(2906002)(83380400001)(8676002)(8936002)(2616005)(4326008)(107886003)(5660300002)(7416002)(44832011)(1076003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gbYYzec3acpvkvv+xt1dCMgHomCJZpfIZ9VGWdtArL61Yi6jJbneOG3USNor?=
 =?us-ascii?Q?KXbUK9foBJKcCUiL3nsL2AG9tTZuW/TxL/drExCxsnoD+OVtEy4sbz3FRGPd?=
 =?us-ascii?Q?D9fur6M4DgiX1hbtGttf30n2T/LibvzrYHzqrZsz7AfyMGI1eilOpulOFKfH?=
 =?us-ascii?Q?yObV4Hx11+1kJ2at6jpNBkfx2xskhHuY/ogzhGqofQz5/vpSYMrqUqU9Npdo?=
 =?us-ascii?Q?zrmBp5O57FvSaSdSenCQP11stXEbGgQnOiLZ7i7cOcKYsDFe4a0jant02TmL?=
 =?us-ascii?Q?dO6Md1Bvih3r+jtuEKPdv9hdtw3ktxut/1HtZBhdfuIEzGDeDaR6BruASUgS?=
 =?us-ascii?Q?z2io8peFRdzN8GL3QCDs+UDI5OP6IG5KTx6nI0h1yoc8dlOgBuBYHuM2iY0d?=
 =?us-ascii?Q?iGrmK1UbhbNCEcQNmDa6FkuPRA5PZuuI7BlW7dcaWGQHfJngoLUjQBbCOlzQ?=
 =?us-ascii?Q?bPGR5bkTjzkFWC5zb84mvBn1GoT0+CNFCgOBdRAr+LAkgc2PogTSYy7tiPJu?=
 =?us-ascii?Q?mPOR3t33wBUXEyDWrSi5sCm4JcIktkRf2HpcBj7r6lJoodgbabIX5wQOQ7pd?=
 =?us-ascii?Q?c+3oThAHCLZOVOwrCzGOMNoRxcjSidfDZNilRzdZyXQ/rkxgO/tJ10HfXQPF?=
 =?us-ascii?Q?bjQl10Otq/aJVWygzw/iKiSJOuAhRlX9nJhK6XpBPHiHs2PZSxAY7PrtqPzM?=
 =?us-ascii?Q?qkmcAb0SkTbAUuXm6XJaDeLoTdnOPtMARBqMTqtxdhIWkIf7Mf3c8xXvsIGt?=
 =?us-ascii?Q?NVjf8Q7ZwMPkiqqYDG9NbdtZkNldVRzgTbnS0nAia/3NWxUOchfyTr+BCWg7?=
 =?us-ascii?Q?0I3r0fQzAhShfO9ErJ7eLRn8H9LAaAn0K9SHXKpZHl2109AviA1MEac41D5D?=
 =?us-ascii?Q?mCq2obtPe1yCo+gc7rXsXEFtQSmo3j3+QM+xLUx4QHx2/Gp/x7Ez10Gf1JNl?=
 =?us-ascii?Q?DC2IPf3wDww/pZ537E8p29uEm4tDpNxUQkifIBHa3iE76GPuLsR6t/FGzuOq?=
 =?us-ascii?Q?ZwyG4jkABwZBYdJ8aCIfXQWxTDYZNieovcnhsPvsQim2G4Ano4MRcRlhvkmi?=
 =?us-ascii?Q?j40j2ljMmKmP1HhI7nNZhTmPmeh6uAPKqGGDhwrdH9hU2XiIZs0D8dxFvIRa?=
 =?us-ascii?Q?7DkqWsLZcOQsuQQTQhT0MZehkZuttIYrsLS+beZWz+szbR6hfDSxbz/dePTy?=
 =?us-ascii?Q?h+ry6CbrZiU9zcgeBU9W/l1DXLrHnyoMEWXDsrNrwa5NzNSzrW8Y9jSHf9LG?=
 =?us-ascii?Q?2d20DsgTmWOMmYgBhdaWUZVYgKkjK2JFX4xclWNIx7308X/ki6KhG7g4uzVr?=
 =?us-ascii?Q?YBssyJkaYUxux/QOZ7LNubBC65yKqcAtq6ANTu2DDPhLpJphMaDi/A0dG5VJ?=
 =?us-ascii?Q?XF8KdiA0zin8+4iPu3u0xDY9UZtlzDqNGUwqzyIj3kNwFSMwxQ6GhmSsS5MM?=
 =?us-ascii?Q?BkBKEotfhKwzBlwiFxPYke7urjVRQWwQLHwcBAb0e5x9vHOgiv+UOj862HHU?=
 =?us-ascii?Q?jbDW0D+G18ZUFXytcsHE2GmD2UVC0I0ZU222jlCCuCtM4PyUyV2yl/UeEeML?=
 =?us-ascii?Q?lGLk4lifIZLFcv7BYwxODEYRHTvasFRU/I7braoFRevoxFsDjT51rmB45zkK?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?mzIu7qk05iTRn6vT7c6E5B1QYvfsUZIyAeq6AUzsp1A7FLoTBCy+Ci3Sdb1S?=
 =?us-ascii?Q?MaXhICJcm9tSUGGfsmnw8EQ0meMkoRvf6QWHSuLX66tsYjRqOgyVnT4LX+ZM?=
 =?us-ascii?Q?fDe+lp9FMaNlueEWRiH+yW50WRyYbj1oQaQ9ZEZLcXHiM9eB13Uw5KNkSMCm?=
 =?us-ascii?Q?5awsZmKnsCXJXWz8YzGn9VMdH6EPxM+Kf94+f0Lbb8MBI8r4gVKzlLwkoQ+h?=
 =?us-ascii?Q?m0nXwU5TNfGP2T27XHmnQe/CnaRgLOilNcmeHEpsqR7WGNYkj3VsImd9FSA2?=
 =?us-ascii?Q?yNMspvdkogETD0JHiVqczOdhMmYEsqQwpEZ2AcB1n6MpeEtmnbi6xV5aUTNH?=
 =?us-ascii?Q?LMhOobmPh0LmpM3adiGG+WI8p18J4ytuf7rTHxFQ6v71Z+F/j5Yoh6AdZl6e?=
 =?us-ascii?Q?I/3fYNyy2N0h4YTRt3Fc3CG9dqoKO+jtApOXQhXZYNp99zi3T3Vp/mggMn0n?=
 =?us-ascii?Q?U5CnBKmEdT/QdhYnVuSwliTc1G601fvgXQl7UKUpN6viZf+piVxCd5AJOrLa?=
 =?us-ascii?Q?VwGCIS3CIQjay4H+T2pVTVnvmTce69MbU9rO8x1+D4gAQPF3P3UEosKv03Vg?=
 =?us-ascii?Q?drBoPH7tv9Sf+bPJSsNur4HdKj2uvXhzovBSBauEWJC+69Pmf75i0w6unMaz?=
 =?us-ascii?Q?qta6ZcrTg4VtvlL4YvOporNsSDpgZonCn33eT4MPvP/LiEjNeXDPTN8RpKCq?=
 =?us-ascii?Q?GlEJVgdUPJMbpX2fmiEaitDFwGbAOdRsSRzPM1A7/EWy9QO+3X9SMlZBU0Ji?=
 =?us-ascii?Q?+deY3IuTcfQSreSB0zC8kEliyRpE7kh5hufT4dyXFXsXaxsYFQ/BdxesP6Nx?=
 =?us-ascii?Q?PTtmSEbHHbDr3x6ZLndzISDaDGDYaPf6CcK+RjVCrrBeJIZ/OrYg9wHmroNe?=
 =?us-ascii?Q?LRUhJpqurmdNUjAfCrVQLONAVqnCyp0mbMK/CdduXmCtxL31HuQYrfbRpfzN?=
 =?us-ascii?Q?PeQ5rW8H7VLIQ1hbFS05NtIcWq1T3yTvK5iIUoqdlaKLFyirf96nAzfv8Pff?=
 =?us-ascii?Q?FGEQXszv3nDrUmOuDmJlsX/uCRzX2SSd9LemsO2ETPPNoBgxNAaXvdbnsikR?=
 =?us-ascii?Q?xJCmkbBayfNUZ0ADrdgZISFEUS99EqW177+YUPL72RGcUFXeIq2NgS9c6xtg?=
 =?us-ascii?Q?n68LCMGIOZNA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a40a7c-5363-4624-817b-08dba59e2671
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 19:04:47.3441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tzXB29o68g/CAMe5RmHwZw+C5GlRk8ogcsrK+e4jDYuVSRtyyMgOp/18T1Q9LB12PbH+PndMRTKUD7AHYbqVZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_17,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308250171
X-Proofpoint-GUID: 3i6DDmuniE7-GNmQInzbcIkT2a_yHKJ7
X-Proofpoint-ORIG-GUID: 3i6DDmuniE7-GNmQInzbcIkT2a_yHKJ7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0bf70f27c1ba..ba6d39b71cb1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1489,6 +1489,7 @@ static void __destroy_compound_gigantic_folio(struct folio *folio,
 
 	for (i = 1; i < nr_pages; i++) {
 		p = folio_page(folio, i);
+		p->flags &= ~PAGE_FLAGS_CHECK_AT_FREE;
 		p->mapping = NULL;
 		clear_compound_head(p);
 		if (!demote)
@@ -1707,8 +1708,6 @@ static void add_hugetlb_folio(struct hstate *h, struct folio *folio,
 static void __update_and_free_hugetlb_folio(struct hstate *h,
 						struct folio *folio)
 {
-	int i;
-	struct page *subpage;
 	bool clear_dtor = folio_test_hugetlb_vmemmap_optimized(folio);
 
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
@@ -1750,14 +1749,6 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 		spin_unlock_irq(&hugetlb_lock);
 	}
 
-	for (i = 0; i < pages_per_huge_page(h); i++) {
-		subpage = folio_page(folio, i);
-		subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
-				1 << PG_referenced | 1 << PG_dirty |
-				1 << PG_active | 1 << PG_private |
-				1 << PG_writeback);
-	}
-
 	/*
 	 * Non-gigantic pages demoted from CMA allocated gigantic pages
 	 * need to be given back to CMA in free_gigantic_folio.
-- 
2.41.0


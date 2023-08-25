Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0577C787E48
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 05:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbjHYDIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 23:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240684AbjHYDHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 23:07:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94A2198E;
        Thu, 24 Aug 2023 20:07:41 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37P2T4Yb030087;
        Fri, 25 Aug 2023 03:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=9epev21FJ+Njrt8angRFDLIcvgzeQMTdjM+LO8uPk00=;
 b=cy7WjowrLRy8v+2A5uYiacCNXT0oJ/SEsZV2BKE+Rz2KJtNYT00idespTdmRU5j49OAk
 nuSnSbDcJMcn6AFPu1qu4Q8R23tj+ZhGMVXsgyql1SMvJkYWhybjqpduT0gmnNQfBQoY
 C8Jz9ppuQ7ccjjhXI3RQDLunlhg+iDn/8EWPPOW8P7Xj7zLjWGT4ZH4ddXQ0nWXI0p7r
 hBy6Xy7RRaqItb0fS7fdOTWaJzZysHiO2RhxOpAyXw4OVIxp9cJrlI7inDxpE7+hERXe
 SYZgfpxUsuVmwGFx5CNzgbFRW+JyWK/HYH0oHJVEiDSLwSwGmYcRgTzvxKBTwNCUrcc/ zg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yv5j6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 03:01:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37P0JBbC035652;
        Fri, 25 Aug 2023 03:01:02 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yq9g8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 03:01:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ms5IGkhtg4dNStt0rEys7n/sXbh7HGc/zfDwVe0ml2+rnOQSK5h44siak8gBPzISHdQVl4XI9G8QWNy437LeMUOJWXZhL5NJcn5TGn0fsPlPK1PlWu06GmhBJ1HgqeR0UqdU4b9xDVPep7sLjZSsNgl8xH2Fcshhq22cMBC/SolQ1nPqsJ1wO5pN1wvivn7EI35Lb6XXbivqEyOSQB3wzhqp93r8L+bvkiAvAVE/iX2psjTWY247jxkmD+jenSKaxM3VjarMhg8Ghs08wK33qfyCOnYZq/33nE5eDUF+KzH0QRpLiKpmX9oB3bM8KjocI+J//e8UwZEyCtOc0iW2zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9epev21FJ+Njrt8angRFDLIcvgzeQMTdjM+LO8uPk00=;
 b=X9jrfXwRFUvMH29uEatJAXsNnGJr+wrIe7wrdXkn0zBSX7ynNKeAF3A94gfvmVUthUmkTjgEnJgROkOyTY+0WauVSnHMJ+MULVC81gv67uUzXxrnK+hnutiiumBRXxiWr2aJcFwTnZOlZsX3gxl/O1kJvak/FqLZAUYFrwMB/pst5WmaSSywiWbD64aaAcJ5p2rF7O1j+5JGzSHUNKwkaJCO44hAyQWdqvaByGF02Ot+YmT1Wz3cXKSRJP9h043PyEo35xDmG2evXRS8Gmm0RKtHD4DLFc5Lx4E6eVFDxvHsB3f3BOJ8ku2WxWJEtmVqee70oRyfEn0G7+Xpk+54Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9epev21FJ+Njrt8angRFDLIcvgzeQMTdjM+LO8uPk00=;
 b=exrenK31aE3fuM4f+zJHyz5nouWkehaKZXhgk5dA5NWYBs0NV68K1YKv51U34CsytnfL1Wbq62ccjldj4zhErzVUzPC5fazbPUqTAGIvOpVBEdswHO5BBPj2Qmg8L4DAzL6pxN6XhlgE2yhZUQ4vrgjvJDtx2sOXxu/7bKzKLVY=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by BLAPR10MB4833.namprd10.prod.outlook.com (2603:10b6:208:333::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 03:01:00 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::7f4b:5874:8553:55a6]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::7f4b:5874:8553:55a6%3]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 03:01:00 +0000
To:     James Seo <james@equiv.tech>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] scsi: mpt3sas: Use flexible arrays and do a
 few cleanups
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1edjr25ed.fsf@ca-mkp.ca.oracle.com>
References: <20230806170604.16143-1-james@equiv.tech>
Date:   Thu, 24 Aug 2023 23:00:57 -0400
In-Reply-To: <20230806170604.16143-1-james@equiv.tech> (James Seo's message of
        "Sun, 6 Aug 2023 10:05:52 -0700")
Content-Type: text/plain
X-ClientProxiedBy: SN6PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:805:de::23) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|BLAPR10MB4833:EE_
X-MS-Office365-Filtering-Correlation-Id: 16076697-2688-4666-7fc6-08dba51782d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6fgeUK1ShweOEEbitla2vGIeIRlSF3bS/e8GMsUezCLh86j9s9mlGy7c/++K/cTOdZLnmVkGA+9BFNrmqnqWWO6pSt5KZRPX2LBVLOyxZ22Pcaq5b2Woj2utCPqOdtNwEVGVxfWob5MLEw1qLXjP111vH92PjylULt0whCrcDQQiDnJDHawKHTVEezDNy3FDyC2MdYOLrE9edw+5wxosIsVr2sU2rHT+1vx7X0GrGTuK2dIRqE0CUkJdW4/WEUjfdMNKrLSSw78o/2bsEU/5DobXayeNz22Bfe1ptZrl2eDzlxePJiGLfAYv3IYDI5m5KKrFuaMDlEqbRz7TTixqOtPbTo/5sGQ3jQoFh7QegaHqEIntO488X0Qg562A0y2vZW+KWozX5TMorIkKa1kerWadmHS8afnDGBqZgpnwJ2/RU+ZDjdjGNGkch0DDNGd0FIdWUIZYIR+g94CHCTcfMjb9D8RZtIwKb8rr3lM8EPGeT2mYBx2z8OYFhbewV/2IRfW9fFNectwjqt+XAej4f2uKDiPTLmpAGusGZM7l1RIZLwwYX83P+zIFRXHfN2v7kmbU2lj201dWwp10h/vyUW64StVZHpOQrcnkpzlVMSs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(136003)(346002)(186009)(1800799009)(451199024)(5660300002)(4326008)(8676002)(8936002)(4744005)(83380400001)(7416002)(26005)(6666004)(38100700002)(66556008)(66946007)(66476007)(54906003)(6916009)(316002)(478600001)(41300700001)(6512007)(6506007)(2906002)(86362001)(36916002)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YB8YrIY+2LMLWRM6dneum5Np5b8T9S/a/FAILNyiE2TdPVJYh8i3Ql8vFRrT?=
 =?us-ascii?Q?SjSFY6sotLeq43NyfUhTh6tM//L/1qDZ6lP5EH/8bL4mmTsyJRguRKXwWlcI?=
 =?us-ascii?Q?k1zhXvxC6UrfpTLtWSnm5/TkeA8smVSIwtd+6EyPTmVFntFPTpWgJT3wVQRq?=
 =?us-ascii?Q?KT1VsH7D0zxA2/ssGQ9exr90erH6WdayYp5uUySsRC3HpJ/h7xWO52u7jai+?=
 =?us-ascii?Q?PmlLgX6rHyy+4vMQXtZjMa+g7ZYh+DsGO2aJnu4P6hXP3qDvIXbWP5MYes8n?=
 =?us-ascii?Q?ezruq/FiNA/izHgXyYSdRarHHF6eYta6zc3V8FeEi7vNFmWmdiiuRX3BAo4v?=
 =?us-ascii?Q?fFhfGjV7heEdD9ac4qF8FEcJwcSN/lnlAIlejE1Wqivm5CI17/sBql7zyg7V?=
 =?us-ascii?Q?QGWmWMX4rAatq0qjbFObWPUAmsfXgXeVC9piymJoXD9gLjAk8FnyOJNNYrvI?=
 =?us-ascii?Q?E8623l5narn/3xR63E2OIIBDmDNhvu5Jr8KxMlD9x1BeI0zMYM8ZfXNoCjOd?=
 =?us-ascii?Q?SCovugB/82TjjdOnEZip6m96l935JbbX0nY4JrQ3LsXXIuUJ3L7Al9M0Px3I?=
 =?us-ascii?Q?MAf8ocf1LgobcLmq4f1bC1W5eVB7UOPADuM3YE4AIMXlDfyDaoOcJ2vNE7PZ?=
 =?us-ascii?Q?/99Vd+w77hymhO+g85bmQ5TKBIMC7KK9pCYOUgpQk1EvM0lJQzUOpv+Zg/jg?=
 =?us-ascii?Q?Y4CC1Z1a1QabOlOKztrS3BlAzqSzashPxLpSLI7sAjzDXekEVBshboC5bOni?=
 =?us-ascii?Q?GDW52DEVdGMZhcbn2LouByPIgKuxeEa+O1DMDIPha6eaBdGejKBoCmhGEe94?=
 =?us-ascii?Q?lrBUpiO9HnBRMwD+BENuPKbsq8X0q3UDe6O3ZzZbh5lEufv78M3uUZs5JLBG?=
 =?us-ascii?Q?AVNIdE/ACcqfIkyW9kdLTTzS/5GeqsQNShoq2uPJqIf3hySMwFyFdXqLWRZh?=
 =?us-ascii?Q?scq3Gk9Z5xTosr86cX+64Yd8PJxQ0qtRmNmmd0YhT96ejZJkytWQIJfi5aPc?=
 =?us-ascii?Q?LjCMnDBblGpA//o6Od8X8orJqA+teNSEmOxiwkCms8nzne2fUlCWSazP6dAT?=
 =?us-ascii?Q?4BZNiTpAexOATddauQuPlyGe+Bdw7mM6P9mL8K7nbLzwzLUHOPRB38kXuLDd?=
 =?us-ascii?Q?1AmWOy72rpmQEsyi3o6SErz3N6wrE0AEISOAbV/G/Dy9lzy5QlU5Cm+un8oX?=
 =?us-ascii?Q?R+iEhqVr5gUxBancmdXN0j4u5xKPsxjCxrNMDVgJqpDf4ZpoLnTE11qlAtIK?=
 =?us-ascii?Q?AdU/5LkDrNHMTO9KGsUGV+Ckl+tdYFKYq3Y8B4tvsQQQy6hWA6DBxR8pgWhz?=
 =?us-ascii?Q?vhsO9mcbM2v91vbtH9zlmaKaILOpKUZrsZ8pATu6o101Vq29wiHFp1VQPYgh?=
 =?us-ascii?Q?Clo50gIdNBydQCImtINHXPh7olkCbrq8+Zr4ytycv/kqh/TqJIPuSfoL+r//?=
 =?us-ascii?Q?AtVTMaCNGDVIPEw96ukVtIaQgRSzUDiLflIJ49RZB9IFw11xldNLDlyLdBPG?=
 =?us-ascii?Q?Z3fohkVO+QUabb7wmRf7qHB4jFAFfo7DqJ/zqb+FdjcIYi/NUdmcjYxrcgoa?=
 =?us-ascii?Q?6VrgK2ouPWkOL9l1yIbz3wx4x6I+la9Li//VQzWeOUZgXIF6vFece5OSUbxf?=
 =?us-ascii?Q?dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Sv7om8QRy0KEBjJwewj6c6ccC5kMAbXjoc+1cWGqJ2elSUaTYuZ4ZjGzNqqezSuT+K2BlxDM2c72l4j6ujfSXPypEvLOvz24hdfoVo+yxZwuZ4qaKMXn+RRDQU9SetcWUuKbQVw3oSS1URas+88OzbzT/00i9r6C/HIEKfOStEdLhCoXJ2bVwOIbqtZgZgNQo6Fvjy9IgK50wlXCK8LJjW0x1M+8g3vm6h/1Sz1DKfaybUIYVC8xyOtZoXlP6H+lbLEQk+yuyQhifjS76ARgFCF+iQffJrUK1D3Ld9xBj6werxpz+JrIhW6Lh4ejFSaEtuOSa507nm3/BZS2ZNvBqbZTskn1cyIJc3VuEJDeWKDMgF29s+ydhoxpW4ojc4iZ0yXFks9KTjfyTrmmstu/1ar/NheP7ZGJHgn8iphGzpmB1oAt1IPtpU5bThX2qVzT/wSHkfdgwSgaaA7gCe/889zbKBJWN5lixR8W2ZxB+jmF6gVKyCEafhQHa4xn5vm6CZZW1Z1qS1Wj++acDiGq0mecEDcFMzIFMgEQOBW4KO08NzsUFcsq3dw8UbOZaxy2vLbzmVdmfE0dS3uFzRZZc4YIbwuFe1wnmKnSvy0pSTjIXkxjJ1JcyD8Ok+PKB58Z/QKI9Ft2xhGl0yFj88y8y8nnCXUlG7nEPS/PgFtpTOUO3YUHxzst7uv+ZuQuuEyl9lsjBEieDNUU0+ZaajHCr2BfMIxHWBLtbIaoCTfUtv/ghA0g3faBbPnrB2UeHAz87Da3/A7Ih9dBUn+i7a3j3J48NwdWzRMPGSpfFoerH1Yo9E/nVLVBOeWtpa2wFkADANqCCEaIVse+pICcUD3LGmRJydXZpQii6anHSUa7Y+GL1SxMf72xlqROKB11QUFnqI4luyWb4wvkgiPd4r/hIuOco9j+rS8Jww3la1OMrUY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16076697-2688-4666-7fc6-08dba51782d5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 03:01:00.1980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XxUgiNwCSYCIyswmaLVjJX0ABG6hycjwSsWLz1pLOk9GtTd5JWcY2ttJgwIiomkpPZn3Vedryzr/08vmmfVzO2sxpPFzE9yY/204KIV5dxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_01,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=984 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250021
X-Proofpoint-GUID: gEhYwq2aYWYxqYflzlqgH53h6G5yOgtR
X-Proofpoint-ORIG-GUID: gEhYwq2aYWYxqYflzlqgH53h6G5yOgtR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3") has
> resulted in the only arrays that UBSAN_BOUNDS considers unbounded
> being trailing arrays declared with [] as the last member of a struct.
> Unbounded trailing arrays declared with [1] are common in mpt3sas,
> which is causing spurious warnings to appear in some situations, e.g.
> when more than one physical disk is connected:

Broadcom: Please review/test. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

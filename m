Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A647EC4CE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344119AbjKOOKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjKOOK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:10:28 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B61C5;
        Wed, 15 Nov 2023 06:10:25 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFE3jiP001949;
        Wed, 15 Nov 2023 14:06:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Yv2ln5eiDA5qUdEVtCQjLwSezGYjsJspiaAOeq8XIPU=;
 b=pa7fkQhWis4ipp3a9w/JX8kb+KkEkW723n3PwYeaczCWIw/Rlaqr1Y7RdSgjmWNFmSLD
 X7Jt4/eAsl9Ig+jNwJYGNMMCF7VL/1q9PbamaRaVJ2U1wcoDprKQXBR4CXvfZU09flwr
 eJtoGNbdqD7Rn3jFE3hUheqWpjsKscbaGhBbt26jgsp+vs1rNxD7hXHlG1YLnKuoREWM
 H9euy2lc6fdZRIUSFcNBEdNlVCaWWyU3KcIeUA7wS5Sn9ShWAnDrqaQSSYXDToV+7wZk
 aS2y9kS/KTCmnAA7vxDCmmlm6kBBqW9+Q95kRiGcCRZsynEgYCdkA2qkBPhlBhOXLmBN dA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2mdrrp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 14:06:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFDotJh008724;
        Wed, 15 Nov 2023 14:06:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxpxvqfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 14:06:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBMSC1CvdBnO1HEaQ2tRFS1tI2/XJ5iXw+/030qhwHOwj0OYtsyPw0seTMs697qedIk+HUKPH9MG7F7/GMHmaGLgjw8pxhJD+U0wVCjpGJuTdtaiiUU7E9UVvDpRz2HU2tElypWskphJvfh9QzlHSGq1+xORQmg/+r80F6KYzMR5gHqmfUsCYbk2UybUrC/4jZ1j61K6yFEEjIWgGozfDiHRvpUDD8CowlGT5Ip3le82zBqpmbe0phaxfIIetME9hmntNjK4JMCOfMwkn2P8J88DoApXcxvgrxhPlNJ2c94PzlOcBqVUtYK0LRjCkyyyvDMZ5awXeN6mDVu/obR5Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yv2ln5eiDA5qUdEVtCQjLwSezGYjsJspiaAOeq8XIPU=;
 b=bPX9yVMt1KM2N9qBV457heUxIQICwEv5uthWCPZKr8nk1iI5Z32mkIeDGQ1LKO0OdBUogILN2++z7/wCL15+Y/5YOFoOpArZq0KXutxh+15YfV8haMp+NKzsQNNByeb+Ge35S6FhjS6qNRP7EkpMFBvumiw68j0PQWcJSjJUU+FbWnAILT/d2IkVVoBU6+4k9LPjjiV3YT/0gf+amfG/4b3yXiqPkkHCN8I4AWlHoNPeaUFoZg3aZ7TVNW5qJmuFrk/x+ca7rd4tWKG4+PniJ3WpPFzpssPEknyAGshhf4qj28PHTDA9VtGbYijRANgag3Xu5xzK+e3yY8a6J2F2xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yv2ln5eiDA5qUdEVtCQjLwSezGYjsJspiaAOeq8XIPU=;
 b=JCw3ihGJuHYku5i0LCdUKjukaB6QJjkkVj8+PrEO+aPx2/B4EsnKkEOyspyyY2Cd2yBREzmy84ESmYSyQRGR5LE0dbevW4CmbyA2nPXGQHDmACMZwLMZ+G8805NV5vDYXwp92T7wZILptuk0CLo6McHP53b1CYWQdR6BNzrK2Iw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA1PR10MB5686.namprd10.prod.outlook.com (2603:10b6:806:236::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Wed, 15 Nov
 2023 14:06:04 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::abe0:e274:435c:5660]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::abe0:e274:435c:5660%4]) with mapi id 15.20.6977.018; Wed, 15 Nov 2023
 14:06:04 +0000
To:     Justin Stitt <justinstitt@google.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: csiostor: replace deprecated strncpy with strscpy
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq11qcr2jsx.fsf@ca-mkp.ca.oracle.com>
References: <20231023-strncpy-drivers-scsi-csiostor-csio_init-c-v1-1-5ea445b56864@google.com>
Date:   Wed, 15 Nov 2023 09:06:02 -0500
In-Reply-To: <20231023-strncpy-drivers-scsi-csiostor-csio_init-c-v1-1-5ea445b56864@google.com>
        (Justin Stitt's message of "Mon, 23 Oct 2023 20:26:13 +0000")
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:a03:255::21) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA1PR10MB5686:EE_
X-MS-Office365-Filtering-Correlation-Id: 94221bf7-1bae-40d5-6473-08dbe5e40175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sn3VP38vVKER8MqKs6O8s3Y2WtJEvUafys4SV+x/GBT4KtdSfMbXBJtxLZft/2GJiD9tqqQhXE2T2t1zzC7ui8oLyv4MBZMHdVxtZYyk8yjGwWTE2ziMJOhZAUVrmRuIzp1VCiMkIXso2kppdr/lhOoW7001IJewn9ucfYXEqU8MRuCQEo68evwukWUn1vaoRsesTRff/39uj23O8bU0+bb4r7wq7z71fGsGTLq9UUnZz3I0bCK6GfvsvHvYFRJMLRVXO12qVoIm5dW9wuI76aj7/l7N0fhBzm0bRklNGXl90caQ1h1/zUkHk55DdMJU5dSOAA5p0qHXr9LGd/Fgrv1L1YMfsjv2uyyXhUTI2WXEdIEyG/l2qFIBhtouuIveTmRLeCjYgld7mSxE9W2yOt8uUZpW5g8eheTHDHdw/zRBOWXp8cbLiEo6Tuo6vEomA2rZt4NZShaVitFfDBXo5wLXmarfq/RtytzIlgwKUiXEz8o5Kgk8LSYoBeUFpdYr9JPZKHmtta77i4m9np8a6mdwlPWTsyXDpyVcCBUfCxnYMXyckv1xoI3kWD6wZNgBfZkpOc6OGs16iwDjmBevc/o7d4QKNTm5EySIchKvuS4LZrt1Ozuf6uRLfInXh34T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(558084003)(54906003)(8936002)(316002)(66946007)(66556008)(6916009)(26005)(2906002)(66476007)(4326008)(5660300002)(478600001)(36916002)(8676002)(6486002)(6506007)(6512007)(38100700002)(86362001)(41300700001)(156123004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P1Tvjg0+qoD35mxXDbxZvbz0urRMwcVTdnGSazfy5sxMQyH1v14j8FEwg1Uz?=
 =?us-ascii?Q?Yh5lvVwKBGnnsJU8s9qjTud5GuU1tsHuuFK/+DtMx8DeNlKzt/WzHnEZYLgN?=
 =?us-ascii?Q?H6xp0asSympJ3WFBCutA6zkt5HdhEZdLUkSZAax4tUOL4gWUqUlfW47Ota9f?=
 =?us-ascii?Q?eeCZK1j2LqlsR8J6GGicsbJGBVVngt7OpNj2SjUAuN2CfugWVQUQYO4ITbgz?=
 =?us-ascii?Q?ihRsLAQRjMVcfmqjFpEtLa2koV0wl+sCOF7+duTPSvKLZIBHaDD3GHa1dI2T?=
 =?us-ascii?Q?sBhM69/xrnx4NzrH36Ogj2kEwjypCbnyg8z8VF9k0c9aiF0a+bW1FnUJKBRt?=
 =?us-ascii?Q?aN4q1vmUoBGSSY2MTo6YCgXftx0+7swiVodt50jsg5N2CTOo+meuInNwMgZN?=
 =?us-ascii?Q?0x1gbncNgd3qPkis4Oo5AKqrkCrmLutWj+oe3jvh3ZnzeuDiK/P8XycHaBLS?=
 =?us-ascii?Q?z1KOaSwa2B/ict48IY7N5lHUHqc/lStcLaQ0JH83/icvaOvOYUIiILdqQ65K?=
 =?us-ascii?Q?jFOEj+QhHqb1RMblCFDKPIk9uA2xX2WyL/Wq8lVLdb4+GQpDUcGG05Tij6AN?=
 =?us-ascii?Q?w+eZOOHuCiZcVpXmIZmASbvEGAOi5sm0/I0qVWJf/ZkEmMLh+AYUFVNnRPZv?=
 =?us-ascii?Q?jpEMG5XH//V9GUo6lAckd0qFQ2sRGbQ0Nrb7R59fQgw+8sv5OPpCU+9AjwW8?=
 =?us-ascii?Q?A6zlyEm4WD+qzBwQeTptVt1ZP9kNOJ1A+qLlSWWZUDnDzGrn8KMG33UcNf6L?=
 =?us-ascii?Q?lPAr+105R3VSrf3a5irD6xJwvN8sXHihy/rfmFS6Wwo456J+BGsvZxi5/D0l?=
 =?us-ascii?Q?HAxfIYahrAOOFhN0rFgOdGLluQYr2/kN/4Hi42NZQp1dNYYrUOdZGE2PrGJg?=
 =?us-ascii?Q?+L7J39V/gQSJibpBX74wynp0qcHyDxniJPZEvzgkKyJnLvp+celCLlKY0biZ?=
 =?us-ascii?Q?rd0dhJRhiRV8NmcI9Qf2eIWdwcyfKYbKc3iRmB9qj1jn3oumCz8RhWxHba7N?=
 =?us-ascii?Q?UKP9Q1g5uSUzN82hZvHQCuiq66ZIjuAhndSv8ofkXReM8vxwysAZK7LdHaTJ?=
 =?us-ascii?Q?roHM/eKZZuncfChome80rNMVqImTkQrOmOeKtlHxQK5phzr7TME1lA+UsFaP?=
 =?us-ascii?Q?CvkVZb6vFWNzQSi4lhtAOhthcy8rekFBI2bqRLiebqvKYy/kX/l6Ba9aUtyq?=
 =?us-ascii?Q?sTwny4hWs8STbAc+0C1jyLYQ0IJQhLbtiOzkq429DC1cTaejvJtxpNad43Fj?=
 =?us-ascii?Q?opA1EY8BRhvZOkH2RW4ydZwLjgqcuC/mFWoLcdATZgXyYKI1Ri7iYy4dAbDB?=
 =?us-ascii?Q?zuithhv0sDLzboeO0bES3hYq/5I8AZgfgPxGU6JxVI8S8sQncBQeuwbw1oln?=
 =?us-ascii?Q?qZz/Irip6UTe2fqh5k7hZG28xgJ6BiYhjW/wHXfxlXTTqQfheXoUyKPywqZ+?=
 =?us-ascii?Q?KYcXwJ8zQodNsdz7MZdYDCB+PfaT+5hBp7desGlOVRyTYMpIRUzjkOWTAH5r?=
 =?us-ascii?Q?8YsdblZ0rTwURjXtcWgvSVrLRDCbg1Mf/NWKi2vJkj9es1wZxx1IsDd+xXMP?=
 =?us-ascii?Q?7mYdAeZlT4qL7WC9u21J0uwYx6lXT+NUcwgHZd3ONiHpgQl1epkojkLLh9kD?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: twtit5xF6Zsxp9X6fn5Di5gOnGnidSfvIUKFnOPtI4H68uLBk/CRW2enMLd7WKLl7O6q7QX0Jf3SnMnCCX/jRJ9m5/OJVxl4iW5wGtl8DKXsbztydRrKFqVIC7Ti3qPBfw9rnK8rMDXA/8omz11arMphmzVuEviseZYDbiz6kTcKjkvJyVk280f+0j7+BvaVZf8xY3kggrxosOIghTz+DtfWYIPiD1OhEIrs6Y1K1hT1V3jfoavIlyQVWjpZCuohN53sWYVOCGaiTGM0vSiEtz/K1v1PtL6selg7BTVhm1aec1vz/uRA3LTUZPvEYKSQkyYT5ydrQjxJbjUpsjjzUU0kZ4fItz9TSeHt8kCF+FVKcnU7giI9irgyfCeDCUryL65cu4epl4PxwQNWaIePDLzbfIuUyA0DMk9H4jlqLqTeqOvtDaXlFezhLxrv7j/aWby+FDZOzmra38nqD0kgisJ9gC0BYDZTZokENuifoK61zLU05O4RA4ocbuVHDXBqgKjPaEcbF452NrBxOsU0we7CUv7qSMvK/9ZkvJ54NteNJgla9YxljhuhIbjnPS8QgQF6Q7jRlTUx/ZzXjP3vWlGHVmHk8S4tWZlqtfaC1Z3J+kFDqLag/EHOEVXGRxwMYPMvHhAGjsunq5SjzmyYDz4hyA31YzTROPB730ARAlAUZZCENDGlKyAWmjsFYR87w2JR2eYOJKQgXvxwKqWq+A646GHXjaCZC+0b7rwEDWzXL+Q7CebJfMA68r1D+oPgIeBY7SRpBusComKjYofmrYlCaKemedPKjFXNBXhYSJ439Gg6/l7KQZJ947n7YOAy/on7mEMyJ397Yv44oOQnig==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94221bf7-1bae-40d5-6473-08dbe5e40175
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:06:04.4152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcjGQEZGd7L++2G0bx7U1Mfmf0r4Bfr/w+YELD4TeP62fcc2Q+vGL6wXB7H+xtdH2R699MTShmmpjsqfLLsxgb690Imc8TBZH3rv1YobGls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5686
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_13,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 suspectscore=0
 mlxlogscore=819 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150109
X-Proofpoint-GUID: nKjyd85Uh7VMQKtz22EramAHbCC3E2rY
X-Proofpoint-ORIG-GUID: nKjyd85Uh7VMQKtz22EramAHbCC3E2rY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Justin,

> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.

Applied to 6.8/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6F080AB91
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574587AbjLHSDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbjLHSDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:03:37 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D191986;
        Fri,  8 Dec 2023 10:03:40 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B8HEjKr003300;
        Fri, 8 Dec 2023 18:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=nbiaJt7MurgXauUsH07wYvT+t8slMGKOZesHpQ7+deM=;
 b=nlxSd870wYqyxQDjD+qwFxRfAOhO8ItIeQp8eodAKD9OgEk8uRqmuELbIGjhpUygOSsb
 efnGMb4yAhIqoGD902wAMFHhGVp4q+PbDcyrMqWC+bEOmSQMDvm82zVsSXvBPRzE0a3H
 GU9UYN/Pvypp25GeBove2JG2+OTWPrSw5YSgi5OKdpIH9UT6OaEg3EFKuzmMj6blx8Ul
 zwlLMcAjG3t+QfCm6RqWmeTA1zCGiJQGGiDtmD2m9/QaBa2esxU8Tnt07lGjaFZGUFus
 bXgz+WleCNPTk/t91Mj8JstpjyfwWKi1w/4xv13jyeEi2iSUB1lODhgGYLKAa0dykQXh +Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdabxbpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Dec 2023 18:03:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B8GquSS001250;
        Fri, 8 Dec 2023 18:03:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3utan96skp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Dec 2023 18:03:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGWUPXH6hgoTvTld5oAo2AYc6lvze2jjGLpM3anhlmMhWze8f6m/iL4FoEY9ftV26/qVUtjKutBI/pfpdRGVGGUWecHXTokx0uOdKJ2xtenfvT9Uz5ZvgxLkEIPkB5rni80jzrQiaqsTvAaQ6/KxtgXrb05wOQMP9XLwxOBaPLNA0fi3UkJyHheUjvls0PjHmnhrjEjOFVnZEniK3f3+YnHavbWEHwCWlYGSlAjYc5BG6T5WPB5ZXFhpIY469xlFbK2c80CWxbg7NB+c1OpPC5JDMd59kyDkHpjzdaKXaN890tm48GRNvjzj+/6MKKJkvSsZH2nayIbg3eNz1G2A9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbiaJt7MurgXauUsH07wYvT+t8slMGKOZesHpQ7+deM=;
 b=hPd5yE6eVpT07z4RhtLIgtLl2rDEf27SyOYTt/Gb+U4lBQWEJ3sNMPwRIUcIG8w2eRPSjW9FNEERXcP3EeuwRs6FMhV937aEtN/1oXLgXnvLW2c/KjlUDX7z2NVvVYiB7spsQYlhWns5PsyM6pOSyytjvn6FMb2LBxDvwa7SWEXFZRNdwVGp27/jemCONWLSrwl7jlYZ0fC2NZA22BE0ymFkEAQJPTYHvT8lYCpZ7roeX7pzaDvEl+zgvLjrnjMkweoaFLyT/F44xD8OFZiCVvv3RzD1UL2wsnlmjA/QNb4eg+gjnTRHYzh8lIWg3eQEr4zAyD/QfFGOA4P6pZehxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbiaJt7MurgXauUsH07wYvT+t8slMGKOZesHpQ7+deM=;
 b=WdmPrtA6KICvXI/S+4JOKlLOCfkiK6tKcfhf+QYAU9Htdub+rVp4nRIyTydstc5ufWVbKqLkxf/XQQcUPZIb4OtkUqnleOct5Q5VwDvCbpZs0pqEzihfxMiEaBf80PL3fMSthk7RBQpzXpQWn3INiaWY7kpYHzd2Yoxp6sTJOR8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BLAPR10MB5188.namprd10.prod.outlook.com (2603:10b6:208:30d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.29; Fri, 8 Dec
 2023 18:03:33 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972%3]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 18:03:33 +0000
To:     "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>,
        "Arulprabhu Ponnusamy (arulponn)" <arulponn@cisco.com>,
        "Dhanraj Jhawar (djhawar)" <djhawar@cisco.com>,
        "Gian Carlo Boffa (gcboffa)" <gcboffa@cisco.com>,
        "Masa Kai (mkai2)" <mkai2@cisco.com>,
        "Satish Kharat (satishkh)" <satishkh@cisco.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/13] Introduce support for multiqueue (MQ) in fnic
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ttosk2n1.fsf@ca-mkp.ca.oracle.com>
References: <20231130023402.802282-1-kartilak@cisco.com>
        <yq14jgwm3gz.fsf@ca-mkp.ca.oracle.com>
        <SJ0PR11MB5896728CD14BD099A273C98BC384A@SJ0PR11MB5896.namprd11.prod.outlook.com>
Date:   Fri, 08 Dec 2023 13:03:31 -0500
In-Reply-To: <SJ0PR11MB5896728CD14BD099A273C98BC384A@SJ0PR11MB5896.namprd11.prod.outlook.com>
        (Karan Tilak Kumar's message of "Wed, 6 Dec 2023 03:53:12 +0000")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0078.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::19) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BLAPR10MB5188:EE_
X-MS-Office365-Filtering-Correlation-Id: dc0cb7a5-7783-4d02-bef1-08dbf817fdf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D2XBbnGJ042BQ+g/BoR/BNqRJKCf7rJWGVGxu8iSgpAhDIHC8sIQSt4PP9S0i5Yuv2tbUO78RBtXu4YNGBNNEUNLLzPqGcvy4aoMVPtiTwqlZZ7Te54cuRmossjP9YEZji0zS/JzM0IYl2J4+toAdORHWVIxk7Rj7yXegnNJ1vWaec8wFb450ewu5cV0wk3ddHQJ7809KsyQTl1EvMq9eOWwRv84iWU6dMsaGdelwMyh98ejQ2a/oAPCjBaFC7tudx6StLtWTlxvBC3C3mSgQNTHiE2ylqljPe4sXI9ElKVzQrHAR8krDNy+/oetYGSIzFVcRTrUCBpaJCTTp9n4CcQc8jYf3ikOfvQZLhYmPeDYIYAHgLmDnaL+IZhJhmKqGV4bGG6c8TxK4QuZXs8TIxHr1TFIAwTZ4VE5H9e8cF42Hz+TtFI/fINXdiFX+Utck/cXr80p4TQEN0cjKfRP03R7IDnixReN3MzqGyerXpgX0wP0ki/o4j5zIaJKp7yxTzc5hc9PVuxIHV/xyGCbMDvpzG0zoRPcNi1xnOtO7r4/7FVuAIjzKh6olgfSY369
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6512007)(26005)(6486002)(478600001)(6506007)(36916002)(83380400001)(7416002)(2906002)(4744005)(5660300002)(41300700001)(54906003)(66476007)(66556008)(66946007)(4326008)(8676002)(8936002)(316002)(6916009)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BRFMgWZGk0pwfCVCt5N/Lmp9G0tHc2jV2iP4SUs91OabhLDZiaNeziJOUhhL?=
 =?us-ascii?Q?W5eGsBGpiKE7yaz3OfWRy5Vt2dGAmkRcOeM0aeTItsJZZY1JzqU/iT+RpIgz?=
 =?us-ascii?Q?p5lGjBPXwlQFa/WBfzH4K2rixGp1u21E4LC/8slSKfnYSq0A+m8fDnZok1DX?=
 =?us-ascii?Q?Gy6fkowPMCStHf3bnNW2e3diz1z0ro/idhZLDJnKoSAjUOAE/4UALPvE90X8?=
 =?us-ascii?Q?0D7OmZ1loi/ZZ1w9ZlVIEdeuD9bTPSJW53TLq4Dw9donBWj3EqK37ITlnuVW?=
 =?us-ascii?Q?OICVYdF8eTfBp5OJZp6w5MAkfqDqUSayUCYrwChT5mI4nbphAx299OfvRJqv?=
 =?us-ascii?Q?1B0sEump8+Z6q+8OPOptYq9Cg3XQln/0R6UluJoe2mocMf4KtkoBcxAdgzRG?=
 =?us-ascii?Q?7lPxBZFa9mALXP0iyry4WKlXae208q367roVUDXiJwI7Clbcn3LJ0hMPMPlA?=
 =?us-ascii?Q?iTl6i4b6zrXZV9pA8jiHFyzd/Ku2/kZ9PaUg5kUQ5mfQiu+KmTNDs0272P/4?=
 =?us-ascii?Q?BBbESDh9vDjwbNyLGTV6rFq/JKspEJk1b/yBFv9uZeO8pxiIOvBK8H4KNc28?=
 =?us-ascii?Q?3TrEjXWfHVyFy4JeaG25x6wozx0Z0aFOMXbig7+LDLmQcrjM5K9byDYzQuEz?=
 =?us-ascii?Q?H3oe86ZTLm5wuP6ze19yOZMhvG1ZpJKYaMUv7skwfkpMRAUNCYVG1n6C377Y?=
 =?us-ascii?Q?FtUDMuDJcCmVzpNvKv9WFtzjWQ7X6yEptSrAv2go15RUhNMbVlmh/3EFYa79?=
 =?us-ascii?Q?M7hge2GSf1Qr4GiTBo8Y/TPqHpih48Ei6nel6Z1qLae5idQ3Be3ErGMCldE2?=
 =?us-ascii?Q?ggz0mdlsl/jOaP8iqlphjmjSy8JBoIAoRLNulqQlsZtk8yH6WjD8w6kFgKoA?=
 =?us-ascii?Q?KM06Bmvkk7QhsHzL5U2h7zTnaVPZs2p50XT76Vr3E2g6qW03hx0BRLohnhvp?=
 =?us-ascii?Q?YyH7vHSponnt6PVXvFrdGUr667ln/VabSo+b9Pzx/vcef+d0TSEO3wc38lXb?=
 =?us-ascii?Q?FV4B5r56WWUATTu8tXvGTSxStkpEv/5yHclPTBNzAQADVoNpHeEveWfh7khk?=
 =?us-ascii?Q?Ij0eFV1fz/91C44WsQjDaHtz7zIUykYbpgBlDTzJXPJJERathgdFDZwmyUiy?=
 =?us-ascii?Q?LV5BTWjur9HjRBkX7v23OkYMFw8L1kk9oOgcWnGArylfwkegu0xDYDrbz687?=
 =?us-ascii?Q?LHgbopuBs7xu51DUJoncWrkD3GlTwRp9+GrH32R2Tf5D5tR0O+Vy2gP91g9j?=
 =?us-ascii?Q?wKALeQ95H5BiFSZUtndGW6ikJ+tJpiLGJUPTqNAZzUxE16xxFVCENoauybsj?=
 =?us-ascii?Q?oBIwXI44S9pkGeqATpmP9PZWhfh9Ld0B9IITxpsrmIG1V2PdQl6f5GyL3PlX?=
 =?us-ascii?Q?jmM3yLdCzNy9UyTjvEvCF3xuj7FYOrhZZgjt9sWLuGF8bJbcDverVPpBVVtw?=
 =?us-ascii?Q?z9x1WdbqVHbMGHRWWjUi66UV9UXrAl4qwpmf4u3mdvzSKPtrNVByOz2ruhcX?=
 =?us-ascii?Q?VV/C5Xd79anvqaGROcqSKPQT3LJUWAb9ovv4ebpf7EeY1cGj5qFHspZAyCMY?=
 =?us-ascii?Q?JT+5QUC99y8u6DGfdoT+GOyutTPJ7NhbabkBM5jWtspOn50WqxW+CHYu6vAy?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FvybBYbx3jPqu/LfJH+5xD3iI5uesZT8nvTWHi7RPub51MeGBgjQ+m3rzSH+PGIsopSiiqlCoAxlwomFO69Zp0nZpCJl8Wep4HcvgPdiR5FTdnJKRyB7U2C3Tew9WB0GGv8yK9jqMikQYLRscMEs7BV5eq5rjOcUrTT6h4clE+Kbk1SH0eAs0pGLCQ6AIPkQxBrC2vXC6Swv37y51KOBoGUwZBqP+NFbpS0JhWL1XNdeBfPG5WYONZCkwYbZmprfAxQyxCIGfSMPSkGuGgZMTQbHn5lVW4WRhmBPnVydUkRU7dtj44pZtSTUxaWaRaWI55thlWYTcAYBytdpsIGEHd0SovpY9Dmyv2R50bhEg/FDR9dg4FujaQ0Dcq5e0JH6G0GhSzCLV1TkwjJu0GWvdOtHFuZj9bKAo6y0k/ZzwL8eWPy1AG86Kb8Z+M/VWlUGjLNdt0C0ee0qJq/ANGL/Prmmo/kGJar5mr+vwG6XSgo4IheddJbmOEn5CCgdFdjPnOIJeiMTm9CheHEs9dWDtvcndmwCdSkPSkT1CqdI/r3CGif7G47VBX4lnlx9Wz1HwuN0a1L4v9hMYQXpd0Qql+MzNL4Ui9RYjG69wh7oolYlq6d9uY2e41Zpg7DSzO4al0MEsd4hkLjQFzdHsm9LF/YGMRRCogsXFu4rs+78GHf5Rs1de+s9932oS6DsV3B9bw4pp9zOITqfP9gao+82eRM3y3aM5+s4m9ZpYxwStIcFfYgSXK4RM2bRPt3SZeP9gyv6IbIcTjEDN4VpHREZ/D0ov57s1Pi6SKpIAEK7P76q943pFG0UKATLj9IZeONO7YH4x/OzPDCSBaxgj/6Rrw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc0cb7a5-7783-4d02-bef1-08dbf817fdf4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 18:03:33.2703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMwVfefi5pvQ2xz+f2Jw8H8JrShLgKuHMiHX4d56yQhrp64gEaDy1R3tE9vHnDwj4miV6jCrqk/VLKowu/YVf9pn96se5nLY6NwZ98OBYS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_12,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=852
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312080149
X-Proofpoint-ORIG-GUID: bqiQ_DkgWnwrbOPOdkBoBtW_sMlRHAKg
X-Proofpoint-GUID: bqiQ_DkgWnwrbOPOdkBoBtW_sMlRHAKg
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Karan!

>> This series doesn't apply to 6.8/scsi-queue.
>
> Okay. Thanks Martin.
> Please advise how I can proceed with getting the patch set accepted.

I tried v5 and it fails the same way as v4. First failure is patch #9,
several additional conflicts after that.

You need to submit a patch series that has been rebased on top of my
6.8/scsi-queue branch. I don't know what you used as baseline for the
series in your git tree but it is not a suitable ancestor of my tree.

Your changelog modification is fine. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

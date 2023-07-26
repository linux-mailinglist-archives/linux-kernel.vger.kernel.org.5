Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171D4762832
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 03:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjGZBge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 21:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGZBgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 21:36:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3251126A3;
        Tue, 25 Jul 2023 18:36:29 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PJIXmX020105;
        Wed, 26 Jul 2023 01:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=uX1811c9W2vxml6bSi9Lmv9yZrO8nM0ne67dNjCC3sQ=;
 b=MTpTJeYDFCS1HJbJ3iuYHGjY6TVzFt6ItwaAxlJ3C6cllNc88Wi2JEYYRUT+r4lTjHMA
 fOu4boa3a0UfkQZW8PSIiUqFrZjTlxXgeypQOSCdvCcwcWb0uS2wuPu4xYy5ZLlprSVy
 FFwdlPipqw6qdxFbMBG8hCHlb0SR21cwPpVspzQS0pEB2AAV4CWTrtgl2xObmkmJq/7H
 MC8bx3MjoSv4c94A9bykqW+XLpwfInQKrrygsKD3QYg460pNZ7CvhYZJr5U85ihla78y
 bhGTl+v0GHrOmgMukOnLfapi58NOEb+5RNc1xXwJG8jAzaXeS+h9h+ToYbqwSJB+rLIz JA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05hdxcrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 01:31:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q0AaTq026224;
        Wed, 26 Jul 2023 01:31:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j61ur5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 01:31:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVsUveyMxqc7svkLpZ7MzgfvmKY0w0tRThi19VKRfpps2E3bqAvv8tGwDWzVo/y6XeI2vICM5HMl+Gutflz4sGNo3oacJdw1KsHP887ev4JIKv9BuM2gq11e+fWaIuNOipIB/O3PDLwVyfOWQDdp7WQSpBY5hwHpPWMjCVtp6jferNHgdwPdNwnpipX8Rjc2eJcPQQQRt6VK0lCALM2BXaoTMuVuQGKnW2ckCP19PaAxQmuUp8dc7t6EiShkbCotNr1LHc5gxZNHl/U+NdvOHjFtJpTGwGDA6Gg1WBUwc0kPCquTWLk4L7ZlDe0XvjDQtbHEySZ8PGPrF0gmqM7Mdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uX1811c9W2vxml6bSi9Lmv9yZrO8nM0ne67dNjCC3sQ=;
 b=TdL7+Cvt8njWbFE24KyhgqEE9gDlJmcDZMGewJKmPeqb5e+ThDMOvM4ciLArnKgR5WBENG0zuxa+4gkgFsmNQ0VqqFwLj4DBsfKz5aGw4x2aZYR2jjAAEfMpjYMlPiuhFEtscegDwP6KFFASVMw/+gdfLDe6SC7XFCwp9jQW3nz/vhnnXEXLroh2GlU8drAHZ5yDhMDYqTsTzTT1L4dn6my+XDX3X09ofywOATsnUTLZf+stmCvm41UTrBDJ3j0DvhKRFwaypwKGGb2hSl/3fBOtm0bhy5QduzkekpvysgzpahDeKWNkwq1aifg5ALjaLoAiJC+GWvgDZ+Y6C4dgxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uX1811c9W2vxml6bSi9Lmv9yZrO8nM0ne67dNjCC3sQ=;
 b=ySbF1kEsfCl5uil8P9muFx7m+ODPfqdGItG6f9Fc030J4qVa5kzurow8jmu1cvG6etJsU6Nb5Zsk8XUv/ZToNat2bryVnDvpkWQoduEa8/0jeZ3L3RM26FPZ4gvPD29W+DqA3jAQjGsnACJx74YHSeFrRM/FNoDB0l2zQysziw0=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS7PR10MB5135.namprd10.prod.outlook.com (2603:10b6:5:38e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.35; Wed, 26 Jul
 2023 01:31:01 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2dff:95b6:e767:d012]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2dff:95b6:e767:d012%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 01:31:00 +0000
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ziqi Chen <quic_ziqichen@quicinc.com>,
        Can Guo <quic_cang@quicinc.com>, Arnd Bergmann <arnd@arndb.de>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: qcom: remove unused variable
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1jzunzcfq.fsf@ca-mkp.ca.oracle.com>
References: <20230724122029.1430482-1-arnd@kernel.org>
Date:   Tue, 25 Jul 2023 21:30:57 -0400
In-Reply-To: <20230724122029.1430482-1-arnd@kernel.org> (Arnd Bergmann's
        message of "Mon, 24 Jul 2023 14:19:58 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::29) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS7PR10MB5135:EE_
X-MS-Office365-Filtering-Correlation-Id: cc9b84ed-4bb7-440c-00f5-08db8d77f7fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 78j1W0qWOTV5RYa/5bkCw/dKwjdWvJh2QZdEw2f2IxDrgds542ikigtwxwhotwlrEbPk/jBBoarlTtl4DisCLMSxfmMJEZusSk8YVAs8Lc9qpCqf+YxvBRmZIg0+6AbWQ6BE58/HfM0IAa7sfhE+CJaQDc2DBwYsYFz+vYumIJzJ7gY1PI0U2pYzMihBJGeMc3q08eqOVqDOZCE9UF/t4rq1mstiwK682t2JCN/ZcXlUXf7GzonXw2xwr+Tfn5NELmwOKAFxbRRDo4J3hBBAMgruxROdmuxPslwcuMyp3g8CT2XOLD15YlKKED8pIzyw5eOlNQ61SYmwo5tJzW5EkDgOY86U0NWlA2Uy0WyvwLVYUP/KXjOl99NX990t29mjvfdspSk81qmW3Yn/vXaepf5jocJq3mhOWRN2l699gZIgCBVZbCQBZLXAiMHVDdcZZ1m/9v4oIfmJLKtwin3Wco5YJHWtA2q2G8+uizCIxLwZe6dCiUURMmg4JQdooImHrUvOcc59d73Mo5v9HpKkw8NQE+lE13uiDrUof8Rr1Lz6HeFSDz5IgU8u4E2PrlXT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199021)(8936002)(8676002)(7416002)(5660300002)(41300700001)(316002)(6916009)(4326008)(2906002)(54906003)(66946007)(66556008)(66476007)(478600001)(6486002)(36916002)(6512007)(4744005)(26005)(6506007)(186003)(86362001)(6666004)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t+nojlO+2ALAKWUWXVLUWWGkHWg21gQf5H8X9rMGYQ11L+n1tjH4nQxiuVNK?=
 =?us-ascii?Q?apLT07hWPnKwcb5XYsWJakR73iH58KrshZSsF8Q/7wg5qMDJZTr6HNBotqyJ?=
 =?us-ascii?Q?32u+huoLE8qeZBGb+Oh8D9oRVRM4yiwOUYIgj5MfOwWhqeM+GQs3CDprRIUn?=
 =?us-ascii?Q?nXU7+8yZPddIkQOF+LsyxULiylWNhoPOswS77fPpBEnDMthh/CMlO3M8bcUR?=
 =?us-ascii?Q?RNaDH3OcTwiGLpnZeCvYxLIjCZPUCxYVa/KKQ3TGKS0d2e4Q95FstrVXBj4m?=
 =?us-ascii?Q?wZB5kpsctJ4KmbfyhjKQrxolxoneqeSv53gnm9SWa5lbTcuSokSYnc8H9Dlb?=
 =?us-ascii?Q?b0K12yajDZ8Qp0Qv66uHPYXkT18xK8c5N71+PXSMzYItdUqQO5TSwVTGpufE?=
 =?us-ascii?Q?RO4twUbKT9JtBNsxjAyJUmokflRj2sJc57y1igqBX4PS8ZJfmTtaEQCRVMNw?=
 =?us-ascii?Q?PXyzSY1dmvBtDARZJYAXWZ9NkcF0RrQXqw3mxJSzRMDkgBwN0R/j67ylvRaE?=
 =?us-ascii?Q?XHXT7Pqu1roKdjvF0BTD6gaQuHHwzU9rDP/HfxrbZMDmsJewzdx7+3HHV7+M?=
 =?us-ascii?Q?mffdtlR/EunJ+O/Pajw/MDNEbr8UyAzCC92PEOWMzU2hCeF3rvyYGk3hTeVt?=
 =?us-ascii?Q?FcYpMA69MSUze/nJlesmIiQAVDInOsC+bV9ymMfW2ItkyS+sdd/v11ddu2aO?=
 =?us-ascii?Q?4aE1bcTs1TyzaYYobLaHhJOTj8Mfzj24fhFgRfDR7qV4ZPxpM/M0UyXdnwjC?=
 =?us-ascii?Q?TLmUnjOssMZV/b5Ns18RIldWZkMfIGIF3M27AYT845PlxXGTrOklhYp7NRWH?=
 =?us-ascii?Q?w69ShpcEYHXRi4udejLC1lVu2eqv7Ue2xZPXroGhqyrF+/tW7j8EDYXPnLHi?=
 =?us-ascii?Q?482pwkJ2Utk4SmgF5carLO/gNPwmPYL9+MITM2iBAPV8OipoegveCQ1OZYMB?=
 =?us-ascii?Q?WMJYoLpWEuS9dHzpiETAyYqi37QiS6Sel4PM3DNHnbPaXMBIRvZkQxaEjA4C?=
 =?us-ascii?Q?JO3v47obbGWVRtfVBAJts12Xb1FczkBZylpXgzG9y8u3xet9fXn8cxKVOOIo?=
 =?us-ascii?Q?FyxJ/crPc9151nftMlqFZf+CXjd9pozVNRIBd49hc36lmtDLTkovkA9/sND1?=
 =?us-ascii?Q?9HzDyMfLgwdMA5AP71KTAr8gboj5YvU/NhHdONuSio+SLXghfdd/Ph+Y4apK?=
 =?us-ascii?Q?82IQ5ibGYCnB/wLrp/MOQBgRUeRUrQuKiZK4EAatZIE1079brhbMZTKMr0oy?=
 =?us-ascii?Q?AbWYylGJiszaXVC+3g1JIG5L72mEVLq04Q5NLTDbI84ETCL5UaxAtGPs16Bn?=
 =?us-ascii?Q?aSlXFmbElG9+oXT64KtqbfxWakNv0oUMFNgdCJhVpzBrUyiCLKd9wGeUSFxx?=
 =?us-ascii?Q?J494lBeU9KmdpxN+vzhQawAiMpTCnrWFUktgZXoqlUQ0W0qhoeDY5Ap20CUD?=
 =?us-ascii?Q?+6tdwOFRcYprxTLRNp+X3ZNWu/a3W0/AdA9+xuOZjSWcoRIJod9iaKmIedvA?=
 =?us-ascii?Q?TYkTwddffzGhcKpK/kZnPfTVbz/SgbzSFS/vGdJsZhBreo8HWMrNQu+4QoRt?=
 =?us-ascii?Q?btNgSZ2f6Ny0CKsGg7+JKura3voGFaa6QQSaOMY+elh5c2cFWw6YjIaGLQAz?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?wh4yNzoi7pjCL8hauHdFIRqParXMSwUZz+O7b97lZTvPXuACB69NOtug4LrG?=
 =?us-ascii?Q?8TRVocSYAM5MO6nA5aQ2vVAL4xcITOT9/UrHChLL8jmh+bAqvxyjawqBkHsh?=
 =?us-ascii?Q?zPpYY36GAkS/eH2lulTNEa2FAhaNQEzda3jg6/WfuJhLhXZa5BIL4DCfj6Gq?=
 =?us-ascii?Q?GSrM81YfjEkXLQdYtvEuyJDAP255X+XcANb6Z68AwDSAyVyQ+SQW6mZXZWXC?=
 =?us-ascii?Q?vmuJzRN/59FmL3jtSxO3zfJV+t8MtE9ldI+rOwRrY2zs3mPKkXtDx+ERcBh0?=
 =?us-ascii?Q?ioOo4nzkrRgMZdZge7y3hvGrlgxstAy0IMf8Xbv0eeYppdh7lJwmqRTuH2vA?=
 =?us-ascii?Q?6qVyhGXzZ1AG66gKGmq3tv9UmgE0rh3JRrmN1C1Z2I3hmOdUVjvU23IbbptC?=
 =?us-ascii?Q?eyFWGZEhD80pbN0VgYr/ZBXX9wV4ZSsnpFhA+p70SLLpNLDZ4GAwInYGYEam?=
 =?us-ascii?Q?Koi6EjzVUy2I20mJhW3YCxDU32nAWVEbIpKqt1MNTRfltUS9b9/qYoFGTGRM?=
 =?us-ascii?Q?QsYvo67jYFrh3gKz6wzZXnKA3LYFELAZWaV+pbERqQA9sCMhJNRMnKnWqCSq?=
 =?us-ascii?Q?YAEFOvnwMI49qSjLuYtzEPY3r6//bvUPxLDJr6pFGTgsd4gePQ3xnfIq6jwD?=
 =?us-ascii?Q?r0LUlOX66Z8IiEl4ts/gqcHpXWT0cXBoRU32J3IP6VzH0dAeJKEH0tV09UT5?=
 =?us-ascii?Q?bT3g5d+Vl1IjG3DEn9lZN9R1nEdU2ahi/D4ph3V28Bfsx53GSA/W42tP9fAB?=
 =?us-ascii?Q?dhW0LdphSfJrWoujuI3rFmQmLKqUTcnkL+0KP8o2lOKq0UJuKTO1NJYWYoTp?=
 =?us-ascii?Q?PqIqJyddeBTf7+1l7+8MTb0ihf0k2b4ftMwTr7CCvA2rL6sRwBATleLes0W5?=
 =?us-ascii?Q?GuY1kgYfSQLUtM3js4QFKbK2Bi7JfqzGv3X7a5V7rJbSfZxZwBA/651JFIBO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9b84ed-4bb7-440c-00f5-08db8d77f7fb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 01:31:00.5291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+SMpScbQv8DWrP5Cr/8yzVqFU6e8/0wZuof0kzkynt1I4FnPohnSvn13AfGC+Di3kusLd+GfazBVnn45YYVjLlpqfphpHJp+nstIBOy5oM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5135
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_14,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=795
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260012
X-Proofpoint-ORIG-GUID: sibLgUgvjp92c8YaisiIlL859hIzOC46
X-Proofpoint-GUID: sibLgUgvjp92c8YaisiIlL859hIzOC46
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> A recent change removed the only user of a local variable that needs
> to now also be removed:
>
> drivers/ufs/host/ufs-qcom.c: In function 'ufs_qcom_mcq_esi_handler':
> drivers/ufs/host/ufs-qcom.c:1652:31: error: unused variable 'host' [-Werror=unused-variable]

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

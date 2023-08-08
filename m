Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA26C7735B1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 03:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjHHBI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 21:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjHHBIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 21:08:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BCB99;
        Mon,  7 Aug 2023 18:08:23 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 377KxQ58010919;
        Tue, 8 Aug 2023 01:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=5q0eYNras5yXEN4hODuNtebDcLemCdEjUsQSExQnfwI=;
 b=aEd2bO4BKzd5ZlPj5OuEmyEONDoBHxoKy99ci4x1A1bcxinC+N0B9So6kSe8ySqufJ7U
 osz+n+vahSxFobL9M3lJbhs3Sl7qWa7eC98hLVImCP2Y6HDrG5aiIUw1mLDQKJEyrs/U
 sR6YUVDl+zihQg9+MV4PlBMqSIkZRTBxFJPRzWMIsjEKiK/7X1uZaaHOfWXjY1duTOL+
 wFUtjdzjhSYLYce8UuY6rITLbrOsMQvQrZGlEYsf/kb2oaQ6Ry2qi2siBrEnghJV+xww
 bMIdDqrhpuJwzqn6SVAngfoRZfWSjtUy2+Rc3toU1Jn2uMnGzy/B8r+0JHWhmKF/7Cc+ PA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9eaam0tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 01:07:09 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3780G1Hx033452;
        Tue, 8 Aug 2023 01:07:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvbbwuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 01:07:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHcFkQa6WeRWxhJkhq1H9oFZh2p9DrKYZFvEEZv1ACceyShVQlDJKCikTR12Jse2Ko5bd7D8lRTaX9JOItqrcu5n+FwRKOQzBH/BXV8Jlxo/xTpk6s4xu8gM9AbHS03f+UWsA1tYRqaFhMjJsEB0y+Nuk6zUDPoWlyaL2fJ9/izQpnG+1i1bonT+QiWEirjRl8ZBqTVoPQWDGwrxvIbj8dW7Pn2MHyPF6gYfskJmgaP6oHwZQx8NLBdESSuxPwFTXLAyRQpPvES/ehX5f9BmZG27sq1qQhtYWxSetX+vZZifnr8FkUngCP5vmSchgxywSwOzXiOyehUALHFsY/q4Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5q0eYNras5yXEN4hODuNtebDcLemCdEjUsQSExQnfwI=;
 b=apR2J5/bb7IF4QFe8k2shKgOQppZA0Vg9va1K73haX2npVkMyywruOe/2zWjVFrW5QRN4lEsEEsIJhnVROe/s7tbzkkZIdTF1O0nXrdfgITqR+hsYRxn1t3qF0JA9naOR/e7DT/lsV194gD9AITpuZ1SBJfSJULfJ9aNO2un/P52EM0chW0InDZyO81W40rJD6yw7yIFqULWGLpt+DYO17LD99LKDa56K2oW6u2a6CvzgRepbgGKPU/TlIShI6XMbwNGz2iUTHhps1gIIe3BXko35+mJbcFsQNcJXxmqZV0UiKPgVZCk4EVW+UOhayEZWNFR4Me9iI4IX4osKu36RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5q0eYNras5yXEN4hODuNtebDcLemCdEjUsQSExQnfwI=;
 b=qf79Tf4vLpyDd6Fc1mIsUWQOnsZBKc7cP/8xvWv2LWb37Mhiv9lcNCRS0OK4RxSJAYAllWNa90OcA+IwHEDQGsFG/8aINvOp0OTSftcEkcRBNJwvCpmdGOjXqAeCrxpt0bsyQapoFBjxJOtznY9YCRKzOnc6KOprpiGQGAgmBSw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BN0PR10MB5271.namprd10.prod.outlook.com (2603:10b6:408:12d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 01:07:05 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 01:07:05 +0000
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     powen.kao@mediatek.com, bvanassche@acm.org,
        alim.akhtar@samsung.com, adrian.hunter@intel.com,
        jejb@linux.ibm.com, stanley.chu@mediatek.com,
        asutoshd@codeaurora.org, quic_cang@quicinc.com, mani@kernel.org,
        martin.petersen@oracle.com, beanhuo@micron.com,
        ebiggers@google.com, agross@kernel.org, Arthur.Simchaev@wdc.com,
        konrad.dybcio@linaro.org, quic_ziqichen@quicinc.com,
        quic_nguyenb@quicinc.com, quic_narepall@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V2 0/2] Fix hibern8 enter failure during host reset
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1r0oel4uw.fsf@ca-mkp.ca.oracle.com>
References: <20230726134140.7180-1-quic_nitirawa@quicinc.com>
Date:   Mon, 07 Aug 2023 21:06:58 -0400
In-Reply-To: <20230726134140.7180-1-quic_nitirawa@quicinc.com> (Nitin Rawat's
        message of "Wed, 26 Jul 2023 19:11:38 +0530")
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0047.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::35)
 To PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BN0PR10MB5271:EE_
X-MS-Office365-Filtering-Correlation-Id: 877c00bb-3530-41d3-4511-08db97abc775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hBm0hiDV4mKs51oeHRdmxbKq5T0RrI1aZdigUw6ezCqMvPdcvp29FeXSX8GAtHQOO6pbkEcmQEciHgwyRAJ/tUG6oqoHl2EbEEk7CKdFGbJgEEgbteeTaKmui7TlofUrMoafymlLjJbL2939UjXpkMMebKPXh7qpQ2ySvy2SMo8nORJwWr+amoJcUQZpCrUl7e8Z6roCTwRsJejqiyMlyVCS2oCboYt6oY3Vfwz6kMHb6JgJnzO4ZnFr9VdnlvMVL6DjqrHcajkKLbNbQA7pjD595PwLx6N26SFFnqbUrQwIkjqXDmrQDe8aRY38hx40WnPeKgQRyqctTWBouHJDBqrK20nuyaAwryQf2H1YulxvmX/GNzgE6g5x9UfkYuRE8CXRjbT7U/D5xib3YJ1P+wCgI9q5pFuSCf2Hin4XhiwyCB1v/IMZ1B37gXlxBJ4cofGFFAP/6Cv6k2Rl2z1eP7OeaV/j60Qp3nfcCEyA22SHuAHEx9/0qwZg+r+pDRrbABHKiVMGfoZWB18UmvaV3EgU0KCT2NViMiYDq4p93Q7YMu62Rb0w7jlR54Dupj4xgMjP8lzPdiSHYIbgiHfoPoe1MDm19jb4YYNv06psqlhf3083rj/iWCNB113dG2OpALG8JnAZlfgNRvVYsk+a1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(396003)(366004)(376002)(90011799007)(90021799007)(451199021)(1800799003)(186006)(6486002)(36916002)(6666004)(558084003)(6512007)(478600001)(86362001)(26005)(6506007)(41300700001)(316002)(5660300002)(7416002)(8676002)(8936002)(4326008)(38100700002)(6916009)(2906002)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EUSshnApK3hRWqmFHSOTs+NMHtfHg/SG8zKEVFxya+fEzyUHTDOA+mztRnUk?=
 =?us-ascii?Q?SZTEdzTNI13B8iRBk7fsbvHTX520C/GPbEtlsHV0sXA2TozIfYdiv3qxfobb?=
 =?us-ascii?Q?YuKCxZV1sap9gKGO2wDsuhqiVVtSdK487sBGkWvKcgqowX9USDW+r4JNE2hc?=
 =?us-ascii?Q?HpV7+kt+ossnUwChR2Z6NqhFiEmDmnEHnk8mgn7DN1y1ih4nr9SLw+vMITdV?=
 =?us-ascii?Q?0RcI0SCxSKcVo1EN3q9lMHIulJIxsRgXLuIUoH7DG6z2HomStDToTgJjiJbY?=
 =?us-ascii?Q?vMH+Q7cLmaW/mR+ePLXZ3RfTLYlM6vLKZ3oWtU/OpSSyZ8kV9M3MXawWZAEs?=
 =?us-ascii?Q?ZXzxGiPJhUqe0zVDqLvTlC1fIZ8Hl7tSHaZGpNcOLfdVd4nbOZRQsZx+2IJZ?=
 =?us-ascii?Q?iv2dfDyGzHn6tlaVUO65fyY2lwd+1eAAVtjMCueoYW0L9+T5qqVaFEHUSxC8?=
 =?us-ascii?Q?qjuKwqa9q2sO30Pj1NKpPOcO1f6plPI7a+GOa5EnMAb0AfROpX2eVIhJ6RIs?=
 =?us-ascii?Q?BkKJzlH7H8JMnIaMs5WRKGgHZucWEvQmM91zusTMLnL3G6JCfmZzDQz8NMCq?=
 =?us-ascii?Q?7pc+6ilgE4xWA9o3XN9WnQ6Z1fac4LbmIZ7r96YX0mYvEK+jbzN9bM4+zJKI?=
 =?us-ascii?Q?AzHSRTB6NUYWzD46CphKin2JZUNx45wkuyu/YkAdCIsLJO701Jvh/gJ6DaQk?=
 =?us-ascii?Q?2x9demDjHn7KPt0DPafSz/EKnWHc3nMeclo+RigTLgNWrikuxZ0eMPgPtynX?=
 =?us-ascii?Q?T+afkK7dTzWiQqg07sM7Tj3gKoKWaGlO+29ZxLYMAqrubWtblLjz+rESaCuJ?=
 =?us-ascii?Q?Ql65DVCbYE7g0X7tMP34PZAzfqdo3CpIbqBfN8B//mpDGjj/2ZvdhQ7muDbt?=
 =?us-ascii?Q?Gihjrr9az9cCOxu5RKj/LH0f3df+8vHtFdBy99qNE97gf25w6XmdcGGeFV5y?=
 =?us-ascii?Q?TKAJYT5m9ujR78BerebfI3X4EQU6jVpQLqzKo+etFy2+RyOuRFCION0p0aBT?=
 =?us-ascii?Q?OsIg3cZtZuSnBQP95JO5J/VhFBuChNxQiy6BTRWuVDLf8XfLXuCseDiE1Civ?=
 =?us-ascii?Q?6w6dNhXO/+Jf8TmpoV0VZFDYoN/QFYNerDNUzAzMiAfPyaKWV4tq4UN/OJ3r?=
 =?us-ascii?Q?DhfLWLZPfeWtOOWbNDCao7fDwIN5+hWqKuogom9O9wMqZUwHr6C5JLItxOom?=
 =?us-ascii?Q?5cg3pcIusHAqatNx2uvs8DIncCV/n49Y3g7USoTNojq1Ryx1VS1chz4eQMCI?=
 =?us-ascii?Q?V4EDA0FkVmLbzaf/paYZdQdZcC04ngMV7aybMFjcJdcOzyc94TBE787OHcUq?=
 =?us-ascii?Q?VpSiOX9oivf/oCwN6yp1Cvxa+W+yihXvuyd4np9MJ0UVbSfkGV046vDu2NGV?=
 =?us-ascii?Q?fMmSY6xhCj1viIk3IvlKsylw9bZRKU+xjxesj3yRASgqLaI1H8+cDx23gWpk?=
 =?us-ascii?Q?wbU3R5g+NxcPW5CxUvsWGVkfv+AsZ2nZ0nyLUZZQU3HZjdLlnj9wksdkRt4t?=
 =?us-ascii?Q?vaDEhnozhFujRfzC2YKfN2fmxFS7oIQEbODZI4OwNpsTASASpJOq4RfNPJa3?=
 =?us-ascii?Q?3U+x+DalKzQDDk1qgzcXQrOwBU9PG2J9oWYQrq5Dav22afyZWLD5zrZja7yG?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?jjV3PfIiBqh1F+8U7k0RXoL0HeWAaN9/8yp2ZwsYgjzy6EddVosmVLix/lly?=
 =?us-ascii?Q?D6E1mqedOEr78wYZDcCPmzZsXH3Ja7ypPDNaH1WpDiMW/8gMZzYLy9nyfWxH?=
 =?us-ascii?Q?/YtmcyjfJYjtZfAIlydw53zNB+/TQCAQ9oHNWzjuM7NPuizM8RikrYwFoWBo?=
 =?us-ascii?Q?lmyUP6QaHkTZ+BPiGW0iRzBn3qJL9bwWH7VQgwoA17eEs/UWteGX0bzVqNIF?=
 =?us-ascii?Q?KDwP9BfEdombN6RAOIoTYLFEtpQ+PiFtcgf4tQMqXc9CopsGdV3i0jbjR3od?=
 =?us-ascii?Q?NPONhOm7Qf6WBgydL8Hw2yq0+SqwqycV/6v6cyJgzDkOxZp6jJobSP5k2q0O?=
 =?us-ascii?Q?YET+Z41vrdHU6TVsNIPzL10jpgut87/aYWfsusc86U6fjANuMomvE6B7Hfpo?=
 =?us-ascii?Q?y2BpxowT/4oDJgh74T+MkuRRwoPH9P7MEY/tvkDlb7yR8o9vfpe/+/yZUQKY?=
 =?us-ascii?Q?E7biZbogDMj6CAFPMbu00+H/53R7pkhCs4TWwXxQkX7KLbeTotpBwNxSq/4Z?=
 =?us-ascii?Q?A6sabD3zbZM6s4kOpkTHygn3hhyk2pce7qiUjQejzcMAULYvDc7s4jy2JNYt?=
 =?us-ascii?Q?x07sUdXiqpeRc6x/dWAF1XfUMJApII14Uqdy6L+y94cCYabUP9/VKX9OyWin?=
 =?us-ascii?Q?1aDZ5+pAU7I0byE5ogK3T97r2PJKn8Q2kdA0KCcyYOcq8RJrDQMx9050v6Wz?=
 =?us-ascii?Q?wkYkvUqveWUzXzunePIEpM3brzNo9zmVotoCPcSXOX5ZV/ihyulvw1IQSv+t?=
 =?us-ascii?Q?yzbSg6M19OeGocfoZEcqU/GCVImeas20lnf492z2FiqSZXE/AMM5L9M2vDda?=
 =?us-ascii?Q?VnBJXFvTNi0IHRo+MwE4UH16bxKZzhvKjGwt4VQ7vY79sWytw3bXGAciK7OO?=
 =?us-ascii?Q?rwd/oyUrjTuZeWdz7vliaBPv5OXStpFxZXlIr9kKqNRv1w8da5XVH+GpSPGR?=
 =?us-ascii?Q?8lbLSUgm+VNg+AN7Kv+hnE7/2zSS1xRUHBqCEvDnteBptVyfYssITdt84Rvi?=
 =?us-ascii?Q?I13VpKhFVfwcpJ09u9smDW1f1ymx/wao8nkKHdMJeJiQDqlKyGIBqoRwQrPM?=
 =?us-ascii?Q?d12Z0G6rKCGgZPFqx7c1YRMR/2Ek1ymDyyx2l1fmFEcOEvnFeay42QNCRmen?=
 =?us-ascii?Q?L+h6N8QcOM7Q?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877c00bb-3530-41d3-4511-08db97abc775
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 01:07:04.7042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50HpwJc+CQBH29F8bMbAkbPQP2Rmq9SbIq4v2SOBPKttI5uDy7TJXEyCdrAX8m6k3S/Vw/yc5Hpi0obQsFZj/DHTfn/eKS/BPXQHxUR1lX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5271
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_28,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 mlxscore=0 mlxlogscore=815 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308080008
X-Proofpoint-ORIG-GUID: CY5vxVi9K4Dk4ekLkk4Rho0uvH-c6A1R
X-Proofpoint-GUID: CY5vxVi9K4Dk4ekLkk4Rho0uvH-c6A1R
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nitin,

> Nitin Rawat (2):
>   scsi: ufs: core: Export ufshcd_is_hba_active
>   scsi: ufs: ufs-qcom: check host controller state

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

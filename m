Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4A17B726E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 22:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241058AbjJCUUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 16:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjJCUUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 16:20:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018B79E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 13:20:03 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393I51mV019574;
        Tue, 3 Oct 2023 20:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=VOD/kz6maG/PD+2GZAp4Spx9m26HyOCsWtrg90Npg0Q=;
 b=kDICEW3jOTccnSROqaTRTFq1Rb6aWJ/nyBPgYTSBemGK4OGQrPySX7azIGDbAMwsdy3J
 c5LUPrE7sXGlCnEvFrx+L0oHDvVAVHqwD2fp5KZNas8lRstChTeMnfs7YeQfhaDeC9uN
 o4/WIfCNMuXQHdQRs3CNNernIEjB6albFHpAqL26Yxgf7tV5nrFcGWAj8aRbG1wxP/EU
 LWBSpH8PHAuCmcWs2/kwCfV7NrNfzmkJ77Yhifd9Dbt2nyV+kaHTbituZf0mAU5H1d+6
 AzVttS0KvY6TcIYje44uwTpR+GeEP70FmihQJrdv9wyKaeS07TnQYTaa7zaQyHqncvA2 mw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebjbwkx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 20:19:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 393K3k8n033640;
        Tue, 3 Oct 2023 20:19:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea46sc2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 20:19:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUcAwyOBkWmyC3tzBdG/qz0OT+r3wJGJ7i+cuB0tKFsvTmdyDitQ3C8+1d6shoOFnnF6Dr10DFUDAMYmIyW9mLesAMSZ7bBh4CQlPxygcysgQdUeg9bOzQ6AD66a9nhuH1LNYgRcWmbeP1aspFkMHtxJSfNyUDKhKkkvz46YietJ1MesJrOv7jNzwxqd05QOeRFKbb09hcoKYqtA93E+lJyDzE/jcP84/3OwEsMkR4gsxsdZOi2ncnRX0SvP8W8ickRoaxz87dJqToJ/T6S3cHdCcNXrAuiJsdjKXibrnbByeeWjaemhGgHGGYukM4x6RGcoHB1Djsoa6nAwWcqKeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxTLpgKIp38L/pXzOOo4IgoGD/srGzqxOuJG7yzEang=;
 b=m3G0DGplbjU7QHGGL1dk5um8PTr3s+55k5upzoIVgTjg0I9mwls2+BAIs0rfDPDEb7fUa0c1lmdMLYiIqB6bAQTTBwCdauvxL0slDgw5TRO67W/gIte0Zs31tkNLcQQw2HNRonQM769f5N14/E9L1lO2F+ZIXYIw6bg6fTxFtsNlgqaGUwWB7oVJhVMc/4mm2x73MMIhb/1OKAXqTexd0+LDDCOf2jg8C/w/tGmg/TcIPMW6VXbwydDil1tRw1vEtPhhZNX6Pwgom12LsMYPymMo25vE2DkG/c7DUGo6o67Ejn48CuxL8fONNCzqNua4P/8VMY5jO9+6yfNzD3vouA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxTLpgKIp38L/pXzOOo4IgoGD/srGzqxOuJG7yzEang=;
 b=iddiUIJKk/ggmEcLopPEfKDrVuB6K/7pJkl1aMVVwuUfKWodFDAx2PdKPJtJcQiTOdH3/S9OChCTFkWdUBNWHoouImVRagaJVGxBC9aN9c/bOsPw36Ficy9zP6JQpC3itqT7zqRiv9ZZTXMuUQDAVa0arG2i2InC5E1ypMET2aA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB5326.namprd10.prod.outlook.com (2603:10b6:5:38f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Tue, 3 Oct
 2023 20:19:19 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::94a0:adfb:6474:63bf]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::94a0:adfb:6474:63bf%6]) with mapi id 15.20.6838.030; Tue, 3 Oct 2023
 20:19:19 +0000
Date:   Tue, 3 Oct 2023 13:19:16 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, leit@meta.com, willy@infradead.org
Subject: Re: [PATCH 2/3] hugetlbfs: close race between MADV_DONTNEED and page
 fault
Message-ID: <20231003201916.GD314430@monkey>
References: <20231001005659.2185316-1-riel@surriel.com>
 <20231001005659.2185316-3-riel@surriel.com>
 <20231002043958.GB11194@monkey>
 <8d19b6d092b7b5d9b1d0829e0d99c9915db3ed61.camel@surriel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d19b6d092b7b5d9b1d0829e0d99c9915db3ed61.camel@surriel.com>
X-ClientProxiedBy: MW4PR03CA0170.namprd03.prod.outlook.com
 (2603:10b6:303:8d::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB5326:EE_
X-MS-Office365-Filtering-Correlation-Id: e05df8d9-a28f-4126-1450-08dbc44e05f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0U3K/X6QBeyYXBOfukQi1rfp2LqE30CCYpePQGoFmvUsiqIFqpD+DUIMVD4KRDiBXFNoGMTmx91XXj/lqhKzDFGU+ZVXzzDaM9pTuOWCV1W+iqrQ3FF5w+c5D2mFETTQkf73EeUGWJvVRZgc2a3JriaCdGc83TDD1O4498PFr+PXKYSpQUFK/kIAY/j3p34oWZjxUdzs+XRmQ1S4Zk3zMuYLaVHxThE5gN+Xi/dJrN7wA6krUqeecWQYKO5g4mLF8Nx8QF5TZp40Cg3zdSmWOx3OAeZdWe+Inogob6aOgj2LVkyv5UMHC5S65C0ZqmBQjX8yLY2mA+P3EhFMfjYJgfaPf2FEmKra7QqgxEO1/kkCXadjnjpZYA4iC4slSjS3LNzBOmXQkOesho1Rp7pCJ9Vbim5MHTO+HSiQbmcKHXHcDGmiwoKO5CUuXyieEgi5sdy2xOr28bgKdRw/XbEBCtWNkeTqXsscxYWLCsOFCnUs8ID6p6rhRd86/EZlxpzFoH1eaJ6b58vaqEWHQCDH8fuleLOY+rJp6/hRFPHI+HffXNH3j8Qk01eBDaJyCyg0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(39860400002)(346002)(366004)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(33716001)(6486002)(33656002)(86362001)(9686003)(6512007)(6666004)(38100700002)(6506007)(478600001)(53546011)(66946007)(66476007)(316002)(66556008)(6916009)(41300700001)(26005)(1076003)(8936002)(4326008)(8676002)(5660300002)(83380400001)(44832011)(66899024)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?q4qNz+EpytZACwb5D8P+hKroZsgK9hGohcIu2hyJqbsbiT065dMRBmUuwZ?=
 =?iso-8859-1?Q?P57aG1P/UOULQouBrYae67LDmdshIlreGOoXcqJTxN6LtCBqeOdXpCPydP?=
 =?iso-8859-1?Q?sc3Fqr/lp0c/Sav7jiQNYvNPZbtsnnZxUC8cGzQ2H19OC6f3IQ41yfiT7u?=
 =?iso-8859-1?Q?pGa7BbQAsDPEqVOyaInNyQBU+FuBMoOBYCbPM4gXCLT95ovR9vMOVtIb3S?=
 =?iso-8859-1?Q?SFOaskwV7F1Wim32RQw9K0C9BIxo0pxT303uYLxi346ezVW5/YLh2vvXlQ?=
 =?iso-8859-1?Q?Y+BB8v3dg8CuxTurSmZnGizvdjG8aKuDufYKn9dLo7bk/nsV8LV+toXD9W?=
 =?iso-8859-1?Q?ox3kBYjnNNmJPPLZvWNgdI3HVg0ifdqtC0Iun12peF6gvIECDEdOrFYQgJ?=
 =?iso-8859-1?Q?JWiFJa0nLFOXY/Sf30ktgs/oJ4MqWmm7mItUZ1/qzCe5T3B8Cj7o7v1wPe?=
 =?iso-8859-1?Q?OifdZ3l1uQe0FzEw4ySn0yr8QB4oBKhm2WwxqTBWk6itwpLgOpVjQ+Lz1s?=
 =?iso-8859-1?Q?PmtzPGOCdojMf0Zz89yIMFAHuaYK1N5A9DxDfL69zdQjO81L92FpmfNOub?=
 =?iso-8859-1?Q?/uN2SDwknDybY0OmxqGo4slJByELs26D84PHYD8kSN0HBSb7yPctTet5h5?=
 =?iso-8859-1?Q?x3VW/ITshLJXTYfyhZfCO1miKlZCrWDpWOtFXh8dcHCSeSFFZgvHkYzJVZ?=
 =?iso-8859-1?Q?LnXFkZIZ3rR74zdqZ4hMH7tc/8QfR9Q5L4YQrmcpTR5cgUrEYGCXo3U5Gz?=
 =?iso-8859-1?Q?V59u3eUSL5OC2j5lGlT+eca0it4e3k2tfuaCaMWk2YUN50t5OS0ezbxfrJ?=
 =?iso-8859-1?Q?93bJoDPigE4XlzyKBn5gMgSOuSgsiL0zAK1EZ47wshT4rf1pTTUGhNTFkf?=
 =?iso-8859-1?Q?3CKK9iSwI5nwiJx+SChxNGLldVX0ZoxdyXVhsvcFBkMWzaXq+9p9Yr+nhb?=
 =?iso-8859-1?Q?MIyvmZSmVNOAqHv3C/1v7wckRbPFRiy1LZTBWAiYjP0mhTOqBYne8v2Huz?=
 =?iso-8859-1?Q?mwc1kDsghpHTtHIcPs3AYL65bwUOeCokBovKcqEZqMPMbKXRZzhyCZRoDt?=
 =?iso-8859-1?Q?C3E6MiEKO18hMPaspcSxgZM8Fqcwb0b+EbCA08XZmoyHYfIZ/IXPpzOuDy?=
 =?iso-8859-1?Q?9TH8dcAZcKYDIuC77nooypM+UOKLH3sLPAjxQPJW3/DCkB/haFPQ1A4Hx7?=
 =?iso-8859-1?Q?vFw/X5TY1oNlDoQecGeUM9VJrnkYjJqoT3KRLyCtq/459po7EPP90Bq3dq?=
 =?iso-8859-1?Q?Gw0T88VfTYwj0zYAwZus4nf2tjgEvlyAJI5NMOVNi41/HeTIzuh1hEYX8g?=
 =?iso-8859-1?Q?FhTOOEBgfxPQQEcy+Dqp2LGCKAeSdEq8JeQx6+eRgMDdH2tee9y6GVTDwG?=
 =?iso-8859-1?Q?9wJWM3bXO8Jnbu5mp1G719JNJjKUMhnPcQ1bkh8EQ6yXewxwP6unCDgJjw?=
 =?iso-8859-1?Q?82wvfUKObQaAiyG99szCynhiB3zdhlJAZhStls5DpCP6GQMLwhKhgoUCJL?=
 =?iso-8859-1?Q?SBa9XIZYVKuIADrEh2fZ6jF7R8CZW7KLWhgVDuI2WUlLLhucqbgpisb5O9?=
 =?iso-8859-1?Q?25Imr3gxXQTnegYRVh91ShBDC8UmaORG1ae1D5xQvfohujNKcxOSKW9jEA?=
 =?iso-8859-1?Q?+AQSQ72/W4sSeVOJz8UfsFJPZJZJGHPxhX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?rvrUpEx6z2jbZiTyafHn40N4G4VHNkNjL0tFBP1bjhyT1sIC3sOyXVaz6k?=
 =?iso-8859-1?Q?Z4cyClXRsOGgNokI2KkJGguE3l/FfqOH6qeW3p3WfDqm5IfKA9DkPfZO12?=
 =?iso-8859-1?Q?VxU3Sxjy18eF3vpb1hQp0g16f9wrRxtvKZq/TnM9owtXrBCx8rZzw4Jdp7?=
 =?iso-8859-1?Q?uGFqqI5sd6dWq9vgAGpL+mgyj8tNquZhkir72FTuuCETnqpo0YFplGVLMC?=
 =?iso-8859-1?Q?SDsv0C65QRE/Bkt67Eo4RfZk6Ka0LirAnA/5vPounBkngE7oQvBRT/i08c?=
 =?iso-8859-1?Q?qFUNEJaQhVQmfRfjmm94Al20qnUx8Hcs/M1Xuc89vc7bQuJBHjxfNyTBYk?=
 =?iso-8859-1?Q?cZNheIaQWNx7Q4i+lu0dhW/BElcfneaOutSSIkcTXFLGstayeVwICXn2i/?=
 =?iso-8859-1?Q?bE0Qpefdtv/nLW8jG62mfpb1PALEOBbFJsyM69wmQpDb8IYVG5GoruGDT5?=
 =?iso-8859-1?Q?6qGCtqjroSMFYzJ1pAL+At0RUFhAg1qaETbMZpzPws24C4aj4lqf0ZRfYX?=
 =?iso-8859-1?Q?2+nDi48eJ4r4MPvVxsABzMp6Be5Icltz7Pl8sLpWIxaWHlPo0Kbl8vCzwE?=
 =?iso-8859-1?Q?C4aThmeAY+IMz63c7301CGeagEbcI2jc9BTrWOWR5c6OFVotPGx5D1pFuN?=
 =?iso-8859-1?Q?6cMEPrIR6FwnmUeE7GcZ6MBc6gZlGDRVco9IkdnBk6UejFAxtOFsZnxKmE?=
 =?iso-8859-1?Q?Uko/YTEsFm+BS0irhPIXe1xoEKCLLD5XzAXeaPjcGrB7xt11XDGUCbl/XE?=
 =?iso-8859-1?Q?nYyodFTGDxlr7GpEmCZUHZcxvS9rNdkD6fqFUER5LmgKrFqN56OLhsId0i?=
 =?iso-8859-1?Q?7nFufynqb0nTi/Bc8ONuQPfS9jc/9PLkurAfP1IV4w5KokGdCHvNINvpr3?=
 =?iso-8859-1?Q?BcWVEj++YKVYevue7dFuIqpkFMQRXHZ6wLQibPtwt+3hZvz0wyh8yZYgMI?=
 =?iso-8859-1?Q?HDkV6HU1WwLSfy8ihejIuOBlOWu/ZIBj42xJifrVrGSIx6usR18SSg=3D?=
 =?iso-8859-1?Q?=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e05df8d9-a28f-4126-1450-08dbc44e05f7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 20:19:19.1378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ail7xw2geQ0sUy8O0ks+S3lsnnP9w7XKt+PjHmQFlLakB8YNHKj3DnUbBu7+nHHXwKzQpKxaZzFiH0dL+M+8mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_18,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030153
X-Proofpoint-GUID: AL7Z7_dAhp_CnqqsoipO1MLZHX6BqA3i
X-Proofpoint-ORIG-GUID: AL7Z7_dAhp_CnqqsoipO1MLZHX6BqA3i
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,URIBL_BLACK
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/23 15:35, Rik van Riel wrote:
> On Sun, 2023-10-01 at 21:39 -0700, Mike Kravetz wrote:
> > 
> > Something is not right here.  I have not looked closely at the patch,
> > but running libhugetlbfs test suite hits this NULL deref in misalign
> > (2M: 32).
> 
> Hi Mike,
> 
> fixing the null dereference was easy, but I continued running
> into a test case failure with linkhuge_rw. After tweaking the
> code in my patches quite a few times, I finally ran out of
> ideas and tried it on a tree without my patches.
> 
> I still see the test failure on upstream
> 2cf0f7156238 ("Merge tag 'nfs-for-6.6-2' of git://git.linux-
> nfs.org/projects/anna/linux-nfs")
> 
> This is with a modern glibc, and the __morecore assignments
> in libhugetlbfs/morecore.c commented out.
> 
> 
> HUGETLB_ELFMAP=R HUGETLB_SHARE=1 linkhuge_rw (2M: 32):	Pool state:
> (('hugepages-2048kB', (('free_hugepages', 1), ('resv_hugepages', 0),
> ('surplus_hugepages', 0), ('nr_hugepages_mempolicy', 1),
> ('nr_hugepages', 1), ('nr_overcommit_hugepages', 0))),)
> Hugepage pool state not preserved!
> BEFORE: (('hugepages-2048kB', (('free_hugepages', 1),
> ('resv_hugepages', 0), ('surplus_hugepages', 0),
> ('nr_hugepages_mempolicy', 1), ('nr_hugepages', 1),
> ('nr_overcommit_hugepages', 0))),)
> AFTER: (('hugepages-2048kB', (('free_hugepages', 0), ('resv_hugepages',
> 0), ('surplus_hugepages', 0), ('nr_hugepages_mempolicy', 1),
> ('nr_hugepages', 1), ('nr_overcommit_hugepages', 0))),)
> 

Hi Rik,

When I started working on hugetlb several years ago, the following libhugetlbfs
tests failed.  This was/is with a version of glibc that supports __morecore.

noresv-preserve-resv-page (2M: 32):	FAIL	mmap() 1: Invalid argument
HUGETLB_ELFMAP=RW linkhuge_rw (2M: 32):	FAIL	small_data is not hugepage
HUGETLB_ELFMAP=RW linkhuge_rw (2M: 64):	FAIL	small_data is not hugepage
HUGETLB_MINIMAL_COPY=no HUGETLB_ELFMAP=RW linkhuge_rw (2M: 32):	FAIL	small_data is not hugepage
HUGETLB_MINIMAL_COPY=no HUGETLB_ELFMAP=RW linkhuge_rw (2M: 64):	FAIL	small_data is not hugepage
HUGETLB_ELFMAP=RW HUGETLB_SHARE=0 linkhuge_rw (2M: 32):	FAIL	small_data is not hugepage
HUGETLB_ELFMAP=RW HUGETLB_SHARE=0 linkhuge_rw (2M: 64):	FAIL	small_data is not hugepage
HUGETLB_ELFMAP=RW HUGETLB_SHARE=1 linkhuge_rw (2M: 32):	FAIL	small_data is not hugepage
HUGETLB_ELFMAP=RW HUGETLB_SHARE=1 linkhuge_rw (2M: 64):	FAIL	small_data is not hugepage
alloc-instantiate-race shared (2M: 32):	FAIL	mmap() 1: Cannot allocate memory
alloc-instantiate-race private (2M: 32):	FAIL	mmap() 1: Cannot allocate memory
truncate_sigbus_versus_oom (2M: 32):	FAIL	mmap() reserving all pages: Invalid argument
mmap-gettest 10 2048 (2M: 32):	FAIL	Failed to mmap the hugetlb file: Invalid argument
shm-fork 10 2048 (2M: 32):	FAIL	shmget(): Invalid argument
shm-getraw 2048 /dev/full (2M: 32):	FAIL	shmget(): Invalid argument

I spent some time looking into the issues, but most were issues with the
tests themselves.  I did not attempt to modify the tests, nor do I
remember all the issues.

Please consider the above failures normal and expected.  That have been
this way for many years.  Sorry for any waste of your time.

Of course, if you would like to look into these you are welcome.
-- 
Mike Kravetz

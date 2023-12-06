Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548338064DA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjLFBs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjLFBsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:48:21 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8701BD;
        Tue,  5 Dec 2023 17:48:27 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B61YU8o018364;
        Wed, 6 Dec 2023 01:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=2mZHxIoaUMG4xnTvWzqgSiTA0NOw7zaVKS7AHe4uiMI=;
 b=PAN45r37snKy4rUYAc2YfyyJh4RbmfnO1D1T3hKAgILooEVtEjOzHt/qoyCSaoy5IjNb
 1JO4ozeHGke38ydedEX6ia+XaB0h4ccBMxH6QggCDeO1QXrEEHOaNf396AMxVbl2IfqR
 CQOv+u5Olk2IEldQW1U+rHQmZBh6fTIhETuqN0DeWBqlY79G6egv0K1ayg9lanigL3kd
 k1HJ6nrReZ/70yHiR6F4bYFkIXqPcTyA7vjg3gEKDesPwI0fAm+1K+WDWLMnn3EfjXv9
 QWHggT70ZlIBCR2kBxh3GDcjlBVBevW2pdhE23ROrPM07bD8Q9PDx2uLin758FhyShf3 Xg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdda04kg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Dec 2023 01:48:17 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B607iFv039890;
        Wed, 6 Dec 2023 01:48:16 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3utan53tgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Dec 2023 01:48:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lz/cK229WkaNvnL6E2jQqJj8I5SSIooNz6O6FdLbaaj6PDgwAouLyrs4JKKjn13I3jsbcE2+DoGeiU3zyPyw5T22faRQelGeIW0MbEJ5myyZa8+ugDVenNN/Eva8Rq5A5UkmdQoTC/ykgcHdGhy7XDOOYbUzpmyYsruW6fHI1K4TSKflxgzF4uzh2yrquSn++4MyjTfyUQGB3TcypfnaMX3gev77G0eMJGw0sQq42bQyl58a8OEGU3yKhkrtyQoVRbirbOPb+wPUvA1WXCSM+oNG6zZivxJ+NV3yHZbuQ2IR27WaJ+GUt+l6HumiwmOkRHs/YzEB27cSwU8lvZiOvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mZHxIoaUMG4xnTvWzqgSiTA0NOw7zaVKS7AHe4uiMI=;
 b=EN/WdKM/AAwJCLmN+d/Y4MeB3/e3Yu6AOqnqZBFgWp8d9c40r5lz9cFNKUVSz3oAoG7kYAGMdB5hl2mw0ArSNxMYsNmnRgMmBLGAUa8xfMMWVX4mXbzNwpltz56SIjZGPBO5SUG4qN31QZfk4j1fOEYC2LAx8rN1PX/AXI5FTrqXIF3MHEluLE3JNYOksXsm2rCa0e0jPbTc9YRWcF5VZMb5FcBOJDl5xX6Bsk+lM2A9sGcKYgHAoUtnzHE8XEBxlhH+fifWY71oAnZx3g4jwV06z57YHlz+yUS8fJs9RDWLT4giDZAbf8ploGUp76FzvwIggAjKmopbLzkaGu5P7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mZHxIoaUMG4xnTvWzqgSiTA0NOw7zaVKS7AHe4uiMI=;
 b=TyOhDrt+axNBdG0Gxnf/45LW1qHXt6N9xHweRfDjATKc96CXVxu2olT3+nzlv5VNG74rjzgve47H+uRzXM/NaLIvfkUf8wRRAW9Og+Fe3bMgt7I/YSPRaZiEulwqB/sjQYr+D4+DR2VpkPlNeOih1uun2Z/MWDdPXnI+TcgHJT0=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA1PR10MB5841.namprd10.prod.outlook.com (2603:10b6:806:22b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 01:48:14 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972%3]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 01:48:14 +0000
To:     Artem Chernyshev <artem.chernyshev@red-soft.ru>
Cc:     Satish Kharat <satishkh@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] scsi: fnic: return error if vmalloc failed
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1cyvkp0dm.fsf@ca-mkp.ca.oracle.com>
References: <20231128111008.2280507-1-artem.chernyshev@red-soft.ru>
Date:   Tue, 05 Dec 2023 20:48:12 -0500
In-Reply-To: <20231128111008.2280507-1-artem.chernyshev@red-soft.ru> (Artem
        Chernyshev's message of "Tue, 28 Nov 2023 14:10:08 +0300")
Content-Type: text/plain
X-ClientProxiedBy: PH7PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:510:174::26) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA1PR10MB5841:EE_
X-MS-Office365-Filtering-Correlation-Id: e7c978ae-7bb9-49e1-2584-08dbf5fd68e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ybrIa5skFW0LJJjCY9H5nW96kdx0JdlzBzjly4Fap3N1f/C911w/RWBvx4lHlciOl7PIf/Ygvo8Y/YxUB/aOtNpvnnCO7GZMPh0M0PvNr19LdDqwhyp3OBJxXr8vYRyyBSRTLFugN/me7hhj/4C6+nNGrxSuLW1oZsfIRtR8gZzzPos5XezHhtIHpYhyLyOATZ02GuJmRM0QUQFoAGc7RZAgZF+UBCx0kOp12qlkaxKEHttSdMEu0YFmv+Gm4rLdKGBUmI30QOhzXGBgN+T54ciOqBZb4AnTZOVhZh+imrSsxEJApADgY7jY22wtQTt1C4Jbctf8xZ456sK4oqfj6h8RioTTuAnjjUdkk0bWGU06cBvbFIhF5uKoD5Y014tEl6dbcV7JmKEG3QpOYPAETFEAtMWXb3QumTKw9tPKWX5OMU17ylvhVXgMm6ZeJp16nySjM1CQG4eWmFvkiCowVeJsErF9Bn56sFwo2mq/Wd8TqLxvobb/Owf7rVRZM2mZ8tY3LID1E5UAZ9qe8Ww2qEg66MxN9TA7MBwEZDAQw7sNwhhuVa0ZpW+JMwVaR4MJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(346002)(366004)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(38100700002)(41300700001)(83380400001)(558084003)(2906002)(6512007)(26005)(36916002)(6506007)(478600001)(6486002)(5660300002)(86362001)(316002)(66946007)(54906003)(66476007)(6916009)(66556008)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xDGDRsDs5Pq0wO1azzilydz8VeQ8nKD+CqKfIVBhiTrbq0NG7s8yHcPNbTti?=
 =?us-ascii?Q?gkAcIG4ZoT2yL4fdU8MPnkuH0XARG89rZdaLY5OBo+BylUu2BbSGeNMGSP4m?=
 =?us-ascii?Q?ztwoQayV2zhBI1dDHGcELaSLWZSyPaIByaucLTttCQjSDzuSki06qM9nQ8H1?=
 =?us-ascii?Q?VX0TBwTApUSAA3Zlm4H+FWSlzSOCY/f/bXMQ9a9vrzOABzZrrdHeaGPfoeJG?=
 =?us-ascii?Q?y3HjP7Oc78Skm9WEFRtCvSnBNjX+La4nks3c2SuHl3wvcjn6hglQboPwraEN?=
 =?us-ascii?Q?+cRaxBLVlS/36zm+LI918QCx9uLJ57pKY5u6Yj7HjcevJw8vXbfLvD5PHGXj?=
 =?us-ascii?Q?LbqqMgUXzAGT8UWYdlPickaupQIGIGDfS5T3Ta3StIjYdSHtKC68sXSMmaH/?=
 =?us-ascii?Q?mV+Qn7ejTj1FHO3TrXhtqdxh/XyhknIIsueUxGqY9PZztis0hmI8CSPVTcSm?=
 =?us-ascii?Q?EuKCFUgZIhMDgAdmiItD2S2zQ0P50/tefNV6fiyq2XZON1hhwrEugwuFa6s2?=
 =?us-ascii?Q?hvVJOkGAoCDHZPmjByEGMAXiRY6XwaKgc+8cr/tWjTlbqxFWZBv2UroUmS0H?=
 =?us-ascii?Q?Z9/aKCfChMva1iFH2dzQEaD2NkmgJSshhEurSPWoFnAWp1RhBnRL1a2xmlSI?=
 =?us-ascii?Q?qswuFlHQ3H/H9EQFnM86wR5m8XjsCbgCeu/QnpZpP9Ser9w4v1rA7RdI6GtY?=
 =?us-ascii?Q?3PwgLwHlf2OvTj77kFIv6KLzXdndHuyQsDh32a3RmTm9810oRzFo++2kOKjf?=
 =?us-ascii?Q?yW466Z5Xe3+exoK6l9mwsor06qNEKBvC+XWhh5cxqOQQOz8wnTXY4zfpkmNp?=
 =?us-ascii?Q?UVnzv/3/j445qCrlugEqIpUaHIG+YyMxM79CDBIVcdtcPMG9CEbA5zwfzSS8?=
 =?us-ascii?Q?qyawDfQkzwEJ8XVGrjf6hwGzRambkY0KFOFwSQs9CI+JCtNIkpSWpIHJjxhf?=
 =?us-ascii?Q?sSaXK9xezecWgqOAXppYZnDPsRQFeL4ZN6ZWmq6eRMlFW901x0CZCkn+MYuK?=
 =?us-ascii?Q?WoRB1s2CDX6sQJvZxGbFSjS7nRPTbumfZuhq7NSyZ8v3sPNVXSzDAWoJXHy1?=
 =?us-ascii?Q?+BOnDRg8oy4Wap4aaDXTv3mTmy2fssuCgXi5Rxqxw4PXXaImacEGDPXoK+Ot?=
 =?us-ascii?Q?JeWmFQINm7yQepKqbL2GSz9U9joGkRLeZFuIvnioIWL1ivNKBW8dkqv+PSwf?=
 =?us-ascii?Q?PZvsXCSFsG4rc6jHjEQLDNKAi55uNqUD8A/FQD3k73uxFDCPukXcH1hdNLeb?=
 =?us-ascii?Q?TqCu+Xy91OTwXmbgIrnSKT4xtgM06/wt6xznipJ9fz2dDn0nygNSwd/lpJmk?=
 =?us-ascii?Q?trYmE5F63ObElQPO7HzD/zLfvT2XIugP074XukGLNgarN6HYWsf6ncA+3RMr?=
 =?us-ascii?Q?s9PQtw2fh4nwukZPxd7GBdNnO23Y8ScZCnI01zIavelgrVGxUnurpUCS5ov7?=
 =?us-ascii?Q?9HDkHwrXGCztoD445T2kaHsq23lD0MSrkqWpIQWyG7JLoEE3jkHPalKQe7ov?=
 =?us-ascii?Q?nBHxE8h/Au0DqguLdyLpGkxpF/8utBJZkCjGrVoQG4w6vixGTqXvEjqIgHKX?=
 =?us-ascii?Q?opCgmwzvBwrhec6J7Q6eqjrEavVbNYZF49/uDEeVgp+rRUt3T415bhIzGLes?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0vJpzZLEoZSJOoRULiqKqcOevrsF2l2NiPcl0njvN5e86AzGxRPY/zd736b+qjaso92efxoHL44P86NyBjiYJeizXr9ihICDCyel+nhwJDu7gT4yfz5k2wk76cJSJ64QVa3hclPEJ3eFzjS3ne99euFeHeJSu93kFNg9+Qk5XDT4IqebGVqOiJKZUzKjW7nvl7eCaIWQIdynhE3fa5rBqPdPtIszzvHPi7LmtowWBFje/Vn1YrurYE8LYqupLJa/6UmMPqbsBH2+73hAbwkicSKjZnYzUPuPRCZUCPGeL/IaEH5Tt3oA+8G7xBtbSt8Kn6SoSIc42oaz0RX7p5LUjzYl1XYH3tgV9a9TzUSmFu2jH1dNGYu3fZ0fiz3ZW0/yfdPQOAaoT+tRlG6SbGnm5PYkG0WOxQo6TDq0bpFucLiDnQdifbWh4dTCzQeS+BJtiP/HdOJNcDBtt3C8evUckfcpT984qhZhipSZ8ScyPoVjBWF7GbQ6cctlghK8O/ZAguf1HCFqphC1x0xM62SNrOU4hqwZa8VBaK7+mXygfYXm5UW5LG97QsPWcWhq8XtbET2ikIfJBR06mKmUSnBzy3Xi+57USVoUr5bU+8S3O5jZvZdr4d5nhytKqEC7du3UMNTdomXkeVPja9Fw6BohFzdvARUcet414EolXXT1P34Fw0AYk6SarFoJiNO3mRJnuKEoNkMcGE26D+OsWKzZ8kDjX81Ck4YVG1ZdfC1xiotp/tmQlJUDyLtZcZG9vPhrzUL0dWQScFrFgStHEzIvaWj3pV//0iH/wk2yRS625kGa+0X42DhMHrMXQ063O80zQPIlBMpsF38fEiLBEHR5/sLjwC8Pq29gChe+2Y1Xm/bgX+EeeaSZI8vbOnpK/Jxo7Yk7KlbvUmrIAK0D6fxWUg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7c978ae-7bb9-49e1-2584-08dbf5fd68e6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 01:48:14.0136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EeBqXPDVQflZD6YUKS03oaSJYpVzRsxg8EoudmhNR4h6P0ami7CUbi3sy8aLCi+fWTzFrYEHZcFkTdOwcg8NROs3wk8uwAyRd+wZjSO+mF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5841
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_01,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=824
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312060014
X-Proofpoint-GUID: 0Muf302U2qn3QTuKSuGG5f4YJEjS_-gy
X-Proofpoint-ORIG-GUID: 0Muf302U2qn3QTuKSuGG5f4YJEjS_-gy
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Artem,

> In fnic_init_module() exists redundant check for return value from
> fnic_debugfs_init(), because at moment it only can return zero. It
> make sense to process theoretical vmalloc failure.

Applied to 6.8/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

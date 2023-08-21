Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BFC78347C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjHUUop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjHUUoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:44:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CEEE7B;
        Mon, 21 Aug 2023 13:42:47 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LFxuvc028627;
        Mon, 21 Aug 2023 20:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=c1OuceOe1arvzXT01gusw2krW4XI4kQ3GbK5taCWWzI=;
 b=P8NFDA+nc69f0oxlXmD9NbpaM9r/plnsIBdyEIq+OPdNtbLgmjiwT18ScZwuEVRDspAt
 WMRk9NtLbd2v1ERkgJqfu9/NzAf5wnat7AQoq24C7pohqc8nZlTk3C/9LZWbnM0Yxka/
 cCMaRv8pJkfjl8jcnmsxEay5hDniv391py34nAenJiUdDj+K+ElBkqPvpS95ePvg8ggZ
 7FPKdr935osJi85zc4YkGI0DZROUg5Ioyn7ko6AnhSyIOTNRto6G7D12WnpDgd59r51x
 jT0GOz8sIovWwMpX+ojjHSs7FtHSMukJtvBngc1UavqdriB/cfVgqZ1P6USRdR7IVwcS Gw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjp9ubs09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 20:42:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37LKKcZQ029896;
        Mon, 21 Aug 2023 20:42:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm6aexvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 20:42:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lpyh9dP0tTwLcAMKVyXlHnTI7C8GmB+3ej7woyb9gbzLq3NvZ+90zSEQxYhP6CGsCNO+e6W/N7MEHuvk2ZEt21xYy01hJUXOlA8BB6Gmr/C6+xmrJDRrFKRc/gl9LCIvN4zgW5z+6NVmoQPVLHzQERH83U3/3qhXaw+XQPy9sj5Cpelh64blyat5eQvsGKSjX5oZPaSCgy0piQXDr+twAvQ8jZZ+oSpc4ChnqEEErBlc2ARej2d5cj8ZlR5k2dQoIBNzCTj+JTKPOcA2lrwWbKymjCGZ07KgxclR6KEsM40+cNaDpoS6bek35ZztIeQ08jjW09rZ7+JsKEZKXc9a1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1OuceOe1arvzXT01gusw2krW4XI4kQ3GbK5taCWWzI=;
 b=XEWAqxvDfXrkXS5MfWiOFHfFBqyl3egX39vaDnZ4sopG5zgDMFkkzb/bhZH2wYSUhXqxLio01aJ6Z2xYYyxD8uurt13Nc7QqFfvi1W476P7xz1l2lj9USN7Ak9uDweVg4DziVrFMri2sxRognhxYmHtlydxE6ma+yZeG0frax2QobuUgF7xy6h2cpQX2ZVx+PAHwyDntBHaBO9MvwPkeecPIUCLPWUAHtToyuZXf5rNtbNRHtdHU7HxKCAjSam0E1jQSSDmN9d63g002ssRvLvy5LOQ9UicUjI6+PyGy9dxYOw5f6AarqK6L8D4ziPAIgwAolZyN4hCJzmg9DCXMHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1OuceOe1arvzXT01gusw2krW4XI4kQ3GbK5taCWWzI=;
 b=jwvLosuJxPcU6TuerBPWkp+iEciy3wZvlzZUjt+8VurEKt8oONbTlNiI//kLoSq28PxbWM6BshCI+tNesg6Gk8qPKIIyngq6G+xzwkPu8vueoC8jO2UqjHkKsX8Zz9YOWfKDaevTUIAs1tSm0WCLjuQ3cerV3Pn1/NgTm4LAs0s=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM6PR10MB4234.namprd10.prod.outlook.com (2603:10b6:5:21f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 20:42:40 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 20:42:40 +0000
To:     Tony Battersby <tonyb@cybernetics.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: core: Use 32-bit hostnum in scsi_host_lookup()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1fs4c86vc.fsf@ca-mkp.ca.oracle.com>
References: <a02497e7-c12b-ef15-47fc-3f0a0b00ffce@cybernetics.com>
Date:   Mon, 21 Aug 2023 16:42:38 -0400
In-Reply-To: <a02497e7-c12b-ef15-47fc-3f0a0b00ffce@cybernetics.com> (Tony
        Battersby's message of "Mon, 14 Aug 2023 10:03:25 -0400")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0014.namprd08.prod.outlook.com
 (2603:10b6:a03:100::27) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DM6PR10MB4234:EE_
X-MS-Office365-Filtering-Correlation-Id: f18afe07-4070-4ad9-35f3-08dba2872991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: irhk1fSg5wrfHth8+HUlvhcZqt5U52dfVjesB75kLknc97W/rNuRRsjRk2HF42+8oJegu6stJ4RAFHem0YzveOTrcnVpyQo4fdXZO+II2jMP/ht4L9SYM7J3SordCt62CJQPba1oxfdPHSD767gjNC0fFgvjEl41c8miShylt1HmIlTXdKUg6xEbo3Q6pdyJsZTP2PzlAv39lYu2/qfDnqcmYH4o/F9VLAAmTF9Vf+Ua3edR+sppZUgcCF+UeHfojpCS+SmfbWYUmgE2SrnN9M5ArB3rehr5jgTxHsGWHl6sGOucPqWfsSJ1Nv3MhtVRaYuHAKA/Wizk/Nke5jFeiF+WGRxS6LjPxGgf1Vhsyn/OjnNkQBLQENBjk8yghWse5iJOxwO+i0pNKgOh8ZoCVizR52ZymnZz1CdKx6Vxp9DoeP97VWU1SqA+AnbrlCL6Qzw/cmoyIasdDBUbb5quQ0XMH7M8ydmSvCeVLooXXg9T1vpMVAot/3zhXkvwLyiiqtct7CJLJUUrhbJRmdF1lDrGrFFSnZ9TB2HQxXky5mAGvf4GZu5HUWQq99p0ssE/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(54906003)(6916009)(66476007)(66556008)(316002)(66946007)(6512007)(8676002)(8936002)(4326008)(41300700001)(478600001)(38100700002)(36916002)(6506007)(6486002)(558084003)(2906002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8DYXUF5z0s3qP2NggPIp5/GCixD6sh+XnhTdFg72hi6qA1elkqhT2eW1PPWD?=
 =?us-ascii?Q?EmiB/G38iF+0vKpEBDQ95uC+OMwasexQJZuh6R9k7HJ9vlGCYhla0Cz/Z9pX?=
 =?us-ascii?Q?cFVJyZg9WaIy5fAyP7EJBG+UXTNsovkm2KSzLyBVaJEevwafYpPMiPEPTCpb?=
 =?us-ascii?Q?TY3YZE8Q/y5DadK+V2kHNREkAELD8bAiLodd3GbTtawy1HNX4bgJeFJOt16d?=
 =?us-ascii?Q?sOHpBDDM6mYMMUVXW5DvotoYCtBOeFyJxGLwqSkAhJT7OgdmsHaaYYQEN07j?=
 =?us-ascii?Q?OsGlULzkSMRKtbTdvCKMBM6hgYJr556r4rL7cbw6K0cOe5KELC+8cUlcJ3yr?=
 =?us-ascii?Q?LZRg6dUJ3tEnhnjrtYPSm05c2BhXLLLK2YRsp0pbc65WPidD5Zvii1bJLds2?=
 =?us-ascii?Q?zyrWb2wu7DqIfG6V66hz+LIzsaavOMeqMnriVeFN4LO8c/7XFb4vo8Vc9x9K?=
 =?us-ascii?Q?yUAcooYG4v4OZri0AMa6dIZda1eFdgbPX+gf48Y8UzGo0Lkd2IL4euJGEV4d?=
 =?us-ascii?Q?JctsRwWFIpPg7HeUGNNAsdUvhWIdqjNa2sAE152x+osuTV4e4Ls1oTkHqB1C?=
 =?us-ascii?Q?Pwd366zWRrflp3dWT3j3P4/hT53iDBTtLiKGmt7FYD+54TfMItlWO/VVSuP5?=
 =?us-ascii?Q?3q0oY9yXAi2DnNjMX9DDe0kYmaENUH4p+KFe8t/oSVI6RufqsHImWY/HQgyq?=
 =?us-ascii?Q?83mLZLIMe6YWSqLiJzDMIEGszTP/MY8og6XcmzqGK4vKr16axfpkphzXflfb?=
 =?us-ascii?Q?zdFf1i+E8biKhVKiZ4H38cNiJDXitxM5oJAfzwBCGkhJZoNlsQwMHwAI8PLL?=
 =?us-ascii?Q?/tAHBawqI0a1d4pLSRyL/sQ2NuTYzZ+cCg2zB3Wo9VPA/3N11p5VgU0dLHqM?=
 =?us-ascii?Q?woRINNFGomBrP9HHGhngFbeb4c27fk51XnxH13bls2+3XlrMk9hvDZUNkC5t?=
 =?us-ascii?Q?v5R9T5aTcU0z5SU5a1nD+w8FsGozEyhp0BUhS2mqOe2/+3iby+hWPgI7gmnE?=
 =?us-ascii?Q?O38uY2taEOScBYhnsLSIjyuOHohO4nOGxc3CsZvSaEsbcuAcAUARyYPUtd3x?=
 =?us-ascii?Q?UxviMplR51+WEwARvAiqRG8K48QPy+ATNzkgvEYtHyYTKWAqB0RxstatiySo?=
 =?us-ascii?Q?I1e74tMuvuh8JZ2jxtFXJGlXs1ZAQEH3+xAwVAUCM1V1ycG3TBDjuiz1FnC9?=
 =?us-ascii?Q?ngHKHhlVVmxkAlBr2zBfRN8XODYzOHCgXxUcTZ20Da1R7rMXZErcOzv4c8WR?=
 =?us-ascii?Q?OeglDaT0uHiQIJ7OP7A6Wh81O4vrAG0i4N8/lAOE8ghn5PWofvG+Sg+MQQuz?=
 =?us-ascii?Q?tAP50kpuvYwl9NVdm7H+Fcu67ciWHSLPqINA+J1trOtPoWFsTNHRQ38v8PAv?=
 =?us-ascii?Q?8gYGSEH4HcOeQ/mZGdhgehZqarFAuG1s+nZT+70DzFqQWDpIeNhunub2Beh3?=
 =?us-ascii?Q?PXw7DKTZfcC6YF7yV4dDL7ii1SkOOESuwsbpnz86kBL3qBWK3guHbYB2DNiW?=
 =?us-ascii?Q?VjQYU+7FVNfIzv2OZMCl+QCUpkiontsFjWPQL2ttEWsuhLQ8WDX7tpwYZydx?=
 =?us-ascii?Q?XN7HgnI3G7uKQHgG6+3eFW0XxwfypxnsQshGi7vL1XVvuUkXTbIjILYbjIGj?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0x+HlJMB1iT5/nS9QB8rwZnG2EGNScgEdwl3LS9p56rat6V1Jl0JXbmF+PAQ7tkAQHI3KITNFgxtrYFP5nrUdc4sLkwEPriqTp1LAwivvUxUxgEUVPS6R4ZKJcfO0EhM+r5H3LgWOl33/0aNvo6+trlque9hLG4NHAg0nk2CrINT5AK7jEaQXTmepoLCZ2RTF9R7Qf6341fF+KfeZkkn1YwizReGPY9OGe8su8mZGh+IWLwQSe2zjiPBoh42AVuXUSUGBEV0bC8HFcc3uV1dJNHfcHbe+TnNg8RwfqC4iokfv0PEP0y66NTFqo/+NuQM5xUQw5XHl7UWdwjImY8vCWRLpeq8KhYot69an2bXaXngtrBAnc2DnW2shgoUvruYF+6I3TiXEA5ptoX7LZaXJmAvhenGYzR5dPs9bkqwe+WduOUgKtc5XUFOvTeg73izn6ARCn3MVU8VQHNOT7ZUGSGDQ9Ex4OHiD/tItvq8/I39JGWDb9QWv4nRcCUCS4UJHqnJ/uIM7coqiha5/90GPgqkW6mpAFPO1jMy483s3kLuIojWxq/Hi3HV0oEO/XRA3c+yMiqKC2UDOIOKM8psAMQj+UKIXKslWu1LkK19WtbOMeeH0ySz1QekzPiNNUNN+h66MbJ4rZC0l74zuiyYPneSovNS2kyWDxaN9roCMlgwsi8zwASELqRhv8TUxA1iOeXB5bgw06sXquVIJAaLPaRj8ckRzlk8WxPRtmwOes/8K3Uksk5neU2e+i6+CNuE7zQv2QANG+slhGjPEq9bnLor0DXEKeqaGFEp0Mz5qz3JoO18qm5zHaOujQGjF27P4m6EVQKNlrs7RXkSwhGV4g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f18afe07-4070-4ad9-35f3-08dba2872991
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 20:42:40.5834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VXVjzJI06jzQ/le3GQkzNYaskRYD7f1NpTdXT83R03aCOKMgbtlSIiKYIQnKS3IleASfpZ8U/JxWmgSU1lu7tSilR5ltSp1qj9JZE/6YkgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4234
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_10,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=912
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308210192
X-Proofpoint-ORIG-GUID: U2qVteGMR_MkD_HHqyJyvKmlMz9uRZew
X-Proofpoint-GUID: U2qVteGMR_MkD_HHqyJyvKmlMz9uRZew
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tony,

> Change scsi_host_lookup() hostnum argument type from unsigned short to
> unsigned int to match the type used everywhere else.

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

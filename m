Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A445B7D5FE7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 04:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjJYCX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 22:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjJYCX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 22:23:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B74710DB;
        Tue, 24 Oct 2023 19:23:24 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OLUOtl004163;
        Wed, 25 Oct 2023 02:23:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=TIqylN3wvAgYRKjfYdoRqFBiqfjsaaZThevou/pUHZs=;
 b=NBFsFwew+CMfIIKRhbX0y7SmAwL8bLkbAyWxlwDfg2O3pytB67n/uFIEG9f/MGkBgl6n
 w0rSzAZDQ/baJ1wm+911VuYAC0Pvm/vfSwOkYlu3+1O4Y8bHomrC1Hz3d8j3Yeq+B8LW
 4Fj5iDsQ3cFXxdeOGjQSXntpEp3zN40lvWyyhXkPOW4OgAe483unHo/PI6kXdXcFa+lB
 9BElKS92upQR4ze6q2MFvRGEYJ17Vz8VmDYGAM1z6EeF8+qC1Bz0p+FBSbreyszBCSiu
 RTLAKgIEkkDoYZwvAtCG7ZXqwT5u/+ACuVTSNMhsSaPS6PkmV/shpXZDOiCaJ9ZsrSOH VQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv581prd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 02:23:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39P0XThG019157;
        Wed, 25 Oct 2023 02:23:20 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv5369ve8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 02:23:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lf6H+es4vX5pCpRfL97Y1Wq9DEgSZaMPq5oHlrOAv/Lb+ZcM1yqCBBmnQESjNUdsS43ULZDHn0fkNatyEQ+dG9xLMeOsay2Otu/+973orKQSRWpKu9RX6dFH5rltnbcf3WvYG087zrYUhbnRItu787+TtVR+Ah7Q0O0gPrv/vrh3yiIcQz6xJR913LfaP5b1HBaNgEZTixY/gB03wiE3XIgl7V/cGtq0/KEx8UQZOPSjFvzrchWbnk5vMQ/QHqGB3ZlhVMjjiuN+R5Uey5Oltu1QQ0BlloHKi4p9bSsGxJ/mJ/wLukP7OKu70w4L3vZr3VGnWUQXhOzmQbqvLyx5Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIqylN3wvAgYRKjfYdoRqFBiqfjsaaZThevou/pUHZs=;
 b=KfK63UMslI8ipMOoJHYsn/nc0CUwlyZ3s/dNmru71ANSRgLD8bdOuk8isiE689hcYp69+dmFGHKot/JuPCV3m+QJ44ZgDtM8u5wW3yvTevRpToqgtRZXFDUTyP5mNlN30ifPOyo8iVxw6gqQs7RP9RL6GLfCqGQT02y2SjTnxJf0ZMsn5gx8kw/AVIWCxyapLU2tLgO345GDPo4FUxNCSSIeebh6cEgsk1VxV2dOm51IHTim+jjkR+nnLOTvNQn5wPSXXkFzotYiEtcnNBwMlb+zPPH/EWpShkO1iFSvOl4oveeI1whIU/2/dDcCyshAVFK1UXL6PoJ4hifdBNmq1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIqylN3wvAgYRKjfYdoRqFBiqfjsaaZThevou/pUHZs=;
 b=aClZzzYdH0NEqzVlTB+AnD5UsVNej+TdGSBS/rCsLSv91wUFna642/44Sa9hJRG3FYpaKN+DErSHqPByYe9UZZ+sRV/jxHwG6bh4hoqq3iGo9wkdO7FU4913A9sC4iflaK1Kz0eOso7q4gud8EkN5NrXf/F7RbOV2Z64xHitgzw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BL3PR10MB6233.namprd10.prod.outlook.com (2603:10b6:208:38c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 02:23:18 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7afa:f0a6:e2d6:8e20]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7afa:f0a6:e2d6:8e20%3]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 02:23:18 +0000
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] scsi: target: core: Fix one kernel-doc comment
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17cnbfnjl.fsf@ca-mkp.ca.oracle.com>
References: <20231017030913.89973-1-yang.lee@linux.alibaba.com>
Date:   Tue, 24 Oct 2023 22:23:16 -0400
In-Reply-To: <20231017030913.89973-1-yang.lee@linux.alibaba.com> (Yang Li's
        message of "Tue, 17 Oct 2023 11:09:13 +0800")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0008.namprd21.prod.outlook.com
 (2603:10b6:a03:114::18) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BL3PR10MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: fc5b51bb-7ffa-4a78-96eb-08dbd50159d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /HUbi3J5Y/sz5ePooSW3a7o8fDi+MKGMgttsqtFmlAZcmPmgMatWWVgduY8e8ndeozOqy9GX13KogcLE1ggzxyhmHWaNap3iBKq1AUMYHvAiDHKD4/VpyOsb+cWglIyL3dB2qZjEEUTzskotkCElLBOzbVfH7ZEHJk7Di32wEBOHrP6/jSTHpFC5KXYMqDv62MQjfJA8jRlLG6BrNkKfStFYJMzYTKSba+iLRYT0PRQtYXDSpnk5USGtXpAUV6fj9J6BJdeEJhFOEn+eNSbEsIhTmr3sgYtWC5yLywOyfg6P5CmpWbdNtADgmQf+VEmnm8s6VWQj6ulDdf2xbCiLEVooYj6UFX0L0U/RYwv6KNu1tDIWJFgtHWt++sp6roXAp9MwJHlGhpyr3TWbFEPNV76ON7MkFl3H/9pfMQVIkAJSxwx9KaKVxmqlG4v9cym/6U7w1o6WS0Pt0uZhxStg70cTDMtqSzYJ53qPWW4TDZbm1AKYTpWz8BNlEqP5m0GwxOPSR6LtuTESkPHy3MOSCWV6CUlno7QVZ2GdB1mWGwW7M8g/j6Kj6/EZ2b/m/dRE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(39860400002)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(83380400001)(5660300002)(66556008)(41300700001)(86362001)(66946007)(66476007)(478600001)(316002)(6916009)(6506007)(6512007)(6486002)(36916002)(4326008)(2906002)(38100700002)(8936002)(8676002)(4744005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+PLzWbkowZIHTOnLM6ix8+RA/rlkoZ0pJ/9WApDlZIvFlipvVp/LvuIARlBe?=
 =?us-ascii?Q?AgT9x5lX0FZYljmTRlq43hqFUXm83kOklrjf05J7TlcqWZkx8cdTwoUHz6Fx?=
 =?us-ascii?Q?Lpd0q0z49VwQpoJrcPB+BImm8KlQH5VK2wMpAWb3/1FMdOO5Z+kw4RFlchQX?=
 =?us-ascii?Q?BLYVGZccqaSEZG8fEC+u8X9ZoR1+jbE1BzrRa6G32gjc2r3ebLkdjCpOrpyf?=
 =?us-ascii?Q?MH/wcaxLnMVpzTPXMGJ8ux/kpdGXhz1k7HTEYTQY3xbUBk4yZUzKHCHSZN/M?=
 =?us-ascii?Q?HNsBSR4yqvFkR3S85tjn47KiXy4skN4Y2ygoT6AVcYu1XrfnwVeZV+O0mDjZ?=
 =?us-ascii?Q?cqZCF18wtCR4SwdTo1X1kuZa+WM6uKXuRu4fU4B6yZf92eVZaBbB0axMDA4H?=
 =?us-ascii?Q?QZcZmk86dMNA70Xq6pC9TBRzksmlc9pnSyR5/AEPRbIXk5xy0X2NkwX9caQs?=
 =?us-ascii?Q?h7Q2mzHrmtD4+hcuCXD738tn7DCMZQJEqphh9nBqARexqkTAkNpqO6jGeY7z?=
 =?us-ascii?Q?E9EAExyeilVa8GH9RaCXkDvQSIKcrHhejqyIBmwjqSv6Ex9TDSo8cSLHLUFW?=
 =?us-ascii?Q?tccuCowZbjSujjoU7ff2fXV8Y9/z2M8rlULa/He9PwjQUEAnGxIZkkR0E4hs?=
 =?us-ascii?Q?g9SmEqXe/sKXYKtUXdhpSKPAfYhQDdOagwGtJVM6MoJQTXU93RPYkwkvItO/?=
 =?us-ascii?Q?3h9okcWxVJa6T6jA0fBhzI8PI1Ebu0ZIs1BMWwzTBQ3lJmKWxY8LamARXogP?=
 =?us-ascii?Q?IOgLHzaO62IPMbVG3CHQbsBAFXrMgMION8qOdJ+sw2nhHEY+j+sGrCDOqONC?=
 =?us-ascii?Q?/tcbQ8opD3FjFM41ICLd0cuGt1Esk2fXXFYTPL5vtBfAr3EDfYaqGhNEmouA?=
 =?us-ascii?Q?/Fy/nWrSKmO+4NRlVCR0l6O3kpa1ljeIrwSOFbhvPDwRkTuAmU1xP9qi05Zs?=
 =?us-ascii?Q?dvMTRTolFw4ySghkxY/nBnE8KhgcBN/7X/oiO48XoEYwmnPAHoDbpgNykCI9?=
 =?us-ascii?Q?jkmXJ8VMIJLr8kPWA8DDR8PZXoEIc+tlK4PGZ3FXgfY2Oazfzfn7oO1cFJk2?=
 =?us-ascii?Q?cHsCQ4aPmUcbxgEL42kEnAUHxaeZmxX+IAfXEbyFEZ/sAcu2jtbmZOsTamrP?=
 =?us-ascii?Q?KajtIfe0HLx3fWvNmBvYOlHVfye0vDMefAPsAFn2h1/Ou1IHTA+LUP2Rv1lF?=
 =?us-ascii?Q?4zcQPOf9bGlDivMDV84umiDckDp+eh+a1WBTVFSeFAcJ+homS106SVrJHvY8?=
 =?us-ascii?Q?H/h8g2AsEjIS30N21YTW6/niF2JFpCMDr5h3pUXYzNLsBXhzaSVtrmyJzcjU?=
 =?us-ascii?Q?bDOqcF4qif4YsY/aofkBkQMewk48ZH/yRv3E5HJvxRpWhQmuGbSy4xGd6ohU?=
 =?us-ascii?Q?PbTUm1dBgCgPcl3myBY6PaNRI2NLfWy7lxWEv7AQAPsZb8loz89kPfs/Ghug?=
 =?us-ascii?Q?HoH2sZdDCDKt4wPjPKg3YyKwEcb6i5iysrrGVDizCT96zDRzYDKn60d6zWVD?=
 =?us-ascii?Q?bY1xDLK3Y29L9kip2togBqa/Mw3Bz9OZRkJOiQFi9jhBSBiQPHCWaDpgAN4p?=
 =?us-ascii?Q?DfVo0qetToV2DsCQ6ecCqET/iNiqW+vNWF0ADaKdkJ0cbfGnM2LbGMBuZkK7?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VaPRN5sE4MLyb+pK3V4O6UI2O6V26+DUUM4k1YFHAgRHS2bJUiwQy/rzENZ6X6g/nlDL8TwLIAk8m/tmLjJeA3NYTnRWBD7fqEl2T8mEY5FO90+l0n8DARyqruC4/YDsGXgVrY0TmXjs6jfWyIUUNfFzTCki5LFBNHESAVMeN7Ggb+6qhlE9/D9sbSHpr9yQcGolmkzFCJ15GfarA8cUVi3aEStRjnpm8do3JdksE4rRlm+6qtoCl3B57EG5zB/b3pBzHEyDvP9SE7qRme8q6V3T3O9lMLVqGU8dXGh3VY765H2VQZ3NumvxnaHg1njQmJTXr4phYHQmgU1n0wfsqs73VE2N57nrHkSZCAVzwdsiIvMTidIR82oJtz5wXWDWncWgrC+FIN0a2cUSwfpRZzvrHwoddYmBagZqyeRGCK6BIgDKxZcHxbzoUn9GM67hK6Qjip9d4MvQnWKIsGlApIz09NGbdFw9CvIHr0Dalg0EzTn0uW/6OyOcO6Bels+V4pQblniAQWjWXm5udmzmLlk1OIbly3CS/bUJH2G2Tw1p9P/JOexg5/x1YBLXbgUDefcAnWnZFjV+Fr3lgfsM9w1QilT2MyeeLlTY2pl1HnJps+edsqvSkhNEGfk2jbj6X/At/GhpNE68uw8+ciCYWzY5iezD1ZpiNwYKm9Z3qYDaR5pA8jD07Ubga7h/TsZARhKnth/UI6n3ohmgDOYChhoXNLU4yldm9GVx8FryjVtbzwx3PZjRZVS0J5RahAxy+38XbXVkXJh0fBicm3WkdxRNL0/DlJiDqTXlPiwo3z8vd0lIXLQYBHtVuDJOHDhu
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5b51bb-7ffa-4a78-96eb-08dbd50159d8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 02:23:18.3604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zfR2FxELviGoXLayyAWwlIl6pNUEQMWSaQmCU/3Q01BC0NMIPeSN1w0AgwwPVSH1mIBAOdRn2pq6xdAMADNYL1zp5cwEbZNcw3Lq+DQ9+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6233
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250019
X-Proofpoint-GUID: PVnmxnskQmgAK2jWgWvJrZFz-L1EIwPw
X-Proofpoint-ORIG-GUID: PVnmxnskQmgAK2jWgWvJrZFz-L1EIwPw
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yang,

> Fix one kernel-doc comment to silence the warnings:
> drivers/target/target_core_transport.c:1930: warning: Excess function
> parameter 'cmd' description in 'target_submit'
> drivers/target/target_core_transport.c:1930: warning: Function
> parameter or member 'se_cmd' not described in 'target_submit'

Applied to 6.7/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

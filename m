Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B868064F6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjLFCTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 21:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjLFCTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 21:19:06 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E94188;
        Tue,  5 Dec 2023 18:19:13 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B620API020062;
        Wed, 6 Dec 2023 02:19:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=2WDCQOIkVbzMzmxPVZQ5b4RdLh5XrTDpATcNV6cUQ+c=;
 b=XuYAyVAOdu/cAbu1TbXENGCgNYKtkOqjAff777mhNEByeSPgcfNy0ymIkZPFqOf7gHKa
 zeZWuCCIskhJsSC/pllX1oM6FwpaP/4JZQbY6EEz3Oy39WxQMOhTEetCOdK1/5Wf2vFA
 CHlgGcnVZD5tHI4NVwbfsRXj4KYzY9tOb1tbUrh4GGM+UQMI/GdDAaYF3dAD6Ybuxepf
 6D7ZzIs7YXCzY00x6JwczJfud+JgcydBawyDz/59DRtKoTSnVhldd1/jCgCYa78hz7su
 QDlTB9B7Edolhv3br7TLEAMzHB8Re6bOdo+haEBUPVUHOr3JPM5SxRXW8U5rP3QGV4kI 2Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdc185hj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Dec 2023 02:19:04 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B608ASh034481;
        Wed, 6 Dec 2023 02:19:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3utan94jg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Dec 2023 02:19:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mM7ZReBKjkNuRQmm+GL4AOzryc1rJZX7c+PKCHj+ghnAkCTskPLfez/r6Qu1mG9B4L5IEIhfHfFY29LWIsCJLTZJKOpc3XYxBcqzUExW/R3pLAke75F4CRoxsc1gsIqzaIXOShwTpS0tFqiiYuYnujawtbpNYXkP6eNtcflyQtryt73WTqLwMO4WtFRtPLVVzSisCIb07TI1hgVge/16bmOgUwXLd01ydImP7oVoHGFxD1Pq6tSYH9Ka+UjXFxqwxYoHEkMUt5nG9932lFA7tq7tfnm0Sl1TZi9FifQ9QlnqEdrPE59J4hov+wjhZsxUL0qwGyG9UI6fIywQYQ0cDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WDCQOIkVbzMzmxPVZQ5b4RdLh5XrTDpATcNV6cUQ+c=;
 b=dv41/WPVCbHj1g/w9VSM2lMMQhQfoppxeEIIUEVxBnN7jn+9625el5aa6k969lFlf8Uk0sXZgZDX+BlgXpvU0dz6LGl21sB/T5fWVop0At2D6AfK+70bY1R4vjxyqpqwHSN+INYaYdIgsdwJNPWoQscl1OC92Yq4DVOnn08hjfXt5VvNgJPv7Dd0qOvUalvB2f/eWFeOhuucpyHu7fSIGrCTY4Yk8QUG4Gdiv1HJRL7MbrU+oKd5VxMVyegQUIs6IFqbw2cmHyQs9sX1LkvdaNSbAtDcntm3ajCcD8jquJy+XxRTt1EFI7Fq3yA0Uet2KwM3SaD8gY8cHM3we3G87g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WDCQOIkVbzMzmxPVZQ5b4RdLh5XrTDpATcNV6cUQ+c=;
 b=Lnm+jrck1DduCXnbR2pmo3XMWjU1lvtzR2C1Db5VK2kthc1xdgxmSWMfnUSKxcap/IHSPVsAoDKPDqUnxvHYnBEHnXk+x0mq5PtX7QadwWbef21KskLKot1mnmExQvY7ntpEtiBMjPXIGJ8pgMDK8H+bm4pf9CdgG4uaNqqdtDw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6628.namprd10.prod.outlook.com (2603:10b6:510:20b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 02:19:01 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972%3]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 02:19:01 +0000
To:     Su Hui <suhui@nfschina.com>
Cc:     dan.carpenter@linaro.org, hare@suse.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 0/3] scsi: aic7xxx: fix some problem of return value
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq134wgnkdy.fsf@ca-mkp.ca.oracle.com>
References: <20231201025955.1584260-1-suhui@nfschina.com>
Date:   Tue, 05 Dec 2023 21:18:56 -0500
In-Reply-To: <20231201025955.1584260-1-suhui@nfschina.com> (Su Hui's message
        of "Fri, 1 Dec 2023 10:59:53 +0800")
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0032.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::20) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ff28ce-bbff-4fcb-a3dc-08dbf601b5dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CngdYwn/SgcG5XFRMX8wKMjf5o2nGkSexWY64M+cCCFpai+eLv4aYbEMgUlNc6FOdnthoDfoZ4n55nAs9vlut2aOuDVCRkTUiBKI4AK4PKc+k+YdtfzdP0gpTrKPyN7pe0N87zx5mwWPoe9BKSJ4IMIjDYEf6fDLcvBEBFdth+Q+uv6QGBnk9kLZYUjiiQNBRH/igI8BWr2B+uePcm8Gx8z4BFqsdWl1Qz12BZust3843VauWLCU0l40/FuC0D/URDzTRR3BVr6is0+zhIB0AGpuq8kWA+LtiHq0/lSim7yqX6p7V1GojyD59rMIiA99KGr405tG4OWV1xV6hhsDQQ+wg30ox0OadOB9KOux7tlq3YuWrgOMctgBfTAT8OS0DJ5zc+8p5AI8D30GFcStGuzmFLzpKefCz0blLxjScL2vyg7IgKlFPY/5wsVAUb4ddEJVVCj6zalj5k/uZmdOVDVeZNegF5CXvSsyawztw/gv0kUiISRo0vMSUtqNaplJTQA1yUh/GfLsaSZ7ke6aERsagjsPB+2Kv2Oex+PYCA15I8/idyhv52Ec3nYjo3PA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(39860400002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(478600001)(6512007)(6666004)(4326008)(8936002)(8676002)(66556008)(66946007)(66476007)(38100700002)(6916009)(316002)(26005)(6506007)(36916002)(6486002)(2906002)(5660300002)(86362001)(558084003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yO4eGAxjyIDNIeJ6AjU8d4zMugLPuHCIVes+JAZim7qGnBHPErBAvx0keoSx?=
 =?us-ascii?Q?mLJeb3OJFaZsOAZWlsSyWrjycgHeD6dEcRruoKpIPRbQGkFWP2K33SlFMC8R?=
 =?us-ascii?Q?wVtQe8TOBmIaYg0w6syTSo2gruXZEpTaijvqMYcXOlI3niNnxDljxIm9invN?=
 =?us-ascii?Q?e4T0EUqCLQ2tPRlP2m+nlbjwt0GQyknn8QLlhKbt5RWxeMLE8QFVvmBq6k8V?=
 =?us-ascii?Q?hAGND7/eiZ7A9FLx2bL3xaqTMOK+uxW/8lSf3dq88zCBOdSS5W6s+PfIxh8w?=
 =?us-ascii?Q?jz4wRA0/dq9Q3ALNq3dZbEEhIJfgfllBUW7S1ijtME574eKmpcFmPLl1qw4q?=
 =?us-ascii?Q?+afJR72FZo0qeOqDLjnQD89ZCmaTpcVvf3BRoUSLNthkTRYOHN0TO+Z2KXz6?=
 =?us-ascii?Q?nEi5p8PTUS0p07l5upVfpm0TWCETIYSvDpPblTrDoaji4avvms5a3Rac1gE9?=
 =?us-ascii?Q?Zh3nJygLNSNRhfYWQhzWBsTTTSvHRtn9jp9117y0CodNmnxKnoeVDU9CPdSh?=
 =?us-ascii?Q?iIdMtlo+EDHsIoB4wBJkednmX/yCIeYXrqILKa5Ykz6BLCia/yhfjN89/zLc?=
 =?us-ascii?Q?EscQw7uc8RNQC4xQmY/ge92/XocauiKGGHnQmNM8hw7n79ncI4k1h6sApOc0?=
 =?us-ascii?Q?Gtdx/jBYByHch+e2l3FBLF8c+dC3B9ZWaX0x7D5oiqdSma6UO4ujy5F8x2Ib?=
 =?us-ascii?Q?otvv9eLhWHoRExUaJqceBFUuGKjtceqO0FQL6h5TXY8/gfd7LeratkoCFf6k?=
 =?us-ascii?Q?5TZaRhvk4UQ8xXw9INO27999yCHTDetLcTmx0yWdosyKPTTybnDUkl1WnluP?=
 =?us-ascii?Q?VVmuRS6k8X1RvR/J8ifPnE1wa9stjONXe2jhJc55ANW3sp64CH1S4BU9HIQu?=
 =?us-ascii?Q?E8gwJESETrEeiVJCaI17MxIgPJ0AlrZFyUjnpUvlo8FyBVz/PjBJLy88a7ax?=
 =?us-ascii?Q?OtaVejHN9B/kyJstRDB0OJiahdajrEjEkmUGxG96VjncuV21cbEbWkQDB+8i?=
 =?us-ascii?Q?hLQsTTRlc//3MrDLy7wXB7nHAQBnStgP1z43Raatra6iLc+CVxNIkw4ZHJMM?=
 =?us-ascii?Q?9QPBnF6M/s0k0G2yPwu25XYOapEh9g0QsSaPtrdSAM8BCsZsrlFFz6KjzKA6?=
 =?us-ascii?Q?53Tg61H53afZu+SWhHKCUIvALkeJJrDI4wKc0YAB6nLjh0xDo0hzW+7MDgxA?=
 =?us-ascii?Q?/rSac0LIhFJXxuuF1y6CrCeACOoPOgcvIEblBga356WkHSj/ejBNIofNUrLO?=
 =?us-ascii?Q?R8WEXdo3ynylhePnL1fck8ow+qbhYOJtfW0zRhIbKMkyMG2uYQ0KFHJi4UoN?=
 =?us-ascii?Q?49VSp4S8fiRlHcHDF6nzZpRGMGZ8n20Qt4yL/sgLkZELncLPKWsNMb9bF+lL?=
 =?us-ascii?Q?v7G56Z/gjyVAeFC1G60Jb+9jgUpoSYqArtBnnkmZsQ6D1ABvxVfKdVRdyxwe?=
 =?us-ascii?Q?URnITxkgNeR7t2n+Kz2R6oVi9UbPOpNttmrlb4hF394PSMdNSwEe19dogc2Z?=
 =?us-ascii?Q?pssPJnUZooFd12r6OUoMNr8P8IREozQi8zydG91fadTGGd8/7gHsVSmS9Mi1?=
 =?us-ascii?Q?G0XN9X+sd9ej87jFA3Yjd0d9nGYjeXTkXPdRz0LOAypdsKw3kkXja0+jR915?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MlsgFdsVzgXJRNld3im+rB9zOQBo0EcfoMaJ4lcXrOISvY9rwr+U/wfZ7DaxspmSELxMWJM3WIzkXBM0SI9fiFuPvPsJBq208s2vg1+Zml3EowuBrwWJGaeIHfkQ97M2V5VGeK7twbSp87GOTB7CQe2K4Ele3UBDQeAHJ1qX4YyKeBVCtAdm4ZoLHjFMdHDo3PciRhrdivykUVG9YsJCsaahB88aBGtKlXhibz89DTEZIhHaqlrUJjrmGd4O1F93UjGov4EkZBXVmS6A2FMrP40n8PPuF0osycF+hynignQv4wE/5CFuyEuFimu3YDsfutyXnnhwZwUX5wF0Z+uflaKddS0G5Dppoyrsy+/pk0Hiv9yOM1bK+InAeI4GVpqhnz9cYbNg4ndtYFGU82fWTsH5q68w+oPTZ08d6BeEQhPaR3b6U48v4AtYenvTmY7jeeNedOYVdx4DcIAau235AGosulTzBM06h6V9j4OYfCqOOfije86P9Nm0ZwwseIZignLJFWNwAne3Zx2tVwI96ZSFmz5T79QjNL64RwuYgiLIcIV9R350WSX06yxtq0+ulcjxlWoJ+D5algKylezfUjagG9fau8iQoqMeXb9WxsY6ss9bCV8adjC9hQHfffLSsovA3ErstQJaY5l6IVBclsgNitHHlXpquAHwetbLdWRkwutkgOp7rUxGyrCnWom4pCFsKOfWHBQUkvhcv3nhhOK+MR3EAiYagqdqASlM/rHIvzOoPL2c845plc2accVD+B7pJRwxiSvdCK28ko7PmlTeSSpHJEcaIGCBH0B5CjB8kTYSCIgoxL09iK4byUJniU1olFZn4FedLdV+09bK8HaBwrCbDDfbdSblhLrwQnW+9svOYIUd+3EosLZ3hYfC
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ff28ce-bbff-4fcb-a3dc-08dbf601b5dd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 02:19:01.0763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0eLSiELnTqYhz+aabO4hp61itW2TOreOYB9lmfproR/WyZwfLAIoKM5GgE0go9xR8rRPgbCCUCDL7BqKl34U4mo8cgVCUWLl7VX+xmIGwPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6628
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_01,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=695 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060018
X-Proofpoint-GUID: Uo7HdfLPyReQZVD1iKTMGy8Yz15FfZCT
X-Proofpoint-ORIG-GUID: Uo7HdfLPyReQZVD1iKTMGy8Yz15FfZCT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Su,

> v2:
>  - fix some problems and split v1 patch into this patch set.(Thanks to
>    Dan)

Applied to 6.8/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

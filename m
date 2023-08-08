Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05538773EC0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjHHQfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjHHQeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:34:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045AB4EC1;
        Tue,  8 Aug 2023 08:52:26 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378DAKrw024411;
        Tue, 8 Aug 2023 14:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=uaEwzVU+qVzT9FU03IrdN5gTBglIimP7n1qQfeOoQTc=;
 b=2D11rTI3uw/0YBgZ9yzjroZP+ze/00PhosjETiUoVAwFQkJYsSH1421vPjYNKI0up5iS
 iptA501OdiOrEwMgL/IT8Y5DG14G5R+KpaLROLvf8C+jhV/NxoCgWBkqPsamsL0MbWDC
 6tjSUKgmXH2q+cKG0IlDSL9uCjaP4QjVl+h4ozaIXpUkvZWnQk9Aw8txXs9lV+auLpCF
 mI2c6BfaVp2AXXcF79H5vCaQU8cBVULVPfd/yiJAv7lCvsrTWpyK5ln+EEeKsXzRCcZv
 UPDqzK38VFHL75fZhS4tGa7/5xsvZYtMOSzkZvn5Sk9oK0aUxIlOZGSl4HrOHDftFRqg yA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9eyud850-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 14:04:48 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 378CdAtI030509;
        Tue, 8 Aug 2023 14:04:47 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvc2b99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 14:04:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cc2rlQm3eLQuhRE8nBzLclzD60PYwxZsoOEOBk/SRhO3YJ94kw6kJZdF7jY3hW3RL1hZMudTo8iu9dCAx1qaEjZLd9FprfsoJnHz/8i2tDM75sEoW3nmtN1w6ZMZ/sgdSJAPRNjz7PcQhVMgS/IOkMcfcjYV+m9XN4MHJcJL439SYP+XgmxQrtGbdbL9T1ZAHb5hOvJjYBCpypxg1DHQ1DtkRMGFYJW8MYxkmdzg2V4ob0z207BkJAMgbPu8f7P8QUTEBcYELheFqwps112oka3/5j2R4VRdctx2yupOnicRyir7GNzohTe5J/kiCCEgToQQshyTuTlUqcj6yHWk3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaEwzVU+qVzT9FU03IrdN5gTBglIimP7n1qQfeOoQTc=;
 b=mCC4c8NXwYyjgwUdW+R73BJ1+zB64xYJ7sB1mwPKxpIkm2xGwzxggGBu9/YqjDoDPyqlCA5ngyYHYLRy9Own7Nu7lvnlLIO2lOZWqyqQjX8ExaQtnBzbE7vcystbTMkswwRj75ERUeM7TuzSGbvyAKZhfqud0zNwk02PTiuRQgIQTOs7Yi0v8SX2Vz3QwCGQRxNHf84LaKHtMnPPgbwrSaNNFL1ZZIazx2rFE8BCanUTicoDgosYpoLt3QViN40Rx/TGzw0qrPr1uEHLDz+dbD7gweMs8VfrJyEbO9Mji1xzfeDKG/cAbd+VbZcrJ/EKSuo2Th9VqKfpsCOWk5H7Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaEwzVU+qVzT9FU03IrdN5gTBglIimP7n1qQfeOoQTc=;
 b=ngSKh5vMO/bhqcKdXkhWoU8s9Gh0Xz7sgdx6hTDZPArn0CsfiEKDR5WDH80wgkuyF0WLushRrH9PaHRv/njhZy1y8wOvmfW77NZhodk8QnnkFQe1NF/Xx3efZqtwmXsZ6RMjr6psj0Ga8QS096leQk4TMiIsd4zGBAly7ZFbc14=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BLAPR10MB4849.namprd10.prod.outlook.com (2603:10b6:208:321::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Tue, 8 Aug
 2023 14:04:44 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 14:04:44 +0000
To:     Chao Yu <chao@kernel.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] scsi: support packing multi-segment in UNMAP command
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1h6p9k4vk.fsf@ca-mkp.ca.oracle.com>
References: <20230310123604.1820231-1-chao@kernel.org>
        <b53321ab-679d-e007-6407-6bd00149948e@kernel.org>
        <yq17ct0nijm.fsf@ca-mkp.ca.oracle.com>
        <f93949dd-e90f-a9bf-33b3-4f31c4328c7d@kernel.org>
        <yq1sfabni01.fsf@ca-mkp.ca.oracle.com>
        <d3c1c2cb-9076-523b-da81-a1b632b4b0f5@kernel.org>
Date:   Tue, 08 Aug 2023 10:04:38 -0400
In-Reply-To: <d3c1c2cb-9076-523b-da81-a1b632b4b0f5@kernel.org> (Chao Yu's
        message of "Tue, 8 Aug 2023 21:42:48 +0800")
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0184.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::28) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BLAPR10MB4849:EE_
X-MS-Office365-Filtering-Correlation-Id: fea438cf-9bf4-4330-bd15-08db98186ace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tiNbA9DcC31MKfvSv3MfYF46bTpFODUhE1BkaLLSRRkb2v7XZsv+S/Y242Yguk/HWo98DxDmKJTY6XYgLbV75d0d6lDav1HTlq11t3P4FWT6FbtgT8w6uFtJ8BW4AiY7WWXFD7ubeCZmb3/1ojx0XIJUUioZgQiRNQBVr6KJiQ342wscWNE9KqHaGjmbJT8iMQfZR1OZElcQxU+DJ6fgBD5jlfUI7IX4jq5S10awzziEor3bVB03uwUK+eTkPey7/lN22EI2ssRREuboOhjQeFrtYgdJmnw//efP1TjghXZVJmw2lcJKOyum91sEIFRnIINmbern/LFZWmltuw4DC5G+rYoAwhSaVX2yxc84KRdHQ3o/h2QMFbdegDVpP7WBRokz6R3N3BpkhRSwJIPVxTDh9HhZdl9tKkuMCTFlbe5bYM4WqrHPCGtPW2jDDTAE3F0WQofFAS3ynrcq5VBQjb3EeylMht1GMrmIro4KvcCk1mrFoqJZtYWzzhZ080J6ndDSAzeNEv8OY98/uNXLst0obQIkFS6NyjxUQDD4/6qG+blxWZYdan/FzJRhrpFZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199021)(186006)(1800799003)(8676002)(8936002)(5660300002)(558084003)(4326008)(6916009)(41300700001)(316002)(86362001)(2906002)(6512007)(6666004)(36916002)(6486002)(6506007)(26005)(66556008)(66476007)(66946007)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FPL6OjlVxqZk97eZvPwe3wSl13VMhuIBE7jpTSEMR42MhYH7q4X3GQ9WDgJN?=
 =?us-ascii?Q?TI2t3m8LJpD6CM3ArG/LEpQqFiKZmwvpgFI/fCk/44lMpNYNsIvyIK4QKlxF?=
 =?us-ascii?Q?I5a/x4WoRk78vfJJjJLiMcKYC0uaah7ejyGM97bXfKjdKv7G795h6SVIICYR?=
 =?us-ascii?Q?MzpH0GGDB3yquchTBPCJPgKHB3N3TqHbeMdMLZGK34DV6U7ytO6R/Zdh1vHm?=
 =?us-ascii?Q?IhSaJOcsh1kTirO36xvPWEY6qHBBIsPOMj8UBwV3ZRlk2LjGneqKTOgUGd4z?=
 =?us-ascii?Q?6jZl71QCySywhjaHgW6FUhB5FyTvXm8Q5Rfo8wwl76/LcNuQUobhDbGT9Mpo?=
 =?us-ascii?Q?v3aZx5M6bNIW7Ti3kFP0QWI81J1ksgQry2JCKfQQLOKwe9n1Kg8qBxR6vWk3?=
 =?us-ascii?Q?jgqBy+zMigM7reWKtBLL99+oB1KrUOP6e4AN6nVhsuN21ipAym80B+i2BVUP?=
 =?us-ascii?Q?k2DG3mqgvODfvgLu9yZtJqMXf1POMnKUL3XFfHAXFoQBcJAVGkFpU+EXBZna?=
 =?us-ascii?Q?Y+GYZSAXGB2acQuFKN4DfShRcb8AVAFKPCAbEWtHn7AXFun4jpUBCBtYbqHj?=
 =?us-ascii?Q?2ofqy8cenoVxZiGDJZQd2us7z2giOmr037RVDcL8I8+pmX3Pnp8NHmzz7Oyv?=
 =?us-ascii?Q?Z/bI3Dk23BLzd0b9a56EGsUPREJqtaVAFGKDI07s9By9ahOfbFxHAI6og8Hl?=
 =?us-ascii?Q?leyfwNKMDYBYqYOIhZpuyr420/+1JMJS4M+/v3yj2OzNK3dLlSKySxovF3G/?=
 =?us-ascii?Q?6m5khIiHxDAfpM6QwroFu4M8dqn8CywNI8ZEJ1OCgMODP5uuHc/fAJAYsa+R?=
 =?us-ascii?Q?swkq2RzjiqUQyz8xT+3v0/yhKqycZ9QDXs1YceO1mKLNfoYAxZn6brnwYqgV?=
 =?us-ascii?Q?943yXq8/T1W/GJ5i0M1rqAl7U4YZvdVIMqTPYknghj1yBvrJiYPQc9Msansv?=
 =?us-ascii?Q?62j+BMhv2wUb+VWgc6lwGT3T4O87X+LLYgBOB/ZOlt3z94Mwm5fcUg20vEk5?=
 =?us-ascii?Q?HrH32Zg6FQ9YOsgZo0AAjav83tH7ltqejrBZCU5HBlQoDCQYXUrJf94wMBS8?=
 =?us-ascii?Q?AyAK7YztbMWmn5aB68aW/sf7DF7rSVWc1gTFbFpU8hs8H/9phHN2h31lWl5Y?=
 =?us-ascii?Q?yWqwU+9RAtI8OUVnqbgJDnSzUZsIlkuJoX8zi5PDG/9PMEAj7VoOFO5qwPLH?=
 =?us-ascii?Q?fV6tGwI0uUrxeGj4nv35raRyTZ7FThREIHKycvzMmo/UGYIU+iBtRMKCbHgg?=
 =?us-ascii?Q?ilDOTKSjEIlyt/C3dn8JFeA+WIsO55Y9wh+UkVWflfN1CTCsFmqgUwWWnuyq?=
 =?us-ascii?Q?7Er7OMov1cL76zOW4ywa57i+TIEembswDkghfOM3/TliC+rco6zXdQS4UUBg?=
 =?us-ascii?Q?a/BROzWSexzUmuihN8X06qWdbCFL67dhGuxC7jFqDMvbc24DiqZXiFbf9TFk?=
 =?us-ascii?Q?Tt+gJRzVbgKHv9dK1OkfM26aZL9Fj8M1THqgBYdr0kJTECPQe7ELi7A+Lqb9?=
 =?us-ascii?Q?nLIpw0c0VSmZjWBrYIIcGX1QwDXLIl5GoUUZ3VzPSnoioPaM2C0jcGGdj+Qy?=
 =?us-ascii?Q?WltsRp7kiVaQTXa+TNSBzqatj6E7Xcfl/C6Ggt3LMCrh1QuJZrQa7I1wJDmt?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: c1QaZ8CUX+gpHISUNtouAeRagWzKDqsiU52sQcF/awUumMpqKRBidVzTRGK8TIb0e6lwQNmatheZAsJUinv3xY1/lgf1cUUFMknz5DHK5Yt//0RGj2794v99hWz4RuGj5MWeCwTcmB97dN1KvAzXJyPrRAwIdIxeuhTmw2FTwCUQ/94M4UzHL706zSYDFhTy9diNQ0h8d2ZZVvyWT79lzpJ5YpGM3zz4/6ZppqTfC+1MZSHutDH5wxkoLp7eNi/SnVx5AGg+LNHB9QAIU4xgaV1j6hT6ZyA8tFNirTrlbIZA1dHUtV7NwyyEhUuoYWB1S7esgkAp4YXBkCHi/nl1ZMSfJKeGS0sMmMA7o3y9NNEV4dmhD7fD941pN+v/5DxCqAUsmO6/zS4joYQvxbxAvSWmF8KgSlDVmgE/rdbdCjjA/rDgxV8v5vJTIkTRRxZmLOIKgDheYyyctRyTS4VN6IN21rHQ1x6A4dDDT2r35yiz0T24FghnAECQUQAHZVgx6puq4FZQMrTk1B9zSZ7aB72HZzewAfmqbcpROkcgDGtbd1Su9DLljhb9SWxlQ7zdSpNoQzemHiXkE3SMtw8AsCo5JK4yBKMmUVvfMg8WvMIbrywTxMcNppwaOWKdxkdMRXasgSOjYY3w9rXXvdEzgCAbSOkNIPUjy2eVqymzF2osVpa/jVRXz+irwmypvT2yUy8eUob2+Rl6r6gYvJYgyKazS4moFZqQtVaV9kqlxoVXgQtntXBdTTbkntzHQI/5AA9p/uJh8Y3+g1NaHMyKhrGaLuvAuOYeAC/WpveBNRwjRfEnQGfMwRGOz7rLXvl3jKPlpt3WI6SPJXvSLRIO+Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea438cf-9bf4-4330-bd15-08db98186ace
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 14:04:44.2855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H5AhNJgcz4ePpIGik15A0V7IazNTdqK7iHhFUMR60JlmyavMpKhv8UlT8mvbmzl2H81uT8hsvsHKyX90yIBnnlXAV599Iz+B8baPJrHD4hA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4849
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_12,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=714
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308080126
X-Proofpoint-GUID: 3JNbleGK8Pa1FGTd2BhkLM43RPNuwZyQ
X-Proofpoint-ORIG-GUID: 3JNbleGK8Pa1FGTd2BhkLM43RPNuwZyQ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Chao,

>>> Any progress on this patch?
>> I'll resubmit this series for 6.6.

Been working on this series to address the reported regressions. Spent
quite a bit of time on it last week.

-- 
Martin K. Petersen	Oracle Linux Engineering

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0652C8125D0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 04:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443073AbjLNDO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 22:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjLNDO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 22:14:57 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6234FF4;
        Wed, 13 Dec 2023 19:15:01 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE0UA08030590;
        Thu, 14 Dec 2023 03:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=xK0hFXYCoZ1iHBSJq/PclyaTK+iy3qfkUGTvCMv0xmQ=;
 b=MO/WjtH23aTnCw5mVljpWzmKMumOS8A0UOoBIppyKvqfgPn9rsbJ/R0/ebiQMM8moZM8
 TCyxYHTGr8y7Nq0Apqy0lRk3OkDPfDv8J2Z24e/x2BokMulqvtnjh6Ltu/iAVElnD9vu
 oeGAcJCBUMF26uMNfp45Xha+I50ysAfVSSc9n5GuWvKr/tZYNQl1VMiWwGGzE7QguEHq
 dBqvbOyG8sCTPKAf+zHN57i5ePT/7AB+qD92znitGBzDwJyhkrXUo6n/5dZJ5uSuCd7n
 gpsIJ44eZGg6WIlimgwxE2dAyKYybzdH6Qy9ktvzhDMV1HTCTiWn4jf+DYQuREGMuCcz 7g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvfuu9rgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 03:14:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE1YRiC012869;
        Thu, 14 Dec 2023 03:14:58 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep9dynr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 03:14:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdjZROk0vvfR9lb1MBALWeu3R6ZvR6tovJ6/7P8aIYHBh4TIA51amOEg8Ks2/L+I1hqdtFMWoRgV5/UPp4VFxFLn6ogtZGYmLHXF8NI/KPd6ktLADK+re/cbQCtwYhwrr7Aa5pwHujQqR5+qkWrwhDWR9S+kyiYbrBsDkUAaeGlmwTwPOrQu3mnIc86lVDBYGnb7joFgXnc/5ejn5evVcULmEF7ekz9NUAM7Y51ilEXIJXi6SfsDr5MeoM9TaRTsjIhaCOvb4zmVDQmRVXn8Fpu0Eges7D2FpcvUsuP+YCQo7yxKz8MAaTuAzyL3soKyEVXAW//pSwnsg3sE6Irlzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xK0hFXYCoZ1iHBSJq/PclyaTK+iy3qfkUGTvCMv0xmQ=;
 b=Q3CwHuWby/iyF91JXcSshCJwW3rPcDoR7+094UPJ+3ZDfpap7o/4sDHXqOQbtCD6tTeyDT2HY34dImdHU9OT70D2Ic5VMdoGV7WgXAhJWkKO0v4ZQglUbVLygDKlQQ6c5LFTQwl2PheXOjqxrQ6gy+OLBaGtVGysu14K2rvU0CgF8eHh1RvZuSMjhHJEJWsHr8cr79QS3tmeqzcaWyfNb7MMZus/UwiloOWsXfvA4fUpO8sAgEI9JrOC7jVme3HrycwlhaxyaR6we3e3VTHDctBBWLtblIcJ5fymIxXFmpwqcPbnbuYZ4esdH2o+LBTEio8/RDTDV3y9XyGRs3KdIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xK0hFXYCoZ1iHBSJq/PclyaTK+iy3qfkUGTvCMv0xmQ=;
 b=Mv/abCdka4nU1dAYzDGQ/yBW09jS54b4Q73mvoiOizZt7FDA/rbeB6A4W/MjOaFGEiV5sUrBs7uipjZuIRr8mBgxVN5mUu26eQy+1pus4WYDXQGM5mahzjbaydnn1FyPlxvYAjFfmsp5bmZGOjoT8umveBIDUuaL0R3VFaPz1jI=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH3PR10MB6786.namprd10.prod.outlook.com (2603:10b6:610:140::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 03:14:55 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 03:14:55 +0000
To:     Karan Tilak Kumar <kartilak@cisco.com>
Cc:     sebaddel@cisco.com, arulponn@cisco.com, djhawar@cisco.com,
        gcboffa@cisco.com, mkai2@cisco.com, satishkh@cisco.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/13] Introduce support for multiqueue (MQ) in fnic
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1wmthh3vj.fsf@ca-mkp.ca.oracle.com>
References: <20231211173617.932990-1-kartilak@cisco.com>
Date:   Wed, 13 Dec 2023 22:14:53 -0500
In-Reply-To: <20231211173617.932990-1-kartilak@cisco.com> (Karan Tilak Kumar's
        message of "Mon, 11 Dec 2023 09:36:04 -0800")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0049.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::26) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH3PR10MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: 4664fc85-a586-45ee-330b-08dbfc52d8ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zQvthF8+UB/gyVUMM1rK5r07wembZJY3NA7s0InFtGeiowm4VeEyxmu4M5MFrGoddTG/Q0LOhaqx+RdfBeGwzGRmQGbVOyOiqYveI2izGax2speMwq3rmDRuTpL1mq3H8HqjAi1llnIIleUCQdbpNtoAe/wuNpQXYPpJDbzuEK2hKYD2ESOoAvGe8AZu2IR54KKPppgLtDujRdnOnJ06V8Eb/MpOpHaWeNvE3oVXS7APBhhiRnJVbMi8IFXo6FhTZFbhuXxK1IK4BnI1AhH9xZUa4CvDWbMrUPMf9zGzGKHO7DP2IPuXXXt0UU50w+rR3HlwUMNoxqKePKqiiQgzBPu1AsMVHQNiAcxALpnMlqV8l3vizK1Pqrn5rkF09Z7Ol5nBuyBt3sTANO45P80gJ2g6/zdPWGHLwlwBqQOo+RK5V+hrNZtIpY/54scxYv/otrkOZ+MzRCKyXNvIops33/7SITnEub3mTfoKnShDddeN/SCzrLrbSsKxGA+QsTx9hWd6L69cbsp44jsg6LXpumJKOEQ/K7f6XSwIyR4Mi7H1WkxNo/MA5OBCw06EfsW1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66476007)(6916009)(66946007)(8936002)(316002)(8676002)(4326008)(36916002)(6506007)(478600001)(6486002)(26005)(6512007)(7416002)(5660300002)(2906002)(41300700001)(558084003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I0X4ExPC6YbNTlCCau7sKIki1LrW227+7btKg0vTuC4CoXM8wNE0/HzqZWJT?=
 =?us-ascii?Q?8IW1A5MxQZZDElvjSJBx9VzvPYM2qXFP9ZL1LZr8D4L2b4KUB10703yX5tPN?=
 =?us-ascii?Q?rEwL3EpCqRSSLQieiDiQidp75rBkonUyDDIExAxxDV506Gm2GVBW+F62rW04?=
 =?us-ascii?Q?jVNPB/DBQp8MjW85yrN1RbO4xguMNWbaEIGQ+fXq5zMlzKCk4Clm+amrEY0C?=
 =?us-ascii?Q?C4YLG0BmBOMmEi0okq4bDXB/fuwVnzf8RJxanA2FAMiUxhKroo6reas9CDDU?=
 =?us-ascii?Q?OdAC0dhru37rZaoBSlvpJyB1DpdqAwGF4ekVuNnjsgZcQNIH0BxOJ/26Nrj8?=
 =?us-ascii?Q?cNikYB1m3cfHwY8ycXkF3+6j6HESJ9DClsM3dpimnILLLvony0FYEObh+v1V?=
 =?us-ascii?Q?eTo5aSK6ULvrFnxuU+mq4Fpt8x/1qT6UjpPfzc0/wKbU6aYsng1cwTkBkjzC?=
 =?us-ascii?Q?H0WaUJNA6hcm8wTtxF9PFhi1dAlTDJMOn391CwyPq6iQdXvnmg3SEOu8x5hy?=
 =?us-ascii?Q?6eYUCLUCrgWb/lcptJD53xI0ZtqRgtiqmhS7YZEC9BWIhCMUWelkQSWOE7ZR?=
 =?us-ascii?Q?hZe3oRIQFqibdofiohLDpBSCJgP6MDr+hP1k/yvs8UU3VUQXmopKQ2OAYFBT?=
 =?us-ascii?Q?j5Kbg4vIuUnWLy/BtazqkbhnnxWq7GfuHJkKzWLqzo3vKI1kKIGqb67pBd8Z?=
 =?us-ascii?Q?piBk8iJ9+p/1dPdmmsz/DPLeaXiSETzy2ZS7nEo8nDpgwljljNmU1PMgZ+0c?=
 =?us-ascii?Q?UDhzXRd9MU10T6cHB04+SA9KYQq0dpkj6ikGeDEZzJCxPJQY2gZHgf2xvyhK?=
 =?us-ascii?Q?MZzK1VWakJqrUtYjSCDzQ+nQpWQl23XKApAkvY8SupptLYvr7/MAw0OYS1lR?=
 =?us-ascii?Q?JVjdoxku79atP3kr4Ftz/rtY0fnBT1Z4dDQAWhbUG8I/h98N5fYkKZk4IAKM?=
 =?us-ascii?Q?WZY4v2Z8cQVP+evfXGvaV1z86J4D6L/aD5i16FHzyqKuCHQsnOuPlSkqgfUK?=
 =?us-ascii?Q?ra/1N5yjGo6ngXaLUpRCi16tSCe38WUbmzl+KpGzTLTKf5yFF11VHrxbae8J?=
 =?us-ascii?Q?YCZiR9uIDR/R6U47xtVW1ry2AICxZuy6oaUbiWZG1JmrmqLytgyckZq1p3E/?=
 =?us-ascii?Q?irusVKohoLuwiU/0haDvAaN3Gk5CvKTrKYekv46/AOA/avaBuEVWebPprTCv?=
 =?us-ascii?Q?Tl2OLBQudhvxcRwChD0Q901WWOIpVNONLuKybh2L2Jbz0nelU5xFW02TFie0?=
 =?us-ascii?Q?agd8iLnqSt6t71j0bgGnABL257IbkM+J0pRv2uI1lKUrewHmd/vuCNQa02En?=
 =?us-ascii?Q?jNF/ewv7qwIlRtB2NtsyimqnfnOk9Ren1W58eu8j6T/W4vCd8jdMVjuL22z8?=
 =?us-ascii?Q?oVNa63Zzrc0wqINhsylwElRjKokU++HPDtU4ID7AiH85JoezD3esZSAY0fzJ?=
 =?us-ascii?Q?EYtEB/wmzKMuqcmrcqAqXKLQyFaKaB8BTytijjH4MG8Cr5Y9mkfOXtQKBDbk?=
 =?us-ascii?Q?0MKCkecVUirhfJHV5xSGoJ+F3FP56/9t5LVC8qZ5xpUqCu2xCxL5vrvjP1UY?=
 =?us-ascii?Q?IQsh5CMp/t2S5ktwy8t+gLJigpOp+LWUF5+luPyTEoau4Cqg2eIc43qTW3fG?=
 =?us-ascii?Q?KQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: N1lsWNGPKj2jfDcGjl9mYYx5NK1f0wYb5rGFL8csxSPon4Jr0yw0rLi83uO3dulQtXKJgVmb6AnUICXLovUXRSOXpuva50aqngQWA6K/GdkYYfGzRbE6ME5OxmwzgAq8kFTaEoqMUQNXXLVKO+3eqENVEP1etWsXS8/neoiW0uDOU15cd0l7/PyENikg+tGuF4qKHlXGUh6RQLMvXyI5UH27ZEUS/tx4UVIGhLTrNHoEJ/eP0Drz5pjeDMXqLHQU9tI3YeOUWnG8RH708m+noxx3a/Tprvp3IyRqEH/ib7mvh63WstqzmFXkTYRA3a+xIq1M1lpLrp893miIaRHcixxs/74kD5vx3UAqKH26RhWeG9PiZBjfvN5TuylqtOdQZZciSPG8LkO/v/GHiYh0JBHMXgLFQ2wdb5HhfzJO48MrTZPaJ899Ss25PggdmLijsaeGrgc6ox6Bo8xZKV7yM7t4Y21qdTNyUPB1a7a0ktRoK8kqRQPzgSkU7R8CpKNgjc1hFhId1WhUWwP0ul+67/1XfauHVLbMy+oRcFuF6bBJtK8CGWS6hP7H5JVQYyLFZu/vrDphCDc3ZRq9P6DuUnXAqYFPjSVjs7zqDGBPng8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4664fc85-a586-45ee-330b-08dbfc52d8ae
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 03:14:55.6983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGcjT9cudXpZ1h48VssaTLeQOqpikT8Cui796ulx3VCwkPofhRKEiCIhOPcodf+Yrr96Zx7xC1m5KSIiT5iio3GmiC3haZfqo1pSLBb68sU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6786
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_16,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=758 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312140017
X-Proofpoint-GUID: 7qKeQoJh9oyyuU_RRtDg618UN98w89Hi
X-Proofpoint-ORIG-GUID: 7qKeQoJh9oyyuU_RRtDg618UN98w89Hi
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Karan,

> This cover letter describes the feature: add support for multiqueue
> (MQ) to fnic driver.

Applied to 6.8/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD34A7EC44C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344076AbjKOOB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344045AbjKOOB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:01:57 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12EBB3;
        Wed, 15 Nov 2023 06:01:52 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFDOZWE029294;
        Wed, 15 Nov 2023 14:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Yv2ln5eiDA5qUdEVtCQjLwSezGYjsJspiaAOeq8XIPU=;
 b=pmiy/PpGZLU4uCz4MMPcKMO1iElcPXnlfemGkLlZyiQXsyAWg3/+m7o6ZbxAzViVm4yW
 JW8pJOAn5ClEnvQ2tP9hUUgkWlNOVefi18DD2j4KJsLVpK8D3IMRAxTy10eKvskFZTR/
 9pSrJhyuiJSnxF/XGK+1I727MoFin62Rdq9VOd2sR868lyr/tpMJJdi9HS+FBOXDd1Ok
 swvBruK1rLPc7QKodZwCjtGU6SFSMjSxJDMdl0Sq0MAQQUc9m4LPoxEdNz83kk/kF/SW
 dqRPSdxhNDofnxg+gNtHJAaOZDMmJZABbeKVbwHfnfI4xUyDvTCzuqA1zQzACv067QiR PA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2m2gjn8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 14:01:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFCjGUv013122;
        Wed, 15 Nov 2023 14:01:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxq13hbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 14:01:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eu0s8WoWFqr8lD2eUanctvdGLK5Qqww8OuNq4vaLoA+YftcqYOMU0sFeRuAV9zl6ax2Re8OpQwViJUOkPggu3I1tkiWhfiSFdzODm4HlfWz9hnCHojqgB3iHKnJBt+0VMt+uqsKdixB+SvUEWjl/aKj2Yl6O6A/BUfYLhjkYB5FK58bXLmCpGlM/iwL/FuGCPKVNvnY2ApKDX8Ga/uARSfmrsqycsoJDpVCMlj/Z1BmctJQOcipfhk0Oo9suiNkVwHjBbTreG8Qv/JapvmfXcNbE7sPYlv7rKst1EnuT4b2/b8NieMTX7U0Sg7se+mJK43OISYUC1KftEKZYyviFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yv2ln5eiDA5qUdEVtCQjLwSezGYjsJspiaAOeq8XIPU=;
 b=n/hNkOl+cAfvrLbWZPGD/XD8ZPNAi0zlBTtdn+IV9TiJVppxZV8hmk9lsGy1Hx2xWlfERFioFKd9c7P4pR1Dln0Hcgt+dmsDUvmlhHWxaXLVOm773AxvUqVE7ciAACoSZjoL+Nz1durjGqZq3KfV3YBibB3NBXtw9mWn6ORDgZrRNynEiIYCKLgnE2JK5+3osdNbJb0OLErvwkuBaA2YeQPbgHrYR76AQX9PwPMH6x+i/z+t9g+6nk+BwwTBYzQl2qBJT4ttDi8BmWFyPbr42xnFeF7C1lSrpZKwGaL8kC4wq9NIE8+/2N7wV7fvPBrL6sT9PiQ9DFq8hCsSlrQWIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yv2ln5eiDA5qUdEVtCQjLwSezGYjsJspiaAOeq8XIPU=;
 b=l7EMWmV3gIxkjfv+vUzR9G8io3rAbY/d3HnGM26YApt+ot9CI5Tk7YNzJaHKREQz4nKUriV3gAJ7m8MOhFLUOVGxnllT7xQGTJuuVNNyrfJk7dPtcQOGF7KmlimqlkTrV4ATQ0ir7JhJajFcGVV8IRtdtgczE9MOIn1kBqZ8+LM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY5PR10MB6009.namprd10.prod.outlook.com (2603:10b6:930:2a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 14:01:34 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::abe0:e274:435c:5660]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::abe0:e274:435c:5660%4]) with mapi id 15.20.6977.018; Wed, 15 Nov 2023
 14:01:33 +0000
To:     Justin Stitt <justinstitt@google.com>
Cc:     Saurav Kashyap <skashyap@marvell.com>,
        Javed Hasan <jhasan@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: bnx2fc: replace deprecated strncpy with strscpy
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1cywb2k0h.fsf@ca-mkp.ca.oracle.com>
References: <20231023-strncpy-drivers-scsi-bnx2fc-bnx2fc_fcoe-c-v1-1-a3736943cde2@google.com>
Date:   Wed, 15 Nov 2023 09:01:30 -0500
In-Reply-To: <20231023-strncpy-drivers-scsi-bnx2fc-bnx2fc_fcoe-c-v1-1-a3736943cde2@google.com>
        (Justin Stitt's message of "Mon, 23 Oct 2023 20:12:22 +0000")
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0010.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::18) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CY5PR10MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: 45cf4a2e-e2f0-4e9c-8790-08dbe5e3603c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I65jrkBRCcjcKodphDiXYKWEIODeAD0P5R2FPzN02eqQsZeBPIQShX50sa8Ql/kQL5JSvStvCNRAkspPvyeNFHOMhM0HUq9vcbHIdcaZSf5h8oyx1sUxW/eBf/VzwiEG4WpEGw1wDD/4nBgelykOUvqN7zT2v8iLK1ZGj8AyIMgYrbn3SzEamgiFoF0dFmIVdJPRfoeQFMQf98H8+QBiOWjnU294PtG2hIF+9iF/VixesOzApkn4/9M051fyWoMB/NJAc07lqzu17V9wzHnfYtvZyYzMeN0jQCepR3L5G7oe4BYEfQ8T94gR06Qa5HtbEJ6pGGvPqkAYkLYIVCE1EtcAv0TWiz0e/oiRZEsCfL9EgPlrzfWOaXL+lExNjWfhultY1nm7f4ieekAJywV0rrP7p2gb8CvijQdq5RgQy9DlVr1NjLR+fomrALPS94iidshjogV9kz29XsHn7eVhF0eo0rE2mcisC814s09zZ15QuIB39GqFnRlb974Y5iW5znxMNicMe6evIF/pXkCDIMzeCrOl0xIS1AK154ASEt04X85ALRiz9wkoPCNGdw8QO3NH83Yc3KA9Exm9Cx9BoC4xerTDcUZKaUWZPRQPPxgukuQsw18RJ0oESeYz+T6z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6486002)(54906003)(66946007)(66476007)(66556008)(6916009)(316002)(478600001)(4326008)(8936002)(8676002)(6506007)(558084003)(36916002)(6512007)(86362001)(41300700001)(5660300002)(38100700002)(26005)(2906002)(156123004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?95VM8szlKBvdk0PhbuoqHcpWou3s7lY4OVew2QzBBDDWAW1082Nc952ZbhdW?=
 =?us-ascii?Q?aHp8LxJ6v8F4oRKsZl7sY5ECEvLTqX6nWqvfnWLRq14j3O6KIusq8Qt/Csrl?=
 =?us-ascii?Q?5qNtsCtHp7tHfmFPn/jYF0lf5zYjpToAbmn16ix1y1A/o29FAo7WkCAn1wBZ?=
 =?us-ascii?Q?ZFfeitJqZZgWAIEn8Jv7VU4Awg8S/tkUuoKakHF/dVrny915WDjbFu0+OhpO?=
 =?us-ascii?Q?lhlnsEf51TOxlysLNebWYenAnRI30QKn3NqD7tJz14jUuW4JmbSFLwMM/yt9?=
 =?us-ascii?Q?nAyaSZ54OG9husu+BcXQQ/j64uu9/s5IS+iKJwJWsuPAJWhdg7OqWROdLCji?=
 =?us-ascii?Q?NhbpC6bIRavtLxX5fFOHpuI5quvgTvD+G8R3Tee0E9xszwDf2tne0i4MyHiW?=
 =?us-ascii?Q?bvNFNGG9f63neXU77139lgWaK5LG9ehb01nlmNZOmSL06BEP3x26rY66Ko5Q?=
 =?us-ascii?Q?xToiTH6hfZRsXZjcta4n/RjibiNQ9scW0BlpZcxOtBOn/QKr0ZE7kaNprplA?=
 =?us-ascii?Q?jj1UR+Uo2Bb4fiOytkTYUIMfCll3IQw8MemtxIql0pkyACzK9vzvC7D7BfAP?=
 =?us-ascii?Q?GtCHev4rIfGMcAruroUiPbGRXWjrI/zv3/eiS86w/jisO1lOqXCqyZRO96fq?=
 =?us-ascii?Q?zvo0CQo1pYVrkZ+cQqmKqa4Esm28IPr9+cR57gZzSd0mIrcJzxyld+hSfkfx?=
 =?us-ascii?Q?PJbV38ZRlYzkJR77ri2x+8FvGOpXGlOW95KoTH8Ec/9CPyComV87VymPW0cQ?=
 =?us-ascii?Q?ZFi12/DmSdtAcjztFbUvNBabni4SOE8lOybqznZ1oRKy+lkgJOPDbIVw/BoE?=
 =?us-ascii?Q?yBvtXPJHF/xQwwggHbQXRMgtqy6lGVyUCgt6RUrIM8HKLTOb+McG4+AdaJKu?=
 =?us-ascii?Q?XE3hc9nhRad7Z9kYPITXzFQVuzBVToJX24UpirmgcnOic9KSsCOYVnl2MF8C?=
 =?us-ascii?Q?r6vfgGpi9ozE3zhZxdlOUMwH4VmLOO53XMH0fMG5V7pbJgmGI04dDxTvLwMx?=
 =?us-ascii?Q?zY7ChA/twNGApNXxWN+Rq0nJ0guQKtjszqm89LSmpAv/7Wcv5o6eFJOMZp81?=
 =?us-ascii?Q?+rBEbSSsFiAF5OyNwrv7iFnVwsD1ZuRX/B4bCtuueWLl692FrzaGuquYogOZ?=
 =?us-ascii?Q?0wGKrGnFoH4rlksCB4JZGpe9JR1pOInkUF5R+XbWM/l2NttN3iYSnCLljaGz?=
 =?us-ascii?Q?xCqWIaiCerCH6wD2e0e6dFWQCSvLNCurV1Os4cJBdg7HCZaP1fFb00CEnjEk?=
 =?us-ascii?Q?MjFMsD8KpjzlCUy9CfgzzU/SMPNThjhEyo+2EdePnDvUiaZkF7yWlD07Ky2j?=
 =?us-ascii?Q?5ucw6q/joJ2uUph8Mw9Bx/5oIcYq1JX9bq7lY926Ity2SQVGw9Ep7J30Klr5?=
 =?us-ascii?Q?38NS6i49WP53mDxWGFK6fAsAnc57BkPIvasXbdVHkhH02UQAhcwVwP0Wt/iW?=
 =?us-ascii?Q?59S4p1k/TyjbvmMyBb8RXcZuRyFzCN2/03Wbj9UU9YpwamYMIklwWG6gOorH?=
 =?us-ascii?Q?J1CaKqhzthiBUt2wD0FsRMl8b2BHw230GfoYQMeq0mpxRLGSe/YU0sLO+ZIH?=
 =?us-ascii?Q?Eyw4L/IaQAslUgA0OS8i+GjWvCW9autR6XR7dP19DI6Uay4c96KcvDF3+s4h?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wNhnI/gzjrZH7desV5XjswISZx0HTwYy29BdgnS9AscKrbsGl/FLZnL5NhvfQugJUpVzbhP9q5M+CTMaQ2Ek8coen1HQ3FI9R0JSJsbB9uy/FVGslt3z7mMZawkMmoGMugCfqQcR4sJVIYI3i5jtGgtQQm4fQveWk7AFFJaZIf9Ywk/WCtH4paFDkX8k/HqcVo3W7BKd2/4fV9r8Tl9i4ONwegx8/u6fFFI7qt/Xel+kiTN8X9Tzg57b1g2t78a/xQjdr5Vl0VJeSx6aD88yLaRNj+iREedox//ibaONkOcsgSp26c4FCoqEMaUzlpZb76oFYqtTbPIi1V94PzQNdU6JtvazSMGkJ3KB7YyB3oNju+HFeparzSkDedpD8oCxZJvWAonb0LdvsiOisp5RyJMbqM6xf3E3/3mSzJyO7hJ0cm0LbTBc2JjWeS7ID5NroNWwRyuQz6y1zostfplOEMHlZpdZOa5vvv53npYCvdIW8EoeDYEjX0QYsbQ+1rRBvg6qWxmmSlmKVJuINO4VAsY7xp06DOJVu8p3SjbBgbDz10zQkmrJtj3mDYNTUN8Uxt9bXeSVIXYlkBUg2z0u5ImC8VGD/yWA47kL32ljmOuxh9FjPNqafuqfn1glL5en5CeHlVbyCn14aDuZAxuj6MgfM5ieB3Bu9Pozsaoayt4gxpm9sAr/DKCGGbcz4I2qeMO6Obiuxb/+3nbYer6OpDSGFHVMF+/ofPp30pBptwwo48bRIC32WT1nJBvyo92A0iddxybIdaqB/jjCri7pwClk2sc6gY+7B5PGm8yG4mL94LQVwAVi18aq1wC3lp4w9okPZJaQ3YC5nEFAh0Sj710cRpnVj8e8cEZvNGBUi/I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45cf4a2e-e2f0-4e9c-8790-08dbe5e3603c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:01:33.8954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26Jmw1vQLodTpLD5GmcigQVIDn7Y2AP8mzvJFSiAxiNJngmlzIlrSl6LF+WRtlZmQY9Rh+fYOSOPzlWu54tPZtFLR2IPhlMl5h34Cen/cjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6009
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_13,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=788 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311150108
X-Proofpoint-GUID: DEvaVzKHeRwXP3erq-fqfU16w98_GQLq
X-Proofpoint-ORIG-GUID: DEvaVzKHeRwXP3erq-fqfU16w98_GQLq
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Justin,

> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.

Applied to 6.8/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

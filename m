Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69707D3B21
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjJWPoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjJWPoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:44:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE44BC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:44:42 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NFNu9i011846;
        Mon, 23 Oct 2023 15:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=fOMyne48XciosjvFxKzPOlneW9XGFZ67eQvu8DrUC34=;
 b=EnhlCopK8LuiHnlGa9PkFmYK5u4sj8rKcBw359lEsF80r43rl2Ia7hZwiOSVkIBhF61d
 0DBKEkFuIzP4WzRRG0hmvNBAFLMowwOryxC4E7aCsy6aDsi9pWUui7XrDVxEzzCl7duN
 nuG4Lm4JWiFZlfxqk8smxZjVTjceR883Kx5OeY8PqAlcdTDJdPgJN6749bDww2Di8i+T
 1I0AqYo3+nxSoXxaU2rIRywq+lreBBRQkTF4nl7tHx6nyR7RQncHdHCGd39EvY+tgF57
 gK1pj+wBymuuSPRdQVi1K8Orw3deNdcBU+sQULD/pYtYfPk+TSiOyJ3xyFjRORl+d+pi 2A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5e33e5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Oct 2023 15:43:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39NFWBJc034637;
        Mon, 23 Oct 2023 15:43:30 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tv5344gq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Oct 2023 15:43:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDeCRLIB183U6qi5Fj+kK8WKplYXCQjZ71UlqN9mmJb7qaiSmQJ1pMEW9iegg1pJo10+xhVFN57X6Bx1pDOvsal7fVlx+yf6j4YgNgkK45yGUpr2stRstcU/XHJWG4YfpZFI3AOiQ+GMiP0jKL90CIYNL0d1MUuR07tF3jJmClgZ1sAldNzNWvV/U+HQyyliwQkc51ZeIJImSpCBr03L+qgZJEs6VszUvmoNo79G1HPPp0YWtORmKfhyg9rngfY2adXyA7vJYjrFjluDJcFRviiwHFjmh0D+GOrU+BC0MZw2DtK8/AU9l8yDQn6lC/vTC3UNFFr7GyWi4XBlndxTHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOMyne48XciosjvFxKzPOlneW9XGFZ67eQvu8DrUC34=;
 b=Y2Cn9kzOcQM++OJASLtoff8kljO64Rc070lh63Pjg0ywwk6tHOaHyoms0Qoya5B12YRX9YzGKjDifwerjompPhPGyjQ7LLN9UsCmg2gqca0fwdq1IDcTvU9o4gxvcKCcdTzo3G2pgMTIiefxQDfQEMjBm+jE01cPaQ9nwScUF5O5QVjnzhAjsWox4uDLvqMzVIlP7/knPYmXI8Ga4gkkoAh23HmOzui/FTRWSxlxS7RcrnpfTncexWbhzsNWNMo6tybzo0ELA0+bEodf8+CK+xDVULsITkomk49akvGJ5HyQTZGksCSz5z7EjRrJk96xGTS4BagpctiISgPtkmGmhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOMyne48XciosjvFxKzPOlneW9XGFZ67eQvu8DrUC34=;
 b=a2Q9MNPVl/6cal1+aVjL+pt6LTmY7EZzIcw6ComfmEse/N7wxnwskyOTyqel607b1RYUAeRbHCIou5g7Mhs8CwOVVsX07GTITCRvwEcDW6InM8JuEamGQsvNXsdMTVypD9BesA7ym4NeJqVHzctJZaRUtZJVkg4mFOctA0HzMp8=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by CY8PR10MB6444.namprd10.prod.outlook.com (2603:10b6:930:60::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 15:43:21 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::c0d2:a35b:46a0:d4ad]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::c0d2:a35b:46a0:d4ad%6]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 15:43:21 +0000
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        yu.c.chen@intel.com, kprateek.nayak@amd.com, bsegall@google.com,
        dietmar.eggemann@arm.com, efault@gmx.de, wuyun.abel@bytedance.com,
        youssefesmat@chromium.org
Cc:     linux-kernel@vger.kernel.org, daniel.m.jordan@oracle.com
Subject: [PATCH v3] sched/fair: Preserve PLACE_DEADLINE_INITIAL deadline
Date:   Mon, 23 Oct 2023 11:43:19 -0400
Message-ID: <20231023154319.102437-1-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0005.namprd06.prod.outlook.com
 (2603:10b6:208:23d::10) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|CY8PR10MB6444:EE_
X-MS-Office365-Filtering-Correlation-Id: 377bc065-131d-4bc8-8bad-08dbd3dec90e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l8Wba/N9S/1YpSGk0k2dk80F+JWTAw5yOXEfoXmJbRU9dLjckxmkDMZX4A4U8UX5E3rMPx5por2+Ao/f2V/Us1fBkvZh7YOHDznB6ifOz8VEuPb6f3MJMRv7Ljmxuf3BjguHh8Q+f4ByZO0MD/f/ee1sjTk4Ih/bri7LinkkTJUz1E1b/35+gkXagZFfbFWaTmm/Zjp/MjkjsJXG3dkWIjSqg8ma9B5gKvja2CzVs9SgZJ5hvA3MN6xmBHfuZCbCQeXO/v4eEd32Fs6+SlqRGZHHAD0sJnkJ07FnXSNVOq8N80Yq3p9bBgj8JDQlaQZITWQlNCX64if8xJ16WfhGLP4vE8o+HpH0CjyoL0koGdDejOR2MaEGMgEyeTZcKVF0aeJieiuuaJLWjQl5Uyfvf7uJvJ2FrF4bCCwegl8CoqZ93HwI5W7GHfFtZpC7834Ny+u6otTeUEe1HgyvcHq52wku05y4mGO+TwSLR4zsOX+ltLDpRiZrDoO+dkH8MJdbEGUWJRwf5dEEYzeEqwdMf7A6LL5I8xtJVmvmE6e1D6nEf86yHgp1KyCqIOLRpLb3xYtnUlgIlZy4v4FEuP13oCsxgA1aeHUjspMcPbqCgVg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(2906002)(7416002)(6486002)(478600001)(5660300002)(41300700001)(4326008)(8936002)(8676002)(316002)(66476007)(66556008)(66946007)(83380400001)(36756003)(86362001)(921008)(103116003)(38100700002)(2616005)(26005)(1076003)(6506007)(107886003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0UJmKxmfLqkmQpoqA5VhbGbJWrGfcVxIEM39ttAAcLzYZcuNpyHPwMfuzZMV?=
 =?us-ascii?Q?1bYk/iAgAu3V65ns14QIUOw5RLgz21BXOPzNrPx2gBhuDQT+XPlqFLsCIWJP?=
 =?us-ascii?Q?K9jkyyHNll2+N3wbH9+dWu87p0G1DPnFDqx/1DxJvgcarS3vRXKfl5csztat?=
 =?us-ascii?Q?FEBjAQGsJkj2PP4oCcphVFJ5nKr/60ACSrbuBVIdNIz2lvyEexM6BMYI1YaV?=
 =?us-ascii?Q?u7//PJd2ENprm/bYv877Y5jGQGlQBdOfuxqRxFD56URiUPdtlALy3CLFWxto?=
 =?us-ascii?Q?O8UOzfp4d+DgClE7VnFCM9UhO/BD2MpJTdIoEavZepPLNmSpxb+LhQuTGflh?=
 =?us-ascii?Q?fchDm/Un/n1H2B4FzPkuvUQeCeiKxouZ6b/5zRrsvy238VgQ3LZTpcwx2V7L?=
 =?us-ascii?Q?FJ8k7yg+envmbVLHI2kA6d3OWqerTjupy9ANAD3IFVWr3vHWdRZ+wDIKzWfj?=
 =?us-ascii?Q?3UIedjgzj+tj74G5aB00VYhJeyoQOtH7hCmuy1f38HVMG8W3TEtkSp4lXBTK?=
 =?us-ascii?Q?DrdQAt2DRjfgU/7qDr7k6yPdrKwFPs7WGw7lImwm3s0kQLGz0iAeKQP4NUEI?=
 =?us-ascii?Q?fSJwdtIE0y1MvoMiFEIwCfHmtOKfWxZdSWRMpfW21OoQ9LFpyHe8n9mO9l36?=
 =?us-ascii?Q?abu/IUIjRBwXN7C+CI7+3LDV13c64IzdADWlMcCpnSjtJTnAN9mZwZZ4qX5d?=
 =?us-ascii?Q?BrqSm3iHaLTxqAmM8KpmILhNXNikvHb9TsW0hvhzcaXsKpQpRrpBAz9sr75p?=
 =?us-ascii?Q?TT/h2AvKQ3DBJMWxNIAJswOd791ckD3uU/2sUtEUz+toT6/BWKMaOlx38zs/?=
 =?us-ascii?Q?YzUPqew0xcTx5np+NSsZNR2yHgasgVoFP1S3SQt9Q3fLrwjdfLSzGWQNB7Kq?=
 =?us-ascii?Q?Gbd7DZOI4saiF2TBSxJ45JyoY8Nfc8VJH96x0+gzHJyYumGcSY0pvYXqDVL6?=
 =?us-ascii?Q?KdPhXxT0KLyfOlTMm8FGRaLFXINZtmq+6NYkwZfBuzXYnsxnomLXbywJblbH?=
 =?us-ascii?Q?BOMwl5Bm7oLa5ANGzNFzJ1QQ0EvHZI29RYHxJP29JWiB55Qgk2BLUSrvW6kV?=
 =?us-ascii?Q?/36Cpd6/ucsiIU4luhghMRKF5bsQ8qosfht7A4M4n4KAMIC9Hp0RjU+HqzKj?=
 =?us-ascii?Q?KISkL0/vYhFS2sQWb6AHrwrgzJEd3DH8rM07h9Cv/5UtYSukVa1n7PvqkHFh?=
 =?us-ascii?Q?bOPv0z6A4DI+XcpUsBeaV9J6Sr2DC7WWAgC+aVkK+0wUvvRLU+HLqF5HKXTw?=
 =?us-ascii?Q?NogTkrS27daqXQFJgdGkRdszp7lSOBMUbVKF5WRoymzGi3bzlSJgf3TfeZqM?=
 =?us-ascii?Q?yU/VoeoHfIQUKYlQmh10yXdtNj7ipspQjUST/OgioSrZkLlqNeOp+VtJd5CV?=
 =?us-ascii?Q?UplH86qrSljbgJXYwHnciriPO4Cr4U3WzMaYcC2UGEuyrF+h526Sox1lqgTQ?=
 =?us-ascii?Q?fZ4kKTtMQEcdIcc/65/Klp7JlxtpCltvcMM2wFXs/vbPpQjhkd458+LcDb7n?=
 =?us-ascii?Q?5iTsAnZ2/TT/eo1tNo1daA22CSFwvXZqOL2ngRbBB+3mRh1Y8eDlgXTT5PSO?=
 =?us-ascii?Q?bXp/uLM4Be22YSSzkc1ZE53/hDQIBEvftKpHtVbvlBwh/8/wp48cTpgQCpA9?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?GynoMDumtk+VJVSZQkDFOivzVKbQSElR6N4gBXoc77jzYH7kl/Yp0LBelKTr?=
 =?us-ascii?Q?UYIJFoA1GXto9EHl/PRS/X54M9S1xx2Uu8OO3cjRlkCBMtfnH2EDqfX5aoge?=
 =?us-ascii?Q?gMnWLWuh68t0kAoYW4Kq1vaaTQ9eDhPE2Kb/rxjEIOyX4FZWuU3F41bIJRdM?=
 =?us-ascii?Q?DKR2gldsdNVCclqlLmrgANUgOg22GUM83jOyWoNF1gyi1N0SAskLOUOEtrf0?=
 =?us-ascii?Q?LWoWM4WS+G5tsrIz0pkmJaGwBz2XzVVnUYThfC4zlSNJRCc8Hk04devmSs+H?=
 =?us-ascii?Q?Z8YZf8CsnoFHNvsAiO29Vfu/11gV5DEwYMQh0ISuJY9Uc0imjuKmv1rz3taK?=
 =?us-ascii?Q?oQ7oMu2pnR/UrcuTVUBwbpsPJv7ZIiVBXLdbDVlCvXDKr+7Wf3mrX7wG7H/c?=
 =?us-ascii?Q?prjdjcy7LATshQ0985wLBdFoE4Py0YxqcVvTycAZvS3pXW2PxdT8KUacrACS?=
 =?us-ascii?Q?qoNkNMqkRumRGbewijeHB3Y0xWaVfL7qPXxdcat5VWqXHmBNXy4eSUPcPUOj?=
 =?us-ascii?Q?aSnVD8SE/OzNzKxA73tm2kn/6AQGHXDU6J1tNM690MEovrqyWqAVROCxAs96?=
 =?us-ascii?Q?dpnF0+5PV6/bjEA1Qhms3pwY529dqja3w7Ev/i9bbyM3EsOKGQfmx4JI8f1Q?=
 =?us-ascii?Q?ozZhEuoKtI7wyFh7YKJiW75a7eGZzHDzhOHQlg4wGtDqGyPAOm056R9pap/N?=
 =?us-ascii?Q?6fbBRw9SHcNNetoDICJrsNql3uS0V04ku3UB9kY5TuHl8+ZR+Fh8qWvffFkZ?=
 =?us-ascii?Q?E2IFpJutXKro0ktJ9cvkcOWl1n1Lc6lAftl2plqXBuECPtEgYtLZf3mhBQpT?=
 =?us-ascii?Q?flnJuGF3KLAtIxkhiz9I8kOTxhKoOnKv3RDf6AiKJKmnfZp8hOuV34ccktEF?=
 =?us-ascii?Q?f/d7gy5PUGB+piKlSb7mZmeWvSJjhHamH3zxiIl5w+o0qkQ30eV7dWiIEl1X?=
 =?us-ascii?Q?A9tD5PuRYaJ4ofW/lH+FZKOByz5LZccpPUjFfkdqiZuUesv182iuXo6IPvk2?=
 =?us-ascii?Q?tsAtVBkYi8H/h+2A0gLNqZVTsA4WWHFPANzrWpGvOtfTlBw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377bc065-131d-4bc8-8bad-08dbd3dec90e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 15:43:21.4655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2t96ey4ZaP2wM2SYhgLw9mZGrNBT6HIqmvavWcjM8aKcYvrKtjua21uSisyN3ZxrP6/2rO+Q+zlqJ7e3utNhv4PvU1a2UnGMIumxami6DQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6444
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_14,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310230137
X-Proofpoint-GUID: z-gb5_pGTmGqE9O4ZvDcvnQ4z0AgAQIx
X-Proofpoint-ORIG-GUID: z-gb5_pGTmGqE9O4ZvDcvnQ4z0AgAQIx
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An entity is supposed to get an earlier deadline with
PLACE_DEADLINE_INITIAL when it's forked, but the deadline gets
overwritten soon after in enqueue_entity() the first time a forked
entity is woken so that PLACE_DEADLINE_INITIAL is effectively a no-op.

Placing in task_fork_fair() seems unnecessary since none of the values
that get set (slice, vruntime, deadline) are used before they're set
again at enqueue time, so get rid of that (and with it all of
task_fork_fair()) and just pass ENQUEUE_INITIAL to enqueue_entity() via
wake_up_new_task().

Fixes: e8f331bcc270 ("sched/smp: Use lag to simplify cross-runqueue placement")
Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
---

v3
 - Rebased on tip/sched/core and retested.  The "none of the values that
   get set (slice, vruntime, deadline) are used" part was checked
   without this patch by poisoning slice, vruntime, and deadline when
   placing from task_fork_fair() and checking for the poisoned values
   everywhere they're read until the entity is placed again in enqueue_entity().
 - Added Chen Yu's R-b and Prateek's T-b

 kernel/sched/core.c |  2 +-
 kernel/sched/fair.c | 24 ------------------------
 2 files changed, 1 insertion(+), 25 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 264c2eb380d7f..bdfdd9598137c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4856,7 +4856,7 @@ void wake_up_new_task(struct task_struct *p)
 	update_rq_clock(rq);
 	post_init_entity_util_avg(p);
 
-	activate_task(rq, p, ENQUEUE_NOCLOCK);
+	activate_task(rq, p, ENQUEUE_INITIAL | ENQUEUE_NOCLOCK);
 	trace_sched_wakeup_new(p);
 	wakeup_preempt(rq, p, WF_FORK);
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4b70b0d146987..544de3b43e146 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12417,29 +12417,6 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 	task_tick_core(rq, curr);
 }
 
-/*
- * called on fork with the child task as argument from the parent's context
- *  - child not yet on the tasklist
- *  - preemption disabled
- */
-static void task_fork_fair(struct task_struct *p)
-{
-	struct sched_entity *se = &p->se, *curr;
-	struct cfs_rq *cfs_rq;
-	struct rq *rq = this_rq();
-	struct rq_flags rf;
-
-	rq_lock(rq, &rf);
-	update_rq_clock(rq);
-
-	cfs_rq = task_cfs_rq(current);
-	curr = cfs_rq->curr;
-	if (curr)
-		update_curr(cfs_rq);
-	place_entity(cfs_rq, se, ENQUEUE_INITIAL);
-	rq_unlock(rq, &rf);
-}
-
 /*
  * Priority of the task has changed. Check to see if we preempt
  * the current task.
@@ -12943,7 +12920,6 @@ DEFINE_SCHED_CLASS(fair) = {
 #endif
 
 	.task_tick		= task_tick_fair,
-	.task_fork		= task_fork_fair,
 
 	.prio_changed		= prio_changed_fair,
 	.switched_from		= switched_from_fair,
-- 
2.42.0


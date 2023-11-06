Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A31E7E30CB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 00:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjKFXM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 18:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbjKFXMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 18:12:20 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF18D75;
        Mon,  6 Nov 2023 15:12:17 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6MVVbS027188;
        Mon, 6 Nov 2023 23:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=KOGWfO8sNBX62LpdPb/klFoP0r1AmbGyZa8Y/e86WSU=;
 b=v1bz1myABMLCObd+yDPb+KN7NXb3h4kTOE78wvxSjCRSkecbHF+3/Y5KZtJl4Ke+U01Z
 t3daoHYTICCjZRTTui/+aEuUQBrZLZYQ7QMcEubJR/eww1p20kRUxXxogO8OBnq170Cu
 +umZBe1Fay7pA5bgOMWQ7OLLq0dsmqUexwypQrQVPOKq+/3b7pOTDhbdfPYRCf8P/alG
 mBdeqll4IiuSdCRmmNB3KtGP0dJZ86VlXu45DaPcF2bHL9sRv6phPa6EF20Rnvg4q3jA
 fMn8Qo7Sj7Y1hPfOCbwQBcble60KN7llO1sjA3hbeAukpVLGfi9KO+PHBLrHeWXR0x/U mw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u5dub4jg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Nov 2023 23:12:03 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6MjLj6020747;
        Mon, 6 Nov 2023 23:12:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u5cdcek0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Nov 2023 23:12:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTAprwtvvFvZTZ3f689woUnnzQcnMy5lxLTK9s3T3ZK7IWUJtOGrOPAkxTHYq1vfMMiotW1zO60bllbXO5MuWUgqWkoo234WdGrW9BZYFAZFoSNv62TirYWHexXPYfhzwjrbUOPTWH5mR+8aTRJH+NiedobdlLgVAtNbuV/6BkssPpphG7+Z95H+cQJ3CNyQxDi3aZ340rq3gEhPdiYVfTohoyrtgGDbkyTdvtvHCzb4E1yrATsWeooHXyOR5dI6I2zIcHL9EzCVaqWEeLfEw6J7wI/sNYU2+bGIlUTpvm+/whZu4MKzLeIUNroZCPkKrvWNFDEw5kYTdNN5jXmBxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOGWfO8sNBX62LpdPb/klFoP0r1AmbGyZa8Y/e86WSU=;
 b=kxdDL+MohOxorv1mNPBDBH+m92ugnV1MGSbFUC4MopfEOQixcTEu4yIKOjbgLb20Pz1bPmEwxAWKL1FzDjUIo2jymWRsv1xFv8F5BLmVN7wePAG0k2MnOhyGpufLqyWRFUtURKLEnNRP6hPINadQb3Mh/qep4z5rOyE5g5wEHymOefKWoAbc69Yt6+MtfmvOUzPyNbY/qhHRZPwEu1HWkmhMPHyuRoAxrI01XkfiXXKkItyZNa4+Iuuludhdsd8tsaRIvlI25PtWt6mS8dZAi890oChrBH9FbbytAY8yBhk50Svycgc3AQK9XoT92XUp4ySB+wQdmnmROKSjfvni+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOGWfO8sNBX62LpdPb/klFoP0r1AmbGyZa8Y/e86WSU=;
 b=f4jMQuSyniQXDnLtvk/JlUOR0ySYFSFMkIytJawkwJZYsD9UxfOGybu7DdALPgHy/JTkfDka9U/pIjeWJgjwPDf2OeDDJiS484A96izAzM++ApwBjyrm8EFsq9RaWSe4CyDZA7FeoEhEq1HM3pq9JeKEEmwnX47aq90fhxG54RQ=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS0PR10MB7479.namprd10.prod.outlook.com (2603:10b6:8:164::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 23:11:59 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::adf2:9029:9b90:56f0]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::adf2:9029:9b90:56f0%7]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 23:11:59 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     zohar@linux.ibm.com
Cc:     dmitry.kasatkin@gmail.com, jarkko@kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, eric.snowberg@oracle.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ima: Remove EXPERIMENTAL from Kconfig
Date:   Mon,  6 Nov 2023 18:06:26 -0500
Message-Id: <20231106230626.2730342-3-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231106230626.2730342-1-eric.snowberg@oracle.com>
References: <20231106230626.2730342-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR10CA0007.namprd10.prod.outlook.com
 (2603:10b6:510:23d::7) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|DS0PR10MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: d681e3df-205f-47d4-85d6-08dbdf1dc776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 10hZ8IBzNk+DWY3++XM62eWdue9Dqbilm4p4LhmKTE0koJaLmRf18LBMSfMjEt6FPq8ez0WCykpOqklkIGZ0C/Mkv2dyLADwCZsKH+Jm+0N2ylif2IVx52Qnvqe3EO/75N3qBRdYCcK4ctS9+vm2mi/zH2yeU6C4tOvOPEyT5oh00nNwDYyQC4gXFF9YOhNfOA6u1Snvp/OFyAbQncSgvfax4hOe/BTJtTkeJu1KY51sdfEinSGSXM1SanWcaw1j8ubUk6qMLGoAXz/+lHncpdJfpACMRQzu5HH2F1x9wFC5js9YMCU8GMVlqfZDwPI1jJAsMnfiP3xV9AJ6sZCNkhNwHIkgtmxw26TySGg0YtED3+ULRkMF1kVVBHg0FO83CpkB6uPxOpvFUfuTS2z24OOxhVXNAGyz5Bd7+kyo7bLRsxJ16xF1bEd+2/77kbmPZp8I9Xyy+MKU0muSJQGlhXkEbLZNm7C0N0bNPxOQ2xxM8psvbZcQG5RUh7dG/4L3KAT+Gb240400xduY5gNKktUypPqaQqAdpjk2YQdUs1Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(36756003)(86362001)(2906002)(6486002)(1076003)(41300700001)(83380400001)(478600001)(966005)(8676002)(8936002)(4326008)(5660300002)(6506007)(6512007)(6666004)(2616005)(44832011)(38100700002)(6916009)(66556008)(66476007)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R8BB9tK7acmmkDZUjedrZxt8rdoot0TOrGPIR6hSMXv2lBLUnRKfNoVqQ4Ha?=
 =?us-ascii?Q?qL9Nv9wgcn8qVl9LcAhSeTFqfdxJfMW4PgIZm66rjJErorPtPMqzrLw4N2b6?=
 =?us-ascii?Q?lzd9RyprlhPuPu91Mm+bmv9qlTM0W8vSiR767GFbbGNEy6ztn8Gbn62cKJN+?=
 =?us-ascii?Q?obSDQUPPz+L4ZkqpE+vHeCNQUiXcnfZv/J0UEBp6A1LVHi5iwa9Yu7D4xCKn?=
 =?us-ascii?Q?XVYNt1NTED//uT5o8S6O5hL9D+GmrOD+3U6mx2KgYt73C3psIlulR/AaGQLP?=
 =?us-ascii?Q?wFOXHCCwCpJmRxwRjii7Yx04amNOwsQKcx0g+i5RUlpeCaVcQgS281loDHk0?=
 =?us-ascii?Q?/NtRteqf852YwbAKuhGJWfWDLs9O+7vVnSMWIwUI34C1L9rho2bYHVVBW/rc?=
 =?us-ascii?Q?c9hsXZw979IuWXL5pwENC/MxKdlDrTaGh/9hyrvQ9bgcVPjnLs9d9Iq4E052?=
 =?us-ascii?Q?o+PQPrpBfHHcYCBlm6jZLqZ21FWFpVL89C9bE9gK4xMUtjyaigdvNppxzQpU?=
 =?us-ascii?Q?2BE+Od+9/Tp8dBTaP0on0aRDHQxMXeCg9kb6RAua1Pr0ORUwrOy8r64BSCY2?=
 =?us-ascii?Q?rnsFr3hRofYNrBnVx6/kwjiv4swlA+AKkRb59gxDhdA+WnfseL6mbSQ8iB3a?=
 =?us-ascii?Q?CmIyH+BmOxZaWr7S3jsPB+zQLGnvRbNkXMyc3Sp7H0y2zqMo2KRXc0nX7hCR?=
 =?us-ascii?Q?RL1e7VdIumziX+UTwfWeWVi4oAOwsh0zIc7T50b0kNNq3Q2CkIW3730+2hRs?=
 =?us-ascii?Q?dlx9rsI2Esrj7IfLJivIVAn9MAPGoRu+kFlVKss+KxhKlS2SacJAJZXBl0Uz?=
 =?us-ascii?Q?n0Dl8Sl6AK9FBEJkx0U6zM0UeIEP4yZ1f5deJ5reSfZFcyiOjoNH81qtsgEc?=
 =?us-ascii?Q?w+xdGbpQeGrVOdCN9/hs71XJRheC3pzkWQU91v0Wb1K5vhPkjeS7YCvzmqTo?=
 =?us-ascii?Q?kH9xvBpK0uHxvCOzEOii3nBLTxNZp6HxqGa4jVDHfKlqfE7xz/gEp3U3+yUF?=
 =?us-ascii?Q?9FIAD8vy5KaGMCgLpCGnaTpigagtANrFt01XKNxcDmZwwm0WZIsKwAup6PPs?=
 =?us-ascii?Q?/54UAiy+Wpk0DQeClYmAxSZDoeslsZYFzbt7GLXFDB83KtdgCv6qYOZz9oT5?=
 =?us-ascii?Q?svghcZ4KU2RHCRiLGm4D/izC91aDjOyvKBCqNfjCI0ox71gkow/MvvC+Uq88?=
 =?us-ascii?Q?V11Zcz1nUUTkmeKUn9C0oPdkMG8YV0LDyoyIxtuKkNWr51ZA8twApOTmP/QY?=
 =?us-ascii?Q?7+exGh+4z5DCs9gWjEDSEr0VzEnsPNMq2JNrQ4hor9oASjVdh+a+QJMim+Dt?=
 =?us-ascii?Q?J6/pbd+JJ5cLJzhBXEFENtF2PBrTo2Ha1zbCLexeUvUVSM3629r1GfcaA93t?=
 =?us-ascii?Q?hAMxayjLvCoaDlYpzrNEm7oTXFsqZwxBxj3ryxtlEXXtF7X/rDDMzdjzz/uV?=
 =?us-ascii?Q?MR5hJrE0FBzLxo+YntONmLZU1hv9dNNP3BzsOoRmtef++kAcC/XIyHL4bogA?=
 =?us-ascii?Q?OGFjIfTq60ic5Bgx/FLHk87G1cIP0KQu7JM73xVx0bPXZvsV78yKyLxlD7Rs?=
 =?us-ascii?Q?a/Oy2RpsMzMgcSvVIG2+sdCyCanXCGsBN6wErnbkMqsB65OSY8fRcApZwHXo?=
 =?us-ascii?Q?8RLyFtzzgw2S3w+PEQ0Joh8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?OkZO8a7sgg+9IXHgagZfkXBjsBo5T3OqptPBXW0ufkIUgiPUDqdrEKA1m/Ss?=
 =?us-ascii?Q?t9BYP0+e9V1MqM+Lwyzbl1Is3yP7oWgae7CwZ1cWiShB8wjDmkNUfEPBQqMx?=
 =?us-ascii?Q?rYV7vSxIXapMeJP9IDniir/bjyw5NO8fC1O28n2O6g66OezVJZ8IvXiNLFKP?=
 =?us-ascii?Q?+8oijRFnRjYcKSMwsZZ4moSebzzz++r4rHDV3A0emPf1vz87KL53Q6TYvz/U?=
 =?us-ascii?Q?f4uJ+UNnaG+CMqlzbFW07oV/9/ifZp0gA/pxgfL/DpQ34grf5QhpxnTl+PnO?=
 =?us-ascii?Q?2iVCus1pNMVH6F8Bv2LfMnxEs29HhQ29X4Jr/S2586g39ml40u/gH0x4NW60?=
 =?us-ascii?Q?oFWWfruZb9H4AtA3VAbLuzRM2sJIy4RMHIZvB7g/0fjijF68HNjHH7ua5oi+?=
 =?us-ascii?Q?hZNu0+WXUPu+IHmz/R0VeZqo8sbB2wN7NPGgVU3ukJ/IO4BzzXL6TNS+9mC+?=
 =?us-ascii?Q?jMen8Xx94oTS52hJFf8vzQjlwJKZ7ZNhX26YnuCRBOt4kOhQrYoBm02/fgbj?=
 =?us-ascii?Q?u/1fq/XhbnKerTtTrIVAVnaxjugHWyAwMXquRPUDVurUZRQFn1nrF6syIXSv?=
 =?us-ascii?Q?L30BXtlRe9qftFY1RdaUyDrqTDwa4KpXOrJ+5v0bOHuJWKmZHqve9MYji19o?=
 =?us-ascii?Q?1qWB8zHAe7+7cAwk3FB69bhK6XgFvxHy+MXUBYr4DmVFDrTvKNzN2KdVVHIK?=
 =?us-ascii?Q?OFJC2gVYbR07cB2HggbAx511WuAENgz4HCMMPiCeAyMcQEE/qkDM1ciHEssa?=
 =?us-ascii?Q?6gJYLzs7B7cgb6QXlMcfF27da9S9vn8K/v650tf0L609VqLgEWMARLCHFbdH?=
 =?us-ascii?Q?pok6eRefpYTdL08fOQtMa9TkcTNtuqAXlHtpHo+b+GgdngzrXa2QNna6UxXl?=
 =?us-ascii?Q?i1dHpaVbm97u+HDNxeg8MJUJypoCx16ihZHrpv1nBvz4lDgRIVUY7u1H8b68?=
 =?us-ascii?Q?DA/G5lAq6/wyPGzBkro3zQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d681e3df-205f-47d4-85d6-08dbdf1dc776
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 23:11:59.8499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPj4KK/Xis/OQtDeXk3lmPps1GZyZn08yyebuAoDDsDg/vDowNDyWQxLluNm0RLmL8bZcNNWNhc+gauyPbfGgAvXAIt2KAJwcHvccHaDrSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7479
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060190
X-Proofpoint-GUID: wWuBH6qFhDURPJS8dTYOrsTCEJvLhNaA
X-Proofpoint-ORIG-GUID: wWuBH6qFhDURPJS8dTYOrsTCEJvLhNaA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the EXPERIMENTAL from the
IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY Kconfig
now that digitalSignature usage enforcement is set.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
link: https://lore.kernel.org/all/20230508220708.2888510-4-eric.snowberg@oracle.com/
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index a0a767dc5c04..b98bfe9efd0c 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -243,7 +243,7 @@ config IMA_APPRAISE_MODSIG
 	   to accept such signatures.
 
 config IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
-	bool "Permit keys validly signed by a built-in, machine (if configured) or secondary (EXPERIMENTAL)"
+	bool "Permit keys validly signed by a built-in, machine (if configured) or secondary"
 	depends on SYSTEM_TRUSTED_KEYRING
 	depends on SECONDARY_TRUSTED_KEYRING
 	depends on INTEGRITY_ASYMMETRIC_KEYS
-- 
2.39.3


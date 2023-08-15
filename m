Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3632E77CC25
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbjHOLxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236926AbjHOLw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:52:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D2EC9;
        Tue, 15 Aug 2023 04:52:54 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37F4pcVu024651;
        Tue, 15 Aug 2023 11:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=qfJomhwqcZ2tSlEKHB3KFaex2MigG/i5X5eY9iK4upA=;
 b=sO+F33hB9DIPvIv4aA9mq1RxWvbjNlPC1s8TaYKQYveNShVyrT2PAr3tTQQ0TcxCMQ3V
 1l28TEwZ8Ui/4UWByMG0YuPeFuuxxlMYX/G8PvhYopCnHTGhh9xVQVW2fs1/NMf5ki2H
 7LuoUxlMizMXcyOQeGKqvW7ux+MWBf46iyK6TvkE+93BxwfEWzABD7g+xZYo6rzGsy59
 b5IBnusjipBgWqRR/MVOtmo4lyk6FkjfuoBk/lTWoqCU/rVHd/XjgBqo3W9dwqAIFQVJ
 b1JaUaMB6O/Y2q6PemPCgrikFjKsNc4cHNPGvF0KBE8zFMky6eSGp/WRkvShoHI73FTb Zw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2yfmg49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 11:52:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37F9MGWJ027586;
        Tue, 15 Aug 2023 11:52:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1rytxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 11:52:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMf3YR4uL3DUaYTRuOfoWBvZ8h41lgJvDarHAGi9mHj3cGxWgQMaDjZISVvRyq5yX/Ugrt6Wt5x4kkWzk54KHlR+CIrU6xZt12bQxvIcdqQ98QiF5utl3r+6OWDqHzPjIlYj2aPW7HKTf48fkiYI4zv4K5EY9u1SLqL5irEvuM2G5yVyiv381oQp9wIFemm6HeBLCxIVMuZsI9oJJpikGYj2Ze+R9z53Ju8yAWYhKYuZfjHQQPLHU4szMiG8zKV7fqfhfA8JEyW/7HxsK2/59KUW47EXLsgeVomdiC2zLfrt0Doy7RRu1EXJBUHRdyYqM5fBt0s8AzgTewwzXUuA7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfJomhwqcZ2tSlEKHB3KFaex2MigG/i5X5eY9iK4upA=;
 b=nhYO9B54I44ZwcAhjhwetZkxMqL5t+ZALoyyk9peCe6nmv9HxdjkJweJXrOKoCAwj2ODnYzHN7qLMCDbAhp36kp7ptv0foV+8Gl9PMkq7gITqkwqKuKLwjMec9IX5tyxx5odvycXhwwf2aKbBvrF03jJ4L3I2QJ14Wd+a2wjnJb7dqgZyGLBGYLQSf9iJIH8jbCJ59uMsIn3CfbBCFgCbqj7FrYIBG6BwqTN1BcufkF3zuWbiGi8fkjGPjCmuwfk7xqRpXZiQlE9B+1uebUiTEeaQ2vIYlCpBfAFCmnxtLJjgqPNxnoIFOXy7otlzOoe0JKJMP7XU/15iRd3RUevrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfJomhwqcZ2tSlEKHB3KFaex2MigG/i5X5eY9iK4upA=;
 b=PoC6lVMDs4kIhijjoziZWiHIhnGZolqEhW6MnpgxwhNJyW3HIbgdcJEL2YlymVMMEkxS/pmtnfpkfcsnwF33gwRi01PGH4KOGR+hUUCuuyhWz09vAI+tu15CLp288A1P8WFtkDplYVRtOpzU6OvZY2lQuwqCl7UeNn0Ms8QmOFA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6710.namprd10.prod.outlook.com (2603:10b6:208:419::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 11:52:29 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 11:52:29 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        chenxiang66@hisilicon.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, jinpu.wang@cloud.ionos.com, dlemoal@kernel.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 06/10] scsi: libsas: Delete sas_ssp_task.enable_first_burst
Date:   Tue, 15 Aug 2023 11:51:52 +0000
Message-Id: <20230815115156.343535-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230815115156.343535-1-john.g.garry@oracle.com>
References: <20230815115156.343535-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0061.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: ca62df22-9bec-4026-6c34-08db9d8619fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XTESEXqgi013wS+MXRBKY+yQ6DN5AARnzhSkFvcCUQVXq3S09EhoQYiK2WXoxhcMftVWVPKS1ki88KJFPLv+TxvGW+K/kG3ayESTeQ1/d+5JmVsVOTqMufar4fvgZJsPGGnlMalzXkEWnS+JtyxgR0/1PY1+cW2B/mZM+ekd6UuWwEo8PL5GNtQIO7RORxFtZT3GXzTs4k3PtqykyWkr6OUrRmVBdjJle+0d+xlvsalP2vrCjPzLqdheloSnHgmStLhG1BxfQQzCME0ENzZlhcJj7NZ/D4dY7XEFr1Nc1e09bgTdhCsWRJvowC4rcG0xik40EY21AMO/SMbXCUQWKCnr31pO7Q5NYJ1ZrPmqxQe7JA/duMIAUpD9ry5OcvQZeIF/q24lfCwCysuDMhpUQI3TcnxuA2egWjQ7h7XDkDEZkuZsuSJMYf84xO90X2jlMYSLtKnvgeoLU5yw2K5+3zLdevQztoOLUeb7t+0aeR58u2tUJQaWy8SlI/Gqyku8mdPV3T2kBZ2rOI7G2fD2hdhZYDf5RNVcpbkFj6fDfUQOY6pKTYNRCDvp+mjlH5jzUycrpevJsgWQBwpFhPzAIDrkzjwfu+YAGqDAj2bLfQPiTAiUHF7feiO3PdQSUJXM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230030)(366004)(346002)(396003)(376002)(39860400002)(136003)(1800799009)(186009)(451199023)(38100700002)(41300700001)(107886003)(6512007)(2616005)(5660300002)(103116003)(2906002)(36756003)(4326008)(316002)(66946007)(66476007)(6666004)(83380400001)(478600001)(8936002)(66556008)(26005)(1076003)(86362001)(8676002)(6486002)(6506007)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UU7+ifz79LcZOKjpCVJ8eaQw180kVkhLBGbLKI40jSRgQMYmKfxQat63e7zX?=
 =?us-ascii?Q?SJtOPUEa/OafZqc6ifusoCZULnT9b1TudlfVENmGUnPPh/XsaFJwcSQh/4V0?=
 =?us-ascii?Q?cPDwW4ErDVOhBAuCkD/853fih2wrGCEM98LKj6KnwtVJdTPZPuxxazl2/cH8?=
 =?us-ascii?Q?8vzlhggOdpyxaU/juFM2J8XTWJ5P2f4pnCsmz3aROH4hKZYUt0gynHV7nrSS?=
 =?us-ascii?Q?uuiHTOoR/vD4QumvFNQwPoG/hy/q3uC/z4hIa9jhunfZQvHep8bV08Xs5+Kc?=
 =?us-ascii?Q?TaIxo1V53TA8Y9afC+ZiJGNfjJSSGfzq8wOX5CIxbs2YmwTNyifcGVpLml6l?=
 =?us-ascii?Q?87UpJBu1w0iX3vYheVXEKB3OabTByIQ2nv2PR7TymBL2wvA/Sm63N5gG6AGb?=
 =?us-ascii?Q?JS/6i+YWDQWcaUBv4OZ6p7zxWySPb89xVZMFMja6tEHp8qtXz5yjH0Q5vQr5?=
 =?us-ascii?Q?SUFhwYTFI0qBZCdRsWtndttCs/GHONnmeYaBdimW5AI6xsYQTcmWIV+U0AJw?=
 =?us-ascii?Q?PcnaPGrl1NUnZ3X1Q30p7KjkMGcdHJGgzJ7+ZALltz+q19Jj9gyJ55QoPK1A?=
 =?us-ascii?Q?gPb2iRr1eMh+Ori6H6ZorFrHwuxmpkSr/GNhvKwZ50BBMQq8bj3WX276Z1a6?=
 =?us-ascii?Q?7aozbs3OA4pO8S7Qh/pkYQxTw1kBLfXKcsCE+oTGOctgOR21X3WB+OJ+kg1r?=
 =?us-ascii?Q?7egaMdb6uXrqpw6NZBXcAPotcxSORy/Jf0X72eHvz/JZ1GQFQ9/nFobIOeL4?=
 =?us-ascii?Q?qmkyKa5yW4XlbZsNTRcl3nYAUi8TCs5mN+kEg2Px09CfcTH5yNug2/2Ax7y/?=
 =?us-ascii?Q?1Hun0+IlQotlbKuQbYiSfiUUbJmVY/iRYaVYDhT5mW+2htlyxwF1T+4+5sIl?=
 =?us-ascii?Q?6GERngh5i4UEatJAV/hZkdN6UUvKt12wkjO0Y7DtM2mwiZKJOw4A/o0dQnsv?=
 =?us-ascii?Q?KyMHbDi3B2ndDJed7U7qigKwH0JYSxoadqEMZSXQibChIhqX4OrWdDZbDxqD?=
 =?us-ascii?Q?WCl5qL+Tpv7Xx7ntoNbtDipCdODnF/ohYpHg+GZOcugIPLPtzZqqXnVyiBlb?=
 =?us-ascii?Q?hW8tKjHsue/2RwxMpUbTmaY23qb79O1YBJjqhJ7V4AeaSZWRavDQMLT8nED8?=
 =?us-ascii?Q?YZ4BZ3Le6oDFZ69bDralNc+m4AIp6qMWLGbZ7ANygsJE+H44QDYDREx+WfJW?=
 =?us-ascii?Q?F/4Av1rF8pDFrFWOZPffPi1nmQ+XgaETSHiHMKyTcfHz+eoaH32+3ViFD20u?=
 =?us-ascii?Q?0Ihck2gR6Zg+nBDW4CJLj9OQi9DSHIptCJeRKbt7y+DR+lXA6b6zp1L8Ye46?=
 =?us-ascii?Q?+pIn5L1xGiZSzvnXFUmM61oTvAUR7AshtguJh2OiiQTIz/hbAavWUI3k4a5G?=
 =?us-ascii?Q?aPLnMn66Z8j7D0dYFXgHDwSFcQSh0Pq34PT3eoX32MceR4N43/RNIPsmoy0S?=
 =?us-ascii?Q?dtXpJw0ZYMpgm4c/k/L/CcjHmbhKnLJ432EJY+zVUZqwm/xDqEV1dQvYFlGG?=
 =?us-ascii?Q?8Sm6bwn7SaSH4BVvmIO7ZuFfalCfZSZZeV2NEEqj28A82YlsBIzrIl0I+CUh?=
 =?us-ascii?Q?HQe5NrdE23HZVqbXiYOIt+Gr9xBy2mVikRL3HeoRAjFgml+Tq9BntMmK4uoc?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?K1snnWzKhXHjuodyW8wY3EFwSZ3eW2LNxJ1Hb6HI/5+PLA/c12RcacnkP/OJ?=
 =?us-ascii?Q?qSlaaZ2VdejxJK7JfHAzbZZb0osGJs/jIOTnc1PAk527Nvj5phBJowRHi/7L?=
 =?us-ascii?Q?732mCOChT/B2t2ESXAXBYoc51QmgXMc2STxc6wbT7aE/AAKbKMo2HrI2cKbq?=
 =?us-ascii?Q?OA06RqfgmPxZpD1HLI9S+DX2S8w5AQgRvljdvhERvn+MEBxS7HHGFf0gXqmu?=
 =?us-ascii?Q?VC806ceCbjkdcTOQHxQgxbaZ/xMbc4OOLoEONTfS8j5yrKAQa0qltYgOfeVW?=
 =?us-ascii?Q?/8xtLwr+9FtbBUZEWqcPfY6xnf3Em/z8wfx/mhLRjNDC1yZzNO4h8fScl1TA?=
 =?us-ascii?Q?mh5hipY/DnMyveiSpSuy/uaZW3uxvLI4oXPkmwbrkDhObQgoFUEnV1naW/DZ?=
 =?us-ascii?Q?eX5p8FQWqI0JgVCGIc+FKuBSY/VZZ62E4nMVag3fROFJu6LEpxjx/OAWW8d4?=
 =?us-ascii?Q?qPYr8CV/KrXPg4SXvsjIiIibg/WpYtJS7Y60PteK6Ct+ktyRb3YU0JK8q415?=
 =?us-ascii?Q?gY+L+4dVievdPwIpP/q6+WOjoWiWUFlmANbAvHxo2agcpM0yHAFBEYJU9AZc?=
 =?us-ascii?Q?Nzyyi3xhsgzou8p/eiohMUT5qR9ffLPvagfEVFffJpl9IwYDw3+B3MBDF3Qx?=
 =?us-ascii?Q?ThXAGzbUVY/mhuoCW1Jub173CE9aHL27kYJJeHNrD8MKwsk5a1IFBFwOnlII?=
 =?us-ascii?Q?wkyh7mserVenSWnvDGaFvfobxXni321955f3jzQtt3je0yJuBwD1xaShmvwV?=
 =?us-ascii?Q?g8Ap/I2gPRIi7wojLcezIX9JiemirD/vpbpAj3bTHC9VWker0lpRZypxDtpb?=
 =?us-ascii?Q?GoWnPZNiFiHA/r1nX+9azqXVTV/hxd9q+AbUY38aoIEq8RL1wMAQeHwg4EbO?=
 =?us-ascii?Q?q24OyQ0RcjQ++p46EUh3BH27zlwHYbbfYxQF+08acUBevE5X/i4cUFuueE4U?=
 =?us-ascii?Q?WIVL68L4bhD/bkW8m+nCfA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca62df22-9bec-4026-6c34-08db9d8619fa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 11:52:29.1238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hX68sha2KJ8QcZj2ULc+wjcuJIWSWCsu2yP61gR/zzmpyAKYwwBJqZUqXUJqNsGa+q9zcuXoEniO4aq/K9cqNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6710
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_10,2023-08-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308150106
X-Proofpoint-ORIG-GUID: hTfhqbS55sOwSK47O2HbjkAoBfy9swbB
X-Proofpoint-GUID: hTfhqbS55sOwSK47O2HbjkAoBfy9swbB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since libsas was introduced in commit 2908d778ab3e ("[SCSI] aic94xx: new
driver"), sas_ssp_task.enable_first_burst is never set, so delete it and
any references.

Signed-off-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/aic94xx/aic94xx_task.c    | 2 --
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 8 ++------
 drivers/scsi/mvsas/mv_sas.c            | 8 ++------
 drivers/scsi/pm8001/pm8001_hwi.c       | 2 --
 drivers/scsi/pm8001/pm80xx_hwi.c       | 2 --
 include/scsi/libsas.h                  | 1 -
 6 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_task.c b/drivers/scsi/aic94xx/aic94xx_task.c
index 7f0208300110..1ac4d3afc1a1 100644
--- a/drivers/scsi/aic94xx/aic94xx_task.c
+++ b/drivers/scsi/aic94xx/aic94xx_task.c
@@ -485,8 +485,6 @@ static int asd_build_ssp_ascb(struct asd_ascb *ascb, struct sas_task *task,
 	scb->ssp_task.ssp_frame.tptt = cpu_to_be16(0xFFFF);
 
 	memcpy(scb->ssp_task.ssp_cmd.lun, task->ssp_task.LUN, 8);
-	if (task->ssp_task.enable_first_burst)
-		scb->ssp_task.ssp_cmd.efb_prio_attr |= EFB_MASK;
 	scb->ssp_task.ssp_cmd.efb_prio_attr |= (task->ssp_task.task_prio << 3);
 	scb->ssp_task.ssp_cmd.efb_prio_attr |= (task->ssp_task.task_attr & 7);
 	memcpy(scb->ssp_task.ssp_cmd.cdb, task->ssp_task.cmd->cmnd,
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index 94fbbceddc2e..d4e3c3a058e0 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -960,7 +960,7 @@ static void prep_ssp_v1_hw(struct hisi_hba *hisi_hba,
 	struct scsi_cmnd *scsi_cmnd = ssp_task->cmd;
 	struct sas_tmf_task *tmf = slot->tmf;
 	int has_data = 0, priority = !!tmf;
-	u8 *buf_cmd, fburst = 0;
+	u8 *buf_cmd;
 	u32 dw1, dw2;
 
 	/* create header */
@@ -1018,15 +1018,11 @@ static void prep_ssp_v1_hw(struct hisi_hba *hisi_hba,
 
 	buf_cmd = hisi_sas_cmd_hdr_addr_mem(slot) +
 		sizeof(struct ssp_frame_hdr);
-	if (task->ssp_task.enable_first_burst) {
-		fburst = (1 << 7);
-		dw2 |= 1 << CMD_HDR_FIRST_BURST_OFF;
-	}
 	hdr->dw2 = cpu_to_le32(dw2);
 
 	memcpy(buf_cmd, &task->ssp_task.LUN, 8);
 	if (!tmf) {
-		buf_cmd[9] = fburst | task->ssp_task.task_attr |
+		buf_cmd[9] = task->ssp_task.task_attr |
 				(task->ssp_task.task_prio << 3);
 		memcpy(buf_cmd + 12, task->ssp_task.cmd->cmnd,
 				task->ssp_task.cmd->cmd_len);
diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index 9978c424214c..165f46320bd2 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -564,7 +564,7 @@ static int mvs_task_prep_ssp(struct mvs_info *mvi,
 	void *buf_prd;
 	struct ssp_frame_hdr *ssp_hdr;
 	void *buf_tmp;
-	u8 *buf_cmd, *buf_oaf, fburst = 0;
+	u8 *buf_cmd, *buf_oaf;
 	dma_addr_t buf_tmp_dma;
 	u32 flags;
 	u32 resp_len, req_len, i, tag = tei->tag;
@@ -582,10 +582,6 @@ static int mvs_task_prep_ssp(struct mvs_info *mvi,
 				(phy_mask << TXQ_PHY_SHIFT));
 
 	flags = MCH_RETRY;
-	if (task->ssp_task.enable_first_burst) {
-		flags |= MCH_FBURST;
-		fburst = (1 << 7);
-	}
 	if (is_tmf)
 		flags |= (MCH_SSP_FR_TASK << MCH_SSP_FR_TYPE_SHIFT);
 	else
@@ -667,7 +663,7 @@ static int mvs_task_prep_ssp(struct mvs_info *mvi,
 	memcpy(buf_cmd, &task->ssp_task.LUN, 8);
 
 	if (ssp_hdr->frame_type != SSP_TASK) {
-		buf_cmd[9] = fburst | task->ssp_task.task_attr |
+		buf_cmd[9] = task->ssp_task.task_attr |
 				(task->ssp_task.task_prio << 3);
 		memcpy(buf_cmd + 12, task->ssp_task.cmd->cmnd,
 		       task->ssp_task.cmd->cmd_len);
diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index 73cd25f30ca5..18070e0e06d5 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -4053,8 +4053,6 @@ static int pm8001_chip_ssp_io_req(struct pm8001_hba_info *pm8001_ha,
 	ssp_cmd.data_len = cpu_to_le32(task->total_xfer_len);
 	ssp_cmd.device_id = cpu_to_le32(pm8001_dev->device_id);
 	ssp_cmd.tag = cpu_to_le32(tag);
-	if (task->ssp_task.enable_first_burst)
-		ssp_cmd.ssp_iu.efb_prio_attr |= 0x80;
 	ssp_cmd.ssp_iu.efb_prio_attr |= (task->ssp_task.task_prio << 3);
 	ssp_cmd.ssp_iu.efb_prio_attr |= (task->ssp_task.task_attr & 7);
 	memcpy(ssp_cmd.ssp_iu.cdb, task->ssp_task.cmd->cmnd,
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 39a12ee94a72..ad5a73b86415 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -4316,8 +4316,6 @@ static int pm80xx_chip_ssp_io_req(struct pm8001_hba_info *pm8001_ha,
 	ssp_cmd.data_len = cpu_to_le32(task->total_xfer_len);
 	ssp_cmd.device_id = cpu_to_le32(pm8001_dev->device_id);
 	ssp_cmd.tag = cpu_to_le32(tag);
-	if (task->ssp_task.enable_first_burst)
-		ssp_cmd.ssp_iu.efb_prio_attr = 0x80;
 	ssp_cmd.ssp_iu.efb_prio_attr |= (task->ssp_task.task_prio << 3);
 	ssp_cmd.ssp_iu.efb_prio_attr |= (task->ssp_task.task_attr & 7);
 	memcpy(ssp_cmd.ssp_iu.cdb, task->ssp_task.cmd->cmnd,
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index d8222c442640..d77db53cbd8d 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -564,7 +564,6 @@ enum task_attribute {
 
 struct sas_ssp_task {
 	u8     LUN[8];
-	u8     enable_first_burst:1;
 	enum   task_attribute task_attr;
 	u8     task_prio;
 	struct scsi_cmnd *cmd;
-- 
2.31.1


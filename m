Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A26E7B2F53
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 11:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjI2Jhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 05:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjI2Jhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 05:37:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9202D1AB;
        Fri, 29 Sep 2023 02:37:45 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SK9989018488;
        Fri, 29 Sep 2023 09:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=BZV751yxhG1lIZ7f1CzDKLnId373epCxiSLnW2xa5ZQ=;
 b=FOp1Yzg8AKNVnT0D6wQBe3vKih/7VuoeIqnHh+yatxQHiahWMIxfnr7aGD1t/N7xfZQ7
 j6xWssI80fsSTLjJia7/bdW6meoYR5oxq3rptj3F03g7oNexHi2R9Z9S5n2lIgbVY9EF
 Qp61K+5odpLYvolIYyyl7TbgCx6ySZgpgqtuiHl7HDadptltcnIiqhpRs6P0X5/pnUy+
 HkW1JfUwLbWbV39pZbJgUKNbzpLfrVdGXDAq6zek3SSVwDK65+mbG11wYANtUDzQOTzZ
 ur1CnqgELlu8JeTXYQlTXl4+s4GO8rD1Q60SNIQHayhZv65qRK9/Wyb8NYgn553xtYlT eg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pt3xc54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 09:37:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38T7e5nk004786;
        Fri, 29 Sep 2023 09:37:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfbgbar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 09:37:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G68ucksqvFSRa1nq1JLrOp7/uVrZeNDNDykjGt43GtWbk4aOnG9YGfahUdFRUdD3jlogqvgfSBan+KICc6/P/mZTTUNaJ8K0koNkIAyGx8qYmYbelTTUJKxS9oyCIk7GqpEaMu4Lv6whFOXrf++yxFrAMwAy+78T+TBMC71fMskF2q9nlwupCfRVTr3+65lrp5lzqZeMh8vVZTS0PaC8X5+2hSJluUqYitWEwC9MFMnIjk0v+Ooe5rlnRcsNqPsief8RZZmgEKlT+1Nlx78QuPHBfkCwguNLbQ64XloLn1ksx9be4xbqhgwR1nqzdZdhBCG0/+kRE3VZNtn6yC2PeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZV751yxhG1lIZ7f1CzDKLnId373epCxiSLnW2xa5ZQ=;
 b=emBLshDKnGUG9zRqivoOOC3k09qSh4KIiOmhsEGUYxjJuZ2pAt1UGA9UH6+T0OPKWP6ugDKvQHuqlxgX/IDIiUcRxHx8h2HWJHAgk24fA7lLIxt+SkzbyjsWyUJEYFg8QgIPI5Wmeo4FnMwucYQl+rOjmtksmfcqH5Gr+llH6p5YD+RSl2t8xsuG6e2n3jQpxazgwGBAO3u24f2S9wv5CPCqDEbrlThKqmcE4EJ5kHiOh1zZ8l/ehUtDtI+hkXmGBGwm1/E3YiveAQQkS2ZaHt6XSuecKOmUlcd2BYKHP5vimu17Xd4qJNjjHmi2dwNs2aIHQYZqk2aIHie7eryBDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZV751yxhG1lIZ7f1CzDKLnId373epCxiSLnW2xa5ZQ=;
 b=X2ED0XB235hlHp8gVY9NgONtYrk/ttq9bE5fcjMwKHiaLghAPbi3qJHxS2z9aq8/VBGUkdHpJMsLbuoCYF8aviAqhI73PMMfogI/70irSqaSPO86A4iid1r8QeT1V6JabudewFlOxYHBy1fGo0KrDrR+ni7OMzmu5OGJdYCMc4w=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB7197.namprd10.prod.outlook.com (2603:10b6:208:3f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 09:37:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 09:37:36 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     martin.petersen@oracle.com, djwong@kernel.org, david@fromorbit.com,
        himanshu.madhani@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 0/4] man2: Document RWF_ATOMIC
Date:   Fri, 29 Sep 2023 09:37:13 +0000
Message-Id: <20230929093717.2972367-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0083.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eb45829-af03-4b0d-5557-08dbc0cfb736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: biS7RDLU5XFZ5hQ+vFHKb9SdE2FswWaPbiai3USncsmfGsIi2uoa+3B5p3vkTrU+nvs+32PXJu6A4oPh2m675Kq7FjD36a50BsQGXVjTTGKcdTbNausD47vC8bl21jKux7g86Aal4AQgrUA+L74Stx9flqNweEDFJ5mvNewT6KxkKnQP8DhITY0U82z6uF4nlMKp1XYkImDzBejz2Z882qrh5L08FnksngElCa607gZ+C6ekeGwoPCwqqBFy1U3289TIdXI+1/jGpPEeRlK/gApS/tJX9skJGcS9hJkxbBOE4Wdo79ftiZAorBJMn05txnjdt9v+2FxXF+9j1H62FZqsc/y2AAcNH7PnHCJRPyhICk3FUPZYlZUjicMy9hTqB48CanyN5QqykwmO+kOCVz4ko7bW72dfFXY5HbVTYEEhaL2G7amfCOyY+ziX5TDMUNwjAAaoWpgMqaapUiHQ/BLHXx326MlEzNYBHZB8ZHUkS96dFrOXLtAkqfLfz1V83assXfA3sDS7U5DjVbpVNCuqI+dvF/l0WmhGwklRi1SfoEXQIjIvHUlm5xWo5pY3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(2906002)(86362001)(4744005)(103116003)(6506007)(6666004)(6512007)(5660300002)(38100700002)(6486002)(478600001)(36756003)(8676002)(8936002)(4326008)(1076003)(107886003)(2616005)(41300700001)(26005)(66556008)(66946007)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4TC3aFMYG5sx/GLWWCpSHiHkawvZSe6kVIwGHtWdP2i+S/wfET8f7WyUCAkz?=
 =?us-ascii?Q?J+kMZQbaJtBPFSIx/EMQFIMqTBr4McwCbjtjk79WoWur1OzXS6t4n1yyiykh?=
 =?us-ascii?Q?GXiLKcSH+y+YsDu4qSZp1u6tMl9vo3CFz4vDf/F6k8FZAlra4SnY5kE4+jaT?=
 =?us-ascii?Q?YvKsNgyBYK+ckHClaSSkIin0f1kt8ld72Ya4yN6ZkTsz+QJZJLUF+cm3AWCg?=
 =?us-ascii?Q?eWqHVo8nhz7w5m5EJDqEYU6ZuYuzcGtAL5eB/lgE26lGQPsuw7XBNyen7jMO?=
 =?us-ascii?Q?lutztBCgCjpWJDCaIDHji5MaSgYkjsUZgt2RF0G6/kG5I61mTFGJLcejcErh?=
 =?us-ascii?Q?MOl2lesdX3E67EcwFGMSEj7+6HxsFoo7OHEohNS/PGtNxn5TqC/FqUQnYtSY?=
 =?us-ascii?Q?j/0SRKPR6wPNEa68pafI1Hsdu7IC/UR6rCuZyoKTBtQ/+qV7SSt27UVpXwnE?=
 =?us-ascii?Q?azQsbTEQhDs7kkIRiZHXtdrtshbhsrvZETtPACwspmfocqqjJGTIqKrF6mIN?=
 =?us-ascii?Q?lKdA15SHDtRh0jnJ0wQmP92siwJuH9FSlpT6vx+wcnDxRiyYZVj/HG4gWtIW?=
 =?us-ascii?Q?2GYFLfGWt9lsBWPcAKueLGQCODMntWRo2bQ27KtcCS8aEaXKp2l1OpKA/grx?=
 =?us-ascii?Q?lUYkb48sKUQ40csTUo4pgcMi8tFKHovn7lGTlSBUUjkWMZgPoEwymrv2Of6b?=
 =?us-ascii?Q?NVu0w0mgE4IXll7lP8SLE0kb47hwxuYKb5rytpc3CYZQbk/VdqW3dj5lwkIK?=
 =?us-ascii?Q?7KaWBJlTccDRe0LH4DeNHHSIUL/TDPINjMpQDAQl4QM75QSAtpr3zyjQwtTg?=
 =?us-ascii?Q?SLmfF2qJgaO5TED5Z8+3ibT2EFVNHKWRXBkNG0jYf1ygJSLQIGytwAoTcs4l?=
 =?us-ascii?Q?LDaWqJCw9pzqdXDBWggbB+Exu4+nDsTGQ3HlM/5416gGz08rgdWTR55pxVjq?=
 =?us-ascii?Q?7Yf83WVdH+j2ySdNVH9jyj4HgaX62cxuGo+xDXBKK2ar9iHu9FMhp3A5rILB?=
 =?us-ascii?Q?FfCqNcMABsyP4gdzCQk+dKsFCFywsDyMJXIAiDLKqtRMiPhmKL0XOfM1zIBr?=
 =?us-ascii?Q?RWfh+3VIQZjg5dQpgJ7s7uPc9mJ7JY/Pl9SN7pHeOBfKd1dKNqm6VqsFNjrZ?=
 =?us-ascii?Q?fQAPxA2w/JOO5fYsGPFGu0fxjier6OvqJMju+TdefFkre8PWggzTJzBGQrcB?=
 =?us-ascii?Q?CW6u8IhcttQ1PuOH4ZNA5epcD/Lox6y8BaEIP/Z+kHnWFQRZ1Z7cHocsGFan?=
 =?us-ascii?Q?gTZMC0a6jenUaRE90ZVM+UwMdOHa+gs/FscEnVKEKFJyY2N0TS5UY6E8xlcv?=
 =?us-ascii?Q?NVpLHCtZ/Xot0kKocZpJe0BO0xaH4xu0qQNtrCucjMryKOIbiyFfk/vT+K5G?=
 =?us-ascii?Q?tbLAsUStffdEUqXedcij8on7XfxuwyfQzpeqHTujDKIW9cwlJZiZpdRFQRyt?=
 =?us-ascii?Q?CYyhZNDpN89aTfjz8igdIHTSP4dpuJOh1h1Qt7iscP/7/qN5SxlOEd4Iu+v0?=
 =?us-ascii?Q?xuUUNMMr7T+O85YJvRO/kR1GD2QnUTaBQR+jduP59VqFLH9jhR5rQY4cU1+R?=
 =?us-ascii?Q?IAcGk5Le9xBOEoE2hEU2xrknVxWTaVxdVNqJwKUY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2X3FiOq2hbM1Ajn71Qx+0Tmo/e+jB3Ux0rJ4xFKvdlpYB9tDF+sJjByAXj53AJmgq8Tby3qU9UOKiiv2gpsqzkiGr/RxzkCU9vQ42Npl1PJtkQooNil3+V9sVjxC8+yNtAUlH6vupI53zleshCbgmesWVN90QDAQ8LJA6+p/qkqa8/7MG3jMAUsPcY0ELRSnGcmmgMpJT6OskX0mzPFFSWiN1RI8PiJtjgpwY7ce+NASXBqfNXYvXwQNldELoh5zNY0861zWCG5b+62Qh51hy0eEDBGh1owdfiZUJjKIRX+XLM1VLbjTDhj0P1A/FOlTcNFG3sajlDKl8ZGRwqDSC6KHq6qW0YmQQhpMYrOu27H/MFzr+D2SiRHBZb0bYGeWOOCxnJqTVk/N5di1/wp2eGLUAJdqWjKv6wmvl2V/yM0BDsO2yp7+bqzxIFhyQjKVGXPhIlNaqQd+aHPSJ5iCTLZp7g235aqCmgZf5HeeTY4oCk8S5wtOKINim+2Kp2qBevRcJWK+SvSWKqFaaXKfI8ZOT/fjFWcgsUDCJiTFmUDwwcn0767C0H7qjz7+lc0ddJMFf9LJ1vdmLfK8uPD/XeII3lzG/ln3oa0g52mbXg1+l67pB3R7aLXxQ0ibxjHsWevQSM9KyC7WGsDFe+uYcWYYiTN8REhipZvbr4lk9da6+83vlOKSN7bDyhTWSSpEmBfIw+pzWPeLeJE5so5onK745dCGbtL4mXgDzBE1EeHY2PnEkcrhg33iA8QmLeVRCcVAEAlZUHZICXOwYuVDnfEKw2ViVK4b01/DGpkV3zc+Vm8uRiUyUmf3RY49mPdlKYEU0SDPG4uBMHf7DNYLww==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb45829-af03-4b0d-5557-08dbc0cfb736
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 09:37:36.9236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzNl66cwQi3eiq8PWxppMRetxELgc/V3cL9pS4kmZ9Pz5zKag/tfEsGesBgH2IOvcTzcPXzAfa/7A0ro2Pe9tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7197
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_07,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=827 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290082
X-Proofpoint-ORIG-GUID: Def4D1t3hamAyEISlqvxtnwARHLjTpZ8
X-Proofpoint-GUID: Def4D1t3hamAyEISlqvxtnwARHLjTpZ8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document RWF_ATOMIC flag for pwritev2().

RWF_ATOMIC atomic is used for enabling torn-write protection.

We use RWF_ATOMIC as this is legacy name for similar feature proposed in
the past.

Himanshu Madhani (2):
  statx.2: Document STATX_WRITE_ATOMIC
  readv.2: Document RWF_ATOMIC flag

John Garry (2):
  man2/open.2: Document RWF_ATOMIC
  io_submit.2: Document RWF_ATOMIC

 man2/io_submit.2 |  5 +++++
 man2/open.2      | 13 +++++++++++++
 man2/readv.2     | 45 +++++++++++++++++++++++++++++++++++++++++++++
 man2/statx.2     | 18 ++++++++++++++++++
 4 files changed, 81 insertions(+)

-- 
2.31.1


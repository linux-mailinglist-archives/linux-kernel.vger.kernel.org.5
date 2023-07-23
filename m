Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A0875E4A0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 21:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjGWTuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 15:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGWTuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 15:50:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8E6ED;
        Sun, 23 Jul 2023 12:50:06 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36NINpxD011483;
        Sun, 23 Jul 2023 19:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=WLTrlboy+zGjSwlUWkGAWvIKVwA/nlrrCOoQ9pgFL50=;
 b=leNId/gRXgDrczMEy8mT8U7leRJTTDYw/+fzxRgt+82ayegYxjRAyQGV9PXnhPjdjXBc
 tkRbc35ealxKwlnQ5gU6zlS2pY2kTknzDsYPJe5QyhAqmUiSrhg5U1be93QJNOT+VHDb
 zK2czXxx9+mgRqrukS89HBmMQxxpBnV7HHRHDoEolmW+y6MLblkyHdBL1LNK8FXWpiaJ
 zZFpZcVecndfwW3OwwgHAM7FM5+b+EDlKFD2LAZxf92xSl2TokBjfmD2p1eDpgV2nNld
 xT7CbULV5ZrB4vg6CKdBrqrBmBu9nI21EtJdWS/xsyJkmRm8H1MQDnCTUfe9CkP4Htnb PA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s070asfj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jul 2023 19:50:02 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36NEj5Mg027537;
        Sun, 23 Jul 2023 19:50:01 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j8xf3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jul 2023 19:50:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A112sD7sPvlALyjScdfHrc5mlAS0NP8PCjLXy72j/VttbbfxNqR5rovjHzgiKkCVi9DllO0s1Nr9uDjpq/dlfubmmYMbtPvb1sBBJw5Le+c6JE4GF+AwBgsjAF23vfBnjJ/0HCEqd9Q6iK3VbhzxUNAeGrbDQuhx15Kj8lSYXvwwS8QOUr6EfFcmvwGtZ4RC6Cgh3GqJNrfWLJxdwCpKvLs0anAPcY419PKIIK49tEonum5lK6UGA3QMNZ79WX7FbencnpWw1Z+gR3JRQfQxnhWFhiwd5i2g1FQMgD7axaKnoQ6IjH/KJI+TtU+nxDcBpc8TXWi5zaVFkQxEZC4uEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLTrlboy+zGjSwlUWkGAWvIKVwA/nlrrCOoQ9pgFL50=;
 b=Oz8uaRKhVh42+cnzSijrVRG5icuqfK1IGgggId6JDngqL5uav+QzTksda6B+PmPFqkkop/ruCmCv9wr5zG2btPLsZ7KxMGnffUoK3GSLVU8/jMTCaKiFQXVHdfTMW+u4I0g0E/gnfVzwaUvFqavYO6zrOvUNOs4xojL9UgqODLtMXQxvrA+GMf6uXbU3PJKla8XBFUYdGlAWvZEnXEeqgffyRyI+lXka2I22W0UQQycHyUZhrp9c+k9ZYvgsrasuOobtcXMHSqq4rVFWLrxXmR9fRqPcqPKtQjF9lSdvtqwMUhwLcRl8s21LNKgGY/RAeN+HUzmJR02FQn/dot2Y/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLTrlboy+zGjSwlUWkGAWvIKVwA/nlrrCOoQ9pgFL50=;
 b=TOAu8uWW3vLtlic8HnJrjS7f4LIhWgW7ivyW8QtjBGk70WVHzM6Oz/mdU8QVIai+F2rxHtnUKh/4O3E65lqi+Ba7ugo/qONPCufMw+5dfRo7rOEOvKRmsX5dji/ppJo/5uY6ZnpzUlbcUi5qmnZTnA4qi9F2OriqiOFYIm/EMic=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by MW4PR10MB6324.namprd10.prod.outlook.com (2603:10b6:303:1ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sun, 23 Jul
 2023 19:49:59 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::f82a:5d0:624d:9536]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::f82a:5d0:624d:9536%7]) with mapi id 15.20.6609.030; Sun, 23 Jul 2023
 19:49:59 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        devicetree@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: Explicitly include correct DT includes
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq18rb65rxf.fsf@ca-mkp.ca.oracle.com>
References: <20230714175052.4066150-1-robh@kernel.org>
Date:   Sun, 23 Jul 2023 15:49:56 -0400
In-Reply-To: <20230714175052.4066150-1-robh@kernel.org> (Rob Herring's message
        of "Fri, 14 Jul 2023 11:50:52 -0600")
Content-Type: text/plain
X-ClientProxiedBy: SN6PR01CA0012.prod.exchangelabs.com (2603:10b6:805:b6::25)
 To CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|MW4PR10MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: 52f04fe3-6c10-45da-8c16-08db8bb5ff3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g/obH0n4y4rg1dhuUo64kMViQTcF0vus9X3Uxz9IzPKxGd1zsj4Br4Z5LR/enSpAc/k602v9S50q+4QFJWve0k7O/olQ+ZTJpHG0hb1C1gQDlGRkEAfQd7ltWDe0qvcgBSJT9JsTbVOBnJrFgWOg6zpLkhraL++S/flOw+8+h1AXMjf7uPcCjPGKmixtqZOamjdlFs8t+2UUInXVs0e0WVaKJ2IQwILePfSiEjoRAfWwMQP6SOMegDo6GKJ93o/lzjIkfzkixlLyATdfuDlCYh0u8fl3wpor7q3Rm9QdW0undRwuwokddT/Fss3LqyPdHyIRf2R9eWvsEg9VWy2Qcc3erpkB/PpdS330W2bz2govky6+d8p4oTVK7El+5AUs3GfcVQMBbuxATIbjc/qma1aHZWT7E1zZH5zzEFD0+zkpyS5eEDbJKfKvq1BXhraupdonBbVFnaueg/GWkqql0lhW/4Xdf3SanXOc/iUWLhrycM3wdu661jJbmheFE/ARs9QJ/BgfURPdiYUZy8Zlxo4o8n/OYgGkppkw0BpnlqqcMI4xbAzwBb0jvzglzhrw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199021)(8936002)(5660300002)(8676002)(4744005)(41300700001)(316002)(2906002)(66476007)(66556008)(66946007)(26005)(6506007)(38100700002)(6512007)(54906003)(83380400001)(86362001)(6486002)(4326008)(6916009)(36916002)(478600001)(6666004)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HO3ZOP3tOA0hTwN28wQVzgYg1cEyV7eL/20WYl/60tXK0qsPoD34nEpVvdTI?=
 =?us-ascii?Q?WR2Vj5+JRy8LZ4uh1hIUcJ4HcFWUB+u++gMzTdBlZ9WyLa+pSRJA0PPkNWWq?=
 =?us-ascii?Q?K9qSIFROQXSJS493/mDzebHIKx6chwxsUkwbnqRvyAvga3mX67edUApLsGHR?=
 =?us-ascii?Q?ZUCOvVWyHdj93dXXTlHz3wjS6gawmJKzPR3Tlas4R15IS0JxN7onicBIcZWa?=
 =?us-ascii?Q?Sb6Z9HRdweT90u0r2rZPiMldBl9buNtGiPwxWym2rOolWuFhRp1BsXR27E1I?=
 =?us-ascii?Q?QKber89WiaaaGimdsPhH0W2rmREP5tQbR8nXj4Jd3npTI21u4v9bT8xCZ7YD?=
 =?us-ascii?Q?eNdPwDgEB+UQixkvIKi1C9ti9Tae0doPgwgdbOu3Ij8UJYq6Sgdw0grIDfVb?=
 =?us-ascii?Q?i6ToPk+ZmMpDnry3L9f5Y7uw81hRzfb6Qo9XLrk0wwCKFEmBnS64/QyvLnz1?=
 =?us-ascii?Q?4Apri21lvRc8CzASCwroy2g56aXo5COJyZSp+xwaTF9SbyUpJZJ3Ui/wSJeh?=
 =?us-ascii?Q?C8yDYXvtw3lBLp+yGEcv0AXK+bdE0YS7SOi4spH5kefxX1f+8HF4h+ySLnmf?=
 =?us-ascii?Q?iKLKN48lXgIyud5YhO2F68o1wn/grCifLkPrlMp9yvhf0QP2le2wsfR8a2Y6?=
 =?us-ascii?Q?Cx8RAS5ysG9IPbmhYIkfxEskiedZKEVQbL35xgBC5mWOr4FcJRkEhWFsoJm4?=
 =?us-ascii?Q?lUT3f+mSHxE7AMbi00RogaKelvaw4UYB7B5CmOrN8gag+jzORRLDYv4KbZ+i?=
 =?us-ascii?Q?hsGkItKK7BRKbIdet/B8uSKbYqfD2atdzI9esKtnHdj8uDZQHA0Yr5RXsDVK?=
 =?us-ascii?Q?Vllidc/qKLspt5QBZiySZspa3lxBdpESnPnh1MWVb/PjTyw+x1SNboK5VKiU?=
 =?us-ascii?Q?D/7lPW7PJrk807Xd/xsglJQlf8Vml6aym+P3azWP4Ec25ehdynJmaO8d7yYe?=
 =?us-ascii?Q?uimEL0kj1yQvJvj44PU91LglqAxgrCM4pfHYhL/RhInPMa3q7CT3QkLbHMFV?=
 =?us-ascii?Q?457EXPywY9+Mk3dyOnj00lFg16EGaE8lFR+PCZq10RsrWTSz5o+GYNWBCRs9?=
 =?us-ascii?Q?930mhtuhAoE8pDLDE1cKz6EOKBKeX49f1/7dGiLuo4xRUjGrZtc6+ZmhtKvF?=
 =?us-ascii?Q?ENIbjPw9LSx43c08ZUM4xR/n5XJb11eW9pNnh+F0XbrpDe436L7k6pbaMTP6?=
 =?us-ascii?Q?m92fzzplZviWiki5voheLux3X4oP+dHYONVctOeeCt6B4++IErwIacSySBdV?=
 =?us-ascii?Q?4Krupk/qZCxMqZaRcSElcT4MkYcojPr9UZHG/aTVoYPxShVtjmPTbhIdcBff?=
 =?us-ascii?Q?+1+eW8JDKQoAmX0bUfOCejoMzTPFd9pF+5nBxTNDuaOIjfzuTz0Mr2kqVYzc?=
 =?us-ascii?Q?E3jpZ8XJVJGFYisNg+s/sj71X+GrVqN4GIzASQgD/qVUam/xEwyWDTv2dc19?=
 =?us-ascii?Q?nToHWAbnJbtRFgOJ7T37oMhlTQbjvwWmf16WQo7tut56ysGWTGxDvSNGBx/e?=
 =?us-ascii?Q?q9pUvAjaf20PKeerDiK7wEfcrczond0Zb1HX0pc373n5Q1iFAiTJZbL8kwrr?=
 =?us-ascii?Q?C457m+yndnxiLjRXsDTpNUshJcWK1aKCFpaEwbLhDIffAS/IGJnl8VOKDCyE?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wn5Wt7D2MAYYjBnE9iulrN2iHhcfOf8YvXYc5Fe6lawYR/66T4q6PDk9ny2cIWbS6RgQjh/Hqfe6FVqghEbBhJJYtQchVPydthWnXw66q3HLdXZy4Gc/DSwT83pzcmcWAN5pfUlNyhGUDEuBpAX88zQ6L8mraAzpB6yUWOWKKg9ssBRhFyCVJ9U+pg1RINOsAK3bAE/7oKHipba0YiCyvwSM8/g+xGifZy7lUB618WSeKPLJH0XkpBnbwmpfNciSWiplXMAiT1ztdvaM+NdNBKAtTYMskQ8NJnsuPT/GAWRCgukH8TCkFAZA3Kp9IITJ8rHcew5cTpHWSfIYaxqtdRYlXR9a0k+P0B7id6GSlIgCB9khIKTSgoRgTZnRuoCCP577fQf6BpQ8cLQo0PnyVt8ynRNE9nX7jwxBqCaalh6LP6bKwg+fi7/hVIc35fNC4ASk9BE9hZSdgRTK11uLTnwc80fQjzIeK/V9tGH2bO6hjj9cNb7EKBaah7qA/FcfI8OCW6j9myl8gHE6ndgmmvsqAUXo51y6AVWKDzyLlIGKBTLp041xlcTX75GuHJvCZfsO1Z0O22fjYsskOw+YngC/QPx/SsNB14vSLdJCAWi2N/2NaoGFmFl+1ygerlqIgEhxpTSYWIofK6nx1nMkoBndKzddkEFDw9Wa/pgUsgnlpYz84Flp2swNdfKFWJkww2Y9HcR/mgh32Ymc/iTnHiU824aVFJHhqOIYJKLh+fEPdW5C3RkeZ3t2G6VUtwbRi/hl8Rz2qgobwZQ8b61+WlJK/s5mnTTkB3ITqZ37CEYGDEAyLWrzd5Kc6MMMUR8MDPRjWeeO83b/1oDrJpytBQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f04fe3-6c10-45da-8c16-08db8bb5ff3d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 19:49:59.1420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QGhSEbf28O5qa8V7pskvYyLrWnYcWPCNML7x5Qhc0VUoYLsULiER+dY9dOcvMfIxmKejE/dkHQA7F7XBgVD2VpEtPxoy0e1ysfV8ogo1gw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6324
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-23_08,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=655 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307230186
X-Proofpoint-GUID: scWuhvYwbBoBk09kYqc2TBnGE0AgnRFj
X-Proofpoint-ORIG-GUID: scWuhvYwbBoBk09kYqc2TBnGE0AgnRFj
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Rob,

> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform
> bus. As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those
> include files used throughout the tree. In order to detangle these
> headers and replace the implicit includes with struct declarations,
> users need to explicitly include the correct includes.

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

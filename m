Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1332A752E7C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 03:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjGNBQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 21:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjGNBQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:16:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FF22D5D;
        Thu, 13 Jul 2023 18:16:47 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DJED6K016839;
        Fri, 14 Jul 2023 01:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=TT4BnDnSvXwXpP6DlS/8TkscDMWsPCJXdePlhtMpK3c=;
 b=IkbypWRHAheu2jyVaLjlGPeCAqdgojRsSR9g059VWbo/7fHVLgIVy0Q6Bv+lZdyuP8HS
 14Q95ra+irwp3J7+jvOszLDxsgAqRLbqau9WD7IfuCTEl676uP1n/3VUYAmMUs2OR1xJ
 nZC0epuOYL6RupTB8UFpfwmI4Sdp6UzC92/Ag7Vaih1MK5NHKrrR13+jflhNLyrPi9/c
 SsDHd6D3XV1VrwtMAw1MkVNmjC7dR3Dgek5BKVandhgeLVdPTpK2UYGT974H7mfVdB6/
 mwB3uZnsY/rBSNgsddYnlHPLw7nKS4CVEK+ho4aSgX35tR0GDzPjNI/eNzDgPKbmTCu2 FA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rtq8arf2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 01:16:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36DNUZ3a002092;
        Fri, 14 Jul 2023 01:16:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rtpvwcwgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 01:16:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9HfKBTQfXuuxWcACRjPkGHmXVKzwfqH568dRPzsfrRRpBh6hZk8J3GpA07pRuv3uBytz7yTZVEMvG3yaRUoh8On5P8cwpq0ez0Jhq4Gr+UlObnALf70ydG6jxnfjpKXD6gcVof/z8vXflWnoJTfQvCsMnex3tk63uwGBrHUydsZqsSHt2o9rcxjUcfLRrhzuJv0jFDk7mIzaqDwX7lDgGSVygo13KgQilulLOKHYDo6dSvpWCw/gx+ZFqWfLMjmVAxLKni2SfcFFv3QNO/Ha9VdisyuW69Pn2Mtqglgq1WPJnIMUZ3fFQ3rp/9k7WM6ItW7fJFcVwBhbQ00ksg/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TT4BnDnSvXwXpP6DlS/8TkscDMWsPCJXdePlhtMpK3c=;
 b=iy8+dfmXP/prFO96S9l2B9mclVCu2a54CFl/L4Dv7KF+rVZJ4xVsQZDyAcn60S0gBsmsZQ0N8OyVfPsZin0/kNBGCgWaHGvQ/p1Yf+wAzRs07oPf5xhF2P/COOyxYC1nLqvnCuYw5g/+Enh78mN7ed6848NE9mqLGPs7R+z/qiErcn4mnThVDIFuHcmP49FJX07VRedPV9qEGwzintl+yuf9vUloQHYAG0+gwV4J4G5gC1u4XEXuGdjdMuUyb7/QDjaN8VEQApYLimXNCV42WgFhe2g1TLAu+WxcL1H/mXQEL4hXKks8d+WURsurIBYjN6D01OAQu6A27aO4e9Xs7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TT4BnDnSvXwXpP6DlS/8TkscDMWsPCJXdePlhtMpK3c=;
 b=rTFkxjjMpp6vur5Qzc5YlGy9KqdXyxWjUjDVxIuxd9exTOmtXiWZf483ultzJdMiZYtQyhaN4T6z26lQZUfR1HDhxK8Ud5DoH69QrXCN6itsY9nl8cXdoQWKqVrWddvP2l/NLsB5q/ac5iQ5J4WXPrV2HbUE1g7UffRK3G8HJl0=
Received: from MN2PR10MB4157.namprd10.prod.outlook.com (2603:10b6:208:1dc::18)
 by BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 01:16:22 +0000
Received: from MN2PR10MB4157.namprd10.prod.outlook.com
 ([fe80::4f9c:e974:fd62:9b1a]) by MN2PR10MB4157.namprd10.prod.outlook.com
 ([fe80::4f9c:e974:fd62:9b1a%7]) with mapi id 15.20.6588.024; Fri, 14 Jul 2023
 01:16:22 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     zohar@linux.ibm.com
Cc:     dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v3] integrity: Always reference the blacklist keyring with apprasial
Date:   Thu, 13 Jul 2023 21:11:41 -0400
Message-Id: <20230714011141.2288133-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0060.namprd04.prod.outlook.com
 (2603:10b6:806:120::35) To MN2PR10MB4157.namprd10.prod.outlook.com
 (2603:10b6:208:1dc::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4157:EE_|BN0PR10MB5109:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b3f773a-5af8-4232-bf77-08db8407ef7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0K2hYwALO6Un7ofD6mx3Vhd1/5MH3Y0TYOjQt6RTxiwLaPnRvwwcYI9+9sjcGxtwH2YgiY3S57Ecy5wrmdrfxz8yh73mypo887ri90zI18u6RvsncG8+q7J6MYeWcXwc6Young7UNo99D8uRkBSo18+qR3HFODOceBZpZlkxAuTQZhp9MMbFVUAzKTVyqtC5bK57TrPC0MVHs9lGB5XagMyEcj6WLw6hYLS3NgExdyCeCuOZ8NcKKO4B14iqa4hVhFWFpj9Cv7K7t0smUY3T4+s6LF4cNNz2O+1bKd8PANm1C0JkEZYKQRm90ok/DTgSTirPPzrY8d440JbbxrNmVrkkB0al/4iAUDSgjT/stpxxjKifbpuucJ8F70HRFX4L56zPi0VqcvJ3U3mfn8cDE867tHMm2uhH0sbEPdPLNSj0BUcgWY6mxGQJJnWPhOeQoewoFE8I5MlbUX+wMIuWO+LERDEqK+kmc6UBJH46PER1VlGegTd/CZwEv98iaBhLwC0A1vX+bU1OqzvnoDSgeB81v6C83uJ4qirnfoABw8M9SSLi/diGsu+GzggF4bT2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4157.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199021)(6512007)(6486002)(6666004)(83380400001)(186003)(2616005)(36756003)(38100700002)(86362001)(1076003)(6506007)(66476007)(66946007)(66556008)(6916009)(4326008)(44832011)(41300700001)(5660300002)(316002)(8676002)(8936002)(2906002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xz3obSSc3MVUHWZ6AAZ5B9+sBxUEfuqbgjRWrARXDFlR8QekwD+dh7xXtH1G?=
 =?us-ascii?Q?T7U5NCH1B3LS/qAJmOXvuBFDe3EwnghwF5er9LLV9s88b/hC2btgDVm1+KgF?=
 =?us-ascii?Q?IGsBSF2xLCtzTv/Vpfdpz2GBeKzro+dZYUCbvjMy7AcLUNkGrHTuR2nX/rOI?=
 =?us-ascii?Q?BTrfv0wopIq2bleHrbSsS8qaeCRoNYX7PWjV5gHcYj04emCJuuZo19Wr+l2t?=
 =?us-ascii?Q?l4mKvtShONMef/59cpTl9yfVcrTnMOnsHZvj2He2Zo+BMHze1YXctvrHopED?=
 =?us-ascii?Q?ieiUOGsxi1fHYdxUureNCyPJUAKvyKn5L4oB6+ofGSHyaxOGtxq4jKsCt/7Y?=
 =?us-ascii?Q?rPz2KJeGlXegMZNR0VbyRHNFa1kUhiFWVn8euGsYEwd/Q1p2sAFdFp8UPj8h?=
 =?us-ascii?Q?Zk7tBXZzpDJj3f/xz2O+6/l6ucDSspKccjgl48IeiQmgCpiccHKHGwoGQi+M?=
 =?us-ascii?Q?G+uxXoE8xysEDNCxayHWcBRxgOEr2B2H65TTAXlh4CZ2UNbbywIZcfAFqHil?=
 =?us-ascii?Q?a0yZ+1bZQMrmDxu5tTGUkuvzwmwcHjFXEYWTmOGuCc/tR4U5L8HT5cX9wQAf?=
 =?us-ascii?Q?hWu6KPq+jeKgK3z/O+uGjY5d9MwBrgQ0qDU/tKAnHMjQpg7sMXyLllhpuH/B?=
 =?us-ascii?Q?W6QnZ5a18s45Kag55F8S769/HYjsyXC+RIsh252AA64w7mpvGV28dDJp2m+W?=
 =?us-ascii?Q?7zFCmwhVsvNEVEn4bVC+LgF80evIELUInB7ucHTd0oAwxyNV8ICh4tDzZdet?=
 =?us-ascii?Q?/9GSYnXJH03yyV7GUwwTuLKuyHySgEpv4+lreZ0PkKn7vh4SQnfKbZHVfjQV?=
 =?us-ascii?Q?fw2OXFqFbOY8bV41m5Gx0UdrxYz1M/GfmIelGM+kFe32W6KK14r/WU+TZtEi?=
 =?us-ascii?Q?5TOO/Tsnq6kwMQ4NOQC1IXtYLFIMGSoKOdTTNNcY/o5I4Gp/WjySkF21pHEt?=
 =?us-ascii?Q?zcAZtPb9Ih2qhIwcJ83tzwzhE/F+RJymjycLStYNe0C8pEa4m2lkMdVAjPYr?=
 =?us-ascii?Q?zfsKTpM3bLzo8HD5zLrtYfUv+VRtjDDc7uekexQLs5nB/mE0zDxnPzSzuEUO?=
 =?us-ascii?Q?KWkML/bnP6p4hc6tXl9q+RJyyJBWvfZ8LMNkCntaKCJf9RcMFhHpjfvFsD0P?=
 =?us-ascii?Q?69YwTIEJPWwy0dipsxC75lRU/jGxNIDBj+qdAWOQkYbouJbv/VrgYNoOifQf?=
 =?us-ascii?Q?ewHmB/jhTpjes7xBLWm3b5XAyPAymjvQuVnRgmpNi+hYqtDQcRH91gRQOHZk?=
 =?us-ascii?Q?XEDaFbZztzR8xHxm/z8ZHpOgyfWge0ur6D2s84HPZMqMGDH1rX4x3lwyTD21?=
 =?us-ascii?Q?n9X7r+Nufy5G6dc2s2eViKQe2ZUVmuBehW5wT6c/yRDy1L3ILVFfSTSZcT96?=
 =?us-ascii?Q?J3q5r7djx018GAFMaAxWreRi7/B8rn0WWEPPtQWZZBkExpR1vSvirdUoCwEF?=
 =?us-ascii?Q?Ug+yLaBpQh8PufRAiHhUQRPcr4wHZbBmjZJKbMZiUWF+BWGDHA/zsJwOLrHt?=
 =?us-ascii?Q?p3qI91w2pFjPah5k3nE2ygnWmgnOaVAOsGJco2zqQ3gpBloYltQ77DfvZH2m?=
 =?us-ascii?Q?VoAcptACczsfMe6FTI+lbqliI4p2VYGBfCaTf7nF6e1nzQhODhKkO+MPJyRz?=
 =?us-ascii?Q?8AHq++hYn3L8DwiuRuf4Mu8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?DP3b2UvAgmSvh/F8K83P+yvNXGFVHKdkWpAJb+VEoFhgLKcf897smfxaThfO?=
 =?us-ascii?Q?RFdiQdy8GChj6cx2s/+npRQ7GJ8QJpwj2BOrRmxb/khPQTweeUBA7ufhQG8F?=
 =?us-ascii?Q?c/JMcn85rXAt765bh03INaPgasIzNoBiRerrVMOwTCb4hscuBpjkW5kDF8WP?=
 =?us-ascii?Q?9qX+x4MBHVYicscdPnoOd9dchx/YG9L7vs5C7Fq5t1fMTDnb7QcIgbS0WG5v?=
 =?us-ascii?Q?ESpH9NEoH0egX3fnU3GixkEgMgLhNHcNnFyqroc1lO2NTlKGdDIjl1jSGCSW?=
 =?us-ascii?Q?c3QeUZvLOTBf6C63KGcEbhxrE+ofgqeLBKEQp0rWk6iVT23Uou151WGY6jHM?=
 =?us-ascii?Q?K+7B41ZbNxLGkuI+s2z14E3++rpMOzWafsDiAp2LIsvUkI0ulBcTI/hVCm2e?=
 =?us-ascii?Q?r9Sl9P68e0I997zCuOyBq/olq4L7ApAv1ccX+Um0pDPzlPkGUNx3qP2EVMpz?=
 =?us-ascii?Q?KxT3hGl1GIUO/oS6QmQeV0ijxGshysKxjd0bQHqcISn4yDWZKratk4QN4GYJ?=
 =?us-ascii?Q?gC8jWvMBhsV3hJGqzxqsAqzw85VNuQH9qPtJgX0K4CAQ2KpvNVPvpU7cF1ik?=
 =?us-ascii?Q?6A95Yos8sYZ15RKKGhIVCFcPTLLb4TLDpeHo721uS0SONrzAK6N3UfGkDuwJ?=
 =?us-ascii?Q?zoSTeuN7eohWHPbeFCF3WGY4hHaVatbL9UTyvg7HVVLWkd/ISIzXcwyUK1QX?=
 =?us-ascii?Q?Ro9fpCUX2TI54gtwS64ydi8Ic1p4gXXplg9Qw+FGw8yvrSu4lhSLi8zhpa95?=
 =?us-ascii?Q?r1JobGRqJMneBIbPmkmGqLOdJnGeC4Z5X9/yEqbE/L5pA15l8CNHxXyoTmqc?=
 =?us-ascii?Q?xgPO2ISkmWdH+GRf/yosJisLAN7qF0DL5qnri3pOOikAR7/upymFlRKk/aaM?=
 =?us-ascii?Q?c3w/1iDplk4P2078m2IYrq1NMQXAaFMiPfJrQQhSBZ2Qmu9Shbg8YJVNqqeX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3f773a-5af8-4232-bf77-08db8407ef7f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4157.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 01:16:22.6568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pReqSOPWxSU780dbcjvkFSk7HvbK4diaVEJV+4pnpLCuddKzLDFyetxxS3IS/DY/u9LF71lkXcrVJdwtUlJhVl9p68g8MFP6HiM02HgdmIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5109
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_12,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307140009
X-Proofpoint-GUID: fmAf3xw7LDOQhxg1Y6rl0xS441rj_2yi
X-Proofpoint-ORIG-GUID: fmAf3xw7LDOQhxg1Y6rl0xS441rj_2yi
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 273df864cf746 ("ima: Check against blacklisted hashes for files with
modsig") introduced an appraise_flag option for referencing the blacklist
keyring.  Any matching binary found on this keyring fails signature
validation. This flag only works with module appended signatures.

An important part of a PKI infrastructure is to have the ability to do
revocation at a later time should a vulnerability be found.  Expand the
revocation flag usage to all appraisal functions. The flag is now
enabled by default. Setting the flag with an IMA policy has been
deprecated. Without a revocation capability like this in place, only
authenticity can be maintained. With this change, integrity can now be
achieved with digital signature based IMA appraisal.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v3 changes:
  No longer display appraise_flag=check_blacklist in the policy
v2 changes:
  Update the "case Opt_apprase_flag"
  Removed "appraise_flag=" in the powerpc arch specific policy rules
---
 Documentation/ABI/testing/ima_policy  |  6 +++---
 arch/powerpc/kernel/ima_arch.c        |  8 ++++----
 security/integrity/ima/ima_appraise.c | 12 +++++++-----
 security/integrity/ima/ima_policy.c   | 17 +++++------------
 4 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 49db0ff288e5..a712c396f6e9 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -57,9 +57,9 @@ Description:
 				stored in security.ima xattr. Requires
 				specifying "digest_type=verity" first.)
 
-			appraise_flag:= [check_blacklist]
-			Currently, blacklist check is only for files signed with appended
-			signature.
+			appraise_flag:= [check_blacklist] (deprecated)
+			Setting the check_blacklist flag is no longer necessary.
+			All apprasial functions set it by default.
 			digest_type:= verity
 			    Require fs-verity's file digest instead of the
 			    regular IMA file hash.
diff --git a/arch/powerpc/kernel/ima_arch.c b/arch/powerpc/kernel/ima_arch.c
index 957abd592075..b7029beed847 100644
--- a/arch/powerpc/kernel/ima_arch.c
+++ b/arch/powerpc/kernel/ima_arch.c
@@ -23,9 +23,9 @@ bool arch_ima_get_secureboot(void)
  * is not enabled.
  */
 static const char *const secure_rules[] = {
-	"appraise func=KEXEC_KERNEL_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
+	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
 #ifndef CONFIG_MODULE_SIG
-	"appraise func=MODULE_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
+	"appraise func=MODULE_CHECK appraise_type=imasig|modsig",
 #endif
 	NULL
 };
@@ -49,9 +49,9 @@ static const char *const trusted_rules[] = {
 static const char *const secure_and_trusted_rules[] = {
 	"measure func=KEXEC_KERNEL_CHECK template=ima-modsig",
 	"measure func=MODULE_CHECK template=ima-modsig",
-	"appraise func=KEXEC_KERNEL_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
+	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig|modsig",
 #ifndef CONFIG_MODULE_SIG
-	"appraise func=MODULE_CHECK appraise_flag=check_blacklist appraise_type=imasig|modsig",
+	"appraise func=MODULE_CHECK appraise_type=imasig|modsig",
 #endif
 	NULL
 };
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 491c1aca0b1c..870dde67707b 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -458,11 +458,13 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
 		ima_get_modsig_digest(modsig, &hash_algo, &digest, &digestsize);
 
 		rc = is_binary_blacklisted(digest, digestsize);
-		if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
-			process_buffer_measurement(&nop_mnt_idmap, NULL, digest, digestsize,
-						   "blacklisted-hash", NONE,
-						   pcr, NULL, false, NULL, 0);
-	}
+	} else if (iint->flags & IMA_DIGSIG_REQUIRED && iint->ima_hash)
+		rc = is_binary_blacklisted(iint->ima_hash->digest, iint->ima_hash->length);
+
+	if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
+		process_buffer_measurement(&nop_mnt_idmap, NULL, digest, digestsize,
+					   "blacklisted-hash", NONE,
+					   pcr, NULL, false, NULL, 0);
 
 	return rc;
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index c9b3bd8f1bb9..69452b79686b 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1280,7 +1280,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 				     IMA_FSNAME | IMA_GID | IMA_EGID |
 				     IMA_FGROUP | IMA_DIGSIG_REQUIRED |
 				     IMA_PERMIT_DIRECTIO | IMA_VALIDATE_ALGOS |
-				     IMA_VERITY_REQUIRED))
+				     IMA_CHECK_BLACKLIST | IMA_VERITY_REQUIRED))
 			return false;
 
 		break;
@@ -1355,7 +1355,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 
 	/* Ensure that combinations of flags are compatible with each other */
 	if (entry->flags & IMA_CHECK_BLACKLIST &&
-	    !(entry->flags & IMA_MODSIG_ALLOWED))
+	    !(entry->flags & IMA_DIGSIG_REQUIRED))
 		return false;
 
 	/*
@@ -1803,11 +1803,11 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				if (entry->flags & IMA_VERITY_REQUIRED)
 					result = -EINVAL;
 				else
-					entry->flags |= IMA_DIGSIG_REQUIRED;
+					entry->flags |= IMA_DIGSIG_REQUIRED | IMA_CHECK_BLACKLIST;
 			} else if (strcmp(args[0].from, "sigv3") == 0) {
 				/* Only fsverity supports sigv3 for now */
 				if (entry->flags & IMA_VERITY_REQUIRED)
-					entry->flags |= IMA_DIGSIG_REQUIRED;
+					entry->flags |= IMA_DIGSIG_REQUIRED | IMA_CHECK_BLACKLIST;
 				else
 					result = -EINVAL;
 			} else if (IS_ENABLED(CONFIG_IMA_APPRAISE_MODSIG) &&
@@ -1816,18 +1816,13 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 					result = -EINVAL;
 				else
 					entry->flags |= IMA_DIGSIG_REQUIRED |
-						IMA_MODSIG_ALLOWED;
+						IMA_MODSIG_ALLOWED | IMA_CHECK_BLACKLIST;
 			} else {
 				result = -EINVAL;
 			}
 			break;
 		case Opt_appraise_flag:
 			ima_log_string(ab, "appraise_flag", args[0].from);
-			if (IS_ENABLED(CONFIG_IMA_APPRAISE_MODSIG) &&
-			    strstr(args[0].from, "blacklist"))
-				entry->flags |= IMA_CHECK_BLACKLIST;
-			else
-				result = -EINVAL;
 			break;
 		case Opt_appraise_algos:
 			ima_log_string(ab, "appraise_algos", args[0].from);
@@ -2271,8 +2266,6 @@ int ima_policy_show(struct seq_file *m, void *v)
 	}
 	if (entry->flags & IMA_VERITY_REQUIRED)
 		seq_puts(m, "digest_type=verity ");
-	if (entry->flags & IMA_CHECK_BLACKLIST)
-		seq_puts(m, "appraise_flag=check_blacklist ");
 	if (entry->flags & IMA_PERMIT_DIRECTIO)
 		seq_puts(m, "permit_directio ");
 	rcu_read_unlock();
-- 
2.39.3


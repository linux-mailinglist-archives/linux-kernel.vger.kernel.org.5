Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D977B238F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjI1RRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjI1RRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:17:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC201BC;
        Thu, 28 Sep 2023 10:17:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SGipbR029126;
        Thu, 28 Sep 2023 17:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=oqBlX4M5rM78uLOs4RJ0kCjmcY3RQeZAYB9nLkDsL14=;
 b=vDICG589HkEcn0XSBzDG7PcsDH8ZR2w1I9VVo0neLcfPFOV0H86oWcK/he1lEj9P99L1
 iHiMTs73VCMMVkAR8JN9hmWK85RO+BfxBIQ72KfEj2OX6oLqEO7XfsGyU6oF+SDJvuft
 BT1VOrMamtbKpjB6vlff/IDBRBMr4bvHhM8DHbD9I2asxhifihVHuwpenRHDbAz2Z6vR
 s2Jfhr3W7pWociaUjVGc6H9YTM0k7p6NmssogN2WMHW6N7CX3mCMpsaAw6wJxA4BOvpm
 /R8RP8tNKSC6kThs3X+N7NCQmEnVKzOTh2NvNkKPGcC/bPLWEwnFIh1SQc/zaYzslVjS Gw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9rjun2as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 17:16:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38SH2E0P014372;
        Thu, 28 Sep 2023 17:16:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfadq9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 17:16:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBeAG2UY/T868/5fP6Y8qyllIA/qi8EBURbaOhE94cTCKQNshAYLBjkXs9kDClhR5wDQzuKBbXdJ8W+1c/2QWNRu1yY/aVACeQUcraSI6gliewaS4sHTPSYcJ+MNZC7+9oWUNx1qS48zS99616cJXBuAZoUz38g+s+K6Z5yLfdN+yV6qJaxK4uzNVUBB9kFaWtEkbxbk9THI0JU1yzrLa4ebBY+En9I8teLBntUjMClQaCG411gKC4UTOuQIr/KWz0J2Fzl28dvOi5TzqRLjIK2WoWwWFYp14EClMiUHrE9iTLjT1kFfQ9mR5yB+81tT00sjg9mkibyP/RvZMIde3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqBlX4M5rM78uLOs4RJ0kCjmcY3RQeZAYB9nLkDsL14=;
 b=oSNRBP9iHVYg63hPlmRCVXjJQFaPI3aM9UQmLE4EJKDap4U7SB9uHTa901tMPKVM0vgJYt1sZnx+oxGeOzqYL6RqIFniBW3m7zJMatMPVUNSgw+qN5MSDBepF08Aiw3h+mx3pCZnbk5gF3p6xz8fA0WqeU+/oKRdHD/25fn6XzNyr+Bdl+VQ/pUl0mfx0UPPgpX07+YOrBfYADNWGTqm+6a0tP4NFhcrmOt3W9Mzlt4ljXZZrlnb7eb5IKyWywJ/1up7OauAGCSiB6ldRwUBgZ17PvnM9uyhVu1S6+W4MwELocfCIRR3XXTWWqRpU7ncmD9Qg25Kw5xeli5kTIvw1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqBlX4M5rM78uLOs4RJ0kCjmcY3RQeZAYB9nLkDsL14=;
 b=gZNLE8qq/wjbfF12q7SoDzZ9BuFCH5/g/OrlXA8KBPJBhSq7VPR7Hi6KUat4Hotm3vWPuKoNY3NZkb47XbyhHd0UtEgKNx7e05buD8QeZRNY8aT1KoHlTlsSM1g0H5etWLOIJaxdt+XEEi4KGbK/akFLJ3jVXrtrfOrsVgihaxw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5273.namprd10.prod.outlook.com (2603:10b6:610:db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 17:16:48 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 17:16:48 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 3/3] mmap: Add clarifying comment to vma_merge() code
Date:   Thu, 28 Sep 2023 13:16:34 -0400
Message-Id: <20230928171634.2245042-4-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230928171634.2245042-1-Liam.Howlett@oracle.com>
References: <20230928171634.2245042-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0089.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::26) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e1d04d3-ca19-4e6b-f084-08dbc046b2ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vIIWUNMO00x1onDjHxGtkiH6QcuN6In0GD8CveMN3E1lpTweRXT4styW1X/BxgJvFL8G0OHIjVw+mbIY3NHf0f0rAV654oKXiWnhlyBQuBxj9qloDful4Odu8oFY9fCa2Le3Trkv0XfQ5KA/FTT9Tu3flkU7j7FCuB0INMA+FCGJm+T+Wzq13HjziltigN5iS0wL/Kp5tzBi0rCznLRixxaSPkscThKNogjwkfEYxenNbyvb9y6F7BklHjLwzQe8xQ+JbQlG1kG7CImuKbvQGdiTKRP8HgdboHEWXmVe92UuXihpn8vqfuMyk7208h+3jED4/m18XLF2lxcYrAW8ZhhkuJHtEgrg4v23UoN8kGnP6HlNwUmwMcSGUl7BvaQ4k3JxcQ2JDibNf8scWyRqlig02hfL52zZJU0+7kE7h08EKAcro+gZ4Iu0cP+9xVODuieZj0HDgLzchKemrw09vlYu7tjYNMndpFWqy7sTQj07lVgSmNXZ3o3nEObyQj7dZkX3hRTXMwU/vXtuBDca8oCrA5Dam9+2UF4qaXZY7EM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(4326008)(5660300002)(107886003)(66556008)(26005)(1076003)(66476007)(8936002)(54906003)(316002)(478600001)(66946007)(2906002)(2616005)(6916009)(966005)(41300700001)(6486002)(6666004)(8676002)(6512007)(7416002)(6506007)(4744005)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ADAsGMURm9w3fG1K3krse0Y0Nf6Q2DvNa1gg2r/q0CYfjBBb8dKqSXDZL+Mn?=
 =?us-ascii?Q?weG9gMzPl/FhWs/hJRsZLQLLJtr4Pt6XulR7Nzrc4JNhXS6H9oQ8URy1DLFb?=
 =?us-ascii?Q?1OpPN7hA4vWrw2bPulf2Jfu9ynI1Rr6OVO1gCFAUJ5YAwCd90a+LYLmBp/WX?=
 =?us-ascii?Q?9ItybcuTKZD50CZIY574kdHoMJX7HYMMworCWHC7QAP2dfQc8VJEFBvbmzBa?=
 =?us-ascii?Q?dBGhYnAf6kG92SbRNaQg1H+WmWDuvfVDdVmt7xq7oJLLSLYSH3AUX3Igwvwh?=
 =?us-ascii?Q?y+rGhVrTYwqbolHIsIFPz8bDCRII01z+fNz4xYMIMr4TJ4mOoA88R1fhKZeE?=
 =?us-ascii?Q?gMfcgGG3QmvjiTXoOumAHHhyGCiTlFPXZ0a5wkRcFTYhTnQPbG4DcdPOjFxN?=
 =?us-ascii?Q?Z9itjwnLgLbJrPjRxvYPdDsCl+8nOmm0JK3MAE7q2A40DMIbx+x/fEo6pTh5?=
 =?us-ascii?Q?84i6s2JZ+FHbSOe7z/0AgnvBe1uamMhLp8xo61hzIEfZdTs5PSxLUH5D2FRJ?=
 =?us-ascii?Q?6xABOKJNIHkDYysk7vlTcdmOgAGb4zBoRS5NGJOWgn/0bkQ9UDrzBrCLTYj8?=
 =?us-ascii?Q?R1ieejsoQlIyJqvg2LxPjXMTQlCfuKatoXMlZ3kF5g74inqLx/FHPLAORWPO?=
 =?us-ascii?Q?U9Ctk7l+n3TYssMpknit3UwEw3CsHiRrai9aNeoG/CQ0eFmiVNhZ0oaZ5XZ+?=
 =?us-ascii?Q?mCGKWKBhs/YKFjL+Y4NR6V9YhVSsQ/Wc4VB3TB6wWbKDspKWVmelHRgIBG6D?=
 =?us-ascii?Q?Ra7XFAfTeTz/tCFIz4cjQIAEaXzt4KZFrIMYPNTUfIXLVg1pjs48EGtM1uGf?=
 =?us-ascii?Q?NyenCrqyHG7lEWYimTUx3R+p1N+S6dNFyHWAeg7slvHzgZwUI0cK6zIBS42W?=
 =?us-ascii?Q?9zv4N7zeQr/rJqJvzIB2iE0S+STn1wUawUmSmcfeCSZWMmyTlbQrTESg/8Pf?=
 =?us-ascii?Q?tjSCg8qY8uvt0P6MbHe7Pm6Ug8xXFuWGb4egn+XGrAUqGBTQUNp4Y9NdJu+S?=
 =?us-ascii?Q?zHmpj8JlPtvuw1gA9jVGNYcVxbZesCnSQCnhh+lMjIGiWwUT5+3IIXQBpEiL?=
 =?us-ascii?Q?OppNDyzoxi65C+uGZCsnswpP9Hs4og+Jvcx4c6rMWWXvDOePifkR5iAi5vGD?=
 =?us-ascii?Q?2H5X7Uh65ezHWsyqPbSCzW2XnavC4lB0tOv8Yb6hM9Pz73GdT9Kk00c8vd8y?=
 =?us-ascii?Q?Ot/L4Ry+vcYH/z6PHaDkj4h9VDHWeRDT2L/ms5KBgfSEL2Z+e4y5U1cTj+5Q?=
 =?us-ascii?Q?ltQQveLE2CZLjZQN+kKHfeD4HRZAxu1uwof6XK9tWpm6L00FH5OtgjWqGth7?=
 =?us-ascii?Q?bO9iiG53wiDpONDbHHd1ggH4lFqdV9efr6YblPssa31eaha7ixzdVvpA3eTU?=
 =?us-ascii?Q?Nr67Ea2ofJxXZ3FMUA2X2oujN5KSBrDiyE/gGimTeHn5d86E9olAHoEpT3n0?=
 =?us-ascii?Q?VJny9taOOs3NrGDmMsTzESfGy30CODBO1X9HmRZiEWuEmPjoYHCkZG2ThOyt?=
 =?us-ascii?Q?aj8JJndPZy/7YC/G3pfeNhjy7HNY8G1ngxs38dp9y48q+Ls0uM70jUJcm3jr?=
 =?us-ascii?Q?n05MiNxAs5FVIcPByEUzAkvngKZI3rFtN34MlqJ7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?sTVEtd+Ic79NTFO1qjZpMSVvfILmF+frRaUj5aKNKygfUPM4TE/m3CEvXQ4q?=
 =?us-ascii?Q?KDSONYwm46CjFNmYkMpKe8+cq/6Ii+4cZIUhqWz7ugUoI4v69epvx5XT+t2o?=
 =?us-ascii?Q?/HM5yIf0PGXQevxsRCSH8qeBsn/yZAEvtJceaPqVx/bFriJy5pXK0HxUzXo0?=
 =?us-ascii?Q?G26QDLCQ1mnYxNojSrGJc5ffi3kAvz98/6x5UtK9/7Rw7Wb8NtxsMA7Seggn?=
 =?us-ascii?Q?drXeOtrJp0sd4o/c2ClP1W4iA0aVZ58RQdh57LlQIW3o+21uGeE4rB3vpcvz?=
 =?us-ascii?Q?G1aL+iwaend48be999zJAFco8LzJ355ZKWgIKoiIUiUoZH8PyhoaHXXO64Pf?=
 =?us-ascii?Q?4Riu79djuYBulWU4N4o8tGFy2m9gxW4ZGEJ5HaASxyBC76QgV02w86ieA8o6?=
 =?us-ascii?Q?p/kwmU5EiLiBePzM5tEsrOEa65dKvatG6Tg0Rl7NRK3HSVVWvkUM9yFBNK4j?=
 =?us-ascii?Q?GHAjOSzXExkm/doMrpZwKow1Njw2l9lhIbRyNoiF9Qd+D2YxJor/UkO2V8+p?=
 =?us-ascii?Q?pTdJHaocvhnz/zR+zsK640oVmd0UO/jnE8mRXoK3AiW6TmE3iRwD3Nc73NXj?=
 =?us-ascii?Q?Iwsl46HWFASCkYLdIN+OzUiDhq6uBNgJ0bI10vrZm4N4BRrVmU7pCtmyKKre?=
 =?us-ascii?Q?nT29XNWSocJlkLQlDS8sJJdOVo4d0cbm4iBMS4r+vcFyxWZlCepNemQFhSeL?=
 =?us-ascii?Q?Dg58S9e1z1iMuT4sbRrJqLxylO5YCXDtfCt/irhnZ5bLlXE/O6aG7NUAZqBH?=
 =?us-ascii?Q?6869111gD4zraX5kM/V48XcPmFY+mb6uwvvNvBVW3x0I7GWShjzfIQKcC2iD?=
 =?us-ascii?Q?s2oo4lNda8MSJlYi08GC58WM4V5TA7V2eFH6QtVke5TM5U50wsToy/1jF4qc?=
 =?us-ascii?Q?CJiTrRCXqVRX3LBYnqIIczBuCAQsXGmYtMt6peeOVUlSIuDyIJfcqTvQ7WSO?=
 =?us-ascii?Q?M/0wNcITs3W0VzmTIhcQ+XRidn6OvQI4/y+qPaZF+AFIM43YCTH8+rgPnCQy?=
 =?us-ascii?Q?TPED?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1d04d3-ca19-4e6b-f084-08dbc046b2ac
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 17:16:48.1849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fe3dbssdI5rQS9i5BhIfWMX8xFGm3LdGkuDTu3Rn+kXW+/LN6EVKQtxM+DSJKV3iK/TPQCR8iKhkuHBjgtGmQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_16,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280150
X-Proofpoint-ORIG-GUID: NxYjELUyBFJZBWbmcnHtjFtkJLtbXpCP
X-Proofpoint-GUID: NxYjELUyBFJZBWbmcnHtjFtkJLtbXpCP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When tracing through the code in vma_merge(), it was not completely
clear why the error return to a dup_anon_vma() call would not overwrite
a previous attempt to the same function.  This commit adds a comment
specifying why it is safe.

Suggested-by: Jann Horn <jannh@google.com>
Link: https://lore.kernel.org/linux-mm/CAG48ez3iDwFPR=Ed1BfrNuyUJPMK_=StjxhUsCkL6po1s7bONg@mail.gmail.com/
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 2f0ee489db8a..3c78afb707cf 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -937,6 +937,11 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			vma_start_write(curr);
 			remove = curr;
 			remove2 = next;
+			/*
+			 * Note that the dup_anon_vma below cannot overwrite err
+			 * since the first caller would do nothing unless next
+			 * has an anon_vma.
+			 */
 			if (!next->anon_vma)
 				err = dup_anon_vma(prev, curr, &anon_dup);
 		}
-- 
2.40.1


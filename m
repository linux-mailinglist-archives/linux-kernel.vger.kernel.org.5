Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C75750FCC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjGLRjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjGLRjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:39:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DDF1980
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:39:36 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CHNl5q012390;
        Wed, 12 Jul 2023 17:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=OGJPPE5z78uh5kTlMXGGScqDBmRhDAUhUI89z5qkCfU=;
 b=Vx0xg+ZHV61B2/wyDhO3xV1LwFFk5hoSTwbOOfOeI7tfgMswzJjf8MO5T9jN59P49xhD
 UZy9wnSMLHeoARdfSQAb8mO8wTXq/35kW+RGturg8F/gCCMimcG3zbPAaUYu2hGXeIRX
 TsHOgpzr8WTW6idDK3BPMOEuH6YuwfReDUe+CUhUH3qCiKfRW0xcDENbV4dk8VGlBNUF
 A2A4iqYz03x+fDjtYyARrHvPOlQy6tO+RZgbUv7k7ulVTY9esyDXWg66gEcfwerMLemo
 oy25TBYVG4nQFK2PEnpzU1oLPsqQMzS6K9IfLDi1IPPAcyrzg2+V2SSp/liv9UnV3R2a Qg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpydtyt0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 17:39:26 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36CGgd4m007212;
        Wed, 12 Jul 2023 17:39:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx86y040-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 17:39:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOMXDEr8jGCuL1luw5dwPFAEHqoA+Ky59hieaHhNF8hPnNknWJoH/8smOfw792BQZUR9igJsblN1txG+kcGYrUbBsGMX5uoLhg6EVzV1Ea1ieic350sxHpYGEGx18AeStNKrMR6P36zkFRtcd+VwWczldz+KfM+YAb8TYRsS9GYwJa2szgIVjtw4VR9XxSRDa6bbpxTXl7p/EpFOwIL9igjSUv0bPFSkZ8LnJr1sc0mHdof/NYiF6WR1z4W7Q3twZTxEHe+FU82hX+TTfxuwu25FfL3bRqEkYIpGG6gA1xGGvW65bTZAMhW3qKZNHpYfMlRuX7upOMkze4FxaD803g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGJPPE5z78uh5kTlMXGGScqDBmRhDAUhUI89z5qkCfU=;
 b=oY+nIX8x8UrXho7wbFmPvqj/Tkl1MJ6mctEtCl8+98bleRgB3duCsztunFYg6xrQ3ZTguEzW4xiamwcWauqp7kmFlyGj1V5N4D8A601xU03Hr6QfXTRo7CI46cQ5PnZRg/7JSFaN167v9v3kdNDHtaCbX4/1Bfby+OeqqUkM7Wj/NpefqfJmfFSZWAQn28R1kF0gbar9yzAW2LPsiE1DXYS/u9v7dOqr6wl9F9IWfu/mfgAe6GCK+unzWKF7YPtxxvMK3dLmUyu0/lZ9CI79k+sXg9pq9I/rWGIcb3LZcvfzsFQ1n5GwQfdk5wamXH7Jk5QWer+iahGUKen7DXVwzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGJPPE5z78uh5kTlMXGGScqDBmRhDAUhUI89z5qkCfU=;
 b=p0x8ELZPPxgK4jNb7yT3deKLvFB/mX8p6vUHfDcitinN2m+RoKCZ5AZuxUCCS2KshXfY8abnTsThLVbI6YOcM7BNkWvX/iXBTGsWujCMLI45Qjeu1vc4uhMNy3nw+vwq+CCI0xJohZDYdob8WrdWwdHN3j+3h1HhWSBGUbQmSAY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB7359.namprd10.prod.outlook.com (2603:10b6:208:3fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 17:39:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188%4]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 17:39:22 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/2] maple_tree: Fix 32 bit mas_next testing
Date:   Wed, 12 Jul 2023 13:39:15 -0400
Message-Id: <20230712173916.168805-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0144.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::23) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: f660eac4-6b91-4ac1-0f60-08db82feed96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nk8fF8LRXcjCgCK9r7QgCALw+3qthZacZbwV74UVuvw01bFAQae+MOBz4I1h0QZS0fbDc4bogNob3mE9PU7KdW582UxwQQZICIh5i84mLnP3qPvsP+MpazckCR9C7VyZ0+WY+fSSj2D1md+xa2aVqCdkAtuRXLZJl2yQUK48PW/iCB2JhwyN8jJKx9EZsM5qflLMnPLmuOdijePxoiFf7PEF1RCyr8Q6SdTRin28wRJqLvTgBc6EQqvEF5XRnOiXSP3zuR6MNs7N8ENI6bDYutkkhOwmL0heui0wFOkNRLGQnQJAKqUS7Tyz6eddajW4cS4TG4ds59qR+Z2KM2lgy0bcyo4mmx4FO4ejFNhSh7x87klPCyL0xKfjQB6D/jXaj+v+lnyqla3ncjlRyCxUeuMW+a8Mu+rNLBh4ERnjAvcz2LgnTwKIG9pFN1fo/Y5bGCIAyia9qKkCCk87+OBBtMRHGmgz7GLVIpfClgly/+tj3C5rVGDqLxjifVV+dvvOUgg8/ihgkpq73PVYVx/6nP/s9XMk+apcUtdmbnSpnJg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199021)(2906002)(36756003)(2616005)(41300700001)(83380400001)(5660300002)(6506007)(26005)(1076003)(186003)(8936002)(8676002)(54906003)(6486002)(66476007)(66556008)(66946007)(6916009)(4326008)(6666004)(86362001)(478600001)(38100700002)(316002)(6512007)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y2D9KSTqVJo6P0EJqC2ts0xuzIqX0xZdVFu9imwxDjs9yjKcW8N43OCcTaj6?=
 =?us-ascii?Q?gvAd80Y8k5Qzow6aubm2COCuQkD+2aTar+WHPFM2ILm+4WE4YvyE549c5eCM?=
 =?us-ascii?Q?kGKp8aq+i/6dKzPFsDYWMSVN+PIe0IuLxr8oT+51Ow5yzkolzh92H78hETYM?=
 =?us-ascii?Q?g2P1DLVDtJiPLRs5DaGQZfkrH7mRudVSl+LzHPrjz3FPDhcJ0q5nO3DjjPnl?=
 =?us-ascii?Q?Tdy3eXT+a6/PImPX6a2yj7mecYw8URlveyb9dpo8lJhSuXilly7ODoU5816S?=
 =?us-ascii?Q?LBQ1Uad3pct1lmQI7Iu3JPVnEDbhmcdTTlZzbFc71lzO01KbGgP5lg9myHnA?=
 =?us-ascii?Q?7dbTy8jeMTdySm+8i4u92Ol2Lv5MtDT10CzaVJyMMLaCzZaBD+Ktd3jQ5F0I?=
 =?us-ascii?Q?h9NfiFZJfhr4vl9sR+xq7ZHPTL48iOiki7ousoXY7pb+sw9ETIEhFuz98uf4?=
 =?us-ascii?Q?HndgGNq5XYhjTuWG6uOlfIWMekTr+9C1pX7QdHdflbckzNlngVgfKtgB1t7p?=
 =?us-ascii?Q?8LSP6TMjadx0qwFRTQBEGnqhgHcrkm3txKmc3atZf+cBIwAiPEqjRJry79k5?=
 =?us-ascii?Q?jopIRZKXFl+OgH4YBGdIrlkCMsYQqlS0CFX8IeeEv7/JE1zljiSp771dsSI8?=
 =?us-ascii?Q?lj0xP7R/QJYRg1RWSrYmSTArynY+sySIDH595AWdo7R0by+N+r3vwIzeSeQP?=
 =?us-ascii?Q?9LQi7mb9IXHHg3ytdZHsi9vsuxH8ttG1MWeuxglAkBztmPhry2lFJS0N7rab?=
 =?us-ascii?Q?FU3dckx0ZaX8760GvijkRsnd6yX412qD2/s+OfuJVT4/jwdEUNYs56vhQw7K?=
 =?us-ascii?Q?w6UyT5nVICDDdWFXH2aVJHFEa7NWawtygy6nKD6xB7UDajwNZbxIT+sm7nLm?=
 =?us-ascii?Q?tDGdZfYSzboB+k58Qsif7XjYqw1E8gfVuCZ6QUlambmDN1RfXBpq7u45E2vY?=
 =?us-ascii?Q?GQfG7J6k4yQkCFE+TgR4/ddqSUqc8Gei2cTnuyqr+ODrQ7gUIW98ut03kDiW?=
 =?us-ascii?Q?QgBEKT1s86Rx7xhYpxcqEfdX0+/NbXAO+TYY8FcH5mtg6AgRk9nud2dTLcoR?=
 =?us-ascii?Q?RzvZ8PZi/Ju+L8zrvOKZGN0FV4C+fby/eDQa3CboOxqbs8LGFjrdKM82DuK7?=
 =?us-ascii?Q?lTpnTDeTq/n3aNyhOXbkci+9HufNkAMIdayEUHfcy7gTv+9n63RaZnPeP4Ik?=
 =?us-ascii?Q?K/S+E1xmIdKHTfsnT+wXOqXfPgmiOTzRsGbGx2WHwfL66wN+QHxsoONK6c+n?=
 =?us-ascii?Q?WtA7iy1NR5O+wWO0XajSWbgDFmGEmtHb18kG54RPbSXlfg7+e04SSwQXYfNv?=
 =?us-ascii?Q?MD49HCg1vCwClPUTAEuhxmmNuztxR4VvgCbpOKUGR5+lR35EcTESJZxfsK7b?=
 =?us-ascii?Q?2Um9EoRzw3TJXi+BqemgJXMy4FgcpHkXGXi3MsS63KvcBsNswdETmk/yjm6q?=
 =?us-ascii?Q?1ixLb/2vg32VmXpt9JvIXDFqoP3p4QunGF+SK+cfxkqVBypz4zXyGNxsZvGp?=
 =?us-ascii?Q?1F/KF0xQwZlTGkcJPnSKLDG9X8+2hD1lgLUeZL2r78T/OIYnZOA/utN5326e?=
 =?us-ascii?Q?DKZCXxpd8irhLWS/z6ffi3qMsQGXeTnqY7fY/Q6tPElwyMQHxKckFKuv73MS?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?CUJ4rTtlSEg/KSyoslAqpGqpSQ6KvqmT8Sw0P8ATxorjCGuY5nLK3FFvS9Zz?=
 =?us-ascii?Q?aw0FRkQ55hI3/Z6xifHLUCaxt98RAWz/AUdNiq+EizUGxcDUe/5vsVqiIiq6?=
 =?us-ascii?Q?LZmuO8vzQfW/piLqI4Kn7dwfl+KbazBpzlDelvJrmysjfU18R8+EO5GG9djm?=
 =?us-ascii?Q?A/8NIwgz1GJCbL1BWVh2JBZo4nqFW3fNCaekNKZNMQRVil0/2Kqt4RmlE+Cg?=
 =?us-ascii?Q?gXFwKiHNN6aHKTrKkuS2zFCI7P4cZCp820juZSobe05bt/v8JFIeEtx7K9iG?=
 =?us-ascii?Q?C5fsFBHyP07ckTjlsWqNbCDjNjwVzShiCqu7a5OlEz6/lqf/uwUAgnaoW4X9?=
 =?us-ascii?Q?XOD5soK+KJQxTGoS84EqZshCaHNjGo08QoWaP1ZfIGom7eT2I7Zt6DipB5rA?=
 =?us-ascii?Q?lUUbfRN8xfXNT8bPHlkNJIq13CkUVVYRSmehs9hZR5gX8pn5dpbbVM7pGSey?=
 =?us-ascii?Q?XuUI3ArCgnKX5bVinMp1ML64A6dqxdKBJHohzHCJKfx/ASeqhjp+ii2+Sciz?=
 =?us-ascii?Q?w1PUIoEyOOKIvgzF5q3tA5n1vSGXlzZEaTC3a5RHdBDglm5IrujalBaKdnF3?=
 =?us-ascii?Q?Pie3bzoCAlnpgvPG9hRqf1qmZmo+vdS/cTkE7C0DnuCHlzjbF+8xrBntZxAb?=
 =?us-ascii?Q?n4x6Ac4xn8fZfJIRfih8LQbbSN6LPZxxnlvMVX+Jv3FinnrJNqG8BuJOLaHu?=
 =?us-ascii?Q?1N5qa0Cu8Rj15GMiZvsLIQSg8xp+ZKY2l/YvL+sOsHmx9RBOsrp5O2wF5BZe?=
 =?us-ascii?Q?G0qDIvwr68YL/omZbYPQ3PFfx3QBaJgUAZsUbwcyhSfdsRZlnZZjPGg9nIYn?=
 =?us-ascii?Q?S2/I8kp2qppKfuV/eMAXAqwQAKQt2Qsb47+srq92eZPXNM1llw2mMlQMFZvn?=
 =?us-ascii?Q?JGTqgrWpu4QlETKj5CDwSiF6TDIbhKOm6HF2FqHB1vd+DXcoMMwjSMFXQAyz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f660eac4-6b91-4ac1-0f60-08db82feed96
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:39:22.3575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZwIxsbXc4xCQ59L1fbeuPxTBrPYAcjf/6mVBSDMN/WKkWl0tLz5OQRR3TfocS7Z19BEctYZNPFJnif9eudorw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7359
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_12,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120159
X-Proofpoint-GUID: au-je2HrC-7xK6RrpcSv3oNEo9LswE8e
X-Proofpoint-ORIG-GUID: au-je2HrC-7xK6RrpcSv3oNEo9LswE8e
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test setup of mas_next is dependent on node entry size to create a 2
level tree, but the tests did not account for this in the expected value
when shifting beyond the scope of the tree.

Fix this by setting up the test to succeed depending on the node
entries which is dependent on the 32/64 bit setup.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/linux-mm/CAMuHMdV4T53fOw7VPoBgPR7fP6RYqf=CBhD_y_vOg53zZX_DnA@mail.gmail.com/
Fixes: 120b116208a0 ("maple_tree: reorganize testing to restore module testing")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/test_maple_tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 9f60e0c4cc8c..3207c2107918 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -1963,13 +1963,16 @@ static noinline void __init next_prev_test(struct maple_tree *mt)
 						   725};
 	static const unsigned long level2_32[] = { 1747, 2000, 1750, 1755,
 						   1760, 1765};
+	unsigned long last_index;
 
 	if (MAPLE_32BIT) {
 		nr_entries = 500;
 		level2 = level2_32;
+		last_index = 0x138e;
 	} else {
 		nr_entries = 200;
 		level2 = level2_64;
+		last_index = 0x7d6;
 	}
 
 	for (i = 0; i <= nr_entries; i++)
@@ -2076,7 +2079,7 @@ static noinline void __init next_prev_test(struct maple_tree *mt)
 
 	val = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, val != NULL);
-	MT_BUG_ON(mt, mas.index != 0x7d6);
+	MT_BUG_ON(mt, mas.index != last_index);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
 
 	val = mas_prev(&mas, 0);
-- 
2.39.2


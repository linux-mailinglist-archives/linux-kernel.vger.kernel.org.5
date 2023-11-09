Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9607E6459
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 08:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbjKIHbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 02:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjKIHbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 02:31:50 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2116.outbound.protection.outlook.com [40.107.255.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C48D40
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 23:31:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n79b65/02NhnXrdDi7HRzRUWITKBicdCOqg0Om1TqmecGCbmFU70VunD4jKknloJVp5vEFB3SWpJ6zhIZAs9MhAJ8h3lpkXQSg0iEGQ5dcU6B0L98KdRHXSoYfcM72gVQ1ij7yzK8uSWCIuoHWcbMr/qSHItIbyfY/UpJex18i7nwGzZqHvcGWHj6JL+PngeK/87DT+EwAYKNRD9bi0pCjZu8BMBVuDfWCPAEXvmTF2QSRX697Ai54E1RyrnLkmo+mcAgy07BlkefDF/X9WSYybqrzxCUhzI9fj2hJ1dwiAQLRakALR0s270dzjSwnCVzMV9p7Z3KT6LpQyvYyw4bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnqHYQ8uMCXZeK9F7tcRpUYiFTWrKNq8BZ5ShbqWMhc=;
 b=YGlXtUBiVibNdYjDYnerpSRhQvhXyhPwaXR7tnYN7Lmmduy8T7aErvsqQHVl3D9fxRZKeUzZYC2Z9Fk0nPJRWRl8nhduP1qJr40dccrZxNnG0ZOAUXkItu/OyQi6RmN1zpxsNCTjroSyiD1FDmA/uyInw/U/9PSyMsfIi2TqO80RgYjKJi+HtbCU9qBSzQqaX70rEk673h0iWKa7ZPth8QcrA7p/kgo4TqSCQXG2zCBChr5aBH7uYsUzr3q1PICXhCqSpP5b3s0GBFAjpm6Ll2GYs/xaMTZXnlfvd6HQdOJ3uyQWN29UtsxjjWV9l8yjJhwghDJqsMosdgWw8zJvew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnqHYQ8uMCXZeK9F7tcRpUYiFTWrKNq8BZ5ShbqWMhc=;
 b=eawTfVGJOlRj2xXd5KaZ1chVNUjWbtM8/IdkXAZK4I6GEhqky7ydZT+ivO/F63tWlhi347TF3ytx2igXbsajFH4AYKRCJQ4JKmyl05uUP0lkzyEH4ZMhYohrdW8JJdAhhg+gzkEK8h3/2JwKn98wPz5wpuU8VqOBcnoKHylZ1b7rkdMfO7ri0n5H93Tf9FvD1UaOmwBgRwIeev0FaOIwmJ9BYNbPaF1KsODJdad4Qdhxu7251fWuY1n/VDE+vfakehCnK+G1MSavSFmJS86dWz1GDe42eA7biKbkdw9FdEJ4lZeHKP92s0g+O/1de4wd6VplZkIMk/5wtUJaGcVCng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by PUZPR06MB5933.apcprd06.prod.outlook.com (2603:1096:301:11a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 07:31:42 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb%4]) with mapi id 15.20.6954.027; Thu, 9 Nov 2023
 07:31:42 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>, opensource.kernel@vivo.com,
        Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH v2 0/1] mm: ALLOC_HIGHATOMIC flag allocation issue
Date:   Thu,  9 Nov 2023 15:31:32 +0800
Message-ID: <20231109073133.792-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0219.apcprd06.prod.outlook.com
 (2603:1096:4:68::27) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|PUZPR06MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: c7998c54-b4bf-4af3-438e-08dbe0f5eb19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bg7VjfM028RQDaAQgcEeYLRdS+Oit+iw7jcyTeS7CAMuQB6XO4BWakPhZFwa+nH7lr9YnyAfpel4aJwivfTzVk/ZMMUUl7Ls9IeQbymaqS4DCUAISxX1RJd7doD2JdGmeobJdBEpgA92H68C+KR2pnmdcV1Z43qCJ77eHco7zz3BgaZMgrQe/3h5I5gqClvje6AVcRq3oP308ZgM+9JNLRjm0Bq3yaP3DzDCBXHt6XoTFcA5kRAQP67CK2NJ393SSTtZmQ3gm3EZXvIMg+EeRv1tRj69lOkIdwEQwD0pgRVwjSLxJSepW+grccwEGkedIfi6XmaY42wgdiKcgYDOry98JoYJpCAxfdSCzzZrg6T3HeFSIltLjAYX8srPX2O96GuNcNnY+69ToWPnC/HDRY+dXXajH6XbwwGaVbXmxx+Fvlz9MPQ+OJ7Jrq3wxzsnuuNs+e8A7hBNeKu5gg4nJB+1bVUWmi8ecFWhSo6HNJ/MlAwtGa6929ecNvZCwmLLHdUU+8p1KfEDPYZi/+s2nFfQXYJyF2lvy0I/SATvbxuAs+erEU2PHUb245Hf1AqrzwSq4SToD5GDaqWWL2MQlBOYHfh05o+hi1ZEGEBMiM8b55+Q6GhRtSvYbnvSCqIs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(346002)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(478600001)(107886003)(41300700001)(6486002)(6506007)(52116002)(6512007)(2616005)(316002)(8676002)(4326008)(83380400001)(8936002)(26005)(5660300002)(6666004)(54906003)(66556008)(66476007)(66946007)(38100700002)(2906002)(86362001)(1076003)(558084003)(36756003)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nqvp+DLCPgLXZmzT7NbuYDsLzyq17Ld+9MsYjg0JkUqdypyvxybYcxWaXqb2?=
 =?us-ascii?Q?NG0p71K9AtUqZZD4K1oYuZZhrhA5KcG+tgKyQbubIh3HRLyUfEOddL2QIoT4?=
 =?us-ascii?Q?BdRgwyzMAMRx3srTZ4x9EEBIf2mPvLZxw+2cwaKyZOZMWZH2X54xVPtxLEmp?=
 =?us-ascii?Q?oKAbxF0TCfnrSf/uUcApc55pzt2ynHyIAAPxgPqs1bRLz5aRsXuHF/1iljHF?=
 =?us-ascii?Q?koGig6lrclEA9xuzCr1960TfX4SElWCwcPCogZYrk7jfZgLH4JdIKR5m5dag?=
 =?us-ascii?Q?WBIqXCfSHFoN87Py+2mobHVG0NmPqIwqNi/t3KnWFV+L7hU8W3yXXu6NONzB?=
 =?us-ascii?Q?piZZDRtywfU2krCMycPGMrG77+5v+0Bt4711+5JBlp9Cf9R6gWOXmGCt1tNV?=
 =?us-ascii?Q?e4pMUSM9g1zKuHE8VjBpJeSQ3IKOJhffVrubFpXV/EXKK33Ya2PYxhtDMSkg?=
 =?us-ascii?Q?B6aRrDirmFi6dai405AFXyo7eBsrgtEN3KgMN8ktvvOiFuo8DKCWer/c+Ah5?=
 =?us-ascii?Q?0q1OkRKS2F7UyKG9sF5uNrt6qFUAj4w/lN6VzzUZrxjI/3OgjBm1THOuZvAu?=
 =?us-ascii?Q?+3giwgb9ZU2iql3K125n2Zi1/CSJZLw1OxNp7AAd/laHiWwBtceg/AO2dU9L?=
 =?us-ascii?Q?tEt0jKZ3cyYvtLt3D5WE/pDcXELgYnVuiiv1QOFCWH5kHgxku9lkpSYxqFIe?=
 =?us-ascii?Q?ceyIDllLJg1F4UjPv1Cl3MDujjq57qdQc/2PS3mWTxtjLV3X4ZABXd3j73iJ?=
 =?us-ascii?Q?ggC1tYaqD5lVImI+UHtLemQKgoVwIw2NZlaCWpO4vzfxn/xOhVfAnLTc9bDW?=
 =?us-ascii?Q?bYwnPt/HMtvYquZ1jIKufutqdYI8yQc2VF6PY16mgQqL9vHJ2YaNlog5LR6Y?=
 =?us-ascii?Q?tpv+EwjLfhhRMjmL/ivn8qzW5dtRj6TU3KMvOKAtX5ImUuAbyhP7R3Chg0VN?=
 =?us-ascii?Q?aoGCmIj/9yWXVfK/79uwgrhb/usleoLIf5LJYwlbJa3WQNhNe1YMzc6smV4t?=
 =?us-ascii?Q?XZAj5cylhvtGlt3+Tp0Vpnmz5ZbfCWZK9b357CQzysfqRk5iDgTdRM9MJFYY?=
 =?us-ascii?Q?Sv8TLGwc+r2xlUznvPJyfLcru7YZ0jga646UQYs00YnLoXrvJkgcgbTA48J+?=
 =?us-ascii?Q?ICo7UVNjneXow/XS/X5kpQct4TvPjCYY2D1Q+gJ03C2FpUDCUA1RFHPT4ZDc?=
 =?us-ascii?Q?zo86KEHsQrxjZssynz/AzvHOv2YBOX50wuWpxwtuvBePHmYk1RJOfGHbSXQi?=
 =?us-ascii?Q?3r8foPsBY0L+14oWW7iKgtpNHeNVLZ584VUyJr7Y8v2nvRhpVGEQNG/iecFQ?=
 =?us-ascii?Q?FKBp+K8ygTc6V09ahk/aR+niTeUEGKD4KVqWSRh4ujlmf0t/fi8eFSmLcSyd?=
 =?us-ascii?Q?zROud7a1PBUtRpo5ijJwxv3EZeMvlH6IBBddxdII4uuiCdKkwMvsG4asRQQr?=
 =?us-ascii?Q?OM9jtceELTNZg4y6ALhMGNPgTY2rO84M+svl+uSZ9sStTRR6pD2mIRcrJE7h?=
 =?us-ascii?Q?pDmDs0E9I/LY+8irAoCI2Ovftv2F2WN1Mx0ddjA8CwAatd+t0g2OHuJ2kh5v?=
 =?us-ascii?Q?gtRNxYhavtdZ87MYqE+MzZBdp72KC03Es5xSj8lG?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7998c54-b4bf-4af3-438e-08dbe0f5eb19
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 07:31:42.0937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BvcBkPEvKaS8Z0P6TU4TmjNg1xi/snudcabbUEvefsc0HinjWWd5PilvByBRDldA7N29JO0CBPrs8JigBafTMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5933
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*** BLURB HERE ***

Zhiguo Jiang (1):
  mm: ALLOC_HIGHATOMIC flag allocation issue

 mm/internal.h   |  1 -
 mm/page_alloc.c | 41 ++++++++++++++++++++++++++++++-----------
 2 files changed, 30 insertions(+), 12 deletions(-)

-- 
2.39.0


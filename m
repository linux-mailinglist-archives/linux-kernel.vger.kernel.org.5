Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5FB770686
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjHDRAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjHDRAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:00:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BADE3C25
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 10:00:31 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374EiMF3030795;
        Fri, 4 Aug 2023 17:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=xGAFUHwaznQZZ9awdwm5ZiuBMO1MMOs1VI9nLTz/3VQ=;
 b=D8ocZhSoPE5PbQZU5qFxn/P2iho5RxYNwU98HGX1IFj89DbhaVPOjhMlxJ/q1W/jFsGf
 P8p9rR78gSBWc5PaLZY9Kfenup8M3MRAtI6jZmko02Vv8Y9H/S582vi4d7L/CAHQpszN
 pasgmSVXq1Gbm/tnKglfoq0fQddnAEQZAelfAJKODl+3yJoOpK0+IdpwrKwXhn2CHlnI
 7xUUXp49FtRAuWEhQMHXFia155xj0ttG51CebqllODbQjr3CBOPevmKn8ta/F08UXrFE
 M4+d7xA1oW7gRyAuUn61RubDs5BpLJp+kUKU0mFpjS+R8Lhcs4s45Q+N1FCAEv0XdI+W 3A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4uav47ky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 17:00:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 374FQvwA011630;
        Fri, 4 Aug 2023 17:00:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s8m2s3grb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 17:00:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVv5WoPz7yLabu4/WJdlZvA+Dcqm8MIjZrONyvWr7Xa1uUvctDZEWCLDuKj05au8p8Dk8jj0fB0Cm0gd6W+kGd2PtsXGvbj4nBRVAlrOUu8+NW4lWTOAYsS5iP/cqU+foJ/q6d/tU2aWSon/nUdM4ShoPgs7kM5/CsKicLl84hJRYkZK+tOFKgq4kKBBcY5BcKGC6VJRrvFb8QX+hxjqkdwD3BmC7wcWygBpBxlgEG7bXdK9cXizprKwqj1BOPBwI+hKqJpZ+y6mV69w9QbVf1DQpAZcQ9akDaq5NIcKjUorQsQ/O+osiv4ifLAJcyw8pvBR5LldGhxmB7eRTCR/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGAFUHwaznQZZ9awdwm5ZiuBMO1MMOs1VI9nLTz/3VQ=;
 b=cpwOTzu1HwTvp6v1FXWrpB/GnnIKapHdsH81bHeQw4H/90xsZwkmVCkTmFKectjqrfcfwNHjkLRuGzUBrFXXVN1oaOImUffYD3p8s6/baJ3fX8jIU4ofPyMTl6sEP8W8t+ZELI2zx7FQpGmG11RZ2F+8CEwinUWu5+rWPk55agxzPdwhJpHNyzwjMcf/NwQOKIUZWvqZLB7mo7MhPAzj5f7QupxOlejf1nimUHQUFPaRmacLmewDZg6syAD4rj8tRmscoJisGIbIu5w4jun5PKv8kcYQpa7Hom9jNnqyQzQEWMtSN4nuBmflYDXk/1vUOA1SN26i8ebBsVkDo2r1VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGAFUHwaznQZZ9awdwm5ZiuBMO1MMOs1VI9nLTz/3VQ=;
 b=hbHD0vQQPXenQxg9RabtN1Y0ZXTHLUcVxxuz+tADelLthKDPoO6ARcH6gV53nFRRLXHyddBGmPINs4FyNB8TB7/iqBwZ3G20nTqz/GD8rGYiUrGgHvsWkn0mQs23d7bIKHTyhJkCc9XnFl8Ejxfu/2OFtE7ytDSkyMUZCHwb99U=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4469.namprd10.prod.outlook.com (2603:10b6:510:32::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 17:00:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 17:00:11 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 0/6] maple_tree: Change replacement strategy
Date:   Fri,  4 Aug 2023 12:59:45 -0400
Message-Id: <20230804165951.2661157-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0181.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::8) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH0PR10MB4469:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ad192b-fcb6-41fa-21d1-08db950c43ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ewlb1nqXRZWI2dku8ZiPOuZi08gi4QoFbT4ub2V8FuYMHln5+d+YQKYfGaGCkpjKoZs3xRycElL7+X2vIRms9NnMgjP3m3zw+uphMgL3mGtuxbfQVONeUCWOIZENyBC2wkoTWzCrL51jPiGcVV25rAy00K0K3ZwsZXMrHT0EynMnWJIRLpdDyf52Qy6MHgja5Q64pSZe2OfX0xfAiphA3sAa2AXPz48kVzcZN/rqcbcb1Lzc6BdL2uoyo2d7GI5rNVw9NQn4ueyZ8fyhr8p9sumPY9s9QDIlQZAWY+518dzNzUz4B1tAOBkJrqgcnaZMU48icfEXSRiEOqzg69+JcomD4d++vcI1dZ1KClqPkfQ+kSEKvWgimRFK36HGWD/dw/ysO16yYF3vQn/ct/4PUz5bR1v6eP8eEvMMVe0GHsmv/NwCW8R34GluSIjaNSs2KZoN983qBJEIYT6AtzbS2uenx0LxW2yXnAxpjX290hjEO8OWdCUnTUByPTcWtKtSWgEE4bIBhKfVznZCSn+O20y24oeG52BjS2N8jSyTeqjV1eb0YV42r88aB4k0EFOv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(396003)(346002)(136003)(1800799003)(186006)(451199021)(41300700001)(8936002)(8676002)(83380400001)(26005)(6506007)(107886003)(86362001)(38100700002)(2616005)(1076003)(316002)(6666004)(4326008)(6512007)(6486002)(478600001)(54906003)(6916009)(36756003)(2906002)(66476007)(5660300002)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JaCcmV9o+THzNz+ntnKaNuzcMuSEqJUNoL/PQyQwb5QUpBEGLyMSUZ3AJDrS?=
 =?us-ascii?Q?trvOahIo+JSCBckX1kJAAd/BftS+M3MXbXhd/yKAG8v1u0OEOMF2iIEUQlhL?=
 =?us-ascii?Q?PMaiIKgbfFBBFCIEOj5/mHGmfGVdus7Tv7cl/vXguHEs7Cen9GhoMGBSoJgg?=
 =?us-ascii?Q?djZqephAhoXrD9weBlpLFFhjRGeC2eS8DHNTtCONueNaOIVNz1r5TocGq1qO?=
 =?us-ascii?Q?1BtjJXvVe+p46UiC1pZ53+M+qShDq87Lit7xi9hbP57BF6yfvfMdQ2umtr0L?=
 =?us-ascii?Q?nPfF/OOtv09SgwYNMBtXh4E4hSKRQSxcGw212HstNzFdA4mwWmXdldQoehKU?=
 =?us-ascii?Q?60nQwdmUThgR5kI9cYBRcFY5sHndUqfYDEdlYEGLuSBrC1GWujwYlYuh8Cbi?=
 =?us-ascii?Q?B2fziN2OBg/YcailHehHHFnb3w0lLObJVKRlp3x5wW5TWYhBrpHS+5ZFhHLH?=
 =?us-ascii?Q?aMXy/1/K8WNuAVEA7n5qMy1X7ZftF3c/Fa58yyJYdScafXvLIadRT9zR7AbU?=
 =?us-ascii?Q?O9e2QhmLcVLPYZgWcwGOJ+WwBDjlSelpmsYclTwQG8IPrwwlqjps4D1qBNL/?=
 =?us-ascii?Q?rtrxkvhbczENYESZCePFW88eosJRw/lqH9HU1+Wg9ci1T2QthuhXA6WSao84?=
 =?us-ascii?Q?dIXP1uLrUBhUPy3Id9PB4/lUssCk94Juqg/+4D2He4RHVIgW+GI2asr73TCW?=
 =?us-ascii?Q?pySwhC9I+ygWJOHdBieKIhzCleX4LO8cYAvsHTCFMDW7VTT5GdV3ARUcfdSx?=
 =?us-ascii?Q?RCPlTvaBCL8z8f7snCHgvoLcbow9CsYILQBEFcAIWvR1i6bZHfG7s900ApQC?=
 =?us-ascii?Q?VVZF15yEy67ZnXZ61vyf/fl0n9wR/ZBBP0um5roItxWt8jAOgk+rW74rx/Bu?=
 =?us-ascii?Q?o8XoiU6CJCCD3UYooQoILbLhZgrXJAuJf+td7zgF5xY6Km6CxGtcjj+lsj90?=
 =?us-ascii?Q?cUxXdGDbK0jDEj6YJrS3i5u34bFuj50PA015ANbDc7+sQ0RkbH670Yq3YfdX?=
 =?us-ascii?Q?6nWZOvA/7+n8y9CBppDWI6hh45RRFvwjGbMS/3T/QTkZKAwy5sTYMwmZm4E+?=
 =?us-ascii?Q?8KUxSjQ1++o9dB45vF/o/7i7BMreT2fsQyHK4uWTXENX1gcfZUanwtslyjd0?=
 =?us-ascii?Q?8+3QWVoMC+zl3SBlb+mI2KnDZZojTzTITP21cA2rGbKgtdAyjg5avcNi/VuX?=
 =?us-ascii?Q?YWNYgLZglk5moKIET9jy5wysLx2xggygyByAS7hDteveEcgPT9qOoa5QFK6P?=
 =?us-ascii?Q?g4EryKh6ESOjBWc8i1ttaMYAmEUrVbYRLcDFWfC3eracEfGrz7tu7AsyJUaZ?=
 =?us-ascii?Q?Ld+q5wQCAs70iqPat7Cx+jW3gGCIVTracs6Rv5iT1SSsEpLBsrmEXLMqrIDS?=
 =?us-ascii?Q?4u/QzaUM5i0BMtl0qyK07YiQsjfvXsAiJGbtjAjFcbr0GvOCg1HT2BGw97Cj?=
 =?us-ascii?Q?T2KUWb216//f7FbpcOo+pJzW+Vqiu4mw9QMg+X5SVRj8KM60B2oHhVodZE5t?=
 =?us-ascii?Q?xjifuJueJHabLlh8fg6Hnh2ffpfK7ftQn7bagnBEra9PBj9ANw1ktO5QTDO9?=
 =?us-ascii?Q?xDDfLVwHAVMIYDHHXhNsgPz3ao/eXgu4rhJuKpux8fmvSUZPiG1u0oNGRy3N?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?IrfxQCi8Ca6PCj+g1yES4SPfvyMPLdA+n2Btz6jIARDjTY44t3/2b0Gsg4oG?=
 =?us-ascii?Q?1TUbwp0DjiTd+k9XoNk25rz+UXPD0h5n018j9yOewHHx1y2kS2ktMSH9iHxN?=
 =?us-ascii?Q?TPPQ+yatZTWvyGAfwJEele7DXIu2g5hrrp/ui7B1XsV/ZTt4v4Nbzcbg/Ffh?=
 =?us-ascii?Q?8BTgguKdFUnGSEtQi+fha7eGRWuU/HKZ/Mk+djdbBc+g2iyiv5pMGgD7+g/a?=
 =?us-ascii?Q?i9BwHhCvqSuggwgT1+GrwDdzoOXgQcTC/w/f4u+lU+R54TK/o+qc9U+ZQk/C?=
 =?us-ascii?Q?dfl7UDaLwY1l2U0RAxdV6QXumZPaK6gAVI5tT0LqOJB2V/Jsp4ljL3cUhXep?=
 =?us-ascii?Q?6mwNAkzT1MmmeyQrU7oywtbLsAkDyw7w+B9m47D/cMBasDpKkEpJHj1n9VfD?=
 =?us-ascii?Q?0JOHDZJRnhliufW7+q6C4NcFxkA2V1o2MmNxLshq2iwyaQAcC72wG0vWCNvK?=
 =?us-ascii?Q?f22ygL3/93X0ikUeQQLdicyMQz6BE6njcUvNx3LNeUSrCL1Q4QTFhSZS9eYc?=
 =?us-ascii?Q?UeU1il/bPN2cuTeMdnEqxcXmK1caZAI3Qe1HMUj5vWB+UocYZFm8QifB6Clq?=
 =?us-ascii?Q?tEGC1XUpzC4lABVMqrZl621LZM+Ivtd9xvb/31QH/DyEQYnkKlRV+oa5stoy?=
 =?us-ascii?Q?CMrc5FHZhdcCc4j8/uo1n5VWOAM0ICYpuN91M7dU8DYvjymTHF2+2m+nXxqz?=
 =?us-ascii?Q?91457dRBNoop4Xagti9Xn6HORD45YoaOLJO8B6m0rqtBJRDh5mqSNT5FQQm+?=
 =?us-ascii?Q?B4a+h60rNPdbKpvJ/69XTpTKXaUHL2O1pirgMz4iwWjPM9E6b7TKLqeM2mxT?=
 =?us-ascii?Q?gk3MDQHQn6gNL5AWjm1Wk55MVuW3NGVJ+qNxOonr+oQ2Zc4PXmGHla24yEtu?=
 =?us-ascii?Q?yZ7UXh5WcZzbuBwB1j+XNrMRjbGhTPwdnXDy6RiBjnrP1/iUDPbZ3aVrhkt4?=
 =?us-ascii?Q?vUxwBfdOmY4X1Y7TqF9BNLYvxLRJJ9MXpCKBZtMfjxM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ad192b-fcb6-41fa-21d1-08db950c43ea
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 17:00:11.6020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUDiJqTXq7p3htrgXC68BSWtSiMit6lI4oJlXtm3v9VR8YPrKI1vI2rjMDqd5xduWejea0A1bkdwse6q2/5rAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4469
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_16,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308040151
X-Proofpoint-ORIG-GUID: RyiOzTUOroQO_GksT8kJsV_lbK1LpXN3
X-Proofpoint-GUID: RyiOzTUOroQO_GksT8kJsV_lbK1LpXN3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree marks nodes dead as soon as they are going to be
replaced.  This could be problematic when used in the RCU context since
the writer may be starved of CPU time by the readers.  This patch set
addresses the issue by switching the data replacement strategy to one
that will only mark data as dead once the new data is available.

This series changes the ordering of the node replacement so that the new
data is live before the old data is marked 'dead'.  When readers hit
'dead' nodes, they will restart from the top of the tree and end up in
the new data.

In more complex scenarios, the replacement strategy means a subtree is
built and graphed into the tree leaving some nodes to point to the old
parent.  The view of tasks into the old data will either remain with the
old data, or see the new data once the old data is marked 'dead'.

Iterators will see the 'dead' node and restart on their own and switch
to the new data.  There is no risk of the reader seeing old data in
these cases.

The 'dead' subtree of data is then fully marked dead, but reused nodes
will still point to the dead nodes until the parent pointer is updated.
Walking up to a 'dead' node will cause a re-walk from the top of the
tree and enter the new data area where old data is not reachable.

Once the parent pointers are fully up to date in the active data, the
'dead' subtree is iterated to collect entirely 'dead' subtrees, and dead
nodes (nodes that partially contained reused data).

Liam R. Howlett (6):
  maple_tree: Add hex output to maple_arange64 dump
  maple_tree: Reorder replacement of nodes to avoid live lock
  maple_tree: introduce mas_put_in_tree()
  maple_tree: Introduce mas_tree_parent() definition
  maple_tree: Change mas_adopt_children() parent usage
  maple_tree: Replace data before marking dead in split and spanning
    store

 lib/maple_tree.c | 607 +++++++++++++++++++----------------------------
 1 file changed, 240 insertions(+), 367 deletions(-)

-- 
2.39.2


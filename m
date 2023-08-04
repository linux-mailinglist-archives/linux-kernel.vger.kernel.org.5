Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6854D770689
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjHDRAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjHDRAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:00:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B861994
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 10:00:34 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374EiDF3002950;
        Fri, 4 Aug 2023 17:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=u4CFjppFxp9l2MaITKNmsStPN7oSuRkt18qYVROXvto=;
 b=eYdumrFqyYhH4qPEX/i+0YDHILjZdjdwZj3bHwLlv32izcpXTLGhilcy2fF5Co/3iCiw
 aVkeL6r3J0RATkpgBR0bujYMoDSYRUaeWlwQqjeH/W630tev1HsNVkZhkvld2/R8KaGW
 wWe/APJEzeAj8ZQcyRwbzs3UK1fc3F0/0focCN7gQoa20jptC2HQo7PrcAODHBoyRYme
 fo/cn44Esn8384iYmK6PL8/0fPJJaG4uVJX3je+ht4KavMzGkdXpslBlPw20L2peoDvC
 KeCuDrWGwDVX3m3RqyI57CAORTrHYFdi3Jzt/v1KqgCmx8XuB/LZpGKoGFQ8U1XxyuUG iw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4spcc9v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 17:00:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 374FJgoG029618;
        Fri, 4 Aug 2023 17:00:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s8m29bmtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 17:00:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrVIitj3IUCky6F5fD9u7X31poirUjinnNhoJVR6qh7boNn4gHkKYGtr3oldmApl9+QtXGkfBR1GpplbaNCf55ECuR1O8FaSRmv1c3gd2vo2oSivfqlP2gwBYs2Q/bj5NyAt/gtNcXfMY7aieIw5s6bojik+acYP1wDN+w0euQHheE91o5SCefMaFfAR58PwK7vV1yIDnpMyxmDrSfYm21mnyBQXAPg3MmH5PrLseergrOtcj7EeOFqE1L01gbWn84j15w9plfop9Q0NDCpQPSca/UKIc0mj5S6WLYpeXJiq4lfu4kdah8fZP5JEJNowhANGs3odCEqH1t9XMOLy6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4CFjppFxp9l2MaITKNmsStPN7oSuRkt18qYVROXvto=;
 b=g+qWeLZo7usR/KWrSY8m7wNw/O8PO32pRdPAb3IQ+BLjWEtr0PBRvNTMiNEULDjobaGBy3UeUGrGser5pcdQWcP1ZSJVwOWBWKnNYAGqjjhfq9v+oeYI1ULSZaDGr+B2LValyRV5QdLClJx/epFkdDSlrDOcxI7NvjuoJmN3+TveQ09OAY8utD9BA2c/ieReLlxQ+/0MW/LU5ykwwhs3ZiqbSGEYHHIWy6j/Rg80oCTN4afS7B+4RVUv6jANxfN6UFhif5w0hHPSAkGu63J8MMHGLZiJzJvl5Jx37dhKmGC+QAGA94OIY+JHYgffaHyrht75kIBWD+TbWTF1FxmTeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4CFjppFxp9l2MaITKNmsStPN7oSuRkt18qYVROXvto=;
 b=QXSeBrbrKegpOXrUs3h8PJt131fnQ//0JVG3wkyVS1+2FZevwMwGek/RUUHw8/0yJNpyXtuEY/SFD6MiOXya7/9ltPCsSqExsycdS57/tygpK0ALX75A5c+QH3TpQ4m1UZBv5mMCDWdmQXEIWteq9DtsK5uQxK2v0jF+IJyEsJM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4939.namprd10.prod.outlook.com (2603:10b6:610:c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 17:00:17 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 17:00:17 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 2/6] maple_tree: Reorder replacement of nodes to avoid live lock
Date:   Fri,  4 Aug 2023 12:59:47 -0400
Message-Id: <20230804165951.2661157-3-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230804165951.2661157-1-Liam.Howlett@oracle.com>
References: <20230804165951.2661157-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0456.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::20) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: 7868e07f-7abd-4d31-c7b8-08db950c4708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pVgEEq0a7N5gMOXBNiGz/MvTEkOsQAjuthf3BC/2wAOiVnKwxuj12rBGIdT/iJRG7o0wJGif8PxMf/SENfbpHdStJ0Anx9ivwtF0lAyieyxLi0RoikmQas/JFlpg85708E5+RM/WU/CP3a9+pHjenecAHs2erzqcxEukTo4uIME62phS9gPAeL+oAAi1Tx6b747eQ8RswOqy8j4kOhDncCU1duQ3GEWX1HEUQ2wDVERLrDkK6OQFm/EgVE803EPNtPUSntQRmE9Z8EzqXOgZBTveJBf+4OmqtOkWSW3Y7hyB0RYy2XYcvGW+ypjtVv7FsPsod+Y10QabgJUVla75xNydicKyPewigOU1VeaLWmiuCvVBowW2FN7mBvt5F1qismXeOpARm6hjIXzSqhNjzLZiXdG5eRAvai/i5lKi0xCjxNnuI0ZNTkyzM1e53LdUD2aLidfqbEotIuZp4po2aqTM1JhenlwZOQk3PoW0dKd+AdxLd2xK4WRfBvtkBjp25Zh5USlLFx85ut3U5L04xBuEST/e2qzBlwO4esd+UpeGIuqTaWg/+dgcBtmvfQcp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(346002)(376002)(136003)(186006)(451199021)(1800799003)(6666004)(6486002)(6512007)(86362001)(6506007)(26005)(1076003)(107886003)(36756003)(2616005)(83380400001)(38100700002)(5660300002)(41300700001)(8936002)(8676002)(4326008)(6916009)(66476007)(2906002)(66556008)(66946007)(316002)(478600001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9M437dGkuFLrkEsKZm60ZHDhqnZ4k1Ek39n/DcMvvfmmhHqen9lgsQkBznUh?=
 =?us-ascii?Q?WQPN0ssUPggLJY65NJc9bRao6a6+aR+fLgEyQ5DVRAqaTVpsPvylYgt3UoAX?=
 =?us-ascii?Q?TF3kza6/A8PRXoE3JchOFBsE22pbM1aokDzdaQ399rHJ6piIo4SN4Jro5pzf?=
 =?us-ascii?Q?L2iW4JOqif7TDtPU11I9WYRFn1ZmGSw7LUV4zPtxCzpxSx/FbRuFUK3C6zTZ?=
 =?us-ascii?Q?h4EXl4tgk9Ux59mrTc93i+Gt9t0bDHHpXXNCh0isX2wKKZmCIQmhPOwUx0ei?=
 =?us-ascii?Q?uzBdtGI6tUliuRdX+Nufg/7vZYJpCyhpY+6xCDW55TsVHFKaHf41DZ8t6SA9?=
 =?us-ascii?Q?kSYQI2ISP+IbFJAfYK8vMF5VaWp5HxukVGRklxL37sPVkTthIhwkLcHRq6TX?=
 =?us-ascii?Q?o0C7BJGPyuQBkzie6ZbPoJanqwaOqU1b2iDbuyMtcjCXl+Qmil4+FQBBhZPf?=
 =?us-ascii?Q?nvl7Rf+suq4SyXCZE7u7DjsXFFuiZ28UHRWnv1AcX6Eo5CVoUWFbQ97/kOr/?=
 =?us-ascii?Q?eAfCeCKeQWEskUfjKkrxbQ4HK22hh9SMtP4NAMe7mXogjBQ57xjPwBJA3VkY?=
 =?us-ascii?Q?ZtjFWwRqn9LhKLimTTDQlBtnhkn+/FjBc/QDXfBERfrjoBx5rr8LBMk3Lfzw?=
 =?us-ascii?Q?6+yk/4hi2cjnkf9ZMRSvtyB6dcPaS5jSiAoPXMJgyT+giKvhcyYBnQ/lfkp5?=
 =?us-ascii?Q?F2kJH7unYj6DTjCrD/YQJotgq8mOgbT2jl2RiEQ0NXepnWVe6oJEHZiAxhCW?=
 =?us-ascii?Q?NB3XfPRwBCYOkJVjVs2kJmVgN/1dPeELJwLpzEE6wuz8jOEVa13DYxWyYeqO?=
 =?us-ascii?Q?lr64KOUI2oEWWijoT/+MBbf9ZpeTEveBiptRVhnHArZyg6fJonHOPgR3OkrH?=
 =?us-ascii?Q?Ka27VfMhfg58bv8WjoalVZd2l2fPDgSkOt/N/PtJp5CV8ptYzDer05A37WoY?=
 =?us-ascii?Q?XVSTK7ZumK1r7VspSeFXPfWqH8HMpN32cXq+3f6dW5t+ifpOu2VCL34Zqt+L?=
 =?us-ascii?Q?ODvNLN95i6fkUZBChD4XF7FKAWQ9PPcbg5PHXZCBKbbLXudF4zvSRuBYs8AC?=
 =?us-ascii?Q?J4T+YR3gj2hkblizjBmUHXd/7lHmPtxXNh0HEAcrgkrH2J0i67CC2zMvTsB6?=
 =?us-ascii?Q?yefYIHhNJpTME6xzLBRWO9JLK4ulKz9G+FyF6yXoA/UGeaGTISJVxGfkE7ZE?=
 =?us-ascii?Q?gf4Bb/s/0wI2ZKRLQvF70BIW8sbAGJ4JRRPm84CklbejC0MDre7vJ+ERKEra?=
 =?us-ascii?Q?Om6Mxt+WW9ini8IeO10+r/AsUBlYyFgEdOQQfi69Vk+yPnjzS+yrTbXG9XKr?=
 =?us-ascii?Q?j9uN03JZ4PjBgRRqy1da0my9uSP7BMC2Y/Q/M63dCb5BDOtDNxS4xcP3L+3J?=
 =?us-ascii?Q?VkbRnhx/WpwY8raBpra3tXbVdC2mzvYM1WZCTXSQSKQYSCdKwYgJcywC5L4v?=
 =?us-ascii?Q?A4NdV0jpge46ObT+A+gxUz2wPb2NSaK7o83q6v/mmK6tDl7sWogvdKyeMcFX?=
 =?us-ascii?Q?5vbvFFEZqkCa8igcghpwfhyl0ICoz7vlMvDTw2ajoQaO6jmUwb7ppw78MwTl?=
 =?us-ascii?Q?YHq//iGUIbNop3rliQVq/ElF+HOvq2AcPTQ4Ndtk4jRC0uXBKQD8Ey6exvI7?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?CjbESMqePxQ4FdHqzZwDtl2MTFv/o2ikj/vHXfTRhmDFQMrjf4LRzbxsGNXn?=
 =?us-ascii?Q?6oOqHee1Vv0HdMhJGCwq4Dp5+wePmhm75n0EfZWwCCKRRAW/5a3+Uuf+jQ4x?=
 =?us-ascii?Q?pDZKRo83vgBQW8u9RpYKSl0NaRKRpt9Fxv6gBlxNn6lbPFtZx+/bs5OMESZx?=
 =?us-ascii?Q?sVMAHm7U8FcDLgm/rNNaDFxFPi2UlP+ilg24ktEY09hVsKHIhe80ruNDzAKm?=
 =?us-ascii?Q?jSUwM4E+HHcEHYI9yenF3yNd7F/DhUZDSoKdyZ7T9xMjl1LJE2aidXip3Kz/?=
 =?us-ascii?Q?E77pOh8cVvMUL72oiYrJKrKAeD3/eGxS0dm7K9511GOiJ2XsB4ZtzFDwW9e1?=
 =?us-ascii?Q?ERJV55rpZRjC3+szofg3jCA731H6g1cv0aSrfxmFQP05n9wW7wSqrI99koFB?=
 =?us-ascii?Q?Gi6CuzOsb5GYq+9tsmM0d+7uwWe4BWhBwUHL1nCr0MvXYVC3kBSxfoqKsU16?=
 =?us-ascii?Q?n40peWpFwsbHh+0FAfPTQDXWmfKhLCntrskeIeeiWpQwqGe0ZQzWFwBWQl6o?=
 =?us-ascii?Q?E9k7l+CqNLxBoiHyOPFRQ69ZPir4bL3K9RH7FROdeodfTOZxjm7aTRPWLNvg?=
 =?us-ascii?Q?3wwIXnnswmAkPhAYXWSfmU/Jax0hf13X9EBoSXG7zujXQVO+l4cc63sjY9R5?=
 =?us-ascii?Q?+kgsWJancw8YnsQuXeLCRiS6QfAoOJ0ZaHh4VW5BGXIeuAjKOWS44OWP4Nu3?=
 =?us-ascii?Q?OEOp9xwavfdoj3cmcRnhpA2wDPjZI4FhhJ4ylquiIAdxSYjuY0ybTntAgLKA?=
 =?us-ascii?Q?MbUIq2nOQvr5tfAGMr6X2B5bpV0SVGVFxQyUZR+G31uTNfJQOG/z7GMJ3Dz5?=
 =?us-ascii?Q?qApTs8KpdHJcdjskXLfwj+b7+0S9e6ENw0bZYnG0768jhnTXkC5DtMwu+d1F?=
 =?us-ascii?Q?3ThYpBGl6swLo9oKdceFP4h5VIVrO6Qpv0t643KpnFmCM6GsHMeVlYXOfeQo?=
 =?us-ascii?Q?gwZT6nxuse3258ASp9VSzpizAi3a0PY7Lfo465+LeBU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7868e07f-7abd-4d31-c7b8-08db950c4708
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 17:00:16.8120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yM3cU92b+h4k4v1Mw/dw1AEpX6lRMpISHE79cxFSFCWGY01YDO3IciwNy+9BK7jXeS1Zfot69NcufnbUcmpocA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4939
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_17,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308040151
X-Proofpoint-ORIG-GUID: JL9Ja1WvvKDzbuFLUnp6brBA8IABs5-C
X-Proofpoint-GUID: JL9Ja1WvvKDzbuFLUnp6brBA8IABs5-C
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replacing nodes may cause a live lock-up if CPU resources are saturated
by write operations on the tree by continuously retrying on dead nodes.
To avoid the continuous retry scenario, ensure the new node is inserted
into the tree prior to marking the old data as dead.  This will define a
window where old and new data is swapped.

When reusing lower level nodes, ensure the parent pointer is updated
after the parent is marked dead.  This ensures that the child is still
reachable from the top of the tree, but walking up to a dead node will
result in a single retry that will start a fresh walk from the top down
through the new node.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 56 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 880ce0fcdcac..0d4573a8d134 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1756,6 +1756,36 @@ static inline void mas_replace(struct ma_state *mas, bool advanced)
 	}
 }
 
+/*
+ * mas_replace_node() - Replace a node by putting it in the tree, marking it
+ * dead, and freeing it.
+ * the parent encoding to locate the maple node in the tree.
+ * @mas - the ma_state with @mas->node pointing to the new node.
+ * @old_enode - The old maple encoded node.
+ */
+static inline void mas_replace_node(struct ma_state *mas,
+		struct maple_enode *old_enode)
+	__must_hold(mas->tree->ma_lock)
+{
+	if (mte_is_root(mas->node)) {
+		mas_mn(mas)->parent = ma_parent_ptr(
+			      ((unsigned long)mas->tree | MA_ROOT_PARENT));
+		rcu_assign_pointer(mas->tree->ma_root, mte_mk_root(mas->node));
+		mas_set_height(mas);
+	} else {
+		unsigned char offset = 0;
+		void __rcu **slots = NULL;
+
+		offset = mte_parent_slot(mas->node);
+		slots = ma_slots(mte_parent(mas->node),
+				 mas_parent_type(mas, mas->node));
+		rcu_assign_pointer(slots[offset], mas->node);
+	}
+
+	mte_set_node_dead(old_enode);
+	mas_free(mas, old_enode);
+}
+
 /*
  * mas_new_child() - Find the new child of a node.
  * @mas: the maple state
@@ -3176,7 +3206,7 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
 {
 	enum maple_type mt = mte_node_type(mas->node);
 	struct maple_node reuse, *newnode, *parent, *new_left, *left, *node;
-	struct maple_enode *eparent;
+	struct maple_enode *eparent, *old_eparent;
 	unsigned char offset, tmp, split = mt_slots[mt] / 2;
 	void __rcu **l_slots, **slots;
 	unsigned long *l_pivs, *pivs, gap;
@@ -3218,7 +3248,7 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
 
 	l_mas.max = l_pivs[split];
 	mas->min = l_mas.max + 1;
-	eparent = mt_mk_node(mte_parent(l_mas.node),
+	old_eparent = mt_mk_node(mte_parent(l_mas.node),
 			     mas_parent_type(&l_mas, l_mas.node));
 	tmp += end;
 	if (!in_rcu) {
@@ -3234,7 +3264,7 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
 
 		memcpy(node, newnode, sizeof(struct maple_node));
 		ma_set_meta(node, mt, 0, tmp - 1);
-		mte_set_pivot(eparent, mte_parent_slot(l_mas.node),
+		mte_set_pivot(old_eparent, mte_parent_slot(l_mas.node),
 			      l_pivs[split]);
 
 		/* Remove data from l_pivs. */
@@ -3242,6 +3272,7 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
 		memset(l_pivs + tmp, 0, sizeof(unsigned long) * (max_p - tmp));
 		memset(l_slots + tmp, 0, sizeof(void *) * (max_s - tmp));
 		ma_set_meta(left, mt, 0, split);
+		eparent = old_eparent;
 
 		goto done;
 	}
@@ -3266,7 +3297,7 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
 	parent = mas_pop_node(mas);
 	slots = ma_slots(parent, mt);
 	pivs = ma_pivots(parent, mt);
-	memcpy(parent, mte_to_node(eparent), sizeof(struct maple_node));
+	memcpy(parent, mte_to_node(old_eparent), sizeof(struct maple_node));
 	rcu_assign_pointer(slots[offset], mas->node);
 	rcu_assign_pointer(slots[offset - 1], l_mas.node);
 	pivs[offset - 1] = l_mas.max;
@@ -3278,8 +3309,10 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
 	mte_set_gap(eparent, mte_parent_slot(l_mas.node), gap);
 	mas_ascend(mas);
 
-	if (in_rcu)
-		mas_replace(mas, false);
+	if (in_rcu) {
+		mas_replace_node(mas, old_eparent);
+		mas_adopt_children(mas, mas->node);
+	}
 
 	mas_update_gap(mas);
 }
@@ -3596,11 +3629,13 @@ static noinline_for_kasan int mas_commit_b_node(struct ma_wr_state *wr_mas,
 			    struct maple_big_node *b_node, unsigned char end)
 {
 	struct maple_node *node;
+	struct maple_enode *old_enode;
 	unsigned char b_end = b_node->b_end;
 	enum maple_type b_type = b_node->type;
 
+	old_enode = wr_mas->mas->node;
 	if ((b_end < mt_min_slots[b_type]) &&
-	    (!mte_is_root(wr_mas->mas->node)) &&
+	    (!mte_is_root(old_enode)) &&
 	    (mas_mt_height(wr_mas->mas) > 1))
 		return mas_rebalance(wr_mas->mas, b_node);
 
@@ -3618,7 +3653,7 @@ static noinline_for_kasan int mas_commit_b_node(struct ma_wr_state *wr_mas,
 	node->parent = mas_mn(wr_mas->mas)->parent;
 	wr_mas->mas->node = mt_mk_node(node, b_type);
 	mab_mas_cp(b_node, 0, b_end, wr_mas->mas, false);
-	mas_replace(wr_mas->mas, false);
+	mas_replace_node(wr_mas->mas, old_enode);
 reuse_node:
 	mas_update_gap(wr_mas->mas);
 	return 1;
@@ -4117,9 +4152,10 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas,
 done:
 	mas_leaf_set_meta(mas, newnode, dst_pivots, maple_leaf_64, new_end);
 	if (in_rcu) {
-		mte_set_node_dead(mas->node);
+		struct maple_enode *old_enode = mas->node;
+
 		mas->node = mt_mk_node(newnode, wr_mas->type);
-		mas_replace(mas, false);
+		mas_replace_node(mas, old_enode);
 	} else {
 		memcpy(wr_mas->node, newnode, sizeof(struct maple_node));
 	}
-- 
2.39.2


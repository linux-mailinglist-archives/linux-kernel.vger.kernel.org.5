Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D25E781628
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 02:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243978AbjHSAx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 20:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243431AbjHSAwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 20:52:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90D944B0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 17:44:21 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IFnlHj023107;
        Sat, 19 Aug 2023 00:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=i+HU5Hf6zjIW6IowZMGU4MJxWA5ebglQke5MHuyoYdI=;
 b=OTto7UsNz5Y5DX1zoljuzWVB6aaYV3uA+cFO029fsdzlBBTJ4+T6DctEtcQHtV79GkMR
 a+w7l4SyAowsdGGvMG7Nt/YUd0dC9MKkEvQMrYHrELa7SLpUEZNfWS4SG2+jdBYSaQli
 WUZsdxLZbE8+QEU/QAXdikGavMkDqoEh6HTngrkKD1LJ5O/UzRIkfB8h8LpnC0YOKdA6
 5uSXhNtfq2fCms50g+AKZ381GjwGCk4i/G0A9il8Wtu6JE3SgyfUjGqvSN0dVoxcp4Fe
 5RP2Yod0WMGzpJQmifWhetSRbm2BrJIOa+2ip24+cgx/0k5G5qtyQzT0XmgNm8HwqYrV /Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2yfvs3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Aug 2023 00:44:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37J0H5Q3003884;
        Sat, 19 Aug 2023 00:44:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sexypjm3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Aug 2023 00:44:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ax61+l0ryiknnVInrmVWCwkCvVvc2fzDuFlri1vPxZtdmUvxUldrx2idtRb/iQ2DG2CxjHBo9kUiCX20UjzdVzQ1NRVxkW7Pxb98j59alyIm3aAy/4ltXkl+oTFaOmPJ6o4DdjYvkBSgBxhVT0Stv9P/UAPoM+CIlPnp+3fKNXEu/cmTTeapIg+0O3zNCNpZA6qYCj51l3sF382ptvaW/k4xgiYwb8hHqqtBGr84MdWj281njF8LjzsAJ5N3/DfAIMXm8ocuDUAIpmqVOdMLvA3e8i0u732EgRECaDsX/YFvsHs7dQ/j+aSC2UXM62wsluPsJ5JTulNv1ZPVy4OmGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+HU5Hf6zjIW6IowZMGU4MJxWA5ebglQke5MHuyoYdI=;
 b=doYwo/X2F+JoJUMl4PNHhjxACLtWMOpaxPsSrno4WBh8il+uPh/n6qTNir/OvTDbrHBx6WGII2Jcnyv9H9P/5DH1hUA+j/vhswRgoPOVXnMYhPp8bIFRIlp6wO0sJ15k4rfJ/KGL+NWbOUqqRO+DqRYQbwfAdEeScZJ7m2fQVpn4swEgO7zwj7g/MyrdxmfAKGYWTcHDdwUTEJhAZDOk8kRwxRNLyj362+MQyT+ordZrrBQrHfwEx8JOC4tI4O8Lh10sEl06OUOWlPblQu+nE1dpEAio917m3ustUIKOvXzvXcZr0wyHsKPNuWmxOFzZ/OmFO+WjQdLd1jrVbYUo3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+HU5Hf6zjIW6IowZMGU4MJxWA5ebglQke5MHuyoYdI=;
 b=AAtTTzW7ThbbuW+o4qKzV5A4Dm4pREZkmUfQWdsK/o8PtlYJRUWH/Jsk/P5aoG9nZn7sWSanpk98VIM1JsrHKIkfwWhNgqeBUHKSMFWajamBCngtKJv3lkVGWFC9/q0Uw/qZv1Qwp4jhpoVsK114FHwZWmLl3M2AFbU7LNxr+sw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB7167.namprd10.prod.outlook.com (2603:10b6:208:3f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sat, 19 Aug
 2023 00:44:05 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6678.031; Sat, 19 Aug 2023
 00:44:05 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 0/2] maple_tree: mas_wr_append() fix ups
Date:   Fri, 18 Aug 2023 20:43:54 -0400
Message-Id: <20230819004356.1454718-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::27) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b19956-16c7-4308-5df2-08dba04d63c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n/hOS3HTBHIlPfoUZ2kcEyGPU4nlM27xTjcMRbM3fCrtYFfBD0rRZW6bc5FS1Co2Y8uRKIf4f8/RqrJWeyBK9/kPCTdIgbqVPveLkoNTCI04HvgF8+HLJvkqC9AuRIQG1zsEw8i45MbZ9bAZuWIpRV7R07BJ7RwsRoKrM1BP7uOGS66cQpGPJ9VeB2+PZY/DIQmadFRUQxw6ElaKFjTTmqfOgR7I8e2m88xDv43Zzm+VeyrtPkc83u2WbhZDM+wzJVFhDewzgDTR3uJqn4IwjDlK/mlURmg0wPId1LPs0i97u3sixii9ae7YsV1Sk1MD/+NcpgKSANbVLGTIXmBz6GxaolmNzUMiQ6tnaW+qc1JsMh1r4OqMvVakpujnCTvBezAm68XaOjs26OoY4pBBfOqHB+vyLLk3C0XW21TSQMN5pFpdxTkySOkfpcCmo+8JydkDxDVYfgzyn02UWBbpbT+mtC5OCMZigOGwI+Q6exfwSPON+pZ8x2lj/mM7TEJF9O9DfRQj+YfMEq9mtqWgVpC2wfP4MO5pOInoE9c6JeQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(396003)(376002)(1800799009)(186009)(451199024)(6666004)(6486002)(6506007)(38100700002)(6512007)(107886003)(1076003)(83380400001)(36756003)(26005)(2616005)(66556008)(316002)(2906002)(6916009)(66946007)(66476007)(41300700001)(4744005)(86362001)(5660300002)(8676002)(8936002)(4326008)(478600001)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nPjGLqnpp+A11w6iOagsH2Au9VWpgkfzmfObEsJpvM8eiSKEdmDg7XUgtqTP?=
 =?us-ascii?Q?0416GWViRXGMijA5klHheJuBad0EVTRxavayGFV1zVv7Sve2c7FRjdckIC+6?=
 =?us-ascii?Q?K0/loOarLEnNPMijfFDuNbuQOv+eegD8NbtITrr+BRjbVf+H+yzhF6NeTbFR?=
 =?us-ascii?Q?Ko+iPhE33B4JROdKRTZ5dhXPArpyvunqsn/UK/I9a1OYEY1c/wCF8xa0B6f4?=
 =?us-ascii?Q?1dhAtKjFYoreJWiHBlrXLH035MeVkSa3Ymcs2zLtPLBigs8wvqtPtYMc1lvu?=
 =?us-ascii?Q?ZVjbeT/V3ckL1yiO+uFwW5Ah/OYOZsnSlrR0O8hOdDvuSb1Mwvltyzlh/QTI?=
 =?us-ascii?Q?hZE0uOMx4E/XIzjhyATEeKxtMCXEbmZQSAiVBo/ZR0FN+1gjCiB4Q/powxwq?=
 =?us-ascii?Q?np650mHjQGMIuBgnm+Xs52kLAIYXnT92Dg6oNzXwT/ktEPbLNGgj1cYMcNiO?=
 =?us-ascii?Q?POMTt/kiq+5XfubVIPhSDcqiW0R68MKSAXmh7seS9FWOP9CZqDUz9coc+8XU?=
 =?us-ascii?Q?h9LJyUzlTb2SorNWTLCYG599Cu5HIStYR1ABGyp/jTiGpNWPTEmKR4tKWcXU?=
 =?us-ascii?Q?0QV//jrKMroOGBjmmEUzD2zL9Qy+C0dl7PjrOD/48eQy6G9s9vQ3uJLULqHL?=
 =?us-ascii?Q?SS4mnvEM3ICN5xHUOeUq65erv+OdORSJXmfJ++jvX6pXnKkPUgIUoVCDzMrc?=
 =?us-ascii?Q?jrNzUMV7LtgiufZZzu014lx82Tj3BOaAyGWB8CM0KfAqhazt7iKeyPxPhhHH?=
 =?us-ascii?Q?TSQdsvAb6lLoaOZrCiLGLPNLb+3Lxq04zG1Mmewq4zD288yH5U+gGawcXJKu?=
 =?us-ascii?Q?S9FtBghuqcLQGs8Fb9u86P+hTF7uCwK8x0O6siaLK+WIZ67DdV/zRbIXEA0f?=
 =?us-ascii?Q?nxbe0JCZNCYDHpM3BVkJvOKchyOkjyWnBdf5+UYK50oP1VELkIhx/A+zDQQs?=
 =?us-ascii?Q?O/NyLe1AVsqCvL3paV4/pb1Qm8q1mZZrfne/q2tLSHdtHZjo+ltFBgQSW045?=
 =?us-ascii?Q?WAT5xhBUMwdwd3dCLYtMpIft9opxP/9/oxM4eSBCtB2FYBiYbXlGH/cIoQ7M?=
 =?us-ascii?Q?ZxOyAuMNYpW3ZmfM8lG1zwhZYYCQ1aTmU51q10cUZEtT63WXwDE0idwT6T7q?=
 =?us-ascii?Q?J6UAvVnGiVBOMXvTF7oKIEMK+EAWEoP9x/yqpirc08VquEoMCdjztyWLFQ7W?=
 =?us-ascii?Q?eVg2hCQyw7426GlWG0eoK9NBOgBf5BTJPxlikSZl8W/3y2NJS6DHYMx1MpBO?=
 =?us-ascii?Q?yT5JQA9rCjcKrAjiyCoGTINwPr3nno1Nf8lLjwql/7IBpdxnd+9WeXj7V2G0?=
 =?us-ascii?Q?oKAHyaXIv+R1c6JYs1d8A56VyAUK67oZWJ3VgZkxXmH3q1NT3GqFNSp5K1ur?=
 =?us-ascii?Q?nbsB6VRgcY6efF1wliJs8qVNx6l6SriYwqaS1m6G2jNKWofgMdOIHQscrho6?=
 =?us-ascii?Q?ZpO7JiHyBr3f43OlYoLmhjIXrXq5UmG3eBjsmkI+EpntGoSkaMJOLy9wo4RR?=
 =?us-ascii?Q?OtS31ddWf79gc6QyJk5O3TA+vSQcW67S2dpsIaAKvFmbcc1YCcWEjcBVeiYB?=
 =?us-ascii?Q?U47WEjaULRUw6jTYGThwKeQsq6a9yYpdVfTT3OrT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: V+Y8firEWhzrSBZQWnzOuR1cvShf56KVlxjLZu7Nfzbmr1EbJogvzaR15P54GPzm+Re1h//QwYj7cLGGrgaCrEND1oxDHh7iY81AYv323H7ZfKWBvLRrGhiHfN6Q5yz35NPwM3PwBtx8UdqjJOGbuYu5cgEvVnBL+0np+oUieWsdCMPI3oehgkxUSaEBQnz4tpBOR/Hgx6KQKgTQ6QHmMSezyh3yRbX46ZHwz7v1TTa3c3pd2u2jZXRnos1XuS4bLCY/p2/+dhx2BaAhlDducxbWylpCf2eDO56d9zrJaOROTovj2OHoQXGY0/ktBAVxoyULXihBqWHiPCY/t1RrvjH8sareYCaxmsjW7Bjq7l8j1boZ2q+0F55F7VIKofD/lNjwNLKq/2I6ySA/TVwRcNRmxsVdk4gHKL/TgECdu9YYQFt/Fj7osB30oT2JQgig1eE6JvdFwAAg0oMp2ykDCJlxElViCz0as7ILmaPMd9W2C7CJRiDkImLR/KZ1Pjso9l7mOtT9AxpgSJOIYAmBUhzxXjon2yWr9K3um0okPZbzBWoq5M6EyS8lGXhQJpjEV0fUBaLiJZ3zvRzQGqXoPeXnbuK+gLLmzI1/Nu3VN7cf452TLDb2QEoN16yvK5F2r4+MtvUw1u1UXTvSJFVqWbV1cqG0kRgOgxFG6CMegLjzPSOkOm7aSrYxIwiUdTQ1QZf/Jzu3kyJCcy/hqdqqApxfLmx9JukeqAE1JaaKBSRm1T2oUcai28OWHc8caO0RpWEjvO/Mp0EOwC/5JwM+9OYJeBjMcsVexB8Lx7P7RFVM6swe5Byf5RjYupMUjr10dMlKv+714Qo0HuxOcHbodQVFh34ch1un2ojQ53TErP4t8SxKXdEV+kZF3/RNWmp1C8p5zA08vbP0/59NW2DT/Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b19956-16c7-4308-5df2-08dba04d63c2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2023 00:44:05.1665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5iiPL8ofTUirLCo4bQJ9Gldh/D2iM50cpSMl4lkKgA/HCX7g50T2I0/YslRbnR4LQ0l8MQtLKKnVOxLJA3FHQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_29,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=468 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308190005
X-Proofpoint-ORIG-GUID: -YkngMy91vgSNZmFXRWud9Gkd3Kfg94J
X-Proofpoint-GUID: -YkngMy91vgSNZmFXRWud9Gkd3Kfg94J
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a potential of an update causing issue with a reader when
appending, so disable the append operation when readers a present.

The code was also missing some documentation, tracing, and some cleanup
was possible.  These changes are in the second patch as there's no
compelling reason to require a difficult backport.

Changes since v1:
 - Added fixes tag to the first patch

v1: https://lore.kernel.org/linux-mm/20230817191505.1170876-1-Liam.Howlett@oracle.com/

Liam R. Howlett (2):
  maple_tree: Disable mas_wr_append() when other readers are possible
  maple_tree: Clean up mas_wr_append()

 lib/maple_tree.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

-- 
2.39.2


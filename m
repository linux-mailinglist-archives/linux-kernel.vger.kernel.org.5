Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C63D79DD4E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 02:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237994AbjIMA6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 20:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjIMA6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 20:58:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C34E10CC;
        Tue, 12 Sep 2023 17:58:04 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CKePZw003307;
        Wed, 13 Sep 2023 00:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Sna73Ly9yn59bFkXBPnNZeV/TPCpl2hhnd2KgPROqDQ=;
 b=fS0XXa9b1lP5GuL8T4XBzuwZLeMA3vtU5pqCByxWToldfoi65uHdFFdRbk25LKibaPR0
 juk7v/BFEBBDzSo20BdjBQZGr3LHRxs+a1aDccQMnLCTGND4dt97X21DpqRMIGXmDTgl
 4C4IDqditaG+zR6NAqbwXyqwuAOFA/2KBZfSSNRNzEV5cQOd8a+dTCIL3iHsJORJTaCb
 a2hyIkOeApxauAzDd+duzyO7rgaPOOTiDTNJd+HoxmfQblwcUf0TU/RJfOgvpILL4eLz
 wkQERzvXWHAOuhYzOQxzoQF11xzq/q/Om636zRy+7VkD4MITkpogWYXdS6ioJdvZBY3w 4A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7r89ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 00:57:19 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38CNkk18002750;
        Wed, 13 Sep 2023 00:57:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5csv2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 00:57:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KN0cOP20F2Hy3h+IM/eqy24aV6hTXF6XX35Aw9QB2aFe/SsRGKYggVKzFeIFVXyJYU95fq9ZWyeBDoLaZT8keOmMOzkH72K5eI6uetF2MS8tj9CVQfygrnkzKt1+3FsDJneMX6a6SqV/3cch58iY5sIj52k1g1jDkJjtGDUfvxu4EtQyR9UTQb5qOUJHY2KshQOHTfdnNn4S8fGzleMJxRTdlxEblnXLi+6IxGFhm3d4P29jXo7C7T8rRUs+3AMDHV5fl2ab8BWce6NQLvh/nscqlyRpBIBUn0V/Mv4tMEmyE+eSTDGtEURFPi9QVa07tTEy73QazFlIvhnOFPkOgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sna73Ly9yn59bFkXBPnNZeV/TPCpl2hhnd2KgPROqDQ=;
 b=RhMYBEYDvdxYjwiRT+TGpj7GN60FPmDvH3Bjys6oLlfW/lQRVWWKl4tEiLUa+p5B3CQU/eUdMReKixhZSoGGGRkWKnxKy0fOgkYM0QPneG64HWlckGBIUPkmqnuwEgIrU8CiT0OhuSQgmNg0/sxft01Ab2s82sHmr+SVKR4n9NPF9ziKfuAWjeCShuiCnUrqBPWoqSTDoqkRWHuJSSovzfmfUpRPTQ6W1qzi5pBSn+z59sADkZtr9MphqDhR2Zdlx0Cn4hUzyMH3F1/5qw+xBwMU0ira+LDfyLdvFHBGNwkQpwRpKBQvkYAwNt70OewQGCdwfi5uuZaYef96Z54IjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sna73Ly9yn59bFkXBPnNZeV/TPCpl2hhnd2KgPROqDQ=;
 b=eXiUXXrCTRr2KvdGAN5GGVq2Yhb9CgZMaHbpSsc91pgV8UJ8/bx3MBbSAJeGySGC6axnpiWuZdQ+TFku+bE54xpyTj6FKr4HVO3acSpvpNgFkzMYxAJi1PZ6EEtHqNeOYZkXq0mvjWy13hlUy9q8mQ0cMMH2KEyJ/TVjmqsXMHY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4307.namprd10.prod.outlook.com (2603:10b6:a03:212::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 00:57:17 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6768.036; Wed, 13 Sep 2023
 00:57:17 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        stable@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] init/main: Clear boot task idle flag
Date:   Tue, 12 Sep 2023 20:56:47 -0400
Message-Id: <20230913005647.1534747-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0078.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::28) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BY5PR10MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: 23891183-d736-4095-4e22-08dbb3f46016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mAjRe6Itgh4jV8uc8wZK6qT5w9vt/DkMUsl/2v1T+62n1GZnz0yyj1lcP5vImpOIbH83CMKQHyH34qoT82vbGx1huUgcllb9va3SR4pbCjvWGryM+KphkO3jKOLrSQ19L5bWR8WaFQBKoF0mftuqren/WWfOQRoCVosOC4UsMh27dBFxwAKU1UnBwFYLUX+nFdWaV08RT97avmk4ZePH4LLVXsjt00NvacicLuWGOIAiTuEWnXjjRrZ3Jb2JthipcLI7i3E879ReCmHkRAJB6QftiudlJfXornlD8FGwYvdD29djtSVbOMxn30w2bubr8qDXbnjbo9Pmy4EnmMnaChVLMN5V3/8GjFkb2aeWzeBqQQkHg6hOMqLP1LoBejITCBDtU0LdFnh+N+zFRCiL/3ndUnRpK8OIcnpmIBLnOiYh+I8h2/t3n1Vtx94QHxJISau7VhSRrG8dHspjm20vnd1hrAzHGwmFprLvJs0M57FpH+TFTEcpl5ghBR9kgsvXk9j6zW93l1lgnlDdK8RGryt8bRGR3O0SEodss3gYdN/XK3c3MyX5GvdGzo5/SH+rNbgcJVli61WI5fuax381Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(346002)(396003)(451199024)(186009)(1800799009)(36756003)(26005)(41300700001)(5660300002)(83380400001)(86362001)(7416002)(8936002)(4326008)(8676002)(6506007)(6666004)(6486002)(1076003)(6512007)(2616005)(478600001)(2906002)(38100700002)(66946007)(966005)(316002)(66476007)(66556008)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2nc45UjYNQrRv/jslnget6h2cVDhwJx2Vrh3NkdeEe5n1tmXZ9JJVYrP0xyp?=
 =?us-ascii?Q?qEdoL+mhmoONOeXo/tlKre/Cga8TgQqE3ps9uklbwt3fXQxDQqv7eHCLPNBd?=
 =?us-ascii?Q?kW6IMnxwj08YaFF502za/MltSMG9RLUX0sEQdJwpa0mVOEmUB3D1bEsQzzgu?=
 =?us-ascii?Q?/rY2JE/ijGdR/2MmN9VWH4DwuF99PVOUVdEi0ipsoLOcbeQllDeNr4w+GC2k?=
 =?us-ascii?Q?OL8cWRRErte2Ne7n+2V6SxLnlMqyHcIHTsWtTWLrAV1h+SZ0fs7i4g7kh4p5?=
 =?us-ascii?Q?2MkY2yCuaC6cG/xgOwanlhFvoC1JiACKA2x/m/R3RWTVuGyvIgpcZebrIFWc?=
 =?us-ascii?Q?lPUw5b1oZpfWGjXJbkwh4cl7mY0bdyqBhOllDTi1HyTK4MA6iqVvx182G+0d?=
 =?us-ascii?Q?KUR0bUJrQ1IpVtXIsgL/VD9lO/YMpDrHJJLZs6FnZCra3LCDw+n4T6kel+ga?=
 =?us-ascii?Q?z3MtgELSN2T5Z74IpYojzCy4jFqapABkrWFR3z+7xPAsXdNg+5WcJbGaWHy8?=
 =?us-ascii?Q?9e3iBtJzjzp+o/ZqXn1mM0YbFFWfpO4O/TMMApY3itF3n31M7Gq2oguWx6z5?=
 =?us-ascii?Q?WLSWp4H370WHVyXT0LyJ+DOjS9i1TPZ37Pjz4Pgo18D1snyjDJUK7ntGDe+I?=
 =?us-ascii?Q?7WUmThpnSRometRqx2GEeSwUbaur1g0maDlyKxuUIw9dHTZIwlm1XQAkYM0E?=
 =?us-ascii?Q?hXVlTb2pGVX4v2ZT4zP5Qz004ArzyinjLw6lQ/gTDLEl44QV0QnOPz/Gr4n2?=
 =?us-ascii?Q?QBvk4q3IHx96eb088Mzb/S6T0DE7UH+g9cUr8TZzU2aQ6RC+Hwnv5heptGdZ?=
 =?us-ascii?Q?M9vNXHbNZRIVgriVmPoXgNn7c0xNPhoacLvIdZFqU3mKyNu9LI6M3+kfSjJ5?=
 =?us-ascii?Q?//CYMKeAshznKUMeq3cQhN4u/FoEHpp+TFjEXmIl3EWWtDljc1+VxApNEmUz?=
 =?us-ascii?Q?Kphp2r07roqbVJ55PPuWfvL9He6hyaHgf39gi9mjcMbTCM+gOM4pNod3P0vc?=
 =?us-ascii?Q?YQ0CaoWTgfswE3ro2IDzQoFkMkgd0bzd2xOa3/fycHyBJRu/weku3Cp8Qk+8?=
 =?us-ascii?Q?gBJ8pZzUSPHhKKjavXDiUC6tNMJVpGU7V586VECwNMWRFJ7BDIwMdnbMcVlL?=
 =?us-ascii?Q?GEpm41hFz13q+0pNaX1um/HS+wGWPHMuklvz7HTBm5MxVqC4ZxWGDrZgZAiZ?=
 =?us-ascii?Q?mbyKd4W9t/mKgF12IVrrV49ndpPTHPqNfHlBHftQEhy9koI57+Q80RXIeDH/?=
 =?us-ascii?Q?bRK+EQnIvmBty+dyAyFeLxJopc1XVwqjMpBWq6unDNvQOeCaEahdmVxID2FA?=
 =?us-ascii?Q?gy9bUY1sWWqGreEfttNBKThvj3iPrKHqqIv200XvytEZBrDaRzTwExOtStpP?=
 =?us-ascii?Q?HBYIc/rlmWBmBU2tVIg5IzNGk5RMe5ordlZVPfv5gO8bQNNGZyCEo3rapD3i?=
 =?us-ascii?Q?HRzPhBBb/Y9L8TVcgGf9RejK6c+pfxtRl9pgqhqFlO5g7VlxF+CIc/FlA/fl?=
 =?us-ascii?Q?tT3nevRnamG6Dt3TvGM7rGx2LtR/Ac5bY1FVRt7IOaPfd6pUuP5BjJd49jM9?=
 =?us-ascii?Q?yF5trjmN4vsYSn76C1H3LmyN8H+mki/VBglcrJtU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?qAHsezrRb3sbYBombWOD7B+Qka9op+Rs3rWNcJzJqM8OgBLwM8/oKbrbmWIy?=
 =?us-ascii?Q?SuzpQUbEZmEd067CYymm21TKdWBNPSqXc+/+su+Z8jH0wkI8iwnC62+OnqTr?=
 =?us-ascii?Q?PlCvXCIU+JtQrU9KDeUJki06380B4tvMKCVV+Ia016ePS7+cBA4zm7kB8hkp?=
 =?us-ascii?Q?cmwySnWJsmMiQPwdxoXWHSuiJHNnALWCxtUvKeXAwqOcl4XTYHTmlQ4NEouG?=
 =?us-ascii?Q?YngLqB64qvcCB30+aPo15VBKPJYJQS8I8qzGYw81n4pUMAcoPJqEPQhWDTi7?=
 =?us-ascii?Q?PlraELzwTczHYEumysIinRZD1odOL6JrcdbdjP0mAV3zTsGCrdBRY9JLdwYJ?=
 =?us-ascii?Q?CvN2FCFWWBwKtfDaDUr0qaJ21sGJCrvNerBDFmTD1CT4AM8HBGsuTkvFFCGE?=
 =?us-ascii?Q?LBCjY3CCmo3bcNUp9hOivFaqQtidflJGJSqA7WET7qBkSKW4CBjCoWPQq+nM?=
 =?us-ascii?Q?K9FU8T254K5XbR3FbIojmxac1Zk/XotDTrTpfJrQiOh5QQzOgU2eAY7MJGyn?=
 =?us-ascii?Q?2V9ZUO38wJe/zH/z5WGHzgpvte9l4UkOQwvF6E6R3ISG9EI0fcsEgQ+bfgt+?=
 =?us-ascii?Q?nx18tOxvACxX2qxNrgdGNNBqJ4QZQeN1oNNO/5gJMrW9LtZkR/sH1hJS7mBX?=
 =?us-ascii?Q?wQjj09ohVUWa393Mk1pKEdJ65fY557OjxybL4947BXhaK42Fx3CKutR45Qrk?=
 =?us-ascii?Q?jnEevxGrx6wOU1rZrSjSDW6+eZkTNCEUAOdX1au/bvealiHsn+QWbv3V/nL9?=
 =?us-ascii?Q?JvdOVL5GEDI3hq8nwJ9FwmENniIWJAKzBmyO2IoqH8z9BTcLzhveopzTBDT+?=
 =?us-ascii?Q?4AQcgd3Oxhyr9h4fBQSi1YJcQrwi23Zs597yq7uWaXHmnBRyC1sU2XgGSzE5?=
 =?us-ascii?Q?koemPilkJov43bgzyQgmg73Fpmx43QCsSzLfpp72NDP1Wgpc3WbowLSAJbb4?=
 =?us-ascii?Q?PN6VEG5ov/WBOy5uClDnd2DFRuUj15NzeUPIKImEPUuBb2uPBpRHFGWJw4ve?=
 =?us-ascii?Q?YdpuZOxj9xb0WHb7SSf53IOK+f4sccJTt1NtXBW+yHOqrRadkFWVv999h+1W?=
 =?us-ascii?Q?LhD5QkZLo7lP7qtoId1LFVeFSU8RN3CLhgGs5Gd1/Z+0U/IVzqOwtdhGBMXL?=
 =?us-ascii?Q?375rnn+vGCBFXevhVfvKFEwe1333R2QlJg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23891183-d736-4095-4e22-08dbb3f46016
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 00:57:17.0013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6M3dal/qulKHzgMQq9YYlpMDSUT0KA7bVi5XPO7R0NP7biyVOzklF8oVhGrpZj3nVspoLc0cWd64SD3wQiIdLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4307
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_24,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309130005
X-Proofpoint-ORIG-GUID: lnR2a977wBTVpPtcCl7DyIVTPEpjkI_s
X-Proofpoint-GUID: lnR2a977wBTVpPtcCl7DyIVTPEpjkI_s
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial booting is setting the task flag to idle (PF_IDLE) by the call
path sched_init() -> init_idle().  Having the task idle and calling
call_rcu() in kernel/rcu/tiny.c means that TIF_NEED_RESCHED will be
set.  Subsequent calls to any cond_resched() will enable IRQs,
potentially earlier than the IRQ setup has completed.  Recent changes
have caused just this scenario and IRQs have been enabled early.

This causes a warning later in start_kernel() as interrupts are enabled
before they are fully set up.

Fix this issue by clearing the PF_IDLE flag on return from sched_init()
and restore the flag in rest_init().  Although the boot task was marked
as idle since (at least) d80e4fda576d, I am not sure that it is wrong to
do so.  The forced context-switch on idle task was introduced in the
tiny_rcu update, so I'm going to claim this fixes 5f6130fa52ee.

Link: https://lore.kernel.org/linux-mm/87v8cv22jh.fsf@mail.lhotse/
Link: https://lore.kernel.org/linux-mm/CAMuHMdWpvpWoDa=Ox-do92czYRvkok6_x6pYUH+ZouMcJbXy+Q@mail.gmail.com/
Fixes: 5f6130fa52ee ("tiny_rcu: Directly force QS when call_rcu_[bh|sched]() on idle_task")
Cc: stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andreas Schwab <schwab@linux-m68k.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peng Zhang <zhangpeng.00@bytedance.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 init/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index ad920fac325c..f74772acf612 100644
--- a/init/main.c
+++ b/init/main.c
@@ -696,7 +696,7 @@ noinline void __ref __noreturn rest_init(void)
 	 */
 	rcu_read_lock();
 	tsk = find_task_by_pid_ns(pid, &init_pid_ns);
-	tsk->flags |= PF_NO_SETAFFINITY;
+	tsk->flags |= PF_NO_SETAFFINITY | PF_IDLE;
 	set_cpus_allowed_ptr(tsk, cpumask_of(smp_processor_id()));
 	rcu_read_unlock();
 
@@ -938,6 +938,8 @@ void start_kernel(void)
 	 * time - but meanwhile we still have a functioning scheduler.
 	 */
 	sched_init();
+	/* Avoid early context switch, rest_init() restores PF_IDLE */
+	current->flags &= ~PF_IDLE;
 
 	if (WARN(!irqs_disabled(),
 		 "Interrupts were enabled *very* early, fixing it\n"))
-- 
2.39.2


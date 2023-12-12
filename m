Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F6D80E2C5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345865AbjLLD06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 22:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjLLD04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 22:26:56 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2101.outbound.protection.outlook.com [40.107.117.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA72B3;
        Mon, 11 Dec 2023 19:27:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBQ8Gjg/i46dNUNb3rEYhis0DWKNXPB41Mp9C9BetYrJRplk/vndXXHf0dQrdA29FRHj7wMAPlwhWqWxkdwhmWADUxZ3uDEJhnqJx50R5+fKOxQPuzm4wH3NBMSretgfoWfsdSisMZ+KJPh/k9psbrLLjjr8h15QGPYBVEQ9aOTFnmLSWqXhlvbKH7igYq8BBZF5iDb9a+rWrn7tybagWL+mWFs4Gbmrl2cGoa2lc4yV6ilkKczb3pl+TrE3N2x62SaAtDIgnqGh3HOEWyu2IK4l7t0Icg4ZJq4xpnEh2yuSFAhlLuIK4i3gHD91LVWYMHRct1o6xVWBHZ5Hkh5U0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlgI34ih4Dumy8MRMg0Cnfnx8aIt/zvSGFFBqfCuqT0=;
 b=NG1n+HLJ5y7y0HHh/0mEFchixfUmnDCfQ/E0MH8eDV1uamZrPf8B8Jz/kpvautBMteUIHcXMdTxf1cv9OJghtnT2BsSimXJ5qgpMXWkjyxwhtdX155Yl/NHo5uVJ6MdZ0XG9ghTtvqtNmJr2DiuMBgBWdGU2eEtosZ8daYUpLWkyUQxk9XOEggU13mQ8EuMsmcAVpUH9mdC64FOKnvtq/im0LjopYAmS/6bRZrrXmQacBt98dk4S8GcjxwpAIu3kGtkboE+vDnmOQUpITK8eaT8cc2n1G+FWcCx4ZPhCOkkHxaUWbo9lrR5oZkknRJrtVMMMpJdSfAaSnSp04RA/pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlgI34ih4Dumy8MRMg0Cnfnx8aIt/zvSGFFBqfCuqT0=;
 b=br1Y6eWTio96d9Tux+RBmhKWrRF+fvVQ4oRE8556/hVt/YWLZ0ZROY7qb4p++mTE9rXgigCaPmzGXPRvSdvapNXKCbIbBItIh2/LCi6jCS7fOTAHMBiW/ZRWNl9B4Q2gGiuW3utPHYtUE9Oc/cQ+aG+Iw3gJ5848jdlq0yBfs4yCLtZvQ42Zk7qfjc9ly5BYabypg7M0559uInHQjcCqeTsOvBjwdRG08rMXCqVMCBgWu737NuyZ+lCS+OndTx9aPwtBt8UcTdE1kpxBnvjnqwLnaYV5vgsdUEBaSyiRZGCNprsU9JuBM9yDT1SULDOnrxltU/hR47rPXqcqOb2f2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
 by TY0PR06MB6839.apcprd06.prod.outlook.com (2603:1096:405:10::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 03:26:58 +0000
Received: from TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5]) by TYZPR06MB4045.apcprd06.prod.outlook.com
 ([fe80::9925:32d7:c818:3c5%7]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 03:26:58 +0000
From:   Bixuan Cui <cuibixuan@vivo.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-mm@kvack.org, cuibixuan@vivo.com, opensource.kernel@vivo.com
Subject: [PATCH -next 0/2] Make memory reclamation measurable
Date:   Mon, 11 Dec 2023 19:26:38 -0800
Message-Id: <20231212032640.6968-1-cuibixuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::24)
 To TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4045:EE_|TY0PR06MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4b0beb-2099-478a-da55-08dbfac23250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 81mw9v2s2ABSb87KW2XXMEC7cM61ahNS3wL0H4iYuXIhpNNyh9lmawhyMoz4IrEj8sWqTMFsYI+MxX/GEN6sY1yCjvLu2e+ASG6AQ9ORgRN5porPhciuR38NXhDJ2RV+vA5EPIplaWiiiMygW3g896WefpH40BizT4PcGTBwmAXTehsZ69bcCt6Mm0K2l+Z0Z75b3CwYm1hBHsxvTNwkNvcYdvWoKQYgnX6aw8Mcbg4aj/536hAA/OBMSp2qgvee8qLnXSVBaO8aNh6HDi/+TzPGQRF5rvMAiXBinqvuurOU9Ma7WBgy9ryQBx8El/bQ+yWD95fdQ2fpLTl7yXo86A5XFJ6EAxG8XfgQxJ72JiTfB65JI7/fXrwNkmCOLqptAgM0SAZg9CmNkEjCZqkp0/01e3UnuxHZIc+SrOidJ0MXIkr5hw3VJEq61QKBiLmzvfUvcTOe+do/vnUzsN55tc8tfFrdUVFMbtWjkkdZqoaGypY56+jgRea8ja6OWKajFsqqN3kVZuMgMKHAxEitjyEVjK1lqmFBFIVhzIGbVhE19a3nRLE2zcxBfisEHGyw5kfkXHuB42EW1/981NryKqfui+oso83bac/mWhetkqENZIMtTEUrXZ8nLJ8Y1md6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4045.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(39860400002)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(2616005)(26005)(1076003)(107886003)(316002)(38350700005)(86362001)(36756003)(38100700002)(83380400001)(5660300002)(52116002)(6512007)(6506007)(6666004)(66556008)(66946007)(8936002)(8676002)(6486002)(66476007)(4326008)(2906002)(41300700001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xBs3z3510o0TdFDuiwCt+FSgRHD2RzHltf4Jb+3iKB00ymStJQGTMOHmJS78?=
 =?us-ascii?Q?dnYYfAqCJwIGwEadr1PXPJn+tm04sp3RVN2M+VWfVtETHHDDIEmpGzgakYMF?=
 =?us-ascii?Q?Hyr/+wo2kAuB5to/gn2S+MyuPZ83KMJ2DNv9fksrxmKHoKB5KOAITYRjmjv/?=
 =?us-ascii?Q?gJgR0Ozv/qU1275z98jxUfVUkOLrRs6SxNoRCt4MW655hoJKFQjV6qmfpEJP?=
 =?us-ascii?Q?z7c+6DOu56Vz05ek+kEz4HfwMoEjTGBc6PsRT3oyvyLMml4RhldJXXLut2PL?=
 =?us-ascii?Q?LAUDn4lRJIwsyWYZvSoys9VLHK2l2jWOPgAbbH47JFvScSDpb4JitM9b8F8b?=
 =?us-ascii?Q?CX3w8+Mu2oyGVaA5P3QCAULnbQcrUrCLCgYjpGfArT30SPzIKTHZoUqJQ04+?=
 =?us-ascii?Q?1LnoWay3hH7uQUUew6eQ2jefEucKdYAXDk5yqnrN+2ggmU8dPyIr5HP487E8?=
 =?us-ascii?Q?IBy1wwi2RUen7Bp3SDUNdxluhNbhTYlv58MXfYGnPIvGnJJHMrH/Q85XnEdc?=
 =?us-ascii?Q?PX8ONWnUQdn9V6yd2eo8Nd9jexQdZl+EQaZDbCEciMgyGmmaNyuwxYHv9CC2?=
 =?us-ascii?Q?9PoL77SB/CrTT0PUpTrg3SnfV70UNvIzFWqTjTzFtB+y3Ch7p75K0W4zPHd4?=
 =?us-ascii?Q?flHb1dNu4iyTvQsneMswAJTtGJUUKKMrxp3BKiFzp5tj7f7hcEZg5mi1H2AQ?=
 =?us-ascii?Q?EuqwBqt+ymxbkesPRUsPjuGTfBCclEg7Zck6uxJi4wPG4EoI084y4I8vFPqO?=
 =?us-ascii?Q?C04sgLHjvI9hOvKNx1cR3S4MwaWqw6pXWNPa8pD/qfD2xsesWOi1qkuoCWqz?=
 =?us-ascii?Q?k+PdTAkqClwyBvOhVThQ5FvqknTsAa1vbjAZLDK9TCm2xuBWKBF4IHpfSrqA?=
 =?us-ascii?Q?EDlMuxFzoEYljgBhzOCaq3DCwQA/euTuIPRvLAivg6k+gRAMDgvbU9CeuPd+?=
 =?us-ascii?Q?KmGINgMFqEHOKlFbpU/lkujIP7SSf3fdj640R41Drmd8qs7jPkxm2zbnwPn9?=
 =?us-ascii?Q?0IZiS5t4pH/KmswhJVJN0mJe8kuGTTyBqKXi2gKKTTfBa5ml1MkDsKN2DvQ1?=
 =?us-ascii?Q?P3qhkZNsvFrK6H5jSmYB8pHvZDlEWTVG0RC3FPux/vO9yY3p8VJo0asfDkV0?=
 =?us-ascii?Q?/G881JYOk9m9bTXnWSgxPASx0vaYaXSLii7kkEVN88dRqSwxoINunbJvyBr1?=
 =?us-ascii?Q?4p3cAxZBe9XwMzljTCZRjti5EjwV6S3zkb3f6MWye6+5wl6suaf90MEQwHRn?=
 =?us-ascii?Q?ftLy1Kl07hYVpqNV8xBLAvOjb9+yyqbi6T0VuyWgrBLrbbSEJepjJBCxEkmb?=
 =?us-ascii?Q?ahx3qiJx6dMuDCq/27WXcXk5PSQ2Wa1APVELVcfXWmlT9Nr4o80jEFsJMA4z?=
 =?us-ascii?Q?yRmMEywhgIv1G7krD79JO2xFNfQPjjTm57DqZm+mIuVvE5Qzhn+97ujNPAZE?=
 =?us-ascii?Q?6QVVjfPr6gjeUyQX5CM9coQ2I/suHvbQmdNrqBCMNO8lEBWPQVh7Y8YVBMlQ?=
 =?us-ascii?Q?5+5y9sSOKqZMSEYaKDPh0l4bA/60Aa7R4YqjTUrKUP+GeI0sRnI2EqKjI+is?=
 =?us-ascii?Q?y1OMwJmYOg2fLbyP1Mc/TU5bbwEAlTmUAlbC9ZTO?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4b0beb-2099-478a-da55-08dbfac23250
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4045.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 03:26:57.9248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+waUGiq4mEdIY61ecD0Jn/hIU5jTJ1Xn4y8Cty90PKBT0hzMFbT9ZVrElvqCJMUBNC8BmlPhMpuox8p5pGDxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB6839
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: cuibixuan <cuibixuan@vivo.com>

When the system memory is low, kswapd reclaims the memory. The key steps
of memory reclamation include
1.shrink_lruvec
  * shrink_active_list, moves folios from the active LRU to the inactive LRU
  * shrink_inactive_list, shrink lru from inactive LRU list
2.shrink_slab
  * shrinker->count_objects(), calculates the freeable memory
  * shrinker->scan_objects(), reclaims the slab memory

The existing tracers in the vmscan are as follows:

--do_try_to_free_pages
--shrink_zones
--trace_mm_vmscan_node_reclaim_begin (tracer)
--shrink_node
--shrink_node_memcgs
  --trace_mm_vmscan_memcg_shrink_begin (tracer)
  --shrink_lruvec
    --shrink_list
      --shrink_active_list
	  --trace_mm_vmscan_lru_shrink_active (tracer)
      --shrink_inactive_list
	  --trace_mm_vmscan_lru_shrink_inactive (tracer)
    --shrink_active_list
  --shrink_slab
    --do_shrink_slab
    --shrinker->count_objects()
    --trace_mm_shrink_slab_start (tracer)
    --shrinker->scan_objects()
    --trace_mm_shrink_slab_end (tracer)
  --trace_mm_vmscan_memcg_shrink_end (tracer)
--trace_mm_vmscan_node_reclaim_end (tracer)

If we get the duration and quantity of shrink lru and slab,
then we can measure the memory recycling, as follows

Measuring memory reclamation with bpf:
  LRU FILE:
	CPU COMM 	ShrinkActive(us) ShrinkInactive(us)  Reclaim(page)
	7   kswapd0	 	26		51		32
	7   kswapd0		52		47		13
  SLAB:
	CPU COMM 		OBJ_NAME		Count_Dur(us) Freeable(page) Scan_Dur(us) Reclaim(page)
	 1  kswapd0		super_cache_scan.cfi_jt     2		    341		   3225		128
	 7  kswapd0		super_cache_scan.cfi_jt     0		    2247	   8524		1024
	 7  kswapd0	        super_cache_scan.cfi_jt     2367	    0		   0		0

For this, add the new tracer to shrink_active_list/shrink_inactive_list
and shrinker->count_objects().

cuibixuan (2):
  mm: shrinker: add new event to trace shrink count
  mm: vmscan: add new event to trace shrink lru

 include/trace/events/vmscan.h | 87 ++++++++++++++++++++++++++++++++++-
 mm/shrinker.c                 |  4 ++
 mm/vmscan.c                   |  8 +++-
 3 files changed, 95 insertions(+), 4 deletions(-)

-- 
2.39.0


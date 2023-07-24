Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431CE75FF1D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjGXSc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjGXScq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:32:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AE610F0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:32:42 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OFOKWI006034;
        Mon, 24 Jul 2023 18:32:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=+b/IhjAnSSBGrrvE7yOCPKQj4CvXkErXLZvpKp+qoRw=;
 b=qkOwK1v6J1GDHLaKLuHrIetVl+CBnG7s4F3XRreRyO4vgUzBJ12i62RHNvs1Fi9PfXjs
 VN41zJBR4IVBDx4BTlqKEebWqraGHMkwdBjwbG2Nv3gFORHobDbhR/YcZJKD20gOK2pJ
 8PGZ+xs4q9qaDheml4XJqth3ZY+7rZ3bIM+fmU9Ffr+KN6gOWntH9Nfd4nqNa/Leycyt
 jIz29uUPhjGiYgD6VWuGT4Jj31oO+OiNpIFOVIvs3olO5WHRhzQEASpt5HR/JiVWMD1g
 amJb8A5xhXflufMGiLBBnLzvrTWb/NyMQRrV6LYCFXB2vuzfowbpiaOcrwjU1b9zMwg+ Rw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s061c3fu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36OH10qe003802;
        Mon, 24 Jul 2023 18:32:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j3ss50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:32:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjtU0MJV3srunVFj9jiwuZ+yG7XIfBey/V8ZR1RdTwHTJafQ44oDuk8SGAMk/WraW1qg6dyRHA0vYi5YfCNs9Zz1e3UaNAm6yBxSwMWCBwoLdUWDBwBvHWt/WLhILax4RA69kZn55hdm6n499J8JyLgGrXxLsZSvtt68+YiTS44naYx/VwnmGmzeytaegglNkKCy1aD9nKEVTvI15stLyOOMpxkFRuun4X2n4KKEB7r1O0z9G0SiaOmLLnt+0qYKMSSSoyNe9fHAOJtyCEd9C/mdTl0FiMcrJ7jLHA12QWorKtiY/NKWQQOqLfZap8iEn3MQblC8sXTfeEEk0eGTJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+b/IhjAnSSBGrrvE7yOCPKQj4CvXkErXLZvpKp+qoRw=;
 b=GEeFXwXGOKbV1OVxvSSM09smmqjkhCWcaXy/K9hz9eEzzUt/xyFoLjtPgjye6fmAWMJS9Mvc/qIkg7AOveWwHpTzcCnwtWKmJr3XkOk5eLWcz/lhmAy9X+GHjW2Nwpk9iPKWW5Mdw2qABt/MiAMkGrgZdp79SGypI595fsewjPiPk6FQS4+5YdJeMEwb4QdTzpWfuv1ZondcFWDAuBwcepjIqiyd2JuFp9r3Ld+Q2XuvOAR7O73XpJSnZlAJAKOxmnK1/gU57BLCALzEuY05K65gCop24I0+es2DCRCW9N2o2VhTMpZGEe3zqz7c8wOfxl/Vdws3Jn31l9sraoVbSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+b/IhjAnSSBGrrvE7yOCPKQj4CvXkErXLZvpKp+qoRw=;
 b=CuYaP8/38yBxWuqGcgnKVo+oeiJZZbbWQ1hFJuy+q2bDjl4PIaU5mLkz++1PY5jhe+HZQmCldnJ1BnRxkZpoJ5gPQFK6CcMVPdzkSdvcGqxSxwM1uwL2PTcfhOWQOZ6UQCLpP2y5urF5pwFMDx9kYMnEO9S4T3ehZEeMldNIkl8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB6654.namprd10.prod.outlook.com (2603:10b6:303:22f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Mon, 24 Jul
 2023 18:32:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 18:32:30 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 05/15] maple_tree: Introduce __mas_set_range()
Date:   Mon, 24 Jul 2023 14:31:47 -0400
Message-Id: <20230724183157.3939892-6-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
References: <20230724183157.3939892-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::13) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MW4PR10MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 59226cbc-9eba-47e3-852d-08db8c74569c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T2GY8HtboCxe+F6sV2wWof8DzkbrW5/kOZOaW1+n9zw7aO1T/nmpKYmKMDfW9ZACl6WmwW5p0NDPz6RSH8Z4oaYdWkHpUdtcoT0fB6fdH/IV9jx/j/ovqiWGqD4vJ/3vhJYbOYz5c0Sspipgv7pPTe/Ilk2ozMH/PuLEP+aCude2tzXIXDiN18Dc5SEk8L7D7bsY8qAn0kO58UVclnUCAyw4bTffCbTkcQk7U/oSUhm7ldZ9fdLkZc1To1whAU+6gxIL+NIun6Cmt80YxLRRdEvC6hCk9gUxtQfSvwZf+1q8+GPjAlL+2PjLz9uaeqyR+ZlC8fJ1Q8cDq36SCdQ0a/MAwjfgd20mMzyhtnKxEbidEiZx3sZo+cCcYeIJ8sqoU6UTpXDhmeIdQr04229cy5tbHqsaU22ssBya5H1cDUtidrsvexjRQc9WBJHNbIVnK3IWEaUaCu+S/vDHBeLOL1XzUsjyKKQBYYc+0YfXlBVInRJDvv71CBWmOkm5S/6rHeqtfJqdInbVxIW4fyWClVblLw4/49stJoGORDUcu9rCWACjRELUZw3gZR9VZLvF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(2906002)(66946007)(66476007)(66556008)(6916009)(6666004)(478600001)(6486002)(6512007)(86362001)(54906003)(83380400001)(36756003)(186003)(2616005)(1076003)(107886003)(6506007)(38100700002)(26005)(4326008)(41300700001)(8936002)(8676002)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?54bv0ZpqulL8lPt8nR4t84VySGOiEFs/TZv30x9h5JZyhHzG8I2exk35X3dK?=
 =?us-ascii?Q?75SKdpGov6Y81pA60aEakzl+BwVl+/c3vbqPplVXOOB4m+gZ2pJUZDakFiXE?=
 =?us-ascii?Q?qS4dHAlLhRlIjs9aMdeZ+tHEs1nDi+iCQXJ08e1CD6vldcihD4mwbPPminHq?=
 =?us-ascii?Q?CQg6ecOZwA8JAV04GNn4EyfGYuNP7ocbT3cWJiQL0o/GwwHzX9E1+Uu9/JeT?=
 =?us-ascii?Q?sbw8ibVtoi3JK+cIKZcmM0ru87MQ/KlgRjWXGySrh9ndFCXhl7//lUkatYrY?=
 =?us-ascii?Q?JF0QUiadC7XnkJdLvQJmNzJk3Vc9MOJLdw7xZMNf8C4RMZrF574ZxihgS9ao?=
 =?us-ascii?Q?GCjL8bpAKKXHJ0JHl/yrhBYt/6A2D2O8nHdSEtDBGYhUk3dfHKWqmIXTTi4V?=
 =?us-ascii?Q?nY+r4AwnpLW7RyTHkXxkOeLn+mxdShU5E7xS1FG+McnXEVgg9p8TvNZKyPZX?=
 =?us-ascii?Q?idzjkuJ846w2wMHZD9vUm02pilvp6GcvkJprziaucueC0/OImlf/Exn+K2aY?=
 =?us-ascii?Q?s+Xm6KkylPbUMjjUUvimGyqSv3/jZblWRw7T9GA1BiH6AkpfntMQWtX9Hxj8?=
 =?us-ascii?Q?YWKH4a7ATsLzb7jGHXpFdqAweQrlUQp/3Qmb7f4hPGZThQoPqGIYDyMdlmOB?=
 =?us-ascii?Q?qr6yaNaHnBaP1D2GV94G+3ZeXwv210yBgOYU3JkGGRurPMuvQnyMUDbbhveh?=
 =?us-ascii?Q?ueTOfEWWv1K5QzTkv3gh+UMr4EF44ggJMoamEnVV4XLxdCh13/3s0DfyZV+3?=
 =?us-ascii?Q?YLV83UF02oFTjqGv+2CXnysH6kSmpcFFaUt7tRCWu2Q64lRwYPvA/3y48WB8?=
 =?us-ascii?Q?0CFisD9K8erC145qAUjNVedHslS9VTGz830OjAPq6WtPoovPQbBImipkgs0Z?=
 =?us-ascii?Q?XAt44fTyDj25z63fXsHgJHM66ekNLk/8BfeC9Os7sbJpc3nRAs3QqxMVpyU4?=
 =?us-ascii?Q?qf65HjEhZHjmB80KfGI5VTopK7foNUaOyRSbHGV1iX2zeSv7XsZzZWhW7pSv?=
 =?us-ascii?Q?uVXiEOAuKBV7rJGCF4E1Pho5jg/KK43mWjcSdLOAVf2iW2VvkqJDW1DE7YTe?=
 =?us-ascii?Q?jkhPDfVuzAeM207jv1to7giziOb/5NNUh3OB/utpqf0fTe/TfMizZTeZUREw?=
 =?us-ascii?Q?+b8kfSGFzHzgNlOX3L/Bb5CNVpfkvcoC92LdoaSGB/Ud6PnWrewfPF/3h4oh?=
 =?us-ascii?Q?u6TgRKT9KSDs3DZ3NgnC3nOYyYSBPBA1PoNyyzeQeBlqkZctjVDNkcNwfW0/?=
 =?us-ascii?Q?SHUl8jpZT8pLLaOmpm27bt7UTaDzDspGqF2x4lNwb5r27mIb3ynK4e+jyRDs?=
 =?us-ascii?Q?hK6LaqcK1bg6dHArjiU2Qu0fyz7dOAkhYYg5TBzJ74OjAOyk8eSAYTc9PmcI?=
 =?us-ascii?Q?vf491aOz8TqbR3pZ6hqLHMsIw1SzEZswlfhH2m8lSz+hJWzIy/vMA2vPG8tS?=
 =?us-ascii?Q?X7eXXuiQzwpPu3qpMMmEc23vOXQFqFHIZ7Aca1mlNez/ryI4X4nzkiQ7DeJH?=
 =?us-ascii?Q?Zd4+t5rWrH6tQHC22QBgCxyWc/A9KMkJaPtdQRbZXXOS5sQpVb41VshUkAuv?=
 =?us-ascii?Q?PqaFX21sfIHyPJa96VeCaclNdrzbo5bLUfofrFe2Eixp0xPXhFFx5ED/KW14?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Rwy06YRcQqlxjsx6XYcai3rjXwnTT4pj6ut7UYiPEPTDbb6C26ilR0G2s96zT79DhLzWacIwPULGXcmurMt9C8O6QvrE/LVjP4HpXWFE0chaBnjBpuh2ZG2Q6Edj738iC5irt7RMA7nHRYcJgCChSLfV0H86inuS+++eB3TzGyj2993U/sPpRAeoiyP7yFPmKm+WpQu8V4N3blhTFFhPQj4ktoZm8GknKl5Od8dLHOmkJh3kff9P3U8f6ezMsbTCQpSj+elWMDnGdAim1X49QTJ1YAMvch5WjiIPXMzTm23awqmYzPYZtLPBXovV5QN1ZMICMfElLtZg+Siac11+zqD2ttiIDPkw3l3irm8dJmfB39/x7fEf3xbt9A5UjvBXY56FlxlxcSCpVEJp/Jrs6AAqazHzk1ahi8Jl+hJqB5HfQw8V48c77A1g/r/jC67LZXTEh4sl9SKddbt1NkparUvhJXtgakzqUeUiHfiPqmpDsYWkG469daV9C2RKdw0spSCdoG0MVXw4Rs4X7YqLqjaI9PK0t9Ub9/0tYgrC7ZQxm4ajvBqFU24S4LQv314Ei9TM9vVDab/3ZIyHp16RbZ831alc3on9CxN6xhBXXDDFJ2pCq55zzrNS3BrOKG3L3wNxeGR4lwnJXaMXSqdcbO4MsUsZteOrLwCYyvN33xggi0D3tcKBi5uQQNSxj1n/RivdfuA/kr+J4GOkaIX6LcKmVoi18dIfAWYa5UZBz7WjU4ZL/x5eV03azE0dJfic2FGDcgHSepFn0CqDSQLANHbIGgGgANOVAjPYgKAul8nkKgKCU0VBB9BHEwUdI/bfb5Gxp+sTSkHurI3EFvPhZksm+iCIBbe93xfPpnkxArS/FdIosyICYBJb80R299PcPDeJb38nLfcSsUA7cfQupp/4I1NCFG8KvXNvM73RUq4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59226cbc-9eba-47e3-852d-08db8c74569c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 18:32:30.1506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBXPSdJ31dzEjTMa3gTbeR9PFXmoG8WRaXGBRuTr25wt/sOor8RSDb481SjoPumg0U/qXOPRSpE5KNIkI1gWbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_14,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240164
X-Proofpoint-ORIG-GUID: 7pHkk0TJFlYs_Ilq3oHAXM4N5C7IBUVY
X-Proofpoint-GUID: 7pHkk0TJFlYs_Ilq3oHAXM4N5C7IBUVY
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mas_set_range() resets the node to MAS_START, which will cause a re-walk
of the tree to the range.  This is unnecessary when the maple state is
already at the correct location of the write.  Add a function that only
sets the range to avoid unnecessary re-walking of the tree.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/maple_tree.h | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 949f911bf955..e10db656e31c 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -539,6 +539,22 @@ static inline void mas_reset(struct ma_state *mas)
  */
 #define mas_for_each(__mas, __entry, __max) \
 	while (((__entry) = mas_find((__mas), (__max))) != NULL)
+/**
+ * __mas_set_range() - Set up Maple Tree operation state to a sub-range of the
+ * current location.
+ * @mas: Maple Tree operation state.
+ * @start: New start of range in the Maple Tree.
+ * @last: New end of range in the Maple Tree.
+ *
+ * set the internal maple state values to a sub-range.
+ * Please use mas_set_range() if you do not know where you are in the tree.
+ */
+static inline void __mas_set_range(struct ma_state *mas, unsigned long start,
+		unsigned long last)
+{
+	mas->index = start;
+	mas->last = last;
+}
 
 /**
  * mas_set_range() - Set up Maple Tree operation state for a different index.
@@ -553,9 +569,8 @@ static inline void mas_reset(struct ma_state *mas)
 static inline
 void mas_set_range(struct ma_state *mas, unsigned long start, unsigned long last)
 {
-	       mas->index = start;
-	       mas->last = last;
-	       mas->node = MAS_START;
+	__mas_set_range(mas, start, last);
+	mas->node = MAS_START;
 }
 
 /**
-- 
2.39.2


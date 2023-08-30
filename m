Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FEE78E08C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbjH3UYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237748AbjH3UXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:23:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B39ACC99
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:09:13 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UInXEB032355;
        Wed, 30 Aug 2023 18:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=k3dumfrrLftC0rbMzucfNY2caXdgyJ52sKyZgZ2BJlk=;
 b=kRkiQc+x0Y00SD9IonzHq1CPYPEIVCDZq6p2fUDPausThUPSy+o3D87R0kw1Z/kchNRH
 IuIX2PEpmQ5Mlb3EAuQvJcFlvN0BV8o2QJ1Lo5E4aLmfWDvEbgrmMXFwx+Eh/3K5wJIa
 FC3nqw+bdzWFAltBHI8QeBpS4j/keHzA3lWlD1tyg3Kv6y5Nd2amOMTM2Ux5HhWaapXI
 JK6GwUZcfPHkzRgLr8qXhWAfM7tKowT6ufX+A3x4vPdV9DjIDppunXjYEC/iJzGv4R21
 Lm4lL5+Hd05w3jl1y3YvDihiGNVxfDeLk6wJSwtVmws/+pCrGdgW1dBTSAFI2D1KGjiT Vg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9k686bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 18:50:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37UIDLKC032817;
        Wed, 30 Aug 2023 18:50:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6dqehre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 18:50:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmDEIYeRanHsCPQYOL3EvPSmsSrNQ6OBsA7XY2K1HvQB+rJATqe2SK5nj14mQxOhLUua7tpf338DbS0lxIFWFR2EHuges3T4CTMnjGsk2A8gwr8ZDpvBI4OGW5VR6IdWdPoqjU5q2YzwD0J3cNmqHDjEMvNiBdpiPDPXfKz1xxGymR/1J/dP/G4kFN/9l7VRxWn8LCOkwt47a4vP1l1fNaZ+jwxbQubHUgMmlO601b8ejDvMiGSYWmANC+H6gPOVwN0bA8K/iLeFoM7Klu+J4/2YmIdqmSH4w7oSj+R7OnrlxIY9GgDBUt9QNkv8UjYAzd0lXwdBBumynx49COgMgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3dumfrrLftC0rbMzucfNY2caXdgyJ52sKyZgZ2BJlk=;
 b=A+sQ06I7i6ywJholBgVjvTsEujiFiePhbQERpH3WoFwN0fLfxi/CwAqcN+E0kOJlL3/Qz6MpQxBtpZ3OFCRGFHhShQooVFEte1N33BT0eYJ/gdvhROPbhyE8g813J3ZlgvSi/sgCaSwpktlrhyTj/c9rR2gh42HtjunRUIzqyVWaYih9KliXPdX6JAF59E7H1ksYJ8I2o//cSL58z5kOEmvQcm6kpW+wax+SnB9vbioAqtzm8IcPISwbabH/P5QpipU1uHOPTzr8b1qLNFOJ3SaLSna7L6lXD3tO2v8fBxfQb8KB7MewLusMD3ZeNZCO+49r0N2ZHILwQtDP/j4rwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3dumfrrLftC0rbMzucfNY2caXdgyJ52sKyZgZ2BJlk=;
 b=MCadMPk5Jw1+KGSUZOG64aA7sz7z5Jw++pZVpjBeUVKHlp9hJjGrc01Cd/pZMhxHbv+Gyg+e3RrrRd+gVeIwVKxQE7I6/yCoMF6kGIKUmDD3r62wXBGEamFliNUAonSgg5J0x92yrYWccCiF1YYW6BZhKoOIVntNPF4pifII4II=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CYXPR10MB7897.namprd10.prod.outlook.com (2603:10b6:930:da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 18:50:19 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::238e:5e86:cbd0:7415]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::238e:5e86:cbd0:7415%4]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 18:50:19 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v2 6/9] x86/clear_huge_page: multi-page clearing
Date:   Wed, 30 Aug 2023 11:49:55 -0700
Message-Id: <20230830184958.2333078-7-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0318.namprd03.prod.outlook.com
 (2603:10b6:303:dd::23) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CYXPR10MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: b67a77f8-6007-4ad3-5c00-08dba989f547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3QTrGcnRQXwG4GAP4xpIQb3YPeleqOAMiPJMKgNoAMXqLkvCw2RO7wCYVSaiI4HFx4hnCEzgOKo55F1n5hKH/q5WaKQ8vHQgU2THGowMw61b1FfB7v/N+Blcvw2H7hP1J57JoIQml7AvhGSwNY7TEicTTwMOod3/MVYerl7wxXrB4Z/QW6Fdr5rKBEL4BD5ndcU4I+z+yT/t2d+5jbStrNqJWjvtG/edR8g4EON299ygEtcyTqnFgus24xextAzIIexGWEfRnE//HiCCLA3tuHYryJxqOMhE/4m7iVgNKwT48qi+117xkivnEq4QRWqNsp1tq7uCJtREPrC4nVYHc7D2EbmcvJesfZkaVxZRg3cHStDAW00so+radWdaEpmUtVPZQVsW9Hw+QOuBqHCI3/N+TxkUL8L4+dnKsLnnW79zgOPFYBMqiz5zh7n3SJ9TXoABU93Oo+rBtfeFdKW94mL5lleRSS97iUW855bQV/0WrO00X/61VC8kTwIezGnNZSgXaE7Hml+pj9U0YEvbSWE2H3imNfuCsH4TMss2L6KRsMUCuSOoZWFoIUHLTxDQPfeTSQKPivWYCS4cJblFrPLQu1mSJ58U1mhxyHKdBmY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199024)(186009)(1800799009)(478600001)(38100700002)(26005)(1076003)(36756003)(66946007)(41300700001)(6512007)(83380400001)(2616005)(107886003)(66476007)(66556008)(6486002)(6506007)(316002)(6666004)(7416002)(5660300002)(4326008)(8676002)(103116003)(8936002)(86362001)(2906002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DA1kNghMTEqQZ00yWf5AxqqyuX62HKg2M6s+pTR8g9PBEaehhEm/TPHHwuhg?=
 =?us-ascii?Q?uN8NIA0VChvBm2wrVsMk0CWa8TIlZUzdEHqjECS5td6XwH86BTbQJ3m54/kP?=
 =?us-ascii?Q?1fSLIrXdffLGZtYpn9krzQrSdAIhNHZfr7p/nKGGROUE6yngVbu/XKFp6xid?=
 =?us-ascii?Q?qPGL5hoYdbseUX0NLgL0MWlIpJmiFFtFL5jJ62f8fjqWeWRBQAOLxObHSgQP?=
 =?us-ascii?Q?LJwopg6GcIramk/YBQ3Tpm03gh1hYaNf3+lx5x0rD6jIxpvQgIfTYPxuvh2V?=
 =?us-ascii?Q?cMKn20jASFZYwqiX13Pn9xhklNsklTw3ayCtcyGE/VZMKGnrN3u1Qw/sD5U/?=
 =?us-ascii?Q?AwXUMC79sBGfZ7unl0WecrD2VeDPctqCb1UnyNVuY30edIY5J6eQLLkbt96Z?=
 =?us-ascii?Q?o6C7R0FhVAHR4I4Ixl2EQ1RV7HysIL/h9ZQ1Hz1NQOBczJc2CMr4sdgOcXee?=
 =?us-ascii?Q?nFkIT2/eZsCfAXIWUqi/NZk6mOOiYrqTy12dkcA0NBQ6B6laAEpRkGEGxreN?=
 =?us-ascii?Q?uzgX/yTDf1qjL/MCFMuuKyARsfzfJGviF/x3wLkmhMvQr0R1EympBZ1Rfqsm?=
 =?us-ascii?Q?XBGg2UQUMUZbNhSCAlY4cXDduyYuItqob3DyJX/TywWmSOnjoqgz5zazxzLK?=
 =?us-ascii?Q?Eug/jJ5z7qucnAFpmC4Mn7yeNiu42mqNAarFqM1kHLB38BvBPfw9KyBkw4Y+?=
 =?us-ascii?Q?7y5+/aZfbiQpVd2CJuNg1Ld1v8kpCmeMryWq/LpvQ+/cPdqpnvHnPP1DrsSY?=
 =?us-ascii?Q?RVQHhDbw/e+BVkP7ONC/6ZCdut3hucdHCWSf5yI7goxBZhDe7mlgC0/8tPhc?=
 =?us-ascii?Q?S1MEuv9yt9OESWIQ7mDJ9JpsnXIfCCKSjugJseQLw3n79DEeoj4KlKVY9EmF?=
 =?us-ascii?Q?cHAxH/xpxnmHA/P7D2T4oKX8N4nruYmD9/c4GlaHufEmxeCEps+AxeQZyFeO?=
 =?us-ascii?Q?0xGbKMnHeHq03Zacr8QBo0auEe3qnngEQCsatYex7C5VX2XkiyfYHZCmB7J6?=
 =?us-ascii?Q?lDHNgX9SrCi4W4svVrhUphlqHSDm3KZHQYiDP8D/A4L5sRqdFrIs62F17s70?=
 =?us-ascii?Q?bCDV1O7ggK1ggRClK33lnciZLsMUoX14OaZLdT4C69/ib1lPlzOLUkVfEyJy?=
 =?us-ascii?Q?JzV+0KfzMzLgjxfRa4WxNAJwMI1JavPY6uZN1mQkmJHRtHo4fCgjmVZHcFiZ?=
 =?us-ascii?Q?FblLP8K6JEW8Sse4xyEo6fN6p1F3FIaB/SzSf6h+0hVq8OJjUsllF1pRkqZ4?=
 =?us-ascii?Q?KHsXLYrO1zs/LzBNqz8RGuPPCptLUW8HEpkz8IezQ4VgEV03/OAt4e5lMX4S?=
 =?us-ascii?Q?TInH4b5WWt+cKcvKpfhNcT79T6dwtVi8An1ZBgUaaO7sl7SVcHTnaGkm9YJz?=
 =?us-ascii?Q?Fc5f6YtFNjtas7toFtW9VORmRgWSXHCA+xy+d1/sm2mgYDq8UNHvX+y39dZA?=
 =?us-ascii?Q?6pP/eQwYKXDakyzWTi5uD0Sro6EwQA6b9pEzib6uNBpFam5KTWLGGXMS+74x?=
 =?us-ascii?Q?3nAnKvBwbrsI1gBbTzrzpqNF9NiNMZvqo7+3Ew1Em1NO+/5+poj9BBWIvK+4?=
 =?us-ascii?Q?VnHqZH8IDl5v3S6NdwirTZulafcVQvyOxW+OhpdrkGfEFsVlha/Tg4DMLuwm?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?yZwHKS2LEHYv7B5KTcxUQEeL7xtQCvg/wlnOxyMBuEizNSUrdqNuxZ0hmNdu?=
 =?us-ascii?Q?K9Nj1YaFCns8wyxrgH9pQ6NZIEXCJH2F9mon3lF9J9x88Lmj7+SRrjDsta+b?=
 =?us-ascii?Q?y0Yy+l3mCCaqs17jxZ2qzO21otBcevWABeViawcWZsICJYWZvnbKtem/73tj?=
 =?us-ascii?Q?qms5z265oH5EtDq5BulElgwPqMe/n+6JXway6IWWesRgy6dBBPNnH1U6Ilqq?=
 =?us-ascii?Q?CDA4/Hs9Difu8rCvWUw3AfnztifKA+8NIVTLcwfHw2eqCqHYsqcvEL8b0HkX?=
 =?us-ascii?Q?Z6L2DSTFGJ1wgaLB38crM75Y6xcF1iW5xaoD46lhJHovXCy91ziwauDALMyt?=
 =?us-ascii?Q?FAjG6jfg4oCkjuDuWJ0v4aEW7tj1SISS+h9J+41r5QfkytqTSylUHUGUi88a?=
 =?us-ascii?Q?txviKxPXtV+nguWKc+G1vczTBgMtB8dQcnspM0ppaX2l6/hclI4R3BYMkaba?=
 =?us-ascii?Q?QXlFguuVLKfRUp7aBNAKrwr3/K2zNamVx7hGRt++X0mSI7Sri8wvmxgpzjs/?=
 =?us-ascii?Q?/J3fS6CxhxBfd3D1wFanxlzeNYkFGdNq6utxwf+xSrXDgdR9Vz6VP6LvmCgy?=
 =?us-ascii?Q?eVH3va//DcX3zgicsxcyE7P7CPmF9fjBpO1YqUIHzAvo7cTJHyPy1RmOuUMp?=
 =?us-ascii?Q?07vN6uvGBwHlkQZC6nTCXj3u6vnNnigKMs8vFbo9UNcZtsPyZD3moSwuC7fl?=
 =?us-ascii?Q?+bK+yUvkFgk4rZxPBr0xJ3si1PGGX1vJ24roVrAP/OYhyRM3GCqRj7hF6EPX?=
 =?us-ascii?Q?2uHrGvwSXOgS+yzXUINsG0JguuQ385QW7OvA36Yjg6XOYUYeNWpz0BUhBA/E?=
 =?us-ascii?Q?dyK4tsG2x4DYyReqgw1y3vYRTt2N8Go2GFLIZuRo05hIkQ3TZ883cMfTYiLx?=
 =?us-ascii?Q?2hzEsxC+kegkQXv6Ea2jWSFVUQ3asCTjcu038fE8nWXG0CWg1omXsOt0ls9v?=
 =?us-ascii?Q?4IPfoh5dctDydpX60iJpWTLzACt9J8z/lb9U6rugUeIzx2t7TmB7oFBojcwv?=
 =?us-ascii?Q?0it8QQAdbecQyxgIx5pkM/gBBxdhCswoJP2aAn9CiMWAbXBWf0s5T9QZqDi8?=
 =?us-ascii?Q?5yUiYrhuBM782lecRMjMOFo/BictvYGMOqvHJa/7FW7yWnj7GAiAaJDt8KIQ?=
 =?us-ascii?Q?+oGRfD7HKwXGJfEnaHQB6VKH1SA6jwbSpLr+hxGd54iGz7L6nVs0aho=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67a77f8-6007-4ad3-5c00-08dba989f547
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 18:50:19.6471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7mmiD+O1KCRYJUxXTlN/6aitQCTNwcg2MN3nKN/vlXq06hYG2G3gE9YwMhzDiUb+Z2Ppho/MriTqBcKaa2DPpN1av9/Jb+td73gxevYq91w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7897
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_15,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300170
X-Proofpoint-GUID: 4__312qXJmNbYqMLkgPDDwLakmlzmzuL
X-Proofpoint-ORIG-GUID: 4__312qXJmNbYqMLkgPDDwLakmlzmzuL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clear_pages_rep(), clear_pages_erms() clear using string instructions.
While clearing extents of more than a single page, we can use these
more effectively by explicitly advertising the region-size to the
processor.

This can be used as a hint by the processor-uarch to optimize the
clearing (ex. to avoid polluting one or more levels of the data-cache.)

As a secondary benefit, string instructions are typically microcoded,
and so it's a good idea to amortize the cost of the decode across larger
regions.

Accordingly, clear_huge_page() now does huge-page clearing in three
parts: the neighbourhood of the faulting address, the left, and the
right region of the neighbourhood.

The local neighbourhood is cleared last to keep its cachelines hot.

Performance
==

Use mmap(MAP_HUGETLB) to demand fault a 128GB region (on the local
NUMA node):

Milan (EPYC 7J13, boost=1):

              mm/clear_huge_page   x86/clear_huge_page   change
                          (GB/s)                (GB/s)

  pg-sz=2MB                14.55                 19.29    +32.5%
  pg-sz=1GB                19.34                 49.60   +156.4%

Milan uses a threshold of LLC-size (~32MB) for eliding cacheline
allocation, so we see a dropoff in cacheline-allocations for
pg-sz=1GB:

pg-sz=1GB:
    -23,088,001,347      cycles                    #    3.487 GHz                      ( +-  0.08% )  (35.68%)
    - 4,680,678,939      L1-dcache-loads           #  706.831 M/sec                    ( +-  0.02% )  (35.74%)
    - 2,150,395,280      L1-dcache-load-misses     #   45.93% of all L1-dcache accesses  ( +-  0.01% )  (35.74%)

    + 8,983,798,764      cycles                    #    3.489 GHz                      ( +-  0.05% )  (35.59%)
    +    18,294,725      L1-dcache-loads           #    7.104 M/sec                    ( +- 18.88% )  (35.78%)
    +     6,677,565      L1-dcache-load-misses     #   30.48% of all L1-dcache accesses  ( +- 20.72% )  (35.78%)

That's not the case with pg-sz=2MB, where we perform better but the
number of cacheline allocations remain the same:

pg-sz=2MB:
    -31,087,683,852      cycles                    #    3.494 GHz                      ( +-  0.17% )  (35.72%)
    - 4,898,684,886      L1-dcache-loads           #  550.627 M/sec                    ( +-  0.03% )  (35.71%)
    - 2,161,434,236      L1-dcache-load-misses     #   44.11% of all L1-dcache accesses  ( +-  0.01% )  (35.71%)

    +23,368,914,596      cycles                    #    3.480 GHz                      ( +-  0.27% )  (35.72%)
    + 4,481,808,430      L1-dcache-loads           #  667.382 M/sec                    ( +-  0.03% )  (35.71%)
    + 2,170,453,309      L1-dcache-load-misses     #   48.41% of all L1-dcache accesses  ( +-  0.06% )  (35.71%)


Icelakex (Platinum 8358, no_turbo=0):

              mm/clear_huge_page   x86/clear_huge_page   change
                          (GB/s)                (GB/s)

  pg-sz=2MB                 9.19                 12.94   +40.8%
  pg-sz=1GB                 9.36                 12.97   +38.5%

For both page-sizes, Icelakex, behaves similarly to Milan pg-sz=2MB: we
see a drop in cycles but there's no drop in cacheline allocation.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/mm/hugetlbpage.c | 54 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
index 5804bbae4f01..0b9f7a6dad93 100644
--- a/arch/x86/mm/hugetlbpage.c
+++ b/arch/x86/mm/hugetlbpage.c
@@ -148,6 +148,60 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 		return hugetlb_get_unmapped_area_topdown(file, addr, len,
 				pgoff, flags);
 }
+
+#ifndef CONFIG_HIGHMEM
+static void clear_contig_region(struct page *page, unsigned int npages)
+{
+	clear_pages(page_address(page), npages);
+}
+
+/*
+ * clear_huge_page(): multi-page clearing variant of clear_huge_page().
+ *
+ * Taking inspiration from the common code variant, we split the zeroing in
+ * three parts: left of the fault, right of the fault, and up to 5 pages
+ * in the immediate neighbourhood of the target page.
+ *
+ * Cleared in that order to keep cache lines of the target region hot.
+ *
+ * For gigantic pages, there is no expectation of cache locality so we do a
+ * straight zeroing.
+ */
+void clear_huge_page(struct page *page,
+		     unsigned long addr_hint, unsigned int pages_per_huge_page)
+{
+	unsigned long addr = addr_hint &
+		~(((unsigned long)pages_per_huge_page << PAGE_SHIFT) - 1);
+	const long pgidx = (addr_hint - addr) / PAGE_SIZE;
+	const int first_pg = 0, last_pg = pages_per_huge_page - 1;
+	const int width = 2; /* pages cleared last on either side */
+	int sidx[3], eidx[3];
+	int i, n;
+
+	if (pages_per_huge_page > MAX_ORDER_NR_PAGES)
+		return clear_contig_region(page, pages_per_huge_page);
+
+	/*
+	 * Neighbourhood of the fault. Cleared at the end to ensure
+	 * it sticks around in the cache.
+	 */
+	n = 2;
+	sidx[n] = (pgidx - width) < first_pg ? first_pg : (pgidx - width);
+	eidx[n] = (pgidx + width) > last_pg  ? last_pg  : (pgidx + width);
+
+	sidx[0] = first_pg;	/* Region to the left of the fault */
+	eidx[0] = sidx[n] - 1;
+
+	sidx[1] = eidx[n] + 1;	/* Region to the right of the fault */
+	eidx[1] = last_pg;
+
+	for (i = 0; i <= 2; i++) {
+		if (eidx[i] >= sidx[i])
+			clear_contig_region(page + sidx[i],
+					    eidx[i] - sidx[i] + 1);
+	}
+}
+#endif /* CONFIG_HIGHMEM */
 #endif /* CONFIG_HUGETLB_PAGE */
 
 #ifdef CONFIG_X86_64
-- 
2.31.1


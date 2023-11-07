Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207827E4B4E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbjKGWBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbjKGWAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:00:40 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29F41992
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:59:41 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJaYI014901;
        Tue, 7 Nov 2023 21:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=7JkV+kciTmBpnKqUeLe4KVhAUVBeoPI01dWAxMnt9wk=;
 b=Js5EvDUXE5efVChn+JaiEFk0/A6TinJMyrnQe5SGK2EBxqTH2E+aHdhy+woSnHBsVlUI
 GFY0ZYTD9QlreI7ZD31j2da0GsoymCSdeNvoibLu8+RUGWQ0KN5jYWDpdOLn92Uqv7lq
 jetuKByokgdiNfDVkR9EV0mvzq4LXZFEBMheiRNx/3uRbyQrs7To3zCOU4wCrt9WNF9p
 PWN2jx4f6hZaiYuaxiOE8c3hScgC2olnoT4hSoB7SrslFQfhkgt/a4gPbvjOS9IQfJc/
 TTRsKA+xKZn2pj8284ePQkylp9vRCWE9DEXTve0UUMEqGT4oU2olWpGa3gXSUjCOHJ5Q dQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w26r2b2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:57:50 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJ1HZ000739;
        Tue, 7 Nov 2023 21:57:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1wsjd2-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:57:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gxmvdq9dtQAuuIq/hBR5Rfe+qKEIxqFMTj8LolanUh/jLQswyoJa7RXzp63wVlaZAnU63lTnQkKxJXC4TtWR0lyIHie/XclRfesQin+f8uXGswUUiB6YvwKYzWVo1VtIU6snM1fWjCQzvSuXOD7hR08MPCi3VJgjPhF36Q/LjPB/Y3fv5e9gyKwaiFbAipf3yP8SBNqws5cVtO9obXEnw/A9ArAaaT1X7VFi0t11tud4ZOiJatwdio+ezS+b08xb5m5Tf0ZbnaTyyHmw35gY/SRf6+GnD2+x2LXmKQ2NoXMoCYinxgiugR7wMRhBvQkoJRZNGi+V69dgdFrtYtEP4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JkV+kciTmBpnKqUeLe4KVhAUVBeoPI01dWAxMnt9wk=;
 b=bd4Vxgh97UXcuE3528iV/jcHFjAQhuL8Z2+rHsaoRCvD4Y+uHzfWPyBRcaELWUSxuINyhj2MU1ghbDSNQoH3TuZqyAF1Ax+6oJiGsC90Jmpo3G93ZKma9CnOQxzu/u0OwXc4MIhj7oXGasLotY7qCPNNnOtdyR7HwWF2J+SvQI+AEpgfREBTijHjX6ljroU/M6QL/KWLWLqkNA9muAycNGjjKaLJ9t2YiqP6GafK8vv6UT4LKbkDmPyqa8clFuRXAVB94tb4Y9baW3Pc3aF8QoLYs5lqHNSpVcrA8Gwc0ijfwJamSsxvU/EFcWbn+t5K4PbygkEY9xuxeopWBZ32Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JkV+kciTmBpnKqUeLe4KVhAUVBeoPI01dWAxMnt9wk=;
 b=lCMeYZkE/n+Z3WsJL1yPEj82JdMtbd8yHwdoQEukZ54dOYinzn8AHQx6uRr/Dwkx3EGUc3oOPLlshBFSwF+KbB5joXiSUFjq2lV4blvzZZ3ggIFJ1F3uh/bGUg2LOcyt9Du6GlQ1JclgG/j8Dv7xuJaWdjuEYn2WTsGDPmtvLOk=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CYYPR10MB7651.namprd10.prod.outlook.com (2603:10b6:930:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 7 Nov
 2023 21:57:48 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:57:48 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 02/86] Revert "sched/core: Make sched_dynamic_mutex static"
Date:   Tue,  7 Nov 2023 13:56:48 -0800
Message-Id: <20231107215742.363031-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::16) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CYYPR10MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 087f5a81-4cd0-4c02-98a3-08dbdfdc9484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xG/m8IW3aaYgpJkgAuVfuQsx+R1JxxqDj1qlYMggpRJ8iwHEMhQDnUDtrDkrO4zalQUyAgYa4XO21CZAibzp6NIug71eOi0NKSaTkqLUzhGUc2qvEU/Fmve2PkXGAttF3TJso0fksvx12LnJ3pofKLJJudv2csCvxN5GLFAFYgZspOyqiM8TYCGbSHyKhD8w9fUZHvIdtftERIF4gW5dCR4cW0Hu4Q992+Aa1dE44SdKE06qJS74tfXaqsyGAWHJwb4hOoryjtG9zBt+R6nypPKEBMhlcBdokJd/0exs08L4l9Vk23dOU0qP+OhTBGuwotSlf6PrTepWtCEEZIE1TrdGAdU7fH72yCPv5hdCZhbNRZOX3ef2QhwvJkG+PnzOeQpYKy2XgqZtfU7UjsCoY6qepGvW6CybhpsfMOvXD1Buy+lN7RrjjkzjBSa4JbvNSIjoJtQhSILZv6BprUKKtTwZaYaZXPkjM9Vqdc/DfY8c/J1aVGVGOPkScYswGnLIX78euwtcnwINfgbej9pKqHbrGUTqDPpdb9swhhSCms2sIlNabDg/7N31/I5vFbxE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6916009)(41300700001)(66556008)(66946007)(4744005)(83380400001)(7406005)(7416002)(66476007)(316002)(478600001)(8676002)(6486002)(2906002)(5660300002)(4326008)(8936002)(6506007)(6512007)(26005)(1076003)(38100700002)(2616005)(107886003)(86362001)(103116003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CdEXP7tzdi9FSzZmTbvX86r1Xi/XvRMZ474b5FTyX0Z4JlpOLP5vUSP5XE5Q?=
 =?us-ascii?Q?avJh0GRUVoz31AJMHvwMY2Y7hIdJsRUdB83Q7cmyvGc56K8n0LF2c1EabhXg?=
 =?us-ascii?Q?Dw7xcGEE8S29tQlXDCtDKTlB4GjcbUpHoDY+f5MWLLfcw/9PF8JYXtsR1uxU?=
 =?us-ascii?Q?o9T0tzKpDdtVxVXvRoxocAUcXB174splQaixNQCLFVupEi4eNjxQE1LgjTTd?=
 =?us-ascii?Q?+8nDWUR24DuL88qKr38Y3nlQToiLDF0b5rNnWVJdVxbcEd1VQ+i+bE7/79S0?=
 =?us-ascii?Q?Lq8JVnkMP1nZnisUsfZ1wDSz24sY+14jW4CYWEDb//T5pEy+IAMwB5eYxktX?=
 =?us-ascii?Q?BG2JDzES63EDIFKTrM2JZBcpRCWtanH426uoJD+NgJ95lHxZ8K+5qoRxMKPT?=
 =?us-ascii?Q?mB1iIoDQDp/N+B5VjC7VXIftBNQJUvK8jMukALP+y7XFLBL34KsYbl6a5Jsf?=
 =?us-ascii?Q?5cYtGelYJAGyMaJ27bEKYU2/VY8anxBUdDU11V3rhMbE31tgb5Vxmfq9CtLY?=
 =?us-ascii?Q?l5XTQufJAoxbKYsazRpHJy6znyDuHskwyy98yCsXgK7v6797SXxUYYLYRvOd?=
 =?us-ascii?Q?n+Esd954rjzcxHL1yYLu1UukGtGReRzoGjRzA9jdCuA9b7obnVmodbDy8sD1?=
 =?us-ascii?Q?QP1R/XyUt8ihcAUJUYB7lKE/0xehEr4dyEnwQfVfozZZqbFowFsMH/r+8hzl?=
 =?us-ascii?Q?DNsYlSKfZQ7QCzqBuf/e61ZdRikHhanux2HQWGqczjRKJuaj5MusW5p5TWjV?=
 =?us-ascii?Q?iLXkzoUQHnE9x1y7GdSaK1UQP6irKNiFRD0cBdama3E2BwLbTIKOQNomUEVo?=
 =?us-ascii?Q?hnxMZ5VrkX/eT8W0kAGoKVy7FzhnkdoGfn5UiQ4NoppYSzzXPF7gKFPvgSaN?=
 =?us-ascii?Q?7G6EJQsW0Utg5VtNQ/XRJgT/wOjH6x7Pt1/lBL5RDSTtUoMFTIKu1ly5SZo4?=
 =?us-ascii?Q?AyM8N1TUPme1mxPXAJ5YWbUbipEUw1JEN9lRRm7Qe2pmDJwnOX+uybEl1Ri3?=
 =?us-ascii?Q?yx0CsuTia6nJfMeJBwgAeGLw/uAgX8I9KRQeclXd1OgnjnIs8xOeEmk//Hew?=
 =?us-ascii?Q?2/SzusEkLNfHWx6IZMStMpHTKY/dYQF/aN4m75QemThlgGBazabwO3JEW7JP?=
 =?us-ascii?Q?NAMPFEOyIDl6UAbyKnC7CIiTJszpo9Xuy1Ys/9rQjIiDb3IjWELR5QqZuL+Q?=
 =?us-ascii?Q?gMtYCLfRonVvHZ1JelGcw0bOX+rfz4KrWav0FDNOLs0smVDaM3oyhUB8pKyJ?=
 =?us-ascii?Q?Xdw/+TXqnpBtk6CTreqrsfMWikHbY2RJRX1qqnib7A+FEqjT3s3sub6c6NrN?=
 =?us-ascii?Q?MHdJWpamCL4e/lZ8EkHeAFg+Sx2pCND3W5E4PvXtCrK8GaysswHAZCBWU96r?=
 =?us-ascii?Q?ZRyhF3c+zd8Vvri3lCUsnnQDoKV22XSVpbQVXC8wEEXaWAXAmukVNlLMme8+?=
 =?us-ascii?Q?8XItxlnoHrYZYKO7QJ0Q8e9lD53pOxB9juLAPjz/Dp8GsOrkLxWljRaGswXH?=
 =?us-ascii?Q?CcP88NESX5QgiUYl3AnaBrukIAKeEpxxZRYlomC0TLNqO6jQbG5X296nRK8f?=
 =?us-ascii?Q?YRNTMlKvWozPdJAR+Cz4E276y57AoNXCCRg0MwJPonVektMwSeAo8LV/hGrD?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?1aamNTWKDI95zxBetMfI653SrA2qRdlIjUmsspcO62TVZl/T25CTS/08IlUA?=
 =?us-ascii?Q?y9PjhIk4GK4LFSY+2XuVbFq22qiLW03cgBTftYaU+38TJbgYCAtYjjIlGLHL?=
 =?us-ascii?Q?4dWrwMzzZLaEIdkZJ+TaH2pg1mnjbG5s1cjCRfbPLzl5DfqlrCLnevAHkFp3?=
 =?us-ascii?Q?Zr+nGbYY5KbRMyhlr9UxYRf+XZYHiA5lf1xxPvp+jGNXsVgOLojOsy99hMVX?=
 =?us-ascii?Q?89i/1l3la1UW0PzE17xLvoeQ8UHCN/AzhwwNeA5419nc0gsBvuvEma7C3MK1?=
 =?us-ascii?Q?1/mlL54rsqXAS3jTVCL6B5fGrUQUL46Y8eV5MTOJEu9wZ26GvEDVYtZEuLYZ?=
 =?us-ascii?Q?p6EPaQ33uRGYV72jgvccrawt/UezcLzFeHCcelDGju1n7gQcCI/OEW8lzMXF?=
 =?us-ascii?Q?midSjXRhhefuLP2xMvkIWAYTuC3wr2YHdw9FNz6aijhc+HKUoweHjM7LtBAn?=
 =?us-ascii?Q?q6aokosSaDY3F6hJhlXQUjaLjuMc6Te05hScjl835Sqs13MUOjhL4NUGOanT?=
 =?us-ascii?Q?Ie05WnrlBPFo6GJhpx2fd1YGRLfmuPaJIws9KUHzo32ELJvFiiQowH2bhFQp?=
 =?us-ascii?Q?w/fSRL6xkK7DT9DaLyM7U+YyksaubdsXnpN0iRygGBkcT9jXIrYCvVF+HX6C?=
 =?us-ascii?Q?piy8gL2aZFpvFa2IxyGAeECFmYg0vdPMskyPogNAkFDTmJ0xhUiGH2cyE+a/?=
 =?us-ascii?Q?flUrPMkMDOfQw1OboDWbRYQ7UMHuIu+3x+BvT5Bw+z4r6TRDCfvTq6pxNFwG?=
 =?us-ascii?Q?NQaVdS8TjhG26oCWV6Yk86JfbbOlIMvX3BWcnKum5XecoVvT+3l/+7VcoJ37?=
 =?us-ascii?Q?UxI2FxTU/IO7gk9FAeJsisrPSzlkOQYxzlneFIU75PlNYhDRYIjZw3t052Lu?=
 =?us-ascii?Q?wnDj6M4kGmSFoMCivAVKNYqcSKlQfO291C1R2cLo8701FVyqHdF47Yu9wEKQ?=
 =?us-ascii?Q?PjBQ+7XTTJWVyuS+SlgR7RdOK5B5dT24USrztwxrlh8I7G/8gAbcm57Uivlo?=
 =?us-ascii?Q?W5DJqiniJ0zcVAIvKFpJTKA54BlD5ShEXlCWqgOj7S+DZq1laTPqdpk0wM9C?=
 =?us-ascii?Q?xs3VyEqt5YSQ7pA1focAImQ+IZiEBepuYbpaZ/VVMUPItFiOTaRKQWW4q26O?=
 =?us-ascii?Q?mZ2KE+eFimdEsLgep2k0ul+35pqUHjaIVQzVHfvIvWrjFjfGOZkbKWqJf4TD?=
 =?us-ascii?Q?5t1qH7QYU38EudxcPkWK1kzVm7sPtIj7uS4pAfYm1oYjh80koKzr61u93fyo?=
 =?us-ascii?Q?qdAG7VcjJk3NDiJIchTmutiwxW7YEk9pfw0E3f7PZvZl5lAxGsKiKOyPQEHB?=
 =?us-ascii?Q?USkSJceoF7ioVN172tH3XbCn2tj0m8Dd36eWzSc7t39fq4wr9vl0vhjIGuvY?=
 =?us-ascii?Q?REEeNP1bz2LvrTqn23guo1LHHpRIW+3H85kBxEWBekW5hwL67xKuEO7QXSWK?=
 =?us-ascii?Q?nY4A1svpw5n8uJ51MloGDm6xzQpzW2S0mJDd3A/rc2ilvT/0rse4MBAaJ8dD?=
 =?us-ascii?Q?q7jLWz8hxnml0WInpxOdKXdwpajIOLNper3P8O+/9vMXldHkTx21XgEfGQ?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087f5a81-4cd0-4c02-98a3-08dbdfdc9484
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:57:48.1973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QUHnjeBpHLegz+VzPQ0zCQ8KeN/++d/s3NdyQRLFsWwim7DPCfgoJ2yO6Lo4z05sfT6Hp3sv0q+6EH7SZiYbS/Q4bDZHmr5JFQKD+gykAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7651
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070181
X-Proofpoint-GUID: tjLZDkD0QR8E9nZqXfsH8d4AXAvL1qei
X-Proofpoint-ORIG-GUID: tjLZDkD0QR8E9nZqXfsH8d4AXAvL1qei
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 9b8e17813aeccc29c2f9f2e6e68997a6eac2d26d.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 802551e0009b..ab773ea2cb34 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8746,7 +8746,7 @@ int sched_dynamic_mode(const char *str)
 #error "Unsupported PREEMPT_DYNAMIC mechanism"
 #endif
 
-static DEFINE_MUTEX(sched_dynamic_mutex);
+DEFINE_MUTEX(sched_dynamic_mutex);
 static bool klp_override;
 
 static void __sched_dynamic_update(int mode)
-- 
2.31.1


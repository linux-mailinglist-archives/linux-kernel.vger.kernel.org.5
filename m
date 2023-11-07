Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8DE7E4B4B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbjKGWAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbjKGWAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:00:35 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D40C1728
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:59:38 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJP6K004600;
        Tue, 7 Nov 2023 21:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=f1g08Eb35v1Dd3lma6dN33gLk2SuN7jERIr9SeS5DdA=;
 b=hs2EHaxp1mOkiGixnjNgVAzZiT8/ognr28Iczp+3ZAu9czv6HIkWQNyyWTW1CtfJrOvX
 sPZiWfWN9OP5KUjnvFs0YOnIlXwTnD14as+5AhzYVy0V95hadVHBKATy5B8ZIR5w+C5t
 Qb72Hj7XAeA9b3qozE8tiS7o0/Wd5YWbBNWwU9P5gPDmyX/LB0DccxphDlosJrE0YcB3
 50IoUxLZOUQJho16YRZrI+omJZay8FBWcxWfMRYxTUgSn6QJJCYC2VKNf/8K5TC9lva2
 XdWfFZcuGG88H6G+TaBMNlHFONcCjwR60+eoToPVsdRLWa008Nj+5VB29pOCjl8qkqJc qA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23g2bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:52 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJC9t032033;
        Tue, 7 Nov 2023 21:58:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w221g15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKmkyYTxEOTO+XCH2oMjCCZU2lL09FTNtc9bt5EPY8PRBZQie71RtawkZcUw3kkT4zqcbOBQL6qk47g5z3Ftl6j//oQjNBy2rhzKZuDUr9pNgF/QOpMhHjBqeIOPwnz3RY9dh64hjMa3ySh9D6Oi+rh+FPjAbJ69xRYhbZCi1EQlFODRuE6z6HrMNOag17d5XbuCt8A6wlMqg4Wt0QZVt2gZBxyDCv3nbl1jMs1Uhp26enSn9BJT2o7iS3ylyIsK33FT+NSC4ZivVe6H9MwS2GcyJnzgTPknyZd7RgSpfG/EssdIpHhHKs4c4jn6SqahZLboOfgveA6zhqEDv2ZIAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1g08Eb35v1Dd3lma6dN33gLk2SuN7jERIr9SeS5DdA=;
 b=Ss/kt7QOSrQ82dze1j1iR40ut6fwmFJRzP6g+Q6+DMvbnwtVlZ/zQHow7GTIh8cDVDqkL8EnskeFOnGLQ6DCJaPHN7bozGwfqpVxvZqWgla/BIeJGSfoKeMH8b3t+4mHHwjkbjFqmlflXh+3OCSvssfespVJOoHZKsyrhGqWVyWdJnJwkJarUaRsJNZnrUjr65b8gF2SbTIUkryPZr+fD872qzBElVuLvk7U3BBdsRZ0tJNV3L0b1bwSXhSyODcq+epi2ALr3G+ftxJ8R4STjYu5r5Rj0pTCZa4TpA358nro6X/jHrT+rsjeod6rXhyNJOGGL66Z4ahLHeQrqg1dbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1g08Eb35v1Dd3lma6dN33gLk2SuN7jERIr9SeS5DdA=;
 b=J6VmkWXpTTWtHnNybsHYK0RX9++2SrEYjk64sLK66lg5TFcI2tDepAx9nMtHdQOYTa4t7MmObajCn6rbE66r9fYYUpZCdlGrMeegzeBarn74e6Vulc0JzIIFOKaAu7XA91aTxxbc0Txs0gcNfErtLh63wUbVnT1LiyIdcxfOSCQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5048.namprd10.prod.outlook.com (2603:10b6:408:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 21:58:48 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:58:48 +0000
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
Subject: [RFC PATCH 21/86] Revert "sched/core: Use -EINVAL in sched_dynamic_mode()"
Date:   Tue,  7 Nov 2023 13:57:07 -0800
Message-Id: <20231107215742.363031-22-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:303:dc::23) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: f08bfcdd-61bf-420f-9a4b-08dbdfdcb85b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: suEH1UZM50VEDNLoMxhdiyuOXhZqtZEIo4/eglHTv1DemFogSVx5Py0P1KLXintdRDE5CCYs7LrkFONdsBsMiGkiwcQ99hIc6Clo6T0KS9WgxNiP85s7niMoXsI8wUV7I+YjA6XQdurUBKnQLTIZ0wGRcd/vN/zsEcxEIgS5psGKaZB+VIt30/3BfsYl7AUeQDWVxFJaCkxaLjMv+FeW8jxWPiUoRn70RYUextex2clcQ2YyQExaU25/HtyxnGQEnoeWhPcuLDABXRnHR8xwlx0TvnmV+vEhUNh6J4LFPRRBBbF1HLE/Wqil8W49JAxdSr45Q68SJtigA2CZNNn6cAaJ9H1Ak6aKgOik8Lk9iQud4ND4QX+AiC35OCqPutEX2g229nfM1UyN7VAtLuRWc1e1bWnxe1RXtEv+6WQtXCUBw/Dk905s10FW9yfHj7TKK6RfQ5jHUwU5/J2fu5Me2RKkE7zQf8EkRO95EM+I4eh3XDrPXLQ6kNmtc+ve0CLXA7py0bDcb4Qz9OhPfXtewNNAxXeXSj17ZVfrB9FFnKgnFvPYGyfkdsP/f+laFqSW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(8936002)(4326008)(8676002)(66476007)(66556008)(316002)(6916009)(66946007)(41300700001)(103116003)(2906002)(86362001)(7406005)(4744005)(7416002)(5660300002)(83380400001)(107886003)(2616005)(26005)(1076003)(38100700002)(36756003)(478600001)(6512007)(6486002)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FmKeHQBR2cWsAS9UJXL3+AdcgcVehkFoLtji/PI/r8nX0bLMkjszRlP42U1L?=
 =?us-ascii?Q?/F1w86S586ypuGCqCJpzj4a2kH0kaPchiUTvjSDbfT3tDP69Ap2uDMgNgyzt?=
 =?us-ascii?Q?JwL9varW8WSuKQuNHv1OEqsIE24IYEoJ8M1zSSCJq3ql2sENl/rxMDiXaxbT?=
 =?us-ascii?Q?oub5cMu8jS2BPV4w688VZW6vmjGm7+qQrx06TxiUVgBbHKy6S8pIfKJ3KCoD?=
 =?us-ascii?Q?T5YBiEAiGfFzIfDqO+pRQqHZh3fw20fwSujIwnYNhe+9bWhqidzHrcJREAvR?=
 =?us-ascii?Q?tlzGV/9h6R7SjYEARZ4MJhjbG6qg74DbCs1bLwfp+l37Y0jaGj5D1cM3fXDM?=
 =?us-ascii?Q?+V494iYzmDl0HiRnhm1TB/Crfuu1ATEBH0/lemyy5Y6e8RUVqaQPFY/Kewu5?=
 =?us-ascii?Q?6OICWWp6HG69GrmScKdioFh7DoArwU6jB82oa3QMWvSK9kjCgqQ1NnTNxT5t?=
 =?us-ascii?Q?hf5CYkrF3Z2y4FtY0WfGcEu+mD/USxNfIjLFNMjy6t1nczutZ4T6x4j3nxCC?=
 =?us-ascii?Q?iMGqOwRPzBoOBGflluILUd/AvueFNzbkLlolwlBLw9762n2PpqkPNhZRoZ1/?=
 =?us-ascii?Q?tZSDyWCUoWwMGLX5PvQ22REsa0WLI2tgiAcm5hGH+LieQqDF5Kl0dHORwWYC?=
 =?us-ascii?Q?ISZF3pMdheqWRNbtwniSwBIcEbZZ1ZZvDmteUQLsMhov6e59Vv/yWeGJN3vy?=
 =?us-ascii?Q?lCUzYWyRvSTh32id7lKJIUqqHsazov/lfQbz9JvCtMKU4CInkaqD/CxLqvWn?=
 =?us-ascii?Q?OMDdMSnj9QcZk2XdjHZ0N7ZXMggH29DuhVoEksjNnJAC5dLJW6q99XUCseSd?=
 =?us-ascii?Q?vkdZmK6G5QDYkjK23wEFhG9psv1jngz3jM/kiMorevLfQt47JlxgvjHlTISq?=
 =?us-ascii?Q?IaLTStmV90pIgOKjUf16dg7UhEx2j3kcOxULtc8MF7VAMHreqGrq3grsIAJU?=
 =?us-ascii?Q?9bFwnfBUdFDDqBjg2DyaK39kucl532hkh9/6oQ6lpylJZiGXOW0fFkwdSRAB?=
 =?us-ascii?Q?DWaQBIGlTnu2lebohyopkO5sufNNVaPZxpJ5qZSqXGMv/Ke5nIqP+IvDohPn?=
 =?us-ascii?Q?MC80rpabkRjulLPY0hJNOgEn7WFAw42LcVtyqy8+UCfjKhpGrRruMV/+jAui?=
 =?us-ascii?Q?KxrZeGsEDm4ErrxRkFZO3hq9S+gWa++9XWcwSvWRsNK9PAbAoH0r4LZzpGRR?=
 =?us-ascii?Q?6rxG+ibWA+mJdzPLP+WoCxxtfKjCjmQiaMeS/z4u3n8qfGOrh3UjtWLk1Zvj?=
 =?us-ascii?Q?jB+NcAxi9QXiShbg6kLeiJRs2fdVFcc23vsZaWsiT1nLBWj439RPymGLxJ9a?=
 =?us-ascii?Q?ILDnc4SEq5pbOiUIHYaKbXlVhOhAk+x0pwTgWk2R2qeWiO9A0CnFpbRMJE+t?=
 =?us-ascii?Q?soUrYZiGkngsuOdmaNUUCN+PL9GZ6HqZ8WNNofZNGPwz/OrZMBuTsUrQelxw?=
 =?us-ascii?Q?JWIKEOEuF1yEqFa8GLPt3ufvkG2rS7bFRef/q+tTGpiEE0chYirKhumGXwv6?=
 =?us-ascii?Q?SteS+wpD1cwEMh6yIjojasN18W41bNuwvL35x7Y0xQOC027f0kvI+Re+ynEk?=
 =?us-ascii?Q?UVB1YNMfwEzovOI6UJuUniZn3KiaQiFf+lZSh9ZODzmvhqagp9+vP5qwo7f6?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?xTIR0oBSkMZxZ9SJu7tI3rsnZR5vBdtDwbWu9cEmZ/9rRy8VSXfaktEILdse?=
 =?us-ascii?Q?sbWMBbivHgnOU/lN72vRAYL7SMsjD4/d0x9k1SOAKEEi+NoXKAiYsra9yax1?=
 =?us-ascii?Q?QlCbOBYP5HdxI8NtGkLhgvJpRGgq3ihUnGnnFGdnanpXWb51I1s0GdG7cZV0?=
 =?us-ascii?Q?EEhYMV2BDMqwlCv3uQh/JYnY9Mto/ZYhk8DpXVlyhbgW9kHj6DhzMPIPg+GN?=
 =?us-ascii?Q?1IwjKDHDgbWRSBjtdRt9/60vP5u8U1v079x3NNivwryh5+Xze3FtLq/0K646?=
 =?us-ascii?Q?LhRvvl1bgOnFE0umu7nlCexbDqzW/6xjzNgfRDJk+NAzqHaPLCSRA3SwAkzu?=
 =?us-ascii?Q?gt2jalPgfs7JbgPgq6zTAGAbxuYocL3U2ShkauVy1SiSuY2Z2LMQy1VDrtkN?=
 =?us-ascii?Q?oALLCqufHa1WivMDE7mPA1RTg1/HBpmRx8WQjEJ6XGpEcR2tcoIoRX3i6h8h?=
 =?us-ascii?Q?p1JeWL1C6gVcGk2+kENeIhgBDYe2TmFdJX0QNMhlXxRkdps7maKkbFW9XmO4?=
 =?us-ascii?Q?nP++bfSpAedaar0s2hDBcTYnZYg9NmhfsiMi4RXaZT4xBSmKWP8G/+XWL65n?=
 =?us-ascii?Q?j2Q4tfR5OYzh8ZJf4xcDKyK3tuzL5Bf1VuUvJ4qKlz+fRl9fMhsNOusBhvEe?=
 =?us-ascii?Q?wF00+7R3wFbxlObsoDS33THqIPdChx04Wz7uPfuU8oEFuBmrnrd/w4XBCcD0?=
 =?us-ascii?Q?H8anMflzBa/9/4KGnGMNem/4eKrfr/A8EM2Do4Rfv7f9Q4HNLY9SxNUftZ4e?=
 =?us-ascii?Q?CjO0w1gRh1jgkCJuVwHjWFhjhJWVWvWYyqtp2/NGqvnZWGWTPPEfwkL64oy8?=
 =?us-ascii?Q?/1p5T7Dvrpe/Mo7npf9oq0QluNS5bOeDYQ2oU9MlfJ1PKavobfO4ieFivmRD?=
 =?us-ascii?Q?+yYqM7XY9dHDBj7X9PXRTuCMULHGIFi50lwtLRrW23LmFFrnCU18tvQtpAX1?=
 =?us-ascii?Q?G8/Ei89CxmZ90eVOCm77IWxE7ZnJnc7QfkjNSD0m1G+eKNnsoHY81TFzbMV1?=
 =?us-ascii?Q?cbT3MHU8BAGAOu8l5J+Ba7GcCKXkdrUhJg5vzaRuC/yepBBW6jRFG9hqgT3N?=
 =?us-ascii?Q?5jnQFRi0LBRCwzpMigrxA/QWDaj2SrKkXEsh16E/TvewSZNSDEEFJ4sfdl96?=
 =?us-ascii?Q?bt7TS/+n2b7pMnkjjk34dAPpqRozE8Qhqjkr0Z4/ocB1PwWk5a3Hh2B/Wk7N?=
 =?us-ascii?Q?BKY+dqP5wLBVfe4Wb9O3nk7DxoG35ZWNMv6dS+Z8Usf5DjLefQTNuGO0i5UI?=
 =?us-ascii?Q?I6oxlt3/kvA8SFO9YYgtLv9RCv1uhHaAE7ukaIZwItY6RQ8OAmzbbq1q+pHI?=
 =?us-ascii?Q?uiyga2gQ1jXMrcsG+G021qRn0xoK+AhzxYiASJR/DXDdPoN6FgXKMmUQbPA7?=
 =?us-ascii?Q?TZFd9a4dxxwjmwbmqEExyB7rArpN7jItXsHRIiHDsbaoLvCu6cCAS0vyGDAH?=
 =?us-ascii?Q?Tsm4s0WLbcL0ZoJ6pRLGnSPhuQ0GQ0MhM9/2O3N/5ljCYPdaSbQhsyPpGzkD?=
 =?us-ascii?Q?vV06LUafdZSViOds06a2sKt/NV9yiwT143TfccFd71SC4YTOcFKKKuVG9A?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f08bfcdd-61bf-420f-9a4b-08dbdfdcb85b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:58:48.3166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gqKTh3CYx+ZPMVFUcBH7vWZMD3f9deJZx6qGUc+79EhZSLD4AXoBggf38Uh2eLtuV4Gj8h34jsuBwakTRII6mEu3pLTRe6o+Y4LPJI0qn8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-GUID: h1BORujpGK4_YWyT2jbTPAVf1NYompbC
X-Proofpoint-ORIG-GUID: h1BORujpGK4_YWyT2jbTPAVf1NYompbC
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit c4681f3f1cfcfde0c95ff72f0bdb43f9ffd7f00e.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e0bbc2b0b11e..673de11272fa 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7009,7 +7009,7 @@ static int sched_dynamic_mode(const char *str)
 	if (!strcmp(str, "full"))
 		return preempt_dynamic_full;
 
-	return -EINVAL;
+	return -1;
 }
 
 static void sched_dynamic_update(int mode)
-- 
2.31.1


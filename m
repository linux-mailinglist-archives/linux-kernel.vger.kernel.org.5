Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CF779B131
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356411AbjIKWDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243634AbjIKRZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:25:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE3FF5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:25:51 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BChWtX028465;
        Mon, 11 Sep 2023 17:24:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=/A1JTTKL2FmXOMwshwDHsikN8yguFzpZoD9fIsIVw80=;
 b=CDZMhkeakCJbuv5xWK5m011EAtZos1MbgIDh2mDLsa1yOFoTMZ8hkN4DF4/20SH8rJWa
 pZ20huZ6uf2tP3GdvTaUEjYW6lPwQ8ozK0BZB4isqnsw3GwE54aETA3ZwmkTPiMGYkke
 2XHma5IqZyKe+xAsEv/ezDF2VLJJwZlr3GXOGPkj6ptIWYSTFxitOyMO4Z3Ybs/5UI3f
 anHx6OdcEngDhjJ9/njre2+Jx1gRUtRbzPPNKTywKwFrtf6WXEMBDzpCaoB4upEcZtgO
 4vkiIzLhqH5VgW3KvSxGjEIjAG8FmC+SE5Gr+QmphpqCoA28K7MH2pQnbcJPlWigJoec 8w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1jp7a17v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 17:24:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38BGUbuf007682;
        Mon, 11 Sep 2023 17:24:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f54htdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 17:24:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gv5iCa21Yp4ASaEAuDAb6CgU8xKVtupWtFNRLNcQZC0Fii596ZcUrg67QFiNedeo85YYs5pYoIwQi3NER5gYOuoWP1r4jjjSI5fZwYukojdxKvRX0YGCOqPenLGggSlBuloKZEdsaLWRa2Fn0FOfPvCUi9bf2LyUGFwfbViLJyl43yg8rpbWUBsnKo1Gam00hZdGasFogl2E6KAWqsnOnP4o76jV7hFmGewroiqCnXdAA8S9AhjFScIY3wZJDvt8CIErGQiV+RX6r+rP1eUVZnoOkB/Ka4p7j2DXLHGuZaiqazNML3n5T2F98cj/7caEuX3Df1JFspNrseZNkeFNVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/A1JTTKL2FmXOMwshwDHsikN8yguFzpZoD9fIsIVw80=;
 b=Jy9Etx/2afONh2OrN35jIpMZShoGqhxJ0IP7lAXvslR+rV2Frf9B3iMGtG5bwbQayC0ojp2MQj1PO/cEL7V1/XkUgpy0HMaw/Sx5pNQjFZ6l4WYB08uxQeFuzY59Ts6CgX+5GtxMfz4XVUHfjnxj9vHseg+MzrRYelscSv/gi2k5wkWWP4y4sFJ69yTMLUdAPuHS60bIeQLBxc5ttTrIEhIpp2LzMIhJIemtqxQtAhIxDhlE9y7P5BD1i+UKimACWhgbsXWB8UFtzaGHaAg6yP0bhMwCAzG0Z3fd4EgnVYsqBb6HFtWo7+Y3GGqPFo7YpxmMouLqR2hDXojOmC756w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/A1JTTKL2FmXOMwshwDHsikN8yguFzpZoD9fIsIVw80=;
 b=SQ1Lp/yaYa1yGJJsbJZG3B3+ZKzc6ZwxmKootuHob35MAiJrkzHoHn19TGi4mofot64H515+oM3DNboSmjDkYEoLkfUDCzTzBRxBNjuUsuOUJWmFoGf72XcgpW5N4QomPfRg9wb3U8JBPsZNh8QxVwu8MBQrIFwXDchHOv1pIRI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SN7PR10MB6644.namprd10.prod.outlook.com (2603:10b6:806:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Mon, 11 Sep
 2023 17:24:30 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03%5]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 17:24:30 +0000
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-9-ankur.a.arora@oracle.com>
 <20230908124201.GC19320@noisy.programming.kicks-ass.net>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v2 8/9] irqentry: define irqentry_exit_allow_resched()
In-reply-to: <20230908124201.GC19320@noisy.programming.kicks-ass.net>
Date:   Mon, 11 Sep 2023 10:24:28 -0700
Message-ID: <8734zk1v3n.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0080.namprd04.prod.outlook.com
 (2603:10b6:303:6b::25) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SN7PR10MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b0a1e84-e925-4bd2-3f5c-08dbb2ebf52b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y3oBXc+/b/q0AUJ+VTR6Qm5Y2JcBW1JFvM6wdoECwLgYmkkp4lmE1rxfZg7Lcfp1wuFPiERiz4yaG1GwsiuM0ed1VULSYuyfSSJ0RX2UaFBEYefI68GtwlU5pdDL4ApiB4lLAO7xOL4sHbXpcibA2Vft/lF1UgeRIfcpxZphcdLMf5KVq15NQj6rNP3AbAZgIiksUFGDG3q1rcmy+xW8NW0BPWwoliUUmitSIzjt9x9cBbTfErwGXq6V+2PAs9svbxYQZ9YY0QVrkfvwEkfiBcGyhh8r/NEzmhkatbAivb9Gq1Xeg4hAUfeqsQYDRjvK7WDOoUz3uq/KpLBvLCa+S8Jml+PJ8JURiO+b944Dwkd8S1ErYn9D1xMGhedhmXSctcihpClhp013+HFPsg9zB2sUBAHk9ak+dvmuDMOrz4x5MY6r3vOhzHXAc79vl2smDA4NF1059YckSHd/b38ESXwYEVlRiinZsBSZ72UsaTSvOcN/3rA7BWtBFPmGapccEuXUYDYd9Y0Yr3iTSjUUO9lUbgBG07OJ265xzx9MiYKvpQlG3aBAySqFyZ3qfp6u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(1800799009)(186009)(451199024)(38100700002)(7416002)(478600001)(5660300002)(4326008)(8676002)(41300700001)(66946007)(316002)(66476007)(66556008)(6916009)(26005)(2616005)(107886003)(36756003)(86362001)(83380400001)(6512007)(6506007)(6486002)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3LtqcBn/TwAyMIOHb5LRcVYYVITrPFCWA7leXqh+4Nd27GZ5JFgtV7s3qaDv?=
 =?us-ascii?Q?3cwRBjoW0VEszloKalhKG3SzlfAs9jPb1ujDICOqo4pLFgF8NWrNdRlVfd7N?=
 =?us-ascii?Q?x2RLLKScEMq8E7gxnZBPw3BHPPR0upSeEHk7EVM1BYjtFA4La7ewWPQc9pNv?=
 =?us-ascii?Q?ksLApBJXvO8L9qLLHbfW8qnVRAq9IMffp14VIhVYo+EiKDuCUT62LZfFR/ZZ?=
 =?us-ascii?Q?3m6jI+MIhmRr6uDHZRMxPurRr3S2w/Uqj2XCTP+pSU4kpjvDK2RbM/oDcniz?=
 =?us-ascii?Q?LNCOmLwGX4wnPoRnNgz79Ew5mBmYvIwb9lyYdL9dlwVfKP/4fgLFF46JoR9U?=
 =?us-ascii?Q?dZ3ryye+tJkuDBnIQmjhM+PmyKzLX8flGwNnnkTqFatFZEWA4HIZ+Kixz4O6?=
 =?us-ascii?Q?tBUOOFCdlUDCOxjjN/uUWUqumh/eguzPYH0LmkjdgGhK70DJ056tE1yx+VGs?=
 =?us-ascii?Q?S2XSv4JjFQm9nfg+lmNVt6HOKsZ7uqH0ZYUcZ7TM+WM+QhycppIOHcukMdjC?=
 =?us-ascii?Q?0VAhBpVwWuhIpVImHEyMi0115ERAQpgzry6SMo2FqtycXzTdZEAP/1SXxGmu?=
 =?us-ascii?Q?7l/VyOsLPCpLhnR2HL2rwEeW05SGuYmovElK9ZYmx4NZKAinT4QP9BwjpthI?=
 =?us-ascii?Q?/svuYdBddVT5lvI8SetyqAghuhBu1FFAsFvoDwrqmrCZKMjm7GfCzu8paLL3?=
 =?us-ascii?Q?3ItA8dBPJQtYpmdUWov8We+adH/3QF4wIXTxbl4nCjoFWeuVR8qNHSuZM5tf?=
 =?us-ascii?Q?qoDXakLhdp/2rESaMjrnGcSc4vn+nSv+lYdl5V1qFHUpbXSPNRSqSAkMCx48?=
 =?us-ascii?Q?ZZOe2tNi3CCnHbglUzMeG2rhixzPkUDz8XNjf8LoxoFPiu0vtrCdjqR3dUUA?=
 =?us-ascii?Q?LqJhRF9PDBE/bJ0IamRNiEzWXmwC+6buvOlfCg0w/4B1YvN197lG0Yv5Yc64?=
 =?us-ascii?Q?Ty2SJ7qDxy9TUWldMwrCmtvAwy8vp3wOrOyVV/mxKfBFF3tUdTL9JZP+rB2W?=
 =?us-ascii?Q?AX3WUOp9L/xa2ZjuAdvfGPz/AoZ6ybPP+sP8J+c032n1OBWBk/K4oRym0VPO?=
 =?us-ascii?Q?765R2rAWES1QoRk0qhIrhonlxPoGlvls6AqlyxX3QUF/dg2QnXUTyh8qiQEZ?=
 =?us-ascii?Q?damkQ4EwppCCNxwpvyj+AlTSsGq+z5EYXFCx6WyxIZsv5zwkJ9STL0/LZX2I?=
 =?us-ascii?Q?bARwDQ1Q32Fy+MwdrbZ1/O2NfdRhoKi5cydrp6Uvn4NbMRmcv/xteUPchUnw?=
 =?us-ascii?Q?GJKPub1XZ/40sh15yTEupK7eb/nG1JjwLOk4vcw0b1EYpZz/qxi6kltx541Y?=
 =?us-ascii?Q?scP/kivYGS9sRR1K08F50M9wDY+YO8bgG1wmtSChqFNvj8jvLHFOyQlQvCjR?=
 =?us-ascii?Q?Aja4Co5gpzzCiGitKqN1r1Ggke3A/vESktsnxUUfo/AxC88SE9EZSoFlJwTJ?=
 =?us-ascii?Q?4ITe2nzT6XfZt5YoYW2DqM5p+VPEAZwmyqcMXBAO5/58DtHyqIQR7nYirCcx?=
 =?us-ascii?Q?GNCn5JRpt6OMCTHhgVtkJfoMXC10QZ9siA6/d993oOVyAA0x1IeLf2eUfV1r?=
 =?us-ascii?Q?sZ2Uwf3aTKKZWp4Hy9GcqOMxWAD5nj1yLEdxCbcho+B44xnEoqKQu4wpD2b+?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?BwCn8q1QWQJlxFrD1YqF1g3sAw3HIEpJv1WFEfOZuOLfr3IPwM9AvUF7Ny8F?=
 =?us-ascii?Q?Uy5+Ht6yG1QQpe1t0qRtUvNbmyELfyd7T1rgOtTeA7I0uDl6X6NGICjeugAR?=
 =?us-ascii?Q?LKtR6juQhQyYZvuCY+D3t6CNfo8/WGRoncEhcPdILKjrUviP1xWFpRHWpfTm?=
 =?us-ascii?Q?h6CMJS1L1dZpzFTIwERojVx1IY5jYpynOABrDHeTkx5J7bQW2lKi51VNWbDM?=
 =?us-ascii?Q?jpudUeiVFtr6DaSfeeEChzn/D2YfAywPCbPs76q5wlrzpSk1n4aHBzO4OhEA?=
 =?us-ascii?Q?vW9gwQQM/exX5gxzOxPl2DjzuuFvPxivbj9is3xOPDzhfMVukQXpPQlMock6?=
 =?us-ascii?Q?49idN5+iBq0a8WbXPxN9EmLIB6Jx8eSS6bcM7joKmR55mzhHQmYg87A/u8Jp?=
 =?us-ascii?Q?IK/mf5h2eJWId7XeQhhJ8qeHF7r0nS6D2ZQO+LxPl+9i+P6qVIiGYECMkDjF?=
 =?us-ascii?Q?bQ5/4tkamAW6ywHeW2PWIJyWvuUK1DRNZ3JvW8CZaPuulwbUfd3S2lxYpUtK?=
 =?us-ascii?Q?6fcpDUWglElang8GeJfIVkX5IJ0coEj1pGf6PelcPBSGYp2d29sUBI3TqYWC?=
 =?us-ascii?Q?06pMSVSfaLCu9/Jth+TuveVv/1LT55aOcEzwvb73Mdqy9F7VnxyQuAXv10GJ?=
 =?us-ascii?Q?fQ9pJm9FqoKTbnTAETyuR8M06dI/WuXaaQFwR4nTLEIE8Bj8SwI4wlkYsW3b?=
 =?us-ascii?Q?GkmeKGNAtIFVerI0WuvdOYGUryT6zhy27BN/+oIoz36y3+HOwJFHy62ieCQi?=
 =?us-ascii?Q?tPRFfgci1ipwpi5IXNbD4vgYPg9x6N66kAW1HAJF9Prj4d4tbWSEr5WHXrsj?=
 =?us-ascii?Q?n5mwVOlB8bNXG5AZyt7EdEd996Yxv/4xW6CkKD0auiMT3BlrISHOvk+eefcB?=
 =?us-ascii?Q?ZB5Cqz3nogrQVjzqsqr4K3wA/b9HrZTSSDX7vWe02zX9cDxRNRtGZXaf1T2M?=
 =?us-ascii?Q?c/oZcfQB5dIJIh/G+rQWNkDOJHXlKqWe9iaVqnvSrDHmPeB2dDIYhH/+j48g?=
 =?us-ascii?Q?/Zcj/TL0/vLBu3GJyNnYp7f6Xo9PXQ/76lmu2DqNNAiK4oNmX4zaMppemsjW?=
 =?us-ascii?Q?a4nzPC1g9aObfK2g34v6rIgEmXSy5r8ztvoZE5tQuzT01t5bpbqjanjWAW9E?=
 =?us-ascii?Q?JcY3XiSinsK6upjiyxaQQycdqFZP2gb9HzMf3zuWOZ7UipNNjigIcqY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0a1e84-e925-4bd2-3f5c-08dbb2ebf52b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 17:24:30.5914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLakUGnPdtP5MCxTzLLUV5l+mSpNxMp8RqdH3VhPXTKfKlpBVTDsg9mQFT9jdTdQJUvz7pA8pB6gyYBVyavU6iclVAn2f3vC0kkgoObPy9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6644
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 mlxlogscore=731 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110159
X-Proofpoint-GUID: GPXtbESQn1QhgRVbA6tmu-T34qAk9ZgO
X-Proofpoint-ORIG-GUID: GPXtbESQn1QhgRVbA6tmu-T34qAk9ZgO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter Zijlstra <peterz@infradead.org> writes:

> On Wed, Aug 30, 2023 at 11:49:57AM -0700, Ankur Arora wrote:
>
>> +#ifdef TIF_RESCHED_ALLOW
>> +#define irqentry_exit_cond_resched_dynamic_disabled	irqentry_exit_allow_resched
>> +#else
>>  #define irqentry_exit_cond_resched_dynamic_disabled	NULL
>> +#endif
>
> per ^, the below comments are not entirely accurate, since not every
> architecture has TIF_RESCHED_ALLOW, perhaps make it:
>
>> @@ -8692,25 +8694,25 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
>>   *
>>   *
>>   * NONE:
>> - *   cond_resched               <- __cond_resched
>> - *   might_resched              <- RET0
>> - *   preempt_schedule           <- NOP
>> - *   preempt_schedule_notrace   <- NOP
>> - *   irqentry_exit_cond_resched <- NOP
>> + *   cond_resched                <- __cond_resched
>> + *   might_resched               <- RET0
>> + *   preempt_schedule            <- NOP
>> + *   preempt_schedule_notrace    <- NOP
>> + *   irqentry_exit_cond_resched  <- irqentry_exit_allow_resched
>
> + *   irqentry_exit_cond_resched  <- NOP / irqentry_exit_allow_resched
>
> Or something.
>
> Also, why did you add that extra whilespace all over? Makes it a bit
> harder to see what actually changed.

Yeah, not sure why I didn't catch that. Will fix.

--
ankur

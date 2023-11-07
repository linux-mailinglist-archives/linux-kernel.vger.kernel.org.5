Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE947E4B52
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344179AbjKGWBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235341AbjKGWAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:00:40 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28DD1991
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:59:41 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJe1j005455;
        Tue, 7 Nov 2023 21:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=f1SAlYhp0paKZ4VGIKby0nu/nWD1InjWF9RcOLJuOCQ=;
 b=KUrP8WwxWpNRmE9gQOvlToA2XwCAWL4Z+X1XPnb+jrF4v1PG8yFe0P4KroRLEww4uShr
 riY921aWRRNkTE7FFM/KzeZtFwCO8DoLqWXspQ8usJvj1/GNpKnFrDZmc5cAL0BYVwSD
 DIHNxByX8wdqhzRWRsqYOg11NeOUop+NlQsuYvDMOXgUEbZQhZLZzVmmQZE2rOSKbfNU
 SSqxqE9jASLvdeES4XH1dqPWC4Fhhi9s/Kl9fdq8xOA5zp5FCJd59NHl3E5iiWglf/nR
 FDRTRroLCLKu1vruIKRIRKK4OUMmiKmeN4DfOEUkKJbhzbUyxKz+jTtR86M7a6yIteb9 fQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23g2ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIrHe003903;
        Tue, 7 Nov 2023 21:58:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vshdn-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LA4Pp9Qnm/KpMw7Lcj++GdKvyu5aupfurAVhzNFrku67N0r+u+BdJFl7HwXFlN0RjH5WExWlzSVVOYgOnEBJIz3bf4eyL1v4KMhm8gYOhHUxkhy4QUYcEWlat7brxsICWnp/qF5VIwZ5KSHm8kdNtDZ/2NkplN3Y/KCbUfBrfgJzFH46Bi3ASmTRcVnYPvv97SiqVR8T1u8bDs76bHp4U3wv7z4wgX0lpgjp/Dv4okbsLn0huQdixSWbRHb+aqTKSOvzrbhhP8scbpkqjRXOYgITkl6P1Hh+cjPpG67jBQO9vGTjzwd/Wzo23m1+u6P3JBHm5tFHh4u3P0WiVha8Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1SAlYhp0paKZ4VGIKby0nu/nWD1InjWF9RcOLJuOCQ=;
 b=CbBU36ROAKr6cVbP1LcCf+sx7jhS4486XCPbrV2gacI5rDaq6LcaQyDejsoP+aggUVbYu6ts+nQYyOBHti4V2QuTOBsvImEiwxUcNYZZuk3W0d8uAQolO4ivu80rwyfFusKUqHTv7Pdlf7/WWz0WXNlDBCpxMRAEL+9yjtHG5dJbe47pmjFcNGhYqLdL4DoHz+vsMJZbSgD444mUKnLUIXoKyZ8k+9PfWnyuCNBwaSmg5Goe66xgmrCwcnZq1HKT3H1N2E5/LULSC5shz0gPeb+2voLDfUwGZBlSr7eaIzyKGHNoCBCZoB8qWViDzLZJA3PoptP38lZjm8/uTGvTKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1SAlYhp0paKZ4VGIKby0nu/nWD1InjWF9RcOLJuOCQ=;
 b=AdJADNUHpg+r3u5nLipZ+Q12/tzGre+48qh2rFFXQchk1k51YzwExuC0CCShPCO9JYP3PdV2JrHMdWTm8FLYy00J6XbTYXD9mhSFgvdq+gierIMq4b+k8DbOfQnUG7IlDv9CV8+3HvAR35x4JA6FJK5N3/9wMobj2/lG5i/I+GA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CYYPR10MB7651.namprd10.prod.outlook.com (2603:10b6:930:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 7 Nov
 2023 21:58:06 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:58:06 +0000
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
Subject: [RFC PATCH 08/86] Revert "arm64: Support PREEMPT_DYNAMIC"
Date:   Tue,  7 Nov 2023 13:56:54 -0800
Message-Id: <20231107215742.363031-9-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0131.namprd03.prod.outlook.com
 (2603:10b6:303:8c::16) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CYYPR10MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 8616256d-8b7a-494b-72b7-08dbdfdc9f71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9xQr28nJWqMPiXOYXsv4xdi0FyHnh3yLlfSr1H1ByGFPcCzKSvIBYavKjs2Kb3XLVsFRqMtP1jLrUTqbSVURD8c4sN/9IkZ7Hl+iSIR+/NoEP7PwW/lCAACr7j3XOcZ9At/1oOPq3bcadMIjTs635FNcOS3VGGL2GNN09HENlaghtBr3sk4KG+6wV+YI96mTJxTED3I34D2Iza0ApJzWCaIgpBB4cQI3sCwT65uPZoYulrzMGDbR9HEyzVyYb5H/3MG4+1rNtc+2adh3XAqUPNeSzpkr5jN4rUV1K/G8T7h+g33blRE8VE3D7Nf4vd9BQF2SEJZD4tp7j63kJ5KTsN/ZG/Jtq0+3yp7K+u4o1hh3l01yxnewQZUqmWlIkW8rDHlU16F9wlS8Xgugf6cFtkd6BJFDjv9eG9M2CbmVlDYPCyURZ1uBQOsucTJTMxUTLJVZ6Qoy2iTFqKovZDG1XwyJe2+TTOJxzB+gxJ1FFRhRod3lVO9vGI0eFjZvJLvjjL4jC6gKf7/Nvsvcp0YVePMKWse9VntIqLHnxiBUsyG2OFKpbF28l/vf4E31Cejt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6916009)(41300700001)(66556008)(66946007)(83380400001)(7406005)(7416002)(66476007)(316002)(478600001)(8676002)(6486002)(2906002)(6666004)(5660300002)(4326008)(8936002)(6506007)(6512007)(26005)(1076003)(38100700002)(2616005)(107886003)(86362001)(103116003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AxKMmqd1Us5/3hk0JWx+JAHK1K75L71u+tIjikfBz4Tfide2IcN8/xAaAAjN?=
 =?us-ascii?Q?fwWk1N3efwseXmZhxhExU8qd4QiMavS2bTyiHeaAXkJpJPb6yuCI6zYGZ/CH?=
 =?us-ascii?Q?ewwx9qvNAV997zAf8SY9R44pNURucr4c4UJrSiMMsF32Hf3lg2V40tEc5Cqt?=
 =?us-ascii?Q?1MrSv4dvNKFVMCEu5i92R4hfuAqC1RE/SjFkQ9IvUvw2kL4//f52tRYaiZi4?=
 =?us-ascii?Q?uzE1ayGKx8BL83/mUO1e4IaZcqdzrGLYhID9O2OIfKnvYm7IrOnDB2gbJPvH?=
 =?us-ascii?Q?3bPb4opzA3o24ox4bh4nyqgNj8McWeBrjk324z/PXw2eEYGH7jacjDn0OxpW?=
 =?us-ascii?Q?0X/HM74W9Yz5oY3nX8IjyRLcWug8Ti6k+fQTL29FqzU59EpOGbJLKeSLvLpM?=
 =?us-ascii?Q?q4Ehvdc4EBbJ6DNCqzyVcQcDGxYp0oNF4C3YiVfd9Bmk5qMOEkrZPh7EuNJA?=
 =?us-ascii?Q?vqXi7OWTA1thUQnZ2s3aY/GSwkF3PvhjBMjpY4X2cGotzJviF0XAkJ8pGmTI?=
 =?us-ascii?Q?9JFdZQz+Ae+a9RVZe9A7xdLvMYuI0VcU6YwqdbdtpvKb00QOjk6wZY4JYH3v?=
 =?us-ascii?Q?nB/wH8TH8lZk5VhY/QMrZwuE8I4wDQkNFiOBz8LOpJAyweFvGZyy+Vkmpkv+?=
 =?us-ascii?Q?1r6UdpaLzXlXZmjrdPDjD5NjNYrOw3lhNDVT3aKuTZ5ZBBftYAa+5S8eIeKx?=
 =?us-ascii?Q?HJv51B8fbRN/nxckPXkk3ZsXXFGnXPn3jGAkQlZ2n87nh2gaDU9amgbVx3J6?=
 =?us-ascii?Q?Ulcp+/DprOtezT7ASIW4YtfFu8uYQuDjvcS9e8FyxU7IdIqW2xqAvoA8b05b?=
 =?us-ascii?Q?MmC3wVF0xGrUnSRunsKHgo/ELHNn/GRWeWUfSuwa4iFyejQNsx5IW5g+guoC?=
 =?us-ascii?Q?eyQe8YnG0InbZN5mx7OuoQ1/pbo0+x8Ok8STyfnRQu9iomcRWCVj76Vjjk5h?=
 =?us-ascii?Q?pRj0cXoDKlbNZOwzzAfskdVTDEOIz7ISEyPnhqqsYgxaGtMQQD4OEyUVQ29A?=
 =?us-ascii?Q?QdI8EQ3OueRGBwgtaFrBDjazlOlpie6+AVaX8693n8rAzFlTV6ObL1PCW5DG?=
 =?us-ascii?Q?vUrxFQMLJ5WMhNjKYhcyHNarNybzvnao3RJPDbl6AfnstL3Fq8H9PVA3NCou?=
 =?us-ascii?Q?utcJoh8gNASZ10Q7vqe7wy8J34pIbwKu+Jn4oDvQJMMrvV5vLm8FmyoAnzC/?=
 =?us-ascii?Q?cBkDYctm4WeguTNcVy+iPC44U0Nxn/AhQKU8CT/JOTQPoUY71OyA9nYGOrlK?=
 =?us-ascii?Q?IrXPa6IXuvJZK08bcuuK759NtvU6nLS0GdlOJS4dDbBLJ7t1y1FqkhnHdyCT?=
 =?us-ascii?Q?A8aHJjP6CJ9WI9/u4i5hsENiYd+KNH43/VlqvFu1HAJ021grROkLQenyd8GH?=
 =?us-ascii?Q?cnXdzzdrSsSFCf9Xt2iAgZgXQbbrgzCPR2reC4FAoQeOaH2mh97m1/vGiaZ7?=
 =?us-ascii?Q?iqLod7XWM2Sd+QiI0JTPtSxPr/xvjHBngN6IhGGQQ1SPtauKlsqvccocJCj3?=
 =?us-ascii?Q?vPZM0T7xKWRsPOA23zjz4UReqM8zcLLBZhxUP9xry885pm0YZ+1NKMpQROv0?=
 =?us-ascii?Q?P2Cu2sSJR3mmcFHK1/tZKf+EGHwDEbuDVB9z65E49zZ9AVR6KwHj9y7F89v1?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?6tzKaxzg/a//PnhE6v0ejab7Buqle3kWPcBuN4YbOmP8RVmxDewNkQAsW7r2?=
 =?us-ascii?Q?5C5QTCfkIvxY6rQEPI/EAOHB3k+i47rP8Tm/IYY9BXclu4J7JoKpKy3tm7je?=
 =?us-ascii?Q?1D+Fmrt9tjSb8OcAT07+cjkwTXoP33sJkEc+ajIFQGJYshxyyz+z7NIsXQVp?=
 =?us-ascii?Q?l8aPbBXJvD88SE+Qfhrr9Wp5BmUpC9ENEOipqQbLJGLoSLBsiNQ8ZOdLNpbf?=
 =?us-ascii?Q?1oS2rYPIlsCTqlZUa4TBuyRrCBMsm8TY6vJgcCl3OgAkI+4ECvilt3LlaTpB?=
 =?us-ascii?Q?mRVwwq27bGniIIt95XIcdE0905QmU6ZkuIuYYeEtqPKQsaGBOcceupwmTjK2?=
 =?us-ascii?Q?PGKzwVQo7ImINSasRqd7DR5+qDsZB7gLpyisuKTaFqMF3iBh+MHwS80KG10h?=
 =?us-ascii?Q?eeDAaJp0Y6Pr+HUXc/6PjStWQXoyotBLJWUEFDvxVrj4G5Mid/fHgG4MUpuG?=
 =?us-ascii?Q?AzOoDZqm2Wq1Ud1/pvO+d0z+rQNrrEvOfd1gUEiTN7uZ3CTtjnlqMqaWAMS4?=
 =?us-ascii?Q?35bsxoSZzltu6ugeozaPx9ET3Kx+9hSgQxwe80AbY8H2cH6haOtoxgAEvil3?=
 =?us-ascii?Q?dC61mKpig+uNad0a0doRCYOrwDDR2IggdvAlF1AvLTTtXhMzCvk5LY5wC7Jf?=
 =?us-ascii?Q?MVBTUdojZl6HrAcbm8JX9sLZYdUrZV3wEdhMQ1CsfxKgxJSCYE0u3KmzMCch?=
 =?us-ascii?Q?0AkUY3qCIBiGROtffGgPD+Xw/sBn8miHetxyRmz8adRovssFS3wh899lRNLE?=
 =?us-ascii?Q?47U5HjTyplw2krJs3Al2ZZ+D+N1FITd9OMc+wCMctOvkqFqchtPtjoMB2xxC?=
 =?us-ascii?Q?hWCAj+k0VnNaGPp6CSlK631shpisj4NlyLLSylXQyjE6cNLShyNr3JXH01SH?=
 =?us-ascii?Q?FCuLOAgJ42Clu5sVJTaly1q0qf6rFHxmCCBxf6bhQcWcAEDwhya15eYR/KAc?=
 =?us-ascii?Q?srg/hGnUqkY1JuURNhcBnu6BD/tektwa0riKQdFd598iYB49h1rhCkR152sT?=
 =?us-ascii?Q?B+Gn3j69NapHaemPalRik2dnCOAZ14q7UuZAxgMA4H1oNa8z/ewYyX4z+Xd+?=
 =?us-ascii?Q?CV4a0yqSEo/WrrDh1LwVFLQEeqQofXxGpC9zSOxbwsS7BhfAR4T5CGPOuT6T?=
 =?us-ascii?Q?hZY+3JW1kJo/4TTxs/iP/cFO4ycrQcEew+A8WaLe5JqXuly7hEFUadGi4vst?=
 =?us-ascii?Q?741Jd3viYKhRNkv3u5oSFJB4Ok3ZC/Qv4VALm6HUCMTV0+VEMBE617V6Oex1?=
 =?us-ascii?Q?Ywx9TxcaF3S5wVXsSCuE+E9RFIO3OpHqHv3qqsc9sKRVR6gBmWYenn1PadYg?=
 =?us-ascii?Q?ebabegJA39WKR/Z7tZ5CU4Me8zAzI+leiWpPhD7jHXUQs4c0PvwMBbS6C9QY?=
 =?us-ascii?Q?u3xOcgA/X5p0qfvZPshtBEUwRWVxNDzLNufOecIFa5RTZAICrquhF2M1G6WM?=
 =?us-ascii?Q?CfjOwFLqZwnzx8+DoVfLMO7Ad9IK2vq5CHM1bMyhnrOeH4XLNiW59HuT+7ww?=
 =?us-ascii?Q?TFwi+3VSvs1H3i5vnn8Qa78ydexRIBMx/tgEbk9uMcFP9GxsK0vTPirkSw?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8616256d-8b7a-494b-72b7-08dbdfdc9f71
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:58:06.6650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wfnm/tw3JZpFQwfil+YMw2Ww8lTKbLdbgnzjVuqGe328pZdF9eQyHyfW1l4F+vX7d0XjFmuBtdw9z702GhbVuva0MozVppS8ORHwCGkbTfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7651
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-GUID: SrFnkSXOXV5UpO6UZimtmdt5rdMnnxQq
X-Proofpoint-ORIG-GUID: SrFnkSXOXV5UpO6UZimtmdt5rdMnnxQq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 1b2d3451ee50a0968cb9933f726e50b368ba5073.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/Kconfig               |  1 -
 arch/arm64/include/asm/preempt.h | 19 ++-----------------
 arch/arm64/kernel/entry-common.c | 10 +---------
 3 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 78f20e632712..856d7be2ee45 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -221,7 +221,6 @@ config ARM64
 	select HAVE_PERF_EVENTS_NMI if ARM64_PSEUDO_NMI
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-	select HAVE_PREEMPT_DYNAMIC_KEY
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_FUNCTION_ARG_ACCESS_API
diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index 0159b625cc7f..e83f0982b99c 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -2,7 +2,6 @@
 #ifndef __ASM_PREEMPT_H
 #define __ASM_PREEMPT_H
 
-#include <linux/jump_label.h>
 #include <linux/thread_info.h>
 
 #define PREEMPT_NEED_RESCHED	BIT(32)
@@ -81,24 +80,10 @@ static inline bool should_resched(int preempt_offset)
 }
 
 #ifdef CONFIG_PREEMPTION
-
 void preempt_schedule(void);
+#define __preempt_schedule() preempt_schedule()
 void preempt_schedule_notrace(void);
-
-#ifdef CONFIG_PREEMPT_DYNAMIC
-
-DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
-void dynamic_preempt_schedule(void);
-#define __preempt_schedule()		dynamic_preempt_schedule()
-void dynamic_preempt_schedule_notrace(void);
-#define __preempt_schedule_notrace()	dynamic_preempt_schedule_notrace()
-
-#else /* CONFIG_PREEMPT_DYNAMIC */
-
-#define __preempt_schedule()		preempt_schedule()
-#define __preempt_schedule_notrace()	preempt_schedule_notrace()
-
-#endif /* CONFIG_PREEMPT_DYNAMIC */
+#define __preempt_schedule_notrace() preempt_schedule_notrace()
 #endif /* CONFIG_PREEMPTION */
 
 #endif /* __ASM_PREEMPT_H */
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 0fc94207e69a..5d9c9951562b 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -225,17 +225,9 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs)
 		lockdep_hardirqs_on(CALLER_ADDR0);
 }
 
-#ifdef CONFIG_PREEMPT_DYNAMIC
-DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
-#define need_irq_preemption() \
-	(static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
-#else
-#define need_irq_preemption()	(IS_ENABLED(CONFIG_PREEMPTION))
-#endif
-
 static void __sched arm64_preempt_schedule_irq(void)
 {
-	if (!need_irq_preemption())
+	if (!IS_ENABLED(CONFIG_PREEMPTION))
 		return;
 
 	/*
-- 
2.31.1


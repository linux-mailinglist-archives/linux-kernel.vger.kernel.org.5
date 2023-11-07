Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46497E4B64
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344216AbjKGWDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjKGWC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:02:56 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3433242
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:00:25 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJlqS020689;
        Tue, 7 Nov 2023 21:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=FD4bmpXlchgZ8GVWezjRtlUp7rKn2l4THNzmYwTAxWQ=;
 b=V6/IrpSAzrhXyUum08fIXiyanIw1FyZerR/ahHqoKYIKai+Qkc2+8UYWotzsNi5+AFsk
 8HzW68eW83V4mFq8BxtDEmIj7pfHfbm7RP0e70jNKJu8LD1C5xv6//HicgDiXtUp1W9q
 XQnHfAX5IPy122kFqNfv8FTxY1389W+ttkQDS2Kk8FIkbr7+ROckpAc554yteQVygzHm
 3bHPt6OPuD6CwY4gHXnPVxO5DajFBrZBgPW7OgFOMphAioP2kRcW80YKMz0qzcWk4A51
 9Rhblp3v0xOXGQ0Dx9GS2azzId+bLyhTmQv1kYOf/TRMcLCZNF6YQrAwq51UTJd2I4Zo Jw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2202s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJBPF031966;
        Tue, 7 Nov 2023 21:59:36 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w221guw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEbRs1XZpRXa9hdAD3HsIcG7Xy+WPrtvDJCPgX/RIm0otkL4n6nVWPJG73CVXIjOKjiKfDrztujRVSLxDEpyqvvADzIqLKcuo7R3ae2vvFlGqKUpkL5WwAmoJU8fFEHMp+n0S5n5s5Kb2gkPDes6yKXd5ZlllqlYARQPztN4qNW0d3DOd7uvyCtgFDWyynAB4HAWusmxkIyC3f3XVb1rWf5R9t5pd4JOmU2gvVOjFvkCtQn84SsrKcgezSAk5VnvCBZV3/pcsk06HufKbq1cm4Lq7lfWKxaF+pZ4BmzxEyifP2tEse3w2RYpvuDb//nYmUKHn3431U0qQQUMZIhm4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FD4bmpXlchgZ8GVWezjRtlUp7rKn2l4THNzmYwTAxWQ=;
 b=KHm7enNAjMnbDv8Fm7fvOuJSYPz62K2f1T1nF65urJitrgxJ9LaxEXGDkc/Ie5HG2Pt5q/9mc0/cgZV7SsKKd3KLLT6wMx7xE7QRNagocAEclS5lpzaCzL95DvjZetOi2TriW8B95ZHoeHdE0z/HIOqXCs+7qJ9vGUVG5Nt4mcneIaZbIT0GsJcwEhGpIO1nBYLL4GwDihhB5+xzaGR5pBBE822hWvxjwEF0bi0We9nCsMqnrOmJStSMKQs8Je32GUbCZMRX1VICXlzelpY9/dMhdxXQlpOcZWI1C4115/gBpjhe88dt8BBN0zVVN+IO4imXAyslFvkCgjUUEXTE7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FD4bmpXlchgZ8GVWezjRtlUp7rKn2l4THNzmYwTAxWQ=;
 b=I/Cdk8Vu3nBxFdDIEEJHxT87ItDLUtAdxNphRhFhGPjlugrhp/QpSl4Qc8puvS1Q55DA48/6FrV7rQ3iLkAkmuZfKTYki6b7oSPUpiO57Ije0lZHOk2rPHZ7lM9aAkf9DsL7GvVdpOlIpTbAXqLPFFZUf2ySnW5auUOrDh32www=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY5PR10MB6141.namprd10.prod.outlook.com (2603:10b6:930:37::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 21:59:34 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:59:34 +0000
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
Subject: [RFC PATCH 36/86] entry: irqentry_exit only preempts TIF_NEED_RESCHED
Date:   Tue,  7 Nov 2023 13:57:22 -0800
Message-Id: <20231107215742.363031-37-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0038.namprd04.prod.outlook.com
 (2603:10b6:303:6a::13) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY5PR10MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 37adc040-d37f-4a16-afd4-08dbdfdcd3d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y+zzraS5kvBUcoDe1zI2QcyZt9MK7el5+tyGleG3Lx0jVLHJEIw9wcWDhD+xAa6VlzOlXDO/mh1x7gUsA5Y6VEX2YcpEsqtMlZewmQdqApyodeFm0q39nnMclW/WCMpQTatW7jWXBl5hB0Nq7tIrp0A7wCQZXWeLTWAJtRGwCnBUWRv+Qxjrs+YQdvReweE3/4YFGrC5uLPNTOynGjVOakeGQkCfUr85EZAqHw2URZLSpEmjJfabd32wcZHm/mUxw0OMmmI77Slkro3KBYqZnUN96QAy8NyT9wbkQxnH93C4TdtQSswXx8S7R59TkDpgpMTGuV72u8tKfgXnH83Xi8Y9/Tkuobo8Pbxa1SpC2Ecgoul/CHkq90ezYP6g9exOSlSnyfg/cgkiPUDv3y35tGoQ7lPByNp+giWgKhvVg35bwMElOPIbwHcCNNGrPPtA0MX2cT/l6kqZ+HPUMUqEZLs1jUmJfL3CWNX9y1YYI47BVoUKWcc2mtsWVghITl6fC3II49SbMPywH2RZbTfb1aU3nl1yNmJvSJIIj0kpSk1E123l8ZEESoeqjKOT91Bk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6506007)(86362001)(103116003)(8676002)(478600001)(8936002)(6486002)(4326008)(6666004)(38100700002)(1076003)(5660300002)(36756003)(6512007)(66476007)(6916009)(66946007)(66556008)(316002)(2616005)(7416002)(107886003)(7406005)(2906002)(26005)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7fnT3QBlCWyadqI6kpgkhw9v6iGEyO7unL9iGSeTArZPRktyxjGgvlwUTwAy?=
 =?us-ascii?Q?BJAO90wiAvijnqU2m8UCLyH+ytrtfljo2b95xXLcIEQa1OQb7s7Nt0Sf0h7p?=
 =?us-ascii?Q?29D7NGD/9wCko3Jn5G2Txpty8SUTTveZZcLxXxR9WsfcPEzqShw1ZuHS46cF?=
 =?us-ascii?Q?CEUrHLQN1DXAUT7hIObqpQZhJe/KDz+gjaLqslqfEF6znfumBBuXk2Xvk7Xg?=
 =?us-ascii?Q?kyjpaeqVlJamobLPHg8UarMfMMeXpyO15n6olewwpkliU8MBuhsxI7TdPcqs?=
 =?us-ascii?Q?l/4JZyVVCte0fXBGhTy76fOHvjAIgCAQ/A1bWSypGvBSr5SVA4SdNcr3v5Mq?=
 =?us-ascii?Q?vU0ZaneIg/4TGtOCgCjiR0F49Et564NB6CvxZZH8pSRyQSnbRhOYHLFbRxuK?=
 =?us-ascii?Q?MsWrl4Bg04rudh2llKH6+kSh3zsV71kVBX/DyvWO2NJSxJ/GfoQYmkXaO3n3?=
 =?us-ascii?Q?qNqhu3gqD6oQxF7a4n1dHdNE1ed/b39tsYM/QaWEj+2c0B8Oi7CCK3SBQnJv?=
 =?us-ascii?Q?FdP2yrDnS+WzUAmDEM/mFaW36peZ9iUo/PjvydgHD2e07vQHvWPdgfP+ETwt?=
 =?us-ascii?Q?R7N7XQ54HekIshoumxFPZ6zrB/BTCWuOdiq9jjEKaImwCimwd2fB4UOkpdfw?=
 =?us-ascii?Q?e88Zmyb/ZZ6eBJ34QyoH4AiHvEI0AMtTVafXS7VcFZzdasQNTwfo2zEUd4bm?=
 =?us-ascii?Q?wuI+0kmUVhq5lgcr6KqaXgnPbZ1c9Yl2VESDd1BmTPY56O7k0uvInDFvIPSK?=
 =?us-ascii?Q?lU24oC45tInT2aPr+jkarF/EnvP2kMRVxOxUx9LE9HGDNapJ10eFU5bHneWt?=
 =?us-ascii?Q?jPim8ri5uRjHbGXBNK/IWPtmkMIQfyiZZH6Lb24AqNfd+CFHAdXr3GhS7EzC?=
 =?us-ascii?Q?6C4rlKMZkY8bA/zOMv7xw6KA/ADk/A1jzsE0VYGF7/22ZqIdSmJ4vF+a2XSP?=
 =?us-ascii?Q?69tmMN9aHUWTR1ZHlVTf4kPCWW65VU7/ypm+gjOtAOdyusd42GDIdJQDbUbq?=
 =?us-ascii?Q?xlXPKywg/TEqhGKYkftFjKcLxgkyINi3fVpjCx540UrnJ+3Q816b0InT5bLf?=
 =?us-ascii?Q?5fMUlJuiolej7Gl5NuwnvoQgnQ4fNZzzjt2563MwAXa+Rap5cv9YJmNXxLuC?=
 =?us-ascii?Q?JsbJhwkX4xvdf6kiFIm/KIwAnpkCmxVG3PBoFFz51jY5O/lcNCTTmQ3gYsP4?=
 =?us-ascii?Q?ZAIX+JD1cEVjxQe5UpGYdMMxTe+W/eY0Tmvk9IeJ8LqxsxMI9Pgf9e/91Bn5?=
 =?us-ascii?Q?57l9ri9N0U1mGdpqlQc5v+p3O6bd3tS3Kw5yC5Dm9kbq6AO3OrTC9lmz3yO7?=
 =?us-ascii?Q?Lqxl2u3KkV70+DthOLMwOHaitjrBFw0TNRZLXTEiQBDLJxau14EQI6J1k3tk?=
 =?us-ascii?Q?A7lX6wm17wr9r4b3JqBNKMKkKxLppbqsBEv64F3tk/DW6l9yOxXEHsQ5DyVO?=
 =?us-ascii?Q?TvyyndeEukXhFCbm7PTa31NF2TTqOqsL5xmX+Oz7xRrvEN56yW31khIp6ptK?=
 =?us-ascii?Q?awGYWoXO2Dc66y92gpyzSR5thUR3o4N0iII9dWDN77oG0PtG4Wf4/NHRJLGI?=
 =?us-ascii?Q?zDpm2N5Cux51O9SuUkbX3mWascGDkN0qWiXsCxiK9lgy88V9Znt7EQjasAbR?=
 =?us-ascii?Q?Hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?6yflTEpLLBoZrKsQJRoBao9iiKd04r2GR9ZIAkgWO3uKNebSN3YTfh7rOUnH?=
 =?us-ascii?Q?w3wrR+BJ1h42JhGgX6Ngdn+AMC3ltfJ6Qv6y9R5u+G3LxN5kiLcncvqVTl9I?=
 =?us-ascii?Q?OE/jFG1nNpebnNR9EKd4zPUpm/YlsCb9dzaPn/ZvGVX7MEYzGjucUJ7j7k8x?=
 =?us-ascii?Q?m7ON+UGM1B5mnhK1D3ESHo5MkFukWWKU8yB06T8jsgdJ2dLTkT3OyxTZqiE9?=
 =?us-ascii?Q?xq2LLrIktc9tQhJcBlCqyfEra74Yw83j6sx4lnRprTOcpY2gs6Z5yW1O0s8D?=
 =?us-ascii?Q?/IB9eziW8TTcibkfVXC2T7oqI35vpi7JEkOM3Y8CeCbL04e9rS8xbb2Td7rN?=
 =?us-ascii?Q?w23hxOKBVCX390u3E2x6rGAr7ZQ16CRrqU9c8T1Cc8F2LKdqxO9NhzZP2hte?=
 =?us-ascii?Q?2wOeY3AGbtPUjkxscGLQtCIo4CJukaGoCPwwZ51RRKJDQRi1WkuGWE0MSgSr?=
 =?us-ascii?Q?StDcpcfJtEXa99jiicaSA2ExaVgIBAePiC/FdLsibFDVs2O2wQ0dqltONDU7?=
 =?us-ascii?Q?afiIjCeB555cvsZKXZMjRd7b4y0drDHmN2pcwXin60BVwrrbPqnf8UGdc+T8?=
 =?us-ascii?Q?rqgXyN/Wfg826bw9NAEFwY3xWdVCTZ1itIADmIo+zRZwsKbhJNKyltLE5m3Z?=
 =?us-ascii?Q?Ob/8RQBNeRGUlgL8qG5FMeIH+PIQXSzspQBnNy+w+OOM95XubASWtXA0+G7/?=
 =?us-ascii?Q?6A4QCSaAA/RFcjexI4Gk1IVAL86FZBFg4+4MpKSxLa/mtUI1LQ49WwWo4iFl?=
 =?us-ascii?Q?g6kJ8dTtBrIQJA6EE5HFn3fOLjnj6NVB94PGPU9qZkC2w+87Anv8emsa/rSg?=
 =?us-ascii?Q?fju4/Cku/VvdiHQvEdEiCPRs+qb5o7IGjaxG4cxAE0BKH8rjX+suQHOq8+gn?=
 =?us-ascii?Q?uxLtB6+lJuUIzm5KLp86uLetosjkTG/txPY+f4g/RqOBDSBhs2fB5jqoQz9o?=
 =?us-ascii?Q?w5FrUfvK48JsNOgAta5+6sO7TineLvzWs4TCwUijZfvKXlkFqoZStpVeALZL?=
 =?us-ascii?Q?GgkNkyBRl3xC/TH7yCXGxe1ey/oQO446gjqRr5M7KQwMff0Xi5AiWdFsA7fu?=
 =?us-ascii?Q?DRGxuEeRi6RxUN09mVt9eC7UKaqyNUR+ABtWYqrBY7V/CHoM1zQNUEL3Jbc8?=
 =?us-ascii?Q?6D8N1Ow5NzvN+AN6diDqDOdsKW3XAPJVyfHKf7j6vJJgDHPL5uQms8/djPch?=
 =?us-ascii?Q?y088QXgOiAv5fxw1GjnroEQ8E6/AnEymvPNpi4c0tT0G6dhD2Qc0OYHEe01O?=
 =?us-ascii?Q?tjinbgBVrMkGeoIeEbdtAT0JSzayIYmYmg2mgRQuT7xcHmYj4dtoAQzAfjw0?=
 =?us-ascii?Q?bmfSG1aNOIGTOMHZsVT2+qRv8UedmsYGOdhqLsavICbXVMM5EFYhXYNr35Gi?=
 =?us-ascii?Q?YfV5+iFEMDykyLaOViKlxTUssp4sBFXcF49+z5wF+HSSCSzJ4Hy6QRABuiLM?=
 =?us-ascii?Q?W/CGoNmIZJCCvbmR1FL2kE88Lnx8I7QG9JuxjMTJDRWodHKclu4oE4Q4jt12?=
 =?us-ascii?Q?eOfFpwzVHWDXxywXO/p7rDJ7irpbSgerAhlsfET5dSvJ5wFzmpmKKK2oKw?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37adc040-d37f-4a16-afd4-08dbdfdcd3d0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:59:34.3817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yi6bAqqBzAGj1f1RiO/WyiKNSuZcbQrgt80+8oU7iCEOLthVjskt4j5p9aN2Md/0PpM9Ldcj59KCSb/0PDbW7lfdK37qL0/USlnoqIFK/h0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 mlxlogscore=930 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-GUID: jr99TgQ2zl7BNlRuGs-_oLSdR9PF1tKu
X-Proofpoint-ORIG-GUID: jr99TgQ2zl7BNlRuGs-_oLSdR9PF1tKu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scheduling policy for RESCHED_lazy (TIF_NEED_RESCHED_LAZY) is
to let anything running in the kernel run to completion.
Accordingly, while deciding whether to call preempt_schedule_irq()
narrow the check to tif_need_resched(RESCHED_eager).

Also add a comment about why we need to check at all, given that we
have aleady checked the preempt_count().

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/entry/common.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 0d055c39690b..6433e6c77185 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -384,7 +384,15 @@ void irqentry_exit_cond_resched(void)
 		rcu_irq_exit_check_preempt();
 		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
 			WARN_ON_ONCE(!on_thread_stack());
-		if (need_resched())
+
+		/*
+		 * If the scheduler really wants us to preempt while returning
+		 * to kernel, it would set TIF_NEED_RESCHED.
+		 * On some archs the flag gets folded in preempt_count, and
+		 * thus would be covered in the conditional above, but not all
+		 * archs do that, so check explicitly.
+		 */
+		if (tif_need_resched(RESCHED_eager))
 			preempt_schedule_irq();
 	}
 }
-- 
2.31.1


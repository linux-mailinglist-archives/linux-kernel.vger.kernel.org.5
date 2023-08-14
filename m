Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B281D77C2B8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjHNVq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjHNVqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:46:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1ABC10F0;
        Mon, 14 Aug 2023 14:46:06 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EJOuHl022060;
        Mon, 14 Aug 2023 21:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=WoOFj9vCUMDBpG9aPvyL1VSqc1Fa6PJne4GrUiiWIBo=;
 b=X1kN33qtfz/Z3edLFWzGKUyNZtD52UkLdyFvNlUQwEWp5xzzX/8G6JujDDLNYlzkrrX8
 Qa+hHond9DvitwCiak3GGpyVRSXUOt56wOtLOp6xLK7lP8bMcRBeCEzmf2stHJCa7PPp
 0wAakjrxxtiTFwm1K+XRMuQwPXpPfxULwK9WkO0RgfO7bdRhlVTYm7hQuaTdRAqyNkE2
 LLqSGO7kFK0j3CI9/ACPqr+xut1RH2nXxzo3eTWTFx1loKnsWa3B0xH3SiPOxC7goE0d
 U0igkzXYVzD1GARvVgTDkZddjJAVmqeJH0occZnCv7pmIV/a6GIwSOze+gZO7MmfXIeS 7w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se30sunq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 21:44:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EL22qT006626;
        Mon, 14 Aug 2023 21:44:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey2ce0vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 21:44:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZt/ASQK1XnPNaEJnmT6C6GY6Y7QXUisDhTPxzBMrnia3G6nX3KJQT4yDJu0nNYEI108dI4Cux/+zNJD/NXyasUfHNte3G7vP9FNfz0hUQbKA+dcQGNIMuRXyUvsc8YmruzxgmwzmvbH2BCGQUWTs7rpdIoI4xSgy2SPZB66w08S5jpQdpzX/W5mQVIB3Qxn0TfRAQElwvp3DF/GR75S62f+SgM7Bpu9pnG34f5MWXZDBvkOHGPcdvNssC2wTu93v45cVYYx00ZvFHDFZ6nElSogNEw5h/IkMDN+QsiaRsgMWR8ZL7l/jJ8w0xo7uvgSR1JB2SFDWmniA6BPvnLyIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoOFj9vCUMDBpG9aPvyL1VSqc1Fa6PJne4GrUiiWIBo=;
 b=e0lJD9Goc+Io82VbycD7ftWOsb5UHaXwiUmxviUi4Q0q9vKVEHPNS9LKZo4g9T7D2Nfst0BGzGxWWBQQErv1+vitM3gn78VJy7oVQ5tGQ5J+Eef8QzNFPjm2kIrh/ZmQjotw/rpWukwzgUVpojVeUjvPkDfnXqm5gLbOIocjmtmo8F1qYHRN107hfOKHo/e+DyefA7f8pOAU2q4CfPhqPeM6Z0OC9tT8OkpuU/PJbQghFogW9rta/v4bXKXzRc6qRKuXfk/cnSGKgipDK7Pk/zBMugNVMs/VvKb9x0nC9jBJN5mEWAoa1aBO+bGlxvw7j49B/kEoCubIYD6SgppW+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoOFj9vCUMDBpG9aPvyL1VSqc1Fa6PJne4GrUiiWIBo=;
 b=yUHbCl89cfCq/Lf30dF7QiOQTsBoTsKzIa0WY9rsIAHF3PovgUbYp7pyp0g5qVuA97Zt1+DJJJD3HgvaVWCXmAaUnh7kBUltHuQAqoQ6yuqcV3j8b9qwkeFahsBxH3Ce/51l7YZ14bD6W/wNhnJSL3SmW4uWOV3yf/K0E9lDsxg=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CH0PR10MB5354.namprd10.prod.outlook.com (2603:10b6:610:df::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 21:44:53 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57%4]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 21:44:53 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v28 0/8] crash: Kernel handling of CPU and memory hot un/plug
Date:   Mon, 14 Aug 2023 17:44:38 -0400
Message-Id: <20230814214446.6659-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0149.namprd11.prod.outlook.com
 (2603:10b6:806:131::34) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CH0PR10MB5354:EE_
X-MS-Office365-Filtering-Correlation-Id: 2667348d-0beb-416f-0fb2-08db9d0fb13d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QGDTbqqtboyaI23WO3zXhJjULsVfra4/8D6MZkwpqvuVoVkX6ZTOHA919R+fXtEunnmlqEjqfGM+/A0u/a46BF9IqrhQxFfkkQTyqsjQHCZMkVCsxqe4/Mpk9tE0WSzrnfPeHN66EYXAS3fFSbcC04l8WMcwzPAVhWNbd6VB8ZFaoEftv3kJjHsmQixuDnGfXYBTmmqwMJxy7VoDdNOrpCkLP2dzfEXaTtBpSYRLRUPZteIqgdCFpbvUkquRfU2K6MN6JheXLOX04Od05fvOUK+KVojX3aHv0zE+RGmpvwTMVHu8B7alZ+hWzao3ArEdQdSC5COPruV9sO1cpGsMXR3PVP5uzCXQ4y/JOL0UWAcyYOqMN1Ba4tpCMdwVJ9jd/EMQXBz5eD6rdead8JkqCpmoshNGkfWI+j26kcZtphhb9VfkM8QqpqZaMPbeCfbznFbuED9bRg8Tn5Y9v+L5YeIYiyDfd8CeNilGQCp9wsy5d6hdZkUhYjRGvQrS7/Cr/ToGdWwR8Us6ExN3DSQN87WIwRcd4WUMu0/FntroBzJfd/z2BvsQFKhbAkdXnX5+7H9P8WsdY/oCxvKqHRLTrOWVpOCkZ5pIks46b4KyQvsjvOLOP+Jsfg2VygmdzIrK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(376002)(366004)(39860400002)(1800799006)(186006)(451199021)(107886003)(6506007)(26005)(1076003)(8936002)(41300700001)(66476007)(66556008)(66946007)(316002)(8676002)(6512007)(966005)(2616005)(83380400001)(6486002)(66899021)(478600001)(38100700002)(30864003)(36756003)(6666004)(86362001)(4326008)(921005)(5660300002)(2906002)(7416002)(7406005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qcVl8AyFz8UZ4Sx0HrY0njYRwJA7HflC29+fpdKRMZcOB5wz6GCTrHzYevOx?=
 =?us-ascii?Q?OEA34DJqg58RLqYmGNW3z/AixLp3sqQjbc2UOmRaeJuUJO2uaSCcWUBFoXxT?=
 =?us-ascii?Q?Fc0JPInlRI21LuBgxmbrp/sBbwG+bGOcHKjhVcJWdOUQ54iBNeDCK2XXC4H1?=
 =?us-ascii?Q?8V7A0lq2nSee/OQ3M/tEGXAKUaOTMtfVfsBBvjZjUaaOWAAabmdCYy8HdfOI?=
 =?us-ascii?Q?odn9K63jSK21aNORnqoo9m7clmCQ7eG02WK9LRO0GMfPZiXunqXOTjsmUV0Z?=
 =?us-ascii?Q?uAWLH3OJjfIPhJ/URKX0zjvC5v1lrTEOch++JkAa+8u8aZGkipapD5FYd1aG?=
 =?us-ascii?Q?iUbM/2HRB4M6shtTaNsC/iIU2n56LFCDKn16Kdx7jZWUKNSZ2hpSo075InKV?=
 =?us-ascii?Q?1b+XWgG0UDpT9jHa0DCgzU6LT2xSLNzwuRNtj6PlvGQkpU8XMXTCwkwRXWSP?=
 =?us-ascii?Q?c4NvotGzT24mbuX9l1M4qnk+ILKhUH4ro73meuwZ+wZ5fFk0ZQ4FiOJf9ms6?=
 =?us-ascii?Q?jiW0eMXQpe5rmChRj4teSJaWvimzKRgnhe6/xsS9C3qgCXsHrU5kdRs3JooX?=
 =?us-ascii?Q?Q/SLOWKhJnIzfgYEf/qlQeqIm4AJMLehGfuhZ1yQxMSUNOvMcLi7AeIwToDZ?=
 =?us-ascii?Q?OVLBrz6nu+17MotnYDisVBZMtXhXg9TVa0zExt2ANvLAyZnlnxeJstZpI1dd?=
 =?us-ascii?Q?mUxgG9HR7W0snKq4m3889LQEoN6BF6yh7O9+OrFrxCD5wdwfJNWn7A/ne0AG?=
 =?us-ascii?Q?qLyEK8tNXOXIgNY62w6EkMOnoP5Ggh8zljofPqkmJiqvpRv55/Hekm3/S91Q?=
 =?us-ascii?Q?iBJfZ6B3JtGNICBVS9BChEKpUPCa8+hJrpr6zTxH1wxPCQJllN6ydTAUDnjb?=
 =?us-ascii?Q?wk+fPWxC6HWoE4cIF0nUjjJGtdxRL3Ly9rFL/7ZpwMCCwm7RMmC0ovPMy089?=
 =?us-ascii?Q?hibEw+r2q/r3Qyy6ixesLZ+/MMVPoPxZJhTF8ZkgNqdYOyh6LlZ7c+UyJrv/?=
 =?us-ascii?Q?hXlAflIoXKHjuPynAf6VdNhTL4VhStnTDKkdZdL3NE7Yr95ntGdhKH/SEhXD?=
 =?us-ascii?Q?mp2cMECX2dz8oh8s1UxsL7ku/TmF9PXHoqQx0r5jLJplvRVJ9pPQwlEZjC6e?=
 =?us-ascii?Q?3kLsuXs+4wITNXC6BLvcXXlmWngHI8igE/zfR+C9BX6BlCWEMvR2VtBaOM2n?=
 =?us-ascii?Q?mqfCScmxVZ7a84RJlr3OJpGXPamy+xJzmnDaYBDot+hq0YxJzYifCSWgOlqP?=
 =?us-ascii?Q?7YBZBrQ4G5mONqXt3ub+N48HSsVi0wwUCeMS+MSmmRN/tqrbWt66dhDOaqCt?=
 =?us-ascii?Q?B9XH5ay6MjpmZDK2lMtxKBcpZTMMXpsllTrP4d5cIEXCO04pURL1bfk6R5BY?=
 =?us-ascii?Q?lpxG4M4gzRo+u8wPsNsXY2QmI8rTxCPPaCqqFxnmUukXh96u7HgNESKLfRpc?=
 =?us-ascii?Q?F2ljl8ABPGrqM/JYPxDlXY1F7rsCQCrifa1Nn7RAci3tUZaY6qPMePmCOYkg?=
 =?us-ascii?Q?Xna+cr4TA8e9eKFdbKn/XsnBbcWuny41bFGlwsFUtLX/fAKaQ5z2R5bNowat?=
 =?us-ascii?Q?hP457hUPjDBXXEoSk7dYIlxlmEwBS6qn13AL0E1JYPPYWbM2urW6FswWvuLY?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Vb/Wc64aKhalhlbdY5NJcODjlDPQk5g8kRQUXbB3agusxdAvmZjnrTNm2UZm?=
 =?us-ascii?Q?otGfI6zfwRKPfIbzv9Sd9n0plzfa0QNVWm2w2NCVULYZ5cwvuoK0tFUhPUoy?=
 =?us-ascii?Q?q4CBbWHgW0SfQY30xZiIuC/7kK9xwl1JjPrtME42kpegL0h630M+OfKo6HcU?=
 =?us-ascii?Q?5Kb/9TfAu2kdO8Qa0oIwVFkVmpn9YWn/ZR/oORo/JbHU0YS/+TJM/3+6FstL?=
 =?us-ascii?Q?U7vi3QWrbUVQYI0Ue2F61yd1olILBFjBsn3tXv116ngxaUU4tpMiHf2if5No?=
 =?us-ascii?Q?0yNFy2tuQUQi4gas/0VmKSdtgrcNIK/syeOHgSMxJpKnuc+imdJiaZD1inl2?=
 =?us-ascii?Q?BxOvgCS+ebuyZ/KVol+U23cmHIiU2A7g6RTK3E2kuseGJeFJCGWklqfPh598?=
 =?us-ascii?Q?U/RJiY50hcIkX7xxUSpHop3biq9B9xhP2g1x+e2Mwm9mYxXsCArENSUAal/I?=
 =?us-ascii?Q?azxVM44x5H9DwLMvjrrQGC3RIYVbkfxIO7Q0/sy54jRmGYMMgl2GqW5/V5Cc?=
 =?us-ascii?Q?mjIp6GC+diU8HomzZ/hUeNJSOzUnRKT1u4vhpQPK8YZgZC0U4JUSCwvJj608?=
 =?us-ascii?Q?awEQ1nHy1opvqQuaauVlQOnqonbhfcoEdHSTOBgCgojEE2JrwiieCluVLlAI?=
 =?us-ascii?Q?0mi/aBrKnaooWr0LwDUMf3olEFGf0lre5prb4q5jO2hd4ir8uLIBKuoKvbK4?=
 =?us-ascii?Q?Dr4bGK9f1RfsSqF+KXFSWJrNB+X4GNEwHs2e4pTEnqVjJgnNn1kgP3d2GxWI?=
 =?us-ascii?Q?td8U9uWtg9B6KVAsjUb977EmLaTCbsoKaUMoYHn4vnZIiNjIMclp5ZrhhCdB?=
 =?us-ascii?Q?2FfK3E4c/GOIPua2L3iR9zC7a5L37++EeVt7Od+ZEeQ7ETBCFinr6jdHebld?=
 =?us-ascii?Q?ZpOkJO+qMNbvBW4/urDVoXpu5C6eCeP1GmxVR9Qv+ZLX7tQYZiwDIAQavw3n?=
 =?us-ascii?Q?qnTw0tjq29lKzF+KrRh5cli+XW2fW6fKz2DRbrONMSFCqvxqK4dB9X/dP4Dz?=
 =?us-ascii?Q?y905qy/ILllPehFKhLpiIgEfxs0Lor4rCOv/057rexZpNBF8uaMfVTXDPTI9?=
 =?us-ascii?Q?c1vKvmSohlRWQNSFlkmcuhJmRpE7tLQTw9nHHsfo2kb6/uq/M6J9jei0sfJj?=
 =?us-ascii?Q?NT4m5FUnl3Y9ZYx24ozptMmR179JQPB2i15O/qDVzQv7ZnJiS6Y87jVmzHdX?=
 =?us-ascii?Q?i8naJv0hhJkqwbE0dp6tm4BDEDdBKfgMn0g3pypGcT2CJpQ6Ud/YrICBtyGG?=
 =?us-ascii?Q?6VapQS6e8BI41Pb+D5iR9v6zGN+WjeR8I65SudGV/HJCqPZLl2rEMP7SMB1M?=
 =?us-ascii?Q?zgQVKVAFzTTIerguDoIC4Rzkd9oYJPVKqKDWj+XRml8GgfXBq1GMIXPmQQVr?=
 =?us-ascii?Q?0Tg5JmwTRxXxGEF8YClHgnbg2S9+4LSEIOqT+TPLjchPbkiISgf9FTpVVHSI?=
 =?us-ascii?Q?ki4jwUNvfOw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2667348d-0beb-416f-0fb2-08db9d0fb13d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 21:44:52.9326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: up6g5Y2EfKzhldD6BvmF0pt5ssm9lZQ4CS+9+Bu+XS98jdzNDvWGHKsa5au0cZ5uqt0L2Y+KseIPB2FBjroR4+zlc4UPuqFKUuN86Ee/UJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5354
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_18,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140200
X-Proofpoint-GUID: s5XUEjsvh-ERo4FmzGme5cJKYVK-Q5VL
X-Proofpoint-ORIG-GUID: s5XUEjsvh-ERo4FmzGme5cJKYVK-Q5VL
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is dependent upon "refactor Kconfig to consolidate
KEXEC and CRASH options".
 https://lore.kernel.org/lkml/20230712161545.87870-1-eric.devolder@oracle.com/

Once the kdump service is loaded, if changes to CPUs or memory occur,
either by hot un/plug or off/onlining, the crash elfcorehdr must also
be updated.

The elfcorehdr describes to kdump the CPUs and memory in the system,
and any inaccuracies can result in a vmcore with missing CPU context
or memory regions.

The current solution utilizes udev to initiate an unload-then-reload
of the kdump image (eg. kernel, initrd, boot_params, purgatory and
elfcorehdr) by the userspace kexec utility. In the original post I
outlined the significant performance problems related to offloading
this activity to userspace.

This patchset introduces a generic crash handler that registers with
the CPU and memory notifiers. Upon CPU or memory changes, from either
hot un/plug or off/onlining, this generic handler is invoked and
performs important housekeeping, for example obtaining the appropriate
lock, and then invokes an architecture specific handler to do the
appropriate elfcorehdr update.

Note the description in patch 'crash: change crash_prepare_elf64_headers()
to for_each_possible_cpu()' and 'x86/crash: optimize CPU changes' that
enables further optimizations related to CPU plug/unplug/online/offline
performance of elfcorehdr updates.

In the case of x86_64, the arch specific handler generates a new
elfcorehdr, and overwrites the old one in memory; thus no involvement
with userspace needed.

To realize the benefits/test this patchset, one must make a couple
of minor changes to userspace:

 - Prevent udev from updating kdump crash kernel on hot un/plug changes.
   Add the following as the first lines to the RHEL udev rule file
   /usr/lib/udev/rules.d/98-kexec.rules:

   # The kernel updates the crash elfcorehdr for CPU and memory changes
   SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
   SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

   With this changeset applied, the two rules evaluate to false for
   CPU and memory change events and thus skip the userspace
   unload-then-reload of kdump.

 - Change to the kexec_file_load for loading the kdump kernel:
   Eg. on RHEL: in /usr/bin/kdumpctl, change to:
    standard_kexec_args="-p -d -s"
   which adds the -s to select kexec_file_load() syscall.

This kernel patchset also supports kexec_load() with a modified kexec
userspace utility. A working changeset to the kexec userspace utility
is posted to the kexec-tools mailing list here:

 http://lists.infradead.org/pipermail/kexec/2023-May/027049.html

To use the kexec-tools patch, apply, build and install kexec-tools,
then change the kdumpctl's standard_kexec_args to replace the -s with
--hotplug. The removal of -s reverts to the kexec_load syscall and
the addition of --hotplug invokes the changes put forth in the
kexec-tools patch.

Regards,
eric
---
v28: 14aug2023
 - Rebased onto 6.5.0-rc5
 - Erroneously posted v26 as v27, so posting corrects that mistake.

v27: 11aug2023
 https://lore.kernel.org/lkml/20230811170642.6696-1-eric.devolder@oracle.com/
 - Rebased onto 6.5.0-rc5
 - The linux-next and akpm test bots found a build error when just
   PROC_KCORE is configured (with no KEXEC or CRASH), which resulted
   in CRASH_CORE enabled by itself. To solve, the struct crash_mem
   moved from include/linux/kexec.h to include/linux/crash_core.h.
   Similarly, the crash_notes also moved from kernel/kexec.c to
   kernel/crash_core.c.
 - Minor adjustment to arch/x86/kernel/crash.c was also needed to
   avoid unused function build errors for just PROC_KCORE.
 - Spot testing of several architectures did not reveal any further
   build problems (PROC_KCORE, KEXEC, CRASH_DUMP, CRASH_HOTPLUG).

v26: 4aug2023
 https://lore.kernel.org/lkml/20230804210359.8321-1-eric.devolder@oracle.com/
 - Rebased onto 6.5.0-rc4
 - Dropped the refactor of files drivers/base/cpu|memory.c as unrelated
   to this series.
 - Minor corrections to documentation, per Randy Dunlap and GregKH.

v25: 29jun2023
 https://lore.kernel.org/lkml/20230629192119.6613-1-eric.devolder@oracle.com/
 - Properly applied IS_ENABLED() to the function bodies of callbacks
   in drivers/base/cpu|memory.c.
 - Re-ran compile and run-time testing of the impacted attributes for
   both enabled and not enabled config settings.

v24: 28jun2023
 https://lore.kernel.org/lkml/20230628185215.40707-1-eric.devolder@oracle.com/
 - Rebased onto 6.4.0
 - Included Documentation/ABI/testing entries for the new sysfs
   crash_hotplug attributes, per Greg Kroah-Hartman.
 - Refactored drivers/base/cpu|memory.c to use the .is_visible()
   method for attributes, per Greg Kroah-Hartman.
 - Retained all existing Acks and RBs as the few changes as a result
   of Greg's requests were trivial.

v23: 12jun2023
 https://lore.kernel.org/lkml/20230612210712.683175-1-eric.devolder@oracle.com/
 - Rebased onto 6.4.0-rc6
 - Refactored Kconfig, per Thomas. See series:
   https://lore.kernel.org/lkml/20230612172805.681179-1-eric.devolder@oracle.com/
 - Reworked commit messages to conform to style, per Thomas.
 - Applied Baoquan He Acked-by to kexec_load() patch.
 - Applied Hari Bathini Acked-by for the series.
 - No code changes.

v22: 3may2023
 https://lore.kernel.org/lkml/20230503224145.7405-1-eric.devolder@oracle.com/
 - Rebased onto 6.3.0
 - Improved support for kexec_load(), per Hari Bathini. See
   "crash: hotplug support for kexec_load()" which is the only
   change to this series.
 - Applied Baoquan He's Acked-by for all other patches.

v21: 4apr2023
 https://lkml.org/lkml/2023/4/4/1136
 https://lore.kernel.org/lkml/20230404180326.6890-1-eric.devolder@oracle.com/
 - Rebased onto 6.3.0-rc5
 - Additional simplification of indentation in crash_handle_hotplug_event(),
   per Baoquan.

v20: 17mar2023
 https://lkml.org/lkml/2023/3/17/1169
 https://lore.kernel.org/lkml/20230317212128.21424-1-eric.devolder@oracle.com/
 - Rebased onto 6.3.0-rc2
 - Defaulting CRASH_HOTPLUG for x86 to Y, per Sourabh.
 - Explicitly initializing image->hp_action, per Baoquan.
 - Simplified kexec_trylock() in crash_handle_hotplug_event(),
   per Baoquan.
 - Applied Sourabh's Reviewed-by to the series.

v19: 6mar2023
 https://lkml.org/lkml/2023/3/6/1358
 https://lore.kernel.org/lkml/20230306162228.8277-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0
 - Did away with offlinecpu, per Thomas Gleixner.
 - Changed to CPUHP_BP_PREPARE_DYN instead of CPUHP_AP_ONLINE_DYN.
 - Did away with elfcorehdr_index_valid, per Sourabh.
 - Convert to for_each_possible_cpu() in crash_prepare_elf64_headers()
   per Sourabh.
 - Small optimization for x86 cpu changes.

v18: 31jan2023
 https://lkml.org/lkml/2023/1/31/1356
 https://lore.kernel.org/lkml/20230131224236.122805-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0-rc6
 - Renamed struct kimage member hotplug_event to hp_action, and
   re-enumerated the KEXEC_CRASH_HP_x items, adding _NONE at 0.
 - Moved to cpuhp state CPUHP_BP_PREPARE_DYN instead of
   CPUHP_AP_ONLINE_DYN in order to minimize window of time CPU
   is not reflected in elfcorehdr.
 - Reworked some of the comments and commit messages to offer
   more of the why, than what, per Thomas Gleixner.

v17: 18jan2023
 https://lkml.org/lkml/2023/1/18/1420
 https://lore.kernel.org/lkml/20230118213544.2128-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0-rc4
 - Moved a bit of code around so that kexec_load()-only builds
   work, per Sourabh.
 - Corrected computation of number of memory region Phdrs needed
   when x86 memory hotplug is not enabled, per Baoquan.

v16: 5jan2023
 https://lkml.org/lkml/2023/1/5/673
 https://lore.kernel.org/lkml/20230105151709.1845-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0-rc2
 - Corrected error identified by Baoquan.

v15: 9dec2022
 https://lkml.org/lkml/2022/12/9/520
 https://lore.kernel.org/lkml/20221209153656.3284-1-eric.devolder@oracle.com/
 - Rebased onto 6.1.0-rc8
 - Replaced arch_un/map_crash_pages() with direct use of
   kun/map_local_pages(), per Boris.
 - Some x86 changes, per Boris.

v14: 16nov2022
 https://lkml.org/lkml/2022/11/16/1645
 https://lore.kernel.org/lkml/20221116214643.6384-1-eric.devolder@oracle.com/
 - Rebased onto 6.1.0-rc5
 - Introduced CRASH_HOTPLUG Kconfig item to better fine tune
   compilation of feature components, per Boris.
 - Removed hp_action parameter to arch_crash_handle_hotplug_event()
   as it is unused.

v13: 31oct2022
 https://lkml.org/lkml/2022/10/31/854
 https://lore.kernel.org/lkml/20221031193604.28779-1-eric.devolder@oracle.com/
 - Rebased onto 6.1.0-rc3, which means converting to use the new
   kexec_trylock() away from mutex_lock(kexec_mutex).
 - Moved arch_un/map_crash_pages() into kexec.h and default
   implementation using k/unmap_local_pages().
 - Changed more #ifdef's into IS_ENABLED()
 - Changed CRASH_MAX_MEMORY_RANGES to 8192 from 32768, and it moved
   into x86 crash.c as #define rather Kconfig item, per Boris.
 - Check number of Phdrs against PN_XNUM, max possible.

v12: 9sep2022
 https://lkml.org/lkml/2022/9/9/1358
 https://lore.kernel.org/lkml/20220909210509.6286-1-eric.devolder@oracle.com/
 - Rebased onto 6.0-rc4
 - Addressed some minor formatting items, per Baoquan

v11: 26aug2022
 https://lkml.org/lkml/2022/8/26/963
 https://lore.kernel.org/lkml/20220826173704.1895-1-eric.devolder@oracle.com/
 - Rebased onto 6.0-rc2
 - Redid the rework of __weak to use asm/kexec.h, per Baoquan
 - Reworked some comments and minor items, per Baoquan

v10: 21jul2022
 https://lkml.org/lkml/2022/7/21/1007
 https://lore.kernel.org/lkml/20220721181747.1640-1-eric.devolder@oracle.com/
 - Rebased to 5.19.0-rc7
 - Per Sourabh, corrected build issue with arch_un/map_crash_pages()
   for architectures not supporting this feature.
 - Per David Hildebrand, removed the WARN_ONCE() altogether.
 - Per David Hansen, converted to use of kmap_local_page().
 - Per Baoquan He, replaced use of __weak with the kexec technique.

v9: 13jun2022
 https://lkml.org/lkml/2022/6/13/3382
 https://lore.kernel.org/lkml/20220613224240.79400-1-eric.devolder@oracle.com/
 - Rebased to 5.18.0
 - Per Sourabh, moved crash_prepare_elf64_headers() into common
   crash_core.c to avoid compile issues with kexec_load only path.
 - Per David Hildebrand, replaced mutex_trylock() with mutex_lock().
 - Changed the __weak arch_crash_handle_hotplug_event() to utilize
   WARN_ONCE() instead of WARN(). Fix some formatting issues.
 - Per Sourabh, introduced sysfs attribute crash_hotplug for memory
   and CPUs; for use by userspace (udev) to determine if the kernel
   performs crash hot un/plug support.
 - Per Sourabh, moved the code detecting the elfcorehdr segment from
   arch/x86 into crash_core:handle_hotplug_event() so both kexec_load
   and kexec_file_load can benefit.
 - Updated userspace kexec-tools kexec utility to reflect change to
   using CRASH_MAX_MEMORY_RANGES and get_nr_cpus().
 - Updated the new proposed udev rules to reflect using the sysfs
   attributes crash_hotplug.

v8: 5may2022
 https://lkml.org/lkml/2022/5/5/1133
 https://lore.kernel.org/lkml/20220505184603.1548-1-eric.devolder@oracle.com/
 - Per Borislav Petkov, eliminated CONFIG_CRASH_HOTPLUG in favor
   of CONFIG_HOTPLUG_CPU || CONFIG_MEMORY_HOTPLUG, ie a new define
   is not needed. Also use of IS_ENABLED() rather than #ifdef's.
   Renamed crash_hotplug_handler() to handle_hotplug_event().
   And other corrections.
 - Per Baoquan, minimized the parameters to the arch_crash_
   handle_hotplug_event() to hp_action and cpu.
 - Introduce KEXEC_CRASH_HP_INVALID_CPU definition, per Baoquan.
 - Per Sourabh Jain, renamed and repurposed CRASH_HOTPLUG_ELFCOREHDR_SZ
   to CONFIG_CRASH_MAX_MEMORY_RANGES, mirroring kexec-tools change
   by David Hildebrand. Folded this patch into the x86
   kexec_file_load support patch.

v7: 13apr2022
 https://lkml.org/lkml/2022/4/13/850
 https://lore.kernel.org/lkml/20220413164237.20845-1-eric.devolder@oracle.com/
 - Resolved parameter usage to crash_hotplug_handler(), per Baoquan.

v6: 1apr2022
 https://lkml.org/lkml/2022/4/1/1203
 https://lore.kernel.org/lkml/20220401183040.1624-1-eric.devolder@oracle.com/
 - Reword commit messages and some comment cleanup per Baoquan.
 - Changed elf_index to elfcorehdr_index for clarity.
 - Minor code changes per Baoquan.

v5: 3mar2022
 https://lkml.org/lkml/2022/3/3/674
 https://lore.kernel.org/lkml/20220303162725.49640-1-eric.devolder@oracle.com/
 - Reworded description of CRASH_HOTPLUG_ELFCOREHDR_SZ, per
   David Hildenbrand.
 - Refactored slightly a few patches per Baoquan recommendation.

v4: 9feb2022
 https://lkml.org/lkml/2022/2/9/1406
 https://lore.kernel.org/lkml/20220209195706.51522-1-eric.devolder@oracle.com/
 - Refactored patches per Baoquan suggestsions.
 - A few corrections, per Baoquan.

v3: 10jan2022
 https://lkml.org/lkml/2022/1/10/1212
 https://lore.kernel.org/lkml/20220110195727.1682-1-eric.devolder@oracle.com/
 - Rebasing per Baoquan He request.
 - Changed memory notifier per David Hildenbrand.
 - Providing example kexec userspace change in cover letter.

RFC v2: 7dec2021
 https://lkml.org/lkml/2021/12/7/1088
 https://lore.kernel.org/lkml/20211207195204.1582-1-eric.devolder@oracle.com/
 - Acting upon Baoquan He suggestion of removing elfcorehdr from
   the purgatory list of segments, removed purgatory code from
   patchset, and it is signficiantly simpler now.

RFC v1: 18nov2021
 https://lkml.org/lkml/2021/11/18/845
 https://lore.kernel.org/lkml/20211118174948.37435-1-eric.devolder@oracle.com/
 - working patchset demonstrating kernel handling of hotplug
   updates to x86 elfcorehdr for kexec_file_load

RFC: 14dec2020
 https://lkml.org/lkml/2020/12/14/532
 https://lore.kernel.org/lkml/b04ed259-dc5f-7f30-6661-c26f92d9096a@oracle.com/
 NOTE: s/vmcoreinfo/elfcorehdr/g
 - proposed concept of allowing kernel to handle hotplug update
   of elfcorehdr
---


Eric DeVolder (8):
  crash: move a few code bits to setup support of crash hotplug
  crash: add generic infrastructure for crash hotplug support
  kexec: exclude elfcorehdr from the segment digest
  crash: memory and CPU hotplug sysfs attributes
  x86/crash: add x86 crash hotplug support
  crash: hotplug support for kexec_load()
  crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()
  x86/crash: optimize CPU changes

 .../ABI/testing/sysfs-devices-memory          |   8 +
 .../ABI/testing/sysfs-devices-system-cpu      |   8 +
 .../admin-guide/mm/memory-hotplug.rst         |   8 +
 Documentation/core-api/cpu_hotplug.rst        |  18 +
 arch/x86/Kconfig                              |   3 +
 arch/x86/include/asm/kexec.h                  |  18 +
 arch/x86/kernel/crash.c                       | 142 ++++++-
 drivers/base/cpu.c                            |  13 +
 drivers/base/memory.c                         |  13 +
 include/linux/crash_core.h                    |  27 ++
 include/linux/kexec.h                         |  48 ++-
 include/uapi/linux/kexec.h                    |   1 +
 kernel/Kconfig.kexec                          |  35 ++
 kernel/crash_core.c                           | 391 ++++++++++++++++++
 kernel/kexec.c                                |   5 +
 kernel/kexec_core.c                           |  43 +-
 kernel/kexec_file.c                           | 187 +--------
 kernel/ksysfs.c                               |  15 +
 18 files changed, 741 insertions(+), 242 deletions(-)

-- 
2.31.1


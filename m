Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1457795D4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbjHKRIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbjHKRIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:08:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D4B30D0;
        Fri, 11 Aug 2023 10:08:11 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BDbULM002246;
        Fri, 11 Aug 2023 17:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=kqZzUcUI7g9GrNNQb568EFpHtig8R3NmjYR2Lpu3gEg=;
 b=Z83Xol3J0V1agDXYpVQMlh5oQp3Q/uKVLAY39czzfrpu97wyjkguwYn8nW2oCwDaGjSL
 CoJ2nBuqEpq8c8JzgTHsf0Sd/Cyp7tfV4W7DAWmnN8E5BhmLaUDa8wY40lFmqMqA19rn
 XbgqYgyvv7h2OiGjang9H0NDC2MXOEbJPU7ylGmLN62lYyWwG5gK8DWk1FWFGv3xRAY8
 32zzSwaLZAF3CG7tjW2MrDMO4TTWS8klsr/rDk9UaUOAw8kqTsfX9wW27XWeY7jugS7T
 L1EGIgVwVEe960PupUaXC7tEjjABVCOmpci7y1ZpKRqcOQw/YLwVUvSDYchkdw2BYWYM sA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sd8ychg4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 17:07:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37BGPusc033488;
        Fri, 11 Aug 2023 17:07:16 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvakvr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 17:07:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8SjkvOOonGzjQePnK4CiE9gfzGqNM3bvza9zceS3ViZ+5SoMXNj5WOG31pxMnPkcMrJ/oegU5U+k+clZA5nrRi6nsMyOT6Hn3/138byX+i8pWRy5FcwvzLGP4vwIFr0gw2na6a5l53ZswNKOaJeFgtlyXs5pYE5Z274iAmgRM5XZR1o9RKEaZPgfPW12XxTZlldR+JAJAZdgFIsg/1pHVf08gFBiYH9yj1Q2+2ceTc00v8zeclEnpDawB6TJtwDQCqBgsiSUZ7trh8zDl8bPonRUTjrGjETMlQioEgJcMOZng+2Mr4ckUIB0AVajcHNntU8j7db/na8ENcO/g79Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqZzUcUI7g9GrNNQb568EFpHtig8R3NmjYR2Lpu3gEg=;
 b=fnOdsQcr1dGNeqHvFonvtT31fM+IYcDWoi1sZhOw6ZWyhRVpYBRWGyEIohrJNF54laKyHiJzG/PoVYWkUe7ed5omREY4lIrObqPGxGsPfHy2uwaS5IuapAgGpVHc/C+UXwQiUEV3r+W8a1MaTEENOWMKtLWZ1gQ43iZlxkbHq5YXbDJSqoSTQv/xPD58+8y5MNK4NZTkKlXqEhbbYb12PDfjhYnIVYeYS0Bha+LnTvSm9gHVDFUCerOQFzaEGLmI74IoT+yLdfN56UN/bhLVFuGJRZdgVLx0s8JkR1RUV3dgO905Sz4DTFdXbqs/G2C5GAbXpjN/sonaAAZ8jGmm1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqZzUcUI7g9GrNNQb568EFpHtig8R3NmjYR2Lpu3gEg=;
 b=0Uo+xZqCxDgZR15i8vPq9u/+GxqwOeMLoLiWGuw5TNtyFTWqOsXGUR1aZvaX8yoVkeglZahMlaF70mdD0G+48BEFYz+Vv7uXMbOM1bMQIab0Kk1xR290O8idWrPF+FGBSNn5IeoEW9l/I4kJxv5/7rqEdzW3a7OW2DzCz5SOUf8=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ1PR10MB5978.namprd10.prod.outlook.com (2603:10b6:a03:45f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 17:07:13 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57%4]) with mapi id 15.20.6678.020; Fri, 11 Aug 2023
 17:07:13 +0000
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
Subject: [PATCH v27 7/8] crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()
Date:   Fri, 11 Aug 2023 13:06:41 -0400
Message-Id: <20230811170642.6696-8-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230811170642.6696-1-eric.devolder@oracle.com>
References: <20230811170642.6696-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0130.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::15) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SJ1PR10MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 723ce4f1-516e-440f-f6c7-08db9a8d682f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /5VCZPgAMFvYN8YznkcxvPPnDwYjIrw5mktrrXU+Szj/7o2XOtpSAcFz9eIQHjKMI1cgUBoBuaAeRE4sIrm1yugo2RKG501qVPSBs5PD6/xtsPfNKjybaXTpKGtXfypx54MvTeACt8uVONkbZ0dxHYKhRhja00vJLJnaUGz9F74UKg25vxauxUJsx7dEvRkmPP7RWcvS6O+I6OfwzYd/Mw+DjinzmtnmyY6WCn5LtnPJy4DViXqmU38sPvJJqnQUl1G/tKkd0kyZ6MEuQM1CgJGuI0xyljrWcp6M/lCaI/NxnY9qPE3o1dedFV83I6b3olsJqS+gr1hvQkDr5OBnN9t/YNRhhwFA1Va5q4BknATBYxY/G5c5l5pgt9mFGI07m4LaY49D6s77cOAGKKz3zGBZOvpKINS5ow2Kn0TywU5frreluK9vWl6ePBru+XwDgFRFq6slpiHFhnOh4IwYLyeNQiobTMCGbfBz8jfZSERiH8OiNtL7+/jckOyzR6z485ycMewW2gGih2uPXTS32f2mCNH2NWgjpoGwzzMtefJeGVwKE6hN4nFYZ0otzlRJIYm56zjH/B4jpPsTlM2Hh1RahpGwN2+ZTNFugD+Akd8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(1800799006)(186006)(6666004)(6486002)(6512007)(478600001)(2616005)(6506007)(26005)(7416002)(107886003)(2906002)(1076003)(7406005)(66476007)(4326008)(66946007)(66556008)(316002)(8936002)(8676002)(5660300002)(41300700001)(38100700002)(86362001)(36756003)(83380400001)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OGtu0+J8dNMNlkIPSme2PosuiRf0aWXn7CWUKtH2MXzmPralM/N5l1fI3DYb?=
 =?us-ascii?Q?iBzZBctZ1LfMmOhB4S2HMxa0r9EFV8zr13yYmKHLxQaqeAgNibWuF5FN0JJI?=
 =?us-ascii?Q?REbTSCLFstD1G/wz1k4tQ888t3gK4eRHaw08fMuNNejazNLO+ci03vqnVMQG?=
 =?us-ascii?Q?8NZS9Cq1PLOYqxExI+YmKVikSkyaKBciGj3Hy72ynyG/sGUF31hpUBECXIXC?=
 =?us-ascii?Q?hn7xcXUXC6XM06W9DvdugXePdSp3LJfShYnc16/M2jFihqjA7qYqwIc+iJWI?=
 =?us-ascii?Q?YpoJfo6quexU3QTPAJ6J9T76lO0P2zVPSQO3yPhLMmfoFcvOZLlJQIBwR0TZ?=
 =?us-ascii?Q?EQ1JomudbYUnxNkjyfu5D8Wf29zDMhJZMsYEvi/ay0y4rff/BdZGTceD5y0d?=
 =?us-ascii?Q?atZOk+Ykhypx6AE44TB4OtdWfL5trkhyIWzH0Db5ZwNABVrM4zELBRRL5hKO?=
 =?us-ascii?Q?xFK/g0p/w2/1feAj3w9jsVMUwFXjJt9kr0ta9JN6qpPMwnPMkDVl40KabmeH?=
 =?us-ascii?Q?y6b+nhqMNVQ1YgsvydnH0nF6oIpl7yDy83su0TQtomdKlazHYJECDRW1b5kj?=
 =?us-ascii?Q?yK2yb++Y4dRtUdGOKNekP6li7MckEKwFQ6U8FEAAvL/EsIhBoym9k0m6mNRj?=
 =?us-ascii?Q?4bbearTpb4gVQ53uUrYqFL/xBKkJ2u0ZYdt7kIwB8aWHmSQOmrPRfAadD+4w?=
 =?us-ascii?Q?AZc9o1I4xlEirwZCdsy6BCu5/crG1oIPxWao7f1qi8ylaf6/jsvauwtsyMXK?=
 =?us-ascii?Q?/SO2tsqhns+2yLHAjhNPJ472Fs0yiVuIPZGKZoAlK6GORFPJW5V1cy188gi5?=
 =?us-ascii?Q?eGikf8BO1BQqR9/FX4CeLoHj+jhr9TNlqSUmyhVPClXcHGFEnNW9SjKKbUoC?=
 =?us-ascii?Q?yFE1yr0PrXPHJWOWDgEFjRM7ySgeyTxP2vIxZN//R9tHrl1DruSTxYzOo5gS?=
 =?us-ascii?Q?Q6TU8NSGi+LS0IumGX4FN0PLbe2KxXkKndYX6egetCEAsOnmo0j3jAcYU5jc?=
 =?us-ascii?Q?maC65+qoXH6PMqL7TZpvMHvnoEtaFBrHEv5mEGkLiT34X5aWZKxgbOM0xZi9?=
 =?us-ascii?Q?uUx4vBN7Lia6dRnrLEa28P+rVbCRQus/P+FRih/o7Hu4eRe6TiKHBwaEpLNG?=
 =?us-ascii?Q?3JyPFpAueFziGItkVtbOjk8stXKTGmim98HIFc64RTPasYhY5WOtaWQJP6YX?=
 =?us-ascii?Q?PYdtnnnpPFqAMH00qCz6sGY/sULMO+cEmOidOPGMdn0EfLNskCX2A/2ODDRZ?=
 =?us-ascii?Q?UvSaj4KugrfcsOD8YjeOdm727I8Mu+Unj+EyrtoPjM2wJ2slj7SvSi65M1IX?=
 =?us-ascii?Q?tUGfyGesVhRDo56J785jhtSWPr5T1PwyH8mePiSYTrfNLSu3FkDDuy64I2y6?=
 =?us-ascii?Q?/ie0B2MIaApLoDbDWCQevYLWDrTpbTAYs5lf1VZNqkzT0iB0NlEiztbGrLLE?=
 =?us-ascii?Q?9pboMMDZqrIVxvsz8w2msDMmVjq8iet1bj1z5kTqhV6dQPD0QIX89iEqGuy1?=
 =?us-ascii?Q?sNfKXekLAhaCn+y/IFr1L1lbZxKSsXslmI2uu2MQ5sYiHg34p+vLNCdYtXF0?=
 =?us-ascii?Q?i/R7X+6rsDklsqZYwW1+0MsA3LWWIBl4vGaYt13i5UsO2rMFWiReqhfBr2gH?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?6V/8FWRW6ktuJT3m8LJSeh9FjMZ0qCPWf9ktE7iMcbWVpb4Jf8XNfUwPoVmm?=
 =?us-ascii?Q?+rcyvZTUDT4X2xyx4x09cTPiYBWhEHQJ6x0tqMop01j7PZsSOlBrTjmH0Yxz?=
 =?us-ascii?Q?6pLyxcqlkl91kNZF7abq1u96a6CdorFYJjU0+AW18lYdnRNXHbr3vOVNXzgo?=
 =?us-ascii?Q?a8AZah0xF8j0btnuk/D1UoxEYBA3N3TVPgonslYhU+KqwaJNgCZoAZlHGS5f?=
 =?us-ascii?Q?id6wFIIt12lf9fD9SKkVzQQF63fXjQKrlNxBYyHyyCXaH7UD30J9SPDhkEPA?=
 =?us-ascii?Q?hWIgw4hV4GaXdau9Q3AT+zfppw2ozvjiei1148/Na7+b60UJhYJx7481Id2D?=
 =?us-ascii?Q?/TkZhhQb7Rzgt/WtObmrUQ7X+o34PFtbDNEIohlY3RYnjVLAyC2ueBcWDVRd?=
 =?us-ascii?Q?E6mmI9MfXKEdaT+9eRRhDSBqQzopVV42jP52BUguNkcwaqQtMgBKP+InRsdM?=
 =?us-ascii?Q?XO3/xaVUv0s2t9aBX1ArF93FTRfekEwMGOG5Hi4Z/1nwEYv1Oqs38kdfgZZn?=
 =?us-ascii?Q?lat1JjL0V9o1hAtsCI+vP6oX2AvHctQGBdK36gGLj4k4x6YFJy8r0Pml8mWO?=
 =?us-ascii?Q?CkK/X2HdCwflhcvjKgh+WwJZBVMw5o6AudC1aWkU7Nq9eSm3jCdZCl/JTVLH?=
 =?us-ascii?Q?cVDuUoDUhLzMTuW0+76cmAcfT8sHBcrs1ggCoQ1ODZt0BBcaGz9wsb/6LlZI?=
 =?us-ascii?Q?ZKgBqzg0Tr2W3QH5DsMEeLlrTBsYJ6wdQtUavQvSAJQNLTLkiWf+tXHH8UVo?=
 =?us-ascii?Q?/m5O+k5Khlx6Y1AgHUHEDG3bKrHwKc4RTW770iVxA067d3hGZwSuGgggLUzO?=
 =?us-ascii?Q?P/1thDa7UufAf0+TDRirAdoC/khZr2gsuJIAMYk0VYU9Sli4RbfzEM6sORrx?=
 =?us-ascii?Q?zkTY2jXfzj0qFuomSwm8CToAXaK0KpVbsQpL4eWYXfFM4orIXRylTxatAPiN?=
 =?us-ascii?Q?22VnXKtY0ISi15MShrLpxyZbdiigwxEpZ+ccLaSkZPiG2GXGaCoZe5SHCjdV?=
 =?us-ascii?Q?3zTLfrlgij2EDmx6Ne2whmSMOK7t+ng+w07C0PoW6t/fBHcbOvtvHnb9epA7?=
 =?us-ascii?Q?+ocQw8Ftj40QEcN/tQUfUk4reTR7MvApbccQ1/Yp8WKYqReQyiNwiKIzUQli?=
 =?us-ascii?Q?NDCI1zyYl0JAmSHgeorIQDU+q7IoUCFP4j9Rw3MmgU4Pbh9tDGvJyexINJcf?=
 =?us-ascii?Q?HHxS+YEwTYQUhWXWRGrDnt9juo8LQ04kUUa2Tlr6vNl95uF0d/XXMOfSQsNz?=
 =?us-ascii?Q?oIFPNFdYh+cUsawo7pq5ZpRFOi1o9CPrLOvqC4h0FoTstB40oBeNJeBX+bmo?=
 =?us-ascii?Q?MMP+rw8vxNeUpvSKuwgHYO0fSc4H+seuu/lcvPTGsij5YunEdtbVw4yj/JB1?=
 =?us-ascii?Q?TtG69NPE3XC5XuslLwy+gUUbfWiE5RqVrcxtCu/Tpa3/WKvXTacIycxztwyk?=
 =?us-ascii?Q?8wUFXwc4GNc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723ce4f1-516e-440f-f6c7-08db9a8d682f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 17:07:13.4498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgskGlM2/a48AMssLoE9cXLeb/PzgJXgFR6ZAoOnwMLStxqyrPWGm4MLmGI4uLmqJx1x2Jz5m+/6mtgsZUHQuY5jgyl/dtBGpgSKmqELZDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_09,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110156
X-Proofpoint-GUID: Fy35Q8OkgxJX8fUMFE--nNe8DJOVb3Ui
X-Proofpoint-ORIG-GUID: Fy35Q8OkgxJX8fUMFE--nNe8DJOVb3Ui
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function crash_prepare_elf64_headers() generates the elfcorehdr
which describes the CPUs and memory in the system for the crash kernel.
In particular, it writes out ELF PT_NOTEs for memory regions and the
CPUs in the system.

With respect to the CPUs, the current implementation utilizes
for_each_present_cpu() which means that as CPUs are added and removed,
the elfcorehdr must again be updated to reflect the new set of CPUs.

The reasoning behind the move to use for_each_possible_cpu(), is:

- At kernel boot time, all percpu crash_notes are allocated for all
  possible CPUs; that is, crash_notes are not allocated dynamically
  when CPUs are plugged/unplugged. Thus the crash_notes for each
  possible CPU are always available.

- The crash_prepare_elf64_headers() creates an ELF PT_NOTE per CPU.
  Changing to for_each_possible_cpu() is valid as the crash_notes
  pointed to by each CPU PT_NOTE are present and always valid.

Furthermore, examining a common crash processing path of:

 kernel panic -> crash kernel -> makedumpfile -> 'crash' analyzer
           elfcorehdr      /proc/vmcore     vmcore

reveals how the ELF CPU PT_NOTEs are utilized:

- Upon panic, each CPU is sent an IPI and shuts itself down, recording
 its state in its crash_notes. When all CPUs are shutdown, the
 crash kernel is launched with a pointer to the elfcorehdr.

- The crash kernel via linux/fs/proc/vmcore.c does not examine or
 use the contents of the PT_NOTEs, it exposes them via /proc/vmcore.

- The makedumpfile utility uses /proc/vmcore and reads the CPU
 PT_NOTEs to craft a nr_cpus variable, which is reported in a
 header but otherwise generally unused. Makedumpfile creates the
 vmcore.

- The 'crash' dump analyzer does not appear to reference the CPU
 PT_NOTEs. Instead it looks-up the cpu_[possible|present|onlin]_mask
 symbols and directly examines those structure contents from vmcore
 memory. From that information it is able to determine which CPUs
 are present and online, and locate the corresponding crash_notes.
 Said differently, it appears that 'crash' analyzer does not rely
 on the ELF PT_NOTEs for CPUs; rather it obtains the information
 directly via kernel symbols and the memory within the vmcore.

(There maybe other vmcore generating and analysis tools that do use
these PT_NOTEs, but 'makedumpfile' and 'crash' seems to be the most
common solution.)

This results in the benefit of having all CPUs described in the
elfcorehdr, and therefore reducing the need to re-generate the
elfcorehdr on CPU changes, at the small expense of an additional
56 bytes per PT_NOTE for not-present-but-possible CPUs.

On systems where kexec_file_load() syscall is utilized, all the above
is valid. On systems where kexec_load() syscall is utilized, there
may be the need for the elfcorehdr to be regenerated once. The reason
being that some archs only populate the 'present' CPUs from the
/sys/devices/system/cpus entries, which the userspace 'kexec' utility
uses to generate the userspace-supplied elfcorehdr. In this situation,
one memory or CPU change will rewrite the elfcorehdr via the
crash_prepare_elf64_headers() function and now all possible CPUs will
be described, just as with kexec_file_load() syscall.

Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index fa918176d46d..7378b501fada 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -364,8 +364,8 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
 	ehdr->e_phentsize = sizeof(Elf64_Phdr);
 
-	/* Prepare one phdr of type PT_NOTE for each present CPU */
-	for_each_present_cpu(cpu) {
+	/* Prepare one phdr of type PT_NOTE for each possible CPU */
+	for_each_possible_cpu(cpu) {
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
 		phdr->p_offset = phdr->p_paddr = notes_addr;
-- 
2.31.1


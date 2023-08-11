Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1970D7795CC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236668AbjHKRIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236496AbjHKRII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:08:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE8B2123;
        Fri, 11 Aug 2023 10:08:06 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BDkcuP014733;
        Fri, 11 Aug 2023 17:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=5eYj+23ZC7VzOGJgW8YD6nEDB2+diEwDOwLRzF4YxgI=;
 b=yyk2+aucwuKopz696v6m5YmgtC4VdhXBMGvahRm4m1IGptRzuO6sAYczSACglkGU7ZDN
 PwnpYmShtwMW/o4iQmI1fNNLyTZEm3C1B8Tx2Hi04MCIzUB73O7Qcd4PMu4xYvjDABEd
 KpF4rq0HQFzajfIxpHpWROQEWQ+17OxzGgut94p21dlwcAIKsrPpbJkKTP+6ixpmWad9
 whcun7NPv+JbAQvJSP2olnXcb2JX6N1f+Eoc30vFHbfQd7OOhBWCaNX8xDAf+AEzA18x
 2lit+eBAgLj7+aJVOXMw79o3FkbwEPYrD7iW5fhvtfvgvyzOPMOR1wi5oEwEyr7JR6W9 yg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sd8y3sg06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 17:06:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37BGOWMp012090;
        Fri, 11 Aug 2023 17:06:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cva2g8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 17:06:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7ehmK/YwBRgFgbdOdb606ccT8yCogJRiYvSuFBJli2oYvHuhA+8X/5X7BS9jJeBNaBBsFtc7emFO8F+gYwV2xXR4UB9laKp8eIgxcCUJGcj9Lraw5VdhO14rkrlc8RmgAGro/P/xR2gA1IC0rEvPDGh8lVeNHTArKIisfLbX2Riq1uEmJ8CYDRaOhJyxD8eyCoibf/+ATPTIDjsl+gZQVw25H31v3ggT3Oe+mY9TEiLnoKRZqo92mqNBOP7kzmY8jgYR+WMnblM1sbE0Htm9/Ybhsbxat1g2XtyvUDlySe26wwi+JmIAC4GAhmnJdFQYRkHSwA7EtnsG7gznNFqJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eYj+23ZC7VzOGJgW8YD6nEDB2+diEwDOwLRzF4YxgI=;
 b=TW3HNCdeCOsBl/PSZIOYeemslmzuvrAEGKoI42Vd+cY+DDU9pBawyG+CC0izdu4RDVXKBKacqJwU82KPzlG58YLjcxRiuFKoavjEhvfCeM5S/0uI3DUGaO3t2ya8xDrvGs6TNcmMPnti1OunSSaf5F3ENYijZ+j38LE3RjEETsyv6B/6rXzy5madTZJxrdzZze9irwoPaRUnJC+1BjeEm0A2EGYEIolYh8viqPzE5arvxnMYYe5BOlS/mE7XHJ3Dw05OyK0RnbJttME/cyGsZf7TGqrdFOfB/vDNF18f+N8yvrISZtlKH6/Drx51T9jHmy8ZrndomA+n8b66S/pYGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eYj+23ZC7VzOGJgW8YD6nEDB2+diEwDOwLRzF4YxgI=;
 b=OdauHP5NFtSYWkEf59/Q7aZr1RZzPz/uS9Pc0W1clrIeOtIuOQMjhS/tF3wYq1xpKI2XifCwiefqwyiPdFYhMzSq/JN1cT5Q1ohEeL6EwkxeeV6kWMu2bDkQtxJFi68TIYfRkSKJrS31hxxTvyMNJFqX44VPlMpuYPCpWP8r4hM=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ1PR10MB5978.namprd10.prod.outlook.com (2603:10b6:a03:45f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 17:06:55 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57%4]) with mapi id 15.20.6678.020; Fri, 11 Aug 2023
 17:06:55 +0000
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
Subject: [PATCH v27 1/8] crash: move a few code bits to setup support of crash hotplug
Date:   Fri, 11 Aug 2023 13:06:35 -0400
Message-Id: <20230811170642.6696-2-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230811170642.6696-1-eric.devolder@oracle.com>
References: <20230811170642.6696-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0083.namprd11.prod.outlook.com
 (2603:10b6:806:d2::28) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SJ1PR10MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: ba573b1c-8d8d-411c-9e2c-08db9a8d5d29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pcn+SG+6lqi22ZZcTpiffuhPCMDdS6iya8nrUzpfa3nuF5CbTVmWiSFYgwiXPQTvyu0W9IsO2+bboGlL7JNjgzMkOdk1lUiH0cLExJ3u/VV5diYSSm0QAsQzJGDC8yYuLbbcUiLeMKX/voObc952M22+vRpfWlttjyKSDVZ8YaA2pszyrQNkBxpN8+x9KO5EqeudfEACHTMVs6GBddpPzmZC4WmXvpSE5dV5MMmGkCEg7CfuRO5yyg+7sJh7AoAq91/Rm8EmRpDtKR/HHjVqXDMVHo1zw8nIB55oY1gCVsZuQjiVWu4n6Xpnsxavnu0AVFOf4eTbYkO1YrGZdGSuf3TU3xJuBuAYMtVoH+cUAO7V0bkRXM4rzWJybDFYF8eYH5+etT/Jm2SQRNP1XDkDSCmFlhk8Jc5Bng0JWf/SxmNp0Jg484w29FPJ8xAXQb3xMOIOc6ujLJeT/7x1fxFi6X48VYBB8MeInm5wAfp8+zyOOv3Vkr0ZpgFFd6kqIKCx6YuzxMHEzv9VZSr/g/K5RwgCONoJAh2JXJxArXQCvRAz/yWJbqLXpbdewgWBnvVYeKAQ0Glgne1LfkXUcJecYrbDmcoSGIEufd/hEkU2/EQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(1800799006)(186006)(6666004)(6486002)(6512007)(478600001)(2616005)(6506007)(26005)(7416002)(107886003)(2906002)(1076003)(30864003)(7406005)(66476007)(4326008)(66946007)(66556008)(316002)(8936002)(8676002)(5660300002)(41300700001)(38100700002)(86362001)(36756003)(83380400001)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kfdISzT76d17SMThZJAHETmqioxtP+OlQwaaNPxbsAeDofSt6AsNG7A2lkNr?=
 =?us-ascii?Q?2LmE+c+tcgGZy/ZUVufiqDCjEtRSsxDunMFQe5I53XDo7ezYHU0o4ckZCW3m?=
 =?us-ascii?Q?gycO5AhFvvSSwmUyQpwrSem5ARjoMHrZC38AuImitLwnyXC77ngptnC8C6nc?=
 =?us-ascii?Q?mtMceVDnwd27Mp2ZsL9k8WwfBP6SbNyaarVe9HQAuBW4LBDusScmoqjSbl2/?=
 =?us-ascii?Q?fJe0wGlDTpoSLnRhlxbQNDoyAIh14DuXa4+9Ys3hb4011k/FCBODBlUZhoLE?=
 =?us-ascii?Q?gQiRqW6TVlAGArog0W1teCJWWytFerKltZuOjCHNF8IrFOpIO3awWDwYZStZ?=
 =?us-ascii?Q?UrXRedCA0J1Q+DxPt33Z8KYgXTi+9uHwIKRR2Ot264tDWVw27UWuC66lmubX?=
 =?us-ascii?Q?Rmx1Gia3UtR1S+27ySayYHRY1afODCdv1a42epW7oT8ntAbyeBli7M2m7ANi?=
 =?us-ascii?Q?JU2DqXbojFuy7xvkr+/ra4wJ6GQeLG0T0nTTKULs1E4KGaScn7qjDJNh6Rh5?=
 =?us-ascii?Q?XYzToAsslPffhfwWInhcjL1zZvdUN/hhET92oV2dYcAYjtcnxDh1hFu2Sjc6?=
 =?us-ascii?Q?Ex4UrUl4tRQdCO2Sc8sjvsUDvpId+IbRr4SLPu7oT/mgw6dvSXPA4EtClKPi?=
 =?us-ascii?Q?P2IEKzHM3NcFxtAdtNvlbQytt/S3naWxvISYja1rab2pD8lDnNvds8b05YF6?=
 =?us-ascii?Q?rfD4MydvIsR8PfM+FXCWLLKJl05i2Pt3np5S83bS1MUITSiuvYD+YSfDR1C+?=
 =?us-ascii?Q?8QfY5xhzh6M0BadR2/whEs/N1P4g037TPFD64oYGHVGCnJ4Hl88l9S9QNc0S?=
 =?us-ascii?Q?UeY4MHIDcrZIOdFCKVvuqtUbe4aLEy+uHH5anwxzeB9JpaofJ24tkbwNU/Yn?=
 =?us-ascii?Q?JOtrBZG3MMPKeUG4/7hYzZh7Ztj0XgFOEvIaT6JcSl3+zfuh92oqn362fHml?=
 =?us-ascii?Q?gOda2wmHujSIWdQcWxsXsRhZpDlI8p4mowqUeaMPxD8mCT8Xt/anPECLK7g+?=
 =?us-ascii?Q?WpXZxpNrm6uVGS0ryVEFtbbB6rTU5E/7VgF9p8C9k6IeGrK/xMG7z/M8nF66?=
 =?us-ascii?Q?WpuPICzc90c2UGy5nvQsypfznO5c5d/r7xbSL65vDUx9N2duoh4cNRItiqBA?=
 =?us-ascii?Q?K9zE/2cdVWOuO/ve4Q1b5TRNcQpoctwkQUtJWeT0ghZKCyRLYmU8ubL8I4E5?=
 =?us-ascii?Q?dLFBlz6rn7nHIFgIV7bQ4ytBVYZN5O6X+GmNumIDgqkmKdDVCe8pCfImE1JY?=
 =?us-ascii?Q?i5C1znQGQC40XGzvmgJtDvc2zcxn5g01JiDV0hho7K6GaEyB2hwZWTlnRCG8?=
 =?us-ascii?Q?SJteR4Q/7WvcF1Oz68LdvggwLiGcI+pKCPe/MIuJLfqQIBNphHGDcrdPOHSl?=
 =?us-ascii?Q?JjVyChFlargTcK1vBJ+5SqkfwL2iUlxrT//JZ+ssc2DzPCddhPhO+ddeifW5?=
 =?us-ascii?Q?qvfyPUfsoE6fwdoF19h4QhayL7MNpBmWeiCuGC+Zx9XhL4HpKoJwdETwKGHQ?=
 =?us-ascii?Q?Scp/4oRwr0j2XbhkYZPxXKfTK7nPsoTFRJ4CeNZ9lHcUCgebotuujDC6iLZr?=
 =?us-ascii?Q?gtyX+Sm1X9ceD2Oto8kcpJQjisU0z9wtd5jrAQy0NxeYFOZhZn5L8+XM5Mst?=
 =?us-ascii?Q?mA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?2Dsu3pD2OohsjZwQsHj0lJN7Xiav3MxjJX3tIYCL8QfQ6PVsEnXvGg3Q9qUX?=
 =?us-ascii?Q?oLlDb9k3jEtadXiFK17oGizOStI4wlXH0lipuqCwdKMdgQ0BB4dT43QbU/3b?=
 =?us-ascii?Q?iGdiXm6TIgg1m8IHfMNufjISPjl70u502gV2gXa2vpt8g9dX/lV0cWHozOny?=
 =?us-ascii?Q?DvGFFSw4gTP52HtxROJAj7ym/ZL+gom2hrrlNh8hohPoX5Qt50pRIpvzuBBN?=
 =?us-ascii?Q?B0MDxblD/dJ0LKhLVZjWUIsIsjbls52eyPxWtRwp5lCB7kpMXvcyhesQIotO?=
 =?us-ascii?Q?n0x9vL6qtWpQ83vjJJa7ze3ofBfOeeXDrxNWDQmv1A1LCKOhfWLhDD7tirpo?=
 =?us-ascii?Q?7z77LtQ1cVCgflapmOP3kmRC2IuXOsSuGCkR4BDUW//BCDJMsbm8stFris4W?=
 =?us-ascii?Q?cSKQoW7xVOtbgKkaDOs2Iv33PRNd1e/9Os/59cZOqpTn7YJY7TM/2YwtPbLI?=
 =?us-ascii?Q?hN9l2+XTjeN0sptPEvKcUUtlNK35DZq5YhC/KbJ/Lv3H01+rYWTlLY6aaXye?=
 =?us-ascii?Q?oY/qhMutuBuVRVqUKt2qXDpecjQw0E7y1p6gBkZjVA0htk6sQSvpjhoySm8W?=
 =?us-ascii?Q?N/aB7cBx7o0osIwU9S/aJcJ2mMtiLJrhZv9xqC6X7d1wPVcHJ6X0ZyMk1Zf/?=
 =?us-ascii?Q?nVoe+oMif45EQAOwnpxXAmFLCBJqCL2S/AcxsWqN6we0hZyVBO3ykiGaV7Gd?=
 =?us-ascii?Q?M2ncCc4Hgewvn7MgDuOa9OyDYTYuY29DYfHEYqTqwYKma3MsLZropei0AR0u?=
 =?us-ascii?Q?PRlcAX5dRkMnamXYSyW6gvqH+943kI1QAtMso52xFH1toWfRHBW3bzO4A/ue?=
 =?us-ascii?Q?hpnedkv16H3rI2vPK0KTmLQ5PXRVLDX2iFPiX2fjegx3naGqAWH1tzFr6+Bh?=
 =?us-ascii?Q?kqwTah6KREA45Sfckn1yqp2neo2NTNvacZ28bKWZxYq0HixkqFHeMH/d3iYJ?=
 =?us-ascii?Q?Hai1JgPItR+FYI0jAwOtj7BYJx0KqwOGkN8TIyTPfI5Ib/YxE8MiggSpSmc2?=
 =?us-ascii?Q?h9e+W5D/JxNamRwiEJZRkGxMnqENI2/MET8ESgmh9YI7EIpcm0zU5WtcQ2mo?=
 =?us-ascii?Q?mz3cfMMGAXkEIwf4hMwJsddXRR/7OyPG7yyVYibjRjli+5Hcu/WvCyFZGmc7?=
 =?us-ascii?Q?aqMTBz6KpatHhqqZC1EFTeROQuZ054Jol6dAqXMlxbIHUqjvoMN1+BbIMZq7?=
 =?us-ascii?Q?RRtsRDwdAEGrrsrNJid06uUCfeddoNcJYtcJeualCqRMqN5Ok2GowI1zZOSD?=
 =?us-ascii?Q?OzOTJyXCDJK75BHfI58lGjCBzYIk2j6wAjz9q+4nXysB5rp4Z7tqO1/V/MDH?=
 =?us-ascii?Q?PCBA0wR+pgEKwZuuv/noYTLogk7bIxWUntp1OAdxzM8NHqbAhm660JvwulYC?=
 =?us-ascii?Q?bTy3gVCrqZt8fVcIIxWvg9cORF4pSzZBJnePn79bnQjGoGpN7LW8v8Q07mJu?=
 =?us-ascii?Q?PmMQjdQRYvs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba573b1c-8d8d-411c-9e2c-08db9a8d5d29
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 17:06:55.0070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEm5gAo0V5bX5k3a14wh/y8sFDs40P+jqWUZkpiyQtYf5aYj9vKnAysBpR0ZqjIKHE0olzBvbLsjPRXqSLgnxkudPXLuGhta6C6GWGvNCeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_09,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110156
X-Proofpoint-GUID: ZzNvknZzyRRdzwWDUjnrKGr-a4v97umG
X-Proofpoint-ORIG-GUID: ZzNvknZzyRRdzwWDUjnrKGr-a4v97umG
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The crash hotplug support leans on the work for the kexec_file_load()
syscall. To also support the kexec_load() syscall, a few bits of code
need to be move outside of CONFIG_KEXEC_FILE. As such, these bits are
moved out of kexec_file.c and into a common location crash_core.c.

No functionality change intended.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 include/linux/kexec.h |  30 +++----
 kernel/crash_core.c   | 182 ++++++++++++++++++++++++++++++++++++++++++
 kernel/kexec_file.c   | 181 -----------------------------------------
 3 files changed, 197 insertions(+), 196 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 22b5cd24f581..811a90e09698 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -105,6 +105,21 @@ struct compat_kexec_segment {
 };
 #endif
 
+/* Alignment required for elf header segment */
+#define ELF_CORE_HEADER_ALIGN   4096
+
+struct crash_mem {
+	unsigned int max_nr_ranges;
+	unsigned int nr_ranges;
+	struct range ranges[];
+};
+
+extern int crash_exclude_mem_range(struct crash_mem *mem,
+				   unsigned long long mstart,
+				   unsigned long long mend);
+extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
+				       void **addr, unsigned long *sz);
+
 #ifdef CONFIG_KEXEC_FILE
 struct purgatory_info {
 	/*
@@ -230,21 +245,6 @@ static inline int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
 }
 #endif
 
-/* Alignment required for elf header segment */
-#define ELF_CORE_HEADER_ALIGN   4096
-
-struct crash_mem {
-	unsigned int max_nr_ranges;
-	unsigned int nr_ranges;
-	struct range ranges[];
-};
-
-extern int crash_exclude_mem_range(struct crash_mem *mem,
-				   unsigned long long mstart,
-				   unsigned long long mend);
-extern int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-				       void **addr, unsigned long *sz);
-
 #ifndef arch_kexec_apply_relocations_add
 /*
  * arch_kexec_apply_relocations_add - apply relocations of type RELA
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 90ce1dfd591c..b7c30b748a16 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -10,6 +10,7 @@
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
+#include <linux/kexec.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -314,6 +315,187 @@ static int __init parse_crashkernel_dummy(char *arg)
 }
 early_param("crashkernel", parse_crashkernel_dummy);
 
+int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
+			  void **addr, unsigned long *sz)
+{
+	Elf64_Ehdr *ehdr;
+	Elf64_Phdr *phdr;
+	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
+	unsigned char *buf;
+	unsigned int cpu, i;
+	unsigned long long notes_addr;
+	unsigned long mstart, mend;
+
+	/* extra phdr for vmcoreinfo ELF note */
+	nr_phdr = nr_cpus + 1;
+	nr_phdr += mem->nr_ranges;
+
+	/*
+	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
+	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
+	 * I think this is required by tools like gdb. So same physical
+	 * memory will be mapped in two ELF headers. One will contain kernel
+	 * text virtual addresses and other will have __va(physical) addresses.
+	 */
+
+	nr_phdr++;
+	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
+	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
+
+	buf = vzalloc(elf_sz);
+	if (!buf)
+		return -ENOMEM;
+
+	ehdr = (Elf64_Ehdr *)buf;
+	phdr = (Elf64_Phdr *)(ehdr + 1);
+	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
+	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
+	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
+	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
+	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
+	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
+	ehdr->e_type = ET_CORE;
+	ehdr->e_machine = ELF_ARCH;
+	ehdr->e_version = EV_CURRENT;
+	ehdr->e_phoff = sizeof(Elf64_Ehdr);
+	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
+	ehdr->e_phentsize = sizeof(Elf64_Phdr);
+
+	/* Prepare one phdr of type PT_NOTE for each present CPU */
+	for_each_present_cpu(cpu) {
+		phdr->p_type = PT_NOTE;
+		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
+		phdr->p_offset = phdr->p_paddr = notes_addr;
+		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
+		(ehdr->e_phnum)++;
+		phdr++;
+	}
+
+	/* Prepare one PT_NOTE header for vmcoreinfo */
+	phdr->p_type = PT_NOTE;
+	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
+	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
+	(ehdr->e_phnum)++;
+	phdr++;
+
+	/* Prepare PT_LOAD type program header for kernel text region */
+	if (need_kernel_map) {
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_vaddr = (unsigned long) _text;
+		phdr->p_filesz = phdr->p_memsz = _end - _text;
+		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
+		ehdr->e_phnum++;
+		phdr++;
+	}
+
+	/* Go through all the ranges in mem->ranges[] and prepare phdr */
+	for (i = 0; i < mem->nr_ranges; i++) {
+		mstart = mem->ranges[i].start;
+		mend = mem->ranges[i].end;
+
+		phdr->p_type = PT_LOAD;
+		phdr->p_flags = PF_R|PF_W|PF_X;
+		phdr->p_offset  = mstart;
+
+		phdr->p_paddr = mstart;
+		phdr->p_vaddr = (unsigned long) __va(mstart);
+		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
+		phdr->p_align = 0;
+		ehdr->e_phnum++;
+		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
+			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
+			ehdr->e_phnum, phdr->p_offset);
+		phdr++;
+	}
+
+	*addr = buf;
+	*sz = elf_sz;
+	return 0;
+}
+
+int crash_exclude_mem_range(struct crash_mem *mem,
+			    unsigned long long mstart, unsigned long long mend)
+{
+	int i, j;
+	unsigned long long start, end, p_start, p_end;
+	struct range temp_range = {0, 0};
+
+	for (i = 0; i < mem->nr_ranges; i++) {
+		start = mem->ranges[i].start;
+		end = mem->ranges[i].end;
+		p_start = mstart;
+		p_end = mend;
+
+		if (mstart > end || mend < start)
+			continue;
+
+		/* Truncate any area outside of range */
+		if (mstart < start)
+			p_start = start;
+		if (mend > end)
+			p_end = end;
+
+		/* Found completely overlapping range */
+		if (p_start == start && p_end == end) {
+			mem->ranges[i].start = 0;
+			mem->ranges[i].end = 0;
+			if (i < mem->nr_ranges - 1) {
+				/* Shift rest of the ranges to left */
+				for (j = i; j < mem->nr_ranges - 1; j++) {
+					mem->ranges[j].start =
+						mem->ranges[j+1].start;
+					mem->ranges[j].end =
+							mem->ranges[j+1].end;
+				}
+
+				/*
+				 * Continue to check if there are another overlapping ranges
+				 * from the current position because of shifting the above
+				 * mem ranges.
+				 */
+				i--;
+				mem->nr_ranges--;
+				continue;
+			}
+			mem->nr_ranges--;
+			return 0;
+		}
+
+		if (p_start > start && p_end < end) {
+			/* Split original range */
+			mem->ranges[i].end = p_start - 1;
+			temp_range.start = p_end + 1;
+			temp_range.end = end;
+		} else if (p_start != start)
+			mem->ranges[i].end = p_start - 1;
+		else
+			mem->ranges[i].start = p_end + 1;
+		break;
+	}
+
+	/* If a split happened, add the split to array */
+	if (!temp_range.end)
+		return 0;
+
+	/* Split happened */
+	if (i == mem->max_nr_ranges - 1)
+		return -ENOMEM;
+
+	/* Location where new range should go */
+	j = i + 1;
+	if (j < mem->nr_ranges) {
+		/* Move over all ranges one slot towards the end */
+		for (i = mem->nr_ranges - 1; i >= j; i--)
+			mem->ranges[i + 1] = mem->ranges[i];
+	}
+
+	mem->ranges[j].start = temp_range.start;
+	mem->ranges[j].end = temp_range.end;
+	mem->nr_ranges++;
+	return 0;
+}
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index dd115571f8fc..453b7a513540 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1151,184 +1151,3 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 	return 0;
 }
 #endif /* CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY */
-
-int crash_exclude_mem_range(struct crash_mem *mem,
-			    unsigned long long mstart, unsigned long long mend)
-{
-	int i, j;
-	unsigned long long start, end, p_start, p_end;
-	struct range temp_range = {0, 0};
-
-	for (i = 0; i < mem->nr_ranges; i++) {
-		start = mem->ranges[i].start;
-		end = mem->ranges[i].end;
-		p_start = mstart;
-		p_end = mend;
-
-		if (mstart > end || mend < start)
-			continue;
-
-		/* Truncate any area outside of range */
-		if (mstart < start)
-			p_start = start;
-		if (mend > end)
-			p_end = end;
-
-		/* Found completely overlapping range */
-		if (p_start == start && p_end == end) {
-			mem->ranges[i].start = 0;
-			mem->ranges[i].end = 0;
-			if (i < mem->nr_ranges - 1) {
-				/* Shift rest of the ranges to left */
-				for (j = i; j < mem->nr_ranges - 1; j++) {
-					mem->ranges[j].start =
-						mem->ranges[j+1].start;
-					mem->ranges[j].end =
-							mem->ranges[j+1].end;
-				}
-
-				/*
-				 * Continue to check if there are another overlapping ranges
-				 * from the current position because of shifting the above
-				 * mem ranges.
-				 */
-				i--;
-				mem->nr_ranges--;
-				continue;
-			}
-			mem->nr_ranges--;
-			return 0;
-		}
-
-		if (p_start > start && p_end < end) {
-			/* Split original range */
-			mem->ranges[i].end = p_start - 1;
-			temp_range.start = p_end + 1;
-			temp_range.end = end;
-		} else if (p_start != start)
-			mem->ranges[i].end = p_start - 1;
-		else
-			mem->ranges[i].start = p_end + 1;
-		break;
-	}
-
-	/* If a split happened, add the split to array */
-	if (!temp_range.end)
-		return 0;
-
-	/* Split happened */
-	if (i == mem->max_nr_ranges - 1)
-		return -ENOMEM;
-
-	/* Location where new range should go */
-	j = i + 1;
-	if (j < mem->nr_ranges) {
-		/* Move over all ranges one slot towards the end */
-		for (i = mem->nr_ranges - 1; i >= j; i--)
-			mem->ranges[i + 1] = mem->ranges[i];
-	}
-
-	mem->ranges[j].start = temp_range.start;
-	mem->ranges[j].end = temp_range.end;
-	mem->nr_ranges++;
-	return 0;
-}
-
-int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
-			  void **addr, unsigned long *sz)
-{
-	Elf64_Ehdr *ehdr;
-	Elf64_Phdr *phdr;
-	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
-	unsigned char *buf;
-	unsigned int cpu, i;
-	unsigned long long notes_addr;
-	unsigned long mstart, mend;
-
-	/* extra phdr for vmcoreinfo ELF note */
-	nr_phdr = nr_cpus + 1;
-	nr_phdr += mem->nr_ranges;
-
-	/*
-	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
-	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
-	 * I think this is required by tools like gdb. So same physical
-	 * memory will be mapped in two ELF headers. One will contain kernel
-	 * text virtual addresses and other will have __va(physical) addresses.
-	 */
-
-	nr_phdr++;
-	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
-	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
-
-	buf = vzalloc(elf_sz);
-	if (!buf)
-		return -ENOMEM;
-
-	ehdr = (Elf64_Ehdr *)buf;
-	phdr = (Elf64_Phdr *)(ehdr + 1);
-	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
-	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
-	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
-	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
-	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
-	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
-	ehdr->e_type = ET_CORE;
-	ehdr->e_machine = ELF_ARCH;
-	ehdr->e_version = EV_CURRENT;
-	ehdr->e_phoff = sizeof(Elf64_Ehdr);
-	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
-	ehdr->e_phentsize = sizeof(Elf64_Phdr);
-
-	/* Prepare one phdr of type PT_NOTE for each present CPU */
-	for_each_present_cpu(cpu) {
-		phdr->p_type = PT_NOTE;
-		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
-		phdr->p_offset = phdr->p_paddr = notes_addr;
-		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
-		(ehdr->e_phnum)++;
-		phdr++;
-	}
-
-	/* Prepare one PT_NOTE header for vmcoreinfo */
-	phdr->p_type = PT_NOTE;
-	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
-	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
-	(ehdr->e_phnum)++;
-	phdr++;
-
-	/* Prepare PT_LOAD type program header for kernel text region */
-	if (need_kernel_map) {
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_vaddr = (unsigned long) _text;
-		phdr->p_filesz = phdr->p_memsz = _end - _text;
-		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
-		ehdr->e_phnum++;
-		phdr++;
-	}
-
-	/* Go through all the ranges in mem->ranges[] and prepare phdr */
-	for (i = 0; i < mem->nr_ranges; i++) {
-		mstart = mem->ranges[i].start;
-		mend = mem->ranges[i].end;
-
-		phdr->p_type = PT_LOAD;
-		phdr->p_flags = PF_R|PF_W|PF_X;
-		phdr->p_offset  = mstart;
-
-		phdr->p_paddr = mstart;
-		phdr->p_vaddr = (unsigned long) __va(mstart);
-		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
-		phdr->p_align = 0;
-		ehdr->e_phnum++;
-		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
-			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
-			ehdr->e_phnum, phdr->p_offset);
-		phdr++;
-	}
-
-	*addr = buf;
-	*sz = elf_sz;
-	return 0;
-}
-- 
2.31.1


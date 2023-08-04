Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A24770A8D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjHDVJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjHDVI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:08:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1A84EFF;
        Fri,  4 Aug 2023 14:07:55 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374JCft4007577;
        Fri, 4 Aug 2023 21:04:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=5eYj+23ZC7VzOGJgW8YD6nEDB2+diEwDOwLRzF4YxgI=;
 b=xmWF7PHj+DUzrCBbXqkH/KjCf11tDxe+Wr0I4Yw+d39g+AxPaWIDy1plX14QARHd6mqD
 KXLfuQywH9qThdKw0e0F7Q+o3k6BxfyQkGH92cy1fJIcCmBYy8/6m4MCGf4pfWVQKnO8
 0Un7c3IYska07CBzcERrMwRD5o8SgOq2Nmve/cAaQkqNW7ZAyg8wW6CH130gnt710usZ
 11Uja4fZQ8YSoKEvk3fIhf+iK5Y7H9H8ciJGr4GcsG00dxgmu3NEG9F17r6fNUV+kWRZ
 JJedNLZfmoAWycZjYdjtMecII+H6+lrbhMVARt/pbS99JsW7W+3pLeCVaRNceOOmrflr eA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4ttdct8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 21:04:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 374J4Wno029410;
        Fri, 4 Aug 2023 21:04:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s8m29nq6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 21:04:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LU4fzF26BHZF1rmXc6dRdscfdB5M7IkfoS5onv8xbho6wMh2TEuwMxshEnPB0F53/ZaZlZkRd5JmZRPnJC6yXurTQIvhQGvvclQAWDfOWE6E446t7qsOFNjLe+Jkt7sTG5U5sDQgpky6tqdn039sbi0XOf++paDcHYSs9UVnmebMoPjLOFojAmeAWVAjTwZjs7amCyYMFlxulhcIIRbj0wxUHxwZCP6TeBdxEF1T8r0aAlED9WEvTNAl1uE5r/JjdBmOkmjMqxHrCY7xbW5rc9jFGKTJNCG8d4I/AaPWtNDohSQw6MleCNLam04nGSUl7W0gRopC960dsRchojKFdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eYj+23ZC7VzOGJgW8YD6nEDB2+diEwDOwLRzF4YxgI=;
 b=ZQhoLGrag9A0Z2wa0jvDzTgJy0jRq6OMDrSIH67Nk/EtsLsLSy1CLezjlpYJhtxvEU1fEgFFONGZBoB9oPNUsNBZHvtdX1FROPekxx4QFy1zvp4iFqWjycOh1gWq3CPjguRycKwFDItNNKKd/fkpVBuX8pZarIV6QA4Gj8wdWhpITPGcQ+q/SkZM3QbmFfleNf1dSFfrY6794qA4izCLb7OTgd9KdbrnO73lR35pvF5C3ptodhyTiyS8LnLekBXbTfBaUO7ZVXGpwTdOAHYS+OtA+GMuw59qKZF2Hg+RP3NP5WhMFGl7hmh0Yrj0UcOeHRCf9c+8PmaN5Hpy0KrydA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eYj+23ZC7VzOGJgW8YD6nEDB2+diEwDOwLRzF4YxgI=;
 b=h74VH6nFQCCiBVxw9H66YGey1yUMfeDNhdZFJnB4HnkitmjXg63Gd4YrADSKfTE7DCvuMxrNDqBd0+dLN3DHn3anOfDcuo+oOd0eREtg50NF5vhh2pKOSRQCGDNTSLmcAPJ4Ci9TJfSf8yvFkqHR2/IoBv5cTbmI4hLC0M8N6gs=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BN0PR10MB5014.namprd10.prod.outlook.com (2603:10b6:408:115::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 21:04:10 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::9a1:a343:e04c:5150]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::9a1:a343:e04c:5150%4]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 21:04:10 +0000
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
Subject: [PATCH v26 1/8] crash: move a few code bits to setup support of crash hotplug
Date:   Fri,  4 Aug 2023 17:03:52 -0400
Message-Id: <20230804210359.8321-2-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230804210359.8321-1-eric.devolder@oracle.com>
References: <20230804210359.8321-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8PR12CA0048.namprd12.prod.outlook.com
 (2603:10b6:930:49::11) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|BN0PR10MB5014:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f09b0a-fa43-46fe-e8df-08db952e5954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1HgXG/2jZRuskRLs+lGQ3IH32sgEZiwLHB03C98M86XQlz/NVGLSe4hAY/0QLhE7edE7kmpbWm+4dK44vovdma0MKII3HnAQKNYJFVrKJWIeIEOdQFez3sVUKPdTqTELRDnzyNM+7fiqcqiPrURGOekIhpEMRvgrMhxz+lLyvJdAcai/VwkzuWh0+5YFBJTGuqtj8DHFPKZ9fPjkV9IMw+E6Q8lSV+iLHJSAm0Fn2xFC3M32F+hyPDKQgUHhXFmG/fHVzyRwKmCtLSAyHwRPN5FAKFRR16PnAX2SyU86i/L42GTkquUdnn0o9lY02GTWfJMTtOLjT1TWwVj8frEml2tcAXpagEc/56iQ+TNo7kTmA1pS5DNfG3e5n/zVjAqpeBIPqW0SzfhBXAFc1DYMOilW4Dsd/hyacs+zboOvQuri8WTUXiW0xxPh9onaqMa4kOgzpxW7gNt6kn0wsgZu1WmhLnimq2xOCyCysCEmmwIEqKp3g5H7bE/XTwxAcxQO8jH4oU1TDwadVDpAdnla4TQF3DD4+gCLDSBED0eRdvt62JhjgT/t8rme1+S9d48MBNohU2mDMD4+khqaIsh4k82wcaBHQvILJGu70fLHw00=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(366004)(39860400002)(136003)(186006)(451199021)(1800799003)(5660300002)(7416002)(7406005)(4326008)(2906002)(66946007)(66476007)(66556008)(30864003)(316002)(8936002)(8676002)(41300700001)(478600001)(86362001)(6666004)(6486002)(6512007)(921005)(38100700002)(6506007)(1076003)(26005)(2616005)(36756003)(83380400001)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vN4IXoErjb8mvhwd+0E0oOrRlfwGuGRf6FLyc+tv/IaZ3B0wtg6rNlS5/S4i?=
 =?us-ascii?Q?46J9ngJ8jlptX4o5hi9byoJe+krNV0+1JisDhnmvn0wigSXDZ7h93z5WoefG?=
 =?us-ascii?Q?gA72S69T1KGXPODxmRukL+Vf9TeYpPL1arHYZ01pGtchcNlcU2Yvc4tk7cqV?=
 =?us-ascii?Q?1dnQ80ByTdb693Vjq7LzLI34Yl13c3c/WGYbzvm7hozb39zUFEtUJnS7MfHE?=
 =?us-ascii?Q?Z9aFLTLSR+JVo8TgBgOm7GGJTrIn9i+zsLqZgLyYceNTN6ORW5ofV3VHbplV?=
 =?us-ascii?Q?0965mLNOqEA/5jL1IG7PwUD/CsUQEdwTQdYpa+8nRsEOmZF/N9xBB0Yiismw?=
 =?us-ascii?Q?FOC6ENcVj5+cKszYMoaw9XpcfkBOtSVms4XK0ETIyCXSzqRnbBIdwPcDPSYW?=
 =?us-ascii?Q?pnc5f/HYvpUsorkRbRhkxFlYaAemX2kDZOWpB4nDJCl0y9sqTU4j9Mi8yUhz?=
 =?us-ascii?Q?yK67KYyp5o7njsxDP76jTplqaupfOL1MNiXLNbNowdm5yVv6cTn0FlRPY0CZ?=
 =?us-ascii?Q?fhbFsD6sCo9nVzlmjgd1prTJWPs6P14kQlAYX0wl6hQ3I9a6YqN7uFDTtCJD?=
 =?us-ascii?Q?eSPX9XlA1r9rNPEHf1YeFaGTqQtdfDPydo82YWGDiXuXe6i8c660P5ExuNB5?=
 =?us-ascii?Q?3mTiq63MX6SXew3AqboRrEoMkb9zdpoo9q3PoFvRdEkLGpTvjxODtpO0O7CY?=
 =?us-ascii?Q?K9m5fSfW1O8QjshBjuW7MrulLMgNcsp2STef8D51tEGzG/bRAS8tvqfLfpFs?=
 =?us-ascii?Q?/tn1Rmmdz08ByMBqrQYl7VoJLNp2CKEBcNdhXEhfaQBoHsGDZ35vy7439c3z?=
 =?us-ascii?Q?OwnnQC95QLeV75CLFZTriGWQ3BZigPQ04x366/3g7lmmF6rgmNJoTbx8dYFg?=
 =?us-ascii?Q?7cRP6VRmSMoKCVZsxCMZhUlP0KwIr5IvUtkOt8fG+nkKLqCshTQ8Vqbh/jva?=
 =?us-ascii?Q?UiBVN7Yz3hUJN31Iznyoj44fxLN/l0TQ+Eyr01bRUfqJuii0OLMDf/6+v+Un?=
 =?us-ascii?Q?Igg36dbhlT+CYjwBKF70htQzEYDfFgOiNd66ROr9YIDjjVnc6Ha2reyrKfMt?=
 =?us-ascii?Q?9yUvZJi1x9GhJAEM89xRA8Ny7hiQqhQ5Pzw5NUIqf0+ptsC5gmw3Gb7OLg3D?=
 =?us-ascii?Q?MgoLiRFmPGQ7A+naLttEL3Pw6mNYpQ03YBeJSCrMWq4MFZ0/mWKvQrDZqQFj?=
 =?us-ascii?Q?z3WStYQXZALYpE2+xD3BYx006OEHkq3pdp1LjigmIoyX2B+DuPJr7Gg95fju?=
 =?us-ascii?Q?lTQZsTHCil5FIexp9EPaNBZkgIGeE1syE6I+N0hcQ7R5PprjzDfkV9XcXR7H?=
 =?us-ascii?Q?8J0Aa2+uUwGII6dpQJBi+NzcZqAJUimMq5UtE4xW7ZqKrG6jF+7JjAJEC5PO?=
 =?us-ascii?Q?Q2uyP9PxgH8kI2LfLIKFqv+tAp+BB9qvHQKk3Kvz/U1lhHHaER9Tm7SMgbz/?=
 =?us-ascii?Q?tM0Elt2NNvZGK8vaGfMxJvKGUJ9KZQUo8S8bkG8xMfu+3UCCZ1Hre4CZUGt0?=
 =?us-ascii?Q?QzS3PLyXQO3mxX8xRqxX89hgDROkPB0EN+LitR8jGolFd8goz+7nJFBTvZCt?=
 =?us-ascii?Q?wpHAe1kBzuEAUQF1P7YMqZg98zxaXBSoZiV8z8fC9AUnDkbeQ+7TOtjlB3C7?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?mMq3I1Yuk3OqpCP8X2kRawkJ/sKxTtsD+MXDhEtFHE4SPbbcDcYeQST/vwW9?=
 =?us-ascii?Q?Xr62DOMpn6NE/FLN3N1rNPHm0S8FdHe5Fn57Ba/iP3IM9k0bL4fJPsuB2KHZ?=
 =?us-ascii?Q?qBeEZQcbJpZDPa+KqE5Bu5+wxG8o6vMp1dv2ENbMibKoMIYXA8ZZTcAQBzQa?=
 =?us-ascii?Q?pTu/hVrNviDHLFOAWD/ugJVbGXIc4jV8nTg+i1m6sPSxI91wMzHMHGBc0Eyz?=
 =?us-ascii?Q?eaEJGKkYvKZPqOzPzie/WEa0jmCtGJc2zQxOF5D1LVgS2wpDEoHA3cId97lE?=
 =?us-ascii?Q?c16lzAyGbEb0GflzjY8V+Px5N41AmCoE9CVRCX6llK5aEJNBIav35/37PM8d?=
 =?us-ascii?Q?zKfIBEHZMBb3JBmAs8gUw04JTcd40hjT0ftzzvLOENsVehGIJ4BmyIbpG3mr?=
 =?us-ascii?Q?JAEf6Zvi6MSgrP/fpSR1QUu4x9XMEdv2HTilgXy0PyxSZpSx+wo+ERokmWeM?=
 =?us-ascii?Q?CjkOaewpF6fG/TP8PJhQctslp/Y3PS1tujoBkxO3+PalbFxsjxslOoTWEIpF?=
 =?us-ascii?Q?Q9vmbsVUoZlMjRZ2hFSwGOqtpyArzk4wNo+As3SRtxWkBcJ9KJqAZMpy5DsO?=
 =?us-ascii?Q?O3Nuaop37FRkIGWvD3bnEbC9Q/e1oZciYDOkT/WcHipYinptazUXE6Uw3biP?=
 =?us-ascii?Q?ebaemIZvu1pgoI2O4VpNfOuPKb4+L+nQPIQZZWUfUdOY2KNgD64olel35X1t?=
 =?us-ascii?Q?X9PwOiedpIs4v48yS6Fnsi+tT8u81zfkY2hd8puBZjSl0LMBnR7/tF1iHWVq?=
 =?us-ascii?Q?RgYrUX0QSxtNhhlWD1ObA8XVcqzIxWA+t1zFeaMHQRhvm34ELR7Ic6yT2hUj?=
 =?us-ascii?Q?nhDjHyxLxA03nT4TfL50uFTJn/DdGoycrFu0yly5oW7rN/snaDdZLpv9Vvmn?=
 =?us-ascii?Q?bZgc44q+EFENLSGrpOJcbKe6nSMDkkzZj1TjK5vGu3kaVN73qai6gz/Rsdqj?=
 =?us-ascii?Q?O9URewfuQVHIQq4+Bq45Ii+FxuYf+JPrHrg2Gi2MW+xp7u39DlCcTXZ/rdAO?=
 =?us-ascii?Q?0s0cY9kZu/tOeNdU/Mj8uleW+E6YZOttHVtSmmBgzOo3ayiDzAaVghRFWfyJ?=
 =?us-ascii?Q?clViA6LLblqCslxla2Hm2xH9J2sS3S4hF6HK0kiXmSyxVHNAXcb/MaLQGfs4?=
 =?us-ascii?Q?ZOan1XO1cXBO1vkzOYl6PyiX2vBWTOh/63c2CvDuRZzvftSc2B0lJHU6QF6m?=
 =?us-ascii?Q?MlM6a3gpgRu/JBGLIbaVMm0H8Udegm+1YD338YdjoStn0rCZK0HPf1Ggq5Uu?=
 =?us-ascii?Q?ntxTx6HM493wFg8LadI5RLpQvzUqYyVusBKmKn0YMKrP66iazgfRUEHaG9X6?=
 =?us-ascii?Q?WzFKx4JBAcUS6him1a+XqWNHiPBDdztmGgl9sMXQs4Hq8qz3TwWUuGSc4Pif?=
 =?us-ascii?Q?GxByk9iZRMADuuaXza0HOJ/8EjqhsH0uqE7K7TVFM8c13eojeVqrufOkrWG0?=
 =?us-ascii?Q?hgCsvxOkFew=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f09b0a-fa43-46fe-e8df-08db952e5954
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 21:04:10.4994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O7uUjUWouaIPiAMqiLUJSpQyIcqQhgSC9EyVoon1V5i2K7GvFJH7RfD7ERhtBUVrVi22kKf/vZ7VGC+6Kbtjpopy70hPnAbfYJp+7rIJU+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5014
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_21,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308040190
X-Proofpoint-GUID: pBZEDHZL7xB3BuozkEAhD4EHjfZXDEEt
X-Proofpoint-ORIG-GUID: pBZEDHZL7xB3BuozkEAhD4EHjfZXDEEt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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


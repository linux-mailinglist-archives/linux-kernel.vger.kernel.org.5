Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454437E4B66
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344255AbjKGWDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235366AbjKGWC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:02:58 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3983E3255
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:00:27 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJqic015022;
        Tue, 7 Nov 2023 21:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=LcTgexJPyuQPcOmH0Fd+Kj3ZYGZ75rmxs9CVuGAoeCI=;
 b=lLX+hFAeJhz35CtEoFcb/aMQQYHaHDSUzfF0RuNBdaXOvrdaWw8odKtDWpdFNTVgJU3x
 EKENUdDlp5DYqjNGNgxH70KUAzRq2BPsHW6D7bR9ysED/Kv1Fqb8oj9vMPuKFHOk8Obz
 CRPVOhLyFqR7I07dQ8z9hCZn6nGkbdtd2Y0AXk2h8xJ9XhrrESGhhKTiGtpqUzHSsbQq
 fATf1SPyhcPAld2zouQf1AGiIcDyHyYsNdf81EsLSLpqnOGvOJuqTRyI+fBCXrjCZbWR
 rOIZ3hpdre0GnCeba+4Q7YCosIbSXBsmjBmvFqrhINprJZD2S+TCU7oIsgtGO3f8MoEx nQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w26r2ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIoFp000377;
        Tue, 7 Nov 2023 21:59:18 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1wsksb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKwbnC15dgiDyd03FgZI0Qjj69U7FppFT/oWjjkxKDFOZUga7cO7rJm50fSj6U/6UHO/RMvy/eNgl1JxQpaiRb/Jh6S4y/Tyteqs9fju3PKRkrroeBDGrfgu7apWktOHhmPiINpoOyd/SwLcdVHyono6EXZua2+SsSUVBGePSfD3BiZKYKGNIdL86USgY9NgjRcoC0UEQfGUSFyq+h8drOHOQl8puL5y/06vR7OQu8NdSMRBDkwgx/nTY7hqQrZwehLs2plx5e8eSb7uh74YKUo8JhaGLEiu0VCNwOmxv8m+KWwNOM/f4c0o31DO7jQAX7TI3hax/5kL1m6ANrhG8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcTgexJPyuQPcOmH0Fd+Kj3ZYGZ75rmxs9CVuGAoeCI=;
 b=GBkTPLJOcKGsUhucH4sOg1/79UjmVD5Pi3n8H6GCHJKM4cCzuViVYi0HAjtVV/YO0zkohiVmW499C1fG23tMr94JwfqKtiAoeMOFf1SeXnjSftkXwL9N0PZ2Pmgr7F2U5cOr3Wpmd02uuRWoBNlju6McsejlhejAHgEhVTCeJdoWPjv9LgJvJkeOtc0vqAf5/Kww+LwEd5SAjYIMMVVng0agInw8fQ8BDxZae88DflFq4iDZDgfpM+z/kM/fDjp6wBr885lcJCvAAhH+RKzmb6trChEK9ck3Rhu0N6YjC3T1ztlJL4dg+2dUf8Z94AARgAtVpEUqnJdH4HQpBaf1sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcTgexJPyuQPcOmH0Fd+Kj3ZYGZ75rmxs9CVuGAoeCI=;
 b=Scz+60d84k46+QtmwXWxmiYHvTsgcUHxoGjNW8/L0Ti6Yub/ki/PhmkmhOYNaVnyqNW8A23a7FgLMD0X45fRSzRGrYtxoGxU1llxE2cqV1h+4INW7y0/TtwIZQrYbuLZ9Wsvs6OAcSp3vO5haqe/GA06XcCS/s8oACXbnIRlch0=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY5PR10MB6141.namprd10.prod.outlook.com (2603:10b6:930:37::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 21:59:15 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:59:15 +0000
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
Subject: [RFC PATCH 30/86] Revert "preempt: Introduce CONFIG_PREEMPT_DYNAMIC"
Date:   Tue,  7 Nov 2023 13:57:16 -0800
Message-Id: <20231107215742.363031-31-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0017.namprd06.prod.outlook.com
 (2603:10b6:303:2a::22) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY5PR10MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 768ec85e-8e7b-486e-9e52-08dbdfdcc86c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uMGXLepc3HQOfbv1ykBcBGEO2se/ojm8vHqgq1SqxKCS1hd0XbgYswIEAFkGqrSBIFmWpWJUZQ0ZCixzPJn39Gvnj2cBpkb3zb5dM8V3eCJfLAWy+Yc+TPSM4f3Mwb/3bczha5QDWpxJ9lqImyGh+p+IFjfAgvhNELaEl/5biDGa6wQfJBLRx7nnuh8Yji6cl5P+SDwaoFS8By3oIo67UQca+m9TjCsBD8rEKK46MjFalPv7QIqm/9VTvsw0T831vCt4MvHJFvKTWgAPExWlTR1Q6MNFivcm0X5YsCw2WNMDWPK7m5J8TbDxHzehjwRRhudQNE9w6IuEJvtlNrS8bsBdA6NOM9h/Wtky0hN/Mo2PNfzFosGDPPk9uhuuIlW/WV+6ercH8f7N5xV/+A6bYnwFkP+TDfAGOkIBjSn/QSZUe74KKAMppaFTItq64Ka4+g1dYJP8sI3f2pe/Qt8J42atWW+B6qgal7pMqJNnmSw9NAX/jKmoHSRf4dhe+q5bsUuUSytVnx0yvM3Tym1Cz3Tiuy7bJPXxC5ln0DxPhBvd+VtK5pW0yWVa9suonK/P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6506007)(86362001)(103116003)(8676002)(478600001)(8936002)(6486002)(4326008)(38100700002)(1076003)(5660300002)(36756003)(6512007)(66476007)(6916009)(66946007)(66556008)(316002)(2616005)(7416002)(107886003)(7406005)(2906002)(26005)(66899024)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vkZjPl6EjXh0yHXq57VgbyXufjA+NPByf2MRSf1cG/mJg/3EqIBkQGrVpUzM?=
 =?us-ascii?Q?nuqaSuA3wwi2He168kylo7Z2eEeKbMHuB5NlDmEK7GSSEwuKBWP6ee9oMYnN?=
 =?us-ascii?Q?wUAn08oukJ9HGXguABYvxdv38HIisJk2pn3P/s4lPMVROmQcNR0qIIjkEVPM?=
 =?us-ascii?Q?Ptl8RJXAiFYeAKHkp7phj1uv83ffjqGatQPaDZN5HuHz4zg0DJ4PPVjanKX7?=
 =?us-ascii?Q?za+YTKN+kezYFpWg0CJxji1oBQ2gtoJqENH5Xf277IKwksb8HGKuBViE3fbK?=
 =?us-ascii?Q?r0as6SkoBo2UfC8TgrNPT1xOo6wiAu5UY0w6maD/SIYwoze5NbFlABx7e/A+?=
 =?us-ascii?Q?Z77BgO7kKS4mY96TmkRrIYPHyAPMlneHAcDxKvmlGE8+ZR63vre/hCWtR48Y?=
 =?us-ascii?Q?7C5ewCa/r7MF5L7jgxdzozy+UjzpIn2tKTpnbXsyPPho9PCKnAIAhVIBtm7N?=
 =?us-ascii?Q?d7p3Xl91rT8LcwdM400pu3ZY5xa5/7iI8B/nn6bqTTkU+A0Pn6Xn9Duwe+K7?=
 =?us-ascii?Q?rtNLwUW46RCUHQaeRPYGNJjo4PuOMMdWMpv8k+e7M9UjNQZTeMnPf/n8NyFO?=
 =?us-ascii?Q?oMQOv+kxRZ3RdAwC1g3CWabAztb88wTlKNEUmgJoqH/weNicz3+1LCErKM+o?=
 =?us-ascii?Q?vJ/SP1n4FR4DghENcRwb/42eOODKj4UZ9f19splpjX9hJZCn91L+/voqurPD?=
 =?us-ascii?Q?wFNbBfcBXa6EN9WH1du5HVSQUBC01wVTIDjmH6P94LinufP8d06kvUGlx9pD?=
 =?us-ascii?Q?EnuxZqfcL6ggV9bzEDwxRNQee/RIFFYItgivoo3pCEl/e8ngq4W3JAjYMgwA?=
 =?us-ascii?Q?Ef2IdRkbHvwvLVj0VYo0rfuV8HTK6GM1cR7OmfCJw92Jcd/RVhmugfJUA/Z2?=
 =?us-ascii?Q?R0Sp+ZmANR0QbOy6ABGfnbCKvMomTP0ttLrGiV49cv2SRR8F1dz90wOa36un?=
 =?us-ascii?Q?uSyH92iA4xkpvDDZRCbEEK0GiExaMPpqa4vZ0wHo0JX08KRLT4rsCVOLA4sb?=
 =?us-ascii?Q?0ZcE/qoxsBCtA/auEvcnuQWKbGCdEIbQKXO4ZdFQDvBTu965AkpHBwuq4Ldn?=
 =?us-ascii?Q?Y9GLGpFNgK8xdYm95y3xxfeEtMgV5Z0ncLwOKi3wUGViAr3ezy1mL2a7813C?=
 =?us-ascii?Q?NpKHK2pakHXWeb8iregbF3mMQu/Ir9y52KT9PzP9cQQkKpEW/HgBepDjdGfg?=
 =?us-ascii?Q?hFlIvARhk9nCIm7I3+SdBQQ6vuZrSyk+0R+XYE2v8SizrsVzXGkaLmMCHnee?=
 =?us-ascii?Q?wEQDagg3ow8TF4mlfo2QvxsXuifprl2Wdl3LrqLU21heWZoik7q1EmGeIo1J?=
 =?us-ascii?Q?a/It1B2OkkcBkMryms/wwHe2id/QMHhGW0lrpVZhwC57XxG2sjlquBlk1yr8?=
 =?us-ascii?Q?oCz05wjWpehlEnh68XznU4+4QBPHvHy9LYUqabZefiG5bOAenh3MVYIbnVDO?=
 =?us-ascii?Q?ukxwCgHx0zCPOuqpSBI+tVfhfx0fp4coOU+eaN02/lmG5Qyi5L2RFUB+pBoU?=
 =?us-ascii?Q?qx8mO2W+H1hWN4v/QbRZjW4rwxKLVvP6+DiK67/YB1D5y3+W4RZe9afSmp72?=
 =?us-ascii?Q?noNE+PPtMZn62PIvxznK8/+xdvhDNJbO5szG7aDqG/JbF393NqzuvUiDWo1R?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?AaFqktU1PHwxdY70N/k5HYIESzipudCGIBPYAushbrzZJ/slymvNuW4W8Vf3?=
 =?us-ascii?Q?AO1WlMg66IxGqjByjLBbC3SEIV85Ra6rFLjY7nYrl1K9Jf4a2ooc9GZuWlMf?=
 =?us-ascii?Q?zFBiye1O+h5qQ/nKf52U5LlJGsYh/egKLH34gY4HUdxKOSU615UJgqWhPTx6?=
 =?us-ascii?Q?gPIo+8bfli0OZV8WRlxCEbs7mfu0mGE2/QxWhkxZs0rtQ7Epziq73RZS2OrQ?=
 =?us-ascii?Q?FNUhXV4DO6oGnu6TCBnzv7smnL0SQAV6jf9aZkCA208DfJsntcTy35Wvajjm?=
 =?us-ascii?Q?87yQtPSYS0G4Q50+3SHEn4GbARbaGcwOhZiybc/TcW7eSd+5iHTsPxzl/UV8?=
 =?us-ascii?Q?mBd/VF4RxU5tyPUwoMfHojTEDInLLdQiFVxbBNJCb80W/3cb+2VxWbKRHShj?=
 =?us-ascii?Q?wp1Bm9DhYyLUkVSrqxBhgIaHj38Wr67IreSbMTiC0QqajKZZDmDOtCVQuNRD?=
 =?us-ascii?Q?ZY6Bm8+PVyj4uPJCv2WMoHHbrXy/tao4rkGDfUCrmR8kUGuM7cuDn11WynPL?=
 =?us-ascii?Q?qdRH9vmXnBSAKuu9eTPBgoj7PXG8v7Q2t9IZH/dlkbl01bnJQ0MLO01sg8mC?=
 =?us-ascii?Q?W4NZK5KuBTd2iEC4Neaoi+86RBmpo9vkq7VMXFmuKL8uOz5gcupv6tRuB2mm?=
 =?us-ascii?Q?AirDlfEHJDkHBX0FDLrTplz52xceb5zayMNsxQ2gU9QcjsagMP1FNYMkqIxJ?=
 =?us-ascii?Q?0EG5oVG+HoRmjS7zbbjxFOf3PRWIQ0OHrKSi/g81s6DtPZ4wFe0cxX3bQtOB?=
 =?us-ascii?Q?evoHf+pJovv0KetXQBNhFCcP7zcMJYOZ4aERnS6yXq99GkpbQ3Z5OJba5AjM?=
 =?us-ascii?Q?RTWGtKISyAqu+cq3HMb6m22h67TDEOzT3pC8OwFyyGVUP64jqI89kRLkQWi9?=
 =?us-ascii?Q?+kJRwIxvyg0DVd8QcOKy11W9CJw9zv4Vp4YlU6UQhCRbCMBEPlLVosv6123J?=
 =?us-ascii?Q?QaXpzayuxqFkoCg8GO8esLesvgw0GoV+19pw6pdje1+Hw3Gaamd0bkKQav4Y?=
 =?us-ascii?Q?G93JgroTAG6Km0Q+MEKQbLw39cyK2rwLAwGX6J1gaeuOnvS6QmsAB6VlQ0wk?=
 =?us-ascii?Q?Nm4bUQqnflbywLm3SZmxUDfjWYK4gZCEN19bLwZ/FxN+9YUNYscjC+eRFQ4v?=
 =?us-ascii?Q?VjPTvwbErGN/OIH4/G6YwsKDOuOaB8lATdIw3yq3fHCNSr4S7Ih8kEBvQmw4?=
 =?us-ascii?Q?X5Dsf/74PN2bm6GbMnUoE22jU0qC9jyDDi+lI92ZH36R9bSYzrRg1nQ8JBbP?=
 =?us-ascii?Q?fnouHKmBmB5eeL+0tFWgi/0UtKcgiBQRbAkOXkfGE8Ub2UbbIcODHckUpVc1?=
 =?us-ascii?Q?ct3zfJcrX3yIMoeM+1m7irXLyArMaOA4MNmTNF2FR5AArWHRYM+rMjp6OOJK?=
 =?us-ascii?Q?iuLhkgz67Hmf0zYbpkMyFEtyiizNXcH20FY8SnNK8poF79qHWOeO/w4nqHFu?=
 =?us-ascii?Q?wO1u0NvBvFoteth93WOi7W78FFeu9QtquLXQS0ZpsdWSxsRXLjjHTS7QWacn?=
 =?us-ascii?Q?1hrSBp0YKpw/FyJevG9SF3HB+NqC4AvG8c0KYVptQKGEcrcCvuWP3wYkjA?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 768ec85e-8e7b-486e-9e52-08dbdfdcc86c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:59:15.3430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMH/Xcuvqw4kwJSlyFG9csJOThlP86yzUr/ROLRvFVu91xQCfvthCgYTXAq2MvYtx+XM27jnBoQQSYlEwDxILbHL9CpuescWGq8vH7djXSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6141
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=453 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070182
X-Proofpoint-GUID: H18O-wWt9i3kyHKp7hdql27CqSflnLOl
X-Proofpoint-ORIG-GUID: H18O-wWt9i3kyHKp7hdql27CqSflnLOl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 6ef869e0647439af0fc28dde162d33320d4e1dd7.

Also remove the CONFIG_PREEMPT_DYNAMIC guarded inclusion of
linux/entry-common.h which seems to have been missed somewhere.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 .../admin-guide/kernel-parameters.txt         |  7 -------
 arch/Kconfig                                  |  9 ---------
 arch/x86/Kconfig                              |  1 -
 kernel/Kconfig.preempt                        | 19 -------------------
 kernel/sched/core.c                           |  6 ------
 5 files changed, 42 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0a1731a0f0ef..93b60558a78f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4577,13 +4577,6 @@
 			Format: {"off"}
 			Disable Hardware Transactional Memory
 
-	preempt=	[KNL]
-			Select preemption mode if you have CONFIG_PREEMPT_DYNAMIC
-			none - Limited to cond_resched() calls
-			voluntary - Limited to cond_resched() and might_sleep() calls
-			full - Any section that isn't explicitly preempt disabled
-			       can be preempted anytime.
-
 	print-fatal-signals=
 			[KNL] debug: print fatal signals
 
diff --git a/arch/Kconfig b/arch/Kconfig
index afe6785fd3e2..05ce60036ecc 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1393,15 +1393,6 @@ config HAVE_STATIC_CALL_INLINE
 	depends on HAVE_STATIC_CALL
 	select OBJTOOL
 
-config HAVE_PREEMPT_DYNAMIC
-	bool
-	depends on HAVE_STATIC_CALL
-	depends on GENERIC_ENTRY
-	help
-	  Select this if the architecture support boot time preempt setting
-	  on top of static calls. It is strongly advised to support inline
-	  static call to avoid any overhead.
-
 config ARCH_WANT_LD_ORPHAN_WARN
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ec71c232af32..76e418bf469d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -270,7 +270,6 @@ config X86
 	select HAVE_STACK_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_STATIC_CALL
 	select HAVE_STATIC_CALL_INLINE		if HAVE_OBJTOOL
-	select HAVE_PREEMPT_DYNAMIC
 	select HAVE_RSEQ
 	select HAVE_RUST			if X86_64
 	select HAVE_SYSCALL_TRACEPOINTS
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 5876e30c5740..715e7aebb9d8 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -40,7 +40,6 @@ config PREEMPT
 	depends on !ARCH_NO_PREEMPT
 	select PREEMPTION
 	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
-	select PREEMPT_DYNAMIC if HAVE_PREEMPT_DYNAMIC
 	help
 	  This option reduces the latency of the kernel by making
 	  all kernel code (that is not executing in a critical section)
@@ -82,24 +81,6 @@ config PREEMPTION
        bool
        select PREEMPT_COUNT
 
-config PREEMPT_DYNAMIC
-	bool
-	help
-	  This option allows to define the preemption model on the kernel
-	  command line parameter and thus override the default preemption
-	  model defined during compile time.
-
-	  The feature is primarily interesting for Linux distributions which
-	  provide a pre-built kernel binary to reduce the number of kernel
-	  flavors they offer while still offering different usecases.
-
-	  The runtime overhead is negligible with HAVE_STATIC_CALL_INLINE enabled
-	  but if runtime patching is not available for the specific architecture
-	  then the potential overhead should be considered.
-
-	  Interesting if you want the same pre-built kernel should be used for
-	  both Server and Desktop workloads.
-
 config SCHED_CORE
 	bool "Core Scheduling for SMT"
 	depends on SCHED_SMT
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5a0bf43975d4..e30007c11722 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -65,12 +65,6 @@
 #include <linux/wait_api.h>
 #include <linux/workqueue_api.h>
 
-#ifdef CONFIG_PREEMPT_DYNAMIC
-# ifdef CONFIG_GENERIC_ENTRY
-#  include <linux/entry-common.h>
-# endif
-#endif
-
 #include <uapi/linux/sched/types.h>
 
 #include <asm/irq_regs.h>
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2147E4C97
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344430AbjKGXNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbjKGXMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:12:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7630E25B1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:11:01 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJl4R004882;
        Tue, 7 Nov 2023 23:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=tq1zfiB4GDrADd32Dobq32ENEB6+vmdJZsjvmxtBuP0=;
 b=Www6Nr99Uhvw+7rllhU7Yp5jICuS3pHCT8VqVxFwN2YUlcLgTttPA8GOQDRMvukDHFeC
 Q8reD7pb7zqnEd7PMK1rvucuZVi1NJcmhxXAo47Xf4L6zU0lkVidYpty/rZMSt4CiVJa
 DBX/orgV2rbQJXHzQCFUwvrUh2meVMILBiSVIbjb6UlhEYvJjmZdPSEUJ3p1aygqwkHj
 PkPAhgg3G+9FYPvIazV/IgPfeGLqfZVpjEW8HMsl7ksNz7a/qrGNiNgbb1TtW8Wanm7n
 mQOApqDE+W6tdIACyQyjtjZhK5RcpuMOyOrH/rWjVTL15BeUF8jCg71lVdQ3HeeeeNLd DA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w22g6c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N2CYQ011114;
        Tue, 7 Nov 2023 23:09:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1tvajt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0fAyMci7+3EakWL4qP0aIBCmfVvEkf7SwqPGa9tm0V8VQI2/b4FalMO/tGPOy1fLMO78ZrFVVDL0mAzfmMRWEuYv1Rprn2gXZJPuliPROeNBwopYVAxUMnak5RJOt+XqvqkXYIL7GAxrWIALFngXlcG1L8KBpyuT6WMZaZdi1dSc+ZIa4IsfLRgU3wX9drid4kdDNTPgcxNjejGbfqOCpOegCC9Vf9JLrl5aiNHwPyWUigKhf+fM+3JXh5vTWas05HkuLED02GW1/8QQZ5okMFlxH91zoKnyPGFf01pZEtCOATT+iL989CnNnkQ+Oq8S/z+fMeTIGqp6Sh3w6I/XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tq1zfiB4GDrADd32Dobq32ENEB6+vmdJZsjvmxtBuP0=;
 b=NNAS/rhai4FS3amuYXQ1VcCX4vOnPnCemhKHxKzL2+FM2SJjNLAOEPc/WFTzT+rZmbQXbd8Zr+xnfxxb6YmKBEtPJ+zniR9DbprIj6qS71qwjP7W1S4PgYW5XrZ1ZV0J3hOht1Xwl8LJHKjim/U+Lra7/TX/UvRSiz+udHpl+9TyU/0IdA+/R7NkeDdfea44htIn7P6T0SboHU/1iIO3strUOzu55JNYWNUiYSVN2B/Nzm9RSk6L4mxvc8fwa30OGKCZw9EhLYxEHkN+qLnu311SDYstwTWiNKAhH/Mmie+ld/M/4fjjzzxR6Aj0nSM3XyklprR3aune81R7d6p3aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tq1zfiB4GDrADd32Dobq32ENEB6+vmdJZsjvmxtBuP0=;
 b=souTidh4Rmk/fOvai8bXm4HNJwdQBllrr7fdcZ/S4SNyM/b1oJpvA2oOfs43i+15VMlpyVasXCUv1+C1l6lcTZJ9IfG9YFzaEVuvAOb/sa09zo4OUOl3NHSJOnyuUWori8eaACtfUt5eYzrWckAQ7K1pZjaSXqoSYuSV7zopYIA=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 IA1PR10MB7261.namprd10.prod.outlook.com (2603:10b6:208:3f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 23:09:52 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:09:52 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [RFC PATCH 83/86] treewide: drm: remove cond_resched()
Date:   Tue,  7 Nov 2023 15:08:19 -0800
Message-Id: <20231107230822.371443-27-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::6) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|IA1PR10MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: f34de6d7-050b-48bc-eaed-08dbdfe6a60b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IJbQ6QvghiESUH2/hQ9+av35ukOOyeyFyaOUiHTHKjDPrYSc6Q8VzARXXYCAkfWlhGgRgnwh6AvIVEA3r2MAT5z2pHTkqFw20LrSTUO9z/k2TcecSSOaQqrHspm8m1aYxLMX/jD3rSFdrLw8L7FMDoH6jvBMZ82oeWun6J/zgQIUQgxp+AfftNm2LHSW2nmjnIoDlPO4xnRYd5xpsqNZjAxu5CSyIkN0R9mGpltKwSerkYPDKiT7lvw9MpECK2mYr4+CKj78686jKsc4qgCY5IcV7pQOsnIihY3h4MsAXLXH4kfFXjAXtCLmDTwObrCQwkY2TbC/4/F2QWLuU6NVh8b1L4H5cAd+LwguL4PRVYg1agx2N55uaYmhCjWUgVpG5jbC1/ErN2OQhuMxkvUhc25qI3OMCMWaAIsdvhhP4xJFszCbrzXpw5X8vrHayXYgYGZGP/sOVy/AsaQcfpf3a5wmY+34PGdSV8Fj1lqMM0ChaaOu3tNXoZ7fC6jHXgte0NwT2Z/AO/aYLC6KQFhDqamHvNaRBBVviEWDIAq0snQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66899024)(30864003)(6506007)(478600001)(6512007)(2616005)(6486002)(966005)(6666004)(7406005)(36756003)(103116003)(38100700002)(86362001)(1076003)(41300700001)(7416002)(5660300002)(316002)(66556008)(66476007)(83380400001)(2906002)(54906003)(26005)(66946007)(6916009)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LZfXZLcj3ZW4ZR3ZPK0iOitquxDz3gwFbIehjJ40ixOoDCs2nELVhY0BU3Mq?=
 =?us-ascii?Q?qQxW4QCJ7LjQP7URrPgneCkvZY+1RVZ/zhbMzGsoQCfXWZq2NXP+ozQqtPeo?=
 =?us-ascii?Q?1J0ku53vtUqtwi2BkqqBgM/BlRZu/swrJ41aTK0pC+Z+fHc++Nyq38S+Cq0h?=
 =?us-ascii?Q?+q5qGrYMGW76y3cT8twguYuxhf6gwv8V349OFBr65dqyCpNX+wpUJRvcIhC5?=
 =?us-ascii?Q?yrwCB9jDFEb2Yf79V0Wg/K89Dme19ZlNGhC0PpF2SnUAFm3SPv2JnqdO0T0g?=
 =?us-ascii?Q?7MiYcahD1QMMXSiH2k/gmGx0f4h/VrrE5uEE2PDJaYBqZiioSz4UYUxvEQWs?=
 =?us-ascii?Q?xGu9Alg0bbH4AeHckpe8ZTzbLRSxbKyHSh0DPQ84aPBHcgC0KrFhSJYqXVfX?=
 =?us-ascii?Q?mgc7vbeyZn/oOgbz2WIuQ0bEIV+A2s0FlaULnUPgogZE3kdQut72zjxCqaFR?=
 =?us-ascii?Q?ULuOV8pMKtEnAQl7begVv5hNpkECUrLFZLszeTVn0MOjf7xiRuBriBRt+I66?=
 =?us-ascii?Q?ybCPAHKv7PjYBQPl8zVbOJGwqcJ3OIUxTbav10sZsfnqwvcGf7CB6kbrywjP?=
 =?us-ascii?Q?tIUlloMDuzj9fXBF64XdPNvw2SYPeyvZ9qtM1S5OElj50s8BGAk7UYwJCQee?=
 =?us-ascii?Q?mfRWbqf03a62UhG7a8LgcKGNzMVpAxFK/KTmB2dABBKKqrhl/h6eWyk6Fjc9?=
 =?us-ascii?Q?60TtNu1AMi/oNYUv+yp9gBxmVzPTE6ADV9OmJk3bOfEYGUuSLjNWIccVmKcb?=
 =?us-ascii?Q?VpZylHpdzed2LNi48O1a5s9TvhH8IbJuG37/r0iSiuV+4B79v6t50w8vwqSD?=
 =?us-ascii?Q?7aXVe68pzUF619SfzhBfngj9hKTEPO+6LybHVhmC9iizDTCwCNgx9MOCnYLC?=
 =?us-ascii?Q?Uz0yYxeSmwr2DKuy6a74sgzWFYuIz5Daxn8AD09+2TnOM8hktDeB90wb4jvA?=
 =?us-ascii?Q?I1Xu1Vb27+ZOEI1wepQTYEYK82a/TxB4jypGCHjeAyZ42UXmNb7MKdiInX92?=
 =?us-ascii?Q?/pQOTRYv5Ebqj/0jcmVcMNdcRQnZSXjYZaKgwcAWw5DeNIp/AOJqkqz4Q01+?=
 =?us-ascii?Q?pwYy4GieZcu6Xg7kJtw2HG1iGaBk+BSGire2Bnlr0FCSIedlQHqYfAaREXpE?=
 =?us-ascii?Q?T+ERNPljg/ADexL6hPPsUmURwGAg2Jwfc5lwiZgR+oF/nStEe/zqgqCZlKoG?=
 =?us-ascii?Q?oULZuZqbsXXq2a/UZJtBNvGA1prv6AZFHTjB/QKCPkwbn8j3ypB7GZAGjHpW?=
 =?us-ascii?Q?pT83Yn5a+mXE6gtwYdrsOxVX4NtdhldcsjXtXjzFuVTEUBN0nZ6GHkV8LSoM?=
 =?us-ascii?Q?GcGZ5s5DqCG4AGlYydDDqgAYySx1uKPkx4k5JZjKUpsOsd2tbpaG24wOW8pz?=
 =?us-ascii?Q?XFH19jMF1CjLu6leFErs6f0pWKT60bGfheTiyIYUOq9WPTSJVK16cfg6i2UI?=
 =?us-ascii?Q?6UD42OsW3cTRfUha1ifBxGOnjPjNiQdcZlxfdcl3Do44HuzE45U3uvOm41cN?=
 =?us-ascii?Q?8JsqPXmUv8TL2EEtoaH1rmcCHuKmTz7WZrjDobJaUbjBxEL5br69mGDBvAC0?=
 =?us-ascii?Q?yoNd302Z2zG5YzQNWK9R83PT0GfMVkGwsWrRyDpbCXCLCu3MgRLUg3opKAD4?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?K66kyMtFgkz0oHjjZQi8GnF0K/v4j+tVZk3et9s/MuSYDZrtAxAPwuDOI2ZX?=
 =?us-ascii?Q?9uubPr8KAUsbh5h8qHy8PckqnwBEQLvlDg6r5nuD5PdcNNSrqLpM2Q6eBfXH?=
 =?us-ascii?Q?N7WC/rr1lgKUBIx0td1FUPg3Y25+NLHZDZkm13S+RmoR0w/RA5jYm/NmL1Ql?=
 =?us-ascii?Q?F/qzzLZhAJ0Aot1Ydtwr2IqYg5XCeWNCjuVfqvqjj0v04E77Hciwbuw+GnGL?=
 =?us-ascii?Q?mFuUXwIiXTEcKmHUO9fIqgGlVG6axm1bC5wN4HnQwlXGthcP7LpKo8kFcSx1?=
 =?us-ascii?Q?D22ksAWxF+OpMCLIWBRCn7I5vwAGvcI4PMYF2x3iQsmX5sREJ5hdleWZaFGu?=
 =?us-ascii?Q?AkWXaWb6qJTiXywuBhjTCYEP/JnRM6O83Q4IrPXygXrz0MW+C63navW2Ptjh?=
 =?us-ascii?Q?pHt+eNIPlELaS8J1YAM9sq6+TijuLZC5IlI8Fx0q5QVEQiZRlH3ruW6SVzN9?=
 =?us-ascii?Q?yGwmMSm3eu/kV6KZftkqfh3stfjetEHkARavTR45pLynsRK5Eg5WUG9SPAAT?=
 =?us-ascii?Q?yl/R96Cww0LEJV3aCMuyiI8bQ45QYVanf/AkA7iUt+bDBO6uKmQRV+Hrzs0U?=
 =?us-ascii?Q?92AiC3sA5fQu6h9qIAgMceTw7synzQWHvKggLZqKEhh6nvwwDhWhLup5Nt72?=
 =?us-ascii?Q?8QQuKHFFo7n9nUZMT5Ixpgy9mxO62Uy8SWpNCC6CSV8j5lCiBiYMcbGKf7mM?=
 =?us-ascii?Q?TCSW7COPN7+WWfm6fukS+5dDSLZxLbJP+Fv+iBSSaO7todw82HG16yZpEe2z?=
 =?us-ascii?Q?N+j8W91CkGSetfmlZSsXAe0szVnoij8Rn39PfMvPAgy29t5EBIoaz0siPmrl?=
 =?us-ascii?Q?s3R7J3oDptG2xN9FmYv6QdUcDGj94PA5OJxgcRcnCZuSsx7auM0rA8OYFPlo?=
 =?us-ascii?Q?PWZIl1ZQzxsKINYhSRH8NYgwRo5Q5AyEvMmHogv6DGuHflW6oCcgJOsvb1D1?=
 =?us-ascii?Q?3sc67H0EOh5KmyaZGm/t3Vys2GYWG+KdBFasEU/H+Fr5iYr2kcspTxj4p1ng?=
 =?us-ascii?Q?9BuXc/pgNtJ4zjUlUHZHclqBYgeqB2W3BNFmQJm3Z5tlhZEjUEW5PHgk0GZA?=
 =?us-ascii?Q?RWK4hNHvLAhpGnQ+mAX/aQJ2ePbV75bMehXVafx+fuog5MpdUSG2NyzffwSG?=
 =?us-ascii?Q?5QcCYOm+x1tgwD72wrNcLD2u0HHQCeERQlaRZ7clq1r8JEud+KjTptUFIBNv?=
 =?us-ascii?Q?irYLcKrrSuVvj1hrGVd4nWDIXdALyJ5LCiNeMf5D7d0hoPaW0gWHw61pSW1G?=
 =?us-ascii?Q?3FH1zXYCcUlrXRX1cD4f+c9kd3kqaOma7Tkc0CoDSo6Xp0yGXNhBGQLlKceX?=
 =?us-ascii?Q?FUGN4xdLdsKk71y9tvCJLgfVgdZruAXaBYZtvuE/1p7TfyAn7prvfO+7BnbN?=
 =?us-ascii?Q?AxfpoBcsy+d8hsKohnU85s+SMDbypKkrTg7vECwO7PR/5TX4yM25AoFiMSfp?=
 =?us-ascii?Q?qNu2cvscFPUu/6xDSbIkcAZu0cHPwwpPVNdxlwJyvM7dLpMpOkdpAfQ5XigE?=
 =?us-ascii?Q?qJlf76bqIbq0O4c2aDRjfoyzDC4qR7/r6G5FRr+NTeBOIDu14Vcq9q3vq8Aj?=
 =?us-ascii?Q?JfZ+hOAva9VoINWpgNKjQ1tv9VjLBBhJuOT66vVH438lT0tju02y4yNHoGDB?=
 =?us-ascii?Q?WuCo806kktwhLZuT4JMmXSbi4drElrRL2Zx+mASxtU/hvvJGKkzw31Xe33so?=
 =?us-ascii?Q?gITGxEAWJ0FQ3eiy+VaP6FtepbY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f34de6d7-050b-48bc-eaed-08dbdfe6a60b
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:09:52.6615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4KgUi8pQ/sLDd1hH8cvqS4xgI7VTK4sdeywxhD0+8ZH6u+RYKx2TSBr8V1fn/rt9Sgx7bXi+60qqGVd69XQGdlqBcY1gZ2LbmXdEDfg8QoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070189
X-Proofpoint-ORIG-GUID: bZTJoCchBsrZ1u2CPnAl9mrDpIaDH0f_
X-Proofpoint-GUID: bZTJoCchBsrZ1u2CPnAl9mrDpIaDH0f_
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are broadly three sets of uses of cond_resched():

1.  Calls to cond_resched() out of the goodness of our heart,
    otherwise known as avoiding lockup splats.

2.  Open coded variants of cond_resched_lock() which call
    cond_resched().

3.  Retry or error handling loops, where cond_resched() is used as a
    quick alternative to spinning in a tight-loop.

When running under a full preemption model, the cond_resched() reduces
to a NOP (not even a barrier) so removing it obviously cannot matter.

But considering only voluntary preemption models (for say code that
has been mostly tested under those), for set-1 and set-2 the
scheduler can now preempt kernel tasks running beyond their time
quanta anywhere they are preemptible() [1]. Which removes any need
for these explicitly placed scheduling points.

The cond_resched() calls in set-3 are a little more difficult.
To start with, given it's NOP character under full preemption, it
never actually saved us from a tight loop.
With voluntary preemption, it's not a NOP, but it might as well be --
for most workloads the scheduler does not have an interminable supply
of runnable tasks on the runqueue.

So, cond_resched() is useful to not get softlockup splats, but not
terribly good for error handling. Ideally, these should be replaced
with some kind of timed or event wait.
For now we use cond_resched_stall(), which tries to schedule if
possible, and executes a cpu_relax() if not.

Most of the uses here are in set-1 (some right after we give up a lock
or enable bottom-halves, causing an explicit preemption check.)

There are a few cases from set-3. Replace them with
cond_resched_stall().

[1] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/

Cc: Inki Dae <inki.dae@samsung.com> 
Cc: Jagan Teki <jagan@amarulasolutions.com> 
Cc: Marek Szyprowski <m.szyprowski@samsung.com> 
Cc: Andrzej Hajda <andrzej.hajda@intel.com> 
Cc: Neil Armstrong <neil.armstrong@linaro.org> 
Cc: Robert Foss <rfoss@kernel.org> 
Cc: David Airlie <airlied@gmail.com> 
Cc: Daniel Vetter <daniel@ffwll.ch> 
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com> 
Cc: Maxime Ripard <mripard@kernel.org> 
Cc: Thomas Zimmermann <tzimmermann@suse.de> 
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 drivers/gpu/drm/bridge/samsung-dsim.c         |  2 +-
 drivers/gpu/drm/drm_buddy.c                   |  1 -
 drivers/gpu/drm/drm_gem.c                     |  1 -
 .../gpu/drm/i915/gem/i915_gem_execbuffer.c    |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.c    |  1 -
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c     |  2 --
 .../gpu/drm/i915/gem/selftests/huge_pages.c   |  6 ----
 .../drm/i915/gem/selftests/i915_gem_mman.c    |  5 ----
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c   |  2 +-
 drivers/gpu/drm/i915/gt/intel_gt.c            |  2 +-
 drivers/gpu/drm/i915/gt/intel_migrate.c       |  4 ---
 drivers/gpu/drm/i915/gt/selftest_execlists.c  |  4 ---
 drivers/gpu/drm/i915/gt/selftest_hangcheck.c  |  2 --
 drivers/gpu/drm/i915/gt/selftest_lrc.c        |  2 --
 drivers/gpu/drm/i915/gt/selftest_migrate.c    |  2 --
 drivers/gpu/drm/i915/gt/selftest_timeline.c   |  4 ---
 drivers/gpu/drm/i915/i915_active.c            |  2 +-
 drivers/gpu/drm/i915/i915_gem_evict.c         |  2 --
 drivers/gpu/drm/i915/i915_gpu_error.c         | 18 ++++--------
 drivers/gpu/drm/i915/intel_uncore.c           |  1 -
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c |  2 --
 drivers/gpu/drm/i915/selftests/i915_request.c |  2 --
 .../gpu/drm/i915/selftests/i915_selftest.c    |  3 --
 drivers/gpu/drm/i915/selftests/i915_vma.c     |  9 ------
 .../gpu/drm/i915/selftests/igt_flush_test.c   |  2 --
 .../drm/i915/selftests/intel_memory_region.c  |  4 ---
 drivers/gpu/drm/tests/drm_buddy_test.c        |  5 ----
 drivers/gpu/drm/tests/drm_mm_test.c           | 29 -------------------
 28 files changed, 11 insertions(+), 110 deletions(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index cf777bdb25d2..ae537b9bf8df 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1013,7 +1013,7 @@ static int samsung_dsim_wait_for_hdr_fifo(struct samsung_dsim *dsi)
 		if (reg & DSIM_SFR_HEADER_EMPTY)
 			return 0;
 
-		if (!cond_resched())
+		if (!cond_resched_stall())
 			usleep_range(950, 1050);
 	} while (--timeout);
 
diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
index e6f5ba5f4baf..fe401d18bf4d 100644
--- a/drivers/gpu/drm/drm_buddy.c
+++ b/drivers/gpu/drm/drm_buddy.c
@@ -311,7 +311,6 @@ void drm_buddy_free_list(struct drm_buddy *mm, struct list_head *objects)
 
 	list_for_each_entry_safe(block, on, objects, link) {
 		drm_buddy_free_block(mm, block);
-		cond_resched();
 	}
 	INIT_LIST_HEAD(objects);
 }
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 44a948b80ee1..881caa4b48a9 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -506,7 +506,6 @@ static void drm_gem_check_release_batch(struct folio_batch *fbatch)
 {
 	check_move_unevictable_folios(fbatch);
 	__folio_batch_release(fbatch);
-	cond_resched();
 }
 
 /**
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index 5a687a3686bd..0b16689423b4 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -1812,7 +1812,7 @@ static noinline int eb_relocate_parse_slow(struct i915_execbuffer *eb)
 		err = eb_copy_relocations(eb);
 		have_copy = err == 0;
 	} else {
-		cond_resched();
+		cond_resched_stall();
 		err = 0;
 	}
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
index ef9346ed6d0f..172eee1e8889 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
@@ -414,7 +414,6 @@ static void __i915_gem_free_objects(struct drm_i915_private *i915,
 
 		/* But keep the pointer alive for RCU-protected lookups */
 		call_rcu(&obj->rcu, __i915_gem_free_object_rcu);
-		cond_resched();
 	}
 }
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index 73a4a4eb29e0..38ea2fc206e0 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -26,7 +26,6 @@ static void check_release_folio_batch(struct folio_batch *fbatch)
 {
 	check_move_unevictable_folios(fbatch);
 	__folio_batch_release(fbatch);
-	cond_resched();
 }
 
 void shmem_sg_free_table(struct sg_table *st, struct address_space *mapping,
@@ -108,7 +107,6 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 		gfp_t gfp = noreclaim;
 
 		do {
-			cond_resched();
 			folio = shmem_read_folio_gfp(mapping, i, gfp);
 			if (!IS_ERR(folio))
 				break;
diff --git a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
index 6b9f6cf50bf6..fae0fa993404 100644
--- a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
+++ b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
@@ -1447,8 +1447,6 @@ static int igt_ppgtt_smoke_huge(void *arg)
 
 		if (err)
 			break;
-
-		cond_resched();
 	}
 
 	return err;
@@ -1538,8 +1536,6 @@ static int igt_ppgtt_sanity_check(void *arg)
 				goto out;
 			}
 		}
-
-		cond_resched();
 	}
 
 out:
@@ -1738,8 +1734,6 @@ static int igt_ppgtt_mixed(void *arg)
 			break;
 
 		addr += obj->base.size;
-
-		cond_resched();
 	}
 
 	i915_gem_context_unlock_engines(ctx);
diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
index 72957a36a36b..c994071532cf 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
@@ -221,7 +221,6 @@ static int check_partial_mappings(struct drm_i915_gem_object *obj,
 		u32 *cpu;
 
 		GEM_BUG_ON(view.partial.size > nreal);
-		cond_resched();
 
 		vma = i915_gem_object_ggtt_pin(obj, &view, 0, 0, PIN_MAPPABLE);
 		if (IS_ERR(vma)) {
@@ -1026,8 +1025,6 @@ static void igt_close_objects(struct drm_i915_private *i915,
 		i915_gem_object_put(obj);
 	}
 
-	cond_resched();
-
 	i915_gem_drain_freed_objects(i915);
 }
 
@@ -1041,8 +1038,6 @@ static void igt_make_evictable(struct list_head *objects)
 			i915_gem_object_unpin_pages(obj);
 		i915_gem_object_unlock(obj);
 	}
-
-	cond_resched();
 }
 
 static int igt_fill_mappable(struct intel_memory_region *mr,
diff --git a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
index ecc990ec1b95..e016f1203f7c 100644
--- a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
+++ b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
@@ -315,7 +315,7 @@ void __intel_breadcrumbs_park(struct intel_breadcrumbs *b)
 		local_irq_disable();
 		signal_irq_work(&b->irq_work);
 		local_irq_enable();
-		cond_resched();
+		cond_resched_stall();
 	}
 }
 
diff --git a/drivers/gpu/drm/i915/gt/intel_gt.c b/drivers/gpu/drm/i915/gt/intel_gt.c
index 449f0b7fc843..40cfdf4f5fff 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt.c
@@ -664,7 +664,7 @@ int intel_gt_wait_for_idle(struct intel_gt *gt, long timeout)
 
 	while ((timeout = intel_gt_retire_requests_timeout(gt, timeout,
 							   &remaining_timeout)) > 0) {
-		cond_resched();
+		cond_resched_stall();
 		if (signal_pending(current))
 			return -EINTR;
 	}
diff --git a/drivers/gpu/drm/i915/gt/intel_migrate.c b/drivers/gpu/drm/i915/gt/intel_migrate.c
index 576e5ef0289b..cc3f62d5c28f 100644
--- a/drivers/gpu/drm/i915/gt/intel_migrate.c
+++ b/drivers/gpu/drm/i915/gt/intel_migrate.c
@@ -906,8 +906,6 @@ intel_context_migrate_copy(struct intel_context *ce,
 			err = -EINVAL;
 			break;
 		}
-
-		cond_resched();
 	} while (1);
 
 out_ce:
@@ -1067,8 +1065,6 @@ intel_context_migrate_clear(struct intel_context *ce,
 		i915_request_add(rq);
 		if (err || !it.sg || !sg_dma_len(it.sg))
 			break;
-
-		cond_resched();
 	} while (1);
 
 out_ce:
diff --git a/drivers/gpu/drm/i915/gt/selftest_execlists.c b/drivers/gpu/drm/i915/gt/selftest_execlists.c
index 4202df5b8c12..52c8fa3e5cad 100644
--- a/drivers/gpu/drm/i915/gt/selftest_execlists.c
+++ b/drivers/gpu/drm/i915/gt/selftest_execlists.c
@@ -60,8 +60,6 @@ static int wait_for_submit(struct intel_engine_cs *engine,
 
 		if (done)
 			return -ETIME;
-
-		cond_resched();
 	} while (1);
 }
 
@@ -72,7 +70,6 @@ static int wait_for_reset(struct intel_engine_cs *engine,
 	timeout += jiffies;
 
 	do {
-		cond_resched();
 		intel_engine_flush_submission(engine);
 
 		if (READ_ONCE(engine->execlists.pending[0]))
@@ -1373,7 +1370,6 @@ static int live_timeslice_queue(void *arg)
 
 		/* Wait until we ack the release_queue and start timeslicing */
 		do {
-			cond_resched();
 			intel_engine_flush_submission(engine);
 		} while (READ_ONCE(engine->execlists.pending[0]));
 
diff --git a/drivers/gpu/drm/i915/gt/selftest_hangcheck.c b/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
index 0dd4d00ee894..e751ed2cf8b2 100644
--- a/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
+++ b/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
@@ -939,8 +939,6 @@ static void active_engine(struct kthread_work *work)
 			pr_err("[%s] Request put failed: %d!\n", engine->name, err);
 			break;
 		}
-
-		cond_resched();
 	}
 
 	for (count = 0; count < ARRAY_SIZE(rq); count++) {
diff --git a/drivers/gpu/drm/i915/gt/selftest_lrc.c b/drivers/gpu/drm/i915/gt/selftest_lrc.c
index 5f826b6dcf5d..83a42492f0d0 100644
--- a/drivers/gpu/drm/i915/gt/selftest_lrc.c
+++ b/drivers/gpu/drm/i915/gt/selftest_lrc.c
@@ -70,8 +70,6 @@ static int wait_for_submit(struct intel_engine_cs *engine,
 
 		if (done)
 			return -ETIME;
-
-		cond_resched();
 	} while (1);
 }
 
diff --git a/drivers/gpu/drm/i915/gt/selftest_migrate.c b/drivers/gpu/drm/i915/gt/selftest_migrate.c
index 3def5ca72dec..9dfa70699df9 100644
--- a/drivers/gpu/drm/i915/gt/selftest_migrate.c
+++ b/drivers/gpu/drm/i915/gt/selftest_migrate.c
@@ -210,8 +210,6 @@ static int intel_context_copy_ccs(struct intel_context *ce,
 		i915_request_add(rq);
 		if (err || !it.sg || !sg_dma_len(it.sg))
 			break;
-
-		cond_resched();
 	} while (1);
 
 out_ce:
diff --git a/drivers/gpu/drm/i915/gt/selftest_timeline.c b/drivers/gpu/drm/i915/gt/selftest_timeline.c
index fa36cf920bde..15b8fd41ad90 100644
--- a/drivers/gpu/drm/i915/gt/selftest_timeline.c
+++ b/drivers/gpu/drm/i915/gt/selftest_timeline.c
@@ -352,7 +352,6 @@ static int bench_sync(void *arg)
 		__func__, count, (long long)div64_ul(ktime_to_ns(kt), count));
 
 	mock_timeline_fini(&tl);
-	cond_resched();
 
 	mock_timeline_init(&tl, 0);
 
@@ -382,7 +381,6 @@ static int bench_sync(void *arg)
 		__func__, count, (long long)div64_ul(ktime_to_ns(kt), count));
 
 	mock_timeline_fini(&tl);
-	cond_resched();
 
 	mock_timeline_init(&tl, 0);
 
@@ -405,7 +403,6 @@ static int bench_sync(void *arg)
 	pr_info("%s: %lu repeated insert/lookups, %lluns/op\n",
 		__func__, count, (long long)div64_ul(ktime_to_ns(kt), count));
 	mock_timeline_fini(&tl);
-	cond_resched();
 
 	/* Benchmark searching for a known context id and changing the seqno */
 	for (last_order = 1, order = 1; order < 32;
@@ -434,7 +431,6 @@ static int bench_sync(void *arg)
 			__func__, count, order,
 			(long long)div64_ul(ktime_to_ns(kt), count));
 		mock_timeline_fini(&tl);
-		cond_resched();
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/i915/i915_active.c b/drivers/gpu/drm/i915/i915_active.c
index 5ec293011d99..810251c33495 100644
--- a/drivers/gpu/drm/i915/i915_active.c
+++ b/drivers/gpu/drm/i915/i915_active.c
@@ -865,7 +865,7 @@ int i915_active_acquire_preallocate_barrier(struct i915_active *ref,
 
 	/* Wait until the previous preallocation is completed */
 	while (!llist_empty(&ref->preallocated_barriers))
-		cond_resched();
+		cond_resched_stall();
 
 	/*
 	 * Preallocate a node for each physical engine supporting the target
diff --git a/drivers/gpu/drm/i915/i915_gem_evict.c b/drivers/gpu/drm/i915/i915_gem_evict.c
index c02ebd6900ae..1a600f42a3ad 100644
--- a/drivers/gpu/drm/i915/i915_gem_evict.c
+++ b/drivers/gpu/drm/i915/i915_gem_evict.c
@@ -267,8 +267,6 @@ i915_gem_evict_something(struct i915_address_space *vm,
 	if (ret)
 		return ret;
 
-	cond_resched();
-
 	flags |= PIN_NONBLOCK;
 	goto search_again;
 
diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
index 4008bb09fdb5..410072145d4d 100644
--- a/drivers/gpu/drm/i915/i915_gpu_error.c
+++ b/drivers/gpu/drm/i915/i915_gpu_error.c
@@ -320,8 +320,6 @@ static int compress_page(struct i915_vma_compress *c,
 
 		if (zlib_deflate(zstream, Z_NO_FLUSH) != Z_OK)
 			return -EIO;
-
-		cond_resched();
 	} while (zstream->avail_in);
 
 	/* Fallback to uncompressed if we increase size? */
@@ -408,7 +406,6 @@ static int compress_page(struct i915_vma_compress *c,
 	if (!(wc && i915_memcpy_from_wc(ptr, src, PAGE_SIZE)))
 		memcpy(ptr, src, PAGE_SIZE);
 	list_add_tail(&virt_to_page(ptr)->lru, &dst->page_list);
-	cond_resched();
 
 	return 0;
 }
@@ -2325,13 +2322,6 @@ void intel_klog_error_capture(struct intel_gt *gt,
 						 l_count, line++, ptr2);
 					ptr[pos] = chr;
 					ptr2 = ptr + pos;
-
-					/*
-					 * If spewing large amounts of data via a serial console,
-					 * this can be a very slow process. So be friendly and try
-					 * not to cause 'softlockup on CPU' problems.
-					 */
-					cond_resched();
 				}
 
 				if (ptr2 < (ptr + count))
@@ -2352,8 +2342,12 @@ void intel_klog_error_capture(struct intel_gt *gt,
 				got--;
 			}
 
-			/* As above. */
-			cond_resched();
+			/*
+			 * If spewing large amounts of data via a serial console,
+			 * this can be a very slow process. So be friendly and try
+			 * not to cause 'softlockup on CPU' problems.
+			 */
+			cond_resched_stall();
 		}
 
 		if (got)
diff --git a/drivers/gpu/drm/i915/intel_uncore.c b/drivers/gpu/drm/i915/intel_uncore.c
index dfefad5a5fec..d2e74cfb1aac 100644
--- a/drivers/gpu/drm/i915/intel_uncore.c
+++ b/drivers/gpu/drm/i915/intel_uncore.c
@@ -487,7 +487,6 @@ intel_uncore_forcewake_reset(struct intel_uncore *uncore)
 		}
 
 		spin_unlock_irqrestore(&uncore->lock, irqflags);
-		cond_resched();
 	}
 
 	drm_WARN_ON(&uncore->i915->drm, active_domains);
diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
index 5c397a2df70e..4b497e969a33 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
@@ -201,7 +201,6 @@ static int igt_ppgtt_alloc(void *arg)
 		}
 
 		ppgtt->vm.allocate_va_range(&ppgtt->vm, &stash, 0, size);
-		cond_resched();
 
 		ppgtt->vm.clear_range(&ppgtt->vm, 0, size);
 
@@ -224,7 +223,6 @@ static int igt_ppgtt_alloc(void *arg)
 
 		ppgtt->vm.allocate_va_range(&ppgtt->vm, &stash,
 					    last, size - last);
-		cond_resched();
 
 		i915_vm_free_pt_stash(&ppgtt->vm, &stash);
 	}
diff --git a/drivers/gpu/drm/i915/selftests/i915_request.c b/drivers/gpu/drm/i915/selftests/i915_request.c
index a9b79888c193..43bb54fc8c78 100644
--- a/drivers/gpu/drm/i915/selftests/i915_request.c
+++ b/drivers/gpu/drm/i915/selftests/i915_request.c
@@ -438,8 +438,6 @@ static void __igt_breadcrumbs_smoketest(struct kthread_work *work)
 
 		num_fences += count;
 		num_waits++;
-
-		cond_resched();
 	}
 
 	atomic_long_add(num_fences, &t->num_fences);
diff --git a/drivers/gpu/drm/i915/selftests/i915_selftest.c b/drivers/gpu/drm/i915/selftests/i915_selftest.c
index ee79e0809a6d..17e6bbc3c87e 100644
--- a/drivers/gpu/drm/i915/selftests/i915_selftest.c
+++ b/drivers/gpu/drm/i915/selftests/i915_selftest.c
@@ -179,7 +179,6 @@ static int __run_selftests(const char *name,
 		if (!st->enabled)
 			continue;
 
-		cond_resched();
 		if (signal_pending(current))
 			return -EINTR;
 
@@ -381,7 +380,6 @@ int __i915_subtests(const char *caller,
 	int err;
 
 	for (; count--; st++) {
-		cond_resched();
 		if (signal_pending(current))
 			return -EINTR;
 
@@ -414,7 +412,6 @@ bool __igt_timeout(unsigned long timeout, const char *fmt, ...)
 	va_list va;
 
 	if (!signal_pending(current)) {
-		cond_resched();
 		if (time_before(jiffies, timeout))
 			return false;
 	}
diff --git a/drivers/gpu/drm/i915/selftests/i915_vma.c b/drivers/gpu/drm/i915/selftests/i915_vma.c
index 71b52d5efef4..1bacdcd77c5b 100644
--- a/drivers/gpu/drm/i915/selftests/i915_vma.c
+++ b/drivers/gpu/drm/i915/selftests/i915_vma.c
@@ -197,8 +197,6 @@ static int igt_vma_create(void *arg)
 			list_del_init(&ctx->link);
 			mock_context_close(ctx);
 		}
-
-		cond_resched();
 	}
 
 end:
@@ -347,8 +345,6 @@ static int igt_vma_pin1(void *arg)
 				goto out;
 			}
 		}
-
-		cond_resched();
 	}
 
 	err = 0;
@@ -697,7 +693,6 @@ static int igt_vma_rotate_remap(void *arg)
 						pr_err("Unbinding returned %i\n", err);
 						goto out_object;
 					}
-					cond_resched();
 				}
 			}
 		}
@@ -858,8 +853,6 @@ static int igt_vma_partial(void *arg)
 					pr_err("Unbinding returned %i\n", err);
 					goto out_object;
 				}
-
-				cond_resched();
 			}
 		}
 
@@ -1085,8 +1078,6 @@ static int igt_vma_remapped_gtt(void *arg)
 				}
 			}
 			i915_vma_unpin_iomap(vma);
-
-			cond_resched();
 		}
 	}
 
diff --git a/drivers/gpu/drm/i915/selftests/igt_flush_test.c b/drivers/gpu/drm/i915/selftests/igt_flush_test.c
index 29110abb4fe0..fbc1b606df29 100644
--- a/drivers/gpu/drm/i915/selftests/igt_flush_test.c
+++ b/drivers/gpu/drm/i915/selftests/igt_flush_test.c
@@ -22,8 +22,6 @@ int igt_flush_test(struct drm_i915_private *i915)
 		if (intel_gt_is_wedged(gt))
 			ret = -EIO;
 
-		cond_resched();
-
 		if (intel_gt_wait_for_idle(gt, HZ * 3) == -ETIME) {
 			pr_err("%pS timed out, cancelling all further testing.\n",
 			       __builtin_return_address(0));
diff --git a/drivers/gpu/drm/i915/selftests/intel_memory_region.c b/drivers/gpu/drm/i915/selftests/intel_memory_region.c
index d985d9bae2e8..3fce433284bd 100644
--- a/drivers/gpu/drm/i915/selftests/intel_memory_region.c
+++ b/drivers/gpu/drm/i915/selftests/intel_memory_region.c
@@ -46,8 +46,6 @@ static void close_objects(struct intel_memory_region *mem,
 		i915_gem_object_put(obj);
 	}
 
-	cond_resched();
-
 	i915_gem_drain_freed_objects(i915);
 }
 
@@ -1290,8 +1288,6 @@ static int _perf_memcpy(struct intel_memory_region *src_mr,
 			div64_u64(mul_u32_u32(4 * size,
 					      1000 * 1000 * 1000),
 				  t[1] + 2 * t[2] + t[3]) >> 20);
-
-		cond_resched();
 	}
 
 	i915_gem_object_unpin_map(dst);
diff --git a/drivers/gpu/drm/tests/drm_buddy_test.c b/drivers/gpu/drm/tests/drm_buddy_test.c
index 09ee6f6af896..7ee65bad4bb7 100644
--- a/drivers/gpu/drm/tests/drm_buddy_test.c
+++ b/drivers/gpu/drm/tests/drm_buddy_test.c
@@ -29,7 +29,6 @@ static bool __timeout(unsigned long timeout, const char *fmt, ...)
 	va_list va;
 
 	if (!signal_pending(current)) {
-		cond_resched();
 		if (time_before(jiffies, timeout))
 			return false;
 	}
@@ -485,8 +484,6 @@ static void drm_test_buddy_alloc_smoke(struct kunit *test)
 
 		if (err || timeout)
 			break;
-
-		cond_resched();
 	}
 
 	kfree(order);
@@ -681,8 +678,6 @@ static void drm_test_buddy_alloc_range(struct kunit *test)
 		rem -= size;
 		if (!rem)
 			break;
-
-		cond_resched();
 	}
 
 	drm_buddy_free_list(&mm, &blocks);
diff --git a/drivers/gpu/drm/tests/drm_mm_test.c b/drivers/gpu/drm/tests/drm_mm_test.c
index 05d5e7af6d25..7d11740ef599 100644
--- a/drivers/gpu/drm/tests/drm_mm_test.c
+++ b/drivers/gpu/drm/tests/drm_mm_test.c
@@ -474,8 +474,6 @@ static void drm_test_mm_reserve(struct kunit *test)
 		KUNIT_ASSERT_FALSE(test, __drm_test_mm_reserve(test, count, size - 1));
 		KUNIT_ASSERT_FALSE(test, __drm_test_mm_reserve(test, count, size));
 		KUNIT_ASSERT_FALSE(test, __drm_test_mm_reserve(test, count, size + 1));
-
-		cond_resched();
 	}
 }
 
@@ -645,8 +643,6 @@ static int __drm_test_mm_insert(struct kunit *test, unsigned int count, u64 size
 		drm_mm_for_each_node_safe(node, next, &mm)
 			drm_mm_remove_node(node);
 		DRM_MM_BUG_ON(!drm_mm_clean(&mm));
-
-		cond_resched();
 	}
 
 	ret = 0;
@@ -671,8 +667,6 @@ static void drm_test_mm_insert(struct kunit *test)
 		KUNIT_ASSERT_FALSE(test, __drm_test_mm_insert(test, count, size - 1, false));
 		KUNIT_ASSERT_FALSE(test, __drm_test_mm_insert(test, count, size, false));
 		KUNIT_ASSERT_FALSE(test, __drm_test_mm_insert(test, count, size + 1, false));
-
-		cond_resched();
 	}
 }
 
@@ -693,8 +687,6 @@ static void drm_test_mm_replace(struct kunit *test)
 		KUNIT_ASSERT_FALSE(test, __drm_test_mm_insert(test, count, size - 1, true));
 		KUNIT_ASSERT_FALSE(test, __drm_test_mm_insert(test, count, size, true));
 		KUNIT_ASSERT_FALSE(test, __drm_test_mm_insert(test, count, size + 1, true));
-
-		cond_resched();
 	}
 }
 
@@ -882,8 +874,6 @@ static int __drm_test_mm_insert_range(struct kunit *test, unsigned int count, u6
 		drm_mm_for_each_node_safe(node, next, &mm)
 			drm_mm_remove_node(node);
 		DRM_MM_BUG_ON(!drm_mm_clean(&mm));
-
-		cond_resched();
 	}
 
 	ret = 0;
@@ -942,8 +932,6 @@ static void drm_test_mm_insert_range(struct kunit *test)
 								    max / 2, max));
 		KUNIT_ASSERT_FALSE(test, __drm_test_mm_insert_range(test, count, size,
 								    max / 4 + 1, 3 * max / 4 - 1));
-
-		cond_resched();
 	}
 }
 
@@ -1086,8 +1074,6 @@ static void drm_test_mm_align(struct kunit *test)
 		drm_mm_for_each_node_safe(node, next, &mm)
 			drm_mm_remove_node(node);
 		DRM_MM_BUG_ON(!drm_mm_clean(&mm));
-
-		cond_resched();
 	}
 
 out:
@@ -1122,8 +1108,6 @@ static void drm_test_mm_align_pot(struct kunit *test, int max)
 			KUNIT_FAIL(test, "insert failed with alignment=%llx [%d]", align, bit);
 			goto out;
 		}
-
-		cond_resched();
 	}
 
 out:
@@ -1465,8 +1449,6 @@ static void drm_test_mm_evict(struct kunit *test)
 				goto out;
 			}
 		}
-
-		cond_resched();
 	}
 
 out:
@@ -1547,8 +1529,6 @@ static void drm_test_mm_evict_range(struct kunit *test)
 				goto out;
 			}
 		}
-
-		cond_resched();
 	}
 
 out:
@@ -1658,7 +1638,6 @@ static void drm_test_mm_topdown(struct kunit *test)
 		drm_mm_for_each_node_safe(node, next, &mm)
 			drm_mm_remove_node(node);
 		DRM_MM_BUG_ON(!drm_mm_clean(&mm));
-		cond_resched();
 	}
 
 out:
@@ -1750,7 +1729,6 @@ static void drm_test_mm_bottomup(struct kunit *test)
 		drm_mm_for_each_node_safe(node, next, &mm)
 			drm_mm_remove_node(node);
 		DRM_MM_BUG_ON(!drm_mm_clean(&mm));
-		cond_resched();
 	}
 
 out:
@@ -1968,8 +1946,6 @@ static void drm_test_mm_color(struct kunit *test)
 			drm_mm_remove_node(node);
 			kfree(node);
 		}
-
-		cond_resched();
 	}
 
 out:
@@ -2038,7 +2014,6 @@ static int evict_color(struct kunit *test, struct drm_mm *mm, u64 range_start,
 		}
 	}
 
-	cond_resched();
 	return 0;
 }
 
@@ -2110,8 +2085,6 @@ static void drm_test_mm_color_evict(struct kunit *test)
 				goto out;
 			}
 		}
-
-		cond_resched();
 	}
 
 out:
@@ -2196,8 +2169,6 @@ static void drm_test_mm_color_evict_range(struct kunit *test)
 				goto out;
 			}
 		}
-
-		cond_resched();
 	}
 
 out:
-- 
2.31.1


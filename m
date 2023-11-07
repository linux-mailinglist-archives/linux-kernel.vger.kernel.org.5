Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2E47E4B7B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344317AbjKGWF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbjKGWFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:05:06 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5E73C07
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:01:32 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJpqk020714;
        Tue, 7 Nov 2023 22:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=zMJzLbouFyv2RVTsLsfrlR2gP3yXNftDrwME+78WkYc=;
 b=1EkMhJVrfl+oOjerPpslH1agBGduW8LBW/Ab7svAdk7OMXqqInFgVNcAuUkVDPuiPqsp
 rk+1mA36BrvIWfIt0QDhjYZNqKHQtvsClnK4/ZAji1xfr2BsIc3zZZWfs9zIFEoYG8b+
 +8y8dYzDm1GIHw2tHZv71xRuN2/sYIECASQjuS8QtfIUAvU+1IoSCwrBehnwiM9PNJgB
 12ZTV+RygOUYUpsnKpv9wTTIeklO/eJLiyZEETcrRBvp506gYQuZYWt2Ci67b64hRRHC
 ofNCueFGyLIBLELbO5fAThrTdX9FLkpv6xRN1lghDP6SLh64fHx1XoYKHzx9lhsGRg8E uA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2202tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 22:00:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIlPk000377;
        Tue, 7 Nov 2023 22:00:08 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1v9kns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 22:00:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjZpnUoQDQyrVKi2yDq5PMUFal/ooiKVRV3J9N3+iwbo59IYRoZG58+4tQLQZ0qkOTyJNS5HTlTZSybCkD4Zb0wZav41huAE9ZmobzMwluYHbQ1ZPbZoy9hnlO53HWS0mVfaK8FmWS9kGSFQBVkBGMlxbRzcZ3LWCLerBaJyxdyyaCARf4BXZQ4le6jstq5Pf5Fl0IwB7IRp7kWPfD1pCg2urM0TPdHwRFbVYuUYh4S5d4lJeWC0NCVcOCrux24B/63couPKMlcxZQpnjroirI/NDZbQEuLKb+kPcB98CktZmKFgn9uX++KhL9ewFcWZboiuCFWFWzY8dFg/t9V5YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMJzLbouFyv2RVTsLsfrlR2gP3yXNftDrwME+78WkYc=;
 b=ebl17F7OVaXwzvitsucNuLOF7rviudOBTTCbk3ED2zqaxFwuStGI0CbZZCP6XBk4sE+gXOpw/q2FRuEzn12Mii8wAcq9Ags8NurnRct+Yl2Wd9C+I07+gcA6bshB50R/oYyKcIZdBLGfbwGaU5SbXR2tcEjXhVCQXZVUk7CGFUHbzMzVO7NhztOdPpP8cb8NoXYeTXmKLA2Sp4E+/H3ntwO0ae2sEA+CJdwcKci3TDOTXvwRzyp4ikWb9jcJ8DEwkAZeg/26nnz+1EvaWF7FkuvtRrRLDXSUg2ueVjfFvKqbfjVRryyl19W75/D04oJXAYZousJW2klfZBBZdKubKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMJzLbouFyv2RVTsLsfrlR2gP3yXNftDrwME+78WkYc=;
 b=d84mPyk+SzBo0CIOALdxMJA9BhCiyv+dWkiSmCHxnIKfyAjCPELMx1bOyO1962UMCYHv2LeZ9ybHNRv2pvakPBnl8LOTA1vqEFW8hBN8/56Z30vwYo/jCTsspmybGJizQpF45Pi4rop2ZiRQqmlJyjXGm830sc1NYmfr+LUVl/s=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB6275.namprd10.prod.outlook.com (2603:10b6:510:211::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Tue, 7 Nov
 2023 22:00:05 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 22:00:05 +0000
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
        Simon Horman <horms@verge.net.au>,
        Julian Anastasov <ja@ssi.bg>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [RFC PATCH 47/86] rcu: select PREEMPT_RCU if PREEMPT
Date:   Tue,  7 Nov 2023 13:57:33 -0800
Message-Id: <20231107215742.363031-48-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0216.namprd04.prod.outlook.com
 (2603:10b6:303:87::11) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: c088578e-4d52-43e0-a1dc-08dbdfdce66c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rMAyWi9vE0v+U517cz8ezNXG+pl7lH41P/aQbw3Q2GlkWTtGD8zXGrsZt/m3wQRZ6A08nLwGKGBCqfsrtAJzntPdI0GgnOpCe4NQxhjBRcTjvUE03HhTaXcMYnX8SBiKgNcRE2QlX3MENuHLZII8Io5TrzM+qyhD5rAlZ7irqwTigFR5QupHY2q/7BMFu/cSWmncJwtj8X6CoiGlPc9Jkze81UFXR+CZp5/dLLWOwyAU0nrPncKIftnBiqzZqy/WrJYQ7tM5k7L3uSM+BSBd27QT50UsanZHUOOzMEAnt2duE566nmk5VTv3uu1YLRPjzkxH5qVqVSttC3kZSTkCoeL9/dGSiXx1oZu+Z9PHpSUdpKviMz4kITZjvfxgxFywATKzJoGVSpu8EmigdDtijUuT8FymQ1QA0BZllNJkRYyjJp6cD6uK6H3PtPNIg5c8pNmh+L+jME26kea9XRZ5ROAN/ClpjQ9Nq5zCKIbgsEp5+UmGrbfn6WCU2jDPqO8HGfYxf7Us1tzXP6Kms6pLnC0iE9CHEVHMjO9W0Ttzm1Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(66476007)(54906003)(6666004)(38100700002)(6916009)(6506007)(316002)(66556008)(36756003)(5660300002)(7416002)(7406005)(41300700001)(66946007)(6512007)(103116003)(1076003)(8936002)(8676002)(4326008)(26005)(6486002)(2616005)(966005)(2906002)(83380400001)(86362001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y/40kaPQWY9wtQOOs4mWd35ZNpUXsiiJaB5ALcXbFVZMfR60ROMC+r3yi0st?=
 =?us-ascii?Q?o/rDIQBT3W1hhlRIUgT0aAAmTBaauMU3dtr6cDax3IpuG3AzRMMyrpRImj1i?=
 =?us-ascii?Q?bT+F9eHQuupdz+cmAiAY4gmmuTMBwSdJJYGJyMOtPgAmmPoOOYliXDGWJK4i?=
 =?us-ascii?Q?Rh/xucwdV8OJ94D+Rhx0zjAM+BHrr00x+/2b1sdtm6mJ22TYGQ4tfhEFqJUS?=
 =?us-ascii?Q?jxL23uQtXimz4K7GLfQn4EhgeakNxsEHZ16F5wAeGRRXr/Dh2me7vwsZ+nPd?=
 =?us-ascii?Q?OVmI37T8tVxbBP26e8PkAvL+gF1DtIhwoX8tfUXDJ7DwBhWaOMdW4DntmP4e?=
 =?us-ascii?Q?kyFbKKWiTBGLrpwSrP6ZsJd3b0KmTqZ3CBIfGK9HPSbSaFGti+sAIpvM+rWs?=
 =?us-ascii?Q?vfHnMHlptBrZZEE42ccSNhLYc2CDQGjIRrTMlbBdDCOtoPgEv//4p4J7bkR/?=
 =?us-ascii?Q?BTrQ8fr/WYxNvEH2wwjfXCGMqPeju+t96hAWDg4grsTno6tm6OwLNSdWaDUy?=
 =?us-ascii?Q?MES2to2dYHklMHoKbsW9QiUG+k1JVPvBI4jJ6HbxiKa52YFvG9G95UwiSxTg?=
 =?us-ascii?Q?ujfxgGUwr71c8RAdN8D3RiqUJvxk+0V8QmCTM1TMUw1BHKwpFjxtNK/g6Nu8?=
 =?us-ascii?Q?YB/joqLVfGryBemZW3r9yHkhUyWjXVWaSY8JI27Li9W/7gWzdBkbUfDv2gV/?=
 =?us-ascii?Q?U+BXPb//e/SA/m5Kzb+mEQiPLNuml5Wo5aCINQeeSpt5NakcZxbwxJaQ6tDr?=
 =?us-ascii?Q?Z/7P2YbFkwWyP8H395yhvAg2bilB5pLMZ0gbw/g2KWk2EfHnfRUfPg51Z1Rc?=
 =?us-ascii?Q?ZxCIn+1zHR4jyZijrqHJWZkZ6J8MzJxYUBS2H2P0c/qyg59kqpN5WIEz73d+?=
 =?us-ascii?Q?sge5thFWkGfakjX7ZT+KWT3iaPDkXnnsHcpwF6Fr4/H8xtSjFFvNO3o8+bQe?=
 =?us-ascii?Q?eZeiwC+jKroMfdZOHRnZA2c52wg3488gyoyb7aP+E3oIWkVoPTfE2w0UYvxX?=
 =?us-ascii?Q?H+BXbJ/fvEhtgadEkgn209anavTZRmrIFJuhox1W/FIyh9V+hE6CVdVOQMim?=
 =?us-ascii?Q?nEyQX2s/FMVk828UfFxCNynwLVNcGruIgidVBamvqEkSyT9qh9u6AaplmQ58?=
 =?us-ascii?Q?c38ngIMI5rHZgOJELUHPSugvyKMKreFJeuxZHSCmvaTHR8lXz79AEvQFbM7k?=
 =?us-ascii?Q?QvlB7oG85E30qRi0T8KXC4GPExqMPIt+YHm2tGi8pqxwIy3NsTYAPHMh86HS?=
 =?us-ascii?Q?DWPOSbkJswBQ/6Y/buj6FHV+yVUlslQJTIN29kU1+aqgcaLH+DQ1beQbwADL?=
 =?us-ascii?Q?nxbJdNT7PtTIoiUXXc5STUVaDLMFHyyzlc+36UVoRlMIO7wkSi78pGEOrrjN?=
 =?us-ascii?Q?4tOz6Pyzc3CtmXskTfCgb6IpagT5KyGTH8bnEJVEGM8830/Y0dJ65CV7jL4U?=
 =?us-ascii?Q?gVi+I88AeIW9JBnsKsYDhfjI4aVlFQ9w8mO9Xmk+l6j0VT+BY3TpDUSEM7u/?=
 =?us-ascii?Q?J+gD0cmEAAb1NXsMrX4o8nJ0MImVaf6GQc8154CxVcANos9lCM8g0U4nNc8g?=
 =?us-ascii?Q?+McG+E66k1CcoL6SIchPpgU3LZz+1WUUMGQFpLCjBfaxGXCXjZekeBP68BLi?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ojujoicF3jZMZ5TdNYQQEXrXwxnednnSdtTQus0of5oDGjmXFOtbRZaeqmzc?=
 =?us-ascii?Q?PEBvFdVPI+URQdNMXUMDIVEhwXiBzUq0il5uiGpyaHFFxitqiv+gpDOCXPIg?=
 =?us-ascii?Q?qqSHxrFO8sDoxiR/v0uhc7twF3hw3E3eEdfz+SVIIWe3pAlGdq8wDA/9h0NX?=
 =?us-ascii?Q?adu1t1lqvO7a0qSlg+ME69GWbCqWIEuyekM6CM19u/mRdtEGClGaJ2hlMOXC?=
 =?us-ascii?Q?Gq2kyCuhNRF3zbN5wTVGsomy1Hi3RBHckJT7PAG6FBZCB/vR3Mkfnm+pdwCq?=
 =?us-ascii?Q?KDwV3XnwofDrBaKMxEjMj4sx+F3lZyElOYg7P62cT2caPXMrJUH6yBbMStxq?=
 =?us-ascii?Q?uO3aSQYjssnMcS9v2RR/47KHeGG0F5z7I9mHbVikUHmjBHXZ/faHLuy9zpxl?=
 =?us-ascii?Q?VewXnrG7q9JtwqwpjoqLCPpO/vmeYmrkiEAsUcBQRH+xMK1FcEnAw6GzkOHB?=
 =?us-ascii?Q?8iwXovslY1k1YB3/4DxgaX3sZVy/N+pw0o7wdDvyI5LepoDsUc/Ty94sTXWN?=
 =?us-ascii?Q?wYasLogKeEdjDv7fLhjht80aSrAO+awA1ld1JR2jpbbGx/tWcLdGkqRzixHO?=
 =?us-ascii?Q?2VgrAW/lahqtnsOxIxJzyiG8INsNpsSpgmFlll3xXCGyqnJy0J2zrq41r7qt?=
 =?us-ascii?Q?5OuFTcBYXmFGoAQ10yjWNILWlmfaBnBNsUDz/3ynjoe/qROoLff+oVBnarVb?=
 =?us-ascii?Q?qkVgMqyDvsHyUBFzcNzO6LpybBFKXLiBf79fYhHeENQ9e1BJ1xysZrjVxWHH?=
 =?us-ascii?Q?uaCVzI1z/uVEz1+iIqfHoS/JpSmZ5uQHX9U0SryMEN6sGmSYlGXU1zWIakCj?=
 =?us-ascii?Q?ADI0dsstjvQI1jjECIPgHms7fYX9CSbeN5yI+w1zYTi39h2PaWPWuPnwp8pG?=
 =?us-ascii?Q?5AliFKCn/D502Fi4cqew3NkQ5rMuQz8wJusFv0h8eIfEH2tPDk0Xp9JUYRs8?=
 =?us-ascii?Q?xsk4j3h42aII9fT3V0cwkU+FmwC0NbL5w18tcZ0CN1MsQkhgMkFKiPpozR32?=
 =?us-ascii?Q?2mKWHQFsI3wmyGVqqgQCuoo8pjMgtOILzh27OMRjNfgaeqVUQtiyGUBffuIP?=
 =?us-ascii?Q?c/BegC+BTzEchZZv/XQKRri3hwzp1GsnMYKMgaCnlRMMuGeYlL6cvDHa/nTY?=
 =?us-ascii?Q?P1l9GBb6FL3yXmdfkekswqI6KdXI0FvQYUNhqPdzJzlfEFehOfpIF2IvMwP0?=
 =?us-ascii?Q?8uIjBbo0NEayHPHOqAanX7EvnHoZKkwsmyVST0jwzej83gYRLLXgdE0VOkzv?=
 =?us-ascii?Q?SNfiOz1nxTV5F0lnJRwz5sCogg9rVjQysY4DtXxnUxqaHhYDsRVEpkwFSmk4?=
 =?us-ascii?Q?9lDg4+0DaaICso/gT09fxfKwC5zXj68J7lgebPiI7ZZBxjDC1YIb8r2mik95?=
 =?us-ascii?Q?jrLRc1PuY5zxAcVDt5wv6BCpLX12iiTclLyuuKCp2QBTgcq4KAMuxW+Exx/S?=
 =?us-ascii?Q?d0yOXl/sa2UZL1oyy9yFLpmmYHouiX/Ayb/Yesu0Jqg4jr4xvRZ/kfvprRhe?=
 =?us-ascii?Q?UvowTiGgu+jlNT4Dyin3Y9yeu+oNHsbbHr2bZkX+Jmca3GE2EQ6/OhO9rcqk?=
 =?us-ascii?Q?n3ikSbPQNxvUn/RKhtBYAqPpMCK0eJ6H8f1E6JYaQ9DmJunEWYzKo18HNSZp?=
 =?us-ascii?Q?6944rKimtLBjk2q4rJUjtmU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c088578e-4d52-43e0-a1dc-08dbdfdce66c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 22:00:05.6166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jegKBUH+FfAh+SAaKqZON/nvITRnAIVz+D06dE8BecvzPzhtAq5yIeM0oNFyLxielW5VvHHsrFPPq2QODw3SXYasenXQlAHyMtxD8EV3KIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6275
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070182
X-Proofpoint-GUID: hEL5cTwxOZyib5HOyaMQchY1SdatqtAM
X-Proofpoint-ORIG-GUID: hEL5cTwxOZyib5HOyaMQchY1SdatqtAM
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With PREEMPTION being always-on, some configurations might prefer
the stronger forward-progress guarantees provided by PREEMPT_RCU=n
as compared to PREEMPT_RCU=y.

So, select PREEMPT_RCU=n for PREEMPT_VOLUNTARY and PREEMPT_NONE and
enabling PREEMPT_RCU=y for PREEMPT or PREEMPT_RT.

Note that the preemption model can be changed at runtime (modulo
configurations with ARCH_NO_PREEMPT), but the RCU configuration
is statically compiled.

Cc: Simon Horman <horms@verge.net.au>
Cc: Julian Anastasov <ja@ssi.bg>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

---
CC-note: Paul had flagged some code that might be impacted
with the proposed RCU changes:

1. My guess is that the IPVS_EST_TICK_CHAINS heuristic remains
   unchanged, but I must defer to the include/net/ip_vs.h people.

2. I need to check with the BPF folks on the BPF verifier's
   definition of BTF_ID(func, rcu_read_unlock_strict).

3. I must defer to others on the mm/pgtable-generic.c file's
   #ifdef that depends on CONFIG_PREEMPT_RCU.

Detailed here:
 https://lore.kernel.org/lkml/a375674b-de27-4965-a4bf-e0679229e28e@paulmck-laptop/

---
 include/linux/rcutree.h | 2 +-
 kernel/rcu/Kconfig      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 126f6b418f6a..75aaa6294421 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -104,7 +104,7 @@ extern int rcu_scheduler_active;
 void rcu_end_inkernel_boot(void);
 bool rcu_inkernel_boot_has_ended(void);
 bool rcu_is_watching(void);
-#ifndef CONFIG_PREEMPTION
+#ifndef CONFIG_PREEMPT
 void rcu_all_qs(void);
 #endif
 
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index bdd7eadb33d8..a808cb29ab7c 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -18,7 +18,7 @@ config TREE_RCU
 
 config PREEMPT_RCU
 	bool
-	default y if PREEMPTION
+	default y if PREEMPT || PREEMPT_RT
 	select TREE_RCU
 	help
 	  This option selects the RCU implementation that is
@@ -31,7 +31,7 @@ config PREEMPT_RCU
 
 config TINY_RCU
 	bool
-	default y if !PREEMPTION && !SMP
+	default y if !PREEMPT && !SMP
 	help
 	  This option selects the RCU implementation that is
 	  designed for UP systems from which real-time response
-- 
2.31.1


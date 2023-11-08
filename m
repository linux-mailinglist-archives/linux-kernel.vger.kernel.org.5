Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1D47E507F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 07:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbjKHGu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 01:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjKHGu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 01:50:26 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A258F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 22:50:24 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJnDM026265;
        Wed, 8 Nov 2023 06:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=RUnnkc1Xa3gntYBHG8/4Ij8lhzqK+mb95z6A/aybiAE=;
 b=07CAYcYsSknUVmLT8nZVkc6PnAgj605ZD9AxiYjz1VCaIWnBkJsQUVRXpH87rR2sQ2sz
 skw2B0SBhW/O9q7oIFOXyhMYkjJVADZMQXub6uBxSjjnpdcDm8fw6muvsGYPnO7xUhno
 VGR9oX97eyhc0XBMMK5NXnuOGNgJ3buNfvnXYKo7OkoRWA8bqejt+7+A7WuXko658XX5
 XB2nnD5SReWqXzsygxWvncRsHkYe981MiHxHB2LCfsugEiCHqqhdzNNbeGifoNkY2Hx0
 KPGWTTfdoj0Xbx86NvuaLpqmihffpEySJt2qi4P1ohoMG+NJPIOKhjhfdHooBrZGZ9gZ XQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w210rxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 06:49:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A86BEIU000459;
        Wed, 8 Nov 2023 06:49:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vsq4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 06:49:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmkZici9juRf02GAmrYMyU5LtIXEIAwh/2MYvFxOsUawINSgOhRRAzps+M1lARPB2GRUY6A7MobD/4M3dBdZDn+50ZkEdCAZxDk/SAq25VJmgPQCF+QyiCgB3lO3jhf+NVTvsIHK7Jl8dtsuMjWNM3G1oDeikpLvpKLA6jT+TZisGfSBdT9rcP1uKMkQ8hrIVxu7KnYB6Pwy+nz6U7cSbwl9k6zS3+ShUVF0w/SLb0HgfoTv2ZpOOc5GfnIA43SJx55vX3hIqxj5FdByTs5qB9ChqK74iLqMkPgKpw8yv3boNi3Z3ikVdNlgErJdFRpaJvZIqw4cTX6ibr60RLYqnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUnnkc1Xa3gntYBHG8/4Ij8lhzqK+mb95z6A/aybiAE=;
 b=loLmn+FJJ+OgH1Rfe6Cj2JuwAHzoKTbJgGLFVB3LZkyciEIqh9RISBHlKT6UbEfXmpWVyS81yy3gokfvmSt5IbhNpwG4q78ygol5RajXeWfAoB44pJZ5YgeUeu0mfobDMbgN67vbrCU/K+71iXBWIKd8Zwticav7Ta/APrQ+Ww4jWIrAwtGQYZhWBAMT4TcW9BwHhtmLuqLPgEpxrtZx+c5hvLuSAjLmdsYq5FD8ofpC4wLDN8B3usLBY1WZ3reYJ63wXt1g5yFGaYyCHnxEwBFDRHaSWUmE3WZ5naltKjOfUo6Ke3I49SNmIzP/PvRXi5VrBXaKlWXQt+kExFJRPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUnnkc1Xa3gntYBHG8/4Ij8lhzqK+mb95z6A/aybiAE=;
 b=m2f7tWV/se9urG8ikDeNZdBymYStaWsosfOAug7F3kfJRnwhLOalRgOiiPmmqPkF5dEu4cCD8HdTg4n2AqyOsxLJXN3/oc3tbwClUUOKZupQCvrC2Dgx+vAtgmf5gXBt/TZCs/RZxdX5B/2CvJmQMIfriR5pHzJVAhdbbPTN838=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA0PR10MB7371.namprd10.prod.outlook.com (2603:10b6:208:40b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 06:49:10 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 06:49:09 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <549c1cba-5cad-7706-de85-d61376db25cc@linux.com>
 <87bkc4vp89.fsf@oracle.com>
 <385909b5-3077-42d4-07ef-7ae915d24b5a@linux.com>
 <20231108001217.068d20da@gandalf.local.home>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, David.Laight@ACULAB.COM,
        richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 00/86] Make the kernel preemptible
In-reply-to: <20231108001217.068d20da@gandalf.local.home>
Date:   Tue, 07 Nov 2023 22:49:07 -0800
Message-ID: <87r0l0rb8c.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:208:d4::48) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA0PR10MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: b5804961-c346-40ea-4c27-08dbe026cf82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ublxAyNZZifZDE3wGvuJQLNzAiXTT8H1dEy1ZRHBfS2CIuZaYQfK2I58DAbNcxeZxYlLk5FNDYvoQ+QhsWRFSSUinE45YVr1lwWwVkfPd1pfjU0z1fU2utMqqiF4jDoiUKNTaU7N+U+KM/JNt7O7FjADKYpzipX2XsHayrS6IjLVV4rvMG7I12BZqdCB240bqXospeiR7SGJtOc5Mc3UwoZKParaYZg4D1U05aTYgCHpU6WRZowQC/dBMHZ0i9zjzPnvtdI64+kPRFeSbMsm3qTG+lAoxv1Z9zHNSIIK+F6r3p0HhANdMTp1vV1f0hGAD9mpec/OqPPuAVDtnfAtTqBQzRrvSqM0pCvUxO+PyExmI8/dgOE3dynyrT19t9PLU2IwUKnYVrYb0ToEpJpNYCq9mFiGwCfkTra2+Y0UQdP6E3E7CK9pTc2FA2kBJo8SaEp0wWN7qwFpv5IUG9Cm5jZfBCKT1esGbHWbhRNJr6x0/06IwoayjjdlTHmtr3ja9TtczgmGKU7DCgwOdDtVA9vS1hsykDScBpPrJxfwhVxtTQcCQa85RVP77JMEgEiDDRTMfbq9c6TvEwuIhtvyAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(66476007)(966005)(6486002)(478600001)(6506007)(66556008)(66946007)(54906003)(7406005)(26005)(2616005)(6512007)(2906002)(4326008)(8676002)(8936002)(316002)(5660300002)(6916009)(7416002)(41300700001)(36756003)(86362001)(83380400001)(38100700002)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MI145OYOaLWPp87crVld6qlR9TNhcnyDz1vwxIlKjmgSMe2FymiGVcoQW1Ww?=
 =?us-ascii?Q?v60vboQN6yU1+I3F8ihzpvt0PLfm6w4kztfQ2J5iCc8tPwB5PHwjKjjdqQC3?=
 =?us-ascii?Q?hwTFaQWgOabfV/WGZBLxrpWsCGszQdOMr6fv0TQEQxIzlPyYM0+5npl7c/vL?=
 =?us-ascii?Q?H1GQJwjwPr4v10eMcPYM4JUO3RCFjYNmtt+I0PMZgXiLodz4AWg1TS0TR8x8?=
 =?us-ascii?Q?bY5MA5hhxjG4X7jydDp9+aT4mw3zIZhjjT4a/3M9WrBpc3cRNLnIX6/Bz/Yc?=
 =?us-ascii?Q?gO8VdMTGtQ5vK9dxtFsXa2esjNA8iOcWXXWLcy7GnIRXq54EXSXJg0B3EVTr?=
 =?us-ascii?Q?LnZRHs0wNZlcK8cEhf90+paWMri0K6ja6kGnMMy4vRmhku/FhYxKGMFezsu2?=
 =?us-ascii?Q?KwHHsxYDEIvrFyjnenji/wrG1jYkdZpV3EQ2VnbwWayVtXP2ILtVAr1KKTV1?=
 =?us-ascii?Q?bPG4xeKLcg7F9VdQa7DPlPX3YCwYsbdKygKspIw2AAJCd6l+YtBksTjg1J4/?=
 =?us-ascii?Q?BtkAB6TSlfLU4fhKyYakfNus6YNO7sNShDOmGhR7cXEXMoAtlu5rm6TySOs3?=
 =?us-ascii?Q?rDC+5xrUgBvFd6YfdjmOLHddHKUHiKUcyvzZPw/+MQQ4Jm1Uq89wyBCNppW6?=
 =?us-ascii?Q?ziypmauoaODRkThmxzu8HT3gxErLZ4xr0VJeJhj0BdEj+XH8sOC+z5MvlSK7?=
 =?us-ascii?Q?xAMILe7tU7Y33D0Sg5G4G9+/ZszDcfTUGxUzG4y644vB+s/3eFy+VZWFXNFa?=
 =?us-ascii?Q?Uoc6joDDC6HIuOUUDEqXo2uHL8QousDLjSa3tAoldI/Eca2nkK6PszN6YDB1?=
 =?us-ascii?Q?obB80nwk6L0LxOvRWZ2onX1Pg2ZE9uVKxANKJEleAL0dpZtfCHw0bOQ9T0NM?=
 =?us-ascii?Q?XdmbF8p3A4bWqiMR0WvCaOKD6tcJTsbxOSAxxnT8L9ovKLPvoNM/St5a5qsl?=
 =?us-ascii?Q?0kza7pIOrFM7VqojAsxpCFS6ANun8WagVILcMZjyCKobR9wbjlLwJdCVKBXn?=
 =?us-ascii?Q?sFriBkAX1FSDmk8SYRrw72aI8mCEFlQZQKWwy000vx9HX+bU8QzjOD9Kusp0?=
 =?us-ascii?Q?9wA6/v7Qv/lGG8PGCXRUuGwIzxFcn9aC47bYXAdCbgyr4UEbrNF5j1Yxe4sC?=
 =?us-ascii?Q?PVyKM6J4Op5K9E5fDrfOHzaJMfCnN/rOD7LDouWmrE8Se35cMfmgA8dapRd6?=
 =?us-ascii?Q?7AbjnHFoNST4ZG7wEx4z1H2SBNavdXCyA6J8N1nTp5fYaCO1ORHHO0KmXzkh?=
 =?us-ascii?Q?GTh7sF17Ouv70+7KcyB3CTOQTkZlXzgC9IDz0gpoPkGjzTtrslNvPyfU5FH5?=
 =?us-ascii?Q?+HVaOypguE/ed1XqUVS5lmxnFvSR13whi9BHO8+jiVE3TaTWZq7sB1HaCo9Q?=
 =?us-ascii?Q?s1pbFrfZqV+r+tjk1fRCbdp3UuZb327wR0Vj69aj9nMhZs9BButVYT7f8Itr?=
 =?us-ascii?Q?c7aeuuNR4LGfC/n9y0YFNHBvX/zvIbrC0zLeb5iPrnFzD9g6QhFHUx/8zR8v?=
 =?us-ascii?Q?6RX2YZskYWaBVT+VJclbLPY2qKcEKuJCG18gIF02NQMEIt2SthsAJNn6/ENB?=
 =?us-ascii?Q?bEzsYwGWBKhE8ruVew6tSVL2jys/gH7582/zyYRluShyZcRL8ucrypRkp516?=
 =?us-ascii?Q?1g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?2Wkd5vIly31rmvUViJMzjyrqkInjbFmPZJfx7B59Dc4+knxKqdyU/iLBAnfo?=
 =?us-ascii?Q?J/qTPVZTWiqeldzx2APTFVgQy0n1HdVeT6G7hvXKo4PY8S6Z+ayNhI5EBAbS?=
 =?us-ascii?Q?6FHM/gWvsntCSsagn/HrwlcTVqiH4ljxVq5K7e+6oDgfqh52L9QuoqfinSt0?=
 =?us-ascii?Q?xuZkfQ0rjylLIrm/WF8JPxh+6m1PSKED5vv64USVN/j8woRSSwEX9N47F2NK?=
 =?us-ascii?Q?EmVhyeRn1fZfzV7N2n2Eo3IKw6+oHFV0cBEwICKstY77q9RTwYlmFPZ1JgLh?=
 =?us-ascii?Q?kJg7cDU/HnJM0mYlTb2UthSz9QyyXPwfUH2HP5xSuWDtAIeYrDzCvWfaRkAj?=
 =?us-ascii?Q?wj2vUnLT+cdy/yqOk5TQNJhczPygqsMEWrDBzK9Mmx4gNKzXpT6yNOcAsZ+Y?=
 =?us-ascii?Q?WgfSL6gXBWWLEDPaxvPDnHxKLS2ntnYuZtqqIihalXl7Dpa1yiy+ogCsKgOB?=
 =?us-ascii?Q?bfF8/yGDhwZTsflC1XAvUoLfbyFxe9FbCzXHubcKxBAtaSNZ5qgPh3cfb/D+?=
 =?us-ascii?Q?5x63OJ6B/voFmeUC37mlDs6I0Q6gpuE+4bzotP88BS2k0tre4u2Fbg/kMy0u?=
 =?us-ascii?Q?SZF6CCraLK7x31tjFcCw7Bc6mgb7i92noPfpEGEpPsAth1u0YMAEHFaM+hEX?=
 =?us-ascii?Q?Kr3LHhx0DRLPPHsxkW8rDzKGlNYD+1/oQppApt5DfstciTfp+9G+P9u0Npgd?=
 =?us-ascii?Q?s7c7bSwqVFZVu7y81w9O4Ih4qcJHkcuaD4Q+USlutNnU6R7512qFgb0qN0CV?=
 =?us-ascii?Q?B/6+XOPLTMNkVOU4nHMI82qPMexWQFT+0FhpiqaulS4r+AOwUiE4037eNHhT?=
 =?us-ascii?Q?LmmQoRfbyblrCKbvNfq+bVHVf33C4ylzBEohbyHwlxS/SZxX/Up/Qn0OQS/X?=
 =?us-ascii?Q?UO1z8MagfBrh4CQoH5qBWKewvwhe3S8Pb56+lcHvOykLsyf10yWcc873j9px?=
 =?us-ascii?Q?IPsliM/Mg2cBuREL2MOz6fK2Kv7gMuB3gmsAimgQFOOkyulo7hC2TL8kZHJv?=
 =?us-ascii?Q?VqHii2nLCkgOThgPAU8xi0HtNQxUn5hN6deWjC3v+7jcN87MfC+gNnJJ+2Nm?=
 =?us-ascii?Q?L+qAR45aFiV0ItdEFXzWHnPb913/QcqbxbW+Ly5GcjEckdLRUaX1o6wAX49f?=
 =?us-ascii?Q?y/5YrStVkESCYQ4nCSGD33QaOGP2zL7wowKJJvFUVcgpU5inXRGHNqY3RLu+?=
 =?us-ascii?Q?04JsUMW1OuRVSP+MgEay9rWXoRrrumPq8PhgB3SB5550m80CLxKpKmjVii/V?=
 =?us-ascii?Q?t7z1kFMDmld3Kj4uDDB3DlXegj/QmpoLtv1yUWlon/qab8o45u2tZOwC+K+M?=
 =?us-ascii?Q?w/CfLIB/7M7+3vdiGsUdaT9EDH3z807KFZeckCE9ZBxg2XSxS9d6jyJTihAG?=
 =?us-ascii?Q?HMp5iP3WWxjQVvU/8FVkuL/GbErL6w1Prei++lqgAi7f9AMmU/i/uxY2S2hl?=
 =?us-ascii?Q?4NKWGuV7kk33saDM3vJeRQzFXle1delczjOgfB3CW4uSZ05olI/tfoG4ZA1l?=
 =?us-ascii?Q?EGEVNDOV2Jt3O5QY1cI4CYxzPTmREeSXUMZiGEi+nkEX/fkadS4ej+neRnVK?=
 =?us-ascii?Q?oEaw0Pa21I5X5qX2YBE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5804961-c346-40ea-4c27-08dbe026cf82
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:49:09.9537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAsmwBYVX8SGQC79q+3cO3UX3WRgUxvvYficw+XBltcIr3mZw1XPZ93NkaXGApKeD/KT32TIo5RFRKf6aKKPLvlXr96jjgTUjeRRn1RF3po=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7371
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311080055
X-Proofpoint-GUID: MDxX6szoIXithGUxz0ILiiL3jJmqby_u
X-Proofpoint-ORIG-GUID: MDxX6szoIXithGUxz0ILiiL3jJmqby_u
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Steven Rostedt <rostedt@goodmis.org> writes:

> On Tue, 7 Nov 2023 20:52:39 -0800 (PST)
> Christoph Lameter <cl@linux.com> wrote:
>
>> On Tue, 7 Nov 2023, Ankur Arora wrote:
>>
>> > This came up in an earlier discussion (See
>> > https://lore.kernel.org/lkml/87cyyfxd4k.ffs@tglx/) and Thomas mentioned
>> > that preempt_enable/_disable() overhead was relatively minimal.
>> >
>> > Is your point that always-on preempt_count is far too expensive?
>>
>> Yes over the years distros have traditionally delivered their kernels by
>> default without preemption because of these issues. If the overhead has
>> been minimized then that may have changed. Even if so there is still a lot
>> of code being generated that has questionable benefit and just
>> bloats the kernel.
>>
>> >> These are needed to avoid adding preempt_enable/disable to a lot of primitives
>> >> that are used for synchronization. You cannot remove those without changing a
>> >> lot of synchronization primitives to always have to consider being preempted
>> >> while operating.
>> >
>> > I'm afraid I don't understand why you would need to change any
>> > synchronization primitives. The code that does preempt_enable/_disable()
>> > is compiled out because CONFIG_PREEMPT_NONE/_VOLUNTARY don't define
>> > CONFIG_PREEMPT_COUNT.
>>
>> In the trivial cases it is simple like that. But look f.e.
>> in the slub allocator at the #ifdef CONFIG_PREEMPTION section. There is a
>> overhead added to be able to allow the cpu to change under us. There are
>> likely other examples in the source.
>>
>
> preempt_disable() and preempt_enable() are much lower overhead today than
> it use to be.
>
> If you are worried about changing CPUs, there's also migrate_disable() too.
>
>> And the whole business of local data
>> access via per cpu areas suffers if we cannot rely on two accesses in a
>> section being able to see consistent values.
>>
>> > The intent here is to always have CONFIG_PREEMPT_COUNT=y.
>>
>> Just for fun? Code is most efficient if it does not have to consider too
>> many side conditions like suddenly running on a different processor. This
>> introduces needless complexity into the code. It would be better to remove
>> PREEMPT_COUNT for good to just rely on voluntary preemption. We could
>> probably reduce the complexity of the kernel source significantly.
>
> That is what caused this thread in the first place. Randomly scattered
> "preemption points" does not scale!
>
> And I'm sorry, we have latency sensitive use cases that require full
> preemption.
>
>>
>> I have never noticed a need to preemption at every instruction in the
>> kernel (if that would be possible at all... Locks etc prevent that ideal
>> scenario frequently). Preemption like that is more like a pipe dream.

The intent isn't to preempt at every other instruction in the kernel.

As Thomas describes, the idea is that for voluntary preemption kernels
resched happens at cond_resched() points which have been distributed
heuristically. As a consequence you might get both too little preemption
and too much preemption.

The intent is to bring preemption in control of the scheduler which
can do a better job than randomly placed cond_resched() points.

>> High performance kernel solution usually disable
>> overhead like that.

You are also missing all the ways in which voluntary preemption
points are responsible for poor performance. For instance, if you look
atq clear_huge_page() it does page by page copy with a cond_resched()
call after clearing each page.

But if you can expose the full extent to the CPU, it can optimize
differently (for the 1GB page it can now elide cacheline allocation):

  *Milan*     mm/clear_huge_page   x86/clear_huge_page   change
                          (GB/s)                (GB/s)

  pg-sz=2MB                14.55                 19.29    +32.5%
  pg-sz=1GB                19.34                 49.60   +156.4%

(See https://lore.kernel.org/all/20230830184958.2333078-1-ankur.a.arora@oracle.com/)

> Please read the email from Thomas:
>
>    https://lore.kernel.org/lkml/87cyyfxd4k.ffs@tglx/
>
> This is not technically getting rid of PREEMPT_NONE. It is adding a new
> NEED_RESCHED_LAZY flag, that will have the kernel preempt only when
> entering or in user space. It will behave the same as PREEMPT_NONE, but
> without the need for all the cond_resched() scattered randomly throughout
> the kernel.

And a corollary of that is that with a scheduler controlled PREEMPT_NONE
a task might end up running to completion where earlier it could have been
preempted early because it crossed a cond_resched().

> If the task is in the kernel for more than one tick (1ms at 1000Hz, 4ms at
> 250Hz and 10ms at 100Hz), it will then set NEED_RESCHED, and you will
> preempt at the next available location (preempt_count == 0).
>
> But yes, all locations that do not explicitly disable preemption, will now
> possibly preempt (due to long running kernel threads).

--
ankur

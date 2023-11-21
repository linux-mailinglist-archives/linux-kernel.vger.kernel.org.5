Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213217F252A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 06:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjKUFSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 00:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbjKUFSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 00:18:45 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798D710E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 21:18:41 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL44upT022624;
        Tue, 21 Nov 2023 05:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=7QwkFKU7Srs86VDqwOXf4gch4Ho+tXNeD+ObOZy9ET4=;
 b=H8112SqsDQ00AvUDzuh//JJyIMovY6zpLYOKG8XGwQaxS8pe02D16jCEmgwFPZuYUa85
 byFK7lZvYikQP03Cxc+LO96+tz/zCN0yvkpfbcofAy8q3MoqrULej9tJsdBe5diBE2c2
 iuOecvCjNZPw0GunQUReZfSFaK/UapC6S4VkYFk5ENSFMbKYG8FC/X3fMZnXLdVM26WX
 3QCgxj8ak1PU7vnLuLCgja2s25FcjHquUVwXNq7TxJzv313yhC2lomHLayyunjgre1e+
 vsjjKc0mG0zjIKEiJtoWRrQuKTMqhCfiZebMXbLxdROMDGwI4CgFaoePb++9KQRxtU2L Bw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uekv2v77m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 05:16:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL2WvkW022675;
        Tue, 21 Nov 2023 05:16:26 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq64jx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 05:16:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8Hhh/5lqbWZpHRuRR1r5wP44dCy7Xv9J1cmPGAznfGPXmW6neiGr8+Inr9JTMfPdUJ7zRFWNWEDubIUPsAeVUs2ZDpTwsU6MYvxml5GeIa/wR2JoYiibCfBDY50FzZRibT/ret3O2P24w209e+oTUp2jJGE9kMf++t2rmERbqcIBwlYT+Ej8ICInS7xtOfqW1lOID51ZiKLJlbxZxYs6uqSaIJjhOodOHRt7KI70aRbmZ7JVRKTLkHMz3q50Oeb1rrBVz5AB0z1/FMiWnQ2dfetk0FCLc9DgIVGJo52xMYngqwOGCExS5/hSda9jj0LK7Ui6x4M2rplJ49AR69XxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QwkFKU7Srs86VDqwOXf4gch4Ho+tXNeD+ObOZy9ET4=;
 b=HrRhYudNKCu4YbhYzkJJ3TtyXcsjYxpAKZ5CQ06jbgZdBz19xkq+A1aqVRo0PUV9VrOSyo4RZs1h3Z1e8SRA3lOdwUG6gBCh7JYxtaDaZ0TczjxNlsLhtI/o7aDHTa40YPW0QPN3gBCMtRlYV9gu8F3nDlUjae7WY5dQjU7ynII6aps0RlyEQ3WGimLx+Png1Chp/zhDMNGkTV1XyfVSpL6ecaiikUPx2W0TN8B1cA4dt1aMxE7uThOeGl6zuoeQl9TO4Mv3YlD0MMxWpS4twYTPq0X7+xannaBQwyKiMMgCZOxxwkBz+SnuMD2z0oe4vH3sPv1jSQcQ34SE5OSUBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QwkFKU7Srs86VDqwOXf4gch4Ho+tXNeD+ObOZy9ET4=;
 b=eW+7ajWssaXEHY5BJDzIBI3aCGZ9B5stZ800Shn1L7d9N+AgMrvO9dPGXlESfBEDK9PGd8VMuDMP1INpu8KBJJL2p8cnf0Pj79PPomKxe5YNlikYIbPs9cB5yYfvNFeVFJV7mJjbXtjsK2Bn6e2ygIW8umMyY7ptI54DfRPd3J8=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB4919.namprd10.prod.outlook.com (2603:10b6:408:129::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 05:16:23 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 05:16:23 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
 <7d85fbde-fc8d-44b4-802e-376a475891e6@paulmck-laptop>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     paulmck@kernel.org
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
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
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>
Subject: Re: [RFC PATCH 57/86] coccinelle: script to remove cond_resched()
In-reply-to: <7d85fbde-fc8d-44b4-802e-376a475891e6@paulmck-laptop>
Date:   Mon, 20 Nov 2023 21:16:19 -0800
Message-ID: <878r6r3cv0.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0232.namprd04.prod.outlook.com
 (2603:10b6:303:87::27) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB4919:EE_
X-MS-Office365-Filtering-Correlation-Id: c15c819d-bd31-4a69-3cb0-08dbea5100aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HOnrdCGoWJ/DUq+PZF4ZfCrKpu9uJS+CVk4/m4TuOv+Rr9gRv/CnQwTBdhVElg/yZSOIzONcXjUQCSz1/fIwc+Wk0+tOcAkqodh+XwZpPDCUYsX9LivDrdFUS7h0QG4VEVwWubAFi6RZJaGvM6VnBCAyrZRxdaUA/a1X1A9SEJ1Cirfk3slefvxdQRjqu/p1GRkxjkNgNtJUBH8CVH+QJvh/0gA//AGu7Qo7/D54ZUdc+a+uGYeEcden3odJqUhfS8bqXTbOYigsD3yzJwEuT0nJMT/F6WbJ86xZwS/5JTEJpCG+NJAFZSjRyszQDkxNOLgecc2bZ1U25SH83KRrsQuDzw4xO5gdZrU/lYoyF1fOM433jZQViJwZwg/6C9kynbatPCFxygf2nooGxY4187Kh0+FAdbxwDgrbx2UFHhqrWPsjlr1G7dL7cgCJ94PpAVBzRUxM3KAKoxkl9atTy7LdriKjF8+j7eTUv3w07RpTYqimfYuAxJx1Fi3q5bdSE2I1O5NhVrUvHm3Vst87My11T3NCTeruDqb7RKH3XMxdEgtCndqntl2hr7QSDK8hPz/l8GpJTCzEMS2HnwgUz/0ATmDa7XjsvGkxkYavtkjphXEKpx0L54fDBS25RH5d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39860400002)(136003)(366004)(230173577357003)(230273577357003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(36756003)(86362001)(5660300002)(7416002)(7406005)(2906002)(26005)(83380400001)(6486002)(6666004)(478600001)(6506007)(2616005)(6512007)(38100700002)(8676002)(4326008)(8936002)(6916009)(316002)(54906003)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HxYKH9iIRR47OHxbJEbK4yBsxoVqqXnmti5VJiWhogTtXPsEgT3OJCnFWIeA?=
 =?us-ascii?Q?MuQE+foHbOqcH4Z47KUH0H+Eef5WPWU9GePywuIzzbZAtah01M3yzqYZZZmH?=
 =?us-ascii?Q?OOE64LJyLnsQb9ck8Usc+HLTxRvCT9kez6n253xoQ3Ib+D7vlCHiVJm4USoN?=
 =?us-ascii?Q?WG6/cRwJ1hZ1DSvEIMIA0MH+wZI2QqsQYb/xYoYGRE5VLNRW8t5UgzoUEZ0Z?=
 =?us-ascii?Q?QjKv4TQODdLdETMuJR1aHrFMyc90sc7gNgAV50hWiXTe99wtM420ugx/Jcdi?=
 =?us-ascii?Q?rXaCDUKDgJsx+zRupdoWefIxzBer2cYgXFPw0DcPqLKQaXINzoOJdERpwlj+?=
 =?us-ascii?Q?H5kA8SYKr6gMDjAynkRLgs0nTGsJiFZ29koDqJABKw3jSujrvFnU36kGBK2g?=
 =?us-ascii?Q?AldZF1+5M9Vxe+RmhlHwdgQ5604CoUDuNwvDGMSoZHLUa2drxoeO5dTGZD3I?=
 =?us-ascii?Q?VuN32dhIbGmmKGNEo2eBkbH+ObOi+7SsugWCnKmO9rGU54uhRNxt876K+e+o?=
 =?us-ascii?Q?F5YtpnajBJgRlSFovqZNvupE5BQ8UNw0C2hnIqiS7Cm2guf/P9oZjBluIPLh?=
 =?us-ascii?Q?O+q3Rody6k7iMlgec6olpSi53hU2h13ibU8Hvnlhh4jJiMLVNzdJQpAy4OI+?=
 =?us-ascii?Q?UvhSyVo8dIHtOz7rxpwQLkQblF2mMKAuZgiVt0vljbxSfWCLt8LiWltPir4W?=
 =?us-ascii?Q?tzUVsooasrN39dmEiPXKnlaRj+jcxDD5D1BZiWM1DTsK3Xlc6wxBrKPhVyHc?=
 =?us-ascii?Q?/2WPnIaEnRGMfOoMavw1EDynyxa6Ju1M6m0KHSboFeRtlxQlNX3FEGAdbD0l?=
 =?us-ascii?Q?BBW6qCvlkxqqRBtVN8Q95e6uzC1XRfSTxwM6V+A38B5Eflq6EVDXOKOOnl9q?=
 =?us-ascii?Q?K0uTnsmnuONrHRaJzGTe2j/2xr7O3z6qr31BTaG8eDb5KJeNcfrhpnNCqfxD?=
 =?us-ascii?Q?fA+i8W+2LxJw/ljE1digKWm6YrDt2jqediy5kVgaBq1VI/l6myeq4XN+uv9T?=
 =?us-ascii?Q?8SJvbEJQXENL1q1k6dCKh14N/4C4D7W/+4UISOiv7agjIcEhEruiob1UNKgH?=
 =?us-ascii?Q?Co2t5LV9PCXOKvY4ZYyMXB2xZMKI55Py/DQ+2261ps1nxTomI+Bjb6xfTOrC?=
 =?us-ascii?Q?nBz0wpKozd/fQmbA7N/L6PdsP92oZq3abjhrsRkc5xTnfyFh1IO751OtPg5u?=
 =?us-ascii?Q?BCHCWDgROxvksyzZsexga9k8Ur8P4aLek7VCaUyNnT0WrGa5uPDCPt4030Aj?=
 =?us-ascii?Q?lpGsd88tcmZPZjLe1ouoNdl7vccuveaPPBDPHv//OXEnly4Jkzlq4pKer/M5?=
 =?us-ascii?Q?pUL75pjUHiGQF/xWPDCEhzCy14mi8KwX4C7d6gDnUJRNMFwMDfJgbYwTDvX9?=
 =?us-ascii?Q?m9+QzjkPxdWvvomK1hNItf5cRfywHPAAHwlbGRXGdAuggLzUAcGa7JDo/UwI?=
 =?us-ascii?Q?0tVeVslNV1gVYNBShD7t/CpLygvrzp0h+qg9uG2lToN7mZpiiOflu35dRrpw?=
 =?us-ascii?Q?I+qfWSPa0xQMGdGXfbPgINRfF7a9uEMxN571lIMLkL9oNJFZDur3Qqk8Q1Ro?=
 =?us-ascii?Q?ZzEJybHJ8/t0nuu18ddT30F7qQAS8bpXH/RZz9Gy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?npueaRjHr06N+8DyZ3mYnxDNjwOQ1ZxY25ApG/3FeCSV1u1KaR4XpiUld6Xz?=
 =?us-ascii?Q?/qsLUZJ+UrAf/pcXW8xLHDteFDvL2jo9QmJ+rYi+5mui3ZNf5TPxzoWoxzb7?=
 =?us-ascii?Q?OBCco/XrnYvCzqpC8LLbTjHbYyADBvAQDGquSsD5JZCBahnvYBvpx9ZzqM1m?=
 =?us-ascii?Q?ALNtUb7b0dl3x0HsUEU8rY4TTlsbZjKHTvrze9Aufvu7fYreqbBAEgIfv81J?=
 =?us-ascii?Q?AxWzkJyrDD6MSRcU8WfQUXF8lBbyJsAaRqpZ1HGBEHUr7Zr54T7JCd8Lkgqs?=
 =?us-ascii?Q?x2pLq3aQ0zJePwS/mxK3P575YRvBaOlYYi1t2z7cIuPkFwEDThk9y75aNCvT?=
 =?us-ascii?Q?2KGPqbA6H0B7606PUIQu1NLW8nHD8KlHwM48qBPtHVHVv48+MyE1Sl7GED87?=
 =?us-ascii?Q?xUHITwB9N0ntleZpai3yejsljC79GXmBslqum3FuHpfVo//7I4vbwao3ChfN?=
 =?us-ascii?Q?jJJNSiMH3KHYoeeOK2ZrHT86q68VsDhE6eNlJhDbTC9VBPpHaV8UGqTbVtfM?=
 =?us-ascii?Q?3icDHcwBViBrF3CWjd8gugpT0ZB0BZUTMTT6rzDpLL7R+T3xjO25LDivWXzZ?=
 =?us-ascii?Q?gd4YFECpe2x9xl3oG8yp/lsl0/hpGgPb9nVrFeCKm4DsubRGVPSPvNl/L24z?=
 =?us-ascii?Q?PxH1hwMtDcJ+1VM78Ikrj6MtHnFzpzMi1+bnm9oxvbRq+VAwSplHfjpdD1Gy?=
 =?us-ascii?Q?jD1eolKOVzin7h5esOOjYBdZGmqPafnq7FZ/EtHwBfDPE+vcVHeEL45JkpjP?=
 =?us-ascii?Q?Tk8jH1HNFYsDjZ3hHvr3CUoE2yGPalTMcDooCZBaR213hGjqbJR7gmxcpH7z?=
 =?us-ascii?Q?caHMmpyV4YdTamIGlKim9JDFHmvVwyjdfk52ZIiHDo8cF4HBGpri9aZgBOjV?=
 =?us-ascii?Q?lDkn1m8CosaOZ1xm0plzAWjjaATbWsIWfsRjgK1nrU20Xemk+Rn1OGErrHVG?=
 =?us-ascii?Q?YdFGxGbWwGkDdCcTJphWWOeFy+Ifc3r4ILlcGhKoLrRYu0H65oUAC6H6E6hJ?=
 =?us-ascii?Q?a5KvHtvDzPLckwTIzVgtPoOojBpTpA6LYeOS5fsxn2x6LOjMdxpg4mJaAzKu?=
 =?us-ascii?Q?PVYx3mhfBeAzcIs8yhb+BJLpscA52bSsrrx2zbL/gGGXANieKXsBk1aAKL4N?=
 =?us-ascii?Q?ZgAyVtgeuZB5g4VsNCtrPfstBdotHEScqLcRgGgSJeLKXy5bpq6D+4QpBJo7?=
 =?us-ascii?Q?U7ZePfvw1niQ8dGTABRDrGMqPrh0rtVXg8FZzD4e70cfQQyc0g1dgRZgoXAq?=
 =?us-ascii?Q?0pGJZynOlo34fCwf/qxJqf6NdqTipWlNhOLPE8YtonNfDDzPDlUStLcwIRX2?=
 =?us-ascii?Q?cp5URiSF8wbLtXDlr/8euwnE6XjGas6DtasOyxIiYqPyJQRQ/8p2lI1Ndj4Z?=
 =?us-ascii?Q?7JYecZhnSnXMMJdFHWOPYjtPe/2HIU49Z/q3R26icJSLUQyrXAD+CEkv6NsP?=
 =?us-ascii?Q?5wYcD7u8tJ3jsgqMziGHKUn2iOukSFTzi7hbiJCwCxdMcwEuNnJhBWk4P7Ab?=
 =?us-ascii?Q?bw17CwE8lVQuzZTnTSF5dqzs3yzuzehOczfG3ilUQ/+X3A/LjJTqakLCL3KO?=
 =?us-ascii?Q?ftG50YZYEES5VzLHQndcCBSCF3bM4X60RaWKKHq7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c15c819d-bd31-4a69-3cb0-08dbea5100aa
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 05:16:23.0840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EI5I/m/k4gZXtpNm0RYS6KcHfYmkyMk0jIvwjTqQ0ZWLsdIZDglHQfGN2SevSrlZlW3+CbgL0zi7Hwr6EEq3zAg1lDHZl+USDe9qnSwqVQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4919
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_02,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=864 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311210040
X-Proofpoint-GUID: jx5vxCnLCJGJu6833JIf8GFGYZxVQVdj
X-Proofpoint-ORIG-GUID: jx5vxCnLCJGJu6833JIf8GFGYZxVQVdj
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Paul E. McKenney <paulmck@kernel.org> writes:

> On Tue, Nov 07, 2023 at 03:07:53PM -0800, Ankur Arora wrote:
>> Rudimentary script to remove the straight-forward subset of
>> cond_resched() and allies:
>>
>> 1)  if (need_resched())
>> 	  cond_resched()
>>
>> 2)  expression*;
>>     cond_resched();  /* or in the reverse order */
>>
>> 3)  if (expression)
>> 	statement
>>     cond_resched();  /* or in the reverse order */
>>
>> The last two patterns depend on the control flow level to ensure
>> that the complex cond_resched() patterns (ex. conditioned ones)
>> are left alone and we only pick up ones which are only minimally
>> related the neighbouring code.
>
> This series looks to get rid of stall warnings for long in-kernel
> preempt-enabled code paths, which is of course a very good thing.
> But removing all of the cond_resched() calls can actually increase
> scheduling latency compared to the current CONFIG_PREEMPT_NONE=y state,
> correct?

Not necessarily.

If TIF_NEED_RESCHED_LAZY is set, then we let the current task finish
before preempting. If that task runs for arbitrarily long (what Thomas
calls the hog problem) -- currently we allow them to run for upto one
extra tick (which might shorten/become a tunable.)

If TIF_NEED_RESCHED is set, then it gets folded the same it does now
and preemption happens at the next safe preemption point.

So, I guess the scheduling latency would always be bounded but how much
latency a task would incur would be scheduler policy dependent.

This is early days, so the policy (or really the rest of it) isn't set
in stone but having two levels of preemption -- immediate and
deferred -- does seem to give the scheduler greater freedom of policy.

Btw, are you concerned about the scheduling latencies in general or the
scheduling latency of a particular set of tasks?

> If so, it would be good to take a measured approach.  For example, it
> is clear that a loop that does a cond_resched() every (say) ten jiffies
> can remove that cond_resched() without penalty, at least in kernels built
> with either CONFIG_NO_HZ_FULL=n or CONFIG_PREEMPT=y.  But this is not so
> clear for a loop that does a cond_resched() every (say) ten microseconds.

True. Though both of those loops sound bad :).

Yeah, and as we were discussing offlist, the question is the comparative
density of preempt_dec_and_test() is true vs calls to cond_resched().

And if they are similar then we could replace cond_resched() quiescence
reporting with ones in preempt_enable() (as you mention elsewhere in the
thread.)


Thanks

--
ankur

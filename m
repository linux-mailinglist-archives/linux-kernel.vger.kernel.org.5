Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F1C7E4C91
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344279AbjKGXMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbjKGXMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:12:14 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EF4199A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:10:52 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJqat022727;
        Tue, 7 Nov 2023 23:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=kFmCq1H+nhZnb2EJiO2RhYOCVAZK5QP5pATpzaaPaCU=;
 b=eK6wq0tmlZQyaJ+AaFpJgGG3djeSjhNpdJK1HL+Bn1vURglM5cAjbJrZTu6nscQFwbjL
 8ehMFieFhJCPhYBcQ/w4hG7Sj9sYRH/cD9NnYk0zxHKKa/+wFyJpb0zW141tmEq7IYRE
 3U2wQKNXJjtyb5skEqH3nb4l0u/5XBeQXGf+eYq/QHgzUBM869eQ58vfUq8Iw56prlOE
 vQlC11sot8r2lGl+dIhOdHe6rKxpGZLOjTh2iyTeobM8Z1VZ4GUlawBWmJXof7lf9eq7
 QgUITHtvEF18o2FhA8m4zVoTIC84Lhmm+n8aTTobHFws9XcZSLKp9wkLFQjlitNk8KJ0 FQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2006g2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N40cZ031940;
        Tue, 7 Nov 2023 23:09:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w2248nk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vq1hWOcYWpn5gFPEzsxvOJA6qQ/Vlj9Jcs+78pld54WjtCZjHq5XlH2vHISBh3N0pual/G9dukmg2IDWIbZdcnuSEZ7mNrUyt2UnLwY/GFqvyT3dRIGHQyIlmdLvQ0CpORnJySmqnIFg48Fu54z+PgIyuov5CnJgUUvCPSSvtUJ5JfCAgVaJopFXQRE96A6JUIGsJs8PwABDyxS9SGKEJ4EZnFaH0lW8FTbkU4CSI07cs+AaXscCfaZPxxLnLclB12f6DKLdNysNprJlsS8tRh9Yk+ethQPJE81bi3zbhCG0IWuXbVzkLQv+pgjX4nsWUWh4QeZc5nOU8IVXaIw6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFmCq1H+nhZnb2EJiO2RhYOCVAZK5QP5pATpzaaPaCU=;
 b=EzlFxtcDbaI1VD6TTChPMotjVtSVeCOhllpJnGqoiRLrTP+1WK6m+LefUyCRrqBr4JkyH03sC2NRQyMwrh+Vta5CJ0TkZgdS2QjswEAfHOgKG0+/wFVzGwVa5XWVhhn1KqIlEK5P34jbefZ7O7P1X2nZykx8P/CsinabGrYvk16z547jHvy/gwy0Q6cTyxm2CQcDqPW2cRHGJ6EsA5I3Lsr2b4O/Xgthg9Ov0rxnavSLPteQmHZ/q+2XoZdxduAHkW1NEGaOGrhb6k4tNvwwYkNqHYCageN87tMw3vVCQRExqH1qLs4nTe21o5zuk2SRNjrJm7UZ6T2Q+tZZQAAAqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFmCq1H+nhZnb2EJiO2RhYOCVAZK5QP5pATpzaaPaCU=;
 b=bGKSKmqChEWukNmhPz7y0WI0fxyzWDfdhIS3sd+GIgAdUF9jraSDaArao6zO4h7UblYquuwT54rxLO1cd70+zGPOTCTmz30gKHWx821CR2IEjHQP+PbmdhazYc7mNHI2Mf8U10NeFFBo9P5JX6JPuX/EBdB57TPwLTaLAUWcoLI=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 IA1PR10MB7261.namprd10.prod.outlook.com (2603:10b6:208:3f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 23:09:37 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:09:37 +0000
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
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>
Subject: [RFC PATCH 78/86] treewide: net: remove cond_resched()
Date:   Tue,  7 Nov 2023 15:08:14 -0800
Message-Id: <20231107230822.371443-22-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:303:b6::11) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|IA1PR10MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: d66ffbe5-a225-43a6-481b-08dbdfe69d16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pAfVKmd481pkxaz8vJ9RPb9S2uQErN0V8vG/tXcKzqXERuWFjDfr1Vt7wxfJnjYJnUw8iB8uqDeyy2/xDOWVZGis5Ok4KCYF3kQLA3aCKbU95EtYwOZAEk1XAeiBuwsinzgOIgSmQ42/f3zIovvjt4g7G852TDk/KWtsN7nc4+U5vr7cykURUkpqLNDY/47BhrjuYqHiOP1OeGp8XQecG4RuFBK+2huXUMjflkb9zBxQkcADEuuIVfvIrLlosXVLyMkFHmAUmKD1+SKQWBogm82B5i5SF3qo4lHdHAE+aPhjxTuLgzPthA7xfCezEK0M5edtyT9Mp2AFYxFBHetCKmOvehbpKUzQ15KEFwUfdpFl5ZKCwyhrLY7LZA1xdMdEUyypILRh/jGmUlQ4dNuq7Qgcd/RfzqUYZIhDOLUnb+BWianT0g8gozAiKS7rMnXj/Vv93Vmg0A0QYJrw67EogtOQPAyQHwAGQ8nH/dWP+aB1LD9uJBJiaUAUqUbvHseyIab7qnqA4K0nVfp4ydUQiQmTMDbxa1fvlDBqwj405fI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66899024)(30864003)(6506007)(478600001)(6512007)(2616005)(6486002)(966005)(6666004)(7406005)(36756003)(103116003)(38100700002)(86362001)(1076003)(41300700001)(7416002)(5660300002)(316002)(66556008)(66476007)(83380400001)(2906002)(54906003)(26005)(66946007)(6916009)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D+BwehR3No+u16UZ72r2X8hNpNoKvTf+pek1vtGvVMaUWkBvwfF1S7mzfb1z?=
 =?us-ascii?Q?bbQkoqDsMS9UBrlw9OudBOvYdYBTNjXCC7WWOnkA+0+GV9G9LqEEbizrLT/o?=
 =?us-ascii?Q?/9RNejZZcQlpiO2aNvVojLMGCsS1V16XKwMmT4m+GyU7wHPoUxlISuG5i4ZB?=
 =?us-ascii?Q?u0nWnTexy11SsXF79c+emWFKo2SQt8KrKwPoVOGKi1xw6RSaB5zgdadyIynT?=
 =?us-ascii?Q?rgH7a92WSl0BkMNXZzuj2nvmpEVfBF1P8fko2YCmNUsPLvZSq+aoTxDZqGPm?=
 =?us-ascii?Q?o/BHa2aU4uoBmRIYh5H4yezdBHN33XKb/+DHZn0xdoUXRTKCIdd+nQOJU6O5?=
 =?us-ascii?Q?mxmLoeL41239LrXaLYSldpmjPji6nykSK32s8m46xX+bZe90M6upAW6DsYFz?=
 =?us-ascii?Q?V0s8a3o98dNKhvEA5hZ3qtPQzONfX8dmwys8GD9c7BNjkQ3YP8tvEOaOnMwb?=
 =?us-ascii?Q?94czkCA8UoGM9nv0YjCk+QXXJSjq6B/1BKev953qxDERjCsNtWtHn+H8hinA?=
 =?us-ascii?Q?LxeqpcBfQFMnVGwE4DNL1//UFjIL/TjQfS/PC51u9Mf+1Z0Ig1J26K/BEW+G?=
 =?us-ascii?Q?o+IJQjofF5NjE/y2woLpx9dAfQ8gSoh1HWepq4sg2aH31yfWO+/QfwdThLJt?=
 =?us-ascii?Q?xrcZbYha6Znde9epeQGZD7x+zelb4jt9B+yOvovhVHGi1EysWbXUHY8PyH8C?=
 =?us-ascii?Q?mdCHL3PNTNo0fHnozto5CitPjiT7uXLVickSjzxsSA9cZZtpkG01Azm3PtsD?=
 =?us-ascii?Q?5pj6NwXRD/IlsjSM68NQBsw8AFnT6dIMXrS1HddTItAdCHY+AL8GD0HmfSVD?=
 =?us-ascii?Q?dtOfPPDl9/2sebNM7CwnwKcBzZZ8+7OslS94l36RIQHB8LXzW6yKFbm+S996?=
 =?us-ascii?Q?dBbnshxKTR2MWcTvTKGpnwONHE3lBV8lsBJNemFSPfx+8jAM+umLQa1hfse/?=
 =?us-ascii?Q?NYCBFv8MLndPPs2s91cvcNhiiMQgI8an1iE9ijwPKPsBUZoEZq4sasyy/mPL?=
 =?us-ascii?Q?VnMWW3a6nIcc4d++gnfcdeJ2ZOGnUjt5asSNt+l5SrLwaCS+fIXr2czI0sJC?=
 =?us-ascii?Q?3v6ii7EIlHfyrs4p68sDqM8Pip2yWfvId9e7dWMX2ZhWz/vUYA/zc1kgJwEZ?=
 =?us-ascii?Q?gH/JM2dKbf89D4feo726weJexwiVm350Jht3/XQpESiwq4wVTI8kAfGzOEDN?=
 =?us-ascii?Q?5NGkol/zeEMBjeUk4v7a4jI5eHhc180b7mpEEdbioO1EHwiXcwGVFCT3e4kM?=
 =?us-ascii?Q?4ulRv6GMcN4koqkRBd2mZxLPaWKDUI/6PtuIjIK5bLlnox65sUAAK+SXzb8n?=
 =?us-ascii?Q?EzxEONanbd1yfT42GymO5vQDK4I97UUNM8gMRu83ENU5dmBUDCRV9efVgwsG?=
 =?us-ascii?Q?MSX6hknUZDVmPs047dCis8rhyfv2nss2KgXYL2/KcN+yHQITx2FdSks/7ht/?=
 =?us-ascii?Q?zyWcFj1FhkU8eru9nymK/pipb7MBRb5ALladffsSViQ0k+ISaqekfNcDBs5p?=
 =?us-ascii?Q?QnMzYzZ91Yua6zNkv4libzD0nnbqah9zTXvnq4Xk44umlQkOXNCVZe+7Wue5?=
 =?us-ascii?Q?2azy6ndgO6hNx1VDzJtAECWnm/LcNrbevqKCrZ6FyTCooRpnhBYnn+NVQ08+?=
 =?us-ascii?Q?3A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?6EvLxdTxYm1dstVGzD9DWBy3kN5nHClZUkaxwz+Y+BkYA90NpbXD46KvMhRf?=
 =?us-ascii?Q?pOHqRzgNQz8d6W88GHEreGRKxWsFd2WzSDCLKdx/z1zeqNSB3EhyH/xSNVuF?=
 =?us-ascii?Q?hJKzM0SeliNcVbWR/tc0JtAjNiUc3mUJDKG46zTjtbxin6sLU1cmu9tCdnLD?=
 =?us-ascii?Q?X3ujJRDLgD6W9vKk9+JEGssQUDN47B+hNaRGMeIT2m7hYForJScUA4RANQFH?=
 =?us-ascii?Q?Md26u4as4wxuI69eEuBzMVTZYUEmTUBuXLvbbgkj8MKV37Q1wretbFoO+sgc?=
 =?us-ascii?Q?rtruQBQbtj7efoS+Kf+gxEOFZOxRzaLtZggfxi3nhiEq5DrKcfYq+3ukN7D8?=
 =?us-ascii?Q?Cw8hI+/4CPl2yE6lZeKy+Si5mRjXhkXIocaVT4JKX5up3o4l2iOe/FhoVaYU?=
 =?us-ascii?Q?j7yOlc+dRgr0cp/z6eeLapTTfxVJAFR6Jo7DxSBXqVVJKpOKINBl9rqwJOL7?=
 =?us-ascii?Q?OYIuxrycEY8USBxv90UXcJCd1JVi1+rQjjJLRddYU9JIH6vDx4dBWLQR0yDz?=
 =?us-ascii?Q?Lyr1luUBiwg5b+OeoYvLb67rP841doTokNcbtc7FEXZjYqqgN8XbEHst3LgO?=
 =?us-ascii?Q?Zw+UvSCzEJ9aU+W5hhdDbgSJ1oeApch4uFCsZa06eql8Qa7XZg9vmDQw7D+s?=
 =?us-ascii?Q?fB2qlUuBXfPc2mTbZN0An8+deKQ7tf6T2myYhZ9RYC1aKLZVTUmtPzIX2tlZ?=
 =?us-ascii?Q?Wb+uXRZCMF0Wnf3WOlP9TJKwu9bV2li24Afr7cxv++UYqPPwHKnvd2unwB82?=
 =?us-ascii?Q?1D9CEJyOLMzJnxdXP2fBmZE+Tr0iUOmuYlUUfMZ8I7OxdDjMwI7UR6Xc2ivH?=
 =?us-ascii?Q?rStDeonczIw2XSz8xkRpkWck31ebWVrx3qeVIQs51WvKRBauwNsUd19e10GI?=
 =?us-ascii?Q?E5a4/j2mCHf6tavxYQta/BU4HmBAWiZXDb1JcQ+JYDZNwBraHkCpjnhxba4E?=
 =?us-ascii?Q?cAWitaRlrhi8GVgyy+YBNQ0PKL0pHReDtkKiz3g4n4el78A6HxB9hQaFkTTe?=
 =?us-ascii?Q?LTFgK3KoA1E51oGF1W2vhYoVIxnrPVrfJEsccn7DiF626NGYcWISvPO9fzkI?=
 =?us-ascii?Q?igMGAnjeJcSLWWGdmGEVRVcB8QxoR2a1417PWtw38voHTvAbcUj3wIYFTuZg?=
 =?us-ascii?Q?r5sG9eKbfrme3p4sQyVE5OEn/ULrn+FuVrO6K1YpvRDBPO9ny900Y+e3D+ej?=
 =?us-ascii?Q?YlsbHFuyGw6AU7qcAdOTMCwLPs16wj8MC8HCbGQvoN84VBBZNM++35862asG?=
 =?us-ascii?Q?dYFs5VB4oTbFNw4Hvi7Yx+44nUJW6QivznRYiLWDoocPwW/Ux9jKl5FZec5Z?=
 =?us-ascii?Q?jYLhjEdjDWm/uIBHf0cMEKHmrRV3m1/mBjzuzoUXyFO8dVPp09KVNDCB6d8s?=
 =?us-ascii?Q?IcBW353GiW6DwIKeHduQy2cbUJc34xlmKKNQi19+Qz+hL0OzKQ4JCAAUPXql?=
 =?us-ascii?Q?0cD6YlcHZsn4xYBJ5ROHbD/KbZAfElntDA35T55ycd7gsXpgFd6I84RGLu34?=
 =?us-ascii?Q?1nP9rffkgjdwNfv3XrG2Oc+qlHMylhqNVMHopdRXbrH+P54CfjHdJzJvNMiU?=
 =?us-ascii?Q?wbx35Z9B/2Y/CglgTC4XI/hhL+ZyPQjreh7CiWv6oGUabCou0h1/3u9cdNvJ?=
 =?us-ascii?Q?A4cTVI2OZ5D9GBWOsLIKMyp5Akw/Sm7zpa9ifIYmM0vXdDynVhbd+QM/B9OE?=
 =?us-ascii?Q?FEJCsjvBfygqKKRGs5spK6Z4q3doWnOrFRXJMoNC0VJuoP+3xM07qTwB1KaK?=
 =?us-ascii?Q?YuQGPuCL5Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d66ffbe5-a225-43a6-481b-08dbdfe69d16
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:09:37.6001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+VlHFYBCjS12SXPk3rN8erFoEcONf7hnv3ljQQPzyA9cFrZuUtkPagKWoo9nQuN3EoaUHlj5uVwbNhXMp2OJKTHsZzJIr3eqpscfKfcWsQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070189
X-Proofpoint-ORIG-GUID: FTgqnyJL450oKGOcFHsMoTV8V8WaEOSl
X-Proofpoint-GUID: FTgqnyJL450oKGOcFHsMoTV8V8WaEOSl
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

All the uses here are in set-1 (some right after we give up a lock
or enable bottom-halves, causing an explicit preemption check.)

We can remove all of them.

[1] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/

Cc: "David S. Miller" <davem@davemloft.net> 
Cc: Eric Dumazet <edumazet@google.com> 
Cc: Jakub Kicinski <kuba@kernel.org> 
Cc: Paolo Abeni <pabeni@redhat.com> 
Cc: David Ahern <dsahern@kernel.org> 
Cc: Pablo Neira Ayuso <pablo@netfilter.org> 
Cc: Jozsef Kadlecsik <kadlec@netfilter.org> 
Cc: Florian Westphal <fw@strlen.de> 
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com> 
Cc: Jamal Hadi Salim <jhs@mojatatu.com> 
Cc: Cong Wang <xiyou.wangcong@gmail.com> 
Cc: Jiri Pirko <jiri@resnulli.us> 
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 net/core/dev.c                  | 4 ----
 net/core/neighbour.c            | 1 -
 net/core/net_namespace.c        | 1 -
 net/core/netclassid_cgroup.c    | 1 -
 net/core/rtnetlink.c            | 1 -
 net/core/sock.c                 | 2 --
 net/ipv4/inet_connection_sock.c | 3 ---
 net/ipv4/inet_diag.c            | 1 -
 net/ipv4/inet_hashtables.c      | 1 -
 net/ipv4/inet_timewait_sock.c   | 1 -
 net/ipv4/inetpeer.c             | 1 -
 net/ipv4/netfilter/arp_tables.c | 2 --
 net/ipv4/netfilter/ip_tables.c  | 3 ---
 net/ipv4/nexthop.c              | 1 -
 net/ipv4/tcp_ipv4.c             | 2 --
 net/ipv4/udp.c                  | 2 --
 net/netlink/af_netlink.c        | 1 -
 net/sched/sch_api.c             | 3 ---
 net/socket.c                    | 2 --
 19 files changed, 33 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 9f3f8930c691..467715278307 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6304,7 +6304,6 @@ void napi_busy_loop(unsigned int napi_id,
 			if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 				preempt_enable();
 			rcu_read_unlock();
-			cond_resched();
 			if (loop_end(loop_end_arg, start_time))
 				return;
 			goto restart;
@@ -6709,8 +6708,6 @@ static int napi_threaded_poll(void *data)
 
 			if (!repoll)
 				break;
-
-			cond_resched();
 		}
 	}
 	return 0;
@@ -11478,7 +11475,6 @@ static void __net_exit default_device_exit_batch(struct list_head *net_list)
 	rtnl_lock();
 	list_for_each_entry(net, net_list, exit_list) {
 		default_device_exit_net(net);
-		cond_resched();
 	}
 
 	list_for_each_entry(net, net_list, exit_list) {
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index df81c1f0a570..86584a2ace2f 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1008,7 +1008,6 @@ static void neigh_periodic_work(struct work_struct *work)
 		 * grows while we are preempted.
 		 */
 		write_unlock_bh(&tbl->lock);
-		cond_resched();
 		write_lock_bh(&tbl->lock);
 		nht = rcu_dereference_protected(tbl->nht,
 						lockdep_is_held(&tbl->lock));
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index f4183c4c1ec8..5533e8268b30 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -168,7 +168,6 @@ static void ops_exit_list(const struct pernet_operations *ops,
 	if (ops->exit) {
 		list_for_each_entry(net, net_exit_list, exit_list) {
 			ops->exit(net);
-			cond_resched();
 		}
 	}
 	if (ops->exit_batch)
diff --git a/net/core/netclassid_cgroup.c b/net/core/netclassid_cgroup.c
index d6a70aeaa503..7162c3d30f1b 100644
--- a/net/core/netclassid_cgroup.c
+++ b/net/core/netclassid_cgroup.c
@@ -92,7 +92,6 @@ static void update_classid_task(struct task_struct *p, u32 classid)
 		task_lock(p);
 		fd = iterate_fd(p->files, fd, update_classid_sock, &ctx);
 		task_unlock(p);
-		cond_resched();
 	} while (fd);
 }
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 53c377d054f0..c4ff7b21f906 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -140,7 +140,6 @@ void __rtnl_unlock(void)
 		struct sk_buff *next = head->next;
 
 		kfree_skb(head);
-		cond_resched();
 		head = next;
 	}
 }
diff --git a/net/core/sock.c b/net/core/sock.c
index 16584e2dd648..c91f9fc687ba 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2982,8 +2982,6 @@ void __release_sock(struct sock *sk)
 			skb_mark_not_on_list(skb);
 			sk_backlog_rcv(sk, skb);
 
-			cond_resched();
-
 			skb = next;
 		} while (skb != NULL);
 
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 394a498c2823..49b90cf913a0 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -389,7 +389,6 @@ inet_csk_find_open_port(const struct sock *sk, struct inet_bind_bucket **tb_ret,
 		goto success;
 next_port:
 		spin_unlock_bh(&head->lock);
-		cond_resched();
 	}
 
 	offset--;
@@ -1420,8 +1419,6 @@ void inet_csk_listen_stop(struct sock *sk)
 		bh_unlock_sock(child);
 		local_bh_enable();
 		sock_put(child);
-
-		cond_resched();
 	}
 	if (queue->fastopenq.rskq_rst_head) {
 		/* Free all the reqs queued in rskq_rst_head. */
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index e13a84433413..45d3c9027355 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -1147,7 +1147,6 @@ void inet_diag_dump_icsk(struct inet_hashinfo *hashinfo, struct sk_buff *skb,
 		}
 		if (res < 0)
 			break;
-		cond_resched();
 		if (accum == SKARR_SZ) {
 			s_num = num + 1;
 			goto next_chunk;
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 598c1b114d2c..47f86ce00704 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -1080,7 +1080,6 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 		goto ok;
 next_port:
 		spin_unlock_bh(&head->lock);
-		cond_resched();
 	}
 
 	offset++;
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index dd37a5bf6881..519c77bc15ec 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -288,7 +288,6 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
 	for (slot = 0; slot <= hashinfo->ehash_mask; slot++) {
 		struct inet_ehash_bucket *head = &hashinfo->ehash[slot];
 restart_rcu:
-		cond_resched();
 		rcu_read_lock();
 restart:
 		sk_nulls_for_each_rcu(sk, node, &head->chain) {
diff --git a/net/ipv4/inetpeer.c b/net/ipv4/inetpeer.c
index e9fed83e9b3c..d32a70c27cbe 100644
--- a/net/ipv4/inetpeer.c
+++ b/net/ipv4/inetpeer.c
@@ -300,7 +300,6 @@ void inetpeer_invalidate_tree(struct inet_peer_base *base)
 		p = rb_next(p);
 		rb_erase(&peer->rb_node, &base->rb_root);
 		inet_putpeer(peer);
-		cond_resched();
 	}
 
 	base->total = 0;
diff --git a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_tables.c
index 2407066b0fec..3f8c9c4f3ce0 100644
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -622,7 +622,6 @@ static void get_counters(const struct xt_table_info *t,
 
 			ADD_COUNTER(counters[i], bcnt, pcnt);
 			++i;
-			cond_resched();
 		}
 	}
 }
@@ -642,7 +641,6 @@ static void get_old_counters(const struct xt_table_info *t,
 			ADD_COUNTER(counters[i], tmp->bcnt, tmp->pcnt);
 			++i;
 		}
-		cond_resched();
 	}
 }
 
diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index 7da1df4997d0..f8b7ae5106be 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -761,7 +761,6 @@ get_counters(const struct xt_table_info *t,
 
 			ADD_COUNTER(counters[i], bcnt, pcnt);
 			++i; /* macro does multi eval of i */
-			cond_resched();
 		}
 	}
 }
@@ -781,8 +780,6 @@ static void get_old_counters(const struct xt_table_info *t,
 			ADD_COUNTER(counters[i], tmp->bcnt, tmp->pcnt);
 			++i; /* macro does multi eval of i */
 		}
-
-		cond_resched();
 	}
 }
 
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index bbff68b5b5d4..d0f009aea17e 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -2424,7 +2424,6 @@ static void flush_all_nexthops(struct net *net)
 	while ((node = rb_first(root))) {
 		nh = rb_entry(node, struct nexthop, rb_node);
 		remove_nexthop(net, nh, NULL);
-		cond_resched();
 	}
 }
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 4167e8a48b60..d2542780447c 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2449,8 +2449,6 @@ static void *established_get_first(struct seq_file *seq)
 		struct hlist_nulls_node *node;
 		spinlock_t *lock = inet_ehash_lockp(hinfo, st->bucket);
 
-		cond_resched();
-
 		/* Lockless fast path for the common case of empty buckets */
 		if (empty_bucket(hinfo, st))
 			continue;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index f39b9c844580..e01eca44559b 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -281,7 +281,6 @@ int udp_lib_get_port(struct sock *sk, unsigned short snum,
 				snum += rand;
 			} while (snum != first);
 			spin_unlock_bh(&hslot->lock);
-			cond_resched();
 		} while (++first != last);
 		goto fail;
 	} else {
@@ -1890,7 +1889,6 @@ int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 	kfree_skb(skb);
 
 	/* starting over for a new packet, but check if we need to yield */
-	cond_resched();
 	msg->msg_flags &= ~MSG_TRUNC;
 	goto try_again;
 }
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index eb086b06d60d..4e2ed0c5cf6e 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -843,7 +843,6 @@ static int netlink_autobind(struct socket *sock)
 	bool ok;
 
 retry:
-	cond_resched();
 	rcu_read_lock();
 	ok = !__netlink_lookup(table, portid, net);
 	rcu_read_unlock();
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index e9eaf637220e..06ec50c52ea8 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -772,7 +772,6 @@ static u32 qdisc_alloc_handle(struct net_device *dev)
 			autohandle = TC_H_MAKE(0x80000000U, 0);
 		if (!qdisc_lookup(dev, autohandle))
 			return autohandle;
-		cond_resched();
 	} while	(--i > 0);
 
 	return 0;
@@ -923,7 +922,6 @@ static int tc_fill_qdisc(struct sk_buff *skb, struct Qdisc *q, u32 clid,
 	u32 block_index;
 	__u32 qlen;
 
-	cond_resched();
 	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*tcm), flags);
 	if (!nlh)
 		goto out_nlmsg_trim;
@@ -1888,7 +1886,6 @@ static int tc_fill_tclass(struct sk_buff *skb, struct Qdisc *q,
 	struct gnet_dump d;
 	const struct Qdisc_class_ops *cl_ops = q->ops->cl_ops;
 
-	cond_resched();
 	nlh = nlmsg_put(skb, portid, seq, event, sizeof(*tcm), flags);
 	if (!nlh)
 		goto out_nlmsg_trim;
diff --git a/net/socket.c b/net/socket.c
index c4a6f5532955..d6499c7c7869 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2709,7 +2709,6 @@ int __sys_sendmmsg(int fd, struct mmsghdr __user *mmsg, unsigned int vlen,
 		++datagrams;
 		if (msg_data_left(&msg_sys))
 			break;
-		cond_resched();
 	}
 
 	fput_light(sock->file, fput_needed);
@@ -2944,7 +2943,6 @@ static int do_recvmmsg(int fd, struct mmsghdr __user *mmsg,
 		/* Out of band data, return right away */
 		if (msg_sys.msg_flags & MSG_OOB)
 			break;
-		cond_resched();
 	}
 
 	if (err == 0)
-- 
2.31.1


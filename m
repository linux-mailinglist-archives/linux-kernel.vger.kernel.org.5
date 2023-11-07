Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45227E4B3F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343684AbjKGV7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjKGV71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:59:27 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C0F10D1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:59:25 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJLZw028111;
        Tue, 7 Nov 2023 21:58:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=05a/YnKdi4LgWgtnGSqIsbNgxNTD61Wh2OdNihh31Hg=;
 b=JFxoWFS6y9ak6XiGNiBWkfzP8/V5gdnj/pSVrwpkjDTzPhxF/r4CAlYKUp5Peqb9EBcF
 SEltDgf80hShsf9Qd4ru/7QXx0DH4VhwPZUYdEnzLxynN65wctHhGOWT7GFET9z9U8FX
 nh2UpUeeeetUN86cehWdG2wuNt/tIR0yEVvc3IFZcnP8Cx2Ht8+kHEQSjf+OWs3L1edY
 +MikgTjsDx+E3tDLY23RxBV6m1pZwpxB9q89TiW/uEI7LACn2rilEDFGRm/YiVLNmGTR
 iK57hMJ4sZFeCwMQmLUWceU4ry3tcvcPHbfIG4MNnTMLqQ1IxDcNBhfa6ocRRd1PVv6x /A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w230299-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIrHf003903;
        Tue, 7 Nov 2023 21:58:21 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vshdn-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJSiqpnWHHLNvMAoVBjEUG0mhCeVCJpWwKslW04SpBjfea4XoHGDcEXLd12htNuoN3KvkU1FNrhensDwbZsAejq+tq30cR+ZBXzxNqU4X1+Yu5t07qHdSUxy0aosqEHVG1oE/E7TWXNepFPqt3sh5yan5RL4Z5IiNgtffndpZWPP/sAOiW4h5ojlLphEYVmlXkxZLobDlu0pYOS3BOXH1Iyj3OEeM03JfpLUzpLDrksR0xZnOYTbGXwN1a0ZV13rkxc+dxQF7Dcd5QkjMfxdpiFDbMWe+j4LZAD80SKz+UaVWDLiwllmYiC6gTAA6WJ5OFmyAkL4qrtsLAQDnd8S4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05a/YnKdi4LgWgtnGSqIsbNgxNTD61Wh2OdNihh31Hg=;
 b=Sydn4grmQhp9EYEyrd+iv9FI6fT1Np9aHPZDVzVaKjbaWvQJLvjKETZ3nkZtlj7BeJ0JgazHqCvIHve2JNvxZyUg8XKfWYSuXPWpZai2QPr4ZFnmGawOixS3jHe7aEztMAr0BAfRn+tSsi+pMJHl+8b8tNNqJiDCGSVlzzOPw3OQfYPG5o4mQjizyg3s7uoxHsAVtKSUTUcpmOa6GjLuXW2qJjHlQFFDqbe1fPmrARFkNb6FLiyg0svFhumbe6jsqWie6bhFE0NG4Y6c2JMAuemUH3gARxtnMfSbYfjvwdYT2nZOyqaCx+kfCrO09ETYUmfkkTnn4Qcqc3gZnpc/CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05a/YnKdi4LgWgtnGSqIsbNgxNTD61Wh2OdNihh31Hg=;
 b=Z1B4RG2lMj62/CjdGe8JvGMytscATerlaErz/nyzKuLoX0WvmB+Smw+5bsZRGWkmtmBkk+L+/soSkzmheqYfKqz0KAAmv6cEwXsqLbRKMRF2VLYVv/JFfX5fjGhoh2rkaj4FHEouB6zO+dbLnaDUpgXJ+cBrUJCtKuznEjRrPQ4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CYYPR10MB7651.namprd10.prod.outlook.com (2603:10b6:930:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 7 Nov
 2023 21:58:14 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:58:13 +0000
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
Subject: [RFC PATCH 10/86] Revert "sched/preempt: Decouple HAVE_PREEMPT_DYNAMIC from GENERIC_ENTRY"
Date:   Tue,  7 Nov 2023 13:56:56 -0800
Message-Id: <20231107215742.363031-11-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0276.namprd03.prod.outlook.com
 (2603:10b6:303:b5::11) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CYYPR10MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ea3c12f-57cc-48e9-3f9c-08dbdfdca3d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J1qWcMTfmW823oOfMF677F1HSnfr8dI/MNs1gJgw2PYExtGieF9rHz23gQG+N/rOf1AEI84Dfqbui348LxCqjgcmPdwztzvKbUrnox19VilmI3+rt1ll885rbQT+FrZgGBEATMLSUUOY7ilhAbFm4DngJ+qn5L7Vc1zRyGW5t6ad8TXrR56G+bYnFTVZhd6a1OQ+8BKHySLsw3yHRjEHeI5z++V7/o8TJ9CoxjzAVRLVrSU1Z4mqZxIYvtcCFIMiQH7uBb5KdDlHB7bD9y1D2WewQPJ5S6ifLzAU8uOqMCl0/sx4epogWY63+z7N5FRlyanu0+EtUy/aZy4B29aqUQRaiBq5vesKr0ac5TXm7aKjMU3wfiQIBaxvqPqwijh0XV1vPtYkI4fp5/x/mFleechteiTwJcSoXcYW9QTmtdiLmZP7QNdfPOn2h34QtssRQiNCGOIjOmCa0u7tNMFXwmwEyEenl+RjwbIdhTr7+aBHjyI1H5XYb3l7Bc0LmcgOyVvfPtfd574PI4FLp3GVnecjgDs9pUOa6lBlVt7wixekKPCcnHihxXF3jEFChradw2PW6Ul16TNfVWfZ8pHPE2Mm9yNy/b/r6Wy3AiWM5HM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6916009)(41300700001)(66556008)(66946007)(4744005)(83380400001)(7406005)(7416002)(66476007)(316002)(478600001)(8676002)(6486002)(2906002)(6666004)(5660300002)(4326008)(8936002)(6506007)(6512007)(26005)(1076003)(38100700002)(2616005)(107886003)(86362001)(103116003)(36756003)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qxeEMRUAqTVHFFBuClu9E/kD1BKyDVcQBUw64KLATTegKcKK3zPfvsKzxW/A?=
 =?us-ascii?Q?CbDPVN7bmjgyvWMpR0nVucr7+dc79aGYyfuP+Jwu6PpYmHUAnUVXdj2shv7A?=
 =?us-ascii?Q?3g4oYCMCpCtDdwBMioECPAM4AAbfI98ujjQeRwf9dvR2qgIF2brBZLNs7n3v?=
 =?us-ascii?Q?D1LHsbXFofMuaj7k7GDC8pIbueyShsaDFQtRzDq0Fc9QOe4epRTX5nRKnPZH?=
 =?us-ascii?Q?SZEE+/HFXOGWmJxjSasGU70E4J67S6UASm1a1C4T/a471lz+5/j1Ofs4RWQF?=
 =?us-ascii?Q?4cZ94BthDgQ1ddu8LOWwJQk2Mkg90Nsa1BrOyiWlyWPZb88jaO0sgHzsYSQG?=
 =?us-ascii?Q?TLY8BaReFW83sipSuyDgqg0397aydEiYlOIZBg79Ifs2Paa4TdupP2atp5fy?=
 =?us-ascii?Q?LQbqqrhzvRXGykUROZ3HdojvKdxbCmHn2vVKo/MFUkrBeXkkJJ4ID0Qhj9AI?=
 =?us-ascii?Q?TaScLKDMZMCZoLqaXd3mNlHsuuOkWt0blTPJ7PjUEAD2zju8CJkAo7/D1wSN?=
 =?us-ascii?Q?fkZafUNcuOz/BrEkcmTIn48QTGAebTai2KUMVx8BsHmW1rD4MtIUFllG8afj?=
 =?us-ascii?Q?Lbqxeg46zlx9Fgzxo8+mnhPqRAb2h5NVIoaWMM2IBsyxNGvlg3gIFiguzYJz?=
 =?us-ascii?Q?2soY0SsGF60hOt8zWhCiNI6NHN8YQOGi93vDu6aFsEOMlQgSk4jl9CA0MuQr?=
 =?us-ascii?Q?AytbsT1dnCbulhlC+DG3UG2zij//ZkLQZS1UNUiMoPFFAn/g8/lPQmRytr4T?=
 =?us-ascii?Q?BhItc9ErfHIFrHEX++1+QnUOsopUlAa+EVmVEt7DgK4+tj/pPnDAma7lZURt?=
 =?us-ascii?Q?0m7V4qYVhHl6FF7Mv+aeU7OQhayHLIEHjOPqWTSX3R9bsQK4syVttGL57KHY?=
 =?us-ascii?Q?v9RRfPXeC54b1cg5BqyuV/PMIeOSt1IrVcGob7gF+3tNr0KOzKuT9XJ1R+Jr?=
 =?us-ascii?Q?99BnWwDOzH6Lq8s/ULjnax48JX+NgpJVnx4CzG4TrC2sO9u/oQwyOSJCVPIG?=
 =?us-ascii?Q?IzmRq8L9DgPr/veofBNDAufZuLg8yYMR8Y6QtR/jXS1MD7LwuhYYhgFscaPo?=
 =?us-ascii?Q?l5orvSBgOKe/uo5sFmAhfyczBxIRXzAmAi6ClzfY7sRQgmywpopoWRs00Hw3?=
 =?us-ascii?Q?umw5Vu6/8dn2S5iWlmza5Kijw1o3shyH7VkIL4icz7qiZyQcxD305FDj5Vd6?=
 =?us-ascii?Q?q60zJ3brmU5McVD44oUP+mZHGRlZwFfSpizHIbzrv6CJVfeiE3NiFWHj8/qY?=
 =?us-ascii?Q?B0Wd4j2F6U5uGa+vBmpEtX5Q0rh9/kcW8iRwUk1L3MplcT7Wqr6td4oxsR2F?=
 =?us-ascii?Q?ZCnOUFiRQbRoXn6cwCHJ3ag9a6iCOco1WRa3fquXqi11TmijlvnMMDRLREKO?=
 =?us-ascii?Q?UmJ1Xky8lK1Qs2IbAKoN91Br0LhCOuAs1/Bbx/y8IyQa9lbs1FrDorj3vUZN?=
 =?us-ascii?Q?Uof6zgtiSiD+H0rNod6b7iQdXn/BDEoaryxMaj5Ub69VOyTUTwuQhioLHdx5?=
 =?us-ascii?Q?+jco9/PeB3nRhgZDAdtgsNkvhIj0E+YlusnIMU8KZqwNRlTmODiIm4hpdSCP?=
 =?us-ascii?Q?UIdmrRno+MxOdpYBGKCu1XcN5qVVHq4GuBNDIimkF6w2Hm/7UUW0zk8MkIwF?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?iTweFJi0eDpmNoazgeXWbB2J9xaKwfAN2nv9ZPnLOErkqFSocjisjO2rzOAO?=
 =?us-ascii?Q?xpTo3aDGDKg7fw8ZZ/1+9N1fcFrG6/IyomhRWXnMIkKenDzq3rayFEJ5TM1g?=
 =?us-ascii?Q?4lX/WEe0oNx7erhOk/xhkLpx6Aa17mhiwFsMNyoAVvzDNcLEUtkLQfUO/2UY?=
 =?us-ascii?Q?CvN91XmcsI4IJRCXcOT1TfGdPiV3DQAIZygDd4NoZKZgM8gnqjXMlP2S8EB9?=
 =?us-ascii?Q?9UsUg3sdt6CRM3da0WdNgn9Ftk5F71NbF2aigAIvWffEtojafTei52CUHk6Y?=
 =?us-ascii?Q?UB1zcZdyzpt6ZINH9ogLLa1ZBdmuUky7hNoJEDk/+MfE0qp7oYj/ja5iKRsZ?=
 =?us-ascii?Q?ISotvlE1OOIltXYwnGTm+Uo9alw8/gKuhZaUDtCLLFphOmhrrnUQTYYpvpd/?=
 =?us-ascii?Q?D5C+3kH90/su1EQfR1Ajk+a0uHkE/2/1RukOzDX7CDgu/x8CSxMVg6z2aP8f?=
 =?us-ascii?Q?HyWZCK/nsxslLpuyzJKU4D4fwtCXn0zlRrARHwsWgRBc9iF2kVdk4Vf1vjDE?=
 =?us-ascii?Q?pj4j9+IpBMSMtD2k3J20gTjaAKZJRPwcBGsnWO/cJZJ9rJHrrLpZM8K8kyQt?=
 =?us-ascii?Q?vUbnWCRvk7sjoio915sQQLrTQCI3tVSevcSPanDIOpGlWTbcRv71sHbRWtyr?=
 =?us-ascii?Q?DckNAMpEkWtbnanJykUipgVDHYdtOhnrOpX/CyE5n6jd/L4IbKDq9umfsxC9?=
 =?us-ascii?Q?IySnF1Im9nJwGIg3X/hAfkXG2mPwtNk8SJlKZUHAQ85VLDVQqEV3HuLcmEXc?=
 =?us-ascii?Q?pRAP40SD9HMhAxwPU9MFrLhcEIABgI7GlUZ/4ZTUCsV2UUrm8KK2sjYiykkT?=
 =?us-ascii?Q?nS4A5YVcSSrjvJXr6dCnDYceZUc5jTSPNVXGfhOEGim87KgskeaUljGACrbS?=
 =?us-ascii?Q?SvtiYvOAjKwGw/DeUzApMdEd/48KgPU8U3NJ+Lly2VZoP5GbBzqj9dRxMnd6?=
 =?us-ascii?Q?hJYrECi7s4IGjjPll8fb8x0i8lTf1/grUwZhhfWf0IZHcvaEybWDVA83it2l?=
 =?us-ascii?Q?SSzXw/wol2kFbL7ZGmbYpE7WZJLvplQPRSCJI/tXrYvn8bIYBwtyg+GJg7uJ?=
 =?us-ascii?Q?XAu0JypnhhpQY4PTztoEIrpTifcp/oUBEIqgmFVtqQgTn36Immogx7f5Sh8f?=
 =?us-ascii?Q?1yiBgKaaXFJ/yDGLvko7rG+km+N5S1fDTvS64UPzrkYUojLSW1dZoGl6ZXm+?=
 =?us-ascii?Q?SeAfUHTC/3lmI5f1QLsF5ct2vWcT7SW794FaGh+zf1HcMv/ah/EN5tM0P0Is?=
 =?us-ascii?Q?KaE/JuXszraL7bxFAnyjaEwXQ1Ot5B9lANYjt1Zbm3VAQsOtbxlTvHbWNzTt?=
 =?us-ascii?Q?PDj2ILM4RGY4dIynfgKwf8b6BfcGg7b0YTa7fe4MspIRnuEws3IUyP5HyMvw?=
 =?us-ascii?Q?mt6fNP27W6gopWEQwDVY5NpmjP3j2p1iM3ISM+y5SVc/hlNKbChyuoh/5I2f?=
 =?us-ascii?Q?40k93wSTU1cmXlkBH1xsxqy+92Nt5DZoUgS9fsnf49RDKEw9IlA+88WFyPDl?=
 =?us-ascii?Q?E4O0p1z8OKo8Pv1B6uN12yaB6mc3A4CB1JECyvuWQ5L7VKc8pv1REcTvSA?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea3c12f-57cc-48e9-3f9c-08dbdfdca3d9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:58:13.9198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hx0+IPMylS87UtvceO0MmExl2B2N/SANU8FrR74xQWpvQieD9soyYyAFLYleeFVKX0e+SLWDjmSE8KVclgKBqksbosK2055Iba8VSJBS8Uw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7651
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=876 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-GUID: YtHjBveuWjnMJjIJCYFSLG0xsat7B67Q
X-Proofpoint-ORIG-GUID: YtHjBveuWjnMJjIJCYFSLG0xsat7B67Q
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 33c64734be3461222a8aa27d3dadc477ebca62de.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/Kconfig        | 1 +
 kernel/sched/core.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 3eb64363b48d..afe6785fd3e2 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1396,6 +1396,7 @@ config HAVE_STATIC_CALL_INLINE
 config HAVE_PREEMPT_DYNAMIC
 	bool
 	depends on HAVE_STATIC_CALL
+	depends on GENERIC_ENTRY
 	help
 	  Select this if the architecture support boot time preempt setting
 	  on top of static calls. It is strongly advised to support inline
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 51c992105bc0..686e89d4ebb7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8636,9 +8636,7 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
-#ifdef CONFIG_GENERIC_ENTRY
 #include <linux/entry-common.h>
-#endif
 
 /*
  * SC:cond_resched
-- 
2.31.1


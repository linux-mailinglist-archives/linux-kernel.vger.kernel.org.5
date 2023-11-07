Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1882C7E4C98
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344142AbjKGXNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344352AbjKGXMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:12:43 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DED326A9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:11:07 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LKAuk020974;
        Tue, 7 Nov 2023 23:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=l0oi6U6XTqi6xUPiF/Vm9OcTQYEcBRyzZ+85IJdGD1g=;
 b=VR6zPQvwIB3atsVE32l07vELNjlh7gG6oicrEi8PbH/A/zXpsThzAJ9AsjfV3ktiH5c5
 S1nMSlrt9MiFGmJyGTxsTuHDp1lnkALddSYR+hvJASDB2aYH0Zj08oryoK/GhOWuCu9O
 0rTypyt16iIScZCV/PABzoiGuBMtnoxv9/Wi+32UAy8ZmwaF5/QXw1tdMVdas6s0TbHa
 84Fm59+3b/1XZJfcCDzCtb6MOX7i0W7qjrqhKtvMFqJXjJcQdbGl2PJmVq12NU49s3Co
 rRvGr/4qk2Pbc3YNuZbmio3n5OO0YW2lljr+GtNyTDVkNqhrJ6YX2H7Zr5QYFgMGagek 1Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2207b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N2MwB003811;
        Tue, 7 Nov 2023 23:09:54 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vvcgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDBZrMND44D6Fm99c+fw/330ICNfOFMfr1Rhp3oldIQAnBQMt9IrVio6jKbJ2zTpLe71QD4tE36YYJtIHTCt1WS4K5L3slWyibS2tenGV65S7mOhpBFEqHzI7sxCZ5cagoTMEsNc7YwZoh6o1po5p+1GjaOG/FOCcR4/hXVWlDADIwXjQKOjoIRGkb9fXsKmSv6NN3R+18U5ZCKWKWY/doqxIruhGmgS0xRW1MuR4UT9M+tdx/CnWrBW4282ffJ8/y+IZjJnNHpuXWpiRcyEIP6kVfdBxRAADtwzCMqYjQIdxcyaVizvsqIkdivzaBGUXmiaGuCv0l+bejj8ifjPMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0oi6U6XTqi6xUPiF/Vm9OcTQYEcBRyzZ+85IJdGD1g=;
 b=F7CFE2QSxc55HT6ZvE0ULg43KdfmkG/pM95TSKw+A2MXkoF7eXP8FA9pjyaemlTYHBG6kgmS32xlaEwwCrdxyuh3uRTwYu3OZI9WmpsYTNkz0YsohmObQjyBXlHnnog0JQ0XDqJG//TIOvkMn/MnwirWzB/s5Br8kY3BfYyXJf0fbEU2/nS+jrDVcGBl5iKHIdg82aA5+y8zrFUJCvwICfzhBjDKuZyBtzkgN6GWDEmOH/LklZqZ787MTE3ZcMkiMtEmFw62rkaBf31zlaO8t6g/KVH1DVroDrAiHIBhAyQcsGRD1PVf+bH5Bl8JHYRPYvYM/9tRK+eNEN6c9dFWwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0oi6U6XTqi6xUPiF/Vm9OcTQYEcBRyzZ+85IJdGD1g=;
 b=ihaGfDJq2N+Pm+/v9+SpbEsemIe/gKAIY7ZWeu2jRtmjaCXe/H53rzNN4Zv1gBaPkGnH96JMdP15+esZPjq5Z7LdkMSDfWLL+ARH7FGcQMoX2Phnf8kOuctNgQBU3JuXFhE2UrqyLun0AzvSWamFd10TPWNDS7+EzlJqSX3cHio=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 IA1PR10MB7261.namprd10.prod.outlook.com (2603:10b6:208:3f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 23:09:50 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:09:50 +0000
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
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>
Subject: [RFC PATCH 82/86] treewide: mtd: remove cond_resched()
Date:   Tue,  7 Nov 2023 15:08:18 -0800
Message-Id: <20231107230822.371443-26-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0046.namprd04.prod.outlook.com
 (2603:10b6:303:6a::21) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|IA1PR10MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: bb59d173-d6a6-444c-d2dd-08dbdfe6a490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y2ys7eH2V0e2+cm5P/g3qeA72iXFdOYfiqQNRw6VLL1Urmz8pkbjItAc7am02jEO1aYELjBxR7zkqh5GDRygttbhWjP3WjRhUUmy9ZKoK7IF5XU1YKtaidwu4uZhLiIlAC9SYxa3jLCl7o/6EExOe412cyYuUtzpWh+PpdKVCAS9UA9SNQrmXHtFqI26uIt+bm+I/LMJl0847y/uE2B8Xr3Q39kWxIWteCwdG70tiNvNI/Sc6PVFPRc82TZdSfNK29/kx6qVyRYKU03QWMe7XJl4HCxGaNfWPCJ6MS6mFfbksCzW/AurQIsK4q0DXq9JHjNQvuyyIABURGcE89ygn4bIaGJDV8tP7sSlWluRftZk4IPp5Pj0MYQc1QARucciH2RRNlt3+YaI9Eg6UZj4mucY7pHilro7CwTa/45fnASYcek4aOhSfdXXHq8wJQUoEe90Jkhnd59EQLIfFfazQoax3BDtqerbq9qlEKfdl0Py7rHAmAEd1p/+zRyekd0K2FbYLvz0CPSRnxwmSxt3Q+VTklnGjUifpLspc+SVNTkmdfKoq02qk24wkDvlHWpR8Fl+lSnujaxTCl9yKPl6JNTiLPpuSk2pcow1wp6AX1GxLpYyVkG6xaejmyzyX+OC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230273577357003)(230922051799003)(230173577357003)(451199024)(64100799003)(186009)(1800799009)(66899024)(30864003)(6506007)(478600001)(6512007)(2616005)(6486002)(966005)(6666004)(7406005)(36756003)(103116003)(38100700002)(86362001)(1076003)(41300700001)(7416002)(5660300002)(316002)(66556008)(66476007)(83380400001)(2906002)(54906003)(26005)(66946007)(6916009)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mkkqFPwc2n+raKKdEIfY1OP4r9YLO3eJx1I525mdqiNrHqezX+zLajDuStuI?=
 =?us-ascii?Q?pNwYGVuzpD4wS2fnPWtEAPcuIopvSjLkAGt4Jh2PuYE9fMZQs7ggqWExi7TK?=
 =?us-ascii?Q?8STqV+v8vUJ91oNBZFxm1+NSfKpbjUH2XABKRNABRcyjkq9Lphv1wIU74I5n?=
 =?us-ascii?Q?ti/bS0Fft2vm1t1IPMOT4J932htMxSdMZyr4wukDe5o/DOWU7HVyt74OlJxN?=
 =?us-ascii?Q?Pcis5lUDNf6wDmHZNwYfypog+FRLI32OM2qaYMlBOLc/4I0WbYUtVqMe7Ab+?=
 =?us-ascii?Q?by8QvbVUwko83iSX/ZBNfPprCFe5rQRuILqIzTTtsoXM3AuOuzPsl8vph/nk?=
 =?us-ascii?Q?Y0dXLuZQOxGimtTASUZsCqxijkFNkHuOtyJBZ96v6BfsYT8sKnXxLmQg3rfj?=
 =?us-ascii?Q?K5+odEl1zETS2MyiP4gzyt+Y3zXURDF8cLj9VgtvIaCFNH9HwPbb+Ze5JIqF?=
 =?us-ascii?Q?mOESFZmu6IOLD/qPrrbyL66mb5ALdEUBAMjV6h1gW7NVjSp5AbbF+cwpuNJF?=
 =?us-ascii?Q?SaWchmlumE6+c3fHirS7xPgvekfqLehzX3seTb7fiko4Gvo9Z7eK7khWa78F?=
 =?us-ascii?Q?hvi3KbZpcLCA7UscUnb/pjHgtv78VaXFg/s/nrPk8rQT+lOuJ0RrlxTj7dyX?=
 =?us-ascii?Q?R+KdBqAIESWDY2EUaWz3Of5q9KhUGmkP3gnmVqI8W33LqcQTObE0tKLb+D8U?=
 =?us-ascii?Q?ehF5PqVBqR+1vYo8zsoXwLdPmura1zURc2dea/VdEFAV6WHemKvbL+SNGo2N?=
 =?us-ascii?Q?gdiRfjOJI8kSkGzm93P28jtja5/eUfgv6Cb2VHl2x/do/iY1yx5zQ8tQa4Zw?=
 =?us-ascii?Q?RfwVngNN7MVv/Vtd1zBFu3EaN8N/MZvAlOuLzZ2rjCbIQosqtLwndpIro7I6?=
 =?us-ascii?Q?uSFI9cJ8vUevGRzJPLi3mYdlorFCTCdB+O9doe5qfSVh7wwCbQCdGaB/I8+N?=
 =?us-ascii?Q?HLeB/S9xpuXdsLGyforz758HWJV1MiCQ5Vv8XOsSdZSjRSTDBd5KgYOvJ2Cq?=
 =?us-ascii?Q?4WhE6ECafmJwSAAaw0ApMjnLJntVkClaYTOdTlxnCyrQx/eoak61AZnQzxkH?=
 =?us-ascii?Q?4GjVCdBuUgWs9ms5jRKjEUS6BpDlipl+MoSfqXxANBE/SdrK3Qyo2CnePZxC?=
 =?us-ascii?Q?grQvyUzJlTi6QYi4UR8cmSUPjBtQ7M+AvHLEBFFhoZz1heky5ypc+3Qy7SXt?=
 =?us-ascii?Q?F4xlxCbho/JU35p/Ej4twqd8MYg6EjFk8eLYOacZk7uDiXCzK48F7r62nDRW?=
 =?us-ascii?Q?DqMDesBWYMLJFO9oyCcx6+Ryl2LCzqdlsncAgbh+P4cLjCWS3kdaxxXkyb51?=
 =?us-ascii?Q?bwT8NEqc+Rpen1qyxO/Fx+N5j879qu6rTdybVkAoIVj98LaWrZOISYEffrG0?=
 =?us-ascii?Q?6jah4Ev/g8oPxl9B3Fv3jI23mjKwY73zQMm3zsTp7D2mUD5MvDg4Jlz0zSHT?=
 =?us-ascii?Q?dqzYusB3XLG0tQECywr6FQnEtNIkqKzxalHq4eOxvj/FL7slLXMd3pFBRxvr?=
 =?us-ascii?Q?zEuDAOdDwFZppoHq2+iaF+qOfrj2Ci6GRJEWUhN+sCOezHa2mOhkz7JghVcl?=
 =?us-ascii?Q?FGe0rsE8VLFiqM0bjkVTH7S7Bxzk+tBGRVdfjuR6qdqO0ebTxilE8Yyuue7h?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?dpD4XlG92Z7fIrFOZYaJm6H/mVqE/uP3xFtpKLqaSfdYr63aXmvEQsTSemHv?=
 =?us-ascii?Q?QhyVuLHA9xRxE376e/Mer14DfOBOHvhXBT7p+BoMHweNBBidVPlsfhVFTNZz?=
 =?us-ascii?Q?IotBeYEgtamBk+H5Najo2myaE5WKzWNzjg1AgTpWb1rfvxOOooS1UCRPZNeL?=
 =?us-ascii?Q?vLqCY+UpuakezIq5RUaZEfmu9wA6up6oigPsqSm8mSgeg78Mv39KS6HRbtPv?=
 =?us-ascii?Q?84mjn1qqU/cwwr41LJq/sndLQ5nEVGV1gkfYhiQzSjvyE2hOWB6vbwFOcWeU?=
 =?us-ascii?Q?hw/+bw5j4ddKQf8h7fcJ//PdsHRIpVGPwhK/PbqL6pajra0eUMHg96A2kIia?=
 =?us-ascii?Q?1LhuNikqyuIlHdpH9GPH1nq8tLIR62X0jbDLhlVFgYyWOQX0YfpgZnc2SQ/+?=
 =?us-ascii?Q?l6+CIB3Td1BgeH4oVSgQiKrhRjJH+YGRGo0AsemtMJQbb9V+n4bk+1Bnz4gI?=
 =?us-ascii?Q?zRerJ6BAcRRDorpuBdLApSn4CIXGoCSvbdSdBhtNT8urpBYJe4EJZFaUg8f+?=
 =?us-ascii?Q?MPZfKpwECe7C/SkCObzj1DnYnaDj20XPjVaZE25+4VTCmIop4mmCPZ+bqp3Y?=
 =?us-ascii?Q?GB5OiH7xtC6bztt1WlM/ntaNNHVLWkR4dOp30Y4Fbi+WiZ4LH9GvYw4HyLVQ?=
 =?us-ascii?Q?P04P7UEvABkJTv/UlZ7ovtirKWLZCL2I1Ig7mNFda4JaxPfg4DCudNLoMIs6?=
 =?us-ascii?Q?rLb3d5D0eJK/MJMdbNse0/kyH2Dk+y2tGeDt4UZQnQxb3oKnyTfSJPMgZfZs?=
 =?us-ascii?Q?ptGtRJTxULY/5xknbnIcmdkos1DQP6DlRrX15yc0HX+GGJA66oMib/1+9oRF?=
 =?us-ascii?Q?QafmskcwgFUBpQaOy4hEpCXpqx3pPiJOxnN4cL3pzYPDbAndizVmLKeEHfB4?=
 =?us-ascii?Q?7TZwnykBkuWJ+0vLMw+yQ5iTlrzLAoxos9/B4WxCmY3HzCUivoi8OacUd+AY?=
 =?us-ascii?Q?Vwd8WrtjjZXXdBl3jTTPxGDpDfvevVS/dY6PVVs2i/MH3wT1JQT73KVx96lA?=
 =?us-ascii?Q?qrJS/q47dRQhIFsrQdAJtxlyF3vmWRuDELqPrpRscJkLzVxT0xE3UkuE8OaA?=
 =?us-ascii?Q?4mrxk1fksR1FRZLnnWreLJ6Blx2T9la7Qvb1zuK2aoswMyucUvNE/uGJzFil?=
 =?us-ascii?Q?Yr1irMh+mV2H21ZSQPAtRER0NQJlXhahtPZlPPxyLIuZzcL4IvgNn72orSWQ?=
 =?us-ascii?Q?cPqjafQYdAZUoS8LwIVyq6gOosQnIrSFPp3HjJvbaG7/umZ728s/tSNUP2fb?=
 =?us-ascii?Q?dpvqZloUZLtrEFpv0z/KIlQe7cu9hGnTbzaiUkml9vk7q23wk7RMy5I65vcn?=
 =?us-ascii?Q?hGiGTn0o2urYo0gK1b15D13O6pInbHfFK8/iW05jT4s6i5gxTtvhutGDbGKU?=
 =?us-ascii?Q?YK1hHUoEx+4ahyb+X5SrQojPQMOhrchA1D+Pb0RxyXWk+G9MVIn0a1MF0IgQ?=
 =?us-ascii?Q?jEX9nAD0OJNINM2EtNc/8DZNUbyddGHLi1bkg7ES/2J6BWcteKwJakSfxyyc?=
 =?us-ascii?Q?GClKJxQzb8+Ms/DKPDtS5VxVnUsfvbCEtuUr/4PBB2HTNVWyKKWU3fPV5soG?=
 =?us-ascii?Q?KtJI3lOP2AeO5C2b3Sau159eQjPO2PZlDBhabKogDo0smEIfZpErXP9AaeFj?=
 =?us-ascii?Q?QNqljI9LtwF7InTL8+odVzA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb59d173-d6a6-444c-d2dd-08dbdfe6a490
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:09:50.1934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQJO+2JFGzXtGTsAXSokwvzyjsezpGMHzHsatF1IiNL2BvtpyqePIePgRgDXEXU/APJgIlolY6S4ALd9Fbkebj63aK13LZyiU5/AvF9oE/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070189
X-Proofpoint-GUID: POEwDWfdeX3YQoqtarJb98fDmkw6lv8d
X-Proofpoint-ORIG-GUID: POEwDWfdeX3YQoqtarJb98fDmkw6lv8d
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
cond_resched_stall(). Some of those places, however, have wait-times
milliseconds, so maybe we should just have an msleep() there?

[1] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 drivers/mtd/chips/cfi_cmdset_0001.c        |  6 ------
 drivers/mtd/chips/cfi_cmdset_0002.c        |  1 -
 drivers/mtd/chips/cfi_util.c               |  2 +-
 drivers/mtd/devices/spear_smi.c            |  2 +-
 drivers/mtd/devices/sst25l.c               |  3 +--
 drivers/mtd/devices/st_spi_fsm.c           |  4 ----
 drivers/mtd/inftlcore.c                    |  5 -----
 drivers/mtd/lpddr/lpddr_cmds.c             |  6 +-----
 drivers/mtd/mtd_blkdevs.c                  |  1 -
 drivers/mtd/nand/onenand/onenand_base.c    | 18 +-----------------
 drivers/mtd/nand/onenand/onenand_samsung.c |  8 +++++++-
 drivers/mtd/nand/raw/diskonchip.c          |  4 ++--
 drivers/mtd/nand/raw/fsmc_nand.c           |  3 +--
 drivers/mtd/nand/raw/hisi504_nand.c        |  2 +-
 drivers/mtd/nand/raw/nand_base.c           |  3 +--
 drivers/mtd/nand/raw/nand_legacy.c         | 17 +++++++++++++++--
 drivers/mtd/spi-nor/core.c                 |  8 +++++++-
 drivers/mtd/tests/mtd_test.c               |  2 --
 drivers/mtd/tests/mtd_test.h               |  2 +-
 drivers/mtd/tests/pagetest.c               |  1 -
 drivers/mtd/tests/readtest.c               |  2 --
 drivers/mtd/tests/torturetest.c            |  1 -
 drivers/mtd/ubi/attach.c                   | 10 ----------
 drivers/mtd/ubi/build.c                    |  2 --
 drivers/mtd/ubi/cdev.c                     |  4 ----
 drivers/mtd/ubi/eba.c                      |  8 --------
 drivers/mtd/ubi/misc.c                     |  2 --
 drivers/mtd/ubi/vtbl.c                     |  6 ------
 drivers/mtd/ubi/wl.c                       | 13 -------------
 29 files changed, 40 insertions(+), 106 deletions(-)

diff --git a/drivers/mtd/chips/cfi_cmdset_0001.c b/drivers/mtd/chips/cfi_cmdset_0001.c
index 11b06fefaa0e..c6abed74e4df 100644
--- a/drivers/mtd/chips/cfi_cmdset_0001.c
+++ b/drivers/mtd/chips/cfi_cmdset_0001.c
@@ -1208,7 +1208,6 @@ static int __xipram xip_wait_for_operation(
 			local_irq_enable();
 			mutex_unlock(&chip->mutex);
 			xip_iprefetch();
-			cond_resched();
 
 			/*
 			 * We're back.  However someone else might have
@@ -1337,7 +1336,6 @@ static int inval_cache_and_wait_for_operation(
 			sleep_time = 1000000/HZ;
 		} else {
 			udelay(1);
-			cond_resched();
 			timeo--;
 		}
 		mutex_lock(&chip->mutex);
@@ -1913,10 +1911,6 @@ static int cfi_intelext_writev (struct mtd_info *mtd, const struct kvec *vecs,
 				return 0;
 		}
 
-		/* Be nice and reschedule with the chip in a usable state for other
-		   processes. */
-		cond_resched();
-
 	} while (len);
 
 	return 0;
diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
index df589d9b4d70..f6d8f8ccbe3f 100644
--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -1105,7 +1105,6 @@ static void __xipram xip_udelay(struct map_info *map, struct flchip *chip,
 			local_irq_enable();
 			mutex_unlock(&chip->mutex);
 			xip_iprefetch();
-			cond_resched();
 
 			/*
 			 * We're back.  However someone else might have
diff --git a/drivers/mtd/chips/cfi_util.c b/drivers/mtd/chips/cfi_util.c
index 140c69a67e82..c178dae31a59 100644
--- a/drivers/mtd/chips/cfi_util.c
+++ b/drivers/mtd/chips/cfi_util.c
@@ -28,7 +28,7 @@ void cfi_udelay(int us)
 		msleep(DIV_ROUND_UP(us, 1000));
 	} else {
 		udelay(us);
-		cond_resched();
+		cond_resched_stall();
 	}
 }
 EXPORT_SYMBOL(cfi_udelay);
diff --git a/drivers/mtd/devices/spear_smi.c b/drivers/mtd/devices/spear_smi.c
index 0a35e5236ae5..9b4d226633a9 100644
--- a/drivers/mtd/devices/spear_smi.c
+++ b/drivers/mtd/devices/spear_smi.c
@@ -278,7 +278,7 @@ static int spear_smi_wait_till_ready(struct spear_smi *dev, u32 bank,
 			return 0;
 		}
 
-		cond_resched();
+		cond_resched_stall();
 	} while (!time_after_eq(jiffies, finish));
 
 	dev_err(&dev->pdev->dev, "smi controller is busy, timeout\n");
diff --git a/drivers/mtd/devices/sst25l.c b/drivers/mtd/devices/sst25l.c
index 8813994ce9f4..ff16147d9bdd 100644
--- a/drivers/mtd/devices/sst25l.c
+++ b/drivers/mtd/devices/sst25l.c
@@ -132,8 +132,7 @@ static int sst25l_wait_till_ready(struct sst25l_flash *flash)
 			return err;
 		if (!(status & SST25L_STATUS_BUSY))
 			return 0;
-
-		cond_resched();
+		cond_resched_stall();
 	} while (!time_after_eq(jiffies, deadline));
 
 	return -ETIMEDOUT;
diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index 95530cbbb1e0..a0f5874c1941 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -738,8 +738,6 @@ static void stfsm_wait_seq(struct stfsm *fsm)
 
 		if (stfsm_is_idle(fsm))
 			return;
-
-		cond_resched();
 	}
 
 	dev_err(fsm->dev, "timeout on sequence completion\n");
@@ -901,8 +899,6 @@ static uint8_t stfsm_wait_busy(struct stfsm *fsm)
 		if (!timeout)
 			/* Restart */
 			writel(seq->seq_cfg, fsm->base + SPI_FAST_SEQ_CFG);
-
-		cond_resched();
 	}
 
 	dev_err(fsm->dev, "timeout on wait_busy\n");
diff --git a/drivers/mtd/inftlcore.c b/drivers/mtd/inftlcore.c
index 9739387cff8c..c757b8a25748 100644
--- a/drivers/mtd/inftlcore.c
+++ b/drivers/mtd/inftlcore.c
@@ -732,11 +732,6 @@ static void INFTL_trydeletechain(struct INFTLrecord *inftl, unsigned thisVUC)
 
 		/* Now sort out whatever was pointing to it... */
 		*prevEUN = BLOCK_NIL;
-
-		/* Ideally we'd actually be responsive to new
-		   requests while we're doing this -- if there's
-		   free space why should others be made to wait? */
-		cond_resched();
 	}
 
 	inftl->VUtable[thisVUC] = BLOCK_NIL;
diff --git a/drivers/mtd/lpddr/lpddr_cmds.c b/drivers/mtd/lpddr/lpddr_cmds.c
index 3c3939bc2dad..ad8992d24082 100644
--- a/drivers/mtd/lpddr/lpddr_cmds.c
+++ b/drivers/mtd/lpddr/lpddr_cmds.c
@@ -161,7 +161,7 @@ static int wait_for_ready(struct map_info *map, struct flchip *chip,
 			sleep_time = 1000000/HZ;
 		} else {
 			udelay(1);
-			cond_resched();
+			cond_resched_stall();
 			timeo--;
 		}
 		mutex_lock(&chip->mutex);
@@ -677,10 +677,6 @@ static int lpddr_writev(struct mtd_info *mtd, const struct kvec *vecs,
 		(*retlen) += size;
 		len -= size;
 
-		/* Be nice and reschedule with the chip in a usable
-		 * state for other processes */
-		cond_resched();
-
 	} while (len);
 
 	return 0;
diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index ff18636e0889..96bff5627a31 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -158,7 +158,6 @@ static void mtd_blktrans_work(struct mtd_blktrans_dev *dev)
 		}
 
 		background_done = 0;
-		cond_resched();
 		spin_lock_irq(&dev->queue_lock);
 	}
 }
diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
index f66385faf631..97d07e4cc150 100644
--- a/drivers/mtd/nand/onenand/onenand_base.c
+++ b/drivers/mtd/nand/onenand/onenand_base.c
@@ -567,7 +567,7 @@ static int onenand_wait(struct mtd_info *mtd, int state)
 			break;
 
 		if (state != FL_READING && state != FL_PREPARING_ERASE)
-			cond_resched();
+			cond_resched_stall();
 	}
 	/* To get correct interrupt status in timeout case */
 	interrupt = this->read_word(this->base + ONENAND_REG_INTERRUPT);
@@ -1143,8 +1143,6 @@ static int onenand_mlc_read_ops_nolock(struct mtd_info *mtd, loff_t from,
 	stats = mtd->ecc_stats;
 
 	while (read < len) {
-		cond_resched();
-
 		thislen = min_t(int, writesize, len - read);
 
 		column = from & (writesize - 1);
@@ -1307,7 +1305,6 @@ static int onenand_read_ops_nolock(struct mtd_info *mtd, loff_t from,
 		buf += thislen;
 		thislen = min_t(int, writesize, len - read);
 		column = 0;
-		cond_resched();
 		/* Now wait for load */
 		ret = this->wait(mtd, FL_READING);
 		onenand_update_bufferram(mtd, from, !ret);
@@ -1378,8 +1375,6 @@ static int onenand_read_oob_nolock(struct mtd_info *mtd, loff_t from,
 	readcmd = ONENAND_IS_4KB_PAGE(this) ? ONENAND_CMD_READ : ONENAND_CMD_READOOB;
 
 	while (read < len) {
-		cond_resched();
-
 		thislen = oobsize - column;
 		thislen = min_t(int, thislen, len);
 
@@ -1565,8 +1560,6 @@ int onenand_bbt_read_oob(struct mtd_info *mtd, loff_t from,
 	readcmd = ONENAND_IS_4KB_PAGE(this) ? ONENAND_CMD_READ : ONENAND_CMD_READOOB;
 
 	while (read < len) {
-		cond_resched();
-
 		thislen = mtd->oobsize - column;
 		thislen = min_t(int, thislen, len);
 
@@ -1838,8 +1831,6 @@ static int onenand_write_ops_nolock(struct mtd_info *mtd, loff_t to,
 			thislen = min_t(int, mtd->writesize - column, len - written);
 			thisooblen = min_t(int, oobsize - oobcolumn, ooblen - oobwritten);
 
-			cond_resched();
-
 			this->command(mtd, ONENAND_CMD_BUFFERRAM, to, thislen);
 
 			/* Partial page write */
@@ -2022,8 +2013,6 @@ static int onenand_write_oob_nolock(struct mtd_info *mtd, loff_t to,
 	while (written < len) {
 		int thislen = min_t(int, oobsize, len - written);
 
-		cond_resched();
-
 		this->command(mtd, ONENAND_CMD_BUFFERRAM, to, mtd->oobsize);
 
 		/* We send data to spare ram with oobsize
@@ -2232,7 +2221,6 @@ static int onenand_multiblock_erase(struct mtd_info *mtd,
 		}
 
 		/* last block of 64-eb series */
-		cond_resched();
 		this->command(mtd, ONENAND_CMD_ERASE, addr, block_size);
 		onenand_invalidate_bufferram(mtd, addr, block_size);
 
@@ -2288,8 +2276,6 @@ static int onenand_block_by_block_erase(struct mtd_info *mtd,
 
 	/* Loop through the blocks */
 	while (len) {
-		cond_resched();
-
 		/* Check if we have a bad block, we do not erase bad blocks */
 		if (onenand_block_isbad_nolock(mtd, addr, 0)) {
 			printk(KERN_WARNING "%s: attempt to erase a bad block "
@@ -2799,8 +2785,6 @@ static int onenand_otp_write_oob_nolock(struct mtd_info *mtd, loff_t to,
 	while (written < len) {
 		int thislen = min_t(int, oobsize, len - written);
 
-		cond_resched();
-
 		block = (int) (to >> this->erase_shift);
 		/*
 		 * Write 'DFS, FBA' of Flash
diff --git a/drivers/mtd/nand/onenand/onenand_samsung.c b/drivers/mtd/nand/onenand/onenand_samsung.c
index fd6890a03d55..2e0c8f50d77d 100644
--- a/drivers/mtd/nand/onenand/onenand_samsung.c
+++ b/drivers/mtd/nand/onenand/onenand_samsung.c
@@ -338,8 +338,14 @@ static int s3c_onenand_wait(struct mtd_info *mtd, int state)
 		if (stat & flags)
 			break;
 
+		/*
+		 * Use a cond_resched_stall() to avoid spinning in
+		 * a tight loop.
+		 * Though, given that the timeout is in milliseconds,
+		 * maybe this should timeout or event wait?
+		 */
 		if (state != FL_READING)
-			cond_resched();
+			cond_resched_stall();
 	}
 	/* To get correct interrupt status in timeout case */
 	stat = s3c_read_reg(INT_ERR_STAT_OFFSET);
diff --git a/drivers/mtd/nand/raw/diskonchip.c b/drivers/mtd/nand/raw/diskonchip.c
index 5d2ddb037a9a..930b4fdf75e0 100644
--- a/drivers/mtd/nand/raw/diskonchip.c
+++ b/drivers/mtd/nand/raw/diskonchip.c
@@ -248,7 +248,7 @@ static int _DoC_WaitReady(struct doc_priv *doc)
 				return -EIO;
 			}
 			udelay(1);
-			cond_resched();
+			cond_resched_stall();
 		}
 	} else {
 		while (!(ReadDOC(docptr, CDSNControl) & CDSN_CTRL_FR_B)) {
@@ -257,7 +257,7 @@ static int _DoC_WaitReady(struct doc_priv *doc)
 				return -EIO;
 			}
 			udelay(1);
-			cond_resched();
+			cond_resched_stall();
 		}
 	}
 
diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index 811982da3557..20e88e98e517 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -398,8 +398,7 @@ static int fsmc_read_hwecc_ecc4(struct nand_chip *chip, const u8 *data,
 	do {
 		if (readl_relaxed(host->regs_va + STS) & FSMC_CODE_RDY)
 			break;
-
-		cond_resched();
+		cond_resched_stall();
 	} while (!time_after_eq(jiffies, deadline));
 
 	if (time_after_eq(jiffies, deadline)) {
diff --git a/drivers/mtd/nand/raw/hisi504_nand.c b/drivers/mtd/nand/raw/hisi504_nand.c
index fe291a2e5c77..bf669b1750f8 100644
--- a/drivers/mtd/nand/raw/hisi504_nand.c
+++ b/drivers/mtd/nand/raw/hisi504_nand.c
@@ -819,7 +819,7 @@ static int hisi_nfc_suspend(struct device *dev)
 		if (((hinfc_read(host, HINFC504_STATUS) & 0x1) == 0x0) &&
 		    (hinfc_read(host, HINFC504_DMA_CTRL) &
 		     HINFC504_DMA_CTRL_DMA_START)) {
-			cond_resched();
+			cond_resched_stall();
 			return 0;
 		}
 	}
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 1fcac403cee6..656126b05f09 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -730,8 +730,7 @@ int nand_gpio_waitrdy(struct nand_chip *chip, struct gpio_desc *gpiod,
 	do {
 		if (gpiod_get_value_cansleep(gpiod))
 			return 0;
-
-		cond_resched();
+		cond_resched_stall();
 	} while	(time_before(jiffies, timeout_ms));
 
 	return gpiod_get_value_cansleep(gpiod) ? 0 : -ETIMEDOUT;
diff --git a/drivers/mtd/nand/raw/nand_legacy.c b/drivers/mtd/nand/raw/nand_legacy.c
index 743792edf98d..aaef537b46c3 100644
--- a/drivers/mtd/nand/raw/nand_legacy.c
+++ b/drivers/mtd/nand/raw/nand_legacy.c
@@ -203,7 +203,13 @@ void nand_wait_ready(struct nand_chip *chip)
 	do {
 		if (chip->legacy.dev_ready(chip))
 			return;
-		cond_resched();
+		/*
+		 * Use a cond_resched_stall() to avoid spinning in
+		 * a tight loop.
+		 * Though, given that the timeout is in milliseconds,
+		 * maybe this should timeout or event wait?
+		 */
+		cond_resched_stall();
 	} while (time_before(jiffies, timeo));
 
 	if (!chip->legacy.dev_ready(chip))
@@ -565,7 +571,14 @@ static int nand_wait(struct nand_chip *chip)
 				if (status & NAND_STATUS_READY)
 					break;
 			}
-			cond_resched();
+
+			/*
+			 * Use a cond_resched_stall() to avoid spinning in
+			 * a tight loop.
+			 * Though, given that the timeout is in milliseconds,
+			 * maybe this should timeout or event wait?
+			 */
+			cond_resched_stall();
 		} while (time_before(jiffies, timeo));
 	}
 
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 1b0c6770c14e..e32e6eebb0e2 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -730,7 +730,13 @@ static int spi_nor_wait_till_ready_with_timeout(struct spi_nor *nor,
 		if (ret)
 			return 0;
 
-		cond_resched();
+		/*
+		 * Use a cond_resched_stall() to avoid spinning in
+		 * a tight loop.
+		 * Though, given that the timeout is in milliseconds,
+		 * maybe this should timeout or event wait?
+		 */
+		cond_resched_stall();
 	}
 
 	dev_dbg(nor->dev, "flash operation timed out\n");
diff --git a/drivers/mtd/tests/mtd_test.c b/drivers/mtd/tests/mtd_test.c
index c84250beffdc..5bb0c6ef7df9 100644
--- a/drivers/mtd/tests/mtd_test.c
+++ b/drivers/mtd/tests/mtd_test.c
@@ -51,7 +51,6 @@ int mtdtest_scan_for_bad_eraseblocks(struct mtd_info *mtd, unsigned char *bbt,
 		bbt[i] = is_block_bad(mtd, eb + i) ? 1 : 0;
 		if (bbt[i])
 			bad += 1;
-		cond_resched();
 	}
 	pr_info("scanned %d eraseblocks, %d are bad\n", i, bad);
 
@@ -70,7 +69,6 @@ int mtdtest_erase_good_eraseblocks(struct mtd_info *mtd, unsigned char *bbt,
 		err = mtdtest_erase_eraseblock(mtd, eb + i);
 		if (err)
 			return err;
-		cond_resched();
 	}
 
 	return 0;
diff --git a/drivers/mtd/tests/mtd_test.h b/drivers/mtd/tests/mtd_test.h
index 5a6e3bbe0474..4742f53c6f25 100644
--- a/drivers/mtd/tests/mtd_test.h
+++ b/drivers/mtd/tests/mtd_test.h
@@ -4,7 +4,7 @@
 
 static inline int mtdtest_relax(void)
 {
-	cond_resched();
+	cond_resched_stall();
 	if (signal_pending(current)) {
 		pr_info("aborting test due to pending signal!\n");
 		return -EINTR;
diff --git a/drivers/mtd/tests/pagetest.c b/drivers/mtd/tests/pagetest.c
index 8eb40b6e6dfa..79330c0ccd85 100644
--- a/drivers/mtd/tests/pagetest.c
+++ b/drivers/mtd/tests/pagetest.c
@@ -43,7 +43,6 @@ static int write_eraseblock(int ebnum)
 	loff_t addr = (loff_t)ebnum * mtd->erasesize;
 
 	prandom_bytes_state(&rnd_state, writebuf, mtd->erasesize);
-	cond_resched();
 	return mtdtest_write(mtd, addr, mtd->erasesize, writebuf);
 }
 
diff --git a/drivers/mtd/tests/readtest.c b/drivers/mtd/tests/readtest.c
index 99670ef91f2b..c862d9a6dc1d 100644
--- a/drivers/mtd/tests/readtest.c
+++ b/drivers/mtd/tests/readtest.c
@@ -91,7 +91,6 @@ static void dump_eraseblock(int ebnum)
 		for (j = 0; j < 32 && i < n; j++, i++)
 			p += sprintf(p, "%02x", (unsigned int)iobuf[i]);
 		printk(KERN_CRIT "%s\n", line);
-		cond_resched();
 	}
 	if (!mtd->oobsize)
 		return;
@@ -106,7 +105,6 @@ static void dump_eraseblock(int ebnum)
 				p += sprintf(p, "%02x",
 					     (unsigned int)iobuf1[i]);
 			printk(KERN_CRIT "%s\n", line);
-			cond_resched();
 		}
 }
 
diff --git a/drivers/mtd/tests/torturetest.c b/drivers/mtd/tests/torturetest.c
index 841689b4d86d..94cf4f6c6c4c 100644
--- a/drivers/mtd/tests/torturetest.c
+++ b/drivers/mtd/tests/torturetest.c
@@ -390,7 +390,6 @@ static void report_corrupt(unsigned char *read, unsigned char *written)
 	       " what was read from flash and what was expected\n");
 
 	for (i = 0; i < check_len; i += pgsize) {
-		cond_resched();
 		bytes = bits = 0;
 		first = countdiffs(written, read, i, pgsize, &bytes,
 				   &bits);
diff --git a/drivers/mtd/ubi/attach.c b/drivers/mtd/ubi/attach.c
index ae5abe492b52..0994d2d8edf0 100644
--- a/drivers/mtd/ubi/attach.c
+++ b/drivers/mtd/ubi/attach.c
@@ -1390,8 +1390,6 @@ static int scan_all(struct ubi_device *ubi, struct ubi_attach_info *ai,
 		goto out_ech;
 
 	for (pnum = start; pnum < ubi->peb_count; pnum++) {
-		cond_resched();
-
 		dbg_gen("process PEB %d", pnum);
 		err = scan_peb(ubi, ai, pnum, false);
 		if (err < 0)
@@ -1504,8 +1502,6 @@ static int scan_fast(struct ubi_device *ubi, struct ubi_attach_info **ai)
 		goto out_ech;
 
 	for (pnum = 0; pnum < UBI_FM_MAX_START; pnum++) {
-		cond_resched();
-
 		dbg_gen("process PEB %d", pnum);
 		err = scan_peb(ubi, scan_ai, pnum, true);
 		if (err < 0)
@@ -1674,8 +1670,6 @@ static int self_check_ai(struct ubi_device *ubi, struct ubi_attach_info *ai)
 	ubi_rb_for_each_entry(rb1, av, &ai->volumes, rb) {
 		int leb_count = 0;
 
-		cond_resched();
-
 		vols_found += 1;
 
 		if (ai->is_empty) {
@@ -1715,8 +1709,6 @@ static int self_check_ai(struct ubi_device *ubi, struct ubi_attach_info *ai)
 
 		last_aeb = NULL;
 		ubi_rb_for_each_entry(rb2, aeb, &av->root, u.rb) {
-			cond_resched();
-
 			last_aeb = aeb;
 			leb_count += 1;
 
@@ -1790,8 +1782,6 @@ static int self_check_ai(struct ubi_device *ubi, struct ubi_attach_info *ai)
 		ubi_rb_for_each_entry(rb2, aeb, &av->root, u.rb) {
 			int vol_type;
 
-			cond_resched();
-
 			last_aeb = aeb;
 
 			err = ubi_io_read_vid_hdr(ubi, aeb->pnum, vidb, 1);
diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index 8ee51e49fced..52740f461259 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -1257,8 +1257,6 @@ static int __init ubi_init(void)
 		struct mtd_dev_param *p = &mtd_dev_param[i];
 		struct mtd_info *mtd;
 
-		cond_resched();
-
 		mtd = open_mtd_device(p->name);
 		if (IS_ERR(mtd)) {
 			err = PTR_ERR(mtd);
diff --git a/drivers/mtd/ubi/cdev.c b/drivers/mtd/ubi/cdev.c
index f43430b9c1e6..e60c0ad0eeb4 100644
--- a/drivers/mtd/ubi/cdev.c
+++ b/drivers/mtd/ubi/cdev.c
@@ -209,8 +209,6 @@ static ssize_t vol_cdev_read(struct file *file, __user char *buf, size_t count,
 	lnum = div_u64_rem(*offp, vol->usable_leb_size, &off);
 
 	do {
-		cond_resched();
-
 		if (off + len >= vol->usable_leb_size)
 			len = vol->usable_leb_size - off;
 
@@ -289,8 +287,6 @@ static ssize_t vol_cdev_direct_write(struct file *file, const char __user *buf,
 	len = count > tbuf_size ? tbuf_size : count;
 
 	while (count) {
-		cond_resched();
-
 		if (off + len >= vol->usable_leb_size)
 			len = vol->usable_leb_size - off;
 
diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
index 655ff41863e2..f1e097503826 100644
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -1408,9 +1408,7 @@ int ubi_eba_copy_leb(struct ubi_device *ubi, int from, int to,
 		aldata_size = data_size =
 			ubi_calc_data_len(ubi, ubi->peb_buf, data_size);
 
-	cond_resched();
 	crc = crc32(UBI_CRC32_INIT, ubi->peb_buf, data_size);
-	cond_resched();
 
 	/*
 	 * It may turn out to be that the whole @from physical eraseblock
@@ -1432,8 +1430,6 @@ int ubi_eba_copy_leb(struct ubi_device *ubi, int from, int to,
 		goto out_unlock_buf;
 	}
 
-	cond_resched();
-
 	/* Read the VID header back and check if it was written correctly */
 	err = ubi_io_read_vid_hdr(ubi, to, vidb, 1);
 	if (err) {
@@ -1454,8 +1450,6 @@ int ubi_eba_copy_leb(struct ubi_device *ubi, int from, int to,
 				err = MOVE_TARGET_WR_ERR;
 			goto out_unlock_buf;
 		}
-
-		cond_resched();
 	}
 
 	ubi_assert(vol->eba_tbl->entries[lnum].pnum == from);
@@ -1640,8 +1634,6 @@ int ubi_eba_init(struct ubi_device *ubi, struct ubi_attach_info *ai)
 		if (!vol)
 			continue;
 
-		cond_resched();
-
 		tbl = ubi_eba_create_table(vol, vol->reserved_pebs);
 		if (IS_ERR(tbl)) {
 			err = PTR_ERR(tbl);
diff --git a/drivers/mtd/ubi/misc.c b/drivers/mtd/ubi/misc.c
index 1794d66b6eb7..8751337a8101 100644
--- a/drivers/mtd/ubi/misc.c
+++ b/drivers/mtd/ubi/misc.c
@@ -61,8 +61,6 @@ int ubi_check_volume(struct ubi_device *ubi, int vol_id)
 	for (i = 0; i < vol->used_ebs; i++) {
 		int size;
 
-		cond_resched();
-
 		if (i == vol->used_ebs - 1)
 			size = vol->last_eb_bytes;
 		else
diff --git a/drivers/mtd/ubi/vtbl.c b/drivers/mtd/ubi/vtbl.c
index f700f0e4f2ec..6e0d8b3109d5 100644
--- a/drivers/mtd/ubi/vtbl.c
+++ b/drivers/mtd/ubi/vtbl.c
@@ -163,8 +163,6 @@ static int vtbl_check(const struct ubi_device *ubi,
 	const char *name;
 
 	for (i = 0; i < ubi->vtbl_slots; i++) {
-		cond_resched();
-
 		reserved_pebs = be32_to_cpu(vtbl[i].reserved_pebs);
 		alignment = be32_to_cpu(vtbl[i].alignment);
 		data_pad = be32_to_cpu(vtbl[i].data_pad);
@@ -526,8 +524,6 @@ static int init_volumes(struct ubi_device *ubi,
 	struct ubi_volume *vol;
 
 	for (i = 0; i < ubi->vtbl_slots; i++) {
-		cond_resched();
-
 		if (be32_to_cpu(vtbl[i].reserved_pebs) == 0)
 			continue; /* Empty record */
 
@@ -736,8 +732,6 @@ static int check_attaching_info(const struct ubi_device *ubi,
 	}
 
 	for (i = 0; i < ubi->vtbl_slots + UBI_INT_VOL_COUNT; i++) {
-		cond_resched();
-
 		av = ubi_find_av(ai, i);
 		vol = ubi->volumes[i];
 		if (!vol) {
diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
index 26a214f016c1..5ff22ac93ba9 100644
--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -190,8 +190,6 @@ static int do_work(struct ubi_device *ubi)
 	int err;
 	struct ubi_work *wrk;
 
-	cond_resched();
-
 	/*
 	 * @ubi->work_sem is used to synchronize with the workers. Workers take
 	 * it in read mode, so many of them may be doing works at a time. But
@@ -519,7 +517,6 @@ static void serve_prot_queue(struct ubi_device *ubi)
 			 * too long.
 			 */
 			spin_unlock(&ubi->wl_lock);
-			cond_resched();
 			goto repeat;
 		}
 	}
@@ -1703,8 +1700,6 @@ int ubi_thread(void *u)
 			}
 		} else
 			failures = 0;
-
-		cond_resched();
 	}
 
 	dbg_wl("background thread \"%s\" is killed", ubi->bgt_name);
@@ -1805,8 +1800,6 @@ int ubi_wl_init(struct ubi_device *ubi, struct ubi_attach_info *ai)
 
 	ubi->free_count = 0;
 	list_for_each_entry_safe(aeb, tmp, &ai->erase, u.list) {
-		cond_resched();
-
 		err = erase_aeb(ubi, aeb, false);
 		if (err)
 			goto out_free;
@@ -1815,8 +1808,6 @@ int ubi_wl_init(struct ubi_device *ubi, struct ubi_attach_info *ai)
 	}
 
 	list_for_each_entry(aeb, &ai->free, u.list) {
-		cond_resched();
-
 		e = kmem_cache_alloc(ubi_wl_entry_slab, GFP_KERNEL);
 		if (!e) {
 			err = -ENOMEM;
@@ -1837,8 +1828,6 @@ int ubi_wl_init(struct ubi_device *ubi, struct ubi_attach_info *ai)
 
 	ubi_rb_for_each_entry(rb1, av, &ai->volumes, rb) {
 		ubi_rb_for_each_entry(rb2, aeb, &av->root, u.rb) {
-			cond_resched();
-
 			e = kmem_cache_alloc(ubi_wl_entry_slab, GFP_KERNEL);
 			if (!e) {
 				err = -ENOMEM;
@@ -1864,8 +1853,6 @@ int ubi_wl_init(struct ubi_device *ubi, struct ubi_attach_info *ai)
 	}
 
 	list_for_each_entry(aeb, &ai->fastmap, u.list) {
-		cond_resched();
-
 		e = ubi_find_fm_block(ubi, aeb->pnum);
 
 		if (e) {
-- 
2.31.1


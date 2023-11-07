Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E857E4B46
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344139AbjKGWAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbjKGV7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:59:32 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BA510E4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:59:30 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJLZx028111;
        Tue, 7 Nov 2023 21:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=z23gi0AtPCZZif+I2F8wsU0hcS0zcnRuySiHcw3gMC0=;
 b=Mks59KGeX405Q3IgJ5hTuBU9MQdOgWh7PHXUqiAPjslkjNP+baul0f9D2YWeGtNyiIFo
 yEwSTOkv5j7ef7Mc1J1Id3wU0WV6MhfuVW8T+UuhIUdQXFmJAX7kyudRq0lpbQrQrP7W
 qH9/RKY3+wu8W89pk4pcQneTxS14AVv3+gBylPP2yRf0WPB2VdDeDG2vwA0vv6GQcjbA
 zpzMPP7ljnxiONWZXKJrxurX+yjYYH3AhyJCt/tpKKHd67HbDqxXDXvuREJNg5XVC2T4
 TTn3XUWA+wGMt4aZ1v+QnnCn13V+eIQR9Nq3ELxF2wFFycPO6Ow7w4b3ZEaWP6l5uMA2 fg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23029k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:24 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LItT5000430;
        Tue, 7 Nov 2023 21:58:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1wsjve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kH0jKf9JdPgE9jJt3JVYPPEb3nZvEsD8SqLPSa7yGaRJjXG36xVrpca8gvWdoBWSaLR/RlAd7H3QgqZa2c6frHT/YRflbX5XY09Atb45JN0WVXHUnd5VnNP3gUwWEOIycmXAKq5/SIMwephmVc/bHh86phsETREGxRoAIJBPlJe+f0Zzpf2V56u2ffHkIs6hIqEw+Yo50llbWrMt0PSsdBHW5AxmVr9Bkn7/pitklawc60KEFED/T/O1L5rXimGAZSgHG1c3dq5wqgygzD8KQ86pTaFC7E4LhnzXLobjARGcMMQGlMW/rdKZx6rXFpx2YWEOqKe7MwfP4ET0aNy/XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z23gi0AtPCZZif+I2F8wsU0hcS0zcnRuySiHcw3gMC0=;
 b=LTOZnm8AiYEwp/Hu6YctvDGwZsEFrKIg7ZDNN/ESseFn2i2X7sOAuptQUkuMd01qMObZkAazKE30PSdAXHiXb7I6Ok45S0G4CvybbS4Zel0yKAb94aVcyYNuMnwNpJ51mZJeAmofTk1or/FzxP/MT5ZzPHg8aHTQ/ug4jzERbQKAPccFgLkwbZh+DxbZxANo15CbdKXKEaAWh6ldJxzbBKDXbFYQeR7X8fANliFRwH5lTEUpy4LjfI1hZlkK6PH/Ug5Ay7GxASEJHjRdhvU6iJ2EUZZgnIsUZskCQGvBKlurHeK58qQCs1mujwbAM5rDEqWWYkrLbBAkDdZe633V6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z23gi0AtPCZZif+I2F8wsU0hcS0zcnRuySiHcw3gMC0=;
 b=NUW4SUMrtSVI+bDj/sw+0O7V+GzregqnvGl59eEf8CnCtZuthbOop0BdmvIAlFHyTzCSBrXUbg7cg/faAh+YOhTcI/LjKZE/SrTP2Pr2a/1oqetRcUNxWrPqyjHkCGZNNO6ZGtYuzujaWzVVc9jaW5IZ8KB0AzH8LAodZMR20eE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5048.namprd10.prod.outlook.com (2603:10b6:408:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 21:58:20 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:58:20 +0000
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
Subject: [RFC PATCH 12/86] Revert "sched/preempt: Refactor sched_dynamic_update()"
Date:   Tue,  7 Nov 2023 13:56:58 -0800
Message-Id: <20231107215742.363031-13-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0012.namprd06.prod.outlook.com
 (2603:10b6:303:2a::17) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: 320f4a32-1e51-4f5f-98d3-08dbdfdca7ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dMHsp3s+HoPVPw2EZbN2edDtvrtSP1qzdWLj6bjOrDToo8qagclXp8rwEW/rUN6uNyiYK4FQUMCd+M6pW/VVhs7HacklTrZWzpanaB8xnHHIrng3fAsQs6dyK942N4nfX7eJkNkOQSU8fAY3JQeBPtfwpsfcktU7feXvB2LqVIgXxlK6RvuOgeN1yhZZWxzOa/+0syL/+oSMmsEvETVSraH/98Rg/GZJYJrbf/ZldHUhkSWXoQdiK+UbdgyZ5MRfGWg0kq8PeoEiZDUajQpN/lhH2Ug2NJzxjsiw/AqQzN/+eeAe7xa2yesa8unUC0bQmAFc/jV2rH5dgNhw4A5BUriu+mSaHMhetRGTIfIlpq0kBMIo+0suQZaqP7LbMR42G6OR6HWBAiS+HsH7X5YMau/0hJkdc614waTePZYKlNEx6OGO7CwAZEQFGwhp/1mRVVGISStjipCc4FIjhWZVkDipW7mY28eqfafcg9mKDNsSGUnF0iPLN7ScEP2VHRfcvX4XKAnBCFtMiSAge4Uxf2MCqDNNHG2CfJiZZ6Echu1OOuMOunZHP4CGlMWiF0QV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(8936002)(4326008)(8676002)(66476007)(66556008)(316002)(6916009)(66946007)(41300700001)(103116003)(2906002)(86362001)(7406005)(7416002)(5660300002)(83380400001)(107886003)(2616005)(26005)(1076003)(38100700002)(36756003)(478600001)(6512007)(6486002)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bx9YM9m7pPPC2+G6Gy3FxhJ8+Bz8GFh6fR2m9BFg4F+QDU++anm9MQj3QWu4?=
 =?us-ascii?Q?Ng0qZ2ZkbZf20fuPQIE3HTFtUohpkczcLnDXVFRUBYoyf+8SxvqlFupxrZm8?=
 =?us-ascii?Q?srRLnjjUSax5psnEfjOh0226kxJ5wVOmhwS+jKSTfIXcNcMuHh0PIL27gTXX?=
 =?us-ascii?Q?MHaMuX9BvJ9rXjd4oO4CRr4nVL5zwq8hJh6l3mtO0fl3ze1Gy7uaQMeK3AT8?=
 =?us-ascii?Q?/Nkman+nvRQa7s1DLVqBauqaLJ6PoH1OE5v3sCOsIc2AUoIggt7+aHc9vR0r?=
 =?us-ascii?Q?LbbgxHQNpVgN8arGN52Curs36HzgCQ/f5UiNRUtC/bNLB3Th+OAU98M0LFHz?=
 =?us-ascii?Q?VoQfw+9jLFdAVyt3GXq3apxK8o0QpfBfzTVeF8l9XYN9Yd1QCltpQuqdg5js?=
 =?us-ascii?Q?RtF70C/nMOiC6gLEdISK0LDww0gBNdUyq/9BzwIxqJ60xLYeOJF7f0GYv4iS?=
 =?us-ascii?Q?Q7yZWYQu1+OYI5IDv+YBR5tTBVOBLLYtHL3Vy2O5UqNKZFNDeOhtOlrUj/Iq?=
 =?us-ascii?Q?R9YdN4F0FpY/WoVTGj3RHXKEiMPva9vGiy/v1lpCmlddpSg2SRyoyx+N4Psr?=
 =?us-ascii?Q?pcKuQhGalnON47PC1wkFup6V9iyAw5rYe9nLgaGAVKTEDHsBd3dPrT3/3ZYD?=
 =?us-ascii?Q?sDHwfb3O6BMQ4n928lJ/qgiXoXA18HbsD+pTE2LOhDx8N+j0K1jYhAZq4pxn?=
 =?us-ascii?Q?Jn/93ZYC5BukFvVDga+EK+isKYuIgLEbqH7pGwiODD3Q6O86qNLXBwTsoI7x?=
 =?us-ascii?Q?2vLeaQ+yN5uCyr5QI/zIUQI3JHyiYhCK1hzTca2GqTjhZyVGaW9Kfm+1yPSh?=
 =?us-ascii?Q?nLzSz7zHZFxCND/1NUjUgPwxmGg9vcaoEA/irDT+HlnGUWmDgyPvBs+Dc4NV?=
 =?us-ascii?Q?U4mk2i7yEFKg5ICyuhf0UHlDDD0jqtbPupVuUnjO3Su2xYprbW8Mqtnv8ABA?=
 =?us-ascii?Q?UCPglgfxUxuQpJBUnqpb9WK5Cj+zeaLvnedDXwyGXfN9WNU2G34fsACLqlGy?=
 =?us-ascii?Q?KaZq6NwTMyUdGum/jwqpxrDj+64YZPGT8XBJ5O3VMzfkBnBGL7oj7JMBjqPI?=
 =?us-ascii?Q?AdrgFaEbgVrKq8S78npnj+AmiQMBp9LJNeQIrzqZiobUKTl0eQ17DOaGhRG3?=
 =?us-ascii?Q?urfr2C009/FivxglD1BWoCZRkC6kT3PQAzRsvv6eD5AWPBHbvsDaSkp2bx4l?=
 =?us-ascii?Q?nv1Hoatq7Sfczp8rn9tAb4xJ3qUzP3x0HOfMi8tnkKrlzcNPSpG+UgqbHHbF?=
 =?us-ascii?Q?zd92U42BmPRlIw8WDnLfF3+tauYA245JlzRAkwPQUSDELIy4Detnkzo/D6PB?=
 =?us-ascii?Q?cAxZljYrNZw2rTsoPltkMfOJyaDIvFPl20R1UBRMp5jBmzpoFdq3TtD4ZTi6?=
 =?us-ascii?Q?ALkmGeM4iNAoxe7FLOjZKr8Hb2z4uRz2IHg4FHPUAnBnMjA8/sLDLM5x5KcY?=
 =?us-ascii?Q?6GS/56nfZRZzWMKj2YhRtu/oxpk846wgABilVkNui0o9n2sAH873pUf+q0ge?=
 =?us-ascii?Q?Zg+ebtt54NHnYPLRJSKaQLjmD/Z0D8nyhXPaeGszzM0ZofxFq4lGjkEr0DEv?=
 =?us-ascii?Q?H8k5DnvX7ZnFvV+3tVVPOa+xTWEBoJlnGE8A0KiLoIGwq2+E/jBTbjWR6l7V?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?gOCfHTc8rZfUsmxwz1X9B6z1HC78sXy+XDkFhawHBlHWvnGUehLM8PAjLz6n?=
 =?us-ascii?Q?Nxr7Q087d3dnETlDf7IE3jm33DtIzq2Tv0o/5DKkzR6n0OjzsLJfRv8YYqyC?=
 =?us-ascii?Q?4prHcxDA+a7vXDz9un5KUwhorWVzFOa9OZ1fmyLePwoAwVLZilKjLnDW6RAU?=
 =?us-ascii?Q?+8A+fOMtjMsIyTpeNUETrRIz274NhtOjkqZa5QjfptA6ojdijWeSQY+lEwjY?=
 =?us-ascii?Q?OrtC7wh86Nm3i4gN/MY2bySVxza0vf4l1EU41o5UUlimxpw6ryZDoaBYL8AM?=
 =?us-ascii?Q?YJ5f9GMdRqNGSl8wfnyebUb+kPwqBTI9/Gr8nFg9gv994rIS0+ZpZNSE+bcG?=
 =?us-ascii?Q?h8IYRenXLu9v2a96AZo1NY6QFbbodDxAfMTXGhsLmTR0GzCBIRu+4nc32cfc?=
 =?us-ascii?Q?vcFwhTmR7FoJ4hh5c4kMTpg4vJmQy3VG7bIYUkOQ+bbFtDbuVCaSPyNnTNWi?=
 =?us-ascii?Q?arS8lGxlY4xUYg+UAzz59JA/QPiERrunYUgRA1D1hYptxJdf3n5HT+Ru3nz3?=
 =?us-ascii?Q?tli63nSfMeYjDvNaVhR/50NG9wP47tabGMWLTWp96SUE386fUyGMYgjK6AUL?=
 =?us-ascii?Q?sXocKdAcnMi1PY1RB0ImZaMqxjbrjvC1F1sOz/K4hVH90Q3x+1kATzaFvll9?=
 =?us-ascii?Q?4GfnYLb70O0p6nFNoaU4rOWFWmWfXqjzKWizpfd9EpEmO7IVQnc/rtjBdU2F?=
 =?us-ascii?Q?Ldv8kCg1bIM/aGeqwvBQUxXoT2dC91Nz26sAOMbjqcPzV2Iq1h6JJrnX/adL?=
 =?us-ascii?Q?eVBKJ/jq5olt3bNdlQaEKzmEvbj37IpgzQr9+x5xUvWIkGhovF7pWBnf0JGP?=
 =?us-ascii?Q?+LP41Kod32i60b05Z+PIE9nZNZs7aWRjGfRvfmQteEtu/U858tKH3E3gE5K4?=
 =?us-ascii?Q?ezgJDayOzKLA54+INhd/3q0ol5wdA/pBJ14gpxEix7uY78LPIMCBLNm8ahWG?=
 =?us-ascii?Q?HeqRRhTzImD7H30uNpDi7WFIHSHkH8I5BJ8OW4PZSrRuq74396edUJLno45m?=
 =?us-ascii?Q?qoiBKqBxjKJw0iI2mMA7oe2XqwsrZ8pOdoKzQcXid7W/1r/mpk32pl2oCEuK?=
 =?us-ascii?Q?nJIQ6sRRDmrpB/3Xp4Kk4eX2dQ/u/dn0Izg8LkRPMG0bm6JDfIM04qfindVc?=
 =?us-ascii?Q?U4WPoKgS/yZdexwMN2PBdM2Ungih8XEMaQY3rbYQCb4y3SjujkItOfwDMg6i?=
 =?us-ascii?Q?REBnDnx0jD2yFwUtkLAtLAjlwFLMxWGAgoxbTQc4e3JzkZugF8MMPLrp3kqT?=
 =?us-ascii?Q?5n92YeojJNOWYdm5zPudDvlkyDlDn+RGrYErBgcPZ7PQuwr7AczG0ejSAx6P?=
 =?us-ascii?Q?HgvVjyTlOR8vDJtpEJTVmHVvV1R2hUmUrfabQ5FJEbHjYWpprjQJsS4J/d51?=
 =?us-ascii?Q?7o4nA/xh+vV5xKOOkD3ocX937XyUFnIdh5erIaBkYvMov5fEzMMgLnmvuRw8?=
 =?us-ascii?Q?pSKx3Bm+9lqnlrV8xDCzLEtpRkeJg3TbvJDU3NsMO0hu69N4e7P0j3c8mxo4?=
 =?us-ascii?Q?waLZ5qQcmZLH7K0QaaS7K7dYglBTL1TABYVm6JDes4ZP9juRRnMl2zqeCA?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 320f4a32-1e51-4f5f-98d3-08dbdfdca7ed
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:58:20.8165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3Y9KvHETsUeBduK9r18QeP0BNuCkUfu+AwspQ9vn31HQpeoFDbzmJomqZ7pW1w1i5KknBdA/24b3VL+R3AZ/quB1xZLMyOhPkGenpeon1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=862 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070182
X-Proofpoint-GUID: z1oN0H65vRw59VGfHUa9iBN_-9hL8IzC
X-Proofpoint-ORIG-GUID: z1oN0H65vRw59VGfHUa9iBN_-9hL8IzC
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 8a69fe0be143b0a1af829f85f0e9a1ae7d6a04db.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/preempt.h | 10 +++---
 include/linux/entry-common.h   |  2 --
 kernel/sched/core.c            | 59 +++++++++++++---------------------
 3 files changed, 26 insertions(+), 45 deletions(-)

diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 2d13f25b1bd8..495faed1c76c 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -109,18 +109,16 @@ static __always_inline bool should_resched(int preempt_offset)
 extern asmlinkage void preempt_schedule(void);
 extern asmlinkage void preempt_schedule_thunk(void);
 
-#define preempt_schedule_dynamic_enabled	preempt_schedule_thunk
-#define preempt_schedule_dynamic_disabled	NULL
+#define __preempt_schedule_func preempt_schedule_thunk
 
 extern asmlinkage void preempt_schedule_notrace(void);
 extern asmlinkage void preempt_schedule_notrace_thunk(void);
 
-#define preempt_schedule_notrace_dynamic_enabled	preempt_schedule_notrace_thunk
-#define preempt_schedule_notrace_dynamic_disabled	NULL
+#define __preempt_schedule_notrace_func preempt_schedule_notrace_thunk
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
-DECLARE_STATIC_CALL(preempt_schedule, preempt_schedule_dynamic_enabled);
+DECLARE_STATIC_CALL(preempt_schedule, __preempt_schedule_func);
 
 #define __preempt_schedule() \
 do { \
@@ -128,7 +126,7 @@ do { \
 	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule) : ASM_CALL_CONSTRAINT); \
 } while (0)
 
-DECLARE_STATIC_CALL(preempt_schedule_notrace, preempt_schedule_notrace_dynamic_enabled);
+DECLARE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
 
 #define __preempt_schedule_notrace() \
 do { \
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 6567e99e079e..49e9fe9489b6 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -416,8 +416,6 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
  */
 void irqentry_exit_cond_resched(void);
 #ifdef CONFIG_PREEMPT_DYNAMIC
-#define irqentry_exit_cond_resched_dynamic_enabled	irqentry_exit_cond_resched
-#define irqentry_exit_cond_resched_dynamic_disabled	NULL
 DECLARE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
 #endif
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 686e89d4ebb7..2268d9e23635 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6892,11 +6892,7 @@ NOKPROBE_SYMBOL(preempt_schedule);
 EXPORT_SYMBOL(preempt_schedule);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
-#ifndef preempt_schedule_dynamic_enabled
-#define preempt_schedule_dynamic_enabled	preempt_schedule
-#define preempt_schedule_dynamic_disabled	NULL
-#endif
-DEFINE_STATIC_CALL(preempt_schedule, preempt_schedule_dynamic_enabled);
+DEFINE_STATIC_CALL(preempt_schedule, __preempt_schedule_func);
 EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
 #endif
 
@@ -6954,11 +6950,7 @@ asmlinkage __visible void __sched notrace preempt_schedule_notrace(void)
 EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
-#ifndef preempt_schedule_notrace_dynamic_enabled
-#define preempt_schedule_notrace_dynamic_enabled	preempt_schedule_notrace
-#define preempt_schedule_notrace_dynamic_disabled	NULL
-#endif
-DEFINE_STATIC_CALL(preempt_schedule_notrace, preempt_schedule_notrace_dynamic_enabled);
+DEFINE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
 EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
 #endif
 
@@ -8561,13 +8553,9 @@ EXPORT_SYMBOL(__cond_resched);
 #endif
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
-#define cond_resched_dynamic_enabled	__cond_resched
-#define cond_resched_dynamic_disabled	((void *)&__static_call_return0)
 DEFINE_STATIC_CALL_RET0(cond_resched, __cond_resched);
 EXPORT_STATIC_CALL_TRAMP(cond_resched);
 
-#define might_resched_dynamic_enabled	__cond_resched
-#define might_resched_dynamic_disabled	((void *)&__static_call_return0)
 DEFINE_STATIC_CALL_RET0(might_resched, __cond_resched);
 EXPORT_STATIC_CALL_TRAMP(might_resched);
 #endif
@@ -8691,46 +8679,43 @@ int sched_dynamic_mode(const char *str)
 	return -EINVAL;
 }
 
-#define preempt_dynamic_enable(f)	static_call_update(f, f##_dynamic_enabled)
-#define preempt_dynamic_disable(f)	static_call_update(f, f##_dynamic_disabled)
-
 void sched_dynamic_update(int mode)
 {
 	/*
 	 * Avoid {NONE,VOLUNTARY} -> FULL transitions from ever ending up in
 	 * the ZERO state, which is invalid.
 	 */
-	preempt_dynamic_enable(cond_resched);
-	preempt_dynamic_enable(might_resched);
-	preempt_dynamic_enable(preempt_schedule);
-	preempt_dynamic_enable(preempt_schedule_notrace);
-	preempt_dynamic_enable(irqentry_exit_cond_resched);
+	static_call_update(cond_resched, __cond_resched);
+	static_call_update(might_resched, __cond_resched);
+	static_call_update(preempt_schedule, __preempt_schedule_func);
+	static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
+	static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
 
 	switch (mode) {
 	case preempt_dynamic_none:
-		preempt_dynamic_enable(cond_resched);
-		preempt_dynamic_disable(might_resched);
-		preempt_dynamic_disable(preempt_schedule);
-		preempt_dynamic_disable(preempt_schedule_notrace);
-		preempt_dynamic_disable(irqentry_exit_cond_resched);
+		static_call_update(cond_resched, __cond_resched);
+		static_call_update(might_resched, (void *)&__static_call_return0);
+		static_call_update(preempt_schedule, NULL);
+		static_call_update(preempt_schedule_notrace, NULL);
+		static_call_update(irqentry_exit_cond_resched, NULL);
 		pr_info("Dynamic Preempt: none\n");
 		break;
 
 	case preempt_dynamic_voluntary:
-		preempt_dynamic_enable(cond_resched);
-		preempt_dynamic_enable(might_resched);
-		preempt_dynamic_disable(preempt_schedule);
-		preempt_dynamic_disable(preempt_schedule_notrace);
-		preempt_dynamic_disable(irqentry_exit_cond_resched);
+		static_call_update(cond_resched, __cond_resched);
+		static_call_update(might_resched, __cond_resched);
+		static_call_update(preempt_schedule, NULL);
+		static_call_update(preempt_schedule_notrace, NULL);
+		static_call_update(irqentry_exit_cond_resched, NULL);
 		pr_info("Dynamic Preempt: voluntary\n");
 		break;
 
 	case preempt_dynamic_full:
-		preempt_dynamic_disable(cond_resched);
-		preempt_dynamic_disable(might_resched);
-		preempt_dynamic_enable(preempt_schedule);
-		preempt_dynamic_enable(preempt_schedule_notrace);
-		preempt_dynamic_enable(irqentry_exit_cond_resched);
+		static_call_update(cond_resched, (void *)&__static_call_return0);
+		static_call_update(might_resched, (void *)&__static_call_return0);
+		static_call_update(preempt_schedule, __preempt_schedule_func);
+		static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
+		static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
 		pr_info("Dynamic Preempt: full\n");
 		break;
 	}
-- 
2.31.1


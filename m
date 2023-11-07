Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB4F7E4C7E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344313AbjKGXKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbjKGXJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:09:57 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C470310E5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:09:52 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJS8e029120;
        Tue, 7 Nov 2023 23:08:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Z3vyht97jSaaiKqlZMd7yfSZ1HK1jQ6jqCqrZaoLl8c=;
 b=ATpJGS/aY6cZvpBBp/2WcVMo0RpbDb0pBtdHc2TbgnNs7WSBEW/6KkWIJfcMhBqDY5L/
 uB4GlQiPZAus3cdj6EpNvuQRXHvCdDKdN3GEpFkHU60rUdURrjKlRWUrZbrBgVBiuqcj
 Jcm4U22aMHAFUrrPaMdC2ywH4iTYGXH3bwmfny8NeD6VK9Dm+dwp9cNe5i9iYu8r0qkO
 7QjyOJh1jqGy63A/e/gnf8o3yB5dRRktC+zt5gxQ+POD8FSqI9xKvefLxVhYVbDSP45q
 ghLyTBCIg6UtdTeHef/yeLYO7/eDBJkg1Q2amFAnSmVsqJbqhsPHVuAELjczpkWlgM13 QA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23062t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:08:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N5AgJ032041;
        Tue, 7 Nov 2023 23:08:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w2247pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:08:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7D1CxbrVyhTZ0g1/HY86uCIyB/kUi7swtMeujudnieGvBHLdx03NuFOZOKIq/modcObWpSrg3Ym++FUOE525hPQ3lUuDDEi5T81gMLJadEzwrF7wkOgWKdMnNnRRmQwkcRAtE8GV9KzJc1XhVjFEC28+ZogGMH+TPSNY32iZ7fJs9jM1OOHKT6pejfQQVMxUgrIJ6sfbUhwcBNy2389WOeFVpL6dVY0kip5ixghzK1EoStmZRXVmYBUl1cvAY6ZK9W6vqn6oAXatIe1Pmv8lAT6oWqHJLt5JIE5ZZmnl2IwyPDleNidy5X6mhtvJ0aCBwU/ONR9PLR/jLsejxOOxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3vyht97jSaaiKqlZMd7yfSZ1HK1jQ6jqCqrZaoLl8c=;
 b=jiPri7P5ruY9q7rFhuiz5FvQQgvwcAROG07KQCrVC1hG5gYjl3bmDsqOIuzCspHv8DlmCksCg0eam5mT+LxYGOGEJ4XhWRGzPoz8yl8TSrQtXjJ09ZcnLlz68e0OS8GJu9wifIWOIggAVQcvSOmcABISFD9oSIF0EAq8qAVNghSk0ZHF/kUGOeel1w9E5qN2H/TB8I+r5kg3LFjNWuvOLf7h8ey+b9IZ47LKoQhSHM0bRgnZkoZRFI73qf/BctXAYhtAkpshZ+BRU3+02V6e6gDFwTMOXoUM0kXlQ7G4iELPmUtktfk1+ZGUS89KnOnx982THZ9NZrDwd6RErCEgTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3vyht97jSaaiKqlZMd7yfSZ1HK1jQ6jqCqrZaoLl8c=;
 b=ISYhFKIRJkzz3ciGgW+nWSK6TLlTIAw2+pQeGADBPCUPB4TiCt/fXerydFkbaw8G+vgdoiC1iPYcEwz4g1xzQ79S2GumRdqp02jN2NkLepRvWhc0y93zJT9Tpx24JWDccNyR3LfbE9TItJIbXxRb6/iRPn7quPnwKbPd/+FmTsE=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 PH7PR10MB7010.namprd10.prod.outlook.com (2603:10b6:510:274::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.25; Tue, 7 Nov 2023 23:08:40 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:08:40 +0000
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
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [RFC PATCH 62/86] treewide: trace: remove cond_resched()
Date:   Tue,  7 Nov 2023 15:07:58 -0800
Message-Id: <20231107230822.371443-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::18) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|PH7PR10MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: 422bde6b-7587-4a80-e8a1-08dbdfe67aec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DC/etMAh+Uqw2PoQKHxdlf5R3xMA4Ujt4jJx7B6thQzRQ8l21qktwr2Smu7oq+W8pVOIjowNBJpGyGWXzMy3j/a4P6ylnJ+x4vNAf/Vo4gcxm8fjpkJxh4T+6hUFhWr734w/GkYIjAWQi2+yffKKPgAPf4CPRREkVtbgeeIfmJv7KbnTCRfUbBbcQv8a7YL2fVCIPdoV9Fvc/lrnEBTIapdpCleAgwd89f2n/wTmRivSEf5hE+vxqqbM75Lw80feQG8ZyebVSGcLEQzCFtoVsnm8tMKj4jSaxoB+2EPEZKAogFuGDxKjGtN220BnyIm1lX5SHCR5B9Ws59G/BMXSny6pll9ZWb0oojvNKtmMWhkQK2KqIveMDOSDVz3MrUy8bsphXFJNFnXTLyJbk/0+l5qR4nPra8AGy2GJYyCTjCrGNh4KEMmdebs8gui4/ELekM2L3KWzYU76rDAattP5h43mtqKbv1gsEtqbNNB3dQfYDhP7bxmXQccRsZ5nlxwLMXY8E2LQCF/03o/E1kwRH+Ppkp+S2U535INGBSC6tqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(7416002)(966005)(7406005)(6486002)(478600001)(6666004)(54906003)(8676002)(316002)(66556008)(6916009)(66946007)(5660300002)(66476007)(4326008)(8936002)(6506007)(66899024)(2616005)(41300700001)(1076003)(26005)(83380400001)(6512007)(38100700002)(103116003)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rQjwd3uR/tRZ0p6PEPkqsIKTYEWVVuWXzqm8Hbmq44QoJ6k3UxGPZRE+4/E8?=
 =?us-ascii?Q?uQxVLXBmA332PEArpkbzdKQaJwiiS9JVTmoXEry1SkhrJgXTpD3qqEXvr7Cb?=
 =?us-ascii?Q?jRdKshJUW5xno7I+R+1NrBXgL3LA9QG3i9hFwki+588RnimbH73US6qgiNZ5?=
 =?us-ascii?Q?cXgfbQv3u0/aklLZ20ztYsYXyHXHqVCU/vaNQzpM4FVCfo+i2VKMVdqizMP2?=
 =?us-ascii?Q?Wu5H2rqPMOakVBKujIj3Jkm+o88ZKcIW0CyBeDJBQUt2ZI6ztoWXEegpm6/+?=
 =?us-ascii?Q?GesAO/KRA0dg5/pYrLyZJYNwdQPSlAnSsgLoTT6H6HO8irZzvk12xkW0jRYj?=
 =?us-ascii?Q?mOQdlMCdIuyBw8nzCt5O4GFMtfSeLDY7tLnKgGQOcw2bC/VmL+nlZNWTJCrN?=
 =?us-ascii?Q?rGPiMHZYbL8oDuo53utlMwOZr8Icl6oxs7w2t3XBkeO4/5uLBcbyxHyvAuUW?=
 =?us-ascii?Q?ZO10+kw33oI/Nm3LmUdFpjj+b0ngtrx7S8z/QhOTz7IQG0EbU8ujY+AiwC5V?=
 =?us-ascii?Q?dcAWfFINRUH7rW9/NjdyG/B7x6hvbL/WgH6HfF+p/ZSc0ZK5ZiX55J94bwgO?=
 =?us-ascii?Q?M6+vVMoWDTyU14dS4XKrZsY5MyBhIOOHRe5j3ETlozVKxAjAhoollu+aPWfx?=
 =?us-ascii?Q?borBNPJT+/0DdKnSA8lLmh2gdNF6zTnM8xJ8TvrKiUeKQp4+uTAp+dyjMWFn?=
 =?us-ascii?Q?y5hYjboqN/N/xTUiXtep71gNn2K/aocKYu87FmpADB4naiLU1W2y44/Ri0PO?=
 =?us-ascii?Q?ExhlX1mCsqJ1Ts364o3Mh25VUZIcjX/yZykK6VOxr5EXkOkCRrANrMhXq8Ki?=
 =?us-ascii?Q?dD1gKBa/fYXHSz0l3fZ2LU/rvRPmTXxZP+UZRBgR2NJL9bUPUi5v7pk1Jfxm?=
 =?us-ascii?Q?VlfXxgtlcrhFkRM9HG8Ae//mkC0ixzVfIPGqZJaYs3VNBKvsTKRwzhpf8gzT?=
 =?us-ascii?Q?xsqwVWg49bmLwUzI/0R25bpMew5t50lMUj/l03KMkBEMd6JYwdVBAPTj0Ew3?=
 =?us-ascii?Q?WK+nL2yiU43duYMDqpgTfYOCTMaVyPCaCfu3TM+OrI10kQVMyJMNTy5P24EO?=
 =?us-ascii?Q?bhPaygmRRuz/IzRYO5/BWWKl6J18Je2yaQ5KbW+Kp4vf6CCEpLHXBNvIQD6E?=
 =?us-ascii?Q?lXo16e7KDD4c7VZmqoRwVb2DEPizayExguEAL6Cx86zaaB3lkxpsOEa+Eox/?=
 =?us-ascii?Q?f8XyxtavYKWAtXRgTrEpUOz3ahyQTzs3fhz8gd54+GnXivLnY3TnMlPJkqCX?=
 =?us-ascii?Q?G5zMcv99u4+GjIp4BLSiJ6pEPhHhYTnGXVbSttmHSy9ZgpgWLtCsci9lQ87W?=
 =?us-ascii?Q?M5hvmlJbisKUP6Qfja61cBpNx3hfRwT5fl/znebDFkX5v0Ekp1c5CukHuzAz?=
 =?us-ascii?Q?A1EQzsZfwm3sH+WavPzukeY2tuusKsZsxNqBdxEfK5eu8IIcFMBgbOpsL5dL?=
 =?us-ascii?Q?br7UQ02XaFYXAjd6Kc+xKUDBHnAhxvst00jjf4dJTFYFyMhCBS0ey6m04WlZ?=
 =?us-ascii?Q?wbmMp9ABE4i2qkwikQ1Ud84hUdNaDykJgNrXoCeH+ryHAD6BW095Yb/dbwK5?=
 =?us-ascii?Q?tU6LP4WOp7ArhFMp11WgwdhH3+p58pMY21DuFdBV/jVDkeFNPZujB/Xiy5IA?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?W8W5H7jAgR63yjJIb1bqPZaW8NMiIuP8jD1IT1R0FeOuFIHY7VbSmu7e1Q7w?=
 =?us-ascii?Q?CMIg+688whZpT8YHTvHpNTHNXdvSL7cI8UC78UeuFRku9Q3zj6WiqAq2EDgM?=
 =?us-ascii?Q?cMIlkoPqEiPDY2FjzKG78AjJTj7uyYeII+x3cl56AyuF8lBrY0ThUZzfkW74?=
 =?us-ascii?Q?3TcWGCihVGYnM6iKR5dWhnaSmdLNTLTil5FKPliHLedpFtQuNtam01unUS+m?=
 =?us-ascii?Q?rxKf2wcEkf5Lr6XiSZep9x3j6yQ3l2i0TOL2qV8jedcIC4zs5pqwdjCLSAik?=
 =?us-ascii?Q?EMPPQ/OxsgVP9sKdmdLaNl/GYi+lNigyy6lPStl0scY0Z511BJYRrwV3+YMS?=
 =?us-ascii?Q?CZ79Nd4aV9zcIbsXCfezzCp1hN+rDG4HNhPg5O6j95pozR4S4vwtPoIUKdKn?=
 =?us-ascii?Q?pnkhfKyvEgfRTpIhyXSvoqkMRN/okJk+8+oo83MwX7XWxupJLu+HtUcsekgf?=
 =?us-ascii?Q?VCzq6+RmZzMokvzJxk/IOTpbEBPBiIPPs7HIBIECcYMDbLuKxtiErES7mioP?=
 =?us-ascii?Q?OtTf8+3D/WDBiWFdTQfxkfAImtrOunGd2jVRHP4YBIMwU64QO9RS/aHZw2i2?=
 =?us-ascii?Q?5oEBJfsPTdjLO6uTkFu03ATfFqLn3TCQpNjxc8SixDlmdecDuXAG+jN8Z7Po?=
 =?us-ascii?Q?0yScxUoRB8JgbXOaefvMSrQn6edTSxcDFkl2pmqGgz0TL98yNTKHyyy4l/K+?=
 =?us-ascii?Q?TIsWCcCzIiqUT+w8KIhbMxxEvtfgx0FsTCQcKPapEkRKtlxI7F1F8LTFtAFw?=
 =?us-ascii?Q?Bz0hq6BCgU2L5ef+aXKTkUNn+R81mpzSXXByarM1L93LZMEDFQyC+//B7meE?=
 =?us-ascii?Q?YnpX5SWBLADXngMQqW1xUN3IvziK9w12OlQdUbIpGUgXqp0HR43w8txPpYSC?=
 =?us-ascii?Q?JQK9JDgWrcnZqnFPCXDhCA9DHc8eQW+KKQsIfvilKpI25/5JUqnKwgP6+84B?=
 =?us-ascii?Q?qn2JMWmM9/u+5SFoeYo/yeVCzxEZrdiofkQaboqWYJoUSSmpjw7JJ/a7eToe?=
 =?us-ascii?Q?UkjP+E6/tcgoqpcWNJUeCQWebmiEFMowzVLWqQAACie6MOkb5aH1oeXB4ahb?=
 =?us-ascii?Q?16F+HHT8x2cPRVMUOyAfFWhgVqJi+v3RockJLi4rKYTFB6/Hk1k/0T3Tjo4o?=
 =?us-ascii?Q?SRxfC3iOxPcceM+b5rSWW2veancvcr06P0E2OVZrEUAst0LjI5Oycy5MQUe9?=
 =?us-ascii?Q?Ysy9iENguerMozKP8PKPCaIck81C25PYrr4MKAB1l9hOAnPfom7VuTn2h5qn?=
 =?us-ascii?Q?ojwosFjxdxY5wo8H0Dk9HcMXzXU3BCVRucL7EsSuUTcDipW9LGSGdK+GWMjL?=
 =?us-ascii?Q?B20PkBsPrZ3kLmEARXUaBqW4g9iJp3ug6HuJaGUpZB1k/qIZUAZvnJ6375ZI?=
 =?us-ascii?Q?hSB8Hf/EE6X+/xPwOFeAlC0rrWFv4w4Q27Aw+PKXF8lb3uJDEV8NGvvCK5uf?=
 =?us-ascii?Q?E8nf+5OivGl8Hc3siDciZkJ4BKuLcjqzbjLIL7RguLDPEkDs/XYUup+Zpvtp?=
 =?us-ascii?Q?w199x77ufRQ4jmvFqG4HZZ9gKGtZYxwUDJWq+EthE3MiJFIbJGsheAiwyWRx?=
 =?us-ascii?Q?EfanWhIS6OXq18SGrtc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 422bde6b-7587-4a80-e8a1-08dbdfe67aec
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:08:40.2404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kbHG77toslGsXPXMoZtSAIk+/t/m7rvoE4lDG8e90OniOKCONSPkw91mpklJkg69byLl3xijjcEOXB6p7qTEBYcVmjyvgxfVilOf4t7L1to=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7010
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070189
X-Proofpoint-GUID: _itpNuPFzLRVEWNGzTbHz_qNX7vWHIOz
X-Proofpoint-ORIG-GUID: _itpNuPFzLRVEWNGzTbHz_qNX7vWHIOz
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

All the cond_resched() calls here are from set-1. Remove them.

[1] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/trace/ftrace.c                |  4 ----
 kernel/trace/ring_buffer.c           |  4 ----
 kernel/trace/ring_buffer_benchmark.c | 13 -------------
 kernel/trace/trace.c                 | 11 -----------
 kernel/trace/trace_events.c          |  1 -
 kernel/trace/trace_selftest.c        |  9 ---------
 6 files changed, 42 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 8de8bec5f366..096ebb608610 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2723,7 +2723,6 @@ void __weak ftrace_replace_code(int mod_flags)
 	struct dyn_ftrace *rec;
 	struct ftrace_page *pg;
 	bool enable = mod_flags & FTRACE_MODIFY_ENABLE_FL;
-	int schedulable = mod_flags & FTRACE_MODIFY_MAY_SLEEP_FL;
 	int failed;
 
 	if (unlikely(ftrace_disabled))
@@ -2740,8 +2739,6 @@ void __weak ftrace_replace_code(int mod_flags)
 			/* Stop processing */
 			return;
 		}
-		if (schedulable)
-			cond_resched();
 	} while_for_each_ftrace_rec();
 }
 
@@ -4363,7 +4360,6 @@ match_records(struct ftrace_hash *hash, char *func, int len, char *mod)
 			}
 			found = 1;
 		}
-		cond_resched();
 	} while_for_each_ftrace_rec();
  out_unlock:
 	mutex_unlock(&ftrace_lock);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 515cafdb18d9..5c5eb6a8c7db 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1996,8 +1996,6 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 	tmp_iter_page = first_page;
 
 	do {
-		cond_resched();
-
 		to_remove_page = tmp_iter_page;
 		rb_inc_page(&tmp_iter_page);
 
@@ -2206,8 +2204,6 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 				err = -ENOMEM;
 				goto out_err;
 			}
-
-			cond_resched();
 		}
 
 		cpus_read_lock();
diff --git a/kernel/trace/ring_buffer_benchmark.c b/kernel/trace/ring_buffer_benchmark.c
index aef34673d79d..8d1c23d135cb 100644
--- a/kernel/trace/ring_buffer_benchmark.c
+++ b/kernel/trace/ring_buffer_benchmark.c
@@ -267,19 +267,6 @@ static void ring_buffer_producer(void)
 		if (consumer && !(cnt % wakeup_interval))
 			wake_up_process(consumer);
 
-#ifndef CONFIG_PREEMPTION
-		/*
-		 * If we are a non preempt kernel, the 10 seconds run will
-		 * stop everything while it runs. Instead, we will call
-		 * cond_resched and also add any time that was lost by a
-		 * reschedule.
-		 *
-		 * Do a cond resched at the same frequency we would wake up
-		 * the reader.
-		 */
-		if (cnt % wakeup_interval)
-			cond_resched();
-#endif
 	} while (ktime_before(end_time, timeout) && !break_test());
 	trace_printk("End ring buffer hammer\n");
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0776dba32c2d..1efb69423818 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2052,13 +2052,6 @@ static int do_run_tracer_selftest(struct tracer *type)
 {
 	int ret;
 
-	/*
-	 * Tests can take a long time, especially if they are run one after the
-	 * other, as does happen during bootup when all the tracers are
-	 * registered. This could cause the soft lockup watchdog to trigger.
-	 */
-	cond_resched();
-
 	tracing_selftest_running = true;
 	ret = run_tracer_selftest(type);
 	tracing_selftest_running = false;
@@ -2083,10 +2076,6 @@ static __init int init_trace_selftests(void)
 
 	tracing_selftest_running = true;
 	list_for_each_entry_safe(p, n, &postponed_selftests, list) {
-		/* This loop can take minutes when sanitizers are enabled, so
-		 * lets make sure we allow RCU processing.
-		 */
-		cond_resched();
 		ret = run_tracer_selftest(p->type);
 		/* If the test fails, then warn and remove from available_tracers */
 		if (ret < 0) {
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index f49d6ddb6342..91951d038ba4 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2770,7 +2770,6 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
 				update_event_fields(call, map[i]);
 			}
 		}
-		cond_resched();
 	}
 	up_write(&trace_event_sem);
 }
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 529590499b1f..07cfad8ce16f 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -848,11 +848,6 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	}
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
-	/*
-	 * These tests can take some time to run. Make sure on non PREEMPT
-	 * kernels, we do not trigger the softlockup detector.
-	 */
-	cond_resched();
 
 	tracing_reset_online_cpus(&tr->array_buffer);
 	set_graph_array(tr);
@@ -875,8 +870,6 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	if (ret)
 		goto out;
 
-	cond_resched();
-
 	ret = register_ftrace_graph(&fgraph_ops);
 	if (ret) {
 		warn_failed_init_tracer(trace, ret);
@@ -899,8 +892,6 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	if (ret)
 		goto out;
 
-	cond_resched();
-
 	tracing_start();
 
 	if (!ret && !count) {
-- 
2.31.1


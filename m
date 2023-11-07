Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485807E4C82
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbjKGXKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbjKGXKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:10:02 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC301723
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:10:00 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJqao022727;
        Tue, 7 Nov 2023 23:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=JafVxiqnswdVWwpqn3XmzBdsqp/u4CdTWeLJekrmYts=;
 b=Hw+962zu6Yi712n4EeenkP5NQHCYRcDslb0xaB3oOe2tLz8UHhe/2zvlm24rDxlz1uDy
 Q4/uhIxvb5Og5J+KKmfLA8Z3jzrxHy1pYdDJ4hUOlfhD5kXr+uvK/NFr/D+PQYxaY1UU
 IxW4jDNqLZHzEjMeg2jc1UzfoVZV3QSX9MKorAGOmNkUkFeg+iqoPsX2iGj+Rt+mRTc5
 E6SzIF0NYSgmZ1uwXPWJsgN6Sm/kNL492AzZbBTl8vwHALQhZppDhVMP6/ybB8M3dkye
 nNUHEZzpoPvqD8YCwHfJnTISAdezocmcWcg/vyboEWwLFhqQUm5McYjnzpJB59BPsORp 2Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2006ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7Msdnx000524;
        Tue, 7 Nov 2023 23:09:01 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1wvd8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:09:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3R74tya9b6FeKFH2C/BYTCIaUOuZXbVGbQl1E4MmXw7RMK60j+42pljhMfdeWlYDHqyFLL7byzy0eln78Aevy7X1Z+2wFdXJu6FKpVtzkgp45FtHqJqEUbxFHVIfQjxVcUQeL/IULOHcH5UtmkUFsr4O1mZKA2a2jTD4jVCbsAvB6kTaARlbNh9WkmPLqpGAU+7Efjk07FGxt+kOxQvVPKbNCvovMDPjhVRi7cq2wEbMj9JSm7/bb3HyJWgQJYNbfWpG0fjfIfxA8zAe96mPcTWp7LrPU1xh7vwx7XGhQXj5QnSx4TOHC5gBHA+ZyvxFngC3pyivVOKBVawOBgiGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JafVxiqnswdVWwpqn3XmzBdsqp/u4CdTWeLJekrmYts=;
 b=B5IyGS8WMBrPyXOJk9f+hBL0doMo+8cqzFqjjGExQmlWiZjxWftadkWnbiyN8cqFjHnczBlmoJvgqmixpsXRZuanpLLVFMYcR3tNBpYSdAqWmAzO35xDUphfrRp4wkseRflbu1IUrL7v5cQ9nd0FIQ5DcGYoItAsa5ckk2kAqWQEPjR6zCIaJnPMRXPhzwyqSY1K2nxsV6Ihpdv1gpXB1ZO+Zz39eisGL+JgChcVx045wB4/nazQ9Wun/e4WgcNa8JTCxkG+5/HgZ+kXb4doc/0rni578y4HO+50fTcAoy8xmMsUGiBrzPj+ad+64dTJiGbtfi7V6HGiXelAA6t1wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JafVxiqnswdVWwpqn3XmzBdsqp/u4CdTWeLJekrmYts=;
 b=ownyZOK+9nqG7GX5+a0BG7rAy5lOwbNlyMzp2X0AUPk1WhxNWB7QQQPihW/IPu4YH6HRWpV3/M+t05WdIYveXehx44JjKxSQD59eNPdmHYWsPaI2ML0/vwXhbOMm/YQ5JNz/St4i0nbqRdoMwjgGsPIL52pMkMvEzUD/QfYze8I=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 IA1PR10MB7261.namprd10.prod.outlook.com (2603:10b6:208:3f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 23:08:58 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:08:57 +0000
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
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 67/86] treewide: kernel: remove cond_reshed()
Date:   Tue,  7 Nov 2023 15:08:03 -0800
Message-Id: <20231107230822.371443-11-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0067.namprd11.prod.outlook.com
 (2603:10b6:a03:80::44) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|IA1PR10MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ade9d50-cd26-4de6-2a65-08dbdfe68567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MLEy72m5rLy1X4NIK49IbSnCp85Pj4Hl176JZmNsyXM8QjwgY1UO9K4UGMcUZkWnlDucLNUfnDGlauTSz5lBSPf4AOYeeC4bSujfDnTo47bg/OtLzfHPGiDkSZtsyxmx2HhRv2ePTV1Gsbf1JGr1xf4Shi+oJN5RDtXRBO2pZpgaXsGZdS/Vv9vnVYfo8CzkmmXdbbQj5OQli1qxn8PRPFwVcfySBZNC6BW18UetUnaT5Pw2HNFCDifWGKL6SYJZL2+DCaVk2er4F+DZwrtKl5yg0n0S9zUpEWvUaz5HO5hwAf+cWtguOkfhfBpQDxtwHnCUWbmhkU24ReANmc1LA5ncLQkhACZt+D4UPo8g77vBK3VtIKVdw2B6GvMx1Jc2WfilBbR3TvVJCB+il8pCCmdHNS8gSzn/akVnMwldj5x2FJK5cfH0aJyidltEKyqNTNW01CjKt8Rz5u1sJIcMX6QpVSJz7XR2MfFNjW7jp5fEEvkYu1jmHHAtCnSFzh1EbwdbxM0W4IdEQT9Gv71KWvWBK0hkLMFIf7dfHTjJhnA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66899024)(6506007)(478600001)(6512007)(2616005)(6486002)(966005)(6666004)(7406005)(36756003)(103116003)(38100700002)(86362001)(1076003)(41300700001)(7416002)(5660300002)(316002)(66556008)(66476007)(83380400001)(2906002)(54906003)(26005)(66946007)(6916009)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nF0Y+8weTvpZH6CZGTP6m193GNY3Hv70FT+oIpHbabAPQ3X/NYYX0wu4xJM2?=
 =?us-ascii?Q?xLfCwZq9pCVKrEfxRIyOK3eawzQ+nuSTh6aWLuWNzMVlXaR3YUTaOR4p0dGy?=
 =?us-ascii?Q?sQdWLpaRfmMRhbmQZd11p6TyCex59gTX26jJvKnQXqRWkiph+myUPbTOT0Rl?=
 =?us-ascii?Q?d5VgRq13qmX+/t3MuUOrCvdrrBNWNjCmLWA6HNbj1SWafIbGIoTI/9zfO184?=
 =?us-ascii?Q?caMSf+8bbACaIjEo8oeGVwtnKKCp+9RJiIXOuFOoEvXFOckOnHlgbyCH8Xyu?=
 =?us-ascii?Q?k0jKL5Z126f5XzV50HQOlNwUUJc9IWFW9f4/HOgxatqnDySyqoNXxRn6X6vU?=
 =?us-ascii?Q?IjHaMeSlD3ATImmf8lvd9u4QOp0KkwfKVj+mZaCiztpWKXdxQUBR1b/XobiR?=
 =?us-ascii?Q?eEjxZmzCfzLSqdg7p/1IEWTDNOVQCEcCOx/Yu4fxHupEumpcIlWHcLDoc4G2?=
 =?us-ascii?Q?F1RCJzAL4KnQ6YhLc2hjcGkoEIu/TEbHVrRTNmGpHT+uYCGFGqQj2HEC6wCd?=
 =?us-ascii?Q?EXlCU/vywAWn1uH22FrJKu7i6XZeaRiRG1oz6X+P79ypgFErs7yr2VHl3LsD?=
 =?us-ascii?Q?TtsSdau2f8r1FuUzssTkZp2TWfhevadWOK3f2v0ZoedTwm3s1PkaP4lbsvvD?=
 =?us-ascii?Q?Ao1PVCnWjgVXxNbkwSTk+DLGVWpdc5xXSIGuv5rQSq/nAeXHgZMM4qDsYAid?=
 =?us-ascii?Q?JPMogatAhvV5/wQBiH+3LGAtDdxQs0wlS8pz2iDfCmSmYLsgiaexNZT9Y7Oz?=
 =?us-ascii?Q?+2VuL5oUkfECYSrLZml55mJZufvC0rspyH1KRz7R9+bSLCI5//LG/MtXV6Ld?=
 =?us-ascii?Q?8o2txW1/NhesMzdLO35kbypRgOLKDpgire1b77LhLjAWN1e/Vgy5ZDcQFABR?=
 =?us-ascii?Q?Qjvj/B3tWf2upRozShVYsWstjK1D5ep46Ti8L0GKBFew8msvTGK4r630zZ9t?=
 =?us-ascii?Q?sGmqUOHBI7v5mYg0PMSKDbWKMl9cpY+znjc2R21tePZ+R15qirMDLrUMq7ZD?=
 =?us-ascii?Q?ir/lqSM65OJbfTzQG0z5JI3W6d+/1KUUIBnOBFTU7CcksYw+vt4FGw/Mf8IQ?=
 =?us-ascii?Q?rTPE2i3ukppoErs7RZ0uQlU8g6D+OA081Alds3PgO5aPna3QBRAxBBFFJ3ni?=
 =?us-ascii?Q?69WnYu45uT5HCfvvsj8/vpZBS/1o6/DytJhRBHYTopW18KG3CYvXDfzifQgM?=
 =?us-ascii?Q?ZlAJiYH/Xnrh2u90RNIxZEaiAslX1aFj1GyDT6avgqtzL505CalKl4+26Xh8?=
 =?us-ascii?Q?o34j2uPqTQ5rzM5kZ7+b4c9hyEk4YIZQCtt4GTgMZUqMYX3kI92CF5PHvnL5?=
 =?us-ascii?Q?X/5LvTBEVSDyb/HBuHiRMDe7aH8W9zwDF+LveueVnOnMeWYj6kvV/T7pAEFZ?=
 =?us-ascii?Q?Xddc3ZUIqE/Oov8dAv9xzkjnt/FHHaVMg2IXRCDiyR6vXGV76Kp7iQC+XCcW?=
 =?us-ascii?Q?K9gZKaVVyIYNjBYO/eGJBXp3D5g1aOSK5apXftc6vDeV1Ok/R1Q4L2NHSQm2?=
 =?us-ascii?Q?mqgHmlGFizQCIENp5o3Dq/NhACN6NXvmknxX/DVV8tLBHHMvERR423qFpQiS?=
 =?us-ascii?Q?DL9SNIu6Yv61A3F4r0FF0joKW5sJ2HRDjC4bUr1Nb0lRXz/Pc/BTVBRtMCMA?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?mM9ey2aoUSHtUX8ZGZhtNac56mswPpko3rmJFtV4h7Chm6LYSnJNvwGL+k7I?=
 =?us-ascii?Q?dNl7AL76fSOqBua79cOrawHrlYX+EtiuCUF46r2VodPx9wYrBtvrCZa0S7eM?=
 =?us-ascii?Q?axLwhlT7eejb74kvlX8JRBsbxF2iitYaWjY4WjEAn3PgMWBWi9Wv1tkrpKqo?=
 =?us-ascii?Q?7z6vhrzPPCvdX5I3oLL+umk7K/RfrofZPB2ysW3mId8H4j++09TfWoqAoqKM?=
 =?us-ascii?Q?KxS3TyFF+6Wr/N4mONZo3b2cihSA0ST9M+VDVUSXMIaiCocJfERr6rF0G9Mm?=
 =?us-ascii?Q?fHmrXVcCM/5YORg1RO9g90zhEWsgga0SKWYfvrmewEo4saUNxhq2DSuuyym5?=
 =?us-ascii?Q?BHcT0umpBHgw0snix3gc/+dCcl5OdDqyY3wHw9/Kvq0Wu5uHIV0uvZje/40U?=
 =?us-ascii?Q?9Oh3Q7eQADHaC0+vSUtRBi4CtiBcnUxzW5sz1p/4pK9pe5du9IgxhTgBz0RM?=
 =?us-ascii?Q?KPIPMRJzUo3u3GXTsCV6TqSGtkDTqxf9gIjANb+0nqcs6Z3vqe4FV4eEK2O6?=
 =?us-ascii?Q?yd4SGkVvGbpnyc2Wo8fq97mqufkfx4LFI8spCAQ6XoAf8nKrfZ0kcKyaTlxt?=
 =?us-ascii?Q?AiQy3AoPHxwsZ50Y/L4uMtE3eENh7ucsgB6Riv8/pmJcphRuYOdQAUJAuekS?=
 =?us-ascii?Q?NQWsUCH4HhekyrZtWxFqItfKdQRVM+LtaiSUL0LO9ruBUoO46d4EGVyDczYs?=
 =?us-ascii?Q?EaHe0PAnA5Q8sSKZCNXOB7L81w6Td84kcA4REEsGPBAkwFTZULNnJrj7FOR2?=
 =?us-ascii?Q?925NC8shJadheElQhsd8WGWcINrgTBloUw/6x82J0czZZoqzvtyVTIc3/A1H?=
 =?us-ascii?Q?QyTUBeMFM7urAoSRhW20pzTKQY3Yp8NT46cI2BraIy1eDwKXHjSGvEqgIkzd?=
 =?us-ascii?Q?TEtIIcWDBRPqBNhYkvbBrAhOxU0+dZe8CUGJnSVMR/8J8r8Zcg3JNUvcDK4o?=
 =?us-ascii?Q?3647Ws1qJZvHcB1Uz35Ty6rKYZ/wGBVkJeo73RwF2K1rB+hH6mw5CC2JL3n4?=
 =?us-ascii?Q?ImPFPyzlhwvW1/rNGQuiknLt7NJzZOr6gdr5f7fJjiDkCpAz9804/exLOIFp?=
 =?us-ascii?Q?nU3xhcSoe10GcihlkJwGOVYr9J9yecoCd4ETCNTbKej4Vl826hQRwqUdyckv?=
 =?us-ascii?Q?PxFNWtvo7bjtmaYN6dzUi99CGsmwC6AW55YzBV/8bQGKagMqb7Mt0cYTIw9p?=
 =?us-ascii?Q?9Th6LoEFLYg6sKTq/soZcEw9lZC4EAzqvrcrZGL2N+MML9Joex8QLVKOp4U3?=
 =?us-ascii?Q?hzLZaod5JkJXCMGjuRS4iTuf2lchsru2bE3aL4FFcQqA3b1qSb4ZkYv1oeVo?=
 =?us-ascii?Q?M1hXgK+3NCp9Lp/+hHg3zhiqBqvg3onuMHsSIai+Z3r3Q1ODl3uOiiCSwn0H?=
 =?us-ascii?Q?y8SO3SPOqHSwFjHHjIN/qG7T4iM1ESvO3TxNDTxj+1kpvaPIiNCycgsnC8/0?=
 =?us-ascii?Q?GIJW+G0u5tM51/OQkN2s6gC5if93Y+Q7ArexGRGS9SsT1W3QXj1MoLkBvxPL?=
 =?us-ascii?Q?8LNvRS4D0gvDtTM7dMPOga/R7axGGQW+lVGAaVCPq6n6nyk6jZXahSOQeg?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ade9d50-cd26-4de6-2a65-08dbdfe68567
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:08:57.8191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rlxhZS+XXXYdf2aGAka82tw6dnDsekE61b5ap8uPd0B4bl7sGSKQxo80US3WitJqbA9SggSa4NljKrqtoMQ4gbTuZ8xXaKcDPtYPkJoUQyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070189
X-Proofpoint-ORIG-GUID: dwU40Yjw50w1YY45RhAtgApT_BvecWbi
X-Proofpoint-GUID: dwU40Yjw50w1YY45RhAtgApT_BvecWbi
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

All of these are set-1 or set-2. Replace the call in stop_one_cpu()
with cond_resched_stall() to allow it a chance to schedule.

[1] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/

Cc: Tejun Heo <tj@kernel.org> 
Cc: Lai Jiangshan <jiangshanlai@gmail.com> 
Cc: Andrew Morton <akpm@linux-foundation.org> 
Cc: Nicholas Piggin <npiggin@gmail.com> 
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/kthread.c      |  1 -
 kernel/softirq.c      |  1 -
 kernel/stop_machine.c |  2 +-
 kernel/workqueue.c    | 10 ----------
 4 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 1eea53050bab..e111eebee240 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -830,7 +830,6 @@ int kthread_worker_fn(void *worker_ptr)
 		schedule();
 
 	try_to_freeze();
-	cond_resched();
 	goto repeat;
 }
 EXPORT_SYMBOL_GPL(kthread_worker_fn);
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 210cf5f8d92c..c80237cbcb3d 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -920,7 +920,6 @@ static void run_ksoftirqd(unsigned int cpu)
 		 */
 		__do_softirq();
 		ksoftirqd_run_end();
-		cond_resched();
 		return;
 	}
 	ksoftirqd_run_end();
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index cedb17ba158a..1929fe8ecd70 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -148,7 +148,7 @@ int stop_one_cpu(unsigned int cpu, cpu_stop_fn_t fn, void *arg)
 	 * In case @cpu == smp_proccessor_id() we can avoid a sleep+wakeup
 	 * cycle by doing a preemption:
 	 */
-	cond_resched();
+	cond_resched_stall();
 	wait_for_completion(&done.completion);
 	return done.ret;
 }
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index a3522b70218d..be5080e1b7d6 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2646,16 +2646,6 @@ __acquires(&pool->lock)
 		dump_stack();
 	}
 
-	/*
-	 * The following prevents a kworker from hogging CPU on !PREEMPTION
-	 * kernels, where a requeueing work item waiting for something to
-	 * happen could deadlock with stop_machine as such work item could
-	 * indefinitely requeue itself while all other CPUs are trapped in
-	 * stop_machine. At the same time, report a quiescent RCU state so
-	 * the same condition doesn't freeze RCU.
-	 */
-	cond_resched();
-
 	raw_spin_lock_irq(&pool->lock);
 
 	/*
-- 
2.31.1


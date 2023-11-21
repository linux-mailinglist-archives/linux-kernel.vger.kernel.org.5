Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EB27F249D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 04:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjKUD1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 22:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjKUD1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 22:27:47 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78D8C1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 19:27:43 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL3DuWf009116;
        Tue, 21 Nov 2023 03:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=vFCUOtyvOU2gArbRbos5exhr3Q6ZxpEUD/q5YdEPV0Q=;
 b=FrHcLQTlKDIsg2dM7MkDlOzT72caoDBR8tcJggeQ/I/G0EMm710L5hU1Zr2VrAugLe/i
 4iNHqgXHcDLci/eWEvZGJBTyCEW1QSBcFqYkzc4uIcNgzD6zrOlHcYDkY4D/a9rMEPTg
 uwIRBz7hc+mkleqNFm7niDWkl/ypy3pC1GYiP9cnpmVqjeyCQwdbLkeldKH0dVuXbyaP
 m+gs16CtMPBGFgoLd8veOeVMHXnF9yX8JCYHuJ4FD7cat3tjD2lIsnyZMnnzmiziYocE
 u443S6u92RZbNp8ST3ucgK8IV+/TCD6op0s3iOl7FLIZN0Aj1v4N1iCFJEa7ikLgRslY YQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uemvuc2u5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 03:26:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL2giwk022624;
        Tue, 21 Nov 2023 03:26:10 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq61fpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 03:26:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJEgJC3tCmJTikVRui+SYnYBCOccQ1DjXKqNUxOxmQSq6cIeT0j+/xkcu15yG092boaKMW81dig2zMgAMeSSa086Fk5Y+52gEiHBcf3YupFCHl4A6l2EyNC/anUGvZwZ/ABEwp7XCBepR+aL897fBIQ7O7VcjI2PspXkEP7cJPhDXtj12zssepC40uMwKNV/CKbOgP0eqQ5o+glh+LzzmElv5Z+wJ8aBZ5LMWB6xHlLosyvEUQ/845lI0kF93BNNLD8Vq4ARg3SSys1dR1WhJdFVOkIJk3wAi7/s0tewlBLHF8Xm8A4LiVeeUjadD5FTQgGwl8iGukns2OblMpQudA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFCUOtyvOU2gArbRbos5exhr3Q6ZxpEUD/q5YdEPV0Q=;
 b=n3lELqqm6IZGZ4PDaQvSKJ3wJuVzwfLdWL7lzozkGcIKj3j3d6m2dSZ3jkaaQh51vZyFj2LmE3ZCyNa5DDeeDsG0RCwGGbTDqynkFBtmZys8ebWc9cVVPkwH7bdHqLAhM3jQXyiTIi8fC255+nZEBadUd0763vbY+nSzioyLXFLHuZ+d0vX6P9CxVO/2XU+6V/dj1jsm2cgYYcSvvd+EkvCBDS13ree2c6UDaWXAiB6K+spAkJdBq/Bo6PvbSZzAnzH8DMlVtYxKFO2xCGB/hSUjTlDgm0R0CPpEpYPexu7Nq+Y0Im/MMxby7Ak6gTilCSIFq/ARcatKGUmVzC05Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFCUOtyvOU2gArbRbos5exhr3Q6ZxpEUD/q5YdEPV0Q=;
 b=Om2FIR7R1BbbfEX2i2ciBxA4zpT4/Lz0JixWd9NBPOYFG3nNaFDc3c21Q7iwJZ1VqRfTI/16qjGzhF1ok62OyEsFwPQ/LBw38BrhLin2yDeM2zDZKcoLUEOTtT/1J3/xMzcL7EMoRceE3qcveqDks8h+ciBk/3mbojzPEzH9M4w=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by LV3PR10MB7867.namprd10.prod.outlook.com (2603:10b6:408:1b0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 03:26:07 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 03:26:07 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-49-ankur.a.arora@oracle.com>
 <2027da00-273d-41cf-b9e7-460776181083@paulmck-laptop>
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
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 48/86] rcu: handle quiescent states for PREEMPT_RCU=n
In-reply-to: <2027da00-273d-41cf-b9e7-460776181083@paulmck-laptop>
Date:   Mon, 20 Nov 2023 19:26:05 -0800
Message-ID: <87lear4wj6.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0116.namprd07.prod.outlook.com
 (2603:10b6:510:4::31) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|LV3PR10MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: 4766f63d-cd7a-48f3-d976-08dbea419964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qecT3t9IHoDqcA0jOXzuvL0gsv4goWb/Uq1J8I7Dv85tkCnqRV7aVHkbKGDzaKa/+CemzjGFoJ0CrQfYOPNZyG1zd1zECanbpmUo4GVxxfJLJeR3RWnq9XBrxcHkE8gMKZo/t5qYVFt5vWFafWdHDG6JOkuAXHfN6mKbHCkunVvrC9ycUEiCN4A34A8Vv3eOqeGEQL7thMU14LQ4T/YhAy8ogA/UyngQ/90Mvh0DbMO9LojX14OAc8qT2ulw6yzSdVGrFT3msVB2f/1ZCGVaFI8DAx8vmVgERkBZCywLvzK0/pEOQp3aQy61zKhtvlS8oXjKCynI5r0e68Bvo5LDXwKDwG67zLnTU5v2aQZdm/3ThGNBGgOHhYdEbY1CDAqITygj7NT9CUHgO7/aH9E4E8slKw4v1qFTN24zVLrKsUVS1mKhVCfgU2CEMuhMTOddmH5HsrgLuSJjd14ynMmBgcRqREFK8LQOylxtX0FkBhTMsUTsG6JkXL+4kcrTOUoE8RLwPX24J1PpZRnnO/C5oJLfoNQm7DvU4wvuAqNYp9xq0qC+D9He9XiHrJXlp7tn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(83380400001)(6486002)(6506007)(6512007)(478600001)(2616005)(26005)(38100700002)(6916009)(66946007)(316002)(66476007)(66556008)(86362001)(5660300002)(7416002)(2906002)(7406005)(41300700001)(8936002)(4326008)(8676002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jplosPZ8oqqe9bPeH7I1DX9IYqdTq/NAiHyIa3yj3yevc5obnaZCHgQy1joJ?=
 =?us-ascii?Q?VkUVaQ1OuZLXGk+2QYQuNp4nEk1IOJZhf6YyC0OSGIqqi+TqA/l1ma1Onr1E?=
 =?us-ascii?Q?c8mlB5RHVe9rLbiXP0WNKzSIFHZ0kCenU4YAiguzygPc5L+FqsnG8DfPBRS7?=
 =?us-ascii?Q?PYe9czlR/MIoEdZGFa66WZNA/bg+2kPle0RQ7m9I3k3JGbe4RoJF+hSj98hd?=
 =?us-ascii?Q?3GI5c7YDe0K11ijTvx2RK1F3Xz2aoxs98CZjmB9dDH8ujJ6eK9l76O6/s+Kx?=
 =?us-ascii?Q?hWtZSQwgp1h5GY8bgFa6PVVBY7dCqH/48T0Sbmf34PFF9wCsCIICYuBi04vQ?=
 =?us-ascii?Q?Y1T8oZzCoy4f7hDuW52Pok8PccgZs4oMX6T8n4k4CcnDvjuKbpjDnATLKiuE?=
 =?us-ascii?Q?PiNDPORWbyDLrPyAfHsycfU39/b4ql3xkCqxg3X13e9EDE+Sn5j0r8J5chSF?=
 =?us-ascii?Q?/b5Z/TMh2Yj8U3yo0U0NZRzs8vNb4gliG5MgMPpb2rOpJIDe1MVLpeRoNmOz?=
 =?us-ascii?Q?lrO19YhgyckfAfrgoasww8XQO7AdKwW6RfDvmJs9XwmP5mbwpu/8glSfqCuQ?=
 =?us-ascii?Q?z7aX2H78CJEtD574ajIwtc46y89s3Oas1Mc4KQ0YppZVYuk+/ptnnGhfnzOl?=
 =?us-ascii?Q?lZkEEGW+al1clqL6wPcAWR2dRv0wEEwAnlnHGJkcmH1JVBopL7UOUpzB7ssw?=
 =?us-ascii?Q?sUEft2afszMSLA5ZeixX9IUcDS9CfjuWW3rDMcOXDkb9MpemTEtyjVN6eYOX?=
 =?us-ascii?Q?M653P52YknUWdL4XTBZgbV3J/050NOwbKDLqJiEZYk6Wv1gfvIAep38IuLo9?=
 =?us-ascii?Q?psJBu0BcypqJLCiAqKFgClX5joXJARNGACVzoYMurEThX3IselGzBVUi67g8?=
 =?us-ascii?Q?sMxBqtg1kvuW6xLb1ZZE0BpPe4soRZeUYNqTYC+lBmsvsHSZ1UOggeiQetb0?=
 =?us-ascii?Q?Gr1LLJUF7e0eOvcDYp2BtvjKi7Nrf+GbWLHxoW17LDd/oAanCSgW04A7vk8t?=
 =?us-ascii?Q?EUVlsptlH3kVeQmRXdPqjnx+XZPT1CtpxyUwyH6Bs/x55V71Zs+DXO3FCNSU?=
 =?us-ascii?Q?DVTTcmmoHNtBbqWgHo4fuACL4jXNgAV0uw4T1zvheZBbPPyE8ZIvGbfGICJ+?=
 =?us-ascii?Q?vC5dGGsE0yI6pr/uSOPrVR1Q0ic8iHXkJAwEpSveLuS1/O0IvERdw+baJ8Db?=
 =?us-ascii?Q?IMt8v2nA9R32/aPCYyODnWrjQXQuwuxn6pela5Q/dClIi90uQGfhb3vPA1b0?=
 =?us-ascii?Q?ffhO09YF6NUYOaqqP+kv5GqTqfgQY1OPBfxDVqz2s7jVjyHOhEs+Csm7pbLf?=
 =?us-ascii?Q?Vt1oVoQM2qE3T0CwehNvSY3JLV9oldINnZ8QPDTT5C47w439jjoJg2bLciMU?=
 =?us-ascii?Q?3qIP9f0tEm5g+N8AOT4hCIvaZ8FPZxMs3c/3h9I6ReXtflTUzhp/uqNKN+oj?=
 =?us-ascii?Q?N8Tv0Xrkd3UupAauT/VRDWCbF2eGPFCioSRFQz9BG8yPfaRad6UbNz/0DPTq?=
 =?us-ascii?Q?ERyuX7EWQQDvURQT4ggjeFBcSOotVx9wufXqlskIxNdwchz3QKj5aBUcTWh6?=
 =?us-ascii?Q?kROK1JUfA31xMEtrVcjFszfSuJx6fXXtzP2pWBzoU++FBUobankDwYpCNcF8?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?lbkvUWg/yafQ8L9CoSX8x5ZVz9IAh9ImKaqa12F5SKJwlCqUNuRHqTLZQPyr?=
 =?us-ascii?Q?1CaWiLU64TWv2iiAUlde6xFz6UOCf5JQFEWk3J25RPFF6CmtnScjNIePlfuu?=
 =?us-ascii?Q?LcI1brT4vwrAWSqaUzSTBnzjnUS6yBz5k2o3wyzuLFvE2o8iFcCt/a64TlyB?=
 =?us-ascii?Q?M/OV1C1nxNCM1V7oehf1LC+IseIvRM1gqUndKvo3d2GMyKvWRPQLBhALvdX+?=
 =?us-ascii?Q?nszwEQgdrYa0/eFnJJ9RQr//2n+4T+s3jng6cbcYD3OIqF2OXrev06BtIs4k?=
 =?us-ascii?Q?wU/S2DlDZnXzf9ZtdpbGDSVctimIY4IaHavDpHzrMXPNL85V3S4+bPtycJHx?=
 =?us-ascii?Q?tuWox8V+/vCzzZKdWtMepKbgxdegTlLF26zN4d9p94ltPA5jmmU15dR6Qa4i?=
 =?us-ascii?Q?agBqmsUNpaQaj7Jz7CZvM4eEygl84nKNHhVeg6Mvwnv1K1Me0y5NtRSH/8kf?=
 =?us-ascii?Q?X4Wz6k19YeSYf7DbFqId8lE/WpSuQlv13TjR8m/FmEIi8wmxU9EKlTDq7ZSO?=
 =?us-ascii?Q?1KjUvk77WI/+qcTwCyj2IEUjedHu7IvmEXgwKQEYOwm62XLxcEi4HiRXASgc?=
 =?us-ascii?Q?zA9mfbSfU1JEnbht5Mc0oX0R4j5L5CtWp5svv+Jq/Q72y193hJ3FJZ5hRQ1S?=
 =?us-ascii?Q?gFigFwiLGKM3w6bv7taSvWiVGrCiDHcbKJxDE5HlZlThH0V6HxBaciCt2fUj?=
 =?us-ascii?Q?nHCfiqLEl2zgtQTM/41/ucHaSN1UvnDAvQcOCAXMXvqKcAQ2i8Zu5+ldVEte?=
 =?us-ascii?Q?VjJN5WuqHJean7h8i9JptKAtZRW4PuNd/a4173h0EOHAcWH35QirxtdC1vgJ?=
 =?us-ascii?Q?FjeseirPzXBHeO2UHNRwNfexcq9rUrLTn+sluc+xDsmhJ58UrSoyqtCpJJbd?=
 =?us-ascii?Q?pVwTxYdk9M7Q/ePklHKXPr4vBkSvWKOtB1bubkT2tZ1dcR5P2o+gv3m87FgP?=
 =?us-ascii?Q?r9gEjGL8GYms/jxbb/YfzeNhR/OVtkB19tbXbwwEBaVGlepzuKPGE85fFRS6?=
 =?us-ascii?Q?Dje2rg7J716J3rGDmRZfuxV1B0aKQqgZpbfuLP129oCPqVoDPpwPhZbd0ybr?=
 =?us-ascii?Q?zUs81zkjIWgbuce/cmPQq9S3LfboWv/9OZUFytsUCCLS8y0AtaVjsn6I1Ta7?=
 =?us-ascii?Q?ZR4KiPNtBxceFIMg/pFsmdT4acvbat39VWsbzdR2Gwk8jEWKeeun/SwxwJ3H?=
 =?us-ascii?Q?QAsYH1Pzs9BnE4vUnTvhv755oiOW+UabJlEbtGyvzjc5WfPJ+mfwH3dBNDQC?=
 =?us-ascii?Q?IBiwQW0DZj5ntlmzSpe9qQJx5bvFrsiyE+RWAFBTOOHR0pr6TQriO8Dhe78D?=
 =?us-ascii?Q?dTbrH9JdmuLmZDN4wGHHWYSQ01UE/LyW6VlxNj5PLnmWFdQLyhh56/dsmBpa?=
 =?us-ascii?Q?9DwXtmRiY+CDJa4Q1Sf4UVMBU2xr8nqD18J69ntx4uCDHNOVRQPVw/9zvDBZ?=
 =?us-ascii?Q?KbjpzJgo7vfM5YjpuxJBn5+0qVXLfhFexX/0+trNpYjVF300I63sNQpjraDi?=
 =?us-ascii?Q?1rDxaN0tQiyhu/2mPpjIXdKjL3un0EYJasXx0HE7VmLDI+N/1mWENKlWDA?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4766f63d-cd7a-48f3-d976-08dbea419964
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 03:26:07.2677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndyGZT/SgbSeCV66pT/UnKijHEGPglHb5DXIKKW2nnZ+3QV9Bv1QEKAZWTfgdk46ob1gtP9fwRj3r3IwnLP01vNstixUG9NwTkudtT8vGZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7867
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311210024
X-Proofpoint-GUID: CSgjbALOO1gC_HgqqMvHlV09_JgUNyBX
X-Proofpoint-ORIG-GUID: CSgjbALOO1gC_HgqqMvHlV09_JgUNyBX
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

> On Tue, Nov 07, 2023 at 01:57:34PM -0800, Ankur Arora wrote:
>> cond_resched() is used to provide urgent quiescent states for
>> read-side critical sections on PREEMPT_RCU=n configurations.
>> This was necessary because lacking preempt_count, there was no
>> way for the tick handler to know if we were executing in RCU
>> read-side critical section or not.
>>
>> An always-on CONFIG_PREEMPT_COUNT, however, allows the tick to
>> reliably report quiescent states.
>>
>> Accordingly, evaluate preempt_count() based quiescence in
>> rcu_flavor_sched_clock_irq().
>>
>> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  kernel/rcu/tree_plugin.h |  3 ++-
>>  kernel/sched/core.c      | 15 +--------------
>>  2 files changed, 3 insertions(+), 15 deletions(-)
>>
>> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>> index f87191e008ff..618f055f8028 100644
>> --- a/kernel/rcu/tree_plugin.h
>> +++ b/kernel/rcu/tree_plugin.h
>> @@ -963,7 +963,8 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
>>   */
>>  static void rcu_flavor_sched_clock_irq(int user)
>>  {
>> -	if (user || rcu_is_cpu_rrupt_from_idle()) {
>> +	if (user || rcu_is_cpu_rrupt_from_idle() ||
>> +	    !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {
>
> This looks good.
>
>>  		/*
>>  		 * Get here if this CPU took its interrupt from user
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index bf5df2b866df..15db5fb7acc7 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -8588,20 +8588,7 @@ int __sched _cond_resched(void)
>>  		preempt_schedule_common();
>>  		return 1;
>>  	}
>> -	/*
>> -	 * In preemptible kernels, ->rcu_read_lock_nesting tells the tick
>> -	 * whether the current CPU is in an RCU read-side critical section,
>> -	 * so the tick can report quiescent states even for CPUs looping
>> -	 * in kernel context.  In contrast, in non-preemptible kernels,
>> -	 * RCU readers leave no in-memory hints, which means that CPU-bound
>> -	 * processes executing in kernel context might never report an
>> -	 * RCU quiescent state.  Therefore, the following code causes
>> -	 * cond_resched() to report a quiescent state, but only when RCU
>> -	 * is in urgent need of one.
>> -	 *      /
>> -#ifndef CONFIG_PREEMPT_RCU
>> -	rcu_all_qs();
>> -#endif
>
> But...
>
> Suppose we have a long-running loop in the kernel that regularly
> enables preemption, but only momentarily.  Then the added
> rcu_flavor_sched_clock_irq() check would almost always fail, making
> for extremely long grace periods.

So, my thinking was that if RCU wants to end a grace period, it would
force a context switch by setting TIF_NEED_RESCHED (and as patch 38 mentions
RCU always uses the the eager version) causing __schedule() to call
rcu_note_context_switch().
That's similar to the preempt_schedule_common() case in the
_cond_resched() above.

But if I see your point, RCU might just want to register a quiescent
state and for this long-running loop rcu_flavor_sched_clock_irq() does
seem to fall down.

> Or did I miss a change that causes preempt_enable() to help RCU out?

Something like this?

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index dc5125b9c36b..e50f358f1548 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -222,6 +222,8 @@ do { \
        barrier(); \
        if (unlikely(preempt_count_dec_and_test())) \
                __preempt_schedule(); \
+       if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) \
+               rcu_all_qs(); \
 } while (0)

Though I do wonder about the likelihood of hitting the case you describe
and maybe instead of adding the check on every preempt_enable()
it might be better to instead force a context switch in the
rcu_flavor_sched_clock_irq() (as we do in the PREEMPT_RCU=y case.)

Thanks

--
ankur

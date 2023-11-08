Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9B77E4DE8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 01:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343906AbjKHAOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 19:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344004AbjKHAOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 19:14:20 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8995C10EF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 16:14:17 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJLLQ031834;
        Wed, 8 Nov 2023 00:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=hLKhomkju4SZkg9qzCNP0z/tJ0zlkjoMVY68KvxsU7o=;
 b=Iuu5J5spXBcHVn2nNAygjnbS/XA+uRMq8UiqThRKcxIMRgV3+0Wlu3qSo5itl966U2br
 MyBjUYdp4YpFTbTRZYyqtjKwx+v3a/vWMIqYtl5vSehaHMg+BCcoVIO284C9flAcuZKJ
 QUf1H3DV+EVff/qORJM3JQkRLU8ZHjo0S1Mhhv4l1LPIIqk56Oaegs2AE810LT/uM71x
 fgdmJ46LawASx+Pw8LWjnrzrE1IX7wR+hpkqOd6ZpK31xRSqSEdgOFrrcBqUfv1zlBC1
 8ZkSVklSE+uVE5xpG8XQonumhuFFrCNJl6+KOYixmT03xs0OwSBlBFIvKKpE5ofL4jVE lw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23g8f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 00:12:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N2c7B031924;
        Wed, 8 Nov 2023 00:12:57 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w2265rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 00:12:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIWpoDd5y6xFCyRK9hffRFifmH7Qz5dRWZO4Cu/FsZuC8oQ9wVmayJpR4E35GkNYeq4/p0AsJRskw6LAnjCTUVgTg+nKRaH90ZQo3yaOA3dno+NDsDqTw/9L2E8d1YpzsbISegtF4MIGD4FNWHMWuCxsUWTztsOq7ugvIaFZbD7tReHRWpvzpsXZc+XmPaIvATELqyi+Xx573C7S7hNXQLxmKP0PMV/dJbxy6sn49HmZK1OnNV1SIkdCM/DL/2kwcPu/9lc+6MzMBszUnpcbeMdTibGr69gQjnXu7mqJBEebUqypb48/G+NXQM6o44+ijajiYiKj+KJo48jW/nvNiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLKhomkju4SZkg9qzCNP0z/tJ0zlkjoMVY68KvxsU7o=;
 b=eXfDMqDmqqOM97Ergd8sRCVibDn3hLi+V3Eon/KVMhY7oa2O1uSmYA1DAFLB8LuqiGj5gdO/pJ9iPGku9MLQKmjzUZ86yFriW9z5Ku1oiLg1kvVKsMXR98OOt46yJze1ifknVa4d/JGghOEcwFLvknL+iSI3/oIWbne+y1RIs3gZF2PPbfn94lTR6wocWVHqtrAxFw52zex017OM21N2rCF3o8LUYfkNq8XZ72QlQhF3UI8W+2iKwud3+ztYJQQ+chMK+sya4XHS4OWkmW/5WbS+NPRnIzKfl/X1jRl0Hi0hindPvfigFnhrpa4lrZJCDwMgS89FPqPiQDpLaFmwyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLKhomkju4SZkg9qzCNP0z/tJ0zlkjoMVY68KvxsU7o=;
 b=qmBeydjLZK3d0Dpi+4taRoFEnLX8U80WWelFNL1SyrFqFGoD0npwO+4ddoBEihvvqrpkkrH37eya+lqktO2DilLndCODQ/fZu3jNemtxBiYxZOXONgBwS7SYWftFvI3iBdFCL7saNPY2DwVHwD/+UYcXNu+CglPteLs0O1A6Sgk=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 MW5PR10MB5805.namprd10.prod.outlook.com (2603:10b6:303:192::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 00:12:54 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 00:12:54 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-4-ankur.a.arora@oracle.com>
 <20231107181057.334c815f@gandalf.local.home> <877cmtywpy.fsf@oracle.com>
 <20231107183154.7f6db059@gandalf.local.home>
 <20231107183425.2f8b98a1@gandalf.local.home>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
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
Subject: Re: [RFC PATCH 03/86] Revert "ftrace: Use preemption model
 accessors for trace header printout"
In-reply-to: <20231107183425.2f8b98a1@gandalf.local.home>
Date:   Tue, 07 Nov 2023 16:12:52 -0800
Message-ID: <87msvpw1a3.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0244.namprd03.prod.outlook.com
 (2603:10b6:303:b4::9) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|MW5PR10MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: 42006c7a-5932-4dac-f93d-08dbdfef7431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XJuhUZamYTspotgUWJZmOLpRUgqqJtIdtvmBEdrCPkmUg/gAIuiSzVst6gNch37YQQ5z6Xj6c5/8QYFmLjbtlZIZpSzo8V3biXHFHiZy3EOTI6p/IMX2bSGGzO/48+ZlucauJlHCGCyCqWh57x8xG7efyR9tEUmy50IaKA6wR0+xW2CTTQ7adv5ItERKOpCrmf775yrH/7DtDQLbqTeDlj7pW1LQVFVXHz8ua5opWAf5snukA45O/EuPTeuxEvesqNAhFy1D97s1i2VgXCpP1/N+irlZnRAVQudv7vvxpQcXH2W6YFXOVLFyW1655aLNfER3crM7zwn3PEU9Wl39xfyKK5jDzDWLGc/RAcKDIX2GwDOckRR1vzcH/rsTUxWZ88pxNpHylVywrjsnA1uo2mx1fYRyOmHwGFftGKHcmUQoQUa/3rsRJMstfD02nQqM9F0MN9vydhEmmRNGp5BZMfu1bF9bJpn+iShiGsrEYpjr+nSjUCUfFqblZj1fQM1bpf4J+eCxY1Jqi5WqS30x8VO3s3sdJ9P8eYKo3sQSpzg3U4MtgumCHEAr8ozcQjB9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6512007)(6486002)(86362001)(478600001)(26005)(6916009)(66946007)(2616005)(316002)(6506007)(41300700001)(66476007)(66556008)(4326008)(8936002)(8676002)(38100700002)(7416002)(7406005)(36756003)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QQFdbTfsSSErw9Pk+5CRmKvkVC8pXV+704TW+F6/gP2sphLjFQO/7EyNhhBS?=
 =?us-ascii?Q?bqxdicsdOTKOUshDXuNCnwkFCzWRZUBCPt3zyVL76QbtR3OaqiwHy3/t0d+f?=
 =?us-ascii?Q?AVh6yHPP1jn5r5QzBDCHgjdKTrVyEq2voCia0IMbXNDNsztJNLSskm/hBtPq?=
 =?us-ascii?Q?/MhR3EGQU62Sv3BtbGz8KiAGSF9iUNBxrGn7zg32L+u9oRxWKJwEWKf8V2uc?=
 =?us-ascii?Q?PUfleuUmJPAvvpP9zpKczFsSdgNVjg9u9DdiSs1pAkvb6OFo1OI1ORNdM7lG?=
 =?us-ascii?Q?c5slzCE9QhxdFI/54BJyH9679D/xeDvnJYaTq5GC7PljBkiYZ70/JB+bLKt9?=
 =?us-ascii?Q?pLcPQw8+diCvu/wLjYTl0TcxA8nc/BnTmmT+rTQG746Cwd8e8wu81QKmoKls?=
 =?us-ascii?Q?DODWp30QnTgrQw3M5H2s0DtUF2bPnTl41o+lG+Tl5MrLUD5dLYkC6BiBrBgE?=
 =?us-ascii?Q?s6gY/eVtnkLrAJnOg3jRSAlTOiiVDwFL9/6GjaJdzy2ELVSu8dHk9l12udU0?=
 =?us-ascii?Q?hZmT96nIrjFVnq4V34XXTUzUehzRGaM8a3QeSQL3E3f0TTbaIZH+b/+63bHa?=
 =?us-ascii?Q?QXd1dcHzQ07Mou0/c5btX9THC2B7nE9McUzlBTm4EY/h1awhiLm7sQpOqF0l?=
 =?us-ascii?Q?lg2mB3YgIt2piw5HGx/tnf2VVdEq9NuRkKYsgTO6kU69Vi5oCiT1Ibam9/qx?=
 =?us-ascii?Q?mHZ8Cs0N6AHGyV6TE4ioQjj9kM28zJJA9dixEwKtZoG3nmRh/Ra6N6PAyZLw?=
 =?us-ascii?Q?1gCJrp6/CD1gnBnIHoGit7XFybVIRQWqDVmW4IFp27GDVo1+kDSkKOKpib4h?=
 =?us-ascii?Q?S+cXjofDd7d9eT4bWLUP/1VFLwAv7NNS89WNkp4VxootResru6xyf7lPhjKP?=
 =?us-ascii?Q?dhs09TplHJAUJoklBeWYEurcuaZQkUF4lNondjARdRRxbfS+eaKPGcGp/aW8?=
 =?us-ascii?Q?zr4/aaZrYSCNJqBOHmPRdH6PiVUM7AkNxrSI0htGwJI70+xUXA0eESF3rwjb?=
 =?us-ascii?Q?wiEqn2cOHv+Cmg1iUoKBwJYb8nSgUiYczBMEprKcUF4yLOlXkRF5B6zCeLGR?=
 =?us-ascii?Q?hwgNtS3KYan6Jo6i5+2LCdJkRtE26qWV+ELUCHlf900a6MNqCn1fHB0DygiY?=
 =?us-ascii?Q?UH5/4U9BI+aHcAMVAI2k3Ky9KgzK3aN7PwV9kjDTqEKnYcR3QCOZS+jngVuu?=
 =?us-ascii?Q?WeA4j6h02anf/pt4/WkrmiK8EZLfXme8eUEka2NTxT9nqn/JDwldDLEUDzcA?=
 =?us-ascii?Q?XZvdTLRN2PQS+DLvLvHjoo3WCs/Etd6JtgRpZxhLIyNJvCXRuhxl4tlxBYcJ?=
 =?us-ascii?Q?0UvI9IjQGmCnRy+XFW0twNwZuiG9OMEHrXXZRbGoxYfutyO1sPCgALFEoM9q?=
 =?us-ascii?Q?X6JNbWqwGI7Ol81ywhojSsJ3w4AZ6WjXjDJZUj7CBUYDnA1JAAfb9HSTZBja?=
 =?us-ascii?Q?1UeUxlFMmSEZREoFQjb4A/65FRB1R8grQyeFifpOWX/HRuSE2tbDydwU9ogd?=
 =?us-ascii?Q?93vSBHxeXAy5GjnyWf2h5JAUD3yR/3UjOr7bh6HfLuNjFu/HW8fH7dABglHp?=
 =?us-ascii?Q?qBWygs5UdSTHhgJPftfrikQWtDh+Tqi3my3JB1m2fD6ABD1VS8fj2LHiF6j1?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?hj2iVw0I8c8dS269mJr7Vji8+509ORt68rZeLq4vlQ0Vg0UHTDDBKHvaAVRf?=
 =?us-ascii?Q?1+Abz5s3fl4DQa6ZKOAZv2VP3Q+d4q8vhcX/DCP2PLJ8oHZ7c27tr+LNbRBD?=
 =?us-ascii?Q?bVo6Db8uzLQ9iCRtSyWlUqWokVfC6m0KzztTs9t8nDtE96sfBwBU3S+6rpuO?=
 =?us-ascii?Q?vmOTqJZG7FiqEHAnPOgkqt0JBOZpXd6qkuWGUqvBCIEwLX+8cUuORL+L/hQ7?=
 =?us-ascii?Q?YV9ZZUc8La9qYhDpGdu/j/ufBV7SyeQDp0L/xUYT0ro3289doccMUz98wZVy?=
 =?us-ascii?Q?RJo6/yWQzsUc1jqqtkMPLM7Zw8g+W05R63XvhBNhzF5C6pP790Im5t1lCrUq?=
 =?us-ascii?Q?W8uUzmd4INYNs1/3bsj7A/nmmBj9GxiM2l0YmZlsaLyeMQHqOjsDQJNNik/8?=
 =?us-ascii?Q?c+7H0C3Fkma3B60FrRyEX7/zghZRGDfubkJ9mNU0+SVPzDtaK5HU+Zz1mKs4?=
 =?us-ascii?Q?hwRD5tANIogAQtyaXn+ahPWD+G3ypB8Xm4dOSA424y66DRid/vUi28zGP1yB?=
 =?us-ascii?Q?rp7IwqOlf5qsTnjLt2eTRbUALXBzxWaNGe4achhL15tCR1Eb/b2rzCpii1EG?=
 =?us-ascii?Q?Uwqr2QFKXXcTI/ATsHLu07NT8t2E2Ryf2G/mZAStK7HcqpaOer6iqafeK2RQ?=
 =?us-ascii?Q?FswEBFjjT7TV34tMj8aXsTGb1zOTRZ7L+5OX/WWAlEHW0MBvCytodeBXwezo?=
 =?us-ascii?Q?lsjq/NcCLi7ZZGiH9JLencOZZTPv+eqZO5u8FqlkmLms2uxA8iueruld4uXL?=
 =?us-ascii?Q?9wDvIdsciiBZNwkLj97+gC3p34af7eofE9U0a3fS59EQfR1WIITkHLyodkH2?=
 =?us-ascii?Q?3iiQF5Wapsa3fVY8fTySSnu7wZ1yK4QmpdUDoUXpyA2O6X9hUFz+EzXEcZHx?=
 =?us-ascii?Q?gacMQkRItR4ZWEjUEYpIIIB1lqtLM/6+sce67ZCnHBh6UeHTfzK+fqWwkCyv?=
 =?us-ascii?Q?cKUfDz1Th33AFumsyFKGWSacLTI8VEdpFqFJBYstk8rNKkO2ekG6Dr8xDXfz?=
 =?us-ascii?Q?KHknFH/yxUGhXWTgoqQu3ObNRI8YSFpHr3f2UOcTHxvkMeyf98sE/mPbE5FY?=
 =?us-ascii?Q?DOvCxHhn5dxfs7IA+vV9qFR4z1NsqyxymvT/S8YwANKd7a5sOLd52pbIMUu7?=
 =?us-ascii?Q?ARiGq3Oiy2dvdjaF2iwJlNb67sDiuCZgchs4Nto9OZHXp1PYJ0sRtakqO08l?=
 =?us-ascii?Q?qa49X6SAIwvFjiwYjXz2JS6peM0KKAhhZOXpOnYdEtUbTKx0rrm2+jkGCjxQ?=
 =?us-ascii?Q?kifRVRku+6UGy0RHb844Yyjr0fmxjIUG9h+4l1ZiQZfg3ryeh9G9grYF/vNq?=
 =?us-ascii?Q?D3Hz0crml7gJa7vfB3UZqpF91XXHLLI7RZDP+0teFkI1ExOnAI0wutmHFc4b?=
 =?us-ascii?Q?3N/WTK+SMANa4xpczdxSIUrj3jEAEG1bkNpzB1wa9con0yySb0LhjKpYW+eH?=
 =?us-ascii?Q?B99MHhtKIHqC3oCEqyyBa6wd77VofXqeR5l4fRZJkIWRpGcywJ+ASq6Wi2JB?=
 =?us-ascii?Q?H7szawCC4V2oNvHkFUn99dyAlnsqjJ3ejIQLA5xcoGkvzzI1P8EZiAgfTA?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42006c7a-5932-4dac-f93d-08dbdfef7431
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 00:12:54.4223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eShw+HygyQMzldvmuIq+Cv3R0iBnfMsi6viqU67GWWR7buAjgDPH7zciO7FW+NrxYWDLYL6R4UPefkAxqcu8DRShJybptqCuJUqSsejyj9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_14,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 mlxlogscore=910 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070199
X-Proofpoint-ORIG-GUID: A3cPS6alrUCVDPtUk9rvqwhYFW3-vrTh
X-Proofpoint-GUID: A3cPS6alrUCVDPtUk9rvqwhYFW3-vrTh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Steven Rostedt <rostedt@goodmis.org> writes:

> On Tue, 7 Nov 2023 18:31:54 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> On Tue, 07 Nov 2023 15:23:05 -0800
>> Ankur Arora <ankur.a.arora@oracle.com> wrote:
>>
>> > Or would you prefer these not be reverted (and reapplied) at all -- just fixed
>> > as you describe here?
>>
>> Yes, exactly that.
>>
>
> Note, a revert usually means, "get rid of something because it's broken", it
> shouldn't be used for "I'm implementing this differently, and need to
> remove the old code first"
>
> For the latter case, just remove what you don't need for the reason why
> it's being removed. Reverting commits is confusing, because when you see a
> revert in a git log, you think that commit was broken and needed to be taken
> out.

Ack that. And, agree, it did feel pretty odd to revert so many good commits.
I guess in that sense it makes sense to minimize the number of reverts.

There are some that I suspect I will have to revert. Will detail specifically
why they are being reverted.

Thanks
--
ankur

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326AF7E4C79
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344181AbjKGXJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjKGXJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:09:41 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481E210C8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:09:39 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJfg0029174;
        Tue, 7 Nov 2023 23:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Nen72dyIbcMLqxVEMjNCU3b1BhvmPRDB0dQ1Q/BjO8s=;
 b=KlXcBKuUHuz5yeH1dAKlLNPuUdLpP26AGB1tz8tu6lMRcU4CMkiaoIL2xLqMEvYEqa12
 7b/zwN/PIvNGLUjSdrdvgJVirtKdE/4cpFd+DPwdgkdjKEhhK6CNRub1vXjzlZvKQIZQ
 h/MOBM45/7/JvVExa76qifwH4PR17dDu1b5K6aZ8KZVddk12Sho3vLDpApn72T+la7b0
 JlREhBY2TAfIcfsyPoB0q9kYL5EIp4vrajdKgao8ZmNNV+JrisjwWqNLfP9gNLwgtHJU
 ORZAhbf9kx4kCN80Mo7RyJHZS7MsZXPhQYtYfI+qRdS0YqZnqb+WajBki1NGT9Gy3ptM Cg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23062n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:08:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N2cbq031924;
        Tue, 7 Nov 2023 23:08:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w2247gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:08:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFkwqhc/hZdDXlhT06uCZrO90fJ9KGN2r84xoEtaLwhrVX9geq1fJx2wXI8T3JFTvUcABXMgpObTpnB2PXgy+dVDW096aJ+WOVYpaCoWABVWMPgF/5BVCrEEMpx8NrTB1vs+6GnplbsGIs+p3sul9qJtjkXNbKJC6Yx83xm3LylFSWK4eVix5A/QLEBn/Mu2CWfjfzlmpOiUT324tGXrknbaCePGbcj7I1L1rwEApxDsm1vidL4a6Gdk9PjXE/5XgTTwsmjXiIVJs6cK3G/eSEsn9Ih0drapj7zDFFLL4ipH4bqEX5PehMDW90TY6SbsWmggsLbWYUpXWFBY2Q8Z6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nen72dyIbcMLqxVEMjNCU3b1BhvmPRDB0dQ1Q/BjO8s=;
 b=EZlBOlvacbnkkVJQRFJYnKSnH0/m+dTefw0S8zL86u2IxZLXxxn9JXFYnF/y2Se1Y5ryQBgLh5VrnU6MWJr6lUe8hxKSH0XlHUv4IdpHomXWUEOGLagSBd515xQDAu89m8TJVkRwBRv581732XKagghESdg+HtDTy+UNXKxdwaioyIOok0GcIO0FzmGtowdPQOafFiw6XwUjRPtNTn2Cj7TwQVzr3WgTZERWcjRm+aVkvF0iLELYHiz3vVnpfr5EgXL/6ojwfaIRAMDQLJ5JcGvBubtAJskns5BZgFgM3BsqoBKw1vR0xalH44RnWakYBqx+aZIjLt+cCn1irAGS0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nen72dyIbcMLqxVEMjNCU3b1BhvmPRDB0dQ1Q/BjO8s=;
 b=r72KnT8jrR4vTwezPQI0P9QL2BTgnSOPqBHU7ZmdX9M3w34jICUgqcYE8zWYkBA9pDHTezXBdN6QRUOiHzxEkdDetXvGniNLtsOX5LXt7lkegu/k1l2+OG0mw1KyvoQVkqEni4sdx66aVe5eZSUyNw9/2uD2HpPhK7K+8CfP2NM=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 PH7PR10MB7010.namprd10.prod.outlook.com (2603:10b6:510:274::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.25; Tue, 7 Nov 2023 23:08:29 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:08:29 +0000
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
        Frederic Weisbecker <frederic@kernel.org>
Subject: [RFC PATCH 59/86] treewide: rcu: remove cond_resched()
Date:   Tue,  7 Nov 2023 15:07:55 -0800
Message-Id: <20231107230822.371443-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0335.namprd04.prod.outlook.com
 (2603:10b6:303:8a::10) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|PH7PR10MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: 965bf1d3-1b95-4a2e-9bce-08dbdfe674b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ye7ewhUVNKyDovM9qQCCJmXFWb+401qftjiHw6abzG4KTKoaHfJSh4ElNKtKGbIrT9DsgTncs+5HdMn1N9k+M71uxqDYAg1h5PP1nDZMA5uoh+EfV9P6cTqjUvHY51rcaRA+wWVgh/fUZ4lOnSxeAqdquV47AMB2ef+zA9dGe6afyw2+VU32vQ2RAmMNPtOew06Nmb0PIMBlXhqZl6twbXuUcys8G/kPJmQrpmcBXmUMrzomvvkEzzVkgXnCz1ERqUqnKUX+1f1Ois3bGSKZM2MlPPVGQ7L3ScqUgYrnvpylRFUjRR2AsJbzODsXolc5E1wLHZMt3WjMql0kefR9qIkCvXNRQL+DDJhpv34lrNDXpgVKQJf186m8+IholYbR3BANjAMutAPKMdkoYuju36oYDf33LnWoVL0Wg312p3nhnWW/0BVW0Kz153EAkIMwXp+ZLOLGxXCsU4omyWmMtV9ccxmxOiezBNspfF8gjh1NlG3q4xWHQLS7JXxT9w+y7JMm1WXQHOHir9XIw59gn5hXHdTk/wlytcGq/S1Wndk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(7416002)(966005)(7406005)(6486002)(478600001)(6666004)(54906003)(8676002)(316002)(66556008)(6916009)(66946007)(5660300002)(66476007)(4326008)(8936002)(6506007)(2616005)(41300700001)(1076003)(26005)(83380400001)(6512007)(38100700002)(103116003)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7COX9TE14FpqLTj/ajK90AQFozphmqli+sOCP+r1NZOQCKSk8cna9VDZOLez?=
 =?us-ascii?Q?lhnZj1fDPtWZLvfXxDXNE9AhYB5sKQFmE3rvNh7Ru50EFse07C7VIGNclUGe?=
 =?us-ascii?Q?qaJOMES08Cp1mx85IwtjTSI92RA4SlFwy/zDaMArmKzPB0DVH6kuCBoj+oYw?=
 =?us-ascii?Q?BC33BQdDREZDJcuavtYCzk5hlyRQ/we/OvoPa/emKVe0kSwQ5N43MhY1kNYS?=
 =?us-ascii?Q?B1WrA4IT7sgRVo0UQmpWq7QF/USZYGlVDMg1eWtSf9tDYegBqq8uZOAkTLmv?=
 =?us-ascii?Q?hfHkp19+t8AMubhELQMhGnJHcekMXFqYYVVzWganS8DBlwQNXPsAeUhcDj/O?=
 =?us-ascii?Q?eWFAf/a5Z8P49XwjKyWwY+S6MOE8AgrIMG9R0VUyqY4X7yjOY2TESrNUm7e1?=
 =?us-ascii?Q?ZKxUhwjKhPu/ShQof7MX3Eegl3wyFFhBd1TKOvhjhobsbbTqPpUBqxMB/z7j?=
 =?us-ascii?Q?RFDsbYEucPJhouU/Z8zIYq+ic8ICfjCqO+v80oBsTxREG5n7OuY6vm/kvVFZ?=
 =?us-ascii?Q?DYVlxKiX3S98wOLt/1BM81FzTLfzA8mtXy5sQgyOs2Mw6bbaHv2460edDtIc?=
 =?us-ascii?Q?zvJykzaGdJ0SPfHlYxQOXq83RpeXO4icHUrZ9m0srCekvTGVoTl3/hF8dTcY?=
 =?us-ascii?Q?3eIwcj+RZGkG/nGeGg7Z1nk4PlarRMTCOf7zruSoMo2CsVUY6mbv5zU45d3Y?=
 =?us-ascii?Q?bkNK9YSuy7om+Qk0D5C91I4xG+BYuZMZExuB9iktwGt2WCh8o6nefrkxpfL3?=
 =?us-ascii?Q?AAq4PfZNXOGkiS0e3JYxHQNIWgWqqHpFhnU4BnO/ZHoWRteu5m4nrjbO22Wu?=
 =?us-ascii?Q?njvk8h+dUiPdYDz2noS0mHNk7PNx+Y4mnmHXh+LuJIQvfjaM2Gpteywc7xhn?=
 =?us-ascii?Q?3JYDbRZKt9FloPY3eNtPZ/6SiDZhscYD06/FWxAs/OJ2yyo9c/G4k3RYBEqs?=
 =?us-ascii?Q?bTqWcW72/+1NEuUd3yJ/5O40dFRMQtHVcC0s05/fU1CFWRQMJlqe+CTJUiML?=
 =?us-ascii?Q?FTeOPo/RPc1AVuxlLrzOBM1mkr2G5M6D595qeiXu4AL2obgVCI4zQR7+Uz9r?=
 =?us-ascii?Q?CDWkoq4CQ6vFj/j/XENa8598tZhcq0MYmLkEhj+X7N20ws/fF0PolweozL7t?=
 =?us-ascii?Q?TWvXtgzUZ+/gnzICDiEjiht5E4wjgoS8TBZLAJsdsJ5+XBUW8kCUJqbLfqYl?=
 =?us-ascii?Q?mklxjIaykiF6jeQCoXcvkEZUduAdDdTO6GM2fZXlqUR9lycCByt5kNfnT55t?=
 =?us-ascii?Q?DaNaMhrfe4CLuuCyExOPzkEPb6/L5qFztGGfmImP5akLEwBv+SmgQ1SisNhl?=
 =?us-ascii?Q?SiBRSmTuJjyN/steRXyjURFe+lkM7ffePI6C9XWfhdKfQZbE1npsTEJoZNVu?=
 =?us-ascii?Q?eETD6eTAssv/rhqsLr+1ah80d+7C9nENUsHmgUWSYalszyn7s+g7wkKuqHgK?=
 =?us-ascii?Q?EMoUvokGi1Xiz/l2fa7/cPV/3F1CDVtxrVtQANiAVNCDcXoF+WoZ8K0i+AS6?=
 =?us-ascii?Q?lfG7gGIckN8XT7C+lZXkPrRZmJfWijkew7p8L9h8d4kpZR5DtLOHP4GX5Azc?=
 =?us-ascii?Q?TvuvtdL03i0boNNBRuiScTozppD9BxaEvGSCnmj921+tyaVop6D+lMfyp+Z+?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?MFZiCeTySkVipkd2zh4NabgPxytey+YeV+yn78xWHWn/uTwDzBLc7wkXZ4YU?=
 =?us-ascii?Q?Lncar7i2a/UrqvHKrtOGz0WkvosdKY7jT5wJbM2by5E1p0SXPrznI514wh0n?=
 =?us-ascii?Q?vsqOAJ3ZZ+cM8d0P1jxm1Hzj6SrHvcVd+6htxg3XlXbPMQyHgvrdRnyJKNqZ?=
 =?us-ascii?Q?6xqBkjJurFfRGBnRVWjsvCDj/NYqyLDm7J2t2d42PI9KSZmoiPhV1yPoeofF?=
 =?us-ascii?Q?c5clsBXbPM2HbryeO0oAisgBPXSgnKNiQTkJFa1eum2DaUB13rdFN0VujA7g?=
 =?us-ascii?Q?olO/gUlcT6ul5WauMf8Iisp/liQPR9Kn4dYWupDnlzK9VW3AL4ChjUcZHUWZ?=
 =?us-ascii?Q?keozMR/nccaHb/DIa0anEvKG5BHPg+FrraAW5EvaMr6blWlbSE9wEAGXl7PB?=
 =?us-ascii?Q?Cun4sDWJ9GC8qAV5yeFG1YMU/bRNBieOZXj7Fhu3q6Ld3HtS+/mJiY+Q+BT1?=
 =?us-ascii?Q?g73Rp5TzS+KXTuo7Q5CORVdosRUONJ8y7HL5sCO+Le0Nu37pKPlb6grOLCd5?=
 =?us-ascii?Q?vEKuKh/YN7LDG5M2XFh8Xo2xl9Yz3a9P/IbNk/UYyDv7uXtsFnNlgbzcCRzZ?=
 =?us-ascii?Q?ZApVV24Z4c97GbHHgSKz8f3PB2PpTJ7suGMS1un3jE3PWmvSfPfG+t5q5CS2?=
 =?us-ascii?Q?2iXv2UkqD9VWDPc3Ngvu51TAQkhk74la/mr2olCPrjmiYM2Avb32AHRmEFiQ?=
 =?us-ascii?Q?FSLQB1EY2pCeckCzJSI5f31XkijDyHheIRfhpTvxsjmGdsZMoqrztvQA0M39?=
 =?us-ascii?Q?CYkOXI9ufobyT81aJ2qhdHQWZJPW52tYl/7t26XmEOcIpY0ZW1phV1ykfvqI?=
 =?us-ascii?Q?38n7odeV6ODdlCni+2qS598DJeLpcbwsPJvm+zDbozSuZA+3xQH3t+4uObFh?=
 =?us-ascii?Q?GDWUbDoRsrQhHcN8kO85NbDwxsVZzVkm+2MLagepfObij7NO1VDc5qqJM2KS?=
 =?us-ascii?Q?BmpTCB3jnw8O92Hp0tMFExn7eVi4C2crulBZn9qbWPLKGEt6UApCaSj3VUXO?=
 =?us-ascii?Q?Nr0FrqO1qzXZnblXLSvUkth2mjd28VAMcvN47QB9FfA4xcdXsZb284yKc6KK?=
 =?us-ascii?Q?E5Vck+ijdkfB74hovwOYG/3Q0OmBm/VH5N31DqaAG/VLKFd75oNvfpo1b52h?=
 =?us-ascii?Q?iXV4aBEJjZZ2wd0dRjLQ8QkgZiGmENQ/FH/cUy6kJ3QVzJa364OOa7pWSwGJ?=
 =?us-ascii?Q?dFBbuNePGltgolPHEBkmz8XXwbVINdoXzkr4SJ8RnOwAkAf5Il2i7rZJQnTq?=
 =?us-ascii?Q?3d0JOZ11/+slYjEzJl7mKo5COB7bkQ3f/GrmE3ONbVTlE8SaNPuhf7LdqNsk?=
 =?us-ascii?Q?kGul6cRY5fSU7zwVrkt5WQtJnvDCKfGrptFtS1iss/AGg9aJnewA0YyLqve+?=
 =?us-ascii?Q?qfytgM/fvcCbRSvalDvf6Y2jEMLuLVJ+kPEm9O8htTTQdOR0xfboxH4xsmGc?=
 =?us-ascii?Q?CSXOcjp5w02cNBHQR0QVP89S9sBgvI/73/zTACdOXRnjuTrJjirPzQI7Za1D?=
 =?us-ascii?Q?gim372fPNNpHOcpk4kn/4XFKpbr2EOc+AotbYqN1cj5yx9Lc1cabQkEkEA?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 965bf1d3-1b95-4a2e-9bce-08dbdfe674b6
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:08:29.8136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /u1d7je9Q5u7zyoFJw+qaOkiqoiKBQJYbPo6fY/PqD7fRMz+VG3rpg7XZi3U0eEHsEtdei9XjUNn5QR8I1A3IUdvcBBYp3m+cxI05NIVWkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7010
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 mlxlogscore=667 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070189
X-Proofpoint-GUID: mI3WrKvtBIps17UzG7Ct3GaywVT13Lwe
X-Proofpoint-ORIG-GUID: mI3WrKvtBIps17UzG7Ct3GaywVT13Lwe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the cond_resched() calls in the RCU interfaces here are to
drive preemption once it has reported a potentially quiescent
state, or to exit the grace period. With PREEMPTION=y that should
happen implicitly.

So we can remove these.

[1] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/

Cc: "Paul E. McKenney" <paulmck@kernel.org> 
Cc: Frederic Weisbecker <frederic@kernel.org> 
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Peter Zijlstra <peterz@infradead.org> 
Cc: Juri Lelli <juri.lelli@redhat.com> 
Cc: Vincent Guittot <vincent.guittot@linaro.org> 
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/rcupdate.h | 6 ++----
 include/linux/sched.h    | 7 ++++++-
 kernel/hung_task.c       | 6 +++---
 kernel/rcu/tasks.h       | 5 +----
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 7246ee602b0b..58f8c7faaa52 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -238,14 +238,12 @@ static inline bool rcu_trace_implies_rcu_gp(void) { return true; }
 /**
  * cond_resched_tasks_rcu_qs - Report potential quiescent states to RCU
  *
- * This macro resembles cond_resched(), except that it is defined to
- * report potential quiescent states to RCU-tasks even if the cond_resched()
- * machinery were to be shut off, as some advocate for PREEMPTION kernels.
+ * This macro resembles cond_resched(), in that it reports potential
+ * quiescent states to RCU-tasks.
  */
 #define cond_resched_tasks_rcu_qs() \
 do { \
 	rcu_tasks_qs(current, false); \
-	cond_resched(); \
 } while (0)
 
 /*
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 199f8f7211f2..bae6eed534dd 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2145,7 +2145,12 @@ static inline void cond_resched_rcu(void)
 {
 #if defined(CONFIG_DEBUG_ATOMIC_SLEEP) || !defined(CONFIG_PREEMPT_RCU)
 	rcu_read_unlock();
-	cond_resched();
+
+	/*
+	 * Might reschedule here as we exit the RCU read-side
+	 * critical section.
+	 */
+
 	rcu_read_lock();
 #endif
 }
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 9a24574988d2..4bdfad08a2e8 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -153,8 +153,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
  * To avoid extending the RCU grace period for an unbounded amount of time,
  * periodically exit the critical section and enter a new one.
  *
- * For preemptible RCU it is sufficient to call rcu_read_unlock in order
- * to exit the grace period. For classic RCU, a reschedule is required.
+ * Under a preemptive kernel, or with preemptible RCU, it is sufficient to
+ * call rcu_read_unlock in order to exit the grace period.
  */
 static bool rcu_lock_break(struct task_struct *g, struct task_struct *t)
 {
@@ -163,7 +163,7 @@ static bool rcu_lock_break(struct task_struct *g, struct task_struct *t)
 	get_task_struct(g);
 	get_task_struct(t);
 	rcu_read_unlock();
-	cond_resched();
+
 	rcu_read_lock();
 	can_cont = pid_alive(g) && pid_alive(t);
 	put_task_struct(t);
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 8d65f7d576a3..fa1d9aa31b36 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -541,7 +541,6 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
 		local_bh_disable();
 		rhp->func(rhp);
 		local_bh_enable();
-		cond_resched();
 	}
 	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
 	rcu_segcblist_add_len(&rtpcp->cblist, -len);
@@ -974,10 +973,8 @@ static void check_all_holdout_tasks(struct list_head *hop,
 {
 	struct task_struct *t, *t1;
 
-	list_for_each_entry_safe(t, t1, hop, rcu_tasks_holdout_list) {
+	list_for_each_entry_safe(t, t1, hop, rcu_tasks_holdout_list)
 		check_holdout_task(t, needreport, firstreport);
-		cond_resched();
-	}
 }
 
 /* Finish off the Tasks-RCU grace period. */
-- 
2.31.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645667E4B5A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbjKGWCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbjKGWBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:01:38 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B2E211C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:59:54 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJm88022703;
        Tue, 7 Nov 2023 21:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=+U/iKR0DamvIXW1I7wH7xY9ovn4mPY9pe4p47kKGclA=;
 b=CAvjvU0oLnZ64Ttkfx5izK5UK8U7xasIlOpl4LVbigtcXxAWW5OqN4UNnXCRrU31max9
 DyqIwL4wzU32SgqPImZ+mjTTbHP58MNRtvhyED97kHHJHwhhjRoce8tEbl1qxu5fQxeZ
 EeMgs95Xrs/3nfTU/sFdEO+VN7hjvAIgVEC+IDomhPtrcoLnK66UjGiWjlWcwAihN1Et
 xg9y/LJmdNq476kPjRWptZs1gWC1rBgacjvsFCPh7t4c/e8t8F2Gd489VkEF5PAbqg05
 IhuC0BqYrqGMbWE+pVKf+0NMz6preDZcMVuEf7oIP5JBsuNEZLpuPSSy0LvxmG48Hz+k EA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w2002gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJPfR023842;
        Tue, 7 Nov 2023 21:59:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w241ftt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JX2OKIZFgFOT5CB9D4VjOOTeFoe23y0GAKlYxmLNva/XPCxa9EFbHS/0NUdzRyYbWg6ValYcVXLH0MRple79Tiuc3UyQ0Xaja6Lt1ZxocpxO3mY2OvaLQxqVxX8kk33Ns37n5nWpH8B46pqTSwylCQj3pv59nBb6goyeTms3yXIDkjadnxiqlSi2FLXObbMbaQ7hdc/uxqOEIvb6R52cp+X0kQT1tXu2hBI16+3bGB9Vr4nn5UiAjpyPRTNCz0Rr9x2fbMrK/8jpmkfp+TdJn/m/bfzH3C+oC+acKPWN6svccLIJDQsLYkKDu3arDRnzyl/92xtXqLLuuSk/qOB2nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+U/iKR0DamvIXW1I7wH7xY9ovn4mPY9pe4p47kKGclA=;
 b=WSmJL26xT21PLdNxEbecgGthLSSTEujxlKs0iwKaP787H3JY4ddibe40Mv4RCYxJsNDj/n4VuEn6Ulr1tD60fOqCzkIiCMNjz/u8EBFLhzVJz3PTAigscExqQykONLclx/qiXSuVWO+RyUfTep4WgaiCq9BElvBTxg3hQxE4PbeHp05r/G7nC0/0WCgbnOO/DPGpXF7JEWMiqCYq7wNlZXhs3g5oogExUS+R5l43UbpNWmlFbBaol4cv+74VAXamyIoarKZB64NwhOG0TjnxGPRqmc1XRjkEPdDAaN/yGTniNGzF5ZhawYbqb6fggLIKiS1m5YQhYobeuqcK1fZrtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+U/iKR0DamvIXW1I7wH7xY9ovn4mPY9pe4p47kKGclA=;
 b=jvDxtj7fOpaBIwO/gbpKgo/06QujIbOcABCBGuf4L6HD5xKaW6Zbe0PBUcpRXPnfQlEATne6Sli1i7HoKOkxfOkE4ly6YFBi6hT15fmZpUO9ZF4zOFBxwIfswdf1rIHADdtOITDR2PplDF5UNmoqNhoANQo8wF+Xkoj18YnBugo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5048.namprd10.prod.outlook.com (2603:10b6:408:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 21:58:57 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:58:57 +0000
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
Subject: [RFC PATCH 24/86] Revert "sched: Harden PREEMPT_DYNAMIC"
Date:   Tue,  7 Nov 2023 13:57:10 -0800
Message-Id: <20231107215742.363031-25-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0019.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::24) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: d241cc17-89dd-498e-eade-08dbdfdcbda5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hz6eb+q7nS7eye99yuYoWW02Io5u6qAxdliw9BiP4qLKLW4yKrkja5rTyFOr1CCBIOxZ+0Y/5u0Q36lqpf5WfvKTxipO4w/BQIbVbmNKlBf4uVjOVUQstV4lteIqc+wnsxVQDF1igcp+mZdVjJajBHBxO4p8MQQ6tdzHgX7S02ggRS+0JeINnULkuQGxq4SIQpU5NyRLXO2Dv3BBg1wxT+itgX37lCWV/XJ1lklIgd3uiHKkvbWSz2tBxwscakjA4bpI4XQ62xk+4/ffBPiNkgik62HlGfDhqtBckXVpsj6JW+wszvY4g+GV1BfzrU7B4886c7bEn/kQU4Teg/d7H+1WhpWZ3Us2JbmfYzLaRhDWUgeB7QBiU0sojUN9/EBVm2b0Hp9HgGyY9lqAyGqzysNFo+jd3ZjamvgnXFEvZC5SGvtmqCkq/JTXphWDaCn4G3fqsGxULALZdCPPpmnL22thAjC/9bPL9c9sSurRbsd1LEq6mJ0mio4n69S581hfHvSgFpFmyRuvXJ/0VZ5uRzetZrFA35XUP24ibhn89X7PrfCJCM8CNNaULCbS7uBu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(8936002)(4326008)(8676002)(66476007)(66556008)(316002)(6916009)(66946007)(41300700001)(103116003)(2906002)(86362001)(7406005)(7416002)(5660300002)(83380400001)(107886003)(2616005)(26005)(1076003)(38100700002)(36756003)(478600001)(6512007)(6486002)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oiSNtbZMlfDrZ6Ted29lVhyNjGFF2dEsIfgm0rCOLNbywTIYif00J6Ov87vU?=
 =?us-ascii?Q?Md7e5EhRAwb74s8YU4Qy4y8zDNbD5jSOrTL1n4IT9HowqsUJjYD3szlgYNXH?=
 =?us-ascii?Q?2RQ0AiRLc4HLeElbJD0o8JwzhabyxDD1JRgqagZDDfobZYO1tWq3H08gR044?=
 =?us-ascii?Q?ebS12a78qUiKG0104YWrgcWsbOarcKqqgFKOMkBMA+RDSCZYc73FpmyluV7k?=
 =?us-ascii?Q?XSbgzBFzi8DP4VxTDulGGxwAvdxFiIX90Wv1tPhS2rb+YB/siB3ei8oBKlLC?=
 =?us-ascii?Q?+0Wezm3VToLYoQUiPizPNBwfXjQ5jIlFur6ZvPusB+6Z+EFSJaU9e7gLaBTw?=
 =?us-ascii?Q?CcHsr7pPKvpsmTchn3lSKfbL2clqlvMBIdShlJkFTHlVXea6U2Rv26DBmwno?=
 =?us-ascii?Q?DKnpZA5aYzIY1QECMD+/9Udpo1PJm9nU0A/Yqz4wMYwdwICuSrpqrcUBmEei?=
 =?us-ascii?Q?dVrZyg44pb1XUMtlkoB3XUs9PfcMP3RY1gD9gT7ZwT0VbD9o8wJDhBaQnXQm?=
 =?us-ascii?Q?yEVH4NaiL1ufTqBtDNWJtqR6Ww3iisz7rmTClB9EkFnisWC2OHiI7rHD03nQ?=
 =?us-ascii?Q?QWbnYV8auhs7VC34P3de3l4Z7EsBuabyGFDvBrYkskgMuWqQVVDGF2m13P7K?=
 =?us-ascii?Q?zkKOzC/DBfmYB8uZOc3fGuANtxsQX+PyjA7A3Sd4+7lanj8poHOr6KSCAjIz?=
 =?us-ascii?Q?/ew5DQjpJs58qxUMeKVkKY7gyNQGisTHD9mxSRjGclK4cEctwZ788LGTw4H+?=
 =?us-ascii?Q?P+8XjLpUpeBTt+wvwZO+03mNWxvwSBubteF51N59FnCv2K/56HRhWSOuk43R?=
 =?us-ascii?Q?klHjfR8hT8SY7EyVlpC3Qf3QIJ6XxYKosjPredug7KbKLnohf8RaPd/TzjsC?=
 =?us-ascii?Q?0CJLFJggi2rJMxfNYqmfr9C+OlDmDXIoygZ2wCG9JjExh3SINeRyN8m9vkGP?=
 =?us-ascii?Q?w6+MFQ2c2AN81y+W1orW+hMkCqWbj+zbVGFkhYgtpfOpgLK9LTDjWgmNAbY1?=
 =?us-ascii?Q?ETnkbQsDi4XrySEs3RqihhAZtkZEFxhg3Ax8NlOgUogaiPgFg49t8gjwhENf?=
 =?us-ascii?Q?9AIRCohQgV3CpnEUSdBvWV1e8S068UNaduE9oYMDa+ehNNSY6ZRoV6gAINyb?=
 =?us-ascii?Q?+ruN+ien00bg7QuIXw0wT9HsXm/RWS+EqgiIUJnqgLKMuifQTuO4uoMY85xg?=
 =?us-ascii?Q?/MxYJ7f/Gn8wue4/tImPona6KLROgWR3E3D10AYaqBBIG2afZgDp5VjtUGOT?=
 =?us-ascii?Q?urbVvpKFinmGWqTqUewBiFJMJoD4G4MNMF2zHsEXBMMVGiF4FrRqYUoAZRhy?=
 =?us-ascii?Q?5Ge6j/hdZgUyJEpF9z1fMNl7diCoIGiS3psgTf4KDlq+Qz6dvCW2q/wXpWIH?=
 =?us-ascii?Q?U5xGDOMhZmSJjoCy5EB9UI6cyD9XBCB6i+tbqiqb1eBB5z328yZKJH8ZLf7F?=
 =?us-ascii?Q?x822XKzD0YLGSeeVq8czXgYccfCIlgzglnNQwZqqf9N20LCYz8SsQlJ6fRj5?=
 =?us-ascii?Q?SJ/58He7kpPKAxlTB6rz5Ar/P4PmdmyGtqNEY38+FONjg3CiblArfe70ZZYf?=
 =?us-ascii?Q?jrZQwKmwoOBK8Gsa1F9qczjpdeBq9TICDuLYPqFwtPcyMNi3QLBWrfOr5x2e?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?vW1BmmuLZLK4NDbKwxII60DgCwcpnV4x3Tbq7STafZqxO0bUE5Nf+qap1LNl?=
 =?us-ascii?Q?lwcwY4sax2ep9Jb9Sh4f+9veQMuzdJXlUU6nOVvF7sQ6ipkH9CpWDuGcGER+?=
 =?us-ascii?Q?Wvn8zoGJnbiDgywBNILQohRcDTFYcp0VtevCZpX/xV3SHO8z3EqCAkm6wcbd?=
 =?us-ascii?Q?S/nCksazi9WVOv4Gt1mko9ItFuGmxmOAUfSpoC36sxKXFWNvQdFGMh5rxMj1?=
 =?us-ascii?Q?saVHKngTeuA8PNxWv1Q6i5InxU2voUrvEc4j4uQEgOUv7Qa3Uf7pezbOlF4n?=
 =?us-ascii?Q?5RqF7E5qgsk3s/p7E+ffr9rMOlC2Z/NKroPgnw4H1CPT1ckoxdM/0qAkJsTx?=
 =?us-ascii?Q?rzB56LVF4CibRR1vMiSI9R0SXcwwzpOhIkMh5wMIliDBBHUpB/9N5mww3cxM?=
 =?us-ascii?Q?8vLaNEGyrbXfps8gDTyHT8+5JihQgP1mAu5oUqCpcoVhRIsrRUdD52FoAjGe?=
 =?us-ascii?Q?2IF58rob+PLLVEfZYRu68pCCrJYibGhWXGCmc+b3EO+Jp+GJx65uW7ExFFOV?=
 =?us-ascii?Q?mtfkjPnhKx0AWwn+SVSKvAlwaSOYeDFzAV79dW1qJqxTCc42ZfLn93dqCtZ3?=
 =?us-ascii?Q?PIiye4zDRDsawpj/653nz5+k++CWUZO76Zx2bol3vyhkk8+6RQPDBt+nYsza?=
 =?us-ascii?Q?qwo3b8g6bu8adZ1OWKQWlQ3y2wT/Sft1FdYnYbON1Jooo/APEn/nBxrzobJL?=
 =?us-ascii?Q?CBgBRBihDDR617eHC8ehxoJ8hRZvfR2OmrN4cDFd/g+hXGqQUEUDXglQ7DR9?=
 =?us-ascii?Q?uOSJZg9rL66uhfmFP5OzMqmKl5Ei41CkcEYQVDkeub5d0G2RWsZc9RlsgrCr?=
 =?us-ascii?Q?pf5rr5xCcVfxZZkYw5nL/GqXoxGtwXAtAUY/mLUvtHDST1V5kf3Oydv/njCZ?=
 =?us-ascii?Q?3bFlPuQkcP+6eDOW2ZA8GahATKCSX2BLxnCGktY25SC/TybVmkj3REQprfnq?=
 =?us-ascii?Q?k8ACMpnR+/eB6hMz6vXS2jxA+rrUAEo2PaXqttC9TEkOPo9vdbG37HBgKfiC?=
 =?us-ascii?Q?pImZjFKKVV8l0cyZcGyX3LkciNhGvh1kq1wF/NVBNZu9CjA6ML+NJTMm2+/B?=
 =?us-ascii?Q?N+o40uBZA+JBAL2DEqUWAEyp9e5x769I5pMI0lOHtK6oGW0VugQrjjK/9L4U?=
 =?us-ascii?Q?V3LpbJU2mZURQC66DhTejS8mekb96p9mYYpQAepvpkHjzC9JD6NTBXvlmjN7?=
 =?us-ascii?Q?q7xmQS1zMf04VvUDC7M/QSppV7TIde9cXOdjeW2e28JB9T4sIuWW0Qc9DNO2?=
 =?us-ascii?Q?xlHzzJikupYCCypjbIfA9mjNvdHKPr2ZK5SiWppSnSLCcZziN1sJPk15RBFs?=
 =?us-ascii?Q?TdtxvGWq481/WnH9Of3P6zE4UxLKp8/tPy/iAyoD4HxgGBLXeEAbw6WUfskE?=
 =?us-ascii?Q?VGMLreEQEKGH/KciAmyNaIvJv1J8UguFjUwXOLAHkoYmQKO6PXItLX/eITvT?=
 =?us-ascii?Q?DMFW7ibDDqhkCoY6vGSUTSJ3nTityPs0NN8VfSq+CbHG8RUK+PuEvb+yJyTe?=
 =?us-ascii?Q?+1ui1AX1V1hSFMsm6EGXGH+Z0sFOfKLjhL3Ol9YldfZLDx8LRY/tZhcuZQ?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d241cc17-89dd-498e-eade-08dbdfdcbda5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:58:57.2002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwOyUiUX85u0/2lAJtpD36G8DoJGFX7QHieSoe3+pSb0RBbTWgZfwYXV1n8R01V4akQvVPdZO9FBibaMKSg52fXNM4XrcEL+jH9v1qg1Lms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=950 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311070182
X-Proofpoint-ORIG-GUID: spy_pRI-nsqHQNPMf4_JV0QdBmow-LeI
X-Proofpoint-GUID: spy_pRI-nsqHQNPMf4_JV0QdBmow-LeI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit ef72661e28c64ad610f89acc2832ec67b27ba438.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/preempt.h | 4 ++--
 include/linux/kernel.h         | 2 +-
 include/linux/sched.h          | 2 +-
 kernel/sched/core.c            | 8 ++++----
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 49d2f0396be4..967879366d27 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -115,7 +115,7 @@ DECLARE_STATIC_CALL(preempt_schedule, __preempt_schedule_func);
 
 #define __preempt_schedule() \
 do { \
-	__STATIC_CALL_MOD_ADDRESSABLE(preempt_schedule); \
+	__ADDRESSABLE(STATIC_CALL_KEY(preempt_schedule)); \
 	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule) : ASM_CALL_CONSTRAINT); \
 } while (0)
 
@@ -128,7 +128,7 @@ DECLARE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
 
 #define __preempt_schedule_notrace() \
 do { \
-	__STATIC_CALL_MOD_ADDRESSABLE(preempt_schedule_notrace); \
+	__ADDRESSABLE(STATIC_CALL_KEY(preempt_schedule_notrace)); \
 	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule_notrace) : ASM_CALL_CONSTRAINT); \
 } while (0)
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index b9121007fd0b..5f99720d0cca 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -109,7 +109,7 @@ DECLARE_STATIC_CALL(might_resched, __cond_resched);
 
 static __always_inline void might_resched(void)
 {
-	static_call_mod(might_resched)();
+	static_call(might_resched)();
 }
 
 #else
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 66f520954de5..2b1f3008c90e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2090,7 +2090,7 @@ DECLARE_STATIC_CALL(cond_resched, __cond_resched);
 
 static __always_inline int _cond_resched(void)
 {
-	return static_call_mod(cond_resched)();
+	return static_call(cond_resched)();
 }
 
 #else
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bbd19b8ff3e9..7ea22244c540 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6893,7 +6893,7 @@ EXPORT_SYMBOL(preempt_schedule);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 DEFINE_STATIC_CALL(preempt_schedule, __preempt_schedule_func);
-EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
+EXPORT_STATIC_CALL(preempt_schedule);
 #endif
 
 
@@ -6951,7 +6951,7 @@ EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 DEFINE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
-EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
+EXPORT_STATIC_CALL(preempt_schedule_notrace);
 #endif
 
 #endif /* CONFIG_PREEMPTION */
@@ -8740,10 +8740,10 @@ EXPORT_SYMBOL(__cond_resched);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 DEFINE_STATIC_CALL_RET0(cond_resched, __cond_resched);
-EXPORT_STATIC_CALL_TRAMP(cond_resched);
+EXPORT_STATIC_CALL(cond_resched);
 
 DEFINE_STATIC_CALL_RET0(might_resched, __cond_resched);
-EXPORT_STATIC_CALL_TRAMP(might_resched);
+EXPORT_STATIC_CALL(might_resched);
 #endif
 
 /*
-- 
2.31.1


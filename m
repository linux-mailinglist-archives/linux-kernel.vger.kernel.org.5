Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E988C7F2595
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 07:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjKUGAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 01:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjKUGAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 01:00:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962BACA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 22:00:30 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL43ksV016094;
        Tue, 21 Nov 2023 05:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=7hH92ZQrtB8k0ohCsdLH6UTsBWOvWfelcXPxIb0rfFo=;
 b=2LaW/+mMjrxKx0pbWcEXicr/3xuqP7ep0ySpkS65xfHJqjBrAgbHh298v7lu8mnRu+fn
 /gp2ZznTQSm7kuJ0aFrcAyLBeW+xNfpIxDi7S3wE6cV4R35/fJjrQU2+GfElbw1Lw8c8
 e8WtblOiwFfALQxVBBBC56RpE5JKZwPoGUdHz/gVLU8EvAVY8xMhJaSmG3YMaDx+n74D
 RxIVBtzceqRW+z6qpKTIEVXYOuTyPVotftcLYyO3uVjg+3fFRXs+3r+oNPzLYh6txIZk
 gNmgqTGX4mG8r83O5fGEVNMoQgdL8KCagbL4rlNHeD9S0/HUyBHMnFRz80Om2CMeZrni 7Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uemvuc7qg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 05:59:16 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL5eS6f023587;
        Tue, 21 Nov 2023 05:59:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq6e2a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 05:59:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1R5DbjkbfSaWCzYRAGCO5FptR/HwPFCCwM3H+JYj9IwXlrzQNaZ647xkpG6MzuvKOzbfGF8E4RjuMUI8vvvOOH1uN68LXJN1G9zbqRbClRd0Bzumqne3U6P5XWwB8+mKr9ICNvltJx9wGMNW437SeX4kpBKeYhAgmeQyoLmRDbt/93M5yn1Kz1SToMCt6c95a1T2DMNedeOgyQ+KJfVFJ6GjOg7mc1XTAZDlLVNxK19Ok53en9lgG0dhW+RUzcsmJhWIi88xW6l3YCZKZ+1Xd+ZWR4gILLgOBT8jw6mAXY+2odOmVuNviL4MIeOZ623ty8Qr3V1IQ4fBr7sfHf9dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hH92ZQrtB8k0ohCsdLH6UTsBWOvWfelcXPxIb0rfFo=;
 b=IZJfpBGjqvhIuMDzrpGELJ3xTlRhuCLSioUNXK8ZJjespzWDTIsBKl78qyYPCAyvQQiXCwNfhe4cu3ObMH6j5LTPBw72Sc6PdThz8/tmZRCB3uLw31O/2JGX9uQ+I4HdZn+/BTNYkIDpfYMDAVfAs4pti06M6K5pApKbXwyiNLshIkUwukwJPbGfKm+sANkbPzXXES01ymjDi3fa9VyZ96D5PFmF7pVJLyWuD6DhkqmvbRfk7sjBpwR4gwHs7fd0390vq/AsaF5cPa1yetVZZdyXu3XCrVoUQ0Adn5TSIAFZO6p6SRPl2/a1GZMVaGdgJHxLTI/taam61e/YYTYh9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hH92ZQrtB8k0ohCsdLH6UTsBWOvWfelcXPxIb0rfFo=;
 b=lGyxAZVJihQmQotLAkybceQxduDo0bKmBEzBhsQ4PSuF7Gpdc4OUulUARg1JuBHNk8rhCu7/ufJ/JxFD9LY8KTaIn1l32mJFGANy0O2uQoVpAweIpxvt1ZrdQ7wwSmY+Bz12ZHfEKwtdCSqeDWeNltwh32bEdNDyK9f5madnc7c=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA1PR10MB6448.namprd10.prod.outlook.com (2603:10b6:806:29e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Tue, 21 Nov
 2023 05:59:12 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 05:59:12 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-35-ankur.a.arora@oracle.com>
 <20231108085827.GE8262@noisy.programming.kicks-ass.net>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
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
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 34/86] thread_info: accessors for TIF_NEED_RESCHED*
In-reply-to: <20231108085827.GE8262@noisy.programming.kicks-ass.net>
Date:   Mon, 20 Nov 2023 21:59:09 -0800
Message-ID: <871qcj1wb6.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0092.namprd03.prod.outlook.com
 (2603:10b6:303:b7::7) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA1PR10MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: d5d0a245-ab8a-4cd4-b21f-08dbea56fc15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tn+MhqkF6HVBMrc8RITxYQAOqf1P9lUA6h8PFNOFc4HurLzdv8raS2r10nWxlKBqO+CFO/BxGzn7RAROlVCoEv1Pj67kljDXqg7SajTskNHQHrTQ9qezN5yA37vPrN5eoGDn3IWZ7qqVAsAW4fdaxZ6KqlHEeHyBwL4d6icJgFKrAFRo+Oo0Bq8tp4USMwH8K+ybSXVdPkb0mACj7is6Nqhi2NGT+CzW5rFxoV0Xonv3UNLKhWbH6FV0g9e6BJOGeKfXQ0B5oFmWZX6o8tlcm8FtiUBa3vKCUzEL7xAbemaNZ715e3Yr/tv40u5OUzFnydkomYM6lVIDbESiMo+SscJXU8kX/5K4o1UmN5jYuNG++bKA/mTr2QNHcDE3HBK22o7oLn+M02t0pohSqGgoyRYjWfHuSDm5MYQFbu37ceIM20tC7DjGchSNyEPEfUD5Bu8pCifloyoakvkprykT6/FHlcNFssGnZOPxX5cF0l9OlhelascW3Lv0BpqDL0OAf3ofdguakEGRNl0ql13Ywe0o2xHxxli0D+QSLwcOwi0eypS8jcGe/ZyK53UI1X8e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6916009)(316002)(66946007)(66556008)(66476007)(478600001)(6486002)(26005)(2616005)(83380400001)(6512007)(36756003)(6506007)(6666004)(38100700002)(86362001)(2906002)(7416002)(7406005)(5660300002)(4326008)(8936002)(41300700001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I2rgd9nzPhsNBjeD3zzdypdiBE+HfB2WXg71YmLgOTrTr6Tg4PIJU0FJ8UqR?=
 =?us-ascii?Q?d2154rUT9cEgCCh4x3fyEldgLhcC98oQjGxeIa/khGgstJNcAcO0AzWABzvt?=
 =?us-ascii?Q?93kZTXquIc9nmqMDCq7Jima+MzfW224IHEXMbARDtblyQsbS65Gvc8pG4Ve9?=
 =?us-ascii?Q?fz58oe8YrnxD2TlMp6Wj9DVdcYwb++HO9EQkfh3wGY857EL9/pRq5zHn71E+?=
 =?us-ascii?Q?SVsLOqy5UH6Y4hkQf2SriE4JtmivSHPwB7LH+lasdsN9C5WXll3nkKB6NFMF?=
 =?us-ascii?Q?hVz83GStSmAnlhHWdkTiLzhGti9DLL3XfFkNHtrMCV+wl9lZC84enzlKo/Me?=
 =?us-ascii?Q?6hVbNLY9eikFfaoN/giDUvvtIqhvJF1GdT4T68EEmF9Vp3BeS9ICflErkNRi?=
 =?us-ascii?Q?bTiKUyFI3dKOzIyoX2CHUWnjalBnXD3N+y6275+yrMOg6Hp/uCNnSiZn4h0W?=
 =?us-ascii?Q?Sx0MHlwCNAk2zj30dJkU1BklCWE6Y8cbrLh7Wtr8gO1ghEFtnsOblleXKrYs?=
 =?us-ascii?Q?xZ2pVuagtUVSWUecoBFcHG9kWzNzmlvbt5vWvE+l/of5q7wmM7l2lVoAQQXE?=
 =?us-ascii?Q?OWREZdUiGzTWSUPEJjFopCR5bpHeQeQN9Rhm4enhDz+K4qLBVw3N5GHunC61?=
 =?us-ascii?Q?bvyxwKxulVPUjeePC2wfTYt44VI12yig6BaZbD13bEPXYWiR/yrocOQDyEjj?=
 =?us-ascii?Q?gmUh/C2wiCj4j2DuLOAnlYhYYpkVVU6H/vW7ZnOGYhLRUYmj7jy2sqQErA8T?=
 =?us-ascii?Q?xzDFSPurejljhazq/Gst2e6Fz5Uu2+F6I8sUOvBM88+xvzDCoQlDv3FPwFDD?=
 =?us-ascii?Q?/Jtl/dENiVe6YEdIgqNepdKxx+fT05dIoYGnLC7gSCfmqNP7yS33RozYlM1R?=
 =?us-ascii?Q?c1ojlU+74l5ZEP39G5/qWVsg5XN8+JQIMnooEtHgByZ+9wMqXrvxlm6FxnyA?=
 =?us-ascii?Q?2Otp31tO/FSGMyVAbi0pAZzfabZqxORwc9rjzjQL2q4Yh0chh6JpPeRMM7LT?=
 =?us-ascii?Q?YYj0jPjljDVo3F1m9mb7/KYiJDhM2bbogKbaGAQWx2iRnYclRD/lMVO5soV0?=
 =?us-ascii?Q?PJ6NrZ8L79ASSvagFC6csYRZhom7OpAjyV37r06rxaEwFfWQvZjx3UI91B7g?=
 =?us-ascii?Q?w52NA2NL1LbchLI36IHgBoBucWPeQOJvOCbtCxrXvDsGt/IHp6LOiihjj9Qd?=
 =?us-ascii?Q?41ilRYbDPWzbCisedCcEaMbo/tUeMIGJEX7goSOmQfA+WpJeVT0iYdigQmpb?=
 =?us-ascii?Q?w1b7RtAfBz4ls5joDPmF7cIg6YYpzyK4C8dX4C8gV2Tk17ujOPKElwGsTCYT?=
 =?us-ascii?Q?BQ8M3QwgNUuSE1Yer1sC416sMHcrXHbJkm9hrmiWtMSQR5lgioj8uVumYfKb?=
 =?us-ascii?Q?utnoJMAXDKTqBsXlU2t7nHc+YCXNL47K5JYwTS/uWeZ2ZJaIcbJAuyzW4xbX?=
 =?us-ascii?Q?euFMW7ioD+2RE4qgu3kYdZo3OofUOpoBtQUrzy+l/B/XqS9YJM1SBTFoLO+Q?=
 =?us-ascii?Q?2d3YDwKUicQSXWXvD2zn6XTnaEdiM6MhEGKoBRuImxh85yKRwFQ2aLGmmmzN?=
 =?us-ascii?Q?/h3KL8zssEnFv6xMrsQf/zwcXcpM71vWUiZqZSRL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?O19emjSVXAb/7YrCmEGJI+uhYhEa4npNl8egNv4IkqWxQdyntggtbI4dbFeo?=
 =?us-ascii?Q?kwnSk4+Jx2qTBPoK/uZXLjAlq1jRyDRAhB62+nbvdMzM8XDtruNN9KYZGniI?=
 =?us-ascii?Q?38PTv3/+OnD4OBaojj8bgLuvqwsfMx3ya+2eg3lVBXYoqZQnn1tFISPTeGyu?=
 =?us-ascii?Q?b8Dxkn69geeWV5i4INZSlY4Vhw9rgaJr68L1AWtRunWvkpOLl4Owo1EorhOI?=
 =?us-ascii?Q?yiT1Ty3pAw1zGRLu+Pj1cestAWjq9yQTI21jn4qObWbKPta4mnOMY9sPpLpa?=
 =?us-ascii?Q?0XrTQsGk9b7eUjyIu9zYVTD3UpDyvBJtJUky9bZoNsoWU8nlwByWq6dxEBK7?=
 =?us-ascii?Q?TuNC61DyLEMmZPNrQAo/Fe/QoYmNONqL4g4Gje8wKGNrEwFbFMo3sTnyPh/B?=
 =?us-ascii?Q?VYaGzc7UXPHv3fAxZE9UhpH1lxRij/SkMxBUoRITKq3a4ZivXb81JBwhFvsR?=
 =?us-ascii?Q?qIkfkzSnVQ1TP1ZLv2fYSrw6ZyVVNhYS6EHs34V9oogjJA1oKBoX2D8WRe0+?=
 =?us-ascii?Q?y2k8BSlB5gCNGccUTXdvpMx8zvXRvybDIFkVqdHLNvyYMUC2HCnPo3YCkf9w?=
 =?us-ascii?Q?Dbl+3rNk/vQ0WD8Og9DlLQCmjXRKUZD0hgSHnLuru9QYktmqYNyOIY4La0+X?=
 =?us-ascii?Q?pSf1+mTLaploFLL6c87Ri0ohO27f2FpMUhbzU0iKn+Ve2WQXSEmwWiMa6D2q?=
 =?us-ascii?Q?36yE9EjiCcDvyzNzC+aBuNjwoWPmo475DhoD/TrYNnhXxs8bG62chUXNlBsA?=
 =?us-ascii?Q?usCg+XaKhMNZFaYsdNSjhCNxvDN6N6aHjhimGAwecfOaivTgNt5QfY93Jk9c?=
 =?us-ascii?Q?hMOZ0VBLOrOxqLVcatS7UwwjyMUdKySadoGwkxlnqPylRUQzv3LDwekBFKnB?=
 =?us-ascii?Q?5q53m6NRRZgHsmwPdLUa3BwSCGMPft3AINljRvP/x2tC/Y+VRoXkjeL2v2+C?=
 =?us-ascii?Q?pdMH13Qcm+tBg+jJqq+T+PlB24mW09jVE/otGWseUQmN2AdkUZF3lb3kgVxB?=
 =?us-ascii?Q?tWFMVS5awjBr8Fv8HWDwus0JI5IIrYa9XkhSsdJyEGgYlYPZuWXQKcTKh58S?=
 =?us-ascii?Q?ulzgcnPirUPeL1oQ0/Xyhwkx8U5fKJo7Dgj0h7guXQa5mMUbHObinMsa2bfk?=
 =?us-ascii?Q?89I5UcPRh4nve9qiqvfMOloBpc4sNyD8sLMGNSHyivbllkdp9xFz90cTNy6A?=
 =?us-ascii?Q?qhnMR7csrQEwbcga5kQhbV96O2gxeZ4Kwst+iz5u2umuHZ348DiWteWoPBjs?=
 =?us-ascii?Q?XDAtBQ+IRakGvUoSBPfPZ+N8txAa8F2nL30rMBXwfVWgOAPLbLSts2CJW2vm?=
 =?us-ascii?Q?RZuuc2KGHwIPe3OMSc5CPMty7eZUzCUQaE2MoBuCsXwRX5guLk1S+UCdmEIY?=
 =?us-ascii?Q?9rz8fY/q74Zhp6EELjW68Htymyo6Va5CrgmAlH+zbSMZXrecR8BYBlYxlq3M?=
 =?us-ascii?Q?um4EpR+6Xhvf+hTbfzLaF38sm5PzHokoWaabx0InIOlogkckN82RINDopr7/?=
 =?us-ascii?Q?0s3iYkFnSa1ia48P6c4T7R4uV/Pjne7siEBwnNt6dwKURF9pVymJLANmtg?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d0a245-ab8a-4cd4-b21f-08dbea56fc15
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 05:59:12.2047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JScQileuFrEcM9txfWdiSY4jX0MTccb4xAPF6doyVBn8RU8mkfUDXcRvvsanFqAcdIuhXTLvKoWTyTmitwoJpim/q/x27GdtR7DZ0wWGX3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6448
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_03,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311210045
X-Proofpoint-GUID: PJQJ0dO9eiZYEqLUYsItcpesI4IFiBy2
X-Proofpoint-ORIG-GUID: PJQJ0dO9eiZYEqLUYsItcpesI4IFiBy2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter Zijlstra <peterz@infradead.org> writes:

> On Tue, Nov 07, 2023 at 01:57:20PM -0800, Ankur Arora wrote:
>> Add tif_resched() which will be used as an accessor for TIF_NEED_RESCHED
>> and TIF_NEED_RESCHED_LAZY. The intent is to force the caller to make an
>> explicit choice of how eagerly they want a reschedule.
>>
>> This interface will be used almost entirely from core kernel code, so
>> forcing a choice shouldn't be too onerous.
>>
>> Originally-by: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>
>> ---
>>  include/linux/thread_info.h | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
>> index 9ea0b28068f4..4eb22b13bf64 100644
>> --- a/include/linux/thread_info.h
>> +++ b/include/linux/thread_info.h
>> @@ -59,6 +59,27 @@ enum syscall_work_bit {
>>
>>  #include <asm/thread_info.h>
>>
>> +#ifndef TIF_NEED_RESCHED_LAZY
>> +#error "Arch needs to define TIF_NEED_RESCHED_LAZY"
>> +#endif
>> +
>> +#define TIF_NEED_RESCHED_LAZY_OFFSET	(TIF_NEED_RESCHED_LAZY - TIF_NEED_RESCHED)
>> +
>> +typedef enum {
>> +	RESCHED_eager = 0,
>> +	RESCHED_lazy = TIF_NEED_RESCHED_LAZY_OFFSET,
>> +} resched_t;
>> +
>> +static inline int tif_resched(resched_t r)
>> +{
>> +	return TIF_NEED_RESCHED + r;
>> +}
>> +
>> +static inline int _tif_resched(resched_t r)
>> +{
>> +	return 1 << tif_resched(r);
>> +}
>
> So either I'm confused or I'm thinking this is wrong. If you want to
> preempt eagerly you want to preempt more than when you're not eager to
> preempt, right?
>
> So an eager preemption site wants to include the LAZY bit.
>
> Whereas a site that wants to lazily preempt would prefer to not preempt
> until forced, and hence would not include LAZY bit.

This wasn't meant to be quite that sophisticated.
tif_resched(RESCHED_eager) means you preempt immediately/eagerly and
tif_resched(RESCHED_lazy) means you want deferred preemption.

I changed it to:

typedef enum {
	NR_now = 0,
	NR_lazy = TIF_NEED_RESCHED_LAZY_OFFSET,
} resched_t;

So, to get the respective bit we would have: tif_resched(NR_now) or
tif_resched(NR_lazy).

And the immediate preemption checks would be...

	if (tif_need_resched(NR_now))
		preempt_schedule_irq();

Does this read better?

--
ankur

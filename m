Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5AE7F25C7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 07:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbjKUGdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 01:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbjKUGdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 01:33:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0347A90
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 22:33:31 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL43fug016095;
        Tue, 21 Nov 2023 06:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=rPnXnCOImwdEJ9/ix4/Feps0w/DxQ4pXUQGxrEBLSA8=;
 b=QaYy1JMX5fp0L/QIDVhSPBsdgKncLY9SvFFBlz73FZV3921aFgfKjHyGCLOGYN0ITjN6
 iPSEJxTXmmOmUjNiQWInr5q/fpR4oOa/HdQRWXVz6tJ/Y+ZryxTKBwsGvIcdrAaJu6i3
 Fbu1JmjFCtABUfq5iRI+5/ezm8DeGLM+y9bX7ShD42yZE0V3zPMeShNZyCaVUx/R/kP8
 hI0h8Mxf+j47KZCoDAD8t/Kq5ilTOW7J0AkGsV76QQaHlHv0WC82TR2klRHXMZ+wuQ/6
 5Vx/LpAXwpn3kejruAkj2YISR1CRKoPFjKHQE6tsCRgjSPE1K3qzQMmelJ6qSj0WxDz3 +g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uenadmasf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 06:32:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL550GS031229;
        Tue, 21 Nov 2023 06:32:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq6h2a0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 06:32:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gum78lQ5cwrH/7YLg4KChCjivHRVYngr0qHP2662oOvlg7rFjzSc7iFPoO4uTuHSilGRw9bBKTFa5hpU5x573gRi+oR8+p6L3mvFq/QnGvQwrpJ2W+QdQE9kQ+zJjyQlteByZPm54mgCqITNFolGXTbjjXaJbVVwHsbBNAmCmkwKQmuZoYUn3P0r3Vv5kAeR7DfDMJCN166w64PtbWtei3Zbi9dlkxnzE1lyjd01QQbrLTS4qU07FlCqN/F92Pux8tLlt2STDGbDQyX0F8AYvv6LCbKCLZJsFNPFhtmuMu24n0o7jGGf8844SUogMYUfPplvE9S/1UQnr34FF4zMfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPnXnCOImwdEJ9/ix4/Feps0w/DxQ4pXUQGxrEBLSA8=;
 b=PhdWAJxGxxbavaChS7OInh3iReit/8LaaCTXmXTdFKa3xBFNPwomVNl0ph0zAOziB3/spQU8SGO5CSziktFswbkalNmECiPaOa99el734W5AM0a7kQ+4gxtSITV5TnG2nEFoWpgLZLovZV6p2rlH1jxpXetLOSCUwbyW4Vvq0A/+xIPJCl7eu64eixy81mOlZZaecWz8Y05x+SEIYLpSPCNTwXjmUOtOY2F48b74t03+fUxgSb82RvQWOE8Wi1r1jBlj40mX+FN0/KTdS45L+HpWFnwmLenIIL1UDleLmML9BkVsGwaPSU1+g+fKyNTOfD6UU58E/H7FSOMLk96rbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPnXnCOImwdEJ9/ix4/Feps0w/DxQ4pXUQGxrEBLSA8=;
 b=V3VwuEXmjRytcCRxB/BnerC41bjH1cmGMcbTlClNID8eMDw/UyOxCXMnNxpuOsTphSUTKmZGqA2F8TIDO/cuFi3+RnMJ9eV7JYpa5a2lxcsmPtnkSO0SezrRHKzAiZZpByh/i8vBTJlNkNIvN2ETXtJmfQLEXgk71mY5XRH9IRI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB6733.namprd10.prod.outlook.com (2603:10b6:208:42f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 06:32:25 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 06:32:19 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-41-ankur.a.arora@oracle.com>
 <20231108091659.GK8262@noisy.programming.kicks-ass.net>
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
Subject: Re: [RFC PATCH 40/86] context_tracking: add ct_state_cpu()
In-reply-to: <20231108091659.GK8262@noisy.programming.kicks-ass.net>
Date:   Mon, 20 Nov 2023 22:32:16 -0800
Message-ID: <87sf4zy5u7.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0353.namprd04.prod.outlook.com
 (2603:10b6:303:8a::28) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB6733:EE_
X-MS-Office365-Filtering-Correlation-Id: e28f719d-bafc-4d63-146c-08dbea5b9c8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EjMqLUvPHpFc111OtVpvoZ8hZ3RLI6czTna99OrPk+lf3gVA+S1lYSS1k72QcI7uPEty9j18ic9OyU8BGvpxKzO3xonKcpqdP/qn7nSo7TzSg/qJC23gEYM7pmsi0MKNVcFYAsPEd8bSpCh+IUiuJsyebuplzQaTVvplNsv9MjBXDu5+7jLiTdPyAk9NRgahnZebzW60BTfLBy2Q+xoMvCBOfun3ieG5EwF4hE5Ga2sa/4ElPQH6nRbtlc5ipCu9oroHFF/tgaDsjiS40M+d1TbrbR+V9APV5xlSRwVRM1VbWQKyHPDX1sigksANvzi18LiF0RZxMvCo9NCkNdmh4uetJwsAiQmORXmb/twLUwO2hMkCRqsldWAxglVhEfwloO3yYpXzldxnwij0BFl/6KZCTeIFM00peEoCkPGnbf4HBdYT7EDU2psyDx+qDpa7C6XN32k1tjqLpJkDDEileYXb99VJiHMeLFZxvMfIVYwU8qtCWKPMpfFFi9MDqSS+SAliyzXCbR/O+oSyjictcFWbxcX07ywmmi9nF1O8EJjjgLaomh/yjcM3wO+Fwlmt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(5660300002)(7416002)(7406005)(4326008)(8676002)(41300700001)(8936002)(2906002)(316002)(6916009)(66946007)(66556008)(66476007)(86362001)(26005)(6486002)(478600001)(36756003)(6512007)(6666004)(2616005)(6506007)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rm1g4U7iUdhkWasvnjqEyLzlJmjwaYpPcXcKgJjtii1cFfz1AGHn3LW0jAr0?=
 =?us-ascii?Q?pbWjGzsruah7HuQDQdHOO13Kq+GRtsW5nAsM7M8FsOMnwSabGq5u7jtYDovA?=
 =?us-ascii?Q?p3c9sbeSTya9QMhLLxZ7SCXm1O/Xps9NV8fDq0fXbEQJzygT0+2RRuuKKwRP?=
 =?us-ascii?Q?vSE4O+DVDJHKVpUGYQ1KOLspug6sfNIZiW+AAmh3b12/kGbGNhz6EjgPgchI?=
 =?us-ascii?Q?AKMjDfqW0F5hIsuu0jM3NizwIVeRCE+XaIOxqsl3cFHD9wucchuSbO+rijnG?=
 =?us-ascii?Q?vRphsQUwKDjvkKbICwAOktDLa43nBggozk5CgUXcDX/X6Fsi4ouXbmfrDeI1?=
 =?us-ascii?Q?nVRHrxUbAgbAtG4LcDZGaT4xxFxrRwLirZQN21oNTTuj23x0CFJW+rkwsSEg?=
 =?us-ascii?Q?x+3Vq+jTgt0s2JbfXuAUkDzIjKlYALhdc3uYvrT+IYnNPVRe2Wncc/z51XwD?=
 =?us-ascii?Q?rS7vestX47/oc3zJwyk0zWWvDx3/c+t1VTi/eYqSv1QZ3Jmo4kpr/tA4FJtA?=
 =?us-ascii?Q?pNERGyGs4gTx6HRf6DMjzKdHyQB8qBssO8XclG0zaEwN43G3ZXQ3H0qq/9cg?=
 =?us-ascii?Q?P9RFQY43DFBudxZ0fS1pHOcsq1+zd4eeSNdRY1Fjjx+AESLENmUuB+UfINM/?=
 =?us-ascii?Q?RpNQ0iWopk6Obomp80LVZjCWI8z+nSFxuaBIuZS3EmDuYl2WFsk4eNp7G5Er?=
 =?us-ascii?Q?6hm4UZD234Njb/Ap1Cimq8O5Y9XBdsK5Mm9R9OSC534MD6N+a0tIhiRBRYIk?=
 =?us-ascii?Q?LkvpvYO0XSd601KyuOx4efDWiPtuXVUSzTZrSTsh0MqJrAymAYWK4GJHao8m?=
 =?us-ascii?Q?1XOB6srLVFncXduVkrPZmnmrruW3WM4SRuU5yVTf/uf4FM1jdQ1GY09f3ytW?=
 =?us-ascii?Q?18AX1ZRhMp+zkiyJj+I+XxEGD+DwimoGpx/e/xI/x6uF2P/dYYRFDdVLcq9K?=
 =?us-ascii?Q?YCImq+l0BCvEJV7kvZOHFgRIt26cjFplWPLeAW2Ch29AXYZ/uY2DQ8Qinj63?=
 =?us-ascii?Q?AFbaWmL/dP8peNKMz6ijNCM7n2HgAMXwGevelAOOfB33CtvTbbaM1neCC4GN?=
 =?us-ascii?Q?wgZR1artyMh/meYxWBuyuEkyfSz9HGAoD8/2PdnL293a02Hcsh+YmoxDTONw?=
 =?us-ascii?Q?yXB9Qzs/mbxTRLZQZ6iGty/YnOoVsxph20OuIkpoT/M6JbYD3tdb/9Eauuhu?=
 =?us-ascii?Q?Vq6GqkxpR9GCVldQyJT2Vl73faGO4WB76eHahqWEoIRJK/ErdnSNBqomYDBP?=
 =?us-ascii?Q?M4y/4odFm7Ii3zHiEdGpU5qT6k7lNCvgzcU7nCh8rESwKesxg0P6A+S+XWqh?=
 =?us-ascii?Q?A+li6BU5ASoObqcO66iczVOB+lYVWqpYprtP/7rx9UNWhTM8SwzBWVSxz3fq?=
 =?us-ascii?Q?YXqu2RzqsaVtI0/S7XFiep1wzCjTcGyz4fcPgwtDImbKomPaQrf1MbYy+ktX?=
 =?us-ascii?Q?ca2t0jTwLPfg43HMjOQT1OeXOjYke+IH/bFyRwO8yGuuOAXv+vYWvLhMKYhg?=
 =?us-ascii?Q?8V3ohfsN7ZY4MLbfiAxsOrJRwQsgT44tssfgcI/NGckuwQs+HOBtjLQjxAE0?=
 =?us-ascii?Q?cyMwnQseiVVIpvl/u04sMoFgE+CL/GLGrUxEKtTJLEFQab2YhfexDhd8BW56?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?rs8j+yAD6nx5L8zyMr4AjuXJshoVYFhSXg/bYoCf5iLJwZ5i9d6beRzWnrMJ?=
 =?us-ascii?Q?Dn52xo4iBu1Jj/I4M8r8SqWI3wucBcP7BFdpjPMLC2jZB4xzax7AZojKoBMy?=
 =?us-ascii?Q?AVrhgJUDI8+rJ5qNH8Z4ZYezEbiDcu+C24TAFkAcj8iZ9q1HZe98cC6Q2IIV?=
 =?us-ascii?Q?NjrZmWuAyskDwRh8BP8CQWdXjEcnzHVHCnYY3u3YIj7Y9bbui/LC310sqUI/?=
 =?us-ascii?Q?BwKpsORiwgEwiTbhQ3Yd/YMJJVPfWDQ89RlTNuFeF/ltW5cXwRgx8pmG9Bkh?=
 =?us-ascii?Q?fZVNiVD0TbrLIlS/FbnO6Eg3LdkJpsnbS8poVrh/CZwQoBmwsjnFDD49WbQ/?=
 =?us-ascii?Q?0qww5+VK3PuyZyqb78+VEYqVakuh+stDBAV5mRWJ6beW29DJ3ffq+EO3zpd8?=
 =?us-ascii?Q?sIPG6/j6wzTYaZ8bfXdUYmHipAtYGZRNjbzeja/C33evVptBzO0SVvN9YSav?=
 =?us-ascii?Q?6/+37VbR6Nm6tf9NZ9ic2wrRzcfXaeV3j5Skqbi6OyxPYzV3clPzJ4Q6UMms?=
 =?us-ascii?Q?1tHs+/Bn3QZcxMCz9c4QNPP590nLELDME+jrX6Xh7c3WDCWxHGe+fQzJa5LP?=
 =?us-ascii?Q?H94p7E9nYNLc8XNgAAE3eVj0Dk8OKGOrQqVHFYsYj50qvVummwo/qwRbUIDW?=
 =?us-ascii?Q?VRT8a1WW/y+aXWtp1z68VBP4FBX9cB+GN/OONYrD7LCkuPQS7vcx5j9Hag+R?=
 =?us-ascii?Q?HpiSSzGHP/mKG0LrWMzPLJdk1EOfwUwZXiyLLzUMCeZ1As5q17m2oFw8r3tJ?=
 =?us-ascii?Q?D6wpsUAh293DrRYz6FjIAO4xRiLwF2fWDy4NyXUk2+N5czlh3Ndq4BwmY21+?=
 =?us-ascii?Q?pN+RI8R13ZXjP/TjDxdm0T/VW2pIjSmZQlL4wU068ou6hMP/30oXiZ5OsTgF?=
 =?us-ascii?Q?R+TB5qHHDW+hECvn/ztBe9nY1107mzbKkhlknbAacWybH7UdM0npVlD5RMtB?=
 =?us-ascii?Q?THjcFTuJPwlrKLdcnGhYNjsqZFSAszYCOwejRzF9Gor8tdqXq2YTExTAhxap?=
 =?us-ascii?Q?DIOso3x0mJR2G2fpFpBkD+kwBpI7oMqFyVJZ52a8RiyJBrexijmzrMWsj40p?=
 =?us-ascii?Q?T73b+JlbKgkrrP7nQjzHv3kGzDkYnyUhOblThcb3+uX4KvdFjx3ofbmXKS3u?=
 =?us-ascii?Q?eemSAOrAv24gNQcNnAOGb+450GAuAmmxuaXpvkd7VRvjCfjXSTgS7BYIfz/1?=
 =?us-ascii?Q?FQ8Ld1IbsWR7wHo3Yck4ydCg9M1XqdpTY7fuwgOPu+yn6sNSZJ8SgLV/q/PJ?=
 =?us-ascii?Q?vXdnk62ynVnh6WZZ6npw6IRyU07CxniRHUwcXSyYh/CX5heYpKt0keJox8IH?=
 =?us-ascii?Q?ny1JtjVmp6QKrhE4LJwyghIhr8QnrTVycNcoNWF1/aeHgKvXkYLCBXluGLrE?=
 =?us-ascii?Q?WX4DpvmjMYhUjy+XpwxpQcDMgfDL8d1rFPfSpouHgsXEqxA1tbn4x5TBqomx?=
 =?us-ascii?Q?HXFhhgRJE73wI/pq7IAQPbgeI6kRH8aSi2b5E7LYZ3fMBpTcKeWwTDeIL3Sf?=
 =?us-ascii?Q?GRbIfzUAkEwZxsuyu1LyXQGut2wPpkP4jB9udn6RgtZRPYAw7j6mFTDaEw?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e28f719d-bafc-4d63-146c-08dbea5b9c8b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 06:32:19.4253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tTvjSDAnzOwwU9mr9ebPBBWbKUgdXFSF4OsAe3WLA5BYd00TalT/ayjx1hrLsBLNfwr1sLHzP3BnOyJ5TlIcS3cl+GT6ZUDkp3O0y7KC0iE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6733
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_03,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311210049
X-Proofpoint-GUID: INORxKXbiNpDB28ErgchHM-WHnmop0ja
X-Proofpoint-ORIG-GUID: INORxKXbiNpDB28ErgchHM-WHnmop0ja
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

> On Tue, Nov 07, 2023 at 01:57:26PM -0800, Ankur Arora wrote:
>> While making up its mind about whether to reschedule a target
>> runqueue eagerly or lazily, resched_curr() needs to know if the
>> target is executing in the kernel or in userspace.
>>
>> Add ct_state_cpu().
>>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>
>> ---
>> Using context-tracking for this seems like overkill. Is there a better
>> way to achieve this? One problem with depending on user_enter() is that
>> it happens much too late for our purposes. From the scheduler's
>> point-of-view the exit state has effectively transitioned once the
>> task exits the exit_to_user_loop() so we will see stale state
>> while the task is done with exit_to_user_loop() but has not yet
>> executed user_enter().
>>
>> ---
>>  include/linux/context_tracking_state.h | 21 +++++++++++++++++++++
>>  kernel/Kconfig.preempt                 |  1 +
>>  2 files changed, 22 insertions(+)
>>
>> diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
>> index bbff5f7f8803..6a8f1c7ba105 100644
>> --- a/include/linux/context_tracking_state.h
>> +++ b/include/linux/context_tracking_state.h
>> @@ -53,6 +53,13 @@ static __always_inline int __ct_state(void)
>>  {
>>  	return raw_atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_STATE_MASK;
>>  }
>> +
>> +static __always_inline int __ct_state_cpu(int cpu)
>> +{
>> +	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
>> +
>> +	return atomic_read(&ct->state) & CT_STATE_MASK;
>> +}
>>  #endif
>>
>>  #ifdef CONFIG_CONTEXT_TRACKING_IDLE
>> @@ -139,6 +146,20 @@ static __always_inline int ct_state(void)
>>  	return ret;
>>  }
>>
>> +static __always_inline int ct_state_cpu(int cpu)
>> +{
>> +	int ret;
>> +
>> +	if (!context_tracking_enabled_cpu(cpu))
>> +		return CONTEXT_DISABLED;
>> +
>> +	preempt_disable();
>> +	ret = __ct_state_cpu(cpu);
>> +	preempt_enable();
>> +
>> +	return ret;
>> +}
>
> Those preempt_disable/enable are pointless.
>
> But this patch is problematic, you do *NOT* want to rely on context
> tracking. Context tracking adds atomics to the entry path, this is slow
> and even with CONFIG_CONTEXT_TRACKING it is disabled until you configure
> the NOHZ_FULL nonsense.

Yeah, I had missed the fact that even though the ct->state was updated
for both ct->active, !ct->active but the static branch was only enabled
with NOHZ_FULL.

Will drop.

--
ankur

Return-Path: <linux-kernel+bounces-62988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890AC85288A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65561C2373B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005D61755F;
	Tue, 13 Feb 2024 05:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QT18keuO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JQVixab4"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5DC15EA2
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803910; cv=fail; b=lbu6U6xHqxCPM5CMlEe2PD8qB2FWgzUx2Q+Gl7yJx6qZAXsobdkpLUQAaT6b/EeNJu16ph+d+T2SggiBpjhk3YGwIg/dxzjoEM2m44MKeU6ufAB77Gbk/yVG/1h3tDTnId3IE26WvCqoebtwA5veyft611PV2i4ZNGDCJCubFrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803910; c=relaxed/simple;
	bh=Hh7g7P3QkviaacmI8bsuKVGg/QOjNTgaUsSh4DIuSqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YqX11bPRU0Rg12R4pik4cypD0e1Pg2kIoHfeGEKEpW4FtN8cOLhK0cin3SQj0BPIz3KoqPsCTa1aW/IvIvLT7yypY5hn3SowCrH7+7myS0qSkO9zmPMwZuXOFTebjQWCp8wD163ZbXZN+J930PTHKjeJlj2APfX7un4dgJb/dD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QT18keuO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JQVixab4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D503mB000622;
	Tue, 13 Feb 2024 05:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=1gzu+2Xh2YBhraKNYVXIbFY8o0B8DJKjS8/hWnD2p+M=;
 b=QT18keuO82Aj3lX+zVQYXUNsa2n+7+ffNRhBtsXVB3BDpzkFnPqG08Vnp7r1xvRBl6tl
 RNGXDl0kWCoqk3c/SLCV8yUVN21jbQDlDwfAnlcHl5eqtnmuIp7M6l/vyOZ/dKBXW3BQ
 I2WOTbfiAJIg2X6pjChjMmCOiCWrl3n0Mjri3Ba9JRlg5bGHRL4JTtWFaO8Gi6naefV5
 lBTMrH5OhIjXmxbiGFSpoGE4OIJRyxyutXSPdeKFZFTNAsvXBxpS5wfmYYn5WZYYbFJX
 Da7OT5hAzl5EjNQbqhSkkv8+jERYwhk5VN8XuFj3yp7WuQB2W8fLUmvX4rAaq3I9oqVq BA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w81vm83a5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:57:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5QHSY013775;
	Tue, 13 Feb 2024 05:57:27 GMT
Received: from outbound.mail.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w6ap9gpxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:57:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZL3DlOrC26ntJOet7+3V1yzRKtft6mzNcJs+4NBFAUwZNq9LcJwFB0nJuo+b26NrFspHtddD25ywm4ye8OosyWIu0sQ9a+CtE8He1f42jnd9E2ShChhL1UxfW7EgG92tDgZCDiXEKUGkojASPg967iPr8QOmzkrcQxkdCcnXEpyWrhibzfuQnIms/NXFWhLijtDfTOj4ovKYnYFmexlgrLFe1XDUa2gnTYvpANeogUOBKeeLWE+vsU1ZmRWmDc5x3ePwLFVhpX9Aya+DkeN6iRvZ4ltdVbfqwYVtYT8MPtVyiSudPxPNyT7cGIHaethdomXGIfNokBZ2NfMO+258NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gzu+2Xh2YBhraKNYVXIbFY8o0B8DJKjS8/hWnD2p+M=;
 b=Q1Yej9TwzWOkrf+OlWfpufTMQJ9x9LLRi0NoSh688jXyRKeHV4IIHvS+VN+5MkmMHSjx7d8vN+v3jS++4w886qMdgkhwBzAEGi2TI33XbsixF3uKKglBpw3ilJuZGj8zVKy7WTqndbrslFuotZvXggg19mrQoxvsj8DGkpYo8ODYBHD28qVqBhCul0JF5aQv3vQsnqzb9O9xCEdCJ27ZFIXT5nXCrXLL5H4x0WjkIWitIwJHTn1dwWLvS3dEh2X3OshdKqldnvqdPbW1wWMmhQmfP5yXCkMjsW19FNHauAJXGvfFmqLvTLIK62jpmJLksS58u3FqDXhDiJp8dOGjvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gzu+2Xh2YBhraKNYVXIbFY8o0B8DJKjS8/hWnD2p+M=;
 b=JQVixab4MviVW41RCfQrMbGR7rmpgplKmHM/9Iiwgp4xhlbyEg12cyWlpDYm4oW3hiUHzmQKj8R3Oe++tPdwgOgVme9cDv1O7dXO0TpXhkczvnlHi7SHeXQkwsvBvAca4/T9OW1hAAsMydm2Oj4QdsXbTD890VX4A+MT7JsOdLg=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW4PR10MB6533.namprd10.prod.outlook.com (2603:10b6:303:21b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.32; Tue, 13 Feb
 2024 05:57:24 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:57:24 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
        mark.rutland@arm.com, jgross@suse.com, andrew.cooper3@citrix.com,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 29/30] Documentation: tracing: add TIF_NEED_RESCHED_LAZY
Date: Mon, 12 Feb 2024 21:55:53 -0800
Message-Id: <20240213055554.1802415-30-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0177.namprd03.prod.outlook.com
 (2603:10b6:303:8d::32) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW4PR10MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b7bbc1f-26b3-4622-75d7-08dc2c58a66a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pj4Dbc/s50EIdSYxxBlH0G7qSNx/kofliQl4lmqqsGpiBU5s7WFwvO2qkVOw4M849iP1g/bvumC/m6QWE+NjLxDscpDhYgdUmrczSkEV+LVoWwF4PwIizAuQ6Uq6vY+YptGxx63cxPhgwip3PMspJblF+4wM8Fo+Ykh6L7pk1VwW+oumJ2ZNJHdvvcNIaeWvirha8oc8Mu/Pa15FFTemwAX7b6wzyDq+riAkRKjZg/9mJdJ8Uw6bMhSsMKICsIr+OWmoihiR9FZUwXcqwG7v0FXmyL3ymr23dP0eduH+jOtr725HEb/zTHFJAodjOJCWGp8P8XUhODemRy6A43tYy/k1HecV6FQby+7zU3eYZgK+DGEuOdHnWfLjpnBk70j2CreAJqhMGlGbhxIDeYmOl3IJvs+lly4R8NhhFcunANadxdVLMtqa/+xvoWBgsaVGAq2RuHyIdP/UFngFXw2p7RMit6uVKMwz8EmgSVGSMXv1xMO2oE9FgFIxgLYiLRaQwCV9CVW+FfY0FlIv79nL5tt8vE0cdJAixDIsUuauCTE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(396003)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(7416002)(2906002)(66476007)(7406005)(8936002)(66556008)(4326008)(8676002)(5660300002)(66946007)(86362001)(103116003)(36756003)(38100700002)(6486002)(478600001)(6666004)(6506007)(966005)(316002)(54906003)(83380400001)(6512007)(41300700001)(2616005)(1076003)(26005)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TZrf0EvXLm7y3QZo/8N75mbtRYGQ2wheZTJDBJRtwIqi9yygF2Syk5mNWKrk?=
 =?us-ascii?Q?0X5JewftGLyaSRbBge9LJCyIc/u5XFMYLlmrL4KGvSmQAq6C6YcxkgJZtLk1?=
 =?us-ascii?Q?zckUArNlORPdVyTo+fSeGaQ0gh+Lcugzy6xUDS8zyChFlOHs7D9mF/LTlPtA?=
 =?us-ascii?Q?lopZihvefPtUqBKQKOoOyw95AcHVg2cCRtV9UvJElGCA/fsGjNlBKpPt5WAT?=
 =?us-ascii?Q?fZLFaD47xfLS0XRGQA17t/e7i1F5k9hN0NUSOw0PS5ErbJ/dAJjmYmNA0GJ2?=
 =?us-ascii?Q?BWgXwpr0v/8GnMGy4cCmmAvJRTN+xGdmZgsQ3kD1GDSZQXe4x9luMK7v3fIE?=
 =?us-ascii?Q?aiAMjbtKxDT1BjpDZ1ggz6IqCLZj/EjCo3ICKTO96PPKzbYBpGO8HlFoSxeN?=
 =?us-ascii?Q?gf/TQadJ2EcgWXVgNDf3pxmIiblZ+XcUoZhVEAWHWvwkQEEdLBvc4Q/MbnxP?=
 =?us-ascii?Q?IFKQBE4TRFudE/DZR0dJKJwY5e6nDXpHbLhqK7Ah1QYpz9Rq6BD1F80U6b+n?=
 =?us-ascii?Q?EW3meCkVvE3x4E0vlWYP2Ym8P8VBNjXY4w2mCKbfN3JYmeVCdpHKbVFBwNzA?=
 =?us-ascii?Q?eLvtDtdF2hait8wkPsiFdrrVCSVCZwE4Q/74YnZ/A3KH82Oom6IccxO6q+yA?=
 =?us-ascii?Q?dtw8sFfJyJiPkT7YyAWtBa0np6emVxdDXK5+qpxci+66a6OWeGJGn2XxzGlE?=
 =?us-ascii?Q?OVBfE7kOnh2NKsVg02C+bZQBN24GaWEKmtir9BBrjC0B1IvNK7tIKd970S7V?=
 =?us-ascii?Q?ntmqo0z10A+SEhUEjf5Oy5NRF9heQajdVQkYpPZyAjioHNWJ9NY1H8kc4Pb1?=
 =?us-ascii?Q?YxlHOC25fkK3eAYCBCh7uKe6f45dErdyNFz3icmqeP8DGjFvuCu/ncL/dKoh?=
 =?us-ascii?Q?3QOaxZM4vYhDpXXEfC6av4YeEDjvoK/ka2OIoMfoCdk77niysq4Rua4dEPwR?=
 =?us-ascii?Q?EWtrGmvJ/7QvziFGQfAW6uPEjasjWRoKYrhzYpr8sdBlA6La/76udYpnBSgO?=
 =?us-ascii?Q?yhrjupBJyBqjXDP6ql8GthrE57ehrZw5IxSESq2W3jVaYOi1S6Vl03qgVrRm?=
 =?us-ascii?Q?jewbChPwmfVRcfJ6CZ8qZl4dAtoW215oW0nqmTHF/E2dpwWdAhW9SDaQD9ik?=
 =?us-ascii?Q?V08onQkXs3xIYpwjTEGaxEl6RWHhh0y6lWrwr0lbvDCuFYn/KmBil6bERHHi?=
 =?us-ascii?Q?pErDadZ8jFuzXgwtNC9vr4QLiFzf/irapSitJ1xthcced0AvFXT0Q4naR/q2?=
 =?us-ascii?Q?t7c9GwwQIztZsOO3e09Y34rubabpjWV8n61hVkK2PjJIbnUspzbBg66tBWlj?=
 =?us-ascii?Q?xpBL+3+WQljc/5m1fZewKeVqhwfk/VIqwx2FJvox/Iwvgl1KYGwGhxiAkBWJ?=
 =?us-ascii?Q?w5r0go19krSCx2y6+B5Rk8ROoUObGGTR+YYmEaI5mA6fkr3FSVOWGDsiTHcb?=
 =?us-ascii?Q?qonudPCw17WtQO/mKw//8NJCA7QYv/piH+hfvt8ifNMDVVVIiAoJu9nRmoXg?=
 =?us-ascii?Q?9aE++6fNDf8Ha36XH6OCg7L+fM6NNwEzFR0DBxJbeHhtfEVSXUhDZqaOz2/o?=
 =?us-ascii?Q?gVHLiiobAIaIlYAGeodrtROw3coO0OPkb/CW+Efj3+aINiAK+KRCqclfELOM?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZBPDhbN/YMpX7p/npeQhnMfBrbexS+Ap6uZ+tah2j1xBZ30zC4k4freu1/AhxDeKVmpEXmKOXELImICFVZxyh7+5JCQWXu+PxytNZoAznd8U4QQVWDN49sOWiVikqqmGO/i+8RBcO/yKo2I+Fpe5ckOcQZdDlqIw4VKUkKQkW2gWXEzT+CFQNEXhmMT0xrs398ttUrsdtwwuqQk2wEjFbYi+HgE84zzmraRxOn4j6dPpkVPokAf/IeSgMus4RzGWtonsbO7KRPDeqMDj6ArXb2LoMe2WBdiFEaRL/4mU+rA8E1UAyzE8Aui0pCXAlDVRAgiDM9KwUbAQO9uPso3Xqsn20lul/BsSGEKYGKwikAKZHq6Xcu0ZAy1/QNyaqiTmZJE6D/h4JQTstmoAqsgyS35RSEJgDOzzbsrYNlNcmUIwHHdOQcbygwe54l/azL5BiAV3CkZtxNIl9pksSIM91guJKPS3hiOKBdCajf7yXtd6UedPvjEjsfQK0nQYe5ULMxGgeKfiFA6xhPwZMxm99JQPWzNT/TLuiIz802JA84z+OcTL4nqvwYukpeOdZxll1DjVhyoU09XQmb/y/z0StfbUafcX8iJxvR58pSKaVDM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7bbc1f-26b3-4622-75d7-08dc2c58a66a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:57:24.1526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQWyrluQLfoIJh/iLxZlNyLv4TsBs5xULm0NRdhAtrFrmlxda7OCjJFi5QGTAEmMBIg9MvSRoV56kC0CzvNVaZcyiOMkL32qBZeTBOkX8MI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6533
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=762 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130043
X-Proofpoint-GUID: ABa53rnHVsNa9P3CQUJK6M0iaJwDRILq
X-Proofpoint-ORIG-GUID: ABa53rnHVsNa9P3CQUJK6M0iaJwDRILq

Document various combinations of resched flags.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 Documentation/trace/ftrace.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 7e7b8ec17934..7f20c0bae009 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1036,8 +1036,12 @@ explains which is which.
 		be printed here.
 
   need-resched:
-	- 'N' both TIF_NEED_RESCHED and PREEMPT_NEED_RESCHED is set,
+	- 'B' all three, TIF_NEED_RESCHED, TIF_NEED_RESCHED_LAZY and PREEMPT_NEED_RESCHED are set,
+	- 'N' both TIF_NEED_RESCHED and PREEMPT_NEED_RESCHED are set,
+	- 'L' both TIF_NEED_RESCHED_LAZY and PREEMPT_NEED_RESCHED are set,
+	- 'b' both TIF_NEED_RESCHED and TIF_NEED_RESCHED_LAZY are set,
 	- 'n' only TIF_NEED_RESCHED is set,
+	- 'l' only TIF_NEED_RESCHED_LAZY is set,
 	- 'p' only PREEMPT_NEED_RESCHED is set,
 	- '.' otherwise.
 
-- 
2.31.1



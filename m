Return-Path: <linux-kernel+bounces-62982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 282D9852883
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9280B1F24D65
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08B242066;
	Tue, 13 Feb 2024 05:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qf2sXnb5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pxKuNoSp"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B553B290
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803863; cv=fail; b=P+vgoo3wZeuJSSS+9l4eaFrJ7qSrXQ7H1M7rG3VuuA9G4RdvBcn+GN+lAz80B5LFKRJiJcT2rESJ4cT1P4u79WNDofSOzfsig37oe1neUE/57EHjNV3AZrRZgMkte6dEqHxCQ63pNLTtoHyGWWRvcfHffHD+4TEaHHT5sxyyOTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803863; c=relaxed/simple;
	bh=wo6GlQe+fRdKnWucgtncVQ/AxrfSTxoZxHao/cBgfuk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JMa/D1n4J3BoLbCHgvuUryuTAjnuLRQG2PFv5NNXumIkNhrTSqPgrb5tevsJQSAC6bSAynH/SkbHbj0ToOAUYVgNrCz0awq6IIH+yBsQ8Aq5TW3dmjt12xd0hJ+S0px0bjhHwZzfELdnrDG7HNHXpmTVG3HhXgb5FlvosH4dxvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qf2sXnb5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pxKuNoSp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5nC7O013768;
	Tue, 13 Feb 2024 05:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=2iwGN19TdbWEak2p/YVPf2El8bxLr84wbWeeHyyM05g=;
 b=Qf2sXnb5EyAeDNCAWcVAKtIIWYB82A9abeY+9Q6qQmBSUyuAkVLklNEcBL7MQWky9Tux
 nUFkDEgFQyDTdYrYxktk320r2UNfWLDJ9C/og9cAR4y+35cXCyL4sVaquMLEWRTcF2PF
 9BKtQR9bD1mJSYIdLb/BY5e4PXScF/j+oX5AoM4m0pUcFwigj6XB2byhP5CZsQKRihAh
 Ya9sop1y4v8zBSCJvsW09EjxF7oErS112rV/ZxIGNNV0X+f1o8Mq18IUjPtGHRJWV81x
 6Tc+8/DjoKPcAmh/9wX/tON546xRc/XmroDA0SQ+VT2ePm6jwQgoKUzomxdkdn+XPZg/ ZA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w816tg4ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5cLmh031604;
	Tue, 13 Feb 2024 05:56:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk6twk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAGznIBtIX+nujt7dZYvv8obm6cNXTydgs9xeOu5qRNx9tNPXJ8Kn2vpaE0VTikADUHcfuEl17yLIhd/rp1Wzp1BEnJbFC6Waq6Gla06onE3H0IWQE0pLvkuE4szsbNN/RvyV/lmT0Kk0HF+jpoPPQYCDpZ7iLTzryRzXCTvZ7QzMuBu+9k5dQdAmdepDvztC88HS0YBS7fYr+JP7CTtY6DYBGMg6uVJ9L3n68rFUB0JE0gwk09nCtDUUYg4dRgXxuOcU47qMx/zX0gSc73L/lcMiVulilv3FmQkVl+0NtOfXp7N1OIGd8D6gG0vD1zf4OVL4L/fZeMp6KDIfj2dRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2iwGN19TdbWEak2p/YVPf2El8bxLr84wbWeeHyyM05g=;
 b=fif3qHsJitt7+QzVFNqATH9d/IQuQemDFlOsAs37byujnsO7B017WOITYnA1mYhkNKGBGyxwWQu0NuQXXwA7RJOCaHZ40suRp4HL2JEP1lUIysUtmnkGl4fuCN8doeE71ATJCOPEHMdc3ukMiXlTiEksuZwhJ/ZCGfXb85smZbEiu0AowizeiedEtmrwBzAwdFbCn63wo3Jlwr0d+Fs5Z5yh+dIA08TK16vQ6WElJMUpomFlIIzccgn9cYcI7n3Zhmq4qHxexdDEU82NLP6fxpV8Zes7mj49d5HAn+/5fr4QQzlla59IaZIzS3JFavE6/zZJdKf4oDzyl2hpk8CjoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iwGN19TdbWEak2p/YVPf2El8bxLr84wbWeeHyyM05g=;
 b=pxKuNoSpa2hGSZuQhPZOCIcb0at2didyHpXW1eTsJi3rz5JVJVHFfnMGCJVQQNpkza6UAq33wGEKDyX3HeWkyXaRt6LByAlq3jqXKD710cpq1y4WJ0/08cozOoAoTl6m0Kxhmcrldja8z8xPuT51paEvyp/nxV37inyUu4sZRQs=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB6906.namprd10.prod.outlook.com (2603:10b6:930:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 05:56:40 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:56:40 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH 23/30] sched/fair: handle tick expiry under lazy preemption
Date: Mon, 12 Feb 2024 21:55:47 -0800
Message-Id: <20240213055554.1802415-24-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:303:8d::6) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: 21ad92d1-6259-4387-0160-08dc2c588c9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+lHfsbbYnrduRU6cRj8Ihf5pK2UPIBPqYOANQ27bfIIMmIMQTwmPxZYeEiZpj4Ixe29VlwdaC0GykqHiJgKJqDU/s/0wKaXqzDQLAF8q6wl67aL16VyJd7S7XfWSGHvanuZTuCrGJw3dDhyrsIOUR7PbG0w+AGIiH9k68+eTYejnmyYUNEIxYInBC1HATqQJDfvhoalKdHr8CaBvJAyy4shiDIU2EFU2ZmboqTOSe7bBsZGUgz8FV4zyL866Li7qoC3QvJYQsL3ImPDpv3vMZGFpplf0C4hHejccfuKQklZScAvdqOpUrgGSzKbobmsQkU0CRDmiBJmEgts/9q/pR+zKteZDS5Av9+RrA9NAlmH/7W0EzSXLkKXPwSKu/AN8d3qqQ8l8dGbBh8S5ivNGaVkUdACgi93/wPh4V3dVKRaN6CHOhhvPIG8JIf/oJ56LwPo1vSQBzgLx1uy5+GZughbK/98iBJYB+kcFX+tL9LKp9YK4Q5k7j1ubEIXy6tBXv+bt95ghLJosML/awv5NLb+hL+EMPhvcqAYke/REEEg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(2906002)(5660300002)(66476007)(66556008)(66946007)(8936002)(8676002)(7416002)(7406005)(6916009)(4326008)(86362001)(41300700001)(1076003)(26005)(107886003)(2616005)(36756003)(83380400001)(316002)(6506007)(6486002)(966005)(6512007)(103116003)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DxsEqEqIk9CiFL65mDfVKA+SQz1tYjD/0M8kcgoFOA6FfsrmkMzq/6VYaPtz?=
 =?us-ascii?Q?Rdom6hYNnAk0GKU/KzfQ0TBL45j24DMke2w/xekMJVfvEJMMrYn487VR0Ikf?=
 =?us-ascii?Q?NL5EcF3haBx9YTXH2Di/WLAKVQ46JiV+MZuwLBX5dQlbQx8uGPGUpcFL1KYf?=
 =?us-ascii?Q?FXk57Ns70OJVBmqvjFGCjFo3zbD9rm7HY+2x2UNZe0sAmpfkWAoY5E11u7xi?=
 =?us-ascii?Q?uzRQL3pjs9kV7uonQ/t0sO8g0zTOU010bo06f/ECCO0UVUSkA6QP+JAJiD3Q?=
 =?us-ascii?Q?kOz8edFUJ7kbT6eAjG3QvJZAZGBaJSmfjWr0qhuhA6b0HxaO3plcOsRs8Ind?=
 =?us-ascii?Q?yu8i3m9IeIqqJ8rCFGs79TI4iBW8gwuDrQzfEVW065clt/kWRBBUPaY+Fr/x?=
 =?us-ascii?Q?skc0H+D29FPCIH1o+qpFu0JRGxdN2RBOmIvSoMq/tvQe2prbemYnsKL6LMMK?=
 =?us-ascii?Q?WkQ/fKCT4afQNkmjO1tGknK9spvuW6Te1b4nfcXbgkUsvg08S+aLWVgxU8II?=
 =?us-ascii?Q?6QWZmAH9Gkf7aWIupBD/Qe3Go81QsjCwU9g2xrFeEbAn58+Z89oE5ONJjWoG?=
 =?us-ascii?Q?c9JPs6oTSbix0IEdQ6gEoREC2mYbVzg+2ZiYTkKjWF8u3GX7k+arjGePZm3Y?=
 =?us-ascii?Q?4kE444fCg7Fsu9fD5yWaU4WQWCX218edQ9Nkldq9x6b8Zho8TxeM6/LvG6sg?=
 =?us-ascii?Q?HL2w2p/eJDyfak9M/X8lbxSeJVFG0+ejOa26YGa7bTXSFcHEXtt88CNGXM14?=
 =?us-ascii?Q?n6l4aYcyHGhC7f+4p4NLXGQvxyPS4+DypLJuVxhXmxh94G2HlZlyqVnv0r+h?=
 =?us-ascii?Q?8WM1vXpC0YzlLgV4u6JIAtGeNKUpKUoLL8MqUtHr6cT9lozJZfo1bx6Q/VcO?=
 =?us-ascii?Q?acAUWcLFvOcRc2C/ol+dx7dZG7e7j0OZ2KXIMDkCeijn5wcQeBLaIm7PABZV?=
 =?us-ascii?Q?ZN9L1zRjAZjPf/cLJKrvUzvcZ3F/JDICwdh+UCiyRgWCDhfhl3Eq5aBrmcV0?=
 =?us-ascii?Q?fgemRygn6V/vP3tCuIXBybR0MNL5H1e5Q6CqL3Nm2S/LaWdPV8SeA0kpPHkC?=
 =?us-ascii?Q?IDgsItkSMEmNFqmJLcrNNAjFDFZfs9xfUY0AZ0F0ieTGOtex6ONqGuUEub9a?=
 =?us-ascii?Q?+cGS1INUrO+5V/hSKAzHRC6Ej9HAUwoJi6uLpkU/MrM6pwRWRGIwmvVBZWKL?=
 =?us-ascii?Q?klZsOyxTNTDoqjEGLikACIdjqdSnzt0TS3vDZtxBSHOr1UTS4wjXLYDa93Fw?=
 =?us-ascii?Q?XiY//sdGvaAvw/ciZrfi5EwR6sQ0wIbrlniCzoHyrIHRz4ZDJ2EqFMSjCkN8?=
 =?us-ascii?Q?ARqya3X6XYAd0py5Lb3Iu9yBWxP/woTsGsOTg1uYmMvJw4zoaWn5ZcEexK6N?=
 =?us-ascii?Q?rzWqdvaJso46cMwMVmxG5kl91sGsCeQRK05EGw7t9dY6wCE9vOOalGoAx1ru?=
 =?us-ascii?Q?cJLY6/pIvAPFqHUnL+2/s2KClx57p5T5CsEUqLco4w+dEYzyjysjVWgv0NDe?=
 =?us-ascii?Q?/mIhqxZ1O2u4C4qm3Vq55TqCPywcqI8GLyGnToSx4H+1fhtl7qFPYtJcFDdM?=
 =?us-ascii?Q?VnFLJg4tX1nnCTAx/v+1+m4+IPHy9gvFGNwAMOOUibHNdbCjO6RXYu95MfmC?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aj0et3LZ0UTuw/dhA+geDfJQOXmwmY4878wmHWw0hVt1AV7/yb5+ROrFnPjjl8mDOHStRELzIP4nKfcA74zqrtjVzXMqH1sC4KpT14OzHeIFRRBoup3pFxQRl3ZAy4RLy73jiQLslc+nbm1AUWq4MX2dTRRmXxBVGSFqQeICU/5Lh7pUzOpDr8mOkAc0CMCjRqm7b711+WyT2rIcSF6s8hLNe14a07JsZx9W0LkN8lUAirAqCJtRk4rI539Z8G8vRQyNoyD+bnmPApWePzjud3IryWAsWYv+R2d7/R+Z5uTqehvXLsTinufo2ZbAu6ywKbUig+a8VGsiKWbUmGlWke5L2/+RhujPbNdZRmaeBEeGFKWWPkAe060VYWeyG28J3hHqt5iKg38weIE/0m81I3I4wGqiZyUJ/ahzHzYB5p64wxBItfVMskdpApcwecePOpUiEAsYZ0ZHzyBe2bsdyVnl3zPZUP9OvipZsC/HbKGjLt0q2zAm0qAZ3n/H+B2fdLsaq6Ak9DyiHBCvrNNWfoA61Ni6aoFpyYXvk61Yd/w2o3VZmvIqKJOQu8k/2K8zGX7dvn8jusvMrhYMf66easEiO03l5Vmkpn5jU6XaCJ8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ad92d1-6259-4387-0160-08dc2c588c9b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:56:40.8677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uz/+7iWBVy1M8V+sSv/bs4VZnFn1K/zWJ24NNgwLyj8PNwGFH3AW84Cpsel7G0IPfnXdZWJMp1zbP+dzot6QB4lKG1tbu31Jby0WDZrXrr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6906
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130043
X-Proofpoint-GUID: am0ulBMsYDuITzzGysj9mPcae3IDlBxw
X-Proofpoint-ORIG-GUID: am0ulBMsYDuITzzGysj9mPcae3IDlBxw

The default policy for lazy scheduling is to schedule in exit-to-user,
assuming that would happen within the remaining time quanta of the
task.

However, that runs into the 'hog' problem -- the target task might
be running in the kernel and might not relinquish CPU on its own.

Handle that by upgrading the ignored tif_resched(NR_lazy) bit to
tif_resched(NR_now) at the next tick.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

---
Note:
  Instead of special casing the tick, it might be simpler to always
  do the upgrade on the second resched_curr().

  The theoretical problem with doing that is that the current
  approach deterministically provides a well-defined extra unit of
  time. Going with a second resched_curr() might mean that the
  amount of extra time the task gets depends on the vagaries of
  the incoming resched_curr() (which is fine if it's mostly from
  the tick; not fine if we could get it due to other reasons.)

  Practically, both performed equally well in my tests.

  Thoughts?

 kernel/sched/core.c     | 8 ++++++++
 kernel/sched/deadline.c | 2 +-
 kernel/sched/fair.c     | 2 +-
 kernel/sched/rt.c       | 2 +-
 kernel/sched/sched.h    | 6 ++++++
 5 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index de963e8e2bee..5df59a4548dc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1038,6 +1038,10 @@ void wake_up_q(struct wake_q_head *head)
  * For PREEMPT_AUTO: schedule idle threads eagerly, allow everything
  * else, whether running in user or kernel context, to finish its time
  * quanta, and mark for rescheduling at the next exit to user.
+ *
+ * Note: to avoid the hog problem, where the user does not relinquish
+ * CPU even after its time quanta has expired, upgrade lazy to eager
+ * on the second tick.
  */
 static resched_t resched_opt_translate(struct task_struct *curr,
 				       enum resched_opt opt)
@@ -1051,6 +1055,10 @@ static resched_t resched_opt_translate(struct task_struct *curr,
 	if (is_idle_task(curr))
 		return NR_now;
 
+	if (opt == RESCHED_TICK &&
+	    unlikely(test_tsk_need_resched(curr, NR_lazy)))
+		return NR_now;
+
 	return NR_lazy;
 }
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index b4e68cfc3c3a..b935e634fbf8 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1379,7 +1379,7 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 		}
 
 		if (!is_leftmost(dl_se, &rq->dl))
-			resched_curr(rq);
+			resched_curr_tick(rq);
 	}
 
 	/*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 278eebe6656a..92910b721adb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12621,7 +12621,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 	}
 
 	if (resched)
-		resched_curr(rq);
+		resched_curr_tick(rq);
 
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index c57cc8427a57..1a2f3524d0eb 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1023,7 +1023,7 @@ static void update_curr_rt(struct rq *rq)
 			rt_rq->rt_time += delta_exec;
 			exceeded = sched_rt_runtime_exceeded(rt_rq);
 			if (exceeded)
-				resched_curr(rq);
+				resched_curr_tick(rq);
 			raw_spin_unlock(&rt_rq->rt_runtime_lock);
 			if (exceeded)
 				do_start_rt_bandwidth(sched_rt_bandwidth(rt_rq));
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3600a8673d08..c7e7acab1022 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2465,6 +2465,7 @@ extern void reweight_task(struct task_struct *p, int prio);
 enum resched_opt {
 	RESCHED_DEFAULT,
 	RESCHED_FORCE,
+	RESCHED_TICK,
 };
 
 extern void __resched_curr(struct rq *rq, enum resched_opt opt);
@@ -2474,6 +2475,11 @@ static inline void resched_curr(struct rq *rq)
 	__resched_curr(rq, RESCHED_DEFAULT);
 }
 
+static inline void resched_curr_tick(struct rq *rq)
+{
+	__resched_curr(rq, RESCHED_TICK);
+}
+
 extern void resched_cpu(int cpu);
 
 extern struct rt_bandwidth def_rt_bandwidth;
-- 
2.31.1



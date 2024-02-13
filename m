Return-Path: <linux-kernel+bounces-62987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F9C852889
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96F31C237EA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9C714284;
	Tue, 13 Feb 2024 05:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aNuN8AYI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="divfJC/h"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F22E1401E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803904; cv=fail; b=oDWXlEOYJHftY2tyU0anVPqcAU8CThQVea7dSI8hj1y0E1m/5zQCfx6BZcqUOiC6fy9LDZNVCxAzMrBmDdqM0On2pqd9sDBkAHWuPavUygJD+ntDoP7Pmlklbu+0uh8F7/AXDfZDJATlstEcNdxILDhqe0wmaYtCrqQ5zS5cHF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803904; c=relaxed/simple;
	bh=VMkEFwCUYdfN30GB7Gfq311dRmUkjGK9iGLckSrn97I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jt1Lw6yq0DSdJyzERmw26RnMY3DfIG+QXlMVpsVU9yC41XoXJvLkm+mD93MindnJ8gLQa1O5QCcWUF1Ew95qHPpOwYRodROB10TBnl1/g75zwoywk8eZyRGnRxRJzTSh+nwXansudA4b1udjuHmXYDwC5QSC6adGZ43WiJw9ffo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aNuN8AYI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=divfJC/h; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D503mD000622;
	Tue, 13 Feb 2024 05:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=kMw/WFtoqiI/n/zOwO4wSzAXSx4Y9p7q9wdCPvVW994=;
 b=aNuN8AYIw3eDXzv0EjIKTPXCam8MOdefHD0yJPnCT7s0g7mfk5pop9mZIr/G7CZRWl5x
 N0TGdJtEbOpEgGA8GN1E8zXJTQ5EA9W5ndYPYSsjMvFO3I27nPIBMpbD8d+1BOP1MeYe
 NCZ/vXleHhX30WZA7qTnTzirITqnFBAjlHwqCoUte9FT980FRyf7qIGhXnHPEb43QTQ9
 /kmJb7fTM9wdRrVfIOwIwjP3GXxHFa7AizIgZeJGRGWs5XSXpI/+kDKDB9h6p1rnggF9
 E/l/677P8HgzU79sD7qVGXDyxkfLe44yH3+PKsWk6hWUALB7EFkkc2kt7s4nc2/6S3CV 3g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w81vm83ae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:57:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D4hSmG013763;
	Tue, 13 Feb 2024 05:57:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w6ap9gq0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:57:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+hP+t/ta0Z5HMt5ieoY29iQv3kvHObDGUbZKxx2W5OJCEIR2++bTWqsrNdAUU/y2X+yXcUOekejpAjPyO365G9YYhyUnoTjmQJaaQtcCfQkm7CugwK/aC/MHjVwcmK76OXuvpHqc1o2ntHPWicjAB1/ElZr34clERVl3k0/yYE2pOYgxJP/t3875bymnA/g1KX0ZYbBmqVW5oqnyc/xRZQrx97j5GUTmSmR9nttx5kT1c2LeKeHw1bQGDZdPPwhpUPsPqXAf2NdksHz2kOZTFrRHb7AM2MI/OxetR6DXQUHKweSzvylarhRPhEyJZbDbP5qc/z2qsYS6Khf28C7Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMw/WFtoqiI/n/zOwO4wSzAXSx4Y9p7q9wdCPvVW994=;
 b=fn1lmBM05MkiQCPlHnOB96M3FNNzYfhPcrJApe2aqkiIu2RF19AUixur1Rp5yJHALTWylQCfVjK/QTLWZ/2Z0FhvsxmjFN2YdiBHgbkHB5xkIzWel0mohVpsLMTNIPHCQOfV1ZNSb9YJoZYAfUXABez58rNQb838jtZ023XaVVaeEjI0XV9du6aPzbNIHnyL3/sQU3bqgYGoBsQBDTGA4iY4DjjjNnfM/wBRZkj0rim//V/QalLYs+iErzzTkc60tpMqBqGupcafq786WuN+yLbI9xLgkmm1V8CzCugGwZu3Oi1qvfDhOgReoPJwN+A9jN+p+1Rdz8zIVQt1TBj42A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMw/WFtoqiI/n/zOwO4wSzAXSx4Y9p7q9wdCPvVW994=;
 b=divfJC/hSgpLQTC8N/M+l3sQ5/FhbRqZ4E81PkDSiawPQCQK/Yd+oXJ08aAc0cKjI804NaloIJIqMRRuFV7mCwFm1UtpglqgwkjVYu1BY8cFId5//qBamp40DH0RLxUCvibisTIfpRp2NwiA1F67fMSRnTGAueqQA0fO2qZako4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW4PR10MB6533.namprd10.prod.outlook.com (2603:10b6:303:21b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.32; Tue, 13 Feb
 2024 05:57:29 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:57:29 +0000
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
Subject: [PATCH 30/30] osnoise: handle quiescent states for PREEMPT_RCU=n, PREEMPTION=y
Date: Mon, 12 Feb 2024 21:55:54 -0800
Message-Id: <20240213055554.1802415-31-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0111.namprd03.prod.outlook.com
 (2603:10b6:303:b7::26) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW4PR10MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: 73debee4-726d-4864-19d4-08dc2c58a976
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GRrwfrLXNwvhUR6rAtpfea6YAz/SZjcimxseOTj3JMy+jItWecz97e8IHaYK7fDvaM5oCKh5u+tK1VWJ9jGKIZ8s4xGfANvZ4UdfMXtOcndsL2nx2UelCMdb8Rp5hb0FNR+DMOsVQi1Yl/DzbhfjyjSMTKxj+ROOJ/eRiWTg/3I46tYy01ZWHi7dP6agKoky3Lpw/lOrOizHHx3cIV5jfcjw1M4eP+x3OuSrmmVeeKM9TWPgZDsWmCGCQq3uWHcY4+JAVwF3a6bgJO2xp3cwmSQqUN+CcUt3R83UTt3DQj1yK6WQqVPJYifZ/DqtGBomZktxDKC0yGyESkqaGpgdS2Da/gte2/PLXFJyuNf+5Au/dm6ofziOys+ufgoUJjhiqKkTfiqSX9wJ0cqhu81TvYPsItoEWocjtA/hNHvvmCClAki0M7rbn4OeGmDItcC9d7+O2yC7T+7LWZzDS0KPd/rq5MW/cMMAvXJErCUJ1lZ0ADRcyeR89iNzYou/VtET3sCGL/wupiKyd8WuLj8X+BxAY/D71W0fOeFN0XDVrprXsEpjjYNti/YXPMOLUO5i
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(396003)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(7416002)(2906002)(66476007)(7406005)(8936002)(66556008)(4326008)(8676002)(5660300002)(66946007)(107886003)(86362001)(103116003)(36756003)(38100700002)(6486002)(478600001)(6666004)(6506007)(316002)(83380400001)(6512007)(41300700001)(2616005)(1076003)(26005)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ER5dELVe2W0RwnrUBRDi3fCx2MsL99JHRxHQASaibRPU3ufNJhnD6nYCMvhv?=
 =?us-ascii?Q?Su0UeNtmflov82EyFOB164VGppiv5Vw4rfknPj6neDaxAnQaleX4kqTt/IlG?=
 =?us-ascii?Q?E9DwvpP9Wp9r/kj3QRfAjDHNPSK1Pl4DBHqRRNzz6amT/rwE8ziRO19VZ+vE?=
 =?us-ascii?Q?vXvdexP73bknNc7S4sFTfwkUUP4NK2WBYIUKLg2cViELYNIjddhrG1CQH0mG?=
 =?us-ascii?Q?TNp4maUB+w+Ip6IZXzxxnMNUcbEoAZz0Y9MKfg2cX8dccq9Yrj0FCq2lOE04?=
 =?us-ascii?Q?UJXH6Ahu2BGoOTvk5J9cZNmbh4ffvhMC/Q+IkB5cUtolKykHqzv+YYDaRJt0?=
 =?us-ascii?Q?aicx+bEDNef42PTPbomklvGOMxcBYbj8bg/fQgcSlUzdHKE56zXZfx8TzS6u?=
 =?us-ascii?Q?B0I7+UazOvv7emd6H5dW87MClRhOvdDGkOBW7HLGgJtU40v1dylBCYAkpxBY?=
 =?us-ascii?Q?6qOHvT0YcRKZF/h4H/lPTNNss/xWRqSADVEUPREsGjU7j1xs0NZ44mOuEpgU?=
 =?us-ascii?Q?jNYYzCZ7rt9pmJPX9MDql1h1aQmSNBFi0xcdj9WIn/mzEfwkEl8t09aJTu/A?=
 =?us-ascii?Q?FgW4L0UozrvtvlKJBVgVeOBGZmKKyMVUQlWZszQigPDcPfLGUVsJL1KyZZm3?=
 =?us-ascii?Q?0Hk/lWuOWpsfjm85GRIg3vD1zQjBvRjtpNlCmwD5T5cPsQcXj/KRRH7qqKJp?=
 =?us-ascii?Q?KLXUZq02s+/wIYahpGAcQJ+5o5ee7L/nccyRcMzp/beqj+uUDFecc5wlqrp5?=
 =?us-ascii?Q?Ij+AQvidPOB5Vg+c7tmxwTE91pLIu6Vd/SI3ar4wvXTHYJyOhWPkMLRrhFNL?=
 =?us-ascii?Q?+K7WG7fjZQnQ6/+v2LNwUSRtjsTJ/zSPeH/pxqjpuy5QcK+qu9BQ+vgeI2uq?=
 =?us-ascii?Q?lU4Z2ZqcGt2iTBx1HBgZVbSBe9PAV++vJahMbYXQHC1qhv1G6obXHN90UDfm?=
 =?us-ascii?Q?iogm4AL3DdFRLyyuF33bsQHYvWathxZpmaeqUFxfS3BkD8FxeCHI87nxD9wa?=
 =?us-ascii?Q?hIuzuQBXy06RjwiPeGqC8mFLfp/kAQZYc52USKJ6tAJKkFV6GXzxqdulWATF?=
 =?us-ascii?Q?7RX2jIm0lrqohbxa5d6HNBUCl7HVCDevYW4DMR4XiQ1PlxXLJbQJBm7Dcwqn?=
 =?us-ascii?Q?fqhuS2rI1i94iE5KQP22CLubIeJpBEMHSattlMXLA5xJ619lCngAsnT+0Wn8?=
 =?us-ascii?Q?yn4ATqYJLfi7vxFJvmUtx/oLKwc/dVW3dBris6BMZrb2AaL3HNcLOrLEwyUy?=
 =?us-ascii?Q?JFOx0oOjTDiFTGFY4nPsp0frqKFixhEiCGVJFwtrjU3mGf9a3Swm+MHISz3e?=
 =?us-ascii?Q?ybRDveUpjBlqxr1TRcyOTgW/7kj8rFeZODaB8tKZjtamtW57MXm3HvVstZAq?=
 =?us-ascii?Q?yqrDyrapW0xCX1L5fMi1/zxIeHUmykLKhjOKrDEtJPihW6sHUbIOn3U4GgMe?=
 =?us-ascii?Q?HbpTYk6JZOe9a/HqTJ6WdCvKrQTxb2DspaBGpD0czTsmybFW6QMcVPxYzoAb?=
 =?us-ascii?Q?SGiN52PiwLmKcDwHObWwepYNv3REcx1T2C3L8xSROMQAT0muplYHKk0YAHIe?=
 =?us-ascii?Q?DWSepNxPGzPIfkXe5Mmi3l+U3KYa7ZTtQ6hGvnvTmdZfh9SWVOFVJIB4w60w?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0xg/Tbx+3QMbu2i/eGVnvJJE+Hm/4eFqRwLtF8mlt5bqa+EK+gWcX2ay7ivgr5gijcpgrcY7ErZGhP8qSgcItJpt8AJX5+8n8OgliB1TgwT67iQzKCQmJxKeFnHj0aKeaL5l5UPYZwB7+VY/v13zleLf1menhnV9di3J4KAvXeFoFmkSh/HW0RPVWOc+YZ5BSQDI78DaSlsHSW8hBEcgjVqZUbZ3azvWsCSqyQd5goloxWpdwLJU2pJSxxTQaecZSr8Owo4uh5Gkip3YQFUlI78CQMpnk+jz8x8L/nHqTtUpMS0gRw1SKu0z+V64/5QbWQyyrt2smptxNumEAl+YtHlO7GcEP5PyDzsZEVEiL9N8stU/IL8si4oPtKcZEMiSsbWh/QdxFL/OR30sMtupqHlz2wq8N/6LgJ68thUIdHIsEx7AMNTmVQCIDOAmfX6zjNFuZFDRHfCvnHFFQFXdIXbpf9jjxfAewJLUW8M+9hbJbseB/f6psVfs/U2DwTHWFsgMbBzzSWGJ7cxbFz15gbP4jgGlVM9Aasqk2pIW9zUjiDGBUfyiHYcJOB35BAlOPcbjOzAxkwwFmPiUYF+bZz8pVKqMuj4772rAkNLipCU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73debee4-726d-4864-19d4-08dc2c58a976
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:57:29.3080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqWpVJsp4fU5DcecyGSK0w/gw5zhTw4qq+JMQwYHZmH6VugxRBBpwBJkUBMpn7+KiKZJw23+lhoI5B+vbbePELDcrl6E0cc0KnhsIdo1+zI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6533
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=942 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130043
X-Proofpoint-GUID: NfzWETDx5tKhze4yfwCRpx3cjxSWr0Sr
X-Proofpoint-ORIG-GUID: NfzWETDx5tKhze4yfwCRpx3cjxSWr0Sr

To reduce RCU noise for nohz_full configurations, osnoise depends
on cond_resched() providing quiescent states for PREEMPT_RCU=n
configurations. And, for PREEMPT_RCU=y configurations does this
by directly calling rcu_momentary_dyntick_idle().

With PREEMPT_AUTO=y, however, we can have configurations with
(PREEMPTION=y, PREEMPT_RCU=n), which means neither of the above can
help.

Handle that by fallback to the explicit quiescent states via
rcu_momentary_dyntick_idle().

Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/trace/trace_osnoise.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index bd0d01d00fb9..8f9f654594ed 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1532,18 +1532,20 @@ static int run_osnoise(void)
 		/*
 		 * In some cases, notably when running on a nohz_full CPU with
 		 * a stopped tick PREEMPT_RCU has no way to account for QSs.
-		 * This will eventually cause unwarranted noise as PREEMPT_RCU
-		 * will force preemption as the means of ending the current
-		 * grace period. We avoid this problem by calling
-		 * rcu_momentary_dyntick_idle(), which performs a zero duration
-		 * EQS allowing PREEMPT_RCU to end the current grace period.
-		 * This call shouldn't be wrapped inside an RCU critical
-		 * section.
+		 * This will eventually cause unwarranted noise as RCU forces
+		 * preemption as the means of ending the current grace period.
+		 * We avoid this by calling rcu_momentary_dyntick_idle(),
+		 * which performs a zero duration EQS allowing RCU to end the
+		 * current grace period. This call shouldn't be wrapped inside
+		 * an RCU critical section.
 		 *
-		 * Note that in non PREEMPT_RCU kernels QSs are handled through
-		 * cond_resched()
+		 * For non-PREEMPT_RCU kernels with cond_resched() (non-
+		 * PREEMPT_AUTO configurations), QSs are handled through
+		 * cond_resched(). For PREEMPT_AUTO kernels, we fallback to the
+		 * zero duration QS via rcu_momentary_dyntick_idle().
 		 */
-		if (IS_ENABLED(CONFIG_PREEMPT_RCU)) {
+		if (IS_ENABLED(CONFIG_PREEMPT_RCU) ||
+		    (!IS_ENABLED(CONFIG_PREEMPT_RCU) && IS_ENABLED(CONFIG_PREEMPTION))) {
 			if (!disable_irq)
 				local_irq_disable();
 
-- 
2.31.1



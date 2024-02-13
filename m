Return-Path: <linux-kernel+bounces-62980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A30852880
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4431C23514
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E12539852;
	Tue, 13 Feb 2024 05:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QzwuVQct";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yH/zQ/MH"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B0538DEC
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803857; cv=fail; b=J5EwoiZw3dDT9E1KJjIDpXjKuZOVi+zv0OO4dMdAAs3TEsuCppuWkK+VwWO8fgVPIp6hmTBgyoH4uucSq5DtzY1E1bzJ9dXZXUEtwXrzcEIcutnWw8Z7xsf4M/PEfyDPhNk9RYmzGs8BTtzsyygnn+RwyaUN5s8TYW+4BWm3iKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803857; c=relaxed/simple;
	bh=Mww0LhqcfHd10l812lIJRHN3IvxONYhQShLcipo36aU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HA3YRNOBUVsqj3nvSd8oMUP9UGubGMa3tNHfsllxNW6I5O/pS2YPC2EYmdNWT/AkA3nPGgITdmypWvWZkrOD78nPDzTKeaMfI4Y0h28O90Uk3ANMky121e2BRcfIsxR12xxY4gEDFehtzPvyp8kJiGcIoAVcwSRgT0zD00jgEa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QzwuVQct; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yH/zQ/MH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5ZIP5006358;
	Tue, 13 Feb 2024 05:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=bs2ravu0cwCgK2dzh8jR6t2SDdXIwliCw+KKLAjFaWE=;
 b=QzwuVQctClNof8rtg4wkipnz87y12TJ0Cz8TDUkur4o6RNXdPb1IblVZRLBfY1jm2eVF
 JB/QigdS621cZhW/hOA1ap6oGjQtxWqOj+GT7gkmBKzntwifDoBs3CJhtaJ2S53J/PYC
 2Fh6zb620VcEGd8stvouVQjTMQMpEMjXANrKCiXugVWYXBQu6xmetef0Km4w2I3yl/BT
 iw2H9vbeFjlbso2ROk6+OieVZS0hkmyljpdEZ7N4ZRrrq8zUMt9Fc/NR2xuGotbQFGAB
 +amWjfUG7eLPVsUpxap1PI4XYpqxkLatG5DoeTbR9NMEm5bU3NQKL/2F4ftrCu/An8pK xA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w82d7r1h5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5aOFG024597;
	Tue, 13 Feb 2024 05:56:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykd3tmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPck2n7hizzyrZJv+KYUoT5iVQB3A6ewZ4IYxZa745G4m2/izzFVJw+WVW3xOwvL85LrC0tiKRCtftQikiXorQ8j0ve21SzbyT0ijwZKrid9tJNELkf11gske/oLj+6at63iVs6raBidT7oo3UVa47aOlyw3TcPb3/Dur4AE+OYZI8Jd/ySk+dlm1AfpNmM8MKpr0ON/IIbfMKyrIUGHDv89UKHIJeN/hYvdHnYW5xHPkGGhp/txM/UG+VhSNUt4C15WymhC04exwHurcUy2C04NJDaf539SjBlzxBzwRGPDn5KOc1WQwWLPNGrGcTg/Z8iBqRMedethQu9mFoy5Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bs2ravu0cwCgK2dzh8jR6t2SDdXIwliCw+KKLAjFaWE=;
 b=oV9lT+/faygPmqdf21gTG0nCU298RaIk6fZqNG3jHUtnwMIvl9pcvkD2RE8jXgzJ7JQDOjvvr9oFCz24sK8McWz7ebA1cV+LcX4jnOeTZBq+dtX13g0PQ2Eie+U3Y5I4rCTU3bThERnA+b7ffijKfvz87AaIHsMLZpztsgf0H2eXCtkQGwYmkkxVtStow71Zgsu+QwfCDPXTM3F5VAupkYyOYb2V65CLAykZ/KZ0ZBBDE9aN7VD9CGrYWFW4fGq/qmYGCaCX9yjxFrgLPNl9WC+Vaq/K+PrjiGvCo9AMJow8abJIdYCrldNm64QG9/DCWsz2Dzh1XRzFBcHQuU3/nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bs2ravu0cwCgK2dzh8jR6t2SDdXIwliCw+KKLAjFaWE=;
 b=yH/zQ/MHEXLJgQgJM0ic7yDu5EfyjeUxTCSmqZIrXb4I+/e4ngi4B/KRW2g/ZJK+zq//PKoa31VVhJR1dQQUA/oWZJp21f3ri0sgPO9uOF14RUjaeRFXvgoiSM6we1jteyzEeDPudBJ4Mj8phuTjMTGaFH9B80OHXrTfVqU1ubA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB6906.namprd10.prod.outlook.com (2603:10b6:930:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 05:56:49 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:56:49 +0000
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
Subject: [PATCH 24/30] sched: support preempt=none under PREEMPT_AUTO
Date: Mon, 12 Feb 2024 21:55:48 -0800
Message-Id: <20240213055554.1802415-25-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0091.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::8) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: acc2334a-a718-4af6-f99a-08dc2c589178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5wUsi1Wf+ADw2T+0gYYXJPCyw2naIeCUR+cwpP7I6o0CqJZuMDo74o1NWiuAmMaqqt8Qc8RFQF6HAWCkSQDwYPYNTPID1wZDTG0L1JP22XOqpuj5qeXnK7PAzNrM6YwI9N/107qD5r1rPe138w3hprSUiLrn8SSmbR1Lv/RsvTrfVJzQ37rJcpE1e/WaE6SwVShImLUlxpusZVLXXGzGXELkiet2kmuAaXQzu4N76k+fDHHCrDvCRRoSNWFRiS/vNbQuvdKpi2cPZ/KOayD8zfInMsw6m+F//xmwV1B+xOzyu2Gc3nOSTwCTpyCBvh4f1CLVj7gadr9gNrsRV31yD0VXPl3AwIOgAfqufVmezCoOTe11cZVQDvfhXuGak07Ruc7O5pdP5EEJt8uzmiGahOM4xaoL+WYIfPoI8xGm7oRJCSW/fO2I7VAUMq1yZdBn/j2vgt6jwmZTSDD/Pjgfdlg9866n2xvOQNevlBKql1II5813ELiPZjql8bLI+qdHN32jtZwK75UxhFs5qgB4vYEyNWE5zzP2uIAhOPfXNY4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(2906002)(5660300002)(66476007)(66556008)(66946007)(8936002)(8676002)(7416002)(7406005)(6916009)(4326008)(86362001)(41300700001)(1076003)(26005)(107886003)(2616005)(36756003)(83380400001)(316002)(6506007)(6486002)(966005)(6512007)(103116003)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HSf5bciRkztbCdhUqBpGpkrDAeJ7cNlnZT2LhwXgTxS63BuMeMpo469AYDde?=
 =?us-ascii?Q?egPIk/0MwMVJQLg78cr2dny+P01Ftxy8W+hriHl93cZG1kfqHT3gViiIBbXk?=
 =?us-ascii?Q?DZeBiJHMgwzDVCMkj6aXkDZh+ysovrdT0BIZn0VWKN55qes8tWKnvFEhIvqS?=
 =?us-ascii?Q?rW/Y8W3qI3FSC93PauF0zjG3lXYFYQzyvLtdNYl2e5mxV/9+BmD4KzV3TSiG?=
 =?us-ascii?Q?J9FReeaR830SCI/JI6mo8XZzTOof+iijZff5+M5VYjY0mdxs3zkOOSAWU6S/?=
 =?us-ascii?Q?CkozqCVGMiEy6qaYxQq2j5p9KARFBxFLM5C9nL6GUFC0u+Q8r+m+rxd9EK1u?=
 =?us-ascii?Q?AwGEg3WxNAv5F6TZnPLHlEGzyvNMJj6O5t+xPiyqEBvNqE3YMxc5UM57DRkx?=
 =?us-ascii?Q?qB2o0E/SI7wYVBhsNhoSPeYLcoDgXRovIb3ecsUlTjTKY9sCf3SVw8CN41NX?=
 =?us-ascii?Q?HqrkfmwE22os1AOhtDo19Qny4708RA6GMtDcVJQqcnkjyRt9KJds/96hP4aR?=
 =?us-ascii?Q?bWC4c6jPCDDzkD89HN/wG7wPeN8K9Fv7vawIiUo2r6Ec/hKXImqODLm6HA7s?=
 =?us-ascii?Q?/eXurP55HymUfsWwcVG5AHRBpHgBN1/UAZhgkwgrlTZKTaRjzvgy3BMhUSCj?=
 =?us-ascii?Q?8NEptylOykTakk29PAzW9dGWs2Mxvn1IKo4sJCZY1paaVudl5inwwWgjZLoQ?=
 =?us-ascii?Q?KiHMQ1Pg10kcSlududwxqqLCrRxwEcyIu6q9mrGKaXk8dJ0ZdF0MvZh+h/hk?=
 =?us-ascii?Q?TXts0uU+qrlSbpjCb7BPBZKKcln2MJEAAW+PXcRGSe2B5oMAcGgoV5p4SavI?=
 =?us-ascii?Q?nUi3kMcMeCRKIVLY9v/5TO3Tsckl3hJIwmsePDOpIha1oX/m9RYLy8KDW9us?=
 =?us-ascii?Q?ymDTxi5yyimfwjanIzqbp7IJth+bUrCUduGAYlLujiSh0pskdIxOip7RsbRN?=
 =?us-ascii?Q?ncfpjLn3ddeNQrd6xLhhQrCWCAAbisagoJZFl1Pc1p22XHcKY0ry1GyitsAh?=
 =?us-ascii?Q?yL/+ek5+orWwZ2RO/V0se4kPeml7EVjHJb01xBeRzH19MVgdy/jJHA6M6ALa?=
 =?us-ascii?Q?UZiN0/YYauBlPKLVduar/N6N7h5CnSQo15h56JZ6okOjTcltIWR6jMc1UsbR?=
 =?us-ascii?Q?XlSK3l5v3C+lmHtJ7XtKbZ0LEnUwlHk7/1MpbomWjel5WSpNh7NsJdxoOa8E?=
 =?us-ascii?Q?a7Y1dE0a3tQ+La0X5evLGpuGlAZI7y38/A56rgrq36JAGB6g0Zm/SSGcYOHi?=
 =?us-ascii?Q?Y62o6Rm2Aeuv0cB/bMDbxxFQHadIcaRlQfFs2RAb4faqTKZljH8iERMluf24?=
 =?us-ascii?Q?gdXybiNkjhqUWYVnE2iXWrBsv8XWz6nsmODJWqDvzbB8nI98cOzfxqCbCxQf?=
 =?us-ascii?Q?EEJNOtw6zz0kxx5+3EqetZil2dkLsToBZUR+j8l1X8Nv1lCtg5V5faNx1JHD?=
 =?us-ascii?Q?Z817JpJzOu0HlHVDSgitxFPRBktAiNwKi0AMwC2adqwRn/AsN5Z7ALREq5Cj?=
 =?us-ascii?Q?oL9gCjO7cJ6MPKMrnsXafGuwbT+5YhmJvUC2T8GTIpjs8mqjrR0240ti/NYg?=
 =?us-ascii?Q?+bEZff8S+0H0yv/vDfXV1JiN6pToEWIo2o8N2DGyq+1s4BEhnTMFrpuHEt8W?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lRHOTcHJvHDdogDE5NOKvzw7e/eRfdL79u/2wYZ0sfNkJssOuqHpsbwj78UR5wa2vKtUbvVyCRUW24PLAoWsk3XWhVjDBkgJpzN3VXIlwB/SqaA426znzHLULAe7SGoRrCpYevUBQfhGDFsNKl1O073cOvdOy0q5YFU+kUJWRBXHUBtUhzmIT58K7PjodK1tmd4PCZddEaRjPJNeRIXFIJvE64L/JPzKfrGDTGzvOOiUMh1AEU29f7bGOhRik5CclddgzZ/O4mfMEnq0rnz5FhHw1A5iKCmimnC9DRBozCEX5W4pi/M/Il0kS1OArwP/cxLO/jLzY01z5sCBHUAORMK24PDN+HQTLCcddMGqf9Wi/iw7ddtqdLJtv6PkzQtXmd36b06YTe3BzDiKRFeoOl4BpBHZ0YSZwjUmW36mqFM3GxBAx824bM5NlEsLUpuiuvWMSHGX0lq6FfacBdv/oq6AJ4qz8qXkLDcpIRzAicfDrVM2A/0E57ezUFvsMPe6D5ySLWasOK81IQR3+nXfwQuo4QNzKtgYgeLoV9kLtB8g9U8slinwbbc0RocxQ/8v8Tz2htAG+p7JxjQlLjCdsmKr+ORrR0uZsGjbiK5K79M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc2334a-a718-4af6-f99a-08dc2c589178
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:56:49.3059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGkd4Me5cL0Fz8It+vEz+xsF1PBLHIjM97PW7q6ikGdhUeBv/P4i72+zVR8TA5/g54OytM+lizScj39TtfC64j26fP0OMO4KWdo6CjHADms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6906
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130043
X-Proofpoint-ORIG-GUID: 3r-F3ECbcNT-BSRGFXVfrcseIKsoCuz8
X-Proofpoint-GUID: 3r-F3ECbcNT-BSRGFXVfrcseIKsoCuz8

The default preemption policy for the no forced preemption model under
PREEMPT_AUTO is to always schedule lazily for well-behaved, non-idle
tasks, preempting at exit-to-user.

We already have that, so enable it.

Comparing a scheduling/IPC workload:

 # perf stat -a -e cs --repeat 10 --  perf bench sched messaging -g 20 -t -l 5000

 PREEMPT_AUTO, preempt=none

	 3,074,466            context-switches      ( +-  0.34% )
	   3.66437 +- 0.00494 seconds time elapsed  ( +-  0.13% )

 PREEMPT_DYNAMIC, preempt=none

	 2,954,976            context-switches      ( +-  0.70% )
	   3.62855 +- 0.00708 seconds time elapsed  ( +-  0.20% )

Both perform similarly, but we incur a slightly higher number of
context-switches with PREEMPT_AUTO.

Drilling down we see that both voluntary and involuntary
context-switches are higher for this test:

 PREEMPT_AUTO, preempt=none

	  2115660.30 +- 20442.34 voluntary context-switches   ( +- 0.960% )
	   784690.40 +- 19629.42 involuntary context-switches ( +- 2.500% )

 PREEMPT_DYNAMIC, preempt=none

          2049027.10 +- 35237.10 voluntary context-switches   ( +- 1.710% )
	   740676.90 +- 20346.45 involuntary context-switches ( +- 2.740% )

Assuming voluntary context-switches due to explicit blocking are
similar, we expect that PREEMPT_AUTO will incur larger context
switches at exit-to-user (counted as voluntary) since that is its
default rescheduling point.

Involuntary context-switches, under PREEMPT_AUTO are seen when a
task has exceeded its time quanta by a tick. Under PREEMPT_DYNAMIC,
these are incurred when a task needs to be rescheduled and then
encounters a cond_resched().
So, these two numbers aren't directly comparable.

Comparing a kernbench workload:

  # Half load (-j 32)

                         PREEMPT_AUTO                           PREEMPT_DYNAMIC

  wall            74.41 +-     0.45 ( +-  0.60% )         74.20 +-    0.33 sec ( +- 0.45% )
  utime         1419.78 +-     2.04 ( +-  0.14% )       1416.40 +-    6.07 sec ( +- 0.42% )
  stime          247.70 +-     0.88 ( +-  0.35% )        246.23 +-    1.20 sec ( +- 0.49% )
  %cpu          2240.20 +-    16.03 ( +-  0.71% )       2240.20 +-   19.34     ( +- 0.86% )
  inv-csw      13056.00 +-   427.58 ( +-  3.27% )      18750.60 +-  771.21     ( +- 4.11% )
  vol-csw     191000.00 +-  1623.25 ( +-  0.84% )     182857.00 +- 2373.12     ( +- 1.29% )

The runtimes are basically identical for both of these. Voluntary
context switches, as above (and in the optimal, maximal runs below),
are higher. Which as mentioned above, does add up.

However, unlike the sched-messaging workload, the involuntary
context-switches are generally lower (also true for the optimal,
maximal runs below.) One reason for that might be that kbuild spends
~20% time executing in the kernel, while sched-messaging spends ~95%
time in the kernel. Which means a greater likelihood of being
preempted due to exceeding its time quanta.

 # Optimal load (-j 256)

                         PREEMPT_AUTO                           PREEMPT_DYNAMIC

  wall           65.15 +-      0.08 ( +-  0.12% )           65.10 +-      0.19 ( +-  0.29% )
  utime        1876.56 +-    477.03 ( +- 25.42% )         1873.63 +-    481.98 ( +- 25.72% )
  stime         295.77 +-     49.17 ( +- 16.62% )          294.41 +-     50.79 ( +- 17.25% )
  %cpu         3179.30 +-    970.30 ( +- 30.51% )         3172.90 +-    983.26 ( +- 30.98% )
  inv-csw    369670.00 +- 375980.00 ( +- 101.70% )      390848.00 +- 392231.00 ( +- 100.35% )
  vol-csw    216544.00 +-  28604.60 ( +- 13.20% )       205117.00 +-  23949.50 ( +- 11.67% )

 # Maximal load (-j 0)

                         PREEMPT_AUTO                           PREEMPT_DYNAMIC

  wall           66.02 +-      0.53 ( +-  0.80% )           65.67 +-      0.55 ( +-  0.83% )
  utime        2024.79 +-    439.74 ( +- 21.71% )         2026.12 +-    446.28 ( +- 22.02% )
  stime         312.13 +-     46.14 ( +- 14.78% )          311.53 +-     47.84 ( +- 15.35% )
  %cpu         3465.40 +-    883.75 ( +- 25.50% )         3473.80 +-    903.27 ( +- 26.00% )
  inv-csw    471639.00 +- 336424.00 ( +- 71.33% )       500981.00 +- 353471.00 ( +- 70.55% )
  vol-csw    190138.00 +-  44947.20 ( +- 23.63% )       177813.00 +-  44345.50 ( +- 24.93% )

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Ziljstra <peterz@infradead.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5df59a4548dc..2d33f3ff51a3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8968,7 +8968,9 @@ static void __sched_dynamic_update(int mode)
 {
 	switch (mode) {
 	case preempt_dynamic_none:
-		preempt_dynamic_mode = preempt_dynamic_undefined;
+		if (mode != preempt_dynamic_mode)
+			pr_info("%s: none\n", PREEMPT_MODE);
+		preempt_dynamic_mode = mode;
 		break;
 
 	case preempt_dynamic_voluntary:
-- 
2.31.1



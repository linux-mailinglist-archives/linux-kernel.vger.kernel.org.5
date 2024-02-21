Return-Path: <linux-kernel+bounces-75519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3700885EA0F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1829286D96
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE9B128807;
	Wed, 21 Feb 2024 21:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YjRyO2y7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vehO3MTt"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492EB126F2A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550596; cv=fail; b=IbNaM31PSo8IViB+GQZZFJSV4oC/2DOK2OVIdzLfkOqWTHfI1mwMeiM+uyh/56f/9rELgp5qO6EIntA82RxjUhmG6QBMCN8HhjXot66qKLz/Fxg93oXp5f6DXZCyuKsrNms1tBNukgRT4O0xk5b4DHObZjUI5ootsDcZdKw7B/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550596; c=relaxed/simple;
	bh=tZup0GmRnQT1lzwVoASBfs7EHVYPuRWbDqwAkJyXLkc=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=WuYpsHcZSZGe1ERT3tpjtlDml/K2WwRcfO8FqTzNHwtM2vFcpkDIptBYr0KbCf7xYFrPvxFYWDhV1shxp/vIge6qcmf62KPX0bhlJ18unQvHvZG4co/cyj3EaXLQOtvQ/rN5y+6DPKDiyYuumrft4ZGsgo/mfdIGgfydOOgc8JE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YjRyO2y7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vehO3MTt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41LJDiGX011339;
	Wed, 21 Feb 2024 21:21:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=ZmvHLylK44mEm3ubgCkbz84ucVoiy0amBtOdV/V1xmk=;
 b=YjRyO2y7OWNsIjZ+9AiM+qYy7s7DYRZWjhyJLA9oGjfITRA2Q0rcHIepk6CQkYnQzULh
 sC4H8MEliluZRtADX42t1F2p/oYTvxTXJ3QTpy4wX8l3n0DCQU5XfLCj0y+gaNh8rcQG
 JQokXBy2VQA0JD3QsrNc3KP1B4XAQM/l9mL6YGJHvlElgfk+PEWzSpvAEW1sAOR5vgki
 DoKZTQsU+Nm5gmZgz9iKvq3sKNXfWydv9AJZpk8LwlQxGDwdAfYQAZPjC/985NIpW5vj
 cnD8Pk1wtHpPqjOn1210eEgMxeTdBYMyZ1+fzs/AQRYDkcQOQIhOEBI/62bn50PvTBd0 IA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wd5fw2m4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 21:21:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41LKaeBX039716;
	Wed, 21 Feb 2024 21:21:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak89njxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 21:21:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ogz4I5assQ10r0Nowd/XnZDp/RMQM3DSvAo2p+EevPKZrglUea4RtrorBtJNuxzQhE0E5KnWMMB2enKI8cV+uVa1YHU4jSZfQEp3Menme079r/h/YwaGEuG8oi2nLSOnI6Y38lftPWcg7mTPtcO6utAd1RbXgObbT/Yj18JJx91QNcvMg/Ee56EYJHEJvB3AS/4fAvuZzStOJF02u3ZyiQye7thcc8S6NSS4CGxtgNmy5DZY8K0sX051njVXuu+yTB6ky+1SxAZlTlCnT+Di508BvhniKe0//Z9GEB/pGG4BrRG4l7G3gcKAglbCukrzXLyoSUNwL48DkYjHbA9Bnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZmvHLylK44mEm3ubgCkbz84ucVoiy0amBtOdV/V1xmk=;
 b=ArqRNyJuX5Z6+25aZnFJCuPT+JWkNcj2e0tMwoQhnXzno+cHBeofSLgAM1gmy2wrx4FfV6F+KCN1afCSszg1cwj2XhXsBNCHqyDBKrcP3mcY/rXFSHcR2aknnEtteTz+SbMHi2Yrk3tBk4KDWhP90vG3ZyEjOR1F4oLJOC7QqreIIPvpC64lGiPnvAuOcFfHkFtJJBIu3Ju6e+fnFINTjrHoPRqp+Y02COJP1hwXz3s4wFH1ErcDgovLQt+myCrt6jP31RKbUbD71gvYF/9PGYjDvLbUhBNJmw5P4N9v9baub2nqpbINnn+DRmyk1aeFiW0LdVebuJ7wjsF1t9oGJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmvHLylK44mEm3ubgCkbz84ucVoiy0amBtOdV/V1xmk=;
 b=vehO3MTtYUva8X962GRMaqrMnoFRChb02kX+M9T2R7qd32mD+lPoS4W0QDTa7jl8EAxrUkrK3hn9sgslAEeM4Jq5N04ThunfghLLTNvcX1b4LWGc0QKZnAiVOZ8A5jINgq8jcHGtlbEYLmJSDAKFzNPoiJDxNVJi4CuBuqrjtoY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB6612.namprd10.prod.outlook.com (2603:10b6:930:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 21:21:52 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 21:21:52 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-4-ankur.a.arora@oracle.com>
 <ZczJU8uZdbRKvcAE@FVFF77S0Q05N> <87v86k8opr.ffs@tglx>
 <877ciykc9v.fsf@oracle.com> <875xyhhhju.ffs@tglx>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Ankur Arora
 <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
        jgross@suse.com, andrew.cooper3@citrix.com, bristot@kernel.org,
        mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
        glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
        mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Arnd Bergmann
 <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 03/30] thread_info: tif_need_resched() now takes
 resched_t as param
In-reply-to: <875xyhhhju.ffs@tglx>
Date: Wed, 21 Feb 2024 13:22:15 -0800
Message-ID: <87il2hfr7c.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:303:2a::6) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB6612:EE_
X-MS-Office365-Filtering-Correlation-Id: 5003007e-b621-4ae7-f9c4-08dc33231f64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Lx4Jq5LAw4N3mxwOsIabEjiJ73DX9d5vGOOSiSt23blk8DheOeuri8DqDBzMAndMtqdMAc1CI2w2SAe77cx0IOG8nKc6QEetz/dMFaYAFk1zZBU9jdLteHQ5TC33VSrcnQQC8IS+1NUrYzgXJuaneckaRgVtJe1nAN/JexOTKyxVTEDk+SZc7x7f2Ro109LISTK1SMy9Qnwl4O2YaDeH5b7exoqp6HnizoTnrfZbIzSOxvpqRWaXLij2rs9WHJ7g6bx8eruXtUsspCll+5fzDU+9RM9x46vT6d3etBES3yUHr58GUlk0BrncXkn+nz7f8JLXjyxnhqwzDbU3g8OY1d+SA47+3HaLxaKs0PC7Bvj5ceQigkcNsXL3K/hljv/oZ1J8buNoneCSDAaV0v6z3jYfhzGLZwg5XhUONgcvJQthYkVKh6u0mX/2IhCjYQTzPEt3r8rpBGesiWrbGbS51jH1OC/BJ53ExM1QnmOGDcEx/CuH4KoHn6gju3yIJnonzR4bujCAPkRSHon1dgDHd4aEtF+1nUXBtJ2ydXVazzI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MWXFfuz5nbb8kunbJkJUDC6Wo8GrCmz+sey4eV/QvSnbugvv3C116vvV325x?=
 =?us-ascii?Q?GUQAo81qE+c7ZQNfhMxXnGPMC8bpOpwT81VuPau3WFFGbx4l50CFRtnBK5YP?=
 =?us-ascii?Q?57y8nJ18WVFDs5Bey981tvQMCfviHkBD6kwFSs7Zfzddy3N0wkeQgKjILZNG?=
 =?us-ascii?Q?bqSrabS5dxYxoRVIYFzuQ52hqz6xgIRGR0yiOo/digmCb+jWnzQnuutCzHZ/?=
 =?us-ascii?Q?UIB+8iyKLhEncKt+z/94u3MHLTl558X4EqoK+kPuC1069hBcDnU+qKl6Dbdv?=
 =?us-ascii?Q?mT0gxit/NGC53M9ngXB1rgVWjWeyVRUpNlOwidtUCSJ0doYy3Hb+AfVj4KJ/?=
 =?us-ascii?Q?R9l8+D/oq6ZqhMJzIFmJ6bAUEAjRoz6ycciSf4tWEiRn2DilzrvFJOVXvSVr?=
 =?us-ascii?Q?0LSxAofH1APkHBagUUsqnGy/BeneQgQrDW44ZSD3ey3wM+R6FOK9NARX3N2f?=
 =?us-ascii?Q?Bljd2XJ1F1BDY9KsSCjBzCvEiWi9cOAyauhKhbhdnhVY2c14z0ciK4BveKP7?=
 =?us-ascii?Q?0b+oblc0/BpoWB3zTzI+5/xIV5bHb+ohTRQJczElTwcH1FmuUV+zcaAi3zta?=
 =?us-ascii?Q?M6xOEz9SyYMkrevlPjn6DCB0kfgkOJmJI7RaIr6rsjEjlC3Ac3WBA7pXZEy2?=
 =?us-ascii?Q?kCRkAPep+Bq9Tu1tf08KMZcWFV73Uq/vfSsy+cfam73dtbBI/eI6vM7BOZ4a?=
 =?us-ascii?Q?Ha3SYNgxen+Y7RWi2ZErGsNewHkAiGRGg8FjgeCIKjj7T0tYTB3hhBKc4dJW?=
 =?us-ascii?Q?m+Z3y3h6sGrDntvoMHK7UHwTjP1oKWfQfe2bW9GoSlnk8sOM71/u/CEGPvn9?=
 =?us-ascii?Q?MpBJtser3aA0nF1VrIqMzhUFissix2OOGPMkbfLfPs6bzzy9MtcwtKFBqnv4?=
 =?us-ascii?Q?QGoaxaG4RZYcPivXsggC3zZXNM2Q8I0IZsmzleVmom2FjZCX53FLghDxdkX+?=
 =?us-ascii?Q?uHX+StHNM1Ucy0Y4XvBrEYsv1wy/6h4BdI8VLxQyaSJQyOlxIPY1+ezALMst?=
 =?us-ascii?Q?DjPSLdemOSuLW0YycmhT4Ot4CVpoBqB1sx5bS+Mxyitmgz0stCHpz2jnoVjF?=
 =?us-ascii?Q?E9Lwo+LowUBOBR4YvEZUoT5Fnh7EpTiOhRozClCTUkZ84jHhsHXVqJyG8Mc3?=
 =?us-ascii?Q?LmqPKOzQid4XbCGfLMzeTjOrEgLMq/Lu0kSX8x1W5N4BzY0ZMciLP/c1J1X9?=
 =?us-ascii?Q?6NqTpLRg0o1y7j2chU9J/JQye1UtkMISvG6vm127lmuFbRTHRqXtWrAt8GT8?=
 =?us-ascii?Q?Ql8TLgs85mpAR/3TLriuLRN2/5nTGvRU7RMNmoISB42i8ichVUGoFSbwzDtO?=
 =?us-ascii?Q?k9YdS5Ye7pJ5buMQMijBRf7QPpE+KGR7Pq6MDvHnZdKIZpHyT7am4A6eO7Fc?=
 =?us-ascii?Q?KdfbhG0/VyLHPL8O38brL4AcUeopnI3reCgXDDusZoTbGCVwvqXvRMUDtd9t?=
 =?us-ascii?Q?Io5ai4v1CqzRprL0tB3EYiMB3X5BsZ5p70mxGg85eYdnxkJI02Cy9K6kcROx?=
 =?us-ascii?Q?uuNekJXAGhx3aBeREjERMfZ4IoI/UIumNkIzDlpFhiMOjoeagF+b1HyXZ5lv?=
 =?us-ascii?Q?GwlKifdbElSgtX6DxH/+lvYf0GwtsRfDwBZ10dLV2tlpXD7JDA6Tg7Y2DpQS?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	077G335tT9fzH/eWl6o8DEE8tIy7iOcxvIKFYY4nUz0MOpD+Cp+4QjQ1CrPGZdVcxTIVt1sZfqBczSXh57vqhF2+7fh20pLqSNGF61X/AJWQNIJo9r4WpKViJhD6rpiu7o4Ab8qDMIQMjedCs7StYMc7bqKkg52k6/EjKzbyZJDLmxc1tCIZSrTRPuCrdC6/gaZlG3aBL8PvU8uqPXU3aFmBZZ2WoaX/TJaRoNocYV3t1etLUvBFZa6ARYdHuTmgM1qDloGI34YtZZfiRBQVrGSI2A1u+qHl8zsdyhND29cxqB/hNw+zjxK1F/wY+EyuWfeqEDiL2rhaI3eS7B3lXiwMe9Z6kEm0FbHO7Slx8IMbDNxWaCZ4OI/x4QVFbfctiAjA7ewgsYq2RTqS29fxyrOn0fP7EtrNmSp5zJjManObXOc+OXaCzFcx/4m0s0yeLttN37eN3RXPOwFHp0h5k98zwDzCzSXFcdOWF2Xm345lIC/8qbqm+z9vUjQJTRYIUYmWiC1Z0zVmOUXrwjijs5kIbjkzETCt+n0hOJu1xXPJtLL/7qizIhMdOHLg24AAanyCL2TO81ZpvvPLl9z7KpB8gRc+A0WN+usjNPwXSVw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5003007e-b621-4ae7-f9c4-08dc33231f64
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 21:21:52.4546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzPDQrisAxDK0yp+6Sz+rey2UqOfMhc7if4P2UnGP4nhw1wJJISnFsK2aHfBEOb0IpL2iDNPTZ1iL0qgjTD1HFFf1Vt9O80cCMGuIAOfNvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6612
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=706
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210167
X-Proofpoint-GUID: dWoEUpfPdYPl9HZcOObB_HJpTbTxnqQS
X-Proofpoint-ORIG-GUID: dWoEUpfPdYPl9HZcOObB_HJpTbTxnqQS


Thomas Gleixner <tglx@linutronix.de> writes:

> On Tue, Feb 20 2024 at 14:21, Ankur Arora wrote:
>> Thomas Gleixner <tglx@linutronix.de> writes:
>>>> static __always_inline bool tif_need_resched_lazy(void)
>>>> {
>>>> 	return IS_ENABLED(CONFIG_PREEMPT_AUTO) &&
>>>> 	        __tif_need_resched(TIF_NEED_RESCHED_LAZY);
>>>> }
>>>
>>> Yes please.
>>
>> As I wrote to Mark in the sibling subthread, I think exposing
>> the lazy variants outside of the scheduler isn't really needed.
>
> But having a proper wrapper inline in the scheduler code (local header)
> makes still a lot of sense.

Yeah, there are a few callsites where this will help. Will do.

Thanks

--
ankur


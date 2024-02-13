Return-Path: <linux-kernel+bounces-62966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B358A85286F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A4C7B263B7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5301B592;
	Tue, 13 Feb 2024 05:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="okoVFJZW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vBS7hq/G"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A88179A4
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803824; cv=fail; b=TNVE2EAy90FFrBwhDbc6rJrNHSeDpEI9VKwe02Z+6sF3ZriNbJu53EhbddQqdkDjyaIr5liOSsBujK0YC0Di8307A5UhfsW9g41ImMhIbseC4CgOuE6fqCMlDUeecwIR+mowMmFpvVHnvvwk6s2GsTtKjietEyFXqkAYT79zWeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803824; c=relaxed/simple;
	bh=Dqa8KlGXrm0C3zFw5hkLi/g8R6Y6VLTIxlmx2O+YFnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BIxJIjB7/LQxzjE0+dACQl5/rXmY/00Ue5XDfg5hGfV9bkeLRYaB7oUmCXfSdSC+Y6NSI0P4PHYW+avtMjXohkWWC9aav3fjQF3fwCoKU0HVLSQ+rf3PO9ukDwko/h33V5Iov7F1XSEHguCTJQP2gGkEmeAWUXz/a6AAy/mIkeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=okoVFJZW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vBS7hq/G; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D4xjrA032720;
	Tue, 13 Feb 2024 05:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=kwO0FTgMGeCJOFyBocC/+VIY0AfnF7GdW+hu2rV46/o=;
 b=okoVFJZWkridKZgN5EBJWxXV0eSRad6kMThpCN8yuGRzpuAm9/5OH6gdfLeTVk1xsmqt
 ychH/tDFoQfdPMh6edJ4vNma96VMsY7pwO0vhdHX/mXDq0D6VEvCvHEP5fexFMDb1Qyq
 pW3D1W+F8VmZjh5hnXn9pJYQsvDqNBqTiRk4KMAFCwMWS5ILFsyPLCubJDcJ4JdOvYyw
 dW6c9J6B50M8OMiZORyBTShTEg/oETD58GqALGorPRo868MVTkadx0htch3dcOjAriAL
 jVchf6nGpEYYsQ1cByojrZu1XX9OJfn4lEik3Vwh2yqO6sFrhO6oD4jUF9C13Ss35T5c bg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w81vm836a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D3JiMx014926;
	Tue, 13 Feb 2024 05:56:00 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk6k88v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+yNPLLFxmWy5cfjBkglVp7iTnrHosZy6hA+5GtUKem3YM9kBV+imLBx5vFC1rRhPXw0i2EMiyHkDBs4ClmO3EATenZ+0UFzf8WWjuL3fimRSAAMG/m3ssTU9w7Q1hYAJwCph6j/V2Njw3JK0JgzQfDezw64PUEmyMUjfChHNwM+O+fnkSiHPiTavW9k3SpSZesA1Uvhb74UsNPPfcHmw+KalfWavlV7yJai6gVjFozsKN8G7P7MysnCzKsuFrO4KdRTQwKRiEl1uRDrj01jN1x9iUReQAq3AZIqGwKLVyrJVChIdOfJmPyVb/4U5o1hwIs0/ExR7xElfxCjt0ekww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwO0FTgMGeCJOFyBocC/+VIY0AfnF7GdW+hu2rV46/o=;
 b=QhaaOf4zKgqq9WvUG+AkczwmPBwGZQBoLi//hYzUtyTeY9wpbp+79dqwh+hjXlcAEq+q5wXbHioPPrnsEMi6mWSYIR2yyV1xL0/pZ4ius+d3e7t2TIGd1BSGdlAx0LuRWgXLnZsYBtm0YtUQAUxWbAP1iaOBj6aQ6s+6ux7DwCe3BCV/4PTwfzmbXnpNNbgNMHKYMvK+SYSq882sJHNeesfgTqDQcNucuM2U8BgLGGerxmF552DJxep9dW45z7voLalfkgEPEdJU11UcQcq8wOG/FNfHHTi6Cpbq/cZJDEnMrIAHd7DriAWDsS/tpexxlkTIBIW3ybzv1YChk4akLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwO0FTgMGeCJOFyBocC/+VIY0AfnF7GdW+hu2rV46/o=;
 b=vBS7hq/GnW9YP+7t5IWMTqRcnP9JGlY+5J33RmFakxAD7RfINp01l4v5lfu6ffaUSCP86lWgzcBuuNvfvw0+hcgkTf97TIgz5n3S2bO1Puv2FLb9PPXWag3RtRodjGteTUdlrbCS9Y1+f6dLczfUEjJhfw7diawzw28YfP7aEao=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CO1PR10MB4642.namprd10.prod.outlook.com (2603:10b6:303:6f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 05:55:57 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:55:57 +0000
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
Subject: [PATCH 08/30] entry: irqentry_exit only preempts for TIF_NEED_RESCHED
Date: Mon, 12 Feb 2024 21:55:32 -0800
Message-Id: <20240213055554.1802415-9-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::11) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CO1PR10MB4642:EE_
X-MS-Office365-Filtering-Correlation-Id: 05749a48-769a-4857-1aee-08dc2c5872b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2hSL9Q3h/PlGi+Rs06jSWaXNZXaHH8rh/HsSDo3/3m//eF+UPbG6E4X3QO8F0oSxAwJhBex3/3Z37AHTnr7jF0N372Md9zdEU9AV4o1WGqT7IuPue7oTXwwQYXRJxxOZcHoQQ3uVeEhNkiP45r8LR708JPlsmYMFOJP6SsR/dl9NasJP15MvokZ9HJUJQ6W8zsxq1R8DQ0QFAOf4sTrdJj2EhY+O9v0/owGi+OMmwLM3PJXXJ2+z3mw/hT3aZcmUYKcBK6VHw7SMwpVrZc/icgL8XqAfIWNOrZI5+30zKTNEcS3ua0aR3LMFrnge5IDhTXutCVmKWRDcN7GNZaOUpS5w6qqdA1yXbsTSrDKx0CWsoeX7AmxW/B3MH8Nrqbr/DDQC7AiiqCcwj7gSTIlZXKropQAzEIONdM6WLAPXeDQG9ZnzJ8vNRZO74okotkkaCNgA01PUkOwSyDU1mYzZmTmtoLs35e6i+9FXKMjoudwyzTGwK25lz/3NEZibvrtgpyUTxEuvzbFq+1Wm+psAm7RXh3QkCldWqaD4GTGwBA8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6916009)(2616005)(41300700001)(83380400001)(26005)(1076003)(107886003)(4326008)(8936002)(8676002)(66946007)(66476007)(66556008)(6506007)(6512007)(6486002)(316002)(6666004)(103116003)(966005)(36756003)(38100700002)(478600001)(86362001)(2906002)(7416002)(5660300002)(7406005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1T+Ntj9g8AxJA4LQcVE8f4qbCyp/cTgETX0tpaben0XtfqqCl4Cv2NA7K2PS?=
 =?us-ascii?Q?GYOTp5jYFVJnbCQVfBDO2c1FUYRV6Er9Ae9yF897h1rB/6X3hKLpORBlL/cc?=
 =?us-ascii?Q?ekd/C4K9jzGW9ByBaoi6Sx580VVKO0vNTE4Oe0TueM79ijv+WNZ5ir9l9MT8?=
 =?us-ascii?Q?/SBYjm07RwBbHQug6M78KY2xrwIiTTkI6w1vwDrVrKU1xylgScCCJqkiHaxf?=
 =?us-ascii?Q?Do1glACWus8Xcen0W93zMpehSK9XUAiAX2BgjyVUXf+GE9rgqErgabzNAh/l?=
 =?us-ascii?Q?Ap/raHUawe6VRQfbxmzL+KV+wVfuXTXK18s2L94ZWgP4aRhciHc8mENsFnv4?=
 =?us-ascii?Q?dOi4jHc2BRHDIKvHKB9NLcZK/KjM+kX94lohJEcFkVlmkk8lReoTl7fj6yCE?=
 =?us-ascii?Q?anY5DiAgCIzmsP36Y/25vOqjTG7zvrVLL3fb1aBv2eCRSUYFYJumzhWhFAIY?=
 =?us-ascii?Q?oic5An2wIWKJJRUZdOXM8KKJaVmtkz1VSFftCZ+hXFLP0lJJd0YNpj5BkJxZ?=
 =?us-ascii?Q?w2d4sLW3WnptsvML0iv7HfOuy8YlCjV8/kUe/oKv6WAroErJ9IftJlTYVt9Z?=
 =?us-ascii?Q?uYbRO6LmUIWK64vsf3Fr35vUabR1Bg/3i5UwR831pwr4J7/cDpDQvV6djH5a?=
 =?us-ascii?Q?xuOfIQE7pq+h41Rs+oVqx7XIqhMLJVi/4OBRIv1BiQCUECW1UnNrpjjZbASz?=
 =?us-ascii?Q?mmW407eqEnrMcIlJcVVmnkSijBneOOJJ6CSBdF74FMeGHXJ4qNhuzEiBY30l?=
 =?us-ascii?Q?bQ1aqPH5SS6R0qT4cjHUOoE95RDSRZee4l1FeoAa5BWH0p1ymrlf9btuVLsG?=
 =?us-ascii?Q?tsG0HiAZoMHUvc2jc9+9JYu7cQc2vNsSpyUjNYeAn7lDq4MgOre7eYUdcFdn?=
 =?us-ascii?Q?Nlro0dUw0mpmo0r2iikf2J8eskn3fBLO/Pud2xE8kmhcPYMzzIcJHv2tV7O2?=
 =?us-ascii?Q?unHozhZrHFwDgFnmbjjBDw3eKn0nQG4hL5GMUO4taumo0Bt8AHwl6vGJe+jY?=
 =?us-ascii?Q?Abg1FQl2OHrvMib/E0KWgBBL4jWodqlQn6F3ESyZik+QI1tDfX2FPvNTt1Nj?=
 =?us-ascii?Q?vCodyrnfAPr2K0mDPHInjBUKZJpA58tTervN2NjMYGa5pkMtdfsYEYIxQnfh?=
 =?us-ascii?Q?2GXbnee5OD4qYDmrLSyTCz1WHTa8iwfc8irJ7bj2taEX29S7DQ6dKM1w2Y/u?=
 =?us-ascii?Q?zT+5xU0plN2wltTVzOuuywY578rPL2lxhe6O8WbMvvjtwcixweyQRDNsS4u8?=
 =?us-ascii?Q?xoMCkaA0ze7IlhSMt5QdO+M2N3rs41xA/BUs8RRthCxFNgfIHi/Z1sNLytmb?=
 =?us-ascii?Q?vFog9RGexh7+IvFzdB8KjNeOuVnPeSsGvONOTSveS2mjyinbJzj5TIFy1Sfu?=
 =?us-ascii?Q?I0mW6D5gcxBaB7x2kVq7GHzNc9I/nQ0l+blzdXovztfZ9mfqCeR/z8MzplOO?=
 =?us-ascii?Q?eSeebDguBJmEsL4XLgtRddgiMbUm3Gc1OhHlBKc2JA7onj2xMRgLT0h6dAc1?=
 =?us-ascii?Q?yUvHA13dugup/b67w6gdgsiokn5/kau6HNCVzbrsIB/HOjVUBwMRMSmIPdYX?=
 =?us-ascii?Q?smjGsLbQHO3vGM4DVp4RQXz75uQo/2f6w4MlHlNNuW7oD63kMfYwxEXprWz8?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NQ2xxY43zMYpT9zs8ZG+BEkrmvGuEkmPEvr0eKS53DdL7QkM/QF8VT1AeTOgMiicJTJHF0PIZrzfRYMuEBZDFAPp6xnEohBzA+cvW4XD63MdN+Tgoih5j5ZcAurNhYszWHjK7DgHHydpcm94LKSKjk5+0uF+ot38DfusY1JLN+bNWQYSeyElromFseiUcl/ghklquXhbuitDtI4rP3COJPMSYrhJVuWRX/FZV3GGzJyl/CwZy+r0KVNx8cg5vb2c6T2nvEEIl59a3rnoX5smdCRGgSYUGDL2d4kLK2KSURZ3TJ1/4xAzlkmM5kaqrzLJZOpSLI1MT2KufEoVqgLMmT8DHxq4OSd09Z3ZT+NK8NW4cFUMVegjUPl7DRGlxs0rW9eZHu5ioxu5o/FbX+SL3MM/7Sd9Cd/3KevZ5Sboa/VQH6/srirDllVU+xzQm6dksKsONWIHH0zsdGTVP0b6yT61m32LLcET+SoiqPZWaT2RUQh3ctbdXWp8jj2sKyvbvNnYpklhLEB+zLfY3kqucdgIS7bwyIgCwAMPgTaVpuloYeOsREfpbFpQNfvYPEIRluIlhE10W00EiQnut0kTO+lp1u+4Qze1+RGJGuxdlcU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05749a48-769a-4857-1aee-08dc2c5872b7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:55:57.4443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZ2n5w8iRshsoccNMHjPT6AyMKULH04074s2jCRd0ihFZk/9dB1dA7v+hUqHkeCau3jXVAGp7/6Is8PFswd4juIGYazsLJgQ+vQRVSVgtUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130043
X-Proofpoint-GUID: 4mymwDjJQ9DjY87fN3ZM0kNxtkQgaRBP
X-Proofpoint-ORIG-GUID: 4mymwDjJQ9DjY87fN3ZM0kNxtkQgaRBP

Use tif_need_resched(NR_now) instead of need_resched() to be explicit
that this path only reschedules if it is needed imminently.

Also, add a comment about why we need a need-resched check here at
all, given that the top level conditional already has checked the
preempt_count().

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/entry/common.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 5c5befb05410..e1e6d7c92ca2 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -301,7 +301,15 @@ void raw_irqentry_exit_cond_resched(void)
 		rcu_irq_exit_check_preempt();
 		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
 			WARN_ON_ONCE(!on_thread_stack());
-		if (need_resched())
+
+		/*
+		 * Check if we need to preempt eagerly.
+		 *
+		 * Note we need an explicit check here because some archs don't
+		 * fold TIF_NEED_RESCHED in the preempt_count. For archs that
+		 * do, this is already covered in the conditinal above.
+		 */
+		if (tif_need_resched(NR_now))
 			preempt_schedule_irq();
 	}
 }
-- 
2.31.1



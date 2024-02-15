Return-Path: <linux-kernel+bounces-66236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6DA8558E2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 03:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4FC728730B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 02:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5016E1C01;
	Thu, 15 Feb 2024 02:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q68FtFGX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gAHKcPiD"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9F04A12
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 02:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707962689; cv=fail; b=XgRQycJ8PxvXodvroX8OhqYxzQD+CKgotic+FID2bGwx+oaBYtpHLz/1KO/P0IBZoODL97kEW5LKBantMPPwFtBUnLJ7UIBDN3fB4sJzrbXz5WyFpM3ESn4AK0W8t/5LNT+F1waM+FdyPknZbMykFDjlGXPi2CzJ38ix5MbPkX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707962689; c=relaxed/simple;
	bh=AkIcrbVVQFUxGd8aGDM2MH7RLtCQ2cEv8FxNrj9VIwY=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=ZYLCQVSxiQ17MyiFs9XrPXJVGq2SuiFenhUBpAclZmuFtmBxqzuV4BGUOsrgEOIugdCJjFA8vhrqvp0Ez/pkDkS6AHCKDnNj0cFoTanjnRlGFPh0JT9bsLtv7V3Q3YPOkEYUqZldQj0pG7mTLACsoOW/jWqs/p4YH/IaTLmYcmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q68FtFGX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gAHKcPiD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EMiDVg005270;
	Thu, 15 Feb 2024 02:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=AkIcrbVVQFUxGd8aGDM2MH7RLtCQ2cEv8FxNrj9VIwY=;
 b=Q68FtFGXb49etqPJBXCMIJ4MK11vpe093vMbFP9GSnpWP5b5i7evw9OvDgT/jT75pdTj
 YxblJwt7DbDa55U0Do+yEL+K+aOjGmshAbtNNzU6b+QW2o+RJrZ1e/oFipUF8clwME2s
 azhcaJCEPrUY/uRJspzJS851BLpmp8pj2YPPgfZR0YAzqdZRwLuCz1O+TosoLlb0BfQV
 1E+quxGJuIK0f/A79FZGLqqCKxzmCCAMu6Txf0sCVVZFMPU93nV91Ig5PHnvlbkvwIMv
 fDseJNEWSydzrkTzWjFD/NunBIhot7TuzYPWi/jT7k6tkwi8Fjw7imkEeWbNOXRZdupE Ig== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92ppgsx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 02:03:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41F12CXl015051;
	Thu, 15 Feb 2024 02:03:47 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk9tgt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 02:03:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SskfLJ4Z1EUPNtx1VMWy943ir4ggCNnrfig7uTsxEwCjO0NzYx1s+QhHDyk6Vv0f0+56yCA+HH6KVL7NMj7Mok335uJ6ApfTNFzMp+f83GkT38WkFVCbeP3s58P2REML6kUENzO3IfFDZSsWIqCdnMBKqDwu0UquCQ4sPrYJPfM7SPaFGMDanjanYK2xTj/WIsiUtC5/VP7PNMwsJFpXx79d+1FuPEqLyDlCXSB6cMBuw8csX65Mg9rVT8PAPcfQtUDXZ8mukXqDwyVqeDUZifeGcUrfkhJVOn7glphAkT8BJr6tDFPlHZ9XXaTiujUNKMA32R9/69vnduWTddzLPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkIcrbVVQFUxGd8aGDM2MH7RLtCQ2cEv8FxNrj9VIwY=;
 b=X/MiR/uCPT1GEgWOr8/3gFIdvEAd72yGqZXDBf806yFQQWIHtsaL66J9PoqOSGQNNS9OoHMTJpdyb48TE6alcrbZCPKOKLY1K3zVTgOlscDgQm0B/Zwm4nI0IIwTgyloNgtob971JcFx2sSyd+d0JqvB1Jbhco26uQKHfLc38QOS31MVhtRbB2f87rfwFCcWQa0ZjnZYtiLWOO0+S3xNsdCSYUPsLIONzpIOKSo5gUn97tiYH1R/gxCEVCY4fIP9nd6C6+GC4XN5I2BQw/4Y4sboX5wkMsYj5Ep/nD4bup+4+lJBo2+Yco8xuGwKgeJg4r1Te2xvCIn8qFPdK48a7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkIcrbVVQFUxGd8aGDM2MH7RLtCQ2cEv8FxNrj9VIwY=;
 b=gAHKcPiDvBIcHPDcncIhVXyroU5Z9yWxbAigvkmyFrDZIJ8JJSVoQG/xJ08V1lVcTQFNY92X0rRNtv70avBqHDUMF2AiwJpVm16ThahAV5itsTuVR8eObeGt9WWGa0tJIf6o1qnbM+1uS2qEyff5kbx3lWtt8mC421uookgcMXE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW4PR10MB5680.namprd10.prod.outlook.com (2603:10b6:303:18e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.40; Thu, 15 Feb
 2024 02:03:44 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7292.026; Thu, 15 Feb 2024
 02:03:44 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-5-ankur.a.arora@oracle.com>
 <ZczKQceazAevmNtL@FVFF77S0Q05N>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
        mgorman@suse.de, jpoimboe@kernel.org, jgross@suse.com,
        andrew.cooper3@citrix.com, bristot@kernel.org,
        mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
        glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
        mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 04/30] sched: make test_*_tsk_thread_flag() return bool
In-reply-to: <ZczKQceazAevmNtL@FVFF77S0Q05N>
Date: Wed, 14 Feb 2024 18:04:00 -0800
Message-ID: <87frxupjov.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0320.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::19) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW4PR10MB5680:EE_
X-MS-Office365-Filtering-Correlation-Id: d8911b70-0360-4bb1-aceb-08dc2dca56e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	C8LykR4lrn83b1ZaRXemPrMAjOzTvI5fILm2q4lFFtXZGyTc6ZHVwTdDiWmPIQrQ12cASHqk5UoUaxpFgtVeeq/FP99sXsbyIFxb1JP56OLVJoXJ+zZ7a/Ph37SI+x+elwZY/qNJJQxfEwFTRXVLZSc8iUHfrs0PhdNMCSKmsaT1GQG9htlnqG5vKym1z3hnA0DHt+3SrsmnVWRdIDTNQLC0knKrfKiUYKKCv7dLBQG7PzX+5ZCAGnjLAtZLHy2hpEDeq24dY91tn4Iuzh97cYuzsKH7U33ViLMaO6WImaftUJYGIr3rQcXCIhry4EM4jAV/5dpL8o6jca79G7IMnxRNyuRNIc6h+4oeSYXtUa29rNSumFAAbHxmPPNQ466IUxiQ+3K3HCyYueCix3jrAj5NlWwS4irQ5vj2Rj9P+MPTOqX0TnmNXuj3IIYqhTLRsgQTWeCyMt8E/gvbIhnBN5jpH1E0QQOc7k4aHmYc4HrEOo0iRqJdRYO6Si9RN7jBgS6BoF39pMaiX7C+e+p/ACpG9+JkS2uhr1RqpnL8/+g=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(66556008)(66476007)(316002)(66946007)(6916009)(6666004)(6512007)(2906002)(7406005)(4744005)(7416002)(5660300002)(8676002)(4326008)(8936002)(41300700001)(38100700002)(6486002)(966005)(6506007)(36756003)(2616005)(86362001)(26005)(107886003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Bgfqc9QyqPukgLuXRQ3EGw7oMeZKZMVxa0zkmI9QCqXs/SueGmei2OcPi1Db?=
 =?us-ascii?Q?66JpcLgHk8AVnSi6LaWx+0WJdl4uAWh6f5h1EvxTu6ndKZ6QAW/+Vju5oXwd?=
 =?us-ascii?Q?+friRSlFuMc9mQFz0zcnMJXjeJ55ljgt2HtsICc81KKE5m9YdW3zVVystVDb?=
 =?us-ascii?Q?5AUeYa0NiWaJhWZGzGDM6jL1x6zdpJNtRXEdX7nZ6shURGf81/OcH1xoN21z?=
 =?us-ascii?Q?sHgQdg5ww/pFWoCwKMPsvEnfb0bi5SdqFdRXffVn4fZkxtvFHBRj0bq3ap6e?=
 =?us-ascii?Q?sC18yMtfQW6RelYVMJfh6AosZADSWtL61tZXL6027wmesgy95dyz1e4Vyh8/?=
 =?us-ascii?Q?H33RBIPfkLOf2XDP250HNPy+2fBCyIJ8Sh/kkRdHTJHdp03nILf4wzA3TA9L?=
 =?us-ascii?Q?DDrRMj0cDhInNtlrfp0/PHORKoo1EBh+pgN0hul2vSawF9c2A1QDgQCZwUb5?=
 =?us-ascii?Q?Skwm78VtwFkiY98AiHL9IgKeVDPTGaC2rRW30cUwBwBdzxv+7CWFL6SZTsxr?=
 =?us-ascii?Q?XOFkmk3r/Ss8DWIySM4tQmtjGmjDa7R3TlIisLYCNt7mkpMBtDsU0aE/OLiR?=
 =?us-ascii?Q?ycwdsDxLGq5sQvdzl2tvaT3QBb+m5lkGg+x9oUItA7AvG4NmFQdWJfhXc2RO?=
 =?us-ascii?Q?CsDa4DfuCr3z7ffeFg92l6gwuWG7ktOiYY5eDfQJBleXYTXv2wBb2mDwU0Vs?=
 =?us-ascii?Q?Kcncqb+xj7Z8qiFveCZGQ4O1+2XkT514FNtKiqkBoDPQvhIKMJXYWVtxfsvJ?=
 =?us-ascii?Q?gKKzsuna7E9WcaZf5Ehtv/OAUFMp8GrkBfWCgMd0klWRwWoMKFaue2GvNAwf?=
 =?us-ascii?Q?NuBlY3RK5GQQ7SP6iGybNDTsJlUXlZd5p6hNHjKWa6CdNGpMNIbgYqnHvRyH?=
 =?us-ascii?Q?CBU7mQbpnwS3PN9O82quiP16raP/2ZlxX0HJjWu7rjPejmsKGEUBm4GLtw7W?=
 =?us-ascii?Q?n0BozgJrjiFRFuAIxfKUkJ9o/hy3UhirMpNzBUdr1AojePAWhFHPsMpO54c6?=
 =?us-ascii?Q?mB+Qp0cAve3GAV3G3XwMp3y5TKnw8OtXzkiFImcNeYPS57ugfTk85B5LGyJo?=
 =?us-ascii?Q?mxWnbl+ta8xgXv3Q6IhupU2wY/JxQUm9Dsl3NdJdZfBz5nbFwp848tBsb4Yf?=
 =?us-ascii?Q?0ulcmcvdmlLYxl89FofBqcpSV81gg7ftvCfCDPcM+pZZp86BysVdmToj3uCC?=
 =?us-ascii?Q?1UrIWx+gGPAVrc7WtlkMtyf64Wcitgr5P71fq6gSGOHGl9+Bl8vgyAXFaEzd?=
 =?us-ascii?Q?RPbZ4XYXHRTkVcbNBPP+e9GkegwWuhDMGHN9NG4+QM5HhEKPHsP5uSKKgvv5?=
 =?us-ascii?Q?/TY43b0ZDGxq9gEzMiDowW1mir1WG1vuUFXV85I7QrPGKcxxddRO+bqTj6gk?=
 =?us-ascii?Q?XGzinV/Dv0SrX3TKLw2px+bbQ0fnqF/pz0GLLu6SfwI1cmctwtDSQjJkPEmG?=
 =?us-ascii?Q?kgoFMf6WWnLlNE1vEXxVmk9UbNeK2dxhVxojt4JGTV15EUGU9lduSIngKmBQ?=
 =?us-ascii?Q?xqzk4OF3TecaeOO1MtA7CHoU7LpwvLZh+/4kO3LIipm2Jc/v9jvYMOnYRI1a?=
 =?us-ascii?Q?AzEzdOjjc8h+YaBwkkypeP+v2IGTi1nQ5TD1c75Ll5fEOqE/+MYKR/xPLMlh?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QkMdI4ovn93aiwXasHGjv4zs5F3E3+QHycuX5cVnMAxH1GAJEOe9YWUftySYB1NMUqnGXJ+xaTf/hOcPwDtfunsdXjDD4WT3zpZlueccTy3Lbw9uMgw69O81hW5Hwgd3sRBAZHU1UqM2kx8l4yyCA5h3AHIaIJg2jfp4/csArkTaHMsy32YUs/auzs1efh4mNNxi7DsFyXVMAR29PGIwG/2OXQd0tgQ3wzMp8vuTdHNfigdZraW+UnTGAWb1lbtvO2CDEwPYSKXnnEg9TFn1L/8pIO3Sw1oa7MF6TrmYcZsULcZGyyKLDCzt2Z6ESsoIrub/3JwdN2q7QTA8igzcAaM4sph2kV6Vb+XHoVOCm9SFNNpyO5hD7iyUaq7VBvjw3yuC7dnjCQdECKNMDwK8XMnTNqYT3qN8Lf8gDPmncrr5bolf0//6l6Us+5b5bL4+uoUov5/5f5gS3D89CaFBwtHGltcS9SR0R1WuxVu3SC++ZONHaL4dpU1PIT/uJ+iMN83ZIRxaBWr0xGuDR6/nVjlNRsT72PvTXFpF3KDaGBJVUlNr6Br7xyUJ6EsQAfhNBUzbfp97UiY7KygurpOph6DluaLI2ghQ3J2tL3Tcqes=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8911b70-0360-4bb1-aceb-08dc2dca56e3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 02:03:44.5277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K4Fnlw3/9MMiz63VdhJjHoaXdYt2xwONzmLv8gqkutTx2a5r7cP9FnKrnrozbRudGFVR2FJhYmeCWEpiGDfTRywSOPXx8wmLBdXzuHn70a0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_02,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=909 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150015
X-Proofpoint-ORIG-GUID: I26_ZiUrkLNwPRfXrzW-P3Xqh1Ilqs8Y
X-Proofpoint-GUID: I26_ZiUrkLNwPRfXrzW-P3Xqh1Ilqs8Y


Mark Rutland <mark.rutland@arm.com> writes:

> On Mon, Feb 12, 2024 at 09:55:28PM -0800, Ankur Arora wrote:
>> All users of test_*_tsk_thread_flag() treat the result as boolean.
>> This is also true for the underlying test_and_*_bit() operations.
>>
>> Change the return type to bool.
>>
>> Cc: Peter Ziljstra <peterz@infradead.org>
>> Originally-by: Thomas Gleixner <tglx@linutronix.de>
>> Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks.

> I think this makes sense on its own regardless of the rest of the series; it
> might make sense to move it to the start of the series so that it can easily be
> picked up even if the rest needs work.

Yeah that makes sense. Will do.

--
ankur


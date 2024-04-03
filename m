Return-Path: <linux-kernel+bounces-130621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 349E4897AA1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E261C286F15
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0F915667C;
	Wed,  3 Apr 2024 21:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zi+U7NFX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rk+VKm2B"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AC82C683;
	Wed,  3 Apr 2024 21:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179537; cv=fail; b=UWuk7tDw/ONTBxyp/l0E6D5dm2e+P8QxPDaWf99xcm/tCWcX39+xIsMPunaM+0NJ4fZXxsPWW+cdiPIOxUBqKpibiW0bEzOqoDLk164E+Jyb8KpXmNIFf2EHE65jeOPN7rlU368HLEqL7qqVPv2kZlr4YejDbuoLuJshjWhLm2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179537; c=relaxed/simple;
	bh=1CDknonKj+ZHcFEZTeW0c9z6MRz22QF719KpEptduDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RXXaGK2hg9QV9MbLZjtJ7CKnxEYtF350dsoDvxYgNcSFV8ius7KAA/xYCrlb4Ysm7a6RgQ8ukovPUxnuUADsVtXc+HaLoISUJXcO9KrT+HxyvX8muIL0eskNRPYrnGVxmaeC+1eTMXPBstfoJ8oPuDA7+DqXYBRID+MYkdMFBAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zi+U7NFX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rk+VKm2B; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 433LE33O012593;
	Wed, 3 Apr 2024 21:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=pILTY2eHVX1xuOgXaLuMVRS8111In4WAT/kKUDFAbn8=;
 b=Zi+U7NFX6a2JihKvjRyqMQwI+Y3wMTCAsyxhsjGYJ+wKw9MZyjUiwr6a1N+IECyV6QyM
 MhJC3nyzE0gC6FSDVE4qwChDyh62R2AHrwKhrN8itIPfZhhOn1q6vjGvzbJqfYoo//WJ
 kn5rMZaMByKa1h2qCAY80QyErCV4c27UF/uoKE3xeMlx0McnGV/296uuzseo0d9EBptn
 c+OmTrKztXFAXo2jPkOFlhjxFm+AslDqythgiy0IBR55qDMzvd6JHU9D8cj3Uxe8v437
 J6hJHC4BS0dyXQdI4VPyg1HGSeU+c2c0N/tsT4LoRqBItKj2qPa6DTyEkQu+E/KPbJFg NQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x9emtg1eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Apr 2024 21:25:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 433Kx5b7024310;
	Wed, 3 Apr 2024 21:25:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x9emkrv16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Apr 2024 21:25:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3BOCeVbaZ7Fl05fyyDgdhmZcnH5HpVRkHx2g9BEL0rZj0YmK9NpxDMTKWMhR+U1/AJ+6oTPLBoMOPl7jLWQQEgHUr4ol84NNCgP1rpqTmRBZTqpOmDQ7D0rHIC5BqylnVO7AmJndbREY7hiFuM8WduU4vi7520uKR2gMSp4DHoYPHhVRR2IAMuUNkPOXtpJzawDQjyMnZj3MJg15SRPJULRZ8cDFEBmUiFyhhzv+fxc5k0CnyuuLMb0iK5hDw4B6Ig+CK5FShWPyrgC0YakcU1w22Nho6WkL6RIzMpW6ELXxmy+7uXlL9ajbzQV3oa0Tlkcgq2mlHMf9J2Q6ERo0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pILTY2eHVX1xuOgXaLuMVRS8111In4WAT/kKUDFAbn8=;
 b=m2Gemig3xM3dPMrMtLkWcoc1yed4BK/izbHD1sqXCA/DTqPZGs4n4tY/EehHFZgbY4Ket2VN5FUY6RkNYLGgQV3SpFQVVjcGdRoiYrR/zMItir+8JqtvNYJqoFlH2T1s1+9faAT9rKRPQpUwV5WDFz857kACWtVKweHmpHbo1n9mMQKPMaY3gLVxYm7ySD5+UgOLyXfobOCq9TygBHGkJ9/z5yeCVvVok7HjlxZ0YVEWXie+87o+DqQ/FYLfxR/CookccV7jKxv3lv0DBa+hpKFYZzzKehMIbe+3tcjsIvbE6Cc7qHqUw4g7JL6E4/+nB+noHHbE61xos56ihAP24g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pILTY2eHVX1xuOgXaLuMVRS8111In4WAT/kKUDFAbn8=;
 b=rk+VKm2BKnDZRhpe3nc9vgFKJ7mhwPbZ93d9TUSd6b6PHfgcSz68jYiofNtNDC4RfAmpBS/KiZZgTMUJMcOTGnYtu6Wox3IzekqDEb/knCSchqs1uUrO1G0UP3KUT9/qc1y91G/hRrYRmEswdxtEicOnct3GkOdKGVkwMpzsSto=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by DM4PR10MB6157.namprd10.prod.outlook.com (2603:10b6:8:b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 21:25:13 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::310c:4c5c:d1cc:9443]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::310c:4c5c:d1cc:9443%4]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 21:25:13 +0000
Date: Wed, 3 Apr 2024 17:25:10 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: syzbot <syzbot+0cb5bb0f4bf9e79db3b3@syzkaller.appspotmail.com>,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH] padata: Disable BH when taking works lock on MT path
Message-ID: <w6w5o45557hrsdgwzpxa7fm7o3nufptc5eayymk4luarqsxrdd@qj6tpurky5uh>
References: <0000000000001963d306150986f9@google.com>
 <Zg0jEu5OsZaUFzn0@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg0jEu5OsZaUFzn0@gondor.apana.org.au>
X-ClientProxiedBy: BLAPR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:208:32a::12) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|DM4PR10MB6157:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Y+pihWtt+wBltHruz5XCbtIzINC6MSvqhQ6Y7unhX0ToASJI+9+C7DmgygxQpP2G4nbV4mhM9QZgrt8wLxe5ApoN17HOCM90xFV4lFFveKaadGQpnELTCW5fuCBe9Xnzt0Gq1RkuadsRa3zv01SiQCny80+lyVf2Nl4cp6ahAY8aPevXlKrEgezreTbh8objLzmF1zW/xb7dpPS6fep3Iy4y34nPRzsH5sU4gUAg+zYX04R5EPJIXXtM48gwBcJhRAS1a2hfw4JdJnZ0K1YmkkY4TdUrsEXxLZcBDt9fC3MR2dWYFml9RbBcTQwXCJG3crAH1HnQesCAFipK5UiHWGZ8LAKhO1cDITRnNnlifcsk3aEDZHAGLwKQ78h/6RJ1HPzOSMO3I2rHhDUj6uIsYCF850AAltc8E8NOj1R464dxCzN+btgCjxxOoZwPsuRHlAFVFySL3L4Ypdd5lbx3KUZgZr10GPeFlZPTFQIQnNMOppIa8/8L3Q4188NufYym0m+DLGdEzima/oONxIBIrBqeI6hbiFt6oebNx/PrOPuvj2VSnHu4DDkQSOzxhLxpV59ZN08IwMmPAy+N8Ro+jcfuUYzMXL9A4NxqpIn4hAIV3MD+FmWEO5WPagOGCjJS
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nixYd70Z7oTAkTizVpgBFs0DCDiJAzQKrHf/KunDH96o7p+blxrhhHW/UJiY?=
 =?us-ascii?Q?/4wPhEoVmHMEz9RgVW4do1LKerayLYd2KE9TsWGuJaBDVlDuMfXkbxs9N1dm?=
 =?us-ascii?Q?H3xvy9GnX0oAneBr0sivNnHzsPE9qVYB4m7+mm3Nksbe7lXf5CgpMgXrGmnd?=
 =?us-ascii?Q?2AM0qfSCcY+KDg5ek0w79bnVIAiRynDMZJTUQCjjISwyl3TyQTbkDtE4BJMY?=
 =?us-ascii?Q?O7u+Br75+9jhu0az4Iw0Ws852r28IuEXkFdbVvfTd3vQ3rXUqT0pmkTvDpTJ?=
 =?us-ascii?Q?YRLtGUWcsWweGxm4TWYXVn4Ba0rWJMxKo9kg0oiJe1+kQGRKuiBy3ts0iapU?=
 =?us-ascii?Q?ie17pKLjNk7h4QX7tURsPz75e421wHkAJNpsajYV4jdv7/JXyljSCZkyjApS?=
 =?us-ascii?Q?s4Fs9R9+uGxkjCk0pAAe7PdiKPgk0vXt0FwShiMBf5QilWQSypD3GyrJMqkT?=
 =?us-ascii?Q?oLxXejfX1QZkizPx0DXXCLnWuR+3HK+oNzQw4AKwJI42fRPM8vqglfCeAcgU?=
 =?us-ascii?Q?7psbcLIIiu8a6lt75WwyGSLfaTtD44a1poHV99wek0h/iapfdZ8kqKX2V+ZO?=
 =?us-ascii?Q?ZmRDXcBz3WqPYQpYBc0F8fEXeNZwX2i5Yf2NJlDyu9SmVJ9YHVHl5Vcz/CJ4?=
 =?us-ascii?Q?m5OZHaiieNYHTlDF8epho0BRV3dfCbEXFPosX0RYIV4DJWkRDUgGm2ohaOdR?=
 =?us-ascii?Q?c9pWl0p9DCb3PbzkSp8DrBu0R6s4vFG+Jr2Xrjspj9qnxg0ZoVE9U5kIp0JF?=
 =?us-ascii?Q?idizfwPX7BX7heH400Dfdy6/DYcAUOFPgGgP5Ho5Z3UDdztUxLxSlspmedB3?=
 =?us-ascii?Q?bhYcbAbsKM5S7aQoI89zRUMuxnxfpP/Pne8Tqfno4EWD++BFQ5P2/5ENN1YV?=
 =?us-ascii?Q?Gz2zF0zmIF2q6/OAa9ZShkRHQAIwbgrV7gSg10USknkV3O8iAN6ntTOtnOvz?=
 =?us-ascii?Q?R7n729rFiCk5Sb6RR3LSAS17ysiXScicaUQm7/Bt70nw9xchWb2w2/rt7wd2?=
 =?us-ascii?Q?XPFoYOcBE40G/dGon0FUiJTsRIwJBQ5gqX9U1vM+ObKSGkSjoBzJsY14Q8WM?=
 =?us-ascii?Q?pPZyTrq2M5igBH6qHF9WOAPzsAzILdRNrV1F0+YrNlO1F3qBn0dHC4JG+xcL?=
 =?us-ascii?Q?FWplHpt4AA+c+rrEHY232TrvZth1L8D/zpAc0x6X1CQ+1Wzw6aXCZgWqFQD2?=
 =?us-ascii?Q?gNXhUVQfH7SCPPU+zgAQWVkp+abqIRLBLyBVlkq3Q9InPATF3t3cECQKu3ha?=
 =?us-ascii?Q?cRARTKS4FRTkHXkyFVnM4KIDP/RdWyyq9Lkve1eNax0XDWwsnNlCJwaeN4tT?=
 =?us-ascii?Q?Uc2TSahD6+o/6VSwNXxwCSqdrbJUjl9K0y2lmZmb45xe831lK0U4SWsQvk8o?=
 =?us-ascii?Q?rg/QwKYDtVWC877pPbzVQ70QcSVfoLUHrlXxoOxoQZpK8HjyayAkcbT9Xhch?=
 =?us-ascii?Q?JoPhCsYBPO09/39ZNIyYUfFKFn3DH6KfeYEVVfJhMYiX4y+FeGoJbXy6gy6p?=
 =?us-ascii?Q?ka0MvHfvvTidATR6vh8M6tzUS9jhsFJlB95RlRZ4tF5SIMj2bH9zscCy11F3?=
 =?us-ascii?Q?U/xMAWomgggvmP8b7Cc93rGK+GG8lirVVJD3MJhFLdwNjas5fPp8q01alTG3?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Xa0AjCaEioB72PjcdbT/JWZqYHEB/Dwt9UYOJs5xYU3eXkLLuVVPIrdb+tUWe26ucDPqMsn5whVYW13N/lMgk04qeJKQZ+yYFJ4cioKm8h3eaYBU8gYWw5XoyHCPJtYT0Zth0cM30s/5SMcfF5D2tgUZJ8fZ7kXJvDlHrpbVWfhSW7LZqX4nIJsYWh2i8UmousfNFe4WpjDjzXBXvpvwySrZZKBoXOQyie5WD1BllW/5Omn16FsfmauXHTZm/dKzEBI94yn3efodj6jzuAggp/8bDJ3OJUlC2VrJ2N9QTdPZ9rgQ+V+Nte7daxFh4fysGsl+Rv6843UlHV3MSmOCJMWEfcxaZ6afzLcRBgdO2wzKAtGxPs04rxx8RLLqAjCzSzIWsadmzoT128EYG2fmoUebjxpopx76sexYWFMDzvlRZ+rBIUZ0W3zPChFN+wl86QbC+ewK1uZJrG8iqsPk0kG7vDR6FwWySn5REP+6BfGAhCFa4Sx4+vf6Y/U85Mk2PPWZOzYYcFz6d9QXtFFIzll8v3RdF7T5d66zdPIQiDNRYZssiAqa88aGLVXl2PZI0AmAQKOHsLIXK6+Xj2dp3aTy/3t3aXfaCd2N5McrhaE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26e0ea2-4cc0-4e96-8d60-08dc54248c96
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 21:25:13.6392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSW95c1AU14naKa+DZTyq1oep7YhfTcHHyU6b3U+inhEcHeWBosnys5ziqbi/hoGuqC3qk88FgV8RZSbVwsgiBlCHMXk/0vlL9za8ZzLoJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6157
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_22,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404030146
X-Proofpoint-GUID: 9ueKH35U0YRgdINu3mkWrKNyy0c_LoGQ
X-Proofpoint-ORIG-GUID: 9ueKH35U0YRgdINu3mkWrKNyy0c_LoGQ

On Wed, Apr 03, 2024 at 05:36:18PM +0800, Herbert Xu wrote:
> On Mon, Apr 01, 2024 at 07:08:28AM -0700, syzbot wrote:
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    18737353cca0 Merge tag 'edac_urgent_for_v6.9_rc2' of git:/..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15d605e5180000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=f64ec427e98bccd7
> > dashboard link: https://syzkaller.appspot.com/bug?extid=0cb5bb0f4bf9e79db3b3
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Strictly speaking this can't happen because for the time being
> padata_do_multithreaded cannot run at the same time as the old
> padata which occurs in BH context.
> 
> But the simplest fix is to just disable BH:
> 
> ---8<---
> As the old padata code can execute in softirq context, disable
> softirqs for the new padata_do_mutithreaded code too as otherwise
> lockdep will get antsy.
> 
> Reported-by: syzbot+0cb5bb0f4bf9e79db3b3@syzkaller.appspotmail.com
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Acked-by: Daniel Jordan <daniel.m.jordan@oracle.com>


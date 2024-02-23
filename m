Return-Path: <linux-kernel+bounces-78481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1988613F3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00DBE1F24611
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2395C8003E;
	Fri, 23 Feb 2024 14:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ObA29dtD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TMwTawUo"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD655D73D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708698594; cv=fail; b=QMDFOeFIuvlas8H/gyV1aRFegX/ji5ioOWFAqQSGiXjjSFyMxpff2O72iiyopxJTH07zi1lQYuOZKKZWmiDdu3UTKDMQd3uB65R9K2xeOtZgBrL2K77+VNKFCdawAP1KK893PJLLlOw2ziI84ViRA3TzjToQGO2bWMeEtXHKWrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708698594; c=relaxed/simple;
	bh=wbz9w0k4XsrTCUcmdn3amvCUyWXL+czI3zizFntd9v0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K83QVhiIQSlsnMqAqoi/7Q8l2EHQCLUDqcICk34WYsODJX9cPsQrVYCvHDH586VG9DJDe5JAVDnYcEWHO2YXdEn2CXtBresCYsp00KbtOmZCObpVUdi+u4Mvm87eXFWTfAN8g5dKzUkoVgU5sDg9ITYVOYd70UgxE0PhbR2rghE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ObA29dtD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TMwTawUo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NEKH3F027883;
	Fri, 23 Feb 2024 14:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=em/Uql2KUmvTr9Nlnv53zuKmDktwjCWcECVt7VwH4Lo=;
 b=ObA29dtDDV0+zCoBX0oAFN9wAJN6q3bE/Q+jItwfiWzW1w6kgHmZg0RiEnq4xK3AiZwp
 cAE8ie2CQwwcKPdJH3Jf/vhfVuznZd3oWCGLagEFaGHeRMnfxNWJLKE2etdkw2Ha8q5x
 bog9SitVyNHSIJ+xc+4wQR4bRXyyqsulyvjMMl0wLwgi3J13lJQDSujy/qleSDCvSZBe
 DLAKYTrWrIXIS6huoth3Py8I49VWC6GLLQaH5oDXmoIDzj8lZiFlNYkqstOKIL3LaPqc
 eimpActBxH1THqKIHzkDkL2kyS2cf+1x3NGhID0b2cjPM8r4hQrDIp+fJXHMp89cV5Ny 3A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wd5fw7hbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 14:29:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41NEG1Qm020293;
	Fri, 23 Feb 2024 14:29:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8cd1d7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 14:29:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9zBLS3z0ZRUbi5MS2f+ak5bTccjCIfPVFM4uCCYqZGxYC40MIC6O+ROOmjOqDHRuXT/y6oeJ2PjR/WzXuj3qpakRPDo0SACt59nYlbL99Xk8ExhfKMiKECBhUIRBbITbBregp5SOeebgFuPVAHOW0S1MB6PSJpY4FhUPc2y7iuUD44BTCrsfyaGhuHLyBmnvMPkwq8xZOX3P7GiE/TTdUfElylOXuePnu3AjPGtZBFwGOV+GaufcL0MqKQVow859FrISlXk6hdD2+gQVlB9xI8+flR2oQkz2Qe28oFe4DHTbyNFJPhLE7xfViWJLnopIiS3pexIvG8P5Zhz2j50Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=em/Uql2KUmvTr9Nlnv53zuKmDktwjCWcECVt7VwH4Lo=;
 b=PIo6sRFu/ywiHeeWhEf/tjMjMZ9C9bHFOB55YSsv+WKkflmbR2zJaF4ImO37FNPMunugW0/L4Cthq6qoJ50Lz2STk+S/rw6n7zNQocxaMKnbf2hAoXJIzE5p/n91ShU+/lCXPeN/mMmUJPPeKwO8CNUeeFj+2bIk2XL15rA8/Oc3Fi94FzzK1Gpa5X5oxRfKt+fWzQTJpcbZJ+s6conRrbz0uK+i5K3YgMdJ085ast2gyyCXFJzgMP+Z0iC0Yf1ZX07WJqPSzzQpc5xhHv2gYH28+/6NFBshjRRM1d2OjJoiO4U4FC1sbeCtjLXSnfIa1GNEAjyOxjk3TEKc72sKxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=em/Uql2KUmvTr9Nlnv53zuKmDktwjCWcECVt7VwH4Lo=;
 b=TMwTawUo67aSIjVKup6VkBTFoJOgZCK7d8V5RcpaNQPzt3dUK1vCRY4WY+h6xUymQLv52dHugVlusDdZiyIWcNUx+33hwMOdpNDUTxbkv/zhA4/MaqGZmZHvXtMvDPD+fUA0zucMgB+Oqn6FlXWTKHdt/FAnving5vw7+GbJeuA=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by CY5PR10MB6239.namprd10.prod.outlook.com (2603:10b6:930:41::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 14:29:22 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::3dc4:7751:97e:42a1]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::3dc4:7751:97e:42a1%5]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 14:29:22 +0000
Message-ID: <51483aaf-d64a-4eee-b256-ab126483ad6c@oracle.com>
Date: Fri, 23 Feb 2024 14:29:19 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware_loader: Use init_utsname()->release
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: russ.weight@linux.dev, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org
References: <20240222145819.96646-1-john.g.garry@oracle.com>
 <Zddt-U-6SdxkxqmD@bombadil.infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zddt-U-6SdxkxqmD@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P250CA0030.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::20) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|CY5PR10MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: 9635f957-59ed-4b01-f33a-08dc347bd3db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HBa6Eh5avYLBrNxmlwhXSrO9+vgBNBCd6FAIlTzV+AFjEj0tp9XNp404lPWILMCjWnFivuTYlNMvOMiJO5ysIAHKiCElNdL5E0VhNV4MfsxHjtZXrjHdzd3PY2X64/va/lcd0TkZpB4cPXt22feJwi6CWQ51YlsUBrODC+ZGT+iG4zdpRkjLozKFf4DXNK7WjN3CrVTXxVb82EMMTUV68fqJpNLBBkaXv08/T1sVOliNoZPeGtwRTG/XXf9vCtux/obIvts52JvfMqNsjGYnC8N37SsJwWeQTD0vDVfqAUb6pxJr5HOiXbEzsep6tcs9Z2/ZOYA779+KC8TfHsFZkWVj0pntMt9C33weU8rTpUtFGwtpNZ94fkZnjEWUmJyEymSoTgQCUrL9HUf9DE6ei8c6uB0pm3UcesDtaWi+DKKhFDHTuOQYDEHg2v4j+QIASkXw8JY1m/qwOW/PzpUwAEoPM0M9ubE9eueDGIPnrsMrCPtUF03WmpuE2lJaEzZpU4V186lw2l4y7au5rlFgsgtjnVmXofJaC/lqHlvygN8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V1ErVStXK2ZYS09QbkZKT2dMaFptc3BNM0syNThBeGY3YzAyWE1YVGRHcFNm?=
 =?utf-8?B?T0NkNTdjbEZOVWpQUnY2TGkrY1pPaWNrdFh6SkhOeXhyRkRkcEp0aEJUMGRP?=
 =?utf-8?B?bmw3ZFFWTVdkV0ZGbU5KcjFNQzJiU1N1TExvYWQ2Ty90cU50UDkxVmFuN3li?=
 =?utf-8?B?REE4Y1psMjhNQ2ZwOGJGcVFZVDhGK2ltOGV1ZFY5bU5YNDlGREl4WmtuMks2?=
 =?utf-8?B?R09sS2hKdExXblU0VXBoWHNZZFdVQ2FXWG5EWGUzWVhacUNGWE4xbkE2aVM2?=
 =?utf-8?B?dnluYkpZMU5XOVJiSldkYm13eUxmclE3djBSYkhpOUVlcDRKVnJJbHRjb3dY?=
 =?utf-8?B?K1dWTzl0WnFHWXIrY3NDSCswRHhmaTdXcmNTV1N3c3NQdnVrS3pjdWxxQWtD?=
 =?utf-8?B?UVJaeWJMUUdDZXNrRHBRWG9TdjV1ZStMcHZNV2hHbU9PWml0b1B2SGoyeXkx?=
 =?utf-8?B?M2kweUoxVStLR1pNMnEyZmV2bzIvWHQzR0Q0S2ZuUUd5ek82MzYyUWcxaUE1?=
 =?utf-8?B?WnNhSzNyY0VaWDhXMVlWRnM5MjVTQWVGcU13YzlIZE9tZTNOMGRhei8zcFow?=
 =?utf-8?B?OGtDcXR5VzE0aUhzOVh5MXR6YTZ2cEZwT0c0R2hocHJyR1JRbUNHYlJnNUIy?=
 =?utf-8?B?b0J4T3BHQUpGd05lUzk1bGRHN2dxTDZiOW4xRXMxWWxJWExFZXpIQXJNTENR?=
 =?utf-8?B?YUFCNVlMWkZFYkRBZXBueGR1QWRRVEFPQ0RaZ2VrRjJ3TGNML3JqbW1lTHps?=
 =?utf-8?B?eGx6NndiOUVtTkRmWFdOcjZqZGdLT0pVZHMyVWtxenpDSDY4dk1mMkwyMXBG?=
 =?utf-8?B?eEpVeUw1RG5JREtzOW8vbmJNMFJxbnFkUFM1cnNIUkF4UXZzcVJCaytwWExh?=
 =?utf-8?B?NGVGbXFtMXd3T3VOdXk1ajh4MFZNbWxHSFdmbTlzMnZSVEZ6TExubVNuRGN6?=
 =?utf-8?B?ZVNpTkROZHhlUm1Ncm1nSTY2S0R4YVVIOVo0N3JXYkc4bXRsd0VQdk1KcUtK?=
 =?utf-8?B?QUd0aFZiWXUxQmdGbkZOeENBOFlKbUd5RVljSEtQNG9NVXBYSGZPZDgzR1VF?=
 =?utf-8?B?cjArUnBmeTVKcWIwZlYyZEJUSjlSaVhVZHZyaDhSVzlsTWF5Z0E4dUJFZmQ5?=
 =?utf-8?B?NEx2ZkxmZnZWSjdkckJwYkVJVC96dUxFZWxuTTFtekhzMTF1VUZzQXFMNEdM?=
 =?utf-8?B?TVRFamZXSWJudENSQW9pZ3RDOVdIK2hpcjZVUXNOUUVvNVlwRDdqbzA4dCsv?=
 =?utf-8?B?c292SnZFZ0NIbDRNV3dTanRONmxxR2hkYUIzNitPdzRueVo2cTBManFEYmZr?=
 =?utf-8?B?OUxselNIb2JrYmMyUHlXNTIwbytGZ2pFbUtrZ2xIT3hHSm15akIrQ1RqZ1ls?=
 =?utf-8?B?RmROM0pmTE5pcnhhQzlpVm1ORUR6eVNDRHNjby9nQUpub0tNT1dsUE8vRW9Q?=
 =?utf-8?B?MklHckg5NitHZll2SGQvalhNQW1qUkFWL0dPTUFFTTU0cHNyZDhtbklNZHlo?=
 =?utf-8?B?QWJ4dXhSeWtZUkhRcDQxM0lQcUJOckkzVEtCeTNjdmJQaThVMitia3ZzMG9o?=
 =?utf-8?B?UHV3OUlrMjZzUTc5b3F2QmNvTkxoZ0hiZjJFUFR6UkdjR2RVdldFVVI1QnB0?=
 =?utf-8?B?NVdOWWpVaHJYSlJlUGZwcWtnUWZsdy9UbVExV05vSWh0Wk9zSkg2eUt1ckN5?=
 =?utf-8?B?T21HbC9qdENsaDI2OFFyUmw0VEp2NXQ1bWl6cXdOR0cwc0VVMjBzSDZlOUJX?=
 =?utf-8?B?SnQxQ2ZySDJ6cmdMTGpjSmJjSkdqSEJMZ3AyRDJGc0FpalZUdUhyMFBiN2Ey?=
 =?utf-8?B?Zm94SVhvbXRqV1l0S0lzQnZqU1R4Z2NQNTlrUW5lNWliWVFNVUZWWnpmbUp1?=
 =?utf-8?B?TW5iSFlXbkVLQ0ZKR1NUclRyZElKSkRpNytvWVFOdVhyTWZ3eXdhcE9OYXFU?=
 =?utf-8?B?dnpHVFdxMDNMQVFidUgwUms1SmVnY2kxMGp3dkZMWUNGbExybm5HM0xzakc3?=
 =?utf-8?B?Um1yWDdZUzMxUGFKZGd2TFRSRXNMcW5EZmlWU3FKR2VuK1NXODc3M3N1Zm0w?=
 =?utf-8?B?c24yMFhJdUZmTHFKTjVlVDNSOFdHeFA5ZlVBU2JKdVpEZ3NCWFdDcDBLMjBw?=
 =?utf-8?Q?wpcL7F8iniOOhhobtUkHzxYSf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	uc0r5Ch19E/v7UTttI7xxyek6KXTvy2/o575Jc2m0jTipVHgP4+/0KBNqIkLlbzDZ6G+VRggdQolpRFJl4HDLzYUtfL5igJVffOJCx5TmXVsOXpg6cIzj3948rqbRPuwfsLcYqN1N1zSdSPJUqvBIK248xYe+ErQwwo7+vETeHM+Hdw5yrDHK9x/lmf2ut0WnVhs/6IkNzpld7nEY43/zfAb++H50mWIuek5oor4hUbWSZf91nWEqUpKsyIHo/b/1NrHcG+8WhkgzJWYcx1hebwtTBQlBuYczbxVjlefo2MWfVOIQMxHcze98hwKhseA+6BKSsqR4p4GswJ7Fk8g9ideOGdMKJ8oTpKe2Ko5CeVvtWAW8KpD5FgJ+Oydj9wN/7UM4QmJu7a8O1pOUi5695WnNYXRDAjJqILLd/rHXJlreBlCY0j7oB7CI38aUjwsR/46JJLBNQ0/FlsKNNtB0JdXW5OM9kKWwtYeo4QBQQ5Nz/0m/qWce7HwaeiR3uOGuYgQaVCQvgp2+PnxvQhbng/YTLEuuVc+54Qm1yjLwPbwrEq/fNJ6ND2EaoyUiZYlzCV7v4oObB+8HiUGipx0FKleIcUiW4y399CWqiKsa9s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9635f957-59ed-4b01-f33a-08dc347bd3db
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 14:29:22.2155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Zk9yN+lj+GN1hbF6k/dhIlgJcCNHWG4UYKWhJf0+68zdzVoF7pTAIQSrSMuX6vr1Nej3+DltFi2jNB9gcstVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6239
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230106
X-Proofpoint-GUID: iZy8Qe-hk7CeVh6M11eFuPoFLEQCQ8zd
X-Proofpoint-ORIG-GUID: iZy8Qe-hk7CeVh6M11eFuPoFLEQCQ8zd


>> ---
>> Note: As mentioned by Masahiro in [0], when CONFIG_MODVERSIONS=y it
>> could be possible for a driver to be built as a module with a different
>> kernel baseline and so use a different UTS_RELEASE from the baseline. So
>> now using init_utsname()->release could lead to a change in behaviour
>> in this driver. However, considering the nature of this driver and how it
>> would not make sense to build as module against a different tree, this
> 
> would not make sense to build it as an external module against against a
> different tree, so this change should not have any effect to users.
> 

ok


>> change should be ok.
>>
>> [0] https://urldefense.com/v3/__https://lore.kernel.org/lkml/CAK7LNAQ_r5yUjNpOppLkDBQ12sDxBYQTvRZGn1ng8D1POfZr_A@mail.gmail.com/__;!!ACWV5N9M2RV99hQ!KxnFzsitgB8e0kDndt3nYwqw0FcAPKzJjuRl9BzwLQ9dbAtqK_SZOkhHw9ssT2PobYVkh8UU7WryWKwGXg$
> 
> Thanks for doing this, could you send a v2 with the "Note:" removed but
> instead include that blurb as part of the commit log as it is important
> information to retain.

ok

> 
> Could you also test the selftests to ensure nothing is broken ?
> 
> ./tools/testing/selftests/firmware/fw_run_tests.sh

I am running this now, but it does not seem stable on a v6.8-rc5 
baseline. I am seeing hangs. Are there any known issues?

This one passed, it seems to me:

https://pastebin.com/ZySPmH9h

But then on another run I see a hang at:

...
Testing with the file missing...
Batched request_firmware() nofile try #1: OK
Batched request_firmware() nofile try #2: OK
Batched request_firmware() nofile try #3: OK
Batched request_firmware() nofile try #4: OK
Batched request_firmware() nofile try #5: OK
Batched request_firmware_into_buf() nofile try #1: OK
Batched request_firmware_into_buf() nofile try #2: OK
Batched request_firmware_into_buf() nofile try #3: OK
Batched request_firmware_into_buf() nofile try #4: OK
Batched request_firmware_into_buf() nofile try #5: OK
Batched request_firmware_direct() nofile try #1: OK
Batched request_firmware_direct() nofile try #2: OK
Batched request_firmware_direct() nofile try #3: OK
Batched request_firmware_direct() nofile try #4: OK
Batched request_firmware_direct() nofile try #5: OK
Batched request_firmware_nowait(uevent=true) nofile try #1: OK
Batched request_firmware_nowait(uevent=true) nofile try #2: OK
Batched request_firmware_nowait(uevent=true) nofile try #3: OK
Batched request_firmware_nowait(uevent=true) nofile try #4: OK
Batched request_firmware_nowait(uevent=true) nofile try #5: OK
Batched request_firmware_nowait(uevent=false) nofile try #1: OK
Batched request_firmware_nowait(uevent=false) nofile try #2: OK
Batched request_firmware_nowait(uevent=false) nofile try #3: OK
Batched request_firmware_nowait(uevent=false) nofile try #4:


And kernel log:

[  385.105004] test_firmware: #3: failed to async load firmware
[  385.181221] test_firmware: #0: failed to async load firmware
[  385.252231] test_firmware: #1: failed to async load firmware
[  385.323307] test_firmware: #2: failed to async load firmware
[  385.397444] test_firmware: #3: failed to async load firmware
[  644.462125] INFO: task fw_filesystem.s:5466 blocked for more than 120 
seconds.
[  644.548803]       Not tainted 6.8.0-rc5-g7e58e46976f2 #32
[  644.613581] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  765.294106] INFO: task fw_filesystem.s:5466 blocked for more than 241 
seconds.
[  765.380805]       Not tainted 6.8.0-rc5-g7e58e46976f2 #32
[  765.445610] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  886.126154] INFO: task fw_filesystem.s:5466 blocked for more than 362 
seconds.
[  886.212883]       Not tainted 6.8.0-rc5-g7e58e46976f2 #32
[  886.277695] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.

FWIW, with my patch we get same output for "passing" run upto another hang.

Thanks,
John

> 



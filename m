Return-Path: <linux-kernel+bounces-154183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD598AD8EC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6391F23337
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE4147779;
	Mon, 22 Apr 2024 23:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TI93Gr+k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZccPMhub"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AD82AE87;
	Mon, 22 Apr 2024 23:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713827363; cv=fail; b=AtzSdWB3OAd2VrIdTy+1xo8GBjHGFSINHGGWhmoacZMpsjwtrrAVHMcct2c7Z+T1Z1I2P8tHzMLq9oxzkYccxG1/Su/hIhTM+9xbwkVHNW5qd7Q9b5DClgIWqMps8p/TBFVVNy1MI9B0BlfdmEkVIlV7g6DExZpHydw/YXI2v2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713827363; c=relaxed/simple;
	bh=wepupZWwGE9QOj9mvlH4mfGlLCUjebzkreYa5NjLMqU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qeThS7lke2oCPMBQbiYBSWQyCQ2AjjGLyITOXIwQpWMGVznVEQzs8MUQVpg8IB51Fz0oD7Z+l9/NfrOhr5rGA6RBP0OblKDcGU7K/5/S8JW7IAJL2A+q8SJ/JlMaZABNOphKsF+NSvH5HOywty8QL4QhPhlLWK8Tto3dXmQDexA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TI93Gr+k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZccPMhub; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MHnQO9005092;
	Mon, 22 Apr 2024 23:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=jlq9PCMHA5Bopp4f7SgmjhZ2ofH2TbcM25ABvCeyi1E=;
 b=TI93Gr+krQwCULdf9Rj5zr6rH2Lyuzt8xm+FlFlLLGjATOrcjJQmoe+pNAvEODzBG/qJ
 Jksua61zxbu+s3Tuxb3clwvnzOWwC8tYYRGB+tDCdzhbaMODhX6z2alGOssv4CzuH7zi
 HIFXtDhW5HBXOc4uIZorG6ueeZ7ovsmd+PtEFclPKUqXmAyJ0sJQQ/UHrgUb1FKgZvZT
 DMUgqLWeIqRNlInwnB5+ESpd/EQSFAqaQzjEFKu1+qnFTX0my+t4hwvKSyxFrgm4k1fs
 0l4RHGeW2mPaZAHIKzjWO1vsmcynGGcQK8rQ0vLGLUE85tkjFAcL/qHFfkXJ1bKGe9se Yg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4md3x07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 23:09:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43MKkeOO040538;
	Mon, 22 Apr 2024 23:09:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm456c914-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 23:09:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQR1KAbUzqaHQL2zLu7FN+PwxENeu9GXNtpxoMpxXL6yRjQrvKTgBo/LJNalfwRUt/eUrM69ch/9/8MSkTBRR1Qfl03+mxU1v98RSIp+WlgF/GNw3cBsRmuBVzLrxaMnJaB0RHUlTF59LhTS4vK+Ar47C9Dl9Pmyoc5M+8XSGEB4jqHEB44YMaax18WFMWYWlVPRnEclhUbwWg6ehC1BsmlhIfCBCs8urWa7OdB+JjTeJJX2s+4ZWX77FKkmQtybDH5wnnssm2gNIK6mHdoq621CSIXIR8KOmzEN5Uc3ZTx4X/ojt9rWxx+xD/0RU3eVAy5ZgH/ELSs5jsmpZbpPpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlq9PCMHA5Bopp4f7SgmjhZ2ofH2TbcM25ABvCeyi1E=;
 b=eXvFQgYqomMaTBGiaQPdy46MUGeCnL3jPhYTWt7sjCM0QuXSx3KLSZQRDRthSSqvEMzfjh67HZfaKvgfq0hVf0s5exdAQruhtyO3OMdS4aAnwt80vlvPhOsuzyBtcX4D9Ps8gbdjSN0UOmfZRac0R/qf7eb9dxxGS0GqWqvop8uHGxocD5F72P+7GomthJn31gS9OMVIHfFWFgGhIz05stmzL69AkFGFp7XEER2MsfaouqaIo1LHlZD+dEN8iRm/x60USP74M2NlBAmRys2bKt9C3tG0QnPWSoRwgHBG5RjjxoPwUpC4kE/nenv+9J1vCWOBLcYTjaYAHMd0scoC5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlq9PCMHA5Bopp4f7SgmjhZ2ofH2TbcM25ABvCeyi1E=;
 b=ZccPMhubhxKzH4J2tC8Yr88jF/abKUnAw3CTt/9EshouefAck0NWzSl4jnn4KsG7pZNeBUOQU5GXI86EV41Ls4dUhu5flJjwqJdwkMogtYiuaAQyizbYlkd3CPVvnmOPnn38ILg9qoQIUZByAEo3ZRjAGIAXTnVDm6VwCmEqugw=
Received: from SA0PR10MB6425.namprd10.prod.outlook.com (2603:10b6:806:2c0::8)
 by BN0PR10MB4821.namprd10.prod.outlook.com (2603:10b6:408:125::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 23:09:05 +0000
Received: from SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::894:70b7:573e:da46]) by SA0PR10MB6425.namprd10.prod.outlook.com
 ([fe80::894:70b7:573e:da46%5]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 23:09:05 +0000
Message-ID: <240e09fb-257f-d32c-64c8-559430b06a2a@oracle.com>
Date: Mon, 22 Apr 2024 16:09:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/1] genirq/cpuhotplug: retry with online CPUs on
 irq_do_set_affinity failure
To: Thomas Gleixner <tglx@linutronix.de>
Cc: virtualization@lists.linux.dev, joe.jin@oracle.com,
        linux-kernel@vger.kernel.org
References: <20240419013322.58500-1-dongli.zhang@oracle.com>
 <20240419013322.58500-2-dongli.zhang@oracle.com> <87ttjtunbx.ffs@tglx>
Content-Language: en-US
From: Dongli Zhang <dongli.zhang@oracle.com>
In-Reply-To: <87ttjtunbx.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0175.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::30) To SA0PR10MB6425.namprd10.prod.outlook.com
 (2603:10b6:806:2c0::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR10MB6425:EE_|BN0PR10MB4821:EE_
X-MS-Office365-Filtering-Correlation-Id: b40f5e9f-bc36-4e7d-e640-08dc632134e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Q0ZJU3FRQ3B6TXRpQlJnamlmdUxDM3k0djM4TmJlQVhkRzI1VXpsS1dzckFP?=
 =?utf-8?B?Q3l1ZW5vQ2RWemVJcDRENXZPb3p5U0J4RnRpdWFzNlArOTU5aEZVMk9wOCtU?=
 =?utf-8?B?WGZIYjE3TTB4N2V6cXQ3TnN3R0taaFArQm5kMnpmT3N0L2EreDQwMGxZVlVj?=
 =?utf-8?B?UVZ4RTdDN2NXUkE5Uk1iU2pDVnVZYmJUdlNpN01aMjhUbm1uSnJHMFVDRm1H?=
 =?utf-8?B?TW9Tb08vRk4wRjNpRUVRZ1RuTzBad0JuM2pKK2owcGJ6cmo0L1pwTnZpUXFv?=
 =?utf-8?B?TXduMGduVU5ZaXJHcWo1NjhSSHp0ZlN4aDRoKzhTSEtiR1hXUDRra0puQmR2?=
 =?utf-8?B?djNrMGxXdDBJWnp3SkRGMldIMTlnWXk1L2dCWW16S1FkWFdXRjFERktHZ1Ar?=
 =?utf-8?B?eWMwQ3pmWDdGaHRqRXJLVDNuTm8wTHF0WkJGSnFwVUNXZHRUTTQ5bmsrU3RJ?=
 =?utf-8?B?MWtRbkQ2L3owQXRYK0xSa0RGN28yb0xBUEY5V24xZHhKUzFmY014cHNqcFlo?=
 =?utf-8?B?WmZMeUxmLy9QV1dsNmZrVmc1OXZwNnZQWVQxL1hvVXFCbEt1dlFiRHVqUGFt?=
 =?utf-8?B?RWZZandaWVFlM0tGNE1RK01OWHlEUnpuaEhLN2h5Z29JSzJUTUM5S1B5YVhy?=
 =?utf-8?B?cVFhbGQ4ZVR2eVo2TWhSbW5vUHJyWG9YMFNqMm13RDl0NlRQeUo2Y2lla2hH?=
 =?utf-8?B?TmFteDF5YVMxR0pVTVhIdm5UZDEzSDlXZ25YcGk1WnVzTVhFYWVrc21ZYlZs?=
 =?utf-8?B?V1dhaFIxYlg3elZxbzMxZFlnckY0empleW04VHdMTlVqU294NlFTNkFaZ1Ju?=
 =?utf-8?B?cGFDSlJtcjdLUUxGamUwTzhJbE40dnJFeEs4S2Q1OWdRTVA2UThrY29sU0o0?=
 =?utf-8?B?MUlMY2Y0dG1vV3loaTJBQm55aTdnWGdVZDRFMDJJdEFsd1BsOUZWU2M2aW95?=
 =?utf-8?B?SVRQV2lrRmsxK3pSRllDbTNnSURGTndUNGt0Wis4bGErVDRhenBvbzVzQjE3?=
 =?utf-8?B?dHlKdGMxeElCekpvbzRBMlBJaUpIT0kxa004YXNWcjdIcE03cDIzMnpOMU1U?=
 =?utf-8?B?QSthdGpDanRmdjVmSWRhbjdNOE9haGU1VGlwS2NjdnljdTJBQjFRQTRHaFk2?=
 =?utf-8?B?dk1MV21venAraEpKQ3RVby9GbUptOXFCMUQxSGk0RUYzc0d2WmV6KzdPZnp4?=
 =?utf-8?B?MTZrN3FxU1N1RFNvdXZIMnluYWRpOE85bkRJNTFTeE8zZ2pQTlNGY0tKdzNH?=
 =?utf-8?B?L0hoY3RLZTBFVW1CWXEvMXJ4RHB2dmg2R1hLZ1RDblhiZTMrNS92L25vSE10?=
 =?utf-8?B?aUJPa2Y2TW5SNWhBU205c3lhSmJwa1h0VGdQZkxUQ1FLWkJVaTB0aEpEbkR2?=
 =?utf-8?B?cXJudVpTcFJyNHZWZnFnczdPODdiZmp2M3FPY0Fjczl0aXhSNXBidWd5Q0VZ?=
 =?utf-8?B?M01PK0ZBTHIxNEFVaVJXZEU5c2VYNWI0V0ZJK0h0TmRvY0R5dmJ3RUUyZEpZ?=
 =?utf-8?B?eURlbnNaam9KOTJPNVFVc05Od3d0dlhSWk1HdWYvSCt2dGFOcE50QVpmNUp5?=
 =?utf-8?B?SGIzOXhvd3hiM2tCSEg0aW13MHZGNG0zTGd1Mm5rK0c5SVVpdE1RZ1VEY2Rq?=
 =?utf-8?B?VWhHQlZQdlh1NlpYSTU5UDRmd0gzUkRqY081dDFDQ29jazFTaUhvbkVrbzh6?=
 =?utf-8?B?VW9NbkJjcndvUllnMWQ1OENQU0dKcFVCRGJGanVJYXRBQkJGRkQrenBBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR10MB6425.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VERad0tqTHh5bzY4emhkOG5rbTJiR0QrZGVvOWRwYy9jVnh0UFpoQ3NRL0No?=
 =?utf-8?B?ajMvaGRwZmZRWFhRWllvUHNaZjZsWmNDcTRjMWsrMCsrU0R2blV5b2VkM0FN?=
 =?utf-8?B?N09Sd0VFZk9VTDV6YzhyN2lQd0daWE52RXNGbjlVRjRnT2RRQk0rVXJGT3R1?=
 =?utf-8?B?V1RpNlB6aWxvT3lrL2xwOEptOXZrY3BySU1JeGZKRXNNdVZ5ZFF6R1Jqb0tH?=
 =?utf-8?B?ZDV3S0xWd2V4YXVZamE4NkNaU2ZFVkxtdlVzN2czWllHTnUrTDEwWTlLenRi?=
 =?utf-8?B?Sm1LLzkyTHVqdTNjZDZCY3dPUUd1SnBmM0tzTVdGcnpjZmtTb3lRdlp0ZWZL?=
 =?utf-8?B?bWxldGsxVkNlWmliYlNQMzdaWDhMSnYxalh3SVFKOUsyWWZ1cktnZTlJL2ZJ?=
 =?utf-8?B?OTFaNXp2S2pwUzNWbzRqcDRrV2RDVURQZ1JQaU8xUkNEU0oxNE5yanpkTjd4?=
 =?utf-8?B?Ym43Y093c3ZORmFPNHlENGxReFNCSnRPVHhOV2ZIMFoyNDdxYVdEY0FyNU9E?=
 =?utf-8?B?TjQ3S3hIQ2ZaOVpsQ1NzRjlFV25QSWdCZzIvclZ2UkFNTGpMSVpVazZyUlE0?=
 =?utf-8?B?YTEwbXNtWWpEMm12eUtqSkRKSXRGVVRyeDZRSE13WHNLMk0vMjF6Skk0Q1BZ?=
 =?utf-8?B?UTZvNmJ4VGRLUEJFS2I0SnhrbFVYL2hlS3FPNi8vNDVNV1hEZUhPWlFIS1RL?=
 =?utf-8?B?cWRvd0Vma1dMMDVidnhnNmdYMmNXOWtHZEdkdXhycmZtNzR2MkZEcVZpVUJC?=
 =?utf-8?B?MjVuUGVPUTk2NVhyM0dVRFFwUWorVTVtdVVYaTcwQkFSZGFMeWRHa20zT285?=
 =?utf-8?B?dUxabzZaK0NVWHl6cGU1Y0lzWU1IbTlqQXp3dFpWbjdZcEkxR3pJZlJpVmxt?=
 =?utf-8?B?SXNaWGtRektVNzJOaGxkUTRRaFBxeXo2cVl1SGkvdjg4STV4SFdIanQzMm1I?=
 =?utf-8?B?aFArdU5aSlk3N2crVXJLUnQyRUVmS3Y4T3F0dms3QmRubTZDQmdvL2kzc3R3?=
 =?utf-8?B?UnR1RGJmT0lxbWhNR0VxbElHMHdxbWxhUVo2bG5wTGhsU3NyRUJETDdRNkVW?=
 =?utf-8?B?Vk9VWTRxaUJSNmRkbGJzbTczaGJiczhpcjJoYkJzaGFYQTZXSnBJNFNjVnlJ?=
 =?utf-8?B?WFFKWlpHckhucWswbVBtU0F1dXJrM1V3TnZBMi9UU29TRnJ1bDM4REgyWmp5?=
 =?utf-8?B?ZXZYMHNtTzZVU012bFA1WnBxWXFPYVI2cFZXMTM1dU1kVXRmc2liRDVwT2xK?=
 =?utf-8?B?M1pnZFhORVhXZ3ZncGlvSSs4b3dvVnpwZTRmd0hpUDFaVk00QWk4eHFVUlMv?=
 =?utf-8?B?UmQzblFOWUZyNlM2cmtTR1dlNnhCSmRjTHZsMnJONkpid09aVjZtYmRNNUxD?=
 =?utf-8?B?WmxGc2s4eUt0S214dVBFK0dTeVhiVVVZcjlLYnVxQmxTTk93by9INndGWms0?=
 =?utf-8?B?YldTWktJbDNUNHNLUXk2K0pzQzM2dmFzb3d4c1hPTm8wZWQzbnB2MTUxTXdM?=
 =?utf-8?B?VjRrSHJSdngwYXpvN09waEl1Y0RHM042eGx5Q3dTS0lSK3Z2d2ZyUXR1SW9v?=
 =?utf-8?B?bXlaS0pmMHNMU0gxNjFtQ1R2UUY1aTVGZVo5TW9OUmlBeVNkZ1daZHNneGlI?=
 =?utf-8?B?aUNSanN1aHEzVVFGc1ZieXdkb2d1U3FILytra3F3NEt3UGN1cWxKQnpvbi94?=
 =?utf-8?B?ZkVEWUp5MkZzOTQwZ2dUaGVWY05uZWlmT1lQU0RRNTN3OS9KSG1KdnZ4UXFC?=
 =?utf-8?B?TTdrR2VYaFlXZkRJaVNnVng2US91ZFpLTm9lVTJPK1FaZ2xQSGozVGhuYmFp?=
 =?utf-8?B?UWI2SkV5dDNxaU1RNUlmWURtL3hrdUE4NDRINEdibXh3VGUvU21DK0tUZGcv?=
 =?utf-8?B?cElPRkdyT2FnRW5KUW92ZUtqRVpXbHpSVitHU1VXT04rdFhQdk9RNzBvcXBO?=
 =?utf-8?B?bWtWWkFBYXhFOG1FWjI3RnAxMzduWlRoZjVyL1hGTWlYQlkzUXFicDZKMnpH?=
 =?utf-8?B?eFFFTGFGWmRYVHArSDRzb1IwM3pqa1ZPU1o1alBvQTZacEMxNU9iQ3g2U01J?=
 =?utf-8?B?aTNPbzhmbHJoWkJIR1lTR3ZMNlRFYWFqY2U2RnZBVzdHczdoSU9uMERqSWlm?=
 =?utf-8?Q?2XsOJ52y4Bsy7Tcr+YWpvU0/W?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9kI17MkV6FjkR/7zBkL0nxeko7HjRubya+AUq+G+ncLndn6Bz4uurgNbegoD8djIGpFM3niqvY8jzCwzvOMn+Yk/4hNiPfHNcW7S4cmrrhcvaD5T9PgLgagSstfStYOlp+StHiUsQgqJRxSSxVUc28BLH+Uc4M3UkRRCTYcQcH6FFygx9n0KkFjCBzxkiQuwM7Vqi3dGMMLJ+AUoHKaHil5UuvFDFqqwtKA8knFJjgfFyqRX4sxop2qBmDk6bbMV8k6DN+OuzUOEp6Vj+m5rUQEcAGlb2KYuxTXWbPF2s+Len1PAULeNZEsR98Q8QRQ+1lCBUDX2JMjr10qEJ3mxhN7C5wNNrHgV+ZF6zWeo9jniqut8ITFNdmEi0H+6BlqKYeFy/mljNW0FKuEw2UhsEHq5ksU/rzIGm4ALnxk+nY1u6in40il4d1v+C8yLVTixfYj3WuRZvO7uHYBV0/TllVI6grVAnXadNHYJb+uYdN4os4hyt7zSe213xA1G37uKLnpNsXqH6wN9RFZ6AHOGhWQOuK0iO9/GFB2Kx9N+T0HQ6AdyXduZ1FE8aE2FB4fYg+lYlMv+jZzN8j9OqyMfjM39CBoBYGe+MQ6YGXbNfl0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40f5e9f-bc36-4e7d-e640-08dc632134e6
X-MS-Exchange-CrossTenant-AuthSource: SA0PR10MB6425.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 23:09:05.3665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/9p8HdXmHcGxp3fJ7DXDCtqTsbX4WnY71xASKXiTHh5ytWW/sdkQfYZS9DJFOvsSHlVC0kEutnFjxcvxiqaRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4821
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_16,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404220096
X-Proofpoint-ORIG-GUID: EgK-J-hR7VOlb-31Lb_vh8kklhHxgdJY
X-Proofpoint-GUID: EgK-J-hR7VOlb-31Lb_vh8kklhHxgdJY

Hi Thomas,

On 4/22/24 13:58, Thomas Gleixner wrote:
> On Thu, Apr 18 2024 at 18:33, Dongli Zhang wrote:
> 
>> When a CPU is offline, its IRQs may migrate to other CPUs. For managed
>> IRQs, they are migrated, or shutdown (if all CPUs of the managed IRQ
>> affinity are offline). For regular IRQs, there will only be a
>> migration.
> 
> Please write out interrupts. There is enough space for it and IRQ is
> just not a regular word.

I will use "interrupts".

> 
>> The migrate_one_irq() first uses pending_mask or affinity_mask of the IRQ.
>>
>> 104         if (irq_fixup_move_pending(desc, true))
>> 105                 affinity = irq_desc_get_pending_mask(desc);
>> 106         else
>> 107                 affinity = irq_data_get_affinity_mask(d);
>>
>> The migrate_one_irq() may use all online CPUs, if all CPUs in
>> pending_mask/affinity_mask are already offline.
>>
>> 113         if (cpumask_any_and(affinity, cpu_online_mask) >= nr_cpu_ids) {
>> 114                 /*
>> 115                  * If the interrupt is managed, then shut it down and leave
>> 116                  * the affinity untouched.
>> 117                  */
>> 118                 if (irqd_affinity_is_managed(d)) {
>> 119                         irqd_set_managed_shutdown(d);
>> 120                         irq_shutdown_and_deactivate(desc);
>> 121                         return false;
>> 122                 }
>> 123                 affinity = cpu_online_mask;
>> 124                 brokeaff = true;
>> 125         }
> 
> Please don't copy code into the change log. Describe the problem in
> text.

Would you mind suggesting if the below commit message is fine to you?


genirq/cpuhotplug: retry with cpu_online_mask when irq_do_set_affinity return
-ENOSPC

When a CPU goes offline, the interrupts pinned to that CPU are
re-configured.

Its managed interrupts undergo either migration to other CPUs or shutdown
if all CPUs listed in the affinity are offline. This patch doesn't affect
managed interrupts.

For regular interrupts, they are migrated to other selected online CPUs.
The target CPUs are chosen from either desc->pending_mask (suppose
CONFIG_GENERIC_PENDING_IRQ) or d->common->affinity (suppose CONFIG_SMP).
The cpu_online_mask is used as target CPUs only when CPUs in both
desc->pending_mask and d->common->affinity are offline.

However, there is a bad corner case, when desc->pending_mask or
d->common->affinity is selected as the target cpumask, but none of their
CPUs has any available vectors.

As a result, an -ENOSPC error happens:

  "IRQ151: set affinity failed(-28)."

This is from the debugfs. The allocation fails although other online CPUs
(except CPU=2) have many free vectors.

name:   VECTOR
 size:   0
 mapped: 529
 flags:  0x00000103
Online bitmaps:        7
Global available:    884
Global reserved:       6
Total allocated:     539
System: 36: 0-19,21,50,128,236,243-244,246-255
 | CPU | avl | man | mac | act | vectors
     0   147     0     0   55  32-49,51-87
     1   147     0     0   55  32-49,51-87
     2     0     0     0  202  32-49,51-127,129-235
     4   147     0     0   55  32-49,51-87
     5   147     0     0   55  32-49,51-87
     6   148     0     0   54  32-49,51-86
     7   148     0     0   54  32-49,51-86

The steps to reproduce the issue are in [1]. The core idea is:

1. Create a KVM guest with many virtio-net PCI devices, each configured
with a very large number of queues/vectors.

2. Set the affinity of all virtio-net interrupts to "2,3".

3. Offline many CPUs, excluding "2,3".

4. Offline CPU=2, and irq_do_set_affinity() returns -ENOSPC.

For regular interrupts, if irq_do_set_affinity() returns -ENOSPC, retry it
with all online CPUs. The issue does not happen for managed interrupts
because the vectors are always reserved (in cm->managed_map) before the CPU
offline operation.

[1] https://lore.kernel.org/all/20240419013322.58500-1-dongli.zhang@oracle.com/

Cc: Joe Jin <joe.jin@oracle.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>


> 
>> However, there is a corner case. Although some CPUs in
>> pending_mask/affinity_mask are still online, they are lack of available
>> vectors. If the kernel continues calling irq_do_set_affinity() with those CPUs,
>> there will be -ENOSPC error.
>>
>> This is not reasonable as other online CPUs still have many available
>> vectors.
> 
> Reasonable is not the question here. It's either correct or not.

This has been re-written in the new commit message.

> 
>> name:   VECTOR
>>  size:   0
>>  mapped: 529
>>  flags:  0x00000103
>> Online bitmaps:        7
>> Global available:    884
>> Global reserved:       6
>> Total allocated:     539
>> System: 36: 0-19,21,50,128,236,243-244,246-255
>>  | CPU | avl | man | mac | act | vectors
>>      0   147     0     0   55  32-49,51-87
>>      1   147     0     0   55  32-49,51-87
>>      2     0     0     0  202  32-49,51-127,129-235
> 
> Just ouf of curiousity. How did this end up with CPU2 completely
> occupied?

The details are in the link:
https://lore.kernel.org/all/20240419013322.58500-1-dongli.zhang@oracle.com/

Here is the core idea:

1. Create a KVM guest with many virtio-net PCI devices, each configured
with a very large number of queues/vectors.

2. Set the affinity of all virtio-net interrupts to "2,3".

3. Offline many CPUs, excluding "2,3".

4. Offline CPU=2, and irq_do_set_affinity() returns -ENOSPC.

> 
>>      4   147     0     0   55  32-49,51-87
>>      5   147     0     0   55  32-49,51-87
>>      6   148     0     0   54  32-49,51-86
>>      7   148     0     0   54  32-49,51-86
>>
>> This issue should not happen for managed IRQs because the vectors are already
>> reserved before CPU hotplug.
> 
> Should not? It either does or it does not.

It is "does not". I will fix it. Please see new commit message.

> 
>> For regular IRQs, do a re-try with all online
>> CPUs if the prior irq_do_set_affinity() is failed with -ENOSPC.
>>
>> Cc: Joe Jin <joe.jin@oracle.com>
>> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
>> ---
>>  kernel/irq/cpuhotplug.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
>> index 1ed2b1739363..d1666a6b73f4 100644
>> --- a/kernel/irq/cpuhotplug.c
>> +++ b/kernel/irq/cpuhotplug.c
>> @@ -130,6 +130,19 @@ static bool migrate_one_irq(struct irq_desc *desc)
>>  	 * CPU.
>>  	 */
>>  	err = irq_do_set_affinity(d, affinity, false);
>> +
>> +	if (err == -ENOSPC &&
>> +	    !irqd_affinity_is_managed(d) &&
>> +	    affinity != cpu_online_mask) {
> 
> This really wants to be a single line conditional.

I will change it to a single line.

Would you mind suggesting which is preferred? !cpumask_equal(affinity,
cpu_online_mask) or (affinity != cpu_online_mask)?


> 
>> +		affinity = cpu_online_mask;
>> +		brokeaff = true;
>> +
>> +		pr_debug("IRQ%u: set affinity failed for %*pbl, re-try with all online CPUs\n",
>> +			 d->irq, cpumask_pr_args(affinity));
> 
> How is it useful to print cpu_online_mask here?

My bad and sorry about that. I should print the log before changing 'affinity' I
will fix that in the new version.


Thank you very much for feedback!

Dongli Zhang


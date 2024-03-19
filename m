Return-Path: <linux-kernel+bounces-108058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 064E1880566
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A4B1F23954
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C5A39FF4;
	Tue, 19 Mar 2024 19:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mR0aFyk6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K2bLN2/8"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3BF39FFD;
	Tue, 19 Mar 2024 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710876558; cv=fail; b=lfty6AR13DbWJMGDEuOh+WMkr4TX7QrWBHv9jq5vML+YfeiKAc1qZ028yGrfgzt3QZ54yVqzgHWrom+vV2qBszLeDowrC742j4TCCsbOOfHqqUvwtqUn0pb9xuPczFCeutcVx972mxNttFBJBztRC3QCEVEzz5BIkP85KrZg1EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710876558; c=relaxed/simple;
	bh=1SCtKrUvzgqm5dkTkBYYIQywmjweTDAQX7Ltep/H7uQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U8s/13s/bm1h35IT9Hf1QUTUZJavlp38T5EGScUQsLT5t4WnJXGm/sOGhIh6WrqyUalE/EuiL5HWYoV1U2ZLOLLfgURum9rw/Jn2haaWc1h3lfv6Bj+F/Gnq2cx0D75QwuL0YvX0DEiUvTSwfqkT9kCUXBCmz2CIKFxUgla1zRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mR0aFyk6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=K2bLN2/8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JJESeq024949;
	Tue, 19 Mar 2024 19:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=DeaLeC8P+m7Q7ovOS6tDnYDODJ+tarwBrjbniZyM/KI=;
 b=mR0aFyk6rJyPQXoQnILf6FYuHn4tga+tvRQXQUwa8GEzcKL1aRCUJAqVl9pCC43fLMWx
 4AQ6/XGospHipvQnfizTkm33xfxVqOBu4RBakThq565xmV5gs66qCaDGR9gngOW9Gftn
 pkh9/e128UQk0a9YRmdCNZEY1cQlFKE0jZxRrwow5WNTFgZZ6vNzJH/jDP7ms0kcJXud
 97e6njtO3bmTf1SNw2kxFBkdp8gMxRyB/qS6mD/ewCBJvaA5rSIEz8xZU3wRUx1ZVMrr
 mCHL9MPBcpaE5a8NGrGqN0P8DbhpK5dKfjWs7xhh89dFcDDVYR8HBzNS8HowPnZ9T0DL 4g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww2bbpf70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 19:28:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JIWH53024144;
	Tue, 19 Mar 2024 19:28:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v710qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Mar 2024 19:28:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSLWFH+YjWrn7kcLN7Qn755Nf4a9VGlU8rHscNsGklXrryR2q+9LjrZ1PWexqdY2FTps/KhlhUYvt7F8K/UhZAKdDmkCmgihZd99bpers36qvYdcwMuA65AWwZvhmrlp9jdqFYzAJeEyG1po355QaGbhzuVO4tQQos85/yexMNRllkX1RdUa+IIxCYaUGlPSV7hcyY8mHRA+LPoO4RMfxXuSTJ1P6uJ4TpON3A1x5OAgnfQbLbZATi1bjwFE0Iut+Z9SR119dDFQ0abG+OBp3l3K90gM4AX/1Cd/auM9gJSd3nP60cXzSLiuqOdm7gCfUxde2dUCS/lw16ND5GkA2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DeaLeC8P+m7Q7ovOS6tDnYDODJ+tarwBrjbniZyM/KI=;
 b=VUKvG3cox+MTO7w0hfde9atRM5+Lz5B0ulatPRECbXoNovZddLQ1isOa3O3JUHw2DgdQS7IPtbHYUZogWnRo+e8Dn/rzZYaS3157UZwrMH9yggaEVycME1phX8KQOa7BmsZS/Dy8QMuQcJSVUsiPgzfrmWFuc0l7fYrB9jQ+6bB8dvYsVk83iAx/teDK/0n6u0EAPAsYh/5E0X0qoM62ib4/f4XxezaO3N6jIvUOFZTe2B2rC5XISjaoIR++Ef2SWTDrYcs4Kg/3mkti+OI74oBd/b3vVu70ALsy878lYkjVokDpHtgDgUuVi+gmK0Lkgx0wjSv/hNX/uoZuNrqIMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DeaLeC8P+m7Q7ovOS6tDnYDODJ+tarwBrjbniZyM/KI=;
 b=K2bLN2/8n85ITSZuNff4/7ctHPPADtNPrFvwIcxOze6VLZMgmDes75O/90ESqpBl2qPH7AmQ22nzyhTRSpCHDfn3IZMTsMLXXJ/HMVAa32UnAm+xGvLqVJRrbH3MU3dJQ2BIS6hcPfrMQlkICE1flSwsAZZWM2DXdGEb0kzEUo4=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by PH7PR10MB7010.namprd10.prod.outlook.com (2603:10b6:510:274::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Tue, 19 Mar
 2024 19:28:54 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2246:144f:3bb9:60d]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2246:144f:3bb9:60d%3]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 19:28:54 +0000
Message-ID: <3abd7f0b-dc88-4183-8762-f2f101402edd@oracle.com>
Date: Tue, 19 Mar 2024 14:28:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iscsi_tcp: do not bind sockets that already have
 extra callbacks
Content-Language: en-US
To: Khazhismel Kumykov <khazhy@chromium.org>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley"
 <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Khazhismel Kumykov <khazhy@google.com>
References: <20240318194902.3290795-1-khazhy@google.com>
From: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20240318194902.3290795-1-khazhy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::20) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|PH7PR10MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd289e4-7d93-478f-05b5-08dc484ad06b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tV9ljpl2imqw74Ep6cpUlm0+4AKjDWb+3EVWcq7hZ34JU4sJaz6FPtwrf3goLjK3+FO24bx1S/vtuSxRXfeFVaO14CjrYPjUtTuMZ3vfETY/pOvlRo/F+I3fe/OZb4eIMZcmbQVEX7jhXLmvH3bTw3ejrMt7S2IT/rLKhi+toCmJWqw25PSoLddm9VLnCu2zPyq6rTaKg/FRHuzhzGqShI6b2P3e6a8tP0naHX6V/fq9crgNg9BrJ8EYFATj2xChun9wBp+5fkPYaFo/VkSaMMT5TYQSxOGe9+014UYEnNEQBRlMReqrhFpiBnr9puxxnH1dUqJ3CNuByJpger5wSRl0c6PgvooK/cOTyGulong01sEfzZGgs+GhLiOxu67dVdxioCEK4dJd8GT8n5k8xv2rWBFpkfIG1aK0V96Q6wHVc9q3vjn76rh74E0tYJKNesMfTLSBU1XTE/XYsVN/2FCTl98kzX1e1RJiBH0fWUqBxHIFAULWBqzlgAEDsuQA6yvIwd1zNpBn3MsQFJL+VpgwOKAwrZGc91dqTW5BMQp9fkE1jtwfzrslB7zPOgkQlpXsNCLAFi1U5NxUwNmlAOD9M8OzRBmESwxvvWPvwznAxYKgUsx5+Xl59XbVI8ScucLyWsF+fGg9R/M2ZM599RbT79Nyi2pH4taqo2ttFG4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VkV5alNNbldqQTVpWTdJVm9YL2tsMzIvZy8zaGJ2MG1udmIrNHJkMGVkelAr?=
 =?utf-8?B?a2JUTzdSeU9DWXE1M1BXM2J4Y3pnVHVDdEtNVm1kM1B6bFBlYzE3ZlpYQjg3?=
 =?utf-8?B?M3VmMmxJNlZ0OFF2aVB1T3RHaC9nYlB5TEZQR2I0ME40eUZjcmZWcW9TRXY3?=
 =?utf-8?B?WkJpLzh2dDhwaUtFN2RGbFdHM3A0MzMxc3orNk5EK2ZWOWVaazZQeCtmc3dM?=
 =?utf-8?B?cWhTWDJ3NTlNU3haQ1Q0aldXL1BNSzdKanlDc0I3ajYwRy8zWE5sN1I3aVJN?=
 =?utf-8?B?TzRHWGUvQVZBaEVKck5mYzJQWVhJQVR6S1BmU091SHdleHVCUUJDSUpWR2hK?=
 =?utf-8?B?MlpqS0xTSXk4aW4vN2RLcUw5V01NdlUwYzBGcU8wQTRmakI5bUg2NlA5Njdm?=
 =?utf-8?B?bzA1aUpIWmthNzBQZHhDclVkU2s4UGtMQXE2aWVmL3JWYUhXbGFQZ3hoRWFN?=
 =?utf-8?B?aFVRR1orWC82emE0M2pMWTZmZEw3RGxQVnZjcEp3N2ZXWkZmUVJYU2lMdlB3?=
 =?utf-8?B?T2tzdFgyZzhOOXBGNDgrWHEyL1haTENLM01qUVM3TzMycERDMnF0NnJ5dm5v?=
 =?utf-8?B?YlhXMW1EeXZCZElVVjI5ODVaNnNXbXBlL05xNEdLZ2Q3TXRsbG14dmF1dVFU?=
 =?utf-8?B?TVFDVG8za0pTSVR3R0d2SEFTaERxcDIrNEJqQXhaRjFzK1NldlE3NTFLZTZw?=
 =?utf-8?B?OUFTalZHL0xhbGNERXlSVGFKWDltS3laOElWT1BuUmtRY3BlVkkrWS9XS0ZY?=
 =?utf-8?B?RGprVlNBbFVVS3V3NUI5Rm9pSmVaQ245YTY1RElVQ1h5L1hqWkptcHFXUExC?=
 =?utf-8?B?dHpUa1k2OFY4djJKQ2xMTGp0dVFUTlhWUzRuSHRybS9ER1lkQzNxd003eml2?=
 =?utf-8?B?Ylh1WFU5Y0s4Sk9McFo3cFJ2RHYvZllGVjlYNC9pMFNXdjBOZU5lSm92MmhC?=
 =?utf-8?B?b2RyT1JVd1RKcGRKaGZPYTQvNkF4Wjdnb2hxNFJPa1ZEdmpzSFRrQVBGVFVj?=
 =?utf-8?B?VXZ6WGlYZ2NIZVRSRngzSDdINk9Vc1IxL1R2cGx6cmQ1YTZIZ0VkZWxsUXFT?=
 =?utf-8?B?dFBoZjRmZFUvMG9BSkFLYi85QTdMT1NiNmd1R2xMczlIVU50S2g1UjI2WUM5?=
 =?utf-8?B?eCtlWmFSamxPZjlUQ3VWVkpkSnFNTXRQVXBCZzRvQjJqQnV3K0VUSzNEY0di?=
 =?utf-8?B?K1dmVnRkM2pwR0FsUUk3emY3UUxZVnl6YmFEK05tOUNLOGxNVXFjVE9BMGV2?=
 =?utf-8?B?dWdRN2V1OWRrVFAvNWtaUnUxQ1pMV1djeTJUbHIyQTg3cFBnNjhUTHpOS1lr?=
 =?utf-8?B?SEhXL2RuekwwRzhHWjk2cjJEcEZTTzhzdW5vY200T2Vnc2RVemF1UzhpNjZS?=
 =?utf-8?B?Y2JCdEl1TmRuSm1IUXNqSWQydStYY2o0cnZwcmRhVGJOYlVLK2pyNUxNUmlJ?=
 =?utf-8?B?K2MrNXIzU2tuWVFMMVBUcnZULzF3eEVWeGtwanlPcTJYamRpbThORXZuSS9R?=
 =?utf-8?B?NFJEM2RESGJoUGNVQ0xSMG5yWkJxVWlwUHlJUjJQMGVvY3ArWlJ4S3B4clVZ?=
 =?utf-8?B?b1NGcDcxZ1QxVi93Y3p4bWpJRFBpSDI0SUdQRjFOM2F2RnBiNFFoWWcyekdQ?=
 =?utf-8?B?L2hnVTVYdWhoejhNL2lleFZuektrUERCNFVhdlJUaHNsZEdURUhqTWJqaVZw?=
 =?utf-8?B?QUJNS0lRejN1MmNlVDdLV2Rzc1IrMkNxUWtMMW5CQlplSkdaak9kNlJFU2I5?=
 =?utf-8?B?dWZIQjBpN29RVUI5TGVRMlJCK25mZmo0T2F2c2xRR2N2RDZ1OXA5ZkN0MFRh?=
 =?utf-8?B?ZnBLSm4weHV0WWp6czBNSkxlRW1IVWcwM3Mvb2dkVFcvMVY4N1BlOVRlc2hs?=
 =?utf-8?B?ZkhWdUFCM2dHY1kxRHQ3T0g1MGJxaEl4MEdJN2Z4VXFmVDdZYkZBYlFIRita?=
 =?utf-8?B?M0d4QWJTNVlxYkYxcEQ1RmYyVDhEM1VqMFFzdTUvSmtlUkNhRnRIa3JUbllt?=
 =?utf-8?B?NExwM0RxQWhtc0VmbU9FZms0S1MvaS8xZS9kQ0hpTGIvWHh3NWJCNzYwZEJr?=
 =?utf-8?B?eWdTWWdodnozazFSTkxJU2dhWGRwZlFUcnlYWHhCUDY1cXNieE1kSDBXYlcr?=
 =?utf-8?B?VDc2dFZ2R1N5YjJuS25wSzFsWjJCTGh3Q0ZLd0MrOEU5YkdzMjZyMTRqb3kx?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zbEpqD0s75KvQtVzuRNBndeAuWYJfNcjMkeCiD7lUv6sJzdTxVmzSEG12/UYebCbCvsA+E5W1kMWf2i2PGWLNKUEtb4BPRJKt3c0n1Rg/+QU19jk65qvPJJDp8lCjR66z9jNWhb3x8JP4BJl7n8iDjUP0hL9EBXNv2GLJoSaNmdJeyMFrhjur3PTXu6Rs+sTtKxH/BrJQty5Sz5qGxcW48hq7NuixLOWEs97SQAgVBkN6zZio7z9MeoR3QGA0m8i0hGqtODBB8Pti83usoropBt1HDceJAY2t/aSZwR9XAuCgskqLOIq3VEua3m+4iFTv6htKaPjrZnlYGAOpfum5qcl3q1nIS4x33KijgoBa8NRLGC3Sy7R6YdRdprtSUjkGvqZ7oW2yycMyrzPyZjcZaJczsHQULe7BDy9t9Fcw9OU85FobUZ0Ha1CfjcUV9jxoqcXTI/uSQiox+Kc0UcuISQfPYO7xqdoHOJNLwfSljsL3aEaPMQnDK7AOa5Esfe9szxlCS2gIBYm9q8uadoaru2P0JReIS5a/XYhegRhl2ObBBwTLBwjLEly9NRcwkUhaWvW8etHDixzNIulAhgMcq4czPpNc7yA4Rya+uqJDuM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd289e4-7d93-478f-05b5-08dc484ad06b
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 19:28:54.3270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ix4puzSB3VFfiKqFKw3/l0cyM345SJ0bgEMxTdfmhb3mgpM3o9aNcR+m8dI38W341pEttB4PHEPNxECV7c+AWSrW4sMV4+N2d6OdD2hjrVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7010
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190149
X-Proofpoint-ORIG-GUID: zzp9Yzf8E5iGrpcd2twIHuplbdxIR5gP
X-Proofpoint-GUID: zzp9Yzf8E5iGrpcd2twIHuplbdxIR5gP

On 3/18/24 2:49 PM, Khazhismel Kumykov wrote:
> This attempts to avoid a situation where a misbehaving iscsi daemon
> passes a socket for a different iSCSI connection to BIND_CONN - which
> would result in infinite recursion and stack overflow. This will
> also prevent passing *other* sockets which had sk_user_data overridden,
> but that wouldn't have been safe anyways - since we throw away that
> pointer anyways. This does not cover all hypothetical scenarios where we
> pass bad sockets to BIND_CONN.
> 
> This also papers over a different bug - we allow a daemon to call
> BIND_CONN twice for the same connection - which would result in, at the
> least, failing to uninitialize/teardown the previous socket, which will
> be addressed separately.
> 
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
> ---
>  drivers/scsi/iscsi_tcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
> index 8e14cea15f98..e8ed60b777c6 100644
> --- a/drivers/scsi/iscsi_tcp.c
> +++ b/drivers/scsi/iscsi_tcp.c
> @@ -725,7 +725,7 @@ iscsi_sw_tcp_conn_bind(struct iscsi_cls_session *cls_session,
>  	}
>  
>  	err = -EINVAL;
> -	if (!sk_is_tcp(sock->sk))
> +	if (!sk_is_tcp(sock->sk) || sock->sk->sk_user_data)
>  		goto free_socket;
>  
>  	err = iscsi_conn_bind(cls_session, cls_conn, is_leading);


Reviewed-by: Mike Christie <michael.christie@oracle.com>


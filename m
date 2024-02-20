Return-Path: <linux-kernel+bounces-73524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D9385C3BE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D6ED1F22701
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1481112E1D8;
	Tue, 20 Feb 2024 18:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YvPxxzWD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qgMK8S+L"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9AD12AAEC
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708454527; cv=fail; b=QQ5MWcsunshuJ9E1N0u6xAIJ9FpbG5AJUHww7Ff2v8y5XFvRdV2RLhMxbSCpFLiAzIBng355gOQD63mgN7eAAlFB1/VE3DNU3RVohzLcUf9KOp1aPUQb2t8hiho6MCjuH4FiKNe9gN/EYZdPuAm3C+HBDkV3YApIVkXFK8eS9z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708454527; c=relaxed/simple;
	bh=3AeFJ0qvyzFQCo0fI+cTnat9ktQxh+yI4NwwMW9O67k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JaWEL9ardXLzCX0BVo4uKLiH9bvxd/6zFcJyJd8qNH3Fo77ECRQr0x911Av07BqcJU3v+PH97q2Oxq/SlI0EPM/HfECJRjeSX/B3B0KqP50KTQf0EiisK1WSaeZuBU+4jYAhUKtZ4089grr73XVF6+czEjoD7Md/HoYa2xubhQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YvPxxzWD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qgMK8S+L; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KEe54v027650;
	Tue, 20 Feb 2024 18:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Cq6N/s/zQ0eiaGtEUpoE87UFUf9rBzLXJyx352yODLA=;
 b=YvPxxzWDtQaMz3PGYXLPoJH/47uLGfpdEzeMLARnBuGIiRv19aNd7LOoXEAVSZaKj5Tr
 tNpkt+bVh77K63vh5nGiSjEIn4dHCSctg1oMWDH7MN/Gd2rCotafCec7aDJDZTnpHLSM
 nUsbInatzlx4jMcz9ma2vYOrJgVymROvjKJ4uDzDuKsW1hbS7/jybKvRmYpZbsl2EHaf
 iEWEwTn1uCqY/oRdV0deLtDsSJTP5g1mBuvhwppx8VWXLl11WlOGaFb11zduLnWGYAy/
 uSQGD2ySC4G8/jcA7tAkrpwd2N0FCNb2i2Vhan/yU+J7S+y3MAJ0WLz3cCIMEkoU8a3M IQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamucymrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 18:41:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41KIVnLg039694;
	Tue, 20 Feb 2024 18:41:40 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak87r3cw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 18:41:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhAtHo0TysA+jJdKpiW14g3fv+gRftDWLUfIp3hv/UNA/6LvN8mD2V/oFu1eAaeZm+z6i3ay1LT3hZNAripXpO9T5GMq4+pJ/Hp8x1Lcb2qrIZA6mmUzJw3VLE/g7VbcbIpz6zgXAGLteQDQEYTyuSneMT2DykKp+5d/zSGG3FPcuIdqtOJBE9FwTkAsgLqlMPyngclwMZQOyFlPXzU+ekMcGRbKNuV2FUXZaMK0ywb4apqWodtEWSceD4MCut6cHnH4aWENFejqwhBGbjxhhxn8qi7l9cV6bUsrd4bh4GdSWM4arW37ipj0/hZUoVvZskZiBBT2FmFNBz7VFxHUSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cq6N/s/zQ0eiaGtEUpoE87UFUf9rBzLXJyx352yODLA=;
 b=JnD6Ns2H7ql5TwviOVPFHeBfUf6wwtG9JVRrLd23MPdbwckViB8UizqyPhwgIRc0Eri+eNX3UibtO7OghWIgaY5cE2dkEysed6Qh0EgbYFee87XclvEk7nSr8+dZxWHV43xmseaEcC2/CCnXq2iT/SVa9nmDsXerPHuQ6yTICsSMhZwSZxbNMSC7DFq9KO6TqmT2fAXEoCkOkSWdnvY4umoERszp824COelw4LRCGc/N7VmV7cy1n0hvhxsVZKthYkg72qmuCQcLXIIjD8Yaspwvm0J2XNge5nihg206fw9nIWSU2b0B3jXDnR+1r+RwKg+6GbGbOJYifQBgbDuRWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cq6N/s/zQ0eiaGtEUpoE87UFUf9rBzLXJyx352yODLA=;
 b=qgMK8S+LkgfpARL6ND0elJLx3aVaqMUv2rxbwbXm3xB1/oM9rJLeEZMyKzGTr2QR3hLvKZO95EfjX2uNFWOKES6QQuvxZ3Vkj2Qt+P0OoZjv1pLX4lfRK29eJcp+esC3TgSMiPExfo0uNHk/0IR768ly12rhFmnY0z/fd+etEwA=
Received: from PH7PR10MB6379.namprd10.prod.outlook.com (2603:10b6:510:1a9::15)
 by MN6PR10MB7441.namprd10.prod.outlook.com (2603:10b6:208:474::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 18:41:37 +0000
Received: from PH7PR10MB6379.namprd10.prod.outlook.com
 ([fe80::f954:65c6:3511:49c4]) by PH7PR10MB6379.namprd10.prod.outlook.com
 ([fe80::f954:65c6:3511:49c4%6]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 18:41:37 +0000
Message-ID: <bcf2024c-30e0-4d67-b5c9-def4e2ff3863@oracle.com>
Date: Tue, 20 Feb 2024 10:41:35 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slub: avoid scanning all partial slabs in get_slabinfo()
Content-Language: en-US
To: David Rientjes <rientjes@google.com>
Cc: cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240215211457.32172-1-jianfeng.w.wang@oracle.com>
 <6b58d81f-8e8f-3732-a5d4-40eece75013b@google.com>
From: Jianfeng Wang <jianfeng.w.wang@oracle.com>
In-Reply-To: <6b58d81f-8e8f-3732-a5d4-40eece75013b@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0119.namprd03.prod.outlook.com
 (2603:10b6:a03:333::34) To PH7PR10MB6379.namprd10.prod.outlook.com
 (2603:10b6:510:1a9::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB6379:EE_|MN6PR10MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: a6be375b-defa-499d-2f1c-08dc32439212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	08dr1AUubgSoIuWo5gWYzETIfP4iDDMWIW3G3NCxVXxz/f0KqIzVMQgtF2UV2PYI+gyfeWd2VyieqyI+AWeIln65RHSZDy95V27eoIIHSoK8PiRbTlu5yPJGqQBuOFhF85FrHWjVvdqvNIIoqEoDY857VmnBFLpp7jQ0++t6q7AEC6XvxnvplJ9DcdSdrWMJObd9nGs47NyYsrx1kTofvjkckEuOQFgt/3OUcb+E+Zp5epcb68rtgvKIiNxLMcvWbbkysY7LgJzzFlJokvn3z+u+DoJd7qv0tW3YSlsnpgj+quZUuMlqtKnYPe1tdRUTMb9/08ZZr8Ecu86TkESfyt6Yvda1WB6YK4Eg3i/1bfu9ggY5uRW8Mx2eZFP9eLPYZTbsc8RIc0Yw4beX0kf9OFIRIy5JR4xer4Mx+iC0WtrQU2C2KiQa6RUNYxHeDDQqm+DCOcHx+WLb6MYkcGL+Voq180AN+ZR6Pyc5N+vLMbd2qJL0WDB/lwH/xww/upuXFXUfQK1+nyPM7h9Qkcao7g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB6379.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SmJVa0NESmQ2bFIwaG90SStXdEpkK1VKTE1hVHJxN3RRcU9jbE8rSmZ0Z1Ro?=
 =?utf-8?B?aVN6aHoyVHkwbXFjbDJpN2VUdTRCSWZUZHlKT0JUcU9TZ0UrWE1iMVdWbUEw?=
 =?utf-8?B?cE9mckRoYlgvRmZiWVowdjRORENOMzl5aEdDczJ0YmI3cVQyKzA3VTNsOFZy?=
 =?utf-8?B?cWRIUENSWk5za3VSakxwYXdlbGpzWHFXd09TRzNuc3BQM25HU0taRUNyUnlr?=
 =?utf-8?B?VjlmcURtd0pKVDhIUkJvTGFRMGYwZ1psbjlQSkxiWlc3T0tra2tacVVnYlZ1?=
 =?utf-8?B?VTBJWWtqUTYyTW9YclJkUUJuenlYMnBCMENMNWd6T0p6bHIvZ09QeE5Dek1U?=
 =?utf-8?B?cUlLL25saVpVZk5xRk9QQ1o2RXJMVXg4SjloSFlYdG5mUk81b3o4cTBZcHp3?=
 =?utf-8?B?b2p5ay85R1BIRGVnWGZSMTFrclNRN2ZuSlBiQTgwb1NhZjdiR3Yydk4rSlBT?=
 =?utf-8?B?MmpBMTJ0NGYyY3hvU0RhWGpvZWdnTTVIYUdKdWdPeEpwMHYvUWRoeGpPVlNu?=
 =?utf-8?B?eVg5WjlDR1ozMmxkZVZ1NGpJVDhhNlJCR0xhVmwzd3MxOEY2RWhQeFQyeWd2?=
 =?utf-8?B?TlYySFpmR3NqeHRxdTFBTGFmQndkSWhRMGlDMGdZVlJvV0p1eHVaamZvcm5E?=
 =?utf-8?B?cnVKZU1LU1EvTGxyWXpEdGcyQ291aWxXNDhSWUxhVGpHZTd2VU1tc3JpK3lQ?=
 =?utf-8?B?Q3ZhM3REQnBZS0h4Y2MybCtkdUtyL1JmeTk0ajJFeVBIbjBaOGoyZyt2anFQ?=
 =?utf-8?B?aDJmbW1XOGRKbzNRUnNGZ0ZBV09ZanV3bHkvMUdyakZrNDZjeVlGK1EwNnVH?=
 =?utf-8?B?ZWkwaFdEZ1l5QVlmOTRiSU1id1B4RmtJdU9jMlZ5MmpDZkJWSklQT3ZxUXcr?=
 =?utf-8?B?OTQ0T2hDdlZ0SXVBYW5ZWEp6dVNUV2RIcDBocWp5ZXBVT3ZyOUxjQTNsNE5D?=
 =?utf-8?B?WlFpZFUwbTFDbXFudjc0NEFnaHl6amFjSjY4b1E5dDdJalBEYU9FNDlIYW1B?=
 =?utf-8?B?VEU5WGpKak13OEYwNGpyc1YrcDRPMGNFUDkya2U4ZE5ERmtDclVhdENFMitm?=
 =?utf-8?B?WkVnM0NKNUVObXFZdFpOTHZIMVVONCt2U3MwbmxadFBsSWNPWjJjQ1NJMEcw?=
 =?utf-8?B?b2NZSVUyUnFqWU9XdllEaXIrVC9YVmJwZ0ZFOENuRGs1KzUwam9YSFhmMjZq?=
 =?utf-8?B?NHpoaWJiT3lEbm42aEpKQ0ZZb3VicUE2Mlc4Ry9lK2VqTGFoWDlMZUtXdk9J?=
 =?utf-8?B?Um5GWXVqaFJOUXZyWkt2RzZEZXRWZmlUKzM4ZGRQcUlBTXVQUW03MEhleE9Y?=
 =?utf-8?B?VGRPeFRVQ1NMWWJJUnFvMWVMU2hhV21RdnZDQUl0Z0xEemVNeVJidXE2eWFH?=
 =?utf-8?B?NXltcDd6TmkvaWFkQlowNEhZSzhSWjAwbkdUT25ZdkdZUlIwYjdqNFkzQXIz?=
 =?utf-8?B?Ni9VczZ4ZVVSVmZ1RG5HMDJNNEgvVTBCNklxL2hZbnhCYWUyL2JtVENsMFky?=
 =?utf-8?B?a3VnSWEwT043Z3ZqQkMwdzRnRzVNdlM0b0o3WTZlbFlrZE0zMURNdm9TOUdl?=
 =?utf-8?B?R29Jd2ZINlpEYU0ySzBYRm42b3BCYzlrVTdOVlh1VExwM2xRaUR4dS9YR2xC?=
 =?utf-8?B?Qm14b2FWVjN1NDVRRFFkcVEwTEx4bDF1VlpBUDRhaEU3bWdsNnVvZ2Q4SWc2?=
 =?utf-8?B?SGo5NG81eWhFdmx0UkoyeUpGNjlpZnA4SXRLMmhiaDAyY0xPVDk4QjMyU21U?=
 =?utf-8?B?RENhdlFJSm9rdndSeThVOTkwTHlraTZSclVEYS9iajJCYW1KVXJwS1VrYVEz?=
 =?utf-8?B?eGh5ckp0eVBuZVhFQlo2RUt0VlpoNmFjSCsrQW9SQXdncWo2MGZITUJFRVVk?=
 =?utf-8?B?RU1YakVjVTM2TVMxSjlLVURVeWd2dmk4SlJKS0VYRGpkeHV4UVBDYnNiYm1u?=
 =?utf-8?B?THdiQ2NQaUY1bko2dzA0Z2tJWUdhY2YwTlZEb3p5R2tWLzRmT1Nsa2xCOFI4?=
 =?utf-8?B?R2g3YzU4SXZHZTIwODZvdk9aVXRZeGRVcTZYWi9DeEN3Z0lKWTRKTGEzeWNU?=
 =?utf-8?B?Sk0xekJkc2lvK2pFQmNmdm85NERsMEpJcEZsb0Y2UEJMalUxKy91dXduTlcr?=
 =?utf-8?B?c2R1VDRBYlZjZCtDdGdsS0NjSVo5aVR6MzQ5Ykd0RkY1ajNSYmE2Q1NHU2Qz?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ANevvfbGn5HXqmJpNs02Bjps0wtM0lG3lsbIoBnBN/xl2r7wK5L9j7oxLlOyakmlREAAYzXZA2NG9REfLImNljipI48qHDZjS3bS7gymfNYmw93Qm4gzlXTsH7jZCsrpvqzVIU03tjE/GGb1G37rfe+MboYnaPk6RsLJRpW0xYTRWq11MBhoaQqdXiV5vpWNHSTwKTtTRgxsEwzkXctpbLOnUHYRs6xVVGXJ/FkrJTIP+oBFLCfErF++EC00BxXmSip+DENF3e9/Uk7YkAk/l3V8SjPO5fIZ5nUpRcd7G1fnoquNPcBt4WK69/SU0f0N4z0PYYjCJuhsWbhJe0y+q5SE77DsZkfMzNQxc9mwFqoLqpb4FWRzkxElGFh34B9SG7VHiC/JqDFVCSyFyCVMhts0ipMYhJfJXCuB++hlCO4KlhXcqlyQKyFie7HqnzZH2PNs5gJQ5fIvugvSVqNm05+iPfAac7PdeuxkWfrEUVFxyrwqsguCkqBm/cUq+Q7r0zx0/MAXR1oNK++CpI4iiOyv5Rsz9bAcmPY6er4Uq2JHDP3S61YLHR+a6GM3wm3mxu5lDHnjyt02xlZ2mGF0wiZ+/bamBx9DO+vuKyJqDrA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6be375b-defa-499d-2f1c-08dc32439212
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6379.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 18:41:37.7044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxPkHsUJUpeZGPdcKtPZ8FphTAJNurk3vRis5TWYrc3Qcru20ujsIuYCdIMazrMs6FFn59X2wBNzXyNktWPfcW4DiPEjtf/OXREPEt36a/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7441
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200134
X-Proofpoint-GUID: 3itxu5lcc62I_OF8_34tyQR1i012_NQt
X-Proofpoint-ORIG-GUID: 3itxu5lcc62I_OF8_34tyQR1i012_NQt


On 2/18/24 11:25 AM, David Rientjes wrote:
> On Thu, 15 Feb 2024, Jianfeng Wang wrote:
> 
>> When reading "/proc/slabinfo", the kernel needs to report the number of
>> free objects for each kmem_cache. The current implementation relies on
>> count_partial() that counts the number of free objects by scanning each
>> kmem_cache_node's partial slab list and summing free objects from all
>> partial slabs in the list. This process must hold per kmem_cache_node
>> spinlock and disable IRQ. Consequently, it can block slab allocation
>> requests on other CPU cores and cause timeouts for network devices etc.,
>> if the partial slab list is long. In production, even NMI watchdog can
>> be triggered because some slab caches have a long partial list: e.g.,
>> for "buffer_head", the number of partial slabs was observed to be ~1M
>> in one kmem_cache_node. This problem was also observed by several
>> others [1-2] in the past.
>>
>> The fix is to maintain a counter of free objects for each kmem_cache.
>> Then, in get_slabinfo(), use the counter rather than count_partial()
>> when reporting the number of free objects for a slab cache. per-cpu
>> counter is used to minimize atomic or lock operation.
>>
>> Benchmark: run hackbench on a dual-socket 72-CPU bare metal machine
>> with 256 GB memory and Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.3 GHz.
>> The command is "hackbench 18 thread 20000". Each group gets 10 runs.
>>
> 
> This seems particularly intrusive for the common path to optimize for 
> reading of /proc/slabinfo, and that's shown in the benchmark result.
> 
> Could you discuss the /proc/slabinfo usage model a bit?  It's not clear if 
> this is being continuously read, or whether even a single read in 
> isolation is problematic.
> There are several use cases of /proc/slabinfo.

Some monitoring tools run in the background to collect system-level
traces to enable performance analysis and debugging. Collecting
slabinfo is one task in the tools.

For example, I've seen an OS crash case: based on kdump, one core runs
"cat" process which runs count_partial() on a kmem_cache_node for
"buffer_head" slab object; the kmem_cache_node has 1,103,484 partial
slabs; many application threads run on other cores and are in
__slab_alloc(), waiting for the kmem_cache_node's spinlock. This leads
to the node's crash.

In the meanwhile, some engineers/customers may collect slabinfo
when conducting performance analysis, most likely when nodes are
under memory pressure.

Both cases can trigger the soft lockup in production. There are several
similar reports. Thus, we'd like to resolve this type of issues completely
by getting rid of count_partial() in get_slabinfo(). I believe a proper
fix is wanted by several others who also reported the problem.

> That said, optimizing for reading /proc/slabinfo at the cost of runtime 
> performance degradation doesn't sound like the right trade-off.
>>> Results:
>> - Mainline:
>> 21.0381 +- 0.0325 seconds time elapsed  ( +-  0.15% )
>> - Mainline w/ this patch:
>> 21.1878 +- 0.0239 seconds time elapsed  ( +-  0.11% )
>>
>> [1] https://urldefense.com/v3/__https://lore.kernel.org/linux-mm/__;!!ACWV5N9M2RV99hQ!JxjieJXhYB_Uehnw5O9tn8CCMdkk4siQXleaZ9rDoRFFIcimaceibjyW026H3vPp2DdaXb_1siulMi1TVeVKkbM$ 
>> alpine.DEB.2.21.2003031602460.1537@www.lameter.com/T/
>> [2] https://urldefense.com/v3/__https://lore.kernel.org/lkml/__;!!ACWV5N9M2RV99hQ!JxjieJXhYB_Uehnw5O9tn8CCMdkk4siQXleaZ9rDoRFFIcimaceibjyW026H3vPp2DdaXb_1siulMi1TgMCGM94$ 
>> alpine.DEB.2.22.394.2008071258020.55871@www.lameter.com/T/
>>
>> Signed-off-by: Jianfeng Wang <jianfeng.w.wang@oracle.com>
>> ---
>>  mm/slab.h |  4 ++++
>>  mm/slub.c | 31 +++++++++++++++++++++++++++++--
>>  2 files changed, 33 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/slab.h b/mm/slab.h
>> index 54deeb0428c6..a0e7672ba648 100644
>> --- a/mm/slab.h
>> +++ b/mm/slab.h
>> @@ -11,6 +11,7 @@
>>  #include <linux/memcontrol.h>
>>  #include <linux/kfence.h>
>>  #include <linux/kasan.h>
>> +#include <linux/percpu_counter.h>
>>  
>>  /*
>>   * Internal slab definitions
>> @@ -277,6 +278,9 @@ struct kmem_cache {
>>  	unsigned int red_left_pad;	/* Left redzone padding size */
>>  	const char *name;		/* Name (only for display!) */
>>  	struct list_head list;		/* List of slab caches */
>> +#ifdef CONFIG_SLUB_DEBUG
>> +	struct percpu_counter free_objects;
>> +#endif
>>  #ifdef CONFIG_SYSFS
>>  	struct kobject kobj;		/* For sysfs */
>>  #endif
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 2ef88bbf56a3..44f8ded96574 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -736,6 +736,12 @@ static inline bool slab_update_freelist(struct kmem_cache *s, struct slab *slab,
>>  static unsigned long object_map[BITS_TO_LONGS(MAX_OBJS_PER_PAGE)];
>>  static DEFINE_SPINLOCK(object_map_lock);
>>  
>> +static inline void
>> +__update_kmem_cache_free_objs(struct kmem_cache *s, s64 delta)
>> +{
>> +	percpu_counter_add_batch(&s->free_objects, delta, INT_MAX);
>> +}
>> +
>>  static void __fill_map(unsigned long *obj_map, struct kmem_cache *s,
>>  		       struct slab *slab)
>>  {
>> @@ -1829,6 +1835,9 @@ slab_flags_t kmem_cache_flags(unsigned int object_size,
>>  	return flags | slub_debug_local;
>>  }
>>  #else /* !CONFIG_SLUB_DEBUG */
>> +static inline void
>> +__update_kmem_cache_free_objs(struct kmem_cache *s, s64 delta) {}
>> +
>>  static inline void setup_object_debug(struct kmem_cache *s, void *object) {}
>>  static inline
>>  void setup_slab_debug(struct kmem_cache *s, struct slab *slab, void *addr) {}
>> @@ -2369,6 +2378,7 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
>>  	slab->inuse = 0;
>>  	slab->frozen = 0;
>>  
>> +	__update_kmem_cache_free_objs(s, slab->objects);
>>  	account_slab(slab, oo_order(oo), s, flags);
>>  
>>  	slab->slab_cache = s;
>> @@ -2445,6 +2455,7 @@ static void free_slab(struct kmem_cache *s, struct slab *slab)
>>  		call_rcu(&slab->rcu_head, rcu_free_slab);
>>  	else
>>  		__free_slab(s, slab);
>> +	__update_kmem_cache_free_objs(s, -slab->objects);
>>  }
>>  
>>  static void discard_slab(struct kmem_cache *s, struct slab *slab)
>> @@ -3859,6 +3870,8 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
>>  	 */
>>  	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init, orig_size);
>>  
>> +	if (object)
>> +		__update_kmem_cache_free_objs(s, -1);
>>  	return object;
>>  }
>>  
>> @@ -4235,6 +4248,7 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
>>  	unsigned long tid;
>>  	void **freelist;
>>  
>> +	__update_kmem_cache_free_objs(s, cnt);
>>  redo:
>>  	/*
>>  	 * Determine the currently cpus per cpu slab.
>> @@ -4286,6 +4300,7 @@ static void do_slab_free(struct kmem_cache *s,
>>  				struct slab *slab, void *head, void *tail,
>>  				int cnt, unsigned long addr)
>>  {
>> +	__update_kmem_cache_free_objs(s, cnt);
>>  	__slab_free(s, slab, head, tail, cnt, addr);
>>  }
>>  #endif /* CONFIG_SLUB_TINY */
>> @@ -4658,6 +4673,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>>  		memcg_slab_alloc_error_hook(s, size, objcg);
>>  	}
>>  
>> +	__update_kmem_cache_free_objs(s, -i);
>>  	return i;
>>  }
>>  EXPORT_SYMBOL(kmem_cache_alloc_bulk);
>> @@ -4899,6 +4915,9 @@ void __kmem_cache_release(struct kmem_cache *s)
>>  	cache_random_seq_destroy(s);
>>  #ifndef CONFIG_SLUB_TINY
>>  	free_percpu(s->cpu_slab);
>> +#endif
>> +#ifdef CONFIG_SLUB_DEBUG
>> +	percpu_counter_destroy(&s->free_objects);
>>  #endif
>>  	free_kmem_cache_nodes(s);
>>  }
>> @@ -5109,6 +5128,14 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
>>  	s->random = get_random_long();
>>  #endif
>>  
>> +#ifdef CONFIG_SLUB_DEBUG
>> +	int ret;
>> +
>> +	ret = percpu_counter_init(&s->free_objects, 0, GFP_KERNEL);
>> +	if (ret)
>> +		return ret;
>> +#endif
>> +
>>  	if (!calculate_sizes(s))
>>  		goto error;
>>  	if (disable_higher_order_debug) {
>> @@ -7100,15 +7127,15 @@ void get_slabinfo(struct kmem_cache *s, struct slabinfo *sinfo)
>>  {
>>  	unsigned long nr_slabs = 0;
>>  	unsigned long nr_objs = 0;
>> -	unsigned long nr_free = 0;
>> +	unsigned long nr_free;
>>  	int node;
>>  	struct kmem_cache_node *n;
>>  
>>  	for_each_kmem_cache_node(s, node, n) {
>>  		nr_slabs += node_nr_slabs(n);
>>  		nr_objs += node_nr_objs(n);
>> -		nr_free += count_partial(n, count_free);
>>  	}
>> +	nr_free = percpu_counter_sum_positive(&s->free_objects);
>>  
>>  	sinfo->active_objs = nr_objs - nr_free;
>>  	sinfo->num_objs = nr_objs;
>> -- 
>> 2.42.1
>>
>>


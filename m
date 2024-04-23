Return-Path: <linux-kernel+bounces-155271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B19E78AE7F2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6894D28E1BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F3013667B;
	Tue, 23 Apr 2024 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RQM32b7D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aFoqH4N5"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDEB135A7D;
	Tue, 23 Apr 2024 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878473; cv=fail; b=AqcsPTLY66ABopHjRmQLeB/nI7BVKu2n8TSC/BcLjMq/UjuF5WI73xb/gu5trkgCy/7m7FmoLOssjXIJN8r60D7nOepzL4Pekn5MkfOHWXE0bkTSncIH9uNeA+eSj3u86yn4vcBijUWt96qfzIyQU1NyHIa2DEj3f+aNW4sIlj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878473; c=relaxed/simple;
	bh=E/Iiniyg40VUhX6Fe9u1SZwLWrpvlm7exKIbG5Yc3QU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iEu5UnB7GXy8RUpDrdwrcbOZTV4SnHnCR+yUhD85F9utlFyPLUOaojZw2fbJk5RFYD/5ka5D0V+Fe34XfsQPhfxzaQmHNrxLe2BmmC9V+UUVs6ukK7Ncp3dxvmwpLdlTTk9cGGSlu9g1KZ5cUmsWMYM6vjmugcCff670nHC6sHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RQM32b7D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aFoqH4N5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43N7Y4hk031855;
	Tue, 23 Apr 2024 13:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=aOx/wzUVSXOQdNvmK8sPNpus5EI4JyxL15o6PnK3hdU=;
 b=RQM32b7DAu7YdhBkW1wkHRy+oiw+FNMXq3adPkjjiFWJ5kgDv+NRxKi+zJxNz566fTe9
 Lp+XF39s/W/oP58l0ws4KeAbhSNvnQ+yH5q1p4WwTFqs6YITj7Bu3kmckBBxAMdoDKQY
 v4GPMkiPrWWPa+1fBU33ljyyBwp+GZj9LEckdn7nawfCkZw1/VVNDARnyOVFm7v/hWhH
 uipau5EGplDcByiaUEgMUzzAHv1Jw+6s40gGxp8nFgq5aqa/PGAmNHq82TO/Z6uHLSFA
 Q4ymYqsv7tA6+kJD2RRJY9VlBwMYScOLrdrhzN/aG6SdI7NrX4pSnR/RmUOSeFf/jrQW QQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5rdw5wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 13:20:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43NCIjfs035601;
	Tue, 23 Apr 2024 13:20:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm4576ym7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 13:20:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiDi4dQ7biMp3Qh0uFVY09lW9t1LIdT7cXTX8e7ntYgwm6JwrWjmY+CqwM4NrvNXk6+w2nxUJ4/epRCaHsqlwWt+ZhuyOtjDfJxi/QHfweSJrsHTMeqfyntHqvkquxhXZE65/VFwmB6hAMzKfrdhYmt/ZLgMSnlo9rd7LWKQq59u8drR8rz+a0t1sufA8VjmIVT9buVZ2lQN9VJWUa7feW/c+anpcdPRfalw9gU+W+CmipdbPJDncI6Oxjm0iwBstgjw28QAmgNyZrwafMBX0l7Q6pBXH6mlnifBu0BvFrciH1W1oQHB3vkqKRG09xM4gYQNbm3R+NkuGq9FhHuNhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOx/wzUVSXOQdNvmK8sPNpus5EI4JyxL15o6PnK3hdU=;
 b=N7VcY8QGhzDEq4QH5JGKAHsqEmpUNtUtFBRJkogeUprHyn4JnWLfG4H0j+WlnVmi+4Z4zu+C6GCHXVjSuIcSwt4rW8wl0Fyr/NoLyVBCBWFW+8mh5H8UbJXe4O1I1KsyTAe5uiuWzGc8wX4wsvYNqCsWInlJ2V2jhgvcxvoGVMe7g+DlXTCZSBuowaYExfRHkw1bEb8GgYZ6O95Vva1Y+YVHZOTDCusKUGtWujRhQBWZu6q5JqOnKVuLvABEhCmjVwHjlnhkjR45x8lJIyWmWK3VlrYILjhRRblWdRmUbdO1biXWfDUrEvQHn7O8qCqh8iOctCtrdY0skBaS5jji8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOx/wzUVSXOQdNvmK8sPNpus5EI4JyxL15o6PnK3hdU=;
 b=aFoqH4N54WW1wjQL3XlFSx2jOpRw5drEGjhs7f6jPO9ABCzuib5cqO5HqUI1sLEC0r2Cr6vdaA/LzWizsswgWTSbEMEDtYmYLY1YPD7B6/yz7bIm9GS5BwmwboQDjiTEjeOuRgfZ0F9BWFDSV8uouwQe9Djd5XKNp/ZN+8ZHMcM=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by DS7PR10MB5973.namprd10.prod.outlook.com (2603:10b6:8:9f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 13:20:38 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::88ef:4ee:6255:5391]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::88ef:4ee:6255:5391%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 13:20:38 +0000
Message-ID: <c8b72a0a-93af-9024-1fec-5cd56b57a933@oracle.com>
Date: Tue, 23 Apr 2024 09:20:34 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] admin-guide/hw-vuln/core-scheduling: fix return type of
 PR_SCHED_CORE_GET
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20240423-core-scheduling-cookie-v1-1-5753a35f8dfc@weissschuh.net>
Content-Language: en-US
From: Chris Hyser <chris.hyser@oracle.com>
In-Reply-To: <20240423-core-scheduling-cookie-v1-1-5753a35f8dfc@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0007.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::20) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|DS7PR10MB5973:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af50238-c58c-4a0e-5dc4-08dc63982abe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dUVBMlVuWVlPWmU0bXRHQUgwazVXUTA2YzYvSVNDTzZWbGRTVEVXeldMbEZv?=
 =?utf-8?B?Mmhuemh4ZDY4LzN3c0FGTUVPQUlJL3htNG5MRHJSWXg3dTZGZkNBZGdxbjNX?=
 =?utf-8?B?UXl2MzNlYVpoWk83WUtjQmNnOHVSVDNydlhUTTVXVEdKc1VwQXFjZ0lLR1VZ?=
 =?utf-8?B?WTRkajFyTmRpTWljZ1d6cXcycy9OQ1R2NEJ0MmY3a2M5aU1rdFZnT3Y3RUhE?=
 =?utf-8?B?ZUFkRE5JZEV6akpDWG93U2xOUnVJS2pSZjdZNVlGMEpEMUo0cmVNRFlhSHlo?=
 =?utf-8?B?SlVXTDN1WFNZVVNZemJNc3hMeFZVeVJWUEdlMHlFNHoxUEZaVFJWYjlQY0Fw?=
 =?utf-8?B?NVVaektZeDdVMkllUC9jRElFRWtIWXZEQk9uNE9CdVp1YjU1dXV0L1FKQTEz?=
 =?utf-8?B?SzhKRkk0TXNOcG1kWVRlb2hTVkcrWURhZDZ1bzdjOFJMNVlFOFYzS2dQd0Fi?=
 =?utf-8?B?YUZWbUtyd21lN3BlY2ZvTTkyejFZQ0J5ZnNEQXdmMWdvZm1QdkR5eTNKdGsv?=
 =?utf-8?B?dkFHcGdyZklqZDhSTHJPRmtIdkNqbG1CZHZZOWJBM1FKZmxQckFkdFZ6dXNZ?=
 =?utf-8?B?R0NQaFJHSG41bW9sQWJPU01NVzJzK3BVamxKejV4TUZCRXk0RU4rWjYxK3R3?=
 =?utf-8?B?NkVIbWYxU3hBYkhYc09DNll6MWVxSmV2dkxXNFFNMzFTd1lmQU84YU5oZUxV?=
 =?utf-8?B?Q3RCNWVlK0hNTHlKVGxMZ1hCK3Qzb0ZrT0lVMUZRcnh1QXcxU2JNREFEOS8w?=
 =?utf-8?B?Q1dMQzZ3eXRqd25qUEdEYUVSejFkUmxHSmt3OU5QemV4TVltOVB2dW1TUjI1?=
 =?utf-8?B?R2htS3gvSFQ2eldnUmlvRXVBMFMzU2tXV05SZktKVUZpSWhreC8yUzZaazcw?=
 =?utf-8?B?Q3pIYmpPSnNwUWdJSFJpZVFpTEZ1K3ljcUVNeVBDdEV0N3d2emFEbklXYXgv?=
 =?utf-8?B?b2pnY3lmL3FDa0NCNEs0bmdUUGtzcVIvSkhsenJDZkFzRXE4S00rRVFEZ1Zo?=
 =?utf-8?B?Vlp4SXcwT2FRL3cwcXpYYmx4azlVMEZIaTVMVGExQlN1clB2WXlBT0VZWjNp?=
 =?utf-8?B?T050dWtmK1BOOGxRK2lMUDc3aGlCSkY1WWZEYWtiRjhhSnhqVjlLYXVIeS9r?=
 =?utf-8?B?R0pISDFuTnJPZ004bHFHYjE4SS8xQjJlaURLd1MxTE9yL1loL0Q0cmZzRzVz?=
 =?utf-8?B?TUlWWVdvWGp1T29MenFZREhNNWxsaGlCY08xOTh5RTlpWHUvM2pPM2tKaDA3?=
 =?utf-8?B?RWV2QXVMTlp6eU82UERIaFRSREhWZHYwSit0aGJtRUpneVJiMDZoVXNmSk13?=
 =?utf-8?B?czBnVXVtalZQQUpldjA3Zy9vdmRDSjMvazg3OExHM0NyRXlLTEpxaXZPTEdQ?=
 =?utf-8?B?Zm8vNjdpSUJDbXRGSGZ0YXhwZUh3aUFoVmo3WGg3N3pHTi9RVTFuRFNONVl3?=
 =?utf-8?B?dmc2dTdBcDJjQ1NjeHZkd09JTnJrMEs5MlBoM3pZNTBlamV6ZTRyT29vSytu?=
 =?utf-8?B?VVJLL1hLS0VDUjVFVWRHTVhpbnlwa1hkYTd4dzhoY1ZMaisxWjkzYWNoSWNl?=
 =?utf-8?B?TnhNUDdIUURYVzd2a1BTcUM3aE96ejNvOHZNcXFwaEdXSmsvS092dTZucTVC?=
 =?utf-8?B?U0Mzb3h5TkEwc3I0SCt5dWZtdElaV2FheFZZbit1aTFjRGNsczdZVXdkMjY0?=
 =?utf-8?B?bEN4TU5yc2VpY2FQNXpLaUFTV0hzZDNDZHIwSHI2d28xeE5kMTFta1VBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QlMyWFRiYXpGSnFmM0xDT0xjaEUrSnVuNXQyOVlGNG5sa0xQeVFhU1NlTHVk?=
 =?utf-8?B?R21ta0lVTmdaZm9HSUkwNnd2ZytrM3k0cUtCTm94bGhYWVNsTEo2NWlKTWpJ?=
 =?utf-8?B?QTNVd0pFRHpUVGY2YjJOdkNjdU1nK2xXcHBHZFYvblRlSDNjSTlsSndNR3Rx?=
 =?utf-8?B?MUNwMFNJM1ZXTXl1MVR6MkZuNzRLRFMzdWRhTFQ3RzkxSm44UlNzVk5XU1kz?=
 =?utf-8?B?L3ZVU0pRZWU1TC8wWExNQXdBNlkxbDRFSVZRMTFQbkdFalFrOTNEUXJ4YzVj?=
 =?utf-8?B?alFHV3RwWEdsM09xaittWlNVSFQ0T2NQR0dod2JmelN1dVRYNHgvSG02Nmo1?=
 =?utf-8?B?bGRGYmtlZjZISUJDayt5SnUzUm1wTFAxYmg1c2JSTjRXVmpuM2llVmY5YUlw?=
 =?utf-8?B?cmZsd1oxUTFBUFVseStYSmZpb0hiMEZNb0h2aVFJSHFER2VkTFlWbTYrai9T?=
 =?utf-8?B?MTNEQzd4VVl4cHhNTkF6ZFZHMUxyYVB4eFhzTDFhSGFHL2hYUHUwQ2llYXYx?=
 =?utf-8?B?bXpwQ2RCRkxkaFQrTWtETW5Lam9oc0VMTUJIZ3dsa0U5eENtcjFpeGxxUlNX?=
 =?utf-8?B?c29HTThxVTc3VGJ2d1JKVXpwTmZnNkRRdkU1ZXFwaGlSVE1kTDFhSHU4Zml2?=
 =?utf-8?B?c2xsclRGZ3dpZ0htMTVTcnY1YTFCR0JQQVdrdFdNelFNZnZ1MGJpMXY0dGtF?=
 =?utf-8?B?U2NJTTNxMkIrTHcwVE14eFdwK3NOZThHL09iSzFRc1JHSWxNYUlTVTFTcldp?=
 =?utf-8?B?UVlSV1pvb0xFbjRkaER3Ymhxem9NdzJMcm9hdWFqRWhjNGJZVlJsU0xXanF5?=
 =?utf-8?B?NXA1MmNyTjIvZTZyQ3NwR2JSTXNFRGdHTWNIR2J3cU9VS25jQmVtQkJ3OWhG?=
 =?utf-8?B?YkdpRXlmZ1gyVzhGWHRuU01uQmhvVC9hZW1ZcVUwWGsxdGlXTmgwcG82blBm?=
 =?utf-8?B?Rjc0bkk3b0g4OStvUGNEN1QzTU9qYUZUVmtVckkrUmdlK1hmcW5mdURZRC9l?=
 =?utf-8?B?bWtuNC9QQVpMS2tMdVl1S3dSTWs3VUoxU0w5Y3BWUmlqQjRMekNzVnhRUndD?=
 =?utf-8?B?QXljRkZSWEUySHdPUEtiRnRJZlVmdnV4Zm1Mb09HcmFEWURkcFdIeDRqUS9w?=
 =?utf-8?B?TWtiSk1nR0p5dU5xb0k4M0Uwei9UeFV1S2lqbGs3Rk9YK25LMUhpOTdjTUdq?=
 =?utf-8?B?ZUVJNC91NlBvMnpUK091TjFxQ3RVRkFTQkg1TVhRa1doWnAvL1NZclJNWXVk?=
 =?utf-8?B?OVZKZ3Z1M1ordjZ5UzVzMjRTOWg4SldrRENsWnN3eTBqQ1I3RjQ2Z1NrejVR?=
 =?utf-8?B?T1RjcEVYa21lMnJjMllSTlVKL3dWL2dzTmJSYm9PL0dQRy9qQWRaNndHKzBF?=
 =?utf-8?B?cmFjOS9BeERrYmwxK1c3K3YrYWFiaDVzbDk0Z3YxTmJXNXFRMTZwTUsxeG56?=
 =?utf-8?B?OG9NVjh1K0EzMC9aUjFzbjdYOEdqNnJNT2dFVklJVWFIK3YzdHM3d3NIK0lE?=
 =?utf-8?B?TmJWV25ER3dZYXgzRnQ0alI2OGlZb2ZIZTdnUCtBY1ZXNzVoM2JGbEF1OU9B?=
 =?utf-8?B?cXdSOTl3dndqeEt1b3o3Tm5PRFhaaStwNURCOE1CTEFSN3JxcGNHeHJWZHVp?=
 =?utf-8?B?aXMrS29MbkY3WGVnOTJyT09NUWZqVUpFamRNeU9aUlQwRU1aeTNtZzcvOXgx?=
 =?utf-8?B?UW5nTmtIZnN6QldwSHBCQlpPNDNURS9QLzc4WU9PMmpnSitPdWZzbFZ1NnR4?=
 =?utf-8?B?d3J4VlhXYTNTbTE2c2RnTVhOQkQ2Qjl3RElibE9hTVV4Q3Jrbk5ZaFVHTjNn?=
 =?utf-8?B?eWI2OWlFa2NTZzBoUHk2VFZ4V1VsZGV5WFl3MXFSa1ZwQ3ZGTW1tN2E2VjlJ?=
 =?utf-8?B?Yi9oK3N2RHBDQzRKeGJWUVVrNnFnd2h0ODlWYkhvVHhVd0RxTXNzeEsyWW5T?=
 =?utf-8?B?OXh4SFM4S24wdWFOTnVUK1EzRHI2cWpjZXQ1MTlOVWxiakZzTjRoL1JZWVNZ?=
 =?utf-8?B?cG9PcGYwRWJSMkZ6L0Fnb1ZIVlZlZE9YTzJHT3JhZEMzTkRiQmJ0NUJYUUN4?=
 =?utf-8?B?VXpxMm9CQjd4TGdvQjdHM0ozM1pWMy8vWjdOVmx6NVQ2bGptMkZaZGJmZ2ow?=
 =?utf-8?B?Qk9HOHRiVE5BVXV3TSt4eTNEcUxUUlV5L2JTbFc1WDVrSkR3M3hkRWFYVTVV?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	h3hRAqZMO/9RtDCofg3J3hm5nz9N0kqojrNDTwNAdHDofzMhpTeuiDAu/uDB0Tn5akMhESKRTEtecMGiAcrgKgw2V5ysuQ/y9/3MHjY7MZ5CvlWToMA5m5x0P62XNCNEXcd4C802F4J9BmRnF5cWiPdmE0BoSVfM0fzEdNxUGwmmSVi/L8xSIv1HTcr18UDnSv6LMlXJ+KhDT4GS1iHywCw7HgSA7F6RjM0Jvr0PbOnKmMWYFzDfP7mdMd48//klrZ5Ta34APJxVoJr2HY7UUXvBQSjK5JBaWkuEWmecQRq5J9uG0HlYzaAZ008VnnKRtglYUuub0dPlUkboZqjsFpy9Wo/q/0G62vhCqoyNyxabRM5Gv9aKJKorfpAnZSzssb7l6ZRiM+0rRkETTcZtmTglNo5TmtnG7leRS512DJVMCpuS+p7bmCA0YQmHnrMmoXk7qcK2fIHGXvg44sqKoGrTcJE6/2KAC3FfATLXVB+doycnK35OJAUQMg3dATc4HqcZ0UlU9jffGdPzar+9NAlvt2+siG6FERugnAPgu/z6oTujg62CSbpZur/+lC0WsG+b2VQluhbmcrwChKfpST7e4LUpJRkhy2Ay7R/j3/s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af50238-c58c-4a0e-5dc4-08dc63982abe
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 13:20:38.4669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88k+y4rUFL+eNPFGm7SypmbBsCn3AL9XQoWQzU5DoQ6ofY+p8tZLheStvawl3Ey7FANydzTJMsCYQ6BE5Zi4vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5973
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_11,2024-04-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404230033
X-Proofpoint-ORIG-GUID: aLzSRgbjSFTHyLFdJd5ZyV6y-F_BwCOa
X-Proofpoint-GUID: aLzSRgbjSFTHyLFdJd5ZyV6y-F_BwCOa

On 4/23/24 06:34, Thomas Weißschuh wrote:

> sched_core_share_pid() copies the cookie to userspace with
> put_user(id, (u64 __user *)uaddr), expecting 64 bits of space.
> The "unsigned long" datatype that is documented in core-scheduling.rst
> however is only 32 bits large on 32 bit architectures.
>
> Document "unsigned long long" as the correct data type that is always
> 64bits large.
>
> This matches what the selftest cs_prctl_test.c has been doing all along.
>
> Fixes: 0159bb020ca9 ("Documentation: Add usecases, design and interface for core scheduling")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/util-linux/df7a25a0-7923-4f8b-a527-5e6f0064074d@t-8ch.de/
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>   Documentation/admin-guide/hw-vuln/core-scheduling.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/hw-vuln/core-scheduling.rst b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
> index cf1eeefdfc32..a92e10ec402e 100644
> --- a/Documentation/admin-guide/hw-vuln/core-scheduling.rst
> +++ b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
> @@ -67,8 +67,8 @@ arg4:
>       will be performed for all tasks in the task group of ``pid``.
>   
>   arg5:
> -    userspace pointer to an unsigned long for storing the cookie returned by
> -    ``PR_SCHED_CORE_GET`` command. Should be 0 for all other commands.
> +    userspace pointer to an unsigned long long for storing the cookie returned
> +    by ``PR_SCHED_CORE_GET`` command. Should be 0 for all other commands.
>   


Yes you're right, that is what the test code actually does.


Reviewed-by: Chris Hyser <chris.hyser@oracle.com>


>   In order for a process to push a cookie to, or pull a cookie from a process, it
>   is required to have the ptrace access mode: `PTRACE_MODE_READ_REALCREDS` to the
>
> ---
> base-commit: 71b1543c83d65af8215d7558d70fc2ecbee77dcf
> change-id: 20240423-core-scheduling-cookie-b0551c40b086
>
> Best regards,


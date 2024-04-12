Return-Path: <linux-kernel+bounces-143212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB678A35CD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8884C1F246C9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB6414E2DA;
	Fri, 12 Apr 2024 18:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xkd5sdQF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PSrCesWU"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F0418B09
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 18:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712947026; cv=fail; b=UDC4YNa6OFJeNVeRaHH7MllqK58yL14CzVo8s/U8EIFxqqR0Qv2D5TA+UPaxgg8r8ah8T0a8FH62t3cPBdLC/sFu+GXEvL8ppOc6mpTs07tmx+cCijKvmRsu32R6LzB20aEur4vkXAx2dpMm1p3WzOQpXrvj5xIx6zQnW9hU87o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712947026; c=relaxed/simple;
	bh=S5iRyLNFBpZiihFl08iUHDyuFnryezDhz9YjbBIFr6c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KJXaJHdqG8zK6w1T12pUlmljk4eABFFIJUVgBpTizhT1qbCCydarUNn98mQ5SscDaT7U3RVt27bJ/DbtnskMlb5V/Pzhsfqj5SxgX0YTvn8Kct4A7xUrzpDJeRtCC9/sAiXYdilBVlwVte87wPW6t0YaJ4Y6kHOM8AwmegyGlyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xkd5sdQF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PSrCesWU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43CHVecn023458;
	Fri, 12 Apr 2024 18:33:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=jJpEOg+9HlEx+z8vcH3Lu3kWZnBZcUQih5iG5rRaH0M=;
 b=Xkd5sdQF02bY+uQHYpRQ7rvm+6SOWNzxJ1DRga/x9weSyyCkyAqfPXP8ppDXxXWAY582
 igG/M4lzKV+xNMG8Alcm2g3CZQfecnH3D6nFYUf24VQrwuI6GpfiIr9JtaNCdhln7g2v
 eD1anG9UG133W1m1tgZr/Abzi4fxjlTNPKzGOFFs+QmhBaJNpeg6tBUtJFk05/Xe9mNg
 Vgbf11KPyUo1yGcAmV8R8AN5dYnKHUQj5ZWmpQWhyManj14NvaAvtQiG4YVtj/Lk50Jf
 MUEwGenGETegAf01qr+ibLDpBb0wDSLPMhDCNI41D8ncWlYsn+t+wkSKwGidgjQPUlTA 0g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaxxvmk31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 18:33:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43CGo5wM010592;
	Fri, 12 Apr 2024 18:33:34 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavubbc64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 18:33:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMkAfawdsT552PyFR4MVPfchAK6xKNeTUjS2vFrt6s+SqnlOmX1HAqPycpjtWjATRGQNCUb0jIg2364cZzxZZuyIVCJZg9XkLWxvQgH1GOAEf+yIl5E1ucLwaC55Ak8BtzFxJMxakHfaMNg2C7M5A6ATThKB0CrAAd8ARAnuX16I7c0X7aAWMZD0AtGcyZlbamtjJ1b6gY9nwkybRbP1FYjedOAYct0ZiXeYUZ+vEb3/EDHwbWw+jpPLMvNXgc+Wf0jSYDWZqAi0eaaP/r1vDQ6UXfF3MCQD3Gk+eYtfMs8pyvNjUrUFiQU5nSputO4Kj+7QcnkIBIe7dzOG0KsxAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJpEOg+9HlEx+z8vcH3Lu3kWZnBZcUQih5iG5rRaH0M=;
 b=KeM0Z7j1LQTVaBlbx+88N9oK6GBKdBnK5WS0KlztszkninFlsvU1wTuFQ2+b9zlBP0oK6aAtaQBqDhyT8ywE/lTN7DvepaKFSZTZ4NdpQNfQM9zN3kUL3k4S9dBXePOnbiHse718rBribvZ1fKC3VRiBx8v5A8dYfqnYX/w3284YosUZfuZTymcWWJ+8qSyznYfwUgT+3+E28wx4+TuBGZ7kkwnJv2IQThk4aQgWi+x+uN3xbjA3vYzRRNcfVIuicAHBVGXA5tS5HmzfI84WJ3AgxLSFIZ9x9wI5A9mVwjUE9rBbp4yiRGRtemjgNAHsqivk92cJ6GPE5kFujp+/hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJpEOg+9HlEx+z8vcH3Lu3kWZnBZcUQih5iG5rRaH0M=;
 b=PSrCesWURStyYxaVDDNtvir1m8zheKTNp3YI4znX/qwRjUlH4GYgQ9gJubL1nUj/7Pi/ChtceQAtQlmfxtlc6/YimQVxgQXlO13ftsxz55c+JATTBuukxBHA58hNcKaK1IhwclvHGw5mAYw7v49JaDpbKE9uKnuOxp/G+hJOVPA=
Received: from PH7PR10MB6379.namprd10.prod.outlook.com (2603:10b6:510:1a9::15)
 by BLAPR10MB5202.namprd10.prod.outlook.com (2603:10b6:208:306::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 18:33:17 +0000
Received: from PH7PR10MB6379.namprd10.prod.outlook.com
 ([fe80::de1f:84ac:fe86:2865]) by PH7PR10MB6379.namprd10.prod.outlook.com
 ([fe80::de1f:84ac:fe86:2865%6]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 18:33:17 +0000
Message-ID: <58042847-7545-4621-abda-02b225cfa3ec@oracle.com>
Date: Fri, 12 Apr 2024 11:32:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slub: limit number of slabs to scan in count_partial()
To: "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        junxiao.bi@oracle.com
References: <20240411164023.99368-1-jianfeng.w.wang@oracle.com>
 <e0222219-eb2d-5e1e-81e1-548eeb5f73e0@linux.com>
 <38ef26aa-169b-48ad-81ad-8378e7a38f25@suse.cz>
 <a8e208fb-7842-4bca-9d2d-3aae21da030c@oracle.com>
 <bb2cb21b-0a5e-0154-2a7d-7e630b50aa4a@linux.com>
Content-Language: en-US
From: Jianfeng Wang <jianfeng.w.wang@oracle.com>
In-Reply-To: <bb2cb21b-0a5e-0154-2a7d-7e630b50aa4a@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0190.namprd13.prod.outlook.com
 (2603:10b6:208:2be::15) To PH7PR10MB6379.namprd10.prod.outlook.com
 (2603:10b6:510:1a9::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB6379:EE_|BLAPR10MB5202:EE_
X-MS-Office365-Filtering-Correlation-Id: 270c9ae0-8257-4b9e-9689-08dc5b1f051d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4syhn3EYCCHF+7yX6fxNfM+X7XngIXPO3brmDG8+CEzD+oElaz+C77PN708z+eyTrzbwWKCpnNdY+gocC+t0ElazqW35sEA//FkseI5ZPzXTJ6i5ELTkzEtTTY/S6urrv/RFZvyXEhTDeTS4uQBCpqRD5RumWHhwY0uYbRFEuDTWxBhULMD2N5BXDjtM7QyZMcT1LXfTHi94w+Xwzah/2hbiHqfc/YPxb13ybUTMuQzhQrSSKfEUMEjvCNTFrgUo8RFstWazwpxlSh7Oy10hQCZA+dAjSXXrAKBoe+aSGo9A5b6Rz1T9ZhLPX7WBImSfZxv/FjJhv7yt4AyEdPcF/qfh6BdvmvXu2TYdcunX+on5PvmLHytTONisMrRFREugjgPcFnRo/U3fyxPTgb6xHJOBSCrQPNLa8qQ+slDOuelH2bi7bhgKmIOc+s5jVm8007S452sGuVHtACJwiuKY5h+6y+DWNr5tm5wiJro/VV5nMftS88DUcylyJL0IpG8N7rbS2Vk0je84mhpgdbRHtQAdn2ge5wYY726AAMWRks+bf7gDQJGU94BTipOn48640uVXRuHnH+G6f2lYb2SOeZOnYYqSBcqAwbav1bPPTCtDxaSmtEE8Mxj3eFvMndHZFqlJt3+zdWG/2R7xm3eH83OWh3kri+mwhtO97KsE11c=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB6379.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YXdabEluMWpTZnJEdzJRMkV0Tm9TTEFIU0dwdmVQdi96VkhZVkZqMlI3VkF5?=
 =?utf-8?B?c1N4WGEyRE82TENvVlBtbUxIUHY1ODFadlFqZnlaWmZvK1kvcURyZ2ZnU3dt?=
 =?utf-8?B?QkJiMVlDWmVOdFQ0VEtJYmEvZFcxY29EdVVCTnF0SzExYS9neWY1WHN3NDJG?=
 =?utf-8?B?cjdMZ0E1dFp5Vk1rQitOandFS2hTNmNYaTFvK3RtT00ycStuSmZuZGJuazRa?=
 =?utf-8?B?UHRRWC9DZWJMZEluMytuTWNlMjdLZXJkeXlWbGhrNWU2ZGEwWWdkTDZ1Z3Yz?=
 =?utf-8?B?cmExb2NSUUJweVJKM0x1M0FjMStWSFpMTjR2ZVFseWJoeXJqZ3BtcUJVR3cw?=
 =?utf-8?B?L28yTTZZYURHQmtzOUVqMnJ3bGNMRWxNMTlnVEFKaDkrNFdFOHpvYTNDbSti?=
 =?utf-8?B?by9aRmYrdzdlOG5xK1M5em03cDZHNXJLVk1xNHFEM3BWcFZyRkFXZkREYThQ?=
 =?utf-8?B?ZFEyVmwzbnZYM1k0cmpPUThqbU5rVGNYTkJ4YWgwdml1SFJQMllsa1lmV3ps?=
 =?utf-8?B?NWZmNXA4T3Mxd3YvMCtHKzRRa2lXWExML3pYMHZjSHQvZlJPZDR6WjVRMUk1?=
 =?utf-8?B?WHlyMDNKVEdNSmlkckJxeFlGK21aMElQVlhtdjRxWmZodWxhQVFNRzJWRjRO?=
 =?utf-8?B?ellsVTYwN0d4ZkRBRXd1R2NJS05rZWZlTkNmTkN2M3hyKzhsMU1Ia1o1UjdT?=
 =?utf-8?B?Q1lJanoxQmJNSnZtNHh0bnVNQnBUY3RnWlJjdWVOT01mS0hlQllXRjM1aFFN?=
 =?utf-8?B?ZnJXbXUyOS9SSWVKQzU0ZTd3cXRmT2RNb29LTXp0M3kzaDlDKzJEcUZmYUkr?=
 =?utf-8?B?Y2NBOTZGeStQMGovakVIc0V0eXM0M1Y0RG1McEg0OEEvSWRueWM0anlGT1Bh?=
 =?utf-8?B?Q3haOVFpNmtGcng0djdENjJvSnhva1BZNHpXbHZGMjY0NFBsV1dGbHF4RWZG?=
 =?utf-8?B?QldtNGIvMTNHVU5OTE1KSEE2dUtUaGUxN0tLbnp4U21seDQ4eEtvVnl4aW9m?=
 =?utf-8?B?emFGMmRTbEtIa1RNak1qcmNHNWhDeHJkY1hUQzB5UmllcXZIOEgydGluZFJl?=
 =?utf-8?B?eXhtWFBaRnBKS3dRMm1Rei91dC9XSjFvdnh0Z1l3L1R1UzhaMXFESnFRTzFM?=
 =?utf-8?B?cDBXa3k1cGJiNjZwSVZGdWh3L213aXdJSEc3bWw4Wnk3ZEdQQWpMRktUaWdF?=
 =?utf-8?B?VnZPb0ZEayswU3JvTVJsbTRmTUQ1b0R4U0p5dlVaQTROdkZGM2twYlhtM20x?=
 =?utf-8?B?N3JHRkRyeFJLeDF1MmZpSjVwa3dBY2JNWVVLL3dUTCsya1ZjY1FIVnhCaXV1?=
 =?utf-8?B?S3pFUzZwaUlDNCs1aXRIM1NzMDQ0cDc1bXNLK3NNeWhOVlZ1amdmM0pLQWt4?=
 =?utf-8?B?MG8yMitqQVZ6Z1NzbUgxMU00cnhLbGJ6Z0lPSHl1M0IyejJhTDFDbTFEZktB?=
 =?utf-8?B?TEVKYXNoaGdvajJETmlhWUk3VUxlYUY3R0lIMWZCZytXKy8wLzlVc2JHWkdo?=
 =?utf-8?B?OWpLNzhoQkVTWjFIdVFuSVE5R21ITVJmRTdFL0xPTFlSb255WEFzTGU5WmVZ?=
 =?utf-8?B?NUdNS3gwUUtGZDRZbG5xZUtwak8wUThxTGdnOGFDTVRQT0lzcUViWjFOYitD?=
 =?utf-8?B?SzBzeE11bnNLa1cxcUQvR3JMM2lVMlZ1SHVsU0E3ekszYjFvQU9YMlhhUjAw?=
 =?utf-8?B?dnFqcERkYWovQUY4TStvM3JscVlZUWtGSWJHYUlhdGxQQldiS0l3Z1MvRWVJ?=
 =?utf-8?B?UUpPWFhyTk5aRDBFcjBndkp2UExFMit4cFJOUlB4eHFBNVJoWnVNWk90MlRs?=
 =?utf-8?B?dXRDRTBxUXp2a1NaMmU0YmJqTkFlaFVHYTRhWE8yRVA5cTB2QnFmekVVbnQz?=
 =?utf-8?B?UjZFUUpOOENVM244RFROc0YyMFBhWVRvMkhhWWVEOXJIWWsveTRjV2srV0hB?=
 =?utf-8?B?ZFE4Q0h5ZlBpZW9PTUNKS29Zb09lbDdIL0w2S0VUNm5BUUJNc1dMU25xMDRv?=
 =?utf-8?B?b0FnbjlJTHcvZFhudWp1eGpOUURaNy9sSitDcy84M2l6RURldGV6S2ZTU0tw?=
 =?utf-8?B?b0k4ejlhaEpOS3JwSHJPQ3ZiU1NiRTRxa2V1SUJGMVR5bVREclVTRkw4bUwr?=
 =?utf-8?B?aTQ2TGtqZjNnZStqNndXcXZtZnNPbC9iNlQzV0Iwbk9KT24vdXZKTmo3cDBJ?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	V5XhYeYYSwIsyB0hEs5q8yHe9pVnkKqmOoozXNY0oT8YK9VUXfeMCNd/e6DMU9v4EkAiobrXSqU/yJjQ+io1a+RBBPxz5rnDLh+j4YNwXRHSrPLfkhwjMq8t5rJKRqzMVqN5AfPqTGAewSNnjSUUqOl5lHDdembZh6cTKK1RJlbgt3sfgkejv596Ee4+aQB06drMKlpQwyfQOrKn2++V81r/HSJdhh5U+80g9CfutI+9rF02IBkjuvxbII+k8+YTIwZczm7G00VDV+C7WnBZ/P96QSvbKCYEtzcj/gPXyADMpgJjGuh7pWM77QVXSgg1CqG8B2K5JggMGYFfGhyOx/8sGi8HkTiTPMX8F7Oz3R4SzuvL1RQ7p0tH2zDyhVXmdqWB6If9s5rYOWFUjc1a2IGhCkwXL7x7qua+Qvn+vhFU2xo2t5sGAojFVh+OOLdnbLzWRPS3fT9o6YGsp6Pmgmgdl94UlLOZPGFa0SCVN94l4Nqi2vH2t4FSFNZeVj5mRxryfsC8F9xipPWxGQ+d6ys9wdwzuALC6J/9mOJP1HsVC1lqsHEztckzpC1gu8W7ISnCVJOhVnFj7UcQE5NZEUwho2sZnlkxxkDGv5m2qqU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270c9ae0-8257-4b9e-9689-08dc5b1f051d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6379.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 18:33:16.9905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sf21k06/Af9vWQltQVhASchaM/fLESe1nhkMPNfK+Agf5cKxOnuX3ZBLJF3wfj3cpmbfnRJampk0FEQaEt39Me3aiYo1djQsZ1b+wEiov6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5202
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_14,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=904 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404120137
X-Proofpoint-ORIG-GUID: wF_X5pQgMPPHXSqxEatfWs9sJNOFJ83f
X-Proofpoint-GUID: wF_X5pQgMPPHXSqxEatfWs9sJNOFJ83f



On 4/12/24 11:16 AM, Christoph Lameter (Ampere) wrote:
> On Fri, 12 Apr 2024, Jianfeng Wang wrote:
> 
>>>> Can you run some tests showing the difference between the estimation and
>>>> the real count?
>>
>> Yes.
>> On a server with one NUMA node, I create a case that uses many dentry objects.
>> For "dentry", the length of partial slabs is slightly above 250000. Then, I
>> compare my approach of scanning N slabs from the list's head v.s. the original
>> approach of scanning the full list. I do it by getting both results using
>> the new and the original count_partial() and printing them in /proc/slabinfo.
>>
>> N = 10000
>> my_result = 4741651
>> org_result = 4744966
>> diff = (org_result - my_result) / org_result = 0.00069 = 0.069 %
>>
>> Increasing N further to 25000 will only slight improve the accuracy:
>> N = 15000 -> diff =  0.02 %
>> N = 20000 -> diff =  0.01 %
>> N = 25000 -> diff = -0.017 %
>>
>> Based on the measurement, I think the difference between the estimation and
>> the real count is very limited (i.e. less than 0.1% for N = 10000). The
>> benefit is significant: shorter execution time for get_slabinfo(); no more
>> soft lockups or crashes caused by count_partial().
> 
> Wow. That is good. Maybe decrease N to 1000 instead?
> 

Yes, the diff is still limited. Here are some numbers:
N = 5000 -> diff = 0.0019 = 0.19 %
N = 3000 -> diff = 0.0023 = 0.23 %
N = 1000 -> diff = 0.0040 = 0.40 %

So, the estimation is quite accurate.


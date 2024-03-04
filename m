Return-Path: <linux-kernel+bounces-90210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5763886FBFD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90031F22CA4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C56199B0;
	Mon,  4 Mar 2024 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j0TI01qa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dgvJQP8/"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078FFBE66;
	Mon,  4 Mar 2024 08:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541336; cv=fail; b=uxR+m5UTvmudm5t6Hy62A7afcn7RjkU77GB7+jQ1i0h5CAiNFXW5GpDf9PZbaFOKBYLybLWoZv+ArOWq6CJgStZ0Wq5nKihnlW6E6qSLJhB+aRgoieH7nfkNJ1wgFmw1W/Al0JfjQ93VaFdpTvsaNEwDxR51kBjty1z2YRu2ytA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541336; c=relaxed/simple;
	bh=H/cLoZkGXVqconavyZXgTasqBz0+tvi24dgngstMEvI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F+wHa3Y7WBurzZur5OxSFeG9TeW5jyphuuJyzJSvX5ij/+wwKomMWbNDArvG5Q33ZpOPNt7qyWie+m8O69FK5wdDyo/+d58md7tQoATjJcx4MRpOQnsO02NIg2YrBWLoY1acQN1kyaj99ahnMsuWon+ga4/6rsuWWrQKFaBoUxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j0TI01qa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dgvJQP8/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4247hqC3015163;
	Mon, 4 Mar 2024 08:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=WV7sk6zfFzlgSufWbx/EY9Q3MxbvFlSY+oCWFL0vxog=;
 b=j0TI01qau2moW8S1ti38MIDtO9EAg6oUJJU1IYEiF1AO7yO9JsYl1xlCN3qva+JahdZD
 ONm/vBRSCxFk6XxwGRnKWzm/DtrY7QOne9+BBnudh798Lb+g6qUz39ISRnnSDwx3llc8
 vEtMSkrAD3qyJdlWsZr3EjSwbwhF2W/3MQcCP2sDsc/+lctjdaV22tbOomX/RsJzg/VD
 2w/dODF6ljvDpYrKZ9pmBcYhJp7rrxXjruMsWzDy43WqgPt3Xcg3wKTQmLIc+YtYi1PU
 TXrxhOu7TxVgxDEJlGQGRpsv0zqOzEVAdyybCISndXmuNltxTRIUQU+YdFcSuZXbXsp5 TQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv5dasse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 08:34:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4246URNq017339;
	Mon, 4 Mar 2024 08:34:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj5q2x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 08:34:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SohoIqmkXSh7+FxspVBLgx6YUEI13WfhFZ118tMM7yqWSdu5q+VKWmQBjlhLqwRN4dxOUd0Vp1BQi/kEIY/K41Qxa2LcOpHn6C1fv6VN/dsFX4eceTwE7XD7wDZ5PmJlc2Qs8kh9AHXm3KIFs3hpz6o0xXZWc7U6MBmE1MRonRi8hBjsomLfxbLEzSz+S7MaCY1Hna2kzeeKfgbcAt4qpbxCVRQjiJB/P8DL9fGlsd+XKGxZ7bzXM2m5cwae0qvZkOOazZUzcvf4MuQKwoPmzFI/cVkw/taLjJ8mQcXon+oqgok8C+hZCBpmw3ZH3LU7pClFjjKg8ecFzm3XEEY/aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WV7sk6zfFzlgSufWbx/EY9Q3MxbvFlSY+oCWFL0vxog=;
 b=SfnVqj9sAkJj2X1twgfOA3jeP6xur+gzGGp14U4UyYhMS6Q24/H2IFLIzTP4Vjo4bcgmUTZoUUCzq5YYiYyHn8uSmkEZA+mGGteAaZqEh+3UmJsNey9zrq62QW4geNltLtmDAZY4EOPXBibTWHiM3XT/+JPJrxgEYSTJE9HtKgtWF4qS9JolKgYh2ypngbhPAWMMV//qH0JoWsi5YjjzVY3ay+pTNN5mEg9YDMvdjnb0n4I0enaO2gOPj4YMG4558OISF2sNN9bKlj+u9LVEHA+jZ8uYcY6XpIvmvy/c6DLgx9iUiBuPEFrv5SVz18WEjb8+HRAaAGj58VkvXKSxiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WV7sk6zfFzlgSufWbx/EY9Q3MxbvFlSY+oCWFL0vxog=;
 b=dgvJQP8/kZclRGv6KzkiSzwrRniRkMcOjMC1lC3sb3SrpjxtWLuMbU2c6SWW0fve4iPCoqa5UlbhjlBOJNKkpTY5vpMXw7MeTGe+iZI8g0viRFRfwp+gXavP1hwC1Nc1xwxwi7uL4kxNdmioQmmg3o1HhwnqgBpYLA7d8l3W/Go=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY5PR10MB6166.namprd10.prod.outlook.com (2603:10b6:930:32::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 08:34:56 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 08:34:56 +0000
Message-ID: <5c20140a-79e8-4d0a-899a-d4ec5c9def42@oracle.com>
Date: Mon, 4 Mar 2024 08:34:52 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] ata: libata-sata: Factor out NCQ Priority
 configuration helpers
Content-Language: en-US
To: Igor Pylypiv <ipylypiv@google.com>, Damien Le Moal <dlemoal@kernel.org>,
        Niklas Cassel <cassel@kernel.org>, Jason Yan <yanaijie@huawei.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc: TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240302201636.1228331-1-ipylypiv@google.com>
 <20240302201636.1228331-2-ipylypiv@google.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240302201636.1228331-2-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0012.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY5PR10MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: c6cedaa7-327e-4295-acd0-08dc3c25f8d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Oc8ley2vIZqdmO9yApDf9+WlSdiZUCOEXeFJS5YAL8CxieI3TLMuKcXctIpYQzrB4Jr/HskjBzPr9bKbPjVBaWuGYdcGVEaB/rTcTvylYVvuo18VianMT5I2KSK2cxvYDV1Kbve7qloTuxXSbSqL7XFWr9dGWy8Rw8sQDxJJ1keeE6VAaE18Ub42dyteK+EJ9YWUsLoW+YIeFq+3QHIymBkQql9LY5AsXgiuBgIHLft/SGdCf+Ho5QNDzfJL5lluW1ZScrA2Acltxzi+BRGc6mrw7DyndHW8zQ2z5c+RK6794Q7IS8Pz0RfBhl1b62FP4oYzhSg/fICY8mwZmQ8AS2YmwX7DssFkEeayUDuKp4m+Eic396Ua+irqWuM38iYB7LeNUvuLvGP3Uu08wkj1k+o5lUxIsexO1c4BAUMk2UFOXBtVI9UFVJ/yZTyHpb165nxwea3Mug1oggz49oaLd1ghwToJVL5aW21UDY9eiWXhNY9Dom0ZYiWi/OuGvP5WXvHy4HhIivSevoW4WlcUo9z1efcP7N3dLSLJVpdfC3Fb+c7EgKAx8xIiMtDfdn7KtlMw5IZHWNSSaGfd/1PLnavygDTJIY6k1oCjI+aLUXx75p2PiAO3aLQ6R3F8vKRTrpkBGr6DHCU8vJxbz4gBciRsUQ+PepfNq3ELxhtD1JxfYuVYFO8sBK9k3EifwZCat1vcek6cfKxihqexdG92fA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OGwyMUhPQ3dwVWl5RzMrM0xIQXBSY2ZTR1U1YnlSdndkSis5R295Wmk4dDZi?=
 =?utf-8?B?N2pXOEtxOUhDY2p0V0JjeUtUaG1QMmh4b21YT2JOTmpiY24wNG9CZjY5MlMr?=
 =?utf-8?B?UGV0a25QV0RNMTYxUy9LTkZMWFN0blFqT3FRTVJPb0tRL1kyUTdMQWgrT1gv?=
 =?utf-8?B?THB3YVZ4YmdIcmEzOTFBUXBFeTAxQjVJbUllTlhuN25JaEZXeDBLYjRWS21t?=
 =?utf-8?B?Z05aeEtNZ0VyVGhlUTN1dGJPS3BVQmlSVHZSZFByTmdwcEJzUlhXYllyU2RQ?=
 =?utf-8?B?RHhEbktGM3NVVHRPSzlTNXNpZHdSTmxZbU1LYVZwZlRyZksyY1VtUDZzRzZ3?=
 =?utf-8?B?Mk9uWTJQaXNCSHl4V0p5ZWZzMWNVTlpwbXVEeXhNMTFXc1B5bmZOcVE1azJm?=
 =?utf-8?B?cVJiUVNPY3B3OFJ0RHd3R0s5WTVzMGpnVDgwV2s4c3Y2Z0hKUE01QjdVQ3Js?=
 =?utf-8?B?dGdCNGpiYWZtTDlHbmsxR20yeDFTU3lPTlIzNWt1WUhjUXcwSWExQUhNZWFn?=
 =?utf-8?B?Z0prNldWNW5TNTdGOGFLc3YxcVZiSDNILzZDSVAxM0R5WEtSSzRrOVFsZGlu?=
 =?utf-8?B?MFB0MmI1cURsc1RnbW9vUU1NNlJuTHJNYlUrNzhkMGpHOEFlT1dheFRkZEpt?=
 =?utf-8?B?UWlkOWVxdkVIS3pOQ2tsb3lISmY5cnZSWXFJbW8vN0IwakpUd3RQUG9NQkZF?=
 =?utf-8?B?MUhZUjVSWlZjSnVGNVNIOWlvM21aRW5qc0pNMkowcWsycjNEcndVV051Ynhv?=
 =?utf-8?B?dXNWNE9DVDgwZ1BoL0pGSThJTGVHVHpQYnVlWTFhM1Q1bkJ0S21mMTUzT2Vm?=
 =?utf-8?B?Yk5Nc0RJQjhXUTlHZHlDWUxZYnZhNUtWdFZJRjZFcEpSZjh5SzIwQXNlNnYz?=
 =?utf-8?B?WnRyRDQwdzZwZ0ZobTRMNER1Tmx1cHoyQjlQVWhvNUZRUHdvVnIvM1NGY1RU?=
 =?utf-8?B?RTJxY1VaYkxVS00vcEU0R2wvWWpTWjVSbExGUEFvTTFRYmp1clg3Q0tNM25m?=
 =?utf-8?B?TzJNKzNXRmMrRHowTGJGMi9kMis5VFowM3M3dk1kNFBaTmZoN3V2VTliMFc4?=
 =?utf-8?B?YzBTSHVaT2YwZGNrMmFjQVVYbnZKSEJyZWV4N0c2eUFoRGozaTIxb3puZzd3?=
 =?utf-8?B?Q0w3em92eWFkMUFtME5qS0RnY2xuOHBoVXgwOVorWExObWJYc2hmYWpTdUgy?=
 =?utf-8?B?S0M4NktuRXhPSllaYTY0anBCZVlTZDlYM241c1Vsbnk0RjBjTXZKU2x1TGxP?=
 =?utf-8?B?UWtrbVRjYTVGV0NZblFoZFZ2bjJHU2N0VTNlcXVmVDAvNk9xb0FEZmNOWE1o?=
 =?utf-8?B?TXhCRkZVT2JCQVJLZHVybEZRN3ltVjRvZ3h0SklpOFBjSHRzOW1kWnh1RC9I?=
 =?utf-8?B?ZmM5cUtvaXVUTmM3NHAzejhOdkM2Tk1FeDdFSjV2S2VXVk9xYzljR3pFQi9J?=
 =?utf-8?B?ZGpsMGhxc1RsSyszSFk4NWFPdkxWUWhDTkQ4enoxOHR6Zng4T0dZcFYzYkMx?=
 =?utf-8?B?YkE1bmRGbVFka1k5WWtzanV4UzdlNGZjWEQ0dmt4cG9oNWlaZ0RiclBqNm1N?=
 =?utf-8?B?Lytja05qV01Ud1JkOXZXdTE1VGcvRHJBRlpiTUp5bU1CcWJGZ01KcmdGQXpO?=
 =?utf-8?B?b3JuejRjRndWMTd4UzlFNzZELytXbkpFZUkyUUQ2aEpFSy9CdFVLYVdjMjE0?=
 =?utf-8?B?MThYbTQyTk96MEw3QVBMMldOeG43RVZpSkVIQzQ4c3JXNDg2NTYzRHMvZUU4?=
 =?utf-8?B?STdpNFNvbXFlZUlLZFc4ZWVBck1VSStrZHUrUXlYQTVzZzIxYzI2cXBiMXlr?=
 =?utf-8?B?a1FVcURRVXF6d3RBaUdVUHBXWFFzNERpcDhsWjZNQitJbXExcHRobG5WZ0Nl?=
 =?utf-8?B?cWQrSVNlaFBUN0tLeUVNZnptVlRRQ3NndGNvQXRIZDZxaEpYSE54UXE2bFZP?=
 =?utf-8?B?N2pjWFRoYnppbFYwUjMydWJ4QkcxUkgvVGF3a09aeFQyc2NldExLYzdzNkxn?=
 =?utf-8?B?WFdDNzlrYStqZ1h1eGMzdHVRQVJxOEtzaFN3dHluZHR2QWU5MFB2UHZxZlp1?=
 =?utf-8?B?OE9ETENQbm04RmZyTXBtTWV1L251YWhDc0hRNVdoZmhBQ3ZmNlhTdnVjUWJw?=
 =?utf-8?B?dVh2am9HQVR3cGFXN3hUL2pLMFVJZW1FOHNDdnlXMkhUU044YjhIanRxS2dH?=
 =?utf-8?B?NFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	P1FsmgqssR/hRq1/FSkk2PPQCCxA+BJhjsBUHg9DBV5QKdR+XlYsRt40uRLG4KBvIWFXcWK7WG7U33ianGtTTdgixkEpEVSBIz/QAKn0yyaTxsYIyoQ1XsXxh3W6Xn7zZnLmLQ9fcsiXADPu02RA63JBzi1HBQbje8k9DNPspV8ZoXKOyC/lTuzaDruXXwO3tWDkpEw1WycDVfRw/t1UMWTYrCavFh6F8zlTxTfRHmg4KJluR/KhDo2CnLlenKf13UmOUywNKuwFA9LTE6QGJ51NLaAB6ffdEE/KP5IXEcse2kThmOCDp10H/PiJVokjtnF7pgjy1oyC1RzMWxrrrkx2B5Z2a9EDSwmiYu+1dvuZ+gE2PbtvYtTlQCl0m08TUjUmCLrXsXU5Ir+lzmuufkmkahmEuBHAM71JJ7LKpm2XJN7sRjZvEXd/qaSuGwjxIqWseVLztffrWAIdobeGSSjppptaCYX3QXeak4CDmnIPRukdx66hZdhMVASexezImssFVCzVi9TXulzUdqqOzLowCNWF53CVZqkrA6AdBVFFIUAsG+TXh/ABd6ea99WiWuDmzveCCQNjUCdsKMk+bou2wmnvHv5TBTMcJkEX47o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6cedaa7-327e-4295-acd0-08dc3c25f8d8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 08:34:56.8098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tPl12xDEY1AMCXAlxbEVg5DRAia4hxWipnK+XAfVMfN0MiMrjzQ6OGeZr5+jgpIesH4SCKo0Yv/N2WmTKW1ALQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6166
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_04,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040064
X-Proofpoint-GUID: Sp1Fquwo1puRL-fVq2CkOurr8VmHeQUK
X-Proofpoint-ORIG-GUID: Sp1Fquwo1puRL-fVq2CkOurr8VmHeQUK

On 02/03/2024 20:16, Igor Pylypiv wrote:
> Export libata NCQ Priority configuration helpers to be reused
> for libsas managed SATA devices.
> 
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>

This looks ok. Some small code comments below, though.

> ---
>   drivers/ata/libata-sata.c | 139 +++++++++++++++++++++++++++-----------
>   include/linux/libata.h    |   4 ++
>   2 files changed, 103 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index 0fb1934875f2..a8d5e36d5211 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -848,29 +848,73 @@ DEVICE_ATTR(link_power_management_policy, S_IRUGO | S_IWUSR,
>   	    ata_scsi_lpm_show, ata_scsi_lpm_store);
>   EXPORT_SYMBOL_GPL(dev_attr_link_power_management_policy);
>   
> +/**
> + *	ata_ncq_prio_supported - Check if device supports NCQ Priority
> + *	@ap: ATA port of the target device
> + *	@sdev: SCSI device
> + *
> + *	Helper to check if device supports NCQ Priority feature,
> + *	usable with both libsas and libata.
> + */
> +int ata_ncq_prio_supported(struct ata_port *ap, struct scsi_device *sdev)
> +{
> +	struct ata_device *dev;
> +	unsigned long flags;
> +	int rc;
> +
> +	spin_lock_irqsave(ap->lock, flags);
> +	dev = ata_scsi_find_dev(ap, sdev);
> +	if (!dev)
> +		rc = -ENODEV;
> +	else
> +		rc = !!(dev->flags & ATA_DFLAG_NCQ_PRIO);
> +	spin_unlock_irqrestore(ap->lock, flags);
> +	return rc;
> +}

I'm not the biggest fan of functions which effectively return both a 
boolean and an error code.

I like this patten more:

int ata_ncq_prio_supported(struct ata_port *ap, struct scsi_device 
*sdev, bool *supported)
{
	...
	if (rc)
		return rc;
	*supported = true/false.
	return 0;
}

No big deal, though.

> +EXPORT_SYMBOL_GPL(ata_ncq_prio_supported);
> +
>   static ssize_t ata_ncq_prio_supported_show(struct device *device,
>   					   struct device_attribute *attr,
>   					   char *buf)
>   {
>   	struct scsi_device *sdev = to_scsi_device(device);
>   	struct ata_port *ap = ata_shost_to_port(sdev->host);
> +	int rc;
> +
> +	rc = ata_ncq_prio_supported(ap, sdev);
> +	if (rc < 0)
> +		return rc;
> +
> +	return sysfs_emit(buf, "%d\n", rc);
> +}
> +
> +DEVICE_ATTR(ncq_prio_supported, S_IRUGO, ata_ncq_prio_supported_show, NULL);
> +EXPORT_SYMBOL_GPL(dev_attr_ncq_prio_supported);
> +
> +/**
> + *	ata_ncq_prio_enabled - Check if NCQ Priority is enabled
> + *	@ap: ATA port of the target device
> + *	@sdev: SCSI device
> + *
> + *	Helper to check if NCQ Priority feature is enabled,
> + *	usable with both libsas and libata.

It's usable by anything which uses libata, really. For the moment that 
is libsas and libata.

> + */
> +int ata_ncq_prio_enabled(struct ata_port *ap, struct scsi_device *sdev)
> +{
>   	struct ata_device *dev;
> -	bool ncq_prio_supported;
> -	int rc = 0;
> +	unsigned long flags;
> +	int rc;
>   
> -	spin_lock_irq(ap->lock);
> +	spin_lock_irqsave(ap->lock, flags);
>   	dev = ata_scsi_find_dev(ap, sdev);
>   	if (!dev)
>   		rc = -ENODEV;
>   	else
> -		ncq_prio_supported = dev->flags & ATA_DFLAG_NCQ_PRIO;
> -	spin_unlock_irq(ap->lock);
> -
> -	return rc ? rc : sysfs_emit(buf, "%u\n", ncq_prio_supported);
> +		rc = !!(dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED);
> +	spin_unlock_irqrestore(ap->lock, flags);
> +	return rc;
>   }
> -
> -DEVICE_ATTR(ncq_prio_supported, S_IRUGO, ata_ncq_prio_supported_show, NULL);
> -EXPORT_SYMBOL_GPL(dev_attr_ncq_prio_supported);
> +EXPORT_SYMBOL_GPL(ata_ncq_prio_enabled);
>   
>   static ssize_t ata_ncq_prio_enable_show(struct device *device,
>   					struct device_attribute *attr,
> @@ -878,50 +922,45 @@ static ssize_t ata_ncq_prio_enable_show(struct device *device,
>   {
>   	struct scsi_device *sdev = to_scsi_device(device);
>   	struct ata_port *ap = ata_shost_to_port(sdev->host);
> -	struct ata_device *dev;
> -	bool ncq_prio_enable;
> -	int rc = 0;
> +	int rc;
>   
> -	spin_lock_irq(ap->lock);
> -	dev = ata_scsi_find_dev(ap, sdev);
> -	if (!dev)
> -		rc = -ENODEV;
> -	else
> -		ncq_prio_enable = dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED;
> -	spin_unlock_irq(ap->lock);
> +	rc = ata_ncq_prio_enabled(ap, sdev);
> +	if (rc < 0)
> +		return rc;
>   
> -	return rc ? rc : sysfs_emit(buf, "%u\n", ncq_prio_enable);
> +	return sysfs_emit(buf, "%d\n", rc);
>   }
>   
> -static ssize_t ata_ncq_prio_enable_store(struct device *device,
> -					 struct device_attribute *attr,
> -					 const char *buf, size_t len)
> +/**
> + *	ata_ncq_prio_enable - Enable/disable NCQ Priority
> + *	@ap: ATA port of the target device
> + *	@sdev: SCSI device
> + *	@enable: true - enable NCQ Priority, false - disable NCQ Priority
> + *
> + *	Helper to enable/disable NCQ Priority feature, usable with both
> + *	libsas and libata.
> + */
> +int ata_ncq_prio_enable(struct ata_port *ap, struct scsi_device *sdev,
> +			bool enable)
>   {
> -	struct scsi_device *sdev = to_scsi_device(device);
> -	struct ata_port *ap;
>   	struct ata_device *dev;
> -	long int input;
> +	unsigned long flags;
>   	int rc = 0;
>   
> -	rc = kstrtol(buf, 10, &input);
> -	if (rc)
> -		return rc;
> -	if ((input < 0) || (input > 1))
> -		return -EINVAL;
> +	spin_lock_irqsave(ap->lock, flags);
>   
> -	ap = ata_shost_to_port(sdev->host);
>   	dev = ata_scsi_find_dev(ap, sdev);
> -	if (unlikely(!dev))
> -		return  -ENODEV;
> -
> -	spin_lock_irq(ap->lock);
> +	if (unlikely(!dev)) {

no need for unlikely() - this is not fathpath

> +		rc = -ENODEV;
> +		goto unlock;
> +	}
>   
>   	if (!(dev->flags & ATA_DFLAG_NCQ_PRIO)) {
>   		rc = -EINVAL;
>   		goto unlock;



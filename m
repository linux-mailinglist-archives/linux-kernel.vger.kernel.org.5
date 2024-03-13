Return-Path: <linux-kernel+bounces-102423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D802E87B1D4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D02C28AED6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C84760DD5;
	Wed, 13 Mar 2024 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yn2ln+eS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cv9ogGGS"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15055B666;
	Wed, 13 Mar 2024 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710358030; cv=fail; b=LlUvqU9nL2P5OB8JV9UjUNsB95VnGz5T/DBGjN51uLukx7QFaIV39gMNgrZw0AQRSOwxCdOO9PpNlyM+Aa26xZTpK0687Rx16nS8MR5V3SbY/YsMuz30EZvMqKvo8XSP4VDr60xbHcFqUywIh4WYhiWJ/2GycVHBnfa1pRat7Yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710358030; c=relaxed/simple;
	bh=Sm7KgSeQuSMdyXSrzDWIQ4SXf1mlp2fXSsoqyhmqflY=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OyrteU2+lNBWrrHHEzYHJSTAhLLjJkriXa0XxKWOV3PyQGZ3oR0UtvNBMl9Uk4a9XnW4g480aoLp+DDed4d9FXqNlL4QSOLUjIcHm8ncQ1YRyJZUX7ReRz3qptUjstugzLI2uYMAX+Wtfw0P907mAf5Zq5dtbLZ9Zpt9GTnJ5Zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Yn2ln+eS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cv9ogGGS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42DJOiC2024920;
	Wed, 13 Mar 2024 19:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=/Vre29FksxZ8LxALgipMJ1OzmouHZ6ndINiiXqBVLzw=;
 b=Yn2ln+eS6sXanZfsWkFYEzgFF5K7m22sBEWTcz4oKq9Y1dLS9VtzN/RV3GnOMuZlgYr5
 a2LTwZjWdhDFw+3RXkp1nh6YVXA5IOvks6Exigk/diMMG9nPC8VW13bTlCXPssgBjmsO
 DHVDAR7NcUjNKvB3xevr+gbIIPNrM47siwhY+AdurLe1mudM6H5ogQ/xs1OxYjGynhbr
 bknaBSot7vLIukXDtBBafTAJHsKCTyojQqw1UwhTxEkLNBD7NetTYg1Qx7DeSwnJ1H5W
 Fq96CiqDc8aMlEngqYcDMDNWRz9vO4pbQGnvkysbimPMx3Wb+NoUjJ/OLyHLOQ4lp7m2 2A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrgausmf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 19:26:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42DJDkjF037806;
	Wed, 13 Mar 2024 19:26:24 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre79ar77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 19:26:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoIQpWQUuzq2PsehsbZYxXrq8DIAbWmMUUrWQD9tV4CN4Al2airAM/bi+czD5oBGBOUGdrSvuob3xPcNA7ALuK5xuN0DcOMjP1PyH8cE1dBtz9vmXF1+06PIgsZTbb1XXI5EF97uqO+vHZn2+o9knwIak7cuS1r29NWZg1M04a4dGP3ZQzgnpU8i+A7xTSHjCS+w1+XBEf59DgCmldDJx48s1Ca9yNSLGqWDvk5wZo0FsFKwsh9tYgq9dUdPGiNhcrAOjG2cddDXgsvvp9dtKmCtY9KGn8g71VHOgCjkE9HXeNFDMCVHIxIGpuBylMLQG+e/KObL711fmZxCSXncAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Vre29FksxZ8LxALgipMJ1OzmouHZ6ndINiiXqBVLzw=;
 b=aQB/C9ybIywssQOiLURIYbpsiv+QN20QEX/CsKBBI5kktzZizrO2ZHR0oeXnUYnE62J6tH+nah60f8g/ZEefNwDR1V3hm7ehyXwA0zVXw/j7u2tjUmIDL6SIH05PPRNN9wbiDHAqdLh20AiGvNzGeK2AzypzkZxPi5NBb2Et0nTocKtaLPRL9ay3rwnK8kaM/WIrSNTskeAEqSCw89mN2scrOE7uLJ0LXI4SgiFZ5dx4KMGLEF8Q2v4tWlRTq1761TKeFfLLfFVGv8ZjISxs/2J6G4GgGHizxJbGkj0sHdhzelM7iTeMCDcYDg8risdlYurRgP29vKbDQyT8deF3VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Vre29FksxZ8LxALgipMJ1OzmouHZ6ndINiiXqBVLzw=;
 b=cv9ogGGSJ6JzNiifYXM5xhcU/qasfwiSLP4WCBrqTKM5t+8GtQpyBsnXOXY4GsgNSjya34EjJxfAhKA65M/br7bjXalItEj9K2B7ZeOFKv+kUMTKq1IotTtrWNeuCbStfXrfuB9NgYsXl1aRLf5bgF3qGuLW/diEp+k9J3p7c8U=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by CH0PR10MB7533.namprd10.prod.outlook.com (2603:10b6:610:183::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 19:26:21 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::88ef:4ee:6255:5391]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::88ef:4ee:6255:5391%5]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 19:26:21 +0000
Message-ID: <6dd91a4d-0a1b-1ef7-4db5-4ee5098223aa@oracle.com>
Date: Wed, 13 Mar 2024 15:26:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] admin-guide/hw-vuln: Correct prctl() argument
 description
Content-Language: en-US
From: Chris Hyser <chris.hyser@oracle.com>
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc: Suleiman Souhlal <suleiman@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Steven Rostedt
 <rostedt@goodmis.org>,
        David Vernet <void@manifault.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        joseph.salisbury@canonical.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>,
        linux-doc@vger.kernel.org
References: <20240313012451.1693807-1-joel@joelfernandes.org>
 <20240313012451.1693807-10-joel@joelfernandes.org>
 <d190daec-a7e8-4a88-9b96-e3610e9fc3b2@oracle.com>
In-Reply-To: <d190daec-a7e8-4a88-9b96-e3610e9fc3b2@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR18CA0001.namprd18.prod.outlook.com
 (2603:10b6:208:23c::6) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|CH0PR10MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a70eef9-d135-48c1-31e8-08dc4393769f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qqYONBHf+GvnrpjlFKtYXDWLA6n5K72voDZY3jmjlVBP6Tkfn5VTeCM+P9KSDn6+M5lLe33Lt069qZGxWERLF8MwyMZzcZWKPqmq/qeZgQeH5JDJfoMl767eSoAwi0mXuR0pdHYxbrGEQ3t/6+15ec9YeAuyzrc8zjoKNSuMVmllqOs6Ams4sNX9smp359rXEzCWRwyWKptp7w1Nsv2D4E3xeYz4lLHEYeb0QrfBx6y1yikBbTGq+mi0pZIUIshb9iBRQ3PppfJriyrSf2pSGpy0oQas/nf+zpviWkcJ7X8buwCyjEMYQyEeYVdL1a3UzCkAp7S2oxlHyQkxLskfna1AHxk4rsXAn1Kmv1L05OplIUiSg2f3wgWhDQ6HP1W/yZJ7G2/D4ktMCGD0xgwQfK9cu+HH6y7KQc6bQPkb2lP4G7OQLWJteY6DT00PxfHdRiRcyS8xCxsgGqSADOgV5B7ACku06ZKFL5BWVitKx3+/pSWuH+8lRa2XXZR5LKBxMzWeXRv5krV7GAzrx1dHdYBYVSZfVvBRtyUanUrlg2CxPBjuSp8rl7w0V410dTpgHdXdnccrlTRiP4JlkBvPPbSjMZiJDlWBLMAIxv9fG7pil4Kk2u4bbLkijFTv7MOeK6PjOoW0YsaVZmyhcrR9bzxHlqkMN7AGhuNDtMDSSiQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZkpMYTNwVm1nOWR2aU1lL0V4cDl0NThUaDVxTm9LT09ITjhUbHdDY0RJWDdp?=
 =?utf-8?B?OWZlb2xkOFptNWlWTlNyUm90b2ltVFpEVncvZkNtRXUxZVkwUHZFbXNoeUl4?=
 =?utf-8?B?WjJmQndON0t1WmtKOHNuK3dQWHF0R0FnVTdlTkpFT1dsZFZVN1MxMEZGMUFD?=
 =?utf-8?B?dmhIR1pDcUJieGt5ZzZVM0MrTEZNeFJ5d3FhSEdnWXJ0blFlZGZVWGhpRXhY?=
 =?utf-8?B?MWxLb3VxMFBjOEc0QnMrR3pWcXRqTUR0RGxSV05CU1dQcVRHZjJyQmFFc2I1?=
 =?utf-8?B?WmZTWXNRY1Arbk41Z01sSUVnWDV1ZHRualpHaHJablBuK3RHOTdiRDlnbVdX?=
 =?utf-8?B?K2FDMnRyZVB6bEdGaTRmdEgyZS9YenI1VDA3N1ordVROWUI0Tk82RHNVbkZl?=
 =?utf-8?B?K3l5YStOa0pHR2kvcm1JTDRqL3VkQVhIeldpNi83cEMreGp1N0ZmTDdIVXk2?=
 =?utf-8?B?V0p2Sm9qcGRSenV0cndCUDRDSDF0STRhTWZ2SzFXMmpqUmJtQmNWSUQycXV0?=
 =?utf-8?B?TnE2SzZWMDVTM3Z4OWYwN0IxM3pNelJLVnVzNmI4cEFlU3lTK2g5M0ZhTmNi?=
 =?utf-8?B?QkdOeWM1dFN2WEdzQ2J4MG8xYzRIRXZzczJzQkJmY2p5T1I4enJpV3lwSk5J?=
 =?utf-8?B?STQyZlJPd0ZXUFArU0xxUVZ6cng4cWVXc3lVN1gyUWdGckR6dVdPWGFDdVYv?=
 =?utf-8?B?YnNMWkxTZmQrb2xGdnUyNDBicEpUK1lSY1NwcmMzbytZVUxyTFVqUG9vV2dl?=
 =?utf-8?B?a0xtRTE4T05PUDZtWmZ6K0duTXlwT0s0UUpTdTZ4dEh4KzVPUVJ5akwxS1NI?=
 =?utf-8?B?N2cwMjBxakI5NmZpcVRTVHUxcmhFYnpRVm13Qm9EOVdLYytTQ3lOZUdjWVkv?=
 =?utf-8?B?Uk1iZFdFbXVKLy9ydXhPcll5Y2QwVkd3MmpiUGZlaitiWVoyUlFZOXlPZXZT?=
 =?utf-8?B?OVg4Yjh3NGNxaTBMR1ZpQk9KbUYwQjZ2VWlyQkFjWFZHQ1VhN255QUNTcjlR?=
 =?utf-8?B?UFcvakg5WjJYOEVuUGthNVFVUmJNcW1JSGtnYm5FQmxkZDM3b2xUWW1uRytn?=
 =?utf-8?B?RFErOUhCYU9yRnE0QkpxYytRRHlkcU44d052eHNYbHNBU2NGMXpJdWlSZXFS?=
 =?utf-8?B?ZmFtOHVTTXRLaVlQdjhXUlZHa0dCZ0FlQ2graldDWXN3NXhwaU56eDBCTjJs?=
 =?utf-8?B?bWIzNkJYaUdEc3c5TGZUNnpCZzVxS1l0eTM5VG93dDVQQ09vVkZpYk5XVk1F?=
 =?utf-8?B?cS81YkFvb3M2VkkxVURrcUZQOTc1STMzcDJNVWFLU2Q4RzJGczJqRUhQVDJQ?=
 =?utf-8?B?ZTBDOFduaTVWT281WTBXZW1aMmVET3pCblVTSitqSTZ1K0ZGai93L1VKMDcr?=
 =?utf-8?B?djUwdkNsYnFVYit1SUoveUE3SWI5N2VwUmY0QnRGR3pjKys4QzNpUGEzcVNl?=
 =?utf-8?B?dU04dFM2cWU4Vk9UM2tyaktVSStBR3lUK3c0ZUV1dnVVV3dVcktGSUc3TXhh?=
 =?utf-8?B?cnlOMjdoNXQrMEN6b0ROSDNmcS8zVkZTNnF0L1dOVTlJQktUQS8weXErbU1H?=
 =?utf-8?B?TGlzWkFEYitmcVhPQ3g2TWh2MlJsVXRXTnM4VWNvOGZzVHF5OVBKRjZmZ0Q2?=
 =?utf-8?B?akl4SXZkcjBOOWxIN0hhM0RadmYzZ3czVEUzbzhyTWZ4UmM0OVNUQWZ2MWp1?=
 =?utf-8?B?enN4M3l1QWJGdnNtT0ViNTZ3TlpUMUY2ZFBqTjh2aXZEVFJyUmZSczh0VHBk?=
 =?utf-8?B?NXAyV1EySzNNVGxodTBycnIrNGpSSlVLZjEraFEvQ2EvYkIvdE1FTnBsRlVx?=
 =?utf-8?B?MEN1N2dGZmlLandVZVh2dFA1a3E2cExtb01jNHpKOVd1N1VMbFV3aS9GcmY4?=
 =?utf-8?B?dnlOU1BpbVlBRkNscnN0WUx0TUFFUlRqeTI3a1gzZjRIdEVCUG1seXAvYzd4?=
 =?utf-8?B?emMvdVpPN29PN0xCYUJLRnluenA2VFlraUNRQ0duU0o4MzlFb1VvS01XbUpT?=
 =?utf-8?B?U1dBT0QyMUNyNGVDd0pndlQyUTNvQ2FLVEhyWVQvNDYvM2VPb1p0d2xnd0Mw?=
 =?utf-8?B?NUg5RlNlTFNURzZXd2pVd3pMa0xQWVVQZnZPMU5BTWpESFQ0emxzdnMzTUJ6?=
 =?utf-8?B?emNQc3lFeDFTUERjNlM1LzhtaEF2eTRDZHVUNFBNVlB4WDBuc1dGWk1GSzdD?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LhFaILP8KyuOxtRENIXwTDsGLgDlOIrjuHQwRD3uoiXmMtqSaZbhmSbw37HpzsEmQsyei0MutBT5zByfQpNgXZJd5ZsLKd4la8pGZpa3Cia8LQ4bLX4Vjr4ISPJGfeW32JTFHvx9QpSdf0GnCGASfyTLsbii7dAxAd2iJimdjTtBVnWEGSmGlaoBavFzrOEsmze+w384vsrXlGZxv3iEd/5DZCIycMgMKsg5bPF7OLT5/4Aa8/Q4pBO6uftHRPfkmTtYzfb+otRfRgfbmGck0m7Cx+Khy1atEGxqr1pvXzvXQEQh2ANVBpISvgoIFcb6XnmcpUAWf23OdwWlBwpuM6AxPFfN+xSDulYKY8Uudo4zkuyqsJtqXLXxBJuZR4ZUhMZUUtD81jTDpc0ka07LD9+PTUIvwpbzloFRb2q9l8tnu4kB6ynxxtpbYlxUaKgIhXJnFEUUJivyXmvGtkbGyulT+j6XtRMLTbJAXApVSSEToDkc78sagnIrW5s/HyGTlzGJ+8WEIW8ltDSjzMEZ4mK+GWm37L3E/0JODGldnV1NVYcAZd+fK6jsyZhm/jfN51ULVkeuUX6SyVJgX3f216CUnQIaTYEGd+jMULsBH/U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a70eef9-d135-48c1-31e8-08dc4393769f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 19:26:21.0182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9N3PBZkXNuiTOxWLYXJ88mBwI39VC0/hp0wyKnM5sfchxRrav1hbRSuEKdQmUVVcWAy9pAopjHNO03KMtepeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7533
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403130149
X-Proofpoint-GUID: Gmwdk9e4TVyDe8--eqxm9AKjogtn5Qot
X-Proofpoint-ORIG-GUID: Gmwdk9e4TVyDe8--eqxm9AKjogtn5Qot

Sorry. This is a resend that should have better formatting.


On 3/13/24 15:14, Chris Hyser wrote:
>
> On 3/12/24 21:24, Joel Fernandes (Google) wrote:
>> Correct the description for arg4 which appears to be outdated.
>
> Technically, the constants referenced in the documentation are still 
> defined in prctl.h, and there are BUILD_BUG_ON() checks to ensure they 
> match their PIDTYPE_ equivalents. I would presume these should be left 
> in as it is technically a defined interface and user code could break.
>
>
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> ---
>>   Documentation/admin-guide/hw-vuln/core-scheduling.rst | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/hw-vuln/core-scheduling.rst 
>> b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
>> index cf1eeefdfc32..338d639a8127 100644
>> --- a/Documentation/admin-guide/hw-vuln/core-scheduling.rst
>> +++ b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
>> @@ -62,8 +62,8 @@ arg3:
>>     arg4:
>>       ``pid_type`` for which the operation applies. It is one of
>> -    ``PR_SCHED_CORE_SCOPE_``-prefixed macro constants.  For example, 
>> if arg4
>> -    is ``PR_SCHED_CORE_SCOPE_THREAD_GROUP``, then the operation of 
>> this command
>> +    ``PIDTIME_``-prefixed macro constants.  For example, if arg4


Presumably you mean PIDTYPE_ here? Otherwise looks good and in 
retrospect this is probably what should have been done in the first place.


>> +    is ``PIDTYPE_TGID``, then the operation of this command
>>       will be performed for all tasks in the task group of ``pid``.
>>     arg5:
>
>
> Reviewed-by: Chris Hyser <chris.hyser@oracle.com>
>


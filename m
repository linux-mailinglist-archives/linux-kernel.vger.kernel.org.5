Return-Path: <linux-kernel+bounces-157001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 253068B0B6D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 224B9B21AF3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1AC15CD7F;
	Wed, 24 Apr 2024 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TVrOhSnx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jNilBhKV"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AD715AACF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966452; cv=fail; b=YjxGoNTikrg5gASFn9iUF5isLoEm9XwEuCvTvFdvpGxucd949/Qf0bvoExHsdnUs5/wywMXBjEc8ZbxglEc33tcDEOaeU+dK2ZGjIYhT/oUiNAS6NPGR5ucBq0i644gmSOkB6venazCWBkIg8qSW6QMkrLPr4H0gjXmcsBDEz6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966452; c=relaxed/simple;
	bh=3E4lg3MXAyHNtXYjQX3+2NPGEa3PbrRNCfDtY5jjk8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jeo+0BWr09Tws8ytp9TbJ2yA7wzw6ezTv5Hosec/ZBWUx3QhZvSwUWqjIcyG6LKlw+Mz5lFv+ZDZieve9YckEeqzUO53OdXRf0XYdioEP7jpnylmMurxkXWFEWDCbJpcOiAUWelwas1spCGIf+Rgdmg2MzsaHBCjjqrQJuz9Ma0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TVrOhSnx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jNilBhKV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OA0gqA019531;
	Wed, 24 Apr 2024 13:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=5Bnuq4pBXPDfH+NUzJxSBPbtkFO+4jE3nGmT+KtROE0=;
 b=TVrOhSnxJGFjbcHgl0OXoIK3kq7AHBh09g6bch+tvulURvEjCqze78Ffwtg6wIKvYEhW
 ZHOmS2Ls1SFW2A1eH4fDFcoY82VQffCVaADew4C3GHE/+dDxaQwR42oXHSqI0wB9ONjR
 5umJBkl5m356YtNQp6UD2wf/maf6N4URIJN/yeFkZJB/Ix51YbdqPX8z5SGbHEPZkFZW
 HRD5gShP2uMimGUBp4JauSR6vWztl5Jl3gCZ9o+Jp0lujh1yy7IgPDuFJro2JF9kk78k
 FkPi8Fvmty0RBz0JQc5dZMq8MckM+jFHur4mTL7BFBcbu9GaDRoQHIS5/fhRoZ94fBAb MQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm44f00j7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 13:46:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43ODRNBx035582;
	Wed, 24 Apr 2024 13:46:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm458upnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 13:46:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRE5CPMT7pLAmHS7H8lOIspKNmjgST1hB0nxNSQgEmPGL1MBZo1O/7/8J2MfB39/a+YqzVD1f7Df4hxp86o80Iiq5YkpMZ+l/YxepZZj47LZiX4etxecHaDUJyPW2HWJKf3iCPY7YAZ876Ar4artBefTOswxcoXBdW1SEuYtdFgJlXDes68d3KsbdDqk6sD6GzCBOfoxq4ZGch3NJOsg35EyDwFJ7MGUGpM96y2oY9YZ6KiYG42fxJeVEjm0HKDEcFfzo0YNQ1aWuHkO2LTwy8AscmN3083d3PFqdGzLUHX8cJ2h/A0Vugbli9XjN9n7UgHjcp/kwJRSAqMyRRaV4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Bnuq4pBXPDfH+NUzJxSBPbtkFO+4jE3nGmT+KtROE0=;
 b=dTfZXMIt0+SiiAJ9AhVL7yVJNCiuRBssdpTufL84bmKFWqMvMlF42WWIB5UxnVQs60VUtsrJGGedwSrmiRPobaeBepgNl4lGKQwD1C8kS8T71H5wWpl7gew5hELZkhW57rYpwyusz3Edp3V0FRWynReKqlulXCWyDhid5ytwSvUg70pYlajDzPyowMcbcGMNCPHaXpEe+eBV1Qj4P+WpfVhS0vVheXfwNFceuKVlk/Z6C1QiKQPYFmmVKiJYKUaZ6gQa/jtdZ0lN1JLgWZ581Kf0x/PrPQSrJMT7xPSVGxKTyptCS5lfGOQ08KsAWv5zlBXvySue7Qjc9LeOM1e5sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Bnuq4pBXPDfH+NUzJxSBPbtkFO+4jE3nGmT+KtROE0=;
 b=jNilBhKVj2EUQ0k/E2Xugd5O5XbYxtwDCTfssWQJ6RfRfxJnRVz7q2wFtde7TxMdAfGbsnz6F0qjmwu8htGc4W1Fa19FFet7XMVUJq8kRAarJNqjFjhpXsHodaw7pfC1uNKvOemgINb3Ud/DB3g5qrCG2aleqLVb3m5hjq7WcMc=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA1PR10MB6806.namprd10.prod.outlook.com (2603:10b6:208:42a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 13:46:48 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 13:46:48 +0000
Date: Wed, 24 Apr 2024 09:46:46 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: limits.h in tools/
Message-ID: <t2n5aj7orslsewknx6vmlf7t4wbnj3u6cabrjjfaptexb64fzn@rbjhcj3uwrkg>
References: <ZigEvxn0-70og0H1@smile.fi.intel.com>
 <ZigKWZKY6kq-w0Tp@x1>
 <ZigMG8ZsBryO57zz@smile.fi.intel.com>
 <ZigMa2GqF_HN39oz@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZigMa2GqF_HN39oz@smile.fi.intel.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0440.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::16) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA1PR10MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: cdafacfe-c3b3-4a4b-b985-08dc6464fcb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RzlvbHJyTVh1blpzaXNiSENzZEY2ZHVscm9CUm10OTZHWXUzTUc0dnIrRFpQ?=
 =?utf-8?B?Qm9uQjYzMXpuWXRjSW5TMytVN3RSVEVleTVJd1cwbldvSUxORWdXVjVrQWRG?=
 =?utf-8?B?MUdQRjRBYWpCWGhGbWlQSEN3ODVJNFY5YVQvZ0ppeWV3YjVuRGdXVGM5ZGRu?=
 =?utf-8?B?QVl3T05VL3JkR3hrSzVoRDlaWFpGQ2pkdmVuMWM1VDBEQmd3dHIwMUwxMWFY?=
 =?utf-8?B?amxqT29ySGFDcTY4anhRcU5YTituUENSc083ejVQT2xRYU1sTWxCRUVJa2RQ?=
 =?utf-8?B?WEd1WktYb1pLL1ZHcUlpNkhEQzFkL1JVTzhDcGQ1SzB1Q1ZqTnUxYjYrMGRV?=
 =?utf-8?B?Y0h4WkVqVXp4ZkY0RzZxeCtEdkRBOWFQeDdyYjN5WWVsbElhTE1md0UrZEtG?=
 =?utf-8?B?bnRLcGV6MXFab05hMmpXVDJ0bUhocFBoRCs5a2o5M01tRTZUdm1YV045bFJ6?=
 =?utf-8?B?L0lmRXYydGUxODJsbEVTVStxSVEzWFhVYTJCTmRtdkhoUWpWQXB5eFgzc0Ju?=
 =?utf-8?B?MFNPd0pZbVdrYm9ManMzeXhIc2xrVzRtY2JwQUplVVN0YUdjVHVSMGJlNzJN?=
 =?utf-8?B?dmRoQ1orWDJRanlzRzc4NGc1LzRvWloyTTRTT2k3S0RwVXJBdEhSYjJjbnZl?=
 =?utf-8?B?MmVNSVl0TzdWUS8rMWhEQ2phQktYU3kyN0RWQ3FjSDVaRkI3aEVobHFxZGpw?=
 =?utf-8?B?QkRPVnk0OXUwaEMrRndQaDNnMi95bm1HME1TRktPNUpGVVJLZFRGVWhNN3hl?=
 =?utf-8?B?aEhwWWd1M0xQRGhTWG1DSDFzUnlpaWIvN0xiMHZVZUs0NHFJelRWY3hQOE5N?=
 =?utf-8?B?K2lGclBYTU5WVFdvbitpU2NqbUZMZEhTV2FVRnEwUlkvYkpFanRpWUNrejM0?=
 =?utf-8?B?UDZIYk5YV1pTYWYwY0g0ckNKMjY1SisrOWt2SFZ0Q1VhUUgrSVJ0SjNvRGdG?=
 =?utf-8?B?Q0tPeGhwWmNrU3puRGdzOVBGSDl0SWxpQ3pZWnRONTYyUHF4ZXpHOEJzbENp?=
 =?utf-8?B?SmJyN1lESWhERFZSZklldnNNa24rcjdRTUpQWXhnZjV2NW1hcklXaHJwR1JV?=
 =?utf-8?B?L2c5cTFKZndRaktYdHRHekpOUVN4b1VJTGkwOW5ldXFCYTRGQUdKZFgrY1JK?=
 =?utf-8?B?NElTeUF6YTBtcjlqMG13aU5QQ29PN2RmZUw3eWNSSjluTkVwN2VmRDV3azFk?=
 =?utf-8?B?VGc2NWo0dTl0NFFLeWdkMFJuWXM2SUVlWHJwNXROamdEUTUyeXZHa0Vyd3Nw?=
 =?utf-8?B?Z2ExTjFkZDRIblU0T0Q0Zy9iRjMyRW14eW0ySFkxelg4SWp4ejVwc0dvN1ds?=
 =?utf-8?B?TjBXY1d1ZURGdytaRDhOUDQ3VWNnQU5kVUczYU5nQ1k4U0QyUGp3SzRBUGJW?=
 =?utf-8?B?S3FYamMyVDI0WW1UMExDRHlqc3lyRDNBbXZhajVWeU9tTWN5SHYwY1Z6N0NX?=
 =?utf-8?B?VE9JRG5LS2lvNTFjS0tDN1FXT3M4eUFvejV0VDJjelpKSmlyRG0wdHlVNjhM?=
 =?utf-8?B?V1NzSFJ2ZXdsWThUcC9FbTRMNW1zS0JNTUtlc0JZZE1RemQ5Y3FmbitnSmgy?=
 =?utf-8?B?QWtlbEZYTDZ0YzZ3L0ZOVjM3UWVaOVd1RDhwZ0RsYWk5U0U3VG81dWxLeTNZ?=
 =?utf-8?B?RVdLK2xMcnFudHkxTTg0Wm02Y29POGdwL1VCN1VNRk1VUi9rbFBTRjVlc3RK?=
 =?utf-8?B?VHF2N3FPbUxBaFgrWmxITS85Vmk4QUkyUXM5czhXTjFLSk4ybGs1STVnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aGhLcUJSRTBRRVpWc1lhZE1nV0FFSW5yWUliWjd1c0xtSFJqbVdOeGJSM0x3?=
 =?utf-8?B?VjJjcU5QRmUrNzJpK2FZSmpnbHdaZkQyNlJMWlZmV1l0QkQrNnNhSEZ4cnlD?=
 =?utf-8?B?YjJ6Ym5OUVc1ZDZsN3Z6WU1yQTMvdmNQTXlVRjRmNUdTdkx0UDZXSmsxTUNZ?=
 =?utf-8?B?RUljLzNHN1lncHlYaWxtanNwUU9SOW41YW02aEJMWXpCNVJ4OVV3aVN0dDg5?=
 =?utf-8?B?RGpFa2dEc3hFUW80MlowSU5Cc0EyZVVVU1VOTjJNQTRFeWs4cGRQbncvUmow?=
 =?utf-8?B?YlFINVdLcnYyeEdvQTl1SHpMeThycDQwckpHaU9SL3ZrR244SUtoU0U2eVdv?=
 =?utf-8?B?SndUUjd6NmdQRkM3S1JaMUg4OGdsTU5ESkh5c3FBMTJqQXJ6dUpqeGllVWl1?=
 =?utf-8?B?c1AxK0ZQeVRmcHdwUEd1L2JpRm5PQ0Nqd00zbjVYcnZxU3lXRzlUYW1xR1k0?=
 =?utf-8?B?TjUzaERCa2dWZmRxSjd6TjdSNlRTZmcrREN4YWRsQ21rRlhpank4S2ZGQkpB?=
 =?utf-8?B?SFUvWkk1cHdVY0M4UW5YMUpiYm1DRzZCQ0I5dlNoZklNb2ZIOFJxNGVITVEz?=
 =?utf-8?B?N0dLeUhHdVdRbVhBc1NPMmg1NFFDaTN0a0ZYQjJWemM1UXVSTk5pc0U5bWUz?=
 =?utf-8?B?cGxDK296VnVJUmcyNDB4Zk9KVUpwaUJqNGdPNXBkQitVZHF5T1NXekhhbFVU?=
 =?utf-8?B?TlVna1Y5clhLOG9jcmtyUGZOTGo1aWFJYjVtTkdPam5HWUhNaTlpQzlFU3Mx?=
 =?utf-8?B?d1ZUVmVOZUFWaUNFWWdubDd4ZEpLSzJ4VEtDUDBGVnh1MXQydk1iSkFKZzhs?=
 =?utf-8?B?UEYrM0xJYTJMd0NCNG01YTNreTlYWUJmSUtOWkNCd3V5Q01Vb2M3YVY1d2F6?=
 =?utf-8?B?NHRxbzBMa1V2TjhVdG1xUklDRjI3SkYrSTY1cGRwV2loQkIrWWhrZFlFRkZQ?=
 =?utf-8?B?Qzk1OHdTb0JBczg4cjh0MXo3TURNcU1WZGJHUXI2dkEwREhEVXRjU0lTZ0p6?=
 =?utf-8?B?MTh4S1kyZW4rZnNYUVdRc2Z0WWpESWthL1BKc0oyd1h6YXdxWUR0QVZhMHdQ?=
 =?utf-8?B?ZFBsVUMwbWN1Y3o3SWt1eDMvWUJHdFE3Y2RIS2dHMjMvN0RyWVhLMzFHTjhy?=
 =?utf-8?B?RVlEeU1UeUoyV2ozVG9TQlczcTQvUnBLOGdqSExJOGVEZGRMSnVqaWZlRTh4?=
 =?utf-8?B?TmM2YlRyTkVDOXZyTmRUZnpUVDVSVUJVdjAvZGNnQlg0Q1FvcDl5Sit5NHJu?=
 =?utf-8?B?cVU2cjVmQjZEVW03T0dCU01vTzdsVVVBbThrb2RqOHdmanBCdG80NnByTERr?=
 =?utf-8?B?NUEwNUdpVmVTZTZjNExGMFBJUjBuR1ZhdlhSeXZ2dkVoWGFLSWRBSlFEQlRt?=
 =?utf-8?B?YnNPQTJvUWpucVBHaXJjNHVlbUttMjlaVDB3UkFrQi9VbUtRaDdDMFhUNm01?=
 =?utf-8?B?eDA0ZDNtYjVaYTlXSlg2aktOYzNJb1hqeTBnTmhNdFZPOGcrc2FHM0JHaml5?=
 =?utf-8?B?YWtNa2xhN0NLQ1pLaEREa2p6M1k1bU8rc3Bud2pzVFBoL3FkSUJWQVZKalQw?=
 =?utf-8?B?cTJrU0dpRkF4UlBQRFhScFgxenN3OVNieUVMd0pWQkJDbU5YejhHMTRDb3V6?=
 =?utf-8?B?Q2ZCWlVLUkRKQU1DZVNzVVY5d1laWEFJWW5mcWxhLytGOXphQXFTd3RBWTZN?=
 =?utf-8?B?bHpROFU3aDNxMlBhWUF0SUZQQklWb1k4WUVJcWpta2dLTWdnOGF0T216V3k2?=
 =?utf-8?B?aHlUdjM2SEI1UTBOeDd0d2pLT2FHNXEvalNqMThWRnpLSWluNEhPaytIcnYv?=
 =?utf-8?B?eVN5MHJVT1p6NnRHMWhKL0ZZTmd3aTVyeW9DTFQwdS9PV1VCaG1jN0FQTzlh?=
 =?utf-8?B?OG9PbmFNaTBUZzU5b0kvWEtWUmxZTElvOWZVUFBraU9yZk5HREFpYkludlhE?=
 =?utf-8?B?YzN5aW5MeUZuM0xyM3J2NmlhQWwreE9MeE5TN1FBVFVUb2pubDZoblNWWnFK?=
 =?utf-8?B?VVFtakk2UUs2d0FnWXR0ckhMaHpUdnZGUSsrekY4VkZ2UmVpWHo5YmM5dm9R?=
 =?utf-8?B?YVBQL1lDdDFKR0NYY2FLWHVkWkdLbm43c1RyQitGWU83YktBN0I4RS95eXhz?=
 =?utf-8?B?ZzFoYUUwS3ZIUmpwNTM3UW44MzgwaktLZHRQTkd6ZmM0Ull0REFWMjF4bkMy?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2YRjXb+fwHdS/BrunpdMW/9VzKsY5oRawmMaexi4PgfVPx3kUUrtl/CQreU1byiwFXG7kVUamgHeGrdbKisz68BoqbdT4oem4SvGDVcwwP1jY60Aa2C1BCrHNSv1S1K/I9SeywraduFOoTLKEGm4lBeTmp8tFrRN7Vo7+c9vHn/SCSq/uJyVEwoOt2eK/SVvidf7IYQ0jeC4VtJpDtoxpCggm984p4rQwmljv63k9Lo/P+Jr4j713f5T6moF+eRyT6XL9c72TYGLdT5RpkxXoinQRk6GMUn4265nFoRt6X2TA8FF9TguAv4+uzuuUAdAaE8n7PILoBthskXW6zuTzXL8ZuMtBTpw8JhDU8/DXofuZaNQ4vRxfZ1FKXV//ZQ4sypLN3PWN61/fUv9Ys87r2VqGsZCQgFE1aX+v7W7ZuoFOsUxtXx6eu2ZZ1Dwo2xxLYi56C70sLX1bzDBrEbBcp8uV/jPxUHBzVB21CWQSG9+BSjkBs3537Hu5b3hN3Gh1vrrZvRJPItMi6Y1wfPREoDmYevPF2iLBFYxbO1Rj1DsgM2qaZq9jt6gYJAk3VTj9xuEtkD3ADp7/m2jzl7iq9uA+35D6tWIgE7gyiKZEJE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdafacfe-c3b3-4a4b-b985-08dc6464fcb1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 13:46:48.0590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fG1cD/XgBEEIASV8uevyifOfPf4TVKdzmAcf/zTzq8GerYcl+L/ZTbPyRS+JcerC0ptFrRMl99YCcqgTxa5HgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6806
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_11,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240047
X-Proofpoint-ORIG-GUID: K0o2JpgtdsJJWtptjNT4h5taPyt670QQ
X-Proofpoint-GUID: K0o2JpgtdsJJWtptjNT4h5taPyt670QQ

* Andy Shevchenko <andriy.shevchenko@intel.com> [240423 15:31]:
> +Cc: Liam, the maintainer of the tool in question.

I maintain the maple.c file in that directory, not the xarray.c one.
xarray is willy, and I depend on some of the functions from the xarray.

>=20
> On Tue, Apr 23, 2024 at 10:29:31PM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 23, 2024 at 04:22:01PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > On Tue, Apr 23, 2024 at 09:58:07PM +0300, Andy Shevchenko wrote:
> > > > It seems tons of the code in tools include linux/limits.h. But I ha=
ven't found
> > > > where do we copy it. Any pointers?
> > > >=20
> > > > Based on the discussion 20220603183231.15159C385A9@smtp.kernel.org.

I was unable to locate this discussion.

> > >=20
> > > =E2=AC=A2[acme@toolbox perf-tools-next]$ diff -u /usr/include/linux/l=
imits.h include/uapi/linux/limits.h=20
> > > --- /usr/include/linux/limits.h	2024-01-31 21:00:00.000000000 -0300
> > > +++ include/uapi/linux/limits.h	2024-02-03 16:18:02.652000641 -0300
> > > @@ -1,6 +1,6 @@
> > >  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > -#ifndef _LINUX_LIMITS_H
> > > -#define _LINUX_LIMITS_H
> > > +#ifndef _UAPI_LINUX_LIMITS_H
> > > +#define _UAPI_LINUX_LIMITS_H
> > > =20
> > >  #define NR_OPEN	        1024
> > > =20
> > > =E2=AC=A2[acme@toolbox perf-tools-next]$
> > >=20
> > > And in the places where I test build perf I saw no problem so far, th=
e
> > > build failures below are unrelated, but still outstanding, see below.
> > >=20
> > > But then is for building tools/, not the kernel, right? The discussio=
n
> > > you said this question was based on is about changing
> > > include/linux/xarray.h, a kernel file, so should really be including
> > > just kernel headers, files in the kernel source tree, outside tools/,=
 I
> > > don't see where what tools/ uses to build is relevant here? Can you
> > > please elaborate?
> >=20
> > I believe the tool in question is tools/testing/radix-tree/xarray.c.

I'm not sure what is being asked.  Are you suggesting that the linux
kernel xarray.h header is including non-kernel headers?  I don't believe
this to be true.

However, the xarray.h tools/testing/radix-tree header certainly pulls in
the kernel version of its header.  The point here is that we want to
test the xarray, so we need to have access to the API, but including it
after setting things up so it will work without the kernel.

The directory you are point to is a testing directory which uses a
combination of kernel headers and custom headers (to avoid pulling in
the entire kernel) to build a test application.  Sometimes the real
headers are used, but other times we are required to write a small
function to do what is expected (eg: allocating kmem_cache objects).

So our tools may include some kernel headers directly, for testing those
functions.  It also includes testing headers where we just need the
defined functionality provided for the testing framework.

Specific to limits.h, if you look in the kernel header, you will see:

#include <uapi/linux/limits.h>

So, most likely, just including the uapi header satisfied the
requirement without pulling in more headers with, potentially, other
issues.  IIRC including the types.h header (also in the kernel limits.h)
caused issues for me in the past.

I hope this helps answer your questions.

Thanks,
Liam


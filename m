Return-Path: <linux-kernel+bounces-98621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C39877CC1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D49A91F210CB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D9717BD9;
	Mon, 11 Mar 2024 09:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hLEuynyY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sXH5Qsl4"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62D22BAE2;
	Mon, 11 Mar 2024 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710149451; cv=fail; b=lhbiZ/GOZV9aRZKJh6pZbi+iEX9LlVQQsrJuS9o6CFImtvuUx/2bwRUHfY1Ic2dfyq1WbVNUsMTQlTA1N6wYk+qsm8aDa3QnCPlKxnCq5PVI8q0Y/k8RGutfdGZLHgtAIPZlHks++u1fcvDwnikCSG1bg/g7oYiV7WattYgw6XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710149451; c=relaxed/simple;
	bh=qHtLYpHwREPGFwYfFCc5g4SoueddD9PP5zE6i9msK3A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MeDP806h2M7hD2FPg8J4Bxc+OeiBY9LRcNQGGv74MxCwM18/VhhXvcjCG3feLLIRPh2WOuQWh4NexTfWT7Z53oX0MvXi8g0ksjGfmPDEymOx5FBAzyzxKj2IeB1Rq46DOqIHhJHEFt+dl3zZkRKkjW0R3fVy/oD9K4C8aqWZqW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hLEuynyY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sXH5Qsl4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42B8DxEG012627;
	Mon, 11 Mar 2024 09:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=uOF4kaTxZy5TXdu9ZdHTbbvxtxBsi8YgxCdCzP7CdV0=;
 b=hLEuynyY0CRukGgjpRrwJn1KME9ZNFS4WHCCPooUfW9uIDT8NbV+gDeZj6mwHDVtw6qS
 17/7hd81FzULXNpTxUxWwQeT+ytjZeyHEjr7ueDYH058+NMsG6C0eVw750v7q5/e46CA
 iUnCaNlfx4xM7ibaWDUI0TDlRJtcBQhOeLuwhzSgDkIv1+dX9ZXEtxMqXsRgYTGA5pBs
 XqliGUecRm7YTRCDrlm5CZFSM/97Y/UWoH/lK3Qq6Qe9xmdr23aOcxX13APwnZorTpzT
 a/+X3OVaHRYC95gjnThSvjPqsBsMVXtp8N6yYrsbBUtCnWJvqS9XLb3oKWfGI/w5y68y FA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrfcuas7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 09:30:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42B8AdWf006507;
	Mon, 11 Mar 2024 09:30:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre75gmwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 09:30:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjszhE/NK6xOoExLTZofvfk/4oQi7oAJNnISKJ6ddWeHoXco9fu42Zh8R8HDZ12bPH8qjt/XX7VX4wvHzJ6A/lTLf1WJ9GawWlfMZspJnFidjSoFG1FubKGbeB+aadDmq2E9dW6+3H4qe9xexnkWpIc8oJRpJTHpk/bF294lb5mdTCWPO/XQuszuDmBscyAS7vnz1WYSHb1BRYxJxBef7y2J4N2H+MEvUgHBQm9ZA+vxhQMJ82J3kJ6oVDjaGDfLDPSIpHbWYwyL1+viFwnzdHvwPqXnRY6VFXBnlCAdqVWMugAh2y5h96EYAX66nJ84h2r8zyaM1tRCb+RDB9F+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOF4kaTxZy5TXdu9ZdHTbbvxtxBsi8YgxCdCzP7CdV0=;
 b=DTTBO9cCJAUqSjrNIJvsHBacb6zGnW0ZxYDSIXMmGJIWqQeaof3DyE4Z1GpKAY/ZUu7wj7nFli3Sgc9xJSALXL0+vU6Cgcdz2voP/yQF2IWMo6ht/IFnku7YXYLtsGwaipATmOxA+gIyAu2bAgrqWZC3aGJ2WF8CcrMv7NhAEb5OB4Eg+pVoDtHSq+D+TvJfjm7vmB/XVk8pKdQF70+3laPxKDqY1yjlU3doDxewhTMS87ajFQsdnwEdfwepoh58w01PxOJKBbRkZtZpaGLTfP+YdbWNpBDGHEpwAmYb9uCnnX4D6CvtQZuVn8khfeseYMDQfw7y0FVGIzq0ReLK2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOF4kaTxZy5TXdu9ZdHTbbvxtxBsi8YgxCdCzP7CdV0=;
 b=sXH5Qsl4bwkI8Xz+Ozp4cD1c7DcdGZcZ5hWTOUTYgqs+DLkie1OtpImsz1Y3YD/oUpq7GjSbWGvjeW5V9DJunuBpZ6TMKTa2ygRAUHIvS4CB1kAjUnXlRm6s0JIVvBNaVPHN8XsW76cD0YT4xhM1/T+6qcj3gBNF5/xRtip2y0k=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN4PR10MB5797.namprd10.prod.outlook.com (2603:10b6:806:204::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 09:30:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 09:30:37 +0000
Message-ID: <03afee77-3d5e-44fc-9e03-eec70c9cee2a@oracle.com>
Date: Mon, 11 Mar 2024 09:30:36 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: megaraid_sas: disabled shared host tagset feature
 by default
To: mengfanhui <mengfanhui@kylinos.cn>, kashyap.desai@broadcom.com,
        sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        chandrakanth.patil@broadcom.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240311085412.2391632-1-mengfanhui@kylinos.cn>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240311085412.2391632-1-mengfanhui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0400.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN4PR10MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: 817e1a52-e4eb-422d-45cf-08dc41ade8c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sbGmhEMe8p77LgPjb3766q98J+ussCPf3kwFyuYEBymNYtygEwcfINXDVJyNiskUTlc2DCb2kxghVp+v7RNSAeYgw92vn1L9jr2nMuh7wM5w51BpjVXMjEqSB9nzmzOgGOMe+raxD0ergp4TK787yUJjFGas9YNnR2pg0H5Chxs62F/94KAVrrPovJpheLJaKDlhi0NA2drvzcKncqm3zatyaDegc7FMRQHQ4HWwut0gJUMQ4fxRCzugcUUOhxzC6xGOkVCiroaD5r/cWb7901TIFRgmCFKn0gFFrg+r/xOcqymv9HoRbQPTaB8wddJ0+Fb92imRI0P2OKvP/H0BeWfw8A2WqDXaqRzShSKUtbPUUqJ/ueuiZL2e+xXBZKZIadybM45k4Hnp2npzh64+inAeRIGHyZ9BOTr0PY8nuvE3pSuHDjW0c2x6s8mSbyo6n5KtjF/cqazM3daqd6n6THzOrYulheMDC6RhjzsxU1n9C+PzPfNEj0hCU9xj/9gsUJa0PtpWQ8uv7Il2wp1xGhUT1j2At2zvN7zyWdK2Ai6+1D+QfDQxT6pmsGG3cqW/lZw01z226Qi8vWfcjn5NTDSr+yFrvz0rGs9A7SS7GX1y+FhnZaDSGxczhSc0QoIXW+j6AffK3NjqxrzvKtb1P5qaVk8GPd9/GQgQ1XTILuw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MnFXOG82UkRkM0Y4UlRRbHFWb1hrMjVFNUpSbnE2QTdtQ3NJT1V4U2xnRzR1?=
 =?utf-8?B?a1NuVEE0VmNzNXdVVmhpNHppT2hjVkwrMzB0TFlaN0V4WHJjdVFLc0dITlZE?=
 =?utf-8?B?TEpJSnJkc3pCWmhIaGVidGlleEk3eWZwQ2ZyN3hWZmhIeHhQZ1dwdVY1UUcy?=
 =?utf-8?B?VEVUN0xyci9mUUpDaDBYVDVjdTZDZ3lrMU45cTArMkFnSjdjUThmNUFpTURx?=
 =?utf-8?B?N1BIdXFrSUFsZmpqcFBUZ2hFZ256UWtYcmt1RUpyalNyaFdQMGluc2RzeEpa?=
 =?utf-8?B?NURrR3RsMFl1ejZud0dPWkZDQUVIcFh1RUtjeFRHMGVNUkx5UHA2UVhpQXRC?=
 =?utf-8?B?RnowWTZWR29laXUwSk9Ec0tkWU5QM0M5Qnl2UkwxK0FabkNSdmNzVGhSbkRp?=
 =?utf-8?B?VnhBcmJvY2cxNGRJY015UUN2WXZhSC9UNGdpcERUMWZocEY3cEhnWWJER0k3?=
 =?utf-8?B?azJEUjVkT3E5RGZSOTNoL1YrTWVxblB6Rlg1WXAvR3NJNXRlUXd6YUZOVHRF?=
 =?utf-8?B?WHRtTEpFYkV1a2JKaG5Vclp4Y2lzRnBuVGFERVBaZDdyNGluNHZTK0UxWjQr?=
 =?utf-8?B?aXVBMEJUZE9HN24xSjhtVlNDVmM1UEZvWm81MGJqK3YzTUhjdkhRMXZkVnRB?=
 =?utf-8?B?RlplNUlJcmFLc3F5elRjdFZRSnhtQVcrVmRaQ2JHR1hmMjdSM3pTbVczU055?=
 =?utf-8?B?RVR5L0orVjErUDVlUTcxU2k1RkNIT0VwQjh3S3RzMHBMM2ZyV1VTbFNxOGo3?=
 =?utf-8?B?NXRVS2dhQ3VLaVRDWDR0c2paTzRwdWhBV3dLRlZveTJpcmVCMW9JbEVZY2lP?=
 =?utf-8?B?a040b0YyUWtGT1MvV3UzczdqajBSY1NMY0xqbitLNlVWbmxUM05aSlMyc3d2?=
 =?utf-8?B?RFd5SlNGaUUxY2lpSmsyOGNCNGh4Vi9nQkhlR3pKRlVDTys1K2Evc0U3OVlV?=
 =?utf-8?B?Yy9SOHV5U2p6eDdmNzVRTkc1QU16WHBqdkkzb1QrVkt2YW10UnR1WEtCN2Vk?=
 =?utf-8?B?MDdXU3g0NjNjWjUzRmYvdEZzYkRlcmJ1QlNndVlpdkNJSGpuZDJGcDRVRjV2?=
 =?utf-8?B?MElOZmNzdElhbkZyblpRbjFBRC9XN0lJRUxZdzEwSitObmtHSHRUam9sTWM1?=
 =?utf-8?B?ZFFMZFFwVS95NkllL2EwYlpVRXZoTXkxR3E2UWs3NDFMRDIrU09xVkpMT3l6?=
 =?utf-8?B?OTJIVWtXb2E2UXh3eG5EWGVOVWFmV3NmQitwR0Q2NjJ1a0ZnaHpxOU5wNytH?=
 =?utf-8?B?Y255bmxXc0NNOU5mYXZ2VE0xOXJXeld5QWk5aEljL1ZTRERia3Q2OXNYVU5J?=
 =?utf-8?B?eEZrSmxTK25JTlBnSkszaG9PbzZsRzFJb0dUTXoybU9Jb0trSzgxRXdYS0ps?=
 =?utf-8?B?UHhPLy84Mk1xQUJLYVhPZU44VllTNmlkZnZGOUxlYVNNVU5ZaDlMUjlFS3VD?=
 =?utf-8?B?Z0Q5eEl2RSt1SnN0RGlKM2FmSUhwMmlINGY4TnNWSFVvWlNJbDhRc3JnY3h0?=
 =?utf-8?B?dHpIRGdEa2RtdDBveUhOOXh0VzZxQlhvdU1xdnFua3l6Smw2Y3REVG1sNWdW?=
 =?utf-8?B?UGp0eDVOOGFmekFjMEFhVlgzT3V2USsybno0NjNrU2E1WHJ1VDRYV0FWMEhK?=
 =?utf-8?B?VWVxYjExa0NESkhoYVNjbHE4NmEyWDFjbng4VEZzMFlhTDYyOUc5N1ZCMW5r?=
 =?utf-8?B?KzBQUWp4Z0JOT3FYeG1Tc2ZrQkdVMEwxNEl5R1VZNUdVaHVSdkQzeU5pclUv?=
 =?utf-8?B?RWFkMlFIT01IeU9ReVVlcEtSemR6WHo3RFlCTlVydC9UOHJESklzUVgvaEoz?=
 =?utf-8?B?N1VMRjBMR2lVVjRtT1RYQkh5Z0ZYUkVoK3hPdFVINFB3cjdOajdJbWU4eXZC?=
 =?utf-8?B?S0lZVTBBU3FWVUFmWGNIVSs4NzY0TVlhQUxVR0JsWDE2RVBNbVRkV0U0VkVX?=
 =?utf-8?B?enBleVRGaWwwbVR2dDBzSUttenI2MHlCMjlwQjgya1FWVi91RGJpazh2QlNG?=
 =?utf-8?B?SmxWL0lCbXMyTllMM0ZOakFnQUpBcndVQk94Sm9GMnFNLzZpUlJqQi83TVlP?=
 =?utf-8?B?Y1N5bkNna2hLaUlIdytMaTJYczJ2enp0MWlrSUpqSU8vYUFNbXp0VXhIWkJz?=
 =?utf-8?Q?xV8G6oPmxzs6lkXq5WW8b1ZRa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ts0/00D+roZF7pypYxckAQ6beZ/fjHzwwhQ0kopN6OMpj86ZB49HJGkKU+KdbUelP3L98W4dOl1NsX9fSB7JhearkXS2p2AJxNhkJYuF/4m/72Qf+SnYIjCmbRPCoOR5A01EBeC0l0n/X+t3QtEYAUTPncmL5xsnV6fb3krqO5E0uklGBiuMq0V6fe9pWLdjUKRh5pN0Y6jQto19djbT0C2BVvT6lPy1bL0/6dIUy+VbwFHk87ixFMXi1KHKTYAKuuzRrD8W0NN24SpUvXQQjaDmUHRCOf3G/GxR4H7N+AKJcud/iciFed7VD8kCheSaqesGUz6R86yc92XJgNbGQEIgQpIxXd9q877EonTQ79Dn9rLeyVFbUaZQL8J+9VWnoowhR23syLCxEZdtIXnuturecjdI9Z1Xh0lp7woJQOfxc025fAnl4EqvcjITbHkpEXexoITNb4ZXNISqDQymE1c2kzuwf4vN27JsKutdNiScBG9kx0aZyJO2r1qyHZakpN7CqePYdDUzyvZZdFdAo4rtUj2sk6iCoVgwbj11KUXFUZYJo4ioBi/Pt7eSCOu5p7WUuR4dL1lhXcShJxCUK5Yp8vSQdDotYSGxeHXdmn4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817e1a52-e4eb-422d-45cf-08dc41ade8c4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 09:30:37.2090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6BklTYt7zZTrIoDPMYFXZkKDw2WhW9IiaZsVgFPTWb0hMIDrvOLTRCcrlmTm5hPTPLO2MM39HKWO6vahSCSlzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_06,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403110070
X-Proofpoint-ORIG-GUID: ym-nuQJYlcG76nN9yamBzbk3geBmEq9n
X-Proofpoint-GUID: ym-nuQJYlcG76nN9yamBzbk3geBmEq9n

On 11/03/2024 08:54, mengfanhui wrote:
> By default, the host_tagset_enable feature is disabled，Fio performance
> has improved significantly
> 
> fio test command:
> sudo fio -filename=/fio_test -direct=1 -iodepth 32 -thread -rw=write -ioengine=libaio
> -bs=4K -size=5120M -runtime=600 -numjobs=$CPUN -group_reporting -name=**.result >> **.result
> 
> The test data results bw  are as follows：
>                v6.8_kernel       v6.8_kernel_disable_host_tagset
> 4k randwrite     375                     642
> 4k randread      210                     784
> 4k  write        306                     387
> 4k  read         435                     2457
> 128k write       355                     380
> 128k read        976                     3665
> 1M   read        415                     3122
> 

There are some huge differences in those numbers. Can you find out what 
is going on?

> Signed-off-by: mengfanhui <mengfanhui@kylinos.cn>
> ---
>   drivers/scsi/megaraid/megaraid_sas_base.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
> index 3d4f13da1ae8..da19c4c07f2f 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> @@ -123,9 +123,9 @@ MODULE_PARM_DESC(poll_queues, "Number of queues to be use for io_uring poll mode
>   		"High iops queues are not allocated &\n\t\t"
>   		);
>   
> -int host_tagset_enable = 1;
> +int host_tagset_enable;
>   module_param(host_tagset_enable, int, 0444);
> -MODULE_PARM_DESC(host_tagset_enable, "Shared host tagset enable/disable Default: enable(1)");
> +MODULE_PARM_DESC(host_tagset_enable, "Shared host tagset enable/disable Default: disable(0)");
>   
>   MODULE_LICENSE("GPL");
>   MODULE_VERSION(MEGASAS_VERSION);



Return-Path: <linux-kernel+bounces-77251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54C88602AD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E332B332C7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCEA14B824;
	Thu, 22 Feb 2024 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AmJu4VoR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZpNgW60Y"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F9C38FB2;
	Thu, 22 Feb 2024 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629796; cv=fail; b=d+oZSI1ojRYWs71HS+PqtoA+ZJ/Dh9fop1NMak11raeaJmWQMP9TIcmgMW3I3wvVV6UK6UUbzyx/Gbwx3g2Na2HwMvOkP3G0xs8xqG4SLTcOrUMBPS6YdkMe/xPa8norM+poZ7lp7hsSMS1T2WNKWpaQxi+SbqaO98FY+rzkFUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629796; c=relaxed/simple;
	bh=zNzoB2PclOZIr3rHNQL29g1LVeEAyGcI3hNrAgxM3xI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a0oTQwqYie4tZFpVOBfDdatHfi3ewYKfwHUNx19Y9fSxxwcdWhEjD9OPNcuz5t3ApTFJoK0BNIHdekFywk5elCiJoIWnzKFu5GTlJpCicb1Keh8NLjfZPLHe/fF+0BhcoH0wgDGkq/26JwppKgsVgBRYX7zsC5/QV926JhpqWps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AmJu4VoR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZpNgW60Y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41MIQWtk020518;
	Thu, 22 Feb 2024 19:22:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=2T5RCV2lgl/y1wD1gNDcB13r4rvwVvvRPpLq9bcQEGM=;
 b=AmJu4VoRrnmthLilarpSBSfIZppos4H2AhUtnLz0KxpVWfhuLAxYz8orMk/YEq8hiLhc
 epEoysYZEPXmBCJgLtuaUkMDog8U08iILHO+V48W5fF+OnmoW/2hciNvNx3a/u/Rx8zm
 UGmtVZc5JnnzCzHhd6CJcni5vyEbEw4AgsuiAQ9s6Ra2sI7gkQijYWoHT7gvcblhCR6V
 ADIBSiiigS6vVBuWOOiKjwEDjDxGJfYxRRzJXTh6uNCRee2QHMk+AAGbVSa18pMFreWt
 /B9wb3oUWNplT42Hii75vtf+p7rjTdZWSoqYT1wn9IvvS5YaGScOUeL9+JKen8BRON5f YA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wd4knwa72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 19:22:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41MJ4lNL022480;
	Thu, 22 Feb 2024 19:22:44 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8b2kn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 19:22:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyOwo04KdiYDN/Pse41gwxAg2RQIexCH1nb+Qz2oJwSq+8cJWFG109pnACH9FtTKWWMFiICk8E/hbhDUakPqGkazekxuX/M4WoDTs7x1c30sT92lyraFELhfJ0QP93/ju8ABITsGmrLRRJ2KuwHS03JQTfNvhnCcylJEHR92cOpBteeoakTQTw4wB1RwzDqZuBYLdGKkQDpQdKTZDBgLOoyasbB+PAp+svdMIsWws2ech/vbbT4z4+s3xsW+r2j348H5esCESYM0+rlGn0aM7wKi3qjggyVao6SWAGVEP2ml5vVtcFbJ9qvU5DJxJYLncGsHDJJEUMl+Muwg2Rd7+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2T5RCV2lgl/y1wD1gNDcB13r4rvwVvvRPpLq9bcQEGM=;
 b=jntc2n2fK0f6htGYEq+FaopV6CQOIDqRDMKWD/FiobbwmPWKquwNGyJXxi98fPNDRWl1Kdge5gnzTwXciUCeTm+AGMct1KyPOOSKwYhJB+RcuZt3pAmjY+CMAu/FpDAHu+AsTAhDn+VpgomAcAdvrIKBhRUnmNUheEnXRq+kWz+8l2Bqop1wQAaT1GQJVDpKxTI4M9Pm3Uv0sxaKdkm/u/OyRz5q0o9VvgEjxMvBwGJ4Cma0y9VmMnmyj3/fBCmwSrj2whKpnF/X7skZIDABQfvz4xBHs9CPP3tvQN1CXuTwCfT3rUZEB9MsyGyxLWRNNH5RcMuXVSek8+mnEONTiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T5RCV2lgl/y1wD1gNDcB13r4rvwVvvRPpLq9bcQEGM=;
 b=ZpNgW60YKgcnbtEsrSdNN5YHyqkCpBu/cC4aTzyyOFVIk0slUViIiTMlDgtA9E/Xj+VeFbOfqe7Cyc0Z1/IJGhLaLO+Yl+zMo2T0msVhQKY17bXFGZHbneOT80yj2HqeRBMNCmrlT4UNZtzKbEdAIk7xUGp7w6nOhIS9WjpClIU=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by PH0PR10MB7078.namprd10.prod.outlook.com (2603:10b6:510:288::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 19:22:42 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183%6]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 19:22:42 +0000
Message-ID: <9a2ffeb1-cb3d-453c-8527-4659778e23ba@oracle.com>
Date: Fri, 23 Feb 2024 00:52:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/476] 5.15.149-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240221130007.738356493@linuxfoundation.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240221130007.738356493@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|PH0PR10MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 250a0c4a-9505-42db-768f-08dc33dba3b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	crP325xkKCThPGRhyuvUHE9hZkZ78F1kGoiAdDdJclMowYJqfA/tJo+q3kVID/jjSDIZ0AyFmh9P6g1P698vEUscTNNgOrBtxeOBUBbP84dHUUr6wh8ROcSzyCmT75xc8+ra//vgdVx2yzJdVhzT7FOJduemMuBVGekTlYuRUTysCrouSc3WSCNegjF6GfsKOv1DLKu+UHPuAcxTmhRylmdjGlxAjc5t2w18hxX4+6i9egxjvALdNyK8FD/zggitNXQd59JjS+TZbH+xhw3gwbsmfNg/9Wk0Q/rpzFTAC59V2mCtLt3O/UTi2UXvdRPAUAZtWsHADlFLwfQu6sGmEImNlbO1/sxm7TdjZgdOTbbDF91xwlRB8zORbW958TvR1+FJ5mhMeZnT2Ehnr4Z4Ey/+CD5R587QRdiaahCo6zsM64SBPrf9oIuI/BAWS8WryyZ2laon3UVa2qMy87IJsPkAcmoKziB2Wws7GXwVeCHQuQsZRqev5TlAMu9Kxtrh+QUXoxe31HV76eka2MyXnw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?amp3TXlDRHBDMFlhWUlTZm53NHkyejUrU0g5VVZWeUNUaG5PWXJUSUZUMUZn?=
 =?utf-8?B?cTJtYjkza2pKaWh4L3A2MGdXbXBkOVNNK2sySUZ0Ryt2cW9WYjMxcWROeWo4?=
 =?utf-8?B?Q1gybWNrWGl6dE53dW0zbXUvU2ZWdThPY0hyVDZwYVpVamlzcENGbGNQUTgz?=
 =?utf-8?B?eVdqREpHY3ozTmZKdVBKbVJhcWtGTlBBYjh2bTd2clZZRjFzeUk1bGg3WXFV?=
 =?utf-8?B?QTNITktIOHUyRGh0MlZxV2hQWGx3NEFCV1RJSFNJRDNnT1dMdlNwNDcwRDlQ?=
 =?utf-8?B?dG10d1VzdDlNVFFuWHYwNHpPd2pXdUVKOGRJeGVPR1RmVlNBVlBSeG9Dc2ZZ?=
 =?utf-8?B?bVlaWWtLckdiMHhNa3lJZFBjVHhhOWJ3Uk4yVGN1RU96NExuMDJ5T0wwM0ZR?=
 =?utf-8?B?emwzZy8rSFZMNnRlWjdrOHV0RFZKRXdYMEVXSFFrbHhaL0FpSE5tanFWK3Z1?=
 =?utf-8?B?Wjg3bTV3K1FlUUlpOGpuL0JJdnVDeXAySlhCMlBhd0E0M3Z3Qm1OUUNjamhz?=
 =?utf-8?B?MGVGcml3bnczVzBSa3lIOGV3SVhmV1c4K3RVVXlsU2xpaFowZHVOTTFjK2Rl?=
 =?utf-8?B?RmVSM0tLdnJCdU1oSXB0NTlob0xLcG1HYWl1dlRoNzBqNEhyaXFRblJ3SSs3?=
 =?utf-8?B?MHROZzhsakcwdlNuQXFybUJNcE9QUUJOTE5YYTR0UUM1M1grNjRzVStlc1lG?=
 =?utf-8?B?K1R4OWFYUWEvOVNRTll3WW1uL1ZhZU4rMUJlalprR1pLcGxkbWVQTFI4cGww?=
 =?utf-8?B?aHBjSWZIUmtwaGxGUktmZEJYL3lXY1ByakRJUVBqQUZCL3U2OXR0Nms2RHVM?=
 =?utf-8?B?N1NFNmlqejdnSUNFM21IcGFYQzJIOGdmTk9LZkQxQ1UwMG1TUDhraHJDV0RP?=
 =?utf-8?B?QU1sdnZyWTNzY3ZpRXczTXBWb3N6NTJ6TmNiRlVpSkhoUVA1VXM0WW9NNG5L?=
 =?utf-8?B?dXhLbWkyQ1RIRS83Y1FzVE90UGVERkJZeGI2UkpRUVdMQUc3NFc2Mmc1MjRX?=
 =?utf-8?B?UTJXQVlIeUhlOXhJb01CZWIwR2dCd0NkYlVKaDk0UDRWU2tYRmlpYVoyVlAx?=
 =?utf-8?B?OVRIVmVOeGpGVmlEaVdXUVBMTGUrQzgzRmwzcnp0QU5WSDhraU5RUDFRV29j?=
 =?utf-8?B?VEQ1QXp3UmVld3owdkJ2YTlwTDNJSi96bU9HWkdzVkNHNFpYQmI3WU8vRU1w?=
 =?utf-8?B?WDltK0dYUm01YkNZV2IyamcyN2lkYnJVdmpkVHFMMkI3Vmx3NTROcGVxbzJ6?=
 =?utf-8?B?LzcvUkQwb1pDTHRPS28zMlJadmZGd2I4WHhPMHQyRVFIZEc4Y3g0MDNQcHNv?=
 =?utf-8?B?dFZSZm9tS24zWXp2OXFvVXFzTDNFa3c5SXdFS0FIaVR4SnhQOFdhQ0w1R0VQ?=
 =?utf-8?B?VGRWRERLbzlWbS83d3lTcFNsZXc5dkdmeWoxWk1nT1BnMlVpUXl2UGtwaThk?=
 =?utf-8?B?bFZaZVljdFU3TFRmZEdRbWN2RjUyWUI4NERINFRJTEdPT2ZFSTdzeS9yR0Jx?=
 =?utf-8?B?UXFLc1F1STNaNGZxNlNSamRhc2RhWGNQeUZRdlo0OThNVGUwN2ZQSjN2NWZM?=
 =?utf-8?B?SElQYXhOSnAzWmdDN202aTUvQjNvRUxyaURCS1V2cnBHUnRsQy8wTTZ0L0Jh?=
 =?utf-8?B?clpQTmJwY2prQ1hhN2hNdm1NK1h4aWM0ejdYLy84Vy84WjZUTmIxdnNmdUdl?=
 =?utf-8?B?bDdMOHE4eTFFbSsvOC94U0NORHVnNzBzZm9iQW0xeldId1JTenJTbnBIODMw?=
 =?utf-8?B?N0tuSFc0cG5WU09kOVIzek9xcTZsWWUxdVZPRHJSSE92K0twbzU3bWxWUXJG?=
 =?utf-8?B?emJqTzRITXN6SWdQRmxLSWV4NG1DK2h3S1R0VUxMd05MdG5YTWJBVWVROTRD?=
 =?utf-8?B?d2VNcnZhMWV3UmU4aGUxS3pManBnUERydDFoT2k5aVJvcmZGcGpKUkdrUmNa?=
 =?utf-8?B?WHJWazBFU3VvbWpWdTdPN1dVNUZFOElRa0NRaTZqK1RrOVhJV1dkNEhQTnRK?=
 =?utf-8?B?bnlDVXBWcFRHMkdIaWhoSkt3cnBvNnRiN3dyQTZQNkRmWGpGNXNWZlRoRFRk?=
 =?utf-8?B?SER6Zk9razNLSlNQY0QrNEhlY3dyUDJJUFBMUnhuK2VoSi9zZ1NlREdmaDhy?=
 =?utf-8?B?alhaZWNaaEdNUnk3bmMyZnp2Vm1zWGw2YURzZlZsOGY2TzM4QkVHOHBHV1pZ?=
 =?utf-8?Q?yLBlufHzuttERwu0Ykxqy2M=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vKSxpEYFcAKPoiRRSEx9lbZ2Vxte8Mk/l6sJqOK89Kdyhr4Ujxknd3uDXGZtD4wUeVoerCjIKLLEBOhrFLihiYVHYkkcZC9Iw6l46PCEblLnhTB2n1h9lbQg05YHV5H9r2/DI2CMnQge+A7lT0BrR9lhEKgVUlSl5/h5afEyUcxiLBg4/OXvWxxFWdlqTz2Y+1NBf7q8MM7AklyoYjjoSg3RsOHyZvrZPHSp/SWNMO5QOtoILaEkp9aW8juyYvRbMKu3j3c9Za9afcqxuI6fZu74qW4ARLtisCi5QBkfBf3sXRAPXHR9YbFSMD/C8tOcW+9yK14/XllWkFlvwEb94xOKhMehcc5dIVTcTgcHjqsADt1tC6SBzMTrYT/n5ZIr8W1OgHxyr6T6lkVuZhTSovBPCFVyQSWbzhMB3ErcNtlLVC9ff52OBwTs6Yw39whEUHlVhDn0YKqeAzFfPTfMLeYyxMrgkd9p4tnUFDtgFDUDFFtGOYWc5OejbLJzVDCI09kwjNzIrE2vF4KXORtK/5aQWbxWyqv+m5rWXDnUgCRM+f0l4MqIvnQXRGoL6R6NqLrMKx0QNSOyEg/A2zlyQyjlSNtyqYKA3JEU7Y3cn5Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250a0c4a-9505-42db-768f-08dc33dba3b0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 19:22:42.0344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/D10ynlqJUbsPK6lO6/Gkfqedihk0vgNH5ZuVKcDtlfZqSvQFT6qVwr42PbiQ+x0/zhgr0aPAVliUI0h3hrOSRymhbex15Zn7n0aS/Q3mb4a0SUpRU87ghwAC7xUZGA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220152
X-Proofpoint-ORIG-GUID: EO0HVjEWdiuuQl_y5_r4VoaHaLXphmtD
X-Proofpoint-GUID: EO0HVjEWdiuuQl_y5_r4VoaHaLXphmtD

Hi Greg,

On 21/02/24 18:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.149 release.
> There are 476 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
> 

Built and boot tested on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.149-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 


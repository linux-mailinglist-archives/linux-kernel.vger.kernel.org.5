Return-Path: <linux-kernel+bounces-156637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A684F8B0610
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0591C22B52
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCDC158D9C;
	Wed, 24 Apr 2024 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VFSRCOKw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LtAa1IcZ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E0C1EF1A;
	Wed, 24 Apr 2024 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713951040; cv=fail; b=XgvotGidTkchN0MGpKPQbiV7rm62zc9cJ7+ueDHSicWrWQmAWBjdB2sNUO60C0neReCkd7SSD+oILdNhKTUaG9KtGQ3KLb5F9wWl66aalbybGByCXimfnItwqIrSDkpS7g4v6u17s1rqxZkOnjwtU6D0OipDDwV6jqTIECdTMac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713951040; c=relaxed/simple;
	bh=F6qkd+g1m6gdqOlYBJ/yVyNyVSpGIJNKqbws+d8EAKA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jodS4LgR/z9PCTg09wJO2GgMiDtgF3fYfpL24whHDwUXsYjz9I7oF4yctG8vQthX0d8lotSaVAsEJbiIyXUkgPvtr6eFSRF0dBraaE4Ad2a1Jw6r1l65BFlgjbEpMnRWlU4j6iaQZJlpZB8k7SRtH6AtJZeq0NYyNKAMK5sgGdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VFSRCOKw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LtAa1IcZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43O8eRB2014728;
	Wed, 24 Apr 2024 09:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=7XeOVleqWkQ4tu3Ka74r2d5GDjNcrhGqy9Kdfn8dURY=;
 b=VFSRCOKwledHNZCvCELkKfNxwYX0+a+diLz9hjftE1W2zIGy/LEPoIVusZuhVkEhUJn8
 gUiwu8/FLf/yTinwsZafE1VcxbNNET6e++oH93U9bKJKnNKrKgvx9Bt2SLTKqcVPbPHD
 iskGlwy7Bnvra4y7ruO/izytz+lrKiGthSVzWVLR9eREe200HZciJU3yciiOOoR//DyG
 BVU9BGxgw2sXZB0GJU5DIpLL5fWV82FOF2Ajmrw7sGk0RAsLq8/chLshioK0SGqi5DnW
 KJ3YggJEe/eHIW3Ewepa/WG4WM0Rnst+u62m8oSWNx+WVA4JRpCuic+MdU6Y9sHZX9DH gw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4g4fmxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 09:30:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43O7jtGj035542;
	Wed, 24 Apr 2024 09:30:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm458hwgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 09:30:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoMAUKp9fwg8UHrRVRPNZ+LCPM10RODauLhmb5SFKsHG1+nLWh/jrAWVEmG5/25YUviSq9diuxioYxKICXQ8EUlQhcizP9+dqPF9rpzxFnjgOMPH/wGAp8USWuZqJX/Z5ftX8pshCOE6B79XkX9ktdxbjs3ifcUsQBPjgEdh64tTAlDjibI7/kSCe8kB5h/To5Xc2NgBvfUAyWLid/2/WnNsNuB+6w4n2p2vsaKNpNfTrAGZRbDPN5wHvfBMOFCQd9BUqytP+stzTSnXkOZDIduEc1Gye5VRymCy4IYkhLnU1GkNOdl9NUUeDmDoNiQGlDl2P3sDDnS6IByVInOq5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XeOVleqWkQ4tu3Ka74r2d5GDjNcrhGqy9Kdfn8dURY=;
 b=kHwis0swt59w5qpTsjHqUtZZ4Bq13/iOmypI2B7WWEgOgzjHGfbSFJq2XjUe55UeOGM7OyYaK78DTTcC4I1a1FpMSXlGAH0lTF2qbwPqtlTdtbcZbFfiWR740Vr/eYIAzq4kTQfNxqFZf/oSWBmVzBJQ3/5JRfz6sE6ALxfmBxaRp1TMOjtCxbbn7melpuxNkB8nDHM+DXcQVFExCq5/qnrMxWrT5vAQKJ0kJyNMEIsH3gN5FhvbGkvu3FLH/UPSO3Yf4wdS6G9ezPUH2TpWgOypyNNQ9SKxIwWHEYJ+90KcYle8datBK5bAJEQuHRoNQCuxqGbyRlfO4athhT6mhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XeOVleqWkQ4tu3Ka74r2d5GDjNcrhGqy9Kdfn8dURY=;
 b=LtAa1IcZav6YTFGIF/5L40Cx8RhHPQ5BT4KA0KlTxyfhmKKGdtR1FQMnWY4uhpt3KR3/+WpcxF5AFn2Bvk65sAWvbuoVoiXZl8lm00+WnNeCH9ktm5/ArE3dx2HdT6fjF3HWjCFs7Hc2hMLSPilv4q7oRaZ4GQKVZx+hc+jfagw=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SA1PR10MB6518.namprd10.prod.outlook.com (2603:10b6:806:2b4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.45; Wed, 24 Apr
 2024 09:30:03 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 09:30:03 +0000
Message-ID: <726633e9-b5cd-4d04-bb98-79dea2e76cde@oracle.com>
Date: Wed, 24 Apr 2024 14:59:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/158] 6.6.29-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        broonie@kernel.org, Darren Kenny <darren.kenny@oracle.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20240423213855.696477232@linuxfoundation.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240423213855.696477232@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:404:56::36) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SA1PR10MB6518:EE_
X-MS-Office365-Filtering-Correlation-Id: 32470946-9754-4dff-3aab-08dc64411ef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bVpSOG9FWVk3ZDRkbG0zTW1kcVQ4WmpEenlWM2lwVlNnK2NseXZYa2diV3Zm?=
 =?utf-8?B?RHNPVjNaM2d1eW1lZFM0ODY3ZU9rNnd4LzhXa2RpcmJLMW0yQnZITmhITnZS?=
 =?utf-8?B?NTNSUHVhL1hSWWhGeUFHeU9JZHIrb01QYm5Pc0hwRlU3STMvQjZBZzZDbHNI?=
 =?utf-8?B?N2pQd3dqZXRWYU11bTE2bUhSWlJ1c0w3elRseEJkU2ZsVy9QK0RSYU9qMWZI?=
 =?utf-8?B?eUZMbzNOV2pqa0x2ZklBK2NwRlUwZmEreU1YajVOZzBpMXZxbVFSd2plK3dw?=
 =?utf-8?B?VUt2bDBXYy9ldE5qT25DelRSRSsrT09nd0FkTXE3dEpZL1hPUWhzZ2NaTmxD?=
 =?utf-8?B?b0xiWSt3QzJNT2VDODJwR0Rwb3BoUlloeWdQempTeDFXNXR0YmFXeEQ0V0NH?=
 =?utf-8?B?U05aV2ppOXhWcjZkT0xhM3ZscFRwZEh6UDN6NStUc1IrV0FhSGMyNlZrN04y?=
 =?utf-8?B?WGI4SktoUFVFNTBJMmpZWGhMR2laa1pETUdrY2dQaTFwUGRWcTZMSUcxOU5E?=
 =?utf-8?B?UFRqY0tERFpBY2dOK2VnQXR2a3JEa0dtdEtkSlorSkU2VFhtQWVaRStLbk8x?=
 =?utf-8?B?QWNqN0pWV2FkMW1EK29keExnY2o2d2xIbU5yVVNyamJydU55akVjYXM5YWFy?=
 =?utf-8?B?UURvemR1dUpEZ2Nyc1NLRE9nQmpSTEFCemRSVkpQTTlYTEIwYzlTc0FHUDQ5?=
 =?utf-8?B?SmlFOWVVd3g1QmsxNzI5VjdULzhDcjVCV2YyTHIzanNKMlpRdFc3VzBOTGZ6?=
 =?utf-8?B?dUkzbG5RWmpmKyt5SzIxZ0ZwL1V0dEd5eVl1UXZoZFllTlEwK2RHU1NJalhN?=
 =?utf-8?B?MUJoK3FlK005NkppeWNZSnd5K3FhZHg2TVpOSDRNSlpGTlc1RGZlK3Vicnh4?=
 =?utf-8?B?UVF3QW1VcStuaU4xUUtrMDFrREpwN0ljOEptaVJRdmwxQm1DUkZXdWdqNnhO?=
 =?utf-8?B?SEphUDVId0prNVc0blBud0Z3bzQ2Q01QcDNqaDRSUERRSng2amNhWkg0NFVj?=
 =?utf-8?B?N05vRFd6bFQ2dzhIMUNDelcvdkhieHdQMC9WVENVaDMvVDRQK1U5Q1VlK1Ja?=
 =?utf-8?B?RlhOR2o0VTVZbHNHY1JWZUxySndRbGpua0ljMXNTOXNlZVlnZE9VT1lWbTdz?=
 =?utf-8?B?UzZWVi8rRUpwektnTkN4dWxoK0dBR01tcm02aExaQmhQK2ljVDR3Z1JxQWRU?=
 =?utf-8?B?dXlIVi93ZFdpMTVXQW1oMDVodDU3UXI3UDhPUWM0N3dvdUVhRmwrUzhPTHlK?=
 =?utf-8?B?bXl6SkJnZ0E1SGtCQyt3VnJWTlF6ZGlqNm44R1VkWUFDbE1yQStUckJ3TzFP?=
 =?utf-8?B?b0JndVpOV1JOY0NKNVdmcW9lMGhLaU0wS24yRjlYSHdZYXRwRHJaVlRVajFR?=
 =?utf-8?B?TnpINTk4N1NXazVuRHR6SGR5TVF5TTZKZUdNQmNRZ01yN1NjaUgxTWdjWW1N?=
 =?utf-8?B?ajhDMUZsOU5UY29TZDFhdzY3VFdYWTg5eFJUNFlsMFA0VEN6V0xsa1pCOXRW?=
 =?utf-8?B?WnlndUJUa0V2K3RlOXlCOTdPdjlVdzRVaUpJd1FEdHkwcU5BSzY4MlkrcTRI?=
 =?utf-8?B?SmwyeDE2NjNubnFySjZkS2c1YkVGaGcwMjRiNkpxaU9vZFpPWEpYTDdEb0hY?=
 =?utf-8?B?ZmdOdUNPYzRFcEt3Q2FNRkNyUTJVWERseEw2QXJEYjRuTnZWRlpWWFc4WTVy?=
 =?utf-8?B?cjJQMll3c3FuNDRrYXVnL2ZDOElQVTM5NG5zY1JOZ2ZZeXB4ZDhsbjBBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R1NWQTF2TWZQZEZ3VkJ6QmwvSGo0bkdHd2lsYTRXYis4UXJiSzRrb1FWZnNN?=
 =?utf-8?B?RkxWcll5L3BUc1J1MFRpc1ZXVjBtS1NLS0ZaZ1czcnFvaDNtOGVyZk03MHNH?=
 =?utf-8?B?QUdGQzF1WXdwbjRjSG9VZzhHQU5jOEZwZlQ2bCtmQXVhMER0OUNTb3k2N3VQ?=
 =?utf-8?B?SlJnV1g5ZjVCcGRIdXZuN1dxZFl0RzI1QStEd0kwMXdVMlEvaDhTNUdySlVT?=
 =?utf-8?B?MzNoRm0rK2Nwb1dVM3hSZVVNR3pvRHRGRVdIL1NOc1k0UzJNWXdLSXpPcUlW?=
 =?utf-8?B?R015cWM0ZFpxTHVVbndVRWF1azBWQkZMQ1NlUnJVTElYVW9JeFZ5ejZxYWZi?=
 =?utf-8?B?U0pCaG16UHp4K2gvYVJETjJscktTQVRjT1Exb0JaeUFBcXJtck11OGRFbVV3?=
 =?utf-8?B?dDVJMjI0MFpSZVVYSGJ2aHBXNjNuM2wxM2xDcDI5ekF6akJNMWtkWDJERmh6?=
 =?utf-8?B?VHpxUitJdGNvT3lvdTFwTWZ1Q2pNR1VnSFhiM2tlY2F5RDA4dlhPaVZQTHU4?=
 =?utf-8?B?aUw1SFBmR3JpRlA4T1p0VE9qNFlsL0dTcE9VZTZlRUY3TEdoeXd3L1ZvUkVa?=
 =?utf-8?B?aVZNM0JZWkhrdEU0ejBmMU1WOVl1Ym5wUmRLRUtUUlJKblN5WUpCZE96WC94?=
 =?utf-8?B?UXBMSi9CUlQ2U1hWdEdSdE1oRFJTa0J4b1ZJZHB2dEYzc2lTZ1FEUjRQNXZn?=
 =?utf-8?B?dk9tN01UMVFyMnRFakhmdmtobEpVLzZ0RFkwTUFiTStmN3V6NGVnYlpEWEwr?=
 =?utf-8?B?N2VpdzNla1p2cGduTTluVy8xbnFubW9VSExPQ1RjNHVTMURsK2x0MHA2ZjVQ?=
 =?utf-8?B?R2EvdU5YeDFlQkd0WjBRL1hPV1pQRC9seG8waG9pY2MwVHczRDVCbTZmR0Zv?=
 =?utf-8?B?dk1qeFhkUVhyeWVBMURlTXEwVDlyN1pjakhWSmVVejU1UVBKdG9yMlQxa2Ro?=
 =?utf-8?B?OHZrSy9VT0Q3NHFFZ1BDY1N6MnlVTVN2TGg5ZlMyemtkaEw5TmlHazlxN1hs?=
 =?utf-8?B?cmJMV0dhNHlwQ01OUjF3QWpkZjVMUWRIbXNCdkllcnhBRm5NSWRpOFdZL2hx?=
 =?utf-8?B?VlFiYmpDVk1PL2tKbWUwTWlZYnk1eVhvWmFIczNFS0xxS3hSelFBbWxiYVl0?=
 =?utf-8?B?bFZJaU5QN0wzT0J0aXR4elZuYndEOW5iVjVjdDBsU2JmZ3hIVVllTDEwcU43?=
 =?utf-8?B?OXIwdCtxMnA4REpuMURVWFlPQ08xTHNDRHdmOG10WGlHWk9ZcmZiczZBTDdv?=
 =?utf-8?B?bWgwazFtazluQ2h1YjNoSlVIZWJwZ1dHMEg5dzllZHpqdlVvVWVUMkxaTGMz?=
 =?utf-8?B?RDRMc3dGQk9kL3pQNGx5SUxMRm1KM1FWb0R0TXFRdE5aWUYvN0xYMHdES2hN?=
 =?utf-8?B?L29VMXNQT2dXNVVLaWU1cGRQdmlYeUxvWVZ1RWdNanRaekc3aFkvcmUyR1M4?=
 =?utf-8?B?ZVAzSFJuaG52c1dXM0tPSnVFaGJnRTk2OE1pR2lzK0Uzd1gxR0FsdXpDYkg5?=
 =?utf-8?B?QTlKTTMwRndtbWFxWkVYcmJpWUdLU0FrU3JRS3YzcW1TL1VtWHZqV1d2V2h4?=
 =?utf-8?B?cjUvL1lXVVU3bkRjRkFSVWxEd2VxVFMvbGd3azExWHEreXNObE5SRU0rZ242?=
 =?utf-8?B?WnI0WkN3cnRpT0prWVhuU0U4aGVEY3RrUUxXend0TnEvandTWjlvUEcwemVP?=
 =?utf-8?B?cFROOVArRzQvdDVVemlyUkFKWURIR3VETG1RZ3lsaWZreDBqZUdta013d0ZD?=
 =?utf-8?B?MGxmc1VwSzlZNmVvNTlFbWRGckI5VUtjcmZBTnl5TmIrTldzN3lkVTlUWFI2?=
 =?utf-8?B?aHU4RWt4YTllVnpvQ2hzQi8wY1FBRDY4alpJRVNHNnRXZm5Xb0JxTkJ0d2dI?=
 =?utf-8?B?aHhuT1hRemI2bWpZdzBnSzVIc2tVU1BSVTZ5K09vaUk3OG1naHF1cGhBc25E?=
 =?utf-8?B?SUVGRzBTNHExeVdUZDcxS084RG14ektyS2xJcTlDU09DTDJ2eTdlV3F1eE9X?=
 =?utf-8?B?RE5DRHpPS2c2QWVFRjNHVEd2M2oxTSt4Q3RsanJLTnFLWlRwaFdJYXVZQlFZ?=
 =?utf-8?B?eno2bDR3TTlQZGdjYklFTW8vYmlsMG5QTmVNWGExNktmYTErTWZsV1gwVTNS?=
 =?utf-8?B?eVllUWNta21BeU1qTkg2TUJHVmNZQU9HdHYyVEtZaGxheDVBanAvQVJ4SXA1?=
 =?utf-8?Q?7VDNLmWej2eCqXuXA2ygYBg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Vs97DEhN+TbRqHLuWDuQOlCzhnKcy/xj4/dZiI8uxRjHqJx2z7U7yQxI2gOxGdU+IUfKT9xlEaJkPkTbPDtT3ieVhU0j4V2NyifSA9xL1gLEGt2ix4dPawXSFvtPs+XXodr77BRz5Nkrdo2/xwSra073C3HB6O7Do9gPUkZvjjZWuXQRYZKZcmNw+Wlgizjr8QOmMgyUeGUksdr3mCIZDx8ukrXqaSswCcqQ2SRz7JnCACKitJdzW4plZrD8C1d1Wn7Y2cAI6LZTZY4Gna9AGP2MXsRccbHxmE7hyROfMixhZYrBshZVHgVUDdQbAfQVHGgqDpqjl8cCXETGurPWYNPNTPDkRrAuJOZ+bqyfyaUwCw7NCf17mvX9WFz3sWDPKploGTwQFa0s59yyyRn1FPErDV2wevrP9Vp2XsUpdAMXRx4cSkQYJ0nfFfUWHUqSIbcG1fc92dq59BaOAl7FIqedk6rLtK1v7MMmd6NlRgrdKQOzTrOtGFV1yqtUh4sCa8kSiflsDX1ZfYcHtQoAKghCzyFmo5TxrZbxAlzbMeJf4GCOulzD4EOvZNbGhg4nOxuydXgpDL8WcOLFnMljpTTR6M5ppmQ+nf6nkw0I0hg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32470946-9754-4dff-3aab-08dc64411ef8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 09:30:03.7237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxvXNXfQJZxMrWkroGv/5Ges20j93Ha+SERHecZG+LluqVRTQqVzJGmnWUtvv9bruqOBGsL34eS+BGQW8GcXQGORE+FISHPMG2vvTrnTY7dfXxchftuIq96IT3ICuzCU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6518
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_07,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240040
X-Proofpoint-GUID: LfC3cxizE5u0MecbjSJld7ABKpM-Dp1Q
X-Proofpoint-ORIG-GUID: LfC3cxizE5u0MecbjSJld7ABKpM-Dp1Q

Hi Greg,

On 24/04/24 03:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.29 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit


> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.29-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 


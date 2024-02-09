Return-Path: <linux-kernel+bounces-59488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A338484F7DD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00EC3B2589E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23726BFA1;
	Fri,  9 Feb 2024 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eqXiVzm0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="djY5z0Z8"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9EC6A017;
	Fri,  9 Feb 2024 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707490077; cv=fail; b=ITPqZa3WB75qNKz28gM303O0nxgtNx1CFCDPzWPZi3pZCFL5IIf8SY41d9I+8QCFZ0PpTSWoZFa8GlCaq6Nsx5cfxXgr3ubByARo524QN0egHEyQkfLnvpGMkNwvxzurxKCTnc/wuTO1gELstEA+w0yFB8nh1uVrjU3iakPKQvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707490077; c=relaxed/simple;
	bh=XBQ5fk5zGbqSm0slOSL4ZKYwqi2sOKsuz2sOPTaWZts=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iyQFM3Zk39MeBQN49W6LNZt2+QepN3Qp3p6gyjV6iYVQprQZmQvyXVfwhF4waBLMrqw7Hu9v2vLwyLN8WyVpky85vu1j22mB+6lYfyWST0/WZj8nr3BopmDnBTzKap147UtvCvP3xFw6mt6uWJ9RxiHdzXqO26GymIy1TACxZ2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eqXiVzm0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=djY5z0Z8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 419E2wM5018872;
	Fri, 9 Feb 2024 14:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=F+xO/9aXA5rIwaEJDk0u5i6EiNTRdBPY/KrK8uSMqqU=;
 b=eqXiVzm079/cTtmujOSV3BXb29fTWP2gObt0RfABQnUupO0iGkgl588lSuULpoFjEKut
 NZaDbB1CFR7iV/u91bEfvX9PS8Wf1qJjnqkBWCEkx7ncw2KXIckg4RqCJm6WxJVjJIdR
 A8qKQkk2ygEfrdgdN627LFF4wbt1ujSucmXe2AvZ1ohYxNBXUvA6+vLgfhx3aHWNB/mt
 HMGwuVKi9tMVA7hsVsE1UEYIOREMU4NSqMoXZNkCRsXvaXk9S5H6QdExm/vkkHBkjzR6
 aa7Rl7x2GKW6K4FIFJaYFjuF02UDD/cuoZOlAMlxE96rRqatl/MZJeWLe8luojNsBnZ6 +g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1e1vffey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 14:47:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 419EDgJS038688;
	Fri, 9 Feb 2024 14:47:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxc20w6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 14:47:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZXUXfJY9BriBu9FztlR7wzRR3v1uUCktU7C13G0LRsa8cH3U2ceHsNgcjxOk2/0eQCL2N/y7tgBkLGNHewyu65yAs54RPGowrYgxLtLtpvxE5unwI+o15tSCvsuX+p/hQ3Jo5WBnSRAjY6ZnMIgcPxLiJg4sumLFx7/VEPi+XAArtWkBMqSVcJsEudEad+VI6TrNfZ3TjwuiacJdZwMQGzf4pDW/13UIarsSmWhhkPIl8ik6Jv7UMaoxue0aC0kcGY13j31+zcev5c18/vqN2jFA3AB3gOxLih9HD12ApXi7oXR/d8qv41oeaflnL69tIpheIetV19mj3NGFsGKAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+xO/9aXA5rIwaEJDk0u5i6EiNTRdBPY/KrK8uSMqqU=;
 b=MB+QsIKIPPKStIbVkTp+p2IqjzLFfRoj+iMZgBLoRNx5c7RvI5hJK/yPPwlm2K8CCDcFccVAGXdFt8o9CI8WPGzOecZzlfKohM+clDwV1twwHCgce7u0VhF6dIrdCqdpQt/kps4yhCqPwQOXgggZTfuureoBD+yt5S8lHGXcwYJM+RzVcOXo34lPKE5vfx4TsxV+CYCQFx9Db9N+n467FfiErkKzOrXzBFSfMY7XY0wuqHBPhjSsykUCRklCt/ck39QgDmZf7l9Bavwge7ewr0gLZ0lwR1FgEbW2HM2dzV5rsHdBKhVb2s/FrTj3IvEIToy4j9VCu2xETQCAgJQMPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+xO/9aXA5rIwaEJDk0u5i6EiNTRdBPY/KrK8uSMqqU=;
 b=djY5z0Z8GjuGwqraTmODHi/JIknpWx5X0fVf/gONqUm9qeCksd33PSplihP6S8YyQlV7/EnJC1WhMdbEVPELZF+x3FpcVjEYI8/+aI2hNLJqVp38yL75DGTAJRaRVicm2FQcSfY7wgk24Fv8oXvhLZtturzWw+GY/8du/pee2Gw=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by CH3PR10MB7283.namprd10.prod.outlook.com (2603:10b6:610:12f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37; Fri, 9 Feb
 2024 14:47:22 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::6e32:a89a:f2b6:864b]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::6e32:a89a:f2b6:864b%2]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 14:47:22 +0000
Message-ID: <2d3359b3-f124-4ddc-97e0-cd56d0e7b966@oracle.com>
Date: Fri, 9 Feb 2024 15:47:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Documentation: Document each netlink family
Content-Language: en-US
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Breno Leitao <leitao@debian.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, kuba@kernel.org,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        pabeni@redhat.com, edumazet@google.com
References: <20231121114831.3033560-1-leitao@debian.org>
 <874jevjgvo.fsf@intel.com> <87jznqewa7.fsf@meer.lwn.net>
 <ZbkebMW+xLqNhsoB@gmail.com>
 <63304f6a-d26f-414a-8c92-14d740774379@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <63304f6a-d26f-414a-8c92-14d740774379@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0140.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1a::32) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|CH3PR10MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c23df6-75f9-4f95-7d08-08dc297e05bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8c5FVLHJkXby3L/PbdkNKjM0/fKTuy6qhibXzHAD+P70XHdshgI84QvhrxjSwrdSwzijt9WFOHRFjO/DDPko55/n8WGOBBt+2+vt11466pJOlNFDPr1nDy4D5RNVV2tAjej2cxQNN9Ozl6e7JdOboWYDE1NnWCNrL4u9/tqxoDJuGcdThNhPO/bvuTig6ZYtbZXQ9yUh6rNfOSeMnywywvXnbNhVt3vovTfGhrtR1L/soUvs7jlY1QF/1wWTjCSPn+FTgRsNh6tSJ9AQuS18ZSF121CumygrRkDPXVp2wuhuIgCsqthYYaIOzZKjheRwmz4/dsh6EAR/Y8r/1zzMT+3GQZkZnNllVgL1RsZLb5+3/wDjoqoOurK1/lnX+kj/VMc/99wLFCsoIKSvRE8Ixh5b6hVkaTGc8l2YJ/tc4cGgdjZxhmSe1TjKSSM6yJQtH0Mgn97DufrwTLetneNkb2akHJ3ey4F7rf27PWnQHag9pEtdbSrZR3AWMSpDvS+F8eIx8um+zjjjz4HjtD0oV1QKyiy72bv6RZ28aN8e4EPRgyPnBlo9ZVpm80cmNA/zVPD2KD0aTO8ELecwW0Cjww==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(41300700001)(478600001)(36756003)(6506007)(6666004)(66556008)(53546011)(66946007)(54906003)(966005)(8676002)(66476007)(6512007)(110136005)(8936002)(4326008)(316002)(26005)(2616005)(38100700002)(83380400001)(86362001)(6486002)(5660300002)(2906002)(44832011)(7416002)(31696002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UGFham1HZE5WVmU5Y1JIUWQ2VTRJM043ZW8zSEhwQkdSLytpN2JSRERvZEVZ?=
 =?utf-8?B?NHdqRU5JWUJFS1M1NEh5VE1BcW1KUWNVVlBnRk9sR0hrcmZrdE5CNnNMZFU5?=
 =?utf-8?B?VzBXU1hwM0UwQWFaZVp5Q2dPQk4yRmhJVXNuSTc1QVhtZ1ZPQkdwL1d1bXk3?=
 =?utf-8?B?anQzWFRFVWtoZWpBZHFJMk9iZll0eGk3bnV6K3JwV2VlemFFeXZIaEF3OVQy?=
 =?utf-8?B?ZVZ3UGdERTYvNHowUFM4MytHQzNUNlB5Vit4eDViaEI0OFJEOHpaZks3MFVN?=
 =?utf-8?B?c3RvcTRrdHUzZ2RJOWQ4dFJISUlSdFkzeVdIRzBucS9kaG5nbXZFNmo2MWo3?=
 =?utf-8?B?Z2lUb0VwQXVSZ1dkSjZlMmFqTXhwdERDRXpSMStIZlg1cWFtcUJrNlNOSmV6?=
 =?utf-8?B?MTM2SmkwL1VOTHR1aWxqdmFKejBYSjBRYW56UnVoVzd5ZUExYzB0alg3Rk1V?=
 =?utf-8?B?S3lFVHpXWG9heTZRaTkxSEtwQytTVzBvdUhaTjQ0Mk43MHhpN2ZDc1NDY2Y2?=
 =?utf-8?B?VHdpTEhTYURyR1ZDd1kvci92WlJSWnh5UWN1NlJRNHdBOFlKMFhvRzVrRFBy?=
 =?utf-8?B?R3F6bFByTXBrbVFvR0xBZnpqNS8rc3IrSHVDU1BqbGJUY1FBM1RvN1RueU9B?=
 =?utf-8?B?eDRiajNSc1J4TEtJNmJ3elhWeXhBb3hhU290ZnNNWjVBQ2xqQkFCTlFiUTFX?=
 =?utf-8?B?UXExUEJxUEdYaElCWVpLcitBZjgxeVdGSEpFWnh2S0pXcnpOV2ljRmFBMDR0?=
 =?utf-8?B?RGRvNDUxSmVhR2s0SHdiLzdKWVRQVUJJV0NMdUd2MmJlR2tjRHhab2pGUEN3?=
 =?utf-8?B?ZVJhU2F5SVB2Y2x2L1NDRHRDMjl4SFVRb1R3Uk1aNytKL1lHZnhxOHYvRGhp?=
 =?utf-8?B?ZWU3cUo5UWsvMXExUUFmZTBnbWQycEV0bURmOVFOT1IvWG9ucm1kVGdNdG5L?=
 =?utf-8?B?VHhjcXhmcGRmaUd6aTNGMXpnYy94QWVhMFRBdEd2OHZ3NS9FM0xnRDc2NUpi?=
 =?utf-8?B?STVvZksveGRPb1VFamFKRG9DNkFYNFVlSlAwUjBFcEhGaTNSY2w3RDBoN2s1?=
 =?utf-8?B?WDJpa3lZTWpZbWdFL3BGRWVWUlYybG9EU0V1STNIUVN0UDI0R2F1eE5WQmx6?=
 =?utf-8?B?MmVra0h3Z2EwSG9KajlaZVRsVStmaHZZNXFhQWVIT2pQcVZ6dHJEUFhoc09I?=
 =?utf-8?B?cm1zbjk4OGNmMWZ2YmN5NG8vYUxtRUN3dmtoUzlFUFh3T0NWQWhjeEZZdDF6?=
 =?utf-8?B?QnVaRGtCVm1tM0lwVzAwUDVOM2hkdFA3UXZ6ZHFCMWU2c1hMVVp2UzNvWmNS?=
 =?utf-8?B?Mnpqd0hNK2NVb0pFelFTd1VnNjV3OEJNQmJrbDA0VHdQc21NMXJlNHpHZ1Zv?=
 =?utf-8?B?emcrM1BnSGEvZUo0WjMrcjZsWEdnZzZzN1UrS09lT0xPNlEwYlUycEV6cDg4?=
 =?utf-8?B?SWx5ckxYY3RMakttRk9lN0UrZTg1dmxSdTJrMC9UNlprY1paZ2dZU3ZGTVM3?=
 =?utf-8?B?YmVBUUo5MDhUbFJYSzFRRGtOa2xwNXZrUlJHdjAybW9rbnpJYVZBdFlEYWZk?=
 =?utf-8?B?SEZ6NUhGZVIzdEVFbjA1bnRWNkQzYlVMMGVadSs5ZWFlNGVMVVNLQ0hybWVX?=
 =?utf-8?B?blFZTjQvL0FDRUdKOERNM0RWbmR4VmhSV2trODkxS2VoS1dhSVRzcWJEMUNl?=
 =?utf-8?B?QldxbnlTLzB0VmVucWgrNEZQVXUwWGdicU56dUFBaTYwbjRVL3VxL1kxTHla?=
 =?utf-8?B?Uld5SVRqOXhuSFlRR3RJVGNGM0JzRjVCR0prNTI1RlJoVlNZQmZZeVlNV1M2?=
 =?utf-8?B?djRyRHhnd2I2RlJFNmo3azhWTHVhU0hseGdxWU96VVBxWmNqN0M2OUgzU1pL?=
 =?utf-8?B?UDFYeFkzMGZiWHA3cElLSWV1T3I1M2swN0NST0xTbFptMVk5WjE0SWsxa1dC?=
 =?utf-8?B?Q3NXU3Z4VldSV1EyRm1qcVFHZ3l5bDlqbXk1R0ZzS095YWxrcnBWM2ZiazZm?=
 =?utf-8?B?aHNmTjByb3dDbWdidzJvYVQ0am1VbUJmTGVOQXUwNllFMGFlNExzSXQ4NHJq?=
 =?utf-8?B?Nm5memx3U1VYZTJGczFORWF1bnpGcHhJWlluc2lDTmUrNEZnNlAzRTRSZHJ3?=
 =?utf-8?B?VDVmbEF0dUtmT093ZXI3M3k2VVdqdy9FRFRBMUx1VnZpdmtOTEZuRDFBWVFu?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4cNLusjAeYzWFAO+f2DTeqvdrw56XmsSm6/LA/CPp8WhT/dt2PTf89EOUtL1Hf9oSnxeyIqcfg/aZGlkysQAVwAKnjRlLmbeTTdNCIdVUL3xqFR432wGvudX/WUCijBOLkoHe64UcQyJuYPZEWrbX3+0ScVjeCPt6hQ1FUA93/CYMS0X7td5CKkA4Nz3J/9vRwwCIJq52TPn7IZYDApkTjXBwqeOIdrZwBDrX+NlNG7+OI+1mDjPocCedOyfYU5EsCvhn/ggOkxOBssMWu3Tnj25md3wKjCxfwuPwq/kkY9ZQMqpvISUu6rScOLd3dt2T3x1S1G0VQeVoGul0/Y22/+WxrJGPw5HLaggHVKE847UYULjk9vMImYcgIhiv4j+S2OGac43nvm5luqb54P6DmoEnmsJf9mVA1os9KHNEKgo2p6MUeFv5UAVTXji10YwSAjlU4wwkAYxYM2sV5SVp0LEL//CMKoogKKekalxRsX4qMb0pOnbdW6a8u2Iwk5LsrpXVDGp09VCezD6mHrXwTwtXRo5hiseQtkHUgWTIG0gP5an/199Hp92O181KUL8MABZjvBQJcNIp1lxJp5BRQepmI5/SLTL2i6hHTUtgMw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c23df6-75f9-4f95-7d08-08dc297e05bf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 14:47:21.9994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HfZ/yhczovHhDOCqv1tEBijlzIfWEzHiEnLRO8nL7CLMSRwogL8UD5XPuXyOxGBHQWl5C0RVuHpkedCppTTmaDzcheLq75ppeJ8Md2OJDy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7283
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_12,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=739 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402090108
X-Proofpoint-GUID: mwArZ7_-Hf5wTi77IoDoSJJm2YwiMa8Z
X-Proofpoint-ORIG-GUID: mwArZ7_-Hf5wTi77IoDoSJJm2YwiMa8Z


On 30/01/2024 17:23, Vegard Nossum wrote:
> We should still fix the writing of .rst to $(srctree), though -- our
> use of parse-headers.pl seems to sidestep this by writing the 
> intermediate .rst output to Documentation/output/, I'll have to look
> a bit more closely.

I have now spent quite a bit of time investigating this.

The main result is that Sphinx really does NOT like it when documents
are located outside of the source root.

What makes the parse-headers.pl approach work is the 'kernel-include'
custom directive (from kernel_include.py) -- this allows you to include
files from outside the source root into a file that _is_ in the source
root. So the .rst files generated by parse-headers.pl are included using
this directive, rather than being treated as real documents that you can
refer to by their name.

If we did the same, one option would be to create one .rst file for each
yaml file currently in Documentation/netlink/specs/ and just have them
'kernel-include' the corresponding generated file. I don't think this is
a great idea because we'd always have to remember to create new files
when a corresponding .yaml file is added -- and it feels like an ugly
workaround since each file would just be a single line including the
generated file.

Sphinx 7.2.0 introduces a mapping of document names (like
"networking/index") to paths, and it looks doable to write an extension
that would discover additional .rst files from outside the source path
to process. But before this there is essentially no way to have files
outside the source root appear in the toctree.

But I wouldn't like to bump the minimum required version from 2.4 to 7.2
either. Also, the extension wouldn't be using a public/standard API so
it would essentially be unsupported and could break again at any time.
It might not even be possible at all even today.

Another idea would be to have another layer of directories in the output
directory, so e.g.:

   $(BUILDDIR)/Documentation -> $(srctree)/Documentation (symlink)
   $(BUILDDIR)/generated/...

Of course this would break ALL the web links like

   https://docs.kernel.org/process/stable-kernel-rules.html

since it would now be

   https://docs.kernel.org/Documentation/process/stable-kernel-rules.html

so I consider this a no-go as well. (We could consider creating N
symlinks instead; one for each directory under Documentation/ -- but
this again goes well into hacky territory IMHO.)

As far as I can tell, the most viable remaining option is to use a true
Sphinx extension that defines a new directive (that points directly to a
YAML file) and never write out the .rst to a file.

I think this was Jani's preferred solution as well.

Jon, Breno -- what do you think?


Vegard


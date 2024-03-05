Return-Path: <linux-kernel+bounces-92310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A1B871E3B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C185284137
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE3558224;
	Tue,  5 Mar 2024 11:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="REW//fGL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HqJQ/iCv"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA5E5676D;
	Tue,  5 Mar 2024 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709639178; cv=fail; b=ASfiFASax3qbSUzwvJuWByMqXSEwA7yX1tmaEMQ+GyROrQqx4lTRaYjQpimiytRg4RSCAVqH/w4T/iHiSQOpXwp0nos/KQnRmWRdcnU9+GKeRNr8p4yhj6KYj099if/Boon02LjRWqVvSTUJLjFPkuzKg2fhD/WRAbagF0STElw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709639178; c=relaxed/simple;
	bh=CMoJd2PmuwpJxfMgYT6Uj+EQF8Xht/1rf+bvBxlF+L0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=geXGmKbxHDIPiw9vhZVS+kioLVlwmqhizYaGlMF/5VWrc/yc5CjJMJp8A1PiMqCQcgajjQ3KXSqIFiuWgsDIUVCV5XfiB1w2kddezr1sMTIlT8Tm9Z0MoE4UcC+hpM2MCBs2Htyb2uE9EHU8k5MyYj9QMoWGUuQxWxHZekuRVlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=REW//fGL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HqJQ/iCv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4259hhG3008601;
	Tue, 5 Mar 2024 11:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=3RM13bYaagdbdCWxnCjSKMhtzBcDQN245QpBy29OUAs=;
 b=REW//fGLqdFaHIFar/chtoCapz51sczgVKXAHsGSTtnER+TGVLvwVY56fIEIgDaF8RG+
 dyX5z4Q8T5BO4B6VjKneo8/unoHmOMIhNnrST7N1vAuw8mKM815HQ/EgyAlcma1IH6Ms
 3xgFXessENP5U+380GhXMwRoPZ1blMO4/STSyC6imTh9rEKjbvdpq/WTemmS2F4tNwK2
 jSlHphI0us3tGVbiz1Y95uiKU4ajki2M8R84xRvKXCGKF1FiOrxfHLh0K2YFp3nQBbKL
 TWURZRaxoWHWLGlyheVnO5hLCzjsYnAxasUUQETPFpP81vWh6fllt20vsFZ1q+T8tcTV aw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv5de2dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 11:45:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 425BXPPc013789;
	Tue, 5 Mar 2024 11:45:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj7e7dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 11:45:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZCsJqmoLZvE/7urSMlUIU00eegWBHSd7zU1Z3apuFwelUPAB+eizijVnXZ9jsu9IKu5FI7lVPVvXO+M2wBiCk3qPmU6kSOTWl1zdMLfVZw1AOlm04rIgrBj4Z3cjWOrLubw36J2kYh2fXxnK/UF2WYO9xvFZQfCYOvFZqapP0JdeMjRx6AN+XKWeP4Y9/k5YaasKkqqVeXq45EyjJdsA6fMt0ZzksnMo4+mYfCS/IrRdZ07Us0bfBl0VTbl9ARgxzl5wAv5lLwGfr/KpmoMF8M6rvCO1iFdP6iTv9DDY8TVcaYPr0uygjd3n2vbldOtKWeK35aCzWvm2dpsHA2bFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RM13bYaagdbdCWxnCjSKMhtzBcDQN245QpBy29OUAs=;
 b=B8mVHyUuBGq/iRVrbApIvDdP5dwuL1pQ4LoC0r+KjLC3zCm5ey2NDxZ5uDfh4sJ+8ubepmHWnsNiUFPniUQK0EZBS7nATkp0szHm/fizoIaMCUwYHCDA9XFA0JhBYT0zTioyQwNyrBbLNpdabCmoWoAeowB6V3KpkgpdkgwSOrRBBiYMrPU7WYdWmhoAsJWwJviiU0vbUzRQQ0YuDP/fmH4Jj7Lt0moQ3XlZrxlH/MIEEbk1yWRWwP7lNjCQXHiLJ4Sl3IfOua1K2UWglx+64SEiQ1XZ6IdIBxs5EUAuWc7kEXrsPrSwerr9TSoie2s5zutqMKOwEmOLsrchTCQ93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RM13bYaagdbdCWxnCjSKMhtzBcDQN245QpBy29OUAs=;
 b=HqJQ/iCvBJJz8bOQmlA2iFLmZHjCJQ/Qe46EU3sDwfcLqYEqGLEUXYX7/UdP5SrVK61Mfl2Pz082XQHbf4W1wbgUGDpI7qKqfafNn35wun7ilckSQWhrn8s4yf4FjLzsBrYWL+Ybq51XlFuWrrb3aCH1XIOTSfXd+rmVDADVtI8=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by MW5PR10MB5808.namprd10.prod.outlook.com (2603:10b6:303:19b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 11:45:45 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7fc:f926:8937:183%6]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 11:45:45 +0000
Message-ID: <784d7766-3dbf-413e-9143-22ffed26293d@oracle.com>
Date: Tue, 5 Mar 2024 17:15:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 00/16] 4.19.309-rc1 review
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
References: <20240304211534.328737119@linuxfoundation.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240304211534.328737119@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0011.jpnprd01.prod.outlook.com (2603:1096:404::23)
 To PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|MW5PR10MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: 967daa74-84b8-42eb-07a6-08dc3d09cb2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TmthYmmUiQ0IvVv4XWU0AKPah16y2L1ODoZ5W+k+DCAA5kXUkY9LNdD6P124g0ih4HBSG7JYC47kDYuWUyBDp9lNgcwt+WOAgtf924Me9OcpLN3A3xSTkvVL1emf0Lk4+eACdiNtuPNZofBsGIgBohPm81+yNNpjKGDa5RcpZxI/fxK+FA2VSqRUY2fFYZJxsBHLH5RGCr9GKZpi3Sui7TmSrWw/MPBb9VQPOo6klb6YWlRfJAPvmEXqG/nMxPPwZ0//L4yqYT9oc03458p6LcasOZtXy+r9xeFFoavlO9qiVjSxkoSSQIQbtnCLf5DCVlnKdVO7X71Ehac8cXnnFM+T/WwYFozvOYgQofuS/3MdGWEJtuVSKx5jVBz/Gk9hUm7NFbYlMdo+IBu38q1zO/nfF1fzTUGMm6L2Fes1b3IcD+BH+t9o4Vc2M5GKOGFfRbdNQt7z5WTB5SrIVrZW26R4fp78snXHvHvtwcj4E21jUWRPL4LP0d27iQGnF+TKEuMzTceNYGFUdAKhodcszaRobQd1zV76iCejNlVUjXsq49nCmXfaDSosbsgjreYGyqZ46PPxvVx9d7uvLD1SwypOPrReY/JT9gG7EY9vpTs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aTJRTmlMcDJRZmhhejRRNjh0MnBZVXBPUnJaUll2ME5Za0xCMDlKY3c5c0FZ?=
 =?utf-8?B?eE1LcmJvNWZNTUhoaWZhdDJjM3cxQ0pzRXlBMWdUMGdta3RneFlzR2hDWlFG?=
 =?utf-8?B?UWNRMlFLcXRpRkdSNGhWZjM2RXdsaHE2OXA2WmpZdVI5NG9oV21BN2NrQ1ps?=
 =?utf-8?B?Tk93ajFTbDhrQk9iVzIzYjF5WDNEQ2tmdjdJTnFrZnBsZ1FNcWFBUjFzUU1a?=
 =?utf-8?B?TndxM0gvclQ0aWdLc1hwQlBsSTlUWXhyUStLelRURmp0d1dRSmg3cEJmRFAr?=
 =?utf-8?B?UmZCV2RPOWFZaEJWaGExN1NhRWtQNzBpclh6WUlpODUzb3J3QjV2bU9pV1Bh?=
 =?utf-8?B?NTdWbDVQZlZRQVJyRmpmdnVaWFR2L2hmbnlRbXk3eCtHQ0Q4b1BLNmZ2Z0xK?=
 =?utf-8?B?N09HU2hyVnFvc0dsQ1JvTkpTUEFPQW5sbFZYV0pDN093eGtYM0ZSUGNMZkl0?=
 =?utf-8?B?UjNpay8xVEFkbEpHc25mK0M3dmRORTRJYno5bUc3YzB3NllHRFdhaGJzamE2?=
 =?utf-8?B?Z1JDMHRybkU0QUhJVFlUWDFvSHN6bU8rVCtWRlVsVGhiMXpvOGFiOWpncCs2?=
 =?utf-8?B?UTU1LzVYQkZPNC9rMW8vZkpyYVdFYUhlN1ZlTnMxdVhwNWFLSVJrZGF5QkpY?=
 =?utf-8?B?YU9HQmFtLzlPZEZCR09yUlJRUzlUQlJvTTNObWVZUm1JWHErZHRqaXJhaFRY?=
 =?utf-8?B?MkM0Rk5FN0JDeWFTcyt5YjJyY3AzWjVYdnByUVMyNWF1aWNpTjhxSDdaS0RE?=
 =?utf-8?B?Uytqc0xUSkRhL0RvUnZMSHBFMmh1Y0pMTGRReXNmaUpTMjVLSVU5SkZiS3lm?=
 =?utf-8?B?UE1sTjdCSWU2V01QZ3BUSkNtYVJpcG5nQlU2MWVsRWNJNGp2QWYxQm4rK3E1?=
 =?utf-8?B?Z01Ec2RZVEkrSDFFdkxrT21ySzQ0RWoyK0lhcC9nVDUyREQyaDFwcmpla1ll?=
 =?utf-8?B?bGN5WDROZVBEOEhCbmRld2lWN1BFZVZ2ZUJIVFMvOU13VlgrQWVzYUhJUEtF?=
 =?utf-8?B?VUg2QnJ5a2ZuUGlkUFRqOVh3bkVsWGJvOU1HbnZJVExoWTFoWVJ2UE93Q0Yw?=
 =?utf-8?B?dkk5S0E2YTlBbXc2VHRnTEI5Mjk0ZVFiTllkZWxsNHRXYnk1WHB4blh6MDFs?=
 =?utf-8?B?NDNsYWgreDJwSW1BZlNZdXI0K2tQTDNGMHZHb0JMRG0zRm0wUTJTZTZ4alhB?=
 =?utf-8?B?aHk0eXJTdlU4ZzJBSDJHcTU3b0pVN2k1dkRLY0gzSk1kdGxXckhjQVR6YUZl?=
 =?utf-8?B?UVEvVk9LOHJwc1FFMDNWNWVXV2F2ZkxqK3Q3TG4wVjhkbElhTEdTVkYvTGZU?=
 =?utf-8?B?L0w2Q0hFQ2Q4aDJQNEJMRmx1VTQ1Z2tsMDFKNitOMnI1U1d0cUNiYlFSSkJF?=
 =?utf-8?B?ZmdFaDBoWlZ6VWlnSTJnaVh3RGZvQUNlZ1ZnWk1mK2NjNW81MlpvMXhkQnVC?=
 =?utf-8?B?eW01UmxhL0k2WnFxaDdNL3ArejJGK1NvSUhjYUcwQUZWYzRjQUV2QWFldU8r?=
 =?utf-8?B?UHVmRVlXRkQwTHRoMzRHT2FDdmd1WnRGTGtiTUVXSDVFWDhSajVCZzNtUy9y?=
 =?utf-8?B?cUpFdTd1Z0l2aDByZkxzMVZmK1VzbjV5QTJEQTFpaHRXWVFlVnJzb0VQQU1s?=
 =?utf-8?B?ZXM4Vzh0RU1WWFREa3MzdHNCbkNzaEN5OUlOWXZ0YnJyZXZQenI4RzM4RDVJ?=
 =?utf-8?B?S2JDR0svTDUxQ2I2ZEFPcDJjYXI5VUEwd2UxcEpZK2FWaDFKUnc5Y3BxbkJD?=
 =?utf-8?B?TzdRM3dwTkM3ZzFvNU1UMEc3YmNFcW9pSzF2U3VoS1RJTGpJY0lsbEdxTUlC?=
 =?utf-8?B?M3BtTWtkdnNSVEFMV1dVZUFqRjlnTUJ6dzlsemZadVNheDB2VUZFNUNXTkJw?=
 =?utf-8?B?RnpvMkZJMXM5RkNoZXRTcmhPMDZONmozMkhWUVFjYTBicEg3SzIyWERNTFpm?=
 =?utf-8?B?eFpicEsrb2lhUk93djBTL1hCOTQvazlIeDBXNDdidHRCWEZRcUdOR3YweGdi?=
 =?utf-8?B?N20zQTJxTFNzVm1KZjRwRFUvTGN6aHZNdERoU1J5dW1GZ2pkakozWFRpQ2gx?=
 =?utf-8?B?V2xyeDQ1MisxL3pMTEpMbGJYcmJuNXJUOVNEaXFWaDQwaVl1andIMkpJK2lz?=
 =?utf-8?B?aWVvTmVGaXVGSDE1aUdJV0VmR3pMQ0U2RzloZGJlUkZmcFpzeS83QTY4c2VR?=
 =?utf-8?Q?acLPtlVKgrmJbpenxJQmlYY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	M3KwtYClu6Ypq8jAvwJ1RbyCw71fTAGQEeNkWSBqFqemXN/HBjYu8p2LWYCHWN37EOaK6AIqzdNMsIK9e9noJJdFX0h3rhJC+tqLlnZVnTrLS7D4gZkbk5mHfemB52khSKIJAZDluOPc11Vqz4nC19zBL+Izm3JfGl/i54+9PUoSPG9w1yW/37PT2mTWd9qNh6Vm0QiIVso0F1NDCiupXpIpdK+cr/q2WAOWzS9jLYev+gIqalt3hkz9LwJRJYfBdopofNvE+mMaMWcdjjttuNglzPSPBY8kXSBDvIV8c06ZL3ZUc/P9huhENsvjvkPs73oLugUG4BkJwZs0u/51DVbNIOFiHg+bzOHi0zisHxZIApYLG4LCiFU43IeXdQuk5dMnZgw+ziNLRrSk4ep1UdGKRP4QpctoXgvq6C79mlnB3N5JK0oL6jVGZonKh3rsIG9Qvm/yfKENZtCglPmja9Z3vVo91ZnS1XD02sOcRYIAuNZxsybLeCDpXDE7gdRtLGM3gSPq0F7xfc8wnTeh+02ocKRYwOEIhB2zlD7XuPVHbHE3CELXSONcWIqWQAYwWreTNY3wW2l5JOqtN+KAFTPGJMEe1Hk5QhSGAMaw/Ls=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967daa74-84b8-42eb-07a6-08dc3d09cb2f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 11:45:45.4762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ElsTMyl2zpA920CUT5DOz3ZI2YK8BlaFzixri4xE8DeJNYvjPUlnyEXaOmSFKYxx02A2LpQBDwGP8xsn5fgkVP9r84JbTjkR0TuUo05bmHuCsvbtimdQ6YSVe+g8CKCg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_08,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403050094
X-Proofpoint-GUID: v28vMrNRz00tqDsmP80tebLIIUX6tpvM
X-Proofpoint-ORIG-GUID: v28vMrNRz00tqDsmP80tebLIIUX6tpvM

Hi Greg,


On 05/03/24 02:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.309 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
> 

Built and boot tested on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.309-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 


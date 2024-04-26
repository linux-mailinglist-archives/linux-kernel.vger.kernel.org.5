Return-Path: <linux-kernel+bounces-160641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6388B4083
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2AD1C2284D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863F93BBDE;
	Fri, 26 Apr 2024 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ahxJQNs9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yzlUQejL"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C6A3BBCA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161218; cv=fail; b=FIDxMwTIaLmGbx3QHryCq/1mhh4nH12Xy/rtxZVz3yX3SHrPkes16lq/af6TuE3g4d3zH2MFmklMu7cudHPrCSMjOkNXRYtWhDWJMNITdJKv19kPrK83sjbYvJpfrajxGjnx9pvWSr3cenc+LP6f3I2dtFCgSOnsAGtCgzZl6Z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161218; c=relaxed/simple;
	bh=X4AsAqFqPv8PF4zJP2xr2z+Ueu0Tb5GtVKp2tDvZtOM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a6kaKeTfestmuVFBmSm4WXaiyo2zN23gWF04DmFO7SLJUkbvJZJoxeT+YVH37vPMi4JtqDAqoqSw5DMwCgIeFFe96Z3G3U683icSFk6saGE8lhFWHO3Vy3+CgPdKfO0KTUHOTxq1/z8uOkUeqZXkpo0s8R4kYzg4DFfWh4BYJ5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ahxJQNs9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yzlUQejL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43QIXusR020148;
	Fri, 26 Apr 2024 19:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=fujZKw0n/hCiFYMnhOtLuMQyIqSE/hYsn/Mlf2HaQvQ=;
 b=ahxJQNs9PhtpoocDG2U66JZokvqXndTmJnGwM0T/7DC8ZeGSzxjrORPzkOglNnwJcqUm
 5G8TfzV8BzcRFwQtqgoFFyksA7gSUovAJoxTQ29TRNqYlkNzWiSIdtaXvivyWnN7YgOv
 +wHAz0NwdEQgto/K6WKsFvY4gpa57/3IpTMsmvmTKJF3MiDhA25lRSuaHXMuGwkRyxfO
 SZdVF1F1etRf6SSvDtJkdo65XxexoK28GQRSuG3tBrXxbGsKFog2O2aO4buj+ABcv4md
 671ptywidsdlhTtHE2HyemMYb6mhWqlYJSEGLT4C/XObMxmGII09bg3Sbx5pQwz+XyYs iA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5aux5q3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 19:53:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43QJkhis006273;
	Fri, 26 Apr 2024 19:53:09 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45c46tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 19:53:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgXzbLU8oU5/1yegyp/uDMWS92TOqWS+7rZZ1hI5lvmaR3ajwwEYUaGmoATbskaDNyjWD0wYl0uvoXbONi0fJfe6JMHfvcFS8zU6iortMSVq9tVZoLx6xVfiV6DyDof/rUWL7AzM2nwTyO06UmIMkvSZp5L6OTD2Lr1QNPOvvpdXt/H8Z2Qm+DKYT9skai97j6DSiE8CxcG6QCzDWw4oy4P6R6fSYslpl3IDcc/QqkHlF+sXChZsG0NhtAK9RGd4a6rG2TRmPBGuj/EgL1ahdM/W+QhiR2F/xHcv6+4NaE+i4hsu072WtaOnw5HBOWiEZ09D3VzQ1Mv7/6kpVQVksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fujZKw0n/hCiFYMnhOtLuMQyIqSE/hYsn/Mlf2HaQvQ=;
 b=V0Vor2wnF8IDOTHePD+XwqllBxsPRX4p15GmqhsvPcoYCCIWLjfp1+ak2ESCWiDhf6z+DqoIAaAHCn2oEKCbSfHx/28I+GInygQQwzTBC2f7aJc45FegUsqMDcVAYyR9DYZ6suxSxD9uFAxbsrM2AgW0hgOt8Xc6/fKD5wC3oQjmuDNKgoCRr8XJR3LQ61j8adofZTDM/liEaSdmJPWP18o0KVE3Hmsf9c2EC67i7S2NOZy4iDVt7cjFeqe/8ppOtEnHFkTxiG+d7u+505ifumhNJuQEZ2H/dQ+K43U6w7x6GG0A/3G5mW6/1Tm7z/61J5xNnjEcJfIitMjYsB0bnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fujZKw0n/hCiFYMnhOtLuMQyIqSE/hYsn/Mlf2HaQvQ=;
 b=yzlUQejLZonhxnaH896PrQfsteHbVo7PADsJtBNEUtImp9yKtSrR3kek3jEcJSJKOBQqvNW7DPiMxSLImSXULnxS/obZ9tn3HyM89/RZQ44RRKOts+fmEBVe9vT8co8TeIXjcodVHHGbViCzV+42OMH9KgM2EgS/1501TaB5oZc=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CYYPR10MB7565.namprd10.prod.outlook.com (2603:10b6:930:bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.49; Fri, 26 Apr
 2024 19:53:07 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::f5b:648d:5d73:dd03]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::f5b:648d:5d73:dd03%7]) with mapi id 15.20.7519.023; Fri, 26 Apr 2024
 19:53:07 +0000
Message-ID: <47614f5d-0942-4b2c-a51a-451f6bc9c802@oracle.com>
Date: Fri, 26 Apr 2024 12:52:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory-failure: remove shake_page()
To: Matthew Wilcox <willy@infradead.org>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, linmiaohe@huawei.com,
        nao.horiguchi@gmail.com, osalvador@suse.de
References: <20240426171511.122887-1-sidhartha.kumar@oracle.com>
 <ZivlrMAwRI6xJhc-@casper.infradead.org>
 <d05cbf22-f3e8-414a-a2e3-03e0b857eaca@oracle.com>
 <ZivyC3vqa2BIBoMj@casper.infradead.org>
 <c40cfd0b-f045-4887-a955-fee7e0392cf1@oracle.com>
 <Ziv67sGBi02YCYZ5@casper.infradead.org>
Content-Language: en-US
From: Jane Chu <jane.chu@oracle.com>
In-Reply-To: <Ziv67sGBi02YCYZ5@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0137.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::15) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|CYYPR10MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cd41a01-43e2-493f-41a5-08dc662a7e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dCtvMjM0Vm1zaXFMMTBPZlEwR1BuRU9pelFLWW1FOGtRc1FPZk9BK2lNV0hV?=
 =?utf-8?B?RnhDeWJBM1Iza21QSDkvc3FaUzdqamUwQmEycHNXc01Sai9hYVIrMi9LZjEv?=
 =?utf-8?B?bzM1cEpPRE1xQWVpSWVraU83S0taTTBMaUVkS2U0Slp5VGJDN2JwaFhqQ0Nk?=
 =?utf-8?B?dWpKdDI4ZGlHMm8wVm0yQnkzRU5mclllYWFlWUJPaGFud2NiSkJvV3V6M1Zk?=
 =?utf-8?B?SUc1R3VZc0xvMlkzQmR3c2tlUTRMdE9DaitXOVREYVFiWUJQeGxiaXFqMmRy?=
 =?utf-8?B?WFU2MGlZV2paUytCbmNRQmtXSnA2Z3BkSEhmZ0xtbUt1VFpEMG4xa2lJQTdQ?=
 =?utf-8?B?UjkxTjdmbGc2Q2lvMnJLL28rNjZESVRuL3RScjNQTTBwSitsZW1JYnBrbXVa?=
 =?utf-8?B?R3BwaUYyLytVbFVaeFZqRVpRTDJFUGROcFJNYUNZUk5BQ25Gb2x3aGRtSUlZ?=
 =?utf-8?B?bWRIbSt3SVhTMWdLUnFsSEhUeS81bGUvZWQ1bEhWSG8xb0lkamcwbWxSYm5v?=
 =?utf-8?B?Wjl4WjJZNFBEY1RCTndYR3hWeTBOY1lNbDI0blNLdHZCdE1kUEQ2dksxRkV4?=
 =?utf-8?B?eWtpWjB1QTRhUDBWTHl4YVhiTndKcVlXU01ETlprUEpRYVFtZUlxVnpzRk9z?=
 =?utf-8?B?dkJZMklDUDVRd24zNFF2Ti9URGxpYmlNSkZsYlYyU2lvM2QrMkRTWTNSUmdo?=
 =?utf-8?B?Q1AwNG1odEw4UDRDYWlnQWdWd3VZbzVYYlV5WE1hQkZ4NDRWTTVZVEtQZE1L?=
 =?utf-8?B?QTZkamtPWkZEQWtHUWkyOFhLaGdPVVBBN1FnTHVsbWdSOFNoQ25DdmIrd2Jo?=
 =?utf-8?B?OUZNbzhmTk9ISTNNVkNxbnBOZ1FYVW44eXhPa2pZQm9GeWpNMXJPZDFWQTN6?=
 =?utf-8?B?eFFJMEdFWEFEZHdRTm9mZis2bG91Mi96TERBVE1yTGFmdjNnZU04d1QzQXBK?=
 =?utf-8?B?T0F5cWxZRnlKNWlsVldKdkZXeXBESWk5T3hmUzdHSVA5S0M2bmo2Und1NEZY?=
 =?utf-8?B?bWRFaE90aGNic0hJbS8xdjhibjdKUU9YNVNYN1BmVzE5MnJzdVpQWkJoU21V?=
 =?utf-8?B?cnZ6QUZMZC82TU9qOEFiaWdQN1pnTEFyVFlpa3kwbkFvcHgrbFN0emZ0T3dP?=
 =?utf-8?B?YU9BaGJydG1jcmZlc0tMcmNLYVNXY1Z1Uk9rQ1lwZHZLd05qcUsxL1NRWGM4?=
 =?utf-8?B?eUpLZHY2Qzl3UkpHSnIzeFRDcFhqSWFZYmtHdGM2bzVhWlJCcEVZTDB2azlF?=
 =?utf-8?B?YlY3bjZSYjFKSEpTb1IxbGtCSmV2RU5RWndubFoxb3RLRWJnb1haY0V0N2ZM?=
 =?utf-8?B?a3ZSeGp3dGVJRGprdkFJVTVFRFVYOWR3UGNUT1hNeXcxMVlsWHhaa2licllY?=
 =?utf-8?B?dGF6QjJPR2tRaVVaRlpDNkJoalJSRVJvN2NOdUM2dVI0clFPTzRGdFhsd1RN?=
 =?utf-8?B?Q000ZUR6aVU1OG5nRmZBRkc5d3BTMVl6akpONUhtOU1laWlWZ1JOeFZ4dUcx?=
 =?utf-8?B?bytrWENPOE1yeGZoR1l6SE1sUmtpclpXWnRZWlNoYUVLYURBUFhLT2ZxN1NJ?=
 =?utf-8?B?eXVRU2g5R082VThMMjRydzNqVFBIMktDTGV0bTBkbVZmT20zeGdRc3pTRlYy?=
 =?utf-8?B?U0RkOEJLM2NleDdhVmwxWldHRXUrOVE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QXh0aUxMNzFwcjBJYm1sVHRaeG8waUhoM25CeWdCZk5POUNOZVFqMWZrWEVo?=
 =?utf-8?B?Z0huZWV1dklIdmd3TXhYWGVHS3Vyak51ak84U3hkS3ZpWFpXVHI1QlFVMGIr?=
 =?utf-8?B?Wm9hTFlwS2dKekM0YzNLNVVrSzd6YUYxclFqdERrQ2N6ZXpyVy9IMUpEN0RR?=
 =?utf-8?B?RzVEMDhrdERWTFFoSitiK09UV2h5N1hIc3F1ZHEwNHFHQUR6Ty92eW13UTNM?=
 =?utf-8?B?U3pReTJrMysvSmd2V1FpT2tpOWdaelNjUGg1bzQrTE1CWlVKbjhxSndRU0pj?=
 =?utf-8?B?ZVByaWZReW1RTHE4dWJNelJ3eEl6SkovUGJ3c0F2NVZtQUFFbkhwcnJlK3JZ?=
 =?utf-8?B?Z0N4THFZRytNcWI1TE00R3Z0SkRkNWxKalRaU1l4MzgrVm1LRUI1dEc1L3M5?=
 =?utf-8?B?bHFYcm1EMXpLckJqYm41U3FzR0ZoOE1QdkV6L3ZsUlZWaVZRbzlrL3hYVm9r?=
 =?utf-8?B?RlR0NWU1RmllcmlEUUt4Rk1iSktuaGtyZTlIV3hkYXJwZnNPcStwNWM1aE5O?=
 =?utf-8?B?NlA1ME9oMSt6K0FiRWg3SXQ3MC8rQjVpUWNXS0hCWFhLdUlySjN2QkQvVkN3?=
 =?utf-8?B?cVV0SENtdGhyRXBPRjRlUFUrejAwbEJrZUlxTldFQlExaUtMU0wyWkNMcHpM?=
 =?utf-8?B?aFdBVDZGTllQMkw4QmpVS0FaVW8zdDhuZVowVGVQQzhCK3JOUmVraDZSQkEx?=
 =?utf-8?B?ZUhhc2poTmg1MDllTHBYS3Z0SnZBWktXS2VLdUg2N1Z1VGlwbjlkdllpamh4?=
 =?utf-8?B?VnNEVXVqWkJoYzNKUkFPVVFxTFNQbEhKSG56Z0QvNkorbEU1QUtGRTZvdTNI?=
 =?utf-8?B?OVhwcmM3ck9ONkpUcUtVend2QU9GWlVzZWtFTVdEYjk4QUV5Sjl5d3UrSDJ0?=
 =?utf-8?B?cjk0eUZhcXA3SFB4ME5PNEVJenFucG50am45Z2NmTXlBb0k3TXBmY2E4Sll4?=
 =?utf-8?B?RDBORHJZS2dPcGx1T0ZvM2E5dk9FVUJnUWZlaTc4NmpJRDNmWk1abHFZT0tm?=
 =?utf-8?B?YVpPbGpsT2h3S0ZwMkV5V25oaU05RktoeTZ1YStpdkNFU1dvOUNPdmc0MmlN?=
 =?utf-8?B?bnI1TFZseFBSb1l1T0dkeFV0QldFUEt1eTBsRWhPc1lLTzkrUUt2MVllalFt?=
 =?utf-8?B?cit2YU5BZURoNmtNRlZyMVYxalQxODFXci8zS1pQUWdjd3A5bGtBWTY5TFpZ?=
 =?utf-8?B?VEphUkY0Y2IzTFBBaW13cllUYVVWRDFOWnI3bW5DU2RRU1h4cmc1ZVZoZ09L?=
 =?utf-8?B?aEdzc0FUcEkvRW9xekFBZloyb2ZmWWozUlUwVlkyay9XQmV4RFJvaFRrdzNF?=
 =?utf-8?B?UHNYb0F6cC9XNkxaOWlIYmVUa2ttR2tiUStocmJ2QkZSUU5nbENJQUEyOVQw?=
 =?utf-8?B?aUc2cTRkYjZnSlg4azk5ZTRpcmRzemNqYUZvbGRLT2xCc3BZdHJSRlN5VVdH?=
 =?utf-8?B?dG9VTExFVDJaZ0NTVmVaSkZnTHZIaG9wR3ZDcTR0dDB2aUw5NkloT2RQdS9p?=
 =?utf-8?B?bUxFQ0dLQ2NIaUl3TCtFZUdQT1hXSmJVTHFlV3V1WGZlRjlRdlR0dWZVTHEw?=
 =?utf-8?B?WGhDakozZzhEMXlZdjNtdDgwekwvZ2tIcUNUa2VPMmxqc2RrbHI0MGFhWmZS?=
 =?utf-8?B?eEVmc1EvcEhHcmlOTWtEMjlHS2twaE54Q2xOamtRenZzSVVPcnF2cVNYQVFq?=
 =?utf-8?B?N1VXdG1YUXdNazJFTHpOb0o3RDdGWm9GN2N0SW5oM1pDb3YxNlFSN3g5NGdw?=
 =?utf-8?B?S0p0ZS95T2Y3bXdsd3YzSTJvREVQNXgxYUdhWkkrY2NLZE96SHpiTmVrRk1N?=
 =?utf-8?B?ZFYvRTArR2NSNHRUMG50T25XOUcvelBrN0F2QkJndVBHYlUwYUQ5THhIMVMx?=
 =?utf-8?B?VFpVRWdabWpweUcrZm4wTHlETFFEeDlTTjRJWTBLMGNQdmxISzNuQUFJbld2?=
 =?utf-8?B?cTJtNzBnRWR1a3oyM3kraHpzSXU3WVRxM3k0VWNNOU9Cc3BFSWxXeFRkdUNB?=
 =?utf-8?B?UGdRTHdwZXNocVlYVDRjQ1p6Ynh5VE5VdXZEdlF2Sk8yNVRYQWt6OG10Z1pV?=
 =?utf-8?B?SHA2anFqL2VBK0xlWTlFL0h3T3ZtTFhxUENmaUo3YWhQYzBadXhDbWgvcUMz?=
 =?utf-8?Q?cQluyVYinGwQv+Weo5c33dBWw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ITfTKQY3+QZ6MQlAaYNaozYh9vAVVPNTh4nO7onTvMUyVBk7LwCb6/bNCVON6swya0Mh9YKu29gHVutp3Hd4JsMiB1CK2g/5ZFwuL3aPn10EoU4rTv7WdVs9LFDEu/7p9An3qQ2WrWOjOgjhASQsfmGq3DsNOeIbeRwo8XehZgMevsK1q4/FGPonfgcPJ92j0Dc3KJMcxyVUzXtZoWX45cPmCdvjhWEo5K473OuWqx+kbAQaxytIKvexsV3Gvf4E8XsZejApFmgRn31HF+I4tiEII4LRMpuwsutx6BwzSZdYozd5mUQCn23MZ5RAwBT6T4romld9apJ2n51wu2MxrzWaMjCaz6CK+MtNEra+lMk3O6WC5/ma669cTD8YEdOpZi9jIufXadUcXLg3EWomOqyNyVQL/CTcMjKOcrL4gBjyFWE7edT42ua6phJsfCQssLVoaGkk9TX5ti+5+aANoBSNmcW5BzrgIbXuMn/NDL06Q3wrb9JIMRBGWorKMKMSmFt5hkgpAaVIC9Dt7w1BV5/WGsKXQVV8kthhS+FZYuGdkgfLTiy90joYkknbj0DzIwC5vIOYYEcDtgDrbwToEagBZw0SQmW4jZcoJwbfJwA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd41a01-43e2-493f-41a5-08dc662a7e40
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 19:53:07.6183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGyxYWlw3M6VQjBFASiohWGevEtX0RhPYXm/G/jTkSU2E+Q+5+BH0xls8X4aGWDaaXxNvBLuXXT4CQDHudRT9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7565
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_16,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404260136
X-Proofpoint-ORIG-GUID: 5fhhDN32QHV7h4tSYEBiyNcq6lLFfyx5
X-Proofpoint-GUID: 5fhhDN32QHV7h4tSYEBiyNcq6lLFfyx5

On 4/26/2024 12:05 PM, Matthew Wilcox wrote:

> On Fri, Apr 26, 2024 at 11:53:01AM -0700, Sidhartha Kumar wrote:
>> On 4/26/24 11:27 AM, Matthew Wilcox wrote:
>>> On Fri, Apr 26, 2024 at 10:57:31AM -0700, Sidhartha Kumar wrote:
>>>> On 4/26/24 10:34 AM, Matthew Wilcox wrote:
>>>>> On Fri, Apr 26, 2024 at 10:15:11AM -0700, Sidhartha Kumar wrote:
>>>>>> Use a folio in get_any_page() to save 5 calls to compound head and
>>>>>> convert the last user of shake_page() to shake_folio(). This allows us
>>>>>> to remove the shake_page() definition.
>>>>> So I didn't do this before because I wasn't convinced it was safe.
>>>>> We don't have a refcount on the folio, so the page might no longer
>>>>> be part of this folio by the time we get the refcount on the folio.
>>>>>
>>>>> I'd really like to see some argumentation for why this is safe.
>>>> If I moved down the folio = page_folio() line to after we verify
>>>> __get_hwpoison_page() has returned 1, which indicates the reference count
>>>> was successfully incremented via foliO_try_get(), that means the folio
>>>> conversion would happen after we have a refcount. In the case we don't call
>>>> __get_hwpoison_page(), that means the MF_COUNT_INCREASED flag is set. This
>>>> means the page has existing users so that path would be safe as well. So I
>>>> think this is safe after moving page_folio() after __get_hwpoison_page().
>>> See if you can find a hole in this chain of reasoning ...
>>>
>>> memory_failure()
>>>           p = pfn_to_online_page(pfn);
>>>           res = try_memory_failure_hugetlb(pfn, flags, &hugetlb);
>>> (not a hugetlb)
>>>           if (TestSetPageHWPoison(p)) {
>>> (not already poisoned)
>>>           if (!(flags & MF_COUNT_INCREASED)) {
>>>                   res = get_hwpoison_page(p, flags);
>>>
>>> get_hwpoison_page()
>>>                   ret = get_any_page(p, flags);
>>>
>>> get_any_page()
>>> 	folio = page_folio(page)
>> That would be unsafe, the safe way would be if we moved page_folio() after
>> the call to __get_hw_poison() in get_any_page() and there would still be one
>> remaining user of shake_page() that we can't convert. A safe version of this
>> patch would result in a removal of one use of PageHuge() and two uses of
>> put_page(), would that be worth submitting?
>>
>> get_any_page()
>> 	if(__get_hwpoison_page())
>> 		folio = page_folio() /* folio_try_get() returned 1, safe */
> I think we should convert __get_hwpoison_page() to return either the folio
> or an ERR_PTR or NULL.  Also, I think we should delete the "cannot catch
> tail" part and just loop in __get_hwpoison_page() until we do catch it.
> See try_get_folio() in mm/gup.c for inspiration (although you can't use
> it exactly because that code knows that the page is mapped into a page
> table, so has a refcount).
>
> But that's just an immediate assessment; you might find a reason that
> doesn't work.
Besides, in a possible hugetlb demote scenario, it seems to me that we 
should retry
get_hwpoison_hugetlb_folio 
<https://elixir.bootlin.com/linux/v6.9-rc5/C/ident/get_hwpoison_hugetlb_folio>() 
instead of falling thru to folio_try_get().

staticint__get_hwpoison_page 
<https://elixir.bootlin.com/linux/v6.9-rc5/C/ident/__get_hwpoison_page>(structpage 
<https://elixir.bootlin.com/linux/v6.9-rc5/C/ident/page>*page 
<https://elixir.bootlin.com/linux/v6.9-rc5/C/ident/page>,unsignedlongflags)
{
structfolio 
<https://elixir.bootlin.com/linux/v6.9-rc5/C/ident/folio>*folio 
<https://elixir.bootlin.com/linux/v6.9-rc5/C/ident/folio>=page_folio 
<https://elixir.bootlin.com/linux/v6.9-rc5/C/ident/page_folio>(page 
<https://elixir.bootlin.com/linux/v6.9-rc5/C/ident/page>);
intret=0;
bool <https://elixir.bootlin.com/linux/v6.9-rc5/C/ident/bool>hugetlb 
<https://elixir.bootlin.com/linux/v6.9-rc5/C/ident/hugetlb>=false 
<https://elixir.bootlin.com/linux/v6.9-rc5/C/ident/false>;

ret=get_hwpoison_hugetlb_folio 
<https://elixir.bootlin.com/linux/v6.9-rc5/C/ident/get_hwpoison_hugetlb_folio>(folio 
<https://elixir.bootlin.com/linux/v6.9-rc5/C/ident/folio>,&hugetlb 
<https://elixir.bootlin.com/linux/v6.9-rc5/C/ident/hugetlb>,false 
<https://elixir.bootlin.com/linux/v6.9-rc5/C/ident/false>);
if(hugetlb <https://elixir.bootlin.com/linux/v6.9-rc5/C/ident/hugetlb>){
/* Make sure hugetlb demotion did not happen from under us. */
if(folio 
<https://elixir.bootlin.com/linux/v6.9-rc5/C/ident/folio>==page_folio 
<https://elixir.bootlin.com/linux/v6.9-rc5/C/ident/page_folio>(page 
<https://elixir.bootlin.com/linux/v6.9-rc5/C/ident/page>))
returnret;
if(ret>0){   <---------  folio changes due to demote
folio_put 
<https://elixir.bootlin.com/linux/v6.9-rc5/C/ident/folio_put>(folio 
<https://elixir.bootlin.com/linux/v6.9-rc5/C/ident/folio>);
folio 
<https://elixir.bootlin.com/linux/v6.9-rc5/C/ident/folio>=page_folio 
<https://elixir.bootlin.com/linux/v6.9-rc5/C/ident/page_folio>(page 
<https://elixir.bootlin.com/linux/v6.9-rc5/C/ident/page>);


thanks,
-jane



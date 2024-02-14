Return-Path: <linux-kernel+bounces-64958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 514EF854525
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7644B1C21505
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F26134A0;
	Wed, 14 Feb 2024 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hCzTbwUN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kac8hz41"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFBE524F;
	Wed, 14 Feb 2024 09:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707902875; cv=fail; b=Bdc3bfonrHi+HrZJimj0LiDl1f0eSb852O3EEWzeY6JiV2a2zDpxeXh3v/1EFPc5OYX6TCZscVoDOcwv0uuKl3FGdOM5CWr0GWC24TjFvt7KA0UTHomrsIh0JIZfnXS1l+xj6/sbfLdQ04YjL++InBLzeKLBJdU99xojuaKQb8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707902875; c=relaxed/simple;
	bh=+JVJhUw3Dhn4TmQ1rMJ65Gjx6Ena/Jc7IWg4la3SPQE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IlKovCE+4r2vw/G/Qug8Sqprs+wakiCnHIIV6E78UcOOpOz62OWX0HYDLEXvSxi3DhVgVrHJi8DfnI033dgeuw4ifqBKsbcCdRzcNL1JXsmbeSie36JoeqiSWpe/rrit627Cbq/GhjBEVirhgifw2bVWiANB0eHuCw9eCWmhByk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hCzTbwUN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kac8hz41; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41E8iJdE005662;
	Wed, 14 Feb 2024 09:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=hTo046e2ScZaPjHPmLRPxrv9xZjQODaidv8tzZJbLRE=;
 b=hCzTbwUNZZhLBwIwDgn4WzW1upyNfmmnq6MZ2s+U51hN1ijoI8XtNCDEXlIkHBQ9i1EK
 /O511NqC/Ui944N/QATacBQt2a3LwpwnGXQvLtMr2dWu91wtei2IAHnraTeChsUnmtHl
 dVx+SUpJRtBmMOYYDWefj9i5AfvzNI+MJc/IY066jtjsRxqx9YxuTJDP1UwK+GRkpDyI
 LH3m7dnOoEemc7EwjKsXqYgTlhwBMO1ILqeGJl8NE1iBZAiLSJ/o9bQodyQEX0GlLmSI
 EYDWx5+3I5+zIlFinR+olAZDcJE9C9yxN9PGjpdheK25IywwpqqDjHaNuP8IVDNqs69I yg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8rtcg920-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 09:27:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41E8Bv6C000534;
	Wed, 14 Feb 2024 09:27:06 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk8pucr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 09:27:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdCm6u/4ShxJiI48RoKhUyFF5EjloZwpGS8sEm3kMcpk04PCub4SnfjLvjGt028AFkndrRZIbvVp335qUsdbAP3LZ4mCmMlGO5vHTQuLXCmV57a48ogITnj5TUL6xwwaiL8X6wZdTD/o0wr5nbxvMi5F6VxwdFe4avhFX5sbfIineBnYqul2INZoTUB01NjeIJatHp0AvDvTqKAiLiXSvFXE1pJTeEMXTcExD6KgGB3BJAheJeQZqXsaVni4BI8kRPQVzUNiU13/P55hN+mYPSobHflLxiiHeWDXwz+Bbxi8u/ymaCsh8eZ2LMY09zoBSembmQxOEoV83H66hUwmUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTo046e2ScZaPjHPmLRPxrv9xZjQODaidv8tzZJbLRE=;
 b=TRzze/sTJiCN2o1rqN4nPpM/C1WBA+HejQIb5zeWUbNvJBG4Jhh8TRPpRr2f47tDMvlHzHAGKA//PTCXu3OBz/17WEVSAobdVI718jxdoHwJvlbyobt2XNdYY+CUwZ6T9w4cePgBnZXSswsUSGI51XfzYWU3YOGKgj+AIOm3YnRsc2AzEgcqygQAfOuvwkO60h44MsAqjkQ2z4ek0yOoih1zCLJOkO+cr17xJnVntsL1G8K/jifyPSHXJRVaobVBQYBQsWUkwFxrz3yBQuXqjBGTEJvgVhMvUF4qrp4va4g0MR7uvkS848YTWxCjNJF8JBlhrQFMMgW1ug403LWZ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTo046e2ScZaPjHPmLRPxrv9xZjQODaidv8tzZJbLRE=;
 b=kac8hz41nUznV5mpe0B5ZWyo0nk06vNXNfZeDuBPs3LYq4HmiApzIk1gyosxv015CXA6n4VP3U1kdM/FgGJ7nHTCyi2B8Svv9zYUpaNdFZJmM6Ii9I0Gomxl85E/esP104nusJosNVt/UfVj5EHwbKfUj0N1Yr9WUswa5EQz414=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by LV3PR10MB7748.namprd10.prod.outlook.com (2603:10b6:408:1b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 09:27:05 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5%4]) with mapi id 15.20.7292.027; Wed, 14 Feb 2024
 09:27:04 +0000
Message-ID: <84a0b3cd-7614-49a8-8f8f-cdb0cc4c343c@oracle.com>
Date: Wed, 14 Feb 2024 14:56:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/121] 6.6.17-rc1 review
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
References: <20240213171852.948844634@linuxfoundation.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240213171852.948844634@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|LV3PR10MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: d01ba8f2-d854-4bce-2fcd-08dc2d3f1aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7vnAuwQAlAtC6pSgcbLNJ+VMfLWJ8LrAUP37k+AA2JjSCPb1fsS+DJ+M/sf9AAE+dMZil7suqKwAG+dOph+1Q+cI0+W7IDnLn0aPAMoPml3e8fXl4Tfew9ZXe4AOpdV42lLTkojTMv4xKZ3lorNW9CexI5N7dVkPpA3wfBO/TtGMN0ubQRYIp8Bl2T+fV1MaJ+19uP+d3pxzpn6HUhwE3tbQfp+sxVAD1KrC+wypxWIPFucHWIXH4zgEEzfnQvNThvBLhzCyhQSP0oNYoai1FeMc5FEULpCq6QjtUHvN0+LyFG5YsMzyVySZSgnGxtQM0U7NR5h88QYCB25nvK5fZxlQ2Xsh1y5ir+QvGUFaRNOsYZ+e/YIZ3V3aSun9r+FbLqC5DLzO+b0C9ku9OjN+q04Ufolc91JSTHRfZUn8rQjYoddj7OCG4rSAk7TGLdM0aociYoLA4LG387J9gB+weZo1otkpiPfz/p0OVQT0BFcbUbgwbHqY7e45/gABjDeOGRdlZCzmD/Y6gJkbfdEQ6PuwiLyPnYC9QwwsmNx8QUE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(26005)(2616005)(107886003)(38100700002)(41300700001)(4326008)(7416002)(4744005)(5660300002)(8676002)(8936002)(66946007)(66556008)(66476007)(2906002)(6512007)(478600001)(6486002)(966005)(6506007)(6666004)(316002)(54906003)(53546011)(36756003)(86362001)(31696002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cUdENjNGeXd2SWV5QU1DeG1jNnA1MDhrNEUrcmd6YzdjUFUxd29oS2g4bFho?=
 =?utf-8?B?eS94djBmN2RYSkl5V3laY2QvQmhQSmFXOEVaUk1QMjd4eEt4Q2JDTldyVklW?=
 =?utf-8?B?OWJmU2w3UzJxYVgyTzNFSjVsd1lkSzl1Y3BHS0xrZ2JuK3p4Lzl5MVMwY0d0?=
 =?utf-8?B?dUVwWXU4ZEdlSTRmaTR0YUNxZ1VwT0Z0Wnp1djRKSmVOanpwMjVDNnNEajZw?=
 =?utf-8?B?N3p2MDN4aTlUMm8wZ1VVYWxxRDQxdWM0NnA4ZFhTcDV2YzRoR2tDSTdvc09H?=
 =?utf-8?B?RFRCZmFYbytPblFCWXlaTnZWUm81SmszREtWalNzeHU2cm9PNUZmRHdhbWhn?=
 =?utf-8?B?NytnL0FvbDFqNHlWT2owUVJibUcyWm1uTDRSV3U5NlEySkdIZ0ppMXlmYzdF?=
 =?utf-8?B?YXM0aHp0Y280Um5ZdFJ2Q05nbnRjOXUvRkIyTExaenJmS0lxS3VDU29qY25q?=
 =?utf-8?B?WDFmWXFidWdNcXFSWmpnNyt0U1NSemtQYTZSVHIxdnVNMUpSQmJKNUZZT1hS?=
 =?utf-8?B?aTNSd0JLd3JQZnJUZE9zNVpwb3BaeEIxZDM0TW5ibU1KTExxNWt6NmxtN0J6?=
 =?utf-8?B?WTRWOFI1T0dIRjFoYlZiaUtNazlpNSt5MWFteWo2TFZFMzkyQ29qb2hRUjFh?=
 =?utf-8?B?NE9raFBlMHExZ3Jta0J1K0RhRjg2V1E3V0pvM05rYzMvc0ZZQ0hzbVc3RlNC?=
 =?utf-8?B?L3pzWndJN28vVzduOTVJdWkxVU8vNm1aSWpjckZySWZQS05NQzNiZ0RVL3Nu?=
 =?utf-8?B?VUJWMXcrd0hkeHdRcEhiTUptbUZONGNXWUJwMFEyWW5zQnZiVGpYN0xQOHpS?=
 =?utf-8?B?VHNjZGRtS1ViT3pvM2dhQmtCZlFpSlJXMitHUjZ6d2xHNVJrK2RsWUdYTnBl?=
 =?utf-8?B?Q1dlelNuN3h4QUhiMWpLREhqNklmcUdhaFpid3k1OWY1TXJkbUN6UjIzNVkw?=
 =?utf-8?B?d1FzRnBwSHdONnlGTGlOTzJTWjgzQWJ5a00xMXVpTEx6bnpCMHpscm5pcjZH?=
 =?utf-8?B?T2lvYm9OQTJ2dzZBM2ZEKzBIcW9CUWZFb21xUU55d2QvdWYvNmZrS2RMUlhY?=
 =?utf-8?B?YVJvaXRiTjRMdXoraXRWcitYa29DSFNZYnU1MlYxeVlSSVBSRUlOaTdpVjRI?=
 =?utf-8?B?OXFNejl2Wk1ZVGZqR0lhNm9LcjZFbTBpZkRPRmtlbS9tdmxxams5ay9URkQx?=
 =?utf-8?B?R1haNGJpbHY2b21YQ2dyUk4waGpUSGdJcVUveEltaUdiZVdwRWozUUYyS0JQ?=
 =?utf-8?B?N3ROWmk4bDBRaGpIL0ZhdmNLYjM2TzRzQUhzcmRaQ1NSNGhVYnlUSXVCN0FP?=
 =?utf-8?B?TjlZbnF4SXJDTXNydVoyVHF0ZGtVZGRWYzc4aVA1dC81bTV3TUtrRFpsU3FL?=
 =?utf-8?B?ckkyT2tvWS9GR2J0bXNPcVVJdVNtOVQ1K043cktrVXArRHVWa0JtM1cwMDNr?=
 =?utf-8?B?OXUwOGhBb3p3Y2hGZ3pTalBQRUxsNTArcnNpV1REQ0xXd0pIVTB4c2ZnbjhL?=
 =?utf-8?B?NzdzL0J0QStCQkgwbXl2TUpKSUgrVS85WCt5YWN0Tm1yTEtGeTI1VHlDZFE1?=
 =?utf-8?B?TDZyMUpWWDExOGI0SVcyZldtcTYyNHJvSEhPNWF6OXRodEFyMUp1QXh6cWdv?=
 =?utf-8?B?ZDVNNDUvTks2bHEzdmNkRnE3bGJ4Qmg0ZExHbHpFTjZIZ2VDazVHWS9ZdVdT?=
 =?utf-8?B?bUROYkY5dEpiR1NlWTZLc2pYVHN2azEyejZzTktSSTBKc0l5d3BiNmlrZ1E5?=
 =?utf-8?B?eG42eE1Yd1NFR1ZXR2ZHYjZkelhDajdrMG9RY1dHc294UVErK0I4bDNLd1pt?=
 =?utf-8?B?amQvMTdxWldHTUc4eGF4b3hpZmVOU3M1cGk0d0hZVnk1RkxSNVdBOHQ3c0JG?=
 =?utf-8?B?algxVG1UZHpwOFBINklhcnFKU28xb296Vmw0MDVETEMwWWF5dXJXNjB0TUlQ?=
 =?utf-8?B?WnJaN1pYTmJsTTR5RVJIZVQwTVdaM2E1WGFPa2dpVzVpM0FQRkU5aWRvcjJW?=
 =?utf-8?B?anRSV2RISVJnWjhMZXorNnp5S1kveHdIL1RyQitIb1NHSW1aR05aRWsxWFNx?=
 =?utf-8?B?d2NMNUc4M3hOMS8zdTlOYjd1V1djVjkxUkxjTHZhOUVBZzFFVm5CUTFxR1Jl?=
 =?utf-8?B?TnlQSll1MEpKTlhKK0cvbm9yZFpaQkpucEY5V0F6a0V2UUdSclh1ajUraFhp?=
 =?utf-8?Q?6X2NANgfxxN+U40wx0450GU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	holvG/oGNCP1kbZFC1Dm9xpyVo1X7ks3U5YOkoP13LiLKJt4Q3MSyLYMpCTsdWVehI/38eyCOKNZXXJpvoPGoGLWw7cb8MLbklXx9LjSZbQCU4M7BA7bM4pRWBSmjVB5fJnwcBY2t3DI4vKKtSYUvRx3DK6SIrukqaJxTQsB/xvw60f2gevhBoeLcisnIKSIJ5d7fBgzyFgn5OM1rzcB3oAVMl1K79C+IPHAFgwmzrarr0TiLDEHX+HV03XAA+WkJuj2J+7fziIBpYecDkQoeJImXvi8AdSIVj6vhmpQ/fWh21oYsYdinS66Sxf6MHLcndtbx2/1c1vZZJDcv/wbuRZwk/vM/BXwjEA7vpRHO0KCBqYfUQceDmS8YkVz1qC/SwewiaCY63bNurk+sMjSOCMdyd38JoyMgHt/yDWQHu4p4OajbOY8qrMnLMuVxSVmMABPIlVMV8EOqxf5Qs4bNOdbwPT8UYPbavaiM2zt0E1PfnvxMiGZC7mpIWBIHMIUUThxczc0IySznNYxN7fwE2cBkzzrUaqIuiIyJEhbGzeAw3NQkMcACqafcnlfOoFGKNnUSyFp4ZboDdM1XjfSp9iVdN2+nWQr0L+GvwMZ6ws=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d01ba8f2-d854-4bce-2fcd-08dc2d3f1aee
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 09:27:04.0708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ORzjDtYfcwCiLXN/61CPiB9Ua9PK6nzCwqvFkSJMYbMS+g7GWes4Kodwx4fU4dfVoM2GhSIRYcpv8tZK8TRK/LWuvqPd4XTsKQsuWG3CrJisNBcmbFrlZe6FoNkOkx0d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7748
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402140073
X-Proofpoint-ORIG-GUID: xXWp4W5dFN70vyKZaysrOu6qs6vxga6U
X-Proofpoint-GUID: xXWp4W5dFN70vyKZaysrOu6qs6vxga6U

Hi Greg,


On 13/02/24 10:50 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.17 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 15 Feb 2024 17:18:29 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.17-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 



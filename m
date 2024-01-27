Return-Path: <linux-kernel+bounces-41201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 003F983ED50
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24F0F1C2105D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 13:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D4C25760;
	Sat, 27 Jan 2024 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kKg7BZBt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n2pgkSr8"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718151DA59;
	Sat, 27 Jan 2024 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706362201; cv=fail; b=CJoNeiasE2MkVO+GFYXHTbhFrE8A+PK0mJfLEpiKQW+GUw09QbE4rhYwFPpA4fHz4lG6XkQ/MABSn2iU8C7O95aL0q9+bp82/ucKIZkSKzQcQFIMlKhLGxFxaZs5a+Eu8PNAQ1uSNsiWN96OBi9SUSaUT3/BcxSNJroVsSPeAfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706362201; c=relaxed/simple;
	bh=3WeWO/KiZpuiRRQcqHFzraARwg8tqKHuGPXIp7lq6rA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nkU3Ije8LGj/+VTb0SE1JwT+UEeohSng0z2C/3vIqoiAjq4OP4VMa1nZwnye7NZjxpd3UnYgID5F0h639Iptzo29x2zxrhl13oV7b02wRoysGPzIqUv815gJN/EKOyM6l/dVIhh/pqNdhM4xxphgZrQOF2fTtKnh1WnrjhYO3ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kKg7BZBt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n2pgkSr8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40R6SoNl024169;
	Sat, 27 Jan 2024 13:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=IBx+Qyo3PWchzzJgisu94n7zcPSose4XXk5AWjOx1WU=;
 b=kKg7BZBtaZrQ1rG1mT8CSJ99yEt9l8EPoPWXoR2RByazJUbroFjsPITC5H9aa+J0s7+J
 qbo4GTmLXnk34+X73mK2dZVcM4BCONuReFqFIShRxDkIFKudWLKrF7WGH7XcyHiFIu9s
 i3zNAeZzpye6WVzMrSovNkvWcZoS6AEPYQvvl6bEa4qWpmv9ieY4l0KGYtF/sRNOIEz0
 glyQBWn9yXfvdO8wdHLyAnHJwwrH7UB1xgRAsB2FHEmJm9NxmJ2Uayrgy9+QX0cauEaI
 0kRjFR8E5URz0KXpIkp3a6aVsakU/OwGSCqhr7wjcg1HUHur9RpGz0J1wsp9z6nXof0e 0g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrm3rma3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jan 2024 13:29:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40RCheBj014626;
	Sat, 27 Jan 2024 13:29:29 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9a55jd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jan 2024 13:29:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7iuXdRGh7ohgTuYEfERm09zEPx2bQt57Q72KuhsaVa9/5Dr0ZSQRnS6/XxhRK0ipQ5Tsxks/ccK5e1CYz1D5k7N8dKOVg0So4VKORB6zOOrwoB3LinHK5nzxdXfaF5XQIT/KNIaCy1atqyD+I3L7cuyMY/UNL5MrQtiy3vrdPGs7xmm2iELv/SLif+SUJ6c1A5g+B+j1uNrlrqAk92fVcahLrbfeabXPfsiP49cr1pZzkMZX8yM9GBt/IQkzA4lwKVg2Nz8LHlrcA3Ppdcq30KXjs6MVpVFtyWcvsIMtbH9yb8Azb+G2w3tp75VX8amEfdfHsmxvbWnfFKDgNpBAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBx+Qyo3PWchzzJgisu94n7zcPSose4XXk5AWjOx1WU=;
 b=mZkAQBdiRQPrPcSUg1lIWSctSpIS/+dUUEt7rLeGA4a+6ZpYZ36JN9ug0CB7Yx2hjxgT/4UEfAFFwx/sMbq7nRMHKDkwbLqY+x7XWtcc16Pmv0yJnnvWiqvIzrrObwJ7IKQ77zTRQvmU7SgLuVL6dKNALcFlBBm/fFwH9DsZjqypM/Q50wMddzEHUvLanHrIMUftG9KF5XgL5L2S64Wto4sl3NNJKJ8+Iwf7tA+NJBxC+ZfaMmT0j3QHm2aXOqLA7lWr4cni2eDutb07vQqNmzbBzzacI1rd5mCrvQzoCS6iaOSSXouu9ys6xVs46G43HkpLuGDf6Nit+yWnPNMQ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBx+Qyo3PWchzzJgisu94n7zcPSose4XXk5AWjOx1WU=;
 b=n2pgkSr8xSqE1YVtttYpONpJwu8aGPr/0d31OVsBfBVRWJwIIlRUMTv+v7mHKLWc2cQoPWSz4S/IC07rKaJuaJYtg1f7ewxWKzIMdsVBx1RifebEmB2krdUAE8Cz25jySN94WYFxS4lcVW3Ue+3nq3/KB7mcxuVy5XjXb5T0j+Y=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by PH0PR10MB4582.namprd10.prod.outlook.com (2603:10b6:510:39::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Sat, 27 Jan
 2024 13:29:27 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5%4]) with mapi id 15.20.7228.029; Sat, 27 Jan 2024
 13:29:27 +0000
Message-ID: <8ad7fac4-dcd5-4ef7-8e40-0c9fd1c6fd0a@oracle.com>
Date: Sat, 27 Jan 2024 18:59:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] smb: client: fix "df: Resource temporarily
 unavailable" on 5.10 stable kernel
Content-Language: en-US
To: kovalev@altlinux.org, Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, keescook@chromium.org,
        sfrench@samba.org, corbet@lwn.net, natechancellor@gmail.com,
        ndesaulniers@google.com, "pc@manguebit.com" <pc@manguebit.com>,
        "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>, linkinjeon@kernel.org
References: <20240126193143.245122-1-kovalev@altlinux.org>
 <2024012613-woozy-exhume-7b9d@gregkh>
 <472d92aa-1b49-43c9-a91f-80dfc8f25ad3@oracle.com>
 <57fda449-0d18-485a-0858-39f48722fe27@basealt.ru>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <57fda449-0d18-485a-0858-39f48722fe27@basealt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWP286CA0010.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::19) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|PH0PR10MB4582:EE_
X-MS-Office365-Filtering-Correlation-Id: ac05f8ea-8f0b-4b23-e352-08dc1f3bfc1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/VlMzvrEARN/N0m7X6ZUgFtadlO36jiIFzKLDOWI/lUYqBPBUBRtPfyBMsSy6SQtzsgywpIOFXc0yQEdyq53eiLtLyPKhLFg28RpK0ZdBSHydKwNVmibekOHqgZFHEGE6XQ1s++UY80Wvf1RxKW7rfcTiTrallRvx6rk4xcRbiqPdRSbR+yS/OAvJMqH4lbMcVpobgecIpk716XMl35bsyly6EWcmbCZtG9uOuuDD95Bll2ISZ7hjhZY/zzRh/q2r9tngvaKyH+elNBXG+D+mRZDs0N8UrKZO07GdC16kqJ4oqvSFCanK3wNm0MVzOiIFV/ihzRqJR8Ck93zpZ7HEj1utT3xhid3yKLttlCJ+5PG1CwbgdXa3zn895OPuF2DzKx4PNGvaAqE1IioqVPtxq9GwMnUyjR0zNRqa1P2USWR8DPFUDpLtYPhEBTZQvCd11v0MRn/3egXNDFv9RyePHnHNX4XD0nFZablbpmV3ehgyickbifrEkeA/19WPqj5UN8Z/OsMNUmGEcLZsgii7udxEV8lO2VfDnrGTo1TnXWskEllUaH585bDn9rhkd6GfQhE9PTzmVZNkYrl9PDkz2P9l0AcopT7vC06FOwxPGR0lPFNYC4OgHBRCWyLsnBw/9YwrcZeUBkqhanSn4jJ2w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(366004)(136003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(31696002)(86362001)(316002)(66476007)(54906003)(66556008)(966005)(6916009)(66946007)(6486002)(478600001)(6506007)(38100700002)(2616005)(6666004)(26005)(8936002)(8676002)(83380400001)(6512007)(53546011)(4326008)(4744005)(36756003)(2906002)(7416002)(5660300002)(31686004)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RUR2V3dUS1UzU2NSQ1BsdklraGxyckVtemtrN0lFODdBT1lEVVZ4ZnpSd0E0?=
 =?utf-8?B?WUQzL3ZGQmNtblRqYjJYVzR1L05kV25KS051aldHa0phM2ZZTTRTN0ZrYkZv?=
 =?utf-8?B?Rm9mZ3BtTWNlVzNCL3MwS1YyZDArYXpibzJ4SHI0M3NpT0Y5MzBVbkNoWTQx?=
 =?utf-8?B?ZkVGazZ5dENXYjZCK1VQMVpjS3JUWnNNSHBuQi9xSVlrcmNnRk5pTDBlQkNi?=
 =?utf-8?B?L3Vrem0wVkkyUHQ4YnVwMmY3elB1dUtsTHZQdWs1bzFZSnZQcnc1SEh1aDhH?=
 =?utf-8?B?Q0s3T0ZRU2pnV3dpVWVKMGFiaWI4UnpUVnRBNEdMbzgrQmRja3pLT3FaT2Ja?=
 =?utf-8?B?VjVzS3ViVVZ2ckE5M2NnTTJsNm9GSU03ZEhuYXc1TUZONUlHc1RCVTErekJz?=
 =?utf-8?B?amVzYmpFaFp4Q0xLVmlUekpId3djSGdmbVh5b2xlMmxLdnBsWGNaVzV4eU9P?=
 =?utf-8?B?N1piQk9hUXg5aXBMdmlxMlZVeFBPK0dRU0NtSzNMVkJOUzdyQThBMDlwZjBQ?=
 =?utf-8?B?Q05xQmFzREJvSHdIazhjSWFsUy92TDI0QlZtaE12WWVxaHVJMXF1Z3J4b3M0?=
 =?utf-8?B?bDVlTWhZbU9xMVVTeVI0VmxISHlZTU41UHNWSW1HaHpBZHVZc2U4RW54S3hw?=
 =?utf-8?B?OUxlNzhRYzQ4TDdTcFlQdEVNa3VIdWlPWENiaDVmQ0YvWXhQcGJ0MlpnOWZD?=
 =?utf-8?B?c3BSKzF4d1NQaUdkYzZYZ3Iwb3YvQWNtRTJYQ0pBdkRHK2lJYWp0T1B6VThJ?=
 =?utf-8?B?L0dEV0tsbFg4YlZjR0g5VjMzdmFEUlBKd1BKb2J2YTZ1ZDJQUlFGbG8zbFlS?=
 =?utf-8?B?NEVud0ZzeUh3QjJnVUw0WDV3MWV6NGRHandkaU83MFVzMTR4aTl2RjYreXhn?=
 =?utf-8?B?QjQ4Q1lkeVIyeDdBRkRHbnJYVU9pRTFDUVBSV0p6eDNvcGhnOExTMUlDSmdr?=
 =?utf-8?B?RmF5YmxWZlB1UWErUEtpVlhkSUFvZTB4ZTN2dzByOU80ZTFkS3BVbG1tektl?=
 =?utf-8?B?UVpCQU44clM3ektmQ1JTMmYvYWo5SldWNk8xcmUvRnJFYUV5SzIxR09qTXlp?=
 =?utf-8?B?dEhBT3FiU3ZGLzkvKzVsNGZINWJ1U09HN25kZ1NHL0lIcTRubWNMYW5YNDBp?=
 =?utf-8?B?WFhpVkZkUXYyNUozOVh2NExmQWZzanRHUVRPd3VTaHdrU1JCK010K3FsUnRJ?=
 =?utf-8?B?V0ViTWNlM1k2Z3l2TVhDbzJQSlI1MC9aTTVsQlBXd0F1YnU4TWdWdGEwRUN4?=
 =?utf-8?B?L3hjMHQ2MFpzTGhobUszdm45MWlxUXNRVm9ubHM5cmd3MXFISVEvSUdoM090?=
 =?utf-8?B?eTlIaWs2WFVtWVZGYlB2RXNHajdZckpYb08vQlNRUWNZOWltNHhRaThxNW00?=
 =?utf-8?B?K3ZnSWgyQStvTW9hZXcxOUVidGZaK1FHMStVQW0xc3VZSWdrVmxtR1A3eGNq?=
 =?utf-8?B?a25mOXE4dFRjSlkxejNIdVhudjA3aUp4ZXNYWWxEK3BpdndwcCtkS1hObS9i?=
 =?utf-8?B?VVZTUGQ4aVVxcitoVGVYdUdmKzZsOFRlQnErWFQ0ZXZUYzFsdlNBZnJ6QjBC?=
 =?utf-8?B?ZjQweFJhbVZpT3d4WDJ5Z1N6bzBqSXQ4U2hYL1hMajZzaG92dksrcGxNcHg0?=
 =?utf-8?B?SWtXNHV5bllxWGFwaGllSFZrUElFM1pXTnBsWno2bnNTbGxTQm40RjdOdVJp?=
 =?utf-8?B?NkNwMW5RZnZvMmVONXNqa2Y5WkE3Q2M4ZEVySTkxdGlTNzgwTHZOcVZHR0FW?=
 =?utf-8?B?eWREblkwN1lVRWJWaUZia3c3cEFVR3NVemM5NXpoK1dPSzdES1hlNWxCYXo2?=
 =?utf-8?B?KzdjNXdSOVY2eExqeVF0VVNGRlRwRkEvRHF1Uk1UT05Xbkd5ZkcrSXMrcDgv?=
 =?utf-8?B?WWdVSXdjZU5rbUIzTWdwT2xVNGRhSFRMMTdIa1lrbXl5T1NoalVmcUVrY2JW?=
 =?utf-8?B?VnJLWVIybHJSUWFiZldpVHc5b2FVbmZKUjJpTjIva3ZCbm1mT2lkb00zYjls?=
 =?utf-8?B?N0dhYjRwMGo1d3FnMlVVdDQ0WTVPOGJacVlqdldOSUltSkNlU1Azd3UyMXBk?=
 =?utf-8?B?eUxsOUtDRDZudEhQZXBWZE9wNDIxS3JVM3p4MUVHSUJFMGFsNHdMR2puZ2Jt?=
 =?utf-8?B?MXhmV2ZjYXhSQkt0UWUzSStod2I2K2d3WVU0aU9NK2ZoRC9SVXZsMGRtcGcv?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	FSRO3klzrD/tOOJmlXcXQJZPumgiiiuNuo6/UZ8dYfylqZulq3W9YlDvp7nAQrCz8MO3QKEfPAzG1UxVLpvetHjrD0VjanH3vZLtclH0J1BlWdSXho1koWQObyjKdKZ3mKUfPPYnPffrcLpQHCT40plzAvov1N0EbO/k9TGOOo9Lbw2Oc4wndOM0DIWohh8WZfhPVC4XcVbep/SVwl0tKsWQaMJh93+A82or/Ky57c5bguEDuFit2H7yz6kC2zU4CGQYPa9EXde1QM3EnsKToy7Izi0Wv8NMFQ7pOedlVs/juwX02wZOxXM22QjZGgAkB+OuXxoHCjFZ8npeE0PbgWkWR3+zCjVVWG3YcFVI50RR5SQLhN+RvYMSKUL99rv6PQCwfeeCWr1FvYVtKcHRjpH0InWLU7GnoagyigK6sbQ1vTEKIoHLt17iqX++78GFK2QEpbIxyqB+tbYpfvnAdhdasW3Knk0d9R2D0hEpv9q8XVtEzqlIm9XdwYTAB8+A7HDDOsIpEWYeUtWy7CJbpZjAcjvvW6v0nWmk1Dun+0m+V/YjIa0KdMYQLk3I2LfblYLpQnrv5uJ8gDc2mim+BzkAU3ok23JqcJ6cBIDCod8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac05f8ea-8f0b-4b23-e352-08dc1f3bfc1d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2024 13:29:27.5612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1SdfyTjvETvGzgra43jPJmC9CBTkxKEeukQwFOB6SN7y0Dl8XTthgoGVbs7EpEGTzzg8Gk19ciDpXX+ERVPviOZ1yR3LQvVSxxO82NAl+NBNgzDGSI9mMJCa0elYHy9p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4582
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401270100
X-Proofpoint-GUID: ADOtwJjTYHIJ-3rjhWDM_dm4VjS6kxgo
X-Proofpoint-ORIG-GUID: ADOtwJjTYHIJ-3rjhWDM_dm4VjS6kxgo

Hi Kovalev,

On 27/01/24 1:32 pm, kovalev@altlinux.org wrote:
> Hi,
> 
> 27.01.2024 09:42, Harshit Mogalapalli wrote:
>> We can reproduce this on 5.15.148(latest 5.15.y) and Mohamed reported 
>> this on 6.1.y, so we need backports there as well.
> 
> in the 6.1.72 kernel, this problem was fixed by the commit [1] "smb3: 
> Replace smb2pdu 1-element arrays with flex-arrays", which was proposed 
> in this series of patches.
> 
Thanks for sharing this, I didnot notice that the above commit was 
backported to 6.1.72.

I think we still need fixing in 5.15.y as the commit eb3e28c1e89b 
("smb3: Replace smb2pdu 1-element arrays with flex-arrays") is not in 
5.15.148

Thanks,
Harshit
> 
> [1] https://lore.kernel.org/all/2024010937-eggplant-bauble-d556@gregkh/T/
> 



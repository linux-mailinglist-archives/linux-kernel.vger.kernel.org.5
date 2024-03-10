Return-Path: <linux-kernel+bounces-98154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCE38775C4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 09:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279551F21491
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 08:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF0217745;
	Sun, 10 Mar 2024 08:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k4ubj8b0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KHrxq9AA"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85B91E888;
	Sun, 10 Mar 2024 08:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710058248; cv=fail; b=YnDhWk3pOsy54wPl+jZGvio294WWZuMeoQtX4NwNha+RGIIlp/nZ8mDifvRnL0CGLIYBTOEc5YGVzUOZ6eW1X01wAKzQk46ST4bo/d3Sc54hpEMOizDxXgAtctbtUK65LWm0Hf7DbZlAJXAK3OnPigsF0dq3FPqa8eqaxbC906Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710058248; c=relaxed/simple;
	bh=6wN22InlNSJ+Jr3ESckJEqAInfB+fOl8RuJG8QzUlB0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GiV9Xa8/93hv1kebtPPyJdYd1d2eztnpWi6mRFg+JC11Jqne4et/Hzs/59qmsjiQU237Ul5kar3kubQmiw8DTitJfaULfBxS2CgR7rrHQSXmTI3yQuR3Hj+I5SwgoFD6iJ3kpTfPQ87T4gQ+6QdRiMC0RiP/usGFuwx85GYkB48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k4ubj8b0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KHrxq9AA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42A6TLQb027457;
	Sun, 10 Mar 2024 08:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Jx/gkQwOhr2woH5ZWE/zGB3YTjZ9Vz2SNnjvJ6ZUwVU=;
 b=k4ubj8b0K6P8qdqmXVtpSR0vmIEUiV7USU020BOTXQWuTGLbVjCZ3PmJZLTPlT+0Y4Am
 CyCTy4Jghvg+BvK7NrTOhUQpstDogC7IwisxB560HnWg4AQrZ6/HXtTYCoCeZHwOLi+j
 a3DvGjXTjdSVSskvQ7ah7t7P3uYqJOhHeU2UylkdkU5yO5wveOvLhsIYeeNmB3T4w8fd
 tQoojxqEx/wdtxkNxqBLzyI3xwBPPxpX1Sq80D5oXaPe4ivskRoUDIas4Ghf843ZCdHt
 ZccvqYQhIRgyiUH+P4Or6Kzc5jr8yp0gwpFdrXBGXWN9v9hEywbfTUR9UmG8bQXK4Kcm fQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrgauh3pt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Mar 2024 08:10:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42A6X6E1004790;
	Sun, 10 Mar 2024 08:10:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre74ke3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Mar 2024 08:10:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNc7oFIzsh3S9mGKWWGSG5Uob/sAw1I5SPXusGx+Eq2ASJ6KCj+vTGCvDGSaMyW6hwrsPllinkxaruXmE7ffrhyQva2YIGm3MXYn+qiyhfgSQARCNCKNTu1LtphxQVTmeOhUL4w6gEDwZ1dRJCdxP9MSVj2TZURZ45Sb3azIlO62HY+s4RB1MSfEQ8nekZ+3B00F0xvT9mA/px4bWcheXTCF9W6YJzAadGpEXZiGiDZ2qDA9vDEEDRpOokfOrTY1CKIz5sMns22uzlkDNjJUEf+g/vPBkAd858/WRm37nP8yXxwINJmbKV7tbk6sDMYZwkdU84MFjYOdNvA7OYXwLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jx/gkQwOhr2woH5ZWE/zGB3YTjZ9Vz2SNnjvJ6ZUwVU=;
 b=XXTGNzjAhtZKQI5h0USbRBexcpARNzdktNArmdRhZTny2XsA52xe+N5uPU3dQ/N87FkmSr3jpKWx6ZzTIbGNyLM4bKoe4sfdLIumoGwVU54HNqUaK23H5jfGxwP2Eo4Y93nPxAp66bHpA8BdZ/jGCyU69NmfZU386LFlNMJwlTswa5nVgE4Wc0YloT0fTs7t59upGLAbZu+ngofzyFmu7FXlAYK9AoRjLwzNOQjow8c+vN8mVKKtM13lqU63wd6wmlxkQ0v4UB3e+PKSe9Bb7bah5J12UfeVP31+2jhen41HCFG0MmPud+q9M5r4UCnhSI/ngyHydpaZTWjmUK9RNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jx/gkQwOhr2woH5ZWE/zGB3YTjZ9Vz2SNnjvJ6ZUwVU=;
 b=KHrxq9AAmUy5lE306TB3+Hb5K2jBi28C0BOsmucXLhgpQDsBNkFi2JgvssCkdIG69EtNr0V85X/uL+KuA07V79/J7NW3X31+YkEl7ler5gOupSFmukOr+QumGzXHLWIiilBvBhZR3rdQBkbiCj9SzC/FV/mqCt87nPu+4BTij6Y=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SJ0PR10MB4543.namprd10.prod.outlook.com (2603:10b6:a03:2d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Sun, 10 Mar
 2024 08:10:36 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::c671:c95b:c99a:d9e]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::c671:c95b:c99a:d9e%5]) with mapi id 15.20.7362.031; Sun, 10 Mar 2024
 08:10:35 +0000
Message-ID: <e4906091-598e-4d21-9e8d-4cb088855d6f@oracle.com>
Date: Sun, 10 Mar 2024 09:10:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2023-52605: ACPI: extlog: fix NULL pointer dereference check
Content-Language: en-US
To: cve@kernel.org, linux-kernel@vger.kernel.org,
        linux-cve-announce@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Prarit Bhargava <prarit@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <2024030647-CVE-2023-52605-292a@gregkh>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <2024030647-CVE-2023-52605-292a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR03CA0034.eurprd03.prod.outlook.com
 (2603:10a6:208:14::47) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|SJ0PR10MB4543:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf1b4f8-a45c-44a8-49ce-08dc40d9906b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fvzFoWO5G7AtBDlqwuhGAiBQcSoeu4XjWZHUF+jboDhgx85kdC+W+PAV6h4BJrcm8vjrvzIw+Ql0JyWU4tkysXyzRamV9zYiuXUz44KUfIRf+nWxKZuF/ffrJARXpmf5JOsUB3RDJwQ/fQSiP1bVoAAeBP0FFdukEbH0t9mRIMe5OdOeYfM9Kz43A8B4UhsbUBnvfN+PsOTAplgw1NukGe6Sq9yoxXjobyqS3aiybrhF2XNe1RJai9CmFJMzFQhKZ1s3/8h67P95rYgzq5avEuR0Zl471oHJShr0T5A8DaCePers91wKCItWtITNPbrA6dZ4wA9vRTPlfkf8+BNb/vaxc5amEXvpP7TkDLxUZHvsDrIvSphJZg83Q7od14T7GJkXLTZoDIIFtGW2bKV5KNE2Cc9Kn5yGiC7Hk6/IPCNn9Cl2HN63dA8jvqKAZiOnhUIPyKWvAbMCfFrkipHalr2/Oa6dBg7mS6QQbH68S1SpApbmElBO68ThJwS3JU9QuGNDEpfvR9JDOn7xktrpf1kvDsXb2a71VPUSq1plwf770Vzq1Z6UIkcWehB2qlHI9sDgPP6JDzvhmi0czW+uT31r28uuBBggq3FJcEfuijfOOX/Oc4xy/eDNm24G7UkpuAClGHRcgJkON4Zk36wgsC3gu121y7aVDeezYdZ7xhE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dE9ielpwV2pPWEpHRUlRbmc3ZEVhNm1ZUlRicjB5b01aSnZSK1owK2hGNWVq?=
 =?utf-8?B?MmNFRnlocCt6SE41bWg0aWxVZkRpOWZyYkpjM2dBU2Y3aW5oZ1BHL3h5Vk9i?=
 =?utf-8?B?UVpTdy9PM3pBcmtaMHFFUjdHZ2VQTHoxNXFRRjVMcVd1aU5kWjdkMFI1bkFj?=
 =?utf-8?B?RkkrYWk0L0NZeWlaRlRNZk9BS25KMVNqU1ljRHI2ZGJPdUFubDR3OWdGRHVH?=
 =?utf-8?B?ZGVrWWdOMldCZk10NVUzZDBDekxCYlIvQzA5TlJvMC9NSzNPekRvRXEwbnBx?=
 =?utf-8?B?ZG4wd3NBU2wrZVNJSkc5ZW1FbDlVeFZ3RDc5L3k1dG1TTGtOaHk2aytveURz?=
 =?utf-8?B?Q05PUFZqcUJtOS9iem5BWVd6VEZMQWNZbXVWakxuMklVOE93ZHFOdkl0ZWZC?=
 =?utf-8?B?RnphbEJYcGRYZGJoSENmcnY3bElRbUlzbStLS1BXblFOZzdHSTByNU1uc2N3?=
 =?utf-8?B?NmhsUnFEcUpVVURPcFhjRkdyZTh1MWQxcEthKzc1RTdwR0tkdlh0NnlFc01m?=
 =?utf-8?B?bjE1Y09mRkhRN293QnZBYUoyNldvdnVCRHc1dnkydlVYZzcyNHRreUw5dk9J?=
 =?utf-8?B?R2NOeWlEUE5HbHB5MHZwU1praHpzT2ZxSUhlK0ZReDJJTS9pYnNiL2RTRm13?=
 =?utf-8?B?TnlFK2Vsd3RteXJpSGMwb1JpeFM4Z05EMUN4YVpSblA0ZHhEWnJoand0NGta?=
 =?utf-8?B?cCtTU29QYWF1NS9xNjlaKzFxN0gwazRGRHVIZEd6WVpPOXBPM3h6bHNib21k?=
 =?utf-8?B?S3RraEFNaXJmd0xjWlFkR1VYS2V4Q2ZRbmdQK1loQ0llUVFWWlByY052TXdw?=
 =?utf-8?B?ZWNQTHVrendTNGszSkI4MGVZVEowQjZEbmsvdGRzSXY4V3NXMDcvRXdMRWJk?=
 =?utf-8?B?bjdETFN3cHRXMGdOWjhkaGdjcU1NcVVyRXFhZEVmNlN4UVU2aVV1bkVDRHJN?=
 =?utf-8?B?eEM5dndYeTVUV21vMGJKQW5mV1d3Y005eVEybFBJVURWUEFiaHpwWU52ZTdJ?=
 =?utf-8?B?NGdlalE4RUpXSFNnaUYrc1EzK3BwVVJuYWt4UHFxTlZMTEJoZGY4L0VlNkRU?=
 =?utf-8?B?aXJES2dPTDBiWXNMNm84SmRSWnBBSzNwYWZEQk9aWWJNTUUza2RoR0tKU1VO?=
 =?utf-8?B?Ri8wWW4rMndicWJ3bWY0TGhncmRwRmZIcDBuWTA0M0J3L3U1MjZWYXNaRzFQ?=
 =?utf-8?B?WVZ4c2Zpd0VmN3FPVTBYdi9TbDU5ZmtLNEhidFFZODNRcm9PRjhWeWRjeFh2?=
 =?utf-8?B?aUF1ZE1vOWdPL2QwUmR0TE5yUWhMb0ZWbGhFeXh0SEVDVmVuWmw2S2dvcEFj?=
 =?utf-8?B?SmNRVDNKcUxGRFZNa3YrZ2ppZ0VQd3ppbm9YK0pvdnNWaFY2dVl4ajBRY1Zt?=
 =?utf-8?B?aVpnT0pYd05VYVZGM3pMWjc5MTNuZktTek9uZG92UGI4elR1d1VGVWM0T3JZ?=
 =?utf-8?B?RXNjY2xMeWxMOG4ycjV6anNpWDNzalUvQ0ZCU3VHTEtmOU5HOWF6TS8ydVVH?=
 =?utf-8?B?R0ZUZjBKMHR6cnZRTjZOMTFhMU13VlR5NWU1dnlJN1pNakFtS2NFNWR0Q2xq?=
 =?utf-8?B?eXBaMUNSQ0hCeW9mRDFSZ29lT1RIckV0aTAzc3d1bFdHZnBhOEFrSHpSM2ZT?=
 =?utf-8?B?NHJlYWEyZHIyb0tycWVYLzNuNHh3T1BCcXRiOWpLbkVMOTVHUGVudERZTGdT?=
 =?utf-8?B?OUprMzN1MHZuL0Rzak91b3VZUUJJVXhiOStwMmREdlhnSUNVTEg5N2ZVQUNx?=
 =?utf-8?B?R2lhblZZSklqWUNCNmZxQk9tWjVKbk8xY3BmNlFFcmpEZzNBZjVUUUh0d2lo?=
 =?utf-8?B?MW9lZXI3OHJnR1RPSWdPVGZuSGVBZHJkc3BUUGh0bGtLVXFpa09aNWcrZkRi?=
 =?utf-8?B?OFE2T2ZXMDd1OGlTeTF3Vmppak5uZmVPQzhHUkkvUVgrbmYyNDd5Qnl5VXVJ?=
 =?utf-8?B?bE0ySkk5d1Jwbko3dXRpbzdlbG5nRVQ1b3pGaitSQmk0WnQ2OVNvTlo4Ukh1?=
 =?utf-8?B?eGdYVktyV3F1TnhiRjgxTDZDOVpIMmx1Y0RxdHFQUUdwdGZpdzNGV045dTAx?=
 =?utf-8?B?eVAxdmxVR2JwQml4MjRIdDd2SXMvU2dmOGEzZ0JTc0ZrVGhTMEtETW9QZzN6?=
 =?utf-8?B?dmRodHlMM2s0ZWlFbWlLa3N5UklnczBuMThyRkdFMWNISTNQamtHREtNcEoy?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hxAy4yY6UInyNl5U2ZODqhQ1sL9gaZsSyDfdDDJKq+QbJkSTZPikcVZ82XwI/9kDCQO1PcGr9rFuInMClf8o4pbu7VH7VlZXGK+/55LJDaR7sb0Glj8TeXw4ApeQPsW0TnqHYQGUIbqPt+rlXA9h0DYY0loYUqAJCuqN2w7fVUTtWspY3mzmT4pUxplyw1/8YL1E/LEMIsXab1ndvA5PMjwDSFHr1Q+8+uzSV0J0v+hkIYxjHQ6pQXHl9Xwg+6lvwzaV4tcw4E4SOWou9HIWSzmYnA14kyWtRGyU6+kMSr4+B6rlxMRNAp17QV0a596U35nhQqONsWS4pw9A6fkAEQTn7pH55W/qRRsn95sSlkdOZ8OeR3TUqLmYC8kHgGgCVmsyHlBPjd77OnP1wsiHJO0XiL7Bg+eZZ9TYK6dJYeggO/pR1gq6mmeSYwPEkCXocu8NI55wXUccTrsRtt+miJY0h5D5KywakIDGA8WQpnVmWYzqK+dLorIjSj3gB+69AtE0vBhvf1fyfRt1q64zV/bLysWVwaz2AQHFlAIMZgOnLDdNGN8Lg2BkOMKWteiqZLVxfsEwFob54YRiHrc8Q2Okr4YYilyCbs4Sp0u5h8U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf1b4f8-a45c-44a8-49ce-08dc40d9906b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2024 08:10:35.7392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aktbAw04+MQhuWPBr6HGvr0SH+3J78IKkjEuPYCvUGaY+z+EQsLmt50M6PUah1UF7Vu3poec/6+hAmefQRCfh1aglN5RAFbru0GtpiXS3bM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-10_05,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403100065
X-Proofpoint-GUID: DYAu_f65dYhDo1RAy9X0OBnsd2ExcHVo
X-Proofpoint-ORIG-GUID: DYAu_f65dYhDo1RAy9X0OBnsd2ExcHVo


(Added author/maintainer to Cc)

On 06/03/2024 07:46, Greg Kroah-Hartman wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> ACPI: extlog: fix NULL pointer dereference check
> 
> The gcc plugin -fanalyzer [1] tries to detect various
> patterns of incorrect behaviour.  The tool reports:
> 
> drivers/acpi/acpi_extlog.c: In function ‘extlog_exit’:
> drivers/acpi/acpi_extlog.c:307:12: warning: check of ‘extlog_l1_addr’ for NULL after already dereferencing it [-Wanalyzer-deref-before-check]
>      |
>      |  306 |         ((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
>      |      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>      |      |                                                  |
>      |      |                                                  (1) pointer ‘extlog_l1_addr’ is dereferenced here
>      |  307 |         if (extlog_l1_addr)
>      |      |            ~
>      |      |            |
>      |      |            (2) pointer ‘extlog_l1_addr’ is checked for NULL here but it was already dereferenced at (1)
>      |
> 
> Fix the NULL pointer dereference check in extlog_exit().
> 
> The Linux kernel CVE team has assigned CVE-2023-52605 to this issue.

This code is in an __exit function:

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index e120a96e1eaee..193147769146e 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -303,9 +303,10 @@ err:
  static void __exit extlog_exit(void)
  {
  	mce_unregister_decode_chain(&extlog_mce_dec);
-	((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
-	if (extlog_l1_addr)
+	if (extlog_l1_addr) {
+		((struct extlog_l1_head *)extlog_l1_addr)->flags &= ~FLAG_OS_OPTIN;
  		acpi_os_unmap_iomem(extlog_l1_addr, l1_size);
+	}
  	if (elog_addr)
  		acpi_os_unmap_iomem(elog_addr, elog_size);
  	release_mem_region(elog_base, elog_size);

This can only run when you unload a module, which is a privileged
operation (restricted to CAP_SYS_MODULE).

Moreover, extlog_l1_addr is only ever assigned in the corresponding
module init function, and it looks like it will never be NULL if the
module was loaded successfully, at least on a recent mainline kernel.

Since the module exit won't be called unless module init succeeded, I
don't see a way to trigger this bug. Is this a vulnerability?

It might be better to just delete the NULL check altogether.

As usual, I could be wrong...


Vegard


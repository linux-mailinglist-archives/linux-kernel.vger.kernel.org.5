Return-Path: <linux-kernel+bounces-86644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14E786C84D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2066BB2123A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8427C6C3;
	Thu, 29 Feb 2024 11:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dDOO3w4Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rBSaNyQL"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA0C7C6C6
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709207070; cv=fail; b=ItvcleQ1Li9XfOBXE+HPsxBwb3PleEUWSFjQ7B5kHiCsBct+V54dqZy5GKqVgpLfyxtC59tCQn+Mf8Lt44b/KA2NoDVtb2/BNG0o3uesFLB1hKqy35U7ZCNpGLSx7pyNZ0c5wYIMcw9TG0q5KGVtdSb85GGO9gldz8vvqX8OQ9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709207070; c=relaxed/simple;
	bh=5qU1ZE7ddQZ4vXfUaimba4iVYs7MURIYsl12fBWhddQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TjYb0K7swVG57qyYiLTVyhoYAudn+biUN0aQVMvhFVUtllPrssrWx+ahIPpB0Vrr157jThpU8tVU2Yv+N5PM4NEPi6/ewtqW246JpNAPnP+yVPZ11JsyqFyhZjzgbiCIMC4BveCIW2N8Zv3X/uMHWfolT6lEn8U7k7JZekU618Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dDOO3w4Q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rBSaNyQL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41T9WBl5013375;
	Thu, 29 Feb 2024 11:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=WmQORgWrDmdjaih+1l0Rja9aRS8MIb8ZajxcyinbumE=;
 b=dDOO3w4Q49kkv9AJj/LfNz7NzlVnc8J7eyDYyBriFmStgHsnQNahOyRs4JI+J4zaBEXN
 FrzLl4YIQxmF9ETzD5O+hDrQPf9QffxnFnrV4itVBPNWX3gJ6DFQ0KpybzmvfwUoqitJ
 ONS9JyScFBnnq3lq0a3XK/CkClHwCmtCvb6ZBhcAExuf/hejjw4yghWE7AU8+1je8a5N
 IXpelWjf1W/FHRxcs9+LrGtp5VfZJO+GuzQElWCVgszK03vMGuFkdtGkjlg2v9otVW7+
 gBUd+hQSkutKl7nJd1giaAKws0RcLps0w8JHKFImfdPPBE5nw03NZb3hf2oJjSR7y/AU Lw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8gdnjcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 11:44:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41TB42NE009608;
	Thu, 29 Feb 2024 11:44:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wjrqk1amk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 11:44:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDbPE1p9TkWX9zsQoplmYrNhjoyTx/5khOyYB03VCxm4kg98tlzKrYMK+2tgWqfLQZM6BSX1Ns/6wbWynyIrRU7kROEREjvsk41XEWw51a2Z7UAeaG6+XaMNPJbQKxVkZeK2YCI+Cmd5anO9SKg/WarQ///jCzdTDGYH735CAJdLX1CRkjx53TcBoixA9j0kpiXG/N70f48SKsh7ajdMSJkpes99RW9Y6D7GqfRgxm3NZ92Mr1xLmVqp0aH45Y6zKPCI0gE6i+yFKEd6WNIdrr64wuuSfzjJf/77hK4FHR4nXVwXlkwQM6hvfvSlCiuiKzvOjkc1FKMRml6ITKFonQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmQORgWrDmdjaih+1l0Rja9aRS8MIb8ZajxcyinbumE=;
 b=WZ+TDJR14zhkvONaYp5gpmJfsTyKaKY3hdGMBTDCruWII1GJ2E0O0QXCHld7H9RhCuSEwOGqxdoNVbE4Gmmo/jUAhRtEPrdh+Ph7ccyVo4ibsmko4/nWbbfoxp4LtKKSDIYGwIuH9ehXlVJP7xdM/DdavGr6GoCvyvRnni3mW+Zq86RG6b54/7VZ92Li70yy+yhj9PVaYlJtgUNNXl+Dwl/7JF4MfTZQ/UIlYgVRfzkbRJWkCBXVqaLjg6AtB4KyME4ksftHZrfNmOiNeimNhMMEnKS/FOIecHrWYVLe/6+54hZjfhCXuemFroN3eU99LlnFOCFofIvugY8W1TOfJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmQORgWrDmdjaih+1l0Rja9aRS8MIb8ZajxcyinbumE=;
 b=rBSaNyQLIAA3S8eVMRGDpArTxoguLmQpzw34aYSgk4dfJI/iePeCozvEycoAk4HhI8cbQu9BylxPk9ugidIx+N4+VC1xh+cFIFNUJnUd4Bo9IjzmIRYuVdvWtRRbZC24j3JPfCmaNW++MehmEtoFcpW8UISotGXhcxvsGZx58fc=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by CY8PR10MB7242.namprd10.prod.outlook.com (2603:10b6:930:79::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 11:44:12 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a4ab:7076:36d:a488]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a4ab:7076:36d:a488%4]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 11:44:12 +0000
Message-ID: <14aca96c-7525-486c-8f7c-accaddd41456@oracle.com>
Date: Thu, 29 Feb 2024 12:44:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Content-Language: en-US
To: Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>, David Ahern <dsahern@kernel.org>,
        Aron Silverton <aron.silverton@oracle.com>,
        Christoph Hellwig <hch@infradead.org>, andrew.gospodarek@broadcom.com,
        linux-kernel@vger.kernel.org
References: <20240207072435.14182-1-saeed@kernel.org>
 <20240207072435.14182-3-saeed@kernel.org>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <20240207072435.14182-3-saeed@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0146.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1b::14) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|CY8PR10MB7242:EE_
X-MS-Office365-Filtering-Correlation-Id: 5645f898-91d4-470f-7edf-08dc391bbf5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	r8/V41hSUQ49NS7QUef6YlFu2WC2I60knLRGhFt93veLz7aIUHJhPApCWpoDMP8IODKq2Vpg2Q3jCcTgnRhZQD77ueLV3cOgSfJfmu9aSVNMZF/EQtsuH5pUaA8/aToW9ua2B0jAjgpPi8DSxjL5f5CaeiMrX2ujZ4YEB+2DSVfW4tXdBHGAb1RhKvR7FSXCR7i3rvOxH1ykpRNVvWjlp80qONfmCi00Y/L1QSPZnnLu9YEwOnMyQH3P9f850wxhGQjFpGctCAYd116GzTEI9oSacvSKF2DuWAg7N4hAasUO7nCDz2Pq4n9VPpvknJokHQQqXfeoByfRLRRgYRD1TVFdky4g//H2q9cNRFXHCWkKNWE+H6Gan/zMQYRqvL/knghtqRSqQVqwxgPi23h71CJPZvOswqbXGa3QRJ04HqZMOPpo6dKsaE3lEDfVtFh6KRF7RAyFSgph58Qpn8KpZC2CdCRmxtUSqsverghkQmWsMP8L0uQ0yTbJKZpYWrBZv/tEGyL8DrypgNDYdtFn2pQEX83pJz8gsoECzMFeT1CsVLQ600D/i11AH120IRSOLR/Dl1GCvX4eYWD5Sy4BmM29Rr4ivhAnBjMfMZO5iKBf8WfKA5KNG7Vqml4Miglj4qv/LWI5mJRSrOwRj/opyQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z3doc1VQcDI0RUtGcGlTWTF0UW8yYzkraFpZb1lNOWZDR2NFY3oyNFBiR2hs?=
 =?utf-8?B?ZjM3S3pzN0xFK25nblAzNkFMbFhRc09YRy9tZlNJSmtWUTR3UDR6cFZHcVg2?=
 =?utf-8?B?cE4vN1Y3czBFV3VpWUs4L3FUNHVMOHpQcGVKSmhZcGFiY0JtTVROd0tSakhx?=
 =?utf-8?B?ajByZEp3a0ZJbUpXL3dudk9KVG9UaHU3KzNQVkpaTUZRZXFHbkcwdkU1R2Jp?=
 =?utf-8?B?b3lBWGFoZitRenMyK1VRZ28yTDdRaHlLWGlsSkJhRk03d0JjeHh1dGVDQjJV?=
 =?utf-8?B?ZnRsRmwwVUZ1RmlxcWMzeWFLemFKZUFOeGxWRmhhYjUyOXNSdU5PaStPN3B2?=
 =?utf-8?B?QTE5K2d6Z2t3bmhGLzY5VE9CTS92Wk9oTlBuazhRbUkxSmc2Qnd3SFdjM1B4?=
 =?utf-8?B?eFh2NWxudXBKaHBjTnFBUUlEdlFJaDFiM21lZ2dXd2xJMER0SEtub0hENzAx?=
 =?utf-8?B?Y3o0WnhpMitzMUlsZjZRWFZDRGJiVEJrTXRtSk5YNU1OYmFwZXFLOWxHc0NS?=
 =?utf-8?B?Y0tjN2FYY0xlK1Q3aHFtaWtHK0lwOC9iM3NMWjRhd3ZsVk1CMkJWbkJVakFy?=
 =?utf-8?B?SVRzTERzOFdkQXc2dERGT2lJb3JqczR4SDA2SVNhUmJOdmNLM0hlS0xvaE93?=
 =?utf-8?B?TGdsMkJ5b3BBa3FPNDRBYmJ2L2hiZ2ZnWFBKalRReGZKK0xMN2JwNUhVYU5v?=
 =?utf-8?B?MUxjMWVoTDV5aUgwdklqMGJMRDh0NE9oaVFRclNnSEREU25XS2xWUE1EQ0hx?=
 =?utf-8?B?N0xEM3FiRk5GMHd5emVmcmpxalMzbjlIYzRyYmRVUFNkajdFbWhPb1BlQjJQ?=
 =?utf-8?B?cGpPbUZabmVCTTZvRnBEUjdmWEpqbStPNTZQTEtKcXBSSVlyOGplWThYTXRI?=
 =?utf-8?B?OC82UjdKMU9zbFJqZXVLRndrRE8rcTliN3lsam81L3hoa1Z3a0trdTdHZklI?=
 =?utf-8?B?Y010elpLZUppWGRKS1NPRDhLUTduNERhVmtGSmhzeDZxK1NwaThMTllpSXEy?=
 =?utf-8?B?akZuQ2d6cTNidE5ONTlBbjBWK0RUWThMNDQ1amw5TklQZGVvMHBsdk9pRGhw?=
 =?utf-8?B?NlBnMlU1WDlXc280Q3ZMZ1Z5OUZPSloxYWFFQWtlSmJXb0RPQ1ZOSmExUno1?=
 =?utf-8?B?TVNReG0wOFhvN2hqRkJXNVBDM2ovVG91dGJDYzIwcEtWNHcyVWU3S0phVjRH?=
 =?utf-8?B?Q0dvTnMra0tCYTVDREZHeWxQZWdzeExUVDloWUtkaXpSZ3d4V0xJd05OYWEw?=
 =?utf-8?B?bmFoVHFacWZpOThPSjRBQzgxV0xGeU9lZ0U3OHM2NER1b3hGQlRVVEFzakpW?=
 =?utf-8?B?TXNUekVXUHBCaytPOThSSDRGeitHSnZ5MXhDTGc4M0RIVVRsSlZzM2RnT3Zo?=
 =?utf-8?B?WXpsZkJVMmVZdVdvQXliWHRiN0Q2ZWNodjdabWlSUXBtZTNQd1AzVnBCcXRV?=
 =?utf-8?B?YllDS0RKb3JMU0JxOS9sdG5YSEsvZmJoR3RoUGU0cEhzanNyUUpOaGNPVEhQ?=
 =?utf-8?B?anRBZE9KMjJ4Z0xIQUxQOVV2NjJ5cU5Wb2UzOVVJbTBTR2NZQlBhYkVuWWky?=
 =?utf-8?B?a0o2ZjVuaEI4bE05bTUwNmtTMlZwSk9RU2kyUjh1NTlNTS9zdGM3dkJhMXZP?=
 =?utf-8?B?Rm9jeEptaGc1SHZIeTNmaU9yV0E1UFNVUFppQU1ZdmVLaklPb0NGWGZyWXRE?=
 =?utf-8?B?WEd1RWhnN2w2U2lDblh1OExpYWlMdG43US9CVDZDTW0zNWh1Nk9LT01kaklm?=
 =?utf-8?B?YzduZEFrc1V6WDJiWGJuTlBPa1pIdGNOOVRGUHcxMElZYWRHUU5CQm4xanhX?=
 =?utf-8?B?UmhwSEZjM3dleldSMFR2UnByZ01xTU9wNllOSDcyK2E5bzZvMytxamlEQ211?=
 =?utf-8?B?WVdZTWxjRWNlMDVTOUZUUGU2NHhSQ216aTFlM1pXRERSRVRjQjFWQzJ3NXYw?=
 =?utf-8?B?dW9OemxmVjJXZk1aWGtoaThCUU4wY2o3WlUrazlhZFQ5SDdLSWlJSDZoZXcr?=
 =?utf-8?B?N2dFYVhQUDgybjU3eTdCTjRuTjAyamhCbDZFcUtQMVFUYnhaSEJLWWI3cnRj?=
 =?utf-8?B?ZTd0RXRpY0xuMFEwRnlLcXloMldNcXJTNzcrejJPcU1qeWt0bjh5Q3c2SlZH?=
 =?utf-8?B?RkNDL3c3WkFPOFNuendUTHczUjRJejV0Q0dScjkrcHFmSStQbDVRMFBCbXI4?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	G4S0Lp+9ZncGwFleOS0/fwtJzSlgePeDtTDJtZzF1PdnhGp3MlMXeYfvcfM/Csb1+YZs8RuyxGXsdTAqYapEEmr/po9yZ2eziN2Ng6xHq46YMuxCSO6fCoBraI6m+LryBMB+VzvNe92rBSVfD2l2oPN2AcnH2JQGAkXD1z/oChIvn5F4J758LahY2Sl2cY6pCCnMEpivyzc/fNRMNiioHLXD7PUJ2Q63K6rBNpuLq+TxCn+iI1JzvP4IVeH8N9umEl9cJS5CYQ0FS7piGmEJms2iiDNU2lsi56gUlLjh0p3uEwUu77LDGESjJQY8Ebj9iMt0HCY8hD/GTM7+u2HVzDmDpUARaBx3gpPnAIJ/X1Vq2l0QGJTuGRvRMtrS8aKmc6Ts58T6nCnut2ejkFKOtGRFtoF4aAxlPyDOI/vWCxDIA6p6GfxnrDV4U9GqNVJyNBy9Nxln38cfL5VwNyQRk5eZy09/sHcfx5AJqwzPNH5hs6Rj5VaO7mgL+vuW7g4uVOHGv6sQMtKu5mhwPPLvKgecfB6O5PMIRQsuf0lDIyp0SdQtIj1Izpv0iMoTgAe7WN9MHbTV8tXOX3c+DfGk1iQEhzv6fZ3HsDy2LCcG3Io=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5645f898-91d4-470f-7edf-08dc391bbf5f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 11:44:12.0215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6JXUDL2p/RPSB16w6kliWUEHZu7qJJtrhJY5FZVRnRVcx9IcsIQ9MbBHluzdBtgJ5/XP/VxdN+PbgZCGcpKrez46pXg+8DjNO6w/Ct/Je0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7242
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290090
X-Proofpoint-ORIG-GUID: jebsG2lefmG5ilHVkXJmIDWkEVOoEkEJ
X-Proofpoint-GUID: jebsG2lefmG5ilHVkXJmIDWkEVOoEkEJ


On 07/02/2024 08:24, Saeed Mahameed wrote:
> +static int mlx5ctl_open(struct inode *inode, struct file *file)
> +{
> +	struct mlx5_core_dev *mdev;
> +	struct mlx5ctl_dev *mcdev;
> +	struct mlx5ctl_fd *mfd;
> +	int err = 0;
> +
> +	mcdev = container_of(file->private_data, struct mlx5ctl_dev, miscdev);
> +	mcdev_get(mcdev);
> +	down_read(&mcdev->rw_lock);
> +	mdev = mcdev->mdev;
> +	if (!mdev) {
> +		err = -ENODEV;
> +		goto unlock;
> +	}
> +
> +	mfd = kzalloc(sizeof(*mfd), GFP_KERNEL_ACCOUNT);
> +	if (!mfd)
> +		return -ENOMEM;

goto unlock?

Or why not reorder so you always allocate this before doing anything else?

> +
> +	mfd->mcdev = mcdev;
> +	err = mlx5ctl_open_mfd(mfd);
> +	if (err)
> +		goto unlock;
> +
> +	spin_lock(&mcdev->fd_list_lock);
> +	list_add_tail(&mfd->list, &mcdev->fd_list);
> +	spin_unlock(&mcdev->fd_list_lock);
> +
> +	file->private_data = mfd;
> +
> +unlock:
> +	up_read(&mcdev->rw_lock);
> +	if (err) {
> +		mcdev_put(mcdev);
> +		kfree(mfd);
> +	}
> +	return err;
> +}


Vegard


Return-Path: <linux-kernel+bounces-78617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF468615F0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52831F25DE8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8414F82897;
	Fri, 23 Feb 2024 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GIj4STKL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q1QVJ4xH"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B4A81ACB
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702512; cv=fail; b=osk6oLBXHAaUajMFM/zLhUgdXsiiCcmC3WRe5ZaagLFkcrxuHACSm9QUVvsC3uYY6Flo3Fhm+NxsC0Poie0qTnfQAzOzExuV9GSS8afl16CL05qw4vY3tUQXnub9oKooKZt7SqVv0hwkgZsYSA/KtZ2AAdgQQGoIcNU/zZ2LS/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702512; c=relaxed/simple;
	bh=FDkNZcZManMe57PcclAVLqLc8/hZPtWVcQMJ3jzygV4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X64TJNm/7mB1RQJ4gQbMPyFs54TRSFCI5ynksZ6O4doGRh89Pm4UtM9GvvB58x1xjqd1ZNIQRWtAh/ut4C42WJI8PK1QB4buuk1njz7oZzGFvvhcxStG45cYaBaNcwN9m/bQRXAzAcaSduZKTacUVzcxI9yzgjUXNTp+Y+s/wX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GIj4STKL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q1QVJ4xH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NEKHFl027883;
	Fri, 23 Feb 2024 15:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=3IIjUOyLvRwEEWqLsSlNoAoemHWvSOOrTk5zZK/NijU=;
 b=GIj4STKLXkBFGb8nUi04432JyfOA1TttuTIwJkkQ5cxhXyX3HS2KwC2KwRcXYSziFv/D
 +dA7xR/ZZ2tjRr/ijIG26xG6m5cwOx0jhdsiGIy/gdOh9mB9vVrgA4ii+c7lhQaYfLKk
 MHvdkg7WDcUz+T1vmNaNntx+2RMcOM8aw6gEcABFkGMSgNnDQLwv8jsZ831ZQssNCewz
 U7ZS3YZ1wco5JsPOfwTUlwap+N2L58CQOhT5mmUIQTw/K3b54R4OUkw5pO1Pa8l18H1r
 iU5+2+sdNWF+XjhS2cBTzzj0+1TGozv4TWYxaIooe388iyHdPrM9ap25QI8ty+EtrD2R LA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wd5fw7qjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 15:34:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41NFInQa016886;
	Fri, 23 Feb 2024 15:34:59 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8crnkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 15:34:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoL+9r6qzViLmWcO/cdNUNcgPRhyN0USNCahU9MxO4Xw4qKqXcb9C26wjpfLQsiouZsjIdZU1ynkdxu+AdmsqEQLUXI+4GzdKF1WUmwUg/ME7DS3MBtPTKm9ORx0xkF0PEwZVorYendMQtToylrwdmLli17MeyTYY7LyfxlBpJLmmTr0TnqQy77pB/dvbzmad/AxUc9nnLg7CRAkHCE9RsxDqO4r18XwJ3/hSPo9BkVoaeG0ebvazhJ0g1Z5jNPIoi7bXhtixa30fM/VpVMIi0l0prCfJmh6+qs2WvKQ3xlAak8i3wLVRI4ISKTTbCYh8NFRbU76VO40ilsHJIYeGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IIjUOyLvRwEEWqLsSlNoAoemHWvSOOrTk5zZK/NijU=;
 b=ICS6Sh1pVRrNlbTC7hSedVCpHt/cZi0b0wWG8FaSzDoQzXQFt8X3FBSl4DzOZBTuw96FlwroxpcFaqI/f9zkE9+ea8Ig6GsQI3HXZ6JoasXhKaRQQlcvJDqR2HNmt8NFECoKNhaJKp5XMVBr0jz6doHn4aUxAijyRKx/NFHe/E9caBfsX/za2Et0gb2r8X0Kn1lB2St3pEIwz2cCtVsjpo3mmWemxxIR8vpxCC/F+rwXLky87moMErRjgtaEs0lFHUdnXJm0M9kAyOjn6meSrWSWioD9qp0M46vjA+/c1iq5NPXFQRKPofbMo9nBTClDPFOwjwuB2Vc5pFIzraE0kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IIjUOyLvRwEEWqLsSlNoAoemHWvSOOrTk5zZK/NijU=;
 b=Q1QVJ4xHFRmY/ujCTp8YqH+C6hrX0C+tgZ5iZrRdmINCLDmbYpC9eVIXxVYbVrbunru1K3obliSTz6+8YFOlANqHVEp4i+SsyGqmZJzPq23pHWfsyvjopSsYZJjGpPbQUdBgoLyory6hhM5iBaQiFgr9G+wFLf6s0foFfvxzUPo=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by IA1PR10MB5923.namprd10.prod.outlook.com (2603:10b6:208:3d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Fri, 23 Feb
 2024 15:34:56 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::3dc4:7751:97e:42a1]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::3dc4:7751:97e:42a1%5]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 15:34:56 +0000
Message-ID: <ee7e4d3e-513e-43e9-a7d6-decbf96d4570@oracle.com>
Date: Fri, 23 Feb 2024 15:34:52 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware_loader: Use init_utsname()->release
From: John Garry <john.g.garry@oracle.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: russ.weight@linux.dev, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org
References: <20240222145819.96646-1-john.g.garry@oracle.com>
 <Zddt-U-6SdxkxqmD@bombadil.infradead.org>
 <51483aaf-d64a-4eee-b256-ab126483ad6c@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <51483aaf-d64a-4eee-b256-ab126483ad6c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0059.eurprd04.prod.outlook.com
 (2603:10a6:208:1::36) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|IA1PR10MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: a86b2982-a8d1-445c-f155-08dc3484fd0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DXae61DlDIXfQBkPjlB1jRoYq51I+NIhKyj/3utCv0JkSGk/M4oKI7KKob+PpAVqOpOf8/rYWm4z00W43jBIf8Ue66VyDgFuhz9uLydgdtZLoPi4dfYvzeRbjXLykbziRe+kMDA+bi7D+h/EghiL6stiWprpKnXedXo+pR6u1CX6X8ZpKlgM38rh7G9c12mtBxSj1CazsqpkMjiPC3dTM4d5NexvD3AHSJK9natck1h0zDbMZJo69ovCUVziFm/1ISl+TPyGjDm+ve+5G+VfMu6ZBRdYAC5AbpleSldR2HXZZEpshD1drTbTIhhbR6fSDXMxIAXA3oEmjWaMyTSt1bcgeyVpIkylAXNxCh9+lxDOiEDmKmqeBIh06ZoFYSw3OelsekczSL1gOVNd/cPXXt4A8f4/AK4Ga3Jy+x1RYBoODnyL3QHKWhdhyRfNhc6Izt6lxYfXJzeqNPM7z9exCY9Qa8yWT/aQNPUyhHC2swDqECdd4Qv3F4aNsTRBcs8SW/BKrn98uYdUXDUOabANvqwaK0xf2CkMSBH2m67YAsI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WDNnRWhndWx3aVZiT0UxTnozYURiR1YwVlNqUUgwRzRhS0I0R2FhbUl6c3g2?=
 =?utf-8?B?QkNhcGR4VDNxdjh5eGFyQ3l0YWdXZzhZZDZFb3FyTndZSG4wengxdG8wejRJ?=
 =?utf-8?B?MFl4TTMySzkwOENVc1Vac1MyOEoxQU5Vczc1VWNrVDZhMUtBR3FnUUtFcXB3?=
 =?utf-8?B?U2N5MFVNUVVDZHZTM3NhTHVWa0NvQmg1dEZXQnR4RVFBTWJZQ3d1TnU1WWFu?=
 =?utf-8?B?OUNLb2dZamRXM2tiTFBEQWpaMHFROHZGbmZOQ295NUcyZE1mQjBZREhVMmZu?=
 =?utf-8?B?NFovOTZLcmc4QmlaVnBsc2taYk9WTldHNmE3V1ZLZGZXUmQ4UDJ1WjNYSVk1?=
 =?utf-8?B?Vk1JUWI1OEpab1QyVWlyVExtaTdOYktJZXAzUzNmWWthM1Vob0hWNUVDV29y?=
 =?utf-8?B?RkZvL2V3ekVQY3l0VmFHb0NJSmZ3SHhZbVlHaFkvd3U1RlJ4LzVaVHkrdHh4?=
 =?utf-8?B?Q3lScjY1VDI0R3ZUM0RGKzQ3dzJpaXRhNW9McFRwOXJXQmJzOVJoWEYvTUk1?=
 =?utf-8?B?b0NzbW5LMExOWElEdnB3Z1RNcmcvOENJTkc4RlVGbTBDVGIrTUwxbUtlOXd1?=
 =?utf-8?B?TTBZc1Y0YmI5QlpPMlI0TWNLZTRQUUFHQ0tGYlQxQzVmTjg0ZEloMitTVGNs?=
 =?utf-8?B?WmpndzJ5YmMyWHN6cjk1dEFhd3NsalFwc01qeFIzTSsxM1o3bjloMnl3ckFw?=
 =?utf-8?B?MnBYWGRjcWsvTDUvVHpsUHpnamVoV1lMTStFUzZZNGtzMUFIYjlRYnVVdGs0?=
 =?utf-8?B?WnVINVo3bktPaFhUcTluaTEvMHUzcUNKVkc3N0J4WDFmbmVlMEFYdE9EbGJz?=
 =?utf-8?B?TlNWWGl1NXhrOWRPYittbFBEYS85Z1lpajRaSCt4QmRZSzhCM0JCYitWSFFE?=
 =?utf-8?B?K3lDVGU2cUhxRnI1eDVQeGRMQnJNK3hmTU9WRDdTb3c0OFVFbVdvSGtvOXYx?=
 =?utf-8?B?dXdhR3hQL3V4VFN2bUtsNnYzQ2ZRbzVOT3ZQT3I4SloxRm9MdWFWZjc4bndD?=
 =?utf-8?B?Z0xEOUFpZEpGdFVXRk5yelBIUUkxT2V1VVpyZ3VRaDhOa0ZXTC94bVo5YnhF?=
 =?utf-8?B?Y2ovakZvYURsOU9DKzdvSXNUc25INjV6RWo4TXZRblowbGgrTStabEt0QnJU?=
 =?utf-8?B?NkUrNEc1a2JGOVNlNGJYbUkzMHdiYWJ1VmhNcWFJckFkd05JN1JWa0dNOFpp?=
 =?utf-8?B?SXJHU2tnL1BRWFIzQnEzRDQ0ZVh5ZVRPWTkzUkJjWkdmdW9hSnl6OFpkNHcz?=
 =?utf-8?B?MVo5MzZkZSs5UURiTko0eUoyYVdoNVBjdHJCZkJuMWltd3dUNWJSZFdrRlhy?=
 =?utf-8?B?amFxb1pybFAwRy9SV0JhczlnUkNZeVlpaGliVk5ZTWZVUWJNMERUL3JHeXdI?=
 =?utf-8?B?NDh0NDVBVkYxUHRzRFg2a1d3UVhORUZzY2FQaFY3MjFOQmNJcHVObllWNkVZ?=
 =?utf-8?B?SVhwVyt4T0ppQUJ1ZHhvQnNCTGpaK2VYd3BYZG9tR1J6ek9VUmJJTHBMSFU5?=
 =?utf-8?B?TFBxZ05nZURqRjVKRXhzK2dHVXpldVd5ZENsVTFHYk52bzJsVFNDbGhvb3Vt?=
 =?utf-8?B?bnAyR0pkTm95d21Tbmp0SE53aWtFV0JQTXdvaFZkZzdlRjNCZ1FOM1dxSlY1?=
 =?utf-8?B?TDY3R0s5SHBRdE5CZnpYSDFSZFlUWGN4cjVGdjdVRitleXZFOVhDakhLeS9Z?=
 =?utf-8?B?YzFDM0FJMVY2cnkyNlZWTE1Rd1ROb0Y1MHBGdGFrdFM4SERNbmRMUHlPYURj?=
 =?utf-8?B?b1BOeGNmbEQyUkxjZDQ0d0RFWDFxTUJzd2pRRUhaQ2VsWHNVcWZ5bFEvV1Mz?=
 =?utf-8?B?ZGFLMEpnSkFtQmFmUm1qWHc2NWJnNXUxREgxTzV3Q2ZoMUU5bjlxU0VWSnZ3?=
 =?utf-8?B?OHRabW40dUE4RzJMcll5aFRHQnh6MndQak9ORHA4RTRkQ2RQdFF3NjlWbi9y?=
 =?utf-8?B?RzE3bWx5R0FhV0kxV1M0ZXJ5R3VTWXJSSk15ZDA0R2VCTnBpc2kzWjYveTAz?=
 =?utf-8?B?cFlQWm41RGlhQ0JyOGRZa0htV0FETG5FeENSd2plTEo2UktRV1RqdWRoZVZj?=
 =?utf-8?B?RFBnKy9uWGw5bUk5YVRWRlJKUlpSSlBJaVk2NWlORmd6RXlXZzdCNFpyYjUv?=
 =?utf-8?B?L2NYS2RRTFU4UjFYUGZJTWsrbnFrQkJUS3diWktadFZBRWFxeFVIOFdaaTYr?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wDru/ZWqxd4KZHFJh1VhF9hDCQBXLrMNr0+AKDmsuMHte0fUlERj1tRIAIm7e3TiiV3ELQRxPFHX23JYEPtzrDimS3YVHITYdgN84KsNyxjZVyoZt9xiIIA2/q9VfYEWHWEDalMnqwAsW/npu1aadWZXnH1kijU6oY0ezlheFQqzeDET2WGJOSx2Kx/VJmsPwb5rLJI2paVAzYJCaIp/z/3n5q3FstSahm0MhOGTCGcE09M4+2B7vJoc6eXozCubDluFwYpXN7nODpTqvxS58g9zJzLBuRiU2sgVmO28n9XUk9NRM9039tztV3F+zRwQ3smRlWkm+DjAMeuPgnf4HhDydYt93G1h857Cj71nVp5XUxZhebZcp5zQHVvAMpT1H9/W6cMS3lIsAZJ0+eSwLNvPHU9W+8UbPSlK3YAw/xB4fPHpHA9SoFZ3cbclz30EcVx3z5erCxsdVm95ruUzPh7QTdKh6jXf4xCNgLhj5PoKumIbWE8KRzwOUj1z6fQJydJzhjMQT61PR/GU906iG4BO47y0fg2IwUInEW9QkKa0refQXK8Q98Eh+cRQOhF71JgqVxkTAvREcJHpRDq5bebvxeXUttZw1h0sAOv6K54=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a86b2982-a8d1-445c-f155-08dc3484fd0b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 15:34:56.8077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7UeZFUW3+7cFWNkx29VqWDfVVCGKqRMH9A9qLtiZ+DJQ8FfufInYdS5G3gyqaF+cpnCXz4ZCLgUFdR/NxoGWQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5923
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_01,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=893 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402230112
X-Proofpoint-GUID: zK4UWL0ERln9RpVb_vIJlEZIjoIE7KYX
X-Proofpoint-ORIG-GUID: zK4UWL0ERln9RpVb_vIJlEZIjoIE7KYX


> 
> FWIW, with my patch we get same output for "passing" run upto another hang.

I will note that it has "passed" with this patch, so I sent the updated 
v2. Please let me know any testing or further debug that is required for 
that intermittent hang.

Cheers,
John



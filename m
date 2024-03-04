Return-Path: <linux-kernel+bounces-90195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DF886FBC5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4801F22364
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5C917995;
	Mon,  4 Mar 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RqCt4Sc0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p6bN9WKW"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E60171A7;
	Mon,  4 Mar 2024 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540579; cv=fail; b=BiYcspqEiTsUow/SOKucW4FPyjQBIgPOD4fhXyXplUK0j9YE26YNdqu1nooUg4zpoj37OocKPEfLbVWjJC7ZBaEfWH58z2Pu8RBfMBWcUpuhuA36HrnnrLhAqoUgvwvTqOHd6/nXPbsYTgBCZFt0PpbCD8t9h3u2P2UWg+QKK94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540579; c=relaxed/simple;
	bh=o+Vm4ZPN3XLf6Uxx8vze+WIkbsoGosCn/Il1n16xrfM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=edIPOxLvfS9TQVlPO4dsZsXih1GZ56+keBR6ujJ5v7UxD1gNm/xMBIySInTGmEoPT2e3V/hzPJB+VHJJY1xjwv2cdDEAYyEvyNxBxOPlSy+/BU8EdSm5Z5g8Q4+SWj32yHfIQXP250V0yrHLXkpkwgDy8OO+wcZrAD9yKMMe4rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RqCt4Sc0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p6bN9WKW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4247iPR9005106;
	Mon, 4 Mar 2024 08:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Kk3xosX5awLpzZvsENBlbCYJeyzV7l/sL/SXeK+We3A=;
 b=RqCt4Sc00vkjJHayN9hhFPd0HJRuY7ah/VqKtrxhlaz2nvEd8edB418X5c4p4lT4Ub2W
 rVA/nZmN+LGuUm4gGWTWPmktxHCKwvyZSHv9RKoXYlEnYcDc8wSHtr3t/MiZRpX8Z43M
 LX2kFiTxDpX6j6JH8UROs+bZULG5FM0ip9knP7nHP4XGJ8O2K5F/hFjmYD0UkprEDBV+
 U21vMdP/t4aOduRx0Zoy5eskwy+DT9pdGSYs2JaPKDYOo/74XifKyg1Ok5bbLshuAZ52
 C9Vnqd6bya3XhyTiP/ihmhW1325syeo3BU+CGKxzIJbVLmaLeY5kWId7Ww8HxjbZzoPt lQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wku1casvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 08:22:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42472ZXW033258;
	Mon, 4 Mar 2024 08:22:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj5sa2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 08:22:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erzxkm5UFrcQqiabZ+AtNbYa4XaimG6TVMBEhWwVLscr9eX8/oj8nKOEX4VbBMeyB5w2o0jslbWZ0ihqBMWBJKD/KapZ7boqHt61SRKTnQZzraVwpxM0Y3EH+pKz7TPN4KwgiHuyjaWi7qyjEmaypUinEiUzF7PSn2H5E5SEAp8qd5OgJeLBz7mxPSqk+cY44m8J5Z6hJAS7zEzKBlzY4gG8OVJwbGtpSbAHCMZOs1/+H3dI8VjfoKnwIAh/r+oUKuEbfyYRvZgIYw1lgkbVTa5ll2AmygoLsERmtIXKkccSXXxwV2zIBt1LFqCR4JPLqEytwbf6AUwqNzAuc02DYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kk3xosX5awLpzZvsENBlbCYJeyzV7l/sL/SXeK+We3A=;
 b=SSXlAFIHdYda7G2jVQvjbyOh3NZLAfwt1/bCFND463lSoYlJCRiJ9OQ4FIUGYgjLjdSL6xtqy4cI2h7AljBF6bZ9/iAtZodzzFwYQfJb4A8BJq1Cp1G8mR1SilB1BfStvxz50q5Btf3WXZTl39YBLDslr3IBkdNeAEoDObY/hmdErEgLaxVU1XIsg8w7NMGM3BIZj7HFbg9d2TUyFp0naPrum3diqbGQYDS9f9kjvYNxuXEgcg9E8zaX72ZFU+2qTs7gdmpP2H1nCBE7FHb76pRz7KBu2EhtD3BMatP0s1AMIgO0GKVthMnJuJXfdpg013dRJ5SpDf62A0RzzIL6Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kk3xosX5awLpzZvsENBlbCYJeyzV7l/sL/SXeK+We3A=;
 b=p6bN9WKWN7YY7pFbvCy5juPSMmHGXeN/SAo1YJAPw+qtR3fHvEOQybgEsUq4lg6HZV9gxNadjrknYlAumuWBOjOzmrOlMIGOL+VA9TB2724M6FhQijaVPA7QLVbH6sqxoL7pUhdb6BL0/3cUoLwnvz+fbqweCuH4AuaYQzmBzvg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA0PR10MB7206.namprd10.prod.outlook.com (2603:10b6:208:402::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Mon, 4 Mar
 2024 08:22:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 08:22:37 +0000
Message-ID: <910cb9cc-6041-461d-b010-a01e690f42b6@oracle.com>
Date: Mon, 4 Mar 2024 08:22:32 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] scsi: libsas: Define NCQ Priority sysfs attributes
 for SATA devices
Content-Language: en-US
To: Igor Pylypiv <ipylypiv@google.com>, Damien Le Moal <dlemoal@kernel.org>,
        Niklas Cassel <cassel@kernel.org>, Jason Yan <yanaijie@huawei.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>, Hannes Reinecke <hare@suse.de>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc: TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240302201636.1228331-1-ipylypiv@google.com>
 <20240302201636.1228331-3-ipylypiv@google.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240302201636.1228331-3-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0221.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA0PR10MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: ab7e8bc7-0485-4091-569d-08dc3c243fe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nKVmzqsnQEGPAaH+LDnSGuiCk7JVEszl0P7lDXV3vzGKvpUT1wp5GFxe6PZt00SeHzMyKEft5XkGYW0joZEY/6R1lKzJoDR3AYwWqQ1VFadeX6fd5Xb2cGYugza16cTE38l4MHMkJAhgIdyti/k2EnMkmAdOHEgmhoFWM15Q1iMdHPHxDPTJ4hRE99Mb/4cNfyExf5COwQc7NZTvPU5OLKvtaPVRSH98SbpVN6AkXvVPpGnFtvMuqqf9qIddAvI6rt2y+99npZ+7dLJrAQL78osI4Ux3KpYVDGZpk325iZUIng5dlSEE0g5VHpOSBiiCsqzSkEmyiPYIaqGtsE1LN6+nUbNZzqIxZKnd6TEd2ZvDEpAxlU56xlbIrFbt4pPEZVR8710i5btS+s0RtMJaVge2ruFALAN/yR0bCXVcUcoHnx9FPJlizDgdKk4J4ONU6sRlgEo/iuxwFkHGPcgVK2DjPztMPF/rS+DdjTR64Heqe6HGMy67usgJPmGhD0ITzHk1HXIgJC38BbZ9+ylnnxL0er7cglXIQUikggXPO1+Wy6SIHXmUJanYoWC/pOX692N8urMfFwujtQVTptzYv7snKsjZKhDw3pzIstqlFImdV9s7JdzMh6Jk6+78ige5FcfhcY7ZYNm7E4ym37aibHhVNEgeU8DY97Xg0E+K2NxRnrGnsIOZhjgbjnJJo4J15sblzKRfz8AP1Z4Gin2Xmw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QkRXd3o2V01EcWNpSDBxbEtUT3VFRjZWLzZlZ3hlOU9QUEE3L1RlVUJFKzBp?=
 =?utf-8?B?ek1GbEMxdWJvVzdGcDNxbzNMQ2F4K1Vqd1lZa3lkdlFaNm9ja3pZbjBvamJ6?=
 =?utf-8?B?YVUyQjdobm5zUXN5TVE4WTZJM2loc0RDMTZ6UzNsbmV5VDJWNlVOM1FFeHIx?=
 =?utf-8?B?NXJTcjlZa0FpTzNFRUNvSklNdXZTcncrQ2lSNW9lRmZMeEJTU21lMjhGQzlj?=
 =?utf-8?B?UVF6Q3NFbjNVa1JtUWFQNkRxZ05xMjc2dWFFeWFncUFNc2xUaXFjazZTYndM?=
 =?utf-8?B?bkxicDdrMGhiTXo1TDZPdmFXMUlhUlJMY0dBOTIyY3lsNElHeW1oeWR4SElu?=
 =?utf-8?B?SGR5SVlnRjhDT3pZZ1Z3aWRYVjBlV1Bkb09zaVFjY0dRQkZER2ZwRzZhTUls?=
 =?utf-8?B?RnFyeG1Hc0F5M1A5eUhaNDlTZGllTVVLd2NwQ0U2Qy9FNk5yR2c3bWw3ME5q?=
 =?utf-8?B?YnowOFNVaGRBNUdseXFBTmo5Zm55YmVJUkhKOW13KzRLSE9oTEJiR3N3a25Y?=
 =?utf-8?B?VGVYYVpNY0Z0ZXR2ZFh2dDFVcFZyMWxaSU15eGp4M1cxdVlGZWNTWmNta1FN?=
 =?utf-8?B?a2R1a3ZYRE1POUM2QVdvZ3FzYUNnVlM4allyTFdRaDMwNWFPWmkxRDZBZUNW?=
 =?utf-8?B?TXlTdFVXMUlPVDYyNyt6TjRhU3pWY3A0MFMvZng2UmV1aWhiWnd0SkZXbm4x?=
 =?utf-8?B?OWZyUDNSMVE1azF0bFFwVkYyQVhzS3RvRzZJZk0zaldXOHJKaEtFWkMxaWc4?=
 =?utf-8?B?RXlERnoxWjVwdTBlRnJpOHdhSlQwZW41UzNkY2pGcThJbklVbURka2JBcUZr?=
 =?utf-8?B?Y0ZrbVpGVVcvMFZzVkFLbk1MZHdCZE55UEh6aXZaeUNsUU1oS0VtUjdndTRo?=
 =?utf-8?B?YmM1dS9TVVpvTXhDTy9tT1pFZGw2NXRmNHFuUzBmNXdQMmttQXFjY0ttK2Uz?=
 =?utf-8?B?TGZYeVdxWGNDeE5KNzU3THM4cFhGRzRFcSsySENleTdRQVRLSHdEWUR0cWJn?=
 =?utf-8?B?VTFOYnVUTWFSUjlvWkh6QTQ2OGFVdjYvNXVOdjl2eGtKOTAvR2Q4czkrbkMy?=
 =?utf-8?B?b0dmeDlrT1lpeW9zTlNKcTJTd2FvZ3ZvZ2JueDNaSXJRUi9NcTJLcmpvZVp4?=
 =?utf-8?B?OE5FdFlrSThWSTR4VzVVTHdNSUs1VmQ2clhvRWR2N25DSUlkcWl6ckc0dlh1?=
 =?utf-8?B?OVBQdEh4OHVIOTFVVlExWGxlUHdTRUpyS1VDWVpiSDloVmgwVHRpRyt5VWJF?=
 =?utf-8?B?ZUdLVDZ0L0swcVlMUjMrbnRNdkhaeW9RVVFad0RBMXRsTGFHMnpWQnBXdi9D?=
 =?utf-8?B?bGhHN1E1eVNIWXhzNFpaZVlzbmwwSCtxM0F3RmRWeFAwMW9CTDV3bHFraEFT?=
 =?utf-8?B?RUUvdW41dXJuaC9URzEzS3FKUlViTkM3OGU2S0Rwd0dORWNzY0JFM0Z4NGYr?=
 =?utf-8?B?STROMFNxR25oTkFCc1lSdHBOa2JHTWlCSFVQVnZ4NjVJSzFuZlZJZWw2L2tC?=
 =?utf-8?B?UWt6M3FKMjNPdDRvb0VFb3ZxNVBtOVpFOVFjR0Nrd3V0OUg3c1V3ZUVvdDRh?=
 =?utf-8?B?Sy8zcThkL0FTM3A2SFBxSGg0MUdNTjBYdjVRY3hCeUZvMVRFdExsaFg1SEFG?=
 =?utf-8?B?WkxYUEFkOUZCenpUZG1jYWJ3NFZObmpPWFR3TmZpZHliTTZ6TFJlYk1VQVo4?=
 =?utf-8?B?ai9EU3AwaE5RaENvNDJEUUIxR3JmaXdlcFVMdWNHNGJKYzdydkQ3eS81cTl1?=
 =?utf-8?B?NE9GQzNaTFVzZDRvZjVDTHhzQ0VUQ3h4cjd6bE9ObmR4QVJwODdxbTI5UzNw?=
 =?utf-8?B?dXhUaTZDN1crSkUvdnc5d3JxWVM0N1kvVHdWUUVmL29LeGVuSEFtR1ZwN3Qw?=
 =?utf-8?B?ellUbDhHMGNyM1Q0S3VjbXVxRVl0amtVaUZ0NUpNWlpGZjRtSnZOdWRaZ3BF?=
 =?utf-8?B?VG90Ui9zTHpsOXMvODNFU0g5QTRjNVlpV3JYNU9NNDhVRWV6YWVrME1nYmRm?=
 =?utf-8?B?SUN5c255NVZodXJvT282SWRmZ3lnSXFSMXdUdlB6WUhmcUpHTXMrdVV3NDA1?=
 =?utf-8?B?Y25vNmYxRnhmUmpGZDdzTitoMWpuMFBUYlo1akd6YVBqSm1SV2Jqbzd2eHJ2?=
 =?utf-8?B?cWZydGMwa0RkZVBHVXdYR1h0cXQ5S1g4cklkck1jNWkyb0FtWmtHclUvRGdB?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ruT5cbqlXtwtQehH9eV/A41jFXAvFwHQdh2GxaqxgaQz0DRvIuBCBxw19w2vlqX3M1XrXfsqwPn+kryZSJFiSlhyeZFBm5HgNBOt6tMx8RazK3fALLQ4R64XzDpA1FKJPiPWF/I/OiZHrgb1wwkhFt9sRugBESwW4SwySd2WbnHQDLBhY3/dPxA7ycUE4z8V0uudh7gBknbBD2QZc266VPmF/IWd/tMBjnfYOG4IDJ+Yd3HPbhzHJWtseLlLBGV9mSeBIi5ZF85VAFfHMHEISk/UvVryxahx3Qsi1Ps0vq50oVIYZ1HtTZyj2c9Q7fWmd9VIkrfGLZ4sYrtA3tnOXnNdz1DRCmqIK9hMt/bf+MFohIrShmthTUwIA0ifiKw1d99xWBMj1TgF9UTA/ity/AFCjdK7feAYktuT9t9FTrYnE/yubDKTtz46b71uZcQv1c/GJKj2K88brkjRTflPpfJcuPh611XfTbmYbmHPwcWeTvv6lLrq2MsQ+KoQgXu3y7rhZMfcYlUqEV62YXlkytGgF9G0jwAcPf7gMpX8GcBqvO25gZiZWpIXMtL5uKVF1KPFIcFMvCm3JeNRPIYHSQwxBa+0tWkSkBBiaHh5NZY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7e8bc7-0485-4091-569d-08dc3c243fe6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 08:22:37.0370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cM0owcT8u55z5J60ManaO4PGGQBcdUSa7AxFxuLeLkjZxSpfl8xPMsbL7r4i1DbaPdlhai0B8Bz5FmRSL7Gyhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7206
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_04,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040062
X-Proofpoint-ORIG-GUID: JZmhUHxodMsg3-lgpCAzVyiaKPma0SPL
X-Proofpoint-GUID: JZmhUHxodMsg3-lgpCAzVyiaKPma0SPL

On 02/03/2024 20:16, Igor Pylypiv wrote:
> Libata sysfs attributes cannot be used for libsas managed SATA devices
> because the ata_port location is different for libsas.
> 
> Defined sysfs attributes (visible for SATA devices only):
> - /sys/block/sda/device/ncq_prio_enable
> - /sys/block/sda/device/ncq_prio_supported
> 
> The newly defined attributes will pass the correct ata_port to libata
> helper functions.
> 
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>

This looks ok:

Reviewed-by: John Garry <john.g.garry@oracle.com>



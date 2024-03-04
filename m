Return-Path: <linux-kernel+bounces-90189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5935F86FB8D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2B711F2200F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D17517BA2;
	Mon,  4 Mar 2024 08:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jMXwfNhi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fcjhPAEF"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B74E171B0;
	Mon,  4 Mar 2024 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540331; cv=fail; b=ff3S8NrIsCTA1cbuDMKbKYpgWA1A4x8q5vzYVLHtyDkkktNkO61ZXgTymOxXcsbFAxlbZc8VxT/k8DtOginMNXW7LgmWRVFOala+FDX0CacMVVziFJkBbGxYpeIyHKO/u6NgXvsFo/5GlTe+qP/RTpKoTwp57IVCdsYRSHnIwYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540331; c=relaxed/simple;
	bh=3cfHu5DvwQEP6vfIpGR9a6G9vTV7T4yBNz5sDN+BUHc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pqNIuYKz9pbpjZUPL2dI1NjChYFqpSAJqaTaNGW0Tyl5Nwjzda4xDbZecYzboXV9lA6HppXDYBmo6MW2MPV8nD3gBmr6009ubc0Z5WD1SXvyYxcJx7PTsrnxKu9M+qzr4OzO71wGTPKIlcN8Lr4BGr3WR/HGkofc0gZikE/P9ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jMXwfNhi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fcjhPAEF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4247iFIg027366;
	Mon, 4 Mar 2024 08:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Kq8/cNWQ9SgHGl9bGzIcmIi9ElVPzkVYLMVRXAa1d/E=;
 b=jMXwfNhiytBaVaV88az/d3jey+P1F7QABAx4izZJ6MfwXzYJvFqGY9WO2qvK2vfi/y+Z
 GdsRJ8rvKsN4rN2ROHvMShAFAThHZ0l/pZGGQe71/aZEPL2/IiEhkN5sXORv7SnYqJ+V
 pW4asUDWS4z2KAD4B9d/g2UyP7ynlkY5f5hdh+sz+fmg/bZJwnFaN/Q7E/2mjaVIgl8F
 lC870SC/h0NDfkYyuoV1VoxxxKDOGMX/56GeNbavG//FjfJjW6tNt01WVFalia2Pnmat
 45esnRCCO6lvJiXfcid46EFhcdG8EZxj1RSSNRrRnNbvaVdkMRjHR3NaR4sLurJKGX3j uw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkvnutqg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 08:18:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 424715xh015355;
	Mon, 4 Mar 2024 08:18:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj5pguj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 08:18:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIl5YHFF1L9iz+aJio6fsuB4qEremZPjwIDSvm2hQqJyzzy2JNA03+Yc/UN0qPPOgSftdghNaUoRCrs3Q62YXgViclFrugOS6EDhYrMbTUhylg1fXyKCKs6g2t0oVEmKKwktri2MMcPXdU/Et993iOOm9zwuALow53MQ/pUHSsl+vbalMFHl5oqBl3ojsQU7LBmvXDeN8i9cp2t18YLxroIe8iqIVpXrmE5Hfmmr506J/k91l7WdTcaFFEPGl+i9Om7HT1O+srRB99owqipYMlge4s0VWL0OnCbu17vuSpEOaVcpVEse1I4Q5FG49xUIkodfSKH9Jgb9twvFYT4yeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kq8/cNWQ9SgHGl9bGzIcmIi9ElVPzkVYLMVRXAa1d/E=;
 b=czZdUvQ5fMqJGhLyj/AXTopFbFPfYTCAKD51cRoUZhyqcFIhVDpfgPda1z0VR60oqkTzgQMVz9As6o0vHKokPoj2SwYf30C8EEGNUTcDjd3liM7F0/sIsvaK6rhuq/htPkGZVd2ltgcN5zfWIVNwR1t1tgJgktUgQtjU3eQ2P2qNm0fXg08GlBO8s0kud8AuDi2GBKuddf3ET4tr5+5u51jCSN+guHd5BxIR4yuzRVyNKeLwjlysEewPMrk8aqUUJayUOCi46QD6qugNIzvuuRYhZQ6X19ZS7p3GAzFxjTGYcGIT86RziY6q8vaYCO3wBwTgC4RdVAT1+P/1t1FYtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kq8/cNWQ9SgHGl9bGzIcmIi9ElVPzkVYLMVRXAa1d/E=;
 b=fcjhPAEFwqd/o9r/4ir1d2b/Ra16UtUwqOguvK+pIH88COZ9PfEE7dkogBbGdWdRJmXuSKn2UjDnuqeWVw0/dMLDkuPp5glW77dQiq3fhgNwDlt/KiQu4m9xC93VDHFjUb/IMFd739m4G2hf+X32ilLq/6ueHysYiFw89Qopyhg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA0PR10MB7206.namprd10.prod.outlook.com (2603:10b6:208:402::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Mon, 4 Mar
 2024 08:18:27 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 08:18:26 +0000
Message-ID: <b6192786-4b42-4b87-adc1-5bf1bbc019a1@oracle.com>
Date: Mon, 4 Mar 2024 08:18:24 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] scsi: aic94xx: Add libsas SATA sysfs attributes
 group
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
 <20240302201636.1228331-7-ipylypiv@google.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240302201636.1228331-7-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0213.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA0PR10MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: 787d6dd6-0812-4b79-3c59-08dc3c23aaa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dLrr+snq8miLd32/fK9HGxKMmI/C45aUINvZMaPF3o48t0xmLDs/vJtmZxxo1Rg/Y+Alcz4Vy7V49MWpzf81hl11rPtVQZkJwnFQUIXhKTFEdJm4tUGpapkGZ+K24aP92Js1xadeMVuIU16M7QiMG8/N3go040hleRiAEbd3B7OujisPbR+LsRLoKD+VkpgV+f66f/lCuswQZmxU5P027S5Q2DW/rA3ulMJat7d0fBnVctmL+EWiXTIs4Dwf7HRAJQ7F8GGpnYQqPDbGL2HlyJuC+y3WS7bfc/xUsO33D9Yg2sEMujboFoVnConZGsgoKVCav+GBZJgwv1BCEzgjcCZuHH9BXSiW5/bQHFcIHi503PxWMumCUYaatUXXhy+eudA+mleUN6E8t7jd57FAES9g1VzaDEjFIJxL7K2QCL0k1H4pAyJ+rdBPt94dP9dvJK8om+PLK48WFE0bJFC1iA1bfkBYDSVBHww38UF1uQsx9Tm5EJyIEisGH1xXXRiVwBp7/Wp6NRXK1c3QdO3wP9s6pooY9oaJ3r9Wtywa07RBfZdgE8SvIq5R2Pl6iAJgP+c8Q1T8B02paiW+mQ14ccvjE96XGZl3JVwQae4vMmA92SayCNxXGpkDbNbWa54jeMN/Q8liOWS7lMBOkur0rpVpwdu8sYOY2MS/zV3O1eNir6O6WJWN1bgs5cpUYu1aUZPqfXltLLjRGGQblR4VtA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VGpCNFRZN29VWm1WYVhNeXhpZHlkWThRQVdMV0pyMWVOWFJQV3FnMVR2dCtr?=
 =?utf-8?B?Snp2MmxLaER0ZWw2SjFmNkUzVmZVcU5MMkJGUHROd2RKV0YvemM0QXM4WUdU?=
 =?utf-8?B?aWh2WG5rSFo5OUtKWitzUE53eWpGbS9nSHdDalRCbnhBUitDZitUb2RacEJs?=
 =?utf-8?B?NHZjR0FhTFBDaVR1N09vbWoxRU12dmVXNFAwWkRXdjdjWTZhTS94Y3dzWFo3?=
 =?utf-8?B?azZTMytrKzJqTWRHamRweWdkeFJuY0pJdmdYcUhDdWk2RDAvMXU4aDh6amRU?=
 =?utf-8?B?RGRoWnlyaWtNdzhERW9RU0ZiQlRhN1Jack9UREk4MkhKR3IzVUdsOFdiamk1?=
 =?utf-8?B?Q09uelg3OXNSbTJqTjFGeUhLVmY0dVBZOUNSZnlaRkdxVzVLUDRQRUxnaFhJ?=
 =?utf-8?B?MWtvVjIyTzdzLzNyaUxhdHdpYjZDTlFpWlZPTld0a05RTEp0Z3ZEUnVCZE5m?=
 =?utf-8?B?OVF4NmRrZEl2M2R4VWtsZkthQ1R0RElZbjJCNktBK0pGMmlxVHc1Zll3NHVZ?=
 =?utf-8?B?cFVHeS9jZDRITjg5QjhKcGZLRldQRVhLYUtsVVo0L2VLN0RiWFd5MXJQa2dS?=
 =?utf-8?B?cnZ2WGdKdzBnMzJCeXZCVXVQdGVSdUdSRmQwRXNkaUFPWnVvMSsyQUNNVnQr?=
 =?utf-8?B?RVMvZDNubWFFUTFjNnhmODZhbE5aUFNGd3g1RjdXUC9WSE9VZGZWT3d1WkdB?=
 =?utf-8?B?dUVuR2I4ck44NXNiazNIcWl3dmFiNi8wZ1hWVFQzVDAvNnlQUVRJcU4rUERL?=
 =?utf-8?B?N1dtYUFHUXljQWxhU0c2WFRGcGhnd0FVVW55UzI1MEZtUlN3YVBlTVdFNkw3?=
 =?utf-8?B?NEJUckEwaHl6Tk9vUDB4WUxWcVV5ci9mYlcrQWZUQWFPY1hGMzMrWmJ2Vjdh?=
 =?utf-8?B?cmFEQ3VYVnQvQ3pXS0hDaVN2UXhOTmxmZSt4SkJYWDBOTyt0VzlrMUE1VDFD?=
 =?utf-8?B?eFFrUTNjWXRyZ05CbmRkaGZVS0pYMFJsbFl1Mzh3bmJOejNzUzJYWjY0OHpw?=
 =?utf-8?B?cFlaQWQ0WFpuaU96UFRySUhOMVBjTk1jTUVTZVNTZ29OR2dCVmlYMi9Ob3VV?=
 =?utf-8?B?RGUzMEFuN1hVWTVCclB6MnRyM1Z4VldtUGlBZlRqeGl2cWFZSFlLTndQUmhk?=
 =?utf-8?B?ZE5RajRsQXpxVHZyK0Z2WGpqV0paNVI4RktKZXVvWThTR1pDblNiWGYxWkJE?=
 =?utf-8?B?eXpuU1dMTWl6aUJQcndGeGtyK1BwbFpqUytJMzBZVTVGd2JUTzFFYVo0cjBV?=
 =?utf-8?B?RW9ZeFV4TGR6czFDMVlPSFJmQ204azVqNGRhdWZFWEhVMlBPaC90dmRNWFRq?=
 =?utf-8?B?OE96N21QU0tJZERPTXc1UFRWaHpHcWE5OUE4UzZsZFJqeUxrOFdFNmZSTmpV?=
 =?utf-8?B?OUsyNjNpZGkwbEE3TW1iWGZJWTFNcFZrWlpaVDM3QjBvVU53WmNwTk5uQUNO?=
 =?utf-8?B?am1PWHhaeWVua1NqMTl3eXQrd01lZjhZeXM0NzQrZzAya0NoZXdLOEcrUkw5?=
 =?utf-8?B?THhmUXlicjVTcDFkaC9vSWZkdzBXRSs0UWlHNnowaHBKUlF5V2FXeUJYc0lB?=
 =?utf-8?B?TGtNSWxTQ3djUU4rSjBMZmpacEJGTVpQODAwcEt2eE1tRmNIVm5VYjErNWRO?=
 =?utf-8?B?SlFHRmNPb0VzSTArOVN1SkEzcHRVQnQ1VkJwZlhYeENYaWxWWnJkWWQ5VGdT?=
 =?utf-8?B?bENPWThwZExVZXBnYmRxWWF6alVUK2dRUGowTjNDaXpqMjNia0w4NU5lWU41?=
 =?utf-8?B?aFdLb1NMUDRiWkhMYjJOa0FueDZSZ0lxZ0NNNXZ6SmJVRk43b1ZiazUzNERx?=
 =?utf-8?B?ZHIwR0FLanZIbFRISEIzVEYyenA1OGFnTXVkQUxXVytzd2RZZVJKOW5FSGNh?=
 =?utf-8?B?dDlITWJ5Z2owOFZ3RXJBUDBIOUVnU2ZDSjJwc0dVekFPTjV3SGJ0ZU9FaW1s?=
 =?utf-8?B?M1luRnFmUVZhQytxRWJMLzdETmlad1BQNStRV0djT2hDbnZoM2RObEZqT1I0?=
 =?utf-8?B?NVJzd0F3SFZMWmg2MXdwM2RETVg0U3h6OUlLQmtJTmlsV2Z3VjdZeW1VbGlY?=
 =?utf-8?B?bzFvNVlzeGNrWWJXQXhoaE1DZE1xSmpFMmttaHVocWtXRjROWjZSR1Y5MlBH?=
 =?utf-8?Q?2GmXdVQ8IHXwKUCemSp6U9csC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9lqU6GfF0VJ5VCOZ0YjAbeqhCsL71E7PBgCu08k/wUbCV2dDZwcmqqg+7kQwp/R5dG+rbCjiTfo3XIBIXkDmJV3oP3MfPmbf95A2FeUgF2htnKXZI9hWCJ5gzfx5r15yGnnO3sC43YbNRbDTjoHLwg7A9RT0v6xvXDyvJfy0SvkFZZgwdc70YaF0FFQhQZ+TnTCleFYRcL5cVJSpultghU17VEocjCiaBdVDXrJbGfuiYTnRTuW2Jqg8NBilIgepYv7QkvjvvBZ3/C67MA9OS7kE9/30nsMgJprW3B5u/3JDQEMWHA++OttU9vwCI/TraiHsRXL8zWlluXLOogMKB/ExdEcyGWUNHdSPc2KKK9olUNfiyOmp/VQZP7HSwY65XTwcWcIwZ4f+zHOv84lA0VL/zp1Vd7nU2CkKyA10FJe5kIHa+HdPyAqQ+ICuyhW4w3ulJoAe0yO1FcospixlmDHYBRzJP74JVoeWINlK9HO5p1pttVOIg5V9wc3xtN0C04/+xrdAQERBfYPX5cHVbpa4KDvEKTZdlEMdmDx2HOpMpz9v0MvUF0IQ3FKbPSW8ZjwGfCTS52RyA6+38dEj37D0gzH2x4dP2vTzzqiNdF4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787d6dd6-0812-4b79-3c59-08dc3c23aaa8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 08:18:26.6209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2YJ5Fsw+4ZFKIDBGl5aHhFXSVMFY7camaKm9n3Dzi+DhIbNFb7aQM0EDdxacXoLM06O5s8fls9sdyt0hIKySg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7206
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_04,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040062
X-Proofpoint-ORIG-GUID: vAqvDVo2Nhuz9IEc5nSJcmYE_nQjVbCN
X-Proofpoint-GUID: vAqvDVo2Nhuz9IEc5nSJcmYE_nQjVbCN

On 02/03/2024 20:16, Igor Pylypiv wrote:
> The added sysfs attributes group enables the configuration of NCQ Priority
> feature for HBAs that rely on libsas to manage SATA devices.
> 
> Signed-off-by: Igor Pylypiv<ipylypiv@google.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>


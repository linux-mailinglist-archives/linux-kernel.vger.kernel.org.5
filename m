Return-Path: <linux-kernel+bounces-84657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0556F86A9A8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B071F26E4D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D2928DDA;
	Wed, 28 Feb 2024 08:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="RR9sb/2e"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FCD28DCB
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709108140; cv=fail; b=VUQ/xaMNxVBs+9OqPDb25B8/A6lHiakaVOEkS0OfjEZbcmLi37fn1Eg0UCEyFUM8gAfGssEgAMDYMn0KVgVfEoZv33R1Bula3KG1tSkmb81dUL39h9O1K+jUF37QLomApsa4gu7Ae3XgUMtTKwgUAtvQqaxLPTMseptCqSHi8s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709108140; c=relaxed/simple;
	bh=PQwHYNalnI51APNPd6YF84Xyzw+FIUu/vT+4H2cZf/M=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hwc3tTxmE5RAkbKq42ObUCKMwajrGWzN6siD8ROEtUuIDddPeiMZxyzcHYr8dVPUbI//XPXeQh/BGKrMMvoLcUVyUN4P1wZ8UNUTLGwvjinZlHEDc2rsbeHvlq5M7AXMhVeWMyrdUJMFaOXYLNTv/hAHJ5wOyYJM774J+xyFZuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=RR9sb/2e; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S5g3tL004493;
	Wed, 28 Feb 2024 08:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=message-id:date:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=tpUlE4RvX4RkbqwXogeqT6ua51X2kEJRcneDutyIH2U=; b=
	RR9sb/2ez+oEIJ4FQtMpJb/hw5aYPsMmJ9BspkOys3+eYGv95IGKEfwNlZKUUNyA
	1T/n1LTyEekB6TB3I4P6OfMfHxc7ppGKxMlEgqYh6+t1JNm+HNyRAYIngDmCkFUI
	vKyL7KExUlifsYmJXZFtoQ4G+babR3z5DqptCDerdKQ6n6GWBDsqwOJ4bAl3N/Fm
	6bdSCq2d50MWQbhUekPeWgNN8wz22FR87jZb2ovRs3dX9C5dZSewPBxeUp+srfI1
	kWiKUIOGZBAi+U02lpV/EWUqeWbefAhWrNmH5gI9qB7oHmhCZfAojxNrOY8di4uX
	zCfqk0EozEMF/O7aV4RfkA==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3wf7e6c2eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 08:15:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pw6/7NeJrAZ2moG3yg6JhOzHR+Akrkqslnktz05/L2ZSf12ME2xVWp9jOyxSwi/Nz6shJD2zaiKkShnuD1EfJRn3+fh3XALJBoaMXu0T+u1PsIW88dQh+FVMBu28BVRGXHzCxf9NZd7DxFj6lja9evLTBSCbhfp3/qW7DzfM1s3S9yFJSRpgcH6i9KhTbiwm1nGIgUhl7Da6zYFfFbF+i6LWBxi8tyGSYH6gLwDUrilzfAHDp5OkkpH5axMPyPd5/RGX57apZpFFOnriF3hRPNhuhGSEw1kE8zQrZ0KRSbTsCX7ve3DG9IriMNQp+NcYOl6BdRcFzm4iOVWGIEkOxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpUlE4RvX4RkbqwXogeqT6ua51X2kEJRcneDutyIH2U=;
 b=dRx800q9txOO866+IIjOmFBiiD6gv4wvPXX7TCpU8dZ8EzPOVlLdLwpIfNM4/Q6lm8AChC3MZZBGNO0ZLmK+3jvQ2FgyIWzUR8mBwvWy7ZGllYKHsX3Om7UmZ4OvQRhFLQToAQVwTc6TDCluMZ0688VaGSucYcImIRaKM7C9NQ9r+xcFTISN8Lt1I2HUdakwV1+/0xAI3w+dUjAqGWeuxX6VNIOdX0dubzJQDGDgo3NI5c2Fo+n8y+n8+Zg1pe+rKCpUaeXRGA4HiqyCCeFdoiB/b4ycxVcDD4hrnNynNv+HKUuMvAhAoQKTNiyqveRI/weeLJArRpYp031+rCuXuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by DM4PR11MB5278.namprd11.prod.outlook.com (2603:10b6:5:389::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Wed, 28 Feb
 2024 08:15:09 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::dd99:4cb:332c:944c]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::dd99:4cb:332c:944c%5]) with mapi id 15.20.7339.022; Wed, 28 Feb 2024
 08:15:08 +0000
Message-ID: <cbdab268-d1bd-437f-878f-8cad1173a55b@windriver.com>
Date: Wed, 28 Feb 2024 16:15:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/slab: Fix a kmemleak in kmem_cache_destroy()
Content-Language: en-US
To: Vlastimil Babka <vbabka@suse.cz>, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20240228030408.2740647-1-xiaolei.wang@windriver.com>
 <303e28cb-9c9e-470c-bee2-b7cf4b12e810@suse.cz>
From: xiaolei wang <xiaolei.wang@windriver.com>
In-Reply-To: <303e28cb-9c9e-470c-bee2-b7cf4b12e810@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|DM4PR11MB5278:EE_
X-MS-Office365-Filtering-Correlation-Id: 50ff0c5a-0fab-422e-7613-08dc383560cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EZkkYnnwewpyESQYiM2mWQrziDLfbsYv0DOflxIMcxCLL9aODlndqTiwmC9azqpusYVFlNcpXejw51rZ2o1j4Ye8jCXDyqzlkl8RH3BGi5j7HDWVsyDhNrN6fnlvJ1kgC2PCdpqeYLmGukHR4YJya0OepJmhM/QCdHDuh6qvZ7v6iY76HgU+0V5mn0Z60I53Pp8/HMz9e1FDxZlWhgyZH++uMTbEIHNQQoqHF1ehRWs6b4z+9ToszWuLUzNwtUw0EgYBOLBZQPIZ4hGoEvmdMIS/a8/2Xlc5WMtxFUakRj6ezLo8s3K6N+aWEY/rqa8YOf8yusyRYgYoehaGYBlkkTl01ba1jLFCSv21eSSMC0w/IX7++X5v21ecAKg7tU8buhmLff3st2o14/apDn1BUxExj66sV3E3txRIyHNq4sMbkX1AExZILsquUeRQ9e8d3DpsNWUOqbfQcssuIUbHSLLNTU8uFhqTFK2yF4uFZiBNSdZcnbZsj96jitjnSfUoE/QiRC4m1AB4TgfvpmmzOT9/r/alV4jZqCBlngLS5jIy9fp1kwrV5G2BZvjuo5mzalVXylJYkExkgklVyuOV83Dp5BbU9eNwWUQlVzwTDx4stY/VN/GEfSMHPJ+SR52kmUDGG7+u1v7vSh8YDb/M/1DXZ3gT2C4wTiiJLyo8T7Epm30vZIRPLb4X0QwfHvdjgRRigX43xfzwQQnS9TdKdg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QlJsY2FkTktvampZTjBNVUxFaG9qbis4RGlUUE4xRVhacFhEZ1I4ZTFYZWF0?=
 =?utf-8?B?YkkySEl6ZlZpTW94UmM3Ym9pUEhnWW41QWx3VHJoeVRWbVpIeUZkYzBXaWZ1?=
 =?utf-8?B?QVZEQ3FKZHdCSG1rNGxaeGFqUXIvKzNBZ2FZV1V0U1h6UnRqT1hZeHRDbkFo?=
 =?utf-8?B?NjQyTEtyZUVvUDdOaW82T2VKVWx2QTlML0dpZ3JTRzZyRUJ1ZDdXc3FsaFFC?=
 =?utf-8?B?MWpSbXJpWDR1cHRKRTBKM0h2emI4d255Q0JPcEpLa3REQm1LTHk2NzB4czJm?=
 =?utf-8?B?d3RmR3lNQk1pN2YyYVFZOFRVdzB0TUYzSzlXSUlyTmlBRTA2ZHVnNjluRjlz?=
 =?utf-8?B?ZEU0Y0NHZmdkYWF1Z213ZFU3amtoT3dhZFUrb3BxVllId2szOC9Zc1VDbWZZ?=
 =?utf-8?B?YjhGalAwZnVVU2ZHa2pQM3d4RGxPK1Boc2owQTF1eXRZbFREMTB6SWFLWnJ6?=
 =?utf-8?B?TzFFcTk3MCtSZlg4Tjl0NUIxVmJvRFhmTTJqcURRZVd3LzhQNDFrMDlXOEQ2?=
 =?utf-8?B?bnp6RUdJNVl4U0trSlRqdWhYRkRHUkdVdnh1Mk5zS2FhWFVaMHhNSDZDNkpE?=
 =?utf-8?B?TmhpM05PNGRsUHJNRWx6TTJoWThXcUdUTFQ1YmZUbEZXQUF2WjhSNzFJV1Rp?=
 =?utf-8?B?K2pCWlVGbldBaUNTM3piSENwUVI0eW9JOEhZa2Q5aDJ3ZXNHR0J1dTBqRkVu?=
 =?utf-8?B?bUw2VzRNNklkclRrVnliSzZNS1RYcGtLWWtvenQ3eWtobFRPWlJCeDROejFy?=
 =?utf-8?B?aXRVQkhkZGpkZ25LZVVDRzRVb0FVL01sMzJxNGZVWlh4RkZXUERrQlZTWEYz?=
 =?utf-8?B?UHNaVTgxbWFyRjVHc0RUaFBYa0tsQXlkdVpQQmtKN0N4ZHdrN1hRM3BTRmpo?=
 =?utf-8?B?dEVxdFh4VmJQMDhVZU0zZ2dSSDBDQll3YWF6NUlpcE1tZzliMGtOWWZ6WHdr?=
 =?utf-8?B?YnZRa01XREFXTUFuWDI0TlpXd0JnMjg3alNqRVdyd0oxVXp0UXVoVE03UHN4?=
 =?utf-8?B?Mi9FQnFlZFRtcUxkNXJOcDA5RGpIK2JoeFQ4L0thMFRJTGNDV25UUzhyV09H?=
 =?utf-8?B?M3hUUXl6SjB3S0wrdDVWbXlETXd0ZStEZElNclcraGxPeGdSZEV4K2Nnakc2?=
 =?utf-8?B?ZGJhZjd0dXdPY3I2ZXZLeDVKOTRjZWVLU3N6VjFKQ2I4OFY5UGRjRXBmb0Ny?=
 =?utf-8?B?aFU2NHhqRFdrQXNYSGxyNWRjTm1udkZPSUV3L2crVkNjcDJxRHZRNlhwaGFy?=
 =?utf-8?B?Rzh0b0JmV0ZXR21lY3MvaFZtMXpuamdQcUtZSlZ4cktDeW5GYldQcnlzN3Nu?=
 =?utf-8?B?VkpnUGtnbnpvNzgrRWIwRTRMY0wwZGNTZ0Voa3NSZE9TdkdoYWxPYXdCdDhP?=
 =?utf-8?B?WUU0NnZjVEZVRkRQMnRXTnZBZUZWSFZCbmVlVFFidEZIUXVyQzd5Uitocng0?=
 =?utf-8?B?WkJhaW9BQS8zb2xMQmovYzRoVTM2M1VNNGVJa3BnL28vV0VwbExuV0drY0Fv?=
 =?utf-8?B?Z2gwQnNZdytpcWNBMFgrSWYrTFRvWUpXN3dIdUtPRFA3L0ZtenVYeGpVY1NP?=
 =?utf-8?B?d2JvRWpWeXhFZUV2aktqbHh5ejVvcDd5aVF1TjYzNWdWcHVUNy9rNFBUOVR5?=
 =?utf-8?B?RXZuVHBTcGJPQTRJVjhJOE51Mm9wWVhWdlRoZkZySHRvN1pyelJ1VWEzaktN?=
 =?utf-8?B?VmdVaTZCWjBpNW15M3Y1SGlMZEhBTWhBZ1JTb2Uzd1p1ekRKNHhCSDZwbXM4?=
 =?utf-8?B?WmFzL2JjNkErSjZ3TVpvSDRHY3NMSVZrUmwwMU9GeSt5M2xQR3JPMUptR3Vo?=
 =?utf-8?B?UVFsTEszMUN0Qll0ZzgveUZ3ekh0WFpaNWExcWc4eXpHS2k5NW1ZS0xOVnBr?=
 =?utf-8?B?UXVGbVhyNGEyYjNuTE5xQ29kbm1OUUM3R1IzTGZyZUoxWmxvWnVLSW9JY25s?=
 =?utf-8?B?ZzlrOTZzN3BjUmlPa2ZjMDNsN3pQdE9FbE9zQVJpQlNhRXF4S1BQZUdYZFQv?=
 =?utf-8?B?Y0hOci9TdVF2YTJzaCtUandVWVBHRWdLa0JJN0sxb1VwTkRGVlQ2aWRkUFBS?=
 =?utf-8?B?SkN5UzBZelhZdUZaZVFMT0ozd1Z5ZmprclJ4b0doTktvNUVYU01Ud0Flc2hW?=
 =?utf-8?B?dDZjZlNMYk9xREpIdURCZ1N1RDJvbzFjY0Z2YlZVeWR2NDVBSUN4K1FXbFl1?=
 =?utf-8?B?Y1puRTlvVVZLeFY2NXA0MjJpSjBLdGhxT3RvelRqTSs2UHNlWXBMdEJGTHBN?=
 =?utf-8?B?aUYrb25wTFZKajFrcHZibmNudFRRPT0=?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ff0c5a-0fab-422e-7613-08dc383560cf
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 08:15:08.9188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gOEYnG7ktiMzGc8sSP7vvratmMUsFgJuQZtzgs5dnPN9f0q/juh0zyOe9IQvGiRYZwjDo6QjGU5Dvc/pkNXvLzyl4gsDU0isz6Z+8JLIBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5278
X-Proofpoint-GUID: q4j1BkZulSe9bdQmtQ8lli7v1B1pTdQY
X-Proofpoint-ORIG-GUID: q4j1BkZulSe9bdQmtQ8lli7v1B1pTdQY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_04,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 phishscore=0 mlxscore=0 impostorscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402280064


On 2/28/24 15:34, Vlastimil Babka wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On 2/28/24 04:04, Xiaolei Wang wrote:
>> For earlier kmem cache creation, slab_sysfs_init() has not been called.
>> Consequently, kmem_cache_destroy() cannot utilize kobj_type::release to
>> release the kmem_cache structure. Therefore, tweak kmem_cache_release()
>> to use slab_kmem_cache_release() for releasing kmem_cache when slab_state
>> isn't FULL. This will fixes the memory leaks like following:
> So do I understand correctly the leak happens when a cache is destroyed
> while slab_state < FULL? Do we ever destroy a cache that early?

Yes, like some test programs, test_meminit_init() or 
arm_v7s_alloc_pgtable(),

destroy will cause leaks after use, and when slab_state < FULL,

there are many places to create cache, which itself also has the risk of 
leaks

thanks

xiaolei

>
>> unreferenced object 0xffff0000c2d87080 (size 128):
>>     comm "swapper/0", pid 1, jiffies 4294893428
>>     hex dump (first 32 bytes):
>>       00 00 00 00 ad 4e ad de ff ff ff ff 6b 6b 6b 6b .....N......kkkk
>>       ff ff ff ff ff ff ff ff b8 ab 48 89 00 80 ff ff.....H.....
>>     backtrace (crc 8819d0f6):
>>       [<ffff80008317a298>] kmemleak_alloc+0xb0/0xc4
>>       [<ffff8000807e553c>] kmem_cache_alloc_node+0x288/0x3a8
>>       [<ffff8000807e95f0>] __kmem_cache_create+0x1e4/0x64c
>>       [<ffff8000807216bc>] kmem_cache_create_usercopy+0x1c4/0x2cc
>>       [<ffff8000807217e0>] kmem_cache_create+0x1c/0x28
>>       [<ffff8000819f6278>] arm_v7s_alloc_pgtable+0x1c0/0x6d4
>>       [<ffff8000819f53a0>] alloc_io_pgtable_ops+0xe8/0x2d0
>>       [<ffff800084b2d2c4>] arm_v7s_do_selftests+0xe0/0x73c
>>       [<ffff800080016b68>] do_one_initcall+0x11c/0x7ac
>>       [<ffff800084a71ddc>] kernel_init_freeable+0x53c/0xbb8
>>       [<ffff8000831728d8>] kernel_init+0x24/0x144
>>       [<ffff800080018e98>] ret_from_fork+0x10/0x20
>>
>> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
>> ---
>>   mm/slab_common.c | 8 ++++++--
>>   mm/slub.c        | 6 ++----
>>   2 files changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index 238293b1dbe1..b6b35bcdd196 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -404,8 +404,12 @@ EXPORT_SYMBOL(kmem_cache_create);
>>    */
>>   static void kmem_cache_release(struct kmem_cache *s)
>>   {
>> -     sysfs_slab_unlink(s);
>> -     sysfs_slab_release(s);
>> +     if (slab_state >= FULL) {
>> +             sysfs_slab_unlink(s);
>> +             sysfs_slab_release(s);
>> +     } else {
>> +             slab_kmem_cache_release(s);
>> +     }
>>   }
>>   #else
>>   static void kmem_cache_release(struct kmem_cache *s)
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 2ef88bbf56a3..9ba59d064b6d 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -6792,14 +6792,12 @@ static int sysfs_slab_add(struct kmem_cache *s)
>>
>>   void sysfs_slab_unlink(struct kmem_cache *s)
>>   {
>> -     if (slab_state >= FULL)
>> -             kobject_del(&s->kobj);
>> +     kobject_del(&s->kobj);
>>   }
>>
>>   void sysfs_slab_release(struct kmem_cache *s)
>>   {
>> -     if (slab_state >= FULL)
>> -             kobject_put(&s->kobj);
>> +     kobject_put(&s->kobj);
>>   }
>>
>>   /*


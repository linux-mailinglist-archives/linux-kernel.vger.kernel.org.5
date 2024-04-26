Return-Path: <linux-kernel+bounces-160670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31058B40D9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1231C21DA5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836BC28389;
	Fri, 26 Apr 2024 20:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cuPizzj4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rWo9NR2A"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F6F25632
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714163635; cv=fail; b=OjmrYtJwbr5wLO5mYuMT72rVHAQ1EJLVSyohyeIh3wjHlZvgeUiinzTUKasqvzfyITuDfQeUqWfE3U6bhXBIIU4ZbYWQCaXGaT59PUnogSdmMd6GjIuC9epJcpL3eZVmiSQPCVIR+gdf+CG8Sws7w36M70gBXm12dpH3wqW2sFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714163635; c=relaxed/simple;
	bh=YLDYDUG072MLhVAXpKvmbBUffpJVkA6gzQWmoI1vsIc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SaKKHItX+tLE/P+XUZLs4qChAu3hFBLCU+X4YZPDw7U7TwZH5F7kAJSXhVZ3Za5IahGwBLU5OID9WyUpza+FVuFDKAEiYpmjKpGJzPbEFqIxd+LpFkl9SYxnJQrRvQvsdjEa6/qkt2eVrazExkiKLuSoSJdWgY3Hp4SA7f+OENE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cuPizzj4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rWo9NR2A; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43QKABOF031169;
	Fri, 26 Apr 2024 20:33:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=EpTAU8UCVRXKW92SODLJLv7kzwbxeV8tjylD7VilzgU=;
 b=cuPizzj4fvCumcDSCtNJgXVbijgs95tFemYvQ6FjJ7lXrSQW5mj4rxJPnYGKkg2rq/wZ
 PzIIcBjXtcq7TYEzvQKiqUA95GIL+lqZuWE7ePlq9B2EAa0XE+MMR0dYyHrS19bMBNoh
 9UhX2vXw3gvk+7JqN46Mij2uzmuFVSl7A7HVSK+XpT5BPt6aNNEtIZNElAQ+FEXCwu+K
 ZTNEvSDWI3ZS0L1Ts7m4nfI8Az406DYleOaIKWIpZWyS429Ux7knuwHhtx60VP83XL1g
 XG4meFycrj6isa+KpnqN2GPkoRYPhi25QwxQY0DU0osbP/NPdyCaxAUXkd8cB7TS0j9z bQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4mdevx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 20:33:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43QIUqsx035600;
	Fri, 26 Apr 2024 20:33:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45c46tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 20:33:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxuaE/YODbOD81tVaLKggWfmpQFqGMjoctB10ezUB0tIKlOUmEZMqZmmVTHxuhT6NvL8XXivxtkT8/3s2DJadZTJnrKVu01JOwalzvIJNSuScKNy0kVx7+GWy9JbpU6perUn+86V18wSeZjiBaz8fCzRetMPwhO8h4226ZGZSZ8VSSsHo6wXoDbALn0uJpKy461WTB7kh24VFNYoNvP08OyPe7w70pN54BCehDQjDS0C/UGWBx6xDCSIPH6Pgr7RVEnN9pZiBZhW49j8Z16c6AqU69DBOV3+hsu4IG8gLfdQPfKwHAAhLQHm3IRBZr0VnyllHYIwtaNQlB54Di3juQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpTAU8UCVRXKW92SODLJLv7kzwbxeV8tjylD7VilzgU=;
 b=QUybh7mLCIdQEDyy6e73cF0SSHpPwFOtgafm+ywpLlXzFmcgU0OUKtZfSH7h4kQWq5oFUxBSit4WnwfBTl/+KvrCHHzpaVDGRvfyELk3x5foQMhCu8Fes6oH/VLrUgCVlFxRluITM4VhbFCeXY/4JHL6m2yoFVZK9EC1vHQGwWAnx7n0hotzQDQn5jzx6QLvgDaNHClJCGjPEShVUh+y+BhPramowMF+nb79lJpu8lVbincbE5adRTxm8VnsbB58kEOR30/pK/SG6ukNXm0bqheEAaO55uhOG3lA3vT2oQH6dWKnbrsu1KID+Rxa6+0HUywNsMFcUuTIBymZt1v4qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpTAU8UCVRXKW92SODLJLv7kzwbxeV8tjylD7VilzgU=;
 b=rWo9NR2Aio6q97ORj3MBVuP2q3hm8hLZsKGcke6eCaKJV7miwBZLulysXACN5ZYzwjHuHgkdkLaN4esgzFQMCkuLwOitPuplA0fCiOwlAB1WjcOBFdF4d0xNKngsmE+AnUL7Giy4BmBk0Qq54KBgq7QcIL4HuWt5NxOUMgr5tUQ=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by IA1PR10MB6898.namprd10.prod.outlook.com (2603:10b6:208:422::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 20:33:31 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::f5b:648d:5d73:dd03]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::f5b:648d:5d73:dd03%7]) with mapi id 15.20.7519.023; Fri, 26 Apr 2024
 20:33:31 +0000
Message-ID: <d19e1033-285f-474b-af1f-ae4c32e32e21@oracle.com>
Date: Fri, 26 Apr 2024 13:33:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory-failure: remove shake_page()
From: Jane Chu <jane.chu@oracle.com>
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
 <47614f5d-0942-4b2c-a51a-451f6bc9c802@oracle.com>
Content-Language: en-US
In-Reply-To: <47614f5d-0942-4b2c-a51a-451f6bc9c802@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR02CA0117.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::19) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|IA1PR10MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 6db439ce-b1f1-4635-54aa-08dc663022e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RVhwMjVXMzBUcm5yeVVNYjdoTkpJSWozYm1YOThmSW1mL0poeFp0ZjVNdWl1?=
 =?utf-8?B?ZGhRTmFxeDROazZYclRoaWR5NnhuWjNNWU15Wkd0U2dGa1orbWhWTWpSWXhk?=
 =?utf-8?B?SjhaaUpid3ZpdXlQeHZhdlozbE1SbU00blBHNEJBWXpCRXIvWktFYWVUK3ph?=
 =?utf-8?B?STBidFRnRHR3VnlZTnprbElYeFpCeTQ0Vjh1ZkU2TU1YVUxXalpvSTBnM2NB?=
 =?utf-8?B?UUQrcFVzUmJiU0dwcWpWU0RmSWg1NU5tSWtKV1RiR0x3Skc2OGltQUZrZ3pS?=
 =?utf-8?B?RndEcWh5R2NicmJvNlFMbk5neDZGRG9VSEZkdlFpdTV2STNDeUVVQndWWWkv?=
 =?utf-8?B?MzZUSElOMHJZazVPSTg1S0JWK0Y2MDFudFQvM0x0Wm5mRHZ4YlBYb0xTbjJ4?=
 =?utf-8?B?VGtRbjRKb3pVTmQ0bU5yWTBXZ296Qnc1NmNHLzVtVW4xMEhJSXc4RlNrODBn?=
 =?utf-8?B?ZElYRVhuaEJhalFRZnZCa1RoeVlsaXYwa2JKYjdOMFZLUUVnMXZRbnJicXJk?=
 =?utf-8?B?S1QxNXRyRDV5a2IvT3lkY2xRWnpUYXJ2NktQVWNwOERWaStrek5XRTNrRjZy?=
 =?utf-8?B?VDVBdjl5WkhzNVZMN2FyUVV2dDRsNTZYN0w0NE9EZ3loVFU1VWZDMVlDSFVv?=
 =?utf-8?B?YjVhb29IdEZoN1pDcUVyOVRrUGlXUjd6TithNlErNVl5V2dTd1RTelkvUldF?=
 =?utf-8?B?dFpNdUZ2RVl3VlpqN2hmbmx0OStuMlNnU2ZqcmJUN0RQR2lzc0lrWDBpSmpn?=
 =?utf-8?B?aEcyaitCMW5Xc0hmRmN3UmZBZmh1MFpLZlN3L0cxZXJhcVowVDdaTjkzTlJO?=
 =?utf-8?B?ZGlCNEt0NUc4T3cxQ2lVaE5RN241ZXlkR0tqYVAyeXYwa3dYVDdESy8vTTMz?=
 =?utf-8?B?UEgxUXdxNlZRT2RRdEx5c3hDOTAvVEhiWDdqN2FUWWJab0dvTWp0bXAwd3NM?=
 =?utf-8?B?aU1PK0N3QlB4S2pCQTJiWDlYRWVQdnBkRjZNQzlPRTMrMHJ3WFRFNVRXMVdZ?=
 =?utf-8?B?eE9LRE1PQjRFdUdqakUrRFNOMGhETWh6bGJTMHNST3d5U3pSV2JuenJyL0s3?=
 =?utf-8?B?QUJ5TWV3bmxONUlMZXpOUFBrZnZvUHRMNjFGQmttYWhHK0tqeEZvQzhpOU51?=
 =?utf-8?B?T3M1V2NWZXdrcXAyaHZVVnlzdVI5Q095WEVQcUQrdWt0dVdmalB3emRZUWUx?=
 =?utf-8?B?MUpGbmJ4dzVKbkRyWHdwY0wvOG5NbE1MNGtFcnlvbVJHWEozcUd6ZVV6cTBh?=
 =?utf-8?B?OHArdXlXTnVudktyWFZtOVZMN3Z6VGt4L0t1WkdKZ1dYZ29Pa3dhYTJzTnlL?=
 =?utf-8?B?bm9ZZGRBTkI5QWtrZU9XOW5MQUhDdVR6QjZZb3piYUhzZ1Q1SnZraC8zemx1?=
 =?utf-8?B?WnhKRGVNRDl5Tks4ZU8yRE9za2N5OVp3ekJkZXd1cGc4UjJrcC9NSTk4R0NX?=
 =?utf-8?B?L25QZXA1enhqcXRPaGE5dUZ5bk5LZ3lxNmJvck12dEFLK2VTYzhKV3A1UVps?=
 =?utf-8?B?bG50SFFOeUYzL3V4Y01zbEFrM2xKZ1prajFPWGNnV1hHZkNPYkJWcmVuVlY5?=
 =?utf-8?B?R2E5VmQrdGN0eExSdS9ERFNiK3JMRnVYQVpUVVE0VTV6cHVIb2M3eEhmNW44?=
 =?utf-8?B?OVdpcWtqSHpxUmNLQ2RFT0xMUmhYeUlNeWVaSExGdFB5TDZxRnFpWTM1Z1li?=
 =?utf-8?B?WHdjTit2Z0Q3S3ppcHNwemdIaFZtTTZOZHVSUk13UWNhOTc0eUl1cjlnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dmoxTVd2dnc0dG5VbjM1RnVyOXZnMzJndnVDRWM2bjlRNzgwR0poMzY1RE5u?=
 =?utf-8?B?N2tHN0lnSGJyNDBRT005Ymd3cjB2TDlEQ2M0WSt1U3d2VU43OWYyRVloc3pz?=
 =?utf-8?B?dEZ6VmYwQjA2QkIzaHdTbnFaRmtDQjhuYmQ5QnhTZ0l6dktSQWQ1N3A3TUwz?=
 =?utf-8?B?SnVxZjI5N1BCUG85MFdzWlJKUjNrUnd2U1E5VDVhSUtoTkJtTExWc2l4SSty?=
 =?utf-8?B?SURqajBKOGNPbkh4dXZseTBGR1NUNHJ5UnQ1UWJDckZGWklxM3JpdkcwbitS?=
 =?utf-8?B?OVNYT2pwZ1Nvd3hyYlB6bUZiMTZMZm5FdFFyRWxQanRkRWZjMGhnVHN1bnZE?=
 =?utf-8?B?UVhLRFlLdTB2YTVlOGxzZTF6SGtEODJRbGJjdytOM0J4Q3dYdHllZkVyU1hr?=
 =?utf-8?B?cTVPYVVpQXZnaEk3TWtsdFhnejBQWXZubmIvb1pNK2ZsUmNvckh2NXY4aEVm?=
 =?utf-8?B?eHdHeStCZW9BTGxWVUlra2lvbTBBaGxNbkZGNExQem1NM05ZVE16WWpHSjRB?=
 =?utf-8?B?bEliREpybTUrQzhUU2RORGVLc1dtTm9UbFprbHM1dlFkWDNSM01oSlNTNlMr?=
 =?utf-8?B?Y05sdVlVK1BmVU1TRlVvTVhVUE1ld212THJRMCtiQmVWZTZZelBDZmNtVktR?=
 =?utf-8?B?c1ZoUkd1TVB1RjJ2R2NsMW40TUt6Y2ZiWFhtTzFWQ0VmcWdMMkJGRGJsbzNN?=
 =?utf-8?B?UWpoWU5nOVhHRkdTUWN0WmQ1T1psUlVUaElSRXN1SkVDVFRTMUJjWStkUS9I?=
 =?utf-8?B?RG5LeHQ5SmNaZE5uUC91eHlPV1YzTGM1WVFVaWZnZk1MN0EyNEhnOG93ZXZW?=
 =?utf-8?B?NGh5YjdoNXZhSTlhNXV3SURITEJPTG42TnEyV01paFhTTVhIYkMyNkVFQmpw?=
 =?utf-8?B?UzBma2UrMDlZR1VZcVhwRDl6N0V0UzlLNkxpbjRZenFmSXdMQ3k4SjNkVi92?=
 =?utf-8?B?clM0RG55VG11RmxHVnR1aDQ1T0JXeHoyWkhNMjdISWw1cG90UzZhS3lmN1Fa?=
 =?utf-8?B?cDYvS2dOOHJVa0hyaUJsUmc1OFdGSFNTcVRUbWJONGJuVHE3WmluMjFsckZE?=
 =?utf-8?B?WGYrZS9KVG5ERmlnb0RKQ1FMYUZQallBdVYzdDgzRFVKWUM3bDVMVUIxc1JX?=
 =?utf-8?B?TWVuOHdUR0kwM0tGMnR6cHVrNXhnRzkzbE9sU1lsK2t6SzNQZnJ6MmhGc1Rx?=
 =?utf-8?B?N3IzNVhzRmF6NGRJanZ1aHI3RkNFQy9hd1V2RTdXY2NvZmpoZkZkTHpnbVJ2?=
 =?utf-8?B?bEs0Y3hSdWN0R1NrZTJDVGNlRFF0ZW5OOFZjK1hTU0duaHZmNEh1emJEVzll?=
 =?utf-8?B?aDlPTElPZVNRd1ZrbGZZbUdmeDZJN2FWWTVJVzBQRlgvRHJtaEhmL3FoSlRT?=
 =?utf-8?B?L2ROU2YyaDV3LzBzMjlscmJCRCtTcjhXSUY3TTFYRCswenBVTWdEVy8rSys4?=
 =?utf-8?B?ZlZacG4rMWhiYnZjK2pOUFpvVnk4OHc5czFpU3dhREJhWlUxRGxMTm1IYzRn?=
 =?utf-8?B?c2JnU25lbFppWkdTVXZUbmFwWDZwUjZ4bDgrWDE4Y2srTzhhQktTaWZIUk9l?=
 =?utf-8?B?alNDUzdQcytCeldTczhNRzQ5Z0duK28wczhaNFIzNmR4KytOSnVZSy90NlN1?=
 =?utf-8?B?ZDBJeFJBaGpiaGk2L21WbHNRUEh5TDFWV3Y0eHlKZDFQRFY1YWhOOHJvZHJw?=
 =?utf-8?B?cWc3OEIxeS9KR1lsMHdsc2JQKzBnSUJEZFBjQ1dEOHY3RktaMVQrQlFMWU9V?=
 =?utf-8?B?MzhtaHJrczFvM1Ryam1LVDFRMjVVbmhhUnJ3cnZXSjN2MTlFM2lhdkJsbHkx?=
 =?utf-8?B?R2gxMFgzdElZNlVqdW85MUdLelcxMk90eExLZ0dJUUZSUjhRdU9HK2F3NllP?=
 =?utf-8?B?K0VPL3lidVFLd2R2K2V1M3puNk9ieFY1YVp1Y0Q3YTh5a3lOZFJWb2Y2dnlh?=
 =?utf-8?B?aXFUUWMwcmZSQ1p3MzJsQ0VEVnEwTUxyenY4QXU1Y2Z6Q2ZvRGJGTmcwT1lZ?=
 =?utf-8?B?Q1piL1J0Y1VzanI3dWpnMXJBOHBBb0w3QVZqQWJHeUN1N2tzRjJPVmlsV240?=
 =?utf-8?B?bHljSjlGbkVNSVlPZWRpcHJiOHhqd2lwTVVjRDJHZXVXRG1pUlp3NkRiRDZx?=
 =?utf-8?Q?8AL5USX8+nXYq8D6BUtPmy3WZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nW0cDJvNbhUAisdWWVA6A5Da5RdDnhRwLu2wWQUnuVVkGtr16v2JAPyIKx2JnONi721mZTyN4QVmk3s+ROxLtS3wqZftlNq5BZDfXf5qGpSQdwWOcJN2lmrscOF8PHQRihtkFQdBnGzsivX6w+9Gp+5wJ2Q2GoJ//THsG4/Z/aGN9UxtjNK6Bi8nouHRbhWImdSPaKusTludFhvj8QMFGdFKITbxQSCoQrwuo3Ng1nr66F+u3xqDBned77pfLrJd7i/ozIhNny9Ifw5/fEWnDCelStzanxc4AI2P/nYXElU2e8iaMrqYCbCeilY4mDg3ciblvBi/2AijRLGHY8804hAlTWD0BgwZh7FKBu7L44NfTCzE82ylz3RdFJED6dmeggfJOjcJQxc15ZHy/OVYcl+LG0/XhslxuJIp2JmEwoDJ6D8vhlT2M8UwW8F7fiFaJAnTfGRPpES/0B44mLzPFvJgbvmmaj+FaN4BHJiZDunMWPqyao3Ns6OeUl97Vee+iU5YqPdzaNj/eAhzTG57qPUJqN2lf2a2ol3qmCLaBeOnHmjVQniXdfav6WWX1be/jRuyOTC/gTlnT/giaNE2XjI81cSCHh5caIBlz/AIFQ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db439ce-b1f1-4635-54aa-08dc663022e0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 20:33:31.0715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETuzw2TXThVnDt6WSx81dTZK3nlAC53ekHtX1+q42qSLoWrnGBlTwy5grcptxMcx6vOhiPmY3/PjPCXlXe5fvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_17,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260142
X-Proofpoint-ORIG-GUID: S2LA-1jh9vvmn1u_CUwX3_IQDrHziwEk
X-Proofpoint-GUID: S2LA-1jh9vvmn1u_CUwX3_IQDrHziwEk

My apology for the gobbled message earlier.

On 4/26/2024 12:52 PM, Jane Chu wrote:
> On 4/26/2024 12:05 PM, Matthew Wilcox wrote:
> [..]
>> That would be unsafe, the safe way would be if we moved page_folio() 
>> after
>>> the call to __get_hw_poison() in get_any_page() and there would 
>>> still be one
>>> remaining user of shake_page() that we can't convert. A safe version 
>>> of this
>>> patch would result in a removal of one use of PageHuge() and two 
>>> uses of
>>> put_page(), would that be worth submitting?
>>>
>>> get_any_page()
>>>     if(__get_hwpoison_page())
>>>         folio = page_folio() /* folio_try_get() returned 1, safe */
>> I think we should convert __get_hwpoison_page() to return either the 
>> folio
>> or an ERR_PTR or NULL.  Also, I think we should delete the "cannot catch
>> tail" part and just loop in __get_hwpoison_page() until we do catch it.
>> See try_get_folio() in mm/gup.c for inspiration (although you can't use
>> it exactly because that code knows that the page is mapped into a page
>> table, so has a refcount).
>>
>> But that's just an immediate assessment; you might find a reason that
>> doesn't work.
>
Besides, in a possible hugetlb demote scenario, it seems to me that we 
should retry
get_hwpoison_hugetlb_folio() instead of falling thru to folio_try_get().

static int __get_hwpoison_page(struct page *page, unsigned long flags)
{
         struct folio *folio = page_folio(page);
         int ret = 0;
         bool hugetlb = false;

         ret = get_hwpoison_hugetlb_folio(folio, &hugetlb, false);
         if (hugetlb) {
                 /* Make sure hugetlb demotion did not happen from under 
us. */
                 if (folio == page_folio(page))
                         return ret;
                 if (ret > 0) {      <===== still hugetlb, don't fall 
thru, retry
                         folio_put(folio);
                         folio = page_folio(page);
                 }

         }

thanks!
-jane


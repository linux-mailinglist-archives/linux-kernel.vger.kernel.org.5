Return-Path: <linux-kernel+bounces-127324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E928949C9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 05:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38EF2832BD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7CC14A83;
	Tue,  2 Apr 2024 03:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lvS/tYdf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BUJkLQaG"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B786FB5;
	Tue,  2 Apr 2024 03:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712026827; cv=fail; b=hMQnb1TTOUMkvPO9V9/Jq47C6VRISk/Iu74PmacRlIdjt7elrpbTvJ4fhJ1PTGuu0OtiJCAemw20lTzYbqnc8aF2Pi63sVNVeCotaJwseTI+IeEmMhhRc2goM1lfTXZSgqorrrtmpiwcGsvDd5ZO/wqk3UApM7NdwOysiDgCyog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712026827; c=relaxed/simple;
	bh=d/9hjJran8b9A2R4pXwdSktU63vylBiCa9hQHER1qXU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sUYpSItM3qeuMBM+CUXDEaOm7KZ4N87V7D9Uj/ysX/jqreK2VJvCsHX35S+6ubfPxkB7q3gWTrQqXptXel2eXaFAHkh6BnpzRNJzP85pB3uhGISOR1jzAXy75ku7aQNWWc3mWzLFPvhu7khOxGhO8KKRPTvoFJvxnqtdgHEK73s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lvS/tYdf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BUJkLQaG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 431HovgK027623;
	Tue, 2 Apr 2024 02:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=6Aa8xxq/ZQib7waIgBzbp0tIX5uoc4LiGpcN5hBcYwk=;
 b=lvS/tYdfcO7CcwpRBM/CMHnZpOxVnPwwA11CVYmDGCxC9j/5YIKvD4xoLjlW5MyH6xGS
 k8bve+581wlSK73M2b0VkAYeReeJfej5MybeLZifjuehpjkGUEzzorM4r0uS/FRGjnO+
 KHTdHDuoqkJ2TtIr7Y48IUTlQ636M62NqFm+P8y0UeaRuaCN73LunGTprscgNkXc9uZP
 boYD7p9L6WNQzkRdzkxvEHQiMoGWwXoYoqmxc9Sz2e3ulskbKlHXMnJVF8lYoVGiEhXB
 Bw4Vx/eRoEmioBLGkgstJMf7qdo4Fpfz9vvqJAIBjE6iCzwIfcUSJ6UrMC7WC74sSS60 Hg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x6abubm18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Apr 2024 02:59:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4321lPJP040399;
	Tue, 2 Apr 2024 02:59:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x6966b3jd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Apr 2024 02:59:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpFgzEBppB7lddq6zD0+WlRuMcDlq7mRlsWeolFmxOs4IIqJWxvAlBJQlIcDTPJbOZeSVo1brlvzS6FycmWtd3Pt7u6Aoqxn03nD3LS0UIYxJOBcgDXRhr0SpNWFYrknekeXOKg2TAoDMll48yJV0HrrGJdyPF+jH7yh5dz/JMb6VSbycdkOk/EJxDll9YlYGJz1yR1OHIl0N1SUtNz9/GzOylfAHl4NMtEfJ8DKdsOsBwn2tOoP7XNgqtRDg700yWfeKr7KWkKKcUxbcRsfQjsByOEyUSUoJE4v0jnnsE8YufTjWUo8RbgioFdzGKt5MWBSmixsk03Qci2FNN4Ieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Aa8xxq/ZQib7waIgBzbp0tIX5uoc4LiGpcN5hBcYwk=;
 b=lGP3v1UKXmYGUJWVljNZl4ZEW2NpUw9dqHCVh+VGigORCylGsQZBBCercmCrrNQNiRxe4WMYuDD9K9VecGsYRL4duEMC6mQ6XIz5P7nBFccOYcPdFsH4VzdgGf0Gk32NCpEXHcIBe93qkysYYQiHmmftd6FN8zxeY71G/KJesoa6DhQGmF8IYAMzpdY8NLr2yZujKpg5YJBdo/A0W/1YMNMH5LJxt1ZG2VtO6S18KHXo8c7q0TqtVg4qFtAAA/PysagGsOkN0PxqCicvc+E9sHx7HXHZrMQPbOxmJuGN8OFt8gnGX6MEDle4EJEhomgNEr3xr2Axe13V1ZREJxXXWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Aa8xxq/ZQib7waIgBzbp0tIX5uoc4LiGpcN5hBcYwk=;
 b=BUJkLQaGoLlP1+hrf7FhxWXcM7d8cP+RKX/Rv9UPGSTyqcV2lqbq6sAlGGACynzF31MiF91lB5HQpwNh2c6ojaaRXiUJD5gVSe6DLL8k3WtWhpV46DA7DBrAnOHDrm3cMKAiHpRIfgqAT4w+ENQbF0OIiCy6jWcN8uxZVo9pM6g=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by CY5PR10MB5986.namprd10.prod.outlook.com (2603:10b6:930:2a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 02:59:50 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f5ee:d47b:69b8:2e89]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f5ee:d47b:69b8:2e89%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 02:59:50 +0000
Message-ID: <541a0865-42a9-4885-91d0-c3e49104c90f@oracle.com>
Date: Tue, 2 Apr 2024 08:29:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/396] 6.6.24-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        broonie@kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240401152547.867452742@linuxfoundation.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240401152547.867452742@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|CY5PR10MB5986:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qJnI2wuehR4BMChTkoBAS1+FNm/1TMWvN03IUyKv6m6Hg7T+c3/PH1dJw2UEYZlydEtc8OJ1xHyUC0E2d6NWnQQF6c2gZow9TLePNROsOK1tFvhydqkZxan7qR4JN60RsyXBQV8SCoDSkjBnrUcs6Qv6+uFsFjMuMTH/6vZn9qp6f0NLO9eYp2Jc/+REuyK75JCrtb2AR0WIZFFahqLShUaiGHb/TsJscQpzSqCap1OOnJlMhEEFS633mePyeXeICpPwvwI1fH0A6nXxDEbMkgbL9XYkJPnV4PjDZpzwci2MAJcccrDJKbZU04/tXkNjK6n2yBuMe6t60OEQ4hGG991pcKlqtcFnoTw/xzgS8j9CYLGzLGaCd8qdSQop1e2p7fqYSqI34syT6gz1QdyCPQosKK7RjS8XCkf2qiaZCSeU7CL1WrDn/15iR2mBInyStG1b08oP10MFrNCwJHaLVF/vQwn7LS0Z+j3gX91a3YtesOhsE+2lYndXOqaqeJUCWzDsa5LBM4E6TJ4F3sRSunC/ePIbTUA8nBbSJF+HTGDuHF4HVxyI6Jq0ybfxKvmDsu1Oib06hGLRC5ys4LhtV//h8F3La/NBLV+d3jzDo1w=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OWVnZXZNU2lGNElOUVdZNC95MGZvOGtmYWtCOTFHalZZbTg1QVdRUTV5UjlT?=
 =?utf-8?B?Tm9iOFEwQ3RVQmRWNGVaQXE4MzlKWVRmNmxBTy9xK1k1cVBGbzAwKzRiRkE0?=
 =?utf-8?B?M0IrTGJ3SHVWd2JMekN3SXhuMkdpUEl2N1NhdGxjVndIV1UwQVUxY0lzVXVO?=
 =?utf-8?B?WktSSFRQMHBEM1A1VlZJQTREL2F0VUpLM0RVOGdKNmNZWkdJQmV1Qk9mOUdy?=
 =?utf-8?B?RFZrNFA0aGt4VFJUMUh2eWl6dSsweklpNjRlNHdyZnhoeDh5U1dQL05vUmZ1?=
 =?utf-8?B?R1cxUStXWFVBRjY4eVdSMm1MeG5lMWk4ZURvampESXFHV1hqMzBXZU9PSVAz?=
 =?utf-8?B?MHJMTkY5dC9KeFREQUdrWUdsRVdDMzN1VVpWYm0wNGF3WDczWExGNENNS05L?=
 =?utf-8?B?MXhCb01yQW1wRVliL0F4VEhNdnVlTXRaOFhIeXpDeDVjQmVZNU1XbU1ab1B1?=
 =?utf-8?B?WEIyS3pMQVhkMGVHNUF2YW5NNDZzWWYxL0IvZjAyS3ppYkxyWC80RmJkcWJS?=
 =?utf-8?B?NzZhSEhnSFRFSm03bEhCVzcvN0hsMkpveDZQeG95TTdDVUxBTndtb2h5MDFD?=
 =?utf-8?B?R0QxbWFIb0d2L0lhbXFGMXdSZVpHL3hMb0p5UXppdWM2UkI3SFVocm5lU0Zk?=
 =?utf-8?B?bExydmRvUnRqdHN4a01PdS9rN05XM1AzVkFVclZKVkNVSlArNVN0bnNMNTdP?=
 =?utf-8?B?b01UZUxpYjZCc2ZWU1d6NUlrTDJleVZzbVRrM3NhRUhXYi9KaVpmK0hoKytO?=
 =?utf-8?B?K0ZYZU4rc0hRY2FRTkJmTzF6L1RRL0xZckxHNFVkZSs5YXhHaExGclBOVDA4?=
 =?utf-8?B?QnNheEk3QWUzdmQwVWZHODAxQ0JUVk1tZXJDRmRTYVZZNGxpeWtRd2k5ajJ0?=
 =?utf-8?B?NWdFcDg0UnJsUFY5bVVFRFFURGRva0MrU2lGckVTSGkxblNqN3JLSFJ3UUdl?=
 =?utf-8?B?RjAzZ0cxc0FxbmZTaHNuUkoyVUVuNCtXWVYzN0ovalhleUlYZlBTeWZNTTRK?=
 =?utf-8?B?MzM3eitPUi9LRVBpc0pXeG5KL3dMRUJSSUZWVWFwTnB1OVdFR0FSVXpWbjR5?=
 =?utf-8?B?ZGp5T05EK1FKdHBHK3lpbVliS09oQ1padENHOWpZTXBzdWpRZU44eVBvYW0w?=
 =?utf-8?B?YTFyaFBRcFQ2NkVxOFRaY2FlQXNsV3pNQzladmRrT2RJaytyeitOZ1I2U3RY?=
 =?utf-8?B?eWJyM0lzRVN3SC80RDNoaE5WNXcwZEs3Y29kSDY4MjduYWNpTWt4SlluOEdK?=
 =?utf-8?B?ZDNtUERYZ1pPNHZuLzRMRnNCVmQ0RWhidWhmbWZLa1RNWXkxbEJ3NnBxcThB?=
 =?utf-8?B?MnU3Ym9WZFQyajYyeklJUzFIcHhrNGNCZHV1TktQSlU4elQyQjAxblAwNHI3?=
 =?utf-8?B?WDZoNUVlNzJSRWYyMjBHSEMrc2R6K2w5Z2VKYkQ4Szc0M1NQS0daOWcvOWEx?=
 =?utf-8?B?S1ZXcmpQdWZDM3JBY29lU1BkakRoT3V1Ylo4OEYwR3dqL1MzVTZObTluZytJ?=
 =?utf-8?B?TnhjTjVGejdITDhzaGRvSUx5aWZjZDdUcFNYSDhsdSt4TmFybWh6QnRhUXl0?=
 =?utf-8?B?ZXc0dHc2bVhNRit2MUZ0L3VXU0pjUVRkWUJnbytvUG9JUDRoR0d1Y3RISkp4?=
 =?utf-8?B?UnlUMGxTNU45ckxjZmdLQ2k0eE91MnVwaC9HS0NaSCtrRkIyNFBrcjk3dmVm?=
 =?utf-8?B?WDdRa0dXbFhKMytKeWl1NWRIbFc1S0xjbEhXUjV5aWlXNVE5WVlpcTUza2lJ?=
 =?utf-8?B?MTVvZWw0VURnSCtXZmFxd2JZVkZCK1NwR2RmSW5kOFQ5dVVmVHFKeDhPRFF4?=
 =?utf-8?B?c3lNeDN6aks4WmNEQzV1RDgweXRJb3RuMzljU2tIdWFEc3BFQWRwajNHbmo1?=
 =?utf-8?B?Qjl2WkJjS2NMRGxkRE1vSDl6WTJYR25PdTZjUlNIRXNNMEJTMnVzWWFObkls?=
 =?utf-8?B?TzdtNWxSM3RSVi9JZVhrbjFpdEYwc0RvSjA3OGc0S3VsTUwrbHMzQUM5eFl2?=
 =?utf-8?B?Ny8zSjZ0aTJpSFZsU2RZalcrV1hVcTArVXQ3WG45QkV5OUNncXo1Njhzcnhn?=
 =?utf-8?B?Qk5KUFErNjZGRjdJdU5qVnI4YVNDd3RCSTdLMmQ1dzVCZ3hiTVFTYS92NEpw?=
 =?utf-8?B?cmZFRnJuSml6dURYUk1RTzhtckFORks2SVV3aFZnbVFiSUtBaW5GTHlHK1NS?=
 =?utf-8?Q?DlUwXzdUrKoxGb6/dBohEZg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aE2SV4IJeKcll1BeL9DkUcetgYY/fghiwZABnMPZRmM8OiyapxhNlyVNBe/3JV/fp5OjJ2Ljwn2arJW3/yP/QbJjmJC3c8rKqq2On1rEiJ8HbfDo3zxpsZXtrqDEllKOXjr8wszDi4JZvUUb8MmKV3iTo98gidaDJ6AEqxSPJrVxtw22eOrU80DTQCWg0c5tNsyJrra0JNA3nLWjRJLviMjE3TYsniHqxfX94pXMurhmrkz2Jh6qUtmKTURe7rKk7TLShRZz6f97de/ycezoLYJwqlZZ6GGJl7yUIHHi8eit4uIndQCcO+MezYqLuV1YQCv3Pqu0CvjFx60oXvod+cqcVB1McfbnzryTOWJwdIggCGvBbcFtjO7gD3yW5wJTI9BIlCQyPYuf7xmEtVodQa5QFpemiznoWE1uCEMx81W42MtwzLnLQflbSDwW0Ip+xDbY83ZGAxT52cTW475hz2hJLRxn6XeV6wsC/7ob/gqAkpdJt+CTBrJnjJAEvcpufUDQgY/enbZWCicjuenhP95vuGacOyRGLD6ORWpJkcfkN0S/iHUgYsjnSXKdiQVPthsxrtHRE8yO/zTW17XwJYiRXkZiTWlfWbdl3YGzk3k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc95450-d8bb-4361-5933-08dc52c0f6a0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 02:59:50.7533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cb6608d8Pzt/wQCtrnBBofJvBYN6Gc6TaFnINYabnrQtX2YIpYC+OQtE1YnWJ5kac68JxUgPM8uXmKsCK1ios+7sk37jSICCKXSzPStYI0xBAbiNkEvBNsssnlaq9HSu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5986
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_18,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404020021
X-Proofpoint-ORIG-GUID: 9SwJRklSaT84z8vpEZwvzVAQdkOSx5kE
X-Proofpoint-GUID: 9SwJRklSaT84z8vpEZwvzVAQdkOSx5kE

Hi Greg,

On 01/04/24 21:10, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.24 release.
> There are 396 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.24-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> ----


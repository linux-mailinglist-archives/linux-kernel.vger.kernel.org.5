Return-Path: <linux-kernel+bounces-59556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FC884F8E0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E691F24E04
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EB6762F7;
	Fri,  9 Feb 2024 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fda0wzu1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eLVLmb8Q"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F636BB5F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707493802; cv=fail; b=CNwagoEd0ThsYDrA8gjU5MxrT+L0mWpYhVfVar7Z4jUoLzMYxopGtcGnGJHpSuG+uOGOZpHtLcELy2srj15FsDg8w9y8GNqM/s+L21cpIREYezsog5hSTxYqQLxeUoXhB/iDW7L/RP+krZOBt3SnCcEVR2eo3oBbqsumDU0eDAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707493802; c=relaxed/simple;
	bh=sCWn3HXzSTv2KA/BCUH4prHmKfeNDPPH/Rt3091CbpQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jhy0HSJFnhMNZV31DcqdOuJfzZa18OAXj82OB8gARh8RP6fOj18M2t2bNsA/W41W3xwtIJB1cxgvUeHz584WXEfuuSk6gfee/T7SrBBJW3CZIQ1PKaESK42avhtZH+aNMm0L0MzBpI1WmpNCyNrOX4EWWNzx+FfNylSCA3NFD0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fda0wzu1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eLVLmb8Q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 419FY6tc018806;
	Fri, 9 Feb 2024 15:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=TzkWfVwy5Kco+p1WSpMViV7P6qBB+UsI0M3JKdrJmCc=;
 b=Fda0wzu1teIMXzR+8SPiYgR3E+gjT+YnBVQ4KWJZ9pi8b5yhv0u9FwaUAz7bxrqNzOUR
 AYKZnLJ+nlxcocGjOOGfu3SGKpBHbHxoAdUvyKnZLw9xXhsiBTrISXsbsjv4crk/25wY
 KoBpNyX7S978jqpPRaFdBe/sRw7ACIWjhhy7ls03BPIqsG+6Oh5j3ZoiRjV2xEADWald
 XPIrqGKajor9S+3u3jKSLMe0ca7Pp4ry3eY0SnoR7rt5Hp5GW8FnLPs9nKNykuvjD0qs
 VYM0/bhZg0Na+rGfFW+Ps+MuYMI3HT1DAuVpYMjy7MBvSDD0HjOQ4hCa54f4oAK5wbcZ iA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1bweyfd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 15:49:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 419EGhOe038393;
	Fri, 9 Feb 2024 15:49:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxc4e9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Feb 2024 15:49:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UivFZrucTL+J7bP4YKZYU8k0l/akEwS9wW24T4PaIjWxbEg9bL3lwMdXV6CT6ZFZzcE0zqiLNVf7gw15sB5aMkNO84qKQSxJHZgkDLz64PngDJwJyzEo8cIDD/vTr5Yz8SqLZbaDBLOPuesqVvNWz7CeakxaWVMtiq2oXGYhf0AK62LiOTPPZda2pKBZ9ZYpGCUS2osFz1oo9YW4G6RSnamt5eEsS4GYlNG/PGia3F2qpA8u8jczKRs27sAQXe1cgme9o96cVDu4mrWoOfmHWUrMgUelPvGUb7rofzCjM5UXJIbND6d8pXd2Y2iIvK3CkMH8kvwLybJL7KZVj15Whw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzkWfVwy5Kco+p1WSpMViV7P6qBB+UsI0M3JKdrJmCc=;
 b=ECnXv+sXeYWcPHCatT7csyj836Aokn0++QY/rS+AZfAfoKHEHFushh+FqXSiZx9hbm3CoJO0PmTHpD2vUAuQZdniGkzpuJF8pnUF6AOw8nW1Z8R0XaFDBHp+6EzViOglneHjDepHos8WtZYkgr654CTdvCFHYzcqGwK/08c3eAY7X6NSgAZBL8vwBEe+jR4dunZO270RRFRxTgc3GVILVpMXuXUwYJinK0WWWt8C1GklvVc2WBzBIgaqOvD+9MoilQQN3WbZhDgIWL0W/TXRBrx8LUTO+NDswPfNjF6g5PsT7isHkvPEwbs9UArnnEB4FCKFvGpziCSM9FjvG94QCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzkWfVwy5Kco+p1WSpMViV7P6qBB+UsI0M3JKdrJmCc=;
 b=eLVLmb8QtX2XkCxdXaNVJ9u5ya25s2pyuCA+010eZBG5t0lvtrQkucDygDnYw2MXc3S6nbsYodUJHGfWgeEqIkAKHa0rPuUBbxo1fy2orkxTjJI4ZNcrTcUM8TNMoBtKT1bqpSrk+4kCuC6HnWN6Mcklvgw596C+txcmDn9R7/w=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DS7PR10MB5263.namprd10.prod.outlook.com (2603:10b6:5:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 15:49:39 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 15:49:39 +0000
Message-ID: <80eaded6-b6b6-4273-a8e2-186a6a56659c@oracle.com>
Date: Fri, 9 Feb 2024 10:49:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 05/13] vhost-vdpa: VHOST_IOTLB_REMAP
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dragos Tatulea <dtatulea@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        Xie Yongji <xieyongji@bytedance.com>
References: <1704919215-91319-1-git-send-email-steven.sistare@oracle.com>
 <1704919215-91319-6-git-send-email-steven.sistare@oracle.com>
 <CAJaqyWc+nSMPv7248x2QWOgAPOjwZ2BJ52LrOhKUu51t+3QViw@mail.gmail.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWc+nSMPv7248x2QWOgAPOjwZ2BJ52LrOhKUu51t+3QViw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0575.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::7) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DS7PR10MB5263:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ddfe19c-578c-435a-1c99-08dc2986b954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	li8/Lv34Utcsd/+rCgk//Sx26gXmN1NecaqIx7+PvoyCbAQPFKo5i3yY2CcJEcES1OrpQb9WwmIlAVv1Ebet0XeoFa8msahWyCO2TsAPESLwWP4UObqb7jE7dFU/UoKjT2r5f03s6i09ja4gP9y34YPMxKJ3PTHUmtwWDsSz6Q7pgdTjTJ25Drw/9h+lPyO23bo+d/8NZ9T238P1c90xissph9iZ7cqSEJoKf3nZ3DUbcMd04RgIvPjuuPAms7p0RYZwTdPldpYRrKNBKUNvWk/lYifQvs+WNHMwZ2dbWM/dNpEFquwwzFCQB84lFWc4Lh4zuqC0Z9QCMqvCy7dMZ53haF3e4C/y5oEgOd+LSs26wY+r2cPupuV9VmglARqvpG3I9wINiVWDlw+ljkhFlsNyQtjWHQOHdqOvF6Hd8U/bQXf6m3AmrW/QSpE7Gv8KBllVEFNtdgE20qRJTKrOTn/DLRpjaYM7r049YCgk6b+G2m3KPxfiEamZ5l1yBUoC5T52nhdZccS9udzCbI8bPzwLJ5ZQrjby35YJxPmgdDZ3DlQFwaxSSMearwHGSy4+
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4684.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(39860400002)(366004)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(38100700002)(31686004)(41300700001)(6486002)(2616005)(2906002)(53546011)(6512007)(26005)(6666004)(6916009)(478600001)(6506007)(66556008)(66946007)(66476007)(54906003)(316002)(36916002)(83380400001)(31696002)(86362001)(36756003)(5660300002)(4326008)(8936002)(8676002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b013VkR5dkwxUW40SmhmTEFIVW5LK3hIN1pmK1dTQXAwYVUydHJXaFVrMHR1?=
 =?utf-8?B?eHhQUGJnTlFkMDdvY3BFMlQ2WjBPeWVlaGV2VnBzancwTzRuTjZUZVBFa1hM?=
 =?utf-8?B?ekl5MjJ0V0VBTnhTbDlXbU0reVhneXkzMFBTUHVnMkR0WnVOQm5OUXdLMjdC?=
 =?utf-8?B?YTJ5bEVGU2JacWVubEk2UkJ4eDd1azFtb1VOTk1GSmlqbVJFSURMNTRrNVlr?=
 =?utf-8?B?NWtjVkxuT2l1MWlYa085K0p6QlUxcUtnN2ZQL2N1THJ0QThudXdvM0NjRUN4?=
 =?utf-8?B?Q2JYM010aDRya2FQaTJldU03ZGhkNTlXVXlKRDFvMVErUzNCdURnNDAxRG90?=
 =?utf-8?B?YlBsZTVBLzB6TXE3dG5JTkxHaEltdnd0cDIyYWQ4RndnalBLdEpTREdHOXRt?=
 =?utf-8?B?UXRRcXdEczNYYWVieWd3a0hGTUpnTVNVREV0TTllUVBDYWlvUU02alpkdVQz?=
 =?utf-8?B?WEVPWFQxQWYwVjdudGRzOE5mN25OS1lZem40ZHJOUXNQNVFvM0hiOHpWay9T?=
 =?utf-8?B?bzYreWwwTWM2dnJ5OGZOVXAva2t5OXBiMmt4bDVSenhMVWxXMTJJWFJuSGVG?=
 =?utf-8?B?Ykp6RXlPNnRDbDBMSHl0Z2xpY2c2UllUVTI2TkxaOCt0czdZWmNiSGFMa1c4?=
 =?utf-8?B?OVQvZ1hwcXBRTXlpRzhzcmJvcEo3YjF4RldhallzNWl3OGVSTGdyYVdCTDZ6?=
 =?utf-8?B?UHpleW1BQ3JJQXphdGhWRHhuaE9vaVk5VHRjNWN5Rm9TZW41T3hUYTdwQnpY?=
 =?utf-8?B?UVR6TmtDNnJ4SG1YYlkzWnJPbWxvdDBCKzdSUFZMN2l0L2ZhT0JJOEtrVHJ1?=
 =?utf-8?B?TXVaNU9iMms5cHdyd1dmT3pwME9HazBQYy9ockxLcnYzVGI3NklieGppSjRQ?=
 =?utf-8?B?RkdmNCs5TW5mNS9UMmRnZStQMDVNQzU1TlYvQ3lXSUw0Q2pHR3ZYMWw2cUpF?=
 =?utf-8?B?RXdIYzByTU9UTWNFNzkzNjZDbzM1WkowRjk4RzM4cjdDRjJ2bGRyd2ZJZ3Rj?=
 =?utf-8?B?aEFiSVlGUm9hMmMwV1JMcnUxOGpIWGppUTM4ZUYrVjhTd1NaMGRtbWswV0RD?=
 =?utf-8?B?RnMwYWJlaXE2Zm1QMkRhM3JReGRmLzRpUm1hM1BycnU4Z2JIbWVNRE4yMTFC?=
 =?utf-8?B?a0RPTWJnRXBZK3RzaUVKYW0xbVgva1lZbjUvZnNzRk1DYVp5elRxZnNwVG1K?=
 =?utf-8?B?YzNCQTZtZzVaZ3lkVlk2THpXUTQ4UzQzYmJxaGhtWFlHMzVpVEorZVRZS0xv?=
 =?utf-8?B?V1RzWTlENEJHNWVQZmlESmxGRjdXOU95UFFlemZiTGk2UW9uaU9CUDhZWVlx?=
 =?utf-8?B?Q09tUllVYnNsc3EvRFRnVHNVbzZicDFWY3RWbEJYRGQ5Rm9nMW8rKzJZQ0lI?=
 =?utf-8?B?WGpXS1VtYUhIL1JMZXJhWjladHJxRFdaMU54TEhiT2ZrMGE0MWVFRk1ha2pr?=
 =?utf-8?B?cGFwZ3U4Sk1vaVh3YXJTcXV4QUd1MzBkU1FWa0N4K1lJaFFacnNESU9VOFRR?=
 =?utf-8?B?WGY5ajdaTGVoS2R5amxGaTRnYTdzVXJIb3d2c1h1aDVjZ3ZvbUV1K1IrQ2NL?=
 =?utf-8?B?NTRmeXVON0QzdDQ2OW16M2FBd3dxeFZvbzY4R0ZlbndpRVc2eDE5T0N3NXQ5?=
 =?utf-8?B?SjJvQnBvS2gyNTRvRTdhZXl3eGlsWUk0M2NyVmlRYXZHaHJiRW1QR0d0Y25P?=
 =?utf-8?B?YTBwYnpNRnVjcTRTcU1Da0RYZ1l6WG5NbkQ3cXFld3JLelhURDZHR25rVDJB?=
 =?utf-8?B?aEZFcWFrVGJKdEZPOFBOTDNyb1g3OEJTODZFek5zc2UrZjRYY3o5dEprVnM5?=
 =?utf-8?B?T1c1aU1DR2Y4Uk9Dc0FNODlOdkhSVytEWTloNjFBRFpPMEZ1QzNHaTVNN25z?=
 =?utf-8?B?VUdneG5xYXJqY3FJVzRMZHBjdHlWRzdkcEdzYjhkbmR1c1VrckJtY2VFVzhT?=
 =?utf-8?B?WkYxODAwRDJyelhUMzBGd0ZaVEp5Z09ER1RwU2FwbWdEZkMwQnBoQW9aZ0dC?=
 =?utf-8?B?ckk2SHhwbFFEc0dCTExZbFpaU3ZXY3lOdlZLdERUWExNd3hpYmUyTmIrSzBJ?=
 =?utf-8?B?OUZyZFFjYVVudno2MWlCUUlZWDg2cUpBTGVVRUM1d3VOSGVyYjlzeHBveFo0?=
 =?utf-8?B?VUZHLzg0dEdJYUZpTlFlbkt6cXVyL3pjZER4TlEwNlVCV1o3dVNPb2wwallC?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	26ZeGl8BnORsOnXgR2QU8Ong5/UaiecWRPDwaZld1VfRYwBDkkYuWDW42UoFx8JQCweXPWx3OjPyqxN8VgESUTu2NlaTZ34Y/TUONvdy+IEtOyBI13peDUZvP4TGuGnlo92mCXbXLLoLwR+h1ltFXKGZHs94NigsLESHKhD/3mkGsb7cz1SRlLFoJacc+KHy8aqENvjsxWukMhQldbuIumJ7eIQy3ft3cTtpDNP/7qhBh6whgYurYp1enPdQ55/FljZa36mNSIiA/S/2023HOJM4rgRsMM7m9nHkTf5is4L2ZUKnjCB6mFMryGbB4J2uIJ8KrDXjPqJEIJI0QcVy3+P9GKaf757QOL5OP4Tp0Fxj3ckxlDtPaKtqbjroanEYO8GZdDmBaNVjQMWHD1WQC7pmDx5r4AC4AbAdHrmgqTRuzPeoktOdMxNxMDeu6NkqYFGBpNPEzJAPpOwj7gYWbuV/+s6kGKCICNq2NPsBKshuFNTDbYVGJKHt9UirAkmoxgeADrGb3BzmNxLdlV3WWBpkr9WSWt3nol1cNuF8/gS8OHD7sIbXzPTWX8jhDfduQI5XQ4RmDiJb174oZVXH+WwNq2ZQg/MIIAAkP45Ryuw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddfe19c-578c-435a-1c99-08dc2986b954
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 15:49:39.3479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twqLSwNF5e/Kf6eYcFDXbmguTije/E7Ynq3zgdWXzYCRs0W2Em7AsKfwiaqs17qe6W5F8GfEalKsp+vITRBaXJEG7RMh9HZZSdzLPlFatGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5263
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_13,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402090117
X-Proofpoint-ORIG-GUID: 3XTkTWpNp-DtttPT_wE1she8bhXzhxp6
X-Proofpoint-GUID: 3XTkTWpNp-DtttPT_wE1she8bhXzhxp6

On 1/16/2024 1:14 PM, Eugenio Perez Martin wrote:
> On Wed, Jan 10, 2024 at 9:40 PM Steve Sistare <steven.sistare@oracle.com> wrote:
>>
>> When device ownership is passed to a new process via VHOST_NEW_OWNER,
>> some devices need to know the new userland addresses of the dma mappings.
>> Define the new iotlb message type VHOST_IOTLB_REMAP to update the uaddr
>> of a mapping.  The new uaddr must address the same memory object as
>> originally mapped.
> 
> I think this new ioctl is very interesting, and can be used to
> optimize some parts of live migration with shadow virtqueue if it
> allows to actually replace the uaddr. Would you be interested in that
> capability?

Sure.  Please share your thoughts on how it would be used.  I don't follow,
because with live migration, you are creating a new vdpa instance with new
shadow queues on the destination, versus relocating old shadow queues (which 
we could do during live update which preserves the same vdpa instance).

(Sorry for the late response, I stashed this email and forgot to respond.)

>> The user must suspend the device before the old address is invalidated,
>> and cannot resume it until after VHOST_IOTLB_REMAP is called, but this
>> requirement is not enforced by the API.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  drivers/vhost/vdpa.c             | 34 ++++++++++++++++++++++++++++++++
>>  include/uapi/linux/vhost_types.h | 11 ++++++++++-
>>  2 files changed, 44 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>> index faed6471934a..ec5ca20bd47d 100644
>> --- a/drivers/vhost/vdpa.c
>> +++ b/drivers/vhost/vdpa.c
>> @@ -1219,6 +1219,37 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>>
>>  }
>>
>> +static int vhost_vdpa_process_iotlb_remap(struct vhost_vdpa *v,
>> +                                         struct vhost_iotlb *iotlb,
>> +                                         struct vhost_iotlb_msg *msg)
>> +{
>> +       struct vdpa_device *vdpa = v->vdpa;
>> +       const struct vdpa_config_ops *ops = vdpa->config;
>> +       u32 asid = iotlb_to_asid(iotlb);
>> +       u64 start = msg->iova;
>> +       u64 last = start + msg->size - 1;
>> +       struct vhost_iotlb_map *map;
>> +       int r = 0;
>> +
>> +       if (msg->perm || !msg->size)
>> +               return -EINVAL;
>> +
>> +       map = vhost_iotlb_itree_first(iotlb, start, last);
>> +       if (!map)
>> +               return -ENOENT;
>> +
>> +       if (map->start != start || map->last != last)
>> +               return -EINVAL;
>> +
>> +       /* batch will finish with remap.  non-batch must do it now. */
>> +       if (!v->in_batch)
>> +               r = ops->set_map(vdpa, asid, iotlb);
> 
> I'm missing how these cases are handled:
>
> * The device does not expose set_map but dma_map / dma_unmap (you can
> check this case with the simulator)

I chose not to support dma_map, because set_map looks to be more commonly supported,
and batch-mode plus set_map is the most efficient way to support remapping.
I could define a dma_remap entry point if folks think that is important.
Regardless, I will check that ops->set_map != NULL before calling it.

> * The device uses platform iommu (!set_map && !dma_unmap vdpa_ops).

I believe this just works, because iommu_map() never saves userland address, so it 
does not need to be informed when uaddr changes.  That is certainly true for the 
code path:

  vhost_vdpa_pa_map()
    vhost_vdpa_map()
      if !dma_map && !set_map
        iommu_map()

However, this code path confuses me:

  vhost_vdpa_process_iotlb_update()
    if (vdpa->use_va)
      vhost_vdpa_va_map(... uaddr)
        vhost_vdpa_map(... uaddr)
          iommu_map(... uaddr)

AFAICT uaddr is never translated to physical.
Maybe use_va is always false if !dma_map && !set_map  ?

- Steve

>> +       if (!r)
>> +               map->addr = msg->uaddr;
>> +
>> +       return r;
>> +}
>> +
>>  static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
>>                                            struct vhost_iotlb *iotlb,
>>                                            struct vhost_iotlb_msg *msg)
>> @@ -1298,6 +1329,9 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev, u32 asid,
>>                         ops->set_map(vdpa, asid, iotlb);
>>                 v->in_batch = false;
>>                 break;
>> +       case VHOST_IOTLB_REMAP:
>> +               r = vhost_vdpa_process_iotlb_remap(v, iotlb, msg);
>> +               break;
>>         default:
>>                 r = -EINVAL;
>>                 break;
>> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
>> index 9177843951e9..35908315ff55 100644
>> --- a/include/uapi/linux/vhost_types.h
>> +++ b/include/uapi/linux/vhost_types.h
>> @@ -79,7 +79,7 @@ struct vhost_iotlb_msg {
>>  /*
>>   * VHOST_IOTLB_BATCH_BEGIN and VHOST_IOTLB_BATCH_END allow modifying
>>   * multiple mappings in one go: beginning with
>> - * VHOST_IOTLB_BATCH_BEGIN, followed by any number of
>> + * VHOST_IOTLB_BATCH_BEGIN, followed by any number of VHOST_IOTLB_REMAP or
>>   * VHOST_IOTLB_UPDATE messages, and ending with VHOST_IOTLB_BATCH_END.
>>   * When one of these two values is used as the message type, the rest
>>   * of the fields in the message are ignored. There's no guarantee that
>> @@ -87,6 +87,15 @@ struct vhost_iotlb_msg {
>>   */
>>  #define VHOST_IOTLB_BATCH_BEGIN    5
>>  #define VHOST_IOTLB_BATCH_END      6
>> +
>> +/*
>> + * VHOST_IOTLB_REMAP registers a new uaddr for the existing mapping at iova.
>> + * The new uaddr must address the same memory object as originally mapped.
>> + * Failure to do so will result in user memory corruption and/or device
>> + * misbehavior.  iova and size must match the arguments used to create the
>> + * an existing mapping.  Protection is not changed, and perm must be 0.
>> + */
>> +#define VHOST_IOTLB_REMAP          7
>>         __u8 type;
>>  };
>>
>> --
>> 2.39.3
>>
> 


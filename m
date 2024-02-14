Return-Path: <linux-kernel+bounces-64994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4578854657
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 021F9B23D96
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9949E134D1;
	Wed, 14 Feb 2024 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xr84sxZf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bn1JOFyu"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B23A17580;
	Wed, 14 Feb 2024 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903809; cv=fail; b=LT2kQNqSI1ktgLZXuIetCgPUh5TJEgMbe+G007RMCMBWQa+EGhA1Vy8jPk5tjTGMaImekniVAQ7HV+NA9BdgYENeUYATn8OcmvmnOF009uVwayBsQ7hzxCByDD0xeOKiBDy7iIjZvyVaRzn1x05YggdRW1VOv2IAhjh2g23i7T4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903809; c=relaxed/simple;
	bh=6lFRLzwfBauHhDtiws/WXEmd9rlOySHGzLtUInjDugo=;
	h=Content-Type:Message-ID:Date:From:Subject:To:Cc:MIME-Version; b=VkIjRPjuRGIK1qjC+SlOthPJ5a0MSa5Jk/IW6DNr1lzGeAUUl93tN9i40wHieEgUkoDjTvPqYioPsFV0P+BJoXqqJU0rIonRRVEkI5HidgNxFFiGRo0NGVHrusHBgnFZ1L4hRgw+d6QPu2NMnS/XoumxBRd6XrgAhxLSoBDhp78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xr84sxZf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bn1JOFyu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41E9F56E027262;
	Wed, 14 Feb 2024 09:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 message-id : date : from : subject : to : cc : mime-version;
 s=corp-2023-11-20; bh=7xtg54w8LjFd/u5JfObbYD25X9pTsPka695gf+HRiZ8=;
 b=Xr84sxZfoU+ZICXZlxc/MzOR3JD0zoc7wbgT6RoHdGA99cz4OCc8P2JpSzIBr48CkOjw
 FzfoOqvWkpvON2XHGMrPvC7mvB+3hAkjEHOFLDGHS9tgD5v/Efg5KtDL3DR/pnTdLUI2
 XQadG0tQtvK2Uk0naHs17B5s3YO9qjnvIshWfoO5x0TlpJe+rWBPn40Aoj0malfvnUnS
 yumZaRnYKd2yLw9nCo7BjQMFoVbBdyhHwrLsrzfIWa37loZJBQY8Z2dDjsM2yFzugG0y
 It+kzxkDu2PVX0PjVTvxfAJj2Cm0ZmTgZKTumIGkIjPZbItOba64Hc05xDKXyjJWyKmx Jw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8tqfg3kt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 09:43:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41E8xvUn024042;
	Wed, 14 Feb 2024 09:43:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykeyyag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 09:43:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nn5Uwsv8QEFjNdXKe4XhBRsS3VEv2u8WsRMxKhZyqzHHkSAO2gQrK+Tsb4j9Zj/U/bD+nSG4q8Nojy9F8qhgh7SX97tCMi+zB659Rwn5T7xjLyBeC9vqcJeoBrfraKwrhU/JCCuVJYLzcbsRe7YgIIyvKcZuNh9HlK+D4FY6h7s/ioqwVnvVAPrEGmDqrfgnVCls31/R8Qen7rwwGxn0tJt4f5ljkR1/ZWiGfMhvBoEezEMFmFLyeBXlr8rJP+wDM3tDtsj0IkjvY4hzJ6M91lvhL3pdVGv3Gihq975NV71SuEHajxaTZIXAvYO9EZTV2ZULV8/5vvrnK1h/S6smEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xtg54w8LjFd/u5JfObbYD25X9pTsPka695gf+HRiZ8=;
 b=g9VlqaYXp3CUGLB/Uiu7l7Zf87FL2AGW6S/R0ITuLXqTgCK7dBH+sjT9qci0F2TLvTrZpc10vanM3OrLTLumuOvjz8odEUYH2KXFrZN2E0jZEIz1RV1W/tTf2bRhZxwxyMNLORLXmubjozNsUVJJTPtAGQIk0W2nAqzfUnJOoFSP/cVgu2/N3PSdoM7rFyWXCZtybkEG8ewkx6wxbyOae4jxLVo+fvv6DXkUBiJkkrNSUrsfPEsDqW+GNaJKR5N2l1j7i5D76+MfBNfXnie0yGxn7RrOAyg9fxGjepAAOHA9GHFH8FYIVk6UXkHZiY+Gr2ud44kT6J0fuBiJL/OaQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xtg54w8LjFd/u5JfObbYD25X9pTsPka695gf+HRiZ8=;
 b=bn1JOFyu2WCvC+3gUoTWtMpYnO/xlap8D6dtojfvbieddbGlDOMMSqAWys2StWPYOeCrs3KDx9OqRf4x+16XKjZeoc6i8aanzFnmnz9tyMV3McCoWyqqe8TMEcb4oGAIdJ8WNEQ1ZUw6nBlGVlNWmoH6nwY5WwRHDn9uoaDMEA4=
Received: from CH3PR10MB7305.namprd10.prod.outlook.com (2603:10b6:610:12e::6)
 by SJ0PR10MB4576.namprd10.prod.outlook.com (2603:10b6:a03:2ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 09:43:16 +0000
Received: from CH3PR10MB7305.namprd10.prod.outlook.com
 ([fe80::fbe1:7124:8feb:25b1]) by CH3PR10MB7305.namprd10.prod.outlook.com
 ([fe80::fbe1:7124:8feb:25b1%7]) with mapi id 15.20.7292.027; Wed, 14 Feb 2024
 09:43:15 +0000
Content-Type: multipart/mixed; boundary="------------LxpOXPLGm4i1gIjOVLF5f9S2"
Message-ID: <08693d17-f2a1-4b5e-a136-81138ca3a58d@oracle.com>
Date: Wed, 14 Feb 2024 10:42:55 +0100
User-Agent: Mozilla Thunderbird
From: Radek Krejci <radek.krejci@oracle.com>
Subject: srcversion hash does not cover all the module's source/dependency
 files
To: masahiroy@kernel.org, linux-kbuild@vger.kernel.org
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org
X-ClientProxiedBy: LO4P265CA0116.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::16) To CH3PR10MB7305.namprd10.prod.outlook.com
 (2603:10b6:610:12e::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7305:EE_|SJ0PR10MB4576:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ca9911-85c6-46e6-3451-08dc2d415dee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	687yz/gLT0YD8iRR2w2WHKcozSHzLbORjLLPDD2YCa6nab4Kbuf5/BiwlOMyU2jW/BgVmxC4SyxzPrjlzT5i1I4hx0E13Khc+ctfBHUBOF88s1fvo2z00bJ14bVmQ9J3SVCMuf2eZgcUN0PQSI2KbZaeWFyjG04us8CMDC6EhEdjlLhkffg8b2tAwlofIt8M4HCTOkxNbT/cQY1mzZP+u93CuFPF0a8EPUdYCkpu8L5gGBhfWHD1R7XFtUQnB7rMHWmQGGXTXQuS4eepQLsK8w5YqX29q6i3MhgD34s/ct7lavSWF5yXM6hpyKEyUdKnbpQjvw4s1gx0dQ/H/chpG1PaTaGE5237HPBEc7J0RmyM5GVku7TyjVln98ix3pERIIFH6eoz5iViZt2kUf7go7qnQ++6zDe0eTZp2hdKoRl+2Jl9FDlyCRL/q2YAsCCbiSEnNUAwZqv0Ok+9n61Gzg6nwdgN6J9DIGFAw6CrpVHGfPKT+KxiseT7GDLWvT9NUubTCiqMtBeljNTbiV4vvkzIUaqmN6s69PAV+9WGSffOC8FmR1Py2fK9UO+fBW6/
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7305.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(8676002)(4326008)(235185007)(8936002)(5660300002)(41300700001)(2906002)(44832011)(31686004)(31696002)(86362001)(83380400001)(36756003)(2616005)(33964004)(38100700002)(66476007)(6666004)(66556008)(66946007)(6486002)(966005)(316002)(6506007)(478600001)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y0habjBOTGRVMGVRNEZBU0J0dlBiMGFLcEN3UFo0WnlIQndSek1GWmU5bTdC?=
 =?utf-8?B?NlV0R0lTcHBVdHhJZ3gyRjg1OEllclowRzJobWJaTzBIQ1FrbFJ5ellUbkdp?=
 =?utf-8?B?ZGNKTUtjWUV6V3dORTdtWFFrd1p6UVhDV1FDNDNvUzBhNWYybHlKUWNVemdF?=
 =?utf-8?B?NmtjUVduQS9FT3BzYTVqckFxVGwyQmoxdVdJWEhtKzhZcTgrVVVldmFXdklS?=
 =?utf-8?B?WmhpcjdzQTdNaGVYZDNOcEpkalpPZVc2UWR0VzZrQ3BLaXhhazlCWWJjeTB6?=
 =?utf-8?B?cU8vL1c1c25DOTFFZ1RnQk9RVjFRVUl0V2lQbGQ0Nm5UeWN3SkJrVGRhaXRS?=
 =?utf-8?B?eWpGaVdzUTZITE16emNqcWxMdTlFSVg0aWtGcnpaZzFzbWdPRld1TG9VaCts?=
 =?utf-8?B?ZzBpdnlHc3JyZUxVUDdpVzZmcjVqd3NRaXZMSFpXbkdzVkxreEZ5aGlIejVO?=
 =?utf-8?B?YldEQlBMOU1RSFNiWTNJd1UwT2lYeGYzTE80SWdiZ21aUzJkUjJwZmJrWEkz?=
 =?utf-8?B?R0RJbXlWaFdTTEppSTlVdE9nZGpBZHRNcHNaU1RSekVoU3pVMHl4OXNvamZE?=
 =?utf-8?B?emRZS1ZmbGlnR1hieW54M3ZnYU9QRzZ0aGtidk5PbE5tdG0rRnNaT0VkdmZN?=
 =?utf-8?B?bG5VR2NSUFUxWDBZeEFyK2JvZUpNYXJrWXFlRE1ybWVZVFJ1dE9HR1pJbW85?=
 =?utf-8?B?K2xFVzFKRDhOaHBxTkJDZmZNZU5PMVo5SEtCNEhqeW1OcTNxVkZLS2g2QVpX?=
 =?utf-8?B?TktlbUwzelkvTzNUUmZEcHN4QjA5M2NMOFBpRDVLdm05UDREQ3M3d0Yxc3E2?=
 =?utf-8?B?dWpEZGpXVVNqRkc5ZzhBc212VWlSbzVudkpTTW5oY2dNRURwWVBhYjk3RnBa?=
 =?utf-8?B?ZER1VisyM0xScUhBOVdQK1Z0UFNObEQ2R0h5WUFZKzlwdjROU1N2TXVqVWhs?=
 =?utf-8?B?c0lNWkdaSFM0dUNSeFBNa1BtVUVySmM5c09QVEMvUW44Sy9UOHQvOXViMm5w?=
 =?utf-8?B?b3JRZ3hqZklBb2pTQnVPd0VQeXBVT3diQSs0Z1VKekc2Ri9UMG9qMnBZV1ph?=
 =?utf-8?B?NjdMZTh3Rnp1bXQyVTRmZU45anQ2VXBFdldINFRQS3JEVmpXZ2hzL0FCak5z?=
 =?utf-8?B?U2FndDBrOGpUU1huV0tZWmRMVndUNnhoWXBLNTQrL0o3bU8zQ2Rkc3BrQW9T?=
 =?utf-8?B?RVFIbHcyS29hQ29LWjBJcHNKU0JNLzV6WmVaUEVUNFJpWmlXcG02VVkrUTkx?=
 =?utf-8?B?ODZYS0R1UjlUcUJOMHI0TGFFOFlCditTbDFvNldINUpzNE94eEhzYjltR1JK?=
 =?utf-8?B?bnBCeXFZQ1hsMnYyQ3cxMXRXYWMvMTFMYVhYYWE2aHJYRlRXbnl6Q1B6aFZU?=
 =?utf-8?B?VGpBNC85NUNYZzEyYSs1eVRPazl6cmxmTmJadnNmaWprTi91cWE5WVF0R0RS?=
 =?utf-8?B?M3ZWeXJtemY5cnJYeDRocXZyeVBoYUhPb0kzWlkvdFc5VWNrUEgzdmk1ZUU1?=
 =?utf-8?B?WmhUZUY2eHdzckRKS0RTUkZwb2pLTDRuUTJCQ3FKNzJFMUV5dkxER2hIME1M?=
 =?utf-8?B?N09yRlg5UkpMbUtuVFRjcHYrL1RwSTJWbHkxRmV1UXJiV1hwcWY5L0JRaVZD?=
 =?utf-8?B?NHA4TWxoaG5qSzdxYjdneUFaYnNSTnpEMWwvU1RiWk5GWGRwUlNtZmxpdlF3?=
 =?utf-8?B?RmdES0NPUDNvYU0wUXVrSVMvYVFCZDJabUtzMVg5RzZveWh1YkUzTEV0U2c3?=
 =?utf-8?B?YytJK3JWM3ZnejBSWkFiYTNqMHRNa0thQmtDclJoV1MwbEdrdnlMaWhHZGVl?=
 =?utf-8?B?OURaYVl1WGhVcTRXQkVIWnhreFhHaWhneUFadTUzekNOQjFRTnUxODUwcWpT?=
 =?utf-8?B?MFVGWEFOVlJxZjhxMXF1VDArdXF3MnBwM3RyTE5vU016SlJiREZ3U0J0djQ4?=
 =?utf-8?B?RlcyMGNDdTkxSkZHNUQxTTRGOWRZUXgxUlNzVlA5MXRNWndYSXdobnVEUmJN?=
 =?utf-8?B?TElERWkwZnc2aU5iQ0I4MmlUWWk5WGdrQ1QwNW5yRUd4SHh5dFhpYTlvN044?=
 =?utf-8?B?U0Z6WXpncllhUXJieHJNTEVCbVRTMnRGQ2JFc3BKYWVobGhLbHV4cUpNRktS?=
 =?utf-8?Q?k3wQIpGfLvT77sm8Kw3p2mdNw?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RlkyP+p8p5mE+XC+hWrprKF6lDKWDBtNkZH7zXm2z6OnRnFgwyRtBBsJOpxoptYQCOIh3VXqjF+HgWVg9HqL3BuJbY3GS12N7i0wsUQJC9JExnJ5LdUAWvINL1PoInlyWAA6Xmj+gZE/DYKiRkKPPIS73q7MNqrkdD2pI4rT91FAEZYuxTiD6yPsyfHBCoDRY5cy4ddmZudL3cqWQqSGLaAodh8uVomKYWXX8dkJVP3XLW2c5HMWzxWlSuJEVBCfzPgvwY9Z/ubNGmrWMtTKhpqETRlrJQC+NolNUJivsAP8SFs4fsxmaLeZYZpC+yOjJBD5fq4ZeBfeX//pCBKyDkOmdwdSGWXH3ncU8ysoRRBTbEPiib7Ps1dlkU6smQbZgBlGbfyu7Z6W2zPQro4jd2+4kLrHKKJfNe+Ar6dIvyqu2yvxRXDmrtflmgNzx5ueRCf8+fjspFf3xqlDOa3rJlkCZJiPGtjTmgLJ9/n4DC6goby6Hcf/IGo+EtjFmYjGSXYuR8oxQNbe0Fqi5Xhfl3Eud95Mplf9T266oAXF2DVTJBwBH3BHSrMH1blPhJZWQUxoHTzEsI4J/Uh7yoivcoBjWeG/QaOGpe4iE5TXeNU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ca9911-85c6-46e6-3451-08dc2d415dee
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7305.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 09:43:15.3713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1+J0FFbAMGNUbq6met0jbPIxF/afSZBTBBDldMAQ1IhqOlHOlG1cXnBegSEQBU8iBk7R2zKsFWXGQDafUvbyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4576
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_03,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140075
X-Proofpoint-ORIG-GUID: kYZKw4D_ag7VyX90D62OP1EQo3GpWRNM
X-Proofpoint-GUID: kYZKw4D_ag7VyX90D62OP1EQo3GpWRNM

--------------LxpOXPLGm4i1gIjOVLF5f9S2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
I've found a bug in modpost - when it gets the list of source files to 
generate srcversion hash, it skips all the source/dependency files 
except for the first one.

There is patch [1] in v5.8rc1 replacing get_next_line() by get_line() in 
parse_source_file() function. Besides other things, the difference 
between those 2 functions is that get_next_line() trims the leading 
spaces of the line being returned. The issue is, that the source (deps_ 
located at the same directory) file names in the list, being processed 
in parse_source_file(), are indented. So, when the code gets to 
"Terminate line at first space, to get rid of final ' \'", it 
effectively hides the source file name from further processing, since 
the first space is at the beginning of the line.

I checked this behavior with modpost from v5.4 and v5.14 (and confirmed 
with the current master in git). In my case, my kernel module had just 2 
source files - mymodule.c and mymodule.h (both located at the same 
directory). With modpost from v5.4, the code change in any of the files 
was reflected in srcversion hash. But with modpost from v5.14 (and 
master) there is no hash change when the code change appears in the 
header file, which is listed at the end of the deps_ list. I believe 
this is quite simple to reproduce with any module, but if needed, I can 
prepare some example code to reproduce the issue.

I noticed this [2] email thread in the list. It mentions a similar 
issue. However, since it happened a half year before the change [1] was 
introduced and because I was unable to find any further details, 
including the promised patch, I believe that these 2 things are unrelated.

The enclosed patch worked for me, but there might be some other 
consequences that I've missed, so feel free to modify it on your own or 
let me know.

Is there anything else I can do to help fixing this issue?

Regards,
Radek Krejci


[1] - 
https://lore.kernel.org/linux-kbuild/20200601055731.3006266-26-masahiroy@kernel.org/
[2] - 
https://lore.kernel.org/linux-kbuild/CAN19L9G-mFN-MTmw0FS3ZX4d1MjeoL2U+s-Fk7Qw9UYWn5Q1YA@mail.gmail.com/ 

--------------LxpOXPLGm4i1gIjOVLF5f9S2
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-modpost-trim-leading-spaces-when-processing-source-f.patch"
Content-Disposition: attachment;
 filename*0="0001-modpost-trim-leading-spaces-when-processing-source-f.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA4ZTE0YjhmZGI3MTM4NWFiNTNhZjQ4ZmM1NmQ5Y2Q5ZTMyM2UxMjY1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSYWRlayBLcmVqY2kgPHJhZGVrLmtyZWpjaUBvcmFjbGUuY29t
PgpEYXRlOiBXZWQsIDE0IEZlYiAyMDI0IDEwOjE0OjA3ICswMTAwClN1YmplY3Q6IFtQQVRDSF0g
bW9kcG9zdDogdHJpbSBsZWFkaW5nIHNwYWNlcyB3aGVuIHByb2Nlc3Npbmcgc291cmNlIGZpbGVz
CiBsaXN0CgpnZXRfbGluZSgpIGRvZXMgbm90IHRyaW0gdGhlIGxlYWRpbmcgc3BhY2VzLCBidXQg
dGhlCnBhcnNlX3NvdXJjZV9maWxlcygpIGV4cGVjdHMgdG8gZ2V0IGxpbmVzIHdpdGggc291cmNl
IGZpbGVzIHBhdGhzIHdoZXJlCnRoZSBmaXJzdCBzcGFjZSBvY2N1cnMgYWZ0ZXIgdGhlIGZpbGUg
cGF0aC4KClNpZ25lZC1vZmYtYnk6IFJhZGVrIEtyZWpjaSA8cmFkZWsua3JlamNpQG9yYWNsZS5j
b20+Ci0tLQogc2NyaXB0cy9tb2Qvc3VtdmVyc2lvbi5jIHwgNyArKysrKystCiAxIGZpbGUgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvc2NyaXB0
cy9tb2Qvc3VtdmVyc2lvbi5jIGIvc2NyaXB0cy9tb2Qvc3VtdmVyc2lvbi5jCmluZGV4IDMxMDY2
YmZkYmEwNC4uZGM0ODc4NTAyMjc2IDEwMDY0NAotLS0gYS9zY3JpcHRzL21vZC9zdW12ZXJzaW9u
LmMKKysrIGIvc2NyaXB0cy9tb2Qvc3VtdmVyc2lvbi5jCkBAIC0zMjYsNyArMzI2LDEyIEBAIHN0
YXRpYyBpbnQgcGFyc2Vfc291cmNlX2ZpbGVzKGNvbnN0IGNoYXIgKm9iamZpbGUsIHN0cnVjdCBt
ZDRfY3R4ICptZCkKIAogCS8qIFN1bSBhbGwgZmlsZXMgaW4gdGhlIHNhbWUgZGlyIG9yIHN1YmRp
cnMuICovCiAJd2hpbGUgKChsaW5lID0gZ2V0X2xpbmUoJnBvcykpKSB7Ci0JCWNoYXIqIHAgPSBs
aW5lOworCQljaGFyKiBwOworCisJCS8qIHRyaW0gdGhlIGxlYWRpbmcgc3BhY2VzIGF3YXkgKi8K
KwkJd2hpbGUgKGlzc3BhY2UoKmxpbmUpKQorCQkJbGluZSsrOworCQlwID0gbGluZTsKIAogCQlp
ZiAoc3RybmNtcChsaW5lLCAic291cmNlXyIsIHNpemVvZigic291cmNlXyIpLTEpID09IDApIHsK
IAkJCXAgPSBzdHJyY2hyKGxpbmUsICcgJyk7Ci0tIAoyLjQzLjAKCg==

--------------LxpOXPLGm4i1gIjOVLF5f9S2--


Return-Path: <linux-kernel+bounces-57386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FED84D7C2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9482B225E3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7723F2C1AA;
	Thu,  8 Feb 2024 02:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VnQhEZWO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FFOB/zUa"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF7A25757
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 02:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707359141; cv=fail; b=kFmiE/NcQabDtI1LZjQpZ7ekTHBSfgZsc7lZP36EwQofnmDBsW5J0UwLnmJymurZZrzDYaq5tDfvrVDXG1nGrca0qQJCZCB+NLJin668X/K9Oufknd7HlzkIJ1uQYxi5E+Lp+F7YqOciqTmoclmeoEYT/zT/atBg9tyPmsyywGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707359141; c=relaxed/simple;
	bh=Co0UM/6MqhHTQLwbYx+AhREhod6vfQzYAlIJZhWPAP8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bdc8BLNHQW3N8PY8rR2Il3dZ6Qv4xrLNm8pOgtChRjmujL/5ywpmvsZcQSRBYHuwx0JH9L5cJPQvlNqLNPbC34sndFmQYaqY6iKsTx5nM2Ana/LCbFDOW6TZupkLCU75JrejKskEWW9mjcbxEjheWyU4xg0HyVQUT+OJjK88EGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VnQhEZWO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FFOB/zUa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 417Mbqun025004;
	Thu, 8 Feb 2024 02:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=blLccjbPC91h3l1TOSxZl58hz8g+NX4I+QqGB1o6sQ0=;
 b=VnQhEZWOwaP727Pzb35sno4rcH5GP80MZkhoDIU+qTTHk8iKRtHFLo4HrX2A1prMvy2k
 XRsXkPDjSuC2XkY54owUuWRAPYDq7Y98zb5l2mMZ8HT0Z+YlR4DUtUlmWKC1ld/o/Vef
 MtY+qXa2z/STCGowZi8YJeChCV3siDvPjoYzez8EhW6G9ld+HJ0w2J+AJvv72DUO5qp0
 LzI+N9O2kAWfiMG3wgXRS+XYuRQecfKmkRKuXyy2lOOpYRmDfSPlXZhSJJm9DqT2KP/s
 usTWT5CeYs4EUDNzd9eedoMrtuTLRlvSPkfbN45Qxq9iM/43Lu76FqogUAJUB9cXmSXV yw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c943jjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 02:25:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4180gMA8038686;
	Thu, 8 Feb 2024 02:24:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx9s6bj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 02:24:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyjykic91iG9CoyEQRtIhflvlsT0iR8tzl2wfDsMCnYhazO2p8AOfPsRC2L6Xc+Rxn+z7SCeN5xrP+FWFVB6Al2cFOuAmML326o7fvndTmNUU0zVvsenvalXfgZ85Di6nrJSeyYpOTbs0pi1ZZe37McPSO0eF/baAtZwhHOjd6hbln4y3L2BXnb9eGKhhKQwuYCSYJyBOJYpyj83jyNdGic64qo9gs/VZHDkgw4zgJAHw1iRB/h90lavu0rjiwdYmDgSF/RCP6jQifWJkh+d5EKT/FHNoXXGK1fUkBQXsx1xXlhBp33N/LjcXxBdKo5P3xi/O6npQsftP4uE8XdZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blLccjbPC91h3l1TOSxZl58hz8g+NX4I+QqGB1o6sQ0=;
 b=YkuOtX8ZmpLxyxAnXeAbFyj8mdl1xIGGcDuWstNIKGiejpuUMsCQD2O8aieyJTZf33FcQfuSPSlN3c9emY7+VMeu+W584/eEixlXMnVIsWpvycAEu929MYbGJxG1ZEoFMTmBGJCm2j0ftGPZNROAFESR6RHtuHGCOdGwiva9qMNRFTNFQV4moNZN1ppyrjcKBGAC5H8yGpkfUWfQYqtSY+tUt3T1wEDCZQ75u81iw2HrfH1a8sO89smRcPTt7XUIUP0y8Ky5wg0oHKE9rjFbLVUTZsYUXlGuZdDsL2tCKfXJ2vJ+RbQ+2bnoEWZVdmEeG0ygikKT9p2SgrZ1RxvZPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blLccjbPC91h3l1TOSxZl58hz8g+NX4I+QqGB1o6sQ0=;
 b=FFOB/zUadUAFd5zo51IxEZTvrjn/iMyaAvmR214UClJx1BoGc3z9Gkh1RBohdq9Dwy8iKT7n0QHCYRQKUvsQORSJ0dC6+jAQhMKPmERFy0DC8kxbfyKB1qV36z3fs5YrQlvxIaeGsF2IYtYX/szlUVuxwWyRdOeplRHhhQnSxo8=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by IA1PR10MB5947.namprd10.prod.outlook.com (2603:10b6:208:3d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Thu, 8 Feb
 2024 02:24:58 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::210e:eea7:3142:6088]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::210e:eea7:3142:6088%5]) with mapi id 15.20.7249.038; Thu, 8 Feb 2024
 02:24:58 +0000
Message-ID: <908066c7-b749-4f95-b006-ce9b5bd1a909@oracle.com>
Date: Wed, 7 Feb 2024 18:24:52 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] A Solution to Re-enable hugetlb vmemmap optimize
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, Will Deacon <will@kernel.org>
Cc: Nanyong Sun <sunnanyong@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>, muchun.song@linux.dev,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <ZbKjHHeEdFYY1xR5@arm.com> <d1671959-74a4-8ea5-81f0-539df8d9c0f0@huawei.com>
 <20240207111252.GA22167@willie-the-truck>
 <ZcNnrdlb3fe0kGHK@casper.infradead.org>
 <20240207121125.GA22234@willie-the-truck>
 <ZcOQ-0pzA16AEbct@casper.infradead.org>
From: Jane Chu <jane.chu@oracle.com>
In-Reply-To: <ZcOQ-0pzA16AEbct@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:208:23a::21) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|IA1PR10MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: 87b5a4fe-cfe5-4776-d8ce-08dc284d250e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	l3YmYCrmwg9ZUBjqEDoRmkyCrb0g6ZYel8x8L4OGS3E7bwfjw+FdTMpuoMd5s36e9Q6jocTjTsX/SNnw/fQijMnDXiCaG4iTxyJXPGjffNHToxck2zhVeBcoVapFG36lpd+kfVDnbVb45F+Y/CSZ8WwGTQiHgHbnFbwNZHXJ2tep2ZdEirpyNWG4iZwwT+5cWp1OGcJuNvwvkZXLtu3oLZgi59JCv7hJlF721yv+RbZo7mxc4cOvEpLxPvDEMtfHxr+KSjM3CFkuQuRauPBv0MeyD4YMYHnCdX9mBX1EzjE+rE9Laf7fA1w/lajiUEv2Zfybg0Ju8XVSTOr8pCTztMNurNL5eRd3fjDW7MvmOHB1qFCgbF7pjbQ1hZ4rcGNTM0GH/5qPHsOjhR5lu/Cm1G/fT2Qbh0r49cdgQ8hB6M8kihGuaoW6/9gplnxjhY5ZoCaKtodvVojZGH3mC68DL0Cl2fLCYbqbFiv7wrbOZCPKK0F/DFUrHq4nMbZUnCa37yMGzGmBrZaXKbDqNTR0WjJlWi7EAlCwQKqVzry8LXhoJyB1b/qwl+s2WtNTdExv
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(31686004)(41300700001)(6486002)(8676002)(4326008)(8936002)(5660300002)(44832011)(478600001)(66556008)(83380400001)(38100700002)(66946007)(316002)(86362001)(54906003)(110136005)(31696002)(6666004)(53546011)(36756003)(2616005)(2906002)(66476007)(7416002)(6506007)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dEF2bUMvN1ZVYkwrZGFSWmpOK3VuRGdpa1FyRlBReWRVNEE3bnVOcGdvM2hy?=
 =?utf-8?B?TE1odXBHai82ZkRNR2NlcU9hRnlmL01ZRklqSFljSTBielh6MUUxNFcrMDlw?=
 =?utf-8?B?R1ZQY0xyVHgzQy9Fa1AxOU1rRzRJR2lHVDkvQ0Q1VElsK3lBSlRXTExrY2Vv?=
 =?utf-8?B?bFZxdExmdklIVXZEK1RnaWNZVGtxN1dYYUh4S0hQOGdUTWxZcGVYMGxCRytH?=
 =?utf-8?B?bVZodG5kZklGdzJrSW02SnNqMTlGZHI4emUyN0h0a0hCQ3lab1ZzcmpZLzBz?=
 =?utf-8?B?dnNvZ2hFZWRYQThqTFRtT3NlWCs0eGJGSmVhdXl3TXMxS0kvWW9SSm40SHBO?=
 =?utf-8?B?TUNkSEg5dFFqMEVwUmtSQzFkeHVXeUZDYUcxOVFnQVhlM2FMWkFocVErd1NE?=
 =?utf-8?B?dUFHTW9rNHVNaGZlYzQ1dEo3bUlpYUJIWm1BUW1ROVNNZ3E5Vk1Zb1NRNFlh?=
 =?utf-8?B?TWl1SkhvNWV5UlU1OExVRmNNMzlWVDVJSm9GcTRjSzZXaXhmVndkTHMwRlBx?=
 =?utf-8?B?LzUrUjBNTkZIbHplaEk4d0EwbTc2Qy83Um1YT2k1a011R1k1ZjFhWjVtY0cr?=
 =?utf-8?B?MFZoV2o2bnVEcGdqMXVURzFEWGtBUVpSU3FtcmxLNm9KbVdiYlpodlhUa1RP?=
 =?utf-8?B?VG9PODJFcFF3b2NUTEV3cUV2RkxwNEpRZWk4azk3TUJBRlNaY09KejFoREdS?=
 =?utf-8?B?TERYbWIrRFRiYXFqQm5xaUk5UnFJRExuRFBUR0RwYVVuNEVyRHJmajhUcHhW?=
 =?utf-8?B?RGZiL1lDaVd0K2JKcU9WcmdqeUhKeWltVGxTZ0hidDVpVWFPNTRobEdLL1Rm?=
 =?utf-8?B?WTlOWWtiS1ZoUkxxay9LUFVqaUIxQlNOYTVnTER0ZjY0Q0pYMHYrZzU5QUlH?=
 =?utf-8?B?RzlvSmRqblRyMDFnOGhPNGMxT2UweTMyYWQxREVMaHNBMDlXOXl3N0FuOVN1?=
 =?utf-8?B?OFFmRityTkVnRmFDb1d4c0NSV1NSTWduWXI5NTR6UElZQUVjZm5nTnFRMFVD?=
 =?utf-8?B?OFE5eGVNbHBDWnk0a2RRcEFNMEJIMU55MjlWMWhybURpMWxHT0RmdzhWb1px?=
 =?utf-8?B?YUN0N1pITjRpWkI3VGF0OUthQjJXQUNOa1h4L1hveGQ5QlhycWJNUlNlZldB?=
 =?utf-8?B?K2FYNWJ6V0VudEJoa2pWT3djM0dMcXgzazdhMmN2Y2xZODVROFRNNHcvbkx1?=
 =?utf-8?B?NnpYaXNIYjl0ZXg2MS9wQnBydnI5U1A0THBIbkN0NUJ6MWRjblpyckQ3MGxk?=
 =?utf-8?B?bTc1YWpCZW54eXlDVk9wQkhla2FSbWtxZVRFUFY4SjB2bDhmSlNrSng5bXAx?=
 =?utf-8?B?WHdwMXVIeGg4M3dkbWU2cjJKbm9LMnRwRk1QbkJSV2tGZ0VYMEV6d3JzeVEz?=
 =?utf-8?B?ajRldHZBZHpHRUN5YjFTeHJxQUxkV2l4UUxZUnpRclZpcXdmYktreSthcDJm?=
 =?utf-8?B?eW1aVUw5NEN0KzJ2aVNaM24yRW5EbnVzTk4zSEtmUUhJOFc2M0x2dEVyRFcv?=
 =?utf-8?B?TGdhNUJzMGltT0ZqUDFJQ0tLSlZNZDFIZEF4bkYxUDI5NnFRQXZXNDQvZnlF?=
 =?utf-8?B?TVRyYmxQYTBEaS94Q0c2M2Vya1AxeCtLWnBveDcyS2Jza1R0NmVPT0dHbk1y?=
 =?utf-8?B?YzNWUldwazZRWllWaUZnNEFObGFyK2cvWWNzMVVJZlcvMDVNOG1DNTE3a3Jp?=
 =?utf-8?B?aGgvU0FuQXh4QURNSnBpWTF0MWxpMnVGWUtJc0tBUGljeHEwcXhwQll2YU5N?=
 =?utf-8?B?L2xTMUtzNTJ3TzU0Z0VMTDd4aXltaHIzajFzTVp0eGV2eGJBTkFacTRSQmV2?=
 =?utf-8?B?TlIwU3FQRzUvQmxPWm9xSkFPTjNoMTJWS1pmdDJBVUhFNkRFWmRkdHRwU2cz?=
 =?utf-8?B?aGdkZXFuWDllWFFlenAvcDNDS1psZ2VXOXY5VDVSRGFrOEw4a3JvMzlTeUM3?=
 =?utf-8?B?T0tvRmFDWUtYZTk0V1p2cmNNckFXKzlMMXpwVGI0TDBNZG9qUEJPNDBCUGow?=
 =?utf-8?B?cjNCejJNbFByKy9hdm9VVmhhcXVjaklJemQramJlY0ppNzNqTW5rNVRzck1Q?=
 =?utf-8?B?d2puYmM2ZFFhMnVFbzFiQWlZTTdPd1c3N2xyanlNenltMytYU3JqTy9WSlFU?=
 =?utf-8?Q?5C2JlsQ/zMi9FBXi1ZTTagd8f?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nb5RjC13aVSwT+FWE2cIxqlSJJP2vD+epzKmRRdHQNSzPs7nC5agyXhHk1RWy4GMa/JjG2kJ9mF8V/wboGxvl6/tTKn9IEmBmTQTPrDdxpgaXYwKcuD8iftJyZWnoXpjopdP3Hv8x/drbvWYZ0ziD/ScZpc15CKWuhZtu0Kv5Puf/Ho6UyRFim5IhANITctUnzrPpYCibZKc2IqKPmfg7+1GhuNN7NpNCwas+guX56vVEoN4fV5Flm9KMdQ6/NyhD1Bgu95tOkeU+ebAMsCDjz15VX1xEuIAUzWNrxbBoyICCK2Jemjwed2toHsFLY8mRqQV6/wp9xwu53zOBpe0qgK5GBXGv4MR/rA9N9NQUhVTr3cp0yoUTWa3Rp+Qj0MTwqPLcru4M+GQW/CYBhR0VfXESfErdKjy7/9HdiPv5f5+wdnScY+kVsxmSUZ7MnezRpJpVlCW0Tn8nY8RDMiSCoQPpYs8S4gYjaKZSMRIrG6D45IFx4VXO4nMi8gYAkKazTC89kw6rD0oej83TEaGtuDO+xRQ6kQplm8NwEpBEjSvjsSfA//oXh3s0oVgcZdC3HdYRxpWtVt7wszuicJTFfuRFdrXJGps4IJYfVzyMWQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b5a4fe-cfe5-4776-d8ce-08dc284d250e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 02:24:58.0845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zFMR3YFGIBItAM+PfY90RynBjjMDXZzALvf+8sT53seSDHFrYFlZrK65MqFYMi1bqZiRcK/fnXn76cPHYNJjew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5947
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080010
X-Proofpoint-ORIG-GUID: EroeD8ghp4jWoaBihSvyCtTDHleQanMf
X-Proofpoint-GUID: EroeD8ghp4jWoaBihSvyCtTDHleQanMf

On 2/7/2024 6:17 AM, Matthew Wilcox wrote:

> On Wed, Feb 07, 2024 at 12:11:25PM +0000, Will Deacon wrote:
>> On Wed, Feb 07, 2024 at 11:21:17AM +0000, Matthew Wilcox wrote:
>>> The pte lock cannot be taken in irq context (which I think is what
>>> you're asking?)  While it is not possible to reason about all users of
>>> struct page, we are somewhat relieved of that work by noting that this is
>>> only for hugetlbfs, so we don't need to reason about slab, page tables,
>>> netmem or zsmalloc.
>> My concern is that an interrupt handler tries to access a 'struct page'
>> which faults due to another core splitting a pmd mapping for the vmemmap.
>> In this case, I think we'll end up trying to resolve the fault from irq
>> context, which will try to take the spinlock.
> Yes, this absolutely can happen (with this patch), and this patch should
> be dropped for now.
>
> While this array of ~512 pages have been allocated to hugetlbfs, and one
> would think that there would be no way that there could still be
> references to them, another CPU can have a pointer to this struct page
> (eg attempting a speculative page cache reference or
> get_user_pages_fast()).  That means it will try to call
> atomic_add_unless(&page->_refcount, 1, 0);
>
> Actually, I wonder if this isn't a problem on x86 too?  Do we need to
> explicitly go through an RCU grace period before freeing the pages
> for use by somebody else?
>
Sorry, not sure what I'm missing, please help.

 From hugetlb allocation perspective,  one of the scenarios is run time 
hugetlb page allocation (say 2M pages), starting from the buddy 
allocator returns compound pages, then the head page is set to frozen, 
then the folio(compound pages) is put thru the HVO process, one of which 
is vmemmap_split_pmd() in case a vmemmap page is a PMD page.

Until the HVO process completes, none of the vmemmap represented pages 
are available to any threads, so what are the causes for IRQ threads to 
access their vmemmap pages?

thanks!

-jane




Return-Path: <linux-kernel+bounces-66102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 128F18556E4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B349D28B0A4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2747113F006;
	Wed, 14 Feb 2024 23:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AW4Ynq2W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vwM0BGz1"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16441DA27
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 23:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707952237; cv=fail; b=XizmhCotK4k2mZQn8pk5Ogdg7RCqf6hAPHQO8keyxYBPxcDDuIFvVG1qZHHz0N3Gu4OfYpCK9bEhdN1JsLD0kC7QGsL1KikQrE2wsCanlWD3haMbkBGPArIWN4Ed+s3KrBlFTJS9pZ2MOhRSEVdzsUgB7lE1UoeCMmrCha90JSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707952237; c=relaxed/simple;
	bh=46n29GxmGhXMjZQk5vT2J0aFUTagnoS6smqOIVyQfw8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FyMQTxvIiJ5FrtWr488zfSrQegc/tSUzCoLyZ8rw7Zwyh7uKUtj/gGItAgSIB7u5zglEbkbdV4Ev1CVYCTXZU3v3pJNsiXLJ79TwSOp9S8K8xB8wpLb26C8YsmsOO/gK6sWfsu4VPMWDyEPqB9fpnruj2CVhAEFTfXX0UVcY3UU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AW4Ynq2W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vwM0BGz1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EMhuuk007343;
	Wed, 14 Feb 2024 23:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=LIbLrY5LkH8/er3dGoJUSyVKdyOS+VEYzYEPmxE+7mk=;
 b=AW4Ynq2WAcbqQ+p2BFK50MN3986tVpTXm9baEIjLlmDd+VCiv8sx1u1S4OeIzY0I2CcP
 wDMmqPu22nvUfT5SLupmoljlYnlijwKGTLmiePO42i3HQIcSbeXWFKPvUWbm1kq3H9a3
 bCTzIXfpWxu+WI6h2cRZp+zXGQ9DZqHGmMt88WqiL01/omQYPjblcPGOMfEx0BS7g/ol
 nuEWB8Oli/WBGwvID6zC5AwRoTDKKe1aluDRmq7NZN/GNAAMtX+jV/Wtaqquv2KQf0gs
 BhPgDLVOMluZgXj2YmpQfTsMc3LL3RsZX1hdd4I7/Gh0i8ISUVwMa05mzME35SmjAvmI mg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92j0gkkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 23:10:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41EMPTFQ014958;
	Wed, 14 Feb 2024 23:10:25 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk9cwk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 23:10:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSeW+aEfSU9+Y+xeMnycCfYDje+ljmjhQRU5mAlmRHdQ2ydzVYtXFgTHWlYOX2ZfHcveFS0BjsLOFI7OHshlDg14gVBVJrriGZT8O2oPW2Qza1239lHS8YCdfwFnRVe8Jp6IAZLXC2hE3WchbgIA/olMGOv/Nl/iPls+P+atvMFD1T6Ey0hDY2fE6KEDGWmet0cZkfkwg65e5y3QTU049+H2osCu2/8zvpdjYNOIwFv/sHj2df70ZwZ6+dwDWCS0A5v6J1mueF9oy62yIiJL1PyhsUgbdS3RwbTnNrGxN108UoL9QQOXyoU5X1gcfjwbPSUL7DGpCryqq58D9xIeqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIbLrY5LkH8/er3dGoJUSyVKdyOS+VEYzYEPmxE+7mk=;
 b=mAHmbiPCUwjOA7/L654/sOCrTrH6Kg1jcbuhzSjhrG8slAvE30ZBjZX89yGXjUKGlycSGFBWkfubGkkLOyocbBZB8MbwL6hMzWD824+/Cb01nzqPfcDiIBVd9sQM3bnRqq4atm075gaRL2NsczK6NJaxImNxDi1o+7EUNzjviYoi9Mrk54QNZFn77FVoQXlX2Sac8CS/QAJR7iwRSAiZ7dIjtrdRB0cKwYbBoaurFaOYnNSTzqjda97QNyK/0B2XRbegKm37NtQ0ZzrI6T2gDgOj3kreHjokM9DGu9vEDXZ1BXIB9qqR6qnjtFua9Wa0OQvBzicaU2biFy+p9FsbnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIbLrY5LkH8/er3dGoJUSyVKdyOS+VEYzYEPmxE+7mk=;
 b=vwM0BGz1vcCIGrQFdWTWNQpoXIb37O2YqUEiXJnO/dUJRE1+NcXD4KniFSb6ZWiLSvMBYFryv3cBrDqjVeShNxvuwDNhqcjbnUKYhrj3ItnHBcczBJgwRHvvhgYQbzZEC48l6a6gh7vBqsJATcl2rnr6M7jRs2Gj2fG1113USfg=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH8PR10MB6339.namprd10.prod.outlook.com (2603:10b6:510:1ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 23:10:22 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7eeb:3b3e:601:2e14]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7eeb:3b3e:601:2e14%3]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 23:10:22 +0000
Message-ID: <df59f5e3-6c16-e371-f987-7776f2d24f15@oracle.com>
Date: Wed, 14 Feb 2024 15:10:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] mm/migrate_device: further convert
 migrate_device_finalize() to folios
To: Alistair Popple <apopple@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, willy@infradead.org
References: <20240214202055.77776-1-sidhartha.kumar@oracle.com>
 <20240214202055.77776-2-sidhartha.kumar@oracle.com>
 <8734tu7jbe.fsf@nvdebian.thelocal>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <8734tu7jbe.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::19) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH8PR10MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: 702349b3-dc3c-45dc-3263-08dc2db21ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gdzK3eL3at+TPrVV67YPmB7BPBgvgIZW4t28c3rP/t0axJn3umRiXXQIxsMyj6Ht2vgZqZ17m6Y3FoWETxXY14tf0QnJxTykMCSPljD04eBtClauznZTstW9XW7ImWrfHFfsBR3VOtWypqypYecV6+cnB8WDzn7msftIsrFSDvC0fFBoNDHDhVNf9+HxmFoj372ggMYo6bifbMEy0CBEP3iSVFEN6gGhlHCW4ptFjr8VjolPpH1QrE40PghZdDYhNyt8F2b7dl5DB3L6V2yywrocbE7JL+9/LGtTX3cSbH4ZnSID1nEfC7CXddY6jmiZ+Qky885uy3hGiJTW9HxzH3Hb0wtUiC+Ng+F0CJpC+/r6HR/rbtNJfxN+2XEieng6SLO04QlPO/5kYweSAC/EYoZeCsxxLgE1IaWSvQEvLgQOBtlmtOi3mVNji8iRN0L6VumG0el3+4vW2mMQGe7Ki7TGAL8sAe/NheJv7hEkbSLfMW142a4d6+s6OhHfW67Bk974hVvmgHapvvV/KoFq77huhUt40lCVMfRAQtYVC+AIEjCZAvylvFaDfhNFLgve
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(36756003)(5660300002)(53546011)(2616005)(41300700001)(478600001)(8936002)(8676002)(66946007)(4326008)(66476007)(6916009)(316002)(6506007)(31696002)(6512007)(38100700002)(86362001)(83380400001)(6486002)(66556008)(44832011)(2906002)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QllwK0E4RXdHa0pZejAwN25haXBMb0ZvaHRmUnk2ak5IVVpXUlBwVDRBR3VH?=
 =?utf-8?B?VmtFdWZidE9QYUJTdjdMNWFZbjV5ZU96emZBWVhmRWZCMUlkeVc2Q0d4NEpX?=
 =?utf-8?B?T0FLcFh6T2FkTlc4dGxlZmJLVFRQdEZMRVlNK0FqWWYyWGpxdVh5T0g5cTNL?=
 =?utf-8?B?NzJiNm5SUFdGRVFCbDFSdkNLKzlodlhxdm5JQ0NmZTMxSWMzYzU2SVRGZ0sr?=
 =?utf-8?B?eW1NRHFtbTVmRHZvVGhkRi95MTFYeFU0anVwNUNiU3pVS2lCSGNBdUh0L0o5?=
 =?utf-8?B?em8wZnRZK1E3R210a0lSSVlMdTlyemVEYWxTRHlCUnluM2pHaDc3MmV4dElM?=
 =?utf-8?B?REFiQUR3M1NUb0hBa2RGSERNTHd4Qk5iejJjOWJHRlhpYzhTY0ZWQnJYeTZ4?=
 =?utf-8?B?QnZheDNuRER1RkpqM2VkR1dIK0NWWC9NeCtvUVlMRTFMZ0sybG1sWEFCMmg4?=
 =?utf-8?B?Q09xemZnU0d3aTdaRHlYbnNzdSt1MFJuaU8rakcwam9yMDZQOFI5bFpIY2Ry?=
 =?utf-8?B?TzZIVG5rK0NFSFVEZnI2ZVpEeENjVHp3SmNFZDYybC9rR01ZbTNPYWJZcU9j?=
 =?utf-8?B?c0dhRVFyY2FVbGJrOTM4OHRrTkN2UUkrK3hsVUxSMlZudkZDNDFwUHU3Mlgx?=
 =?utf-8?B?aDlmZWZneTFIMDFUTmhJV0Q3L01uTjIweXpJNkh4dFNNU2Q3ZFh2NGljTEZ6?=
 =?utf-8?B?U21lcCtBd2N3akpmRytJWVpyZ2dINUMvRFJFc1JyZHNGNWoxWGNlYkpRVWg2?=
 =?utf-8?B?d1FvOU1CR2VUaXFJbFBsK0hkcUpsZGFiVmREaHMxTVNYbEkxZ00wUFZrMVBF?=
 =?utf-8?B?NGZHRUh5YkY0NEpNS3VCcG9aMTBTOUYrK2JTdGd0R0hiNDhhWWNlQnZ6QU9S?=
 =?utf-8?B?cTRXR2RBR1JERzdwVkF6YmV3eDhvZzl0NVJ2SW5mUGM4VEJsb0lncFFKa0Zx?=
 =?utf-8?B?WUlrNjU4MlhaSThiR0E5N0gwS1J3SVhudzJLWjIzWnFhMWlqdEpwREpibnhw?=
 =?utf-8?B?M0ZGTkFEWTZEaUluZVdXUDNBY2RJQ1JzUXpkaXJYWDNSY1ltZzJJY3dsS05X?=
 =?utf-8?B?UER1Skhid09OdjFJRVlZTW85SlNBYkRZMmhINkhGaFE5Y24veVpyRGtWRFJl?=
 =?utf-8?B?MWVONlZ6R21mZHFWUWpncG5ybFBCTlNFNWJzN1F0b3JMVHlNQnNLcFh6UFp6?=
 =?utf-8?B?dStmM3FvQ1VnZnFPT1ZFbytvNE5hRFA0U3QvdGNPcklBTEc5dTJsVWtiaXhV?=
 =?utf-8?B?cldyc21hQ0dLK0ViYTYxT2UvZTNGbDJrV0JnT2hSL1ZyYVY1UVArNkJJWHdz?=
 =?utf-8?B?UGptNndHL21SVTNHRVBBYkhnUGVSNVRvWGJLT0JPMEpjRlkrWExiN2d1T0ho?=
 =?utf-8?B?UXc1Ymp6eVNYMVZjclNsdnpVT2JuKzdWNjZjTVpwOFE4b2s2dkxHblQ5NEU4?=
 =?utf-8?B?QmNOaVRjUjR5cmpwN21yemlnMlVNVm94YXVQNmIzSjBpcG1PZEpmSlNJZ2RS?=
 =?utf-8?B?OVFEb2lZYTRKK1JCZXZxeTlFeDc4Tk85V09CU3ZlelY0U1RvaGZQVlBxT2lJ?=
 =?utf-8?B?MGpPc0Frcm9OaE1CS2lmN3cvTzdkMFpOWnNmSy9iYWZaRzJtM2Q4VzRzQ1lz?=
 =?utf-8?B?cGVwWTZIY3hFeGZOT01CQVFmeTBnWHJlb0dlQWQ3V28wYXB3MjhVVXVadTND?=
 =?utf-8?B?Qkt1MGx5WUY2QjY2emRVUUNrMWdsVHJpMG1vY2ZwUnZ6Q3ZFTk04ajFhUGV2?=
 =?utf-8?B?eXdJZnNWcWtpOHFHRDZyVHlieHRuNUVKWjlNY2gvRzY0eG1nVGNnSmpDakh5?=
 =?utf-8?B?OWV1WkNCYzk1MnpEYzJVYjQ4TzZPZWRqbGpjdnhyQzVJSGlUR3ZicSs0blRv?=
 =?utf-8?B?d1JndUg5TzNNNk0wemQwcHRWcnBHZkcxems5UUliK2NWREErYk5JVzVaWWx4?=
 =?utf-8?B?VkpCRHpUVWJOQkxiWlVnWFBVUzlWU2psNzhQOWdUQ2pVVnRyTXc0WHJXQ25B?=
 =?utf-8?B?ZEhFN1hCeWRtclcwakZTUnJ2ZW9kM2VENzlSM1p5RlZnQVF6MzQzQVQxSkZk?=
 =?utf-8?B?bjNWbWM0U2ZDSVNCNkxyQUdjTXJybUJvRjZJU2JmYzg0d2xPTXZxc0lLdXEy?=
 =?utf-8?B?R28xMjNQUmUyQ1dnZTJiZGpTWWhvanVjZ0lCdmQyRkxLbFZiSkw5aUJEUEtr?=
 =?utf-8?Q?imv1+N3Qo8gJ1CsSt/YqNPU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	sGvxietifGFYdYwe4hVBckWJfhrWmtSXKb3jsNpwU6a4zE/UFMobt6BNR/3KS3tj+573/qLGt0QkYoFn0hraQlMhS01EzElAmOeCu1BjEi8xFTm/Kzqbn6WIPY2XEdE9iICz3dl3IW9464HJeZX9IvAYkSeUEQ7XlJjKEoVexmiAPdRFtF3uVXy5DKkaVqnrxsdi5E/6o9lR/X89m7YhEaOieNJ5RzROP+ww1l6nkbCRzWoIcrfKDB0iXPtp4H5ukCH9cGlyV0tCp/dpG9P8oqhOApVfWKxQSf0q7BkW597zjqc4znD2xHIFjAVsZtrPlFXo72kzou77i9GJF+Ijh81mmNVkd1VJ3wYXI0yf2UfaJFR/hELTXOXe/EJugzF0LvHKIksXX/HGzqQ2isXviDZOJIgP07Xij59oSUiIINFAGhBmH+Ga+UAU4CBKLPvTEXPxpwN21850NTjnlk4QCUCtbXgr79NGkezrRnmnXjJm7cRYj5NR6BhF7GK2rHj560SScHBQk/leWF9GwyOgJrkDBrzwS+30xPLTU8KarHF21REUeDqOpFV1tulJkmsXmN0X4YhYIKy097BSs5/raZ4sIKVTXq937JdXcixAHQg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 702349b3-dc3c-45dc-3263-08dc2db21ec7
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 23:10:22.6953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P66Tf9AGSuUnS7NIINkiVmDU1e/EWM2GK5U/iRY/CjFq9VbDJ7bt86/6+k5umakXG89o0J3dIRhsUoIwm3Z8XyJFl42um0PhmAJPrWI/ick=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6339
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_15,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140175
X-Proofpoint-GUID: waEIMJAbLRmI_33QICuMwvK-_zWEsUOp
X-Proofpoint-ORIG-GUID: waEIMJAbLRmI_33QICuMwvK-_zWEsUOp

On 2/14/24 2:45 PM, Alistair Popple wrote:
> 
> Sidhartha Kumar <sidhartha.kumar@oracle.com> writes:
> 
>> Use folio api functions from the already defined src and dst folio
>> variables.
>>
>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>> ---
>>   mm/migrate_device.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>> index 9152a329b0a68..a48d5cdb28553 100644
>> --- a/mm/migrate_device.c
>> +++ b/mm/migrate_device.c
>> @@ -843,17 +843,17 @@ void migrate_device_finalize(unsigned long *src_pfns,
>>   		remove_migration_ptes(src, dst, false);
>>   		folio_unlock(src);
>>   
>> -		if (is_zone_device_page(page))
>> -			put_page(page);
>> +		if (folio_is_zone_device(src))
>> +			folio_put(src);
>>   		else
>> -			putback_lru_page(page);
>> +			folio_putback_lru(src);
>>   
>>   		if (newpage != page) {
>> -			unlock_page(newpage);
>> -			if (is_zone_device_page(newpage))
>> -				put_page(newpage);
> 
> Defining migrate_pfn_to_folio() would also allow the removal of the
> newpage and page variables entirely which I think would make this
> clearer.
> 
> As an aside is there any motivation for making these changes other than
> as a general cleanup? I ask only because I have been looking at allowing
> device pages with order > 0 so have some of these clean-ups in a local
> tree as they're a pre-requisite for that.
> 
>   - Alistair
> 

Hello,

The motivation is just general cleanup. In folio-compat.c I saw that 
putback_lru_page() does not have much users left so I could convert them and 
then just get rid of putback_lru_page(). Should I still continue with a v2 that 
will include defining a migrate_pfn_to_folio() or wait for your clean-ups?

Thanks,
Sid

>> +			folio_unlock(dst);
>> +			if (folio_is_zone_device(dst))
>> +				folio_put(dst);
>>   			else
>> -				putback_lru_page(newpage);
>> +				folio_putback_lru(dst);
>>   		}
>>   	}
>>   }
> 



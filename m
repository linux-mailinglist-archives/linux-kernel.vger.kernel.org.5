Return-Path: <linux-kernel+bounces-54762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3A684B365
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E5A286330
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1472E43AB8;
	Tue,  6 Feb 2024 11:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BwWhAhbk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HN7mSyd8"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427B512E1FC
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 11:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218670; cv=fail; b=H9rR6EWSfx+YU3P3wNoZZBN/YfeB8dgQkhAmZg8cmtkaagGus1ddwcwuHoXLzmWISRujdHqeSK6Hopr19qqbAiXnkMt53CHx0eEuZQWCMZi7GAC6TBksxN5DkO/s9zOkvETlrcCptcbwgaZRjS3Ah3Jqhh31G4hUCg0Tc9EAufA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218670; c=relaxed/simple;
	bh=u49f+D0+vgefelvLTYnD0SINCoBTD7ebNKKZR9ghYWE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZuRYb8HZoSpRBoNVU4DA6x00WJ/Sc8h6CXXhuQqquthx7I7dKxkKbryKQBZ4xbRRtLLwx8KqVCluy/pyVdcrTd0FjIWiVTPZcoZQk1ZZ/ujoZre8kAt3NY9Dg/O6ORUzYDQcWYfjY9xWBK2T6Hezkl5sEBprujeLNRIcSD/KKHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BwWhAhbk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HN7mSyd8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 416A9BY9000625;
	Tue, 6 Feb 2024 11:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=tsAP8PSrdSuMvBEJpDR74SbiO0yR0oGjpUsBFO2ohFM=;
 b=BwWhAhbkzjrIHCnLYetkwR3vKwp6+VgOYO8jUldLvSCNqTvjK5qMRZdKfxjhicPh7Ies
 B811dKlck9qM8uPX7KJdNGRe+tvphAKJCVKPQSrnn4olfA8yHZb0SPcGAcrYMWewJ99f
 lIrHfq5kg8RhlR+3aW6F3nPfUPRNJRsRaCErCpf5gy9cUhpdXRC01jr4p507ZqCagQnR
 r7yKJSWzsKvTyvgJEaMYv0McEBakNua4J0kxCTPQPzidLGh3wvHqs/h+Gy9fpcEbDQVX
 P4qwXEAh1Bd1i0Qa1ai+WfhPQ5KHxszSWmSNXMWwGj7SyWBNojSBMm4/Xjt/ZUjeLAbG JA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1d3uejbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 11:24:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 416BLiCk038399;
	Tue, 6 Feb 2024 11:24:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx6xufq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 11:24:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfXNy7F8mtui1QmiJ4XdlNQjYzLhU13blzI4e8+29WdtgbiRV/W1I5T6bDz9iosKqbakv4zjSid3d/27YGFMZWOblkOVfT7VgKeipB9Vn+jrP1TLa2LRVlmYoBTFc5H3Ca402dIlRqrPu6mYUX70KDzTLTifxoXNdQfhWdKmp8503zWGt7ZJnT8DOEoPW+r2re3i/CqCvc0LLcmxMYiGxMgFMp3vaptDyZNMO5Ixs/iURRfw3Z2aap7Fwfs3PiKxha9L21hgW2+T2WtRgYV1mPzhqFOfebgkvyBhzLTQP05WsbWEdAXdCaKg3KmQePLtU8IcUvcRCisnBCJ3LjBS6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsAP8PSrdSuMvBEJpDR74SbiO0yR0oGjpUsBFO2ohFM=;
 b=ZBwRoCiUEco/eBWR59ufZcHE19Fb+W4Y8woY/jPTslYJAg/ApN/DFSKJ4sc1C2hELUzPzAdQhjwyZepLxIuZALFfX8+HkX/CeFruQlIoiYkO7Tthc1Gg4MJ06522rio5GYUqQBF5FKUZclY3wsf1Dwp6bWjzMdU3mtMUeup9xKQr11uZhjM+rNIEEprZ9vMNsyNT+EbMXhpey3ER0507Jk8MlBEsXoNhwhRYVFKisnwXUrlCJT76zWfP/WP/1hpNApdD0ZIlZlG9ep+wD3i9ShaKDouw6MSBi40ykvOD8d59f90oo223W6fyDOOWYSeQY7t0nPNrgg4XSVxh4IXHFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsAP8PSrdSuMvBEJpDR74SbiO0yR0oGjpUsBFO2ohFM=;
 b=HN7mSyd8iwNWVJm/gHsYU6aw9zrr9hnoY/3TCzDBeJ9JM9WU4pSpidC61HFgQDBCUZVmMaYocC+7NPlsouxk3f/7zERGUaVKwOut+TdJCRUClppKqhFem0GFhe9REE6wiWUxc0K27yXmIwM7Oag6b1oGyGeUHvRtQcyUa9pyUZg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CYYPR10MB7626.namprd10.prod.outlook.com (2603:10b6:930:bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 11:24:10 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 11:24:10 +0000
Message-ID: <83a0aafc-8a9c-48ce-a203-96b901489d41@oracle.com>
Date: Tue, 6 Feb 2024 11:24:05 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] iommu/iova: use named kmem_cache for iova
 magazines
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
Cc: will@kernel.org, pasha.tatashin@soleen.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, rientjes@google.com,
        yosryahmed@google.com
References: <cover.1707144953.git.robin.murphy@arm.com>
 <dc5c51aaba50906a92b9ba1a5137ed462484a7be.1707144953.git.robin.murphy@arm.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <dc5c51aaba50906a92b9ba1a5137ed462484a7be.1707144953.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0166.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::34) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CYYPR10MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec9e48c-e381-4028-ef1b-08dc27062390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	n1aT/Vvfpv4AOS1RJf5N1M/4eY3eKvbysbtWexSWa1py9fAnKzXmMAcdsfDK+fQGO01vVXq4SHIHn5/0gMJT6SqSjLMmSewIWKAGBJJMLZzJSeU3eYseCqBY1hNdQeYr+PJd0dGY0lqtSvugNeAjROzPkIPljeIDK12xCx7PJ7hIMKzs+BuUF9zvJZHwDf1cTCVTS0TQ60tjXl7R6Azo0NIS9jIULfFqppJQ/4xD+dMYZEZBwlmax9jD4FXctk++uqAsR6LfHxgzmgj5ZWnkCKwAxiJ+n1F4l2vtgja0ikE2RgTIN7TLdA9V8zw18e+KisYYx565mH8r5gbQyq+VdWeA+2J8Cfvf5cCaUC6p11vkpEyoZ+ihTnYL8eDIyDHKVM+O5KOKg0KWIKyDSAeiDdc5tFl+pV/6JGB5EOZ0rLri+W8K4Ryu6GuXS8O1yUZg/OI6/+T9P2ABTLqcgKhl5x2YWXA6Q8Dr1IbhrXvwuVM9EH3Gpmn2r/ewEkCA/AYZ0hFpKGW1Iuxam5w9VZaMC7IYgW3cdZ7JqKCzTN15/hjLFYJ+2TvBsBWYe1u7WIqXa5keNoLbHfdx6VQplUFhxWNAXfkMAELS0RdtPeb1HNhzx2IThGyOVyHGrIZ/nlXh1GcCQYYqJpLZSPU/gLQz4Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(346002)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38100700002)(31686004)(86362001)(6486002)(6506007)(31696002)(2616005)(26005)(478600001)(6666004)(36916002)(53546011)(6512007)(316002)(41300700001)(66476007)(66556008)(66946007)(4326008)(36756003)(8676002)(2906002)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OEk2d09uRk8vN0I2U0RmZnFlWWk4aUMxTHJZS0tXdlNBTDZxRG0zYlNZSVNj?=
 =?utf-8?B?ZUlkMGVoMU5QbkFNSUVoaGhiUGpYTmY1bjdrVHdoNEZYbSs4Mi9QSnVoYnlz?=
 =?utf-8?B?TlNOYjZzWWRzTDJlWXMyeWtlRDdQK2haSTV4S1J2S0k3cTNtc3kreU9ucFU5?=
 =?utf-8?B?ZzI4bXZ0VHkwSHpqdUY4TkhrdUQvYjgvd2JKV0JVOEhyMXpGSUIvUDBDQVVl?=
 =?utf-8?B?WTRsMzAxQ0FMczN1ZFB5d2pPSUVhclcydlhKb1BJaHdZMC81OW82TFVCd0hj?=
 =?utf-8?B?RHhyTDQrSWJPYnlod2hIcWU0Mktwc0lGNTdScWZ3ZTVnc1g3OURQOTlTVkJQ?=
 =?utf-8?B?MUZnODlIVUgyV2Vzc292UCt5TXlQeVZ2Z3l2NkY1aVFoMitaSVUxWVYxdmxo?=
 =?utf-8?B?R0dLeHlxL0kzeFRXVm9obmNkMHNKS05XTWxUTlI0TSt1ZWk5U3hlaVZnd2pq?=
 =?utf-8?B?TzdxeDJJdzREOW1GMnpXTVFraEd5M2dQeHhBVUJKQUdicllxa0NNR2ZqbURu?=
 =?utf-8?B?dEdFWS9TTnZQRUp0bUpkUnhsM0R1Zmw0Y2FVREdmTkE1dEZmQ1JkWUVBVWxL?=
 =?utf-8?B?RWI1amVscnpid2hFWTBJeHg4bEVJQ3FiUTZNUzgyRko3UU1ia1BXdGZEbVg5?=
 =?utf-8?B?UWI1eU5mcU5kRjJvM2lBN3Bkb3dqVTA0WStQWFNIUFFGb0R2NmlKY2xGS2Ez?=
 =?utf-8?B?TzZ6c21hZkd4c2c3aHVzWEw5L2tSSFpBOG5Zc3JUemZzbGVHRTdYMi9NL1RU?=
 =?utf-8?B?WXI5OHNhcm1nY2x6VGthTHlrT2Y3aXEwOXBXM2FGRGM4cm96RUw2U1ZuYXZa?=
 =?utf-8?B?aDU4Y1NEYndRaFBFcjVOa1R0U1J2UFNHTVY3ZjI3RmJUa1ErMmNIaGVXcVh6?=
 =?utf-8?B?cHpxaExHdG1BcklpaVFIbHQzNUdldVdacE9BQVNRdWNWaGJGNENxSWVjdk1N?=
 =?utf-8?B?cVZoWk5rZUprOGJUeUx1VUtCK1ZGaEZ3d2duU1gwMjkvenFiR2hFU1Y1Tm9V?=
 =?utf-8?B?TysxOWlCQ1lFM2xhdWpEdTl2YW9aejVEQTBteWlNMzNhT0RDTkhaNy80ZjJC?=
 =?utf-8?B?NU82UzFOOS91QmkrdkFlN0pRUnRCbDE2NDVtejl2N2NaVzBsSnZ4cG9jSGpw?=
 =?utf-8?B?ckM0akRJeGZwYnppT2EvZWNxY0dhR01yTzNReVR5aXk0ZnNkM1VySEFLZlRr?=
 =?utf-8?B?T25NVVYvc1l2YTIwMUFZQWRCeGRnOHNFV3FwNWF2TlJndzZXL0ZuWktTME4r?=
 =?utf-8?B?M3hZNmhDYlI2c2d1bUNtazFLcXFWY0xLRFVTb0svMUhHRXpSVW9Vc2RqY0xp?=
 =?utf-8?B?dEE5YUN3cTFyb1lsTWJ1Q3A2YnBIenFtbUtVZXQrMWwvVkFYSmtkaExaNVQ1?=
 =?utf-8?B?d0JSV0NLSXJXOUxsWVl2akd1bnZVY0hoNklMV3FpMVNwa2d3T1UrRWw5aFlS?=
 =?utf-8?B?V25mejVYdzEvYnV3WkZidHhFUGpHTGRaK1E1a1pVMm1EZ3JxMjdiaEZLWXBx?=
 =?utf-8?B?RjkxcHZ4anhHSFNseGNiaW9ZMEZqWDdBVWNqdDBkZ1RET1hDRUxTcWNqaXg4?=
 =?utf-8?B?eVZWaHp5azNBYUlFaWc4Y3lVK0ZRVUxkVERtTGVoUTN1UXZJVTBnU3VuOVQy?=
 =?utf-8?B?QmgrV3pZVHdVUGFjWHFvemthVTRUT0R6RkJ2VVkwOHkrQUlFNTdxZ2NEZHBE?=
 =?utf-8?B?MUFCUXJLWDBSdm1BamtQSTluNnVlcnRNYTEvdVJZa21QK1YwSlA1QWZXK0dk?=
 =?utf-8?B?cmNwMjJhWEFpZnVqMkJFNlYzYmpUUGZxQ1NOdkpacUtIa25WVkhRV2wybStp?=
 =?utf-8?B?Y1hlSmxldzlieXI5YWVPa0FqckZvSnpwMlJsSEkwRkFHaER6QUQvY0d0RGN4?=
 =?utf-8?B?Mi9PSVlzUXZneHN5TkR0Z0gvK1o0Y3FRY1RnQ1FaeS80RDdMRlpLU2ZjZHR1?=
 =?utf-8?B?YlZrUElpazYwdXdjQTJJSDljODd3bDUvdDNIVnB3NDB3MEdpOHR5SUd6bkhY?=
 =?utf-8?B?azFLamRlSmFUYzFLMkxLdmpkS2QrdlhHRlRaRURiZXhXRUF3SEdJMmgwZ1Yz?=
 =?utf-8?B?RENGVEZ4TitGZWtlL3pCQW56R29MN3hyRU1vcnNEYnJCTVhPbDhyMlJNZU82?=
 =?utf-8?B?QStmVEFPM0RvcWhoRFdGemlmME9UVHNhdGpvd1RGWWhtNm85RGlOd055cXk3?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IipLDUtuOHWZSZLQwcPBcCRjnHAVkxyFgCAAc5qYHNB4RtRjG8PWrkiUgB0q1e58SesQ/yVN1ZKjXZ6ayyJGHQabfeuGXDtaSi3YAnDNqrqxtiW/u01lnm1jwQ5apZMFcSoPdQ3Vcsb84cHCcHYET2PLwO6DcRSgPBGqfM/xdPzCKBWv8lJ/QmKQRb5q/C6ax21M+2+GIiVyoVCMMLHD274YUa2UzkrVJwLSJKLfuK5Ya4cAbxbPG9OfbrNXqDq2zHjU8+6ZQeMJLla8oT3lekY4d/iTJ9DGJssUO75sY3NMhbqGV4fzBxMFECCK36o3TZV8tv5qQuBPGopA8KSQoRphd28DxZJRY/WgQR+Fmc8uQ00uECji+rOCE613ufXxAxyxb/OvGdpUeljE2HqX0wHEJMn3rQyqjB3B6vDubHE0m/es+x3M7ephF6bLdK5XDSTg1Gtwockj2YwDfuDVYNEzROSOXqor5p57MVfnD4gbpr87yjLDuu/5dVfUVMcFijPomaJOpuqGXKAWlos4sG22yUzLpchvlK83r3lLScOjuq5AnO0DFUwXXH0hr1olN/qZnZV+IvnaSzejdJa8KtWOQqAxk7/rblVnWiL+kpM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec9e48c-e381-4028-ef1b-08dc27062390
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 11:24:10.1432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6couULElPHeD2kAre8LnS4bYyk2xvncYy2mC/H1UTjGG6ChtHBwgOdVohZCT/i32XRRKhdBlXtu7ZHCFlXyDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7626
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=535 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402060080
X-Proofpoint-ORIG-GUID: 5Q9kVVkjQ5pzNL6WFjaHVtqtaQ2FEpjJ
X-Proofpoint-GUID: 5Q9kVVkjQ5pzNL6WFjaHVtqtaQ2FEpjJ

On 05/02/2024 15:32, Robin Murphy wrote:
> From: Pasha Tatashin <pasha.tatashin@soleen.com>
> 
> The magazine buffers can take gigabytes of kmem memory, dominating all
> other allocations. For observability purpose create named slab cache so
> the iova magazine memory overhead can be clearly observed.
> 
> With this change:
> 
>> slabtop -o | head
>   Active / Total Objects (% used)    : 869731 / 952904 (91.3%)
>   Active / Total Slabs (% used)      : 103411 / 103974 (99.5%)
>   Active / Total Caches (% used)     : 135 / 211 (64.0%)
>   Active / Total Size (% used)       : 395389.68K / 411430.20K (96.1%)
>   Minimum / Average / Maximum Object : 0.02K / 0.43K / 8.00K
> 
> OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
> 244412 244239 99%    1.00K  61103       4    244412K iommu_iova_magazine
>   91636  88343 96%    0.03K    739     124      2956K kmalloc-32
>   75744  74844 98%    0.12K   2367      32      9468K kernfs_node_cache
> 
> On this machine it is now clear that magazine use 242M of kmem memory.

Those caches could do with a trimming ...

> 
> Acked-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> [ rm: adjust to rework of iova_cache_{get,put} ]
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---

FWIW:
Reviewed-by: John Garry <john.g.garry@oracle.com>


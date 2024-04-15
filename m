Return-Path: <linux-kernel+bounces-146010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E498A5E56
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 512C6B20A44
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93ACB1591F9;
	Mon, 15 Apr 2024 23:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GojCcy46";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Vu0tFg66"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B219D3E48F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 23:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713223993; cv=fail; b=btnRd3Y0UR/G4yRvpXdB7Qo/P25BCkUZNvpO0DI4C8kvsxOewpYVY5HnUz547E2tHt/dNCjQML8/GRlJZaddQOiAVG5BCb5CsWFcLXNY7XvM8dAjz4GQuVEYLWtN7mLKuu/CDPh4BKi1lJHi32pZyIgvLDGY8VzjFAuPhYDGai4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713223993; c=relaxed/simple;
	bh=gBD9IgrUYH8rLRtv4Mh0s3HxyvFiiNKAIri50ijCfcg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g0sULTHvjhdTeixL8G+HNlhqT48KRPQVDz0P0OC8NQSIp9DHx54cSy1ssEDpeMWp52b2VNmNVnRCnHSQ9H+ZqDES9wUIHV8P7z3xO3db1dCNlDtDjzYf+c7s/9Jl4AQ4HVsTTjXEhH2GnW2btZtjbuHaSA9H6E37JxpfmeyFyBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GojCcy46; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Vu0tFg66; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43FNE3vu015587;
	Mon, 15 Apr 2024 23:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=BGj6u5zy+Shcd1Up187oOazVJ/1J0ENNRM65+oApaMU=;
 b=GojCcy46pbnBx6bYq6WNEooPJi6Jnv0WpC2Th7+k4d5bgGnLoJr5H70CggdBxu63C0hy
 uN5W/jbhCjEfnG4eQGcrQhSwow1vqhtBPwy+vicGd+aFRv17mTEfhJo/8B6jmcu03ym5
 hrkdDKoMiqDy3vp+uZX2Ukrvg1BCvptRyHatiNjUH0xWkiGcfs0Ohwlc6pu0WVXQJ/I3
 tPo4YDWJo2uqJtKffz8BXalv8kuzxPjytGtoIqcxwin+XZEPELwMZY+jVqX95PodTIM5
 1X0co1bEhILg6teT6SaHmKrJdufgr78swKRVz6gNtPbQd8VlXe3FsRjxH4sSRvRvFPDw RQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfj3e431j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 23:32:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43FMV1Di004283;
	Mon, 15 Apr 2024 23:32:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfggcqkqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 23:32:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hpc+tIQEWIF73IRERPjtysIng7d/mSh+BvAr/5PfCCB0bSLocoyqFLZYCTCJmzMIw9Vewu1XfAC327bPvN1P9w9+trQzdNMsL7q2csqxD8Bk5aAa9VjKnghcS7AeoV3iejG5xvFhreyrr7dmpNN06S2rO2rzNpLrO9tst+zDlxy5f4WW0ocD7x6hzOydZLfbka7LClS8G8NaJV5htVVddVufgIDfeF/RdDtCNDUgV4T+hcPjpF4HMbR8jqKIK113sx0xsQTvJ1LvwMx1FKUANJ8qGMc7810M3UnlhqqbiI0AK9YH5dkbuAmK+oOBaVkB/IjidP7lnxWV3CaP2Qj66Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGj6u5zy+Shcd1Up187oOazVJ/1J0ENNRM65+oApaMU=;
 b=Vui4C5Hdc1NS3ub0IN+dAL3919EFNK8+okIiLght2HHmcK+mLvRa79GUR8Pd/1tFPRi1szDIiQ39uokBy1lkBtmmfYGcWm4EQzl+Va6wTLCH3gxLlW/PcuNHdbyhemTJ/+IYfUzTcwqPc6EZTiilzD7xTzKb2OUBYOp7B4QmwDxw2jSWyaA1s17ZlgdLYwGGymWJx1EJrd1mR8TygoDX9A5eFTf4P0ymfqGqJOj9AfmtSzVLIgjaNzu5eIHW8hVOozgUplsjn7F/FVCJKjbxEgfB1FNCJLw5/b3tqFVx/UgkJCHjHONhfWYw/WFv9yW7cVn5hZ9q+8y+6diW9ER4MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGj6u5zy+Shcd1Up187oOazVJ/1J0ENNRM65+oApaMU=;
 b=Vu0tFg66+djFnCOPLq0W7v9dAekk//m7tEIAXhWtMe10nLSn9QhmpI2xpe9PujXJnNzs499g0UtVxsEADOPUAqmYSSxETx2QSAlkH9cB7b+xq4J/XRwEt+dpIrg/xKj+mQ+w0tPn40RpAmLeE6OwXb8ucjCMX5HXqntowO+gXbQ=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by MN6PR10MB7541.namprd10.prod.outlook.com (2603:10b6:208:46e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 23:32:31 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::f5b:648d:5d73:dd03]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::f5b:648d:5d73:dd03%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 23:32:31 +0000
Message-ID: <28976a8e-678e-4cfa-8748-e566c9c29053@oracle.com>
Date: Mon, 15 Apr 2024 16:32:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fork: defer linking file vma until vma is fully
 initialized
To: Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, brauner@kernel.org, oleg@redhat.com,
        tandersen@netflix.com, mjguzik@gmail.com, willy@infradead.org,
        kent.overstreet@linux.dev, zhangpeng.00@bytedance.com,
        hca@linux.ibm.com, mike.kravetz@oracle.com, muchun.song@linux.dev,
        thorvald@google.com, Liam.Howlett@Oracle.com
References: <20240410091441.3539905-1-linmiaohe@huawei.com>
Content-Language: en-US
From: Jane Chu <jane.chu@oracle.com>
In-Reply-To: <20240410091441.3539905-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH1PEPF000132E8.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::28) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|MN6PR10MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef5ef9a-9f22-4950-9a2d-08dc5da45208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1HcGJ1GxVPkjzprAsLdCBqy6SY39yvnCm+VroGttdHvo2i6CnhuDNk7kUjkRiTRLPvT6QNmqmvCuERUFUxwdlvXOutwdBdNKRWFx6ko7JG1ElShT/GZkuOvVys4Y+DDlmjoPyVHr/JsM0I0axQfjswnYsS7TjgSF71gz5M56YHyEze1uwnWtEPX0IS5NaqTTKM985HnK6q6WTZ0PmhxR6GbQYEb0DnX4CVHfs7HnCYqwGlIzMUkOjJ9qvlubbCYW8c+TEzJFliWzwne/8+wYrQ9PFH6gt5PzI6RhdAp5JkJyqN2lBtnu75KsHVqpm/ECavohxFM4gfJ1ZYBS9jtPUWfuAIfBbOxeGyLNfJwgUSQBL5LqIve0IVczEiIJSSqm1/2DS9lxz/XUCoAB1MRPl6d7qWggs7Nmr6ySaVAtfjbf01bkr3Nn1sGamagc/zMpQsVfxKlTAVOpHeOB+b/S1e4vVo8Cq7ORI5/bQJUFOQi2vA2Zhzq07j8wJOAj+/TivTdk4ox+pKD0gRZR7D7ZShKfhtS9XrQ7kU/uCXVQazBe8Ie4riQSvbceR0pwnGcJqhfdIJLEc4Kj2p47zwZo2s9zneTO2OPDWNriL3LqEhnwIApcLzJ94MUPQE+IGXPITskW+TBQLDCKAT13LW8qOh8+CQbwuiLMaUMbWHX+NIk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?empRVW1SNFlobDJNcFRlWmhPVkFyU3JHQkl6ajNFVWpHcE1WL2I4S041Znd6?=
 =?utf-8?B?UXlWZlFibjU2ckgvRGVpcGhCTE0zL1F0dHFpYllaVU1uTGpxWlc0aStaMDFT?=
 =?utf-8?B?emJCbXpEdkkwN1FabXN0YWdtYi9KRHFNaWtNUGNPaUFwbFYrQXlNRlVlTVhI?=
 =?utf-8?B?bkRFNjVpM0FEanp6UTJCVTlaT05qT2xnNDhER0V5TVloRW1NczlwNlJLcXJM?=
 =?utf-8?B?WHFRZFRXY0M5MjNaRmxHM041VTlvZ3M2ejBVM3loMWpJNDdSMUNaTksrUTFC?=
 =?utf-8?B?MUxNeVdvVi9GWW1IU0Y1QjFTTG9tQUU2T1FORURYenBDd0hNMVlTdmYwY1l4?=
 =?utf-8?B?N2F4ODdsYjJic0dlREw1aExXN2tEVys4L0Z6R3FWS2xoQW8vVHFER292TlVJ?=
 =?utf-8?B?R0crMmpQYXlWOTJCdnNoTlVIVzMrS1JGOXdoalZrN1I5UXVQOUNOcXYrOVE3?=
 =?utf-8?B?L0V5eUhseHlHV3ZZR0NIK3h3dlgvQkJXMWU5dHNCd1daNW04NGpmMGVnajI0?=
 =?utf-8?B?aGpxUjJ6WlZiMDZBc0QzbndLMUtqMGRZRnY2U3EvUFNiSmtJSXh6aldHU3pM?=
 =?utf-8?B?Ykp1aXNmbGozZWFKVnlUVTNkS2wrcWhzeEVzZzQwc24vWVZaVi9EakJJR01Y?=
 =?utf-8?B?NnFQMC8rSDFKNDNrNUh3OXBFUlFZK3NxRVllc2tmNUNOaEJIT1BOZEF6ZWpr?=
 =?utf-8?B?Yy94OHdhRDhwL00vaTA1azcyT2h2OXM5OGpVZnhTeVhrWG40NEtmV0Jsdmpz?=
 =?utf-8?B?bGxtVmpwNjFOdzFURTEybng1QjZPelEyZXhPTno2WG41TXhHeHJWMVlHRitM?=
 =?utf-8?B?Z1ZtVzhoSGJhSFhCSHdMV24vQ2ZlVVlQcEY0VTFoeG1HQkcwNzE2RTdpV1BC?=
 =?utf-8?B?M2MwOTgzSTNscHB3Zmk0UXZqWFpPY2hYdithNmRYbTlEaDNXLzRNTWxFQTRl?=
 =?utf-8?B?aFhwZmdGYzZuREp1S2dBd3E1SlY0MWZ6azNCYml6clFZWXZMMGZ4NXRYQ1Ro?=
 =?utf-8?B?UjVMY0lqWGFZSWlDVXE5SkZrUWhHRjNCSjhXMWdleU1iYnFEckF6MXJ4Vzkx?=
 =?utf-8?B?UXk3UG16ZVdna2F4SEltN3Bvd0o0bTNoRzduK0tCaEFCdTh0QWdTeHYvQVdt?=
 =?utf-8?B?dy96aFJpYkRhZFVoSHpqTFFrM2tnTE1nS29MNFo5WExQT1ZTWGQ0dUhLelBZ?=
 =?utf-8?B?TzJIOFlJa2UxbzhHdDNpVEphU0ltR1R2WXV1R01HQnZuZW82ODFqZ2Y5TlAy?=
 =?utf-8?B?anR1bkFObWpicklLelJOVGw3OXUrb2sxUE9KZVc5dkRVQlZ1ZmhkQTd6N1F3?=
 =?utf-8?B?LzNzdzVDcnJuTUlRcERJWWtWdHYzZENMbXQrcFdaVmpsUiszOG1vbVgvSkpw?=
 =?utf-8?B?OXU2ZExVTXNCTlFZZmMzRlZxM1dmTHZFSk80aUFYRlFKZS9Qa2xXZUV4eWhL?=
 =?utf-8?B?dHdhR1BVN0lXUkdNNUl6aEtjWHNJUm9PU2tjc0d1TzVIUCsyc1VHWVpndnIv?=
 =?utf-8?B?SElkaWtZWkVQOGNVNWh1dW5WWjBDdEI4QzJtZ2xzVXNpOWZSZlQyZStHQVJp?=
 =?utf-8?B?T3E0WTVjdDFmRm90ZmQ3Tit4ZFQwVCtzZ2phdXVuREhnWGExQm01UHF4Y1dL?=
 =?utf-8?B?RUxMdGxwNE9TUjQ1czNnZXBHNHh6OWxWMFlZUDBOUTZub2loeW84WXRmYWdY?=
 =?utf-8?B?MDN4eTF4MEVwRXBEQTFNeGhjZXJaV09QbURSdk51NXYyNk9TeVVINERUL0Rr?=
 =?utf-8?B?ekpYYnp3ZFNrV1ROc1dKbGRIRmR0ZEl1UzVCTHoyampiRmttaWx6a1huaGpj?=
 =?utf-8?B?VnV0MXhXV2tmcHd1OWlETVZqN3R1bWNUM2JHclMvQmNLVnN5Wm01TkhLSGFl?=
 =?utf-8?B?U2l2UTRRM0R5aWplSnhtRW5oU05YVi9OR21JUERJUzkzUSs1YVNqWTJQT3dr?=
 =?utf-8?B?Rmt1TXRFV3p3M3ZBZ1JiUlBsN1VZQTU4b1o5bU53YXhhSmppWkJmKy9BeEtq?=
 =?utf-8?B?aGZWV3NXYThMWjV1RVdrMkpLWFhtaXRrZVFmRG1JWjlvY0pya3FHQUsvVHNJ?=
 =?utf-8?B?cnFJdE1LQXhpT2JHcHlvTDkzMFBDdUlzSCtQM3FZU3J6S1lwYUFWNStkWVRh?=
 =?utf-8?Q?GyJCWywdBN2IN2ghiUNUAtQYB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	L3pSmRvKv9WLI7Q8lA89ezTdpgYeTTh2bZrgj8+jgWtCSvGbWOwDeIAyHj9sVAUPzovVuAZeOEahws/C+Jtgc5dps6CD//aX3zbBmnBBs8mRu1W4EshKW6tJHxz128RWV8x+QfBHiLo5LVhXOKD9t6cRbWegKtNdtDpZcR9d29CEM9uXKz77gBPO1nPpuZouOHWMYQUi9DE/Y+2ixM6CDgkjA8rVzI/jG4EC3KWq/+bqQLldvlfWBOt/WvV5skCw/kelf25acpXD0/PgDbaRFFhEd67IVXIx+4TCtQ8yWkcZKRBrDWJGILOsQQaGoELJU0AJJlzxTpnIodvmgsDArV6hcpTF+do7yIznXxkldcA8YzBHBMSWvFUt78+y4PemXKjNlmz00TIol69wZdJgKbHe0IDod4PJVLuJLz9AzJzO7qJdzbngnEYPf3IM/E7vUlKlpJRqzhrkW7RzNRURGO3XLGamzvqYWBiPn0hHfsZ9wLf2XiQaR53Mspq0bIT0opLrs9BEDTC8wHtDpZFpqy9vBJkdCRjZtUnedABvTKyvfeGkBLygvHIn0SM1AvZXfXH0oWcaDLj6m69N/KJKNK2qui0eq0tHaBc7iAeTGKE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef5ef9a-9f22-4950-9a2d-08dc5da45208
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 23:32:31.3825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Asf0atLDKG/TF00W+KpvB7ZuHwFLlhPSkyyXcURmQxZrkhLy5wd8TZ3w2DP1MG9yzfXqMHrPk6DwsI/YSe23ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7541
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_18,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404150157
X-Proofpoint-GUID: 4vIaaX_z7Yu68mF2XN7stqSVD06S4y2m
X-Proofpoint-ORIG-GUID: 4vIaaX_z7Yu68mF2XN7stqSVD06S4y2m

On 4/10/2024 2:14 AM, Miaohe Lin wrote:

> Thorvald reported a WARNING [1]. And the root cause is below race:
>
>   CPU 1					CPU 2
>   fork					hugetlbfs_fallocate
>    dup_mmap				 hugetlbfs_punch_hole
>     i_mmap_lock_write(mapping);
>     vma_interval_tree_insert_after -- Child vma is visible through i_mmap tree.
>     i_mmap_unlock_write(mapping);
>     hugetlb_dup_vma_private -- Clear vma_lock outside i_mmap_rwsem!
> 					 i_mmap_lock_write(mapping);
>     					 hugetlb_vmdelete_list
> 					  vma_interval_tree_foreach
> 					   hugetlb_vma_trylock_write -- Vma_lock is cleared.
>     tmp->vm_ops->open -- Alloc new vma_lock outside i_mmap_rwsem!
> 					   hugetlb_vma_unlock_write -- Vma_lock is assigned!!!
> 					 i_mmap_unlock_write(mapping);
>
> hugetlb_dup_vma_private() and hugetlb_vm_op_open() are called outside
> i_mmap_rwsem lock while vma lock can be used in the same time. Fix this
> by deferring linking file vma until vma is fully initialized. Those vmas
> should be initialized first before they can be used.
>
> Reported-by: Thorvald Natvig <thorvald@google.com>
> Closes: https://lore.kernel.org/linux-mm/20240129161735.6gmjsswx62o4pbja@revolver/T/ [1]
> Fixes: 8d9bfb260814 ("hugetlb: add vma based lock for pmd sharing")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   kernel/fork.c | 33 +++++++++++++++++----------------
>   1 file changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 84de5faa8c9a..99076dbe27d8 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -714,6 +714,23 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>   		} else if (anon_vma_fork(tmp, mpnt))
>   			goto fail_nomem_anon_vma_fork;
>   		vm_flags_clear(tmp, VM_LOCKED_MASK);
> +		/*
> +		 * Copy/update hugetlb private vma information.
> +		 */
> +		if (is_vm_hugetlb_page(tmp))
> +			hugetlb_dup_vma_private(tmp);
> +
> +		/*
> +		 * Link the vma into the MT. After using __mt_dup(), memory
> +		 * allocation is not necessary here, so it cannot fail.
> +		 */
> +		vma_iter_bulk_store(&vmi, tmp);
> +
> +		mm->map_count++;
> +
> +		if (tmp->vm_ops && tmp->vm_ops->open)
> +			tmp->vm_ops->open(tmp);
> +
>   		file = tmp->vm_file;
>   		if (file) {
>   			struct address_space *mapping = file->f_mapping;
> @@ -730,25 +747,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>   			i_mmap_unlock_write(mapping);
>   		}
>   
> -		/*
> -		 * Copy/update hugetlb private vma information.
> -		 */
> -		if (is_vm_hugetlb_page(tmp))
> -			hugetlb_dup_vma_private(tmp);
> -
> -		/*
> -		 * Link the vma into the MT. After using __mt_dup(), memory
> -		 * allocation is not necessary here, so it cannot fail.
> -		 */
> -		vma_iter_bulk_store(&vmi, tmp);
> -
> -		mm->map_count++;
>   		if (!(tmp->vm_flags & VM_WIPEONFORK))
>   			retval = copy_page_range(tmp, mpnt);
>   
> -		if (tmp->vm_ops && tmp->vm_ops->open)
> -			tmp->vm_ops->open(tmp);
> -
>   		if (retval) {
>   			mpnt = vma_next(&vmi);
>   			goto loop_out;

Looks good.

Reviewed-by: Jane Chu <jane.chu@oracle.com>

-jane



Return-Path: <linux-kernel+bounces-141848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8B28A2438
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522CA1C21992
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B30B14F70;
	Fri, 12 Apr 2024 03:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d31yyO4X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r+MdOnqo"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB01D12B77
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 03:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712891579; cv=fail; b=kUvQzDoXSa0pqCMWcepOI7Vm2j0ktVUgJI5t1TCFkAESITZuG5vqk55/67sVOtSLuk5cSWjROuF8oUvgubGjs5/zJ0MfTYgwZLAOdtSQupNB5V6WVtLQYDHEXA2yzNlyqCqwIk1zCISrzZr7jJp4jwg1FOUTueC/HUh1FNIYLvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712891579; c=relaxed/simple;
	bh=eNG2znYJDd23/5vnn9butgdqFOKz6ZjBtAZi8tuJcOE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oNRy6/fMyn6yaYF+tVNyGuu8GToGplK2v7IdPnstEaJHx9HkBfFqXTMB8YLAp6ZO5NB1S7n73R8mnT67fRPq0iYogobxOefHGGPztj4+vtC/Kqh5R52QB6qBF2w2G+fJculKqZyQ9tdN2I/kREWPRouUcmBhkkbUhZpXMKThivE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d31yyO4X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r+MdOnqo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43C2n7Nv020242;
	Fri, 12 Apr 2024 03:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=aj8uWC/hvR+7KzZZ6DmHpeur5j3sBydUJ0UDP81lE2o=;
 b=d31yyO4X0HY+6eMBFc5sJBycSTGQm53KCgJD9VV3HT9hpSxFzgWPUl4uoS4IumJ9P0MN
 LlaRaXxcTEmOFnaJT0KIz8K2XRCscJ0qcU6KWwPFeBhJ4ZeduChrhRLaVqRfEqkRBfKe
 EBoxCAOGbticJB2PNpMZXVnrl1wPH5VEqkq1VzwezGx3eL9ozptpsMY4e4wAeaFxTn9H
 qDVOXHvD2G4LzmtV1N3sfINk+kMu/6wPonpQDTQrxtNar8faN7h6OIThp4F87eA9SlL3
 WnQG5ASpTYNXPTQhA0wAqNoGUF7fnbcwdtKCqBf1MIdEXCAMle3oH+8yiqSQLuh4DKB6 QA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xavtfar6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 03:12:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43C06Gsn010539;
	Fri, 12 Apr 2024 03:12:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavuacv2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 03:12:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I934c/WV9FPHyKECB6nZVf25vQXh6fZ8WlzxylhXjTY+HaF+jXh5N3hFKCePBaXFn1tSlpe3CJe/daQt9ixnQgedX4hGpkVGv9C2q4YJpnDzOtnsAwFSqJFgDGSp6PYYIVG0rkTM9UhUuX153uBEbOldhj7OujfT2BEp0cjqHvVNlAzoaeSQ4EyHZD/2SKi18p5LMwY8fH9yl4zhHvz0BLUY9JJl7ETKjgf1zK+f9kbB4cHzJvCZqOhr9Y25MA7PBz1W2f6246BsxcquSG2eTc5Ufz1UXmYxWI9j1LfmEY97STmDIs/CC8iluIlZFeIp7XlvGFJRYCnQzuWU6WkzsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aj8uWC/hvR+7KzZZ6DmHpeur5j3sBydUJ0UDP81lE2o=;
 b=Drh7HSfgu6c83N10QVP6pUPr6HOnGGEZFmGgGFA6LSvp4vQfmKIMsZDxUwtb8Qo5aONzZDkEQS/L7HDc224WchGYUx40j9F+jcQr2lnmJqKniS2p9oOAh8hAmryutEDR3mCj37uWrIJ0wirFmQ6Jn03D5QZKny9+wT5QsxGntC/uJLPnWK4ePuucXqE32UuYn3rvLUzBboXEZQrlCWHJUYZUVedACVWrZDyAOCZj5wfgM8nXWIddRMk4QpMU3yrYaZyhdTMlXrKIKcl+Np1lnUF9nCSb+FR07ZIdBCnsyKgZIwDcT8QcdSz83Ix1w2VD3D3fQmWWxic96jA1uWVwoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aj8uWC/hvR+7KzZZ6DmHpeur5j3sBydUJ0UDP81lE2o=;
 b=r+MdOnqoQCtRnFXUNba/IPENsZebmXjvvFImxPMgmDU777yyLubzpnyEexWHEapMhBDDuIHRdwM9GnenijVyDafgA3t5eHYyH2LyH5rLUYDZ2O/Rw3+Ozp7UU8WEguDOSUuWE72tNCM+dbJVIqz8129T321tCzIzW0BdXPw9fQo=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH7PR10MB6481.namprd10.prod.outlook.com (2603:10b6:510:1ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Fri, 12 Apr
 2024 03:12:35 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6573:ea04:fecc:cc68]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6573:ea04:fecc:cc68%5]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 03:12:35 +0000
Message-ID: <48647e5b-d15b-457b-9879-fb1b6bbaee27@oracle.com>
Date: Thu, 11 Apr 2024 20:12:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/memory-failure: fix deadlock when
 hugetlb_optimize_vmemmap is enabled
To: Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc: naoya.horiguchi@nec.com, osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20240412025754.1897615-1-linmiaohe@huawei.com>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20240412025754.1897615-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0107.namprd03.prod.outlook.com
 (2603:10b6:208:32a::22) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH7PR10MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: f7ffafdd-114d-42d4-2ea7-08dc5a9e6635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kImURULU/qopn0ctbZdIv3Bl6Sh0jIV44bulJBDQ5qABzEQA8JyIwCZyvpfDDrXefLZgzuuQvAVzQ8r+kZNRG1o2V30RxTZIrAXU4/JeOImpZxYtFhieXVinA1zN6FS4j3BLAgJ8v76DiiB7/HPvE09C8uU9FIMIKQ6PTiCJ/Av0GQsdUIvpDeYwnkd3DDyTc3uHabwnjRgGXZOKnwT7XKLOFjlp853C63huY+3RTLjtOsve3iEgWlr4g6Xx86hVXZfkF5jTKxxivkOH1WKATNqADDmbq1r00UMbw0rzd3F2Y4dUW5ygBAilroFqGvxlAWiaV1b93CHAZ5Vss4IqTJ/gFeY0ppCm+qSeBAY4MLwpa7K6ec7oYkJxB0B6Y7QJZp4Sntoe3PG3oqqwhStPGHZtfqwFrOT5W05oLQgf8h4iL4BjDyfaaOuaRvHfztgZqz6NwjbJJRcxrEKI3F3eLNA00RPcMNqQnibl02UQ7ZAAw/0SjzLiGnXhfuvUfjJbvGRO0uD77AqTucBODlyGqLm3rXWEf5cL5T42zCMlq0W431gCIO8OU5HsTbP4DPZpaVcHudGtmOGZSKbhA8wHyNMIcGNoHM9NLDUS70MVNgU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L21xcHcxNHI1UE9JVWFoUjh0c0tTN01Ocy84bDd2eFFzWUVTUCt1MFpLSGN2?=
 =?utf-8?B?bHdQT2Y2akpUNUVhOVA0TlRaMC85VWtCa1Jna0xnWDlkdVV3anp6d0hLaVFS?=
 =?utf-8?B?dVprS2hRMHBBd2pxYW04Rk02aFpjOUU1aGk1K3M1a0FaYWd5dHV1STR1bTNn?=
 =?utf-8?B?eHRYTFZ0T0hJUWVseVVUMUhqSVczYVFkYzB4ZFFDVmU1bGprZWVhSmp6K0Ns?=
 =?utf-8?B?UjhQWndNNHUzbWhKV2NoUE1kbGJqRSt2cUx2Zlp5aWVxYmh2TCtjKzR1QTc1?=
 =?utf-8?B?dEk5QitoR3NGNmpPRzNHMDlIaHV6OEtBcnJuS2tUcEEvZVlYNUpRNVNFeE05?=
 =?utf-8?B?LzVLNm83QXJQR2llVjBVcTQ4VDdTWi9jSUgrVnNJTFNHeUM4YlJLYzErdmxC?=
 =?utf-8?B?bWl0VkNTa0VrU3psVnhFdjVkdFdCenhkU3FxUE9LSklLVUs3TkNFWVUwY1Ji?=
 =?utf-8?B?NjJWOXBGYnBXTnVhYWpZMGlTNmFTZkROa1FtU0FUOWFOem1ERldOZ0hwMDlq?=
 =?utf-8?B?WHpNWk1wUE9lRGp2SVMxVk5qazlLNCtxWWdNVVJnbGwvQi92UVpTWTAwWlhu?=
 =?utf-8?B?aEI4bjYvSGJSQkdjdERnZXVYSUVtZ3lQanNBYkZZeVFqRzJXT0VuMm15WWJV?=
 =?utf-8?B?QmhkNUFXS05sd1grTTlaZFIwNlZBNERkSitKUTFLYnVQV3FNYUpTVFh3RURT?=
 =?utf-8?B?NWltZkF6S1p4OWxFUEV4SDNHd3pUdVNjaklCZGk5cGNzYWxlemcvYUZ3MTFH?=
 =?utf-8?B?ejVpR3BuTWV6S1pPL0hCREJYRE0xVndLeWlsQm9uVFUvLzBQTmNacS8xSEM0?=
 =?utf-8?B?THpTNzNJbHBFUngyR2hqbG1yTnpITS9mdUtKNjRIeEpnc0pwbVA2a3hpbFZO?=
 =?utf-8?B?cVYvVkRMMHlZZWtLd0lLYjZQRzdrMEpNdXM1b3dLVTZkVkxSd1hSNkpIa3o1?=
 =?utf-8?B?bU5tbTJsTGdrWTZDMy9ITmhHbEdqSEdzN2hweVZBa2srTmU3Mm53K09CM2x0?=
 =?utf-8?B?S0thZ1JqaG05Y3R6NFZyS1d2TTlaQm9zWHQ5UXQzeHZmYTQwUWxVZ1ZxQVVx?=
 =?utf-8?B?ZXVhVkVEVTRtQzNtd2d2VWswNzhQMVlBZXBTcHNrQlFtUjdBTXhnME1IWito?=
 =?utf-8?B?eURhZEM5VGl1cWlUdTNDRldvaURua0pIcHZrMnVEMFVPMDk3SnIrbkdZT0Jk?=
 =?utf-8?B?WTQrWVE4YWlCZ2ZkSkdaUTBqVlkwbnZBSFUxQUhJWDRyMERQYWNQNEQyeHdV?=
 =?utf-8?B?Ykdubmt4NlZ4VGMzdVEwSGw5UTNrUGp5Y3NsZmVCUGx6dTc5czRQU1hRWW8x?=
 =?utf-8?B?aVV1cS9hVk5TM3o2bTJJTkdUalAxM3ArVzJ4V3FjbE5nYUE1ZEpBRCs2Nkxm?=
 =?utf-8?B?MkNSeVByZ1hTajA2K0tzUG1wTDlKaSs5VjM4MGN5Qkd3V2VMNEVPNlRMeHhN?=
 =?utf-8?B?eEkwR01wdzJucVEwTTZRSE85OHArS3VvaWFGQmZQZktHRldtV3h1SWdLdlVj?=
 =?utf-8?B?Znlvbnh4Q1p4akU3YjNKVEtIanNYS25PTHV0WTUzd0hxanhZMThMYlVQWDBH?=
 =?utf-8?B?UGlpb2JFUDB5QTFZUXRrbWl5T0QyalFMc0toaTI0bGtJVXJTRjVZYjZJYWpX?=
 =?utf-8?B?TDlhSTVJZUpQeG54aWpRZzlmdDMvZFVBUlZpemRTQ25td3NBZ011OWpRK3pN?=
 =?utf-8?B?dkZudi9WYjdLbWdPcHY3bHhhVTA3YTZIdW5pMVd0Ty9ma3hlWnU1b0VpQXU2?=
 =?utf-8?B?ZnJ6R3FjU3AwVmFRR1JJcURGcFMzcm1KanYrQzNFWWh1a084bVg0OUtWWmhs?=
 =?utf-8?B?MGZuNFBMbWs3UEMzdEpXVDZrMXcrTHJod3BtdnBxc056RFZiR0ljK3BVS1VK?=
 =?utf-8?B?dFNXWm42eTl3TGF3KytYQU5PRnNEVGc3NHE4RVZzMkRjaEFKQ0R4djZiMnNZ?=
 =?utf-8?B?eEo4SWxPTWxSOC96bDJYbFRTNFcyVEQ3VXI5MHF3WGhKWldrVndwb01hbURq?=
 =?utf-8?B?T0J3N01rQkIydVdDaWVnTlJqRGtQMzZ1RGp5aEY3NGFxMGlLb2o1L0hPYzEr?=
 =?utf-8?B?TmgybXNsQ2hDLzVDc0EvVllRazlRd2ZTZVdWZFY0RFYrUUM0bHJJb0FVSWM1?=
 =?utf-8?B?UUtHYUg4SFpYZDR6M0NweEpDTUpEZkNTZnFFaTg2amVJQURSV1pzeDNDWXlP?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gCKH0h6sl5OHomx05txTcnlEbgl85ZPAzS9f1UXoic5qpa/1FeplsjK+btyuCqdF3akllppw7EgM7ZrBWs1fDInDtbaclHy7I5XlkhnhYOwvUSEUgNUjEJqvRIOavs/MrYQ3kkUm+TMyWA+sCiLuSJ0dnuvHIcvj5Hmqx96uX0TX7h90JCYS2tguB5GK0nTKY9vll+bmjHUHcgeFWx6g02csavjwoX2I8JLYYu5Oe8u3hoA+HJ379YETbKnbTOMCZmG1BkXQCmhbftCI3oWPOn1xI8EWlj2Q9lOdx03q3zL7K3sH2xZsIr3v2EE/f9GurkVLlcFhWXQZcFK39dJpZbtrMTpSF+duONyk5t+nnSUCRyBY3chgdzoIzMupCaplzT2k9ZgGgA1pCLexH4I9KwgeqpbcoVZEvjdbGSxhSyY7aRvVHGkdQSWjB15AyNLKrgGCvUDdFU/AT6xmIeicT6eZD22tVTH3UvQbIYWH+t5JmV2J0PQxKTY+tm4EnrnVtDVIBTWrWv//a7hZ7Vbo+SR4ig/xHgZmd2ktt9lxUQfOqA7U66jzqI8MarHPGdJccxh9g+9r/ecAZcw5iNtVI0n38WgXGgCkoTShG8yPesA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ffafdd-114d-42d4-2ea7-08dc5a9e6635
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 03:12:35.4112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLAfSbfB9d1KOlj0nuF+cyuZmdYxWO2+6C+dyF+uy3mxlNtsoU7eMR6GFxdsaLrqNk8xR5/OKN9xnQ1SiIBeeC7LRPPXiISjLwDHpHcTfKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6481
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_14,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404120022
X-Proofpoint-GUID: lcj0bU3XrKglu-O6_BGRRWlcq_fNFBzh
X-Proofpoint-ORIG-GUID: lcj0bU3XrKglu-O6_BGRRWlcq_fNFBzh

On 4/11/24 7:57 PM, Miaohe Lin wrote:
> When I did hard offline test with hugetlb pages, below deadlock occurs:
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.8.0-11409-gf6cef5f8c37f #1 Not tainted
> ------------------------------------------------------
> bash/46904 is trying to acquire lock:
> ffffffffabe68910 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_slow_dec+0x16/0x60
> 
> but task is already holding lock:
> ffffffffabf92ea8 (pcp_batch_high_lock){+.+.}-{3:3}, at: zone_pcp_disable+0x16/0x40
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (pcp_batch_high_lock){+.+.}-{3:3}:
>         __mutex_lock+0x6c/0x770
>         page_alloc_cpu_online+0x3c/0x70
>         cpuhp_invoke_callback+0x397/0x5f0
>         __cpuhp_invoke_callback_range+0x71/0xe0
>         _cpu_up+0xeb/0x210
>         cpu_up+0x91/0xe0
>         cpuhp_bringup_mask+0x49/0xb0
>         bringup_nonboot_cpus+0xb7/0xe0
>         smp_init+0x25/0xa0
>         kernel_init_freeable+0x15f/0x3e0
>         kernel_init+0x15/0x1b0
>         ret_from_fork+0x2f/0x50
>         ret_from_fork_asm+0x1a/0x30
> 
> -> #0 (cpu_hotplug_lock){++++}-{0:0}:
>         __lock_acquire+0x1298/0x1cd0
>         lock_acquire+0xc0/0x2b0
>         cpus_read_lock+0x2a/0xc0
>         static_key_slow_dec+0x16/0x60
>         __hugetlb_vmemmap_restore_folio+0x1b9/0x200
>         dissolve_free_huge_page+0x211/0x260
>         __page_handle_poison+0x45/0xc0
>         memory_failure+0x65e/0xc70
>         hard_offline_page_store+0x55/0xa0
>         kernfs_fop_write_iter+0x12c/0x1d0
>         vfs_write+0x387/0x550
>         ksys_write+0x64/0xe0
>         do_syscall_64+0xca/0x1e0
>         entry_SYSCALL_64_after_hwframe+0x6d/0x75
> 
> other info that might help us debug this:
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(pcp_batch_high_lock);
>                                 lock(cpu_hotplug_lock);
>                                 lock(pcp_batch_high_lock);
>    rlock(cpu_hotplug_lock);
> 
>   *** DEADLOCK ***
> 
> 5 locks held by bash/46904:
>   #0: ffff98f6c3bb23f0 (sb_writers#5){.+.+}-{0:0}, at: ksys_write+0x64/0xe0
>   #1: ffff98f6c328e488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0xf8/0x1d0
>   #2: ffff98ef83b31890 (kn->active#113){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x100/0x1d0
>   #3: ffffffffabf9db48 (mf_mutex){+.+.}-{3:3}, at: memory_failure+0x44/0xc70
>   #4: ffffffffabf92ea8 (pcp_batch_high_lock){+.+.}-{3:3}, at: zone_pcp_disable+0x16/0x40
> 
> stack backtrace:
> CPU: 10 PID: 46904 Comm: bash Kdump: loaded Not tainted 6.8.0-11409-gf6cef5f8c37f #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x68/0xa0
>   check_noncircular+0x129/0x140
>   __lock_acquire+0x1298/0x1cd0
>   lock_acquire+0xc0/0x2b0
>   cpus_read_lock+0x2a/0xc0
>   static_key_slow_dec+0x16/0x60
>   __hugetlb_vmemmap_restore_folio+0x1b9/0x200
>   dissolve_free_huge_page+0x211/0x260
>   __page_handle_poison+0x45/0xc0
>   memory_failure+0x65e/0xc70
>   hard_offline_page_store+0x55/0xa0
>   kernfs_fop_write_iter+0x12c/0x1d0
>   vfs_write+0x387/0x550
>   ksys_write+0x64/0xe0
>   do_syscall_64+0xca/0x1e0
>   entry_SYSCALL_64_after_hwframe+0x6d/0x75
> RIP: 0033:0x7fc862314887
> Code: 10 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> RSP: 002b:00007fff19311268 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00007fc862314887
> RDX: 000000000000000c RSI: 000056405645fe10 RDI: 0000000000000001
> RBP: 000056405645fe10 R08: 00007fc8623d1460 R09: 000000007fffffff
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000c
> R13: 00007fc86241b780 R14: 00007fc862417600 R15: 00007fc862416a00
> 
> In short, below scene breaks the lock dependency chain:
> 
>   memory_failure
>    __page_handle_poison
>     zone_pcp_disable -- lock(pcp_batch_high_lock)
>     dissolve_free_huge_page
>      __hugetlb_vmemmap_restore_folio
>       static_key_slow_dec
>        cpus_read_lock -- rlock(cpu_hotplug_lock)
> 
> Fix this by calling drain_all_pages() instead.
> 
> Fixes: a6b40850c442 ("mm: hugetlb: replace hugetlb_free_vmemmap_enabled with a static_key")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Acked-by: Oscar Salvador <osalvador@suse.de>
> Cc: <stable@vger.kernel.org>
> ---
> v2:
>   collect Acked-by tag and extend comment per Oscar. Thanks.
> ---
>   mm/memory-failure.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index edd6e114462f..c6750509d74c 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -153,11 +153,21 @@ static int __page_handle_poison(struct page *page)
>   {
>   	int ret;
>   
> -	zone_pcp_disable(page_zone(page));
> +	/*
> +	 * zone_pcp_disable() can't be used here. It will hold pcp_batch_high_lock and
> +	 * dissolve_free_huge_page() might hold cpu_hotplug_lock via static_key_slow_dec()
> +	 * when hugetlb vmemmap optimization is enabled. This will break current lock
> +	 * dependency chain and leads to deadlock.
> +	 * Disabling pcp before dissolving the page was a deterministic approach because
> +	 * we made sure that those pages cannot end up in any PCP list. Draining PCP lists
> +	 * expels those pages to the buddy system, but nothing guarantees that those pages
> +	 * do not get back to a PCP queue if we need to refill those.
> +	 */
>   	ret = dissolve_free_huge_page(page);

Hi Miaohe,

I recently sent a patch[1] to convert dissolve_free_huge_page() to folios which 
changes the function name and the name referenced in the comment so this will 
conflict with my patch. It's in mm-unstable now, would you be able to rebase to 
that in a new version?

Thanks,
Sid

[1] 
https://lore.kernel.org/linux-mm/20240411164756.261178-1-sidhartha.kumar@oracle.com/T/#u


> -	if (!ret)
> +	if (!ret) {
> +		drain_all_pages(page_zone(page));
>   		ret = take_page_off_buddy(page);
> -	zone_pcp_enable(page_zone(page));
> +	}
>   
>   	return ret;
>   }



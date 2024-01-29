Return-Path: <linux-kernel+bounces-43512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4975841502
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5288A1F2520C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A15A1586C9;
	Mon, 29 Jan 2024 21:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g3zBPC+A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n10bPbut"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8127176020
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 21:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706563074; cv=fail; b=eKGX8gh+cfWAnZisAxNt8Wz3LCQKIR99Mf1cu7DWnpB0XsOMN03P+jaLtAwP9tTz1KWXxZBQm6ue5e06M0RvveUjJ3MlSV+54I9o+I3RBoWrZMhJ3nGP4kth2kA4fMtmkftInQ0tg507Ribay+nXG1eHTLBSaNsMfxomGoWeq54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706563074; c=relaxed/simple;
	bh=UhiQXprmBVJoIe3GH74TclrBH8zgGger04oRJ6xg5PI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a1ZSeYLwdZvB4EDNz1J9bp6B7x65lUnIOrnmZ/qQRyUVLpVdKb8bjuq7/0+UV6Jrzq/1/ZRStPobyZaXDspgaTJNOrL94z60ODp1WqFgTbCzD2dHFqqgg4kuJeF9l3MDc4qCJFz5GZfUCbAvtEh4uYWh/YETm3+KHQE77g4EzL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g3zBPC+A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n10bPbut; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TJi1K2016789;
	Mon, 29 Jan 2024 21:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=d7yAzGC8lkYw4vvKQICCME1KkL+74wcZVGdyCMaeyFA=;
 b=g3zBPC+AmpFOuTzlx4B10oZLOFatct0vMRXU9kOI4aFi3tXCuk4md09QeW8hvQAE0Qpk
 qLDDZZ21JJ21e3RR0SACYcSdQuNt9JDePQoNNMvUmzBK7Ejp4OT8JUnOIVNLc3hw5yjV
 /kafcV8EuI6H+eeLm0p9QHjfZQ+xphGmr38Bzmc7JrkMT+wkqUXejfXwZTRYOC+HR7z0
 JEQnLDnmK+5LOHK6RW3RIPp5Ak8ERbkPw3ONNwdewBdeg3cb2A3CEuxQf/Kq4kvoXysz
 2qCCP2BKbL7h/jNvwQ9kS6hgPe+hBYBH0g+hcc9x/f5KjrPp5fL7Xtcq2P1TnHY1lRif Bg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvsvdn0rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 21:17:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40TJwc5S035358;
	Mon, 29 Jan 2024 21:17:32 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9c811u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 21:17:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/h35woS9uf0HEKkUkET1ocOkpma9osg5tMReMd05f+pZd3wQFlrQsAXTzUswNTAjab99TevtgkXjgsbwoI8s6zUsyzsGFhWMCvDSpL8eMc+ouudxQ78bgcilpDR2tBmmo4akGyc9t7zl1YTCt2Y0cqhUfYP3QUM1GUDd3Rnk858uGe+xgCLhkc53Km/N6F3jE3iA1tH0wY8oFj+8+rKxl7Cj0ResfyaC4WtpDivvKn00DIq+MIco2wMYc7YyAaTMFmdPGs672Shh4hlX54pJy2hiut+ogqvf5KHYLW91lgI0PGzH6Id/M8ZRZDhWHcN0fJ02P4vBi51bn9FxH/gYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7yAzGC8lkYw4vvKQICCME1KkL+74wcZVGdyCMaeyFA=;
 b=H6mePNbXvzxTA1S9IcKT6eJ7H0a6WWhm5nhSucxHiEeq9HWHRr7d8Odjbg/PDIdBjGDqXGyXAEwDweUUnoKJY8hU3eW9NVZ/LFHrC/Cpi97bVcOwG/p36QpuTdl76ytecJfFuKWN4Hh+teeUdVGzCj/v8c07kOwmqMOHyhVRxVs06JYchgbOsKHLfvH6uWM6QsH0hx7WMm9MxHxu2Htbtsvw4TgT3alKGgp8uKF84HeAHYMfKFQs6nHGvMHXj1WBIy+BgemngH4ukLpxOGuGX55TiEgwqvWTPCfhkhIw0CwmJ8MIZOdPfdUVZE/XZMdTFGBQiMHO/e3lHjQqJRMv2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7yAzGC8lkYw4vvKQICCME1KkL+74wcZVGdyCMaeyFA=;
 b=n10bPbutf8wQPWM2KPWV05YbPIJc3pnoTzpQnYIagMptyDmHPrCNngqr8uKQeHUjiQDEfPDpo6XunwIRWoSXdLuam8awskkfXq+M3ikt+TK/ZvZ6FRLw3LuLdWNHy+kthrTJDE8BNTl8hQk1av9yteYXH6hoJ1PtdNYqUyh9wsE=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by BLAPR10MB4963.namprd10.prod.outlook.com (2603:10b6:208:326::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 21:17:29 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::bd88:5306:d287:afb0]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::bd88:5306:d287:afb0%6]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 21:17:29 +0000
Message-ID: <37af8f84-98bc-4733-bd9c-102b62fdd028@oracle.com>
Date: Mon, 29 Jan 2024 15:17:27 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs: fix shift-out-of-bounds in dbJoin
To: Matthew Wilcox <willy@infradead.org>
Cc: Manas Ghandat <ghandatmanas@gmail.com>,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+411debe54d318eaed386@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>
References: <20231011143937.31996-1-ghandatmanas@gmail.com>
 <Zba9zRWq6rZhWn-p@casper.infradead.org>
 <a25c75af-c961-4ca6-9810-dbcfe64753d5@oracle.com>
 <Zbe8c_CPNP8IdphB@casper.infradead.org>
 <551e1e86-f990-487a-ad88-53799df0882a@oracle.com>
 <ZbfumG4uLUwZkzlf@casper.infradead.org>
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <ZbfumG4uLUwZkzlf@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0382.namprd03.prod.outlook.com
 (2603:10b6:610:119::35) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|BLAPR10MB4963:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a25558-d042-4e62-ce55-08dc210fb343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LLdteRQSXSS5VKnaJqkGYhyEaHxUUxfou96Spp7QjUYfGRNVf+bOLXJDnMn+mZzT6/ERj1q6MBSl+S0AZNTj4cnAMp0b8HVlmesf/CYPFSqmMyKGOEpsCvAHeqrHAqyQIBCaDlBavI3tzp/u9QQJCPFXgjRQ8hyvQWwpajTLRSumbE9dda/6sw9EtfCjxCm8w0IBkcXcujZAwGR4dFojDLjXbwVYzuD7xB/+Cq+qBiSD8bLZwyTkDkGstSa9R/E/qIi7A/Icg/Yb1NYsnT31PPAyLwssPPMvMzLbkGIz95/urfZCIi5ptPSjdercgnXHDTvd40cm2xnYEeDgldB3RBO8/Fnz/ckgr96OKzc/bRZfIZzVe0ffhNZuWLHwHGfrwFQ4qNUVomiS4vi/2FCLYMzSc2xjmcsHPvy5b1kMk96J0cJov0Zbf8+ZKN2vbKEMp5IJs/FQdlo9tIN8xcQ8WNwZk9yav6aji+mqn/hVQkTXzQJ19h64PdG5FkMmXr/ehSstNU6JjWX9XPCQeEpuPe3DvE8lNIpAVMUK5pa/boBBiavLsXswxQ7RcJ5egJHbvF+nDSrPNIywJVPivelE6Gj0mg2kT6alwhDCyXSsmkZUu0cxb3TCHz8u1f2cqE8j12uZYKQ2Av8TxYie0Qm0IPD6eTAaa8+6uehtTxSKq4yISlNjR4+acBnQaZkvIJr0
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(366004)(346002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(1800799012)(186009)(41300700001)(2906002)(5660300002)(36756003)(66476007)(6506007)(31696002)(66556008)(66946007)(6486002)(54906003)(6916009)(86362001)(316002)(6512007)(83380400001)(2616005)(26005)(8936002)(478600001)(4326008)(38100700002)(8676002)(44832011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RXZ6L3RHNjAxaUpmeHJYOFp4L0NkYXl5djNmS1RzcnJMQm9GOUs4OXlIODJU?=
 =?utf-8?B?Z1ZGUHBBQmo0UGRJL1A3Q1pkNE1DcUJzc3dFQ0VQcC9Zbk11NDE5cjNZeStT?=
 =?utf-8?B?bmVsejRZNGw1dVZiTnhmQzVnV2l0K242Vk1wdVhyYWFzZklFeVFieGJPTmU4?=
 =?utf-8?B?T3kxQTd1Yzc5RWNuazJZR1dwaFBKQ3RiT2dDUnRWU1dIaFl4M1A3TTdIcUNL?=
 =?utf-8?B?SVQwdmIxZXdiMmFRbHRieGEwbTNFM1MrODJ5WmM4MHAwUVpWODNIODkrYVVK?=
 =?utf-8?B?RnYyOXdNbVFTN3BDV3Z2a0ZET1VjcmdzRmFxQ2xUNVN4NG4wK1paNFljakNU?=
 =?utf-8?B?K2YvY1picVlvS0xYbExWeWJMeEZuZlp3bklEaWxMcmVJWWpHbU1NNjJjeEt2?=
 =?utf-8?B?STQ0cGNVYzQzMTlQMGlDMXpEdEpzY1NJU2tDeVFOd2FjYldCeEVxdjJQOWYw?=
 =?utf-8?B?eGk0azRFdUNORW4rVXN6Z3YxU0Q2S0tXbytDSHd3UXh2RHVjc2N1dDZLS0ZX?=
 =?utf-8?B?ZXRES1RWdUE1TTIxS3ZRV3I0cHFkdElMZ2VteW15aUNkNm1CbEZ6d0tMd0JX?=
 =?utf-8?B?R2RoNjdiM0FQSkRyWHdSOGh4N3BmbHRyTFVBMjFuQlJLMUdWOVVuVnZjUnBh?=
 =?utf-8?B?QmsxajNiYm00NmVqUXJLSkVqN0R2cjc1VXh4WWk3dnZwUTN2NDJNL3R2Y3RB?=
 =?utf-8?B?MnU5cG40WWNBeTJJak1Qb2J6QkQrV0F2YURyOVRNM2duQ3B1cWQ0eS8xRU0v?=
 =?utf-8?B?L25vTU12bVpuV1lPN1lscXc4dElTRGxYbWIzUjNOOFJSOWVxdk5WRTh3TXdL?=
 =?utf-8?B?WVBJRTdKR0ZhVkNGaHF6OVBwUVhGZ1UyTi85L1JaVm1KMHQrSithbzJXZXhP?=
 =?utf-8?B?SEpQZGl5WnJIbmJOamhaOUROcElZcm84ZHZKa0pvOCtWd0Z6dUFKT2p3YlFX?=
 =?utf-8?B?cTF3ZnRJa2Y3MFFFbFB0b2sxdHRUY1htWWVlTzJxZXNHcklqSnppVkRCMzhD?=
 =?utf-8?B?dENkVWY2Unltd3B1SkZWcmIyaDV4NUJLTTFTM3pxbjRlRkd1NnFRaDlNQjY4?=
 =?utf-8?B?dGhxSk1vcUI0RlpML0VneHN1WE9qNGJoUzAyakhYNDJ2OW9OMTFucGhMNGMz?=
 =?utf-8?B?QTFQM01rQmVVTno5alNwMFJuODJOQW8zbzYxMlk0NHltTVFsa0Q1THpOYWlj?=
 =?utf-8?B?Q0ZFWHRWRXIzVXZzQmtyVFgwclZFcTN3aVhJeXM4b0hFTzJXQmN3YTBQRWtB?=
 =?utf-8?B?QUlkdDRweXJOeVpSVmtjZjZTT2Y4amxPVDBQeE5UVnJEZno5d3NMTzBYbXB1?=
 =?utf-8?B?MjdibXZVOGNDbEFjMDI5RmhhaDJVUjExN0lhS1RhS0xJazdrZEJoUWR3Qmll?=
 =?utf-8?B?b2NVN1FPcFV5UGRQZGUzZUlkT25WaW5pZzNwa3hLbk1wQUJtdEpoalZVN1Rp?=
 =?utf-8?B?SjlaZEhyd0s4RG9jNkI1b1NXcEF1UmhPMlBXNFBmekZYMG56SHFDTzNGc3p0?=
 =?utf-8?B?N25aTWhGMS9UZG1GSnRZVGJqNXk2MDNCVmxzME8zWWFWa09JbFl0VDlhdVFi?=
 =?utf-8?B?empPR0QxMXAreXRpeFQ0SExGb0lpRG5GcW81QmdPNzB5d2IyVDErMnQ2MGo3?=
 =?utf-8?B?a1J1dkxPSk5tR2pQcXVWemlxbS9jMXoyN1BHM2xObkl3UTFXSTdxWk44U3Bm?=
 =?utf-8?B?RG9DSXNVTlg1Um8wVXRFbXdCRmV0alpnR2paREdGMjFBM3hnR29KOWJUZ0I0?=
 =?utf-8?B?RVEyMG85VlQ0bVVMWktRQktWUXVvdU9QWm1rZE9YOWZGWGoyTnhWQUV6RG15?=
 =?utf-8?B?a0MxMWREWmdUWE5PRmsxeUxVYldsb21WbExPTkcvcGlHME53eHRIMUM5a3p6?=
 =?utf-8?B?Vnh0czBVOVBTUWFpWXpJdERtMEJZMGh1dWtRRkdNb0p2ZHVKZ3RNRTZ0Z2p1?=
 =?utf-8?B?M2dqSG9UUGsyQUNTRHA4Z0VzUjdjVjRIdW9PTjNUNkdYdjZCKzhMYVVqQXp2?=
 =?utf-8?B?MHpoOGpwazdmOGp3KzZJcWRYTm5vU2d5R3pLdTdZOVFkbXBpL3FXTUlLanFF?=
 =?utf-8?B?WXdvSStFczZUVEJhaFF2MnZIa1hMU1NFazBEaTJhZGxaYklIeU9xYUc1Z2hY?=
 =?utf-8?B?UG5wOXFSVVBkek1FL0UzbDZNdlpDS0hQVGxnN3FOWmc1TWUvS1U3YmtjQ3R5?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fxnh3OqW+qYXAdhAT6YHmf7aGLz+yihUb8psKw5t/HEl3RTEGLt/R6X7Lc5s79fY5dKu4qzKAnWMYPs3EPE6vXh1W7NiLzvT2EeU/bhIVwIDK8qQGtKtoqZMSBE1tEi4uOVods9P/DbTk0e1g+MdNohiFQAX887ZtalR6M/t+LCOTLlSMw2O3VRPLsob2PLtjabQTBzZMOudKs9YIwxdra9olrO2Gw84IILyBCYzn8yEDR7QziCTJ4l+LkF0b1LYCkOYMq5FMwyYC37oHYGYLHlqiSNJxz3/wdElRvnU5pYdfr9bgNNbrua3Pihy8LkmTGjVC1KedWO9gjyarPiHseGEwfdS+xe2HiSe6Sqql2oTDF9Y6TXxiBy60coSz1biklDhENxTX5erJxWLFvdC1YZWJItci1xvAnLf6HX6wCZZThHOHm4OiH39eoLqF+CkghC1qo5cnR8x4hb9bD7jn7AYoJGCFBAgWIVU5pv3XXjZznYPdWNGZJn544P5uxun5mVUcREm3Gcm3gZgAVaClTf4yR+U0wjjqPyNwixoZ21hkNvipU5OUPCJxGQ71swPk7RUN0p9ZYTA+HrYM8dkfTLLmArMzXGSbjXn7UBPseM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a25558-d042-4e62-ce55-08dc210fb343
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 21:17:29.7068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+d2BWgBFtx8wTN3Kc5JZ6b5S0YKfUPMxbiCzkb2jSRDi7Ak/EqeBKYKMN+QhF2s11AfgTRym9FKh3pi2Z4DvNmYRbmZ3217J0/6JxCvb6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4963
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_14,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=817 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401290157
X-Proofpoint-ORIG-GUID: p2FyNYHdqED_ooO59S8o2d3i4oEG-vZ9
X-Proofpoint-GUID: p2FyNYHdqED_ooO59S8o2d3i4oEG-vZ9

On 1/29/24 12:29PM, Matthew Wilcox wrote:
> On Mon, Jan 29, 2024 at 09:00:56AM -0600, Dave Kleikamp wrote:
>> On 1/29/24 8:55AM, Matthew Wilcox wrote:
>>> On Mon, Jan 29, 2024 at 08:39:18AM -0600, Dave Kleikamp wrote:
>>>> On 1/28/24 2:49PM, Matthew Wilcox wrote:
>>>>> On Wed, Oct 11, 2023 at 08:09:37PM +0530, Manas Ghandat wrote:
>>>>>> Currently while joining the leaf in a buddy system there is shift out
>>>>>> of bound error in calculation of BUDSIZE. Added the required check
>>>>>> to the BUDSIZE and fixed the documentation as well.
>>>>>
>>>>> This patch causes xfstests to fail frequently.  The one this trace is
>>>>> from was generic/074.
>>>>
>>>> Thanks for catching this. The sanity test is not right, so we need to revert
>>>> that one.
>>>
>>> Unfortunately, my overnight test run with this patch reverted crashed
>>> again with the same signature.  I also reverted the parent commit,
>>> and when that crashed I also reverted the parent of that.  Which also
>>> crashed.
>>>
>>> So maybe there's something else that makes this unstable.  Or maybe my
>>> bisect went wrong.  Or _something_.  Anyway, I'm going to spend much of
>>> today hammering on generic/074 with various kernel versions and see what
>>> I can deduce.
>>>
>>> So far I see no evidence that v6.7 crashes with g/074.  And I know that
>>> next-20240125 does crash with g/074.  I'm pretty sure that v6.8-rc1 also
>>> crashes with g/074, but will confirm that.
>>
>> I'll try to beat on it too and see what I find.
>>
>> Sasha, maybe hold up on to all the jfs patches for the time being.
> 
> I have it reproducing easily on cca974daeb6c.  I ran it a lot on
> e0e1958f4c36 and have not reproduced it.  So I'm going back to my
> earlier assertion that cca974daeb6c is bad.  Now, maybe other commits
> are also bad?

I was able to reproduce it too, but not after reverting that one. I 
believe it is the only one causing problems.

I only asked Sasha to hold the other ones as a precaution until we were 
more confident that this one was the problem.

Shaggy


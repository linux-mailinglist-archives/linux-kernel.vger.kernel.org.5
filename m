Return-Path: <linux-kernel+bounces-4220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03894817942
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C344288CA4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359E45D73B;
	Mon, 18 Dec 2023 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ktg52dFj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N3T4Qil7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325BA4FF6D;
	Mon, 18 Dec 2023 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BIHXjpt018106;
	Mon, 18 Dec 2023 17:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=EUS0wW0lfh6W1IZ3zcCz+uy7BUd+/OD0RSdv7zKgCws=;
 b=ktg52dFjgTm/s9IYznvGpTsAMmoawOeyyTZUyqGrcSrb/JYxV+6Bp7H0ugeYAvxwIZ1d
 Tf7F1LvxIoUG/M8hg3kPFGY1dv4cBNtJE/Qq2XKpexKb+2BhQReRz8SbDMcbwCEqiTWr
 MN9klFpgzIgeSa48rbBtdHv5l0FkMM2rvOcM1x5lHIJR+fG4LoG09OTZflJIiQONbx+U
 ynXUuF5taNZogr3ks2R7d59y4XckBjO3dwrqxX+CGc8bqKIACAhsuhyqJS0waaH0qQ5i
 t/Y6w3BdltOMPEf1MxmCocQ8woGQpLNRBiIxyyqqaM7y8KqlWY4auCHv/pwpkqm1d1Mm Ig== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v13xdbxvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 17:54:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BIHj9DN021003;
	Mon, 18 Dec 2023 17:54:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b5s8h1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Dec 2023 17:54:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRyfAD8QWDm1yR7AOaT2tZsje7FQaVHz3gBbPOUXEcqGDx5kicvyunVI7aA0SZrfv0iXxufENwHlIxmVRVZXBmiO6ewZbs7jS9E2T72/UooZa5QjSDny8NFX64igiNuUAqiz6oiHuXA6K+hVUi33HwbHl2EyklSyEPkER/cfKbBMvZBJW2cygTvznAQv9XW9+GiuRXo7n3WhCsAlPEMcVTioa/9FyyCUcvmMyc35RiH4Xwl9C/LKTyDNHfUwmPeAMcXvW4OnO/ojpFhWWmtv+ScuEVFBl/wftbbjGNjzdI08/CDeTqfyJzNWLHQk2lyDRv4+NyoeRnvDeVncIaZJEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUS0wW0lfh6W1IZ3zcCz+uy7BUd+/OD0RSdv7zKgCws=;
 b=CVkrAQS4bdDgUtVKCdNJzRC6Ry3FAxOjFMI20wUlvrGg2GA38o7W7qFkAYojgjEXq5Xn0D+GDYqqQLbrwUAkB7kgaS4whogSKuZ1PENMDfgjhJLKuINVEPddGY640huDV3wsbzIxWofP49OiZ0L7HIaM1Y6uEY4OJPIjRBuywM5+oW2qLXNqV8USbcb0BnqIrpSwY0ROFjqcyc47sfXefUp8GZxdWqFg4rCOthQWGpOLwKi4LvUUvo7dW81j3MymJ1QElUDfsHp8/yWvpugDqZC6SS/w1GRnYDoSsP1cxaU5qnYdtxscJ0UE4Eqbtv9PDyztobUJB4ruN4sOhnK1mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUS0wW0lfh6W1IZ3zcCz+uy7BUd+/OD0RSdv7zKgCws=;
 b=N3T4Qil7DMxfWsLIvdEtJd6PZerDEroM6jcnCtclLUFyG1xtcFlqapQv0dxuEKmQqjfg15sPkyz0VZofSWUpp4UzQfrzIuFuFR6hJmLgrP8q8rLa7mVxjg2zIN8R6apbOPrOBUaZoDi9X9OTvT0LzgF526p4xdIjyjc2YCYDh9w=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CO1PR10MB4706.namprd10.prod.outlook.com (2603:10b6:303:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 17:53:56 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7361:23aa:7669:bcce]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7361:23aa:7669:bcce%7]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 17:53:56 +0000
Message-ID: <19b88718-a1e6-d699-f056-cf00b1b75346@oracle.com>
Date: Mon, 18 Dec 2023 09:53:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6.6.y] maple_tree: do not preallocate nodes for slot
 stores
Content-Language: en-US
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org, akpm@linux-foundation.org,
        willy@infradead.org, liam.howlett@oracle.com,
        zhangpeng.00@bytedance.com, stable@vger.kernel.org
References: <20231212195255.219624-1-sidhartha.kumar@oracle.com>
 <2023121847-cope-surviving-26bf@gregkh>
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <2023121847-cope-surviving-26bf@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:a03:255::31) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CO1PR10MB4706:EE_
X-MS-Office365-Filtering-Correlation-Id: b736d2f2-285b-4419-ba2a-08dbfff24dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/wM20+xTMXodNOzhuP8OLZsVzK6U2y7dcxc1aTa2evCnTZNU1OqvFKth4eqGaXvoSx6tKzT1z1OC2J+BA7D39zZY402dvupxBm77GEq8fYBC3+KID3YfmxOy5fQxk7PtWohrQBzQYVHifB4OrcLmhf/fkRXPg5iFrEj4ncxI7nYxcBBIE6KVvZcTjSBgB8+r0hJahYCBLg38F0JKcFufiThNVaJNyb79hiDjekNJqb10OM5r8mEQp2qIyqln6pQh7db/fERP2Q10L0AkhfMXPqGp45HoypUemsS8FWH0veFWx0nXiPJLktQjF3T7PaSt65qUSydJSwJdDuO3Pt1zb9pD8jLY3Za/JJHQ+dChPhjV4aHO6Pmea6EJ38W8fStoS2fHfGqQvbzDuSI2srS42r2Y1gZ+NFImL1JUCqEQ/a2DbaA7za+MbD513D+aBCH8C0QwZstxd13eNwLRlIww37KVzVw7fnka4zJmi9Y3MLALNTMwCBxbCU/d1ScQzeo/ElVDS2VfagXThDF+ic2kkPXQKx46C/asb/n4bhUISqQi4Q3/G192bdtE107LnA/DFvvMaSs3Gk5nXP9j5U2Hf34NpFgT4tJaHjRXFhHNWO33LEKofESlF7/ftcByTLbyrqegxjU0AnblFY9nufOl3Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(83380400001)(478600001)(4326008)(53546011)(38100700002)(8676002)(8936002)(41300700001)(44832011)(5660300002)(66946007)(6486002)(2906002)(6506007)(6512007)(6666004)(66476007)(66556008)(316002)(6916009)(36756003)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d3NudU4yY0dxQUdkK3RlbFM2WkVTU1VmM01vT1JwTDIrMTBXQkpKZ25OTUJM?=
 =?utf-8?B?WFRXYVUyeHVPazJOcW5FNWNtbHE1RDhMczdiZjdIMUZ0ZDB3Z3dKTE9CV0hY?=
 =?utf-8?B?YWdtUzhzamw5RWx4UUo1T1UyM1lmOUoxL0JYWVJqMVRKd04vRW1aU0J1MzIw?=
 =?utf-8?B?ZFBvUEUyNkt5cTVRL1c2QVFPcCsyWDVXT3hWS0VZbStYUVZEdTVJbGZpRktV?=
 =?utf-8?B?dkU1VzhxL3Zlc29tOGtOcWRUNm1IUzg0a2h0Unl1bCt3QzAzWmU3T1B6dUkv?=
 =?utf-8?B?OTR0cTFGcGxvcXBrWUhieWVTc1p2RDFObHc1SkdVRk5jMVBnZEt3Zi96MjNn?=
 =?utf-8?B?bCtaS2VsaE9GUWpXVmwrWVFMLzVDSlpMdFdaQmEzam9ybzV1NnBnc3JkdmlU?=
 =?utf-8?B?dFNoNUllVlU2bDlyVHRlRjg1N1hzZXZSVkx5SVV3Y3U3MnFNdm1MQ3pUdmhS?=
 =?utf-8?B?cEdsYkxadmJQNFRlMG1uNytWbldqOUxPZXNyZVI4d3BtbDhBcGVOOWtMcFNL?=
 =?utf-8?B?S1VzODhEZzFFVzBIT2VuOFZNTWZleFRXOWc1b054dE1kcTNJdFlGMEtOcVE1?=
 =?utf-8?B?alBRVjZ5bDltWWNDZjZwZjBiOGZTcm9uKzA2aVdsYVZPNno4NjM2eldSK3E2?=
 =?utf-8?B?dTB5STlCOU1TNDdha2svQUdwaFdMTzR5Q0wvYUgvWGF3RHJkRDhsU0ZQNkhp?=
 =?utf-8?B?S1hnTHhZVW9QdlNGYzhGSmNhWUhLZ0lhMElrdS8xY0JROVphLy93bkZ0dUFx?=
 =?utf-8?B?RDhIQUxYQkZEeEpjM2dybWFJMXFZcFh6Y1M0RlZoVjhaZUxMVU5yeEVDRlA3?=
 =?utf-8?B?LzRZejJ2UzlKR2tDaENaaStZcXpwUTkwb0liSFBGbVpjK05KRlF1MzFDaWhV?=
 =?utf-8?B?dllKY0tOWlNhTElkSEtuNnJ0ZzhoS1Evc3RlWW9maGdmdGlVNi8rTG1VN0J6?=
 =?utf-8?B?M3ZpeU9hVmllcU5HUkdRZkFYSEhxSGhsd3laaVFDMEhpY0VuYjZYOG1HSjNT?=
 =?utf-8?B?NmRHZEFBcUlGU2tVSm9PMHNzOFMwNURzTmdzTjBhUnkzNUp0UHhVN0ViQTRu?=
 =?utf-8?B?MGpkT2NkVUhyZ1BVRFlJQnY1ZmJBSXlQZ0dzT3ZITHVSd0ZsMFJpTHBtWUFm?=
 =?utf-8?B?WXpLMGtJMTJtZU1BSUdnRTZZd3YwWHl5eFJqMUVLLzRiZGg1OFJYZWtmS3M1?=
 =?utf-8?B?SVNvMnd5WTB6NEsyTlpyRTcydjcreXFIdGtUNG1BdVMrRGd3dXY2V1pUVVJi?=
 =?utf-8?B?Y2lzNlBkaFNBRGNIY2hubFdoMzVHeUdpY2dkakdUM1ppWE1uK3FCMmpndFZE?=
 =?utf-8?B?b2J4L1g3M013Q2RqUks0Qm1nOGl1Wi9VWXJCOHQwS0lBY2hGdklRRlAvWmhi?=
 =?utf-8?B?RmNXYlJaYUF4VXZ4NGtrQ3l0dEc4cldQNzNPQStPZzVhUzdJU01XemZWWDFZ?=
 =?utf-8?B?N2ZZSHZUdkVyS2RQbis1L1hKM2lQRkJvL080TmxVaktaMUtFY2NSbitqNlBH?=
 =?utf-8?B?OW9CV3UwSzk1RXBreDFscmUycVJHN3ZqM2Z3T1NCSmVBd1p6K3I3ZmpZT3FE?=
 =?utf-8?B?LzVFRUtwUkdQdTFIdzVHNFZpM2dXZXgvcTNqOE02RGdVR2Zmd3VrRnNGOHhB?=
 =?utf-8?B?U0hTRXVoV010ZWdPTHhSN1N0TVdJUHFrR3FqTTdNRUh6WWZVelV0Uk4yajUz?=
 =?utf-8?B?NVpnMFU3MGR4TUNZVWtXY3N3d1Zsa1lRUGZaN0NJaTV2bEFlU2dPc3ZZQ3JY?=
 =?utf-8?B?aFdGTzVxNVp5ME1QVEtPYTE0K20rVSs3NDNZaHR2Sm4vbTV4cnBoV3E4emtB?=
 =?utf-8?B?OUhiSk1LeXZuVHdZc3FKWjNveUgvOU4xTVBNYUcwa2w1NTJvVHVHQ05PZk1v?=
 =?utf-8?B?N1Q4Sll1NTV2SnY5dVM3Ly84QkxCaFlmRmt5NmFFNm9jVHo4aWorbUR5Sk1z?=
 =?utf-8?B?dWQ1UEtJUFk2OWJmMTRsQ0dhMmc2dzd1cC9oQy9jL2xyaFBJSktCUTV2dnlB?=
 =?utf-8?B?c3h4elFwVzhlcU5wd2JiZjcrbndtNS8zNDcyZG9QMTg1V01yeTZXZU9hUHkw?=
 =?utf-8?B?QVM1aFJpd2dMMEdvVzI3Mm1qWUtwVXVxYXRUTC9pbTh5d3d1dWhyUS9zR1hk?=
 =?utf-8?B?NHVjWmxoRDErbnlhb28waUQ3a0FIVFBSeTFVa1E4MitabHBJOTdKalJzS0VY?=
 =?utf-8?Q?shy5RFNcdq9xecgztEvZcmI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+a3K+hWtokoTGbcXzqfxyfe7gH/mYBMUbMGqaT0I+VOMYtafdC3RzV6I1Blyl9y3ka8Cs0h7Xw8NP7JjSaiu2U7eDHTDkpN/PVHrZtlQNflEd4ZOaxCU2oDS+CXJf1k2IGjm+IH3JEH+agSJPAA+o1irMZYBTxugyYMR1j9wJXfwnPBhVL8uGHVF4XaQCKaPHr16cbEfsmlz+ZsAKw6cKAHAMwEAS1jHNLqGqEf1YP/Hy/VdDyp5CZJhtXW0TmQVQkbLF0XsSiVXPhbVl3Tcw/FE8yfpIIES4zEwLQE3B6issvMmuMbtMoPylb4HTBiaATVoLNTWKd13WFUdPdnRimc4odpaORoCKJbYcj0V1RwREOn3UpDbvEQirHb8DgYSvXFZ8HihH77DTG6GCS8sxfp/ulVgEOdivR0KQXBlepBOaXZ0zFBeTzBY7C21XvUwEIPuFcMnWgRfLZRCPb3DbR7YCI6csQKODzSrOHpxlQfNxD4SK5vB+So1vCjlafmv72NsJrRqQeGdFwSEK/YBRo/rCqCHZDtk169wvs0FcioTI1kQRt/inVHtOyQtfpWjJt2YYm4isiREevGacciwP0+LWjZqFPNaY76kSHBPrpc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b736d2f2-285b-4419-ba2a-08dbfff24dce
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 17:53:55.8981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2YP5qGFapIRwFzaLWUjjcmss2mJAiXXppOThchWYJzPzluHcBTclu/xDQ+l5n6/scmEcjaAWRmYGn+zOR3VVm5AAVZg5UqA7hgt2kzAMNUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_11,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312180132
X-Proofpoint-GUID: Wue-1za10fmUIUVloSO2tmZw30l2i28S
X-Proofpoint-ORIG-GUID: Wue-1za10fmUIUVloSO2tmZw30l2i28S

On 12/18/23 2:59 AM, Greg KH wrote:
> On Tue, Dec 12, 2023 at 11:52:55AM -0800, Sidhartha Kumar wrote:
>> mas_preallocate() defaults to requesting 1 node for preallocation and then
>> ,depending on the type of store, will update the request variable. There
>> isn't a check for a slot store type, so slot stores are preallocating the
>> default 1 node. Slot stores do not require any additional nodes, so add a
>> check for the slot store case that will bypass node_count_gfp(). Update
>> the tests to reflect that slot stores do not require allocations.
>>
>> User visible effects of this bug include increased memory usage from the
>> unneeded node that was allocated.
>>
>> Fixes: 0b8bb544b1a7 ("maple_tree: update mas_preallocate() testing")
>> Cc: <stable@vger.kernel.org> # 6.6+
>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>> ---
>> This is a modified backport as the patch to fix this in upstream does not
>> apply to 6.6 because the node_end field was moved from the ma_wr_state to
>> the ma_state after 6.6.
> 
> What is the git commit id of this change in Linus's tree?

The patch is in akpm's mm-hotfixes-unstable tree and has not made it to Linus's 
tree yet.

Thanks,
Sid
> 
> thanks,
> 
> greg k-h



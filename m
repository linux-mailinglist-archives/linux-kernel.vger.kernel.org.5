Return-Path: <linux-kernel+bounces-65898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6E485537A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A927B1F257F6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E1713DB85;
	Wed, 14 Feb 2024 19:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Huc0BueD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rvkRPMDb"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C8F1339B6
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 19:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707940361; cv=fail; b=cr0CWkzDRk0ARRVmkt/ZuqzepBngm+RHkCZhbX6YEPu2ZOtX1/mTjSxT+7UG3Vb6RnzOd5PWxQfG8XZai52bG6DIygzH7s75ZuJKJ+zLgNQBRlPJNPB0j0JNwMi4zHXMPOuYMvKF7/VRljRIUfACdNVPrn2rva7Lqe3AWnzi/Qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707940361; c=relaxed/simple;
	bh=2VBLjZmTKMWX4QYYQwOXOKcwG21HRi0TO18DVOllXTg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tbtz6rlGFGeXgGUcONvQcnyITjNMqLCTszvr/Og5TGF6S7Xwdl0iihX0IJ8qPN5TmXi/2ThstdsnHzbE2zKD613Viirm534eT4CPLTkzslAulN3DCfjBOw3uqgwC91gy53nXF9vtjMjtHZXG7arMXRYAXWdRKn4WM/WpbrVryTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Huc0BueD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rvkRPMDb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EGsnwq004559;
	Wed, 14 Feb 2024 19:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=I5C/7/Qei6RQj7fhQtoOK6K1Vj5aGccQKHCKXrr4A5I=;
 b=Huc0BueDqnoAbbh+OZUFzo3Sp2ZZZfHVldnBXNlVCkRKdk2F2+xRYZoO0PInVL97UrVK
 HdUAmuKY+0rYc8Vp/+4Dt0uDgr7nP/qXj2gIjVxfHyoz5WHMuLmev58nzXyEDi4CYcpu
 yoAXPerH7AU/Jv3J6irVmho7hc2+sr49fCakW3jis+/OStWxNPgGo1tJXKnDOB986wDN
 llAPA3pstVtEVEBD2PxerILt5KYJQ2QNSKmFEzixTQGM1DcvvfqN+U3DQvIyTXPU/UNN
 HNeh85UEQCiINCOnCWUkEJmHdvBj93CmfW4IehUlEba6f4lfgSTAv+2w2pRENOu1+YTc 5A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w91f00feu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 19:52:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41EJ1G9U015037;
	Wed, 14 Feb 2024 19:52:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk9eg4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 19:52:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Np7E4eUdOrRDywvzZjM5Ne4rWLsxZuDcVENSAayZrab5k3eyfGB8/4q55zvDtRj9asYWAxWDaMccNfjWVtO9frTEIT37M/ExpAN+7bpJI+mKivswe55ehlG4uqBfMYcjTlTc1MG3LTXIuom7FkS3GdDZ/Qe3+IArAcdpcZ9askSKMq9ugp0n3ufKg6CoXEnSovy4/YkmNex3flu9p001lW7YmWsPHnSdpeYh4t1BNWo4A2E67XRCHDmqvlcpBbGEK/f9tFEE78RVr+hDoir1M38el4l0HLEl287U5lMZNVczSaYjZ856xXqVtSpq+IOGlwWn9maotqfMvThq5lF6Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5C/7/Qei6RQj7fhQtoOK6K1Vj5aGccQKHCKXrr4A5I=;
 b=hgtqhgZ4H0npuqWrN2oRqh7F4GOB5DBxlmDT5x/8HDcy6EpH40QG/cZ3MX173/Ob/Zf/G1tOhC163nu55eRqjNRYmI2Pt3fxFtwdCEFIJMFLRpGxabOevvXb2dm8crloBIMNoP9bPH53IHjP68tM+YkzL2ukUc04WbwqPVLrZmQ3900nXbgSy/yAQUZyJLl7azKwjDXUJKSXDNnF8uwIzSsjDA0t0N2FgUr5q0wKhPjbtNwHM9xEuWPcsB/QmpJ+D8COsNNvUZKxyBxcwWcGkkXD1/al6sf87K3goV9NLcNmbBzhIx3TY7s1grLOB+VBxUfR/oPDCK5txihuWRsUog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5C/7/Qei6RQj7fhQtoOK6K1Vj5aGccQKHCKXrr4A5I=;
 b=rvkRPMDb56qYIAKaSFrs1bNRmWTO4BfEO9NZ/QeebTzn4HJ14gW04GrG/tso6cVb55ftJlnsftsd1B5J3TR6wgBJyHLTuepDPj22TEYItmSuEpGMMgofX5ZpSKLDeXNiZJMuytbfpyxA4TG9IQ+N5MjmuAI9w2UaywNoNxFrgTQ=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DM4PR10MB7389.namprd10.prod.outlook.com (2603:10b6:8:10f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40; Wed, 14 Feb
 2024 19:52:21 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7292.022; Wed, 14 Feb 2024
 19:52:21 +0000
Message-ID: <996cfabf-c612-43c8-9e56-03fb58a1ebec@oracle.com>
Date: Wed, 14 Feb 2024 14:52:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3] vdpa_sim: flush workers on suspend
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        Stefano Garzarella <sgarzare@redhat.com>
References: <1707758174-142161-1-git-send-email-steven.sistare@oracle.com>
 <1707758174-142161-4-git-send-email-steven.sistare@oracle.com>
 <CAJaqyWfYHqf2=8BMo5ReKEB137fxGZR4XEJ2d4imXOOXAX2wHQ@mail.gmail.com>
 <e1b80fee-30df-4733-9072-ce67e3edc72f@oracle.com>
 <CAJaqyWe1=eQ4eQyv+wOqbr3pfZst6gmss2SrDZSNkY_ZVXcf=Q@mail.gmail.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWe1=eQ4eQyv+wOqbr3pfZst6gmss2SrDZSNkY_ZVXcf=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:a03:333::12) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DM4PR10MB7389:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f3fc4e6-9403-4d28-c082-08dc2d967554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	PxkNf/n78gep1YrCMFcIGGKyqUwaEhD2dqMLXgMWi2ewNK+Ko8gMALHg7Npfrmh+FyWn8Vu92+1xABIy525WiJkPFtxTX+Sm/nymEefxIN6kVHIviA0RyOAZ45oTGahUF82nG+QVq9eaikANPvM2ue9QJDCRTMCrhSEnaosEBMKXZZAl+SmJeUXrV5pBNkqy4dGOGjfHcEuejuh0NcmQkywWDudkKMRa16SZ8wMaEfZJX2GRNAqYInD13RgeklTaFo+zBLhdLpNwHeyTRI+DwvJayHrXKJj5G9gicufqZVvIOUnK4D0E5G9c+WzXs6J0WYKdb2oBKt9vU8hxK3rsdH6fPeFkSH18ll266nUAd9Kt0B46SBSY05Ax4UyD8CmsTm5lwa67gWZ1ah8rXhr8j/H0ypCMj8Ex3KCWljsoXhtNpTiEI1UwY5UbBk0/ahz7M+nW3VtrdJsHpA+O1tmZjRAqgmJJ+xjPJ+45zfXklLV6FT31NNSDKKSg6ZXwJhWdChoOdCZokDPgnzmesn95lp/nv9Ba65LENX7s3B0pa9HHgnUJ012BbV0txwU6tel4
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4684.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(54906003)(6916009)(316002)(41300700001)(31686004)(2906002)(4326008)(15650500001)(86362001)(66556008)(66946007)(8676002)(83380400001)(31696002)(5660300002)(44832011)(478600001)(36756003)(6512007)(53546011)(6666004)(6486002)(66476007)(36916002)(26005)(6506007)(2616005)(38100700002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eVp6Vys4eWdtc3pkQ1VIUUxjTU4vMVg0cjk2cE5CSUVCb3Y2aHhwZXlXTTMy?=
 =?utf-8?B?dlB2Y3djNHVnNG11VGQ3OE8xamJZTG1Rd3ZiKzVYMWhHdk5YMXp4UVBsakp3?=
 =?utf-8?B?UkVtcjBXb05udCsvZjhSYnp0aVh0bkVWb0QyTTNFdGZEOGhMZGk0aHF6eXFa?=
 =?utf-8?B?OG01ZW1Zay9zL3BSbmMzbGYrTEVEU0hUVWxZYzA0dzhxRnNmUDB4K3JZS1N4?=
 =?utf-8?B?T2tKUjFNRWdxQ1JCMXJneGt6cWM3akYzUS9ZNlZjVVF0VXZVM2hCNHRIclZW?=
 =?utf-8?B?SzN5bVBxQU0xbHZuK1FoNEk0QlM0RjZvM0IrWmJtMWw5VVBSVW1tOWNKeFN3?=
 =?utf-8?B?TGdVcDNjMUh5ZWFrMkNwWnRNVmlXTDgvUUE4SmpzM1R6V2Nabyt0UkxZSnFo?=
 =?utf-8?B?YlFkdE10bThodEdvWWhNL09rSHVSNVRNZHFxWkdwZnAyUThOaFFQcjdkQ3ZB?=
 =?utf-8?B?SnQvRDh4Wi9sNGVkeDI3V0w2Q0JyT3d0OWxEYkNFRlI4WGUzTnlQK2IxNzVV?=
 =?utf-8?B?Sk5KVjRtZUg5SUhGelFheTRDOVpQK255bjE1MXFQVjkvL1NzcXlvYzEzN3JQ?=
 =?utf-8?B?TGw2SEtrM2ZocnRDN0Mvc1J1M1dzTHV6RzNrT3k4b2hLZ283eE5OZm1kQ0d6?=
 =?utf-8?B?VGhBZnJibVdxUktkSksrRmVoZkxFaFV4K0owRU1GcFg1RGpEbzBQY1RjNHE1?=
 =?utf-8?B?c2pPOEUzWFZEL1NwTExKdXZyOW9ONE5xbHBRUnNVUytVWWl1WWk1MENyT3l2?=
 =?utf-8?B?NGdEdW84K2hRcVRzNDkvTWJaZjhmOVZhb0RtT0lHc1VMRkUxcVpBeHMxcXpG?=
 =?utf-8?B?eks1UnhwTnBydjBPbWdsRlljamFYTzdJeDU5NkZrbWVwYTJTNHVzYmZ2emNP?=
 =?utf-8?B?NWNXV1hOMHZCVk8rYndTVE1wVTMxa2d3S25TOE1UMGNScmZyMTFBc2pzRXNF?=
 =?utf-8?B?TDM4YXg2bFdLNlBmdkl0WitQN0puN0w3TVNmQXYvL216ZTNIZTZjS1RaMVEw?=
 =?utf-8?B?YVJZeVZ0cExJeTVWTFZzUHJ3akJRb1BKK01FbG9va21VVVE4TmE2UWVIR3dS?=
 =?utf-8?B?QzdJM01hTEVzWUdjR05OcU52bnhaNFhXWldzMEdpRk1PUnh1cVcrRHd1WjFE?=
 =?utf-8?B?cHM0Vlg0bEpjREhWbnhnYWUreXFrR1hqQStUM2tMZ1N5enFLVkNiVTZxL2Jj?=
 =?utf-8?B?S0pTcDFuQk5Ga1BWVWVUQ1BHbUpnbjg4NHRwbFBQc0xYTUZSM2I4WlE5eDdF?=
 =?utf-8?B?TDlQbGRMdmFzZ0l4ZkRCMzFhMmF1LytZakJ1ejB3ZTk4cDVtTDZDMGgxNzVX?=
 =?utf-8?B?Rk1VNXVqSEVqTXpzcFhXNm5vS09WMlBmRVdETDQ5MFNPMkVSdUluQjJOMTZW?=
 =?utf-8?B?c3htZ1BUc2o2akp3d3hhRkxEZlBpNjdWdnVMTGs1S3ZEUkl4NVdJZmF0RmVF?=
 =?utf-8?B?Y2Zhd0hxOWZHc3VOd0FVbURFaTNsc3pIZFo5TUxtS2VIOHU0REZKdEJvMGF2?=
 =?utf-8?B?VVhmcFYxTkM4T0NmL3hGWnlZYkZvN1I4M2NpVmt5dXQrYmpKa1RBdEkzWExr?=
 =?utf-8?B?Mm1UMGJkVkRuV3pEcTU3VlhpeEhpd2FOTXhSSzlWTUZuWUlmcUZTcW05cVEy?=
 =?utf-8?B?aTlxcHo1amNIbk9kRXhRSEsvc3RlOHY1SXgzZ0Mza0VwSis2cWJrR1Q5WHkw?=
 =?utf-8?B?TzUwdzVIek9DcHJiOXdFbWZoM2J5ZWUrMlUva3djcVVjNmkyWFQ4NU51ZjBS?=
 =?utf-8?B?bXNWYVhPakJhNStBVGk2WlhIYlhUc09kMEpjck5NTytiOGpvRnZ6blpRZXVJ?=
 =?utf-8?B?MW1qZnJuaXdXc3RGVVRGUldwT21SeGRvcERwRWFST2RwaEl4RVVuWmFpV2Ey?=
 =?utf-8?B?ZDN1cXhlMnNUdXJVZnM3RjNSVmFadWJvbjJXbmJSREUvME9lYW9DamQyU2Zx?=
 =?utf-8?B?dnBMU2pvMG9wSVpaUE16dUM1Z3RENkc3QWlFZE4rQUEwOWxkVzdQa1lnaG1X?=
 =?utf-8?B?OU9lS1duNER6MGUrcXNMNGk0N3RTU2JJU3JMdXBvWkV2QWpreUFjNnhWVlR0?=
 =?utf-8?B?T2JYRXVKSkF1K0k5c1JTM0tyYUVoUE1FNE1hWEtXeVgxT3VaZ0djTXNiRnV0?=
 =?utf-8?B?Yk1STWZ3TzVHSHJWRm5TQkUwSDB4eUw4ZVF1RkprcmJJRWx4S2Y4UHZDelln?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	R7Mi7naTI90njtzvt7Y7HE8egr9LZLezW3+m4D9QFDCTg82VNqFKDgXkz/Vc9DH3LGwur+dY8rLjd9SdlWeDmyPRLa7DGz7vR341hVoALh1+/38rRrOcKzpwChlzSPoZ6gwRE7DY5HHCqme12xLu0p2+foUyPgYBp49ojvRPVWXnpaZ98s+0Wt3hENB44lLlklMJjxjedv+Ox2qypztwPwdHgZ66HxzREQNOrnwODNaTPsfK++zDpxTw5MO7RUAN0C2WggjSRgkZNLjf35FMbRh39Nzd4uToTy/r+zaX0FkCQiATCChEyTo5fjOGgqbcN1uEhqEAxdKVqmYLh9Tf+dNecFD3XSczIers9EgEnc8SPdfNS4XBABuqax1oIFXqj1eEfuLcN14MAirB/qJeRkrTo5Qq/YzYduAhpNyfjRbQiQTj3/bkbKJvWsp0UVTytUUCkRFO6PQFNCBDv82HlOCYkhn6Hphf+QHa8nwJIjZyqhZnngmDPBmydF/9HyXEnqRMEQic5CwSIu8gSU5H+32vHMEf98d8l826jAZfPd7IZK64+IpuJJpmvBPppltL4ZAxvlNVqU7ZUkK6gtxHKUNOIRN7p1Iz0377Y1++npA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3fc4e6-9403-4d28-c082-08dc2d967554
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 19:52:21.7984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cufAh9D5yDz/ojoU2P8jzCVM/1eeLaln1VjdtoUSihCn1kz8gjw3EJCyImtDujCgZFwmSoT++iW9o3sq9m2ULpJkDhfhk7vH3tUVX0jTRog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_12,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402140155
X-Proofpoint-ORIG-GUID: FHtyLBdd1A86l6-GCG337CDpejLZpFlN
X-Proofpoint-GUID: FHtyLBdd1A86l6-GCG337CDpejLZpFlN

On 2/14/2024 2:39 PM, Eugenio Perez Martin wrote:
> On Wed, Feb 14, 2024 at 6:50 PM Steven Sistare
> <steven.sistare@oracle.com> wrote:
>>
>> On 2/13/2024 11:10 AM, Eugenio Perez Martin wrote:
>>> On Mon, Feb 12, 2024 at 6:16 PM Steve Sistare <steven.sistare@oracle.com> wrote:
>>>>
>>>> Flush to guarantee no workers are running when suspend returns.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 13 +++++++++++++
>>>>  1 file changed, 13 insertions(+)
>>>>
>>>> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>>> index be2925d0d283..a662b90357c3 100644
>>>> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>>> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>>>> @@ -74,6 +74,17 @@ static void vdpasim_worker_change_mm_sync(struct vdpasim *vdpasim,
>>>>         kthread_flush_work(work);
>>>>  }
>>>>
>>>> +static void flush_work_fn(struct kthread_work *work) {}
>>>> +
>>>> +static void vdpasim_flush_work(struct vdpasim *vdpasim)
>>>> +{
>>>> +       struct kthread_work work;
>>>> +
>>>> +       kthread_init_work(&work, flush_work_fn);
>>>
>>> If the work is already queued, doesn't it break the linked list
>>> because of the memset in kthread_init_work?
>>
>> work is a local variable.  It completes before vdpasim_flush_work returns,
>> thus is never already queued on entry to vdpasim_flush_work.
>> Am I missing your point?
> 
> No, sorry, I was the one missing that. Thanks for explaining it :)!
> 
> I'm not so used to the kthread queue, but why not calling
> kthread_flush_work on vdpasim->work directly?

vdpasim->work is not the only work posted to vdpasim->worker; see 
vdpasim_worker_change_mm_sync.  Posting a new no-op work guarantees
they are all flushed.

- Steve

>>>> +       kthread_queue_work(vdpasim->worker, &work);
>>>> +       kthread_flush_work(&work);
>>>> +}
>>>> +
>>>>  static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
>>>>  {
>>>>         return container_of(vdpa, struct vdpasim, vdpa);
>>>> @@ -511,6 +522,8 @@ static int vdpasim_suspend(struct vdpa_device *vdpa)
>>>>         vdpasim->running = false;
>>>>         mutex_unlock(&vdpasim->mutex);
>>>>
>>>> +       vdpasim_flush_work(vdpasim);
>>>
>>> Do we need to protect the case where vdpasim_kick_vq and
>>> vdpasim_suspend are called "at the same time"? Correct userland should
>>> not be doing it but buggy or mailious could be. Just calling
>>> vdpasim_flush_work with the mutex acquired would solve the issue,
>>> doesn't it?
>>
>> Good catch.  I need to serialize access to vdpasim->running plus the worker queue
>> in these two functions.  vdpasim_kick_vq currently takes no locks. In case it is called
>> from non-task contexts, I should define a new spinlock to be acquired in both functions.
>>
>> - Steve
>>
> 


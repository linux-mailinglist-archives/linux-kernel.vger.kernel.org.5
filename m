Return-Path: <linux-kernel+bounces-28543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA4582FFE6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DF9EB24B40
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 05:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9BE79DC;
	Wed, 17 Jan 2024 05:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="BEDRbJrm"
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20A87465;
	Wed, 17 Jan 2024 05:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705470066; cv=fail; b=g0rDF8t2GwQfE3qILLE7y2zNJ2XIShOGitTKQYkviwfeYSFcsNbF1/9+pGM+dj0uLxUq0pCzEnookTnjhkCOrUVR0A3RhI26ZFXMKVz44qImh9XM/qUN0G0nk9a4RyDljyLeyJl4EJ+gEvYmtqfjRt4nWhqthABcC2b2pV3n9N4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705470066; c=relaxed/simple;
	bh=lLIbIN3euoi3sXfxPxN5i5X5Cj9NRGzjOOOgJfAZRKQ=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:Received:Received:
	 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:user-agent:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=HfIVpbwIVWf5KUMEw7BQ4hMTj8kkQzGJLeyDxwE3Z/WjbNEiwO3U6GeGj7ZWhISRa5cp0lkEjld660XM8qMHVP84rwrcoybyj7NrHpAJ5SFxKgT6shn0OuuCRnN+PfuIra9Uv20g1PwRT/fX/GC1gYT+ByQVMTmFU0dADzzb9Jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=BEDRbJrm; arc=fail smtp.client-ip=68.232.156.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1705470062; x=1737006062;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lLIbIN3euoi3sXfxPxN5i5X5Cj9NRGzjOOOgJfAZRKQ=;
  b=BEDRbJrmuJwRLEBCyIGp0ig0s3m4r2qyXS3Q3oGAX3cgDmTGhaD7t4c8
   QjilAM8X33XjghDUq1CJv6e1zoLTmH+o0tt3bc5q+RntavssyCW5XVPKQ
   1yKEWOGH1pQNt6K9/IOItKgekpQrDGVjEzJ0FHxx+TW+Gi//RyWsA4d7v
   gwom6yO3sCQ5OueKrnX+5aA1enSnUN0KV+hzrRUwVABobfwl6LmVXnAND
   r5UVOHTYCk6vNtK1dWjU2xrVduKMe2vG9inK8MvVmLfMXsnSzAOf4qWlh
   NiTBi7uPllmoftT1U0Lzyb/UQLsOzZ2dQQqmE+2CAiy94qRHujcfAtiqh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="108592321"
X-IronPort-AV: E=Sophos;i="6.05,200,1701097200"; 
   d="scan'208";a="108592321"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 14:39:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ES1qbChi7+ng5PosQmTVy/1vAwpGkR1d8fgvmzVMhJbSEV4BSIIgP2J7vAX+lH0cJohrxRLN47e6wuz1hVutAlYQKEkosIISB0l2ufoMhdJ71XjLNzFRuiQAEvW2AAOIaIpJTvwOAQmB3lqITGcrYFODHOUjNqlSSKtBkrhCNE9XIRnPH5n6Q/ueRjvkdXI2WjWeseuEPevfbf1VHYeu4BCVjS4kJnSP1zYssJ6aJfeY2ZjulwBrd3hZMmII7wgQzByfjjCSThQCBIAEGwgsKIGLqa2g1pPzU9LTqZP00ciyTnAMEAGROGSrGwilDppEQqXaqByVxsyNxTXD4oTR3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLIbIN3euoi3sXfxPxN5i5X5Cj9NRGzjOOOgJfAZRKQ=;
 b=eH7V7Mdl6wvF0Y/0OJfEPQ9FGf2WorZByLfwgDhIXmtpi0lFGJDpQebdQfwZeWvhH24nWAChrvZveaHH0kytlj6Y9OkstWJtlAbNGl4zGy5mNz2HCFBMeq+inuLFX36wvMQ/iL+4TJ2HKPfyfBArgV1BnOsB6YAwz4gQ962lPAdi/b7Lp5uIg/pXV3M+seHJuQ4osTsVD8ArfSatChHYk/uS6esrHDdacECPgZEhTLfvMd5gCRN4J7g8mNPFcFZJJQ4jE428Fi1QW6ioxIkBTVz4aZDgSGdSsaIQK9df/0F5JdR5mCkdT2J8zqD16NJcWaKpy0FZElyTy2aP/UUrgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TYAPR01MB5787.jpnprd01.prod.outlook.com (2603:1096:404:8056::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 05:39:46 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::c96f:52b0:dd4e:8d50]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::c96f:52b0:dd4e:8d50%6]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 05:39:46 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Richard
 Cochran <richardcochran@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH 15/42] drivers/ptp: Convert snprintf to sysfs_emit
Thread-Topic: [PATCH 15/42] drivers/ptp: Convert snprintf to sysfs_emit
Thread-Index: AQHaSDfKq4UVG5RABUyqD6L9r7IuSLDckjMAgADsgwA=
Date: Wed, 17 Jan 2024 05:39:46 +0000
Message-ID: <9b5866e1-98cc-42a9-9cd6-f89927c79bab@fujitsu.com>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-13-lizhijian@fujitsu.com>
 <20240116073314.09dc408c@kernel.org>
In-Reply-To: <20240116073314.09dc408c@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TYAPR01MB5787:EE_
x-ms-office365-filtering-correlation-id: a9271dc9-b4fa-421e-59c5-08dc171eb6ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6g8gXVEtS8zucE/u5Yo3BWiP61uxc7uuFWFaLt1oGezoTchLb6eoFkUAwOto/NhBBeAG1FLGAkJpm7xO3/7H42yr1lHPjFpxMkwJR9stYaWgOJsfAdxGLvDVJgTXzvPoHeqmJeoV1BwXQx+n5n2ke0DPEbhSWBQ8A+kvJhAjpxardZzCPMxv+xHctH/k9drGvYxd4vyEIw9v3ksU1+sTgtNpAC/3h/dlkl9yCVRhbRP+WU28csIfaurSRsC9rWOQc/xc26sLuQwzoHvwKOGKMmw2DQt72VGbUC9+JVdrWEgTpozA7BOlKVrEpVOwN1PFa0EBosrqM0s7O61fq3yTzsJW+6uo2Tr97Sjw76VDo3nXVBlxZWCF/ux4GZpXlqRxb7M/WJ6f3QaMJ/VBQuIAO2pYosKEqKyQHTuRYHwJbZ4Ehhimk4UgDEx0i9fzvktYhg6AdBjy+544RiNN1uJ8vGiY1R1LsRaSw65xOg0F4Jg3j/PIOdFZ1Lj7v5jIts/RPTzj+7yW40YN2VjRzKSJBo1VgniOix7x+MNOz/z1GYtfAkZkISXkydDBQI3LaGtssi4twfN1xu634tNX8FbPBod2BRAjGcPIo9XQ0azcInLPY1k5lfyHnvCAX4EIQA4fvGanHCZ0jWj4pdSrN1MPkg7XnCPigsIghJ8bhr7TqsmDgX2dD532oAWYIa+rxZHjHWgVuHp9BqLx10NCkP7pA7sHRQcBRpXCZZnfrWzw2YI/UmeLpd8Hy1/vvz2UC6TJ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(366004)(136003)(230922051799003)(230173577357003)(230273577357003)(64100799003)(1800799012)(186009)(1590799021)(451199024)(122000001)(1580799018)(38100700002)(31696002)(38070700009)(85182001)(36756003)(41300700001)(86362001)(82960400001)(26005)(31686004)(83380400001)(91956017)(71200400001)(76116006)(6512007)(53546011)(316002)(6506007)(64756008)(54906003)(66446008)(6916009)(66476007)(66946007)(66556008)(478600001)(6486002)(4326008)(2616005)(8936002)(8676002)(5660300002)(2906002)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?djB2NFlDKys1WVhPTHlGM2UzR1MrYmwxa2RMZEhMa3FNelMwYjBGUjIvUEg0?=
 =?utf-8?B?bzg5TkswM2ZQSFVQT1ZhdUcrWnJNSFIxQnN6a3d1TEthVmJ1TStaYkMxNWl2?=
 =?utf-8?B?aUs5cm9QeWRodTJvT2tVbDE3clFYanB3UDBVYlpSNTlLRzhBc3VKbU9hQm1l?=
 =?utf-8?B?SjJ5blJMTTRyRHdGUG5KVXJEb09WOW9UQXp3dlBvL0pocjhmOW81aWsxWXNl?=
 =?utf-8?B?Y1ZHcXFBVXYrTzhEN252cWlLMG5adXcxV2NYTGJyMjVvUnQyS0FtUzZXdmZQ?=
 =?utf-8?B?Rk5PZU5Hb1hDdFdjZHBTWXhCWVVxSG1TVlY2MWdETjFmUHJuMElmT2pSakhP?=
 =?utf-8?B?akRta3RRYVM1N3ZEVWJiUFFXWnYva0xMci9pZVA3SG1KQmNVVjlHOWVoQTJI?=
 =?utf-8?B?MGp4MHhiSGREenI5TlI3UVVLRG9BcWp1YytFVHpoUExQR1BLWkc4MTFiN094?=
 =?utf-8?B?OGhjcUtHcE9INzc0ZVJYQkgvNW80azMrdDRzV0x0cFhaQTdiK0tZY0t6R0dY?=
 =?utf-8?B?WlVJdit3YS9XZmVsaWlpVit3SEdJOWxMNjUxZE9Fb0JLancySm5OQmpheUhQ?=
 =?utf-8?B?ZDlGNXdhUzJSeFMveURHSld6TzMwa2NQalQzWkU0Z3Zrc1Q4ME9HTnRBcnY4?=
 =?utf-8?B?RmhybUpkQkZuKzlGVjRBaFpqbU5MN2tBU1AwRk5FR3lzQUpqaElVNSt2enBW?=
 =?utf-8?B?SU5EVkt5QlI3TzJoSDhNcGNaRktNSlhhdURnWkJvS0s0blhOUGQ1WmhCc3NM?=
 =?utf-8?B?b2tRakQ0d2YxeEx2R09kS3Q0MDJLNmZGU1JEZk11V2R2S0F2T1FXYmlNS1I3?=
 =?utf-8?B?dnRwM3p6UFVmVDgvdUV5bitXTmVKT0hXQ3M4Sm5CTXZIR3daMWttOW1rTUJ3?=
 =?utf-8?B?dXJXZTFiQ0VnVFpPV0EwNXB6aE9sYStqZE1qR21jcllndzlzTG5SWXNTVTE0?=
 =?utf-8?B?dXZFcWlBd1pacElUNkswWDVYVTFiY1BpT016cVlYRDE4QXdzMlA3UWFBR1Ux?=
 =?utf-8?B?WTlKN2xGUzc2dEI2RUhCUnVQQ2JPekFYNE1pM1E3NURtTjFQSklMU0NkU0pH?=
 =?utf-8?B?bVdBd2RhNXRLSThnOXNnVzh0SmRCNDNxUFBabU5FNlR2TUFLTDQzd1lsVFhY?=
 =?utf-8?B?OWs5WUVFeFl4WGx4L2l4akZWZ0pPaHBjSktwL1IxQXI5UHFlbVNJNEgxUHNo?=
 =?utf-8?B?amNWc0M4KzZKUTZJWWoxbHhHNEtTVkNnQ1hqYzl4NTBNYkh1Z29INHR2cldk?=
 =?utf-8?B?ZCt4dW9MRlJmSG1KVDh2R3N0Y1hqSHpZcVB4cWRhWlVEU2poL0tkMVhkc3BP?=
 =?utf-8?B?SDc2MEZOWS9xY0lRRTN5Q2RvNjdRTkZwei9BcVNMbWZjVG9tbCtmempJMXll?=
 =?utf-8?B?dTlGdXZ2RGxrTU92R2tOZzVvTEUxTks4cXRtVjY1TVBYVTArdUszWVlKZDlC?=
 =?utf-8?B?T2Y4N29RMHVIWFNaYkFSSDdFSVNmWWtsZVN2OWlBZ2hWRFQxcVlsUnBJM3JU?=
 =?utf-8?B?dkR5VlRlMEdWb2VaS1ZDdWh5QWdqMGFXYnhneVIvajBkUkVjUDVpVTVhRllu?=
 =?utf-8?B?L0pQajJ4KzkvajNGVmxHUERrNXRvdWNhRkdlc05IdnpidHJEMzZNdEQrNWsx?=
 =?utf-8?B?RHMyMUhBVWFsdUE0a1BBTzJVNXM1VHZtTThKTDRxa3BkOUN2VFNkS2oxNXFC?=
 =?utf-8?B?Q215b1BSNm1ObkJCVVNaYWJzcnM4ckJ5WnNBR3BDOVFJNDF1RnFjaTZrdE1h?=
 =?utf-8?B?dE5rblZHZUJpTmkyODdjSU5yVlZ2ckMwYmhXZ1BSNURnWWw1clJYR0M0ZG0z?=
 =?utf-8?B?Z2o4Sm5xOVk4OTlPT0ZMa2l5TStYMU5RaEs0bEp3ZnpTVmxFWlhLL3pQbE54?=
 =?utf-8?B?enVJaDRyR1pIdjlESHRhbTdLWTJGb3h4aGVzQVc5cGsrZFdlU1JJWXlqd2ow?=
 =?utf-8?B?WG5ZaU85WEZ4SXM2S1FPOVNjWDROUVNSdjlmUG82YWtWVlhEbDFyZmJXaFU3?=
 =?utf-8?B?OWJVWUJBcWtTVmFvZ2w3ekxKWURhajdBMmNERkZNTkZIcjNFVitVcnN5R1p6?=
 =?utf-8?B?eDVCRWcwZFNkZm85K3dBajBYeC9KN2tMajd5OWdSTFN0RmhJWUVDQm5acnZ2?=
 =?utf-8?B?Wll4UDE5UFlxZEc1aWFPODFsSEVzN09NRHZ6ekFvTXFXaVdGWXVRaVNKd3o1?=
 =?utf-8?B?ZXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9944C5649B27624B9A97ECF82C76DE36@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kfOaeccPKdJB0ch3jR07r/ymMKi9mHNq0ZscbMbdj3IUnEcRdXVUNmgRZ9K4ie/qTIS7sf5qEJ82PFuEOb0O+cNbbZtbfzBB6vyRopa33t3HvmJNHmivE8cl9VSM3h9WDH4E8h00U4D6XqsLVg0+pEA7F4O6+sT+2UQWdtCacL8HR/JMVD1pq2BfciZ9u2ilTZTj6W/sdVkenXLzynegBLpKFsIZFVawZYZHRb5VtJVQDhHnNp6qcC563NYIPFDp4qPW+3sN7TRZ7L38CIw73gpop7m4PN119KTqP6QQiNSU81bDGgNfrfov6oYawDrKf7atLgP9JFqF+8MM5Byv6P/p5RMxcWJQj6CTlwVtoZlgMImvB6DBppIDA3R4RTfqPDDhz7QX70uzLhmzMRvmdo7h0JVnElvIdMU3u6PnLWBkgDFLmEzwpla/jlnoiTgwBAqplekIKUNqsr0ThVCT9uhcngGpXBq7bvklNL4/oyGirOsrMgNQKm79OZpM1oQQXDBt57kgmLuZb5rZLtWTODtGmjgRbXwN6T1PDKni7JuTNW0GrSOX2Pl1dZ3ZK1sI7iEWGPTitqSH1HCtQtd3q4yIFfaGPrxs8g6FNogrVe4DUyE+D2b+1eR2zhKw+EFs
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9271dc9-b4fa-421e-59c5-08dc171eb6ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 05:39:46.0444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 979SympEsTYImV18aVeGIseUA4bX5sig7pXZX3pD6zTScvpCuM+ecdCIgM07JkAGWWSH+CXL2iHuSsM/eJbCsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5787

SmFrdWIsDQoNCg0KT24gMTYvMDEvMjAyNCAyMzozMywgSmFrdWIgS2ljaW5za2kgd3JvdGU6DQo+
IE9uIFR1ZSwgMTYgSmFuIDIwMjQgMTI6NTE6MjQgKzA4MDAgTGkgWmhpamlhbiB3cm90ZToNCj4+
IFBlciBmaWxlc3lzdGVtcy9zeXNmcy5yc3QsIHNob3coKSBzaG91bGQgb25seSB1c2Ugc3lzZnNf
ZW1pdCgpDQo+PiBvciBzeXNmc19lbWl0X2F0KCkgd2hlbiBmb3JtYXR0aW5nIHRoZSB2YWx1ZSB0
byBiZSByZXR1cm5lZCB0byB1c2VyIHNwYWNlLg0KPj4NCj4+IGNvY2NpbmVsbGUgY29tcGxhaW5z
IHRoYXQgdGhlcmUgYXJlIHN0aWxsIGEgY291cGxlIG9mIGZ1bmN0aW9ucyB0aGF0IHVzZQ0KPj4g
c25wcmludGYoKS4gQ29udmVydCB0aGVtIHRvIHN5c2ZzX2VtaXQoKS4NCj4+DQo+Pj4gLi9kcml2
ZXJzL3B0cC9wdHBfc3lzZnMuYzoyNzo4LTE2OiBXQVJOSU5HOiBwbGVhc2UgdXNlIHN5c2ZzX2Vt
aXQNCj4gDQo+IElmIHRoZSBwYXRjaGVzIGRvbid0IGRlcGVuZCBvbiBlYWNoIG90aGVyIHBsZWFz
ZSBwb3N0IHRoZW0gc2VwYXJhdGVseS4NCj4gU2VyaWVzIHNob3VsZCBvbmx5IGJlIHVzZWQgaWYg
dGhlcmUgYXJlIGRlcGVuZGVuY2llcyBhbmQgdGhlIHNhbWUNCj4gbWFpbnRhaW5lciBpcyBleHBl
Y3RlZCB0byBhcHBseSBhbGwgcGF0Y2hlcz4gDQo+IFRoZSBwdHAgY2hhbmdlIHNob3VsZCBiZSBy
ZXBvc3RlZCBhZnRlciB0aGUgbWVyZ2Ugd2luZG93LCB3ZSBkb24ndCB0YWtlDQo+IGNsZWFudXBz
IGR1cmluZyB0aGUgbWVyZ2Ugd2luZG93Lg0KDQpVbmRlcnN0b29kLiBpIHdpbGwgc3BsaXQgdGhl
bSBwZXIgc3Vic3lzdGVtL21haW50YWluZXIgYW5kIHJlcG9zdCB0aGVtDQpzZXBhcmF0ZWx5IGFm
dGVyIHRoZSBtZXJnZSB3aW5kb3cuDQoNCg0KVGhhbmtzDQpaaGlqaWFuDQoNCihHcm91cGluZyB0
aGVtIGludG8gdGhlIHNhbWUgc2V0IGhlbHBlZCB1cyBoYXZlIGFuIG92ZXJ2aWV3IG9mIHRoaXMg
d2FybmluZy4pDQoNCg==


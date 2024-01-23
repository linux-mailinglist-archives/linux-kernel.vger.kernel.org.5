Return-Path: <linux-kernel+bounces-34943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E63983898D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F130328C21A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3FC5732A;
	Tue, 23 Jan 2024 08:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Nz8hb4x7"
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9BD56752
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705999804; cv=fail; b=ElOhBME0wTh6lBa/e9ZG3L5kFmbww09gdYkQy4Misz5U2S3xyZIdXq5sjjBmTPCtq5dXhVLkRkNQReN342JAXrJ6CZ6qCXjOfm5FmLH0kHBHxR4TNIzvqxT87DJRfnnJ2SCvMY2MtsZ9ayY7KB51UWHWdZVk/avjHLWP05vv/YI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705999804; c=relaxed/simple;
	bh=yKPnWTMiwcNP7JWMwQ8OTe1KPgpUNK4JSl0x6eoQpxE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DGDD4nWg7QiOEk1FGIXsgly8H01YVknJfQN+eegYl6ARpfvQw4ra0t+KJW0kby7CKMPOtmB6LJPMfmFVArz0dIoXhiS9fYrAA5g5eN1M1gXwp5AZlakJ7FQHBu9l623/2OCw+MTqaiGKHFAF8D6goiLgDqmr9Zw83uQsNOp7aD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=Nz8hb4x7; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40N8Rbc6032165;
	Tue, 23 Jan 2024 08:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=yKPnWTMiwcNP7JWMwQ8OTe1KPgpUNK4JSl0x6eoQpxE=;
 b=Nz8hb4x7fySxiy5DjjizKLJhGTGhEj1IV0cpzwiIoLsemP76qIt+B6/LJV2maJV/whb8
 tWHrbjh8ZPY5KpZM2lAsxwIvdvptRMT47fMb8Xtv3bFNcilb/p2I8Griu+AP98hl5nlP
 5JCJwWPkHFYCy1PYCUWa2kkLJVr5/JTo6IkqpUDYLfMtslN9547WpINZQOV4hLd7p46U
 DofZjgIC2seb3/Ubv4bEnOPbBc1UpF1VWXXmoFXgs8cu/X6rMHuqpIWFOhSGWMFG9klr
 IJbLuWsEES6xvOe/T4FNyYz8lKyWRi4x5u9Q8ByNbsXexYqf8vhAob9zJ3dRgmdUtI0k Cw== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2040.outbound.protection.outlook.com [104.47.110.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3vr7hmtvs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 08:49:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwwx0bvxwlmtTGAiTUD0h3INOsMUGISqZ4tSin9NijI8sVGGKJYO5s3CEgZ22VXfjelCkZ39043IVfuDdgNTVdB9qyDNfMrmBO0i4iwl+W8PnYQ5sk1/5fi1waDUANhFUcmt7Sr81UJM6pvFPTC5nsx6wcAadu86FIWnQq5SdnQ2wThTTYfiSltyExBA44BBnbuVb6qDoIAHVsxkMSzsQYM6nHyEBVO8C7pITt4TvAi9EFyI8fxExSN9j8hlNpPh4wkC03YLah5evZBW1fq2MFMg3QF9IvvGSl+J0NmBrU1/jGQ2BXGErWgiTRAdrb+gaCPYnd/dZV73vEakn3imwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKPnWTMiwcNP7JWMwQ8OTe1KPgpUNK4JSl0x6eoQpxE=;
 b=MMrEpFQqKEKkmzlrQvZChvsXynJoR+xHMRB+IETPereZN4/UqiCzT1jm34/PaZWDbY9G8p88ehibVv/M944K3CE6wq1ZPdzXJbLHM73W8t2YBxhuWMqW6YkpmtS/S0bB6ILe22LLUa7H3qxsgxkke0r/e4HDhZilh1gejWV5udHYCIKjZVRGJ24NmYpp9BMq9O2wAN4svocxXsPjQnO0Viva8z4O3X53MNltK4iEvwLVIjwdnuZCYYPPQvUgCdnzLErvmKyJXGmXALBbEPfrYdbgAlWNkCS8jC8xkBczaxffhcpvcT3qX/eAsDf0uEmGdPQBVLb5btVmNbABP7yKng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR04MB8172.apcprd04.prod.outlook.com (2603:1096:820:13f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 08:49:16 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::f0fc:7116:6105:88b2]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::f0fc:7116:6105:88b2%6]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 08:49:16 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: David Hildenbrand <david@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Ryan Roberts
	<ryan.roberts@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton
	<akpm@linux-foundation.org>
Subject: RE: [PATCH v1] mm/memory: fix folio_set_dirty() vs.
 folio_mark_dirty() in zap_pte_range()
Thread-Topic: [PATCH v1] mm/memory: fix folio_set_dirty() vs.
 folio_mark_dirty() in zap_pte_range()
Thread-Index: AQGBQBz0FTRFVn8YiQNky+4MIo0Z1rGZL0uw
Date: Tue, 23 Jan 2024 08:49:16 +0000
Message-ID: 
 <PUZPR04MB6316745B9234C3B5781AEA1381742@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20240122171751.272074-1-david@redhat.com>
In-Reply-To: <20240122171751.272074-1-david@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR04MB8172:EE_
x-ms-office365-filtering-correlation-id: 4e74cf9a-c349-4278-ee50-08dc1bf02e56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 IQgkfjCqLlxjnd/N06p1ToNjK0pMuQk9hYmiYTQxkZOYTsT9xKuulAHGAvwoS8aMUQDGSNpFJg6zQAD/Zts1HVZW6PjazVit5fxhmAtF++GSLCrz7Buqaip+HXTFR+yHEC645GLNBFegXvQdh3OfP8hC4DGV7QQMKYfNYW1RcO1WW+9zdSExcFxOhMNjKwpteC/aYIQXZxNjgQj7ixj4Cs3KX3ZkKbX9OKS2KhB9fi6+l24F2yEU9yDbcP/5lyMmV1DEBCRLZ1uVwARzC+Zfuspdc7hag4R59M0DQ9WBE01oeX8+EwrCcWJP61CQ9ec7dJ9zgG+NE92Tspl96D8o+0kiJaGfNmZpkAqxM1x/z/aaJYHE4di2UfjLlPW7X8ziN2Fo7eeg6NDWZwO16By5ml75+vYjGSNZfLSVYL7Ioe2ju7AjGXoX6FH1ba2Uxrc19klByuSOLuJDdD7orcfVSculFYpISyy2eXF/YFMoabOi4HDK73pJm1dmSbaMvwlQ/Ur3ZZEIZIIDO6R4UGBftYjHBQCM29ATE34MlN9lvXJL/7SEkruNwQgGDuj0v8YAPqKHByQiJ51x1DxhCbsYQuQfccWweA5YNNABg9aFXQabGpj2qY7T9OodluGjZL/Z
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(110136005)(76116006)(478600001)(41300700001)(86362001)(2906002)(71200400001)(66446008)(64756008)(66556008)(54906003)(66476007)(66946007)(38100700002)(316002)(82960400001)(7696005)(9686003)(53546011)(6506007)(966005)(26005)(8676002)(8936002)(33656002)(122000001)(52536014)(4326008)(38070700009)(55016003)(83380400001)(5660300002)(14143004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?K24xL0oyaDJ3eDBPTHI3VEFRWmNhY3hPWlpWaXZpSURXbDhJalVuOWcvWXVx?=
 =?utf-8?B?YnFFMmtiRFRydThZdXBqSkpSVWF0Y1NNR3pmMHphQzA0VDRoNFFuS2tXTnAw?=
 =?utf-8?B?Uzg4TEJsUGxlQXFuWk1iTVY3dkIrS1hsQ250N2gvRElybmx0VkJySC8wWndJ?=
 =?utf-8?B?V0tiVEtGbGxmQmE0WDk4OEJOYmM2bEVUY2pWTEhlQmVHeHdHYU8vR3RRNEo2?=
 =?utf-8?B?dGdLTGFNM0pkME13aTc0Q0gvNy9hMkNhd2dJaWNxYlJ3RzJHczg4TGp2Mk9H?=
 =?utf-8?B?MWczT1U2RWZwdlViS216VFdLUDZOc2ZhREpsRmtIajJGcjVTN1c4Rk04UWlv?=
 =?utf-8?B?VktlUUU0QjhRMzlWRHJReFA5NGUvOWR6dS9qVHhNNStqVG5DVUhXRkdWakha?=
 =?utf-8?B?N01aNlVBRzFHTEV5MVBCQlRKb2krbWhsUGdhYkZiaEhhdEZEN3FBVnpaTzEr?=
 =?utf-8?B?eHczYUEvcEZFUk5ZTmNFY1g4TVhHRTFYK3A3MEJYMXV3UVg5SmNTdVVELzJW?=
 =?utf-8?B?eGpYM1A3TUtQbHdzRHgxRzh4OHhxbTBHaWdialJ3YU5hb1NRcFIyOEdnL0dJ?=
 =?utf-8?B?UjdpdXp0dUprS1BwWVBJcjF0Ry9VM3VYRGNqaUdkWGpVZ3dyK090ZmhjaHZJ?=
 =?utf-8?B?Mzl2Yml3MmhhT0xqUjRvRVFZZDhaZGlScXRmalU5RXQyREJZZHkrY0xyS0k2?=
 =?utf-8?B?YUptMWsyRUZNcTF6NHhuUk1nMjBrd1NtRitJd2ZOSDBaWGxCL3NiL1F2Y3VS?=
 =?utf-8?B?TkhEQ09IOStpb1QxbnhMa3ZSeHBxbjBtTUlmdnNMMzBTZk53cjcwTmVDUGVa?=
 =?utf-8?B?NStha1ZldmVzeDZBMU9yelNZT2pCRlRKUWVQZU52VFJRZ0hlRTNXNXJVeHBO?=
 =?utf-8?B?d3JDelZJRk41YWlEMWYwNTZDMy9SbkdrdTl2Tkt6ZFdhNkdmakowbUl2STZO?=
 =?utf-8?B?a3VFL3pBYUtBbXlCMHgvUUtVd0RVbExaaGFoa0hXK3pTYlg4T2VpWUorSjZv?=
 =?utf-8?B?RzNxN3h1YnIzTno3cmNwWWpJS3diWXZhV3IzTW5yZVIrL1VHZlAvWnlxU2c1?=
 =?utf-8?B?VVVCaFI5YjRia0l2OGQ2d3d2UWhqczhrNVMzZ2tGR1B5RmFlQkVWSWkvZGpJ?=
 =?utf-8?B?VnFyYUVQSUxqTTJjRU9XRDZleW9rN0pmVERCdkY4L2tFcmZLckkrdGYzY1pJ?=
 =?utf-8?B?dVgzOHhaWlorRjhjNHR0K1cxNGxWcmJtSHYzaHJ4Vm1KVmxFVzAwaUNPSDVy?=
 =?utf-8?B?Y0xxb2xhcjdZTmtwM01lTENOc2xPZkYrR3cvaFFqandIOGRhU2JRclZuS3A1?=
 =?utf-8?B?cE00WXQ2L2kvSzUxY0svRG9uNTlFbS9hbXAyb0ptZm51b3ZEenoybk5rS3Rk?=
 =?utf-8?B?MGxTTUtOUUt4aHFrb1d2R0dxUCtZVmMrcWc3L2xhT1NKeVdaRVg5MnRvbVJo?=
 =?utf-8?B?L3BSalFUckNFT0FSZ1VSWWpKM3g0L1c1a0dwQTVualJDN0RMZy9qSHQyT2dW?=
 =?utf-8?B?VGJNN2VyUDRLRElWamg3UXpBU2VLem5rRmhwY3F3bXR5RmFrc0VJY3NOTjVJ?=
 =?utf-8?B?cFh0bjJ2KzBVLzFZTUVmemNUbzdFbURSVXJ0aHByQ01KNG1DbnpTLzRISW1G?=
 =?utf-8?B?ZjQySGF3WEEyQnczM0Y2bkRNSEtseGpMcktFbkxvSVJBMm1NaTg1R21mYXNr?=
 =?utf-8?B?MjkxaWlTZ2FkWS8vYU1xTnRtUUhiNU1aWWRRV1dSUUl3WDJHRURRa014VzR6?=
 =?utf-8?B?ZjhUN1ZYWDVKQUtkTFdZeDlqUndydThEMkdvZnlXVTU1dlFKa0VQb0dqVFR1?=
 =?utf-8?B?V1k2THFkQ1U3MmJrQU1Md1ZjcDlzZWl5L0ZvbmVXdjNCNGJ0bXhCWVJtODhN?=
 =?utf-8?B?VjJrei81ZzdMak1tNU9kcmlKT29ZeGhLai9EZERMQ1FpaWNrWU9DbXNxQTdM?=
 =?utf-8?B?VmVLcWtvV2YxUDg1bC9HU2x1aGNMUUhRbnlkck9KUit3cFlWMWtLUmFtZC9a?=
 =?utf-8?B?VzY0NzloVFJTTlRMcUZLQjdTTk9NUXQyWlo1RGVidkRQNHdVSElEZkNDYTR3?=
 =?utf-8?B?enJDelRYWi9sTG1sUExrL0tRVFJSNWo1TnFvNUVUUkJKRGlXbWNkQm5rcUlR?=
 =?utf-8?Q?jFuSmpNH26qxPdLFA2UroRX6/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3OLYBGW/HqRl6U/JGx8PsipwomfVorFPNYrP+RBEhLZs6vk3I9KoullbfajaQrZ1r+9GxeA6ltUSh6R+wU894j/F/fC/bMHaRoWzUXl6/Zv9i/FzXHTyAfj+68z3+geQPzFtyaoyE/e/oWWynYKLNqvp2vU4/rdKiVfGdkXq4IcfqbzB1RIbdM6+2Lr2MEqKL+gdG+nY1cujNxSiXirYVOjtYnSQKgCuK1FSo1r4EJfbZVP1DlzOdGDBKlVPYveaBI1Old5aETq8NW3/lrjavPt9QtdWVmsohjmB6DY/Qo3US5vPCrpmsNVaYu1SamLeluVEXR0zr82NAYyPGT+PX5PKLbBiop/ar0ljkiNfNY2hPPx7hBzNueH3RCLM8NwRhNHowfVMLGYrbhfWKDbrZx5HVv1tm3kRrRO2yNaIF7HvIaTryEqKeapXZQ+4UqFc0XAvWeDeZUI6a6EWzfDXPxudpHH4gj5ti0HM2Fb3ZUHhct1l5UUIY2TfIqT1e7KolZQzib2ygyFaWAnb5iKX/BPrlvcJESj0gKHY7Y7plzkk1q00hr7tQ2lUHlTQ7pnOYgUO84iSHy+dWUe8qcryQ51Hq0nqdVepP+yAWnSaVzs7aVSwCtD4YLdT1Uqhu5U5
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e74cf9a-c349-4278-ee50-08dc1bf02e56
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 08:49:16.2761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vae7wnhkDkd7mcoI2AzByOtQdsMBLVpM+c4Fh+QRjygmuR5gvLAxZKw/iaedgVqiDy84SzDWYhowZAWzA2P0dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB8172
X-Proofpoint-GUID: R2C_8XLYyUX96-5pszMNOpO2fai-XC9A
X-Proofpoint-ORIG-GUID: R2C_8XLYyUX96-5pszMNOpO2fai-XC9A
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Sony-Outbound-GUID: R2C_8XLYyUX96-5pszMNOpO2fai-XC9A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_03,2024-01-23_01,2023-05-22_02

UmV2aWV3ZWQtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NCg0KV2l0aG91
dCB0aGlzIGZpeCwgdGVzdGluZyB0aGUgbGF0ZXN0IGV4ZmF0IHdpdGggeGZzdGVzdHMsIHRlc3Qg
Y2FzZXMgZ2VuZXJpYy8wMjkNCmFuZCBnZW5lcmljLzAzMCB3aWxsIGZhaWwuDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogb3duZXItbGludXgtbW1Aa3ZhY2sub3JnIDxv
d25lci1saW51eC1tbUBrdmFjay5vcmc+IE9uIEJlaGFsZg0KPiBPZiBEYXZpZCBIaWxkZW5icmFu
ZA0KPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDIzLCAyMDI0IDE6MTggQU0NCj4gVG86IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LW1tQGt2YWNrLm9yZzsgRGF2aWQg
SGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+OyBSeWFuDQo+IFJvYmVydHMgPHJ5YW4ucm9i
ZXJ0c0Bhcm0uY29tPjsgTWF0dGhldyBXaWxjb3ggPHdpbGx5QGluZnJhZGVhZC5vcmc+Ow0KPiBB
bmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPiBTdWJqZWN0OiBbUEFU
Q0ggdjFdIG1tL21lbW9yeTogZml4IGZvbGlvX3NldF9kaXJ0eSgpIHZzLiBmb2xpb19tYXJrX2Rp
cnR5KCkgaW4NCj4gemFwX3B0ZV9yYW5nZSgpDQo+IA0KPiBUaGUgY29ycmVjdCBmb2xpbyByZXBs
YWNlbWVudCBmb3IgInNldF9wYWdlX2RpcnR5KCkiIGlzDQo+ICJmb2xpb19tYXJrX2RpcnR5KCki
LCBub3QgImZvbGlvX3NldF9kaXJ0eSgpIi4gVXNpbmcgdGhlIGxhdHRlciB3b24ndA0KPiBwcm9w
ZXJseSBpbmZvcm0gdGhlIEZTIHVzaW5nIHRoZSBkaXJ0eV9mb2xpbygpIGNhbGxiYWNrLg0KPiAN
Cj4gVGhpcyBoYXMgYmVlbiBmb3VuZCBieSBjb2RlIGluc3BlY3Rpb24sIGJ1dCBsaWtlbHkgdGhp
cyBjYW4gcmVzdWx0IGluDQo+IHNvbWUgcmVhbCB0cm91YmxlIHdoZW4gemFwcGluZyBkaXJ0eSBQ
VEVzIHRoYXQgcG9pbnQgYXQgY2xlYW4gcGFnZWNhY2hlDQo+IGZvbGlvcy4NCj4gDQo+IFJlcG9y
dGVkLWJ5OiBSeWFuIFJvYmVydHMgPHJ5YW4ucm9iZXJ0c0Bhcm0uY29tPg0KPiBDbG9zZXM6DQo+
IGh0dHBzOi8vbGttbC5rZXJuZWwub3JnL3IvMjQ0NWNlZGItNjFmYi00MjJjLThiZmItY2FmMGEy
YmVlZDYyQGFybS5jb20NCj4gRml4ZXM6IGM0NjI2NTAzMGIwZiAoIm1tL21lbW9yeTogcGFnZV9y
ZW1vdmVfcm1hcCgpIC0+DQo+IGZvbGlvX3JlbW92ZV9ybWFwX3B0ZSgpIikNCj4gQ2M6IE1hdHRo
ZXcgV2lsY294IChPcmFjbGUpIDx3aWxseUBpbmZyYWRlYWQub3JnPg0KPiBDYzogQW5kcmV3IE1v
cnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogRGF2aWQg
SGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+IFJldmlld2VkLWJ5OiBSeWFuIFJvYmVy
dHMgPHJ5YW4ucm9iZXJ0c0Bhcm0uY29tPg0KPiAtLS0NCj4gIG1tL21lbW9yeS5jIHwgMiArLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvbW0vbWVtb3J5LmMgYi9tbS9tZW1vcnkuYw0KPiBpbmRleCA3ZTFmNDg0OTQ2
M2FhLi44OWJjYWUwYjIyNGQ2IDEwMDY0NA0KPiAtLS0gYS9tbS9tZW1vcnkuYw0KPiArKysgYi9t
bS9tZW1vcnkuYw0KPiBAQCAtMTQ2NCw3ICsxNDY0LDcgQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcg
emFwX3B0ZV9yYW5nZShzdHJ1Y3QNCj4gbW11X2dhdGhlciAqdGxiLA0KPiAgCQkJZGVsYXlfcm1h
cCA9IDA7DQo+ICAJCQlpZiAoIWZvbGlvX3Rlc3RfYW5vbihmb2xpbykpIHsNCj4gIAkJCQlpZiAo
cHRlX2RpcnR5KHB0ZW50KSkgew0KPiAtCQkJCQlmb2xpb19zZXRfZGlydHkoZm9saW8pOw0KPiAr
CQkJCQlmb2xpb19tYXJrX2RpcnR5KGZvbGlvKTsNCj4gIAkJCQkJaWYgKHRsYl9kZWxheV9ybWFw
KHRsYikpIHsNCj4gIAkJCQkJCWRlbGF5X3JtYXAgPSAxOw0KPiAgCQkJCQkJZm9yY2VfZmx1c2gg
PSAxOw0K


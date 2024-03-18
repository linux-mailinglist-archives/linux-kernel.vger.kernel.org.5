Return-Path: <linux-kernel+bounces-105897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0420287E62A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E392829B9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59D12D051;
	Mon, 18 Mar 2024 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="lTrCEgR1"
Received: from esa2.fujitsucc.c3s2.iphmx.com (esa2.fujitsucc.c3s2.iphmx.com [68.232.152.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80D82D042;
	Mon, 18 Mar 2024 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.152.246
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754982; cv=fail; b=Xz6RN/tZaM6eJvYgt/5zUPs8zRw9RW5UEEIz8JEnebvhxaUlyivQQWZXkpgshSDVJc8I9E6+pq7PBDSEpzNdr1qemB8DbfkSpvMaKnFRVKNMi9sW3hDLd8m1ch1T6CyfAunmUlKJOuDUw/SP18a6mPFmXnF8S8SCOMj+ZZTsq6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754982; c=relaxed/simple;
	bh=45kMrtx5SYvQ+JlQ6arSKwboxP7BYUz6xrKuzsTYUIA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XEcSusoWQEW+yZ1cLtUEBvL+/iUZtK6BQMBGDNKKMyQFeBWEjufsopPTDnncJxCyZuAyoO36xrgzWXmoeCuLXOJWGvAzyypBMirSJYp/k3cteWPxRg3w1t2OBm4IsUCgMRNMnsDg9p8K2ILbl5UMFjyUq6C5Ax3vwi47q+zUM3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=lTrCEgR1; arc=fail smtp.client-ip=68.232.152.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1710754980; x=1742290980;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=45kMrtx5SYvQ+JlQ6arSKwboxP7BYUz6xrKuzsTYUIA=;
  b=lTrCEgR1663PLkYi3OVoQU/L+z7hwG/VWeI9TStc+gR0eAiay1jMjboN
   35ECi/M3pZRRfWJcdMw9Yl+77Wpgl3eFUk8qUWbJSakDemqjQVp3Q5oQk
   bJCMy8w5EmMGg3tAlViRhn6AYoxloYpECHmUDeNLbsVqJyvbBirGoptXH
   X+wAcmFS/Eo7XvVKUS0ta1VnYvBvvICSQt5WZlEzbvMFoye6Qs7cA0wGG
   wdw7wFwQzQslqoxHAf93Z+yQoEF6vvVHADmOd+/P9SMniLGo232hrmxRE
   xpPzFfRZk9ZkncpY6bOGeegJ9NtC+AgzCnZrmvFltfp1kP4MktYE+KmNo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="25339020"
X-IronPort-AV: E=Sophos;i="6.07,134,1708354800"; 
   d="scan'208";a="25339020"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 18:42:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYfH9IujrK04vLozhK3h1qc5MhJTm3EMU+Jgk7gPTI6U5jIENjTqsg06l9gxmponh4B9V8NP6b8k5cqHD/EHd3QFpqDd47+F4te90E647NUv9XmPkrQm5QeBl1XJzr79CokXGdZjkOxVrz5ej9pMssMD9SudS840rzN2/efCBdqIE7QvOPwVC2iHKZ5iJi+Ns1U5uCcat3XgTPYm+JfnrWqXdg+xTTpncgX18w6rj4E84CmYnowjUVR9gMF79dFcJTh7DJX+poPHNgj4dT0gSEZ3Y5S6gosRgrE+wPa+97xR/NR6ms1e6LOUFHqMQja+aad0ZnDfDeelpRzal1fQPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45kMrtx5SYvQ+JlQ6arSKwboxP7BYUz6xrKuzsTYUIA=;
 b=VoQOeqsKRrJycyYH3syljYA0Wh7daHDVAr3/iycaP6w5ataxIIoeXW4mXjZVATskZQJTG/ccJfsKAo5s4hBteFFMSepVsUPoGlzShOepUe/q4reGgNO8o9R02Wty7LRnQkt/Zy8udWmEK0DlBzRAVctZLvwnWfEZVxfo9FcSZuS/eYzqmrL43yjZAexc838ixCiKYDHmaSSqI6PVfTjzpF/ExwYM33S7O7xEyZY68Bokd6Vxuvi3/pot7uhniLpp0OqjtNVIeoZ36Aj+F58BYFD/yhQaqks3888SfzVnOE7PRH9POMCzQT8vdNNRQX3OuG9+c6iuvpmX3tonOJNbKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 (2603:1096:404:8059::10) by TYCPR01MB10635.jpnprd01.prod.outlook.com
 (2603:1096:400:293::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 09:42:51 +0000
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::c52a:473a:a14f:7f0e]) by TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::c52a:473a:a14f:7f0e%3]) with mapi id 15.20.7386.022; Mon, 18 Mar 2024
 09:42:51 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Kalle Valo <kvalo@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] wifi: ti: Convert sprintf/snprintf to sysfs_emit
Thread-Topic: [PATCH v2 3/3] wifi: ti: Convert sprintf/snprintf to sysfs_emit
Thread-Index: AQHadpz2LFfVLrKDNEacm6j25P7jObE9PODngAAHLYA=
Date: Mon, 18 Mar 2024 09:42:51 +0000
Message-ID: <115f3f2f-310f-4474-bdf6-070d5c30876c@fujitsu.com>
References: <20240315055211.1347548-1-lizhijian@fujitsu.com>
 <20240315055211.1347548-3-lizhijian@fujitsu.com> <87cyrrew7f.fsf@kernel.org>
In-Reply-To: <87cyrrew7f.fsf@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB5818:EE_|TYCPR01MB10635:EE_
x-ms-office365-filtering-correlation-id: 0c393324-d07d-4fc4-920a-08dc472fc775
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xNfjt2WjWEW1t7Ixl7j0WZn9OMX0PnbSNoN/keedWQykrMBezYAa6n7s/KLDQ060tqfNofwT7k7No9WOxJcIHBkW6VQor0K0x2/BJSGErvlnA1inIH+6fFXgSulFYfGH/79kIY7PgrhLhL0ohqmm3bGPx2WfO/RgMMPJIx95w5MR4yrrIh6zOTRzuPzuKqGyXVr/Hnz2bUbHffJcOxEY6Lb4IXUIaAwvFHsf/CBhpxKWoGd7a8tph38EvDC1UiVu6H1K0uARNJ/lf2KPyjgsW89PSth9bYDY0hQZiBbEfzK5mqW1JyzHG7Wayn+1Nkf9jJdouhIZYUOrZRHe4n8tOyJpeKkF7MwsRF6nHSzkC2znIodN956W1FNpU3TEkKlGrCQIw1Ez7T/+VJ+eG1q9SHcjzeHIQOnq+Blclk+zW1zJICJogfUpls4cJAOSe52t/xMQdhc9wZEPVpjxCcY9ng6CRVhN1USMW2D4R1fpqDvu4B359ggDxC7aeAadL9SDN5DESPMDp/qx4/ayAQCTna79GXGTIUuhB9p+lrGry+kdvJAnog+5HEbuFuYznedwGcTkgtPJQDAbDMStddhlfMb24xsWwVWv2Ct3rTt4lCSAoqOx8WFAYn9VSexXqtjjHWOksq+oX3es6oa1rhznT/1uFTFN/8TI26Nlk0B6QAX54kp1ueEtimWAFMuK7WmV
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB5818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VE5WV0k2cC84cmZrYUIwUEZjSzQxTWFWSW5ONy92UFkyd0ZmU1hXV21GTFRE?=
 =?utf-8?B?T1E0WkwwTnNOd0ZsYlhvM0RuVGVLYXV1NUxIWWtDc2VXdTk0b3N2d2wxOFFH?=
 =?utf-8?B?amZ2ZkVjYlJkby9OTE0xNGZ5a3RGWG5iZWp2Nmd6V2ZGVGdIZ09YVHR4MVpy?=
 =?utf-8?B?ZGkrUnhLeVJyNVlHVE5vSjMySG1wVjlaaHZKdi83QXFMQ1JEbVpUakdQbW9h?=
 =?utf-8?B?NzBmVVlyV2tBSVI1MldSVHhLa1JDemVqRk9YL2xLeGNIai9yS05Fa2lPaVMv?=
 =?utf-8?B?cndvS0ZCejNrOHV5R3RHL0ZSTC9GM3Frb3lxblZuT3k4ZFI1M3N0R2srZVAr?=
 =?utf-8?B?WVpSdlpMdm9qTTcxbHBrM3BqVTgyUGZXNWdxeHdIdEpucFQ1R0lEUXpJY0k1?=
 =?utf-8?B?WVFpb28zOVJPMUxVMWhxVy8rVElqbktYeCtDRk5SRDFIM3VpQXEvbFJ4YjZY?=
 =?utf-8?B?eE13WjJqQjZUT1ZPakUyeFJlT0NsdU5HZVJTdTVRK1NiMjFxUDF1Y3VrK2pK?=
 =?utf-8?B?ejkvY1Rncmg4VEZJWUtxd0w0ZGNTZWpiemdSRlBwQ0JWUkxnUkxVN0pLNzhP?=
 =?utf-8?B?eWE0Qm96L3l1eEk3RldiL090Ti9wMkxXVjFVUXd6anFMaWRBY25ndWVURE1Y?=
 =?utf-8?B?L1VxdnRLaDZ0SitjQTltbUdkblROZlBXUzB0VUpEVjVHV1N3Q2lSNlFlTGtG?=
 =?utf-8?B?UmIxRUJGdlYrVjZldy9hOFNCSWhlRU1kMmNMeWVEaCtZNmxDbFVNTWp2V3Nw?=
 =?utf-8?B?S0NyMVQ2bklGamF5OTVUeUlCOHZ1MTZkM29pMGtyRzNhemVLMjY0ajcwbTZu?=
 =?utf-8?B?QnhGQlRqL1Vod0tqMXFSWlIyakwxVXZPMFcyeXh1WDFVNGd4M1VZS1JTZEhz?=
 =?utf-8?B?THE4Vnh6cVp0dUFDQ1RZaVVvWUtzSVRLcGtNOEFpakU1UERoMjhON2lTZmQ1?=
 =?utf-8?B?U0ZCYkZBN1VRZkFkUWRoTVQ0eXJyTHAweTN2bnhQV1lqbzdxU2xjU3h2ajhB?=
 =?utf-8?B?bGZKU29xcm92d0hyYjA1RWdmd2VVcS9BZ05HU3JlMFRDRzBZc2RURmVkcmk4?=
 =?utf-8?B?OTkyemZBcy9lYkwwTGczRXNXOW92NWVRNGFVVVR2eUNWU1h1NzhuUlJhZUR3?=
 =?utf-8?B?Qk9TVzdUL1U3WElZcWhRRm9PRzR3OUk4T2YxcTRlNUE5SXFEWHF3SnROY2RR?=
 =?utf-8?B?a2crckdHU1BCRDNqNGtjRTBSVHIxVm1VcGcvWG5YTkpUL2xldGEwTVQzNkdL?=
 =?utf-8?B?NzQ5dDJKTDNMb1R6dk1lem9BQXNVUFJqdmZ5VzBHbWNJanRyeVo2WkRnc0NI?=
 =?utf-8?B?WXlHS2JPSEtyZnpsdnRiV3RwN2Q3S05nV1lLVk5TSEw2ZFZZTmV2bjJjZisx?=
 =?utf-8?B?R1NIUGpZNzRmRktrODFVYWRYQTEvQWdYb3FEWm9Pd1VNeVJUc2xyMXZUMTl6?=
 =?utf-8?B?a0hBYitGVWdQSTU0OGIyTTdXRi94RVAxQ1k0NVd1NEEwOWIrVFBuZU84RlVt?=
 =?utf-8?B?cVN4bDFJVVBhYS9VOXVpTkxxMmExNTR0aUFtS3BRajRzQlpPeHU2TjNUMjRT?=
 =?utf-8?B?UStMSGZkUFJHL3hJT0lhMWY5czNrODMrL1VIeUh3c1hXYXQ5T0hSNlczRDlZ?=
 =?utf-8?B?ejNzMnBYOHgzTmh6ZlBuSlNVc01LaXE5V3B1N3pyRUpRVitWaHF6WWJ0bFdj?=
 =?utf-8?B?M0dKR012M0d3NEordUtqWGR6cHhTOVhuS29BcFRFZGZVbDg2ZTYxdkVpRktE?=
 =?utf-8?B?MzVnb2NpcDZsZUJ6b1I0VDFpNmNDbHRvVUxFbDZ3QW1aSFVtbXNWSE9ZalJo?=
 =?utf-8?B?VGtjNWVIQ2lxU1RuM2p0VXdHay9UTTd4Y3NydEFCTEJFcm1BQmxTaVZMOHE3?=
 =?utf-8?B?eEFJcHQxb2xLUmRNQWV2OURnalg1TytjZElnTTdMamRHd1FWYThpWWRPZis5?=
 =?utf-8?B?eHk3WmIwQjJUcm82Z0xKbmN4NWV6OE56SWpxSm5NU1I5Z244NzlVS2ZZUnBp?=
 =?utf-8?B?N0Nuc01Idll0TmRZdk1rZ1dIOGFzWTZtYThZZUxGTFJoaHlIdkF0a0g5Ni9U?=
 =?utf-8?B?VlFuOU9kcTVKV2N2WldzWHFseldSR1RmMVZod3UvL29jNzl0cC9hRFJHVjVP?=
 =?utf-8?B?TEUyS2RZMlNxakRXSXVHT1lnQ0xWZWR3c2lhV0hBQ3cxcWp2bEhFNk9KN0Fn?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <234DFF18D2B9394889F9AB1AFFEDA9D3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qyKHJGh0iW6osQ39klwRqHImdlV452e3i6XEzxkWmF0/X8TRkaSRLD2emWKBXxAF3xkSstAw2nKMA7aY/1Y8FRyvAmjwcrtyujZHgXEyNk3/rOWRplBvgWOTAcUJSouWNPbL7e6GxbQ70577SVe8+JlSPFSBghxGJfM90KYaRU9ACfDICiuza0/+aaWVMSpme8/ool2vCf5fOet2aFp5GPQIhbHdZgi03wlDrbZjAThNGzg8v0cDurT3kGNGnqPtQ91rhuI6e4FRiV/K0OuTNgJ9J9cyFVHf7mFBPdURfiHti94QQ/jgmyiuq4718f95eRdrZN4nTze/vRsokg95Q5ypTOHYiT8wXvGYHlAQVl6Th5iv+jTgAXuwLGLMkuLxEaTg/ZU0GE3T1wWn5kWGVvak9YRYbWAAgkZKwoW4X7yFaUnjTFpP3PidEaa4dVOvB+VqdpUAX/vqsQW1Hv3U4TjV/fRrPxFpT+oK839yaPM8ovnI9N7Zpr/x/D9XA/8pdnB7GtzowwYXSzVsBqUu8z1YNpDmEcs1OuwCxIuArPp6exHbrwwBNPmPbg3gFRd4mwjgppf5rwvatHLgA5tp3YLKCNB2oZu25CUm84h9p63tJBJ5z3jKzD8vyzuaq1+f
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c393324-d07d-4fc4-920a-08dc472fc775
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 09:42:51.4661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nboHEw8OI7z/h0AHQiwPvBNz/P3QpVPFgwkIhlMPOGJZKqrKpsGaHO3/dKZTRiceKRg3wvCg717EH7YC/ILVUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10635

S2FsbGUsDQoNCg0KT24gMTgvMDMvMjAyNCAxNzoxNiwgS2FsbGUgVmFsbyB3cm90ZToNCj4gTGkg
WmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPiB3cml0ZXM6DQo+IA0KPj4gUGVyIGZpbGVz
eXN0ZW1zL3N5c2ZzLnJzdCwgc2hvdygpIHNob3VsZCBvbmx5IHVzZSBzeXNmc19lbWl0KCkNCj4+
IG9yIHN5c2ZzX2VtaXRfYXQoKSB3aGVuIGZvcm1hdHRpbmcgdGhlIHZhbHVlIHRvIGJlIHJldHVy
bmVkIHRvIHVzZXIgc3BhY2UuDQo+Pg0KPj4gY29jY2luZWxsZSBjb21wbGFpbnMgdGhhdCB0aGVy
ZSBhcmUgc3RpbGwgYSBjb3VwbGUgb2YgZnVuY3Rpb25zIHRoYXQgdXNlDQo+PiBzbnByaW50Zigp
LiBDb252ZXJ0IHRoZW0gdG8gc3lzZnNfZW1pdCgpLg0KPj4NCj4+IHNwcmludGYoKSB3aWxsIGJl
IGNvbnZlcnRlZCBhcyB3ZWVsIGlmIHRoZXkgaGF2ZS4NCj4+DQo+PiBHZW5lcmFsbHksIHRoaXMg
cGF0Y2ggaXMgZ2VuZXJhdGVkIGJ5DQo+PiBtYWtlIGNvY2NpY2hlY2sgTT08cGF0aC90by9maWxl
PiBNT0RFPXBhdGNoIFwNCj4+IENPQ0NJPXNjcmlwdHMvY29jY2luZWxsZS9hcGkvZGV2aWNlX2F0
dHJfc2hvdy5jb2NjaQ0KPj4NCj4+IE5vIGZ1bmN0aW9uYWwgY2hhbmdlIGludGVuZGVkDQo+Pg0K
Pj4gQ0M6IEthbGxlIFZhbG8gPGt2YWxvQGtlcm5lbC5vcmc+DQo+PiBDQzogbGludXgtd2lyZWxl
c3NAdmdlci5rZXJuZWwub3JnDQo+PiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWpp
YW5AZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+IFYyOiBzdWJqZWN0IHVwZGF0ZWQNCj4+DQo+PiBU
aGlzIGlzIGEgcGFydCBvZiB0aGUgd29yayAiRml4IGNvY2NpY2hlY2sgZGV2aWNlX2F0dHJfc2hv
dyB3YXJuaW5ncyJbMV0NCj4+IFNwbGl0IHRoZW0gcGVyIHN1YnN5c3RlbSBzbyB0aGF0IHRoZSBt
YWludGFpbmVyIGNhbiByZXZpZXcgaXQgZWFzaWx5DQo+PiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGttbC8yMDI0MDExNjA0MTEyOS4zOTM3ODAwLTEtbGl6aGlqaWFuQGZ1aml0c3UuY29t
Lw0KPj4gU2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0K
PiANCj4gUGxlYXNlIHJlc3VibWl0IHRoZSB3aG9sZSBwYXRjaHNldCBhcyB2My4NCg0KDQpNYXkg
SSBrbm93IHdoYXQncyB3cm9uZyB3aXRoIHRoaXMgVjI/IG9yIHdoYXQgdXBkYXRlIHNob3VsZCBJ
IGRvIGluIFYzDQoNCg0KPiBFdmVuIGlmIGp1c3Qgb25lIHBhdGNoIGhhcyBjaGFuZ2VkIGluIGEg
cGF0Y2ggc2VyaWVzIHJlc3VibWl0IHRoZSB3aG9sZSBwYXRjaHNldCAoYW5kIHJlbWVtYmVyIHRv
IGluY3JlYXNlIHRoZSB2ZXJzaW9uIG51bWJlciksIGRvIG5vdCBqdXN0IHJlc3VibWl0IHRoYXQg
b25lIGNoYW5nZWQgcGF0Y2guIFRoZSByZWFzb24gaXMgdGhhdCBpdCdzIGRpZmZpY3VsdCB0byBh
cHBseSBwYXRjaGVzIGluIGNvcnJlY3Qgb3JkZXIgd2hlbiBzb21lIG9mIHRoZW0gYXJlIHN1Ym1p
dHRlZCBzZXBhcmF0ZWx5Lg0KDQpJIHRob3VnaHQgSSBoYWQgZm9sbG93ZWQgdGhpcyBydWxlLiBG
ZWVsIGZyZWUgdG8gbGV0IG1lIGtub3cgaWYgSSBtaXNzZWQgc29tZXRoaW5nDQoNCg0KVGhhbmtz
DQpaaGlqaWFuDQoNCj4gDQo+IGh0dHBzOi8vd2lyZWxlc3Mud2lraS5rZXJuZWwub3JnL2VuL2Rl
dmVsb3BlcnMvZG9jdW1lbnRhdGlvbi9zdWJtaXR0aW5ncGF0Y2hlcyNyZXN1Ym1pdF90aGVfd2hv
bGVfcGF0Y2hzZXQNCj4gDQo+IA==


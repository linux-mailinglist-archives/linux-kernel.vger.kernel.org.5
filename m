Return-Path: <linux-kernel+bounces-32288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C61835989
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B1301C21319
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ACA15D0;
	Mon, 22 Jan 2024 03:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Bw46lvmJ"
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21671368;
	Mon, 22 Jan 2024 03:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705892441; cv=fail; b=pXHu8ZgXu5HyjHKmm3gK/4pVHJ6P29Wn9BYgeFMNDHHEGXBLj9GfBBTya9Jp9AXkTYpwKjanXECQctxmeTylq5KcHywo6TvOOlU+UJhiJ7s3CCRA/P1buG/MXMLMjhYlDBmpl2p79FKzcqKFMdlDTOBFTDYsyVJ7w43idxJKyG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705892441; c=relaxed/simple;
	bh=ate3Chu96TRCAMLGW9h0bzYgsuIy4SboQEVLozNa2sk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VaFpeSAwm0exkk0FM9eJ+P5/j+DxBc3j30ZF/BhYuHT9gBylLVbF7FqivsK8brszeK85XHkHrTklTc7EftvusK0MVcv4QKSE568T6OGYcbXs2kh6VPzo+cp6s4ZLzGT2050I/vfsme8+ugmC899ux06hDs6TRqWsZ4hE3QOG2R8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Bw46lvmJ; arc=fail smtp.client-ip=216.71.156.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1705892435; x=1737428435;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ate3Chu96TRCAMLGW9h0bzYgsuIy4SboQEVLozNa2sk=;
  b=Bw46lvmJPkeByRth/jU4HEFKrvLlp4+fXSLHJGlQEn78QKA5u5NrkhkV
   2cK+QERcEdIzYuFfLUiJ/zTREfIuRoewLt3AGhYbABSexMTPZJzLc9SxS
   SYYGkD0ZTQI6NelHJdKe9blNRIb+zNoT67rDwuVIcMYdOs0K4TMKTi5Lz
   ieW58C2BXg9l2TbTLt1AYtVFegTqcB6NNf99WFy3v7yFziso6N/46RuQN
   Lzmuh0X/x4aO1KK0PV1gLQtIuEJmejvZzdAp8MobylwB0f/aBUBApjaX0
   Y5mHvyl2PkMGQZrmzyZYXW7a1ifl5jPIkyNv1I7L7n8MSTj7Jm8xDLp/5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="109027722"
X-IronPort-AV: E=Sophos;i="6.05,211,1701097200"; 
   d="scan'208";a="109027722"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 11:59:20 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WR33m3+wY6EhE6JZq/fL/3VDZGYrot6AHKbclRinFnwTNkyRYTMU0M1+kDcjfsuvtB1Y9AkwbNezg0GIZeYXLisPUt8dQWX4Mcpx3m8ZS9dvAXHY3gms6vlzGWvJ2T6BQyJQD1gcZVaVRxsPP0Qu8g7zzaeD4D5zr3VrBVrOJhCpVtDIG1q+Ad6HOsYF52Ces8y3qLdvV9keAFHcAgMygxzYo0NSIkejlARFvjIkJh+++yPDJJ8i6P7lvNRuLHJvDgc++XM0/J4obo/rPbzyuO0WbrWLi10txO21IAZbeZEjZmoOYwZ2vozoszG7aO7Aw1e1e9NrIpam3WFSPbhcBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ate3Chu96TRCAMLGW9h0bzYgsuIy4SboQEVLozNa2sk=;
 b=UoyHBDFVLrv3N+hyaC4Fn+JEz77IwsotaNoaDy/uxEpA3Cn/ECgVaoDnJFx/uyUl3Me8TD1nJ1+EclbobhuTyQiz7S6BR7+oLv1/HaTKhEPKr783eP2n8I1Hvw52Ky9CRIimXDkxHrGf+DTAH4Y/LBlCVN4s/U5RGvGAzlYHzuyx1mED+xhpSz0PGqTF/BhVoSdu2dfFH0IcXOpZd5ouG9lHjSmRvw6bkHhppDZOBrk9CDosTko/PNUDdYwicaT2Z2jYL50WYwl0G0xIAOLzKu49ONyJouZU9CxBxZW6I3sSVd8WgAfPFz/UOaWDU/+N6HfFzhGnZhjz67WaLXPUjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSYPR01MB5445.jpnprd01.prod.outlook.com (2603:1096:604:84::13)
 by OSZPR01MB8767.jpnprd01.prod.outlook.com (2603:1096:604:15a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.16; Mon, 22 Jan
 2024 02:59:17 +0000
Received: from OSYPR01MB5445.jpnprd01.prod.outlook.com
 ([fe80::c61:6ef5:22ee:565]) by OSYPR01MB5445.jpnprd01.prod.outlook.com
 ([fe80::c61:6ef5:22ee:565%4]) with mapi id 15.20.7228.011; Mon, 22 Jan 2024
 02:59:17 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 05/42] arch/x86/events/intel: Convert snprintf to
 sysfs_emit
Thread-Topic: [PATCH 05/42] arch/x86/events/intel: Convert snprintf to
 sysfs_emit
Thread-Index: AQHaSDfI/v+ziTV+e061rZ5G9wQNQ7DhtXOAgAN4FgA=
Date: Mon, 22 Jan 2024 02:59:17 +0000
Message-ID: <afd87194-d21a-4d4a-a984-1e340252a6a8@fujitsu.com>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-3-lizhijian@fujitsu.com>
 <CAM9d7cirhP65hMsgD7Kt+puferoJ76i+p6f7EGJsaoh4a2eLag@mail.gmail.com>
In-Reply-To:
 <CAM9d7cirhP65hMsgD7Kt+puferoJ76i+p6f7EGJsaoh4a2eLag@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5445:EE_|OSZPR01MB8767:EE_
x-ms-office365-filtering-correlation-id: d3b3fe77-e68b-4a4d-4584-08dc1af61fc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8N9W4p31P9MnPUTRwjEOet76ri6HMrihHIkjSaNzEEt86OGh6PD6AtYRdZVaiDvEKyseU8XEbf/5G8Daf1s2Mv7WOxlxS9UEQ8HLgxBg/7IlZusxNTWSSfyqZDKdOU+ioq46GdyVY46i9BDl6UZLgn9lSdg7ubZPiiqG6/4Gnpzga/SiLO2zR86VoO/dpu69411W/rXRRDlja/1aDOj0Fu/v2NPgjCbPzS6281f06mpDbNu4glbVvo12M+RNiK7qY94UjAXoq9rVE6JkPJJts3laX62oauk1a+SOtTpK5yjan0DkQ7+It2kJTr8urv99mdlGLSr9NwU+HbOreFC2ouDsbWozm6ugjd+FCCU0K53IkGe6yMazkLWCljJ6niGa3PBsFwEDE0wpdxwq63khiuIniriZ3pfGzfNZwFCGdQ7g5dvNO5GWlqDhz5jlUnvJwNOqe9pRyr3lhyPnD1hGk/td/BSwLgRPoozBC+BQQFDjH9StFaAB0EiYcDjMwpc1jUeWsDJ5w4dceVXy+vXg/liHFPVBSF7gHQoAL3QYsfKcUPhVJp0U/K1rQ2Hu5ZKCaCAGNWBWdPumM3rz0y3P5DVI3QA34p6dmVO6RMXOFwigBwVgD7QFg1SQWzAHfLot2ydc2mYPSBg4EIFyThEHzVxIjVegxvc6GiCnkTQ7S0t83buRtPob/fy/hdZL7XbhZRdlLBt5FWVV9jZxbmoC7UXnm3MvOIHA5xmKNEVa7vnBnIKUFNWgfnJ8p17kUlzjIbmSn/92o0vDXJ401bAmmjj33m65Yb6cEx51K/Kr+7g=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5445.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230173577357003)(230273577357003)(230922051799003)(1590799021)(451199024)(64100799003)(1800799012)(186009)(1580799018)(122000001)(36756003)(85182001)(41300700001)(31696002)(86362001)(83380400001)(82960400001)(38100700002)(478600001)(6506007)(71200400001)(4326008)(8936002)(8676002)(316002)(54906003)(6916009)(66476007)(66946007)(6486002)(66446008)(64756008)(76116006)(66556008)(2906002)(5660300002)(26005)(6512007)(91956017)(7416002)(53546011)(2616005)(38070700009)(31686004)(343044003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aVptanh2WWx2NmIvSUQxQ3g0T0F2Z0hEOVlNdnQ3WTJRVkttNXJ4U2pZVEF2?=
 =?utf-8?B?dkpkS21FU3JlTWV1bG8yTVFPSitoUXF5VXRMK1hMQkhaTmRhUDZIQTVLRjB5?=
 =?utf-8?B?TW0rQ1psQVhMY1lGbXhTVE5GRWY2YVVyZ0Npem9yZXp3S2ZmNlVrcURsVTRP?=
 =?utf-8?B?MklyQ01wbFdlL0V2N1hqdzdreHg3SGh4SzRXNzR1RmhPcEV6SExiRlJlRUc4?=
 =?utf-8?B?ZXBZeFNRT2YrVWQzY0toemlJRFlnTE5VTFB3bERYN20rd2cybzZLcmtLK0ly?=
 =?utf-8?B?dG1tSlNGZUllL2FRZzkxelFDckcyRnJWWUhrckZXcEY3cWZtY0ZlT3ZSRjBB?=
 =?utf-8?B?Q1F3RmU4M1NZeEduNGJkalRsZ0Z0Z2YvVVVUSDE0ZVladkY2WDh5T0cvWnFy?=
 =?utf-8?B?OWR0Nk9ob04ySzQ3RU5MbGZUTmxYR3p3WUc2WU94c3lPUzM3UFZBMUZRZnRU?=
 =?utf-8?B?WWxYSFYzMHJCbmhaZ3hITlk3UUFwempZWmhVTEpJYU9sNWk5L0lVNjhGZ0VD?=
 =?utf-8?B?UGFZMVBYcXJJSUcvYmhPbUczMFg1YURVN1RkZG9YeDZaUVUrdmU1dU44QWIr?=
 =?utf-8?B?bTNhMzQ3RUJiT0hBT0J0YkFvREVjdFdtY2Y0dHF2ZEcwOWwwb1Z0TnVXOWNm?=
 =?utf-8?B?SUxYOGhuLzU4MDZ3bG9KVWU1Y1hUUDl5U0NxazhtQngzbHFLakU5N0xBWHhm?=
 =?utf-8?B?YktyVU9ra0FuN2kvZ2J3cUZoZ2VESjNmdTFYZTZ2WWFUZWtCQm4xOTNCb0RV?=
 =?utf-8?B?WGpSVXZMWGp5Vi9ERnJzV0RDRjZNMWhpVzhQZmNWREFnUFJtUXdlcmhvendw?=
 =?utf-8?B?V3J5T21sS0FHeThGaHlOZm1nMnJvRXFZWlpvR0pIRG84aUticVN1K2tRZ0Ni?=
 =?utf-8?B?Y1ppWjJqeTU1MmRvczl2clBQcm5lM3VLejVka2lnZlNaQVMvdzVPaHk1NnFC?=
 =?utf-8?B?dTU1NnY3ZUFncThVdEpPTTFuZmhLd0dxRUZyT0JwK0FLTWFlWEZjOUVQeEEw?=
 =?utf-8?B?d09HZXF2dW9tMmVBcW5GUTlwU25senhWQTZZeWhkMUc4N3BydEYxdDFsZDFo?=
 =?utf-8?B?ajcrTzdEYTZDeFhGTFE2ZDlTeTg1UjNUdkZGbzIxaEo1dVo1eUc2N0FqZldr?=
 =?utf-8?B?ZGZ3SEVmRmgxRGYwUmsrVlFRR1pYV1hKWmM3VVpvZHJOeEJZdmlKVXBVNTF2?=
 =?utf-8?B?cFovMFBDenhXL29na0pFaUVWbm5xSGk2UDhjYkRrZURmRGhLSmhNcndZdEpY?=
 =?utf-8?B?Y1JyZzFXSS9qUUV5aTVCdy9nTittS0dUanI3K1dwNW1BSjdqVlBSK084WEd4?=
 =?utf-8?B?TzVZQ25LR2RGdGFJSVF6YkUxRlBuOG02cDR6d3Urb2thNG9UV0ZUaStzMkhM?=
 =?utf-8?B?Wm1zcGJjSmx1WmtRb3JOb01pc3hOakMrNVFPdG9VeFdiakVVTW5DTTlUVmM2?=
 =?utf-8?B?T0VwMHpiOUFObUdUQU9GSUpHNkdOSGptaGJpQU9zZEhEWTBjUlVwSUkxR0ll?=
 =?utf-8?B?OHRjdVhTeW56L2MwRTFoRkVkQVZhNisyZVZwQmNWWW1FZnNyTGgwQ1VSYm0r?=
 =?utf-8?B?MVBIa0hkbnFhWmRpZmN6ejRlRGdEbDVsUHgwdEdlY2NFY1liTENDY21zSG5k?=
 =?utf-8?B?a21TMzIyTzZqSUxsS0hjb0ZISGNRcWlqS09ucmp5MXRwNXdFUHBKQnZ4a1Mv?=
 =?utf-8?B?cjhrUnI0NzBOczQzOWJoN2FtYmZ6bGtkQ0g5S245SXRCa2kxbks3eHdtSDdT?=
 =?utf-8?B?MEhxSmZoUWR6Y1haVzdXcklvWERuK0V4UmRIUDUxMzhxYWlXUzF5bFVmQW1G?=
 =?utf-8?B?VjRhT0FjNXptVkZtTWxzMEtaYU4wTWMzZzlWK0dIQ2plOVBIcjNQRHVDRnRC?=
 =?utf-8?B?N1VXZlllVlcwVUFlK09qZ24wQUVCQXNWblFZaVhiSHdaL3Z0bHBrMXV6V3dK?=
 =?utf-8?B?Ui9xOE92cmxnUmtxb204Mm51MWRJallNbGhuSHJicUtXZkEvajliYVJOSGVV?=
 =?utf-8?B?NjdPTjhyMkdCS1dNb2VNb3ZiZGtsKzMrR204ZmwvMUJLenFCWlVEVXMrSm15?=
 =?utf-8?B?bExNOXM2U3NHcHBsSUhVUU1YeklTTTZkN2VRc1BVQTZ6b3BGb3hHRHE2aSs2?=
 =?utf-8?B?eUpXRzV5aW9ZZmJiYnhYYmtDY3IrdkYvVTZzRmF6d3dDZHdzWDdXeFNkQmVR?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BEEFE43A15A1D42A5E6E19C343D5A7B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eTz062hpJxJpIU2WUYyIgCAbLYDnF5GG0Cm4K8li3ajRe048wxE0yBd9gbGaRoTKHu/GW10Yqqyz7Zt+lrVQq8ocQSmG3VrjQDEcO0t64FtMD12YEF30T+YBSkAzaifSHRmgKikEb3sFHHFv4M6k2vhxPz0vh4Wsrbcxqk+zDvpMgG5my2nmuEg8J6vxagStwR8+xUDvNsA/GQqWRY57E/ykYoOkDdk2uGdqQiIqQ+YCZ3bDiKt5njsP+XXAXO+4hFz8QmxETr5yQUuJ++ftiA8eiFEPQTB6j/0m2sjXD3XpHvRsukBkSTp0FWnXUGL3x4aWhQv9W/BokNcBbMT3jA8tP/ykg7tFCxvfBxzPgrjJJUjIktz4xqW+piJglBFijbk8u3Mkls7132TKujka9nkBHxteALNlAlS/YESz+6elEYYAbpKNOsx0O9OQl2T/NvE5FCc4oSjAOBm2V55+XfPxr6ug6MZ+5PhPO2HWee1l5W653XAk+FZMQkTl9XECyt9ARndt+/WC6MXa9U2AEGDAQHob919JmGGEcSQfXfniUdaa/WhDJfr4DaH5YIK5+1S5k6qPG6sM4VAPJpNUSA+Y8ptXfAz1FkNKW8mxUpFCbmZD0p4TOKfLy7XRzp9V
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5445.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b3fe77-e68b-4a4d-4584-08dc1af61fc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 02:59:17.6529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0nVb7x1DnY9mf6E+Qr02w1SHgboXEy53kdEvsrcJyHuYbGjDw2fLYGK6VhHU8TZQJuxgeYlJ53TS+45zz4WQ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8767

DQoNCk9uIDIwLzAxLzIwMjQgMDY6MDAsIE5hbWh5dW5nIEtpbSB3cm90ZToNCj4gSGVsbG8sDQo+
IA0KPiBPbiBNb24sIEphbiAxNSwgMjAyNCBhdCA4OjUz4oCvUE0gTGkgWmhpamlhbiA8bGl6aGlq
aWFuQGZ1aml0c3UuY29tPiB3cm90ZToNCj4+DQo+PiBQZXIgZmlsZXN5c3RlbXMvc3lzZnMucnN0
LCBzaG93KCkgc2hvdWxkIG9ubHkgdXNlIHN5c2ZzX2VtaXQoKQ0KPj4gb3Igc3lzZnNfZW1pdF9h
dCgpIHdoZW4gZm9ybWF0dGluZyB0aGUgdmFsdWUgdG8gYmUgcmV0dXJuZWQgdG8gdXNlciBzcGFj
ZS4NCj4+DQo+PiBjb2NjaW5lbGxlIGNvbXBsYWlucyB0aGF0IHRoZXJlIGFyZSBzdGlsbCBhIGNv
dXBsZSBvZiBmdW5jdGlvbnMgdGhhdCB1c2UNCj4+IHNucHJpbnRmKCkuIENvbnZlcnQgdGhlbSB0
byBzeXNmc19lbWl0KCkuDQo+Pg0KPj4+IC4vYXJjaC94ODYvZXZlbnRzL2ludGVsL2NvcmUuYzo1
NDk2OjgtMTY6IFdBUk5JTkc6IHBsZWFzZSB1c2Ugc3lzZnNfZW1pdA0KPj4+IC4vYXJjaC94ODYv
ZXZlbnRzL2ludGVsL2NvcmUuYzo1NTMwOjgtMTY6IFdBUk5JTkc6IHBsZWFzZSB1c2Ugc3lzZnNf
ZW1pdA0KPj4+IC4vYXJjaC94ODYvZXZlbnRzL2ludGVsL2NvcmUuYzo1NTQ2OjgtMTY6IFdBUk5J
Tkc6IHBsZWFzZSB1c2Ugc3lzZnNfZW1pdA0KPj4+IC4vYXJjaC94ODYvZXZlbnRzL2ludGVsL3B0
LmM6OTk6OC0xNjogV0FSTklORzogcGxlYXNlIHVzZSBzeXNmc19lbWl0DQo+Pg0KPj4gTm8gZnVu
Y3Rpb25hbCBjaGFuZ2UgaW50ZW5kZWQNCj4+DQo+PiBDQzogUGV0ZXIgWmlqbHN0cmEgPHBldGVy
ekBpbmZyYWRlYWQub3JnPg0KPj4gQ0M6IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPg0K
Pj4gQ0M6IEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbyA8YWNtZUBrZXJuZWwub3JnPg0KPj4gQ0M6
IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+DQo+PiBDQzogQWxleGFuZGVyIFNo
aXNoa2luIDxhbGV4YW5kZXIuc2hpc2hraW5AbGludXguaW50ZWwuY29tPg0KPj4gQ0M6IEppcmkg
T2xzYSA8am9sc2FAa2VybmVsLm9yZz4NCj4+IENDOiBOYW1oeXVuZyBLaW0gPG5hbWh5dW5nQGtl
cm5lbC5vcmc+DQo+PiBDQzogSWFuIFJvZ2VycyA8aXJvZ2Vyc0Bnb29nbGUuY29tPg0KPj4gQ0M6
IEFkcmlhbiBIdW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPg0KPj4gQ0M6IFRob21hcyBH
bGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KPj4gQ0M6IEJvcmlzbGF2IFBldGtvdiA8YnBA
YWxpZW44LmRlPg0KPj4gQ0M6IERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5j
b20+DQo+PiBDQzogeDg2QGtlcm5lbC5vcmcNCj4+IENDOiAiSC4gUGV0ZXIgQW52aW4iIDxocGFA
enl0b3IuY29tPg0KPj4gQ0M6IGxpbnV4LXBlcmYtdXNlcnNAdmdlci5rZXJuZWwub3JnDQo+PiBT
aWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQo+PiAtLS0N
Cj4+ICAgYXJjaC94ODYvZXZlbnRzL2ludGVsL2NvcmUuYyB8IDYgKysrLS0tDQo+PiAgIGFyY2gv
eDg2L2V2ZW50cy9pbnRlbC9wdC5jICAgfCAyICstDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgNCBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9ldmVudHMvaW50ZWwvY29yZS5jIGIvYXJjaC94ODYvZXZlbnRzL2ludGVsL2NvcmUuYw0KPj4g
aW5kZXggMGYyNzg2ZDRlNDA1Li5hYTVmYTY0YTkyM2IgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL3g4
Ni9ldmVudHMvaW50ZWwvY29yZS5jDQo+PiArKysgYi9hcmNoL3g4Ni9ldmVudHMvaW50ZWwvY29y
ZS5jDQo+PiBAQCAtNTQ5Myw3ICs1NDkzLDcgQEAgc3RhdGljIHNzaXplX3Qgc2hvd19zeXNjdGxf
dGZhKHN0cnVjdCBkZXZpY2UgKmNkZXYsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsDQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgY2hhciAqYnVmKQ0KPj4gICB7DQo+PiAtICAgICAgIHJldHVybiBzbnByaW50
ZihidWYsIDQwLCAiJWRcbiIsIGFsbG93X3RzeF9mb3JjZV9hYm9ydCk7DQo+PiArICAgICAgIHJl
dHVybiBzeXNmc19lbWl0KGJ1ZiwgIiVkXG4iLCBhbGxvd190c3hfZm9yY2VfYWJvcnQpOw0KPiAN
Cj4gSSBndWVzcyB0aGUgc2l6ZSBkb2Vzbid0IG1hdHRlciBoZXJlLi4NCg0KSW5kZWVkLCBpdCBk
b2Vzbid0IG1hdHRlci4gQnV0IHRoZSBrZXJuZWwgaGFzIGFscmVhZHkgZm9ybWVkIGEgdW5pZmll
ZCBjb252ZW50aW9uDQooc2VlIGZpbGVzeXN0ZW1zL3N5c2ZzLnJzdCksIGFuZCB3ZSBhbHNvIGhh
dmUgc3RhdGljIHRvb2xzIHRvIGNoZWNrIHRoaXMgaXNzdWUuDQoNClRoaXMgZml4IGNhbiBib3Ro
IG1ha2UgaXQgY29tcGxpYW50IHdpdGggY29udmVudGlvbiBhbmQgZWxpbWluYXRlIHdhcm5pbmdz
IGNvbXBsYWluZWQNCmJ5IHRoZSBjb2NjaW5lbGxlLg0KDQpTbyBJIGhvcGUgdGhhdCB0aGUgY29t
bXVuaXR5IGNhbiBhY2NlcHQgdGhlc2UgZml4ZXMgdG8gbWFrZSBhbGwgc291cmNlIGNvZGUNCmNv
bnNpc3RlbnQgYW5kIGJlYXV0aWZ1bC4NCg0KKDIgYWJ1c2VkIGNhc2VzIHdlcmUgbmV3bHkgaW50
cm9kdWNlZCBpbiA2LjggbWVyZ2Ugd2luZG93cykNCg0KDQo+IA0KPiBBbnl3YXkgdGhlcmUncyBm
cmVlemVfb25fc21pX3Nob3coKSBldmVuIHVzZXMgc3ByaW50ZigpLg0KDQpZZXMsIHRoZXJlIGFy
ZSBzdGlsbCBzZXZlcmFsIHBsYWNlcyB1c2luZyBzcHJpbnRmKCkgd2hpY2ggc2hvdWxkIGFsc28g
Y29udmVydA0KdG8gc3lzZnNfZW1pdCBJTUhPLiBUaGV5IGFyZSBhbHJlYXkgaW4gVE9ET3Moc2Vl
IHRoZSBjb3ZlciBsZXR0ZXIpLiBJIHBsYW4gdG8gZml4DQp0aGVtIGluIGFub3RoZXIgc2V0IGlm
IHRoaXMgc2V0IGdvZXMgc21vb3RobHkuDQoNClRoYW5rcw0KWmhpamlhbg0KDQoNCg0KPiANCj4g
VGhhbmtzLA0KPiBOYW1oeXVuZw0KPiANCj4+ICAgfQ0KPj4NCj4+ICAgc3RhdGljIHNzaXplX3Qg
c2V0X3N5c2N0bF90ZmEoc3RydWN0IGRldmljZSAqY2RldiwNCj4+IEBAIC01NTI3LDcgKzU1Mjcs
NyBAQCBzdGF0aWMgc3NpemVfdCBicmFuY2hlc19zaG93KHN0cnVjdCBkZXZpY2UgKmNkZXYsDQo+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAq
YXR0ciwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNoYXIgKmJ1ZikNCj4+ICAg
ew0KPj4gLSAgICAgICByZXR1cm4gc25wcmludGYoYnVmLCBQQUdFX1NJWkUsICIlZFxuIiwgeDg2
X3BtdS5sYnJfbnIpOw0KPj4gKyAgICAgICByZXR1cm4gc3lzZnNfZW1pdChidWYsICIlZFxuIiwg
eDg2X3BtdS5sYnJfbnIpOw0KPj4gICB9DQo+Pg0KPj4gICBzdGF0aWMgREVWSUNFX0FUVFJfUk8o
YnJhbmNoZXMpOw0KPj4gQEAgLTU1NDMsNyArNTU0Myw3IEBAIHN0YXRpYyBzc2l6ZV90IHBtdV9u
YW1lX3Nob3coc3RydWN0IGRldmljZSAqY2RldiwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLA0KPj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgY2hhciAqYnVmKQ0KPj4gICB7DQo+PiAtICAgICAgIHJldHVybiBzbnBy
aW50ZihidWYsIFBBR0VfU0laRSwgIiVzXG4iLCBwbXVfbmFtZV9zdHIpOw0KPj4gKyAgICAgICBy
ZXR1cm4gc3lzZnNfZW1pdChidWYsICIlc1xuIiwgcG11X25hbWVfc3RyKTsNCj4+ICAgfQ0KPj4N
Cj4+ICAgc3RhdGljIERFVklDRV9BVFRSX1JPKHBtdV9uYW1lKTsNCj4+IGRpZmYgLS1naXQgYS9h
cmNoL3g4Ni9ldmVudHMvaW50ZWwvcHQuYyBiL2FyY2gveDg2L2V2ZW50cy9pbnRlbC9wdC5jDQo+
PiBpbmRleCA4ZTJhMTIyMzVlNjIuLjMwYmJhNWYzYTg0MCAxMDA2NDQNCj4+IC0tLSBhL2FyY2gv
eDg2L2V2ZW50cy9pbnRlbC9wdC5jDQo+PiArKysgYi9hcmNoL3g4Ni9ldmVudHMvaW50ZWwvcHQu
Yw0KPj4gQEAgLTk2LDcgKzk2LDcgQEAgc3RhdGljIHNzaXplX3QgcHRfY2FwX3Nob3coc3RydWN0
IGRldmljZSAqY2RldiwNCj4+ICAgICAgICAgICAgICAgICAgY29udGFpbmVyX29mKGF0dHIsIHN0
cnVjdCBkZXZfZXh0X2F0dHJpYnV0ZSwgYXR0cik7DQo+PiAgICAgICAgICBlbnVtIHB0X2NhcGFi
aWxpdGllcyBjYXAgPSAobG9uZyllYS0+dmFyOw0KPj4NCj4+IC0gICAgICAgcmV0dXJuIHNucHJp
bnRmKGJ1ZiwgUEFHRV9TSVpFLCAiJXhcbiIsIGludGVsX3B0X3ZhbGlkYXRlX2h3X2NhcChjYXAp
KTsNCj4+ICsgICAgICAgcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAiJXhcbiIsIGludGVsX3B0X3Zh
bGlkYXRlX2h3X2NhcChjYXApKTsNCj4+ICAgfQ0KPj4NCj4+ICAgc3RhdGljIHN0cnVjdCBhdHRy
aWJ1dGVfZ3JvdXAgcHRfY2FwX2dyb3VwIF9fcm9fYWZ0ZXJfaW5pdCA9IHsNCj4+IC0tDQo+PiAy
LjI5LjINCj4+


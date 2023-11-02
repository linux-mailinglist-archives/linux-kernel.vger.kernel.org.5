Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93B57DECA5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 06:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjKBF6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 01:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKBF6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 01:58:06 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453DCD7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 22:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1698904681; x=1730440681;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1iyfrXrtt3laLi9K1GNHz43C0Ua/VAfRX9fdUa2oL2Q=;
  b=Z6ZQdq3k8zzpK7Bjuuw7TpC5m2byHUHBobBOmJnRKhqmrRY36lKKAaF1
   Tjo7L1dOpD+P9FlnZLCKbvqMIVFatNpU653xCQrfpXyA+M9cJ4tqNOUf8
   rAVTHKj79rCXFNVx+z5UE0izV9L30XSiPtXYbdnOGpMmJv0F2AwlVeIi+
   szne4gWFEq8AJg066e9mHw473FXZ5qEvtOPZOW0+1beeqbP1PBDiOa8da
   O0bvVIRja32d26RoBbh+N72hOOydFREvIkaQhqHzxVZW4Kdb9s9rKfc1j
   ecEyY1qIstgWutX3gRqwVo4VY4JANCrdGdm5twPa8fD68Z0V47/QpRL1h
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="101155420"
X-IronPort-AV: E=Sophos;i="6.03,270,1694703600"; 
   d="scan'208";a="101155420"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 14:57:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYsUcIKrTXziWn2pBf9f6P5cRzrC5Ymq3v04s6nd7LJMqTcOI4js6vgn9qzVuxJWpFDEde1Uf85eQ6LAEhHL/bC0VbSkDue/ETI6SY+46daE3adCtPoYwn5fFZxjxCV/levBkzf12lB1X5TID6HsqXajbos1I2BEJoha83EJ/e9xsj9ktCk9GHAPbTQtTcD7Z/S6gI2yGfLiOlkA66FGP9TLpDv/BkEkGp6FSXWWUdFjILHqT+/qhbnhkjsUPAnJD3gfFGg2viigpBWfqH0ESvF6LD+ZxmfJVjWtsk11mWzE0XxqgTZ3qwb12HcJD9EbXBEBOReRBIj6ptROz47Iww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iyfrXrtt3laLi9K1GNHz43C0Ua/VAfRX9fdUa2oL2Q=;
 b=j3eTqPd26vFKU80xAL/gd/LzjJDBNFjFhGPpWel/OaEAzN9BQoYbIxBLT3RYQubJVXK+qcrrxZJn7/a7cjwUTKFGfLMMGQpFXSW6M6HJRoROFVPlAvzE43nnOgQ27XJZvgky6jecKyiQyyKNVvsYakvWGf2ITlNCwdxr7l5ZAHbsXeoiKaNuGbosfkfnXxHShaycLOlNc66flfDsb8FwK71aZj1+zwwVt/NvAgO5HNS5UrhmU1GTJ9KlTG1YC+k1z+TjbMUHQZy3v1muMPp9WtGCCSXNLMO6wV1pjaJwdJ2mIp84X5fjafxWTy43jcpVBY96+4OcrTWXmrGsdtIsMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by OS3PR01MB8844.jpnprd01.prod.outlook.com (2603:1096:604:17e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 05:57:54 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::51e9:b5fa:db90:6c2a]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::51e9:b5fa:db90:6c2a%6]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 05:57:54 +0000
From:   "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 2/4] mm/vmstat: Move pgdemote_* to per-node stats
Thread-Topic: [PATCH RFC 2/4] mm/vmstat: Move pgdemote_* to per-node stats
Thread-Index: AQHaDTg+KXmNbb9YgkqK9ujKhL042LBmhRbXgAADgQA=
Date:   Thu, 2 Nov 2023 05:57:54 +0000
Message-ID: <3adb78f1-46ad-4ae2-82c3-f57a20862771@fujitsu.com>
References: <20231102025648.1285477-1-lizhijian@fujitsu.com>
 <20231102025648.1285477-3-lizhijian@fujitsu.com>
 <87v8ak1ziv.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87v8ak1ziv.fsf@yhuang6-desk2.ccr.corp.intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|OS3PR01MB8844:EE_
x-ms-office365-filtering-correlation-id: 0bb36343-cacb-462f-f792-08dbdb68a7cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hlnj+dG0n+kDFmyVVoGCGSYtx+m+SZFc0fJ5//oQ7IYrz8nQfW5kLjYdaTFvbSapB0TQACCU76hU7MnCgxylkU90wJqRri4NedXGyVnUDBqEEEYgk3hjWx0E1MDLuvkFgEVO9MDCnYhxiKXKHpiO1lIqYUgvamNyQYeGxtE7tqxASgzhC0dDtGVH/jL3v6BR+UHuQoq5q6FJ4WNVXgu3uK/G5L+arB4Sd0bBW1ObVUc3zyYgMBvKFfuGRSECQQuaOQYc7++sPA6udlrs64VTZaAwZ2f/jGcd4EK4uZhQnaFCV0Sr2zptA3INCqNC8JgJ5QPHQzFCF4ZTdEPjqn+Y4ikYyC9qio/w7BOazANvr4/EuVlDTxfvYXQcHRo/MKRgHocPvdm7FsivztF9lgeDrVeGB3ePnx6LnjFn5WblV1cVF0/4GZztCehMlqRpqdMG7BblCbL9V3LKnWWhf0oIdhN1fkthM1yGQ3mQ5p0U/DanidgVLndqeEdLvEFPToabCdr/bKyuwMwRSZA1S8tSoi+Posn8a3Ys3NQH6qz9jNTey6qSRXKYg3l8xeQv0NvrGomr8vC3E+KuiwRouLtG20T/fA8+8JGuDXdeC/9eMVJwCPMxUkUyKADBvpIt5b7UF64sbv0JSa+eO1hwonJHy/yIEC9xXywSfUmVXlRhdxufN6XyX8NKtvYITIDHb2NoTJkeS2u9ATjsOU/CK8bNyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5442.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(1590799021)(186009)(86362001)(1580799018)(85182001)(6512007)(2616005)(6506007)(53546011)(36756003)(71200400001)(38100700002)(26005)(38070700009)(31696002)(83380400001)(122000001)(82960400001)(478600001)(6486002)(2906002)(91956017)(66946007)(31686004)(41300700001)(66556008)(66446008)(64756008)(66476007)(6916009)(76116006)(8936002)(8676002)(4326008)(316002)(5660300002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmpzS0lrV0IzMDdlVFVzVzBMeUZEVFNRVGh5bUxxdVhBQjFuTUlDeFpzYyti?=
 =?utf-8?B?VG5BdHV3OFI3SXJNc01iTytOMjRjSFRiZ3A4UERMUXpoZFUrdlk0TG1MTGZE?=
 =?utf-8?B?UlFna3NiZnBvb1p4TXQwMSt0LzZOYWZUQXViYy9YblhBdGFpVWVoZUpXQVNC?=
 =?utf-8?B?aEdtNi9xVTJLZXp5UDFPR1ZETmQwOGdDUGhIdHJ3enZZSTlsa2M0V2dGS3Nm?=
 =?utf-8?B?T2krZlVRUGYzUlY3ZlM5eCthRm02czlCQVFFMk5SN1JZUGFhKzRaNTFwOFVa?=
 =?utf-8?B?YjM3eERwZ2tROGhsbFlrbnBMU1lWTzBhTjVZbzl1akhXTU16cDRxeGhZQ0xI?=
 =?utf-8?B?dC9FdVl0WVVSa05kMXZJOVc0RldiOERhQ1I1clBlTjhlUlhSRnJvUnR1KzR3?=
 =?utf-8?B?OUxIYlVGN0Z2ZjBNalBlMTBJSFNOa3V6bjdnRXVCRTZiK0ViUmQ3U0F3ZC8r?=
 =?utf-8?B?K1VxQVZBd0hVbm9FSkhsN1Mvc3NYL0xwdXdHV2VGR1ZzSk5MQm5ycExESFcy?=
 =?utf-8?B?a0NoWDJaZUR3Qm91akFHcDcyakhQWE8xMUsyakVxYVFLL01uUmtlNE5EZzlo?=
 =?utf-8?B?cC94ZUhvbDd1UFpmSmxqZjgrblRpMFVWeFo2TUN0ZXBybEo5eG1mSjQzVFM0?=
 =?utf-8?B?VnRQMTM1SlpMRU1CSyt2V2h0K2JoR21xNWxNQ3RkVE14U1NpSUprQmxETG0v?=
 =?utf-8?B?QVgvQU52UGxua1MyUTM3aVJKWUpCTlNUSkNXRDAzS29za1p5ZlBXdHZhMmpK?=
 =?utf-8?B?ZTZPOEtocGJaZjJRM2hONVhWNVRFd1Y4N3djSmEyY2gxKzFyZURETlFIUlhu?=
 =?utf-8?B?RjhqZ051VkJPeEY3VlRjdDNKckRiWi80N3d1dE9nWmZUcXNOdmc1bWhJUFFI?=
 =?utf-8?B?SEk3amZ5cThXTnE2SWJjakNCalBlNFI3VC9PLzZYd3VWNGVsbkQ4aVg4K3RU?=
 =?utf-8?B?K0F2UmQ4b080S0xNZkhqeG0wSXg3d3QrQ1Z5bWtyOGM2b2paWXBpNTFrRS9m?=
 =?utf-8?B?eVVnSjBnMldJdmVuSkErekpVQ0NFOGVBaDhsQktUUUFkTUg2NGFKNVRxWUVp?=
 =?utf-8?B?V1FaY2xqZXNXSXo3WjdHR0dqbkdReXpMS1M5WWtrVE56TGJhMzF6bm9kRzk3?=
 =?utf-8?B?WEhlSHVxcGtXNkxHclAxU0Y2aUhMTXkyT1ZweC9lcnVLcFE2azErejJpSklj?=
 =?utf-8?B?RXVRVm94NTA2SUEraDB4UEJjUWZWWks0MGZndG1QTGdnOE9nYUlWWkcyY21j?=
 =?utf-8?B?bTU5SHpub1VGbVl1eFBhdUhnN3hvVjQwWjh6ekxrblJMNmlyMWdsZWNjbzBk?=
 =?utf-8?B?Q29pdFhHMUVxeGpkV3o4RGgxc3U3MlprNGx5emd1K2UrQVEzYnNYbWNTSzE5?=
 =?utf-8?B?SDlXQXJTN2loN2EvTlRwQUFpSzYrd0QwSjd2S2xjU091b2MwUktwdXppcHFo?=
 =?utf-8?B?RnYrOWI0SkQ0MkV6UzB6VzYzeTNCdU9XRHF0Mm5FTjZHUUVQaXJ4VHUreXNG?=
 =?utf-8?B?R29DSGxrMmNRdEVlVUJ1bWVVQit1WXhFMklNODNiSzl6aEdid0Q0MmpHUmp0?=
 =?utf-8?B?WEdCQVdHL1ovUEVEcWRYb2hyRHBiMDFoTlMxa1NQRlRpU2RkODVyeWZ1eUlx?=
 =?utf-8?B?dk52eloyOG1xMDRod3JXOXRZYlVPQ1d2UHI2ay93czJIRUpBd21kQXhmekwv?=
 =?utf-8?B?V09SazFJbDlTMk9EcmNjamJoaVh6RVJNb3VMMzV6YVAvOW1sY3JVV2xNclUr?=
 =?utf-8?B?VVE4Vzdla3FrdldJelUyMDhrSlhkK1FrYm9aSlZqOTJsOWRuTGU4NGJSNmNk?=
 =?utf-8?B?a3grOUdyTmJFaVhUS2J4MStQdk9hd25DTWdwNHROYWdwbTFxdGNWY21UUzln?=
 =?utf-8?B?WDJGb005eW5qWVFPSGhHSzY4R3VFSDFDbS9QKzRWUE1CeldYMGlKQmx1dUZV?=
 =?utf-8?B?M1RVUnR5Q3NMSVZScXppZ3Z6cmMwZDM4TFI5NGRLdG55WVhrTklsSEVJbXhC?=
 =?utf-8?B?VFM2TnhRbzFLWHBoSDREdnhCVzdCS2M5dlRTdEFhSWdOQjBmUmRxNTZoT0JV?=
 =?utf-8?B?UGlmaHUvYnBsZ0hudTVyamJIc1pEc1dXQTN4Zm1kOVZxQlFTR1lmUlNaYXBa?=
 =?utf-8?B?OFpYS1BSSmt1VzFaV0FLMDIyaXE3L2JMRVpEOTNlRG9xQTAzNlVKWXFPcWta?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <199FA7E148E3E947BB0E73A26B390658@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aTRLOERQYmE4MXJ2empIOHY1cGRJTzdSRnFOTmREMkx5bGM4ZDZxT2o5NVdK?=
 =?utf-8?B?OUhsa0xOdHpXNzErMU1jTHNLaUIvUk5pWjlNZytEZjlYTFRaYzk1L09FTklj?=
 =?utf-8?B?c282NGQxcVQvZmgxcC8ydVpVQXQ3NEhPSlpNcmhndTkxek9HSHpCNzU4T3JF?=
 =?utf-8?B?NG5xQXBSNXB6YXNSRTdJWEJERG9mODZZUXllOVhDNkFLTnZmUlRiYXFWc1NP?=
 =?utf-8?B?bW1sV2hpTUJpbFYxbUsySGVGSlNBSnFvTCswSExQL1BzR1JTRVRHM0NyT20v?=
 =?utf-8?B?VzVMVEptTTBIZHVyYWVWc2dId0xIT1J5UVBtOWpUZ3BEeDRRdlhWVTJvWGQ0?=
 =?utf-8?B?SHBBbHFjSXRUSWNIWk5FWllESFNmSllHUE5hV3ozT0cvN3FyTFMvdllRR0Jt?=
 =?utf-8?B?NE1NYmE4dS9tM0lDcGZGbkpQOEJUaGJzY1hWZUdSYXJPbUxaQVd1NFN0SXNO?=
 =?utf-8?B?Q0l3U2JhbW5KM09QeWNoMG8xcTE5MUFmSHJvOG00bHhIb0k0MTNDamhoLzAr?=
 =?utf-8?B?N28wVTd0Mm9nN3VHYkxKRlJXNHhqUEhjc0NFeUNOMElXYXhZUjQvcVRmVGZp?=
 =?utf-8?B?MVZ2RnhSSGRoN2tuWGxnZWpvaTB2RC9obzlSaVBLekJiTnc1ckRFQ3dxRWtO?=
 =?utf-8?B?YlZ6RGw1R2pmWnZVRnZiSTUrcVRKM000NzhOaE5yWDliMVJsNDJPbDl5N2VR?=
 =?utf-8?B?Q2x4enRqTm1udUVscy9LYm1COHBRL1MxRWUxMFhONWNYQ1JWblhYekM4OEVR?=
 =?utf-8?B?VnlZT1NjWGp1dms1UmRJUkdQbmM1TjlENG5HNVlSSkNpWUlnTkNyK1dJd1BP?=
 =?utf-8?B?eUJzMDBDN0FNMEE4b0VLbENtREExWWRHMzVqWE5nRG1TdXhzTEF4L2RJWEpT?=
 =?utf-8?B?b2RoYUlSbnY3aTlLWW9MUW44QXU1ejJNNVRINm56MkZpYlF2ZzlIa3FUUVYr?=
 =?utf-8?B?dTZDcExmRlJLTlYzWFVaeElHb1BucFFtQXlnV1ZSTE9Rd0xDVDZjTnIyZDhG?=
 =?utf-8?B?bEtUeXRpMTNGaHorWUg5V1BBbXZNWWlUdUk4blpUN0F4UUNhb1JUMEFBUSt3?=
 =?utf-8?B?OTZiUmdjUEc5a1VRWlE1WUxkaUpIclBmZFIyekJqaDRQaU9WVnhZV0N2dWlB?=
 =?utf-8?B?dUFtUWJZVFFqTDhOK1JFWFAxSkZVaUJjTk1sWXF3QW9KRnlnREw1S1JyMHYz?=
 =?utf-8?B?SjhPVkhETG12VW9YSEdBMkRxMGM3MWhZcU8rWXQvK2FmS08rbDFUTHJVOWtp?=
 =?utf-8?B?a3R3c3E2eWZLMCtsakZINmVVYlFIQnVjeHAwbkRhdTZxRStzQT09?=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb36343-cacb-462f-f792-08dbdb68a7cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 05:57:54.0791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ogybCXT3kES90SNpPfAG4jUA7B31QJJFJzl2xqFvfLaWTiKaCF+Z5EEhp7IV33xhn6xR+Uq+KImj6DozzHlTWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8844
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDAyLzExLzIwMjMgMTM6NDMsIEh1YW5nLCBZaW5nIHdyb3RlOg0KPiBMaSBaaGlqaWFu
IDxsaXpoaWppYW5AZnVqaXRzdS5jb20+IHdyaXRlczoNCj4gDQo+PiBUaGlzIGlzIGEgcHJlcGFy
ZSB0byBpbXByb3ZlIHRoZSBkZW1vdGlvbiBwcm9maWxpbmcgaW4gdGhlIGxhdGVyDQo+PiBwYXRj
aGVzLg0KPj4NCj4+IFBlci1ub2RlIGRlbW90aW9uIHN0YXRzIGhlbHAgdXNlcnMgdG8gcXVpY2ts
eSBpZGVudGlmeSB3aGljaA0KPj4gbm9kZSBpcyBpbiBoaWdlIHN0cmVlLCBhbmQgdGFrZSBzb21l
IHNwZWNpYWwgb3BlcmF0aW9ucyBpZiBuZWVkZWQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTGkg
WmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPj4gLS0tDQo+PiAgIGluY2x1ZGUvbGlu
dXgvbW16b25lLmggICAgICAgIHwgNCArKysrDQo+PiAgIGluY2x1ZGUvbGludXgvdm1fZXZlbnRf
aXRlbS5oIHwgMyAtLS0NCj4+ICAgbW0vdm1zY2FuLmMgICAgICAgICAgICAgICAgICAgfCAzICsr
LQ0KPj4gICBtbS92bXN0YXQuYyAgICAgICAgICAgICAgICAgICB8IDYgKysrLS0tDQo+PiAgIDQg
ZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21tem9uZS5oIGIvaW5jbHVkZS9saW51eC9tbXpvbmUu
aA0KPj4gaW5kZXggNDEwNmZiYzViNGIzLi5hZDAzMDllZWE4NTAgMTAwNjQ0DQo+PiAtLS0gYS9p
bmNsdWRlL2xpbnV4L21tem9uZS5oDQo+PiArKysgYi9pbmNsdWRlL2xpbnV4L21tem9uZS5oDQo+
PiBAQCAtMjA2LDYgKzIwNiwxMCBAQCBlbnVtIG5vZGVfc3RhdF9pdGVtIHsNCj4+ICAgI2lmZGVm
IENPTkZJR19OVU1BX0JBTEFOQ0lORw0KPj4gICAJUEdQUk9NT1RFX1NVQ0NFU1MsCS8qIHByb21v
dGUgc3VjY2Vzc2Z1bGx5ICovDQo+PiAgIAlQR1BST01PVEVfQ0FORElEQVRFLAkvKiBjYW5kaWRh
dGUgcGFnZXMgdG8gcHJvbW90ZSAqLw0KPj4gKwkvKiBQR0RFTU9URV8qOiBwYWdlcyBkZW1vdGVk
ICovDQo+PiArCVBHREVNT1RFX0tTV0FQRCwNCj4+ICsJUEdERU1PVEVfRElSRUNULA0KPj4gKwlQ
R0RFTU9URV9LSFVHRVBBR0VELA0KPj4gICAjZW5kaWYNCj4+ICAgCU5SX1ZNX05PREVfU1RBVF9J
VEVNUw0KPj4gICB9Ow0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdm1fZXZlbnRfaXRl
bS5oIGIvaW5jbHVkZS9saW51eC92bV9ldmVudF9pdGVtLmgNCj4+IGluZGV4IDhhYmZhMTI0MDA0
MC4uZDFiODQ3NTAyZjA5IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9saW51eC92bV9ldmVudF9p
dGVtLmgNCj4+ICsrKyBiL2luY2x1ZGUvbGludXgvdm1fZXZlbnRfaXRlbS5oDQo+PiBAQCAtNDEs
OSArNDEsNiBAQCBlbnVtIHZtX2V2ZW50X2l0ZW0geyBQR1BHSU4sIFBHUEdPVVQsIFBTV1BJTiwg
UFNXUE9VVCwNCj4+ICAgCQlQR1NURUFMX0tTV0FQRCwNCj4+ICAgCQlQR1NURUFMX0RJUkVDVCwN
Cj4+ICAgCQlQR1NURUFMX0tIVUdFUEFHRUQsDQo+PiAtCQlQR0RFTU9URV9LU1dBUEQsDQo+PiAt
CQlQR0RFTU9URV9ESVJFQ1QsDQo+PiAtCQlQR0RFTU9URV9LSFVHRVBBR0VELA0KPj4gICAJCVBH
U0NBTl9LU1dBUEQsDQo+PiAgIAkJUEdTQ0FOX0RJUkVDVCwNCj4+ICAgCQlQR1NDQU5fS0hVR0VQ
QUdFRCwNCj4+IGRpZmYgLS1naXQgYS9tbS92bXNjYW4uYyBiL21tL3Ztc2Nhbi5jDQo+PiBpbmRl
eCA2ZjEzMzk0YjExMmUuLjJmMWZiNGVjMzIzNSAxMDA2NDQNCj4+IC0tLSBhL21tL3Ztc2Nhbi5j
DQo+PiArKysgYi9tbS92bXNjYW4uYw0KPj4gQEAgLTE2NzgsNyArMTY3OCw4IEBAIHN0YXRpYyB1
bnNpZ25lZCBpbnQgZGVtb3RlX2ZvbGlvX2xpc3Qoc3RydWN0IGxpc3RfaGVhZCAqZGVtb3RlX2Zv
bGlvcywNCj4+ICAgCQkgICAgICAodW5zaWduZWQgbG9uZykmbXRjLCBNSUdSQVRFX0FTWU5DLCBN
Ul9ERU1PVElPTiwNCj4+ICAgCQkgICAgICAmbnJfc3VjY2VlZGVkKTsNCj4+ICAgDQo+PiAtCV9f
Y291bnRfdm1fZXZlbnRzKFBHREVNT1RFX0tTV0FQRCArIHJlY2xhaW1lcl9vZmZzZXQoKSwgbnJf
c3VjY2VlZGVkKTsNCj4+ICsJbW9kX25vZGVfcGFnZV9zdGF0ZShOT0RFX0RBVEEodGFyZ2V0X25p
ZCksDQo+PiArCQkgICAgUEdERU1PVEVfS1NXQVBEICsgcmVjbGFpbWVyX29mZnNldCgpLCBucl9z
dWNjZWVkZWQpOw0KPiANCj4gVGhpbmsgYWdhaW4uICBJdCBzZWVtcyB0aGF0IGl0J3MgYmV0dGVy
IHRvIGNvdW50IGRlbW90aW9uIGV2ZW50IGZvciB0aGUNCj4gc291cmNlIG5vZGUuICBCZWNhdXNl
IGRlbW90aW9uIGNvbWVzIGZyb20gdGhlIG1lbW9yeSBwcmVzc3VyZSBvZiB0aGUNCj4gc291cmNl
IG5vZGUuICBUaGUgdGFyZ2V0IG5vZGUgaXNuJ3Qgc28gaW1wb3J0YW50LiAgRG8geW91IGFncmVl
Pw0KDQpHb29kIGlkZWEsIEkgd2lsbCB1cGRhdGUgaXQuDQoNCg0KDQo+IA0KPiAtLQ0KPiBCZXN0
IFJlZ2FyZHMsDQo+IEh1YW5nLCBZaW5nDQo+IA0KPj4gICANCj4+ICAgCXJldHVybiBucl9zdWNj
ZWVkZWQ7DQo+PiAgIH0NCj4+IGRpZmYgLS1naXQgYS9tbS92bXN0YXQuYyBiL21tL3Ztc3RhdC5j
DQo+PiBpbmRleCAwMGU4MWU5OWM2ZWUuLmYxNDFjNDhjMzllNCAxMDA2NDQNCj4+IC0tLSBhL21t
L3Ztc3RhdC5jDQo+PiArKysgYi9tbS92bXN0YXQuYw0KPj4gQEAgLTEyNDQsNiArMTI0NCw5IEBA
IGNvbnN0IGNoYXIgKiBjb25zdCB2bXN0YXRfdGV4dFtdID0gew0KPj4gICAjaWZkZWYgQ09ORklH
X05VTUFfQkFMQU5DSU5HDQo+PiAgIAkicGdwcm9tb3RlX3N1Y2Nlc3MiLA0KPj4gICAJInBncHJv
bW90ZV9jYW5kaWRhdGUiLA0KPj4gKwkicGdkZW1vdGVfa3N3YXBkIiwNCj4+ICsJInBnZGVtb3Rl
X2RpcmVjdCIsDQo+PiArCSJwZ2RlbW90ZV9raHVnZXBhZ2VkIiwNCj4+ICAgI2VuZGlmDQo+PiAg
IA0KPj4gICAJLyogZW51bSB3cml0ZWJhY2tfc3RhdF9pdGVtIGNvdW50ZXJzICovDQo+PiBAQCAt
MTI3NSw5ICsxMjc4LDYgQEAgY29uc3QgY2hhciAqIGNvbnN0IHZtc3RhdF90ZXh0W10gPSB7DQo+
PiAgIAkicGdzdGVhbF9rc3dhcGQiLA0KPj4gICAJInBnc3RlYWxfZGlyZWN0IiwNCj4+ICAgCSJw
Z3N0ZWFsX2todWdlcGFnZWQiLA0KPj4gLQkicGdkZW1vdGVfa3N3YXBkIiwNCj4+IC0JInBnZGVt
b3RlX2RpcmVjdCIsDQo+PiAtCSJwZ2RlbW90ZV9raHVnZXBhZ2VkIiwNCj4+ICAgCSJwZ3NjYW5f
a3N3YXBkIiwNCj4+ICAgCSJwZ3NjYW5fZGlyZWN0IiwNCj4+ICAgCSJwZ3NjYW5fa2h1Z2VwYWdl
ZCIs

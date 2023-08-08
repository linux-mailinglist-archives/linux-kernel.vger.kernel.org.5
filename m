Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E357745DE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbjHHSra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjHHSrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:47:05 -0400
X-Greylist: delayed 1794 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Aug 2023 09:54:07 PDT
Received: from mx0d-0054df01.pphosted.com (mx0d-0054df01.pphosted.com [67.231.150.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAC812D947;
        Tue,  8 Aug 2023 09:54:06 -0700 (PDT)
Received: from pps.filterd (m0209000.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 378AQPct032088;
        Tue, 8 Aug 2023 12:00:28 -0400
Received: from can01-yqb-obe.outbound.protection.outlook.com (mail-yqbcan01lp2236.outbound.protection.outlook.com [104.47.75.236])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3s9kb0jde0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 12:00:27 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZNEBpdlzFXZ9BEzOsIllx/bj09fGbw0sIwU/Amzg+XTyRLgl4CXRMq40Wp9jZzQZ4QwP6pY9TAE+eN7oz6/bVbWfzx62Fwti5b4pg+IFrkQuRAzo5w6pD/0M5KZqFP184ZfWazCFBw5/wjfSs6z0MdywnjDTJ4VTa5xDIn4YVsN3fGW/G2Xp2+xjD8qWGScInkT5Q48/WUeMRrk2pnUIorcD487Z+GP1EA7okUgq9BVFiQhqA57ejmXp7PkZj0s91Mhz2XkXzxmKznqah5Ud1HIi1vBXdzqUy7ece7XWiKul/9LmwuMp2E/oMjTh5XqBAdwoubJcmVTIkhA9g8BlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOUnmXTcGMbnCLoLt9WjCaR9f1/NH7ZwK8mCSF+rAR8=;
 b=TP5mWxcmnM1+POXRzUJ5jb45NIG4U7Xa2xy43ltWtselO/j3pXQ/MnL0MuCjkRSVk7K8j/mIF+ALd055BNiBmszR4JujD7wHCHNKalQ6SVNbVikd+NjH7YzV7vJric00vsI/IShxrfXnIl+xY0m3Wo0ANGTH3P/hzeIo6JvSE+a0UIYYz+sTsBAp8/kzTvTnzbi71/l/7R0i04ZfG8Q7gCtE3ymSHi4QotnDaqATwSePt6SzCUYW4zEKe4TTiQAX+0s2ojeIK/WZz/BVOlYgnuG2DRZQWQHhJmLME5shEEbdpX6zskBrRmW6C1txEiguKm89w9s9Ux3PcZjVlWvGhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=calian.com; dmarc=pass action=none header.from=calian.com;
 dkim=pass header.d=calian.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOUnmXTcGMbnCLoLt9WjCaR9f1/NH7ZwK8mCSF+rAR8=;
 b=Hbcl/DtJlBSb9nVU3XQqlu9bpgs2QM2tQtmzugN+W5fZ7ipK4uxUgUpXvd3H6Iy5Jm5WHJREldsAzcIgq7TWS1z05uJobdCHomOgxhso4nTBInkePvnUl7BBnICHb1J6OIc5QfyWFw9Cngh3mTmukAzIcZmfvX/qrMbTOnTzu44=
Received: from YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b9::6)
 by YT3PR01MB6196.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 16:00:22 +0000
Received: from YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7dd8:39d3:3f11:59f]) by YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::7dd8:39d3:3f11:59f%3]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 16:00:22 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "nbowler@draconx.ca" <nbowler@draconx.ca>,
        "edumazet@google.com" <edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: PROBLEM: Broken or delayed ethernet on Xilinx ZCU104 since 5.18
 (regression)
Thread-Topic: PROBLEM: Broken or delayed ethernet on Xilinx ZCU104 since 5.18
 (regression)
Thread-Index: AQHZxurDTj0YCOtCPUq9rlcU+Pg8mq/glQiA
Date:   Tue, 8 Aug 2023 16:00:22 +0000
Message-ID: <efeee3765f8177bfde3c845face67757d383e4ef.camel@calian.com>
References: <CADyTPEzqf8oQAPSFRWJLxAhd-WE4fX2zdoe9Vu6V9hZMn1Yc8g@mail.gmail.com>
         <3a3a53ec-81c0-c5f7-3c37-2c07212a6330@leemhuis.info>
In-Reply-To: <3a3a53ec-81c0-c5f7-3c37-2c07212a6330@leemhuis.info>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT2PR01MB8838:EE_|YT3PR01MB6196:EE_
x-ms-office365-filtering-correlation-id: c84dcb4c-f725-47c8-8e75-08db98289250
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l+pyHIaqks1kMAAdK9BAAQEUzhKkjbHsvTUEBXBrNGZ4j7uAlO0u3nUneDzzBYtUhJ82lZtv/t92Q9yPK6+eMzHCUZwpDSIT1UWKqR8BkE//E2zVHcqQ+O7vZdgpbtb3iFBBjxC3oSPrZMLd/3s8/jOc+IPVlkWerxsgZ6ae7R3GSfsXhUMD9jEkMSj1miBGMmaBBDz4aMBtykHfVPx1nkJaoe3jNoj78RxsLWalzfi5rIbb42x7tqqpYFoVEXnHVftf3sdfxdzeQPmwRxoCwfawpfxBSBzpattef64M5ir05SUqpob0A18TcxltsAEFMk3HMTyzklHELjQ4d/rXOF/psKrGpoICSM/bdB4dYpMIH11DimsOcibsPYoa9j8v6fN6ShVU9x8/XnkrqBhKM0q69Gmi70fv1Njq7HmyiLxntnk9NZRhoWUVRyOeFWXC6nwSyAVrAz1ua3xYMC52ThePNBsrYyWsxnP5S85BRzz92TSVkacxshMLrGqwLD19C8PLnRdhduHavsfGQHEy8D0pvo0hfRvZIz1kFnxE3jjFYMchxjwMh+g6+CdAW5KHprWv46EcBmEWqT89NNGT4CXcNf+sshPI5MQzU4txyfg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(186006)(1800799003)(451199021)(2616005)(36756003)(53546011)(6506007)(6486002)(71200400001)(966005)(6512007)(122000001)(478600001)(45080400002)(54906003)(38100700002)(91956017)(66476007)(66946007)(66556008)(76116006)(64756008)(6916009)(66446008)(4326008)(316002)(66899021)(41300700001)(8936002)(8676002)(5660300002)(38070700005)(44832011)(2906002)(83380400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTlzSjdSOVNpdVBUQkw5WGJQRmlNUkVNTlBrOHMwakxNWCtnY2tjVm9mc3Z6?=
 =?utf-8?B?Y1NFdnQ5dlF6Q291Z2VvK1ZtMC9yU3VLeVhkLzBhZzNCMUNtdlVmZjNwQ3dC?=
 =?utf-8?B?bnVXQ2Rlay90bGx1N1dmSXlKeU9WRkNFc0grMEZ3QUIvRk1VMFZnNnZnK05F?=
 =?utf-8?B?MXdvSWExT2tibEgxQ1FVNzA4NHRNYWgybjk3ekRxNzlSNEp1MFFMU2tHMFFz?=
 =?utf-8?B?UUlpSmhJNU9Pc2IxeTQ4ZTVwYnJZVUxsc01xYmRydmdwYzdkOTlZUEJiRWI5?=
 =?utf-8?B?bjNaWUovVXVTZFZMaWhRdCtBTVNhT3Z3TTU2UmYwVmZGUVZ4YWswc2xSZTdX?=
 =?utf-8?B?YmRGM1l2N1FkZytnZlhYd21MeGtzaDlQWkNCcjNERFdyUmRzbnQxWEEvM2Za?=
 =?utf-8?B?SWlXU09TYUpldkwrQUhLaHA1MlFZYW9lNlF0TkNHRWkxdzl3MFZtaFJ5L0dD?=
 =?utf-8?B?MGYyOGgyOElwNUVvdVFVQXlLZE1QMU9XaU5vdUZWZ1dlbUNHamJYbnVyVDZK?=
 =?utf-8?B?UHBVWEVuVjRUT2lwSXZMLzRCTGJOVHlpV3UxbTVqNU9veVFhYTdTOUVzTWlB?=
 =?utf-8?B?MHVjUXZyMnQvNDdBdXBiTS9IblJiL2dMZ3czVno1aFV2V2xjUVVBMmpCbmFZ?=
 =?utf-8?B?TnlZelhjRFlUZDJRcWZkZnM2VEZJZzJKcnI0UzdwZVJ5QVBHT2tMTkJvcHZL?=
 =?utf-8?B?ZUNKMmh1U29MbWdzalZoQVQxZDVVd3V6WlpXNGozSmYzSFFXT05YRjhkWGdL?=
 =?utf-8?B?RVhtcW9XN1pyNVUxMExYMUJuN2hKbGxoeGVJaU94cXRCcFdEODNYbVh2VU5N?=
 =?utf-8?B?QjFhdndqc1RjNWZuRFJiSzVWVS9BRytKTk5qNi9QNXVSdXk2SHZHTjloTUcr?=
 =?utf-8?B?NjZPbkxGM0p6c1h4SUd6RGN1N3NTU3E0L3VxOXdIZjZTV3pkejFiaFlycG15?=
 =?utf-8?B?a0MySEJZaytEcEIveC83bUE5TEk2cCtmM0IxUjcvN2hHUTZveUREVFhkcElE?=
 =?utf-8?B?Zi9LSVIyU2hSc2xLUDdFUHMrck10aUg5SG5uYy9pemFZQmp3MksxanFtNDhX?=
 =?utf-8?B?bHhKRWJFaEpnMGlPTHRFUkd2L2FESWJnaXNucE5mSUE3RlV3emlOUTFHa1B5?=
 =?utf-8?B?cENkMmJYc1RvVVNuZ1BHRG1FUTRHT1YyL2cycS9GaStWMU1KNzFlMEU3VmQ0?=
 =?utf-8?B?bGJxM0Ixekp4TEZ3bzRYRmtHYVZad0MwREgyUmJVR3V0VlFnSXd0Y21xSEdD?=
 =?utf-8?B?L1FObHhtSXBHOWlPMlBFby9FeDN3czVXaE1kZHEyVC9FVFljZXFNOXJlTjFE?=
 =?utf-8?B?SFNwYzJHWWgwSkVYN3JuUTRUVWZDS0hUQlY4dzlPWnJpVjNiczFMU0hrM082?=
 =?utf-8?B?YkdLNUVkMFRhaHgveUJOZjZVMjNVY3oySWVLN2htcU1pWjQxOWhPcGJPWjc2?=
 =?utf-8?B?aVF0dGhqbnFiNWpyNjVuZ00xazFMY2UrRG44cEt0Um5ydTVqZzhCWnN0YjFy?=
 =?utf-8?B?OGl6V1VzVTBObXdjQkJXNDVJT1FNR2kvc2x3M2Y1bzlUTXY2ZmhqMjJGSWlE?=
 =?utf-8?B?dlNUa0c2ZUUxbFVPVFQ5V1JiZWJNU3FDamx5QnNpdXplSVhDcTE4THJndUtF?=
 =?utf-8?B?VEhBOGRPNG10SEhidnB3ajEyQ1ZYM0w1dW1PMStSb0FtM1h0UnNmNzV5YVBz?=
 =?utf-8?B?UUhhT1BvWi83U0dDUnZRazBYdEZ5UTNoZWYxWTR4cG5UZTNnSFBKVFUwY2xO?=
 =?utf-8?B?OC83TnZENFBLUW1RK255RHRHcFU1dklDUkpuSUpaTEJHdHljVEhBV0JCVFdT?=
 =?utf-8?B?VUNvZkFzZmNUTDBPLy92Zk9MQTN5ZXdPYzNRbnFXeDl4WGl2VG4vdW5QZ29N?=
 =?utf-8?B?VGJPd1JDaUlqMnlRVTlmVzVxWnhOd2xpREFjak90SEFJWEQyMFJGZUpBdGV4?=
 =?utf-8?B?MW5VcWw4NVhVTC9Ta2hLU2l1S3hNbys5TS82WG1ZRFp5bjdrY0pXS3ROcmUy?=
 =?utf-8?B?YzZnenp0RlBDWHVqZU1UZS9BZzFkZDFBVmpnRjdHZS9MdG1MQ2VzSGw0RE1x?=
 =?utf-8?B?VHZOb1JXdzFOdGRidnBHWHB3cnM3MVZ6OXBzRllOVjhCQzFVM003NnBBNmhk?=
 =?utf-8?B?U3YxV1R2VFVVdk5LOHgwOUZNb05vRnV2clZyS2lqWG1Jb2NKLzlFUTRGdlFV?=
 =?utf-8?B?ZkRlVC9pVmZ4UFhVMWdEYXdPS3E4TjlTeEZ2VjI0ZUZBL2Y3ZGZsT1czRTM2?=
 =?utf-8?B?czVsazVvRlJwQTFKMkhjcnpUWkR3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA7426317A648040A73433A63DE12B23@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Vng3VEpxOGloZWlMNW1pcVZBelZtajJscUhUT1dnK2x3Z2luTnZFM0NWdjM5?=
 =?utf-8?B?WmNDYy9Bd2IwWWZTaHpLSytzQk5IZk8xQjllOUtaOEZXeU0yZ09KUTEyREQ0?=
 =?utf-8?B?ekxvaGYxa2hZdDhWWkZhbGsrdGtDZWwvdEpvK1pqSXNvSWFRbDFWd2FZSzM4?=
 =?utf-8?B?ckJiNmxFUVk2T25lVGIrK2RlMXV0TUlzSWhwcDRWdlhjV3Y3YkRQdmxuTE54?=
 =?utf-8?B?S3BGWTBVWkRnZmQxNjZtM0oxaTJ5YWNFZU9zMmUwOW9yWkFpZUhBWjdSN2Ry?=
 =?utf-8?B?SDdSaXYyajdVRHQzaTU2aHBkcUc2cklXQWlQUVZhUmdyOFFtL2t5enFPTVps?=
 =?utf-8?B?T0hiSTNZOWVTV3BTWnhHRkREbkEwQW1LcmRIZnZhQWM5eXNaaVVkMHRuZGtH?=
 =?utf-8?B?QVh3TFAxZUZaTEdqbjFUNEZsd2VDVDlYbWp2emFJVTFpVHB2TTZBQlRjTkE4?=
 =?utf-8?B?VUw0RUNOSzA3dERNTHBVOGx6S0tLelpKSk0vZlIzc01meVFrMHhjYnMrZFhy?=
 =?utf-8?B?MjJQcCttYnhHUmJJUjd4WEZNakQ0RkRnZTFTbzNhbkN6Si9PYUhwQmt4QWhl?=
 =?utf-8?B?M0Q3R2p0Z041SFJsRlAydS9GTjZJalhWMEVKL3dPTy9LenQrWitFTE1pU3hy?=
 =?utf-8?B?NnlpazBYL3RITVdGdFM4TXo2R1NYeW95YmxVZ0F5b0k0ZDN2aGZ5TXNKMUMz?=
 =?utf-8?B?YUlxM0pQVnZmZTd5UERWeWpWTmg0c0U0dXlwb1pWYVBzRlplNkd5UlRQVFl2?=
 =?utf-8?B?MEdIR0xXTVFoTmJXcno5SHJJekJQZlJjcHBVM0l6S2tvMlluZXp3cythVVJp?=
 =?utf-8?B?OGM3djA2TnF2V2hpbHZtaFc3VTl4LzVrV3I5dk1iSDJPcVNRcm9vQ3RjTSs1?=
 =?utf-8?B?UnZmT1Q3bGJmaE9aZEc1bTd0aEJKNWlHT3FobFhKS055VU5ibUtxeHhNVDJU?=
 =?utf-8?B?bWd5NWNvMEdpaTdCOWx3SDFrWk03TGhsRXRLQjhzdmQxVUFvMVdWWGpIM0Ry?=
 =?utf-8?B?TjJGSS8vem1RU3AvRGg1UFAxU1cwVWlZYllPU0ZVWWJDUVNpTEtHZVIyUUhq?=
 =?utf-8?B?T3pJUW5RNXIzS3BwNHVFZmIrRUpEd2ZxNzdSQjBnRkJJcU9HbW5xdWVSN0dP?=
 =?utf-8?B?RUtpbmZMNDA0ZXk5MlRVd0p0M3JYb1JRc0ViSHEzYmtiWHVGNTNuZkNqTDVQ?=
 =?utf-8?B?RkRRaTdvdEp0d1c5RCtnNlBjSmVwbTM3T1E5WTlBV0RsMFBvWW5NZlRTQURH?=
 =?utf-8?B?WldFQVltendtbFRmaDJtOVo0RHdNQUYyMkpuaFZ2bjVTSWh6dFJ5YVZBc0lv?=
 =?utf-8?Q?Lmwdhvo5eqFXJWJ4vDkwScQXqcaWAHTbuQ?=
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB8838.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c84dcb4c-f725-47c8-8e75-08db98289250
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 16:00:22.3824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sKPq5tVohia/LBGbFU9OVbS/4AnOImbp3chAEGlzexx3Ye0jn8nx68vPkixCFhGMxnxRN04Wyu/fUofrV2NJd5ub3hRqLefMf9jPEl/+fro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6196
X-Proofpoint-ORIG-GUID: Ljjt4miG1mqkv0gliEVjhpytv8lZq1gi
X-Proofpoint-GUID: Ljjt4miG1mqkv0gliEVjhpytv8lZq1gi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_14,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 clxscore=1011 phishscore=0 mlxscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308080144
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA4LTA0IGF0IDE3OjQ1ICswMjAwLCBMaW51eCByZWdyZXNzaW9uIHRyYWNr
aW5nIChUaG9yc3Rlbg0KTGVlbWh1aXMpIHdyb3RlOg0KPiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9y
aWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6YXRpb24uIERvDQo+IG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5k
ZXINCj4gYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IFthZGRpbmcgUm9iZXJ0
IEhhbmNvY2sgKHRoZSBhdXRob3Igb2YgdGhlIGxpa2VseSBjdWxwcml0KSB0byB0aGUgbGlzdA0K
PiBvZg0KPiByZWNpcGllbnRzIGFzIHdlbGwgYXMgdGhlIG5ldHdvcmsgbWFpbnRhaW5lcnNdDQo+
IA0KPiBbVExEUjogSSdtIGFkZGluZyB0aGlzIHJlcG9ydCB0byB0aGUgbGlzdCBvZiB0cmFja2Vk
IExpbnV4IGtlcm5lbA0KPiByZWdyZXNzaW9uczsgdGhlIHRleHQgeW91IGZpbmQgYmVsb3cgaXMg
YmFzZWQgb24gYSBmZXcgdGVtcGxhdGVzDQo+IHBhcmFncmFwaHMgeW91IG1pZ2h0IGhhdmUgZW5j
b3VudGVyZWQgYWxyZWFkeSBpbiBzaW1pbGFyIGZvcm0uDQo+IFNlZSBsaW5rIGluIGZvb3RlciBp
ZiB0aGVzZSBtYWlscyBhbm5veSB5b3UuXQ0KPiANCj4gT24gMDQuMDguMjMgMTc6MjYsIE5pY2sg
Qm93bGVyIHdyb3RlOg0KPiA+IEhpLA0KPiA+IA0KPiA+IFdpdGggcmVjZW50IGtlcm5lbHMgKDUu
MTggYW5kIG5ld2VyKSB0aGUgZXRoZXJuZXQgaXMgYWxsIHdvbmt5IG9uDQo+ID4gbXkNCj4gPiBa
Q1UxMDQgYm9hcmQuDQo+ID4gDQo+ID4gVGhlcmUgaXMgc29tZSBiZWhhdmlvdXIgaW5jb25zaXN0
ZW5jeSBiZXR3ZWVuIGtlcm5lbCB2ZXJzaW9ucw0KPiA+IGlkZW50aWZpZWQNCj4gPiBkdXJpbmcg
YmlzZWN0aW9uLCBzbyBtYXliZSB0aGVyZSBpcyBtb3JlIHRoYW4gb25lIGlzc3VlIHdpdGggdGhl
DQo+ID4gZXRoZXJuZXQ/DQo+ID4gDQo+ID4gwqAgNi41LXJjNDogYWZ0ZXIgMTAgc2Vjb25kcywg
dGhlIGZvbGxvd2luZyBtZXNzYWdlIGlzIHByaW50ZWQ6DQo+ID4gDQo+ID4gwqDCoMKgIFvCoMKg
IDEwLjc2MTgwOF0gcGxhdGZvcm0gZmYwZTAwMDAuZXRoZXJuZXQ6IGRlZmVycmVkIHByb2JlDQo+
ID4gcGVuZGluZw0KPiA+IA0KPiA+IMKgIGJ1dCB0aGUgbmV0d29yayBkZXZpY2Ugc2VlbWluZ2x5
IG5ldmVyIGFwcGVhcnMgKEkgd2FpdGVkIGFib3V0IGENCj4gPiBtaW51dGUpLg0KPiA+IA0KPiA+
IMKgIDYuMSBhbmQgNi40OiBhZnRlciAxMCBzZWNvbmRzLCB0aGUgZGV2aWNlIHN1ZGRlbmx5IGFw
cGVhcnMgYW5kDQo+ID4gc3RhcnRzDQo+ID4gwqAgd29ya2luZyAoYnV0IHRoaXMgaXMgd2F5IHRv
byBsYXRlKS4NCj4gPiANCj4gPiDCoCA1LjE4OiB0aGUgZGV2aWNlIG5ldmVyIGFwcGVhcnMgYW5k
IG5vIHVudXN1YWwgbWVzc2FnZXMgYXJlDQo+ID4gcHJpbnRlZA0KPiA+IMKgIChJIHdhaXRlZCB0
ZW4gbWludXRlcykuDQo+ID4gDQo+ID4gV2l0aCA1LjE3IGFuZCBlYXJsaWVyIHZlcnNpb25zLCB0
aGUgZXRoMCBkZXZpY2UgYXBwZWFycyB3aXRob3V0IGFueQ0KPiA+IGRlbGF5Lg0KPiA+IA0KPiA+
IFVuZm9ydHVuYXRlbHksIGFzIGJpc2VjdGlvbiBjbG9zZWQgb24gdGhlIHByb2JsZW1hdGljIHNl
Y3Rpb24sIGFsbA0KPiA+IHRoZQ0KPiA+IGJ1aWx0IGtlcm5lbHMgYmVjYW1lIHVudGVzdGFibGUg
YXMgdGhleSBhcHBlYXIgdG8gY3Jhc2ggZHVyaW5nDQo+ID4gZWFybHkNCj4gPiBib290LsKgIE5l
dmVydGhlbGVzcywgSSBtYW51YWxseSBzZWxlY3RlZCBhIGNvbW1pdCB0aGF0IHNvdW5kZWQNCj4g
PiByZWxldmFudDoNCj4gPiANCj4gPiDCoCBjb21taXQgZTQ2MWJkNmY0M2Y0ZTU2OGY3NDM2YThi
NmJjMjFjNGNlNjkxNGMzNg0KPiA+IMKgIEF1dGhvcjogUm9iZXJ0IEhhbmNvY2sgPHJvYmVydC5o
YW5jb2NrQGNhbGlhbi5jb20+DQo+ID4gwqAgRGF0ZTrCoMKgIFRodSBKYW4gMjcgMTA6Mzc6MzYg
MjAyMiAtMDYwMA0KPiA+IA0KPiA+IMKgwqDCoMKgwqAgYXJtNjQ6IGR0czogenlucW1wOiBBZGRl
ZCBHRU0gcmVzZXQgZGVmaW5pdGlvbnMNCj4gPiANCj4gPiBSZXZlcnRpbmcgdGhpcyBmaXhlcyB0
aGUgcHJvYmxlbSBvbiA1LjE4LsKgIFJldmVydGluZyB0aGlzIGZpeGVzIHRoZQ0KPiA+IHByb2Js
ZW0gb24gNi4xLsKgIFJldmVydGluZyB0aGlzIGZpeGVzIHRoZSBwcm9ibGVtIG9uIDYuNC7CoCBJ
biBhbGwNCj4gPiBvZg0KPiA+IHRoZXNlIHZlcnNpb25zLCB3aXRoIHRoaXMgY2hhbmdlIHJldmVy
dGVkLCB0aGUgbmV0d29yayBkZXZpY2UNCj4gPiBhcHBlYXJzDQo+ID4gd2l0aG91dCBkZWxheS4N
Cg0KSGkgTmljaywNCg0KSWYgdGhpcyBjaGFuZ2UgdHJpZ2dlcmVkIHRoZSBwcm9ibGVtLCB0aGVu
IEkgd291bGQgc3VzcGVjdCB0aGVyZSdzIGFuDQppc3N1ZSB3aXRoIGVpdGhlciB0aGUgenlucW1w
X3Jlc2V0IGRyaXZlciBpdHNlbGYsIG9yIHNvbWV0aGluZyBpdCdzDQpkZXBlbmRlbnQgb24sIHNv
bWVob3cgbm90IGJlaW5nIGVuYWJsZWQgaW4geW91ciBrZXJuZWwgY29uZmlndXJhdGlvbi4NCklm
IHRoZSBkZXZpY2UgdHJlZSBoYXMgYSByZWZlcmVuY2UgdG8gdGhhdCByZXNldCBkZXZpY2Ugbm9k
ZSBhcw0KcHJvdmlkaW5nIGEgcmVzZXQgYnV0IHRoZSBkcml2ZXIgZm9yIHRoYXQgZGV2aWNlIGhh
c24ndCBsb2FkZWQgeWV0LA0KdGhlbiB0aGUgcHJvYmUgd2lsbCBrZWVwIGJlaW5nIGRlZmVycmVk
IGluIHRoZSBob3BlIHRoYXQgZXZlbnR1YWxseQ0KdGhhdCBkcml2ZXIgd2lsbCBiZSByZWFkeSwg
YnV0IGlmIGl0J3Mgc29tZWhvdyBkaXNhYmxlZCBvciBoYXMNCnVuc2F0aXNmaWVkIGRlcGVuZGVu
Y2llcywgaXQgbmV2ZXIgd2lsbCBiZS4NCg0KSSdtIG5vdCBzdXJlIHdoeSB5b3UncmUgc2VlaW5n
IGl0IHN0YXJ0IHdvcmtpbmcgYWZ0ZXIgMTAgc2Vjb25kcyBpbg0Kc29tZSB2ZXJzaW9ucyBhbmQg
bm90IGF0IGFsbCBpbiBvdGhlcnMsIGhvd2V2ZXIuDQoNCkNhbiB5b3UgcHJvdmlkZSB0aGUga2Vy
bmVsIC5jb25maWcgeW91IGFyZSB1c2luZz8NCg0KPiA+IA0KPiA+IFVuZm9ydHVuYXRlbHksIGl0
IHNlZW1zIHRoaXMgaXMgbm90IHN1ZmZpY2llbnQgdG8gY29ycmVjdCB0aGUNCj4gPiBwcm9ibGVt
IG9uDQo+ID4gNi41LXJjNCAtLSB0aGVyZSBpcyBubyBhcHBhcmVudCBjaGFuZ2UgaW4gYmVoYXZp
b3VyLCBzbyBtYXliZSB0aGVyZQ0KPiA+IGlzDQo+ID4gYSBuZXcsIGRpZmZlcmVudCBwcm9ibGVt
Pw0KPiA+IA0KPiA+IEkgZ3Vlc3MgSSBjYW4ga2ljayBvZmYgYW5vdGhlciBiaXNlY3Rpb24gdG8g
ZmluZCBvdXQgd2hlbiB0aGlzDQo+ID4gcmV2ZXJ0DQo+ID4gc3RvcHMgZml4aW5nIHRoaW5ncy4u
Lg0KPiA+IA0KPiA+IExldCBtZSBrbm93IGlmIHlvdSBuZWVkIGFueSBtb3JlIGluZm8hDQo+IA0K
PiBUaGFua3MgZm9yIHRoZSByZXBvcnQuIFRvIGJlIHN1cmUgdGhlIGlzc3VlIGRvZXNuJ3QgZmFs
bCB0aHJvdWdoIHRoZQ0KPiBjcmFja3MgdW5ub3RpY2VkLCBJJ20gYWRkaW5nIGl0IHRvIHJlZ3pi
b3QsIHRoZSBMaW51eCBrZXJuZWwNCj4gcmVncmVzc2lvbg0KPiB0cmFja2luZyBib3Q6DQo+IA0K
PiAjcmVnemJvdCBeaW50cm9kdWNlZCBlNDYxYmQ2ZjQzZjRlNQ0KPiAjcmVnemJvdCB0aXRsZSBu
ZXQvYXJtNjQ6IGR0czogQnJva2VuIG9yIGRlbGF5ZWQgZXRoZXJuZXQgb24gWGlsaW54DQo+IFpD
VTEwNA0KPiAjcmVnemJvdCBpZ25vcmUtYWN0aXZpdHkNCj4gDQo+IFRoaXMgaXNuJ3QgYSByZWdy
ZXNzaW9uPyBUaGlzIGlzc3VlIG9yIGEgZml4IGZvciBpdCBhcmUgYWxyZWFkeQ0KPiBkaXNjdXNz
ZWQgc29tZXdoZXJlIGVsc2U/IEl0IHdhcyBmaXhlZCBhbHJlYWR5PyBZb3Ugd2FudCB0byBjbGFy
aWZ5DQo+IHdoZW4NCj4gdGhlIHJlZ3Jlc3Npb24gc3RhcnRlZCB0byBoYXBwZW4/IE9yIHBvaW50
IG91dCBJIGdvdCB0aGUgdGl0bGUgb3INCj4gc29tZXRoaW5nIGVsc2UgdG90YWxseSB3cm9uZz8g
VGhlbiBqdXN0IHJlcGx5IGFuZCB0ZWxsIG1lIC0tIGlkZWFsbHkNCj4gd2hpbGUgYWxzbyB0ZWxs
aW5nIHJlZ3pib3QgYWJvdXQgaXQsIGFzIGV4cGxhaW5lZCBieSB0aGUgcGFnZSBsaXN0ZWQNCj4g
aW4NCj4gdGhlIGZvb3RlciBvZiB0aGlzIG1haWwuDQo+IA0KPiBEZXZlbG9wZXJzOiBXaGVuIGZp
eGluZyB0aGUgaXNzdWUsIHJlbWVtYmVyIHRvIGFkZCAnTGluazonIHRhZ3MNCj4gcG9pbnRpbmcN
Cj4gdG8gdGhlIHJlcG9ydCAodGhlIHBhcmVudCBvZiB0aGlzIG1haWwpLiBTZWUgcGFnZSBsaW5r
ZWQgaW4gZm9vdGVyDQo+IGZvcg0KPiBkZXRhaWxzLg0KPiANCj4gQ2lhbywgVGhvcnN0ZW4gKHdl
YXJpbmcgaGlzICd0aGUgTGludXgga2VybmVsJ3MgcmVncmVzc2lvbiB0cmFja2VyJw0KPiBoYXQp
DQo+IC0tDQo+IEV2ZXJ5dGhpbmcgeW91IHdhbm5hIGtub3cgYWJvdXQgTGludXgga2VybmVsIHJl
Z3Jlc3Npb24gdHJhY2tpbmc6DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczov
L2xpbnV4LXJlZ3RyYWNraW5nLmxlZW1odWlzLmluZm8vYWJvdXQvKnRsZHJfXztJdyEhSU9Hb3Mw
ayFsZ0VJalJnN1p0QzBWNjhqaU9WSW1nMnlWdXExakVNbnBibVR3SFhSN3hOWnVCY1NmdFgwUDlo
U2NXTTNyOWFmWkpmUHIzRVlKdURfTU56Q3A4cGFEMUVHSGU3YWtBJA0KPiBUaGF0IHBhZ2UgYWxz
byBleHBsYWlucyB3aGF0IHRvIGRvIGlmIG1haWxzIGxpa2UgdGhpcyBhbm5veSB5b3UuDQoNCi0t
IA0KUm9iZXJ0IEhhbmNvY2sgPHJvYmVydC5oYW5jb2NrQGNhbGlhbi5jb20+DQo=

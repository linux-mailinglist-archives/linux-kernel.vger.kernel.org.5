Return-Path: <linux-kernel+bounces-25742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B3A82D533
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEEA3281C18
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B8063DA;
	Mon, 15 Jan 2024 08:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="TJrp23rW"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2105.outbound.protection.outlook.com [40.107.117.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EA26FA1;
	Mon, 15 Jan 2024 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFfk6Hnn4JdYKapeAPa0hpq9qVIHl1WXJufI82CzpQnjfd97qesAENR/h8XZuRllf0y2rBMo8aB5znB4f13yGBGNCxTQCCC1La1IaqR1zFm6ufjx5PhBhePksFpVeoPs0odLXzLwngVdUAW6APpbORO1Loid+scLVPzQN82EsYjYrANOlw1YnqrdiulRWGVfmh3G6+zE+S2LMIqKN4NV7j5Fnr7wli+Pwf40ecsIkKDLk6GcoZ8cI7lEnSDgI6pHIib0MAAKCyj4wL+H0Ihn0tvcT/Gi91zvdrHxsncgQUoEwWJtLII+5XH2ZnSq1npTXAxf0AESWQdgI4yJjDMV7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRCWbulzf0TeqVgiB0AF33LAS9x5mZSborVRjlm7xnU=;
 b=gGtY2SzuZcRdyhJqsjNOKnDdxZaD/jd2nvH59/kcmfOyJum0990WFKneciD3pxdV65jqfLczIKkwUKRoslcBThlLDp4cf1DWSzyAnOSgjE2DKfcPvkoNThyK07SKqwNqDbbOxtWbhuDqScvBcL6/9eKeO11uECXnO/zgzx6xXXS/DIwt7fgFwohmbiYft7HbIF+c2Gn4KXUm/keZ7afEx+aDNzcw5zzjxFneP/CnPhLcu+PoRcfb8gF0eIlM3T5S/l1qOsewr1WEzb81bnnL+AhMjTcWETgGxF8S2TL6jIFu7UiHbPt+NCV3nnfmzOdfTxME2YffUj4zfW5yKQLPzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRCWbulzf0TeqVgiB0AF33LAS9x5mZSborVRjlm7xnU=;
 b=TJrp23rW30Epv0QMCR5OXBbVam0+89ZXSYCVdNAWzBWD1RWKCTSPob7QWmzjuA4wWzy080BkSvAsgOqwt3j/ckXgBRJIynsVn6we2LZhyAWX7Fi3GMs9dlPxhW1xabzxNqu1fXr8gNsoLfQJAA7C7PzFnu1W6nANObAych7bPcRiQEckXWoxjdk+P8dgwrz+rniZUvp2EeHgkuGME1X1L3xqV+GZDK8oSPPYm5xp0W1mkAdUcodGyfXlvTMRIHTCN3QRAr9eFnZdOJhAxQE408aTXTxwYVNKNl8wmGo13cQO/UuW5qxd0KxhCLpXsV/l1pk0EafS7PSFX4zTQGJsfg==
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com (2603:1096:604:29c::6)
 by SEZPR06MB5592.apcprd06.prod.outlook.com (2603:1096:101:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Mon, 15 Jan
 2024 08:43:09 +0000
Received: from OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::36df:4bd:1991:976b]) by OSQPR06MB7252.apcprd06.prod.outlook.com
 ([fe80::36df:4bd:1991:976b%5]) with mapi id 15.20.7181.018; Mon, 15 Jan 2024
 08:43:09 +0000
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring
	<robh@kernel.org>
CC: "jdelvare@suse.com" <jdelvare@suse.com>, "linux@roeck-us.net"
	<linux@roeck-us.net>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "joel@jms.id.au" <joel@jms.id.au>,
	"andrew@aj.id.au" <andrew@aj.id.au>, "corbet@lwn.net" <corbet@lwn.net>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"naresh.solanki@9elements.com" <naresh.solanki@9elements.com>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, BMC-SW <BMC-SW@aspeedtech.com>,
	"patrick@stwcx.xyz" <patrick@stwcx.xyz>
Subject: Re: [PATCH v12 2/3] dt-bindings: hwmon: Support Aspeed g6 PWM TACH
 Control
Thread-Topic: [PATCH v12 2/3] dt-bindings: hwmon: Support Aspeed g6 PWM TACH
 Control
Thread-Index: AQHaQgZuUE5b5SSLEUGoux677v5Ay7DXAz4AgAN4T2CAABEVgIAAANU/
Date: Mon, 15 Jan 2024 08:43:09 +0000
Message-ID:
 <OSQPR06MB72520BD77D68B7940273F2498B6C2@OSQPR06MB7252.apcprd06.prod.outlook.com>
References: <20240108074348.735014-1-billy_tsai@aspeedtech.com>
 <20240108074348.735014-3-billy_tsai@aspeedtech.com>
 <20240113015556.GA3829553-robh@kernel.org>
 <OSQPR06MB725208AEF8779B0BC971DFF48B6C2@OSQPR06MB7252.apcprd06.prod.outlook.com>
 <40210196-3852-4c8b-94e6-e744890f003f@linaro.org>
In-Reply-To: <40210196-3852-4c8b-94e6-e744890f003f@linaro.org>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSQPR06MB7252:EE_|SEZPR06MB5592:EE_
x-ms-office365-filtering-correlation-id: 84105c39-4753-406c-b06f-08dc15a6003c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 adYEqprLDkLPVo3ZCmjYAEefhwr3hxgLrVO+3zm+2XmF5g0xU1IbvHp9hNd6Qw5fkY1KiLFw1enMrcPNRobYYj4f57qct0mRmTrpsDWZ9g2aWsnCK1PYTjUhNJhapK1pnUS7DS74oxAPK8nQOZ4uHGOdvIvNoJQEJpAHhupOAWeyY/ncLeatYawmD503mdqvrEA9J0G8JOvE1h9Mq7tnUyB16LK6+S456aiiqeP6N5G/q8nmdxjhF7//wxBq0SuG2+r3HYv4ZB3RiJtGIqUjHqsWgkUGAAzEtxMeURF6+dP8yBDJVTBPtInMHnksMsjlz5yMSt8by98OaqGxDIoE42NsKetnchjb4PXlRTRN3QUSmAjv26rLqFbv3XgZATpMDAg3TD5VZEzzUCo2o6G54VRiz9vGvCYyn8PVPVJGSLfZhduUQbADDaksxvgVUq8A2xbH6rPY56HWM9jWzSAX8MUfEhp9bzRWwtY+2HE4Rr8IqPgyrHyT8l8dnfE/gVQ+UuiReVArUGg18GMTYqQ3NP3B7/yekFcFJl6EQ3ghvS97t1niCtyJeTP/RCnjFjMiU0OPxKtaONkYzs/hZCyHnxKVRLvQeEWy4h9ztz8r4YVQSflUbcFCdXhQ/Sk5C4Gy
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSQPR06MB7252.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39850400004)(376002)(366004)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(55016003)(64756008)(2906002)(7416002)(5660300002)(66946007)(66476007)(8676002)(8936002)(41300700001)(316002)(71200400001)(52536014)(76116006)(110136005)(54906003)(9686003)(66556008)(66446008)(4326008)(478600001)(122000001)(33656002)(26005)(86362001)(38100700002)(38070700009)(55236004)(7696005)(83380400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7T49JpnUmm3/m26G8phn7p6m05DJvoax2h6Sqmfdw/+4Zq/E7Vr/qHltYl?=
 =?iso-8859-1?Q?gPAjyDsAqLvveaUa3Z+zzknP3WLrgjxie+enl9VSGKQHdakxeUFEnsCiII?=
 =?iso-8859-1?Q?KvKWnyUw10xpGHozDk2CfkR1bNjzAWnE1P2B4Yq+qZ+BYtnqkgzv6dK6IN?=
 =?iso-8859-1?Q?4YAWgB+vJTLR0tNWVsrl6+Aiz5FK0Yw2TgaIyQmeMeaWha9UTsDzOulJwN?=
 =?iso-8859-1?Q?HBnX2CYOwJvpNCqP0HNI6YQd+UKl5DKXv+USbE4gp60rGj0p7k4Npoz7ac?=
 =?iso-8859-1?Q?Tn1BLAoTCnEgPRG3cTZ5SGswvcPu0cYGeTuw6R5WrnKUTh/rBcz0CEIhiy?=
 =?iso-8859-1?Q?HDlmpGjXSfLi3HFujDzuHsCRUFuC4fb45Bvd4k2C1VzsybQMAheBNC7m0Z?=
 =?iso-8859-1?Q?QCTPMI14V8B3I7q+nfwIbOz7GXoVLodYFn/m7WyKB7JaOhjHEB4LU+9Ff6?=
 =?iso-8859-1?Q?qLZZ8DiWjE7fH7D1WKiWB3W4qJLjkhjdi4W4YJTDCOzGYyTSKvrgsF2T7w?=
 =?iso-8859-1?Q?JIEmqwS8txUAEMR5/xtqTiIS18WyfwjErPEcnP4u4HOhIALMUtm6mwsc8e?=
 =?iso-8859-1?Q?YJsxDJrWhZedTz9crTj/gfku7XAE2VQFiZ3BOIx40HZbF/8iSIoZmV2qON?=
 =?iso-8859-1?Q?9L/BL9Mvp4PR/wIi2nl8PrrhSnzYTkRFtUohauJf8pZEXihZhr7ySKNfdf?=
 =?iso-8859-1?Q?REVJ/EuduXW2RrLt6cvKf1oIu1sRPo3XIOCsga9aRKE14RwvT3xE+9WKLB?=
 =?iso-8859-1?Q?foveT9AdjB9D0351f/xScWJsHGEEnfPzn3WVk3nVOMetNIgjzwWExxLF84?=
 =?iso-8859-1?Q?UVUzmv5vU5paSmOYw989+sMVwxHSE3na9fWWcFPBs0HQmXdwFORZrPsrne?=
 =?iso-8859-1?Q?dYf1Pq1PVBac2TFpMMbT9kF3zH2C+gCXv7zxKs3Faqyh3fGZg/HI/DF0Ns?=
 =?iso-8859-1?Q?hYZ6obwhFvPSx0T28t+nRMobzk9ItcJLdIexHHLk9svA4WDHb9oQcvZoWK?=
 =?iso-8859-1?Q?KSNYnELh+1E8bhkMGTeZYjGi+x5ALy/BK0K1NZG503teTj+FvmnXF8wXfV?=
 =?iso-8859-1?Q?JnfZ6kkXdWLcKOr9HnniC58tzJalw3AspiQ/a8KWXcqnYtGwSjSS8qPm6f?=
 =?iso-8859-1?Q?ew1MfDwmrJzU5OHeOXpt+s8+0Mrmj4l6I3Ev+F1Ond3903vDbpW6uKnHGC?=
 =?iso-8859-1?Q?Z1IKUQtdAJVs+IIRDwgdcryiTereh4uks1qO9o39Lc7b6+DBtF9Vwz9lxY?=
 =?iso-8859-1?Q?NZdUb9PzfRiFSL3WwXcURZuLHsjC5O0/Av7j+kT5UTTVCdMpIwWOIpbxhF?=
 =?iso-8859-1?Q?ibwfJVxyilgtE6rAVQT00AXC9zZ5RVrYl4Xwfb9JyD4waX61aJoLMnyKnp?=
 =?iso-8859-1?Q?Hutm8Bkq+StP/5cBgdk3ukMXrw4HpvRWE8jjf3Hv42ml03oqU+hFzxmOI1?=
 =?iso-8859-1?Q?Lg3vNcvdavnpcdusud3yCrxLXQEnKCFU4OobGQqy5CoWyi9mmu0o8Jj7m4?=
 =?iso-8859-1?Q?T5N9Jjb1lZk2gWMehV+rXn3N5wVi+DfM1jlQ6ssFjam4TniDyPQYBM9d40?=
 =?iso-8859-1?Q?l9pqjwM9KaS2Hfc79wVCr9bcrNjRBeAjK1Z5FK9qQmEOreeKPggA9DO3ec?=
 =?iso-8859-1?Q?DcNARcoIAaTfDCel03U/szvMDvfSby+TXm?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSQPR06MB7252.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84105c39-4753-406c-b06f-08dc15a6003c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 08:43:09.2394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mZDnV0btBjzSx/5MU2U3/oG27oUHcuYAPFcA+ADHohd457jStj6n1eZ2hliPv2qOsOq229+9waSPuhwh/8QHnw6t5WwC+2WE3S40sXx6bXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5592

> >>> +examples:=0A=
> >>> +  - |=0A=
> >>> +    #include <dt-bindings/clock/aspeed-clock.h>=0A=
> >>> +    pwm_tach: pwm-tach-controller@1e610000 {=0A=
> >>> +      compatible =3D "aspeed,ast2600-pwm-tach";=0A=
> >>> +      reg =3D <0x1e610000 0x100>;=0A=
> >>> +      clocks =3D <&syscon ASPEED_CLK_AHB>;=0A=
> >>> +      resets =3D <&syscon ASPEED_RESET_PWM>;=0A=
> >>> +      #pwm-cells =3D <3>;=0A=
> >>> +=0A=
> >>> +      fan-0 {=0A=
> >>> +        tach-ch =3D /bits/ 8 <0x0>;=0A=
> >>> +      };=0A=
> >>> +=0A=
> >>> +      fan-1 {=0A=
> >>> +        tach-ch =3D /bits/ 8 <0x1 0x2>;=0A=
> >>> +      };=0A=
> >=0A=
> >> NAK on this based on how you are using pwm-fan in v10 discussion. See =
my=0A=
> >> comments there.=0A=
> >=0A=
> > Okay, I will merge everything from the pwm-fan0 node into the fan-0 nod=
e=0A=
> > and add the 'simple-bus' to the compatible string of the pwm_tach node.=
=0A=
=0A=
> What simple-bus has anything to do with it? This is not a bus. Just to=0A=
> remind: we talk about bindings, not driver.=0A=
=0A=
Hi Krzysztof,=0A=
=0A=
If I want to create a dt-binding to indicate that the child nodes=0A=
should be treated as platform devices, which will be probed based on the=0A=
compatible string, can I add "simple-bus" for our pwm_tach node like the=0A=
following?=0A=
pwm_tach: pwm-tach-controller@1e610000 {=0A=
        compatible =3D "aspeed,ast2600-pwm-tach", "simple-bus";=0A=
        reg =3D <0x1e610000 0x100>;=0A=
        clocks =3D <&syscon ASPEED_CLK_AHB>;=0A=
        resets =3D <&syscon ASPEED_RESET_PWM>;=0A=
        #pwm-cells =3D <3>;=0A=
  =0A=
        fan-0 {=0A=
          tach-ch =3D /bits/ 8 <0x0>;=0A=
          compatible =3D "pwm-fan";=0A=
          pwms =3D <&pwm_tach 0 40000 0>;=0A=
        };=0A=
  =0A=
        fan-1 {=0A=
          tach-ch =3D /bits/ 8 <0x1 0x2>;=0A=
          compatible =3D "pwm-fan";=0A=
          pwms =3D <&pwm_tach 1 40000 0>;=0A=
        };=0A=
      };=0A=
Or do you have any other suggestions for describing this in the dt-bindings=
?=0A=
=0A=
Thanks=0A=
=0A=
Billy Tsai.=0A=
  =


Return-Path: <linux-kernel+bounces-13100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF5881FFAF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 14:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B76071C21753
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 13:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2869111717;
	Fri, 29 Dec 2023 13:37:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2047.outbound.protection.outlook.com [40.107.239.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E4111701;
	Fri, 29 Dec 2023 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmB/4obKca5omjCRF/wUkhB1R22lgFkwp1nFwh32Q5fGxutLyfMGhGhfYnkbqpvnjoOyTj0TftcQBgGkX0tpVBuB4VeNxZxKS5dr13XWXSzuOvyFYRrbK6pkFZHgDhYkRjhj11Elygi0i+kLRcTxSYc6L0b2umbBFMubfhu3mezn7mO6WMJYgHh/zGD/Eir91dc0azQi+VHWPqFa6hKiPuaerCJiKRkJaPSgp29+2pH58NsP2LhBYRXDcDvuw3BSMmP4Zzf3E541py4C46Xvxj5Ug58tN5m50NpUWPXLKcTcvLjtiIm2HiyYHDdbm9qqCVeZhfkGDT8+I4T7yLokBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lid5rd7Zu9BCursPaboElEwjdiQA+cn9MGTRLXQzA2E=;
 b=jR05E3oUdwqtnq2b3zXacdxi9JkFKzqefk7BQzzWZVqTPH20h8xUnY6QBhAyGBPRgx5frr6gKdQZS0kyUzAU14a8jbkRzr0XBBhUKmjltPtejuYUmTjTdcEwecmlt1o/t6LQG3eQSCHLOQ8PCHgwA9PmFStHbC7ZJYRNhpMuyPZ6kvHG715BtSkF3S/lEwzsCZ/ttJx+tFBvLFQKIGF5nrJaLFdbi1uoK1UsZ02kgLz1TJQBeEIBX7wWTKlIN3mjx4JzRjjeWjhVs0ijDz6I+FfOsQRr9rBtrpap0NKEToWYFByxeEED+u7RH9sO2UztqOuOhHuUDl5udQqvDUoygQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:42::6)
 by PN3PR01MB7535.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:cd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 13:37:15 +0000
Received: from MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c1b:b2aa:7fc0:6532]) by MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c1b:b2aa:7fc0:6532%7]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 13:37:14 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: Kieran Bingham <kieran.bingham@ideasonboard.com>, "lars@metafoo.de"
	<lars@metafoo.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>
Subject: Re: [PATCH] media: adv7180: Fix cppcheck warnings and errors
Thread-Topic: [PATCH] media: adv7180: Fix cppcheck warnings and errors
Thread-Index: AQHaOMmdPe9NxYhWWkOjigXD9AvXv7C+lJIAgAGuGp4=
Date: Fri, 29 Dec 2023 13:37:14 +0000
Message-ID:
 <MAZPR01MB695797DF964AA599AF2D7D05F29DA@MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM>
References: <20231227133516.1356553-1-bhavin.sharma@siliconsignals.io>
 <170376380893.2881109.11558061738942135116@ping.linuxembedded.co.uk>
In-Reply-To:
 <170376380893.2881109.11558061738942135116@ping.linuxembedded.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MAZPR01MB6957:EE_|PN3PR01MB7535:EE_
x-ms-office365-filtering-correlation-id: 9f757db1-421d-428c-eb24-08dc087344d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 OKToCt9t7RU0UqHoeEYHx9Hd3IfZO8OBk6vNCmQB/FN3B9asEoTNNsyOSlpYFNMzFWqz1yBe5F4bxhUVTRV8k3qevjfUPYn0NabJezoO9TUqgtVwmhwthkiCsu4rDlqOWZ2OBq3yU7MNPyi8TvyVaJn0+t/+00iXZPmo8EErCTT2Q7GZB/OoN5RziTbpqOpVwC5/6yrY0luiJk8XWO1K8Lf5J4FVjzQxsXCVc0xbs5uGDoT6mBRD6a1bOPNRKvCyxiahNgDIR8AqgegBGBIBhGOTlS22W4VjTHVFqeOeo9Gx5IaVZ8sJ7ChF1kqWjQ4ksJ8oWY4uloz980x4tpsrW3qTHOlMf/E71ekZNdfo98GLV0NdvHDwFVDDci599Y8umEn3Tx+5+d8C4145mLpOFWp/KVEcHd4VKhTscmobVXiFtjFzX2CukaInnEvYAQoZs0PcOqc15bN7yrn62MFVbttM1Prc0jNXaqdSCVdpYapsV88SsQms9PpY0W9/ql40LxJEbbTYb4Z7i0tKqbrebz1SprLKH+5dfyXu0n7EjpyZhDGzv66zkp7msyefBE9bNU6DhOpqx/AH/79x1ONwSdFpLIyxJHVDJe2iYtl0GimrRzFPKPveTOdD4TVxkteQhQTR7OqOTpU5nZnv2W7z0V0JplhYskotMm1QxBm9wlg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(376002)(346002)(366004)(396003)(136003)(230173577357003)(230922051799003)(230273577357003)(186009)(451199024)(1800799012)(64100799003)(55016003)(52536014)(2906002)(5660300002)(8936002)(44832011)(110136005)(8676002)(316002)(64756008)(66476007)(66446008)(66556008)(66946007)(91956017)(76116006)(41300700001)(38070700009)(7696005)(6506007)(71200400001)(9686003)(26005)(33656002)(478600001)(83380400001)(122000001)(86362001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?fbSRm3ywJxjKOUy7hzm0Y76A+ks6oUklwGaZ96q7rr7yNKK7QQkXiLnXvy?=
 =?iso-8859-1?Q?cvlsj+5t5fjbgtV7cDzRZxzD2HSvSwOW6H4ah7BdhNmIsRMM6AsNwm/4ux?=
 =?iso-8859-1?Q?MlE1nQ9KvTX2DLhFXs4vW6NBBkBIdud4KIH1gvGpdDa70IWzmuKPV+w3GK?=
 =?iso-8859-1?Q?HQ65VMP2sLi0ViV5PZYWxg75n/ODnR04hmwmClqrH78yMHGf6yDwFvfVXH?=
 =?iso-8859-1?Q?IsQp1slxBxXWd73Ml+B6hGywxoz0lbEKMqbi0/fOH/DQzkEzqDc4xT6frU?=
 =?iso-8859-1?Q?2szcn1C4Mi2vJ8+zik1aifFHvZ2LiIzyR4QdZdxFsp9rU3UQINuC8D4LYJ?=
 =?iso-8859-1?Q?GmceVOtafFrAZdH5gVtPqFmEPDau4Vf4zKam6iHFh6Ce4/RsB3K/lZmN/M?=
 =?iso-8859-1?Q?sJzju6uQfNrhhF3xOIqTF5zlJk7+A2UKVKvUXHIswZIxbYbFolIqvnMAd+?=
 =?iso-8859-1?Q?RNb1+f8AzbwSwQLk84mf6g2/UglGUoWnIqBdIY5veNZpVR082UX2KON+sE?=
 =?iso-8859-1?Q?BbzAj7O6+DCqlwHsu3KmaX1Ezo6suPMi/9MTsSwSZN2hfTeIeZCDGJHDS1?=
 =?iso-8859-1?Q?OEVoTW0A0DBrCA7dQkDSEhLgzq38JOBp2ZoqeGdETH+XlPuFurQWMnXIxU?=
 =?iso-8859-1?Q?qm7T3+Z6ykLCp1zP05e6dUX47/iQnQ5TWalRM8KLpc6BJt2wPRtN+DHbz3?=
 =?iso-8859-1?Q?qUIeKIuOBzATk4dmogdvSVIjF71h4eq7LBl9My/jB9JuhXDunz36yHBLXC?=
 =?iso-8859-1?Q?/v3KupfrVd26zLzWhj+Q9ha+YFBJ8Ub8jOOX+CeDHw0okmeT30nMEPtjLb?=
 =?iso-8859-1?Q?AKlIFb0W0Ut1fBY8HCjmeKVKuLPjWNBQhE9XLSy/eQjRjUYH94W40xalCh?=
 =?iso-8859-1?Q?/WT1H2aAwEblszOIsuXLWTpoQ2wwo20p8TWOKpV4+goLXW/Ts78EmREFZ9?=
 =?iso-8859-1?Q?o+sjTfvKz7uaj/d0TPSxMY0eLCfMN4646hxaDYOS5EMatoGye86QwP/cHE?=
 =?iso-8859-1?Q?ywStlXLSx9G+Ti+2yXorIyi7Gm21JlIv44lu0ikzpmHd4NnJHZ2FG5HGJp?=
 =?iso-8859-1?Q?mwvtt/JzTkLyrdYvTm6y/KmV19n8KqegBZT+OMSZkLJHWZfCKsGUd+dj5K?=
 =?iso-8859-1?Q?GI5SKhLqHSdYK9W1CkbdUKzPo/Q/ksW87TwELjSs5x4yxrfq/O3yoMCSAS?=
 =?iso-8859-1?Q?ljqeqH5VrxtEakrRgi3b4V+m7PEbPbw1+h3jbMEwBDAkORLKvyaRXxpB18?=
 =?iso-8859-1?Q?IUAMlGfawtF1wwg2PVCjHushofJCPNTI7QTsSsv5rteYrHpWKC0OdSWJgx?=
 =?iso-8859-1?Q?7YsDOfsUADx/Qq08LbITV2IodSnw74bz4hCAJ3RCk7T2+Q7165exwT6x0p?=
 =?iso-8859-1?Q?vLkPsdYZWNbpuUcKyBFrjSty5cOl8MsTDMJF4Y/e6EC72GmOo38vRI4Hmt?=
 =?iso-8859-1?Q?rYKspWwAhHFw5FTNw/ZJ0Gqd03NxywHTWsKn8I+wEjv0yfRppjp2qImkq5?=
 =?iso-8859-1?Q?Ap62Pt9Up1PvhVNPYp7P1iXtr+hFdTPYTHqSNXZl+GZt/rHu5A7z95tMCu?=
 =?iso-8859-1?Q?Tib8xojv1hmVkibyaQ2/AHsOJ8uNaEBA9UIX0WpXyhKVIPUCZyqbWyfAPb?=
 =?iso-8859-1?Q?eMqoxRhPMaIHcL7pBHTcJoRCvTe9cuhF15lCbCyCNSZq6M9LI7cW0JVA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f757db1-421d-428c-eb24-08dc087344d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2023 13:37:14.8374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aTiX4KLD3Tju7SPeSgjzPTifOYsn4lVkDEFGHGpxNBEVAx8PRansfbLHllONPrOkjtM8tqe4FtCCEO0y0Sk1AbbeYvvFQDiRiEcKB0wbjT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7535

Thanks for the reply,=A0Kieran=0A=
=0A=
>> WARNING: Missing a blank line after declarations=0A=
>> ERROR: else should follow close brace '}'=0A=
>> =0A=
>> Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>=0A=
>> =0A=
>> diff --git a/drivers/media/i2c/adv7180.c b/drivers/media/i2c/adv7180.c=
=0A=
>> index 54134473186b..91756116eff7 100644=0A=
>> --- a/drivers/media/i2c/adv7180.c=0A=
>> +++ b/drivers/media/i2c/adv7180.c=0A=
>> @@ -357,6 +357,7 @@ static int adv7180_querystd(struct v4l2_subdev *sd, =
v4l2_std_id *std)=0A=
>>=A0 {=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0 struct adv7180_state *state =3D to_state(sd);=0A=
=0A=
>>Personally, I would keep the if (err) hugging the line it's associated=0A=
with.=0A=
=0A=
If we follow the code base pattern for this diver, we are getting same onli=
ne space in conditional if statements.=0A=
So, we need to make changes there also.=0A=
=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0 int err =3D mutex_lock_interruptible(&state->mut=
ex);=0A=
>> +=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0 if (err)=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return err;=0A=
>>=A0 =0A=
>> @@ -411,6 +412,7 @@ static int adv7180_g_input_status(struct v4l2_subdev=
 *sd, u32 *status)=0A=
>>=A0 {=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0 struct adv7180_state *state =3D to_state(sd);=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0 int ret =3D mutex_lock_interruptible(&state->mut=
ex);=0A=
>> +=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
>>=A0 =0A=
>> @@ -1046,8 +1048,7 @@ static int adv7182_init(struct adv7180_state *stat=
e)=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ADV7180_=
REG_EXTENDED_OUTPUT_CONTROL,=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x17);=
=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
}=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else=0A=
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else=0A=
=0A=
>>I think kernel code style requires an else clause following a multiline=
=0A=
scope to also have its scope enclosed in braces even if it's a single=0A=
statement.=0A=
=0A=
On many places in driver there is single statement after else without closi=
ng=A0=0A=
So, we have to make changes in those places also.=0A=
=0A=
So, better I should make changes in all places and make version V2 patch.=
=0A=
=0A=
Please give your suggestions.=0A=
=0A=
--=0A=
Bhavin Sharma=0A=
=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
adv7180_write(state,=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ADV7180_REG_EXTENDED_OUTPUT_CONT=
ROL,=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x07);=0A=
>> -- =0A=
>> 2.25.1=0A=
>>=


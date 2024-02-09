Return-Path: <linux-kernel+bounces-59146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CE184F1FC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46171B290A1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18B2664D4;
	Fri,  9 Feb 2024 09:11:29 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2134.outbound.protection.outlook.com [40.107.239.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0DF664B8;
	Fri,  9 Feb 2024 09:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707469889; cv=fail; b=FBduYgR+1+O7VC7DdD8pkKRu/WtgfHrGlfvYmVl/k5ZHeL3ntyVQ0dzFXHSFKsAvOe2As++hrSanYH/Z+z1lNYX+JWPavbzgqJgq+9KacWIzEYfTACWwB50QsQOWbgKhF49OQURVJbAmuGuNoCG2Dp8bir4U4c40Uv9gRfiwSqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707469889; c=relaxed/simple;
	bh=Kj1gWB9w6crzXmPnhVBLtrnUD0b3hbqeZ9DM63gbUPw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FgtS3Ir4/fLjSoddj5KsIq+HBBK0Xz0zNbZScsc8IHySW+KbqjOixpMtzNkgQpEBLvTOcMRLArcSjsndpTpCP/gqpNFSlOlWv6VVqTc43um6+tkSDd6G3d/kONekmt/LPqSQ2A6r27+Tr1aQKsgnlPLcz3D27/YXOfIMGQVuzss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1Sv0to+9nbBRgSLhR3mS6t2cp0pakqpl2fVkt0mZsfZ2oMB2XcYDaBeXQU6/+Af10tmV6maoOtfJ6t8IxklN1ab3cgBtAD9jB5f8689sxMUudohcEEIomZLfTBPBZzwfpYhL7YTrBIbje47lRdp/B/B1J4Ge5xkTZreN/jE3xU1A7es3qfvSNHBOpHVfErXuzTjoKUqpTbnI8trL6K0pk+p2E5v9t11qdBRRE7xKJ7SNz/iumbst+DTvcdilmlufqxPSvrGuu8RonmumNFRr8n/eUgjfMDCOaY56fRiQy70xuWeAe7zpW34uoM9XvBhvn5uSQyczcXXyqauTlkV/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uw/klW7ciOE+XJBLWv6sa/deTOcx3DoF0z8sgUhYiBE=;
 b=PN0kvq3rV0AtZsUs9d/IBdzJOCAB9hw1GeyOmlewN/+A6PJw6yHptpFOsmwt1AoftcVIsCiWACF8W1FleEGC9AzSkUL8+1746OGU1C3Wv9X3XTZd2gcL28BlNnzHWS6c/dh88irXpiv3AFPZYc1cW0Wu73ylzeafTs9LuR5cYD+FG8bEcXeqA+REfiv/IH0gZ7do6k+7UmVh+O1LhAQKRL+cPeAaDiJhUvAf90WqvsqtFv5PBw1rOCrQeeNrhI9ItJ5ISeXOFAOneJDWyDPHtDtwIq+WamKZdonivoIo1ugvjr+Amww+WA7VlfL85JuoFZBwHH6qvd97aKjqBk1EBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:42::6)
 by MAZPR01MB8891.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Fri, 9 Feb
 2024 09:11:23 +0000
Received: from MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::72b4:8a64:2d93:7cc0]) by MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::72b4:8a64:2d93:7cc0%4]) with mapi id 15.20.7249.037; Fri, 9 Feb 2024
 09:11:22 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: Hans Verkuil <hverkuil@xs4all.nl>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "kieran.bingham@ideasonboard.com"
	<kieran.bingham@ideasonboard.com>
CC: Lars-Peter Clausen <lars@metafoo.de>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] media: adv7180: Fix cppcheck warnings
Thread-Topic: [PATCH v2] media: adv7180: Fix cppcheck warnings
Thread-Index: AQHaPYfkNCfvrDXYy0uGv5NwfP7QArD7odSAgAFQ0FGAADFkgIAEzmA4
Date: Fri, 9 Feb 2024 09:11:22 +0000
Message-ID:
 <MAZPR01MB6957B9B109854FED3106A3DEF24B2@MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM>
References: <20240102142729.1743421-1-bhavin.sharma@siliconsignals.io>
 <16ef7746-d038-4607-8e2f-8f7cef5a8b48@xs4all.nl>
 <MAZPR01MB695711E70CEDFC41DE5C2C8DF2462@MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM>
 <ae539786-f73a-41ba-97a4-ea409fb88e2f@xs4all.nl>
In-Reply-To: <ae539786-f73a-41ba-97a4-ea409fb88e2f@xs4all.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MAZPR01MB6957:EE_|MAZPR01MB8891:EE_
x-ms-office365-filtering-correlation-id: cf4c5a36-1c61-4ff6-7053-08dc294f15ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YK5eEzXMfBAgiYMKvald4rm944pbGQ9EarW0xOiHc6kP0kTzvZqjdrJb9adzcxPy0x9Wvg8RjPtQb/kgpOSeZdBiKvTc1zFsJ8QfZ0kaRlsHHwagmJNJ5EopXN3IUCfkNEUMEflh/JJyMr2WcyFsvMO+6QAqn16Z+jrDFaJ0YN6I4MBSORhCLr3wwA3MVuIQuSpoLzC/VLRE0zprbBYAAHyZlIUUsY07BmMyumnWWNmAayXdYNbjq1TrEqTQgt0gtHmpoDWzUHSgh3gApovzevw3cQ+JVuNWgdqZo8KLmOycxx8y6fWw2545ePNWBHXDwU8tpm5Si9lRf0rCwpfqwGALxksJQmYXMLWv3VggyF3iD5/XYGQfDhKC18lfihsJaGbx1J7p1vjP0K0uGvu7v/lxIQ8grrLOO9xiTHuWrBCnTaY+YApPJf2aa305Uy9BL8L35bLL9TZVIyEoCQZy+nXn37/mL4yghNpVLiS4s1iUYs7wOg1062tb3xKcmFMAg5w2Wghe9k2f4Hy1kxX/VM672NH454x2COdwnvRwf7ERHJVyjNGE229mDWy2ovCM3RdpzUxTzcRYL7J0snYgzopE5leDzOly9leAIwrErDA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(376002)(396003)(136003)(366004)(346002)(230273577357003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6506007)(55016003)(41300700001)(7696005)(71200400001)(53546011)(966005)(478600001)(45080400002)(66946007)(52536014)(66446008)(83380400001)(66556008)(110136005)(91956017)(54906003)(66476007)(64756008)(76116006)(5660300002)(9686003)(44832011)(26005)(33656002)(38070700009)(2906002)(38100700002)(8676002)(316002)(4326008)(8936002)(86362001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?k6BXLlQKqogmSDs6du6eOmmTAKR09A6FPC5yX+Xe6kHto4MGRji3Uh/t5X?=
 =?iso-8859-1?Q?sel6kkCpiYbTEFib/jCRDruPT68aTwFh2Bdf9ARtEoNhbT9gnnt2LRNVGH?=
 =?iso-8859-1?Q?K8br0x1Hsubq03gosP3zRAGvpO12A6/wE/ehksECw+UBKb6GMwwcDt3Kjk?=
 =?iso-8859-1?Q?o6gmQbp3WEhuNzrxdy2uwtaUhAxNVm2N7VNoiw2rHGAZgLtJQ0415zJ8+r?=
 =?iso-8859-1?Q?tAMRrZxSwakeUUx5ypzl1qRloSbWndkuefBUPzGW4/sxAA+U5OFgUFgSnF?=
 =?iso-8859-1?Q?+vzLF9QfG7BoApVaPk0hmUpnrrTA1uC1w6tT5DyMkcwcyLJWAuIQEAo3+b?=
 =?iso-8859-1?Q?t/rA5RxeJl65ryD4AaGIv8fQYuBVQitVcb6GUr0KD1jtim1q0XSSndrJZB?=
 =?iso-8859-1?Q?8Jf+Cb2gKyzf3Tp+zaNMToPCqwtTd2rU1Xi/Nolpp71Xw5mPrl9PBBFQaP?=
 =?iso-8859-1?Q?xiWoFQhbtkxrw34wHuTB4PLzyglf2CwXFj3IapjWUWFUBQAz49VX7hVb2Y?=
 =?iso-8859-1?Q?eIeEAZARRa9nKUOvUh4oUpswqZ+uASFzoAUQifyv7FvGGVT8BTCuqpA9I3?=
 =?iso-8859-1?Q?o+uGUPewjPIXdlPisVl3e+ZctEsjfN4qTulQc15frGJDeJ0KgMMeEYf4zo?=
 =?iso-8859-1?Q?bCKg2ESNY3rgwmRGSmPm1KDcBRK5qSM2osckhBYsbT2EhcNKUgoNUyeCdK?=
 =?iso-8859-1?Q?G3sqHIgjdDAzMfoo5oYBQCqCHwHqhSW6ZYb3M0/u0eWIBV3vsK31cYye5f?=
 =?iso-8859-1?Q?wWI6+VykcXP0H/xpT4FUc11ZNz1fo6Qa/rHsC/flW5ag8RGOArKVudV0QW?=
 =?iso-8859-1?Q?V88j8KlonXIzNynFa6hhdVE8U7ql1yQbAwCIbKE0jZ/9XOMNK8YhwC0bCD?=
 =?iso-8859-1?Q?XfP9okvmaNLYZG8l3HcfptG/v0C88xuPfZJ9HHrnLUK9Ztead8DSuPd4ZN?=
 =?iso-8859-1?Q?+bhRjm8q4Wdbb8U8iEthYAtJDhTIKPuyS3K3qP1V926wM6sb7gN2UCT8kz?=
 =?iso-8859-1?Q?6dSYCZVpLiMzJI5ZmbaRTNLnVjgRnp45Q7kr9Qar+n/q7mNApRFgVWHZMo?=
 =?iso-8859-1?Q?u0eMKG0Dp+TzkaoyPckhNu6klLuzNi6dGuECoQHwbpirJz9qZlkndLjhgT?=
 =?iso-8859-1?Q?yI2wAnnMeghx46O3Pk3ZTQrha6ja8lX88hc7Zjh5kfmunMQ/qxA6G378Fo?=
 =?iso-8859-1?Q?+T4g7gobP259oh9yTtFIV6jqcBelTJ87nkuOHBlynmV4gFFnPsZYcuSot2?=
 =?iso-8859-1?Q?Wxxz2Yj4R6KkzpBdnfMTOL7DkrGILNpQp5ZCE/XpWHm8tKCMwu8OxcMlx7?=
 =?iso-8859-1?Q?IXjpOwZA2CiFVZL3aYvOWtw+WA6tIM3pxEAsqxJlu5S+5MMmiXxXRRmIav?=
 =?iso-8859-1?Q?0GfKr3sPoHYBx7GbWT9CflMwbK8rpaizJvl6ppxewcb/GwHcgjOg9O/5fp?=
 =?iso-8859-1?Q?nF+dnn7IvoHeEIskRNinp29g7sT8r/XY4vjRw2gf9+bv1sPbuikyVLMfDJ?=
 =?iso-8859-1?Q?KpDvsx7ApNyASrrfY3hxcdcxeknF529fXSjbIvK/3VK8iXYS68uvwnrGuu?=
 =?iso-8859-1?Q?aZNO1Qd9a2ogKx05rfxx/+ZYrWW25D4iNIy0siFqLnyoLzLPFROZOre4Ts?=
 =?iso-8859-1?Q?ic4cMURCeO1O9dYqbrBUbrEYC4CBwoT6LOMlvaT1ti96PYM54Ys4vGoQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4c5a36-1c61-4ff6-7053-08dc294f15ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 09:11:22.6717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: apaCrFUIpWcTeWqI2zXMUFJaxY8tMs31ZOBC/h4k3a4atf+4w0NwB/4yxQizGlmpdmNf0dm07aWmUzGLCEgGLgAdYWNQOyDXZjfR3qvVvG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB8891

Hi Hans,=0A=
=0A=
> On 06/02/2024 06:05, Bhavin Sharma wrote:=0A=
>> Hi Hans,=0A=
>>=0A=
> >> Hi Bhavin,=0A=
>>=0A=
>>> On 02/01/2024 15:27, Bhavin Sharma wrote:=0A=
>>>> WARNING: Missing a blank line after declarations=0A=
>>>>=0A=
>>>> Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>=0A=
>>>> ---=0A=
>>>>=A0=A0 drivers/media/i2c/adv7180.c | 27 ++++++++++++++++++---------=0A=
>>>>=A0=A0 1 file changed, 18 insertions(+), 9 deletions(-)=0A=
>>>>=0A=
>>>> diff --git a/drivers/media/i2c/adv7180.c b/drivers/media/i2c/adv7180.c=
=0A=
>>>> index 54134473186b..0023a546b3c9 100644=0A=
>>>> --- a/drivers/media/i2c/adv7180.c=0A=
>>>> +++ b/drivers/media/i2c/adv7180.c=0A=
>>>> @@ -335,8 +335,9 @@ static u32 adv7180_status_to_v4l2(u8 status1)=0A=
>>>>=A0=A0 static int __adv7180_status(struct adv7180_state *state, u32 *st=
atus,=0A=
>>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 v4l2_std_id *std)=0A=
>>>>=A0=A0 {=0A=
>>>> -=A0=A0=A0=A0 int status1 =3D adv7180_read(state, ADV7180_REG_STATUS1)=
;=0A=
>>>> +=A0=A0=A0=A0 int status1;=0A=
>>>>=0A=
>>>> +=A0=A0=A0=A0 status1 =3D adv7180_read(state, ADV7180_REG_STATUS1);=0A=
>>>>=A0=A0=A0=A0=A0=A0=A0 if (status1 < 0)=0A=
>>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return status1;=0A=
>>>>=0A=
>>>> @@ -356,7 +357,9 @@ static inline struct adv7180_state *to_state(struc=
t v4l2_subdev *sd)=0A=
>>>>=A0=A0 static int adv7180_querystd(struct v4l2_subdev *sd, v4l2_std_id =
*std)=0A=
>>>>=A0=A0 {=0A=
>>>>=A0=A0=A0=A0=A0=A0=A0 struct adv7180_state *state =3D to_state(sd);=0A=
>>>> -=A0=A0=A0=A0 int err =3D mutex_lock_interruptible(&state->mutex);=0A=
>>>> +=A0=A0=A0=A0 int err;=0A=
>>>> +=0A=
>>>> +=A0=A0=A0=A0 err =3D mutex_lock_interruptible(&state->mutex);=0A=
>>=0A=
>>> The problem here is the missing empty line, not that 'int err =3D <some=
thing>;' part.=0A=
>>> So just add the empty line and don't split up the variable assignment.=
=0A=
>>=0A=
>> Yes, the error is of missing empty line and I only resolved that particu=
lar error in the first version=0A=
>> of this patch.=0A=
>>=0A=
>> But I was recommended to keep the conditional statement close to the lin=
e it is associated with=0A=
>> and to make changes in the code wherever similar format is followed.=0A=
>=0A=
>> So I followed the advise of Kieran Bingham and made changes accordingly.=
=0A=
>>=0A=
>> Below is the link of the full discussion : https://lore.kernel.org/lkml/=
MAZPR01MB695752E4ADB0110443EA695CF2432@MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.=
COM/T/=0A=
=0A=
> Kieran said this:=0A=
=0A=
>>> @@ -357,6 +357,7 @@ static int adv7180_querystd(struct v4l2_subdev *sd,=
 v4l2_std_id *std)=0A=
>>>=A0 {=0A=
>>>=A0=A0=A0=A0=A0=A0=A0=A0 struct adv7180_state *state =3D to_state(sd);=
=0A=
>>=0A=
>> Personally, I would keep the if (err) hugging the line it's associated=
=0A=
>> with.=0A=
>>=0A=
>>=0A=
>>>=A0=A0=A0=A0=A0=A0=A0=A0 int err =3D mutex_lock_interruptible(&state->mu=
tex);=0A=
>>> +=0A=
>>>=A0=A0=A0=A0=A0=A0=A0=A0 if (err)=0A=
>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return err;=0A=
>>>=0A=
=0A=
> which I interpret as saying that he doesn't like adding the extra empty l=
ine.=0A=
=0A=
>>=0A=
>>>>=A0=A0=A0=A0=A0=A0=A0 if (err)=0A=
>>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return err;=0A=
>>>>=0A=
>>>> @@ -388,8 +391,9 @@ static int adv7180_s_routing(struct v4l2_subdev *s=
d, u32 input,=0A=
>>>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 u32 output, u32 config)=0A=
>>>>=A0=A0 {=0A=
>>>>=A0=A0=A0=A0=A0=A0=A0 struct adv7180_state *state =3D to_state(sd);=0A=
>>>> -=A0=A0=A0=A0 int ret =3D mutex_lock_interruptible(&state->mutex);=0A=
>>>> +=A0=A0=A0=A0 int ret;=0A=
>>>>=0A=
>>>> +=A0=A0=A0=A0 ret =3D mutex_lock_interruptible(&state->mutex);=0A=
=0A=
> I don't believe he meant doing this.=0A=
=0A=
> In any case, none of this is worth the effort, just leave this driver as-=
is.=0A=
=0A=
I appreciate your comments. =0A=
My intention is to make linux kernel source as per kernel code style. In th=
is approach I found these warnings "missing a blank line after declarations=
"  and made changes accordingly. =0A=
Also, there should be blank line after declaration of a variable, correct m=
e here if I am wrong.=0A=
As per the suggestions of Kieran Bingham, he recommended to keep the if(err=
) hugging the line it's associated. So to adopt this change I made changes =
accordingly.=0A=
=0A=
Regards,=0A=
Bhavin Sharma=


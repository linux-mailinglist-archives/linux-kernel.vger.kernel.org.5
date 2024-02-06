Return-Path: <linux-kernel+bounces-54332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC0C84ADC0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 06:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF554284B99
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967C07993D;
	Tue,  6 Feb 2024 05:05:08 +0000 (UTC)
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2119.outbound.protection.outlook.com [40.107.222.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF349745DE;
	Tue,  6 Feb 2024 05:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.222.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707195907; cv=fail; b=RDEaBPX7q0hcjsXGPi3b9W5vQYK49q8zEepX+Nv+/7n80j9paZkG+sOmkJcU8h9n4lceDfLhaAZniwEiX6heg4ZXpkxoogGnaxdW8u2NhuRGhkbHoPYqSO0gaJEW7HTcQCTjo8ABSEWHAHkBdnaCpauqevdCcHVj0dHi33QGVXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707195907; c=relaxed/simple;
	bh=/aCiWw9NTSaqeplKveytxXGrXy5PPEGFT9nTm+60ei8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jbV1N78hChLaAtiN2RxK2C+TVoXcMVZNPN6pTiniguczrYfpZu182+aLLt5c4gk2rscm0zU2Pgq07MJ2eJgd92SB27avxQxmk7AzklYXOrZ0Mh5728Jqdhv8+lzMX972OR9MKKCOU8Nxs7D2zNCtYM8usWDHo0+yRuX9xOw0neI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.222.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeiyyBsCpyHZoBI/u0jNe8H5RJ+hz4fto+dVL3xCGKhP3u48YRfYQblavamjgpuRB2TICU37MBlMxr9fVSZ7yuoUWOqdliJAZAr+gdcGKWNy3bptJS4eXIBwljYL782vL5oOLa6eFie5H6rgRDjWzAzQYVGzGzA1drOICRpZO6XgbWS6SLf4Enik0wM5z1kSxA/dz+duzPkXufQytUcf2UYd0QLVLaUCSR4eESIMZicYqSLBURypZUcJgZAzoEgTfIe7gUN96evr3J+PK4sEYGqZgA+qci5qW64cZwiYs+osT+hc+Tyn6gHHH++mBLhwvsIs0luy/qdDbg2Dmg1Rqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aCiWw9NTSaqeplKveytxXGrXy5PPEGFT9nTm+60ei8=;
 b=CwHRLkwFOVyYC8jL0Z37fUr3E9iE2hv6buP0ylN7wzPLhGB6AOoN+6C66VPtgmck7Vii7eGh/83ToQSBy6Vl7SfKCnZdEY8dl+LR4YANvf3/KZUVFsOYjQs2rjYE6Nf0sd2xD17gEO4HBsUeBrDaQr+V/3jmdZzlvoyNc2AfZRNn5Xu+G3JTfKnRgPJfmXGPIaCbnpsQd2e7HapUZHt+5jE2GFQN/ZtJG4XPEDLZ06Jx5lWCdH2tqdVzHa2u3/dcK1ak5OQ6Yw4L609/u71XsUiJZDZt0P6Q7LSrplziR6+mSd7qbKpOfyoyrHYMebqNhfakNy1VHT1lZ9kRqTWqgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:42::6)
 by MAXPR01MB4358.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 05:05:01 +0000
Received: from MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::72b4:8a64:2d93:7cc0]) by MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::72b4:8a64:2d93:7cc0%4]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 05:05:01 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: Hans Verkuil <hverkuil@xs4all.nl>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "kieran.bingham@ideasonboard.com"
	<kieran.bingham@ideasonboard.com>
CC: Lars-Peter Clausen <lars@metafoo.de>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] media: adv7180: Fix cppcheck warnings
Thread-Topic: [PATCH v2] media: adv7180: Fix cppcheck warnings
Thread-Index: AQHaPYfkNCfvrDXYy0uGv5NwfP7QArD7odSAgAFQ0FE=
Date: Tue, 6 Feb 2024 05:05:01 +0000
Message-ID:
 <MAZPR01MB695711E70CEDFC41DE5C2C8DF2462@MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM>
References: <20240102142729.1743421-1-bhavin.sharma@siliconsignals.io>
 <16ef7746-d038-4607-8e2f-8f7cef5a8b48@xs4all.nl>
In-Reply-To: <16ef7746-d038-4607-8e2f-8f7cef5a8b48@xs4all.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MAZPR01MB6957:EE_|MAXPR01MB4358:EE_
x-ms-office365-filtering-correlation-id: 27e2c913-ee1f-466a-e71c-08dc26d12c52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wVyWWSPVyBn1jrIFkHMPZM3vnTCiy0atbFjhpKpSZQjzrDnQxNZvWT3tu9Ao7pfutnIXBBg4ZeWalMjupngsn3dzkuvPeKDEs6V9mm5+VKEnAX795Zmj+Gaz51iH8JElOG1tJsCHsPD5MMUSe7o3GW+3sS1C8IhG6/7oR0gjXobmDIMxG09McVUvqyGittrxlJM5/l9Xkb9yTAnsrfaq07vB+03pKZlrc4g1LEOHrDsadMXuLYtJI9zEVqTPjkygn6E1tYfZkGkZgVgmBS+uEnXWAj5HYdC2x+rB4UVIalSUxYqnEVAgzz7Q/vH/Xvyq5c8bDk+BP1JxGtDI2tv4mfbtJ8A2Oxg5WZ8+XebeTifFIJkLg3Eyzw15twdiUv+AeV2WW0QeH1bFm1WSgUujPh2IKX4YDx/6fYB8TOutd2iXDw/fFtBtbk3+J+1c9zJLOrz8K5JEPnZI4lFoEpj/rk8k9hzpBT+/dPyJuzzqHYZi8cqincbiegX9t6pRMVmwcyQ6d9nLFqzIq1aEostyyeHPzX146FWXGej6BkordtkYIY5xZ1h8GFfXW6I7QmWHWnu4ObVbIwKOBJzHkArEMrY+524c12HFIvEtshhEoSs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39830400003)(396003)(376002)(230922051799003)(230273577357003)(1800799012)(451199024)(64100799003)(186009)(55016003)(44832011)(4326008)(8936002)(8676002)(38070700009)(38100700002)(41300700001)(33656002)(5660300002)(86362001)(2906002)(66556008)(54906003)(66446008)(52536014)(66476007)(64756008)(316002)(66946007)(76116006)(91956017)(110136005)(478600001)(53546011)(45080400002)(6506007)(7696005)(122000001)(71200400001)(9686003)(26005)(966005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Nhk5PvN5cS9eKJ8Q1IN7xmlU0rn27KXhlIo8YjV/sYJQdCRXR9Es3asC/d?=
 =?iso-8859-1?Q?DgTV7EhysAjfY0NZNTe2jYskIcTdQ7B1Cf/58owwrtMlNBqhrH6gS11ISy?=
 =?iso-8859-1?Q?oxInxBXdgu2cmCLUsLRyMK1Tbi7RANK+ZMxrIVnov2nfc3K8/2L8YPHs2m?=
 =?iso-8859-1?Q?rlrOb+P7Uk1uyz3c/9lCex3d7rM2LZV70nvX01481Bz+2fyjbXdFLL1nin?=
 =?iso-8859-1?Q?a2FmA5+EjzX46/2T0xZJY7JIKGCyD2KIJpXg80X8CRB86GJSHSTBroaYj3?=
 =?iso-8859-1?Q?S/KBPnT+it08065Zt7Q5JwWxos44vJtyJxYFUB2pp82iS3SMBBGTL+TT4F?=
 =?iso-8859-1?Q?N8ybi6N7WwybHJhj8NxuwjvJJvNlvouRqQW3vTnSG0xfhQZg8SGMm35yQa?=
 =?iso-8859-1?Q?9y6Ms/CmiOtrKzcmrJxOEibdfzHO8qd1HOWRh4McGYXR+ACq03iUfrnfUA?=
 =?iso-8859-1?Q?nJiJ7au6HszxyCBBk87WKeDQiwKeCR+2WSTDoClO5Vomyi88W0hf/NACUw?=
 =?iso-8859-1?Q?4UVCvXuYJ4hETenHv5w0ltvffG6azp9L5bEVCeSUQ/z0pfZCkR6DSGmcJl?=
 =?iso-8859-1?Q?zYsviUYxDcCL3fer+WFit5cI685ge0IemOBLsHf6Gl+rkUhe8sFkUL5Ob3?=
 =?iso-8859-1?Q?2IqY/S8PFKL6BQkSp8QV5kOzKZlD8nRgiB17iiGP+m928FeVcDUqRhyfPi?=
 =?iso-8859-1?Q?mQJqzNyFSlbbyiGJo637qO2wy63R/tq/F/hzZ1XlNkTOGcebyKcqtoQgNZ?=
 =?iso-8859-1?Q?dpBGL01IwrZa79HCfxQ5w9ncb58NR5jYkTpyOCSxTkvYufV7WxvM3dpKGa?=
 =?iso-8859-1?Q?9efTLXvSiavro89NS0sT8yn6j+05wKuz5lsd8QnnwJ320GMNGgW+k3njnO?=
 =?iso-8859-1?Q?EhIwJU6dXBPd3jtQm+GerXsrTmMyMNtkT+tynEPtuG1ECGI7Nv3nOvYvdL?=
 =?iso-8859-1?Q?oPaKQR8Y7h4rFJAAiKd8Kuld8zWNH7SfjPI4tN11g7ZiHeaMfXtUF+05Nv?=
 =?iso-8859-1?Q?CisqQygzNsGxNw7H91Awpp3KPPLTRLREJXeFrvfxBua9pUofvvEQdFMsEE?=
 =?iso-8859-1?Q?JT5TY73L9w5WZZB5dJi1dMFfg0TBfyH+jIt8qs1HbrEGi74hMlS1b9lWG5?=
 =?iso-8859-1?Q?+KZCHYJOcg4CZXT345/m4Z43H7Tj/VhI7DNZhE44lJgjPU0EDVIsBoN7O2?=
 =?iso-8859-1?Q?eawAPdawhJzofrGvqAk8owMALNtAbwBJQ+fMy3Gk1NS+YtlycoSbqYXeOs?=
 =?iso-8859-1?Q?qjEjUYvU9BV7US1qbSc/VN3QcJy722dBo7VP5aUvVvw/ZBXBpiEVCfDJoi?=
 =?iso-8859-1?Q?nMDzbLftRM6HMIqZlzlcK4Ync3vLM0vhX9LDBp/dAdSsUD8C9WcIIR8USg?=
 =?iso-8859-1?Q?BdLwmAsINyzWvpkGlEgqbM6dOPZOG72Q6TLc16N5vAHKHbPf6zx21AeL5V?=
 =?iso-8859-1?Q?Cy71xszKPeYtetzl85jBwBniGBaUjMbUdhV0g6vrWtiScd3EOiWtM1PxGI?=
 =?iso-8859-1?Q?+714gkyGONH+NuowRC0uIt8O8ZUEsBazz8ErbGJ7ijZ0H/GG1Q9FHJPkXI?=
 =?iso-8859-1?Q?LTdu8rIkq3p0b/PhdehnkdcmoaWMHhLD3hQVowbsIHvHiETH8b6E4rEVzN?=
 =?iso-8859-1?Q?MoCMaNeFmxFC0206OYFPUZsFnE5FGgd4drRidnCkau5x4ArDMq381shA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e2c913-ee1f-466a-e71c-08dc26d12c52
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 05:05:01.2952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1j8m1UwDnDC7lkRcCw9kxFGEc51viZ2C/FRkAsByRGyzjujKPmdIUAlmeDPAyyiDU+Krs8JL2m2BcLi5m9tjjsELHdOjerGU4KzJ6MyYcnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAXPR01MB4358

Hi Hans,=0A=
=0A=
> Hi Bhavin,=0A=
=0A=
> On 02/01/2024 15:27, Bhavin Sharma wrote:=0A=
>> WARNING: Missing a blank line after declarations=0A=
>>=0A=
>> Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>=0A=
>> ---=0A=
>>=A0 drivers/media/i2c/adv7180.c | 27 ++++++++++++++++++---------=0A=
>>=A0 1 file changed, 18 insertions(+), 9 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/media/i2c/adv7180.c b/drivers/media/i2c/adv7180.c=
=0A=
>> index 54134473186b..0023a546b3c9 100644=0A=
>> --- a/drivers/media/i2c/adv7180.c=0A=
>> +++ b/drivers/media/i2c/adv7180.c=0A=
>> @@ -335,8 +335,9 @@ static u32 adv7180_status_to_v4l2(u8 status1)=0A=
>>=A0 static int __adv7180_status(struct adv7180_state *state, u32 *status,=
=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 v4l2_std_id *std)=0A=
>>=A0 {=0A=
>> -=A0=A0=A0=A0 int status1 =3D adv7180_read(state, ADV7180_REG_STATUS1);=
=0A=
>> +=A0=A0=A0=A0 int status1;=0A=
>>=0A=
>> +=A0=A0=A0=A0 status1 =3D adv7180_read(state, ADV7180_REG_STATUS1);=0A=
>>=A0=A0=A0=A0=A0=A0 if (status1 < 0)=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return status1;=0A=
>>=0A=
>> @@ -356,7 +357,9 @@ static inline struct adv7180_state *to_state(struct =
v4l2_subdev *sd)=0A=
>>=A0 static int adv7180_querystd(struct v4l2_subdev *sd, v4l2_std_id *std)=
=0A=
>>=A0 {=0A=
>>=A0=A0=A0=A0=A0=A0 struct adv7180_state *state =3D to_state(sd);=0A=
>> -=A0=A0=A0=A0 int err =3D mutex_lock_interruptible(&state->mutex);=0A=
>> +=A0=A0=A0=A0 int err;=0A=
>> +=0A=
>> +=A0=A0=A0=A0 err =3D mutex_lock_interruptible(&state->mutex);=0A=
=0A=
> The problem here is the missing empty line, not that 'int err =3D <someth=
ing>;' part.=0A=
> So just add the empty line and don't split up the variable assignment.=0A=
=0A=
Yes, the error is of missing empty line and I only resolved that particular=
 error in the first version=0A=
of this patch.=0A=
=0A=
But I was recommended to keep the conditional statement close to the line i=
t is associated with=0A=
and to make changes in the code wherever similar format is followed. =0A=
=0A=
So I followed the advise of Kieran Bingham and made changes accordingly. =
=0A=
=0A=
Below is the link of the full discussion : https://lore.kernel.org/lkml/MAZ=
PR01MB695752E4ADB0110443EA695CF2432@MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM=
/T/=0A=
=0A=
>>=A0=A0=A0=A0=A0=A0 if (err)=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return err;=0A=
>>=0A=
>> @@ -388,8 +391,9 @@ static int adv7180_s_routing(struct v4l2_subdev *sd,=
 u32 input,=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 u32 output, u32 config)=0A=
>>=A0 {=0A=
>>=A0=A0=A0=A0=A0=A0 struct adv7180_state *state =3D to_state(sd);=0A=
>> -=A0=A0=A0=A0 int ret =3D mutex_lock_interruptible(&state->mutex);=0A=
>> +=A0=A0=A0=A0 int ret;=0A=
>>=0A=
>> +=A0=A0=A0=A0 ret =3D mutex_lock_interruptible(&state->mutex);=0A=
>>=A0=A0=A0=A0=A0=A0 if (ret)=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
>>=0A=
>> @@ -399,7 +403,6 @@ static int adv7180_s_routing(struct v4l2_subdev *sd,=
 u32 input,=0A=
>>=A0=A0=A0=A0=A0=A0 }=0A=
>>=0A=
>>=A0=A0=A0=A0=A0=A0 ret =3D state->chip_info->select_input(state, input);=
=0A=
>> -=0A=
=0A=
> Why remove this empty line? It has nothing to do with what you are trying=
=0A=
> to fix.=0A=
=0A=
>>=A0=A0=A0=A0=A0=A0 if (ret =3D=3D 0)=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 state->input =3D input;=0A=
>>=A0 out:=0A=
>> @@ -410,7 +413,9 @@ static int adv7180_s_routing(struct v4l2_subdev *sd,=
 u32 input,=0A=
>>=A0 static int adv7180_g_input_status(struct v4l2_subdev *sd, u32 *status=
)=0A=
>>=A0 {=0A=
>>=A0=A0=A0=A0=A0=A0 struct adv7180_state *state =3D to_state(sd);=0A=
>> -=A0=A0=A0=A0 int ret =3D mutex_lock_interruptible(&state->mutex);=0A=
>> +=A0=A0=A0=A0 int ret;=0A=
>> +=0A=
>> +=A0=A0=A0=A0 ret =3D mutex_lock_interruptible(&state->mutex);=0A=
>>=A0=A0=A0=A0=A0=A0 if (ret)=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
>>=0A=
>> @@ -436,8 +441,9 @@ static int adv7180_program_std(struct adv7180_state =
*state)=0A=
>>=A0 static int adv7180_s_std(struct v4l2_subdev *sd, v4l2_std_id std)=0A=
>>=A0 {=0A=
>>=A0=A0=A0=A0=A0=A0 struct adv7180_state *state =3D to_state(sd);=0A=
>> -=A0=A0=A0=A0 int ret =3D mutex_lock_interruptible(&state->mutex);=0A=
>> +=A0=A0=A0=A0 int ret;=0A=
>>=0A=
>> +=A0=A0=A0=A0 ret =3D mutex_lock_interruptible(&state->mutex);=0A=
>>=A0=A0=A0=A0=A0=A0 if (ret)=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
>>=0A=
>> @@ -466,8 +472,9 @@ static int adv7180_g_std(struct v4l2_subdev *sd, v4l=
2_std_id *norm)=0A=
>>=A0 static int adv7180_g_frame_interval(struct v4l2_subdev *sd,=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct v4l2_subdev_frame_interval *fi)=0A=
>>=A0 {=0A=
>> -=A0=A0=A0=A0 struct adv7180_state *state =3D to_state(sd);=0A=
>> +=A0=A0=A0=A0 struct adv7180_state *state;=0A=
>>=0A=
>> +=A0=A0=A0=A0 state =3D to_state(sd);=0A=
=0A=
> And I am sure this never produced a cppcheck warning since there is an=0A=
> empty line. If cppcheck DOES produce a warning on this, then it is a=0A=
> useless application.=0A=
=0A=
>>=A0=A0=A0=A0=A0=A0 if (state->curr_norm & V4L2_STD_525_60) {=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fi->interval.numerator =3D 100=
1;=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fi->interval.denominator =3D 3=
0000;=0A=
>> @@ -828,8 +835,9 @@ static int adv7180_get_mbus_config(struct v4l2_subde=
v *sd,=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int pad,=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct v4l2_mbus_config *cfg)=0A=
>>=A0 {=0A=
>> -=A0=A0=A0=A0 struct adv7180_state *state =3D to_state(sd);=0A=
>> +=A0=A0=A0=A0 struct adv7180_state *state;=0A=
>>=0A=
>> +=A0=A0=A0=A0 state =3D to_state(sd);=0A=
>>=A0=A0=A0=A0=A0=A0 if (state->chip_info->flags & ADV7180_FLAG_MIPI_CSI2) =
{=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cfg->type =3D V4L2_MBUS_CSI2_D=
PHY;=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cfg->bus.mipi_csi2.num_data_la=
nes =3D 1;=0A=
>> @@ -857,8 +865,9 @@ static int adv7180_get_skip_frames(struct v4l2_subde=
v *sd, u32 *frames)=0A=
>>=0A=
>>=A0 static int adv7180_g_pixelaspect(struct v4l2_subdev *sd, struct v4l2_=
fract *aspect)=0A=
>>=A0 {=0A=
>> -=A0=A0=A0=A0 struct adv7180_state *state =3D to_state(sd);=0A=
>> +=A0=A0=A0=A0 struct adv7180_state *state;=0A=
>>=0A=
>> +=A0=A0=A0=A0 state =3D to_state(sd);=0A=
>>=A0=A0=A0=A0=A0=A0 if (state->curr_norm & V4L2_STD_525_60) {=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 aspect->numerator =3D 11;=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 aspect->denominator =3D 10;=0A=
=0A=
> Honestly, none of these changes are worth the effort, so I just reject th=
is.=0A=
=0A=
Kindly give your suggestions.=0A=
=0A=
Regards,=0A=
Bhavin Sharma=


Return-Path: <linux-kernel+bounces-31997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5B7835516
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C067281580
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 10:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34D6364C1;
	Sun, 21 Jan 2024 10:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="ReGq1PgB"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF6AD2FA;
	Sun, 21 Jan 2024 10:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705831361; cv=none; b=L4ihGjH4fZrrdSp4SsoVZ+6QeLCMLkBGxkqig5khGUMkb0afcxhZBqqSGKTTHQDHcFG2nEJy8xk34ik7u6pOUVWwVnD/yr0XFbJjce6sN8IkZcDZ/+dbzPbN2weY/9qqXP6FEZAXHMNS06Jrrr9W3CNqRmlbeKVNzMiQx3sQOEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705831361; c=relaxed/simple;
	bh=FMFyYwfHVwyPvjx6pt5kG1PX507Umfc+6g7d7Tbpqmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qr81/IwoPqZuoCNhEnvuzO024Ow624Q7OJ4uCeMD1pDC/vVClCndoQsiW12vwKI756LCEvp6xVZToGZGeiQSMwcxnZKsfdqrvx5D/czn4sex8tPa0e3VgG0SXlcPjUMSdlhPwubFA+fUgZC5AJyGjIlOje8xwqRaPevlalA+F/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=ReGq1PgB; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705831337; x=1706436137; i=erick.archer@gmx.com;
	bh=FMFyYwfHVwyPvjx6pt5kG1PX507Umfc+6g7d7Tbpqmo=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=ReGq1PgBtBmVHFl5oyVGSS7A9xIEYgi6jvCiB1UVuaMA/hiFlbH4b7HAgOtYYfEY
	 qgTgk1XF8M7qvHihLStkDMYMiCH8rq/1VDbfKYpERl6ysXzgjBApxWJI5bcuBPLgp
	 a2acYOMRshhn6KxJR7jj3VAiDrlbw9ym+PR9M8vIi4FswjSbozNgANhwzyttztPB3
	 X8yiGRO7Tl6VpTtTs8wDXbKr0bmCDtFAdhqyX8B1Tqc8wY1nG+/c0MM23AWdrO+k9
	 KXYugAd44zU/La6hpDTwgTjGLKnEjOaRknhy2dOhgFIEFVyxj64/ZiBAHMWr77YkZ
	 KFwwddxpiUf8zK4Phw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from titan ([79.157.194.183]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mel3t-1qrKtI0Sjl-00alkP; Sun, 21
 Jan 2024 11:02:17 +0100
Date: Sun, 21 Jan 2024 11:02:00 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Hu Haowen <2023002089@link.tyut.edu.cn>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Erick Archer <erick.archer@gmx.com>, Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] docs/zh_CN/power: Use kcalloc() instead of kzalloc()
Message-ID: <20240121100200.GA2790@titan>
References: <20240120122204.4287-1-erick.archer@gmx.com>
 <a567932c-d878-44e5-836f-90fa15999ba6@link.tyut.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a567932c-d878-44e5-836f-90fa15999ba6@link.tyut.edu.cn>
X-Provags-ID: V03:K1:tmBTpr5C/7J3nUOCUFtcx1Io4AKYQYgyFXKIFHQt1S7l9VaSvqH
 BiUnQ/5KH7dGSyCbEtHit7UM212DY+MeaD6Bd/gLESkBVxfItTBUkVm81+iNWcI+A9PZ1EH
 CvkyiRH+JebAfBfg0Oj/UjRsR3zcLU3SKxdI5zCzGY7fUtvWYXBK6tZBqFJNNjWN7N/rdAy
 XhXF36i7iBXMc8XSeqmsg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+f0LBdijmAA=;RUTWIuVqfR+NAd2kYjIN1CUlEnB
 H3InGi9HvBi0RB90KCz6DV7IZGN3GxaPBX6+uKGrmclTylNYOHIWSKAb032X+QWTZKE00sqXg
 vBxemqr6mF1+Newxeuvu0Q9lkiVZLPMtMMvFZ/vuI3ZwBc8+JXNxvkpcV3Fe8PQ/jRZzZVPQL
 BPOuj5fH8HiycbXQoRYFM+5Ki/MGLbgSA5zEw2nHkqNEvQTwp+46UnnDrE9ZvNq6KVxUQuc6Q
 POr8yNhoLQDEpeRZ1B1RdFm252733DPEPGhVluJPvGeoFVqzaoQGJCiH9GTB3dNpQoQsgo1yr
 cPNK1eW7MdLCaSWWd/oJ0Adv11eda75B2BbPPqO5FbJvOcOWHHm+47IOPToNi+aFQyIyxyp2q
 z7rMxfkgGLyyAuroYThXl9n5CLqPC+ORiV9fsbeVBL2tFr0Varwr3cFoAG3SESFHPAcyEBKdh
 PnGRXPzMVPyGkxFdr5kcQIJ0SrAJG1pdpcxsc5eKMgCu96ZhBc/dtQKVC+UmWQBBlULLjGuOv
 Z9zTnmw9Vrd5EhoX2tWoKspi0p05u4IDptC+P1G8mrT7iL3YTNqwkowq5tk6wo08QCW7PHODQ
 GESDGLHyxNyItYlEv5MGYS+V64jQZmE62PanG86B6Q3Mw/EsBnExoZk+YsR9KF8ZNHEOmaGY+
 GMVQpXcDhPx49Ju78ewjUSx6g2jHpZgKVseYVfCbWdV0Z6cszCH9ViOxf4+fap6WqFJVIzeR4
 NZIFpfV0reyivx1o+zi6yJwiBsrXzfurjwkv7y6aVrCsT6Gg5QqMLSX4X3DV5AvLR+1qewYGM
 PumIJYITvNxoNo4uJTieGRLhEgzHfLsnnkm+qscLS/zh/is0cVGEtIHCCDlVUBXCxbu3/aQ+b
 A0ceYE8kCdy+1DlXcUuUzPf7RGVJgbZ2du10tq0zRHd04LMyU2c5H/j0Utghjbn9o0f8kyfbX
 /02jL/jzM7RO+1DgPuG+hPCzW+Y=

Hi Hu and Jonathan,

On Sat, Jan 20, 2024 at 10:24:42PM +0800, Hu Haowen wrote:
>
> =E5=9C=A8 2024/1/20 20:22, Erick Archer =E5=86=99=E9=81=93:
> > As noted in the "Deprecated Interfaces, Language Features, Attributes,
> > and Conventions" documentation [1], size calculations (especially
> > multiplication) should not be performed in memory allocator (or simila=
r)
> > function arguments due to the risk of them overflowing. This could lea=
d
> > to values wrapping around and a smaller allocation being made than the
> > caller was expecting. Using those allocations could lead to linear
> > overflows of heap memory and other misbehaviors.
> >
> > So, in the example code use the purpose specific kcalloc() function
> > instead of the argument size * count in the kzalloc() function.
> >
> > Link: https://www.kernel.org/doc/html/next/process/deprecated.html#ope=
n-coded-arithmetic-in-allocator-arguments [1]
> > Link: https://github.com/KSPP/linux/issues/162
> > Signed-off-by: Erick Archer <erick.archer@gmx.com>
> > ---
> >   Documentation/translations/zh_CN/power/opp.rst | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/translations/zh_CN/power/opp.rst b/Document=
ation/translations/zh_CN/power/opp.rst
> > index 8d6e3f6f6202..7470fa2d4c43 100644
> > --- a/Documentation/translations/zh_CN/power/opp.rst
> > +++ b/Documentation/translations/zh_CN/power/opp.rst
> > @@ -274,7 +274,7 @@ dev_pm_opp_get_opp_count
> >   	 {
> >   		/* =E5=81=9A=E4=B8=80=E4=BA=9B=E4=BA=8B=E6=83=85 */
> >   		num_available =3D dev_pm_opp_get_opp_count(dev);
> > -		speeds =3D kzalloc(sizeof(u32) * num_available, GFP_KERNEL);
> > +		speeds =3D kcalloc(num_available, sizeof(u32), GFP_KERNEL);
>
>
> If the translated version is modified, I think the original file should
> follow as well at Documentation/power/opp.rst line 308:
>
> diff --git a/Documentation/power/opp.rst b/Documentation/power/opp.rst
> index a7c03c470980..dca35018214a 100644
> --- a/Documentation/power/opp.rst
> +++ b/Documentation/power/opp.rst
> @@ -305,7 +305,7 @@ dev_pm_opp_get_opp_count
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* Do things */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 num_available =3D dev_pm_opp_get_opp_count(dev);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 speeds =3D kzalloc(sizeof(u32) * num_available, GFP_KERNEL=
);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 speeds =3D kcalloc(sizeof(u32) * num_available, GFP_KERNEL=
);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* populate the table in increasing order */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 freq =3D 0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 while (!IS_ERR(opp =3D dev_pm_opp_find_freq_ceil(dev, &=
freq)))
> {

As you both suggested, this change should be made if the original file is
changed. Therefore, before this patch I already sent another one [1] that
made the proposed changes to the original file.

[1] https://lore.kernel.org/linux-hardening/20240120120527.3866-1-erick.ar=
cher@gmx.com/

But if you prefer, I can send just one patch with the two changes.

Best regards,
Erick

>
> Thanks,
> Hu Haowen
>
>
> >   		/* =E6=8C=89=E5=8D=87=E5=BA=8F=E5=A1=AB=E5=85=85=E8=A1=A8 */
> >   		freq =3D 0;
> >   		while (!IS_ERR(opp =3D dev_pm_opp_find_freq_ceil(dev, &freq))) {
> > --
> > 2.25.1
> >
> >
> >


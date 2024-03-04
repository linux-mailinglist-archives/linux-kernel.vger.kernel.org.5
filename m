Return-Path: <linux-kernel+bounces-90527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4978700A1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12CB8B2387E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D333B299;
	Mon,  4 Mar 2024 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvdcOhRh"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B212BCFF;
	Mon,  4 Mar 2024 11:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709552810; cv=none; b=uX4X3LWbdwPsoGpPLbFPxLdRFq+nGlEt9VKicaSIGOJlwgMkqdII5+18rlqAXPEyIIxRDKitDoDX5sM8KnDtqhEpbyiW9D/6x2Kr7MHKOiYFtKAJyFXO4/wW1IV1+8KsFj9EWeDlKvPK7uGROnPeKHGSZidU9mx+rm070VlwSPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709552810; c=relaxed/simple;
	bh=MREf+q+trSbCOEQo2zmMzNcMz+h6WiYld+brhD1xTWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vAwaLAzDFboMP/bVJFK9zywBFqXy1AIds7Fm2YeGVoUrEQdCLkU8eWgGadbQDQJ0JCVVCnNvVc7kn/x66Ipn9U6s3bdjbzYXtYK+aSeZSjR7A7FLyvT8jOtxJWddXCXipOaVpyXqVCdbcH1Zsx+WtZ2YIbsqGPYQV7hurDvKiaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvdcOhRh; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5a0a19c9bb7so3538188eaf.3;
        Mon, 04 Mar 2024 03:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709552808; x=1710157608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JEGHtbqyJwPzknb9cutu3F9GTXF2cnTcxkajaqQGKU=;
        b=DvdcOhRhKJyzGkG7Xb+992GJpuMqhdDK05IQXQlF3RDOmeun1SMzVBtpt8kqypkoyR
         5+JSoS0LXJ+EJJhxTa4FOGIRA3bwp2TDgRTtdwn5TM0LELJJseas43sRlLsKxAhwVaKT
         v+Hi5kqyLRPj0iTqtFuNjta5vU/X1IgpPlBa+AYMW3Kd/OA8eCLBr/IkUM8hVGLD8YRm
         Ii0Bx8wTHySCJcPoEPgBJnyhL9gFcNOXRjEJzNfLbuvGof4dFnRdyYu+keqP29PYUhey
         GgaxbzGK1dularqYVkhBM4ixCMQTA4MKiRsdJfx1ZoO8HMv83eFHT6JyCqwVo9w7C/SF
         JShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709552808; x=1710157608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JEGHtbqyJwPzknb9cutu3F9GTXF2cnTcxkajaqQGKU=;
        b=kg0IeYDFci5KRr4K63TTWp3sELHuJCguH5li7mJrv7K4Rd+InU8xWj45Ny6apR1kJW
         9eQ41V9MFM3u6z3Zqd8v+J3Gr0j7o4yjU9JqYj6QeSRn4146XefFfMVSSgH+biCxFr5U
         ix3BWG5dPShZmGxgr9KVr6NW2gwJYVzKHWBdeD6SvKumivyLvMIlLMhAxM0Sw6vJr43o
         vELmL1MbUW2DV9Heqg9XLOfvaxcGM+KYGJBQEDl52Gs40mSY5AgBYQbV8JpkmiNxp03N
         w8xE6uc5fbo+d8opwgeB9uQt0SZlRti5fDqRbVBv+DR2E4ZszO+ma/24+SpTFdaUdq6X
         VpaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOywENJYacw6n6vNS4N8GMG0rypYriOC6pWoT8vIYSpkNrog27t1ocGAYz4Qs47JHxQberi3caS07NGFuKaMXQ8RHvH+9ErTd1nPHLz8K5MJ6XWNMvyNrc1ccicQKbuMdzX3MbSvpUBk+K30HyblX5wIIOyekYWM/ryIQhQKmGYRBWOoxUL9TZKlA=
X-Gm-Message-State: AOJu0YyBFHIiJDuoJCam9w8bY7DSOkiBJv/TxyqlIT17q+/qA+CkibJE
	qlHG3Kap2k7WUiRbSBlR+c5kpheyvsHZ+6bE3ehqTJWllJ57WyIuDq2KGiGPQ5DgPQsihpCpz1V
	KHVvAHswhiv36hGFSk5aRYFwa24w=
X-Google-Smtp-Source: AGHT+IEeP26jeJGto7pU0/H3MLxor72shrPPLiWXPA7B5vfhOmQFc4jDmdCqhuCwpM9prlDnUrdGDerfdd0RJie/m6k=
X-Received: by 2002:a05:6820:2281:b0:5a1:841:c2a6 with SMTP id
 ck1-20020a056820228100b005a10841c2a6mr7832749oob.3.1709552807779; Mon, 04 Mar
 2024 03:46:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301193831.3346-1-linux.amoon@gmail.com> <20240301193831.3346-4-linux.amoon@gmail.com>
 <52158bf6-16fe-4ce2-b9b6-bbc6550a6e14@wanadoo.fr> <CANAwSgTCaSSMN2QCw5fr=RBp0WwWaLuebzQDO=scnABNFNctJQ@mail.gmail.com>
 <e85ad80f-af7d-4eaf-9d14-dff13451f7e5@wanadoo.fr>
In-Reply-To: <e85ad80f-af7d-4eaf-9d14-dff13451f7e5@wanadoo.fr>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 4 Mar 2024 17:16:35 +0530
Message-ID: <CANAwSgRrOw+6MHLPDP8RwLwzwB1EVGBTovtR2ChhqR3b5uWowA@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] usb: dwc3: exynos: Use devm_regulator_bulk_get_enable()
 helper function
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On Sun, 3 Mar 2024 at 00:07, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 02/03/2024 =C3=A0 17:48, Anand Moon a =C3=A9crit :
> > Hi Christophe,
> >
> > On Sat, 2 Mar 2024 at 21:20, Christophe JAILLET
> > <christophe.jaillet@wanadoo.fr> wrote:
> >>
> >> Le 01/03/2024 =C3=A0 20:38, Anand Moon a =C3=A9crit :
> >>> Use devm_regulator_bulk_get_enable() instead of open coded
> >>> 'devm_regulator_get(), regulator_enable(), regulator_disable().
> >>>
> >>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> >>> ---
> >>>    drivers/usb/dwc3/dwc3-exynos.c | 49 +++---------------------------=
----
> >>>    1 file changed, 4 insertions(+), 45 deletions(-)
> >>>
> >>> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-e=
xynos.c
> >>> index 5d365ca51771..7c77f3c69825 100644
> >>> --- a/drivers/usb/dwc3/dwc3-exynos.c
> >>> +++ b/drivers/usb/dwc3/dwc3-exynos.c
> >>> @@ -32,9 +32,6 @@ struct dwc3_exynos {
> >>>        struct clk              *clks[DWC3_EXYNOS_MAX_CLOCKS];
> >>>        int                     num_clks;
> >>>        int                     suspend_clk_idx;
> >>> -
> >>> -     struct regulator        *vdd33;
> >>> -     struct regulator        *vdd10;
> >>>    };
> >>>
> >>>    static int dwc3_exynos_probe(struct platform_device *pdev)
> >>> @@ -44,6 +41,7 @@ static int dwc3_exynos_probe(struct platform_device=
 *pdev)
> >>>        struct device_node      *node =3D dev->of_node;
> >>>        const struct dwc3_exynos_driverdata *driver_data;
> >>>        int                     i, ret;
> >>> +     static const char * const regulators[] =3D { "vdd33", "vdd10" }=
;
> >>>
> >>>        exynos =3D devm_kzalloc(dev, sizeof(*exynos), GFP_KERNEL);
> >>>        if (!exynos)
> >>> @@ -78,27 +76,9 @@ static int dwc3_exynos_probe(struct platform_devic=
e *pdev)
> >>>        if (exynos->suspend_clk_idx >=3D 0)
> >>>                clk_prepare_enable(exynos->clks[exynos->suspend_clk_id=
x]);
> >>>
> >>> -     exynos->vdd33 =3D devm_regulator_get(dev, "vdd33");
> >>> -     if (IS_ERR(exynos->vdd33)) {
> >>> -             ret =3D PTR_ERR(exynos->vdd33);
> >>> -             goto vdd33_err;
> >>> -     }
> >>> -     ret =3D regulator_enable(exynos->vdd33);
> >>> -     if (ret) {
> >>> -             dev_err(dev, "Failed to enable VDD33 supply\n");
> >>> -             goto vdd33_err;
> >>> -     }
> >>> -
> >>> -     exynos->vdd10 =3D devm_regulator_get(dev, "vdd10");
> >>> -     if (IS_ERR(exynos->vdd10)) {
> >>> -             ret =3D PTR_ERR(exynos->vdd10);
> >>> -             goto vdd10_err;
> >>> -     }
> >>> -     ret =3D regulator_enable(exynos->vdd10);
> >>> -     if (ret) {
> >>> -             dev_err(dev, "Failed to enable VDD10 supply\n");
> >>> -             goto vdd10_err;
> >>> -     }
> >>> +     ret =3D devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulato=
rs), regulators);
> >>> +     if (ret)
> >>> +             return dev_err_probe(dev, ret, "Failed to enable regula=
tors\n");
> >>>
> >>>        if (node) {
> >>>                ret =3D of_platform_populate(node, NULL, NULL, dev);
> >>> @@ -115,10 +95,6 @@ static int dwc3_exynos_probe(struct platform_devi=
ce *pdev)
> >>>        return 0;
> >>>
> >>>    populate_err:
> >>> -     regulator_disable(exynos->vdd10);
> >>> -vdd10_err:
> >>> -     regulator_disable(exynos->vdd33);
> >>> -vdd33_err:
> >>>        for (i =3D exynos->num_clks - 1; i >=3D 0; i--)
> >>>                clk_disable_unprepare(exynos->clks[i]);
> >>>
> >>> @@ -140,9 +116,6 @@ static void dwc3_exynos_remove(struct platform_de=
vice *pdev)
> >>>
> >>>        if (exynos->suspend_clk_idx >=3D 0)
> >>>                clk_disable_unprepare(exynos->clks[exynos->suspend_clk=
_idx]);
> >>> -
> >>> -     regulator_disable(exynos->vdd33);
> >>> -     regulator_disable(exynos->vdd10);
> >>>    }
> >>>
> >>>    static const struct dwc3_exynos_driverdata exynos5250_drvdata =3D =
{
> >>> @@ -196,9 +169,6 @@ static int dwc3_exynos_suspend(struct device *dev=
)
> >>>        for (i =3D exynos->num_clks - 1; i >=3D 0; i--)
> >>>                clk_disable_unprepare(exynos->clks[i]);
> >>>
> >>> -     regulator_disable(exynos->vdd33);
> >>> -     regulator_disable(exynos->vdd10);
> >>
> >> Hi,
> >>
> >> Same here, I don't think that removing regulator_[en|dis]able from the
> >> suspend and resume function is correct.
> >>
> >> The goal is to stop some hardware when the system is suspended, in ord=
er
> >> to save some power.
> > Ok,
> >>
> >> Why did you removed it?
> >
> > As per the description of the function  devm_regulator_bulk_get_enable
> >
> > * This helper function allows drivers to get several regulator
> >   * consumers in one operation with management, the regulators will
> >   * automatically be freed when the device is unbound.  If any of the
> >   * regulators cannot be acquired then any regulators that were
> >   * allocated will be freed before returning to the caller.
>
> The code in suspend/resume is not about freeing some resources. It is
> about enabling/disabling some hardware to save some power.
>
> Think to the probe/remove functions as the software in the kernel that
> knows how to handle some hardawre, and the suspend/resume as the on/off
> button to power-on and off the electrical chips.
>
> When the system is suspended, the software is still around. But some
> hardware can be set in a low consumption mode to save some power.
>
> IMHO, part of the code you removed changed this behaviour and increase
> the power consumption when the system is suspended.
>

You are correct, I have changed the regulator API from
devm_regulator_get_enable to devm_regulator_bulk_get_enable
which changes this behavior.
I will fix it in the next version.

> CJ

Thanks
-Anand


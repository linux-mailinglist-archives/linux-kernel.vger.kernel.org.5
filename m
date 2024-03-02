Return-Path: <linux-kernel+bounces-89520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A5686F176
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 17:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392FA1F21FBF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF252BB08;
	Sat,  2 Mar 2024 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtRO6vlV"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247D42576E;
	Sat,  2 Mar 2024 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709398136; cv=none; b=JQytdZXdX6AR8Li3TdIKI3oGe3j+8gCaBvQHSPguTRWHRuGp5MJby5V8QHis/oawXEwx/02OycioOpbHka8CT/xFJ7RVIRB85i+DUk1TdOaKA4I30ob38D5XJzCM0wcDAiM+c00pIYXKN9KVczNgRjDL6JLKIy3V7F/5ieeybmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709398136; c=relaxed/simple;
	bh=y35nQqHvk8et3aA/CLuaDglmNABgxaS61lBtLH5SflQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QyJKeG1nVBPbQZM5Y+o1VumSDJtMgJswNdyu67lwMjIrID/KQhKfuOU8JgtGX3c4h9stBMNDTrthzfMPTjMP1Qy2KDgKRvaXl5/dEldwOmsV13jglD2d+fJAmhJVE3nnfOvzeU/3as0+SpAaX/kRCsk3710fcWpowGFCQfygbkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtRO6vlV; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e4d88b93e8so197966a34.0;
        Sat, 02 Mar 2024 08:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709398134; x=1710002934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aTmr/G6TBOiO/VLM0W9MwJQXpsDd1fTyOWRtibIPFE=;
        b=VtRO6vlVUJNii/KyfkLNO1+5/qqB1PjJTFAAj43YYnV79o8Z38z4DGnnb8BOzWzjo/
         k0VkECia93TQ7dBBb0YUDZuV0PL3Q2sa26WRwTKMz/Y3xh8ScknyS6GzvU69hIkEYR49
         AcVs5wYv6c/4c+rjoshZLBCwiHTn42VbvifDykNanYnFtmjg8rBTStI8MjnAkWY+rrDX
         YZQcFOxHDXOTXLAgwG4yhswckJZ+3AxvjiKKTELIqC6DmNseVPs1qS/deaeE4O4LOVrB
         PE7iHfnacfFy2cGOJyeBY2XMafK2QZAafAqA/fQRdUBZei0Bl7TA4KdMDzjyI/Oq2qKP
         bbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709398134; x=1710002934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6aTmr/G6TBOiO/VLM0W9MwJQXpsDd1fTyOWRtibIPFE=;
        b=HnjPgMv+BjpIt2Bq6GJ0Co157LoUDh/ESBE/Du4s74qqkSt5L+8dhIlIVXFtLnxL94
         EaKATXX/t6DLbU/Wbfu2aweQadyV9Uv4LkHLOcCCHxJ655uD8N6lFL79ulF6Sdatz+o3
         HfecAg3KmbnoDw72CmdKTd6g9GRq/OzCs4vZBcu5diRPKS1iINtbb4JQ1BmPN0pYa3+5
         vRTusyF2TJ4J1CcsIUKozfFaWS5vhTx0vHrl5pJ9G3/FACuhYu6l2MHsL2MJZxSLhVUE
         JaNTaPuSnQZO2tDeTiMDA0lzMqNcHpRroJOXJfyPibh4SgQQ31TFdc+6jdj0FVjH2gE+
         Klxg==
X-Forwarded-Encrypted: i=1; AJvYcCWFfi+bV19uKbtee/wh7ALUUxN79Q+X2xDHch+y9/+ezgvBzsihlF+Cxey6oBG9bye3wfhtEn4VgbZ38WRuE2ZYaAUNs7rJmwuGymoapZXmG8igoN6QYRUNv0soN4upzw4rJtRZ+HCA/uHYj7EpnHYptDjTUDWvxtEgsL4WcvrZXNOQaMNSUl07RPs=
X-Gm-Message-State: AOJu0Ywp4k4tlekb4Nufoxj5foz4DdDhls129hKLKQ/+kC+tNID+ts+F
	t13wkAv5fTA2guJDCjMOcowfb2KwLv3mmgWyFwF+Y9AhRaPumeGD4nzzpsl1b3j2IfjkahuIXGB
	/7kKJ3kbOKilETLUvrDtAypCn7rM=
X-Google-Smtp-Source: AGHT+IEh/kIzLb+xvSkjlIu4hIrDTmCQsguu9qJCUavYtNz9VyGgQHZldluKXmIqDaUL9Wjco22OIcI5b4rfcE/or0U=
X-Received: by 2002:a05:6830:108f:b0:6e4:7b1a:e334 with SMTP id
 y15-20020a056830108f00b006e47b1ae334mr4881158oto.20.1709398134290; Sat, 02
 Mar 2024 08:48:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301193831.3346-1-linux.amoon@gmail.com> <20240301193831.3346-4-linux.amoon@gmail.com>
 <52158bf6-16fe-4ce2-b9b6-bbc6550a6e14@wanadoo.fr>
In-Reply-To: <52158bf6-16fe-4ce2-b9b6-bbc6550a6e14@wanadoo.fr>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 2 Mar 2024 22:18:39 +0530
Message-ID: <CANAwSgTCaSSMN2QCw5fr=RBp0WwWaLuebzQDO=scnABNFNctJQ@mail.gmail.com>
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

On Sat, 2 Mar 2024 at 21:20, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 01/03/2024 =C3=A0 20:38, Anand Moon a =C3=A9crit :
> > Use devm_regulator_bulk_get_enable() instead of open coded
> > 'devm_regulator_get(), regulator_enable(), regulator_disable().
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >   drivers/usb/dwc3/dwc3-exynos.c | 49 +++------------------------------=
-
> >   1 file changed, 4 insertions(+), 45 deletions(-)
> >
> > diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exy=
nos.c
> > index 5d365ca51771..7c77f3c69825 100644
> > --- a/drivers/usb/dwc3/dwc3-exynos.c
> > +++ b/drivers/usb/dwc3/dwc3-exynos.c
> > @@ -32,9 +32,6 @@ struct dwc3_exynos {
> >       struct clk              *clks[DWC3_EXYNOS_MAX_CLOCKS];
> >       int                     num_clks;
> >       int                     suspend_clk_idx;
> > -
> > -     struct regulator        *vdd33;
> > -     struct regulator        *vdd10;
> >   };
> >
> >   static int dwc3_exynos_probe(struct platform_device *pdev)
> > @@ -44,6 +41,7 @@ static int dwc3_exynos_probe(struct platform_device *=
pdev)
> >       struct device_node      *node =3D dev->of_node;
> >       const struct dwc3_exynos_driverdata *driver_data;
> >       int                     i, ret;
> > +     static const char * const regulators[] =3D { "vdd33", "vdd10" };
> >
> >       exynos =3D devm_kzalloc(dev, sizeof(*exynos), GFP_KERNEL);
> >       if (!exynos)
> > @@ -78,27 +76,9 @@ static int dwc3_exynos_probe(struct platform_device =
*pdev)
> >       if (exynos->suspend_clk_idx >=3D 0)
> >               clk_prepare_enable(exynos->clks[exynos->suspend_clk_idx])=
;
> >
> > -     exynos->vdd33 =3D devm_regulator_get(dev, "vdd33");
> > -     if (IS_ERR(exynos->vdd33)) {
> > -             ret =3D PTR_ERR(exynos->vdd33);
> > -             goto vdd33_err;
> > -     }
> > -     ret =3D regulator_enable(exynos->vdd33);
> > -     if (ret) {
> > -             dev_err(dev, "Failed to enable VDD33 supply\n");
> > -             goto vdd33_err;
> > -     }
> > -
> > -     exynos->vdd10 =3D devm_regulator_get(dev, "vdd10");
> > -     if (IS_ERR(exynos->vdd10)) {
> > -             ret =3D PTR_ERR(exynos->vdd10);
> > -             goto vdd10_err;
> > -     }
> > -     ret =3D regulator_enable(exynos->vdd10);
> > -     if (ret) {
> > -             dev_err(dev, "Failed to enable VDD10 supply\n");
> > -             goto vdd10_err;
> > -     }
> > +     ret =3D devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators=
), regulators);
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "Failed to enable regulato=
rs\n");
> >
> >       if (node) {
> >               ret =3D of_platform_populate(node, NULL, NULL, dev);
> > @@ -115,10 +95,6 @@ static int dwc3_exynos_probe(struct platform_device=
 *pdev)
> >       return 0;
> >
> >   populate_err:
> > -     regulator_disable(exynos->vdd10);
> > -vdd10_err:
> > -     regulator_disable(exynos->vdd33);
> > -vdd33_err:
> >       for (i =3D exynos->num_clks - 1; i >=3D 0; i--)
> >               clk_disable_unprepare(exynos->clks[i]);
> >
> > @@ -140,9 +116,6 @@ static void dwc3_exynos_remove(struct platform_devi=
ce *pdev)
> >
> >       if (exynos->suspend_clk_idx >=3D 0)
> >               clk_disable_unprepare(exynos->clks[exynos->suspend_clk_id=
x]);
> > -
> > -     regulator_disable(exynos->vdd33);
> > -     regulator_disable(exynos->vdd10);
> >   }
> >
> >   static const struct dwc3_exynos_driverdata exynos5250_drvdata =3D {
> > @@ -196,9 +169,6 @@ static int dwc3_exynos_suspend(struct device *dev)
> >       for (i =3D exynos->num_clks - 1; i >=3D 0; i--)
> >               clk_disable_unprepare(exynos->clks[i]);
> >
> > -     regulator_disable(exynos->vdd33);
> > -     regulator_disable(exynos->vdd10);
>
> Hi,
>
> Same here, I don't think that removing regulator_[en|dis]able from the
> suspend and resume function is correct.
>
> The goal is to stop some hardware when the system is suspended, in order
> to save some power.
Ok,
>
> Why did you removed it?

As per the description of the function  devm_regulator_bulk_get_enable

* This helper function allows drivers to get several regulator
 * consumers in one operation with management, the regulators will
 * automatically be freed when the device is unbound.  If any of the
 * regulators cannot be acquired then any regulators that were
 * allocated will be freed before returning to the caller.

[0] https://elixir.bootlin.com/linux/latest/source/drivers/regulator/devres=
c#L330

I have tested with rtc suspend resume and did not find any issue with
this.patch.

>
> CJ
>
Thanks
-Anand


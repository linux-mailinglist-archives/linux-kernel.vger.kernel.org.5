Return-Path: <linux-kernel+bounces-131055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF27898278
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7597B288E3D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201F65D465;
	Thu,  4 Apr 2024 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfu+l6ia"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E966BB37;
	Thu,  4 Apr 2024 07:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712217025; cv=none; b=GQdqrQAHPwrPJQWTD+w0DzeI3XokB3dGfEwn55ZlY2kg7wTreANdIuvzExCGq844tbrlUL6aidFwjDHFtOH1SWPakxHz9CfMLqIPn+pbyA21Mn48aDK5l5DRzypiFePFgUdd3tZperY49YGyq4r/FZAkWLKkq6Ro7L5PQGvp/yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712217025; c=relaxed/simple;
	bh=NWxJC3S7oWeoP6JnP4Wnt4FVn9if0vkhHt462TfgcJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bR3gUDqdEwu8k/sKwjf29zQkKtzjin1Lgbxy9AowdALWaTcTF0wBrT/4itt5t5Wtsdk5QKgXdb8i3bDjtW2oR4r2jv89U9agqHE1dWAZp+FIv/L4oaUN7c2ZeUJP379tpwz2jrSfE/idIzuuRYe9rH+fs80gSw309oKUwaGqefg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfu+l6ia; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a128e202b6so241798eaf.2;
        Thu, 04 Apr 2024 00:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712217023; x=1712821823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7DLipv1gLwdp+4wPnw2EaA0n0cimect1ObBpG2y7Fc8=;
        b=dfu+l6iaVjF4jms5yWtNIPk1BTsCCqut6ekb5I3RWa58bh6g4yPnNUvWE2tOD98qYn
         p6LT28a2+NTkihMNq2AIjKS0Y0hL0oK7XXcz9S55jzAWq/2xEObnLik1u4iY2PP81hkB
         n9QpYqzdAf5y6W+jKpopwlLF0b70HIAcoZWMGIXCaGzQ74iHmEuTKOgMwJ6h0w6SbmRO
         hmWhu3tq0IPrU5cg0qoTg9uXrt/fNr0Xv9lwk3Fu5mNJgegIBp4nfb3rLpMS5lOy8ejo
         OnsVNrbM+mOlfbevlqJtL/OesgxyGf/z9h9eEYxJbNFPl4AoXrxQt24KcCExVQiSX1xB
         fbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712217023; x=1712821823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7DLipv1gLwdp+4wPnw2EaA0n0cimect1ObBpG2y7Fc8=;
        b=nXMaQGVx+3HDn+wo0SzBgA+MKI8NyQ3X+7LfAyCMRZ9JH0GeLV6XbPniYS8VIuflEF
         1ASuHsVBQy8XvzRK2jyxvMrFxosfZJzyfMyHOZ8OEXQusSbcb/Xx7fR+RcccqsU3p/9F
         6DKBvViFBPLZkvJ8vL4gL0NMOpucrGy9Rs7O1woIW9p3XJNdbYGXwbqXFD0ypk4WrROF
         uKplUCrecXET0/8uefQjOPOVqFrrhcshmU7Ay4xZWsv3axfRl4+UbwK3jdR+/v9ICPQP
         YwBhBEfkWT95YHuyZyeYvduRNQXBs31nGRI+qGs84kGJaJ5746p1+qhCN5KL0hjD02cU
         GRjA==
X-Forwarded-Encrypted: i=1; AJvYcCUUuK9A9pyWL29YA+5Kh53r4nicbcJ59EGrDHJCaTRlZZ5rzsDqrQcrF93NudB9edwT+H/PziB5RofhIF2LJaT8LXBuACD3Z+pNzKncqo9S+EO8f+WjM8N72MR3QaoXma3MR0klgcan2t43WVA9P40nFQ+XQhwcu4tjdAMcwlcQNOUzH8hy/C277v4=
X-Gm-Message-State: AOJu0Yw+9lZLiyx9WizJ+euafUAq4k5uAJZC+Un9iPeaGLKCNbqBUt7C
	J/IYF6VMDjTm1VE9ECsThQiP2S5fYIRBedfQROBPotr37YforeLq1AbjIsKS2NEn5sPk3X0kxax
	NNZentCO+0uMeqBjPHdyTrQoFeM4=
X-Google-Smtp-Source: AGHT+IEplLI26Agv3bOugDmqgcY0bZfVaal2vGF+fsJurKCq8gepckFybKV9rn+Ek4jGGtsVEYO1ReRXzrPUQeXcJiM=
X-Received: by 2002:a05:6820:a08:b0:5a4:77f2:1c9f with SMTP id
 ch8-20020a0568200a0800b005a477f21c9fmr1669484oob.6.1712217022889; Thu, 04 Apr
 2024 00:50:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404071350.4242-1-linux.amoon@gmail.com> <20240404071350.4242-4-linux.amoon@gmail.com>
 <0a21f8e8-f4a6-4311-ab35-a02a1a593629@linaro.org>
In-Reply-To: <0a21f8e8-f4a6-4311-ab35-a02a1a593629@linaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 4 Apr 2024 13:20:07 +0530
Message-ID: <CANAwSgSU6YYM5qCrmsqp8vWDJkAMTOOAc2Wrjf8Fe8x72-4aGA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] usb: ohci-exynos: Use devm_clk_get_enabled() helpers
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Johan Hovold <johan@kernel.org>, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,


On Thu, 4 Apr 2024 at 12:50, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 04/04/2024 09:13, Anand Moon wrote:
> > The devm_clk_get_enabled() helpers:
> >     - call devm_clk_get()
> >     - call clk_prepare_enable() and register what is needed in order to
> >       call clk_disable_unprepare() when needed, as a managed resource.
> >
> > This simplifies the code and avoids the calls to clk_disable_unprepare().
> >
> > While at it, use dev_err_probe consistently, and use its return value
> > to return the error code.
> >
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v2: new changes in this series.
> > ---
> >  drivers/usb/host/ohci-exynos.c | 19 +++++--------------
> >  1 file changed, 5 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
> > index 20e26a474591..85d04ae0ae40 100644
> > --- a/drivers/usb/host/ohci-exynos.c
> > +++ b/drivers/usb/host/ohci-exynos.c
> > @@ -135,20 +135,15 @@ static int exynos_ohci_probe(struct platform_device *pdev)
> >
> >       err = exynos_ohci_get_phy(&pdev->dev, exynos_ohci);
> >       if (err)
> > -             goto fail_clk;
> > -
> > -     exynos_ohci->clk = devm_clk_get(&pdev->dev, "usbhost");
> > +             goto fail_io;
> >
> > +     exynos_ohci->clk = devm_clk_get_enabled(&pdev->dev, "usbhost");
> >       if (IS_ERR(exynos_ohci->clk)) {
> > -             dev_err(&pdev->dev, "Failed to get usbhost clock\n");
> > -             err = PTR_ERR(exynos_ohci->clk);
> > -             goto fail_clk;
> > +             usb_put_hcd(hcd);
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(exynos_ohci->clk),
> > +                             "Failed to get usbhost clock\n");
>
> Why do you introduce entirely parallel exit paths? There is already
> single error handling part with labels. Use that.
>
OK, I  will use the labels to return over here,
>
>
> Best regards,
> Krzysztof
>
Thanks

-Anand


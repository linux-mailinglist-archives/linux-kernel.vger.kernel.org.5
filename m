Return-Path: <linux-kernel+bounces-135197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B2889BC94
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069E1282FC7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7AE52F71;
	Mon,  8 Apr 2024 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Atm40Bj5"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E2614293;
	Mon,  8 Apr 2024 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712570605; cv=none; b=IIVnyJWo6ZvV9x7iNWTH8opmtyAzjRVdNHnncNBDMPvRTJ9I47R7ycu7eJvwz18+QEUcq5Oj6ZCdXvlZ8aY4kZgMEFOyHs/klLaE9zy+hlSSmtPiSPE7YHM4gmMaJBaddSxkhUpi/yoOnArK14c0UgIM2vtbxkhjH7MBSYhIlb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712570605; c=relaxed/simple;
	bh=WORzMsyv7/eD22IgJnRRrJyiZieZ+C20vntCjs2Cb68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kWU9oCkC8Cj4Qarlpecr3IeLLFOIl66Qr8yuEWV2XXi8rTaEkh5ZMh4DQyr5GtzLeGrENQkLNeB4T1Tlk1zvGuVI2aln6MlAMYA3UsJ4QXboD/AR2z8sAi42la7EkHmxRjl6P8fdMZt6KKneltsag0oCEnAl9nt62ibSR0IOhs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Atm40Bj5; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c5ed27114bso166915b6e.0;
        Mon, 08 Apr 2024 03:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712570603; x=1713175403; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2PE03u/ATA7y4is4W65IiCIRxo+xGf7RO1YxtgagN7Q=;
        b=Atm40Bj5DhHX529XEa8+6GDsUotHimRLTZI0XdPiUmKmiXgo0a7PNVBf/DRSRmBwyD
         iUHguEcfQAZ3Ucpd+7jvOleaA7DIkG9u+hgX8iRJdQXhEOeW0jpic3o9ONRc/L18OFbj
         aeyeEThA5CTkf0HlkBEadIG3bStmvtd7cewo54mG7fgxaVPuSHyrCkaWuHEgs4X6QHQc
         y1N1Io0Yzc9Ooe3o7H8/j8Q8O8sbDmHxhkMNg3IFDepJQNz9MOjLpMMKEcORLioOuZRJ
         z2Hs2t8R45CkPg/0RCF8EDi5FxImC37Gys93G4DQ3B0fegi17TgJ0qaMCPW1LU3eqTCW
         FChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712570603; x=1713175403;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2PE03u/ATA7y4is4W65IiCIRxo+xGf7RO1YxtgagN7Q=;
        b=nvUPjUJ9lkiQHcI3NkQXgFnvcKfxod+R+l7zpYDAyVqjCtXf89LANuI0mxTPgjQrM2
         rb1h7OaPK02ekCjQvXIUhjHt7Wb3hS6wNYfceQHnYLu+Oqx28UBGBk4/gJMHDhIZC0fO
         ulIUkiUQe32aw3uScqMFPx7A2xUcFW7bN5QWRVUXwOQOt94fLsdjNFVj6zQToOaNqRwB
         chBsiQq7NX9GmmXQ7r14TqtTMQzEobQ5ovJlwwux6qm+W41mI/QWurlVzwqgGTBika9T
         kR3Ox0lUhmvOc4Q4oQ78bK2KX21Po3eXi2YlzLCU5svfNXf+L7RoBLRWQbPx7mzh5jqo
         9OuA==
X-Forwarded-Encrypted: i=1; AJvYcCXhKG7E/gUVy1A247kCq1xXLSkQ5wnq8RA6a6w26wUdId8A3DXMpMxeIYouQBd8uTUPyFoUAMwuPvB2eGJblD1n8Qs1aGSgn9MAUAn9m/okCH9aA9OSGNa9kQ7EuQEAS7icEOzufpGg2a0X+6f5kmNFixU9ne3CxnTlpwwGwy96thSlmhjkjfO7Am4=
X-Gm-Message-State: AOJu0YxOUtLSymAi4WPf58/2dlykv7rjZDGJecOcsUbtP6DFJVi58uj3
	PCVEp/stfE9ToicJ2zcSCNbuP2tsdkB14e95S5IA+piXxkM93v0QZE10L9Fene+VDj/MkEw333q
	TnPmnkNyVJc9ORkag1If96SQb5Xc=
X-Google-Smtp-Source: AGHT+IEQ3hVGE92TGKT4B04slYnWVGrK3nnjU+kRC8lDhLD9YRUEmgm7Gj1sBkLvrK/h6jh3Ut4TpCkZptegcRGNtjc=
X-Received: by 2002:a05:6808:2010:b0:3c3:e679:cfbf with SMTP id
 q16-20020a056808201000b003c3e679cfbfmr2936986oiw.21.1712570603048; Mon, 08
 Apr 2024 03:03:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404071350.4242-1-linux.amoon@gmail.com> <20240404071350.4242-2-linux.amoon@gmail.com>
 <2024040442-subscript-detective-8d12@gregkh> <CANAwSgTpvrUY_H4Q4TzZWF+z-B=rGM1ny9B-pgSZ3dKCn-mXrA@mail.gmail.com>
 <f52f0634-a12c-46bd-9701-e5caf4326432@linaro.org>
In-Reply-To: <f52f0634-a12c-46bd-9701-e5caf4326432@linaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 8 Apr 2024 15:33:07 +0530
Message-ID: <CANAwSgTM6744thtq4ywFfgtsBjnNEdHqkH9Or9ENm6zjqoUmxw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] usb: ehci-exynos: Use devm_clk_get_enabled() helpers
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Alim Akhtar <alim.akhtar@samsung.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Johan Hovold <johan@kernel.org>, 
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof, Greg.

On Thu, 4 Apr 2024 at 19:24, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 04/04/2024 15:52, Anand Moon wrote:
> > Hi Greg,
> >
> > On Thu, 4 Apr 2024 at 18:30, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >>
> >> On Thu, Apr 04, 2024 at 12:43:17PM +0530, Anand Moon wrote:
> >>> The devm_clk_get_enabled() helpers:
> >>>     - call devm_clk_get()
> >>>     - call clk_prepare_enable() and register what is needed in order to
> >>>      call clk_disable_unprepare() when needed, as a managed resource.
> >>>
> >>> This simplifies the code and avoids the calls to clk_disable_unprepare().
> >>>
> >>> While at it, use dev_err_probe consistently, and use its return value
> >>> to return the error code.
> >>>
> >>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> >>> ---
> >>> V2: drop the clk_disable_unprepare in suspend/resume functions
> >>>     fix the usb_put_hcd return before the devm_clk_get_enabled
> >>> ---
> >>>  drivers/usb/host/ehci-exynos.c | 19 +++++--------------
> >>>  1 file changed, 5 insertions(+), 14 deletions(-)
> >>>
> >>> diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
> >>> index f644b131cc0b..f00bfd0b13dc 100644
> >>> --- a/drivers/usb/host/ehci-exynos.c
> >>> +++ b/drivers/usb/host/ehci-exynos.c
> >>> @@ -159,20 +159,15 @@ static int exynos_ehci_probe(struct platform_device *pdev)
> >>>
> >>>       err = exynos_ehci_get_phy(&pdev->dev, exynos_ehci);
> >>>       if (err)
> >>> -             goto fail_clk;
> >>> -
> >>> -     exynos_ehci->clk = devm_clk_get(&pdev->dev, "usbhost");
> >>> +             goto fail_io;
> >>>
> >>> +     exynos_ehci->clk = devm_clk_get_enabled(&pdev->dev, "usbhost");
> >>>       if (IS_ERR(exynos_ehci->clk)) {
> >>> -             dev_err(&pdev->dev, "Failed to get usbhost clock\n");
> >>> -             err = PTR_ERR(exynos_ehci->clk);
> >>> -             goto fail_clk;
> >>> +             usb_put_hcd(hcd);
> >>> +             return dev_err_probe(&pdev->dev, PTR_ERR(exynos_ehci->clk),
> >>> +                               "Failed to get usbhost clock\n");
> >>
> >> Why is this logic changed?
> >>
> >> If you want to call dev_err_probe(), that's great, but do NOT mix it up
> >> with a commit that does something totally different.
> >>
> >> When you say something like "while at it" in a changelog text, that is a
> >> HUGE hint that it needs to be a separate commit.  Because of that reason
> >> alone, I can't take these, you know better :(
> >>
> >> thanks,
> >>
> >
> > Ok, I will improve the commit message relevant to the code changes.
>
> Please read Greg's message one more time. He did not propose to fix
> commit msg, right?
>

Ok I will drop dev_err_probe and keep the error flow as it is.
It will not break the feature..

Thanks

-Anand


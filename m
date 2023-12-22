Return-Path: <linux-kernel+bounces-10076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469A081CFB8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFF9A286580
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD182F52A;
	Fri, 22 Dec 2023 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DbANNZZU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA122EB0E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 22:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bb732e7d78so1643067b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 14:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703283607; x=1703888407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zh4GNA4Y05yXEeCWYCD5IWiPdQ5iIa0JnfPD6CHsXY4=;
        b=DbANNZZUmbahoLkT6DE4uZ/9Li0YIA08Gvq0G3RaWURNIcOQhNdOXxv7pftmDt8H5I
         QkPdOHmQBjG8Fro4i47JacAb/ztozoXt+nFMc1OvUXQDrMJJb23AXLbO1eXp8Kn0cCmh
         4BpfmwQhcsbPSHR0CHVBs723QdTk1htJeffzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703283607; x=1703888407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zh4GNA4Y05yXEeCWYCD5IWiPdQ5iIa0JnfPD6CHsXY4=;
        b=sjgUOAhBtupBvQ13UgWrez/8RHuZxJ/gSeeLLMxdVg4TS9Eak4kYHZdGMxBrotjeWI
         CLyPb65tD96HawHks1NilaOaqkrYXNzbLaRHmDgClQ3xwgEVXXY1mIzFhhwM6vOed0LS
         1AKKRm5NgbE+J1t3LExU9UDoSE2B403zcFOvec/7Z6C1SUlZcXnNJJv94xaPpu0l860W
         0fNuIm8p1i5pJIc70cuds1xfJ2UFO+s160WleqIgoMn/RUTAxCsqHcay5XBctB6/SYa/
         95eyIila/u8gyP8N+UQU7+iotsUNdCxdG1PEzKPtigVatK0U8hbVPP1eQ+KwWyAqGesl
         +AZw==
X-Gm-Message-State: AOJu0YxmOhVFUdy+aB90xcbCstV9Cy1JHsbihDNpiesOCaS6OafjoCoS
	jpV73t7kbTfLIoidC4S2pvMwRor89tFTD/JMP638kit44whr
X-Google-Smtp-Source: AGHT+IH1gfrcqYhXI4r48hl59zh7w2/OMXufec1y3JujW5Fx/vftezklyAWWZx0YfAU1/S92XP07ZkzsKE7TgE5mhqY=
X-Received: by 2002:a05:6808:2014:b0:3b9:e20f:96e7 with SMTP id
 q20-20020a056808201400b003b9e20f96e7mr2217983oiw.28.1703283607328; Fri, 22
 Dec 2023 14:20:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220235459.2965548-1-markhas@chromium.org>
 <20231220165423.v2.22.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid> <ZYP-H27vsJvMTupH@google.com>
In-Reply-To: <ZYP-H27vsJvMTupH@google.com>
From: Mark Hasemeyer <markhas@chromium.org>
Date: Fri, 22 Dec 2023 15:19:56 -0700
Message-ID: <CANg-bXAUiw-v3D6u3dzve3i65b29wqPSAnw3uuZ2mFNsVgY9Hw@mail.gmail.com>
Subject: Re: [PATCH v2 22/22] platform/chrome: cros_ec: Use PM subsystem to
 manage wakeirq
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Raul Rangel <rrangel@chromium.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
	Benson Leung <bleung@chromium.org>, Bhanu Prakash Maiya <bhanumaiya@chromium.org>, 
	Chen-Yu Tsai <wenst@chromium.org>, Guenter Roeck <groeck@chromium.org>, Lee Jones <lee@kernel.org>, 
	Prashant Malani <pmalani@chromium.org>, Rob Barnes <robbarnes@google.com>, 
	Stephen Boyd <swboyd@chromium.org>, chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 1:58=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.org> =
wrote:
>
> On Wed, Dec 20, 2023 at 04:54:36PM -0700, Mark Hasemeyer wrote:
> > The IRQ wake logic was added on an interface basis (lpc, spi, uart) as
> > opposed to adding it to cros_ec.c because the i2c subsystem already
> > enables the wakirq (if applicable) on our behalf.
>
> The setting flow are all the same.  I think helper functions in cros_ec.c=
 help
> to deduplicate the code.

I'll see what I can do.

> > +MODULE_DEVICE_TABLE(dmi, untrusted_fw_irq_wake_capable);
>
> Does it really need `MODULE_DEVICE_TABLE`?

Nope. Will drop.

> >       ret =3D cros_ec_register(ec_dev);
> >       if (ret) {
> > -             dev_err(dev, "couldn't register ec_dev (%d)\n", ret);
> > +             dev_err_probe(dev, ret, "couldn't register ec_dev (%d)\n"=
, ret);
>
> The change is irrelevant to the series.

I'll drop the use of dev_err_probe() to stay consistent with current
conventions. Perhaps it can be added in a follow-up patch.

> > @@ -470,6 +512,8 @@ static void cros_ec_lpc_remove(struct platform_devi=
ce *pdev)
> >               acpi_remove_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
> >                                          cros_ec_lpc_acpi_notify);
> >
> > +     dev_pm_clear_wake_irq(dev);
> > +     device_init_wakeup(dev, false);
>
> Is it safe to call them anyway regardless of `irq_wake` in cros_ec_lpc_pr=
obe()?

According to bench tests, it's not a problem. That said, I am
refactoring the code to move the logic into cros_ec.c and will
conditionally call the cleanup functions.

> > +     if (!np)
> > +             return;
> > +
>
> The change is an improvement (or rather say it could change behavior).  B=
ut
> strictly speaking, the change is irrelevant to the series.

Will drop.

>
> > @@ -702,6 +710,11 @@ static void cros_ec_spi_dt_probe(struct cros_ec_sp=
i *ec_spi, struct device *dev)
> >       ret =3D of_property_read_u32(np, "google,cros-ec-spi-msg-delay", =
&val);
> >       if (!ret)
> >               ec_spi->end_of_msg_delay =3D val;
> > +
> > +     if (ec_dev->irq > 0 && of_property_read_bool(np, "wakeup-source")=
) {
>
> Or just use `spi->irq`[2].
>
> [2]: https://elixir.bootlin.com/linux/v6.6/source/drivers/platform/chrome=
/cros_ec_spi.c#L762
>
> They are the same, but does of_property_present() make more sense?

Yes it does. I'll use it.

> > @@ -768,6 +778,9 @@ static int cros_ec_spi_probe(struct spi_device *spi=
)
> >                          sizeof(struct ec_response_get_protocol_info);
> >       ec_dev->dout_size =3D sizeof(struct ec_host_request);
> >
> > +     /* Check for any DT properties */
> > +     cros_ec_spi_dt_probe(ec_spi, spi);
>
> `spi` is possibly not needed.  See comment above.

Agreed.


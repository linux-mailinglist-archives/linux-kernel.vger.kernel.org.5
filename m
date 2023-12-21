Return-Path: <linux-kernel+bounces-8211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC75C81B3B5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3A41C24804
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8416B697A9;
	Thu, 21 Dec 2023 10:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R2cVRFVZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A896978F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5df49931b4eso7458597b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 02:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703154891; x=1703759691; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k1jggwYkG4hQyycQm/RtNvDfA67fuZq9Z5qOm74FzWI=;
        b=R2cVRFVZK8yYhOW2cQy2NMWE6yMdB8Vpaknnm8gwCF9Zzsp8NPIjlsyO730w+Z9uWq
         aLlHOLrLELiJzSm7HyXg6+J+Fwbz6ge/mocVKj8XVdGB9aquYgeDVQv811IKR2Dx7Wht
         pg57sswTJBa51l5hvJ0JwjkXmxUg9kOrmnR3nmia05j2qsIfOHlX6ZYzMyQ46KmP5Mrm
         gU4huELdFVHqMVD8Rk2X3lCGIEWZ4+huDzrDG/vyx880MQQXrffKaa68woz3ocioScli
         C3xrjJ5PiO81X2gYwuWyvpWkfi6cDubS3PHtJH0DhCwnjiV4F7M4DkNMSMSDl5xIlq42
         XrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703154891; x=1703759691;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k1jggwYkG4hQyycQm/RtNvDfA67fuZq9Z5qOm74FzWI=;
        b=uaSJhKxNrVHEf7lfbCN0OJbCmW3oiPKJ1PtlVs18yW/GRpfEk/Nzd2pIzn3VcuWdmb
         GhJ4s0xFQychmPkZ7tkfKdOnu4rCDY228agVkQ/CUubCwNwU4lJJdZjOuvmNRchDIXCU
         gZqQP77sJkhMZtFpfs4v+nKUg2KCrg2bibd0UuaaFLdLq4hDxkV+05ztQblVCm2pdjyU
         NCMvzfvVIQZJ2F5NxSD/M6tC8/bRm0n8u838nWIgKAlfXiEaSEvGnmlLI1PPlwwVTzV2
         e0HE27Fyq6/DwtLLFVWuPxo7SIhLWVHlBQklyMH4Z2H2numWHa7aH/0SwmSySYYzH0Cd
         lRkA==
X-Gm-Message-State: AOJu0Yw7nYJnpuXKxordGgrVl2WhJmu+wOjGy8j6KxdL9NA90Pyd5Gc1
	M1EQ9ZjMS2OoYXgvsAF8kFzLwH3PfKSGGWxJQYLZnw==
X-Google-Smtp-Source: AGHT+IGfnie6/2dvOxBU6HIqheolQzMJV+6Zo4QAQEchMvhcGdYYrIohHNPC1JpbJAdq0YamseBDZvDZglYO6CXJ7tE=
X-Received: by 2002:a0d:c5c3:0:b0:5d7:1940:b384 with SMTP id
 h186-20020a0dc5c3000000b005d71940b384mr1196055ywd.80.1703154891585; Thu, 21
 Dec 2023 02:34:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220-fp5-pmic-glink-v1-0-2a1f8e3c661c@fairphone.com>
 <8d042095-1e09-45cc-9762-909fe8d663a9@linaro.org> <CXTU5MLN0YDS.29PPV8KZF8G9R@fairphone.com>
In-Reply-To: <CXTU5MLN0YDS.29PPV8KZF8G9R@fairphone.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 21 Dec 2023 12:34:40 +0200
Message-ID: <CAA8EJpoD3x=kVLu4x2yLtAqCp=wmGSU4ssq5Oj_SD5VQ=GyAYQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fairphone 5 PMIC-GLINK support (USB-C, charger, fuel gauge)
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, cros-qcom-dts-watchers@chromium.org, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Dec 2023 at 09:33, Luca Weiss <luca.weiss@fairphone.com> wrote:
>
> On Wed Dec 20, 2023 at 1:32 PM CET, Konrad Dybcio wrote:
> > On 20.12.2023 11:02, Luca Weiss wrote:
> > > This series adds all the necessary bits to enable USB-C role switching,
> > > charger and fuel gauge (all via pmic-glink) on Fairphone 5.
> > >
> > > One thing that could be made different is the pmic-glink compatible.
> > > I've chosen to use qcm6490 compatible for it and not sc7280 since
> > > there's plenty of firmware variety on sc7280-based platforms and they
> > > might require different quirks in the future, so limit this PDOS quirk
> > > to just qcm6490 for now.
> > >
> > > If someone thinks it should be qcom,sc7280-pmic-glink, please let me
> > > know :)
> > IMO it's best to continue using the "base soc" (which just so happened
> > to fall onto sc7280 this time around) for all compatibles, unless the
> > derivatives actually had changes
>
> Hi Konrad,
>
> I think at some point I asked Dmitry what he thought and he mentioned
> qcm6490. Even found the message again:
>
> > well, since it is a firmware thing, you might want to emphasise that.
> > So from my POV qcm6490 makes more sense
>
> But yeah since it's likely that sc7280 firmware behaves the same as
> qcm6490 firmware it's probably okay to use sc7280 compatible, worst case
> we change it later :) I'll send a v2 with those changes.

Worst case we end up with sc7280 which has yet another slightly
different UCSI / PMIC GLINK implementation, but the compatible string
is already taken.
I still suppose that this should be a qcm6490-related string.

>
> Regards
> Luca
>
> >
> > as far as firmware goes, I *think* CrOS doesn't even have PMIC_GLINK?
> > There are however WoA 7280 laptops which totally should have it.. Would
> > be nice to hunt some down and see if they report different stuff to
> > what's there on android firmware
> >
> > Konrad
>


-- 
With best wishes
Dmitry


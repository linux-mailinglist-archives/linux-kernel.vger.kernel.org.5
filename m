Return-Path: <linux-kernel+bounces-50301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4101284772C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E481F2575B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EF514D432;
	Fri,  2 Feb 2024 18:14:37 +0000 (UTC)
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AC714C598;
	Fri,  2 Feb 2024 18:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706897676; cv=none; b=Hop9BYt9OYfff5jhN1a6KFRUVqIUA1iqaLJEDgCoYCR6ZNPcjlZpIY1EJg2Xuumw+VP2q2H3fcgH+6ftsOX5dHhiMND7iCFAd6gSYgf5rEQTUvHdoDiBl9avrDtytNKUGNnOo33CKntCxM394I1+i5MI1X4T4Qp+vwq1ERGaIU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706897676; c=relaxed/simple;
	bh=Qlumv/9uD/Ad60fEVW68xuF62Y9Da9rgfUBp5OwRCCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DV7pGpvsOD//eJMNpSVSdMmWRV4PDrq+eJfMQ844VtDlyF2dNWNYVpO4nsBcl6s90cuQokbZ2fuQ5X16zbIJ1naFOMMSGkiBGpHoUiX+J5Hx/D2PwfU9tGscHM3xPwTetAdEpKupPDXKHzl5Cp7SfxscJk+6HKW0Y/hUi1DJCss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5958d3f2d8aso876477eaf.1;
        Fri, 02 Feb 2024 10:14:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706897674; x=1707502474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qlumv/9uD/Ad60fEVW68xuF62Y9Da9rgfUBp5OwRCCw=;
        b=O6dJZ/KGtRkSTsfLgt861J+PojzBVICg0zBK/Dg9mMwjpmP8CKEua7OMIe8Qt2LgCd
         TMCbJaEdr1OtX2txID5oc7DQnpCpjB9EpkNyDiI+OvModm8B/BPMT35k/urEXwIvLCKK
         XEWGHVApZEIxxHXAT3bB2oDA+NpTChDHjd3hfRSf6W16ueeKn1WR8Z2WZ7BS86MoXroZ
         yCHfpcMzOVnjXnXxwLIo7bQvSZLd13fUtVNLIoDnTtbJVhSzOPsBXrd4VYk+AzxG7X3b
         8vvX7r6wEY+FmgZWq14aBMMg9vBJfqcSU457cSk4F4FpwPbX1WC/G0uKtxFDrJKM/1Pl
         b5EA==
X-Gm-Message-State: AOJu0YzNoV1S8K/GlG7LA9fDDaLEQP8nBuYNmeJTZJz19ZpnswJkVbrr
	bp9xP9zqzKB730sEkRlIiUhdk1giBiN+RBTjvAWVPARrG726LpjzvW+4prof//SscUX1hLf1A/l
	YGhIFR2CDxqM0SaGAQwFhjN5CsI8=
X-Google-Smtp-Source: AGHT+IHkzDffLcCIGTcPZaT/tdccQ9v137kmLpYKisYhgO4aPBXrk6f08Eb0XAxWYhTSMChaUCRRRAxv8+tjnudWx9Y=
X-Received: by 2002:a05:6870:c087:b0:219:2a72:1c66 with SMTP id
 c7-20020a056870c08700b002192a721c66mr1744914oad.4.1706897674303; Fri, 02 Feb
 2024 10:14:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130111250.185718-1-angelogioacchino.delregno@collabora.com>
 <20240130111250.185718-2-angelogioacchino.delregno@collabora.com>
 <CAJZ5v0hOcS0Fm2-mKWtc1-0ym33XuH=B39GGL9b6MfGSqeERkQ@mail.gmail.com> <6f8021d5-50af-40c5-983e-cd203b1b3683@collabora.com>
In-Reply-To: <6f8021d5-50af-40c5-983e-cd203b1b3683@collabora.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Feb 2024 19:14:23 +0100
Message-ID: <CAJZ5v0icS+JC9oZLYwYu=TUuNFDc+MMDYjijZe9LhT+2VHpXNQ@mail.gmail.com>
Subject: Re: [PATCH v1 01/18] thermal: core: Change governor name to const
 char pointer
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, daniel.lezcano@linaro.org, miquel.raynal@bootlin.com, 
	rui.zhang@intel.com, lukasz.luba@arm.com, support.opensource@diasemi.com, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-imx@nxp.com, andersson@kernel.org, 
	konrad.dybcio@linaro.org, amitk@kernel.org, thara.gopinath@gmail.com, 
	niklas.soderlund@ragnatech.se, srinivas.pandruvada@linux.intel.com, 
	baolin.wang@linux.alibaba.com, u.kleine-koenig@pengutronix.de, 
	hayashi.kunihiko@socionext.com, d-gole@ti.com, linus.walleij@linaro.org, 
	DLG-Adam.Ward.opensource@dm.renesas.com, error27@gmail.com, heiko@sntech.de, 
	hdegoede@redhat.com, jernej.skrabec@gmail.com, f.fainelli@gmail.com, 
	bchihi@baylibre.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 11:01=E2=80=AFAM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 01/02/24 19:37, Rafael J. Wysocki ha scritto:
> > On Tue, Jan 30, 2024 at 12:13=E2=80=AFPM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> All users are already assigning a const char * to the `governor_name`
> >> member of struct thermal_zone_params and to the `name` member of
> >> struct thermal_governor.
> >> Even if users are technically wrong, it just makes more sense to chang=
e
> >> this member to be a const char pointer instead of doing the other way
> >> around.
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@c=
ollabora.com>
> >
> > Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> >
> > or I can pick it up right away if you want me to do that.
> >
>
> I appreciate having less patches to carry over with new series versions.
>
> Whatever you can take, please feel free to pick directly :-)

OK, applied (as 6.9 material).

Thanks!


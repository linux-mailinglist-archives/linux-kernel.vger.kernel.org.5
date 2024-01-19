Return-Path: <linux-kernel+bounces-31535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9575B832F9F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94BF1C24221
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEE656762;
	Fri, 19 Jan 2024 20:12:11 +0000 (UTC)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEE056744;
	Fri, 19 Jan 2024 20:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705695131; cv=none; b=ZWYLpjYIlhvjnd0r+rVeol/iM/4uxgv3DDwtCmRTHHlmMl+M4/BlR7szot+7iTcB+IPPZRaOuD8vvUp7XGkQMJhlh7R+dI+OMiUhxRdxDnlfLcQA3UGPUkvl5MeMyaIIJQb8CExGioSv1pQh8Ke/fcxpoU79PTUeTiCD9qczlmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705695131; c=relaxed/simple;
	bh=oj82RE+xwL+tTQ5FoXo/tiqNu+qcGaI88wirRkvvO5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOGbGh+Xu2PNGOmIh2yu3lUDozgtDJc8755ZUN6L8YbiSSNWKs8XusyPPt8ahX1U45TkHteMHZ5PhbF6ZIGy+1N9LGPeiUwyUnfO4Jyq3xgiresDfRZYk+Jxum4zYKdjCsjQRNeGsOdEnX1ugWPATkfxAQVCAwYLE67wTmHRN24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-59910dcc17bso243575eaf.1;
        Fri, 19 Jan 2024 12:12:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705695129; x=1706299929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oj82RE+xwL+tTQ5FoXo/tiqNu+qcGaI88wirRkvvO5Q=;
        b=VJ0lTpKdBjCRw8KF2wUxyU2hWU6M7mLxrGZSm8UIOTE8OAQUU/CKqzBsgOb2r+ToSx
         qtsGFwK0hpzLIXUrTq3yRIOjkGRV+tB0k96eKmJ5/SWP4oh+Xra6/wZO8p8FvoewGWHP
         vM0EXZiLukhKEzuuz2+/y/zxHXzkvFN6XPWHAcvDpxhEv0yRfdS+1m/nydOZwjNXWc3D
         6C9aQIy/1mKFi4h0DbcAOWssBW2D6fJch24SfmgnpFzABXLAyx1BG1Hl5vSB+ZyK0Q4H
         djCRRpjWEoA9jLHot6n32ztyeT3d8RZeVky5fo+6toEGTL5idyS14A1D6h1Y5IclxP2p
         /CdQ==
X-Gm-Message-State: AOJu0YzVcaF9teVBWNZ9SGWnkpwqGoQmvkZf1YiNEk6424qhJd2iXvjc
	zpPT6ltZNxyFohAAi5rLS1UKxGCO24ZOlbetdiNe5/hkwcQAZEEvPl++wzIXUVKloPOfwRWRCB+
	95giFrlySp8LgXT4730GM+V62tMU=
X-Google-Smtp-Source: AGHT+IGzZs9+C7fIVtmHrDvcPWAPxtnlXKeZgAKEGk5NVm8P0YeGZ+JfQsFvjoABPc7SArEcVGUFquzrPd+SJhpMrao=
X-Received: by 2002:a4a:a6c4:0:b0:599:283c:fc53 with SMTP id
 i4-20020a4aa6c4000000b00599283cfc53mr569803oom.0.1705695129080; Fri, 19 Jan
 2024 12:12:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119132521.3609945-1-o.rempel@pengutronix.de>
 <20240119132521.3609945-8-o.rempel@pengutronix.de> <CAJZ5v0gfOaCvsxX5QFzgcTeEZgWGZvqJ3C9d8_Pu6pSp=78m9Q@mail.gmail.com>
 <20240119193441.GB163482@pengutronix.de>
In-Reply-To: <20240119193441.GB163482@pengutronix.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 19 Jan 2024 21:11:57 +0100
Message-ID: <CAJZ5v0jvJa-TaB_ifNdDCDMLozAuX=e7ddgUcU1tx_3Rzp3rcA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 7/7] thermal: core: set Power State Change Reason
 before hw_protection_shutdown()
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, devicetree@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>, 
	Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	kernel@pengutronix.de, linux-pm@vger.kernel.org, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 8:34=E2=80=AFPM Oleksij Rempel <o.rempel@pengutroni=
x.de> wrote:
>
> On Fri, Jan 19, 2024 at 07:34:26PM +0100, Rafael J. Wysocki wrote:
> > On Fri, Jan 19, 2024 at 2:25=E2=80=AFPM Oleksij Rempel <o.rempel@pengut=
ronix.de> wrote:
> > >
> > > Store the state change reason to some black box for later investigati=
on.
> >
> > Seriously?
> >
> > What black box, where, how this is useful and who is going to use it,
> > pretty please.
>
> The 'black box' refers to a non-volatile memory (NVMEM) cell used by the
> Power State Change Reasons (PSCR) framework. This cell stores reasons
> for sudden power state changes, like voltage drops or over-temperature
> events. This data is invaluable for post-mortem analysis to understand
> system failures or abrupt shutdowns. It's particularly useful for
> systems where PMICs or watchdogs cannot record such events. The data can
> inform recovery routines in the bootloader or early kernel stages during
> subsequent boots, enhancing system reliability and aiding in debugging
> and diagnostics.

OK, so please add all of the above to the patch changelog.


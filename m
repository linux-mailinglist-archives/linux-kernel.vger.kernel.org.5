Return-Path: <linux-kernel+bounces-107882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 780F68802EF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 196B8B2531C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B7220335;
	Tue, 19 Mar 2024 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mbbe0BL/"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05761774A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867732; cv=none; b=IV+tIXXGQydp6PJ5f8aLY9ptGHjP++XVsqRCofBLZVro7tEMacGmxtMATfxuVSrNaNXkBkGqZfZVA9XfKMdVbTWx+AB5uzfMu1JWBa3xz5ziBFPM2ccuDnmBay3b1sQ4Ge4I/Zii1W9TfkYbgh5p3AUhSr3fx3Ko9dV73tC0/X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867732; c=relaxed/simple;
	bh=Q5lgL/UYUi0wBc5ljNWF/sNTHnsGWvNZaNSG+iCsiG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxnTsUfAye4fy0NeQaxRVsKxTLF08d+Ci4HA63Nwm9T35sgvgsGWSKVxcmWGxcKcLCMNauhlT6L2oflX6+cfZGMrcPkSmmEfDRtzFn0DnwB1WmXXi3PUxYO9om77zlxeZZHdwokzOrsTBEHTD4aT3A0AZVwYbZafRdTlN0RByDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mbbe0BL/; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso5611406276.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710867730; x=1711472530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSJayiOdnOskGqQNRA5Szr6q3i+a3h1/Mm928Gh7jmc=;
        b=mbbe0BL/+Zu7RgS85t25vJp/cl2gd8/Cd7oVK6wSSePI6BEGSQZm3CpKGzfbZUOGa+
         Z/a9TTqeMP0qHaWL/fA5ZqAv08KzRYCkqutl0zQ5n4nthBJsgh7WCWVPSSTdC4BbJQJX
         ollUsi00VsSuPuhyDIw86vBbC/n8AwfO4yBhz1S/cpyZNFMhjQGULr24HHTK9E1Yyzs6
         ebyoIrVjsriIhRwTuW9k/csgvssLiDtSXiWzbEmo8uu+1p/laJSjr9HuQgP9bFKWbRqA
         lZFIYQHgMN/LZcblY5/KmUURJcGPPcCrOZmoE/RqnKftl9pXzcaF0RBZ5woiF5qJ/Va4
         p5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710867730; x=1711472530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fSJayiOdnOskGqQNRA5Szr6q3i+a3h1/Mm928Gh7jmc=;
        b=fLP8E2L+S5Cn0ymp7AK+j53x3b9mx2RmD9cjj4wxP1qIIgqXVh6ZL+NsxumTnQPJ6p
         CpdVH/fDRQ7zZwqziqAhI2Cv/Oz9L3bvDTNO/eL7lUOOo6r0AfhSNHX/IfSHJx/z8UAK
         L7N2iYoApeL6voFSf+gsaNDjlCH4/PHtz3QRUiND51UcZmLT9o+aeAQy2JLEAZzs/2qe
         n16SdRez9GhL9pWL2qDO6GteDHJDgjHOajNeYaKykIYREOwMIFR6/Yt25EIspCuZlx6C
         qDNsL3eRmXljbqDDcQhcbkmZdgnnlSiDBei83JfvTA87X6ymhSfLeYypc11qyJzwQSRR
         4/+g==
X-Forwarded-Encrypted: i=1; AJvYcCWGJiKJP+fWd4jwJts9ZmZhGyECDlvLuMJHMDEf4Q5+PyUMJMOmGi2UJs5TOstsFXlNcNbhthsKALH2irOLl97cu5LYJGGigpM5XzyY
X-Gm-Message-State: AOJu0YwQwBU0uegilchAzFgGLnewHktFKOzvBtRshEpFMgWg2JCWNr28
	K4Z2ZkQa/tAEEBi2q7WES04VBnenMjZLL2jLFbfT2gid8YJb5WTp4hn58pGFySQzcQcE3ecLZ8c
	0Xpr5tTl4IFr5blfNSLott2wK18a+20VRSOXY9A==
X-Google-Smtp-Source: AGHT+IG80CC2WBTporSlwkYDb/CO384o+uaEGdCM3vQNY6pEDnUAqPCq1EIEYUMt/sysyvog9AyZoNTpqnUl6MsDJuE=
X-Received: by 2002:a25:8503:0:b0:dcf:47bb:59f8 with SMTP id
 w3-20020a258503000000b00dcf47bb59f8mr2412752ybk.28.1710867729606; Tue, 19 Mar
 2024 10:02:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319152926.1288-1-johan+linaro@kernel.org>
 <20240319152926.1288-3-johan+linaro@kernel.org> <CAD=FV=VUFodCAXEJgfpSqZZdtQaw5-8n_-sX_2p6LuQ2ixLRpQ@mail.gmail.com>
 <Zfm8nifvqb3xO5HG@hovoldconsulting.com>
In-Reply-To: <Zfm8nifvqb3xO5HG@hovoldconsulting.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 19 Mar 2024 19:01:57 +0200
Message-ID: <CAA8EJprp89VgFMjHv=EynROUs632CfQPbEka0GAcEAy743EMaA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] Bluetooth: add quirk for broken address properties
To: Johan Hovold <johan@kernel.org>
Cc: Doug Anderson <dianders@chromium.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Matthias Kaehlcke <mka@chromium.org>, 
	Rocky Liao <quic_rjliao@quicinc.com>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Mar 2024 at 18:26, Johan Hovold <johan@kernel.org> wrote:
>
> On Tue, Mar 19, 2024 at 09:10:23AM -0700, Doug Anderson wrote:
> > On Tue, Mar 19, 2024 at 8:29=E2=80=AFAM Johan Hovold <johan+linaro@kern=
el.org> wrote:
>
> > > +       /* When this quirk is set, the Bluetooth Device Address provi=
ded by
> > > +        * the 'local-bd-address' fwnode property is incorrectly spec=
ified in
> > > +        * big-endian order.
> > > +        *
> > > +        * This quirk can be set before hci_register_dev is called or
> > > +        * during the hdev->setup vendor callback.
> > > +        */
> > > +       HCI_QUIRK_BDADDR_PROPERTY_BROKEN,
> >
> > Like with the binding, I feel like
> > "HCI_QUIRK_BDADDR_PROPERTY_BACKWARDS" or
> > "HCI_QUIRK_BDADDR_PROPERTY_SWAPPED" would be more documenting but I
> > don't feel strongly.
>
> So, same reasoning here, this it not some quirk that people should go
> around setting without first considering to fix their boot firmware.

The address can be considered broken in many different ways. The name
should still be descriptive enough. If you want to specify that it is
a broken behaviour, please consider something like BROKEN_BE.



--=20
With best wishes
Dmitry


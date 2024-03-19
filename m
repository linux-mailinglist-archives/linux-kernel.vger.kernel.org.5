Return-Path: <linux-kernel+bounces-107885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880E6880301
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FFAEB238BB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B1022323;
	Tue, 19 Mar 2024 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkvGCOay"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9031F19479;
	Tue, 19 Mar 2024 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867876; cv=none; b=u1SQiKe1pkg6b2HlbYKVpkpqHa+SUUMdKJdjLgkHINvNGhbsyIc0UAjvse5HihZS0vz4cGUPCXBGRwvIrnMOkhj5FhQ2PSx7Cd5tUNd/zPlHlIcHfU+MFe3jyvBJddDa64dNPhbbbzZvr4qshCpnCjmwM8c8UtR6RA4JuLZlEHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867876; c=relaxed/simple;
	bh=usIsYgIB0u62bf/li3eb1mq6pfYpxdSdelwSwtp6FQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmIHfdSF9lxFBIe/pp2lKJ4LHccTJys2ILMWax4ouj9VHWS5yGNHBOE/hqtK32dpV5SXbIPOjmWzErMf7iG7fX8tnSwb3L6JXrAAqe179qCdnST/4YeBmhQ96ZISpeVC85zj1yZgsTEx8dWz94TtsD+NL3tIT3LGGpwAEyQyJxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkvGCOay; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d68651e253so10844581fa.0;
        Tue, 19 Mar 2024 10:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710867873; x=1711472673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVU1n+8/34SlYxPAq6Hsxd0vjvErqKHwoC6NDWWzfsI=;
        b=IkvGCOay6PMdFUfYjHpDFrRDp6ByHCl81crAB5xMke95UIpx1B3GAICj6kZy9FYU9Y
         q4bSIZyoyPNOHC2xi/ozuwHclDtlazwuZesdzT2h3wKNmJd7QoPZXJ9urBk0mSysd2sM
         WGKPxvjCaL/DQAbpDwPeKZz797s4oP5dpaTnl01U1IuXsu3cvffsWDvgTtCWTD3vetcJ
         egSi4HDJ2VZ0guTq1T5ssxjkIsmqpTud/80cuiEgMjTpk+faAbPruFcgsKsYkl9iCuTO
         4uzBh6iTUeZAwyokTqF3bKz9A4AhO33zlBWo73aisFqfrFIJ4dpqlL2TJ2ZtazxWRKZ2
         7Uqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710867873; x=1711472673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVU1n+8/34SlYxPAq6Hsxd0vjvErqKHwoC6NDWWzfsI=;
        b=satYSuhRftuTcUXLj+FJR0whVg8s6z3CuWQfpJJfZ6gXsbAxJHzxaqFkBa4Nvm9h56
         1PasHGbvoKSugp9AmxInT7I7orBcIB3Z567/zO9VoPW0tDEeBCMknFh6DCcaKrFPXFU3
         GAll0H5q8H9KvAzhq4D199S/6uxgPwMpSio//HWO/hm7Lo+nedJPjDwnQQTxvgtULqUT
         bpa6TGJ9wu8UULGonZgS4RJRTYm5el9edJk5H718AuOyjmSP63jsvp9IKF1xXdEFXID4
         sAaaW/q55BxF77c1+1oy4dByNYlDJeGO1M3F10ntXpbw8beJ4u4vPPP/Ge1yucWSc3pi
         aX5A==
X-Forwarded-Encrypted: i=1; AJvYcCV1p30mF7wmHcspCF+u/W0IwOEHeCM0E14vXUMph3HbJyCTPCR2PybNP6A6bSaLQBdb4I/jNuloILyaG2FC+dQn0TNBA7e69Te7mh33SR2k6iobwdi2gQXLSoVt17za8emrf1bwk3F1u5QkW/pNheGRHdKxoXJ4uphtl21N2nIIa2eUAjVMRXIz9zHwabn/gSF/6oZTUafN2Ke1GkD/rhE54c1z3Mu5tN6VR13whsg0k/PApBzFV6Q2mlWOX73BBzfPW2ucLTQ4Ny2mkW7yC1WOdVecXKrkO2Q=
X-Gm-Message-State: AOJu0Yx7+MyyjGNJIiMRgvswqquULSVIvxIQ9xgqbagamngu9L3AQlD3
	wW3/Hi0A9tU5EIyIXliRiEloPW3ww1/YNFNwn9OY9vifN6tkBsnyd/rCBrut8AEGVUFuB6lu8Rs
	1dFM/DCC6gmVSkB6w7cvV659uQepsKcb71Df8tLRD
X-Google-Smtp-Source: AGHT+IFcvqkGzHZJKFO78b1jwlV6Dv9MozcKlvuAEmYaP3sEG2nkhFwwxiY2HUqD2MPIyKWZvIasLf0i26cOkdvZaWA=
X-Received: by 2002:a2e:7a02:0:b0:2d4:7218:4cf1 with SMTP id
 v2-20020a2e7a02000000b002d472184cf1mr8168352ljc.7.1710867872545; Tue, 19 Mar
 2024 10:04:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319152926.1288-1-johan+linaro@kernel.org>
 <20240319152926.1288-3-johan+linaro@kernel.org> <CAD=FV=VUFodCAXEJgfpSqZZdtQaw5-8n_-sX_2p6LuQ2ixLRpQ@mail.gmail.com>
 <Zfm8nifvqb3xO5HG@hovoldconsulting.com> <CABBYNZLCm2w=oBZUFON+AW2rHo8zPMVGosZr3SAVXbs77XPgUQ@mail.gmail.com>
In-Reply-To: <CABBYNZLCm2w=oBZUFON+AW2rHo8zPMVGosZr3SAVXbs77XPgUQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 19 Mar 2024 17:04:19 +0000
Message-ID: <CABBYNZLUwCisMyHWEJpRJxp6LUeTPOFM_VPsAyb6UJ2r5iT6kg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] Bluetooth: add quirk for broken address properties
To: Johan Hovold <johan@kernel.org>
Cc: Doug Anderson <dianders@chromium.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Bjorn Andersson <andersson@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Matthias Kaehlcke <mka@chromium.org>, 
	Rocky Liao <quic_rjliao@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 5:02=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
>  Hi,
>
> On Tue, Mar 19, 2024 at 4:26=E2=80=AFPM Johan Hovold <johan@kernel.org> w=
rote:
> >
> > On Tue, Mar 19, 2024 at 09:10:23AM -0700, Doug Anderson wrote:
> > > On Tue, Mar 19, 2024 at 8:29=E2=80=AFAM Johan Hovold <johan+linaro@ke=
rnel.org> wrote:
> >
> > > > +       /* When this quirk is set, the Bluetooth Device Address pro=
vided by
> > > > +        * the 'local-bd-address' fwnode property is incorrectly sp=
ecified in
> > > > +        * big-endian order.
> > > > +        *
> > > > +        * This quirk can be set before hci_register_dev is called =
or
> > > > +        * during the hdev->setup vendor callback.
> > > > +        */
> > > > +       HCI_QUIRK_BDADDR_PROPERTY_BROKEN,
> > >
> > > Like with the binding, I feel like
> > > "HCI_QUIRK_BDADDR_PROPERTY_BACKWARDS" or
> > > "HCI_QUIRK_BDADDR_PROPERTY_SWAPPED" would be more documenting but I
> > > don't feel strongly.
> >
> > So, same reasoning here, this it not some quirk that people should go
> > around setting without first considering to fix their boot firmware.
>
> Or we just change its meaning to say what byteorder is the BDADDR e.g:
> HCI_QUIRK_BDADDR_PROPERTY_BYTEORDER=3Dbe

Ah just ignore, it is a flag not really a property that can assume
different values.

> > Johan
>
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz


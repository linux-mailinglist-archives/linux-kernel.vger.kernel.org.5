Return-Path: <linux-kernel+bounces-107883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 160698802F8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5731F25063
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7F52033E;
	Tue, 19 Mar 2024 17:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbXbCNAF"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50181097B;
	Tue, 19 Mar 2024 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710867778; cv=none; b=YKpZTylpmfAv+UqsU9+9vdPvPq8PesvpSZHHRmo3Ppei4iFYIltRYlTi4WmNI8DtG342T9CmRFkR6iNzxIlynHMhCogWTnbdTCrWirKeMRfB3TamR7Es9/dhnnuB8a7NxFTFQGCUiKsLly2c3iYfsMt6oe9K00DNqi2qvMgcTho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710867778; c=relaxed/simple;
	bh=QLj4SBziSYByNfn+PkyMFIwzh3/oLmaSdq6Fx2MFGvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHueg41OvQI7eCJq4Bo5FO2gpx51e/kdW1tfYJOjrXILmL1lQF44vvoDnfPPRzVspLguWHWKv+qK3HAaJmS6rm8Uelsy2wfDCTGG31RH3eZellQrApLRKR7jZMIeWqaaUgaDSyt90WjG1CKkD/Fa6+4iGVYO70B+m6O51b8m5Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbXbCNAF; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d4a8bddc21so33233071fa.0;
        Tue, 19 Mar 2024 10:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710867775; x=1711472575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvnTFyrLCKf1xltd5FyTxVjgf+ydvsYO9RUlNuwgGNc=;
        b=dbXbCNAFoA81TU1QP5B02NWcTe33ppf4XfkIW4BVN+3x35zDVbp+SYccWNVe4kyIwK
         qJEMPDvQzi0sMirWBQKZViWt5SmbR1ClOKFNypK5YUUe3zSwOBq9Vnp5lbfsdfFNwbBC
         PVic0b6ktRDwfLAXHuf2gVz7lurc5rqtqY6yF9VdWwsJM/e98UKxewLf0F/D7qVA3YfB
         NV1EMlReXajPCY8x26ZrfNb6Bn40e3W1M9uUdDEoKqvNjHjeiKTqAPZ/xq7BWUUG+Hfc
         vqc/b5zKWaSAcOgoL6HOkU+jf+lEaYQ0rznhedS/pdahTaEDLQTddYAGV2t54vno9QuA
         GSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710867775; x=1711472575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvnTFyrLCKf1xltd5FyTxVjgf+ydvsYO9RUlNuwgGNc=;
        b=xN3TJe8WJw5mZnxo4dy4WhvvThxHH30zLbxOFo2Xl7OEkczD3XtdMVkFWJDLt/pPof
         uBxzFw+6MJn2xbiIymQ7sHHALcVp8xkvRFXLAs++qYPgT/hzvGaif0EpaHMalfUFUxR6
         JMS/ILTNnGmT0tY5a6YY+8NkxmUKgbgNJ1d7l93TGTR4rxaukIlOt7vI2kYVlxSiSFX3
         MobIG4+cA5w9ssc+Pz6L1gGNNzkPn8WCY4yhRn9dvs4upC3JgXF32LUk4exkjrlwybto
         ghmANxaJogvQgVH1Jo/uueSZ69BmZm+qn4qOQRjPlKvKtpm6X6pw3Lef2pgkdkfJqd48
         n+sg==
X-Forwarded-Encrypted: i=1; AJvYcCUvTdI1KneeB1AzNUbd1QlWfqMgl0TgsNsHXowkKela0ZjSSs5HM8XQ4gEBQvHMmXz4inOoNWRVEQdr7je9A0Pm5zwvD7tHWFgA3EV6Rz2UDNy6cM7tdcWVx009ZO3+6edRInR74pZbd+CXtIKxe2830NPdMSHnZmu4CewtyAHqcmnPdp4QdRYVg4ACbgPAkfk3SQVW/B06vNgbXea93BI57Aev5NgSgZKBpPAN6vYix01npFmH6JxsguuFWc9nNKTyWl5/12sI5U+mEu5punFNfJ2SAc/CPrw=
X-Gm-Message-State: AOJu0YxjAKVx8d9P+iZ8XUp8ypQU2SMEY65N+zys3CUUtvq/OomRN2Ub
	98EBX61q4sGqxCtNpGLk3/6dWOhauAb9YBdbthMn0JaC1v2sbZ1wHKa55F0r5j2mKQSRjkuhDqq
	GpksTBbyyMxU+Vl76jpp7D5KyvEK/5AU0POd5VbeG
X-Google-Smtp-Source: AGHT+IHu8Ej1RfFnLRLx3VFYlsyKjxzDRYeik3lLZdY+MA4TepHpLzJmBwJvzbebQlseQBGhVzDyYxktI0tQMU+ogsc=
X-Received: by 2002:a2e:a9a7:0:b0:2d4:1700:34a2 with SMTP id
 x39-20020a2ea9a7000000b002d4170034a2mr13234874ljq.33.1710867774534; Tue, 19
 Mar 2024 10:02:54 -0700 (PDT)
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
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 19 Mar 2024 17:02:41 +0000
Message-ID: <CABBYNZLCm2w=oBZUFON+AW2rHo8zPMVGosZr3SAVXbs77XPgUQ@mail.gmail.com>
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

 Hi,

On Tue, Mar 19, 2024 at 4:26=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
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

Or we just change its meaning to say what byteorder is the BDADDR e.g:
HCI_QUIRK_BDADDR_PROPERTY_BYTEORDER=3Dbe

> Johan



--=20
Luiz Augusto von Dentz


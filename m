Return-Path: <linux-kernel+bounces-73358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5AD85C16D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 320451F242AD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A856D76411;
	Tue, 20 Feb 2024 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Frt2OeGC"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02962E84E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446633; cv=none; b=O+5JUOWHJTDGVv73L8QxmpMAHCOrvRZUblmJb8CaOKXoaAOyl9jPZ2/e42taFuZY6VBcipuU1GPwMKCpLJ5YtCZ58S7wIccpH6xMgRM8TG8HMZ1+mkmYpKf2CqFO2encHjCEmTrQeEPp4a2sYyIZuUAUggmmhQh5ZnbiVotZofg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446633; c=relaxed/simple;
	bh=1fXyq6cAuoEnamSFWTgvyvNEMlThUpp3Kff1Mcr9tDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXHJ0YDQg8kOoBkdE3SpEbzR3BKkh5WGfMnNX9S4CmdCJpzKw6t+hjEd/gEPSWQPxiw18DrNCvbJ0ani1lrjV4d60P/kYhyaVzow/jdewuZdggt70M2okeJdjRugXbreeMQOkbtLY6o0xMMdrGnUk14ITvISfgx70g7sN/JMqOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Frt2OeGC; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6080beb19ddso32997757b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708446631; x=1709051431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+xYMPVEaZiTF2DZys9U3HRcGSv7XVsfb8mgJa/NGLI=;
        b=Frt2OeGCPYMZZuQPQyFE68yD+YIxzvZdQ3pZBp5iJav5PPOREnbCJnQulZlmFllt0h
         ACi9chRg+BWeOXJI7DV+N39NWDsBjk76obVbGx0iaP66LVx/+9l4fPfRSJxbU/l4sPWM
         8ZwqDmO81618wM6IHemuEuV6QaEyxlypN7FtS2Y0kdDYcboXIq6AXRFeEjUVOk+XSbML
         7izskhU1GJrAVbQJgqgEIIP5wAO0Zh4qIhydzdK0kLBx83/K8OLcCJ0SPcxbfWy/SuUI
         aHYIvwMPKuRKjlO5c8FRezwk9ckNDr/2AD1Vk7BLdIU/fPQcs+6lfYH54M2nEMSvox2G
         LkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708446631; x=1709051431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+xYMPVEaZiTF2DZys9U3HRcGSv7XVsfb8mgJa/NGLI=;
        b=n3u62fs3d8SiYqy7fAaTG/idVABzVLtQwPH0zowQxorWE17pggfGxscVEa80C+iq/U
         oxz98Y7GESyM9Lpmq1I9ZL15iV41rSDAVSgdTIZ/wOpLRPlQjktqVZ68Mm7WlIC491W5
         EOxzMRMseJuI+CFO8b5SD7IeqB+J+CFEXUizLg4BLIXmYLU5IwvYyACRbk8JeZh7B81a
         7owi0hCAhLoTmRRpvH0RkTWqRCAojj4zVMA9lOMJ2hjIxH8/9ejfosFQ6Q+BNEiCob6h
         zLLUgZogD+WaLbAXFPkuZXT+z7jBa0H2nh1zJGm8nRUaRc7kKVaAMM3dTZVkhhITwkkv
         1kfA==
X-Forwarded-Encrypted: i=1; AJvYcCWCFP0G2nMZnncVEqsJ2eYZx6m5nnpVWHGnPIQTSGKyYID9aOex8EpGe0x+fn8aQvH3q06AQqz1Sy5wozn26yJ/K9SnYHj65ei+g+Ue
X-Gm-Message-State: AOJu0YwG0elOniItsqS9rOeHyp98czU5qjEYUAS4m4hBhp41pHjDcnMI
	PD7c09mF3uZUQMi7zWJ3SazMQRm7gBm8C93Tp5blk/Fyw4juYepqO/D/2T2kRDpnRvMLkLZ6l4e
	IGTUMVV9osP8Qz1P+brOdw74Gf+XfVwFFdlhZZA==
X-Google-Smtp-Source: AGHT+IFDa01ZVzEZiS8s0O26WczezIZBh59zgBpRUtt9QCMKZfbnmrqIUOMg6EBt7uBSs9R0KGrlYwTH8vjmTDt3sAU=
X-Received: by 2002:a81:490e:0:b0:608:ba5:729d with SMTP id
 w14-20020a81490e000000b006080ba5729dmr9159540ywa.19.1708446630739; Tue, 20
 Feb 2024 08:30:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216203215.40870-1-brgl@bgdev.pl> <20240216203215.40870-10-brgl@bgdev.pl>
 <48164f18-34d0-4053-a416-2bb63aaae74b@sirena.org.uk> <CAMRc=Md7ymMTmF1OkydewF5C32jDNy0V+su7pcJPHKto6VLjLg@mail.gmail.com>
 <8e392aed-b5f7-486b-b5c0-5568e13796ec@sirena.org.uk> <CAMRc=MeAXEyV47nDO_WPQqEQxSYFWTrwVPAtLghkfONj56FGVA@mail.gmail.com>
In-Reply-To: <CAMRc=MeAXEyV47nDO_WPQqEQxSYFWTrwVPAtLghkfONj56FGVA@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 20 Feb 2024 18:30:19 +0200
Message-ID: <CAA8EJppzkuH=YTAHuJ3Og2RLHB93PSas004UDvpqepYbGepVPg@mail.gmail.com>
Subject: Re: [PATCH v5 09/18] arm64: dts: qcom: qrb5165-rb5: model the PMU of
 the QCA6391
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Mark Brown <broonie@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Saravana Kannan <saravanak@google.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Feb 2024 at 13:16, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Mon, Feb 19, 2024 at 8:59=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:
> >
> > On Mon, Feb 19, 2024 at 07:48:20PM +0100, Bartosz Golaszewski wrote:
> > > On Mon, Feb 19, 2024 at 7:03=E2=80=AFPM Mark Brown <broonie@kernel.or=
g> wrote:
> > > > On Fri, Feb 16, 2024 at 09:32:06PM +0100, Bartosz Golaszewski wrote=
:
> >
> > > > > +                     vreg_pmu_aon_0p59: ldo1 {
> > > > > +                             regulator-name =3D "vreg_pmu_aon_0p=
59";
> > > > > +                             regulator-min-microvolt =3D <540000=
>;
> > > > > +                             regulator-max-microvolt =3D <840000=
>;
> > > > > +                     };
> >
> > > > That's a *very* wide voltage range for a supply that's got a name e=
nding
>
> Because it's an error, it should have been 640000. Thanks for spotting it=
.

According to the datasheet, VDD08_PMU_AON_O goes up to 0.85V then down
to 0.59V, which is the working voltage.

VDD08_PMU_RFA_CMN is normally at 0.8V, but goes to 0.4V during sleep.

>
> > > > in _0_p59 which sounds a lot like it should be fixed at 0.59V.
> > > > Similarly for a bunch of the other supplies, and I'm not seeing any
> > > > evidence that the consumers do any voltage changes here?  There doe=
sn't
> > > > appear to be any logic here, I'm not convinced these are validated =
or
> > > > safe constraints.
> >
> > > No, the users don't request any regulators (or rather: software
> > > representations thereof) because - as per the cover letter - no
> > > regulators are created by the PMU driver. This is what is physically
> > > on the board - as the schematics and the datasheet define it. I took
> >
> > The above makes no sense.  How can constraints be "what is physically o=
n
> > the board", particularly variable constrants when there isn't even a
> > consumer?  What values are you taking from which documentation?
> >
>
> The operating conditions for PMU outputs. I took them from a
> confidential datasheet. There's a table for input constraints and
> possible output values.
>
> And what do you mean by there not being any consumers? The WLAN and BT
> *are* the consumers.
>
> > The cover letter and binding both claimed (buried after large amounts o=
f
> > changelog) that these PMUs were exposing regulators to consumers and th=
e
> > DTS puports to do exactly that...
> >
>
> Yes, but I'm not sure what the question is.
>
> > > the values from the docs verbatim. In C, we create a power sequencing
> > > provider which doesn't use the regulator framework at all.
> >
> > For something that doesn't use the regulator framework at all what
> > appears to be a provider in patch 16 ("power: pwrseq: add a driver for
> > the QCA6390 PMU module") seems to have a lot of regualtor API calls?
>
> This driver is a power sequencing *provider* but also a regulator
> *consumer*. It gets regulators from the host and exposes a power
> sequencer to *its* consumers (WLAN and BT). On DT it exposes
> regulators (LDO outputs of the PMU) but we don't instantiate them in
> C.
>
> Bart



--=20
With best wishes
Dmitry


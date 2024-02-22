Return-Path: <linux-kernel+bounces-76542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C55085F8A7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87A0DB25CAC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C9012FF8D;
	Thu, 22 Feb 2024 12:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LKLzS/CH"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191C412DD96
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606255; cv=none; b=sEUXjeAxHbrTUVgxqAg5fg0sDGcwmrMda3etSzR20RfqH0JcrUD+qCr4sXZD64MQGVogp97AXKgX/tktu3uQbZMFqi7vHG8XdL9I141CtzaCbSaSuMvg9b2hMAUmnGJnnSVBqZQMFrDUnnrQdrjHkJ7wi9wz5onXdKnx0GLBCLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606255; c=relaxed/simple;
	bh=D/Rv64Y5sXOy1hNvU3YRveE5JBFKjHlveZT/G/uvFqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pm22vzXk/qSZPYCCLMxdHVbE1XQobbxhHZz5eUS4C4NscsTOuXxZYXYdZgWtmMcDc+jfYtrnt6aZgwyNDtcU5Hu6j8rASMqxB1f3YwzfoQRVv+HHId2X5l61LGD3VZF7aQwQAjmKq6nxXHa25cUPmQRl1WQO5OWE/JhylgLyhx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LKLzS/CH; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4703e4d53b6so436454137.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 04:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708606252; x=1709211052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1FTSWWbKgvLwm17WUy3ABhI4j9ElVgmuDBNeAXwxPE=;
        b=LKLzS/CHlY6j3aQfqyPsc5py+kJ8OsywTj+C1GxUa56NtwFEvXEZbAN73hjDfs1u61
         rBd9Lm5HciyVN4GLjzgUzwv2yx8nxETNIrEgbi6MJDDaCFEdgYM4yNFAruQMLhWpbtar
         zcGx76yKl/kZS2u3/qZinz5CsdOtwdvaAWSWpkn+2hfbSxSBLM4jGydIsoU8SOS+6agt
         wBgmDNTBmDDU3Oi6mwWc9zccq4gRgGtrS9+JTkElLL2qudbn3RnC0EdvjUuChsV+k/CJ
         PwLS9dPXcbkz/E6aBRNXbw4fuWFFA8nI/15r2IDMKUrvHRM6vPOabtIr66OoNtNL+5Of
         bjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708606252; x=1709211052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1FTSWWbKgvLwm17WUy3ABhI4j9ElVgmuDBNeAXwxPE=;
        b=tq9PMalpDVsA2ijoY6JOaPjqQGX+HbuiYl1kTfyeX1fhO8z4wuPekFjk0D3Twe5m72
         m56JoYp4p8RykDFbao4YgczOieTyLftaGkJZPP99oXwXhb28GRtCvVozrRhwVS87u9XB
         BPmvZqIJA/cheC96EhIULWp+PYuWi6MlAlOk17SXf6wqDTHTtNGHa0wtME5Z/r0a7qcw
         aQz8WTRsyaM56VNnvmBelpM/FZLA6DROAm0Gnet6n/wRqK8QuBZY4iNNudpp1XFAFtg+
         YiBoHJB03S4h086zeP5ekHNw38/9FCI78KcamFerfZC4QOVW1rNhyE/7bU7dL2cKKIzi
         IkjA==
X-Forwarded-Encrypted: i=1; AJvYcCVjvSREcFtFtgt8bUcjhsVzI158uao1zwqGqSQ6J6/mpKQO4Pdg8iJlavo+va3XcgMET1SCGQXUAcf4N2ECiSzK7Z67b82lpagFzg2Y
X-Gm-Message-State: AOJu0YzcyP7SfDEYKGv5bAYBQZF6/pUtDgKoLJg9ChPvMw699ULad6J3
	HTEmkup6gooZ0qjSIMo5+KAMiHkZG8mKAInIfJ5mqj3Zbr6vA7prUyCnR4GeoytaemrYT4hrKRY
	kHTEGq/ospCAJtU9G18SE4j8g5FEdL+TYTbyw2A==
X-Google-Smtp-Source: AGHT+IE1dv1EwDAd6TX1lQGq6n3XBsSY4vP2JhDCLl+t1UgliKtkx4suismK+MOv4dm7qGwschM/R4BLzbUnH1NzkV8=
X-Received: by 2002:a05:6102:dc8:b0:470:4043:8f21 with SMTP id
 e8-20020a0561020dc800b0047040438f21mr1890402vst.11.1708606252028; Thu, 22 Feb
 2024 04:50:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216203215.40870-1-brgl@bgdev.pl> <CAA8EJppt4-L1RyDeG=1SbbzkTDhLkGcmAbZQeY0S6wGnBbFbvw@mail.gmail.com>
 <e4cddd9f-9d76-43b7-9091-413f923d27f2@linaro.org> <CAA8EJpp6+2w65o2Bfcr44tE_ircMoON6hvGgyWfvFuh3HamoSQ@mail.gmail.com>
 <4d2a6f16-bb48-4d4e-b8fd-7e4b14563ffa@linaro.org> <CAA8EJpq=iyOfYzNATRbpqfBaYSdJV1Ao5t2ewLK+wY+vEaFYAQ@mail.gmail.com>
 <CAMRc=Mfnpusf+mb-CB5S8_p7QwVW6owekC5KcQF0qrR=iOQ=oA@mail.gmail.com>
 <CAA8EJppY7VTrDz3-FMZh2qHoU+JSGUjCVEi5x=OZgNVxQLm3eQ@mail.gmail.com>
 <b9a31374-8ea9-407e-9ec3-008a95e2b18b@linaro.org> <CAA8EJppWY8c-pF75WaMadWtEuaAyCc5A1VLEq=JmB2Ngzk-zyw@mail.gmail.com>
 <CAMRc=Md6SoXukoGb4bW-CSYgjpO4RL+0Uu3tYrZzgSgVtFH6Sw@mail.gmail.com>
 <CAA8EJprUM6=ZqTwWLB8rW8WRDqwncafa-szSsTvPQCOOSXUn_w@mail.gmail.com>
 <CAMRc=Metemd=24t0RJw-O9Z0-cg4mESouOfvMVLs_rJDCwRBPQ@mail.gmail.com> <CAA8EJprJTj7o0ATrQbF_38tW+kLspF1nBySg+_y_RWmadVnV9A@mail.gmail.com>
In-Reply-To: <CAA8EJprJTj7o0ATrQbF_38tW+kLspF1nBySg+_y_RWmadVnV9A@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 22 Feb 2024 13:50:40 +0100
Message-ID: <CAMRc=MfkQuaJ3FnVwbVKQRQEgmJKbZh7SJoK3Kbmb5ebzE2rKA@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] power: sequencing: implement the subsystem and
 add first users
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>
Cc: neil.armstrong@linaro.org, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Saravana Kannan <saravanak@google.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Alex Elder <elder@linaro.org>, 
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

On Thu, Feb 22, 2024 at 1:47=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, 22 Feb 2024 at 14:27, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > On Thu, Feb 22, 2024 at 12:27=E2=80=AFPM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Thu, 22 Feb 2024 at 13:00, Bartosz Golaszewski <brgl@bgdev.pl> wro=
te:
> > > >
> > > > On Mon, Feb 19, 2024 at 11:21=E2=80=AFPM Dmitry Baryshkov
> > > > <dmitry.baryshkov@linaro.org> wrote:
> > > > >
> > > > > On Mon, 19 Feb 2024 at 19:18, <neil.armstrong@linaro.org> wrote:
> > > > > >
> > > > > > On 19/02/2024 13:33, Dmitry Baryshkov wrote:
> > > > > > > On Mon, 19 Feb 2024 at 14:23, Bartosz Golaszewski <brgl@bgdev=
pl> wrote:
> > > > > > >>
> > > > > > >> On Mon, Feb 19, 2024 at 11:26=E2=80=AFAM Dmitry Baryshkov
> > > > > > >> <dmitry.baryshkov@linaro.org> wrote:
> > > > > > >>>
> > > > > > >>
> > > > > > >> [snip]
> > > > > > >>
> > > > > > >>>>>>>>
> > > > > > >>>>>>>> For WCN7850 we hide the existence of the PMU as modeli=
ng it is simply not
> > > > > > >>>>>>>> necessary. The BT and WLAN devices on the device-tree =
are represented as
> > > > > > >>>>>>>> consuming the inputs (relevant to the functionality of=
 each) of the PMU
> > > > > > >>>>>>>> directly.
> > > > > > >>>>>>>
> > > > > > >>>>>>> We are describing the hardware. From the hardware point=
 of view, there
> > > > > > >>>>>>> is a PMU. I think at some point we would really like to=
 describe all
> > > > > > >>>>>>> Qualcomm/Atheros WiFI+BT units using this PMU approach,=
 including the
> > > > > > >>>>>>> older ath10k units present on RB3 (WCN3990) and db820c =
(QCA6174).
> > > > > > >>>>>>
> > > > > > >>>>>> While I agree with older WiFi+BT units, I don't think it=
's needed for
> > > > > > >>>>>> WCN7850 since BT+WiFi are now designed to be fully indep=
endent and PMU is
> > > > > > >>>>>> transparent.
> > > > > > >>>>>
> > > > > > >>>>> I don't see any significant difference between WCN6750/WC=
N6855 and
> > > > > > >>>>> WCN7850 from the PMU / power up point of view. Could you =
please point
> > > > > > >>>>> me to the difference?
> > > > > > >>>>>
> > > > > > >>>>
> > > > > > >>>> The WCN7850 datasheet clearly states there's not contraint=
 on the WLAN_EN
> > > > > > >>>> and BT_EN ordering and the only requirement is to have all=
 input regulators
> > > > > > >>>> up before pulling up WLAN_EN and/or BT_EN.
> > > > > > >>>>
> > > > > > >>>> This makes the PMU transparent and BT and WLAN can be desc=
ribed as independent.
> > > > > > >>>
> > > > > > >>>  From the hardware perspective, there is a PMU. It has seve=
ral LDOs. So
> > > > > > >>> the device tree should have the same style as the previous
> > > > > > >>> generations.
> > > > > > >>>
> > > > > > >>
> > > > > > >> My thinking was this: yes, there is a PMU but describing it =
has no
> > > > > > >> benefit (unlike QCA6x90). If we do describe, then we'll end =
up having
> > > > > > >> to use pwrseq here despite it not being needed because now w=
e won't be
> > > > > > >> able to just get regulators from WLAN/BT drivers directly.
> > > > > > >>
> > > > > > >> So I also vote for keeping it this way. Let's go into the pa=
ckage
> > > > > > >> detail only if it's required.
> > > > > > >
> > > > > > > The WiFi / BT parts are not powered up by the board regulator=
s. They
> > > > > > > are powered up by the PSU. So we are not describing it in the=
 accurate
> > > > > > > way.
> > > > > >
> > > > > > I disagree, the WCN7850 can also be used as a discrete PCIe M.2=
 card, and in
> > > > > > this situation the PCIe part is powered with the M.2 slot and t=
he BT side
> > > > > > is powered separately as we currently do it now.
> > > > >
> > > > > QCA6390 can also be used as a discrete M.2 card.
> > > > >
> > > > > > So yes there's a PMU, but it's not an always visible hardware p=
art, from the
> > > > > > SoC PoV, only the separate PCIe and BT subsystems are visible/c=
ontrollable/powerable.
> > > > >
> > > > > From the hardware point:
> > > > > - There is a PMU
> > > > > - The PMU is connected to the board supplies
> > > > > - Both WiFi and BT parts are connected to the PMU
> > > > > - The BT_EN / WLAN_EN pins are not connected to the PMU
> > > > >
> > > > > So, not representing the PMU in the device tree is a simplificati=
on.
> > > > >
> > > >
> > > > What about the existing WLAN and BT users of similar packages? We
> > > > would have to deprecate a lot of existing bindings. I don't think i=
t's
> > > > worth it.
> > >
> > > We have bindings that are not reflecting the hardware. So yes, we
> > > should gradually update them once the powerseq is merged.
> > >
> > > > The WCN7850 is already described in bindings as consuming what is P=
MUs
> > > > inputs and not its outputs.
> > >
> > > So do WCN6855 and QCA6391 BlueTooth parts.
> > >
> >
> > That is not true for the latter, this series is adding regulators for i=
t.
>
> But the bindings exist already, so you still have to extend it,
> deprecating regulator-less bindings.
>
> Bartosz, I really don't understand what is the issue there. There is a
> PMU. As such it should be represented in the DT and it can be handled
> by the same driver as you are adding for QCA6390.
>

The issue is that we'll pull in the pwrseq subsystem for WCN7850 which
clearly does not require it in practice.

I'd like to hear Krzysztof, Conor or Rob chime in here and make the
decision on how to proceed.

Bart

> >
> > Bart
> >
> > > >
> > > > Bart
> > > >
> > > > > >
> > > > > > Neil
> > > > > >
> > > > > > >
> > > > > > > Moreover, I think we definitely want to move BT driver to use=
 only the
> > > > > > > pwrseq power up method. Doing it in the other way results in =
the code
> > > > > > > duplication and possible issues because of the regulator / pw=
rseq
> > > > > > > taking different code paths.
> > > > >
> > > > > --
> > > > > With best wishes
> > > > > Dmitry
> > >
> > >
> > >
> > > --
> > > With best wishes
> > > Dmitry
>
>
>
> --
> With best wishes
> Dmitry


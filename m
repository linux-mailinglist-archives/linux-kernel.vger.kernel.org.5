Return-Path: <linux-kernel+bounces-23840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1422F82B2A0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 274E61C236FD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FD25026F;
	Thu, 11 Jan 2024 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="B2scXr+O"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8344F8A2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bbd6f87959so4431744b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1704989817; x=1705594617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0L8Io9WOaU9zuxGb3WJPoQE4gX/uTxUJ5wFQjECB/w=;
        b=B2scXr+OKXWnyIR11WNhHl4HnA8sstMVDe5KXjsz/WyqmtmiCB38/AajhI34/s5Zb9
         Crd5F7aju81hDfjiQs+5gnq8UaWJuK/n9TMraE4vEh1Gg5y78E8xiB6l/bzcuaj6Z/Pe
         61NPE+Ye0I1ppuwtjod6jxvhHhni9e0TQ+nS9EYK7hTq3mTgGw0XrUMos3m0A5CEkB4I
         O5wuseypKGTGN3TfA2ZpwDrwE/u3wp/tN/3GKybqgdFvgUbjXUC8OGD1lb2YFc7MaUw9
         FQYj33p0Wbhbc3fD8yR+tymfYdCD7U5vjcov6VvolmJkaMthF5PkY8/G/jv1jGWet1CB
         I4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704989817; x=1705594617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0L8Io9WOaU9zuxGb3WJPoQE4gX/uTxUJ5wFQjECB/w=;
        b=Ybjc/h/3LRqg79KCXfBk2XHKU/afBHDbofV+tnjXdptLkNTsMQkUxCjgplpF5C+a/k
         FH1TzFZbDiv2T4uOHIAu89VkQoZkoq6HJ0qcrcoZm+DR3rFDySnW9HvBAYudYOVetUl3
         3cDZPHnX7sIR5vj8yffrDFn/l5bF3NZd4xwpI7JGk3Y8EI75dN1hSWDCC7bLlrz4nYEE
         2mHrApkrsubtLHN+gMZx9gkG94/wSUfbgwiqKHEe3oZKm9GjXhFaM7Lmv7zasWcSxClK
         Mpq8h6G9tAB13HsWiGJsWQfIPvAEz9hl/kkqNG/A+AeKDY5xeEogaZqCwDxzREZlMFWv
         iT6w==
X-Gm-Message-State: AOJu0YxpLG4qfvVfd/7o+xTCk/SQwjU+fW83j9UlSRvUQHL7W/T3otmX
	kLQPQWfVlVyhipMuVw4Tn2fLaxw4YCp8ZkCs71VE8bQ7i9GGmA==
X-Google-Smtp-Source: AGHT+IGJENwweiSWgpyQ2rt2ZAKEMsGtxTp3hgP1clpfKIQ8hkKdJSDGEsbKitZOWDOeRpTbQTmQIXknw6HKsHnJXYg=
X-Received: by 2002:a05:6808:1289:b0:3bd:3e96:a8ab with SMTP id
 a9-20020a056808128900b003bd3e96a8abmr1572401oiw.53.1704989816773; Thu, 11 Jan
 2024 08:16:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104130123.37115-1-brgl@bgdev.pl> <20240104130123.37115-4-brgl@bgdev.pl>
 <20240109144327.GA10780@wunner.de> <CAMRc=MdXO6c6asvRSn_Z8-oFS48hroT+dazGKB6WWY1_Zu7f1Q@mail.gmail.com>
 <20240110132853.GA6860@wunner.de> <CAMRc=MdBSAb_kEO2r7r-vwLuRAEv7pMODOMtZoCCRAd=zsQb_w@mail.gmail.com>
 <20240110164105.GA13451@wunner.de> <CAMRc=MdQKPN8UbagmswjFx7_JvmJuBeuq8+9=z-+GBNUmdpWEA@mail.gmail.com>
 <20240111104211.GA32504@wunner.de> <CAMRc=MfT_VLo7++K4M89iYrciqWSrX_JyS1LX5kaGTNDNVQiOg@mail.gmail.com>
 <20240111150201.GA28409@wunner.de>
In-Reply-To: <20240111150201.GA28409@wunner.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 11 Jan 2024 17:16:45 +0100
Message-ID: <CAMRc=Mcngw1vw9q0DXRWLKk4o9FOY+Mzz-niueT-v2THvbS1Dw@mail.gmail.com>
Subject: Re: [RFC 3/9] PCI/portdrv: create platform devices for child OF nodes
To: Lukas Wunner <lukas@wunner.de>
Cc: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
	Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <terry.bowman@amd.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 4:02=E2=80=AFPM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> On Thu, Jan 11, 2024 at 05:09:09AM -0600, Bartosz Golaszewski wrote:
> > On Thu, 11 Jan 2024 11:42:11 +0100, Lukas Wunner <lukas@wunner.de> said=
:
> > > On Wed, Jan 10, 2024 at 02:18:30PM -0600, Bartosz Golaszewski wrote:
> > >> On Wed, 10 Jan 2024 17:41:05 +0100, Lukas Wunner <lukas@wunner.de> s=
aid:
> > >> > On Wed, Jan 10, 2024 at 05:26:52PM +0100, Bartosz Golaszewski wrot=
e:
> > >> > > Seems like the following must be true but isn't in my case (from
> > >> > > pci_bus_add_device()):
> > >> > >
> > >> > >     if (pci_is_bridge(dev))
> > >> > >         of_pci_make_dev_node(dev);
> > >> > >
> > >> > > Shouldn't it evaluate to true for ports?
> > >> >
> > >> > It should.
> > >> >
> > >> > What does "lspci -vvvvxxxx -s BB:DD.F" say for the port in questio=
n?
> >
> > # lspci -vvvvxxxx -s 0000:00:00
> > 0000:00:00.0 PCI bridge: Qualcomm Technologies, Inc Device 010b
> > (prog-if 00 [Normal decode])
> >       Device tree node: /sys/firmware/devicetree/base/soc@0/pcie@1c0000=
0/pcie@0
> [...]
> > 00: cb 17 0b 01 07 05 10 00 00 00 04 06 00 00 01 00
>                                                 ^^
> The Header Type in config space is 0x1, i.e. PCI_HEADER_TYPE_BRIDGE.
>
> So pci_is_bridge(dev) does return true (unlike what you write above)
> and control flow enters of_pci_make_dev_node().
>
> But perhaps of_pci_make_dev_node() returns immediately because:
>

No, it was actually a no-op due to CONFIG_PCI_DYNAMIC_OF_NODES not
being set. But this is only available if CONFIG_OF_DYNAMIC is enabled
which requires OF_UNITTEST (!).

We definitely don't need to enable dynamic OF nodes. We don't want to
modify the DT, we want to create devices for existing nodes. Also:
with the approach in this RFC we maintain a clear hierarchy of devices
with the port device being the parent of the power sequencing device
which becomes the parent of the actual PCIe device (the port stays the
parent of this device too).

Bartosz

>         /*
>          * If there is already a device tree node linked to this device,
>          * return immediately.
>          */
>         if (pci_device_to_OF_node(pdev))
>                 return;
>
> ...and lspci does list a devicetree node for that Root Port.
>
> In any case, of_pci_make_dev_node() is the right place to add
> the call to of_platform_populate().  Just make sure it's called
> even if there is already a DT node for the Root Port itself.
>
> Thanks,
>
> Lukas


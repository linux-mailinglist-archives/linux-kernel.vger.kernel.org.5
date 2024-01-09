Return-Path: <linux-kernel+bounces-20669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF49828348
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C16D7B21E90
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E748E35883;
	Tue,  9 Jan 2024 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M6WNk8GT"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C817633CED
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 09:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ccb4adbffbso31742821fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 01:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704792896; x=1705397696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJqT/yKntbRPcfe0qLvKxkYIwKna5/PtEhah9svhmss=;
        b=M6WNk8GTtRJ7PfhVeUKRLvc9KuKl7/GvTnnix7epUayVA0lszttlOW3ibvBC9RU4dx
         gwzfV0wp9R7Lfuw6Jb4psVsPfczJBwcPJDTZO2hEQp4BRbz71TFOjl7ewnQGRpxOVT65
         O0jeSwv3a4GLpJxmp+OBZumLQyzAmHEJ1AddE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704792896; x=1705397696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJqT/yKntbRPcfe0qLvKxkYIwKna5/PtEhah9svhmss=;
        b=gjk+W/FBdzpCW9VkKsPDeWEV0xn9zuGAYlOJfaExm8rQnHEPMsVxnruQ2uK3nWRl9k
         pRc3A8ageQsOBIf6DOVwTKc0c6YleawMx+RMb6W1nM0R6PQAXzRWaiTNMlBM5A2s4opF
         zdeVRnaZ+zKiZq27Nw7KBaBlDN9w/+8f2/AoOymVLYtUmRI3PR031T2yEpI2A/w5lDc/
         m0IC2oeP+EdIGLfD1TRZ8BUqgiW+9uSMDRW9wuN7UZRvD+Vp0TNjGVmTLJDRG9muX+dQ
         EZGqvQyPodm3JiUp+qH3Rq+dmn7MjFod7qobp2JeZdoFiHi6IGSuIQo0QfvvlJhc1w1N
         dtHA==
X-Gm-Message-State: AOJu0YxS2sQQLVw6IH4YJ44WODXlsiRWWWIdLk/qppSoUl8U8m4wJEs9
	Iw8kgeUK3b3Aze3XS+0ZJZlx4htqTC2Yi1e8EIlbR5OSGrnI
X-Google-Smtp-Source: AGHT+IELR4dwiGp2CIF3HMU1TjlgQoZhorSEw6dUp7zODhxGJIXldhW87IKKw1kYE9yxlp9R4VuLTKn/aa/czSet4Hk=
X-Received: by 2002:a2e:2245:0:b0:2cd:23ed:19dc with SMTP id
 i66-20020a2e2245000000b002cd23ed19dcmr2040924lji.39.1704792895784; Tue, 09
 Jan 2024 01:34:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104130123.37115-1-brgl@bgdev.pl> <20240104130123.37115-9-brgl@bgdev.pl>
 <15443d5d-6544-45d0-afeb-b23e6a041ecf@quicinc.com> <87jzoizwz7.fsf@kernel.org>
In-Reply-To: <87jzoizwz7.fsf@kernel.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 9 Jan 2024 17:34:44 +0800
Message-ID: <CAGXv+5FhYY+qyyT8wxY5DggvWPibfM2ypHVKQbsJZ30VkZDAkQ@mail.gmail.com>
Subject: Re: [RFC 8/9] PCI/pwrseq: add a pwrseq driver for QCA6390
To: Kalle Valo <kvalo@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
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

On Tue, Jan 9, 2024 at 5:18=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote:
>
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>
> > On 1/4/2024 5:01 AM, Bartosz Golaszewski wrote:
> >> diff --git a/drivers/pci/pcie/pwrseq/Kconfig b/drivers/pci/pcie/pwrseq=
/Kconfig
> >> index 010e31f432c9..f9fe555b8506 100644
> >> --- a/drivers/pci/pcie/pwrseq/Kconfig
> >> +++ b/drivers/pci/pcie/pwrseq/Kconfig
> >> @@ -6,3 +6,14 @@ menuconfig PCIE_PWRSEQ
> >>      help
> >>        Say yes here to enable support for PCIe power sequencing
> >>        drivers.
> >> +
> >> +if PCIE_PWRSEQ
> >> +
> >> +config PCIE_PWRSEQ_QCA6390
> >> +    tristate "PCIe Power Sequencing driver for QCA6390"
> >> +    depends on ARCH_QCOM || COMPILE_TEST
> >> +    help
> >> +      Enable support for the PCIe power sequencing driver for the
> >> +      ath11k module of the QCA6390 WLAN/BT chip.
> >> +
> >> +endif
> >
> > As I mentioned in the 5/9 patch I'm concerned that the current
> > definition of PCIE_PWRSEQ and PCIE_PWRSEQ_QCA6390 will effectively hide
> > the fact that QCA6390 may need additional configuration since the menu
> > item will only show up if you have already enabled PCIE_PWRSEQ.
> > Yes I see that these are set in the defconfig in 9/9 but I'm concerned
> > about the more generic case.
> >
> > I'm wondering if there should be a separate config QCA6390 within ath11=
k
> > which would then select PCIE_PWRSEQ and PCIE_PWRSEQ_QCA6390
>
> Or is it possible to provide an optional dependency in Kconfig (I guess

imply PCIE_PWRSEQ
imply PCIE_PWRSEQ_QCA6390
?

> not)? Or what about mentioning about PCIE_PWRSEQ_QCA6390 in ATH11K_PCI
> help text?


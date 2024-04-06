Return-Path: <linux-kernel+bounces-133778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 340EF89A88B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 05:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35DA1F22313
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 03:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8171C680;
	Sat,  6 Apr 2024 03:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPNxgNuy"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB16B80B;
	Sat,  6 Apr 2024 03:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712372637; cv=none; b=pPIjtCnSwkZRplmiGQzXp79EoAGZiOrl6YxdpPRJU3+fvukzRfscbAeWXlqBjEdMLxyis0jXcv3aulELqrarlkJdVz/0Xvv+PQSm3I7+Gjek4DjasvNfj50BVEpsVxP8527wPsyzQ7zGZHZ74g8cSaCJhoD32M6c5v8c7veWUeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712372637; c=relaxed/simple;
	bh=gEeL1D+1UxhAOwHdVHLyiJhqPupwQQHuUgmFMiv4g1s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=E6F2HDrX5qvVr4ws6IRGEhPX4WDMvURdfc4sV+345E9GUJZETDkeAyUbO6XmzgN88PZztP9TvTaoFNWdOkBu8Cl3eSe+DH7nqwvrukXT3ODDgaPUB6Y6b9wkFQCUd3IQJCKA4mZxPYL12qcIRYMZEXFiHQ8x/gxj3MxIcacRbA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPNxgNuy; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e252f2bf23so24783865ad.2;
        Fri, 05 Apr 2024 20:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712372634; x=1712977434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SrwcE7/g7DLqX8byBtpEwpa2r3Ey0OJYvW7oQqc7U4o=;
        b=iPNxgNuyBOaiOWrlatbrkCD6DYA36h7idhtZ24sCF2xxjgfz2v6s8UDr7ioxDSSQoz
         gnqKOcivSG9IPqIQHb9HMMRNN63YLY8STVsdHnQrlLCxJLZwzc6E3HuSX1JS4pYogVN8
         89cCT6lh+Z18v6Crst0nBksPZPtIm54v0Jk39HEDGEjYH8mp/HtY1uOsvnnl8Y1d0u0a
         bp1iZPhFST5KZ7N0Z7H7GUAo3yA2VPH39WJtNwc3IxjN+GPsWmaj8F+7BR9DiRl6qCR1
         oBBNTJumyXMX9mFIMvpPr4Cx21uApdepEqDocFMt+/d+QgC400NxJUbW9CR8vvM5xwyS
         J43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712372634; x=1712977434;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SrwcE7/g7DLqX8byBtpEwpa2r3Ey0OJYvW7oQqc7U4o=;
        b=W8Nqe//BIVPJ8dEzsfJYTyisQoUQeZMagrrYxgIghr2sny9/5cL8H1ZhxP/YitWDdR
         ISWeh5OmZcw84vXuD9W+Et1r9ebiX9e4YTkAMKP+vea1O9pKUyYpi2NgHZTnVnTpdXGT
         lnH1HipWnCKCSrRbunrz9IBd5/YaaJRbdfX8Lp0VjpA1MFgnJLSvOCoxUZeAAG+zN6AH
         B6M48jkVhrSRKkz2torlrNmRvjF/hh/qvtke/+7lmOOTgTEL0M0hnEBFg/WTrL1MqCv8
         PimqeEg4eYQL8nlhKNPR33V/hyAbZurFYB4KnyeLMbkANwOiU7OeaKyYnEaFrr1MsePW
         goNA==
X-Forwarded-Encrypted: i=1; AJvYcCVP/Hx4Z/Px2rArm5+gthomnEwDRUPaD0oOhp0Sqp4FxsuS2c6U3UiS1813HR8C59/17Lwi8/92FkKGw7+D2Qw6wNPi5IccFHV3wihifSkXqAXhutOvhmSdu/BkrC1oyr0MNLMAV4H4tNV7+pKO964jVsnsasUWu40rFrs2Ox2+8pDA4U4tQFh1vjmHq3ftM/By27Li5bYYL0qcPqlV/RuMLMuSKAUTuYpZrWX3Y8Gr/rpSVcobH8cyHa8bTMW0/MWTuqseYOYRkv+xa2UJEXr79ozrZ15JLATiwGW4X45L5xrFByjL7oyaQaerdcMl4T6IcF5o
X-Gm-Message-State: AOJu0YzZv9Jdggdo4fNwZL7ax9C8jMOZbfPqW2m8vUeEBbwZty7aIHHq
	ETfWlon+dypx0w5hTqrsPgZYpJP/lcs0xcdFCpn48abaYkC8nHO+
X-Google-Smtp-Source: AGHT+IEo6TWDacBRWn17imIEDPv2gEfcvREBF4v6IhvEh5yW/NKJs5Im2R91/61Uf4zmKS9JQd8BJg==
X-Received: by 2002:a17:902:f085:b0:1e2:c8f9:4cd7 with SMTP id p5-20020a170902f08500b001e2c8f94cd7mr2674988pla.64.1712372633702;
        Fri, 05 Apr 2024 20:03:53 -0700 (PDT)
Received: from [192.168.0.171] ([223.166.28.146])
        by smtp.gmail.com with ESMTPSA id l3-20020a170902d04300b001e2ad73b15bsm2367967pll.203.2024.04.05.20.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 20:03:53 -0700 (PDT)
Message-ID: <6b63d5d2-5f30-4fbd-a872-91f32dc32c87@gmail.com>
Date: Sat, 6 Apr 2024 11:03:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Xilin Wu <wuxilin123@gmail.com>
Subject: Re: [PATCH v6 00/16] power: sequencing: implement the subsystem and
 add first users
To: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Saravana Kannan <saravanak@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Alex Elder <elder@linaro.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abel.vesa@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Lukas Wunner <lukas@wunner.de>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240325131624.26023-1-brgl@bgdev.pl>
Content-Language: en-US
In-Reply-To: <20240325131624.26023-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024/3/25 21:16, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>
>
> Note: I dropped most of the the review and test tags on purpose, the code
> changed significantly and warrants a new round of reviews and tests.
>
> ===
>
> Problem statement #1: Dynamic bus chicken-and-egg problem.
>
> Certain on-board PCI devices need to be powered up before they are can be
> detected but their PCI drivers won't get bound until the device is
> powered-up so enabling the relevant resources in the PCI device driver
> itself is impossible.
>
> Problem statement #2: Sharing inter-dependent resources between devices.
>
> Certain devices that use separate drivers (often on different busses)
> share resources (regulators, clocks, etc.). Typically these resources
> are reference-counted but in some cases there are additional interactions
> between them to consider, for example specific power-up sequence timings.
>
> ===
>
> The reason for tackling both of these problems in a single series is the
> fact the the platform I'm working on - Qualcomm RB5 - deals with both and
> both need to be addressed in order to enable WLAN and Bluetooth support
> upstream.
>
> The on-board WLAN/BT package - QCA6391 - has a Power Management Unit that
> takes inputs from the host and exposes LDO outputs consumed by the BT and
> WLAN modules which can be powered-up and down independently. However
> a delay of 100ms must be respected between enabling the BT- and
> WLAN-enable GPIOs.
>
> A similar design with a discreet PMU is also employed in other models of
> the WCN family of chips although we can often do without the delays. With
> this series we add support for the WCN7850 as well.
>
> ===
>
> We introduce a new subsystem here - the power sequencing framework. The
> qcom-wcn driver that we add is its first user. It implements the power-up
> sequences for QCA6390 and WCN7850 chips. However - we only use it to
> power-up the bluetooth module in the former. We use it to driver the WLAN
> modules in both. The reason for this is that for WCN7850 we have
> comprehensive bindings already upstream together with existing DT users.
> Porting them to using the pwrseq subsystem can be done separately and in
> an incremental manner once the subsystem itself is upstream. We will also
> have to ensure backward DT compatibility. To avoid overcomplicating this
> series, let's leave it out for now.
>
> ===
>
> This series is logically split into several sections. I'll go
> patch-by-patch and explain each step.
>
> Patches 1/16-5/16:
>
> These contain all relevant DT bindings changes. We add new documents for
> the QCA6390 & WCN7850 PMUs and ATH12K devices as well as extend the bindings
> for the Qualcomm Bluetooth and ATH11K modules with regulators used by them
> in QCA6390.
>
> Patches 6/16-8/16:
>
> These contain changes to device-tree sources for the three platforms we
> work with in this series. We model the PMUs of the WLAN/BT chips as
> top-level platform devices on the device tree. In order to limit the scope
> of this series and not introduce an excessive amount of confusion with
> deprecating DT bindings, we leave the Bluetooth nodes on sm8650 and sm8550
> as is (meaning: they continue to consumer the GPIOs and power inputs from
> the host). As the WCN7850 module doesn't require any specific timings, we can
> incrementally change that later.
>
> In both cases we add WLAN nodes that consume the power outputs of the PMU.
> For QCA6390 we also make the Bluetooth node of the RB5 consume the outputs
> of the PMU - we can do it as the bindings for this chip did not define any
> supply handles prior to this series meaning we are able to get this correct
> right away.
>
> Patches 9/16-12/16:
>
> These contain the bulk of the PCI changes for this series. We introduce
> a simple framework for powering up PCI devices before detecting them on
> the bus.
>
> The general approach is as follows: PCI devices that need special
> treatment before they can be powered up, scanned and bound to their PCI
> drivers must be described on the device-tree as child nodes of the PCI
> port node. These devices will be instantiated on the platform bus. They
> will in fact be generic platform devices with the compatible of the form
> used for PCI devices already upstream ("pci<vendor ID>,<device ID">). We
> add a new directory under drivers/pci/pwrctl/ that contains PCI pwrctl
> drivers. These drivers are platform drivers that will now be matched
> against the devices instantiated from port children just like any other
> platform pairs.
>
> Both the power control platform device *AND* the associated PCI device
> reuse the same OF node and have access to the same properties. The goal
> of the platform driver is to request and bring up any required resources
> and let the pwrctl framework know that it's now OK to rescan the bus and
> detect the devices. When the device is bound, we are notified about it
> by the PCI bus notifier event and can establish a device link between the
> power control device and the PCI device so that any future extension for
> power-management will already be able to work with the correct hierachy.
>
> The reusing of the OF node is the reason for the small changes to the PCI
> OF core: as the bootloader can possibly leave the relevant regulators on
> before booting linux, the PCI device can be detected before its platform
> abstraction is probed. In this case, we find that device first and mark
> its OF node as reused. The pwrctl framework handles the opposite case
> (when the PCI device is detected only after the platform driver
> successfully enabled it).
>
> Patch 13/16 - 14/16:
>
> These add a relatively simple power sequencing subsystem and the first
> driver using it: the pwrseq module for the PMUs on the WCN family of chips.
>
> I'm proposing to add a subsystem that allows different devices to use a shared
> power sequence split into consumer-specific as well as common "units".
>
> A power sequence provider driver registers a set of units with pwrseq
> core. Each unit can be enabled and disabled and contains an optional list
> of other units which must be enabled before it itself can be. A unit
> represents a discreet chunk of the power sequence.
>
> It also registers a list of targets: a target is an abstraction wrapping
> a unit which allows consumers to tell pwrseq which unit they want to
> reach. Real-life example is the driver we're adding here: there's a set
> of common regulators, two PCIe-specific ones and two enable GPIOs: one
> for Bluetooth and one for WLAN.
>
> The Bluetooth driver requests a descriptor to the power sequencer and
> names the target it wants to reach:
>
>      pwrseq = devm_pwrseq_get(dev, "bluetooth");
>
> The pwrseq core then knows that when the driver calls:
>
>      pwrseq_power_on(pwrseq);
>
> It must enable the "bluetooth-enable" unit but it depends on the
> "regulators-common" unit so this one is enabled first. The provider
> driver is also in charge of assuring an appropriate delay between
> enabling the BT and WLAN enable GPIOs. The WLAN-specific resources are
> handled by the "wlan-enable" unit and so are not enabled until the WLAN
> driver requests the "wlan" target to be powered on.
>
> Another thing worth discussing is the way we associate the consumer with
> the relevant power sequencer. DT maintainers have expressed a discontent
> with the existing mmc pwrseq bindings and have NAKed an earlier
> initiative to introduce global pwrseq bindings to the kernel[1].
>
> In this approach, we model the existing regulators and GPIOs in DT but
> the pwrseq subsystem requires each provider to provide a .match()
> callback. Whenever a consumer requests a power sequencer handle, we
> iterate over the list of pwrseq drivers and call .match() for each. It's
> up to the driver to verify in a platform-specific way whether it deals
> with its consumer and let the core pwrseq code know.
>
> The advantage of this over reusing the regulator or reset subsystem is
> that it's more generalized and can handle resources of all kinds as well
> as deal with any kind of power-on sequences: for instance, Qualcomm has
> a PCI switch they want a driver for but this switch requires enabling
> some resources first (PCI pwrctl) and then configuring the device over
> I2C (which can be handled by the pwrseq provider).
>
> Patch 15:
>
> This patch makes the Qualcomm Bluetooth driver get and use the power
> sequencer for QCA6390.
>
> Patch 16:
>
> While tiny, this patch is possibly the highlight of the entire series.
> It uses the two abstraction layers we introduced before to create an
> elegant power sequencing PCI power control driver and supports the ath11k
> module on QCA6390 and ath12k on WCN7850.
>
> With this series we can now enable BT and WLAN on several new Qualcomm
> boards upstream.
>
> Tested on RB5, sm8650-qrd and sm8550-qrd.
>
> Changelog:
>
> Since v5:
> - unify the approach to modelling the WCN WLAN/BT chips by always exposing
>    the PMU node on the device tree and making the WLAN and BT nodes become
>    consumers of its power outputs; this includes a major rework of the DT
>    sources, bindings and driver code; there's no more a separate PCI
>    pwrctl driver for WCN7850, instead its power-up sequence was moved
>    into the pwrseq driver common for all WCN chips
> - don't set load_uA from new regulator consumers
> - fix reported kerneldoc issues
> - drop voltage ranges for PMU outputs from DT
> - many minor tweaks and reworks
>
> v1: Original RFC:
>
> https://lore.kernel.org/lkml/20240104130123.37115-1-brgl@bgdev.pl/T/
>
> v2: First real patch series (should have been PATCH v2) adding what I
>      referred to back then as PCI power sequencing:
>
> https://lore.kernel.org/linux-arm-kernel/2024021413-grumbling-unlivable-c145@gregkh/T/
>
> v3: RFC for the DT representation of the PMU supplying the WLAN and BT
>      modules inside the QCA6391 package (was largely separate from the
>      series but probably should have been called PATCH or RFC v3):
>
> https://lore.kernel.org/all/CAMRc=Mc+GNoi57eTQg71DXkQKjdaoAmCpB=h2ndEpGnmdhVV-Q@mail.gmail.com/T/
>
> v4: Second attempt at the full series with changed scope (introduction of
>      the pwrseq subsystem, should have been RFC v4)
>
> https://lore.kernel.org/lkml/20240201155532.49707-1-brgl@bgdev.pl/T/
>
> v5: Two different ways of handling QCA6390 and WCN7850:
>
> https://lore.kernel.org/lkml/20240216203215.40870-1-brgl@bgdev.pl/
>
> Bartosz Golaszewski (16):
>    regulator: dt-bindings: describe the PMU module of the QCA6390 package
>    regulator: dt-bindings: describe the PMU module of the WCN7850 package
>    dt-bindings: net: bluetooth: qualcomm: describe regulators for QCA6390
>    dt-bindings: net: wireless: qcom,ath11k: describe the ath11k on
>      QCA6390
>    dt-bindings: net: wireless: describe the ath12k PCI module
>    arm64: dts: qcom: sm8550-qrd: add the Wifi node
>    arm64: dts: qcom: sm8650-qrd: add the Wifi node
>    arm64: dts: qcom: qrb5165-rb5: add the Wifi node
>    PCI: hold the rescan mutex when scanning for the first time
>    PCI/pwrctl: reuse the OF node for power controlled devices
>    PCI/pwrctl: create platform devices for child OF nodes of the port
>      node
>    PCI/pwrctl: add PCI power control core code
>    power: sequencing: implement the pwrseq core
>    power: pwrseq: add a driver for the PMU module on the QCom WCN
>      chipsets
>    Bluetooth: qca: use the power sequencer for QCA6390
>    PCI/pwrctl: add a PCI power control driver for power sequenced devices
>
>   .../net/bluetooth/qualcomm-bluetooth.yaml     |   17 +
>   .../net/wireless/qcom,ath11k-pci.yaml         |   46 +
>   .../bindings/net/wireless/qcom,ath12k.yaml    |  100 ++
>   .../bindings/regulator/qcom,qca6390-pmu.yaml  |  185 +++
>   MAINTAINERS                                   |    8 +
>   arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      |  103 +-
>   arch/arm64/boot/dts/qcom/sm8250.dtsi          |   10 +
>   arch/arm64/boot/dts/qcom/sm8550-qrd.dts       |   97 ++
>   arch/arm64/boot/dts/qcom/sm8550.dtsi          |   10 +
>   arch/arm64/boot/dts/qcom/sm8650-qrd.dts       |   89 ++
>   arch/arm64/boot/dts/qcom/sm8650.dtsi          |   10 +
>   drivers/bluetooth/hci_qca.c                   |   74 +-
>   drivers/pci/Kconfig                           |    1 +
>   drivers/pci/Makefile                          |    1 +
>   drivers/pci/bus.c                             |    9 +-
>   drivers/pci/of.c                              |   14 +-
>   drivers/pci/probe.c                           |    2 +
>   drivers/pci/pwrctl/Kconfig                    |   17 +
>   drivers/pci/pwrctl/Makefile                   |    6 +
>   drivers/pci/pwrctl/core.c                     |  136 +++
>   drivers/pci/pwrctl/pci-pwrctl-pwrseq.c        |   89 ++
>   drivers/pci/remove.c                          |    2 +
>   drivers/power/Kconfig                         |    1 +
>   drivers/power/Makefile                        |    1 +
>   drivers/power/sequencing/Kconfig              |   28 +
>   drivers/power/sequencing/Makefile             |    6 +
>   drivers/power/sequencing/core.c               | 1065 +++++++++++++++++
>   drivers/power/sequencing/pwrseq-qcom-wcn.c    |  336 ++++++
>   include/linux/pci-pwrctl.h                    |   51 +
>   include/linux/pwrseq/consumer.h               |   56 +
>   include/linux/pwrseq/provider.h               |   75 ++
>   31 files changed, 2614 insertions(+), 31 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
>   create mode 100644 Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
>   create mode 100644 drivers/pci/pwrctl/Kconfig
>   create mode 100644 drivers/pci/pwrctl/Makefile
>   create mode 100644 drivers/pci/pwrctl/core.c
>   create mode 100644 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
>   create mode 100644 drivers/power/sequencing/Kconfig
>   create mode 100644 drivers/power/sequencing/Makefile
>   create mode 100644 drivers/power/sequencing/core.c
>   create mode 100644 drivers/power/sequencing/pwrseq-qcom-wcn.c
>   create mode 100644 include/linux/pci-pwrctl.h
>   create mode 100644 include/linux/pwrseq/consumer.h
>   create mode 100644 include/linux/pwrseq/provider.h


I tested the patchset on SM8550 and it does give me working WiFi. However I
seethe following warnings during boot.

[    5.973011] mhi mhi0: Requested to power ON
[    6.597591] mhi mhi0: Power on setup success
[    6.597631] sysfs: cannot create duplicate filename '/devices/platform/soc@0/1c00000.pcie/pci0000:00/0000:00:00.0/resource0'
[    6.597634] CPU: 7 PID: 154 Comm: kworker/u32:5 Tainted: G S                 6.9.0-rc1-next-20240328-g955237c9980c #1
[    6.597635] Hardware name: AYN Odin 2 (DT)
[    6.597637] Workqueue: async async_run_entry_fn
[    6.597645] Call trace:
[    6.597646]  dump_backtrace+0xa0/0x128
[    6.597649]  show_stack+0x20/0x38
[    6.597650]  dump_stack_lvl+0x74/0x90
[    6.597653]  dump_stack+0x18/0x28
[    6.597654]  sysfs_warn_dup+0x6c/0x90
[    6.597658]  sysfs_add_bin_file_mode_ns+0xdc/0x100
[    6.597660]  sysfs_create_bin_file+0x7c/0xb8
[    6.597662]  pci_create_attr+0xb4/0x1a8
[    6.597665]  pci_create_resource_files+0x64/0xd0
[    6.597667]  pci_create_sysfs_dev_files+0x24/0x40
[    6.597669]  pci_bus_add_device+0x54/0x138
[    6.597670]  pci_bus_add_devices+0x40/0x98
[    6.597672]  pci_host_probe+0x70/0xf0
[    6.597673]  dw_pcie_host_init+0x248/0x658
[    6.597676]  qcom_pcie_probe+0x234/0x330
[    6.597677]  platform_probe+0x70/0xd8
[    6.597680]  really_probe+0xc8/0x3a0
[    6.597681]  __driver_probe_device+0x84/0x170
[    6.597682]  driver_probe_device+0x44/0x120
[    6.597683]  __device_attach_driver+0xc4/0x168
[    6.597684]  bus_for_each_drv+0x8c/0xf0
[    6.597686]  __device_attach_async_helper+0xb4/0x118
[    6.597687]  async_run_entry_fn+0x40/0x178
[    6.597689]  process_one_work+0x16c/0x410
[    6.597691]  worker_thread+0x284/0x3a0
[    6.597693]  kthread+0x118/0x128
[    6.597693]  ret_from_fork+0x10/0x20
[    6.597698] ------------[ cut here ]------------
[    6.597698] proc_dir_entry '0000:00/00.0' already registered
[    6.597710] WARNING: CPU: 7 PID: 154 at fs/proc/generic.c:375 proc_register+0x138/0x1d0
[    6.597713] Modules linked in:
[    6.597714] CPU: 7 PID: 154 Comm: kworker/u32:5 Tainted: G S                 6.9.0-rc1-next-20240328-g955237c9980c #1
[    6.597715] Hardware name: AYN Odin 2 (DT)
[    6.597716] Workqueue: async async_run_entry_fn
[    6.597718] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[    6.597719] pc : proc_register+0x138/0x1d0
[    6.597721] lr : proc_register+0x138/0x1d0
[    6.597723] sp : ffff800081e3b9a0
[    6.597723] x29: ffff800081e3b9a0 x28: 0000000000000000 x27: ffffddb2a28eabe0
[    6.597725] x26: ffff3425c9ada5c0 x25: ffffddb2a2d4eef0 x24: ffff3425c9ada540
[    6.597726] x23: 0000000000000004 x22: ffff3425c7b1822c x21: 0000000000000004
[    6.597727] x20: ffff3425c7b18180 x19: ffff3425c9adaec8 x18: ffffffffffffffff
[    6.597729] x17: 3040636f732f6d72 x16: 6f6674616c702f73 x15: ffff800081e3b910
[    6.597730] x14: 0000000000000000 x13: 0a64657265747369 x12: 6765722079646165
[    6.597731] x11: fffffffffff00000 x10: ffffddb2a27c4fb0 x9 : ffffddb29f5d7528
[    6.597733] x8 : 00000000ffff7fff x7 : ffffddb2a27c4fb0 x6 : 80000000ffff8000
[    6.597734] x5 : 0000000000000358 x4 : 0000000000000000 x3 : 00000000ffffffff
[    6.597736] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff3425c5ce0000
[    6.597737] Call trace:
[    6.597737]  proc_register+0x138/0x1d0
[    6.597739]  proc_create_data+0x48/0x78
[    6.597741]  pci_proc_attach_device+0x84/0x118
[    6.597743]  pci_bus_add_device+0x5c/0x138
[    6.597744]  pci_bus_add_devices+0x40/0x98
[    6.597745]  pci_host_probe+0x70/0xf0
[    6.597746]  dw_pcie_host_init+0x248/0x658
[    6.597748]  qcom_pcie_probe+0x234/0x330
[    6.597749]  platform_probe+0x70/0xd8
[    6.597750]  really_probe+0xc8/0x3a0
[    6.597751]  __driver_probe_device+0x84/0x170
[    6.597752]  driver_probe_device+0x44/0x120
[    6.597753]  __device_attach_driver+0xc4/0x168
[    6.597754]  bus_for_each_drv+0x8c/0xf0
[    6.597756]  __device_attach_async_helper+0xb4/0x118
[    6.597757]  async_run_entry_fn+0x40/0x178
[    6.597759]  process_one_work+0x16c/0x410
[    6.597760]  worker_thread+0x284/0x3a0
[    6.597761]  kthread+0x118/0x128
[    6.597762]  ret_from_fork+0x10/0x20
[    6.597763] ---[ end trace 0000000000000000 ]---

This probably only occurs when the relevant drivers on compiled as built-in.
Similar behavior has been noticed before as well:

https://lore.kernel.org/lkml/20240201155532.49707-1-brgl@bgdev.pl/T/#mdeeca9bc8e19458787d53738298abcfff443068a

Thanks,
Xilin



Return-Path: <linux-kernel+bounces-71124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF46985A0F8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5BDFB22018
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995CE28E11;
	Mon, 19 Feb 2024 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J2SZ8TRl"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0195288AE
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708338412; cv=none; b=LrKOZ34SZuhryHb6yq+mgsp3uzhgml+6IUGgsxXRnhcJiF4OEVoo97vCXMo7/F0z6f8oktlTN9JsJFZ8U27SXjOYc0lYDKpdViYN2bFAMSL/ayrdKdOxcY4EjZogMxDsO6VxyTbr3WLR5AD4FaO0qlbaeZtzepN5BmW4mw76Lq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708338412; c=relaxed/simple;
	bh=lCcUA04zUjPlqcbDjjJroqxQOZ61QPH+jdJBen0HMLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvHGwAYQ5xSByBwqp8VKTs3oX1TyFkOA0dxM46iSVc52rzmM2qoMqV69DAwLBs/BdUz24zHzonQbCBfCEL0u2A1j1HBAJv2rvt4sjC3ErpuHKUldSxdpyBhdpldoDj860mwPrk6lNj0Xk3Lba+Kg8MpUsvbadUKQzrqUtFyqh6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J2SZ8TRl; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-603fd31f5c2so42811817b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 02:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708338410; x=1708943210; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TmyLIGmDRBMuA9/uAiTaewm8j0zrsoCAkXewuup87r0=;
        b=J2SZ8TRlXUXjErTvCm7meKfgsK876x8PjR9Lrc9V6qfoVUkCUC4BNRI4xrXnLC/Uee
         Y8R5YdV5KqE1BIL5V2PIFp3QGWnLdp3LDS1OlZRdKJkASqCNEZdzN8ScB6au+leYAtjI
         EKsuIHFKb11X4C/iwunFLucXzVsXtIlutqbEBw1+9Ctbt4BDYkuh2U2rhC7ZEv9KYTXj
         IePMttvXdtYHsE3+ClHNpcrsrVYfeIH4rCK5OVT119AMhEms/2ud9Uyyg4yR9+I1igY2
         E24p80Jdrk4UrIHyeMr6xvls2gYwklgZXZt1nh2v8XJDQNPjlO2Mc1rRtz3f6qcjK9vS
         IcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708338410; x=1708943210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TmyLIGmDRBMuA9/uAiTaewm8j0zrsoCAkXewuup87r0=;
        b=fnKUBBmtmveeDXAtfv/mMz9Qx7icey5YODcFX65zV8A5oMKS8swhw7YS1LnhyyEqNz
         JP41hfbwt+5ZhZ9YJq2UXWDte0u4hveo4mHyq50Dz8aOgRIWjCmFMJpCR8G+1AjH9kip
         829jguoPtR0YNz5KNtim9B+VD6yPRJr1GEuG4z4A0tx7YNtSfHjJOOHZ9mcAvqaICA3u
         JUr0itBDHtNIhOuV5qZohzH+IVSqxUlGDH6eAc6WTRj1hFKpRS71Y86QE95ZeV1G6iIx
         dr7dl7YhYbUl7Usii2VdQYRhXse7D0UCOjWcAp8/HCCahBt5qKEkvPYrtm2uf0t95cDj
         xj4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpx7nBsS9Pkh1sytyWtA90POcmpp2PZo80BuBr4xDw6SOQJiTji330L76E9LXM/BFMJrsXMAoFvWfsZ8NAV53RhK93QM68mrEMGc3u
X-Gm-Message-State: AOJu0YzCUdCFN6DbIOTdUfIA61fEYL4c73aZ/SpocL6N20y1bcbzFnAY
	NE2zvOdCcBXQIVr+dw2OMECwDw6q9kVBXTQGfoHHfhAS1HJS1gIn2HI4yJ7eNXohpu4OoTv4yXf
	BwIj0HafJDlJ7edhfIZRTfBS89xLtS2QoApsM2A==
X-Google-Smtp-Source: AGHT+IH8Xj1z0uS8Qm7X6TratBsLyV3NzUK9GlyrRDCdO1y8h0WcX4ALGme/oMWCWglNot9Mbw3Z17eahBSzxpWPP2s=
X-Received: by 2002:a81:84cc:0:b0:608:427:bf61 with SMTP id
 u195-20020a8184cc000000b006080427bf61mr4616175ywf.19.1708338409779; Mon, 19
 Feb 2024 02:26:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216203215.40870-1-brgl@bgdev.pl> <CAA8EJppt4-L1RyDeG=1SbbzkTDhLkGcmAbZQeY0S6wGnBbFbvw@mail.gmail.com>
 <e4cddd9f-9d76-43b7-9091-413f923d27f2@linaro.org> <CAA8EJpp6+2w65o2Bfcr44tE_ircMoON6hvGgyWfvFuh3HamoSQ@mail.gmail.com>
 <4d2a6f16-bb48-4d4e-b8fd-7e4b14563ffa@linaro.org>
In-Reply-To: <4d2a6f16-bb48-4d4e-b8fd-7e4b14563ffa@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 19 Feb 2024 12:26:39 +0200
Message-ID: <CAA8EJpq=iyOfYzNATRbpqfBaYSdJV1Ao5t2ewLK+wY+vEaFYAQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] power: sequencing: implement the subsystem and
 add first users
To: neil.armstrong@linaro.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Saravana Kannan <saravanak@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, 
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

On Mon, 19 Feb 2024 at 11:42, <neil.armstrong@linaro.org> wrote:
>
> On 19/02/2024 10:22, Dmitry Baryshkov wrote:
> > On Mon, 19 Feb 2024 at 10:14, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> >>
> >> On 18/02/2024 13:53, Dmitry Baryshkov wrote:
> >>> On Fri, 16 Feb 2024 at 22:33, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >>>>
> >>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>>
> >>>> First, I'd like to apologize for the somewhat chaotic previous iterations
> >>>> of this series and improper versioning which was rightfully pointed out
> >>>> to me. I figured that the scope changed so much that it didn't make sense
> >>>> to consider previous submissions part of the same series as the original
> >>>> RFC but others thought otherwise so this one becomes v5 and I'll keep the
> >>>> versioning going forward.
> >>>>
> >>>> This is the summary of the work so far:
> >>>>
> >>>> v1: Original RFC:
> >>>>
> >>>> https://lore.kernel.org/lkml/20240104130123.37115-1-brgl@bgdev.pl/T/
> >>>>
> >>>> v2: First real patch series (should have been PATCH v2) adding what I
> >>>>       referred to back then as PCI power sequencing:
> >>>>
> >>>> https://lore.kernel.org/linux-arm-kernel/2024021413-grumbling-unlivable-c145@gregkh/T/
> >>>>
> >>>> v3: RFC for the DT representation of the PMU supplying the WLAN and BT
> >>>>       modules inside the QCA6391 package (was largely separate from the
> >>>>       series but probably should have been called PATCH or RFC v3):
> >>>>
> >>>> https://lore.kernel.org/all/CAMRc=Mc+GNoi57eTQg71DXkQKjdaoAmCpB=h2ndEpGnmdhVV-Q@mail.gmail.com/T/
> >>>>
> >>>> v4: Second attempt at the full series with changed scope (introduction of
> >>>>       the pwrseq subsystem, should have been RFC v4)
> >>>>
> >>>> https://lore.kernel.org/lkml/20240201155532.49707-1-brgl@bgdev.pl/T/
> >>>>
> >>>> ===
> >>>>
> >>>> With that out of the way, I'd like to get down to explaining the two
> >>>> problems I'm trying to solve.
> >>>>
> >>>> Problem statement #1: Dynamic bus chicken-and-egg problem.
> >>>>
> >>>> Certain on-board PCI devices need to be powered up before they are can be
> >>>> detected but their PCI drivers won't get bound until the device is
> >>>> powered-up so enabling the relevant resources in the PCI device driver
> >>>> itself is impossible.
> >>>>
> >>>> Problem statement #2: Sharing inter-dependent resources between devices.
> >>>>
> >>>> Certain devices that use separate drivers (often on different busses)
> >>>> share resources (regulators, clocks, etc.). Typically these resources
> >>>> are reference-counted but in some cases there are additional interactions
> >>>> between them to consider, for example specific power-up sequence timings.
> >>>>
> >>>> ===
> >>>>
> >>>> The reason for tackling both of these problems in a single series is the
> >>>> fact the the platform I'm working on - Qualcomm RB5 - deals with both and
> >>>> both need to be addressed in order to enable WLAN and Bluetooth support
> >>>> upstream.
> >>>>
> >>>> The on-board WLAN/BT package - QCA6391 - has a Power Management Unit that
> >>>> takes inputs from the host and exposes LDO outputs consumed by the BT and
> >>>> WLAN modules which can be powered-up and down independently. However
> >>>> a delay of 100ms must be respected between enabling the BT- and
> >>>> WLAN-enable GPIOs[*].
> >>>>
> >>>> ===
> >>>>
> >>>> This series is logically split into several sections. I'll go
> >>>> patch-by-patch and explain each step.
> >>>>
> >>>> Patch 1/18:
> >>>>
> >>>> This is a commit taken from the list by Jonathan Cameron that adds
> >>>> a __free() helper for OF nodes. Not strictly related to the series but
> >>>> until said commit ends in next, I need to carry it with this series.
> >>>>
> >>>> Patch 2/18:
> >>>>
> >>>> This enables the ath12k PCI module in arm64 defconfig as Qualcomm sm8650
> >>>> and sm8550 reference platforms use it in the WCN7850 module.
> >>>>
> >>>> Patches 3/18-6/18:
> >>>>
> >>>> These contain all relevant DT bindings changes. We add new documents for
> >>>> the QCA6390 PMU and ATH12K devices as well as extend the bindings for the
> >>>> Qualcomm Bluetooth and ATH11K modules with regulators used by them in
> >>>> QCA6390.
> >>>>
> >>>> Patches 7/18-9/18:
> >>>>
> >>>> These contain changes to device-tree sources for the three platforms we
> >>>> work with in this series. As the WCN7850 module doesn't require any
> >>>> specific timings introducing dependencies between the Bluetooth and WLAN
> >>>> modules, while the QCA6390 does, we take two different approaches to how
> >>>> me model them in DT.
> >>>>
> >>>> For WCN7850 we hide the existence of the PMU as modeling it is simply not
> >>>> necessary. The BT and WLAN devices on the device-tree are represented as
> >>>> consuming the inputs (relevant to the functionality of each) of the PMU
> >>>> directly.
> >>>
> >>> We are describing the hardware. From the hardware point of view, there
> >>> is a PMU. I think at some point we would really like to describe all
> >>> Qualcomm/Atheros WiFI+BT units using this PMU approach, including the
> >>> older ath10k units present on RB3 (WCN3990) and db820c (QCA6174).
> >>
> >> While I agree with older WiFi+BT units, I don't think it's needed for
> >> WCN7850 since BT+WiFi are now designed to be fully independent and PMU is
> >> transparent.
> >
> > I don't see any significant difference between WCN6750/WCN6855 and
> > WCN7850 from the PMU / power up point of view. Could you please point
> > me to the difference?
> >
>
> The WCN7850 datasheet clearly states there's not contraint on the WLAN_EN
> and BT_EN ordering and the only requirement is to have all input regulators
> up before pulling up WLAN_EN and/or BT_EN.
>
> This makes the PMU transparent and BT and WLAN can be described as independent.

From the hardware perspective, there is a PMU. It has several LDOs. So
the device tree should have the same style as the previous
generations.

-- 
With best wishes
Dmitry


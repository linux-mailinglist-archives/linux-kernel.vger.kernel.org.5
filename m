Return-Path: <linux-kernel+bounces-33849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA5D836FED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B40D1B2BA86
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537A44642A;
	Mon, 22 Jan 2024 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rv6Rcd4n"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9B83D573
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945421; cv=none; b=LGmnqhwh7E0ZuelRhMD4QnYj7BKU3PDcQwyuUPnJX9TTks+MJLKVXkrQSnBqDWd87Q0p+lxVzJUXmH5denmNX7iUlLkSzlh8Vhmq2sbtM66nvBgUpqI9WMu0b2PSHykerd0g/5DjxDDmihx0YHjfzlEtkhA7aT5Z6RruxgtwRuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945421; c=relaxed/simple;
	bh=aIOnQm+u0Sgg7h5AHZWFGHaNeKPCejsto0qSNsoN0Dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/dJ3U2rsNV2fEKFWmcqxanx5WwewNBRXopCNkr4ucxBhgBC1sPyPKU4vOGf3+s3Na4uLM1d0Qtmm0TtsT7OfPfib+K3DVCRPn05BTsTQGTKV2r0leA5totbuKPDvv9S9COxppmlj2OIamReqDXWCc9F03KWn0GA6//wZMZ1ilM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rv6Rcd4n; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5ff790d41bdso22415437b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705945418; x=1706550218; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GoxIjIov4FxsoO6Px6OXODCKwLlnQWhE5WKTvldbDWs=;
        b=Rv6Rcd4nIy0c/9OX2IOoVH4B+A50xWs2b657/qd1sZ1XHGLTwhAFUnrwsRFNYXAp6T
         5/L+umTtumo7HzFJReNJnlANeGHYtfGj4KuzPkVHw2vOJJh6MH6/Zs1Yral85uqWLJP0
         fHKlEMGZLt22GDoRtiVguw5blqSH0diQ2Q+jXFUsV5jXsXLqER0Ln/MBe9Hw6OTz94EL
         jtxWmBJl6xpuZByqswYh6QXfwBMiyRBxGwD8PShz3gmSpb+trFm1PxuYaAE93WBjBfFw
         0ZGSgq4UfDzxcaHnI4TCG7vm9qFYngx8oG0K5Eu1yNSxbwfd8MIzpVpcKUXalMf75Yla
         TWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705945418; x=1706550218;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GoxIjIov4FxsoO6Px6OXODCKwLlnQWhE5WKTvldbDWs=;
        b=ivN4z3VXsEfwlhQb/fjH+IdzpsamPgmNUSDXJ+wiNRadtxckXhNSepdn5fBiMvggfh
         YGaTeHJhZ/Hn3a1r9E+LIORLpmOymXdPEkomxEGBZdGWCyUu50jnJOjvlO048xwVR1KG
         QwirnyhtAXj9wHQYhhc7WEkNDcGxnFv2yZHyxPr5BladC7nbbJUtI5xX8HZftCsd8/ha
         hyFW0g9ka0mfFZCX2bjMvzUniojbO9Ms2+hxdhGZ3KQOzaOWNg8kXBw/3T6IvLz3YfsZ
         skVD5TI2hLozZ6zWYDn7SVAvYfedcb6dAtVjDHDK8bTcbcLZNHCf8gMFaCk8GIpmJUkV
         oWMw==
X-Gm-Message-State: AOJu0YwqLlfa9Njtlks+Nxmc8lL8QvQW39x4auWBwVnbHDw9B6FcZaqz
	SHx+spZzKtRsEdD1HqCLthlrJj6eRZoFNCfKm/xVvBhPOnE55KgUsSeCy0xcfm6ec0TVbg2stzg
	ZV9nDbFUgB5oGRl88mlzOj8umMas42WDAlVvwOA==
X-Google-Smtp-Source: AGHT+IHjNAmDzfWOjE4heRBByoeLZwDFG8zH4wGjVigmAwqPbq44ESDrHHDaV6brgae6L6vZqDzpEclP668GPt0jJlk=
X-Received: by 2002:a0d:e24d:0:b0:5ff:8466:20f0 with SMTP id
 l74-20020a0de24d000000b005ff846620f0mr3934593ywe.63.1705945417856; Mon, 22
 Jan 2024 09:43:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122143030.11904-1-quic_okukatla@quicinc.com> <20240122143030.11904-5-quic_okukatla@quicinc.com>
In-Reply-To: <20240122143030.11904-5-quic_okukatla@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 22 Jan 2024 19:43:26 +0200
Message-ID: <CAA8EJpoU=jOSERW70NBXkr5JARH+2TAL1KSb130DTcSu4EmX4w@mail.gmail.com>
Subject: Re: [4/4] arm64: dts: qcom: sc7280: Add clocks for QOS configuration
To: Odelu Kukatla <quic_okukatla@quicinc.com>
Cc: georgi.djakov@linaro.org, cros-qcom-dts-watchers@chromium.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 16:39, Odelu Kukatla <quic_okukatla@quicinc.com> wrote:
>
> Add clock handles for required clocks to be enabled for
> configuring QoS on sc7280.
>
> Change-Id: I58991300ff1d8d2865763d4e79ee81c03586249e
> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 83b5b76ba179..73acf1bd0f97 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -2099,6 +2099,8 @@
>                         reg = <0 0x016e0000 0 0x1c080>;
>                         #interconnect-cells = <2>;
>                         qcom,bcm-voters = <&apps_bcm_voter>;
> +                       clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
> +                               <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>;
>                 };
>
>                 aggre2_noc: interconnect@1700000 {
> @@ -2106,6 +2108,7 @@
>                         compatible = "qcom,sc7280-aggre2-noc";
>                         #interconnect-cells = <2>;
>                         qcom,bcm-voters = <&apps_bcm_voter>;
> +                       clocks = <&rpmhcc RPMH_IPA_CLK>;

Is there any reason to write QoS for the IPA before the IPA starts
poking around? The same question applies to aggre1 NoC.

>                 };
>
>                 mmss_noc: interconnect@1740000 {
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
>


-- 
With best wishes
Dmitry


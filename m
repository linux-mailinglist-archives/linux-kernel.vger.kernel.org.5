Return-Path: <linux-kernel+bounces-9176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A836581C1DE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48596B26228
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919797A21A;
	Thu, 21 Dec 2023 23:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xUs/D+UY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7291A7995F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 23:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6da4894a8d6so837023a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703200937; x=1703805737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlybDmShL7dZTsi3x+EewBqggHiwTM9Kr/2m+TeNB7c=;
        b=xUs/D+UYD4Nuns6GwHk1E9jeO37f2Vy5P9TKT+OgRr1DQyCbHZ4/q9Z8nedZCoFLxI
         RRsW3K4V9npbKQ7RJoiOyQECOpxEBKaSiU0ItktOPNu6W5S8B2e6Liw3mTlqOjHZPsxe
         yNz+WxtWPt69SZeb7ufbXLp5KYTH9ClFFtDNp+O388IK0SbH8T6Sy0AyhHHhUcjbd0Ev
         ltrmigtetyXcyJxhpkrn21ljoAgd8yyDX39RaLjEFz3jEOTDhPOUn7mVugNR6BpDzmF1
         k5k06vkDO+RlNg+IcA/oGMGLPy1U5UBZpeO2MVdCAposTulyFH3+kCDA7Hbutz6c6Q2A
         lSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703200937; x=1703805737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TlybDmShL7dZTsi3x+EewBqggHiwTM9Kr/2m+TeNB7c=;
        b=l1ZYwarXE7E+jpjlR6g0U31sMZrqM/+nSJvjmejn2SmTDC2p+/nlP7UN3dCA654pPr
         e6ctAgaNDik1uX7LBTCtKghTK8sxJpnFUZWW0dh5iPU4W90A3B2caSHnKtxA8Aog8wzZ
         3amXiwQaclhdeXJi0koKXAdUhe67um982B0bGPXspFeYmeEmNwxrwwfFs+ayiyciRAZg
         Aznkf6BrA+1bRmacAJ2Ama32gdA7O0MVjd0KgcDQdtWii7ymCDr0tgnKuZ9hVjC/xCZn
         yug8vOfcgwq/pTU28+WYWMvGHOsDzuZTv36KD+mTJpmCUgDzPcbkOYnZdIQYtdBIJ0bB
         KTrg==
X-Gm-Message-State: AOJu0Yxspi5bNtsov4bxRMYWX8MbLOxwUJzOZgQGED1sEf/sWfN61fZ1
	1ZEc/v1lavJequVUswkfARLTqMqAbDKDExOOnLd6hBX1LUUmxA==
X-Google-Smtp-Source: AGHT+IGs7zUqzdCT9Xyd01upCzhbYPXR4Yuwd8j//oNfpJW5nVv9WL+6qwUnigu46hKo0j07CMMh7ibsBZideIuLpP8=
X-Received: by 2002:a05:6830:44a1:b0:6d9:dbe2:5ec2 with SMTP id
 r33-20020a05683044a100b006d9dbe25ec2mr509430otv.69.1703200936971; Thu, 21 Dec
 2023 15:22:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221214822.3063219-1-olvaffe@gmail.com> <c5b28a49-cc0f-41b1-8dfb-76af93636fb0@linaro.org>
 <CAPaKu7Rx_tShhmJrwYgnZefaxy37yhms9qoXS9n07+=ohCEZ9w@mail.gmail.com>
In-Reply-To: <CAPaKu7Rx_tShhmJrwYgnZefaxy37yhms9qoXS9n07+=ohCEZ9w@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 22 Dec 2023 01:22:05 +0200
Message-ID: <CAA8EJpos2D0pjLtXR67p5G-uC9LyraVHm2H-by0h2RZgppVJ4Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: revert back to PSCI PC mode
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, cros-qcom-dts-watchers@chromium.org, 
	Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Maulik Shah <quic_mkshah@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Dec 2023 at 00:07, Chia-I Wu <olvaffe@gmail.com> wrote:
>
> On Thu, Dec 21, 2023 at 1:55=E2=80=AFPM Konrad Dybcio <konrad.dybcio@lina=
ro.org> wrote:
> >
> > On 21.12.2023 22:48, Chia-I Wu wrote:
> > > This effectively reverts 7925ca85e9561 ("arm64: dts: qcom: sc7280: Ad=
d
> > > power-domains for cpuidle states") for sc7280-herobrine.
> > >
> > > Fixes: 7925ca85e9561 ("arm64: dts: qcom: sc7280: Add power-domains fo=
r cpuidle states")
> > > Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
> > > ---
> > 0 explanations?
> Ouch.  It's in the comment
>
> + * Devices that use SC7280 with TrustedFirmware-A
> + * need PSCI PC mode instead of the OSI mode provided
> + * by Qualcomm firmware.
>
> and is similar to the case with sc7180-trogdor.  I can send v2 if necessa=
ry.

Absolutely necessary. And so does the accurate commit subject. The
existing one means that the whole SC7280 PSCI mode is reversed, while
instead you do it only for the TF-A platforms.


--=20
With best wishes
Dmitry


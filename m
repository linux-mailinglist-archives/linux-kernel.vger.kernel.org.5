Return-Path: <linux-kernel+bounces-53239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC30784A27A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E7B1F2300E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A739747A76;
	Mon,  5 Feb 2024 18:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mz2lAVhO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA503EA67;
	Mon,  5 Feb 2024 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707158227; cv=none; b=sZuhFTfvQkasA+mdI+4FPkKfltK5WqTgE2ybzbLcCXE0+Dn9s8W9e03batCJGueOEd6ouVHeZAduI4mSn+xbR6AuPJB0hdnEJxB6XY1njif4G9iAPPG+MuynAEOnsNXQLXNMz6AsLBd2Bfr7kei51KYG0VrdAtDxl7DFVS/aszc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707158227; c=relaxed/simple;
	bh=ril2mjZw5Tmfit3JBs/6rZtrfDzak390D6OdEMFzCTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HmwuWvIkOCrUjeq7V7Abt8nzY/ugUYgmYnieB7tHbH6TRDwIJ0Q2bHMI/r0Ed2k2S5yVRlVwnouCuv3fCsCulr8c2oQzp2XXhhT9xDIr9kbtdTVcGaFR5L7gcpQ00aIOCxV1wWhz/KucVZoNZQLK8u3MChickLqfAH4dQKlT8NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mz2lAVhO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A48C43394;
	Mon,  5 Feb 2024 18:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707158226;
	bh=ril2mjZw5Tmfit3JBs/6rZtrfDzak390D6OdEMFzCTY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mz2lAVhOIlwI+4wB/NVzBZtNzy3hVoLPol+OJX3UyjRvBwlwZL9MsvDrDBZ/41K+i
	 hbsdSEryR640VyZfB3Ds02wPJsKxRQJzGfDa7mNHK1PG/MWUtYAREVpA30AOIwANf4
	 5lXv2Q5mVpK4LIHT1WmwxuCa18r4bLxLSYRoTcQkpSrQx5lntSlMdE7b9WLbt1Icg6
	 iaKT9VCFBBWAl20NYgzjtNCsenRrKTC4U9zZ9aZZbDgE+3bnyMR/9y/bzM/uFl+qaT
	 5ZoO12U0bq5771cDCfV7HSn5BOmmKe9Kkd6E+n7FW59RfdvSqDotrM5rbqfLvw81GK
	 ru+aPoxUvf6ug==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5112a04c7acso7643543e87.3;
        Mon, 05 Feb 2024 10:37:06 -0800 (PST)
X-Gm-Message-State: AOJu0YyEJ87A7r3FWbUR036E8PGdQtYL22EibhW4f2dZ+seCCJ2Rbp0D
	hUzuYeWwAY96/Ol+I32nWbFptqHZ5ncOngY9woyzAZW/24C7eGLZomKT06En9uIVNmalaDN81/1
	3fC5gaWUBNOSRkZMGgp1z6OQlGQ==
X-Google-Smtp-Source: AGHT+IFLhqaDldx2J/zwVTLy2bXBhYfBWSmTcNJzhsZJZXwWmsKPuubHGJZmQXSA9B4FmBD2VULodz3rrgOrIHfHrtI=
X-Received: by 2002:ac2:4c93:0:b0:511:33d4:c99a with SMTP id
 d19-20020ac24c93000000b0051133d4c99amr302024lfl.61.1707158224608; Mon, 05 Feb
 2024 10:37:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202171915.4101842-1-quic_jhugo@quicinc.com> <20240205183338.GA3905881-robh@kernel.org>
In-Reply-To: <20240205183338.GA3905881-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 5 Feb 2024 18:36:51 +0000
X-Gmail-Original-Message-ID: <CAL_JsqJvW7fWyCXt6UfNkJwezY27Ezkx4UWA=d5ecGrRS=8Q-w@mail.gmail.com>
Message-ID: <CAL_JsqJvW7fWyCXt6UfNkJwezY27Ezkx4UWA=d5ecGrRS=8Q-w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: clock: qcom: Fix @codeaurora email in Q6SSTOP
To: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com, 
	sboyd@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 6:34=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Feb 02, 2024 at 10:19:15AM -0700, Jeffrey Hugo wrote:
> > The servers for the @codeaurora domain are long retired and any message=
s
> > addressed there will bounce.  Govind Singh has left the company which
> > appears to leave the Q6SSTOP clock controller binding unmaintained.
> >
> > Move maintenance of the binding to the Qualcomm Clock Drivers maintaine=
r
> > as suggested by Bjorn Andersson.
> >
> > Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> > ---
> >  Documentation/devicetree/bindings/clock/qcom,q6sstopcc.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> How about the rest of the tree?:
>
> Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml:  - Sa=
ndeep Panda <spanda@codeaurora.org
> >
> Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml:  -=
 Harigovindan P <harigovi@codeauro
> ra.org>
> Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml:  - Odelu K=
ukatla <okukatla@codeaurora.org>
> Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml:  - Kiran=
 Gunda <kgunda@codeaurora.org>
> Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml: =
 - Balakrishna Godavarthi <bgodava
> r@codeaurora.org>
> Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml: =
 - Rocky Liao <rjliao@codeaurora.o
> rg>
> Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml:  - Shyam Kum=
ar Thella <sthella@codeaurora.org>
> Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml:  - =
Srinivasa Rao Mandadapu <srivasam@
> codeaurora.org>
> Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml:  - Sai Prakash =
Ranjan <saiprakash.ranjan@codeauro
> ra.org>

Nevermind, I see the other patches now. BTW, this kind of thing you
can just send me 1 patch fixing them all. Split is fine too.

Rob


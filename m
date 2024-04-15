Return-Path: <linux-kernel+bounces-145647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BE58A58F0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300581F21570
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F9D839F8;
	Mon, 15 Apr 2024 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiOTkWnp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E2E823CE;
	Mon, 15 Apr 2024 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713201371; cv=none; b=szLdx2hNpgFCKJoSWsVcWU7fjGfX/X+fyEQguhbBENmnrh8QlObUICyYkrUY4rdgyNzdoF6SKPkhFa7vwFZb2liOnW+qVbF6SltvCvOeF5TnlvKP4I7c2WRMBfRkrCtH8ipP/uJ2liSBultkZk76mHpkKugwLzZRmWqQD2EN+qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713201371; c=relaxed/simple;
	bh=clBNt8e+6YrryyfPUqSdkx19pn4NeG8mB3JuyFyvw8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NeoRQS4+1VWZGQaxkttmoayKJTCQ99qSRnmyiETe5RZsG7pOzD+QCtVzf34FYJoFPp6OP8A1wczJdoUe4huUTnndozeK1yPl7kN69wjRLBGAPWDQmu/Cq2CUTan3zVpHLItg4or6h0yjV4E7uJokUg3xBVkUSw15oo/fluqXFl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiOTkWnp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A954EC113CC;
	Mon, 15 Apr 2024 17:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713201370;
	bh=clBNt8e+6YrryyfPUqSdkx19pn4NeG8mB3JuyFyvw8c=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=XiOTkWnpcikqzTLyG6q9HC8Yf1PFVtG1Dl1eBbOi2IQPINtjXOmksWhu/RyIA2nGG
	 bmfF3V54qeEX3IpXHIifv7E8ENg+5KnL+R8XaMweuzKjaDZ+inUH75nRkchBFJ1zJq
	 xcTNnQcKQAuY4CWnXeFDu9TkH67PCScmY0LNAtw8O/Y/6hMMHDk+5vuRw0Dcflmngp
	 Kn8kt8tslfLQjLc6fW/IUrtxp/l8xiJ4QnD1DBJyJ/H+QxkGzB/5YdqlSj8EGtAe+y
	 BOsg3L4kIx2VJCEoF7I/XvN6Kpyx1JSr0+stmnA4mSlqoXHDJFrvLCS6HtZhkO5Ava
	 W/HB1Pjdv6YXQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d8a24f8a3cso37406801fa.1;
        Mon, 15 Apr 2024 10:16:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVtgrD9Ee4Gs7uek7S6oZXqfcqDL8EbFEFm8uuIPsLywL7F2gxfIC2JUVq5j4aXh7B+7RSMwm4Fon5P0/zk1DltnKfOBUK4mpCQ9Lnt8Ih/7WoiAOnqVWv6zbDetYrpLiA7z0u5yGAG94n682Gr9stWZNkETBXJ7KaweLd+X6GdAA+qB8t/gED2lITMkyfjr27xdApsaKfgyJUJrWMwgQ+OMAWLL8+BxY6YA+SIKiTvEs/TggfLVYXs9HJuWehlB+qGOYzX2Qof
X-Gm-Message-State: AOJu0YwlsbdI2ACHPYECCetGl46h480TfpGkge66wzN+0/d7A3Vhr5ZX
	D+ix7O1b1Ufsks5UTSXJUIu/dGWrEHzfR/7YnwYCUi+HBPixwfB7nMr5qBV+niEvSQpUvY72Xwl
	lIV6lBTUoNuKjp2CXM44U2Yy+sg==
X-Google-Smtp-Source: AGHT+IEkz26w525DUde0Uob20fmQI4fd4Chc0AN6DRGivhpSGWQdBtr0Y20V2JMzBwteB/hWf3vT168YMa0bRGYd8lo=
X-Received: by 2002:ac2:41c6:0:b0:516:7738:bd5c with SMTP id
 d6-20020ac241c6000000b005167738bd5cmr6496177lfi.4.1713201348179; Mon, 15 Apr
 2024 10:15:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412222857.3873079-1-robh@kernel.org> <Zh0vXinxy7woerJQ@hu-bjorande-lv.qualcomm.com>
 <CAA8EJpqL2T4bJZqtZ9KF=V2NLnFxUjouA6_Hu_H07DofifZaoQ@mail.gmail.com> <CAL_Jsq+q3OLEMT=d8=d9o1D9deKGQ5TAtZg_bgptDPQ1cWcctw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+q3OLEMT=d8=d9o1D9deKGQ5TAtZg_bgptDPQ1cWcctw@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 15 Apr 2024 12:15:34 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKSz_WVTTi7+AgjgDzXAnAqaxXM3i2NUv93nZSpyuZK5g@mail.gmail.com>
Message-ID: <CAL_JsqKSz_WVTTi7+AgjgDzXAnAqaxXM3i2NUv93nZSpyuZK5g@mail.gmail.com>
Subject: Re: [PATCH] arm/arm64: dts: Drop "arm,armv8-pmuv3" compatible usage
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>, soc@kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Dinh Nguyen <dinguyen@kernel.org>, 
	Tsahee Zidenberg <tsahee@annapurnalabs.com>, Antoine Tenart <atenart@kernel.org>, 
	Khuong Dinh <khuong@os.amperecomputing.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Robert Richter <rric@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, "Paul J. Murphy" <paul.j.murphy@intel.com>, 
	Daniele Alessandrelli <daniele.alessandrelli@intel.com>, Andrew Lunn <andrew@lunn.ch>, 
	Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Heiko Stuebner <heiko@sntech.de>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com, 
	Michal Simek <michal.simek@amd.com>, devicetree@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-realtek-soc@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 12:05=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Mon, Apr 15, 2024 at 11:52=E2=80=AFAM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Mon, 15 Apr 2024 at 16:46, Bjorn Andersson <quic_bjorande@quicinc.co=
m> wrote:
> > >
> > > On Fri, Apr 12, 2024 at 05:28:51PM -0500, Rob Herring wrote:
> > > [..]
> > > >  arch/arm64/boot/dts/qcom/qcm2290.dtsi                | 2 +-
> > > >  arch/arm64/boot/dts/qcom/qdu1000.dtsi                | 2 +-
> > > >  arch/arm64/boot/dts/qcom/sdm630.dtsi                 | 2 +-
> > > >  arch/arm64/boot/dts/qcom/sdx75.dtsi                  | 2 +-
> > >
> > > Acked-by: Bjorn Andersson <andersson@kernel.org>
> >
> > Note, we'd need to override PMU compatibles in sdm636.dtsi and
> > sdm660.dtsi. Ideally it should come as the same patch.
>
> Uh, that's an A for reuse, but an F for readability... It's sdm632 as
> well. Will drop sdm630.

Actually, aren't those Kryo cores just Cortex-A53 derivatives? So the
A53 PMU compatible is an improvement over the generic one still. We
can't just add kryo260-pmu compatibles because that breaks
compatibility. We could have a fallback, but then that introduces a
pattern we don't want.

Rob


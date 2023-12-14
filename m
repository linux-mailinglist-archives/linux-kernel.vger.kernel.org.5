Return-Path: <linux-kernel+bounces-181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5608813D24
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812BF1F2275A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7042C689;
	Thu, 14 Dec 2023 22:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuHgemc/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B7B2C68C;
	Thu, 14 Dec 2023 22:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845EFC433CD;
	Thu, 14 Dec 2023 22:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702592442;
	bh=DLrciHpGY/Tr+KDhmgFsHpodGdAyv9347IqpzcQxN0E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QuHgemc/eGs8haslapsQfMlcL+SJKh/2Xkj9g3QjaPcNuqzC8IWQRs/V6rEVsZiIv
	 LnzLfQTFWKNWM+7/ZObc+6o4ZRqg4NTZJhX60pJ5mHsQMn3EG04kGRZy1ccnAiux4M
	 BbBVLJeJrNzckEWKZv3yiatDKAG428GX/bkOp6W9Yb9+qY0DStkTuHKYBOrVF6ZPTc
	 IX6dRKutdX5tij9PkNcXKB4PMeV8xfy2B0zgG3rzr3dwjvoOnOkZ7JWbPHqVmUEJxY
	 3S17UtGir9Baa0Jpj3ZSPIIf9oppe7Yc3bS5+VJoneicorjDh+YiyKfdCq47JMIc1v
	 1Y1/grdMFxhXQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50bdec453c8so10211463e87.3;
        Thu, 14 Dec 2023 14:20:42 -0800 (PST)
X-Gm-Message-State: AOJu0YxhLRUyRuCp3hR/amJKTRH4nQgq6woqV1/RBCiMUGhRjpK+P1Lt
	pdR7Ejn36U7E9Q4Q8SBdlXXsYIhSmbeEzTj1hQ==
X-Google-Smtp-Source: AGHT+IGv5JFi0lNuAs8VuSZYhhQ038anhXHkFFHu9EfV9TuthpQBAyp6VCuGwuNxaswRwh/ZuAYrqL6Y8WdKhTnUgEM=
X-Received: by 2002:a05:6512:4847:b0:50a:a5f7:47fb with SMTP id
 ep7-20020a056512484700b0050aa5f747fbmr4457434lfb.49.1702592440674; Thu, 14
 Dec 2023 14:20:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213110009.v1.1.Ifd0903f1c351e84376d71dbdadbd43931197f5ea@changeid>
 <20231213110009.v1.2.I274b2d2255eb539cc9d251c9d65a385cc4014c79@changeid>
 <20231213221124.GB2115075-robh@kernel.org> <CANg-bXCG61HFW7JFuAd3k+OrCG_F9F3e8brjM-pmBauS53aobQ@mail.gmail.com>
In-Reply-To: <CANg-bXCG61HFW7JFuAd3k+OrCG_F9F3e8brjM-pmBauS53aobQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 14 Dec 2023 16:20:27 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+MYwOG40X26cYmO9EkZ9xqWrXDi03MaRfxnV-+VGkXWQ@mail.gmail.com>
Message-ID: <CAL_Jsq+MYwOG40X26cYmO9EkZ9xqWrXDi03MaRfxnV-+VGkXWQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] arm: arm64: dts: Enable cros-ec-spi as wake source
To: Mark Hasemeyer <markhas@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Raul Rangel <rrangel@chromium.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Andre Przywara <andre.przywara@arm.com>, 
	Andy Gross <agross@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Baruch Siach <baruch@tkos.co.il>, 
	Bjorn Andersson <andersson@kernel.org>, Claudiu Beznea <claudiu.beznea@microchip.com>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Jesper Nilsson <jesper.nilsson@axis.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Michal Simek <michal.simek@amd.com>, 
	Paul Barker <paul.barker@sancloud.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Thierry Reding <thierry.reding@gmail.com>, cros-qcom-dts-watchers@chromium.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 3:04=E2=80=AFPM Mark Hasemeyer <markhas@chromium.or=
g> wrote:
>
> > If a device knows it is wakeup capable, why do you need a property too?
>
> I'm referencing:
> https://www.kernel.org/doc/Documentation/devicetree/bindings/power/wakeup=
-source.txt
> "Nodes that describe devices which has wakeup capability must contain
> an "wakeup-source" boolean property."

That's probably too strongly worded because wakeup capable devices
existed (and still exist) before this binding was created. Powerpc for
example doesn't use it.

> Currently the driver assumes the device is wake capable without
> parsing the device tree, which is an incorrect assumption as wake
> capability should not be enabled on some cros_ec systems.
>
> > I haven't looked closely enough, but it smells like after patch 6, thes=
e
> > properties would be required for wakeup? That would be an ABI break.
>
> Agreed. In this case, the driver is a ChromeOS related driver and DTS
> is built from source for each OS update.
> For more context, I will make sure to CC you (and everyone else) and
> include a cover letter in the next series version.

Please explain in the patches with an ABI break why it doesn't matter.

Rob


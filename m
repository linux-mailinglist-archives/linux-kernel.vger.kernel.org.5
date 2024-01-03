Return-Path: <linux-kernel+bounces-15687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D7D82304B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6199285DD1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9526B1B296;
	Wed,  3 Jan 2024 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBH/QuA3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3561B290;
	Wed,  3 Jan 2024 15:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53746C433CC;
	Wed,  3 Jan 2024 15:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704294911;
	bh=ldRoSHvT6Rsry6/JCGChzrHz1I65uNFCAGV5UUxFlGA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IBH/QuA3Eycfx0gIQnxzlatxLaXul9m7My77lsHmfTkfYNeF2R35sxVYcFG0qYDGz
	 Q2iFfwWqCBl3NgMeZtXwVmpGWCNbLQrkdM0GRQlC93esLlCTFu6U66mTgGhgug0Kcv
	 jFjCSnPbSFL9OlRN51iSaJlvh1uHcR7qdrwMV/pdymLkbQ5YDBMVvS9Ze5qwochBmV
	 qV6Xw2hM0zEWHyDmy3HuZsuU1ynBjHnGM1PnPCb2UuY5nlXrgjwXcSafGbSdPnI6Z8
	 8+Y2X5cpolzxxxFBMG8Xq2OhIkh6uZ+ziQbhdUODDuGMS0j0h4nkOueGMPGO3GH1uA
	 71+1Qu//CUDkQ==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cce6bb9b48so53150141fa.1;
        Wed, 03 Jan 2024 07:15:11 -0800 (PST)
X-Gm-Message-State: AOJu0YzHIzN5G4odunC0wl0jkOjn2AvX5fVy/ankt0xHJz4MyNP2ShDb
	aEVI6ULa9RCvKy04uOlcB/vAeA/3ja5kY2b3iQ==
X-Google-Smtp-Source: AGHT+IFqtORKMYmea6Sua/HpDIR+OhSvzO5v/pjx+rnHnj7+cZmrhfeXvNjnLi75WlD7c7NCdkjTTKvfobADQjhDnlM=
X-Received: by 2002:a2e:9c14:0:b0:2cc:6666:168d with SMTP id
 s20-20020a2e9c14000000b002cc6666168dmr3813403lji.69.1704294909538; Wed, 03
 Jan 2024 07:15:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103142051.111717-1-krzysztof.kozlowski@linaro.org> <20240103142051.111717-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240103142051.111717-2-krzysztof.kozlowski@linaro.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 3 Jan 2024 08:14:57 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKBANb+SKfykPvUH82bGH6sU5LuCfsM5iSbZ6Uk4vKHrw@mail.gmail.com>
Message-ID: <CAL_JsqKBANb+SKfykPvUH82bGH6sU5LuCfsM5iSbZ6Uk4vKHrw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: juno: fix thermal zone node names
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Amit Kucheria <amit.kucheria@linaro.org>, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 7:21=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Linux kernel uses thermal zone node name during registering thermal
> zones and has a hard-coded limit of 20 characters, including terminating
> NUL byte.  Exceeding the limit will cause failure to configure thermal
> zone.
>
> Reported-by: Rob Herring <robh@kernel.org>
> Closes: https://lore.kernel.org/all/CAL_JsqKogbT_4DPd1n94xqeHaU_J8ve5K09W=
OyVsRX3jxxUW3w@mail.gmail.com/
> Fixes: fb4d25d7a33f ("arm64: dts: juno: Align thermal zone names with bin=
dings")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/arm/juno-base.dtsi | 4 ++--
>  arch/arm64/boot/dts/arm/juno-scmi.dtsi | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>


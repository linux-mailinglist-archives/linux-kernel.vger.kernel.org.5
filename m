Return-Path: <linux-kernel+bounces-137400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE6E89E183
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47B21F23CD7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED275156233;
	Tue,  9 Apr 2024 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOXtDKhU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373E7155A45;
	Tue,  9 Apr 2024 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712683626; cv=none; b=BXdNrSoUbRnOmPJxagfxuKpjvzQnFKep793aUs+9AfoIFFM8dpSeryDONK1aAMZ6MHpcG8WKzX+8drg7IYqhRbRbczflXws8po7Ux3gdNHSWrWySC+qa4Lx/0xaUk6WmD9BggOnwh+pD8xkphHPfLPA8nbLpx5K77THb04CONJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712683626; c=relaxed/simple;
	bh=Kbut6EHysiAuN2pqwbI1Q3ysmlqsWX1b/pEAFMnt+eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HiPP0NX/K2RcK3B2AqNgeyz21DFPFYq0jI8MlFWrtEf/HfsuB+9gW81Gb59iPU20uZKLYJMdDt4A2maugis6zjEU3n6dVarXvyIrG+O5nmY+KJH6q/Z3u6D6+T8rj4LqqioABwqOnb5+HPFRMGS1oKlCP5VYNP73cAuJoNipuII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOXtDKhU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6636C433C7;
	Tue,  9 Apr 2024 17:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712683625;
	bh=Kbut6EHysiAuN2pqwbI1Q3ysmlqsWX1b/pEAFMnt+eg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MOXtDKhUSuGy06O0wOHEzMRUsMEx1PIpgQJfGYxuWXcCM0Hi03dVimVFkMGIujRJ3
	 nnf9k4pl9WHvRGO24qbpJYe5cQPMAlNzXQnqaC5yB23mArWmjYIwoTLkAe3pHeAij7
	 bVG/W9agnm3h+ORu1i468Ml2zhUUaDQ23Yr1D4nJprQjvE1GV6xLqsfRHLIKOfK+3q
	 5WbVRukqkcBpuL0jIA799KCPPHH3S8qo1NW+hOFq4D1e/TJ7DFYKieiv1xGAljJsFj
	 KNdM3guD0TBs5LxYi9iL3llXOJVY7wDUyizpGSx2sSGYlAGQpTxPcJT7ZnjWoES55A
	 YlEg8mZ22GnFQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51381021af1so9546528e87.0;
        Tue, 09 Apr 2024 10:27:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4YrIlbxcpcD0Cqj4P1qr3fD3Zr96Bw1tsxsn9qcj1xdfx30Ri6i44HHNkXM9XETGq9owZIpSd705nmBhpPNc1WVfmIa47msYn4HNvpvmYNfrkxGHJKXNaSDyAflgbEHoYX8nTaY8T5Vr7+b6JZEe7h3tj5HEyHZeWipO55NsGb7Uqq1Cr
X-Gm-Message-State: AOJu0YwLZFUlp0T+ZO/p4mawkGTHJdfdz/g3UsYFgFBNG0LdENfRz0/b
	9RNrYaCPx5RvAch1Kq4ELIDFb+062mDsnDg4SShMLvSLoHNTSs1OtJzfC6CUvqaRWelyqKX5mRW
	PjAIbL3fRFzv7onp4eakz3+VqUw==
X-Google-Smtp-Source: AGHT+IEHcM0JD7ZqWipo4LWrXKbnA82iD02tShlGX9cvVnQUGGgSKaw7D46ABppnjB6v8ynWM6ZkjO5amGWWIwt6rYg=
X-Received: by 2002:ac2:4c35:0:b0:516:9fab:75de with SMTP id
 u21-20020ac24c35000000b005169fab75demr55819lfq.5.1712683624187; Tue, 09 Apr
 2024 10:27:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322145406.2613256-1-Frank.Li@nxp.com>
In-Reply-To: <20240322145406.2613256-1-Frank.Li@nxp.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 9 Apr 2024 12:26:52 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLJDhJd_uoL05Z=s3Mc7PRkcJWsQGGjdG0Q0GFp0zA8xw@mail.gmail.com>
Message-ID: <CAL_JsqLJDhJd_uoL05Z=s3Mc7PRkcJWsQGGjdG0Q0GFp0zA8xw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ASoC: dt-bindings: fsl-esai: Convert fsl,esai.txt
 to yaml
To: Frank Li <Frank.Li@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shengjiu Wang <shengjiu.wang@nxp.com>, 
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 9:54=E2=80=AFAM Frank Li <Frank.Li@nxp.com> wrote:
>
> Convert fsl,esai.txt to yaml. So DTB_CHECK tools can verify dts file abou=
t
> esai part.
>
> clock-names 'spba' is optional according to description. So minItems of
> clocks and clock-names is 3.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>
> Notes:
>     Change from v1 to v2
>     - alphabetical order compatible string according to rob's suggestion
>     - clock description move under 'clock' according to kryszof's suggest=
ion
>     - fix descritpion indent according to rob's suggestion
>
>     Pass dt_binding check
>      make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- -j8  dt_binding=
_check DT_SCHEMA_FILES=3Dfsl,esai.yaml
>       DTEX    Documentation/devicetree/bindings/sound/fsl,esai.example.dt=
s
>       LINT    Documentation/devicetree/bindings
>       CHKDT   Documentation/devicetree/bindings/processed-schema.json
>       SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>       DTC_CHK Documentation/devicetree/bindings/sound/fsl,esai.example.dt=
b

Did you run dtbs_check too? Probably not arm32 at least (first number
is number of warnings):

    218  esai@2024000: clocks: [[2, 208], [2, 209], [2, 118], [2,
208], [2, 156]] is too long
    218  esai@2024000: clock-names:3: 'spba' was expected
    218  esai@2024000: clock-names:2: 'fsys' was expected
    218  esai@2024000: clock-names:1: 'extal' was expected
    218  esai@2024000: clock-names: ['core', 'mem', 'extal', 'fsys',
'spba'] is too long

Conversions can leave warnings, but any you think should be fixed in
the binding should be fixed in the conversion.

Rob


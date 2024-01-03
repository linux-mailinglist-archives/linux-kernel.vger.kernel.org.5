Return-Path: <linux-kernel+bounces-15980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ECF823687
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65496286152
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391951DA39;
	Wed,  3 Jan 2024 20:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLH2wcCX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE441DA50;
	Wed,  3 Jan 2024 20:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF902C433C7;
	Wed,  3 Jan 2024 20:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704313388;
	bh=/1wi2elESu3qA3ymnpBhXxm3Cm+EGVj4BLX3l9jDeR4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BLH2wcCXsSl2DovBkC7X1OYo1n2t+AVRmYKhft/A+OqHrwxapT4fJZm2g5gGobnQe
	 uO5JM6ufEggqRjmBTKVvIxwG5XLviwmeZ/AZLV9AMtIVPxNZwE2g6JXG9P+1EQfaTU
	 IFRHlrkoEv2QUfQeASwRkwcfM4QqEklPW1/Lhw/SkKSJEuwTO5ObThdkYq2gRG3Gw8
	 ua0kVLNPAn9E67u+OUEhegv69kgs47HPCj35fqOQCZIrT0BFTl/Xz9T9buqi3pzXMU
	 8tIyCNLx/F+7CSNWOKpFKjeXFH/lBNvgXJZreUupf4tUc0Z82iD0N8+GY+fVRJlcLJ
	 iQahrI1SeoUsA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cca5e7b390so110391391fa.3;
        Wed, 03 Jan 2024 12:23:07 -0800 (PST)
X-Gm-Message-State: AOJu0YyYfXwCsecXYbmxrP6O1PG+yYuuWdQIa847aQt9wIY5okSU2RWf
	yP1Ei/uq/ZAZ7auRD90h8cxOMYOcOX8t+3+B6g==
X-Google-Smtp-Source: AGHT+IEuSajsLar5BZfyKxFsEncrEL3hHHCChs5bYkTvb/M8kfLvaIglHefhLNG4QxD4FygqIsE6WgfNNyRsASBkyD0=
X-Received: by 2002:a2e:9684:0:b0:2cc:7d41:548c with SMTP id
 q4-20020a2e9684000000b002cc7d41548cmr8632506lji.54.1704313386193; Wed, 03 Jan
 2024 12:23:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9d7e85914eb1cdb313b28cb019093a84dd9b4773.1703167505.git.michal.simek@amd.com>
 <de6370c5-5cd1-409a-8716-99dd7738d30d@linaro.org> <08546f36-9f88-4fd9-ba4e-5d6ee21cd60f@amd.com>
In-Reply-To: <08546f36-9f88-4fd9-ba4e-5d6ee21cd60f@amd.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 3 Jan 2024 13:22:43 -0700
X-Gmail-Original-Message-ID: <CAL_Jsq+yPHT3VRVzNh1NY03KUoKvN41zzQKtqYvxxGjvv754Zw@mail.gmail.com>
Message-ID: <CAL_Jsq+yPHT3VRVzNh1NY03KUoKvN41zzQKtqYvxxGjvv754Zw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: Describe ARM dcc interface
To: Michal Simek <michal.simek@amd.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-kernel@vger.kernel.org, 
	monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com, 
	Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, devicetree@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 8:32=E2=80=AFAM Michal Simek <michal.simek@amd.com> =
wrote:
>
>
>
> On 12/22/23 09:20, Krzysztof Kozlowski wrote:
> > On 21/12/2023 15:05, Michal Simek wrote:
> >> Debug Communication Channel (DCC) provides the way how to pass data be=
tween
> >> target CPU and host via JTAG interface. Every CPU has own interface fo=
r
> >> communication via dbgdtrtx_el0 and dbgdtrrx_el0 registers.
> >>
> >> Signed-off-by: Michal Simek <michal.simek@amd.com>
> >> ---
> >>
> >> This communication interface is used for flash programming on Xilinx
> >> SOCs from U-Boot.
> >> https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/serial/arm_=
dcc.c
> >>
> >> ---
> >>   .../devicetree/bindings/serial/arm,dcc.yaml   | 30 +++++++++++++++++=
++
> >>   1 file changed, 30 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/serial/arm,dcc.=
yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/serial/arm,dcc.yaml b/D=
ocumentation/devicetree/bindings/serial/arm,dcc.yaml
> >> new file mode 100644
> >> index 000000000000..fd0589356617
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/serial/arm,dcc.yaml
> >> @@ -0,0 +1,30 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/serial/arm,dcc.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: ARM DCC (Data communication channel) serial emulation
> >> +
> >> +maintainers:
> >> +  - Michal Simek <michal.simek@amd.com>
> >> +
> >> +description: |
> >> +  ARM DCC (Data communication channel) serial emulation interface ava=
ilable
> >> +  via JTAG can be also used as one of serial line tightly coupled wit=
h every
> >> +  ARM CPU available in the system.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: arm,dcc
> >> +
> >> +required:
> >> +  - compatible
> >
> > no allOf: with $ref to serial.yaml? Does it differ somehow?
>
> Valid one could be only nodename format and maybe label.
> Others are not relevant. But if that's fine I can also add it.

Yeah, I think serial.yaml mostly doesn't apply here. Not really worth
including for just the node name.

Greg may have already processed this, so you might want to resend. Or
wait a few days and I'll just apply it.

Rob


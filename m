Return-Path: <linux-kernel+bounces-117990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 055A188B20F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83D3F1F3E6C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF4C5EE80;
	Mon, 25 Mar 2024 20:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwA6OjC6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CA25C61A;
	Mon, 25 Mar 2024 20:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400047; cv=none; b=EzQjJ9coAxykYvL/mBtedwDuCbm1bXPvE/Y67al/0/iI9WMqdcAut85hKpfYTduc0F9rGfG7pzEe4c51wNCtvuWca6V87bhKMiCPxomZ++4IOp6waN82ubBYNJJh3Tyd0RdOAdmyyHy2U6wnmZOEG3mWvl7275NCz2P12MwfHZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400047; c=relaxed/simple;
	bh=9C8mX0Sn8bD6Hlp2PGlk47N5EtGWqTTT35zwy1vMM/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KlmPampOuByCO6wl10VfJqPpCkZ00zwyUYKserrK5CEp83BhZxFjlLThUTD3wDFgIAOJI2s9QaLKZUTiKj7F8NGij86AEYjCVFd3pR6ZThWIQZr8cHMDdlGlKilZWYgQDYnO/SHR/TrMY6EIMStTCFOxsaq9VSsJ83smZ7cgdPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwA6OjC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF9AC43609;
	Mon, 25 Mar 2024 20:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711400046;
	bh=9C8mX0Sn8bD6Hlp2PGlk47N5EtGWqTTT35zwy1vMM/8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KwA6OjC6kS7NV4mny7t0anve5yezcA9gHGnG0+QBB3qOWPGErzfBZStoXLBg25km5
	 34oeL4NmVasFpVxJP9mI4dyLdmyV1RCDk7bPNMDUhMcgUGUJFMz3IOrz2zfoKmfKWV
	 tZTQ/gz0S97oC7Ep7xnjvFEps2ytyFxpN314XnB+DjmDV91IQxuIQaIo4WdT7yuZLF
	 hU+P6h8JTg/1PxpKh4h/YqEK7s1kFinJIhe+CWQMWWzKFtbpfs3hY4v4jOFifKvO00
	 bBbrmuQtb50X8oYWzEwHWQETNMbBlXjCvo2qVrYBpDaJI2xnOKuqWPppPflvp2zJYx
	 tonE2+1i/EbWw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513dc9d6938so6038052e87.2;
        Mon, 25 Mar 2024 13:54:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXjA2qNiMoi+upOOHm/GrhMwITMC2eLMP2ApuIfNwMHRKCPaeeg0+CyclTqrW8DGJ4ERPaiUe47TNMP3K96+Uf8TAbXvprtAGNSHOBYiPLbicXGQsoBFbJpSdhbQq9mlk9uXd6O3OiUmg==
X-Gm-Message-State: AOJu0Yx9EK3h49dk/NRFEO5w1MavfDGqYjE3vI0Uamt5GqlGOeOsDxWX
	bmZRe4/BFonZi69Re31Rnxy3Jp0fo23tUIklfOsb8EChYYaDkjam/C2T1Qld70l39b0bdRJEfVv
	Gm8dmLY1EKQhnvAkr4Dv4O1OYTA==
X-Google-Smtp-Source: AGHT+IGTbH9QEnxsUF+g0cge9suFlGFw+bMh5s/tISFaAF52hjs7iTkFjNsCLSrhGK9FRt8/U9kUQM0J93ZdPlGIGe8=
X-Received: by 2002:a19:431a:0:b0:513:cffc:e74 with SMTP id
 q26-20020a19431a000000b00513cffc0e74mr4954881lfa.52.1711400044805; Mon, 25
 Mar 2024 13:54:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325195306.13133-1-sudanl@amazon.com> <20240325195306.13133-4-sudanl@amazon.com>
In-Reply-To: <20240325195306.13133-4-sudanl@amazon.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 25 Mar 2024 15:53:52 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKYXk7V4bFHCfhaD_DtetxQR3Z3SwHKJehuH_Br3YOKUw@mail.gmail.com>
Message-ID: <CAL_JsqKYXk7V4bFHCfhaD_DtetxQR3Z3SwHKJehuH_Br3YOKUw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: rng: Add vmgenid support
To: Sudan Landge <sudanl@amazon.com>
Cc: tytso@mit.edu, Jason@zx2c4.com, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com, 
	thomas.lendacky@amd.com, dan.j.williams@intel.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, graf@amazon.de, dwmw@amazon.co.uk, 
	bchalios@amazon.es, xmarcalx@amazon.co.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 2:53=E2=80=AFPM Sudan Landge <sudanl@amazon.com> wr=
ote:
>

Please give time for discussions on prior versions to finish and
others to comment. We're not all in one timezone and are busy. I've
replied there too.

> Virtual Machine Generation ID driver was introduced in commit af6b54e2b5b=
a
> ("virt: vmgenid: notify RNG of VM fork and supply generation ID"), as an
> ACPI only device.
>
> VMGenID specification http://go.microsoft.com/fwlink/?LinkId=3D260709 def=
ines
> a mechanism for the BIOS/hypervisors to communicate to the virtual machin=
e
> that it is executed with a different configuration (e.g. snapshot executi=
on
> or creation from a template).
> The guest operating system can use the notification for various purposes
> such as re-initializing its random number generator etc.
>
> As per the specs, hypervisor should provide a globally unique identified,
> or GUID via ACPI.
>
> This patch tries to mimic the mechanism to provide the same functionality
> which is for a hypervisor/BIOS to notify the virtual machine when it is
> executed with a different configuration.
>
> As part of this support the devicetree bindings requires the hypervisors =
or
> BIOS to provide a memory address which holds the GUID and an IRQ which is
> used to notify when there is a change in the GUID.
> The memory exposed in the DT should follow the rules defined in the
> vmgenid spec mentioned above.
>
> *Reason for this change*:
> Chosing ACPI or devicetree is an intrinsic part of an hypervisor design.
> Without going into details of why a hypervisor would chose DT over ACPI,
> we would like to highlight that the hypervisors that have chose devicetre=
e
> and now want to make use of the vmgenid functionality cannot do so today
> because vmgenid is an ACPI only device.
> This forces these hypervisors to change their design which could have
> undesirable impacts on their use-cases, test-scenarios etc.
>
> The point of vmgenid is to provide a mechanism to discover a GUID when
> the execution state of a virtual machine changes and the simplest
> way to do it is pass a memory location and an interrupt via devicetree.
> It would complicate things unnecessarily if instead of using devicetree,
> we try to implement a new protocol or modify other protocols to somehow
> provide the same functionility.
>
> We believe that adding a devicetree binding for vmgenid is a simpler,
> better alternative to provide the same functionality and will allow
> such hypervisors as mentioned above to continue using devicetree.
>
> More references to vmgenid specs:
>  - https://www.qemu.org/docs/master/specs/vmgenid.html
>  - https://learn.microsoft.com/en-us/windows/win32/hyperv_v2/virtual-
> machine-generation-identifier
>
> Signed-off-by: Sudan Landge <sudanl@amazon.com>
> ---
>  .../devicetree/bindings/rng/vmgenid.yaml      | 58 +++++++++++++++++++

Filename should match the compatible, whatever that ends up being.

>  MAINTAINERS                                   |  1 +
>  2 files changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rng/vmgenid.yaml
>
> diff --git a/Documentation/devicetree/bindings/rng/vmgenid.yaml b/Documen=
tation/devicetree/bindings/rng/vmgenid.yaml
> new file mode 100644
> index 000000000000..24643080d6b0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rng/vmgenid.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rng/vmgenid.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Virtual Machine Generation Counter ID device
> +
> +maintainers:
> +  - Jason A. Donenfeld <Jason@zx2c4.com>
> +
> +description:
> +  Firmwares or hypervisors can use this devicetree to describe
> +  interrupts and the shared resources to inject a Virtual Machine Genera=
tion
> +  counter.
> +
> +properties:
> +  compatible:
> +    const: virtual,vmgenctr
> +
> +
> +  "#interrupt-cells":
> +    const: 3
> +    description:
> +      The 1st cell is the interrupt type.
> +      The 2nd cell contains the interrupt number for the interrupt type.
> +      The 3rd cell is for trigger type and level flags.
> +
> +  interrupt-map: true

Sigh. What makes this an interrupt-map? Why do you think you need this
and #interrupt-cells? You don't have them in the example.

> +
> +  reg:
> +    description:
> +      The 1st cell specifies the base physical address of the 8-byte ali=
gned
> +      buffer in guest memory space which is guaranteed not to be used by=
 the
> +      operating system.
> +      The 2nd cell specifies the size of the buffer which holds the VMGe=
nID.

I didn't ask for you to explain the purpose of cells in 'reg' as that
is the same for *every* instance of 'reg'. Ignore DTisms and describe
the format of the registers. For example, is it 4 32-bit registers
(hex) or 9 32-bit registers (ascii)?

> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      interrupt used to notify that a new VMGenID counter is available.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    rng@80000000 {
> +      compatible =3D "virtual,vmgenctr";
> +      reg =3D <0x80000000 0x1000>;
> +      interrupts =3D <0x00 0x23 0x01>;
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index de6a64b248ae..e295d2f50af4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18461,6 +18461,7 @@ M:      "Theodore Ts'o" <tytso@mit.edu>
>  M:     Jason A. Donenfeld <Jason@zx2c4.com>
>  S:     Maintained
>  T:     git https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.g=
it
> +F:     Documentation/devicetree/bindings/rng/vmgenid.yaml
>  F:     drivers/char/random.c
>  F:     drivers/virt/vmgenid.c
>
> --
> 2.40.1
>
>


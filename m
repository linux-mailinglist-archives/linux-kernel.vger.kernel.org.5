Return-Path: <linux-kernel+bounces-78215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 761A1861059
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191A71F22927
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FAB76C62;
	Fri, 23 Feb 2024 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTF/Cjbl"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E875633E9;
	Fri, 23 Feb 2024 11:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708687678; cv=none; b=UU1eCEEIqjD435PJFxvDLWsY9ktuSVbFZXaIDdes2pKYG9YPDE/6i5dnTHQX5yFS0KzyXYYi6pMYU8hBaG2s5LoTyNiguKlJJqR4L1vCI7/zAopj/kHkEBFHzA3idxjlN7uUxp5gHZBfqb/p+UeWgk6qEMrm1JsI2LIavc7Ljrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708687678; c=relaxed/simple;
	bh=7lns47V9d3ljbXIZeFjyZUvZyAsX6a4jfQAcXB1V2Qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hPRt4Q4gRR6kDF+7zfhmxHXuQrWg6H2OkdGqFeEsAioD7/COT7mr/IpsedHbv0YXn2HxxUzqncmRHGCLwOKUq+R1s2/fmNU46su4qlulmzCuudSh0nDpMcMWd0fm9b758aoFTdojWL948O333VydkZiWZTkZ99N2HRLOR1j8YEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTF/Cjbl; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-204235d0913so497883fac.1;
        Fri, 23 Feb 2024 03:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708687675; x=1709292475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ownr1auPC0la4RuCKQdoXSaC+bAZpMifBCf/a/ywWOs=;
        b=CTF/CjblEWkgLSzP5YURDT1sil9vKTBBPamB4tdVPbClC7ZsHV3j/RH2PnVJMtMwKX
         9FG3X94MVKL/Q/JSTexA00i4ctAvsZj9vXehydQTo9al+stGejapR177bo/JCmpXlvyA
         LFz24akBSkWGdRoYFv6lHUmH+YpKzsYAympp+BwytopDTi3R80Fw/pSkcexbSbrildm5
         eLRSXAxnRpgEnIncs2d0sYhcjCownGZNZs6UrBotOa0QAYMRNPcft50c7NR2sGdjZybf
         rJcLegaeWS1WmQe7XU2Ohv1Nd3wBYEVhFWDizLs0M0UIMHg1+pN4Q+86E5Vaj7cnqpqO
         Pi+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708687675; x=1709292475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ownr1auPC0la4RuCKQdoXSaC+bAZpMifBCf/a/ywWOs=;
        b=rEKPO1SvZu5NVz7ioA11yvthsdtOuMqtBpmiU7vArECUtJ6kYaYATGUbZb8bg0yhJZ
         baY+n3p21G0JVrqL2CLWA8zYU6JZYMrZ6QLFDdiyOpyX0easMtWVsKZcnpufqxjAJdjF
         2MCZz0Yf/d2adx8s9iYTsmFbIdb7iM7k3BR/b08weHNmVI7e2on/OitYv2GmTybQoKEJ
         rQhbs9XY0c+oH2FWCA7yPZF+3BZ9vg/oVdSYcsc3bFdvRa3FIiLEjJea73UGnlK//S4Y
         P45hwrx1X5PeimToFdr8pDtUveR87Hdrgm2ifGfNdTSP8ydRilaM8kAuPjRKf6xjFi2I
         m1hQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3RatNtTehrtTqUcN9Wo/gDXNBT7+SYH+6lHJJUB4a+t3XA6kmnIysX7Sl2bmqiHSfZ6dXyloWmkovTaLVtRcpJ/Dr1lZUI6YIISqv
X-Gm-Message-State: AOJu0Yw+8Ra+kVo8/3xYLx66iC8FbJ4a2rO/F+Bpt3JnYeY4TE6DknmU
	pq5jMHRm2oNa7rTpwwHs9WhDh5B2G+sNHD+yneQidDId26eg4VddshNzUQTOe/JcR5qn6a8c3zf
	uP35Ht5O6XeL81EW7FYjNmeF+d+xE9omn
X-Google-Smtp-Source: AGHT+IE1dBDMul055Ysj1AjF1wKdwGtZya5r0PJl264jRWgiOUKOaFU21Dt8QwN11JqlwDix4OLBt+41tp2ccN34RO0=
X-Received: by 2002:a05:6870:2014:b0:21f:746a:bcc with SMTP id
 o20-20020a056870201400b0021f746a0bccmr1666226oab.49.1708687675556; Fri, 23
 Feb 2024 03:27:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212093443.1898591-1-sergio.paracuellos@gmail.com>
In-Reply-To: <20231212093443.1898591-1-sergio.paracuellos@gmail.com>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Fri, 23 Feb 2024 12:27:43 +0100
Message-ID: <CAMhs-H__b2dNQH+nsbc0+gTeQPmkZf5B95+3Y88iRZ5KZmu=yQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] dt-bindings: timer: add Ralink SoCs system tick counter
To: devicetree@vger.kernel.org
Cc: tglx@linutronix.de, daniel.lezcano@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 12, 2023 at 10:34=E2=80=AFAM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> Add YAML doc for the system tick counter which is present on Ralink SoCs.
>
> cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
> Changes in v2 RESEND:
> - Add Daniel Lezcano to CC in the patch itself.
> Changes in v2:
> - Add Rob's Reviewed-by tag.
>
> v1: https://lore.kernel.org/lkml/CAMhs-H_9kAdOfR-RaJWqAq6d3S3DXtKJqWy-EWC=
u0-ZjWKB9Sw@mail.gmail.com/T/#re9225265416ca8463c5f06d736f9834ae75efe0c
>
> I am sending this with Rob's RB added since I ping for the v1 multiple
> times without response. So I can be missing something or the patch is
> lost for any reason. Thanks!
>
>  .../bindings/timer/ralink,cevt-systick.yaml   | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/ralink,cevt-s=
ystick.yaml
>
> diff --git a/Documentation/devicetree/bindings/timer/ralink,cevt-systick.=
yaml b/Documentation/devicetree/bindings/timer/ralink,cevt-systick.yaml
> new file mode 100644
> index 000000000000..59d97feddf4e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/ralink,cevt-systick.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/ralink,cevt-systick.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: System tick counter present in Ralink family SoCs
> +
> +maintainers:
> +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: ralink,cevt-systick
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
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
> +    systick@d00 {
> +        compatible =3D "ralink,cevt-systick";
> +        reg =3D <0xd00 0x10>;
> +
> +        interrupt-parent =3D <&cpuintc>;
> +        interrupts =3D <7>;
> +    };
> +...
> --
> 2.25.1
>

Gentle ping on this patch. It has been a while since it has been sent.

Thanks,
     Sergio Paracuellos


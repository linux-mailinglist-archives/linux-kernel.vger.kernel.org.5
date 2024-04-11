Return-Path: <linux-kernel+bounces-141475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37E88A1EB6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E1AA288A4E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BCD57316;
	Thu, 11 Apr 2024 18:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhfajAfV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D359134A6;
	Thu, 11 Apr 2024 18:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712860046; cv=none; b=FFW/n4FITvzO/8ohHHEhegm2EPWTQKAHn4Y/9E1GXaKdM4OsaWQzZSW5W36juu4i/UQp8JCQK7O/UwtQeiOTU4TAF6c9O1WAojq0jjJrVxuqWJ2gkJcGZBpD2iCrPevb9Kt59ekCcSslKR0PqQQqW+TXK2vc8uKvSYl/XG8pM/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712860046; c=relaxed/simple;
	bh=RiL7NCYtCcHsH+uweOP8iPvVB49rwBQCyP21CknrcZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEFYIjRS7QuXFPyNUzu4sWTigOIMBB0o2JKiPxcjMMRUdD+nj6Ej0mLR8JANNaMvIOuu/3iTxpzOSb5fRrhikvIwFJvJwPs5quIirJ6hhsVI0wxZKiqALt5vD5v7ZF62MA/7wPfDEQvvimz6NYREhegQ/WerhpxCQm0C44yfyoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhfajAfV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4F0C32786;
	Thu, 11 Apr 2024 18:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712860046;
	bh=RiL7NCYtCcHsH+uweOP8iPvVB49rwBQCyP21CknrcZg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PhfajAfV0BmG+7+IfYzoqUo3TNVS2GMVSgMx//q+VCaR4AK4ZNQP/9Io9j9OF8xrj
	 vIYBb5vrLpS1gxNWVANZxNUUP/V595XrtKk3M4VGqhQHnt8N0byRhSvSGxoRFKU+RV
	 lAM/S0InNKq+2mAjNO0fe39tD+Z+iD9FdISYCS+ab59IsaeqP0aAWO6ZAoYhhk7E84
	 YHHR5sha5cS/PqQ70qJdzZpcOM/ldkG6/ojHRZQvxy5Zx9D7kjeVCFqt1Ij4H/n0Di
	 LEyEBaooDIPHqAXH16WzqzHKEkzfMwYfgwlM9xpjmr0uSA5G2mLrTBcHen/WFxRyDJ
	 0IU+hn4LsjV7g==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-516d2b9cd69so138064e87.2;
        Thu, 11 Apr 2024 11:27:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+LqNwTj/TFsEOAN5HmId4qcnzxUOJm+iSfZx/WbysgSuIWOnaoK/uT6NtN0WX58y7SCjDvD7qNodpk6ZahxK2zvfcr4yWv0RwnULTq8n9kOajRwURN95iwb00PQZvS+YaSYjrdJtYhw==
X-Gm-Message-State: AOJu0YxZ9J8iKMpFEQhTQ98plYTZpEfCAn7BdsLCbBBolMUMSihb/IDp
	NzwjKqBIboCCdrHcAsaGajLhtzbz1yYtQn0rnGU3Rg7SZYvVT/QoCHX0I8NlhlFF1kd1xCUDKDV
	PA+nolkQfm64CuCXRslK7s+DPbg==
X-Google-Smtp-Source: AGHT+IHIsBjL1j1+9YxaTLq+zl13d3n46AebiWDvDlRVOWu512rh2eh3yNUkEheuWfLp+SJva7CpHGdaiqq3rh+Se8U=
X-Received: by 2002:ac2:4d1c:0:b0:513:2b35:2520 with SMTP id
 r28-20020ac24d1c000000b005132b352520mr264893lfi.58.1712860044216; Thu, 11 Apr
 2024 11:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405190419.74162-1-krzk@kernel.org> <20240405190419.74162-5-krzk@kernel.org>
In-Reply-To: <20240405190419.74162-5-krzk@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 11 Apr 2024 13:27:11 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+PtL3HTKkA_gwTjb_i1mFZ+wW+qwin34HMYmwW7oNDFw@mail.gmail.com>
Message-ID: <CAL_Jsq+PtL3HTKkA_gwTjb_i1mFZ+wW+qwin34HMYmwW7oNDFw@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] arm64: dts: microchip: sparx5_pcb134: align I2C
 mux node name with bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
	Bjarni Jonasson <bjarni.jonasson@microchip.com>, "David S. Miller" <davem@davemloft.net>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, horatiu.vultur@microchip.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 2:04=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> DT schema expects node names to match certain.  This fixes dtbs_check
> warnings like:
>
>   sparx5_pcb134_emmc.dtb: i2c0-emux@0: $nodename:0: 'i2c0-emux@0' does no=
t match '^(i2c-?)?mux'
>
> and dtc W=3D1 warnings:
>
>   sparx5_pcb134_board.dtsi:398.25-403.4: Warning (unique_unit_address_if_=
enabled): /axi@600000000/i2c0-imux@0: duplicate unit-address (also used in =
node /axi@600000000/i2c0-emux@0)
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Changes in v2:
> 1. None
> ---
>  arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi b/arc=
h/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
> index e816e6e9d62d..cafec6ef0d0f 100644
> --- a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
> +++ b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
> @@ -395,13 +395,13 @@ i2cmux_11: i2cmux-11-pins {
>  };
>
>  &axi {
> -       i2c0_imux: i2c0-imux@0 {
> +       i2c0_imux: i2c-mux-0 {

Doesn't this introduce a new warning with simple-bus.yaml? These
devices shouldn't be under an AXI bus which should require a
unit-address.

All the sft-eth* nodes have the same problem:
axi@600000000: sfp-eth63: {'compatible': ['sff,sfp'], 'i2c-bus':
[[91]], 'tx-disable-gpios': [[87, 31, 0, 1]], 'rate-select0-gpios':
[[87, 31, 1, 0]], 'los-gpios': [[88, 31, 0, 0]], 'mod-def0-gpios':
[[88, 31, 1, 1]], 'tx-fault-gpios': [[88, 31, 2, 0]], 'phandle':
[[78]]} should not be valid under {'type': 'object'}


Rob


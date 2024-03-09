Return-Path: <linux-kernel+bounces-97747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBCD876EBC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 03:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A25BB20FB4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 02:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DEF208A9;
	Sat,  9 Mar 2024 02:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjFmO5k1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FD716423;
	Sat,  9 Mar 2024 02:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709950515; cv=none; b=le9h2gR73J47d1HnVURlW9ZyCzbCB9oCryFf3mkNmFQrqsc3xrAS3IdQG25ByRDi3Qhzvv6nBp/skWPBX5KH7yn4nzSMlXdd4PXtOVFqokqmRcqO+LPU3AAP30WhiIj/VNI0+EzzOPJfVNiElCC3Nxmtv1+bVBgxT3KtR4cA1Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709950515; c=relaxed/simple;
	bh=4Qrf/Byr2Zv7iIhlTlzgFacoEmHeefX1Prg8xbK7Dzc=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Q837suVV++kaAEIar93pK8FLe9mbLeXFaEw4wSoGWE2CN8JLrHTQpLUMXXkazlZvtxVt70oEF2WcgQ2ro9pudUrATQP4ik6tIBh4TMKh3YFJOWWb9Lka9vc30XfyMPaggBwhECyVzxwz0Vh2Cmq3FfOGmlKNUE6nHog+pEIiIf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjFmO5k1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AE7C433F1;
	Sat,  9 Mar 2024 02:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709950514;
	bh=4Qrf/Byr2Zv7iIhlTlzgFacoEmHeefX1Prg8xbK7Dzc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=UjFmO5k1oGM8NsMYEbhrdS0gAGUK9qruz+5oAbTF2r5OCLJi5kFRzftf9exqAiY3W
	 Kv2X0NvthRLUMvqO3vB7KSk65/MjV/GuWdiYU3X1sej/l1IvbqqX3B3JH0NNjvTgrI
	 S1Qxk6sz1afXLT/YDq9Ubov8QhNX7xkDOEjAf+WSn6xIwdcQVewIu1yucLAfxmK/xs
	 z0TSQwGRUZpkT6+3vSpZ0ncN7wKLh2T4k9Tg2aiTj/rkMZI/TcBosVr/ruB0Hzp/rx
	 5k9whKJpwXmo//aCY1AA4ZX/kjKxDrJI6z9X0PThKFM6Orw7OkYT9rScMS9JSSjArC
	 iNFeFB40RnZPg==
Message-ID: <066c6fa4b537561ae6b20388a5497d9e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <49faf8ff209673e27338d4b83948ade86b3c66e4.1708397315.git.unicorn_wang@outlook.com>
References: <cover.1708397315.git.unicorn_wang@outlook.com> <49faf8ff209673e27338d4b83948ade86b3c66e4.1708397315.git.unicorn_wang@outlook.com>
Subject: Re: [PATCH v11 2/5] dt-bindings: clock: sophgo: add RP gate clocks for SG2042
From: Stephen Boyd <sboyd@kernel.org>
Cc: Chen Wang <unicorn_wang@outlook.com>
To: Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org, devicetree@vger.kernel.org, guoren@kernel.org, haijiao.liu@sophgo.com, inochiama@outlook.com, jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, mturquette@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com, richardcochran@gmail.com, robh+dt@kernel.org, samuel.holland@sifive.com, xiaoguang.xing@sophgo.com
Date: Fri, 08 Mar 2024 18:15:12 -0800
User-Agent: alot/0.10

Quoting Chen Wang (2024-02-19 19:08:59)
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-controller@10000000 {

This is the same address as the pll binding before this. How does that
work? It's the same register area as the pll node. The resulting DTB
should only have one compatible for this node.

> +      compatible =3D "sophgo,sg2042-rpgate";
> +      reg =3D <0x10000000 0x10000>;
> +      clocks =3D <&clkgen 85>;
> +      #clock-cells =3D <1>;
> +    };


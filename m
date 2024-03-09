Return-Path: <linux-kernel+bounces-97744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BC6876EB3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 03:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A16F1C20D97
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 02:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F48208A9;
	Sat,  9 Mar 2024 02:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DggvOQZf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D383523741;
	Sat,  9 Mar 2024 02:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709950331; cv=none; b=RhXdevo+GLnhzQW7aE+MA6KHfiy5t+OiFLUzOS/FSgeD2PiKeVzpkWLH4QdElwqwg5obhZFYYz2b7Umx4thYMU5Tyw2Z6G6AAN32M34yANaKDAMofnGcm/0M7ddpeZvPC+qA+WGEk9718STP0cqOVTL0XgSasUJRumrNFpHS8WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709950331; c=relaxed/simple;
	bh=BSB1G8R5O4rAwZZrcEgw7e4XCZZVSBJLhxduFJPG6LM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=bhZXscHMKgYkE6YY+qWP0wKEKTlgjjjosAmKNq7j2h46kkA/KilX4MQs/dc8o9kqxl6OawaOYWdO6rZ2wnRurfK+gv6ip+9a3YiNM3jjuVqzPCBHCK7PenXN1PEPNuJ/ElXGtpY5MXH9NBK7/Y8sgCnCkXjQRZlK5EpPdhBA+oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DggvOQZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484E1C433C7;
	Sat,  9 Mar 2024 02:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709950331;
	bh=BSB1G8R5O4rAwZZrcEgw7e4XCZZVSBJLhxduFJPG6LM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=DggvOQZfoETsx8hzcPslXyXJ88+KLSZ0+AOupGyD/qKlNdYpdoHE8z9ivtnoWcf2R
	 LjZa3/XIfdWty1z/SP4ntgi9MlhjoxVJLX40G2p5qshm/H4f0b6smy6KxXhQT7u1g0
	 mvwaCzoc7jw0S8SfjlveRynfEofyZy98Cwc3wgieDLbZd2BTaL8/H2skR81/kyJIhx
	 oeDmMK+PKZbYd1tGd0tEskJ//Fi/YIWVru96DmVC5dkmzRgSaS4391TkOXRpi1mcgO
	 Wh23eS0faYQgOIqhP+JzX07Y2uvu826w/Y+uUKV6qAUmGKiAaivZr8ZVu1AmSkKeJG
	 Z97FNOTIDIuag==
Message-ID: <d22eb9d0bfbaf12689a2d14d3c50e263.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <92448a1ca9ad8f713dbdbf3453f1a5db0ca47d9b.1708397315.git.unicorn_wang@outlook.com>
References: <cover.1708397315.git.unicorn_wang@outlook.com> <92448a1ca9ad8f713dbdbf3453f1a5db0ca47d9b.1708397315.git.unicorn_wang@outlook.com>
Subject: Re: [PATCH v11 1/5] dt-bindings: clock: sophgo: add pll clocks for SG2042
From: Stephen Boyd <sboyd@kernel.org>
Cc: Chen Wang <unicorn_wang@outlook.com>, Rob Herring <robh@kernel.org>
To: Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org, devicetree@vger.kernel.org, guoren@kernel.org, haijiao.liu@sophgo.com, inochiama@outlook.com, jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, mturquette@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com, richardcochran@gmail.com, robh+dt@kernel.org, samuel.holland@sifive.com, xiaoguang.xing@sophgo.com
Date: Fri, 08 Mar 2024 18:12:09 -0800
User-Agent: alot/0.10

Quoting Chen Wang (2024-02-19 19:08:39)
> From: Chen Wang <unicorn_wang@outlook.com>
>=20
> Add bindings for the pll clocks for Sophgo SG2042.
>=20
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> ---

Applied to clk-next


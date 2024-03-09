Return-Path: <linux-kernel+bounces-97746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 330BE876EB9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 03:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C73C1C20AE5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 02:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91654210FF;
	Sat,  9 Mar 2024 02:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5HYpbJr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19511E507;
	Sat,  9 Mar 2024 02:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709950358; cv=none; b=fKdimz6eJaPf/J4dFH2tBCQ2kCB3LZCoQxHfp6v5t/NN2M7PKfbsL+IxikMcQbPF1KhzIypetvIkp4H3roecwN+YCyJJOyJ9hiBXL4I+UXtodbdOCuZBY83ACxYglWgZRh8e+ybsbp8HqwHvVg3Gu6jnUN314IOJF7YM7hW6piQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709950358; c=relaxed/simple;
	bh=I4Llxs/mkHYecNgMkWeDzb5d5ohYY0ybnjRdQ/uNRRE=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=YC+AsWFZmZ8oVv+2YeBaik5d3+QnNhmi9cMxlApHT3l2ol/Fbkpso0fiT7o46G9LivH/8cxnLRGNR2ZnucZyVtvMs1dnyu20r/yr0OIeD3Hd1/LYfe1VCtG56oXstpUd1RnYzThdFZamJlGgtjJDdKmG4Ewm6BSmrfkywsYMCks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5HYpbJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53CF1C43390;
	Sat,  9 Mar 2024 02:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709950358;
	bh=I4Llxs/mkHYecNgMkWeDzb5d5ohYY0ybnjRdQ/uNRRE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=s5HYpbJr79LAi14UNgqaavQgnx50oXr5T6zFxr7/FZFvc7BWMfMyrAWX2i0TLTpOO
	 0dzRE6DbfF4CtZtDywHd6NGz8koqUB7MDEyYydEeFtM2yOjNkH6rsHHwcbirU5HAUH
	 Hwvyj0gcrqL8xWNVzxGYBhEAPuSuihZ3wR1NjpS7dqZ0wc4VECro+jn7hivdDOe2JX
	 edL8GR4Bs+bZ0WqIL6YbhZhb3FMufYlLLJGQ44ejcVTkQl/gCMOhONRHPkxxyyr4v8
	 vQYJqREXAYPpeb/seG9OwdHLTqgOwO8EZv5Rp/g3dYWMRemGYT4pNTByxkbFZfZBac
	 a4Dznd/JwvVdg==
Message-ID: <30eaec5e622af4ebebfab4f8caf72f60.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cebef63e3e704db58658b5eae3f1fc4dfd1a587e.1708397315.git.unicorn_wang@outlook.com>
References: <cover.1708397315.git.unicorn_wang@outlook.com> <cebef63e3e704db58658b5eae3f1fc4dfd1a587e.1708397315.git.unicorn_wang@outlook.com>
Subject: Re: [PATCH v11 3/5] dt-bindings: clock: sophgo: add clkgen for SG2042
From: Stephen Boyd <sboyd@kernel.org>
Cc: Chen Wang <unicorn_wang@outlook.com>
To: Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org, devicetree@vger.kernel.org, guoren@kernel.org, haijiao.liu@sophgo.com, inochiama@outlook.com, jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, mturquette@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com, richardcochran@gmail.com, robh+dt@kernel.org, samuel.holland@sifive.com, xiaoguang.xing@sophgo.com
Date: Fri, 08 Mar 2024 18:12:36 -0800
User-Agent: alot/0.10

Quoting Chen Wang (2024-02-19 19:09:18)
> From: Chen Wang <unicorn_wang@outlook.com>
>=20
> Add bindings for the clock generator of divider/mux and gates working
> for other subsystem than RP subsystem for Sophgo SG2042.
>=20
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---

Applied to clk-next


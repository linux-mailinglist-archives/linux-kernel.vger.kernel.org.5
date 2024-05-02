Return-Path: <linux-kernel+bounces-166717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D349E8B9E83
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D6B1F24D0F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D17A15E5B9;
	Thu,  2 May 2024 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNXH3ChP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E90615AADE;
	Thu,  2 May 2024 16:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667110; cv=none; b=q5+9GEOpJC3djWM3CNGyqzPslQg2a6oRR17dfRKva/r9c2wkJbonrdYndfzxosDWgmxENPUQsw79n73q6ejcBdY8gjdvFvkWXQn5zSbNkEdETu+vk+W/LQKUNeV+q8+XLVyzMpJC2T9T7AUD046ioF1s7BQOJ9o2FiyqEqQhqjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667110; c=relaxed/simple;
	bh=eVUU9My3Jrjs/UHQZgJr3z5gPt43bz69SadF6dklRZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0CmTk3+T2+oJLk+z+eQK8DM+qaZM6l6FLt2fGPgX8Qecq4QoUBwHHo7+owDBiBmjE/jaWJeu18FX1jrlSVshqLJaWGZuauJ8EfBCjx+nBV2azRGQRKAKuEyz0X6qJvBs6U+UyA+4oytrK1/01vBKbg5GPxv48bzW+QuDwbRTvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNXH3ChP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCB5C113CC;
	Thu,  2 May 2024 16:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714667110;
	bh=eVUU9My3Jrjs/UHQZgJr3z5gPt43bz69SadF6dklRZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WNXH3ChPi0Vwe6FxeKPmuAqK9AxeuX4anIvy5ODcU4kxdrgHftCjt8XEsxT5lQjkk
	 T4+yj0txY0H3urWx5R5wJNFbVA/fq9Y1LWt8G/l4o0jGNqJzjWsM81qzZguxjfmAab
	 1ZDFHiN1QsuS/4wN0zD2KjnW5GZB8Cz3uJa8Sh9xsY7p8bl3TAtXbb43gcqbwVOG6+
	 7Sd65ReQrl9+vW668LRvM6GOfHVSvqFLtfRIQXge9SQwwW66V1x+LhZ8EEl+gJbMoh
	 MTAeqe5W9yIOTTVzBSH/Q8TsVi1zIsYfxg92qTUc+05kGap3p2HDsQ1gKsikBYH2RC
	 qCzJSXYnMKOJg==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: microchip: add pac1934 power-monitor to icicle
Date: Thu,  2 May 2024 17:24:55 +0100
Message-ID: <20240502-wafer-landowner-fd8f7dc290f4@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240501-spearman-primary-17df3c21c770@spud>
References: <20240501-spearman-primary-17df3c21c770@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=524; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=d0Yhjtp2Siagwln1k5fEq4fncaZ2UG0U07TBV/HvY+0=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGnG+8KvB2zWNj4TtDW4QPOhgwBHqOAfuWltwQdnrb95o Gqv9YOejlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEzknC/D/7jIh9VtmYz7v9jK FLSWLIjUPmf993Fj15eCpZMPfbumwcvw39e8KMdz+8WlcinrNs/Z0W3lEFUv+TZAdWZEwsZ5J30 UOAE=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Wed, 01 May 2024 16:36:31 +0100, Conor Dooley wrote:
> The binding for this landed in v6.9, add the description. In the
> off-chance that there were people carrying local patches for this based
> on the driver shipped on the Microchip website (or vendor kernel) both
> the binding and sysfs filenames changed during upstreaming.
> 
> 

Applied to riscv-dt-for-next, thanks!

[1/1] riscv: dts: microchip: add pac1934 power-monitor to icicle
      https://git.kernel.org/conor/c/8fd63d81a760

Thanks,
Conor.


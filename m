Return-Path: <linux-kernel+bounces-75911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEC785F08F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E41F1C21390
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31001C16;
	Thu, 22 Feb 2024 04:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRhCVowN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226C8382;
	Thu, 22 Feb 2024 04:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708577738; cv=none; b=E/RjknSfrukGxNGW4BFFOk4yBGZeKf9cHybAABo9Zxk31kNrxG5d8P8vGZtftz8StAMAO608sMxZmzdgyJs9Gf635nFApUOgLNG8sxweUj7qU6Ulr+yHV29RqPmnvp8q8d5Y9KgBoHWAiClDRbKfS7pS0yQGXAwu2G58jJGyM0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708577738; c=relaxed/simple;
	bh=0twjdnUZK3fCwX0EY33IZ2Wjb+zn9RhH3jERrQuyxng=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=JF5CCkxDq8wd42xGPMjo9IGU68G1nGNA5xhLgGyL5hxZiEQbCYFRmFfkopSGXb/+v3ClPUqQKaH7jKj7sCyd5o294JdilHv2BSWAfcUbAgpZBn66imWR60Pv5NMB4tqSKawXnCIhsNjeDpRKxslg6iXrmiEd3b54V8HnZsHx/j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRhCVowN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71AEDC433C7;
	Thu, 22 Feb 2024 04:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708577737;
	bh=0twjdnUZK3fCwX0EY33IZ2Wjb+zn9RhH3jERrQuyxng=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=JRhCVowN1kGPufF9VMiWE1+2taFg1JqW+zEhyPT263uu2Gx8JFjv25+FVEk9Eq7nQ
	 3TgCaMS/MKZ4Jx23YGDtfe0p7We1We+fb/hz7AOPD8UOob5F8IeSIgFvBZCSZYDxaH
	 l1qdP5owoOXLwXXy6H/1Ex7mC6i7eMjY1ov1sNgbnVzwT6IJ/IvpApEL/lv1tdnWWb
	 U3wUaSA0qbSId7k0//A+Z5xHrIQbY1aaspx7yp+MWxfmzxljGAJ1hQ9OTcpNCcOQXr
	 JGDnMLNblWPsVqdXypDyPWgZJ12kJYWp1tKnhQeIxRsdBBq0xilroSvJtsnLYOOre0
	 NukMhNoqZ67cQ==
Message-ID: <779e41e11d90cdf05ead7932de07192d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240219105125.956278-1-wenst@chromium.org>
References: <20240219105125.956278-1-wenst@chromium.org>
Subject: Re: [PATCH] clk: mediatek: mt8183: Correct parent of CLK_INFRA_SSPM_32K_SELF
From: Stephen Boyd <sboyd@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>
Date: Wed, 21 Feb 2024 20:55:35 -0800
User-Agent: alot/0.10

Quoting Chen-Yu Tsai (2024-02-19 02:51:24)
> CLK_INFRA_SSPM_32K_SELF has the "f_f26m_ck" clock assigned as its parent.
> This is inconsistent as the clock is part of a group that are all gates
> without dividers, and this makes the kernel think it runs at 26 MHz.
>=20
> After clarification from MediaTek engineers, the correct parent is
> actually the system 32 KHz clock.
>=20
> Fixes: 1eb8d61ac5c9 ("clk: mediatek: mt8183: Add back SSPM related clocks=
")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Applied to clk-next


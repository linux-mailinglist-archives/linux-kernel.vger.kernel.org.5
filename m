Return-Path: <linux-kernel+bounces-7841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AF981AE17
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96F9C1F23155
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E7B8C00;
	Thu, 21 Dec 2023 04:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7Cx73xO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665339479;
	Thu, 21 Dec 2023 04:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB44CC433C7;
	Thu, 21 Dec 2023 04:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703133504;
	bh=T0r6cxoGvSvAzvc8s4xGyg2H9N6xHNdpy1pG9PlQOrk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=T7Cx73xOyswpwiZZdJfKW/I3jP33BRO9Qs6zZQuUObuKhQ8H70Jo+RIBgqo3h3Hon
	 KnpA205GOMhi2/zQOav9YxX5+MFO4FXQoveR6dutdqq1VjYfFzMfajSJqXoIcHdVph
	 kZ/6Bq2qs0nrhBnUl4CXXCP2LazyCcSUWrwaz6171MFKOTlX04RrNie1oQZ64yRHMk
	 r1TgcwsvmJKwITggQ5YliSYd3MuEJAzUbulcMSJw0BZ895CznzS/tuiuHmez4ZscIq
	 LCY1Jd7QN1XGA6BX5T+Au5bRxipYqLnL5y1zlh4WeAjA91w9GWeDQyhDk8FSo2wVne
	 erfcFC7GPlQtA==
Message-ID: <7bfcce007938a575a6d6f41faf4d432e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231219232442.2460166-3-cristian.ciocaltea@collabora.com>
References: <20231219232442.2460166-1-cristian.ciocaltea@collabora.com> <20231219232442.2460166-3-cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 2/2] clk: starfive: jh7100: Add CLK_SET_RATE_PARENT to gmac_tx
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Emil Renner Berthing <emil.renner.berthing@canonical.com>, Jacob Keller <jacob.e.keller@intel.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, Emil Renner Berthing <kernel@esmil.dk>, Hal Feng <hal.feng@starfivetech.com>, Michael Turquette <mturquette@baylibre.com>
Date: Wed, 20 Dec 2023 20:38:22 -0800
User-Agent: alot/0.10

Quoting Cristian Ciocaltea (2023-12-19 15:24:40)
> From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>=20
> This is needed by the dwmac-starfive ethernet driver to set the clock
> for 1000, 100 and 10 Mbps links properly.
>=20
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

Applied to clk-next


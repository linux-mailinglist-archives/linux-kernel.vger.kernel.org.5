Return-Path: <linux-kernel+bounces-2426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4B4815CF8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 02:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4771C21760
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 01:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA93515D2;
	Sun, 17 Dec 2023 01:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4iCYiS2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BB11852;
	Sun, 17 Dec 2023 01:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A446EC433C8;
	Sun, 17 Dec 2023 01:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702775590;
	bh=AxnDyTzaBhyrkBIleqLu77K26uIARMbwOapVhxy1RUg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=d4iCYiS2bBYdTgvjHzzE6bwlXyUjUGo4v3L4d/e57hZvoDN658d++Tcnm2ENKa8SZ
	 7dUJr8hys/XHcgvVQOwXDMCNM2jcBXEmdUVGYr22Gt6pp0vhzx1BHlyomoZ+VnBHz5
	 0O8E0Q7+hyVk4YNG9zV7HuiIQmUKNsrPo4lJ4iy1CSWAvcDn7vMk1ZHGTX7mqKE3ae
	 nVHKZb0+d40uILKB4ymJMR+G9NuP3cytkM7T/xERVgqgMEr+jRiZtTwrkyoMoA5i5n
	 dI1LzQRqCpDkcjwH/3q0qUKPziNEeA8I/pd+/zBtYENiJemnPCS/ckgtXYUQeSLfnH
	 RsqMgFk11F43A==
Message-ID: <f3e5af2eb7a63ab1a2dd993bfb0d8f41.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231210165040.3407545-1-visitorckw@gmail.com>
References: <20231210165040.3407545-1-visitorckw@gmail.com>
Subject: Re: [PATCH] clk: hi3620: Fix memory leak in hi3620_mmc_clk_init()
From: Stephen Boyd <sboyd@kernel.org>
Cc: robh@kernel.org, abel.vesa@linaro.org, dinguyen@kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Kuan-Wei Chiu <visitorckw@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>, mturquette@baylibre.com
Date: Sat, 16 Dec 2023 17:13:08 -0800
User-Agent: alot/0.10

Quoting Kuan-Wei Chiu (2023-12-10 08:50:40)
> In cases where kcalloc() fails for the 'clk_data->clks' allocation, the
> code path does not handle the failure gracefully, potentially leading
> to a memory leak. This fix ensures proper cleanup by freeing the
> allocated memory for 'clk_data' before returning.
>=20
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---

Applied to clk-next


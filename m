Return-Path: <linux-kernel+bounces-153893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB938AD496
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F8B01C20AA0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3008155331;
	Mon, 22 Apr 2024 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvvLAdMx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A021552E8;
	Mon, 22 Apr 2024 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713812660; cv=none; b=YUOX/N6H53Z4f6Iei9K0QSTEgeEz1/9+B4nB2VuesPPzQ/eEi6dhxjiW1Cu1y34wpaNI/+1MszEQ549EzhfWJxbNiLvXinjdnB00ISB64atnR1q23xafIp+i+hzYgDc1s+G2bONsfodTp4APKvzQPh5vJy5ASSmsZ1vD3myS9jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713812660; c=relaxed/simple;
	bh=L1zXCh0fyUD6RClltbUf+JXEJGHaqDZQuwYuCAOrRYQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=XRqAxdL4ZyPgd7nB+cKKd34DpOA/uXaEPthhGxsQLi5q7Rl/72W+SoUIhmxpe8JlUIbbtFEt9WeEXAihqdzd+HEUxWfeD96A3iq9sBQSGQIJ5gFcybyq9wab9lOJhqdOmuMn7htiHwJjp/bf7oOW6w1KfM9717AD+avek3gBiIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvvLAdMx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5775C116B1;
	Mon, 22 Apr 2024 19:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713812659;
	bh=L1zXCh0fyUD6RClltbUf+JXEJGHaqDZQuwYuCAOrRYQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=RvvLAdMxCv8Z18cZKUgvjzsPJ3G8K4/ZXeOghwBQzMuYSuDijRLFWbBbzGYWg341u
	 GNl7P6a+11s9BAqoV2tSVUoihXSblv7LMLGyAA/KfTSJgNGU4SmRwraVCQ66C6tYFo
	 OeCn5emCxOY7UD+JYNKDU+zeLkwUpOFN14WZHowVia9NhJuIZXS7oMpWEAJRp1qAUN
	 LwEg6u4NcW6lVHmlOWJwns5sf+gVHVCEivl8fW8GOpaMruXy5UvE4tQGqu7UOwEXWr
	 /lnM3xHvH6T4r7hgwcXwLNZ/3CWNOdyVzbvVnaImh13rsc5vZef6haiNDi47TVKjoe
	 syhG5CilbIyJw==
Message-ID: <2507c8dfa79762901d6b5f28376f749a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240415163649.895268-3-cristian.marussi@arm.com>
References: <20240415163649.895268-1-cristian.marussi@arm.com> <20240415163649.895268-3-cristian.marussi@arm.com>
Subject: Re: [PATCH v3 2/5] clk: scmi: Add support for state control restricted clocks
From: Stephen Boyd <sboyd@kernel.org>
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, f.fainelli@gmail.com, vincent.guittot@linaro.org, peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com, quic_nkela@quicinc.com, souvik.chakravarty@arm.com, mturquette@baylibre.com, Cristian Marussi <cristian.marussi@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 22 Apr 2024 12:04:17 -0700
User-Agent: alot/0.10

Quoting Cristian Marussi (2024-04-15 09:36:46)
> Some exposed SCMI Clocks could be marked as non-supporting state changes.
> Configure a clk_ops descriptor which does not provide the state change
> callbacks for such clocks when registering with CLK framework.
>=20
> CC: Michael Turquette <mturquette@baylibre.com>
> CC: Stephen Boyd <sboyd@kernel.org>
> CC: linux-clk@vger.kernel.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---

Applied to clk-next


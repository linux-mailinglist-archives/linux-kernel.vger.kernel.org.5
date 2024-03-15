Return-Path: <linux-kernel+bounces-104220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DBB87CADC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBF85B20F6D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E47D17C73;
	Fri, 15 Mar 2024 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="nS/mr1G9"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AE23D76;
	Fri, 15 Mar 2024 09:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710496178; cv=none; b=pQD0usPRYwroevWqBy41Y2w9Fvx3rgOjt+RLUnlcGJvN20wfWsd812bOhEtw15h8lBC2tS06TlR/UOxG65rJLruqn7iSl1oMK+QeMvvWJrb9CUwgB9Z+4bk0HruYAmXwm45l0PxvzBSA4oWW6Wr8eO4cI509zneLlIMVMZ4FP+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710496178; c=relaxed/simple;
	bh=IvwRJt3u2lCE2S8ckyxSaFXMoO4jI4DtyMsiY2HqSrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QL+A7gRFvr1+66PeXp/04u2XvsXaJwuiTraSNbiwJPYnV7y+bHBNUx9fQc/Y68tipRlzduRWRCd9y0SsNXGxkYShYloUnhGWFwCVKjePUf347hAkHfu0Xr0t/35xEX/OvN5qgJPKroj9KGUcxB/rAJy9pp4Y4lrkUseXSX70t7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=nS/mr1G9; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id CD28A1FA8C;
	Fri, 15 Mar 2024 10:49:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1710496172;
	bh=IvwRJt3u2lCE2S8ckyxSaFXMoO4jI4DtyMsiY2HqSrE=; h=From:To:Subject;
	b=nS/mr1G93Zpp5yJVdg/j3GUx9KS+VUW3TgRpTWx8+gmGhck6zlGnUGN7zjOBpMGen
	 tBhiKVayYXHKboV3b+k1+8/m7F4ZVBF4ZucfaNsmJu/vIk1NZPg64djemDDsOI2LsA
	 Q8vrwUqqDkDUCOaAFhO1WNVMCvJnfwyX1GtKETv/CUgWpUnlNyX5NBdI+O0KLP1H8B
	 WZ9XPMVrISSuabJ6GpuguvMuqV01qgeKY8DSt8R0rlRnP0BV86BwIJxK/+RblPw9/k
	 qpjsJ0fUbNaHHopGEBwzfPxLA0aZR5ADLM0n0jybr9Iic5MRiWzPfbdzUXOLk55923
	 jsd6cr8Irmw0A==
Date: Fri, 15 Mar 2024 10:49:27 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: briannorris@chromium.org, kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lin <yu-hao.lin@nxp.com>, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com, rafael.beims@toradex.com,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host mlme
Message-ID: <20240315094927.GA6624@francesco-nb>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306020053.18054-1-yu-hao.lin@nxp.com>

Hello Brian (and Kalle),

On Wed, Mar 06, 2024 at 10:00:51AM +0800, David Lin wrote:
> This series add host based MLME support to the mwifiex driver, this
> enables WPA3 support in both client and AP mode.

What's your plan for this series? I know you raised some concern when
this started months ago and I'd love to know if there is something that
would need to be addressed to move forward here.


Francesco

p.s. I'm aware we are in the middle of the Linux merge window and
nothing will happen till it closes.



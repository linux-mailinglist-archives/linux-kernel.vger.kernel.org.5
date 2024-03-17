Return-Path: <linux-kernel+bounces-105510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B5B87DF86
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1F71C209D0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351471DFFD;
	Sun, 17 Mar 2024 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSi2XOPS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4591DA20;
	Sun, 17 Mar 2024 19:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710702613; cv=none; b=KR2kpIn+yd7w7ZvpL5AGMDxGOqwzy2JAI+U7mJcHz9AWmsE7hg9VReIRNgOZ2fLMOAIxCVK3wgWGQEZY0gtliSAcGdua7b+f2Z5ggzQNjj9tqjeYC9vFqokeKd27BOAhwWTG6uzmpvl1J2jCY39T7IUpLDn3RDqeTlmSQfQpIrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710702613; c=relaxed/simple;
	bh=m0Flx86hlt0ID5OEE6IkxZUX4ODTKKRFVINUHUA7ss0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+YzSsoE6CpieiTPka65oYYCODPz5nKIiQ9urAkyc/GiyrDSFbHsahgzmk3vrULnJIuO5knN658a5vtK9cHKkFS1o0BDjtVntK1tKRIt2plxd/rLqIwbiZUSuZVjdFKB69V/y+RGHUBj5KUsh1IbJhZGuunl9BpWS1sBFHtYzcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSi2XOPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E14C433F1;
	Sun, 17 Mar 2024 19:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710702612;
	bh=m0Flx86hlt0ID5OEE6IkxZUX4ODTKKRFVINUHUA7ss0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rSi2XOPSw4Fdzj6YPbJ7NmZItS9T42PBNe8meEGA9KvXJRseIYJNeFYApi1qVRjuF
	 hIcM+uFWfRSLKPwIEl2GIBRnd/xqgU02SVSNm08VSB2uIpoHwsjOHvrYMOKlecUNqe
	 sNLexeaItJBWTmeVgGgkG0bjOqiKxcdEeQSmeE9JPymngvyhmvUGJSw1r1ho26OeJA
	 sx7OgUz6iWHYATK8MUlkVmE+L1E8nd3af5BCjQjAKDUMxsERP65WIi+VlffTIPxhwL
	 T8mRlVfXX8byeWK2sL7DNvakNHAC6ae1At+0UorQOGPwMdLHUrvc2KEyio6w6lWTzT
	 OpDtA+MjP4/2w==
Date: Sun, 17 Mar 2024 13:10:10 -0600
From: Rob Herring <robh@kernel.org>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, kernel@salutedevices.com,
	Conor Dooley <conor+dt@kernel.org>,
	linux-amlogic@lists.infradead.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>, linux-clk@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 16/25] ASoC: dt-bindings: meson: meson-axg-audio-arb:
 claim support of A1 SoC family
Message-ID: <171070260941.2083610.11098658927011018629.robh@kernel.org>
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
 <20240314232201.2102178-17-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314232201.2102178-17-jan.dakinevich@salutedevices.com>


On Fri, 15 Mar 2024 02:21:52 +0300, Jan Dakinevich wrote:
> Add "amlogic,meson-a1-audio-arb" compatible string alias to
> "amlogic,meson-sm1-audio-arb".
> 
> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> ---
>  .../bindings/reset/amlogic,meson-axg-audio-arb.yaml    | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>



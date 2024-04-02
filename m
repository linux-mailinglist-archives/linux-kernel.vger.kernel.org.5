Return-Path: <linux-kernel+bounces-128430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585F7895AB9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F06289FE9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A08C15A480;
	Tue,  2 Apr 2024 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftwVH2lZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957B615A4A7;
	Tue,  2 Apr 2024 17:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079148; cv=none; b=CgfddK0jGobcuCWgqshjIcqX/PDDL0TTqtAO8ZPQFvpuSpAc9E/tS9Q49BSeSasys9JAXbcfq2hZZFHpp/PjAasYeZsxPPjyNOtbkwW+h+rDfKmJTiLjhSJ/BI5k3g7Y4yH4BWJAnK/pyLViLozIDWNaiiooGcDXdMhvUyjXAYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079148; c=relaxed/simple;
	bh=aduyaipM5T0aY6bLSz+8o4Wc9lDD8Yn5NJTGROS+eYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZL/HmTRjqFHfJZinJPffbb2Z8O44S9+P7Lg3xB23wTTklmHYykaQn3MQ7FQB58E3tQBejUBXCGPop95HUZj2ohYGZOVXPL2JpuJi9/7CaT0kuRYtDwZ2RhUlKr6Jii17c8Rh5H0Huh5KVjfQymFMwt2hx1TrXTpcCLk57HvXAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftwVH2lZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBACCC433C7;
	Tue,  2 Apr 2024 17:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712079148;
	bh=aduyaipM5T0aY6bLSz+8o4Wc9lDD8Yn5NJTGROS+eYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ftwVH2lZZkE6NWKmyLWEpoXc+AXiKLggaHNTdHXUDYQWrKGMcU9xwWfM2Nze8kLn6
	 eyjHIhskwQLsC9VZvfX3Beinz/6YA6GhqyEdaeILQdD1CmpjKtbM+nAlkpKUSCzpm8
	 dHY6b8PTsjk/c+uBooXZQhvfMXmlj7G1VtDyc0a+o8FGZg//9+VXRYt2JZ3VhqVkPT
	 WhEjkxiez2pONugapBTfLLB5XlqsipzkURfytbnfQgnykuxpu6nb13v4Z67ZaVyiXM
	 rZ+zx9c9cOcQkEXR7xtsyiowmJ+WyTFcB/wnkjaGv5j00HKJhFoTsExDSZJIrjAYu8
	 q4Wh/+l93ZkZQ==
Date: Tue, 2 Apr 2024 12:32:25 -0500
From: Rob Herring <robh@kernel.org>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org, christophercordahi@nanometrics.ca,
	devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	herve.codina@bootlin.com, Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 12/13] ASoC: dt-bindings: davinci-mcbsp: Add the
 'ti,T1-framing-{rx/tx}' flags
Message-ID: <171207914341.324604.378399290864675575.robh@kernel.org>
References: <20240402071213.11671-1-bastien.curutchet@bootlin.com>
 <20240402071213.11671-13-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402071213.11671-13-bastien.curutchet@bootlin.com>


On Tue, 02 Apr 2024 09:12:12 +0200, Bastien Curutchet wrote:
> McBSP's data delay can be configured from 0 to 2 bit clock periods. 0 is
> used for DSP_B format, 1 for DSP_A format. A data delay of 2 bit clock
> periods can be used to interface to 'T1 framing' devices where data
> stream is preceded by a 'framing bit'. This 2 bit clock data delay is
> not described in the bindings.
> 
> Add two flags 'ti,T1-framing-[rx/tx]' to enable a data delay of 2
> bit clock periods in reception or transmission.
> 
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
> ---
>  .../devicetree/bindings/sound/davinci-mcbsp.yaml   | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>



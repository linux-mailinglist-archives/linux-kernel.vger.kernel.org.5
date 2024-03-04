Return-Path: <linux-kernel+bounces-91300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76241870C88
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50A731C254BA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191135B1E9;
	Mon,  4 Mar 2024 21:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3IviibI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C33E1F5FD;
	Mon,  4 Mar 2024 21:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587590; cv=none; b=YBNZcefiO/RxkpSwqhf3p15yK1ptLA7OnSArBc/RDcZuAiUAnljq0ItXgGCuTmdtJPPgUa5fzDgF+HIxN1ODin4f7nAMV+k7MRVJWHN0dxyLbqvB3RkYlP3j65h2I0f/XKT6TUQ1xL9yRPjCS4tuHkpoMuqnGz3u2Eeu/lr3Wvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587590; c=relaxed/simple;
	bh=CzbbppJj4URu/ZwENXc/SuZfwfRp3h53NmuSsst2lhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qng4tSQkd5O4WHmrSkY4b2wKUsFXJOxWZQaVBM1YVVZ3mfHf9juECA7Y1JOmSLJuYQf8LeS7MkHcX/4NAlEiQSaXVPhkUFO25QS3xJVJ2Ez0LqEOAsukJ8glAuA11OYN8gubch0AL/SdhrQOOcxw/6p8OQ6t44LHPgeYVkti/FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3IviibI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1DBC433F1;
	Mon,  4 Mar 2024 21:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709587590;
	bh=CzbbppJj4URu/ZwENXc/SuZfwfRp3h53NmuSsst2lhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R3IviibIpF8P/rEwyPHUlxmjM4bm7oKTCJ2hG5lucAODpyCpDjyIJ1rfH+Xeztw0F
	 7vgs5XFLVSC5mmLBT5k3NYBL6tMv7CPDcaEnJlRxaa4BjqXGSfLkcnGXNtRMrfiePF
	 pA/wbX6pMCvdWKePcmF5JNOVKd9TEcROjV6BWOoQCmqcthpPKTzk50ENyRWOnl4QNw
	 exoCyPJ5B6IynansJAnBc+eVZ0lTGHFB03AX6Hl5hYS9ZtOhQqdfGdrtTD26VNAPQZ
	 Cem1whi4fO4PwuON9cUh3xhN09Flhn12xqOhXyKe1nvX4zMqzDALyPIwDyXQM4hPJ3
	 blDe15l9V0YhQ==
Date: Mon, 4 Mar 2024 15:26:27 -0600
From: Rob Herring <robh@kernel.org>
To: Javier =?iso-8859-1?Q?Garc=EDa?= <javier.gar.tab@gmail.com>
Cc: Jack Yu <jack.yu@realtek.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>, daniel.baluta@nxp.com,
	alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: rt1015: Convert to dtschema
Message-ID: <170958758740.1075337.15453587624816097337.robh@kernel.org>
References: <20240304142315.14522-1-javier.gar.tab@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240304142315.14522-1-javier.gar.tab@gmail.com>


On Mon, 04 Mar 2024 15:23:07 +0100, Javier García wrote:
> Convert the RT1015 Mono Class D Audio Amplifier to DT schema.
> 
> Signed-off-by: Javier García <javier.gar.tab@gmail.com>
> ---
>  .../bindings/sound/realtek,rt1015.yaml        | 41 +++++++++++++++++++
>  .../devicetree/bindings/sound/rt1015.txt      | 23 -----------
>  2 files changed, 41 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt1015.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/rt1015.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>



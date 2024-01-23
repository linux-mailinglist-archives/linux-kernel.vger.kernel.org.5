Return-Path: <linux-kernel+bounces-34856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 076D7838863
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28071F22717
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A5255E70;
	Tue, 23 Jan 2024 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obrUMfBg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F926121;
	Tue, 23 Jan 2024 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705996689; cv=none; b=USwqqDGcPudz8XITau5SaDTGGyKW19L0o8ZTPlfSoF8LennqhILp8iJC9dc7+yJKnGsDKIZR1KVihNSzxf2ktGpu/FGiqhGDzUoQ0Cn2dBaKuN/Yf3ckyLONKmB7lX8yLI+vllEDztMEsP80uyfjOzHTxIsor1kCxpxnQW548OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705996689; c=relaxed/simple;
	bh=E87nD93jJ+vmxbmKH7yTTktP9lMuBJ2ulmspVtaJYKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NK4lnxMOEXczzIZbQi0fSJi88lwozS/kd+CzamkzId4ElVg/j9g1Xj0I3maeo4KOkEX4j2GvKJLbhy6f0R6YjLBen+92OuaN+XCjOTL/6g0zdnmRWfzNheJVcgbKl+NiIYk4TLS/oowJ2m8sOMvx64oPKx8djmdRX/fuqStrZ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obrUMfBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3462C433C7;
	Tue, 23 Jan 2024 07:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705996688;
	bh=E87nD93jJ+vmxbmKH7yTTktP9lMuBJ2ulmspVtaJYKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=obrUMfBgK9Z0J3D4toVHkjnUI/BHbpboUTHMYupaer114w5skrzm8AcoVhyoLN9HZ
	 3Z9l9amEBJ7YJ/E5V2tNjXlehcXVsfhw9U3rNsDF31Lfl/HeVUDYBH5CwGprrwsEdY
	 VExOLl3zb/y0ZiEsJKv0EvgWVn7YAxEImEF6+f0RMiH0dzMiRvp2TZKG+zqb7y8lEH
	 LOciS4+YztgnOmsIU2Bkkjec5qlAxPeHHZg9P7pwkm6UQTC7CD50gBF9jfuiQpJqVO
	 CuiALrHaOe0eziCDFfDD5NXTFL3cBlDBZqHZwQvxkeIIZTXs2oiLiWbOOZdFyLwgZ+
	 JShGXd4cJ3UIw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rSBfo-00000000267-3iRv;
	Tue, 23 Jan 2024 08:58:20 +0100
Date: Tue, 23 Jan 2024 08:58:20 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] ASoC: qcom: volume fixes and codec cleanups
Message-ID: <Za9xnEXYczA5rsw3@hovoldconsulting.com>
References: <20240119112420.7446-1-johan+linaro@kernel.org>
 <170596045016.161959.16318695944363636291.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170596045016.161959.16318695944363636291.b4-ty@kernel.org>

On Mon, Jan 22, 2024 at 09:54:10PM +0000, Mark Brown wrote:
> On Fri, 19 Jan 2024 12:24:16 +0100, Johan Hovold wrote:
> > To reduce the risk of speaker damage the PA gain needs to be limited on
> > machines like the Lenovo Thinkpad X13s until we have active speaker
> > protection in place.
> > 
> > Limit the gain to the current default setting provided by the UCM
> > configuration which most user have so far been using (due to a bug in
> > the configuration files which prevented hardware volume control [1]).
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> 
> Thanks!
> 
> [1/4] ASoC: codecs: wsa883x: fix PA volume control
>       (no commit info)
> [2/4] ASoC: qcom: sc8280xp: limit speaker volumes
>       commit: c481016bb4f8a9c059c39ac06e7b65e233a61f6a
> [3/4] ASoC: codecs: lpass-wsa-macro: fix compander volume hack
>       (no commit info)
> [4/4] ASoC: codecs: wcd9335: drop unused gain hack remnant
>       (no commit info)

Thanks, Mark. 

Could you consider applying at least patches 1/4 and 3/4 for 6.8 as
well?

The former is needed for proper hardware volume control with the fixed
UCM files, and the latter avoids ending up with the digital gain setting
set too low or too high while by-passing the volume limit set by the
machine driver.

Johan


Return-Path: <linux-kernel+bounces-155121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D3D8AE585
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F41D1F21A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A241350E8;
	Tue, 23 Apr 2024 12:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHJePlC8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E5785645
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713873745; cv=none; b=u0aIXLVz1ZK4fvd0eojUkP4zZaDDL+5zer3rn8t+BUtlTZq6p/I91LsqZ8JA3Q7yeUP/6GRxTPggrz0PQOLIDFMhgyxDeP0LtHCGhj4C+UFpV5zaNUty2BpvUzW0UB1SYMlougnHuu+LCHLjSYNyjXZ72mftqS/9EzwqqvpfXTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713873745; c=relaxed/simple;
	bh=vjqw66gxg/k9RXm6AmFoqyNmXnRBIYP9D+Q0yn+Hl1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIWIhwvjNWB1yg882F/eYUaToUzSo7N4NwowL4H6FNLSlSb++MPRpP6q6NNFi2/wBS9lrebzWrFEMcwnO2MaAplt50XDQW52ytrcbGEoXIbLhqBl5IOdIi3HO0OzhOkV0ptL8Pjt9aNb2yYYBqrimnUEwfNPWccd7UrTTFAqk80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHJePlC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E79C3277B;
	Tue, 23 Apr 2024 12:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713873745;
	bh=vjqw66gxg/k9RXm6AmFoqyNmXnRBIYP9D+Q0yn+Hl1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VHJePlC8LmSMSnm/X7ALvprhDUROvJksMQVYLlYpEUPTnr7aV+I/Jpe3KIiJJjfEd
	 HK4/B/F97gzwuh/6eDE1qGIUFYLAym/OlZGwLYhG8Ew67iDed1sfbVDIJP+gT182sa
	 1r73mvuw+JjCxWHgKccUR33KFhYaBZ9vqq36K7bJeMXRk/mTuxzGhbeERTLk0Qe+od
	 ce9I48bSCv8hWUgFaGfrVy9eJuVa07bL3I0bsZs1iO+5eRctXGRzX/dOqHHCoRdOoR
	 nSOACPHFE21kyfrTkjcBywuVBzeGZAmr4QY++Vm7RNVO+Udi5HqCRbZTnxN5VcNQtX
	 iqgZnDkBREeRQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rzEqt-000000005PS-1iZ6;
	Tue, 23 Apr 2024 14:02:23 +0200
Date: Tue, 23 Apr 2024 14:02:23 +0200
From: Johan Hovold <johan@kernel.org>
To: srinivas.kandagatla@linaro.org
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ASoC: qcom: common: add Display port Jack function
Message-ID: <ZiejT5yddioQ8upR@hovoldconsulting.com>
References: <20240422134354.89291-1-srinivas.kandagatla@linaro.org>
 <20240422134354.89291-3-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422134354.89291-3-srinivas.kandagatla@linaro.org>

On Mon, Apr 22, 2024 at 02:43:52PM +0100, Srinivas Kandagatla wrote:
 
>  static const struct snd_soc_dapm_widget qcom_jack_snd_widgets[] = {
>  	SND_SOC_DAPM_HP("Headphone Jack", NULL),
>  	SND_SOC_DAPM_MIC("Mic Jack", NULL),
> +	SND_SOC_DAPM_SPK("HDMI/DP0 Jack", NULL),
> +	SND_SOC_DAPM_SPK("HDMI/DP1 Jack", NULL),
> +	SND_SOC_DAPM_SPK("HDMI/DP2 Jack", NULL),

Shouldn't these be split in dedicated HDMI and DP jacks too? What if you
have a machine with HDMI and DP jacks which would otherwise both claim
"HDMI/DP0"?

Johan


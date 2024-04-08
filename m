Return-Path: <linux-kernel+bounces-135349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC9889BF56
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ED021F21B35
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C176BFA9;
	Mon,  8 Apr 2024 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQM+9khF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D306F065;
	Mon,  8 Apr 2024 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580304; cv=none; b=hQvjJFP0Ne8MI9hIzzDDXS7qOlC3Fn0pS428BLIfP4LhYvxUYmgcJxwwfiZatWfMN0FSyN33aVv5JNBelakrS6j6BxcZbm2VI5dKym3rpYD9AijPxu3aedABLb90u6dwRdk08TqaQPVz2sZwxJRai5+puddyatNOsjHqeZd5QgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580304; c=relaxed/simple;
	bh=tfA9OCUUYmRBc/HfduGlcOEWNno6qBswTFUJs11/8Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwVkRI22gHFjReRx5TI/C9z1XZ9d6jhW4jnYRRk0DjWQ1ogCvYyabdvtcGclDwmn8TMN/1XJDuK/K0AUS+X+ecMZhukaYyFd98a+7B3K/2PZc6p61JbZOwW6YhGeL6mWmkUYqjEbKO0kk6Krr/I3XFviN3NQv4FBM0nvcOBwzQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQM+9khF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F782C433C7;
	Mon,  8 Apr 2024 12:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712580303;
	bh=tfA9OCUUYmRBc/HfduGlcOEWNno6qBswTFUJs11/8Xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aQM+9khFVzUOxlN8kWH6/Ua0hK+6TWyjo1t158gVxNaLnzWSbD+CfOLvDMaSVOk1S
	 p4yrEToGN4+sy2F9Js4CY63FE/qYbPlpEPkAAqKFDc6lVmM8VbDLurDOH/FQhKA27X
	 9EomU7+rrKF3MTc242A3SPlvFSFz1+ryQ8IEVea1MGYnWzCYaerP80Pt+JRbZrsct0
	 A9eNlJvr4IdSrjXtEafomf6NH64Du3w9oWDfTt6NlaN8sfVaS7WdgSC4LImuFaMc6r
	 wbsLGNYtw2H3Zhg6UYCqI2cd4Tyq1JxhN1IR6rU8a6hQCFpcacnY+KYHRoZ9T4qoQF
	 JMOE4QShg0amA==
Date: Mon, 8 Apr 2024 07:45:00 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org, 
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com
Subject: Re: [RESEND v3 2/2] ASoC: qcom: sc8280xp: Add support for QCM6490
 and QCS6490
Message-ID: <45yy3cvepk4uwi2jdmh4w6l5ac3dffqhbot6xzv2bwjvo637ss@pryzth2hghyu>
References: <20240408042331.403103-1-quic_mohs@quicinc.com>
 <20240408042331.403103-3-quic_mohs@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408042331.403103-3-quic_mohs@quicinc.com>

On Mon, Apr 08, 2024 at 09:53:31AM +0530, Mohammad Rafi Shaik wrote:
> Add compatibles for sound card on Qualcomm QCM6490 IDP and
> QCS6490 RB3Gen2 boards.
> 
> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---
>  sound/soc/qcom/sc8280xp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
> index b7fd503a1666..878bd50ad4a7 100644
> --- a/sound/soc/qcom/sc8280xp.c
> +++ b/sound/soc/qcom/sc8280xp.c
> @@ -169,6 +169,8 @@ static int sc8280xp_platform_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id snd_sc8280xp_dt_match[] = {
> +	{.compatible = "qcom,qcm6490-idp-sndcard", "qcm6490"},
> +	{.compatible = "qcom,qcs6490-rb3gen2-sndcard", "qcs6490"},

We now have 4 <platform>-sndcard and two <board>-sndcard compatibles
here.

Not saying that your patch is wrong, but is this driver board-specific
or soc-specific? Srinivas, Krzysztof?

Regards,
Bjorn

>  	{.compatible = "qcom,sc8280xp-sndcard", "sc8280xp"},
>  	{.compatible = "qcom,sm8450-sndcard", "sm8450"},
>  	{.compatible = "qcom,sm8550-sndcard", "sm8550"},
> -- 
> 2.25.1
> 
> 


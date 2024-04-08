Return-Path: <linux-kernel+bounces-135353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A59589BF63
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FD27284DCE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE877173E;
	Mon,  8 Apr 2024 12:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okB7bNo5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E766B6EB72;
	Mon,  8 Apr 2024 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580495; cv=none; b=tmz7UDBUimtCgDanCMyflKVIKYnBiQxA47xBevZi07dph1Ytg2CHIfXxcM4tUjjEVN4AdtVDzY513vIl72rta3+Fy7U2iYYjCsoFBa9tihaNeGohDEHO0LGoQsl6fQk1gsHUVlgmgMxHZ36/RbXC0OUAgU9oSoiDURhNfh/q38E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580495; c=relaxed/simple;
	bh=Q7GITuY41W3ogDYnIOkjx+esojDwuo+Bt0JnS0VPjzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FG1m2hDV/pOZl8uE7ovGLRkrtOpnoi0NufCHn83JJYHjuitAYSj38l8a9a1HLCDWFXFEPI4wQCgHJl9M1mxdC/wxER/sayoH4zeaS+JpADKGn5tDAz3YPcGXKn0enyFTteloIi+9ftn2s504uknI5o+P3maQdgUBaM3kQLJ+uw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okB7bNo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB03C433F1;
	Mon,  8 Apr 2024 12:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712580494;
	bh=Q7GITuY41W3ogDYnIOkjx+esojDwuo+Bt0JnS0VPjzM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=okB7bNo5qZMw2r34Mrz+i13VEm63qG1ebCMW7wQcxPUTwYNA8ci2544eWmPQfXj8i
	 FfBJmGDf3xOmD0GuQDstSY9GamWzd6c95SUVDdp8VG04xtFDBmXmkXTM55ZI/YDv2H
	 uxljy8Pu6aEBRBD0pFlNSCHJsYri7tHxQ0802H1rE9JndcO2lhuq/t4HEdpxhfTVGU
	 aVTAY8sBA/H/Ix0Fsjq6SWs2JO7+LDWpkslzsKeZ/IdqThbkXBR4+nO0tDs0VLbkR9
	 jz53vhcM3fAOKQeW9dcYPtk7gvU3yuCIg+HRspVTjvt/MaUhHfCABCEz/rryWKvkmv
	 4w59xnZJ73gwg==
Message-ID: <ce975ce2-12da-46d0-9e91-a417819f0914@kernel.org>
Date: Mon, 8 Apr 2024 14:48:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v3 2/2] ASoC: qcom: sc8280xp: Add support for QCM6490 and
 QCS6490
To: Bjorn Andersson <andersson@kernel.org>,
 Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_rohkumar@quicinc.com
References: <20240408042331.403103-1-quic_mohs@quicinc.com>
 <20240408042331.403103-3-quic_mohs@quicinc.com>
 <45yy3cvepk4uwi2jdmh4w6l5ac3dffqhbot6xzv2bwjvo637ss@pryzth2hghyu>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <45yy3cvepk4uwi2jdmh4w6l5ac3dffqhbot6xzv2bwjvo637ss@pryzth2hghyu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/04/2024 14:45, Bjorn Andersson wrote:
> On Mon, Apr 08, 2024 at 09:53:31AM +0530, Mohammad Rafi Shaik wrote:
>> Add compatibles for sound card on Qualcomm QCM6490 IDP and
>> QCS6490 RB3Gen2 boards.
>>
>> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
>> ---
>>  sound/soc/qcom/sc8280xp.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
>> index b7fd503a1666..878bd50ad4a7 100644
>> --- a/sound/soc/qcom/sc8280xp.c
>> +++ b/sound/soc/qcom/sc8280xp.c
>> @@ -169,6 +169,8 @@ static int sc8280xp_platform_probe(struct platform_device *pdev)
>>  }
>>  
>>  static const struct of_device_id snd_sc8280xp_dt_match[] = {
>> +	{.compatible = "qcom,qcm6490-idp-sndcard", "qcm6490"},
>> +	{.compatible = "qcom,qcs6490-rb3gen2-sndcard", "qcs6490"},
> 
> We now have 4 <platform>-sndcard and two <board>-sndcard compatibles
> here.
> 
> Not saying that your patch is wrong, but is this driver board-specific
> or soc-specific? Srinivas, Krzysztof?

To my understanding this is mostly board specific, but it is also
partially a software construct thus we simplify it by using SoC
compatible for all boards with given SoC.

I have no clue whether this applies here. I think we asked about
clarifying the differences, but as you can see nothing improved in the
commit msg.

Best regards,
Krzysztof



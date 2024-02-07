Return-Path: <linux-kernel+bounces-56472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A3284CA92
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4066289033
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1048F1B7EE;
	Wed,  7 Feb 2024 12:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hIqhqKzL"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E18459B6C;
	Wed,  7 Feb 2024 12:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707308127; cv=none; b=j3iiqTEiGpdwfyATaRonrtokACTM13PykFK1ckFRAW77F9o8vrVPv9ArDXU/C2CwXRmFXsZ/gUESER36JRJTX4+k9dpPQfaazYLoH1mJNsH3p8iMILM0DHOTZhNwI2Bxi8VYILtFVnraFA0HBoN6hphu/+IgQntdUOV+8hrfoL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707308127; c=relaxed/simple;
	bh=NybHckFncJ0KkN3jVVXoKqPgsh3dBuBh1zYR1aSYl7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kC4mrjxQZv0heh0S+ND9QQx08KkA3Qkh+NLATO1GBS5BvQocn0/n+1RWbD72z2vGLj6lBu5r1KDRPpdeDQ+t8GcnDhE6dMwv8kuXJGmwE5UYdrSTdllcA7WG2rPWgle7zwj0tMR3Aq+os9QXiIZbQ/utUdkcwg8A0rAqK8jSnK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hIqhqKzL; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707308122;
	bh=NybHckFncJ0KkN3jVVXoKqPgsh3dBuBh1zYR1aSYl7U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hIqhqKzLQgafMDRbj201qbF4xnuBIHKB1ewOafY290qM7BbS2kVtstC/8PkOIwCs0
	 JIFU4lu7LCkHUL+Gs7/Z/ZChsx4pDEdd9ZtivAddd9aiwN2gU9L3IacWe4vlF45Sbf
	 uC9RkS9RVgKO/v3D4Us8BlpHE9GyCZy1Ov8RCRhO5kaUXgNZeQPd0Gtmy5NS/84eOK
	 74X/79V+V1qxWqhJgsoLyQ8LCl6YTI2TfcNoDXyM+JqnXBPuuO/ddqW8fuaW9/tNqg
	 GWPQD8jBdWZeNUN21GE4wKkVVqLriMgZGt9fAty9+xezpsd7JPAYhnIAgRKqIRy9rq
	 4dec2ld9v9MIw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AB3933782069;
	Wed,  7 Feb 2024 12:15:21 +0000 (UTC)
Message-ID: <48aa9df6-44fc-4d1a-8eeb-0e9fdd8b8833@collabora.com>
Date: Wed, 7 Feb 2024 13:15:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: msm8976: Declare and use SDC1
 pins
To: Marijn Suijten <marijn.suijten@somainline.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, g@somainline.org
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, ~postmarketos/upstreaming@lists.sr.ht,
 Luca Weiss <luca@z3ntu.xyz>, Adam Skladowski <a39.skl@gmail.com>,
 Martin Botka <martin.botka@somainline.org>,
 Jami Kettunen <jami.kettunen@somainline.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240121-msm8976-dt-v2-0-7b186a02dc72@somainline.org>
 <20240121-msm8976-dt-v2-4-7b186a02dc72@somainline.org>
 <808bd239-6a61-4932-ab91-3dcbe10a7a05@linaro.org>
 <tz3vwpcpbctxfx22rbhdnpy7fljijtpbdlmq6jwtw3jcvcwpka@3mnyq5h5h7bb>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <tz3vwpcpbctxfx22rbhdnpy7fljijtpbdlmq6jwtw3jcvcwpka@3mnyq5h5h7bb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 06/02/24 23:36, Marijn Suijten ha scritto:
> On 2024-02-06 19:58:50, Konrad Dybcio wrote:
>> On 21.01.2024 23:33, Marijn Suijten wrote:
>>> Add the pinctrl states for SDC1 and use them on sdhc_1.
>>>
>>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>>> ---
>>
>> [...]
>>
>>
>>> @@ -840,6 +890,11 @@ sdhc_1: mmc@7824900 {
>>>   				 <&gcc GCC_SDCC1_APPS_CLK>,
>>>   				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
>>>   			clock-names = "iface", "core", "xo";
>>> +
>>> +			pinctrl-names = "default", "sleep";
>>> +			pinctrl-0 = <&sdc1_on_state>;
>>> +			pinctrl-1 = <&sdc1_off_state>;
>>
>> -names should go last
> 

Konrad is technically correct as per [1] but, for consistency, since all of the
other nodes in msm8976.dtsi are following that order for pinctrl, this version of
the patch is correct.

That, unless anyone wants to reorder everything in this file as per [1], which
may or may not be worth the noise.

[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst

Regards,
Angelo

> Per the cover letter:
> 
>      - Moved pinctrl-names before pinctrl-N (Konrad);
> 
> You explicitly requested this in https://lore.kernel.org/linux-arm-msm/60a40ace-d4e9-df74-88f9-4354d80efaac@linaro.org/#t
> but we also backtracked on it somewhat for consistency with other -names, and the general state of this file.
> 
> Maybe we should apply v1 of this specific patch?
> 
> - Marijn




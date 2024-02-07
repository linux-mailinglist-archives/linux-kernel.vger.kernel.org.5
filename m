Return-Path: <linux-kernel+bounces-56811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E8684CF8E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ACC7B2873D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC6782D79;
	Wed,  7 Feb 2024 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="R5Fi9UGL"
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE46823AD;
	Wed,  7 Feb 2024 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.103.80.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707325973; cv=none; b=PKPqh9I+SsRulYXgE+Jpq4LT1g+XNkAyeH2vYCZz1ILFe3IHj8js9qZQNvyZDIfAG615LNLNpHbpcFyCvm/YdbXHkYKYBdPsYqoSDR8y/G4iut6e1UVKNu7mtYnKXR6HpNU/blXwCpPd5c9FuaLeXlRPAPXhOsvnrOWdq+jFc7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707325973; c=relaxed/simple;
	bh=4thBBmqk5hlMpmpcQwxAA3u0nkyAH6ntKflK/ok1k2w=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=q4wfvhc6mb5JgRt89Cr1V3+1AtBjCvvhsSnRNs3yVonZPTUeAPy0ko9RqK+V/tyF69LGiYBM0rlKOBvrUOmDmMWTTVolv8zNHbzW6TcEtmzclzTl+pyfHs5Gj5TfpiaBKOkTcF3792FgcpQxHfcLUBDvzv40J4ll74U9+iCEF64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it; spf=pass smtp.mailfrom=vaga.pv.it; dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b=R5Fi9UGL; arc=none smtp.client-ip=212.103.80.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vaga.pv.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaga.pv.it
Received: from localhost (unknown [127.0.0.1])
	by mx.kolabnow.com (Postfix) with ESMTP id 9AEBA2095C06;
	Wed,  7 Feb 2024 18:06:15 +0100 (CET)
Authentication-Results: ext-mx-out011.mykolab.com (amavis);
 dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
 header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
	content-transfer-encoding:content-type:content-type:message-id
	:references:in-reply-to:subject:subject:from:from:date:date
	:mime-version:received:received:received; s=dkim20160331; t=
	1707325573; x=1709139974; bh=aHIWuq7r2wmuzrEqiql4mNGKz5wCpRsiiSb
	LoRj77zU=; b=R5Fi9UGL7pdTdbdeeNB5OrOOKQeYcBm9/Rzpc/6Eh6lkBI8oMia
	Iw3+ERv1gMdlWmT6gal0kYPE/6D0biQ0b4GIjPgE/JR6PejdxaVIAM3A2rMl4AtU
	3XSNxQqB2oW7W2VwX4lvn83SzpbJhxfpFilCoxJyzKCP6NAi9aTHDVMh+LWR5Hfm
	yxwDVW9vlOZfqn8StEbMJaFdze7wRAbLb9E+zBJh8oy3HzV6hcR0QyFdk0i1cx+O
	sLEa9A/PRmAGVAWkmN/kw3SXGjkA+YNURDcxQYoVdZrT2Sbn61H1wR7nnlFwSt9C
	JkNHWbIjEcs9PD42lCieDCC/ktL6ICQM/bmjc7CNQ5kyUY92ddqxxGkROf1LQ81V
	OqcX5uKL8KfolAyHCKkjVebeBsvddCR3z5dccMeZFhACV/bKl3hBNGy8FETNfH3/
	WcxTJ4imITNRM2npmrVrcSulCbAfFqOLUFsZp/0sEgPSzEoYEyHzTdfMCANAnc2W
	11QPr0+VTKDp8/DOSN2tygE/W6CYo9ksnQWMujn+LVsIiqNtzKBSwCN3zJY/8Q+A
	3zLqEmD5FIijSRUUaOnYGLFoYIw+GTlQj85e5GMn7rfroNVNPTUdx08MJ1p6PSNI
	tB82lO7sNh8SDt5ns4fwTSWKzaCkyWAWFOW/rS44Exg/a0rlus8Tha44=
X-Virus-Scanned: amavis at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level:
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out011.mykolab.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id D36b_ffzchBX; Wed,  7 Feb 2024 18:06:13 +0100 (CET)
Received: from int-mx011.mykolab.com (unknown [10.9.13.11])
	by mx.kolabnow.com (Postfix) with ESMTPS id 51C8F20C81E3;
	Wed,  7 Feb 2024 18:06:12 +0100 (CET)
Received: from int-subm015.mykolab.com (unknown [10.9.37.15])
	by int-mx011.mykolab.com (Postfix) with ESMTPS id 0129C30B0233;
	Wed,  7 Feb 2024 18:06:11 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 07 Feb 2024 18:06:11 +0100
From: Federico Vaga <federico.vaga@vaga.pv.it>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc:it_IT: fix a typo in the config name in RCU torture
In-Reply-To: <20240207150322.20238-1-lukas.bulwahn@gmail.com>
References: <20240207150322.20238-1-lukas.bulwahn@gmail.com>
Message-ID: <c7917018190d71e6ebecd91ce81f5f2c@vaga.pv.it>
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Thank you for the fix

On 2024-02-07 16:03, Lukas Bulwahn wrote:
> This issue was detected with the scripts/checkkconfigsymbols.py tool.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  Documentation/translations/it_IT/RCU/torture.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/translations/it_IT/RCU/torture.rst
> b/Documentation/translations/it_IT/RCU/torture.rst
> index 79d9e6932acc..189f7c6caebc 100644
> --- a/Documentation/translations/it_IT/RCU/torture.rst
> +++ b/Documentation/translations/it_IT/RCU/torture.rst
> @@ -129,7 +129,7 @@ Uso su specifici kernel
> 
>  A volte può essere utile eseguire RCU torture su un kernel già 
> compilato, ad
>  esempio quando lo si sta per mettere in proeduzione. In questo caso, 
> il kernel
> -dev'essere compilato con CONFIG_RCU_TORTUE_TEST=m, cosicché le
> verifiche possano
> +dev'essere compilato con CONFIG_RCU_TORTURE_TEST=m, cosicché le
> verifiche possano
>  essere avviate usano modprobe e terminate con rmmod.
> 
>  Per esempio, potreste usare questo script::

-- 
Federico Vaga


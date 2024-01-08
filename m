Return-Path: <linux-kernel+bounces-19157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BE98268E7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485B81F21E63
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4015C8F55;
	Mon,  8 Jan 2024 07:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKRlJNEt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1123F8BF9;
	Mon,  8 Jan 2024 07:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e7d6565b5so1479489e87.0;
        Sun, 07 Jan 2024 23:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704700301; x=1705305101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xB6dTmy7PPONUEqk9zrc11jGA1ahX/VsK6NLrJv8Ibo=;
        b=BKRlJNEtsvPUNZqxMDLldvZ2I9yer42F1wk1zk2OGsPvzgcyZ0OFzXi59a/VtulcD+
         2TZxNEQcodsHICX2wWDVrCnimvEjjngqYgTOOges0lE0DUgemupWAKkq9o2DVW8dbZxY
         ojHI/mnfy3hvM9EDglJCDqOpXGKV5g1Dkx8eBgn9ArHNfrWOmZnSYYakzReVNw9rjWtR
         MNYsV9Edoiyk5lzNp6OnO8vUUvcztmzG0/PhqkUOMtwF+yvrb7WZyUAUBGgh5HfbR7MS
         TmyzFLzO+vH0qoW5bGnAIHf7yTBX7YD8/DiwqGf2zvZDmM/5v9yQlNuTDHBnBOnDdGgF
         WQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704700301; x=1705305101;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xB6dTmy7PPONUEqk9zrc11jGA1ahX/VsK6NLrJv8Ibo=;
        b=e9eSY0V0+YSadMZUeE69lJXAzJaomJaEsNwTFAVUrIKtCejd1/j5dWbyGBsnedBxPc
         EO6QIMCIVSWC3yaP50JdnaL/eFxuWktJGRfmsCtltoPxAVzCVEto+XSMMV0xoCCEMtPZ
         MRbprn9LrbnA8V1PamZWhYuh6x9Bd9QbbqGHYJq7DSky3364SUXnbjZ1iAzh2ORRSRrr
         3CYPxUe1DSkmFqdCvs5ZN4HJMdzy34NeKenzgDV8GGZa9yOwDBbVsUCRUJjafo8awTCl
         Wr7XWAm+KAEwI6Vje/bTQVmv+CYoQJxnpcICFIm9GPIdl78O7sSg1lOyVqP2ZieGveTU
         OI5g==
X-Gm-Message-State: AOJu0YwVSxJPyybbZMu5HeJvw/xNRAFv4l0qPg+R83vbBzFeWF6dn0xf
	2UDQ3JcXPE/zzpVud2CRTLw=
X-Google-Smtp-Source: AGHT+IFgZcByQqbr97652HkUV9fLE574WgqqSfXCYtLKE0ke5xjsGHFQbJJlJSSp27L/fI7gvAQaBQ==
X-Received: by 2002:a05:6512:48d1:b0:50e:7a04:2229 with SMTP id er17-20020a05651248d100b0050e7a042229mr1196568lfb.25.1704700300833;
        Sun, 07 Jan 2024 23:51:40 -0800 (PST)
Received: from [10.0.0.100] (host-213-145-197-219.kaisa-laajakaista.fi. [213.145.197.219])
        by smtp.gmail.com with ESMTPSA id f26-20020ac2533a000000b0050e7a97ae32sm1062227lfh.78.2024.01.07.23.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jan 2024 23:51:40 -0800 (PST)
Message-ID: <20894f38-2e35-40c7-9e6c-f1b7f375a030@gmail.com>
Date: Mon, 8 Jan 2024 09:52:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: ti: Use devm_kcalloc() instead of devm_kzalloc()
To: Erick Archer <erick.archer@gmx.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240106162752.18599-1-erick.archer@gmx.com>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20240106162752.18599-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 06/01/2024 18:27, Erick Archer wrote:
> Use 2-factor multiplication argument form devm_kcalloc() instead
> of devm_kzalloc().
> 
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Can you fix the commit title to:
ASoC: ti: j721e-evm.: Use devm_kcalloc() instead of devm_kzalloc()

and send v2 with my:
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> ---
>  sound/soc/ti/j721e-evm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/ti/j721e-evm.c b/sound/soc/ti/j721e-evm.c
> index b4b158dc736e..d9d1e021f5b2 100644
> --- a/sound/soc/ti/j721e-evm.c
> +++ b/sound/soc/ti/j721e-evm.c
> @@ -649,7 +649,7 @@ static int j721e_soc_probe_cpb(struct j721e_priv *priv, int *link_idx,
>  	 * Link 2: McASP10 <- pcm3168a_1 ADC
>  	 */
>  	comp_count = 6;
> -	compnent = devm_kzalloc(priv->dev, comp_count * sizeof(*compnent),
> +	compnent = devm_kcalloc(priv->dev, comp_count, sizeof(*compnent),
>  				GFP_KERNEL);
>  	if (!compnent) {
>  		ret = -ENOMEM;
> @@ -763,7 +763,7 @@ static int j721e_soc_probe_ivi(struct j721e_priv *priv, int *link_idx,
>  	 *		   \ pcm3168a_b ADC
>  	 */
>  	comp_count = 8;
> -	compnent = devm_kzalloc(priv->dev, comp_count * sizeof(*compnent),
> +	compnent = devm_kcalloc(priv->dev, comp_count, sizeof(*compnent),
>  				GFP_KERNEL);
>  	if (!compnent) {
>  		ret = -ENOMEM;
> --
> 2.25.1
> 

-- 
Péter


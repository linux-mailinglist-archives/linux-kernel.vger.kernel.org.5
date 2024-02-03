Return-Path: <linux-kernel+bounces-51266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC24848881
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 20:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76FA1B214D6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF985FDAE;
	Sat,  3 Feb 2024 19:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bxwqdKhx"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132F15EE79
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706988269; cv=none; b=HPOkkyIIwn6tKSTiB190F085bRClGpP+tOTJ4TSJckBH4Ewhc+UjHpbo068URYFu5Go3g3DyY8HdGJSwmiFMUmWDzqYcHGRqg8SxeRLhwKDCsTIgQJqF0BVNO3rgJl1krftCPF2Ca+WnwEFmTnlfGTGZRBkYdLF+jjlGEd2yXd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706988269; c=relaxed/simple;
	bh=G8zdVE1C7ydUD8XZ97hPNR0zsmJUmtFW7X4zyOxFuNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XbGXtLUvYEIELDKMnwxiMOkiwxufuR23r5Wusbye55QeOnp2QK/ZFc2Hft2JhwlwztJKk4CUFiRb7mmfyBCp5t2gHBzf6n08is0Ezfo3QCLEM4I7XTg7wOdMcmoAGqaI4tM/CoWwN4DJiBSaUokVVXFr/sriffv3xbhjdhvUMgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bxwqdKhx; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a293f2280c7so423516966b.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 11:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706988266; x=1707593066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aYyj1uk/bgka7K60dsvQj0Vg+7bcMyN2D6pY6lowqws=;
        b=bxwqdKhxXwnHoL9vhwOJkvCwODwkAOCRlNroAb93y8foMeM5AU8mJb1SRS8Lpz2XwQ
         ekKOoYwRnqyITsmnd20GY+T3kFM5Wx5AFPM3oGwa6wPqt0V0YExekeH0ubeepxwnO+Ac
         9n7KcZeP2NpZaJ+hBMGTOZsPynI7KprKNybGaChhLMmZTv1wApU0Dmz/7WDtTHJkSVZv
         BMiy8qXq4BDMPJckb900RjJQZgJwMNMhn5I8ptPueV+E4ccky1/hM36LMNB81zGKesRi
         9rp6wIR/ySzygBoy1nSJoTzzHBExXtINQLeGRndZIHX4wsPd3HDZXWEkv2PAMhW0X648
         eRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706988266; x=1707593066;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYyj1uk/bgka7K60dsvQj0Vg+7bcMyN2D6pY6lowqws=;
        b=AVQxUVxu9dJ98XstC76DzWPyfJlQDRwLJRNTnOGjYntLD0qk04l8PMspgeeVSFOuUF
         8LlNCFQSGp87jeLl2ZO4SyQckAoKuYX92ig1riwjU8IcyTi3RXppDHCrStSnISibeIy5
         IEjMRvJ68f/sYOoUh7dfvsKKF9LEyjpfs5F79fRyKxWgA6hBFGOwwssGdCFGoG4Ee9KV
         uG9cala1tlgB72OlssJ3NwYdKBWPID5Ou0FdESUxZdE3gHSjb4Pgy3Iw3VtzTA4JKoV3
         vKmnznS5o5zkruHz7+A36lsUGzSpAs4wf2/nMNrR6cOQDzxGdpthg2qnDH7gPPjk1fAt
         R1mA==
X-Gm-Message-State: AOJu0YzVFPfmRoq+5R8I/UcaYjKycH49oiqLpLY0jRs5IQQOlJeva4A8
	yRDJAVEdl6CfL5O6LhUaoBTvipSnQtsM5H/MKEXQketbeZYOzmLeIEt0ZMPep6w=
X-Google-Smtp-Source: AGHT+IGvR9LKsSROg0vpuwzzR27AK5HCLj70c2eyTDeffZJ4EzTgVr4TzrOB45CpWlLpT+s4khs9iA==
X-Received: by 2002:a17:906:28cd:b0:a2d:bc90:de6b with SMTP id p13-20020a17090628cd00b00a2dbc90de6bmr9239898ejd.30.1706988266093;
        Sat, 03 Feb 2024 11:24:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWOGQGuPS6JhmV49+IfQSP2ub32BgRRDFILPLp3L9YSIWGnGSwpIw6jlPDG58WT/he83843xoHLR67nFNCnpfCCRcoXNjgHr9hdAmzt4gwOiJtsouELe2I5ro2Ag38RSxwrH5xvNRYqL8S9pjQx0Wb0ydy2nGDQ3kEz+c2WgWsGYjsgAtYCvxtrKwGgVSUi04lj7HlznA94nVpvQrXXrGXdO3qnPOIGXHlC5XVEAjU2wJ1AOifpg06NSCl/Se0iu3L0OqwGnUYRatY5
Received: from [192.168.159.104] ([37.8.245.233])
        by smtp.gmail.com with ESMTPSA id gx2-20020a1709068a4200b00a35ed4fd4cesm2296206ejc.115.2024.02.03.11.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 11:24:25 -0800 (PST)
Message-ID: <33e6b6fb-4450-489f-8a7a-5840033df6e3@linaro.org>
Date: Sat, 3 Feb 2024 20:24:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: sc8180x-lenovo-flex-5g: set
 touchpad i2c frequency to 1 MHz
To: Anton Bambura <jenneron@postmarketos.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240203191200.99185-1-jenneron@postmarketos.org>
 <20240203191200.99185-6-jenneron@postmarketos.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240203191200.99185-6-jenneron@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3.02.2024 20:11, Anton Bambura wrote:
> This solves the issue when touchpad gets stuck on right or middle
> click. This also makes touchpad working smoother.
> 
> Signed-off-by: Anton Bambura <jenneron@postmarketos.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad


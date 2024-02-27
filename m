Return-Path: <linux-kernel+bounces-83267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB97869100
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3B1285296
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF3B13A895;
	Tue, 27 Feb 2024 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYdqAWsy"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4A61E535;
	Tue, 27 Feb 2024 12:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038479; cv=none; b=IoxcSXDwcRQb/0XizbTAJIyXq6EbRB9ZCrD3NazY9a4B0jG9UoNItwyqgs9q2+R4CArpcnoctb0Bt/cgickxRetZAQSdOi916LyxB/XDUuKaKaHLDAlFK4a8QL0VlzsI+4e+HVvKVjJPpzK9RmZ+8w5nmRsSc5YxaWYvq2W51tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038479; c=relaxed/simple;
	bh=hzcl8ETz418dMjd6G20Lpf/mTOdZjZj2Qy8qFzLW91I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+ic8ilC9Sru8fJo7ZPc09KN2IDnfjIcQF4HJjmdMTqzU9uNhzMWy1IzxvdEekFH0vWG5fIOkEYG67qPgNc8ZqxKK1dpXK5Owp3oZgD2AhuCFa6TobRmjUv2kiCmGfsrtDj7nR9BbsIeV5Yyam6HBz11c6NuSLRIUbPUhlkP848=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYdqAWsy; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a293f2280c7so633615366b.1;
        Tue, 27 Feb 2024 04:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709038476; x=1709643276; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fu6wnvLt7SL5MDp9Rtohqbab7bq75miqKe0wHBxnz5c=;
        b=ZYdqAWsyIqS2Nm+mxy/HDSGfFg28D9B0Tt/VF4lYYN28MGGma5Vw4Dt6E35440rOUS
         X1DLhVxL5PTH0k5tK7ua0/SFUrjHZhadA6orsXu6qwSxpYPlFUQHCGyPp1HKRwrLJ+Bi
         Oom0HI+gJjjitXCa1fLMijynOKiM4h4rVrMCOlNSwFcupEJSTR7jBhMC3K67PrI5ee0t
         eb2NXvHS2LPwfj9c1rm3d/KDT23IGFIrnW4/GOQLkFsw8mE5swkRb8GCJ5h+EbpgcpB7
         oSxZxVIrUgcNZS4ruIOkNhEdD664AHdRoGqwAZugx0nhkg/S5hXapJkpU5Q6fVRYLcNS
         4F1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709038476; x=1709643276;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fu6wnvLt7SL5MDp9Rtohqbab7bq75miqKe0wHBxnz5c=;
        b=rP24YP0HlrmJTFLIsVr/gODl8AD625Vdsruoco9HLSEkfPeTjO0Lqza6YFRVCqlxQb
         AdeZ1k1Griv8HYPMBWSfap+opW2obRO0x+bYDco4OxnHj2b6gAd/Akbg3Job4EtVRhvp
         Lo5uYS4UwgtFAjlH3vPtXaubgmeEZEHMRaOIulmue2KkoJX8wrvj2oygXFVA79sxrYxl
         jFKwODaTkK/mcp5A/QnKiWhnITD0c84Iv4su+ChVVqC8Mz5QDEXplDpcDTgE0ISrwkto
         F5s/iw5NKdeCcGEsurdOJisEsKbQgrtOwLSwOZbmEm6Uz1ZFEtkeygr4msLrgMWEuQ2e
         g1vA==
X-Forwarded-Encrypted: i=1; AJvYcCUjHKhW71y3mq+2k0dvDETjWUjy+wNwdqjDCU83rEqTPndo/Iiz0rBXzoSbcvwLh+hsn4+x9Osn5R6yz9Wwrms5KO9GbzopO2+qBikSSQ9+xctbFO5t57ggK9w1Iclu8TKtrlhwurIH8w==
X-Gm-Message-State: AOJu0Yymxk8EiUBMHg1sn9qeE/iDLcRhd04JJ2VqmqkvvvnbSSuIIfy8
	KgOoxPdBcqJnCNXeWhUKEBKF7QckEHki4QYGdtHrjrQyKceLLMB2516HQ1JTPPDfsjfHg0UKF4G
	7Ehm7uIpfI0hNNd2KYhLVeMoSqKc=
X-Google-Smtp-Source: AGHT+IF4BkL4UQx6+4pVk9ZzaBlJ7bwex+QDUbRui4NuhDaik48pgZL9E2yleH+qiS3w9aoTwufqHq9Nmlhk7ZfBnLY=
X-Received: by 2002:a17:906:35cd:b0:a43:2aef:b5ea with SMTP id
 p13-20020a17090635cd00b00a432aefb5eamr4451060ejb.66.1709038475924; Tue, 27
 Feb 2024 04:54:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227123602.258190-1-javier.garcia.ta@udima.es>
In-Reply-To: <20240227123602.258190-1-javier.garcia.ta@udima.es>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 27 Feb 2024 14:54:23 +0200
Message-ID: <CAEnQRZD1chD+14iFc=m1zY17rEQXGB9AQTxLZnhcPg7VVmR=PA@mail.gmail.com>
Subject: Re: [PATCH] Convert the Imagination Technologies SPDIF Input
 Controllerto DT schema.
To: =?UTF-8?Q?Javier_Garc=C3=ADa?= <javier.garcia.ta@udima.es>
Cc: daniel.baluta@nxp.com, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	alsa-devel@alsa-project.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Few comments:

Subject should contain a prefix e.g:

ASoC: dt-bindings: img,spdif-in: Convert Imagination ....

Also do not add a '.' at the end of the subject line.

one more comment inline:

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/pistachio-clk.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/mips-gic.h>
> +    #include <dt-bindings/reset/pistachio-resets.h>
> +    spdif_in: spdif-in@18100e00 {

Node name should be generic:

e.g spdif_in: spdif@18100....


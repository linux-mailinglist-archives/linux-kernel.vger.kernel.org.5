Return-Path: <linux-kernel+bounces-161791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 739008B5152
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95099B21FFD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5BE1118E;
	Mon, 29 Apr 2024 06:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Licry87w"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AEC107B6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 06:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714371774; cv=none; b=XNwkm5qQh/sRgZga7DkZt2M364YuI+Mf2T8efXr+zoolAuVXP4qs92+3eB7v+ooUi7XCRBDRyBw4joUeDMHgXr+PIwn8Q08q94hvHyQdnuvNEqhtnVhdfadQmaIA4fmVbPxvmF9mEI1a7Siz3FDWDFxAjdOZsAhq6LQWKl/hKdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714371774; c=relaxed/simple;
	bh=Wxkj73nojrFJVGZO8bfPeoHUNWao2nESVl95v8stghY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UNBx+ELMGwytbOf1Np3xaQMcZ1B80xmmFO7pswhkdUVypHLbVcR4vHRsd2lcihcqVwUj8njYB3zwgvmLZEaHQwNzacld7vklfLFewobuHoQf6/DOCn4kWVmMPsOLRFRWleGQnLs1YjpMF6RHg8zZapKyfQBz6VlY6lAayKZGwI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Licry87w; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a58e787130fso241940066b.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 23:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714371771; x=1714976571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xsUQ10bmiOuB8gOZuiJVxLsQRkrCTf/s9QF/0Zs4sL0=;
        b=Licry87wsEgn4hFZqRrnKnPncTyGJeb72gfWYV4JrjKrjHgnS0M8QrGLs+AmuLI1o8
         01SbcstLqaYtTlSP2Bj5dvbvtg1/rkGosb4aIQd3++ftY1KyGvUJPynwwb+r8x0bSBHH
         HWYjJTe/d3JBDSd8q+ASiNraarmFMo8pxQmA7FtpfD/HB1BdxGQPdKxUyLq843wolJRP
         1P3H7Hds2F7tbSA1kGZrY2fwj6P3nrry2A2Jd7/y7D66GTdSfIV+AvxDdDkhy5JwW9E6
         h4ly0NSFpxjieqep9RhniWL0zpO9IeIDMYKB9T8ESZ8gzxH/pS58nA7a34JQHHwNEKHh
         NFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714371771; x=1714976571;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xsUQ10bmiOuB8gOZuiJVxLsQRkrCTf/s9QF/0Zs4sL0=;
        b=P8eDgOd3tLzN9ni1nT0kANhTj2gRsNiT+Oz9BYjit+doIWRUO7bE9KEVDJQOH7MlY9
         G+e+lUSMrGIlIQHg6rxuyDpmtuKl/lppwTcXgdb2GD2phQh0K2CHV4UqjAEixu9RQrlU
         47sGh2c1way+XsIgwCc4eR5JSIqN8FyqJNTqmaJQABKq4qdQWqVoe1reOmlwZf6tP+AR
         4PeswTG5EWQ2VVP4t0bGgqRVz7rB8K0VqAACmMo5TzSk6ZZScaTpDGhMGTOXEC3y+PAV
         ALpSW/Mx9tUSmYNrzaZtzwilKiuS3wVSdFLKLDng3R0DLt+T0DCZ4dfssz6THqsmzUfI
         +2tA==
X-Forwarded-Encrypted: i=1; AJvYcCVwrex8icbGx+O2eXnU7XJCK3P/FVwVtS/665B2L/pWgKlMawujsv28AlKJmwDuS3cGjxNjwH9RFDJJrr62v0Y06Lu39FHlE5KXxWqM
X-Gm-Message-State: AOJu0Yxcguvg55Z7E9A/LJK/ioNCuBChFKMbUgRERJ+dqi4LDjyTBgmH
	ukf58yjrkQWpp3nA2cPBt9Xy49Kgq4ch4Bcwc/+cs+2RjUk7Fp1Sq8Tgv4Ak4jU=
X-Google-Smtp-Source: AGHT+IG0CERJgpPfVPY8KThpiZZB6NyQ2RtI/GfjV7w6rdbkj2iW4i9+hDt+/78NFbI3EKMkNyZQKQ==
X-Received: by 2002:a17:906:e17:b0:a58:921a:970d with SMTP id l23-20020a1709060e1700b00a58921a970dmr8131293eji.6.1714371769106;
        Sun, 28 Apr 2024 23:22:49 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id z2-20020a1709063ac200b00a4e1a9e1ab4sm13468722ejd.157.2024.04.28.23.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 23:22:48 -0700 (PDT)
Message-ID: <35b5361a-78f0-4a9f-b7af-993d09169572@linaro.org>
Date: Mon, 29 Apr 2024 08:22:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: Drop unnecessary quotes on keys
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>,
 Michal Simek <michal.simek@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 linux-tegra@vger.kernel.org
References: <20240426202239.2837516-1-robh@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240426202239.2837516-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/04/2024 22:22, Rob Herring (Arm) wrote:
> The yamllint quoted-strings check wasn't checking keys for quotes, but
> support for checking keys was added in 1.34 release. Fix all the errors
> found when enabling the check.
> 
> Clean-up the xilinx-versal-cpm formatting while we're here.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof



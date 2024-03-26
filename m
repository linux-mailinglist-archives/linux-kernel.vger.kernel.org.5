Return-Path: <linux-kernel+bounces-119948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B849188CF4A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99C11C67185
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B288A12A17D;
	Tue, 26 Mar 2024 20:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BGz+873r"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D101374E11
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485923; cv=none; b=fc/pNO5yJyc314LzUwnNoJmSgVAmzcsRxQ7nrDd6hBp7t2gxsKNC1L86mlA9WrPeX+u0lGf7sKbBZ5C6rAHR7jykjn72oPALM/W2wpCd+XJuroZ6Jhfo4sZVepLR66i/RVKzSHF2dnIc2ajn1srx3Mh0gixOPW6YqS3gMtkqTaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485923; c=relaxed/simple;
	bh=bKXbnOtJYrdlG3PHh8HDEB5z5LJ6iIjYT610bIiPvVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=siTzN8nz2S7V9RjPDuP8q0nlX2YM6ANvByVLYUrtoD0pmuIH/cYnvNCuPQpUHJojvA+RhgKpsPk1kOXEZAo4s1Ix11zVLSdR9GvKPfIw/SePe5ecq/sk097Xyxl4fNXYGRVmRh/0jwVLLlP8pRF3Z4nxNHWe3TSks2AAQFsoROg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BGz+873r; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56c08d1e900so3624554a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711485919; x=1712090719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jd1p+UCPXhOO4ogs196NyusAYt2QT6k4NT43IJKJnyQ=;
        b=BGz+873r+uYvWdeWTZ8hpSlv/pwErwgvtHrxMPcHqrYVVequGqx/igqnic9p2tiMf0
         FFygYDx1PoVVvEeBqLFLMlcVzNpEa9zQiQq6zZX59GCOdCG9DluFtjSWkWbucsIKiJJn
         sQvYhydH3LfMVGhObZ4tO1Y36gKvpUJSjwXDrO5VxL3jGweQiZYWFny8hYvEthHkWFYG
         qkIbTJwIiTW8C7dNdeXltLTUljieiTGhfaW83VmTpT/mr1+bxe/aPPr/tD2S+fyN8+D+
         FKQC3lm3y/HDLmvNcBG1g4eLbPiEIoLfTmro5hKXvm5nEBGT0rTlmk80MPNxri3KqF2R
         ezcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711485919; x=1712090719;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jd1p+UCPXhOO4ogs196NyusAYt2QT6k4NT43IJKJnyQ=;
        b=lr31Yx/mmGUvuC2ScKODDCeXNeTDxRDGuz+3zGSCEu58ffpe/xotI7h4o8DN0rq+JK
         iIVIZkgy2KUzB9ZVRyB5egPmp0/RyAb91NjRM//ovJnCxpbLSl3zcnTHSBljSeEw/XAL
         JyInDSvTC3a1yo/g8BuhCZnxl0O15Ih3+e0M0CCyvpcVLC6MvNp89zdYAK3xJ126ofYu
         PBu5alN6S/aX46PJ2vcZXeZQ8GIyLsYuzxUrUqtC89Y6vbUpgHn4lmvr812zODjO7zvX
         2cTDA8Bm6rqtPp/+FeZ/0NLaSJiq7Hwzref4nBJHH5U/rtxT2PGl2iZw9+xbRg/peP5g
         su1g==
X-Forwarded-Encrypted: i=1; AJvYcCVcXY8lAVmAk0FSoEQ8ha+RrKD01rizxeDxF2V6C/Sdra/lkg1K84ZLdCz4DMIdpxccZv/MJS080Arh8MTAm+7h9i0uNmnq5oH03BQt
X-Gm-Message-State: AOJu0Yx6iM+7GTHkWyRUa+FuvVj3dkktPJp5rDTRjsJ8etsb6y1rOkgn
	TAIv4x7S/WZN/DRXDXtho5z36LuiUCIuVxw9oRF1X7cSbJRowA18/2haL0ZdPP0=
X-Google-Smtp-Source: AGHT+IHTpSvPq0BzgDUrRfmAXwsJW68zOOnR0J+5B4NsMGX+LBaW748FkLH7jX/vwcpWP8uWJ9F2qQ==
X-Received: by 2002:a17:906:716:b0:a47:53b2:2042 with SMTP id y22-20020a170906071600b00a4753b22042mr2891726ejb.2.1711485919021;
        Tue, 26 Mar 2024 13:45:19 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id e21-20020a170906081500b00a4df251a601sm1203408ejd.77.2024.03.26.13.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 13:45:18 -0700 (PDT)
Message-ID: <e97918b3-ddc7-437c-a9e9-36131366a0e3@linaro.org>
Date: Tue, 26 Mar 2024 21:45:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] clk: qcom: gpucc-sc8280xp: make cc descriptor const
To: Johan Hovold <johan+linaro@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240326140108.21307-1-johan+linaro@kernel.org>
 <20240326140108.21307-4-johan+linaro@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240326140108.21307-4-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.03.2024 3:01 PM, Johan Hovold wrote:
> Add the missing 'const' keyword to mark the Qualcomm clock controller
> descriptor data as constant.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad


Return-Path: <linux-kernel+bounces-105175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6B287DA13
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 13:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A045B212A8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 12:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A84217BB3;
	Sat, 16 Mar 2024 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NcotFaW+"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E5C18AEA
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 12:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710590894; cv=none; b=AbELnKZjbPkHOo2Acn+33HMCp6zUBIlZ5mb1dHZF6jYd4HCAcm610rJZrPvTrEbusFc2l04pDbHJTYV2OUBg2v50SeXzd6sZubPXiaxSikb893M6D/VyhCExwluvrE7k/QHI9H2v/e+Uj37NuuaJg0KGasHtJ6vVzFpJX/pBRPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710590894; c=relaxed/simple;
	bh=lOLo/MNfzxLJ6WfvIA5d9qx+T0I5n1LR8XctpmkR9ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejdkeijP/+O09lDPlLzp8ShOrnGpocgL9fwoUJ00/47kUZdW8hJhYu0bOs+OZgcGDnSmAG4J8/U2eeM6fcayBSD7qrrReqlAsaxB4Sd+4eaPxWvBg5EyUG+zKEJIx1vQQXKjD+oz0JqDKrY3VIo1qnFWlJxUmB7jXjtICBnAo1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NcotFaW+; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513dc99b709so1536950e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 05:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710590890; x=1711195690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gBQn+4o33fa3usgQAoaNIQyP/sacMzy6onFIQRcXAHA=;
        b=NcotFaW+G94GjGNVkaWkCZowO6sJj2gkN2YMVr9CeF41mGQosp9pUY+g4oVnecetz5
         pJc3IxCVxTN15FUuTEb7Rcs0Lb83FD08R6zEiHpJ1JjgvuwuGzvI8fDuxtHMLst/jdOu
         vRLOOddnYvCJUwgtfQ3Hj4Id1Ct2cfGwpMtqbZyMRC7ZDdz1dwQ32+dTtrG4nmABhRKu
         kiSy/gR3hgGSm83kC9Fa/f31xU8zDOw6QKkzGbPPdJa4+sZcIt2CtyxWZujrmZvtNG5q
         jAzAB4JZDoQHG7uU0oVwDzHJ5uhnIU78Z5ZSBj5BkahCgW0Cgf0O9Y8kW8Pn2YTqvONl
         Wg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710590890; x=1711195690;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBQn+4o33fa3usgQAoaNIQyP/sacMzy6onFIQRcXAHA=;
        b=JJP+PIKczHJmhY4uLfc9FEuteu259PFGVgeWyZqUUASWDpFyjdgeFDslWf8x3X/Cqf
         TRlEwRAG2tgLbTO8aS2oQ4uQ/flj1Uwo5vmxMzvR5wvX8zTzdEaZBB1NJHfg2blnIGui
         d1l8UyXOHVj5uUM3fppjPmXV7+WDO+X5v3sTgpva+L5qEe0oaFE9Mbf9n5kin0CgMV0Y
         aQvp7vp4fM0usGu371oo2Mqoflq0sOLYVdqawb88jXdPOpM58DQliej7rzboYCO+tJMO
         EMNH0sJDnWsqgBG9z27fmrsFJg5xHybZwP1pGrsnLJ5qOnbBTYKEkhyTXhbS7bOktChB
         73+w==
X-Forwarded-Encrypted: i=1; AJvYcCUSZtPOZ/rwvTqN602GHEOZ3xXUKYTo6F+Fy1NNPZqsnIn+03yKkhcORqenD0rhbUYBkYxIdNffwsdZMjRSzqt4QTV7Hp+0IoUJOS7b
X-Gm-Message-State: AOJu0YwcJuwkzTUTf282+DUoDqz3O/ZZs1YCA2IuMhlrBBSCXF2FK4ww
	qGcoOn8cANbIrK+UmNLUZL4alUxFLU/cI/5llQOPkMXjwlA80PD/qaplyhmUdSc=
X-Google-Smtp-Source: AGHT+IETHhE2krTe+L4sEOdBQlVRhR0BCKoPhwiB4W8KP8W6cMoFtA095QgnuHEnxphTSkhsDSmAAA==
X-Received: by 2002:a19:9142:0:b0:513:d5b5:78e9 with SMTP id y2-20020a199142000000b00513d5b578e9mr3793878lfj.26.1710590889797;
        Sat, 16 Mar 2024 05:08:09 -0700 (PDT)
Received: from [192.168.223.169] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id fb17-20020a056512125100b005135cdcf4a4sm950755lfb.32.2024.03.16.05.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Mar 2024 05:08:09 -0700 (PDT)
Message-ID: <a201b559-473c-4020-88da-2ab0589723b0@linaro.org>
Date: Sat, 16 Mar 2024 13:08:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: msm8998-yoshino: fix volume-up key
To: Sebastian Raase <linux@sraa.de>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240315225237.1616550-1-linux@sraa.de>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240315225237.1616550-1-linux@sraa.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.03.2024 23:52, Sebastian Raase wrote:
> The volume-up key is connected to gpio6 on yoshino.
> Fix button node ordering while at it.
> Disable pm8998_resin, since it is now unused.
> 
> Tested on maple and lilac.
> 
> Fixes: 390883af89d2e ("arm64: dts: qcom: msm8998: Introduce support for Sony Yoshino platform")
> Signed-off-by: Sebastian Raase <linux@sraa.de>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad


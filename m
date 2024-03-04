Return-Path: <linux-kernel+bounces-90767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C54ED8704AD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD542834D1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E2946537;
	Mon,  4 Mar 2024 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LsdsrFnE"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65283481DE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564365; cv=none; b=jGt4WDcwMP0mERgoIST7ztN1pyVaPyZCSttmDJGhBSd7fA13usJBgbyqaMeri+Ik4ht++etbZCFy13vLDg/Hf9pw+1COeqc2VWTwZcKe7tSg5DE+MRbf5NzxO7eLqyrA94MLdVEbD799JYDSdHK6VnqO4qtJAbIT6ahFnuIlR8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564365; c=relaxed/simple;
	bh=u/ek3q1kVCTn3VecuWgufz0Q/b4zPEcqhFv0YfTJRUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0DRkAIvsJJ8kqTRfTu8Bc3IL+Xjx5bRYERz/EnVQNscNl67Qfiicxnpl72UCmJuRKJl62QpQ04UtIHDl9b5r8fH4paJOkP+RFXbFIfpHhGUgHdPlAZqKQlcpputTt3XIP1IafbMfKYbHpHQzJytumqiKNb7cffL9OxyHAL2oiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LsdsrFnE; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a44cdb2d3a6so290663666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 06:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709564362; x=1710169162; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OQPhJYLB3T7gmWKqDA+4bZDbuiPVQDX4htvMvW6HunQ=;
        b=LsdsrFnEffygCH66+X5CMlft9GJRfEEHBCvS1Zfckt2zLOJVkT0RoggfuW9yTn5jmc
         YUH6jnLF8Z4doZ2lTp+UBjwC3mTt6JqKuh0IRMfN7qhbn8ScPWcslpAYZG70n2lUfuEK
         t0gEOeNG6wTBhqQC3Xtiv73D95ecp2eV+5BalmFdvjMopjyrwwijlikcbWEbyuctxIiU
         pfATBtmJ9nJanJF0FlEcpCkuMczvHzAixwIRCWCNlqd5Vckm6RTrW178ms5gq+YLGxp/
         lPSOCahpabI/mcLRHlDeuJSh274qVPD8Aonzan4IevROUDhQWS5OvNanTHbc4+xb21HW
         b3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564362; x=1710169162;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQPhJYLB3T7gmWKqDA+4bZDbuiPVQDX4htvMvW6HunQ=;
        b=cFwO3EhKZjFAdX0FfNYQhPNbb3BGt9gXKwPeskGFp0sK5uX55gBES/CxwxLSUWNr6I
         qAz7dCuvDryUspaDgXwTW7kd19Vm01Ddajkl96IWqiXnSbMMNrhEf1YoaeAEeDxdZ5DP
         2fQDCm/oXVLZlUA7X11Lkv0d9+Yu3uBhWoQYoFVWRRssSQWQ0NIS5Ayo6VmPuo8XPupV
         VMhQOeVYFy/qarxILlUb9Q5QzmM8kjhjO5anJ/l+9ZgQHNjcGIx7GonbcQrqAGxZ8eqE
         SOYJeqB2AOmgsBKaidRmnmV494wKfKy6d00wNUHhfLKWaDshyoIx2GnDcuMWor3SII9Y
         BQow==
X-Forwarded-Encrypted: i=1; AJvYcCXMW4PX/gkt7flAbclWjmyt7aniu8FGaVBBFMIba+xHopJG5fdGzxmJIVRz3L+3wLeRrj6tRX2eq8xRZXYrC3JuBGdqX50JjPwQEDm9
X-Gm-Message-State: AOJu0YzZqaa+QjMedH0RRtGKyRgY1O3LpIPl08D9wVv/vrco+G4h483r
	NmUTPwpl/n8pqU8Q4OzFPWd9Vcmk+lweQ3TwvINcEny98G3dEDTDAEXYTTjof4o=
X-Google-Smtp-Source: AGHT+IFP8IQHricKVRaqhoT9wiys2VbWCFTGaiuyUVPnWAaGNxSqsQPsgjybd7rrcazoWXyaGQwA5A==
X-Received: by 2002:a17:906:ca4a:b0:a3f:5c5c:33ac with SMTP id jx10-20020a170906ca4a00b00a3f5c5c33acmr7044835ejb.62.1709564361903;
        Mon, 04 Mar 2024 06:59:21 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090629cd00b00a446c787c86sm4180511eje.213.2024.03.04.06.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 06:59:21 -0800 (PST)
Message-ID: <6c9e0570-fcce-4796-a943-5f0e65605b1a@linaro.org>
Date: Mon, 4 Mar 2024 15:59:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindindgs: clock: support NXP i.MX95 BLK CTL
 module
To: Rob Herring <robh@kernel.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Abel Vesa <abelvesa@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Peng Fan <peng.fan@nxp.com>
References: <20240228-imx95-blk-ctl-v3-0-40ceba01a211@nxp.com>
 <20240228-imx95-blk-ctl-v3-1-40ceba01a211@nxp.com>
 <20240304143916.GA181628-robh@kernel.org>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240304143916.GA181628-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/03/2024 15:39, Rob Herring wrote:
> 
> As that is the main feature/function.
> 
>> +      compatible = "nxp,imx95-vpumix-csr", "syscon";
>> +      reg = <0x4c410000 0x10000>;
>> +      #clock-cells = <1>;
> 
> Please make the example as full as possible. For example, add 
> mux-controller node. Do some of the blocks not have mux ctrl?

I asked for this in v2...

We can keep asking and asking...

Best regards,
Krzysztof



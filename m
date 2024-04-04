Return-Path: <linux-kernel+bounces-131355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3504F8986A9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82AF3B213FF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997D38527B;
	Thu,  4 Apr 2024 12:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NwwGXHR+"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9DC84FCC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712232003; cv=none; b=n9mktcackAM2sO5sfTX0VnALd15l7bSSlgqTU4ftsh7VOWTmsca/Qwq9hB6kuLr3vBYVS5PZ31FVr+Bl01b6E844m7Dk0C5uPMFRqsDVNV2YMgalEZ86T5IptjGMM6WwzordWDfpcQJenRQUzsR4bUIM5I9et6oNceVXOiqdgXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712232003; c=relaxed/simple;
	bh=FEeqM0QXIfOr3fliFm1l8zjQQUGQnK0ajtDwI4qCyjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TvUkX8XbAE3K9gsaPC20L9Kk7O9GzZHN5Ep1GHVS4A4Ezkd4VhbW2INqw9EwB+TGihylpnJYGXGtai3RGfS1BGCHrd0VZb/xoiMXn1bj1RbXI9QPBiaYGclKT7XJ2fL85XbKtNbIJeoIcSgSnex6bKM/M3RB0VgJDlk9I8befXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NwwGXHR+; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56dc9955091so963899a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 05:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712232000; x=1712836800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nXx5yz65zaeAOrWd6X0p4TMONHDZtAudltRg4le3KKs=;
        b=NwwGXHR+B4zADzo4wRhKcGEDZGTmWciCFAZs1GAHJFLDOkL9Rb0fSuw4Au18OWGjiq
         Uvchh+WGIsiujhWBT5FosycMTo1NhWyKK95mblghy8FDIfNIouptOVgl3XZfHRCvhmZ+
         THWRjWDoN6573MpUSdkPBZvpbhEUe34s50cIGGMIIGpUvpP6MFBV4gdekzPB1I3Pay1L
         LHu+lsPetmi7/Ne7c40kEJu/0COJClTEqaeZqscYW253f0nqrdbWCupov5yZx0Tz+zMD
         ZZy+OR8TODzsjuYSQAU3O0hlLPD4Juyy8mvU9XFYRendLlZ0Glx53hh2zItaz7POOvUs
         OB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712232000; x=1712836800;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXx5yz65zaeAOrWd6X0p4TMONHDZtAudltRg4le3KKs=;
        b=OP83QiGTzGav7tq3FV3SQI/cvwD1gyPo1cYcPaX+ABINf8sqSCtdT9sCYHzlgFV90r
         MgO7i80fanFe5WqDCcjMSQf7oKLIp0MszAOELYja9fr22HXAaZyjABv8zDTUhk2KlwrY
         UWEcjk2I/l4PivuvDR+QbSw1aP37Qy+3tqN8YzjCiC+H6irevyZZK2WuOWdBdURnnQS8
         mP5Zoo8UchVQXkODpI1M+LOSqO7cCzJ/PzhKjr218XcEDYGZsj0Wuq7eoRRIb6zg67Eo
         ufiKgj2hShCdymQsGvt9+6hyDaqYhOFKkjYdL25Dwh3vCHZTohzUf9CJVl7pfUtCZLzM
         Q8Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUxHUJ//Xrijv3eRvLnCCZlExhtKgmmw52zK3mEZOUutbhvuQavcCBJMI46rQUunVc7wnGz5gWm9DxnTWX9tqMENJEy3AVz2x1YuW0l
X-Gm-Message-State: AOJu0Yxm/WH5CpK4yl09T8Ls9xmhiIRDDAubS+jsDw+vu9l3+x66Ymkf
	d4mH7ddI+MGsyWypIjXE47+vEtkPW0ilVqc+Dx8ATgfnGeRUn8nNtww7/o2RCa4=
X-Google-Smtp-Source: AGHT+IHCWsBjiESlX+BWKOs8k4LriA4MwY8hUEBP7Jwq9fmc2PdD8jlpYByT4Mw/hMUat/3xwY8ocg==
X-Received: by 2002:a50:ab50:0:b0:56c:d20:22df with SMTP id t16-20020a50ab50000000b0056c0d2022dfmr1582068edc.20.1712232000241;
        Thu, 04 Apr 2024 05:00:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id u17-20020aa7db91000000b0056c06d5dce1sm9256367edt.81.2024.04.04.04.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 04:59:59 -0700 (PDT)
Message-ID: <e78c8c2e-1c83-4492-9db9-08f06856a414@linaro.org>
Date: Thu, 4 Apr 2024 13:59:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dt-bindings: media: imx-jpeg: add
 clocks,clock-names,slot to fix warning
To: Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>, Mirela Rabulea <mirela.rabulea@nxp.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 "open list:NXP i.MX 8QXP/8QM JPEG V4L2 DRIVER" <imx@lists.linux.dev>,
 "open list:NXP i.MX 8QXP/8QM JPEG V4L2 DRIVER"
 <linux-media@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240404035205.59492-1-Frank.Li@nxp.com>
 <af602862-5120-4717-adb6-694ada09e8d8@linaro.org>
 <f5fa1872-0bae-4f04-aa94-27db937516e9@linaro.org>
 <CAOMZO5Dtd_p02YeX6tcWMGzujZ-GwLQMQBPBOx9xLmEgs6VVNg@mail.gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAOMZO5Dtd_p02YeX6tcWMGzujZ-GwLQMQBPBOx9xLmEgs6VVNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/04/2024 13:03, Fabio Estevam wrote:
> On Thu, Apr 4, 2024 at 3:54 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> 
>> And for the clocks, instead pick up this patch:
>> https://lore.kernel.org/all/20230721111020.1234278-3-alexander.stein@ew.tq-group.com/
> 
> Or maybe this one:
> https://lore.kernel.org/linux-devicetree/DB9PR04MB923493D0DA82C9EC4386BC2A8FF1A@DB9PR04MB9234.eurprd04.prod.outlook.com/


Three people were fixing same clocks issue... and three or more people
were trying to fix the slot property.

This is really bad binding maintenance and driver upstreaming, NXP.

Best regards,
Krzysztof



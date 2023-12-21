Return-Path: <linux-kernel+bounces-9075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47F981BFEF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EAD71F25E9D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE0376DB5;
	Thu, 21 Dec 2023 21:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q28p3H6T"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDD476DAE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 21:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d2764c0f2so15155395e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703193184; x=1703797984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GdMlmaV9AC7XvOLSkLsEav9XnreEWiVniTZV6CZEpk4=;
        b=q28p3H6TBjI5NmTShE0CsG4Nov/c5hTdRCcx5Vc+gjoZpqV1HLn4EuncBEf6o0TT/m
         VnTtneGUaUGjrq5A0gKk31Q+x6cwirQP1/vJqAvIm3zftSZHLugnB3IszlDuGLNvHKpp
         lQDdDZlYgMwev1HdVwSzMx8aK/6RzSfEA3AIEIBYwHJ+xaOtQTMbm4m9/5ZX3T1bGNOz
         RtyX1ZeKfay5KBt1yn0d+lvg65IYztqZdFCI0dO0GLlReaJVfES4JouIguxz5tIW0T/l
         XInqh5vSryGwd34N7mDckN/2karryvM0Ll6FPgmZgv9l+jQs346wtcmlSHmJuDdPHa0C
         Nr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703193184; x=1703797984;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GdMlmaV9AC7XvOLSkLsEav9XnreEWiVniTZV6CZEpk4=;
        b=rNZkW9X0nyUay4+Fy5rE+Q5Jtxl4/TK2D/pkBgKnufP45OnP9YXxIpW95m178EMDkJ
         AUjHYn62cFL5lxh94LcYq4rT8UKMQmGq4eD9mFkutXM7XEUIXfhC6IKGmXJbisI7O8/7
         Vh/TwF4sh/Hu+OP5YuKZhfjSrw98KDVaTsO2NZRj+Y0S7OvFIF/Dlb7cb4szn6t7rOTT
         2uzCmtHdQ447iXdNUMCM6rm5ZeSDlr+lsODattFAYLalcNIP9YggdgEhsComl7I2ISP+
         0uScRzjvpF9DTjIeZ+9D+lf4bo+sMHb0bsTqVU70eTDdfFxeRA6D1NzfakHl/FvqSkrZ
         wI8Q==
X-Gm-Message-State: AOJu0Yw+ijK2kxvnakte2vji8i9K+Lv23zr/kB0mGyPLt381PaZxRRMW
	psLs9UExN6cmJwO90wRYnbKa1F8zEa36HA==
X-Google-Smtp-Source: AGHT+IEaptAlsGu2FAQRl6GgDxH92kk3R15a9/9ALjxi45/P5iqrlZBjTJFycViFTuu/3edjunSGWw==
X-Received: by 2002:a05:600c:1908:b0:40d:3452:e791 with SMTP id j8-20020a05600c190800b0040d3452e791mr179835wmq.127.1703193184340;
        Thu, 21 Dec 2023 13:13:04 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id d17-20020a170906345100b00a26af0a6845sm520953ejb.9.2023.12.21.13.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 13:13:03 -0800 (PST)
Message-ID: <b2b9d95e-dcc7-4a3e-b4b4-14d5af964b96@linaro.org>
Date: Thu, 21 Dec 2023 22:13:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] w1: add UART w1 bus driver
To: Christoph Winklhofer <cj.winklhofer@gmail.com>, robh+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231221065049.30703-1-cj.winklhofer@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231221065049.30703-1-cj.winklhofer@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/12/2023 07:50, Christoph Winklhofer wrote:
> Hello!
> 
> Krzysztof, thank your very much for your feedback!
> 
> This patch contains a driver for a 1-Wire bus over UART. The driver
> utilizes the UART interface via the Serial Device Bus to create the
> 1-Wire timing patterns.
> 
> Version 1
> 

You already sent v1, so this is v2:

b4 diff '<20231221065049.30703-1-cj.winklhofer@gmail.com>'
Grabbing thread from
lore.kernel.org/all/20231221065049.30703-1-cj.winklhofer@gmail.com/t.mbox.gz
---
Analyzing 4 messages in the thread
ERROR: Could not auto-find previous revision
       Run "b4 am -T" manually, then "b4 diff -m mbx1 mbx2"

I still cannot find the changelog. Does it mean nothing improved?


> - In v1, the driver requests a baud-rate (9600 for reset and 115200 for
> write/read) and tries to adapt the transmitted byte according to the
> actual baud-rate returned from serdev. Is this the correct direction or
> should the baud-rate be specified in the device-tree? Alternatively,
> it could make sense to specify the minimum and maximum times for the
> 1-Wire operations in the device-tree, instead of using hard-coded ones
> similar as in "Figure 11. Configuration tab" of the linked document
> "Using UART to Implement a 1-Wire Bus Master".

Depends, are these hardware properties? Are these runtime? What do they
depend on?

> 
> - In addition, the received byte is now protected with a mutex - instead
> of the atomic, which I used before due to the concurrent store and load.
> 
> - Receiving more than one byte results in an error, since the w1-uart
> driver is the only writer, it writes a single-byte and should receive
> a single byte.
> 
> Changes:
> - support different baud-rates
> - fix variable names, errno-returns, wrong define CONFIG_OF
> - fix log flooding
> - fix locking problem for serdev-receive and w1-master reset/touch
> - fix driver remove (error-path for rxtx-function)
> - add documentation for dt-binding

So this looks like changelog. Please make it explicit - move it to the
beginning of cover letter and say "changes in v2".


Best regards,
Krzysztof



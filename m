Return-Path: <linux-kernel+bounces-19777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A134827386
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8427B22A3D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828D251039;
	Mon,  8 Jan 2024 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i8r9Y8Gh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F895102D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-67fe0210665so12184496d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 07:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704728207; x=1705333007; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jBaWBCELdQDCiINd0412kAHTBmS2ucp0dmDPH4Uxpys=;
        b=i8r9Y8GhblDlA8C0HFbwpeNF4EoAKV/d5CygpvHbbndNf/cHBbokiR+Q5eyjdwfBHE
         m8pV8yYDjxzE2FZQHAb/0FhWovWLso4MfNanYO5e3ZP50YIpt+I43hFyuxFbLef+WQMt
         U5N8xVoQdla5uhw7QirAimz4IFgqkz6RjOBYJ6/gf78PUM6XE3srQ27zsCNY6u7Y5Tyl
         R343YYlr5yw9sWA+niOjalrthuU8rbz3dVQcwu3g1Tee0UVno9nHzNHY+Ect/v1HkYGL
         6hA+dRrgl8m2VaJkYu49K9iaBZAGjKHzy2lXYwGNkjVEIcuArM74H2Mz4uVDdw9Ey0Q8
         897w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704728207; x=1705333007;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jBaWBCELdQDCiINd0412kAHTBmS2ucp0dmDPH4Uxpys=;
        b=An7HLDVoWeAwmAT9XdZTONcERZbG7w0WWHU+aDek4RdB/GsQgrmEqSqgOEDi9DrAJE
         zhuAWBsedMkgZXI0yCUYUfowSxLYAsnzXIPi4uFlN8ZoGHyAW1xs0f7DS63ctYwa6R9g
         2kUghCc+34zd81NM8OAsXjazSUkYjTCME7OlfkHsvm9OVGmTmZHfcUCOnDgU9oW56OUJ
         3kTb5NX0kMtLfU3CsPvN4HHM8WAdqVfFWkuHlDpZMiBdbXs0weWRhBjOOi2/ykCfSafH
         hAx+lPYwuRHlIRZWk8qj63alUPp0av4+X2XjsO9NFnqUuaVR9Mt/LJCZ6LFiC9fGNyC2
         LbQQ==
X-Gm-Message-State: AOJu0YwFpoBMDOSx6pEqryFHuab0cFjysYPRffAn57RPGx3qyO7xrhyj
	rI9WYvTHgW2jPk3jPJz9XveHSFG+srIYwMP3U5n7MjzSWVCQvw==
X-Google-Smtp-Source: AGHT+IH863p9DTyUG3cXWcw7QQe6quuJOFyZtJC1s1k1mesk2Eh6/H960ZPZ7GBdSUYoxKfwC2OmpJHMrbTKpMHrU9k=
X-Received: by 2002:ad4:4ea5:0:b0:680:ce74:9523 with SMTP id
 ed5-20020ad44ea5000000b00680ce749523mr4727352qvb.54.1704728207402; Mon, 08
 Jan 2024 07:36:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228125805.661725-1-tudor.ambarus@linaro.org> <20231228125805.661725-10-tudor.ambarus@linaro.org>
In-Reply-To: <20231228125805.661725-10-tudor.ambarus@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 8 Jan 2024 15:36:36 +0000
Message-ID: <CADrjBPrYkqzHQDw8aj_=cGBdrWv-j9DfnxqpswjMM+kavis0PQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/12] arm64: dts: exynos: gs101: enable cmu-peric0
 clock controller
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org, 
	andi.shyti@kernel.org, alim.akhtar@samsung.com, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com, 
	cw00.choi@samsung.com, arnd@arndb.de, semen.protsenko@linaro.org, 
	andre.draszik@linaro.org, saravanak@google.com, willmcvicker@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-serial@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Hi Tudor,

On Thu, 28 Dec 2023 at 12:58, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>
> Enable the cmu-peric0 clock controller. It feeds USI and I3c.
>
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>


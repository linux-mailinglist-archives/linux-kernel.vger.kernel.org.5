Return-Path: <linux-kernel+bounces-127756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 870ED89507F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 416B9281574
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDD969D27;
	Tue,  2 Apr 2024 10:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n8Vzfiqs"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057475D749
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054389; cv=none; b=u8sg+vC7OYyzhfujamGXP4kw6GowH81vfiPjJWa7NmtDkFJacZvc49jFdsl/BRzU1k2Ovsb9VNDHK3TE//J1IMCjEMeoyCI8d51TZkia/0lHK/504BQoXC4qbh7qPb2G+XTe+xVeRzCVsagouCVl9XOCQUWHczvrk/Wu/mRB3vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054389; c=relaxed/simple;
	bh=HhEFB0IGRWmX+BEHDfO8KYBrrkkM8mY4tpZ16mAQ2nU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r5m+IFcA6GSqwLf/9LpDnkilnygc8q4qguSZCLyi3IVf/oBqBZkQrLFGL8nsqtUG4LRxRwG0yHGgghW+SBPrRxf4yq8tQMynHtgegc7CifRfqAOBpVgUUvtkLt8gVp+IaBLJIGqLeE95k0AawHdJM/+Str9mbThYoaFJxALb1pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n8Vzfiqs; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso4663965276.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 03:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712054386; x=1712659186; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N+1mQHP/C9wtu+pPXviceegNYIKTTtoExeoBTWfttgk=;
        b=n8VzfiqsuWOr93E0ssGrVoPf/59FBcfuZMN3XmPUEZdGoRrJ4WtKwbJqg0X6vqn7wj
         5c2nPYP3QUagIBWBAGIrXb7rZF5mSmE8lUuedV+tXmbi3iokOFQ/gegSoddd/wo0vAaw
         u0cCCvRjOuKITkzfl05CwtyJm0AQG5T6x3Qg4QAjbq2+p4+i5j8+JXqtNc96aU7UEham
         cjhg3OUgnY7hmoKQdABZtbi5ykfUnD6QtdA4NxeFwyujSU5PkvnNIgBc3B5H6D78M9RX
         OGGrPNILVGPstrLEjpvMc7qN6IPG4FkANwxNt9J/HxyKiEWt+VDBPcQGY0shMNsK4ezh
         n7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712054386; x=1712659186;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N+1mQHP/C9wtu+pPXviceegNYIKTTtoExeoBTWfttgk=;
        b=gnjdtKPtxXAuhwfe+ljhFueAj3jmdPtPW8OVrf+37VjdE/ashwakU3rMLnHqktAcBl
         q3JdQ5V4K+DgJYUJ79exi76ukqDZP8a8yzUKxlLUSy5VwvVgB8uI40RQ4eaGu2e/k2vS
         rTgkizIr7Kaq4vZbKOi7W+fJ6uuO8cZji+Jur+eTLXanI+xVXHFHL1YrWboPgFO4TaDa
         2tkXgveDUBEUwH7PPo2Fp8nG1NqmdSOZ9m+gPPGvW/y6P8mSQDU6w5VRqX0UdNsQyrbN
         lqHEBOlixit774ep93txrA2TkLDLDpDFI3LWVfXjI4PG3+G33RDEedTWuEg8avE86QbE
         YfNA==
X-Forwarded-Encrypted: i=1; AJvYcCXFXFc/WfV1QitO/uUIc6Z9W59YQFzVolhCGq0wekjYb7UcTI5aiB5ohndc7sX6/kZZJIX9iZIiM/onH4o9Su6QXtlf+u20Xbxrbogl
X-Gm-Message-State: AOJu0Yz+tPXBV4ZA3payN4uC+l+Y7p7Y5JFo/r0EtdSA2yl6tOfnixEe
	M5QXLLOAIJF1sgHbR2TAaoBDKkOobZovmqmsSYmNtjSXg3nT29n+M9/12zAe8GcH9C8YXN+tZKR
	alkq+C7r9LfRnLimzbP8GEMhBIbx0E5+/bBbqRg==
X-Google-Smtp-Source: AGHT+IFBCL4yjfbf9P6S4J9vEGaxrXR9oX+B1iTse1Th7FUTQ5eAJxtybDGU8x6mh7uftc+KDUharfT5L6xDsM1B8Ic=
X-Received: by 2002:a25:aa89:0:b0:dc6:dc58:8785 with SMTP id
 t9-20020a25aa89000000b00dc6dc588785mr10269779ybi.62.1712054386067; Tue, 02
 Apr 2024 03:39:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402103406.3638821-1-quic_varada@quicinc.com> <20240402103406.3638821-3-quic_varada@quicinc.com>
In-Reply-To: <20240402103406.3638821-3-quic_varada@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 2 Apr 2024 13:39:34 +0300
Message-ID: <CAA8EJppyuagb5zkP4LCjjJwConw3mw3iS-+dO7YB01=7-waRTw@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] interconnect: icc-clk: Remove tristate from INTERCONNECT_CLK
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com, 
	sboyd@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, djakov@kernel.org, quic_anusha@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 13:34, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> drivers/clk/qcom/common.c uses devm_icc_clk_register under
> IS_ENABLED(CONFIG_INTERCONNECT_CLK). However, in kernel bot
> random config build test, with the following combination
>
>         CONFIG_COMMON_CLK_QCOM=y
>                 and
>         CONFIG_INTERCONNECT_CLK=m
>
> the following error is seen as devm_icc_clk_register is in a
> module and being referenced from vmlinux.
>
>         powerpc64-linux-ld: drivers/clk/qcom/common.o: in function `qcom_cc_really_probe':
>         >> common.c:(.text+0x980): undefined reference to `devm_icc_clk_register'
>
> Hence, ensure INTERCONNECT_CLK is not selected as a module.

NAK. Please use `depends on INTERCONNECT_CLK || !INTERCONNECT_CLK` in
your Kconfig dependencies.


>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404012258.MFriF5BV-lkp@intel.com/
> Fixes: 0ac2a08f42ce ("interconnect: add clk-based icc provider support")
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  drivers/interconnect/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/interconnect/Kconfig b/drivers/interconnect/Kconfig
> index 5faa8d2aecff..f44be5469382 100644
> --- a/drivers/interconnect/Kconfig
> +++ b/drivers/interconnect/Kconfig
> @@ -16,7 +16,6 @@ source "drivers/interconnect/qcom/Kconfig"
>  source "drivers/interconnect/samsung/Kconfig"
>
>  config INTERCONNECT_CLK
> -       tristate
>         depends on COMMON_CLK
>         help
>           Support for wrapping clocks into the interconnect nodes.
> --
> 2.34.1
>


--
With best wishes

Dmitry


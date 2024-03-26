Return-Path: <linux-kernel+bounces-118469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5852988BB62
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F201F373AA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2648A13249E;
	Tue, 26 Mar 2024 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HbjebAuD"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E15130AEC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 07:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711438595; cv=none; b=kdWslzMX3WD58KqYEKmSJSPEQAauOVvefn6AodzOrBqe24LTXoFy5pTd/U7q6Qnpkdr6W/h4BtXhfeA1zZw+FDiGk7JVvkCi6qnY8I+xR5MJ+tsLZW61oRIpBS3J7P4ih/BzQ1JI50VpXYv9NtWRQ6XtpLsGZP2yvNZTAh50RHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711438595; c=relaxed/simple;
	bh=m3u1NjETM1MBj5on95tx4eAdtunQnjt2ckTBjz0VJeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ipdgpdzCkDL1B+whkELkr6DvozLhVu4hIznHbmdeBKWPXnXjuvGUGzH1DQHT68I5ffoI9nx4fs6OKKGhRHW1TlKImjEhniWWyaMV/DgoDCi9aNH/QQLhrD2Tj2yAOH9mtaiAuzHMM01g/0ldZhmeY66vaOsbaXuK5u6AGjtIGQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HbjebAuD; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a472f8c6a55so467787166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 00:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711438592; x=1712043392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DTwj7yMPnsFKbElzhkNgnR5pLBrvg9NCd+lk4WtlFCE=;
        b=HbjebAuDcofoaivtOQ6eAo1YbsS4BIedTC1mwyXm1K8afsecHirxeSNyxykqg9EqjP
         DVJ8mmGY6Vfhizvu9q32uWS9jYLj7yCVFbA+fznFDFAlMRxqN7Y0EvFqeUgF28PtiCyK
         2WhZt6c1OBVRGDds2EpvNIT9r9LddmbcZOW/pDTwging3+7R2dFvHg4lQ2ylp7Emt2MD
         erVbz6787k4OnH1bsZcL78FX4TQzIC0zCAl4+QsMbkguuMevxwhmYYLQirzRttm4ymmc
         QvwqS18/aO/Y4KUGFiKi3xP8XvY7sTzDvPSFmj17UtjaffAcIS1/q7V9JrzRJfhdMWTf
         rTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711438592; x=1712043392;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DTwj7yMPnsFKbElzhkNgnR5pLBrvg9NCd+lk4WtlFCE=;
        b=j+F8+XTEfOg+g6QGWynR+bggOfwkx4kW5DlDMV2HQqIUvMk7D6RfVZcslqlSE9LHiA
         nrt9R1IO3LMJa8X9BDkpb4S7Oz9TNllehr0JVyOyYwW8gg6GHNA2CnYOF4n3de1wqv8K
         9f1sbBm0/KRYoixyDEv+icge5F2Y7vPv/9mhDarwbo4Mv+WPPTHGH2NfgEQPdnt1Z880
         eSbR7PvPc2mlrnT7yEaDSmxxCfvnKrPqAA6xpLEzXS+13JAJ2n5MiK8xnrKKkp6TPTNP
         nXj524TV7d/NWGTGYgqWnRZK8qvx0agY8rdjtmjdjnp1C+WZEfc0uMstjCndHILv2E0i
         OPEg==
X-Forwarded-Encrypted: i=1; AJvYcCXTkTkfGqYiFswP3bPwlL3krEqnnC0GhWjM8LuEE3036LMVZNHzEZVdtmKVkTVeiDgydJlzaCI5DbVbrbAM9iM2IMRiBIjFoaDOykBn
X-Gm-Message-State: AOJu0Yw3JSBU5tVl1wSQ38uw3Yf73sFJcRnwWobjueWwtFWi5CbAaDJD
	0Q4F3bMrsDGsX6oN9T6teZ4VRjPZO78A3bJkSmyLcFAqoKQEssjphMJ9gJcscAM=
X-Google-Smtp-Source: AGHT+IEp5me4kskCsA4FG+us2408AgOnpIfaBluH+ZZcaxjBNIgc2mTSO7rEbnw9cgCm5H/TOtjSHg==
X-Received: by 2002:a17:906:8419:b0:a4d:b0e9:efbc with SMTP id n25-20020a170906841900b00a4db0e9efbcmr1655263ejx.17.1711438591859;
        Tue, 26 Mar 2024 00:36:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id b12-20020a17090630cc00b00a47342b53a4sm3898654ejb.191.2024.03.26.00.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 00:36:31 -0700 (PDT)
Message-ID: <96d421d0-1a86-4290-8d90-98442e344c1e@linaro.org>
Date: Tue, 26 Mar 2024 08:36:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: input: touchscreen: edt-ft5x06: Add
 ft5426
To: Andreas Kemnade <andreas@kemnade.info>, dmitry.torokhov@gmail.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 o.rempel@pengutronix.de, dario.binacchi@amarulasolutions.com,
 u.kleine-koenig@pengutronix.de, hdegoede@redhat.com,
 p.puschmann@pironex.com, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 caleb.connolly@linaro.org
References: <20240324184415.206587-1-andreas@kemnade.info>
 <20240325192531.256854-1-andreas@kemnade.info>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240325192531.256854-1-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/03/2024 20:25, Andreas Kemnade wrote:
> Add compatible for ft5426.
> Searches for documentation reveal neither edt nor evervision
> as some related company, only FocalTech.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  .../devicetree/bindings/input/touchscreen/edt-ft5x06.yaml        | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> index f2808cb4d99df..17b05522eacd9 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
> @@ -40,6 +40,7 @@ properties:
>        - edt,edt-ft5506
>        - evervision,ev-ft5726
>        - focaltech,ft6236
> +      - focaltech,ft5426


Please keep the order, so one line bump.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof



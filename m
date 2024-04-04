Return-Path: <linux-kernel+bounces-131138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 591B7898387
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C5EF283C1F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3014071B5C;
	Thu,  4 Apr 2024 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mv5oojXJ"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23DC71B45
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712220841; cv=none; b=KwS1SYcBPeOyrOFoowHhn0DcQXMu+NWfXx+D5EhFYtZ7DJyIG3iwnXUGnkjFxZghBNX4koT9mCIsLRY3F6ekkiwn6d+J9qopSOF0BgkHsP4CmIMYs3m5AFyBpK318an3eYiWE32pqNUBLmapLxWfwskamThJ8pV5R9Km04Begjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712220841; c=relaxed/simple;
	bh=oN6L5F4339c8x9zBSAaPAAYbUmNj5mF92X0nhCMXYT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YFoIFqWNFSmxkHYlEOky3CDPmZ/fHK9hw0Xy6P5hI28kpYJW/bI40FmVQpdsZXlOf8Rrpndg4HDtfEg/IeaGCrT4Wqa/vhlFNZO3MxUjXJjiiSxZ+mtQEb778kqEo9JaOr4AXp20tkJX0iKL+OI49iDA1oirxLgY9EMRMYq/Yvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mv5oojXJ; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-ddda842c399so812093276.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 01:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712220838; x=1712825638; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b0saMo4QGYVfrGZY3BfXYJ+wYYPXK1vgxsVH3LduLhE=;
        b=mv5oojXJQs/dZqQOhmlv9SMhqb2lHABRfOuVOazj+KbLtq6vLKnVn6KWdbZIHz9vqp
         udi60YvI2iiiD/lI4W4tUhUD4NitfrqWYRPxlDPRCVJo0SHxpBLQ1Q2Of1WfrkEDz2Lr
         dKH+ykmhgxoYfvS53r4hipq4zP7LxCgHkVCZlRg3R6aN+LeBCgrtn2+d/MaN2s/XU7od
         9epamVS6V6fic0lsr+gpvKRxmCNHcx63REOVqjyXxknlcFGqP/orKTG7hb5u75aq7UTO
         0ymfs5VFMt9nhk7zlwNKfweK2SXA5fHFZBg2jPaEtABerz5P+bWK7+hgSqw/nqRhI74x
         2ClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712220838; x=1712825638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0saMo4QGYVfrGZY3BfXYJ+wYYPXK1vgxsVH3LduLhE=;
        b=rObt00769A9+opBMCfhfBP37w9Mn4t0mUfqOJWPgqC+azarAWZn9NQqbbKfWqD7yHv
         m9M/US0YgAnUxFNsWQftd3mFuW9STHckPtuJMudzIbwxSeH4meEgd5BftMPiSkva5L+/
         Nf8irvOf9RWAIzFdb7Y9+F8ocMPaDpi849ewPDKqsGTJKfKxkTkYnLlvUxom7gON+Ag6
         1Xth2HPn2V0b5kzq1iayG4Ov0EnnBUlJ3J+Pl/72ofRR6Y7Iadto7+74X23A15zY8+pq
         l2qcBXHcU0VH4VVdho5CZODalz6GfJG86oTq1cLCvQFfDi6Ze7iOfzbQFyEiGVp33RK9
         XJkg==
X-Forwarded-Encrypted: i=1; AJvYcCX5Dr8dpKvROqBc3vqK05D5dyThf/elvJ8/pQeatW754izKqex3NBgzBWIAiWax/FjjIXZ7XEnlQ1wwOXBQGoKbF4SLAabnHRjL0jz+
X-Gm-Message-State: AOJu0Ywu73duiVP4wIjtStx4/Xn96NsBhfpsUQ9SpOCgQ10JvvR46XsP
	tDhjHkE6nEYniMh35p4N/y3w9wiXkiYrl2rdb27GjGG/s8w2iHtshOnVB8a17DBHb4ansNOvKrP
	J6pGnzgZBh1xJ5x3de9rAIbZ1G41KiDcLwfvx7w==
X-Google-Smtp-Source: AGHT+IH7f3/xIqdGulCRGC9S2/T1fajzZP/pOTgqSEEM7kR4WSRQcksdbB122eHZa/2SpUYAsKQ5FgKEuYfHL4yMoGw=
X-Received: by 2002:a25:5f51:0:b0:dc6:9d35:f9aa with SMTP id
 h17-20020a255f51000000b00dc69d35f9aamr2068959ybm.19.1712220837771; Thu, 04
 Apr 2024 01:53:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404084631.417779-1-quic_mohs@quicinc.com> <20240404084631.417779-2-quic_mohs@quicinc.com>
In-Reply-To: <20240404084631.417779-2-quic_mohs@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 4 Apr 2024 11:53:46 +0300
Message-ID: <CAA8EJpqWaYhzPKgTREtJnfdNZ4oSFZaRFM7Jhg+qd3AqadGOkA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: qcom,sm8250: Add QCM6490 snd
 QCS6490 sound card
To: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Banajit Goswami <bgoswami@quicinc.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org, 
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_rohkumar@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Apr 2024 at 11:48, Mohammad Rafi Shaik <quic_mohs@quicinc.com> wrote:
>
> Document the bindings for the Qualcomm QCM6490 IDP and QCS6490 RB3Gen2
> soc platforms sound card.
>
> The bindings are the same as for other newer Qualcomm ADSP sound cards,
> thus keep them in existing qcom,sm8250.yaml file, even though Linux driver
> is separate.
>
> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---
>  Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> index 2ab6871e89e5..ff1a27f26bc2 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> @@ -29,6 +29,8 @@ properties:
>        - enum:
>            - qcom,apq8016-sbc-sndcard
>            - qcom,msm8916-qdsp6-sndcard
> +          - qcom,qcm6490-sndcard
> +          - qcom,qcs6490-rb3gen2-sndcard

My 2c: you are adding one soundcard for the SoC family (qcm6490) and
another one for the particular board kind (qcs6490-rb3gen2). That
doesn't seem logical.

>            - qcom,qrb5165-rb5-sndcard
>            - qcom,sc7180-qdsp6-sndcard
>            - qcom,sc8280xp-sndcard
> --
> 2.25.1
>
>


-- 
With best wishes
Dmitry


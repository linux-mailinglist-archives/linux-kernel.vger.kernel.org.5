Return-Path: <linux-kernel+bounces-69811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ACC858EDB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2089E1C20BA1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCB355E46;
	Sat, 17 Feb 2024 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ms0Z0kPS"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A9E1EB38;
	Sat, 17 Feb 2024 10:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708167341; cv=none; b=gvfk4JrnwHkEcZGT/wrBWqGfCkgWOwp/w1EiIJU4do3Ptm3010aSuY4+3Vl998BC2pY9MwOD59ECRj2aIihEvlt7vMHq4iJs5qofU8EFyi8NEJB4YASsVAVWWkZEyUKmwzifDC0bO+R9J7twCCu9XPu7w4W9hhNMjhHlSRVu+70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708167341; c=relaxed/simple;
	bh=SoFQRevF3P8B1B7jPZY0miee+xfWZrDI6aIwspeCFDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k6oDsE+rwQ1Sk4lNB6B6Oj/YuMAVoni6wveD/K5kvHeu64cqrH9zdH+ws2bHlMYiptwSajPqwNSnQeZ+q7fn88sIPNQy3tLPC6MQkSSYUgiZauuLS0llwja+YUtZ16CflCEzjid/5XrazzZXImuHUJc2qiZZZQkDB0l6tjUOD48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ms0Z0kPS; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-599fc25071bso1750894eaf.3;
        Sat, 17 Feb 2024 02:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708167339; x=1708772139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoFQRevF3P8B1B7jPZY0miee+xfWZrDI6aIwspeCFDo=;
        b=ms0Z0kPSdKD+QBLQuRaUvc1zsb4Hg4ph/eMd9oM2DcA6ZdqZP94DiPZxTX8IOX8ib5
         2KIVxMmWG2Eq98xIbw2Z1u//cY7Tk/6K3B6kE5r0P+5XR63jir5o4Bcf1gZeHrJ8XzHR
         SHVZ5foM/UtJPzUEqCWntN0QwbNTBMahCPN+hojpWYWDSBu3SvmKulKwJbTvoMVY2AIt
         OjUZp2cwS3jUhb0ZTkllpvQH+zOPWl7Ct0kRfmbsW7C50EbR2xm+H2ICXVc4bMl5IWrB
         /vJST01tosftrtkpjSg1z2x5wM7KsAZEUZRha5r+r4cYIfL24frL9cMtSU9Ucm2OnRhf
         oM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708167339; x=1708772139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SoFQRevF3P8B1B7jPZY0miee+xfWZrDI6aIwspeCFDo=;
        b=VNok5wSrKsLqJewzbVSUEzVN6dxQQhTz8qn0ShpG0cngmv3nzGH/XBDQ5fX0Y07mCZ
         KKLsOfGN3vIolx5zMvYaGR/8JyY9yxNgpD+IPy788arpSacdaa8+beR7vcXgJOELjx5V
         kNL2rKniSA/iZMhpnCVVr3omAW2ZV9vBa/aUUf5cXksdL4ewiFAx82gMonH3zzS+B77e
         XHJ/PlBi8nBT9VTGB0Coi8Pa1PWwvskqnFep+SwM+c2zH8vr0lKjKWGqiD00O0ApJf6J
         KcyWJKb4LvDGUwhDeYZuKwEAUSbDBLaW0uhsJQpi+/IiY16bYUDxZv5ezxHgtozctA/G
         NxKA==
X-Forwarded-Encrypted: i=1; AJvYcCVjkZgN8w6XHL2k3VXHYD+4lv9GZZQ5Q3IbQ5fPTwQFnwf6Yn5sHF1riQsKueAAgxTRLFcZYePTegHEmE4sZUFEFuwJhyOMtmptD5fwQlGqmQsetiehT+fxglDZzDKY3BnDz9p66qpXWzMvkX4N0GDGg7m4sxJEJrb7ApeMr7ZypnM/SQ==
X-Gm-Message-State: AOJu0YzXe9IChbVXngaoL24jS8rj/hRq//0lU4ZzV4VzPV6SO88Kgm5F
	M9tKB6Jo2psjTGxLlCvANFI3yRlOkdyrs3IXUCwwZKA7mm2ELvfzrKt7LGRKxwUe6GywRVpOF2S
	U8EHXYErc9YSgtsptXbXXeYRK2w==
X-Google-Smtp-Source: AGHT+IH7mMLJzeSoG9griFwSEkpLQGesrTArcnSoA+JLLMNaCb0YTsBj7uY5SI6fseakD4l4NJLciLF54U9u9PSiJXM=
X-Received: by 2002:a05:6358:d391:b0:178:a555:c312 with SMTP id
 mp17-20020a056358d39100b00178a555c312mr7229121rwb.32.1708167339204; Sat, 17
 Feb 2024 02:55:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZcH9u7Vo2sFERIHJ@finisterre.sirena.org.uk> <20240207224546.44030-1-frut3k7@gmail.com>
 <20240207224546.44030-2-frut3k7@gmail.com> <cd8c2f79-2307-4ad8-90c7-747d40f14ede@linaro.org>
 <CAKEyCaAy9U_qQ=pXPYaGetEuuuVuoejxjKPrG92fBFauy1wwuw@mail.gmail.com>
 <263bb77f-b91d-4139-91a5-0ddeda0ece17@linaro.org> <CAKEyCaD=2Md8f=K0pfAFmSCQjL0PkBvAzG_g5Me-wpd5iv2rVw@mail.gmail.com>
 <18583e61-bc7e-47ef-ab2c-c669785dfd08@linaro.org> <ae0827d9-416c-4547-8882-44dbb46931fe@linaro.org>
 <CAKEyCaCteCG+B0H4DTRtZ3JcU1_-Qimc4iR6UJDCokvvkwPydQ@mail.gmail.com> <3a4658ed-1418-4197-8d1d-f35975d8cd25@linaro.org>
In-Reply-To: <3a4658ed-1418-4197-8d1d-f35975d8cd25@linaro.org>
From: =?UTF-8?Q?Pawe=C5=82_Owoc?= <frut3k7@gmail.com>
Date: Sat, 17 Feb 2024 11:55:27 +0100
Message-ID: <CAKEyCaBELLgLG3YjqKmDR=NgeBuL1UeL2MEjaVPT0riQANvt3w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: trivial-devices: Add qca,qca4024
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Robert Marko <robimarko@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
	Peter Yin <peteryin.openbmc@gmail.com>, 
	Patrick Rudolph <patrick.rudolph@9elements.com>, Michal Simek <michal.simek@amd.com>, 
	Marek Vasut <marex@denx.de>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, Fabio Estevam <festevam@denx.de>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 11:31=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 17/02/2024 11:29, Pawe=C5=82 Owoc wrote:
> > Can you point me to some example?
>
> Please stop top-posting. I really have no clue what you want here and
> what you are referring to.
>
> Best regards,
> Krzysztof
>

Is any bluetooth device connected via spi already supported?


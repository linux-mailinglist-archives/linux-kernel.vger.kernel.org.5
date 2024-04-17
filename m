Return-Path: <linux-kernel+bounces-148421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CC28A824E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 558131C22EB2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A0013CF85;
	Wed, 17 Apr 2024 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mCpzGYZR"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAEA13CAAE
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713354409; cv=none; b=m1QWPAW8y1d5gXMytAfIb50TETXLGKso+1COvLopIF57xKOsgnQFpLh6eNGNr03G/MIKC6f+sJXSNHNAHiAzaX6mNwUta9IL93op0FESFN2/ngaBhXqEvKOU6q/h3TwK+6T6FnDLUMsCGXH0ihvFHCmtLWIOUKBzxwTMK+y46xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713354409; c=relaxed/simple;
	bh=fvmf65/P9szpFK2qdaU9n3rF1YNMb7cvoUstdIgrV3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AV8E+/U80ru7GFX135jHmkwQi/SFoWTuaWrQeh8rWkKuiHuXKCdZCEK4Wn5TLV8SSRVglAJlSGpwKgpoTsuuC8z3d0zDTGQYsi0te3/ghcM09Px9ZJ6wEiM/AGXSDhtZfBobEAN+p8lRbESg9eocqHUn8x4PPQxHZ4IbRQnccvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mCpzGYZR; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-61ad5f2c231so37686377b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 04:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713354407; x=1713959207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvmf65/P9szpFK2qdaU9n3rF1YNMb7cvoUstdIgrV3o=;
        b=mCpzGYZR/46ZQuAau0bSRhR0FD5k7fh4SSEz3Nq7zi0S4UDs+2+/mgG8hbZ2TOEfFa
         VnuEAxEfiUW5dW8ztwTzgs7fezgt4SmjroWhsc5KCg2ILZ7XrFDUkqJj/kWhLJR9n3cX
         OAaASPVPTX8pPR4V3iIxqTyRES8TonOBKKbj8Ia9JgBKr6Qo2O9mnQjtJiGDMZl/CoIE
         l5+oqhw1O3ZLVLkibs1r73NVAeJmC+6UJmoA72qmo1LGEIGNvEbMA71jIQSfnMCbN4Q7
         Knym4rLCB+h0yYobOKyFaTbBeAhFXbW32Fkuc43l3jarw91MdMvjaNsXaBDxbbL2vQLm
         KYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713354407; x=1713959207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvmf65/P9szpFK2qdaU9n3rF1YNMb7cvoUstdIgrV3o=;
        b=N/0K8sqBSgtmARVFYdA0i/X0ye1koYhGxsn46lsYTMiNyGxFYbi0I907uqItZu0Lk0
         i45iQvV7LaOKVglwxROJgzOrDWElk0Nd2ufPG77M0Edk4pZnfR0bpnCHKRcJIbR7Yc6p
         G+5SvO7l9bDdVwqLjUqJMWJ/7AbsQlejDUT1EHl/cO1B9viB4RqeWu9UOBQi0+BBtyaI
         AJdDZCjYBziBBn6Q9Yv2kj+93vkRvFP11IHkDvxPiRhyi8DZzEVu1pn+gaF7T3M4Yqnq
         ZW348H69TIIQ0SV2Zdb5RYu94afbsUlItSh1uH15Okc+4H35KfbGrFG0MUdqLLhtC6Ho
         rTWw==
X-Forwarded-Encrypted: i=1; AJvYcCUE/0jVjmv4eLnO9xNnOhUxYEaCIOIfnkDzvnahnP0I3+AN1Q7SE1tJ5N+FCkOdI1U5gJkpGX2JVKRc3YFgx5KPBZr2mOF5WvQ//0cZ
X-Gm-Message-State: AOJu0YzfNrAFh5jWS9c545m4xSXZlak3XlWBitDEXBFMUmGFaa93le2F
	m4Ts7uOEHA/JDUrisPFuOdSA3+P9LvaWabKhqWa5F0dTZGqCcKPqRQtQz8dkux3k68RZZwQMJTH
	vB6zpk426Fj+4OICm3R+2fKye+sECD37rkWpbZw==
X-Google-Smtp-Source: AGHT+IHaD+oBtxsxurR2xr7+C5Dc/H+UHa4V1Pxg4C+1i8P8lLpLApH2p8YLciARVFNYj0rwHnv7aiDYHF6DmqUMe9U=
X-Received: by 2002:a0d:cc4d:0:b0:61a:e856:85f1 with SMTP id
 o74-20020a0dcc4d000000b0061ae85685f1mr6294364ywd.13.1713354407196; Wed, 17
 Apr 2024 04:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417-msm8660-mmcc-v1-1-efc9e455268c@herrie.org>
In-Reply-To: <20240417-msm8660-mmcc-v1-1-efc9e455268c@herrie.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 17 Apr 2024 13:46:36 +0200
Message-ID: <CACRpkdZYujAGZc04Zk0CdzMvFi9KJB+8z8ADN6+VBgahxxPwUg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: clock: Add qcom MSM8660 MMCC defines
To: Herman van Hazendonk <github.com@herrie.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:19=E2=80=AFPM Herman van Hazendonk
<github.com@herrie.org> wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
>
> The compatible binding for the MSM8660 MMCC already exist
> but the enumerator defines are missing. Add them.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>

Same question as the other patch here:
do you have it working on real hardware?

I didn't submit it because I could never test it, and
for me something was missing (like SAW regulators,
interconnect or something like that).

Yours,
Linus Walleij


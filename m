Return-Path: <linux-kernel+bounces-79140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE61861E1D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC805284816
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7DD12CD85;
	Fri, 23 Feb 2024 20:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GEXixc88"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F5E146E6E
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 20:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708721238; cv=none; b=ZuxnDRsyE8i8U0xi944HIvl/I7jK60dfzh/k060vxpzWz+bUFRAWoqpER6VgB1ove4D6z7WSFKf3YPPterxCwFj1FAkHS1oHYHOw0Fa7Mj+3rq6AwRedCaU+JYG80V/+J0nyaAqPjWSvId7ZeLIektCKmvwNlyGsOO3eLB54dsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708721238; c=relaxed/simple;
	bh=0fFTWm56iJV+ctFkvNgjI3jrYotv/EN8fHjPw2a72gQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqaxwolbrC8UEv1IS9ZdcFautPWyncUq/aXPiryvkJQ+dpQ9m29qGdlDN+2D8oSwU84uQh7kh0RfjKsYKNpVgfGIJ4qV7fQzLlaXsCylNZOE0/YVgbXfhO9lwQREzo2uIcq9pkbOKMe9ywEOuJPqN9M0EawYHCTCH0HuiiXO/NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GEXixc88; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-db3a09e96daso752499276.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 12:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708721235; x=1709326035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fFTWm56iJV+ctFkvNgjI3jrYotv/EN8fHjPw2a72gQ=;
        b=GEXixc88q6C2JzskUB/iI/0LKbZQF1Evv0GAtA/EpmdR+NrZsfsXItoNxg9c32H7jI
         O8jPfmygSHvM1DL4MHXRkUXes+uWopyX7PkqCRGnj0/PbH2FUhh3ruoFT0qjowq8+9IC
         4sXqW6S4vUvXIwEM+HfnfJMkUe/Zxi1B9SMS0a/i1D0UznuravKElPQrry/EZ7gLcKtr
         NAe8rFbY5K3I2yEbceVcRn3ozGvWKvain05QgpXaucK9HEbfa39ufF3uJvbZtQ08DDSe
         kSokwecRe22b5Lpig2KPJivj6ES785uKPR0JiaTYQPfyMZikw7WRNqar6QcnyG70Z2c4
         K1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708721235; x=1709326035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fFTWm56iJV+ctFkvNgjI3jrYotv/EN8fHjPw2a72gQ=;
        b=dH0CSFtIQAy8vYAJIlOpJdxel1+HYvZGLgWytpv28hXX3FRxZhUjnrwpqPf8foUAAl
         WU+PDjYSPdzG53GmdVi2NlrY7gcQqIqxXvgvkTv3oEYKApiUPH+T9F5Q7kZbcSgUp2WV
         mIjhOeKD6eX8AsXvZ/RLKcCCbJreevouYKy5aMdUfEmaVbHZu+V+7ASOvTFA/8Y3BZ2z
         YsmC4mQU0Qc2nViVnKMorvkgUpuU4ZWpcM9wa0rHh1OJZNv+7Z/H5r311fs15iMtiCVQ
         YGl4AJdMLud1tt5FbRfz9SQpkx0+lm51BqnWE/bSz5tgEQLM20JM/JmwwR7kzvm/eXrN
         0eUw==
X-Forwarded-Encrypted: i=1; AJvYcCVQsMFaT5lUvkTBh2HV6yce0dU/i6eqxiNDWUlABXXua6n82VLCO4XG6uLdxGe6XIsxdefVmxnX10k2Q/qq+bd/urtIZ8w4A7BgahRm
X-Gm-Message-State: AOJu0YxdPA8JR6QtUV8HImgk4ECgRUEsvRhZg997vHnEMLgJ+V0LixLg
	dAnFpcivF2E3+6G1tz5C2oghy1iRddedt9RN4AYFZ5hM1I9hm1+SL0T3BqXVgrVhM84BNxb0Lan
	U1s65zjPVq3g3Z7CBe5+L1YSIW5jzyExaEPvtYJYFOLglEqPX
X-Google-Smtp-Source: AGHT+IG6Gf+G3ngH2onPvFWemsQPhymAGktJK0IB+myTcQRjau5iLrj+DS0i0ls/ZIdjmlW01Zla/fXqBNKs6+0JvSc=
X-Received: by 2002:a25:a049:0:b0:dcc:7b05:4cbb with SMTP id
 x67-20020a25a049000000b00dcc7b054cbbmr907828ybh.31.1708721235497; Fri, 23 Feb
 2024 12:47:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223181439.1099750-1-aaro.koskinen@iki.fi>
In-Reply-To: <20240223181439.1099750-1-aaro.koskinen@iki.fi>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Feb 2024 21:47:04 +0100
Message-ID: <CACRpkdaA9WfXJ9KGC+7RNO4iyH-6=qauYHv+uKsjLCYKmnh1OQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Fix MMC/GPIO regression on Nokia N8x0
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 7:15=E2=80=AFPM Aaro Koskinen <aaro.koskinen@iki.fi=
> wrote:

> Nokia N8x0 MMC has been pretty much broken starting from v6.3. These
> patches restore the functionality. Tested on N810 with eMMC and external
> miniSD card, and on N800 with SD card in the inner slot.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

100% my fault, I'm sorry I couldn't dry-code any better :(

If it's any consolation, there are now no GPIOs left for me to break
on the Nokia N8xx:s.

Yours,
Linus Walleij


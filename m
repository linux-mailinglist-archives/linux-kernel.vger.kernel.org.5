Return-Path: <linux-kernel+bounces-167346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BB08BA841
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C0B2832AC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C263C14883A;
	Fri,  3 May 2024 08:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AgOQFL2n"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38501482FA
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 08:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714723363; cv=none; b=VyWTxD6vXse799QdJlf5vXZP4YXknZj8qlsFCFhCpNnxpjDamUYbh78wkA29DQgNnhmuLsMBMZmg7zS8qWeWzhrChjVhFRv2WxcT4zcahVVr4WN1WH2/s/jixkGot5r/b9JhVHR8nlWqMYpT4ETzA8TPylTJqp7proH/VM3nqBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714723363; c=relaxed/simple;
	bh=5l4XlUqBqhwI1SMm61YkCiHT0P7gnVKiEtpLpYImolk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QsEZWahgpUW/Lu8489b5oB9/47cvNDuOWYzTd846qXDNKwVgOcMhGfxTiPQE/1kH7Jjb8J+v7nd/BrCFSAK/aHkhV3UoRh1s+hKoLZgtm6r7lEfOXDiAHbtSZIuWdu0F17vvNdIederbvFSrZL4v2MAi7jYSRP8U4q4paG5Cgk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AgOQFL2n; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-de604ca3cfcso4947924276.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 01:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714723360; x=1715328160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5l4XlUqBqhwI1SMm61YkCiHT0P7gnVKiEtpLpYImolk=;
        b=AgOQFL2n8HJb33NBV3bFuTdAE7ZoyDI+zgrOBQlb3h1dvRFFdaqiDiif5JEhrgn7dX
         uv5SL4ToGaN1HoSXcr+tioZVNuxt1tUM77HoeVZsQOSMdSurj2J5TjKdpwt1njLZ3ryv
         hPWHFiVmvdwvRFos4xbzo0JJOMHBpYxmFnklNCGLEiL1z5gQ1eMJ+iTBC1QaYLkEgjbJ
         WIZqB6RMgyFlW/XBizJ0YtJIu3vYuFdm+O2OlcuBvVqryU7ASNOG7lwV0Kt8/pZ7HxRU
         uWBl0C7uAs5oxfSviilTHDNbRhRlFyhcXOdeNYEqQ07cLk1Ic4+88/hluVraHKmj8EYv
         EQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714723360; x=1715328160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5l4XlUqBqhwI1SMm61YkCiHT0P7gnVKiEtpLpYImolk=;
        b=kUc/Us1t4PzYBdzGsJGApMzg7L3bSv+UX5IqNJVVlI2jbzSrBIJJTJDopPO6DCswqH
         k0ndpplHEtOtCIxGY4WO/GtIDlhr24frGqILY5T2i+jU8joFFphn+whU0FXBiN42RR4V
         I5meam6npSbDJiXUlGiN5LZzBaq+OcTMLjSsWijdxB5x2M+Te7SiJzXoy8rdusJ8s7dY
         sMRWv89B+eyQAHs+qTsWMYYqXusX5ftQFI4dXwDDz3Z5++Zfhbsj4jQjHoWPTzoYZvCL
         UVNcrjt8AbKW6/T0ofpVdy/X17CCQdQQOGLT09ZnjXl02EaA+U8ClZ24tt2WL2rZ/64p
         uFbg==
X-Forwarded-Encrypted: i=1; AJvYcCWeu+NuRQKqm0B5MZnaaPX/gwFsDRRnyDPOgXchOxKMibev598IQMMYImcGDWNdIjTNmQuoUI1UId7DVmtr6JwNSjHUnEOXAptyamEq
X-Gm-Message-State: AOJu0YyDljegPwA79l3ZQpShJa7/Cr6Q9vbRJADyIHYAX9uGOMjxI3Ku
	P5tWBgUcENZPOnri0kFJ+6UaJLHK41QHKXnNxk5Rxjv0iwxG4OJCu+PzLs+Dhq3FwJhr1lXDq5g
	az8GyuZz8x3NiSuhz9Ndayt8t2bZmkq3EYAs1Aw==
X-Google-Smtp-Source: AGHT+IGCUHlRRDycxKRVNSSdC7EJzLJSHjj9gaqFw9fOINQkvak2OuBO2rLIuQiE5A/AOn4mnItlVreNPQH0nkrNqSQ=
X-Received: by 2002:a05:6902:2011:b0:dcf:2cfe:c82e with SMTP id
 dh17-20020a056902201100b00dcf2cfec82emr2350328ybb.55.1714723359842; Fri, 03
 May 2024 01:02:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425185603.3295450-1-quic_amelende@quicinc.com>
In-Reply-To: <20240425185603.3295450-1-quic_amelende@quicinc.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 3 May 2024 10:02:29 +0200
Message-ID: <CACRpkdZgrBfzLxKtCHcyxUjw2peiUw43+HC8wZEZcXubKF6DwQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,pmic-gpio: Fix "comptaible"
 typo for PMIH0108
To: Anjelique Melendez <quic_amelende@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 8:56=E2=80=AFPM Anjelique Melendez
<quic_amelende@quicinc.com> wrote:

> Fix "comptaible" typo in if schema for qcom,pmih0108-gpio.
>
> Fixes: 6acc46f8c065 ("dt-bindings: pinctrl: qcom,pmic-gpio: Add PMIH0108 =
and PMD8028 support")
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>

Patch applied!

Yours,
Linus Walleij


Return-Path: <linux-kernel+bounces-12320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 038D081F35A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3099284038
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 00:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1587E5;
	Thu, 28 Dec 2023 00:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PZjXOvyU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73F6385
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 00:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5e811c5c1adso46510347b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 16:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703723048; x=1704327848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnZpCbxpG9ZXkJEKbWpCszWIDg90Dh3GgSsbG0XTifs=;
        b=PZjXOvyUqbK9cwTda+j4ivq5zTCdszAVnhlXxXGeP1qv+ELsDTl9/+yCDwoV/U0kDr
         GbJoZYtcoKfQ6qXKE3C4lIBLfc7dkzpMl7AAOGnfzznR2o517vlK13bc/gbQ3vN0QORP
         cDy92eSPOr0T+2JHePNYPnQCub8XDeuSFlSgHlu/aseCfa3/xVYie8Xf+C6I8ikqUNT3
         QkSkgPo2OEEETqTYBHfSFANMoFjGUm5rSPaahZG2xi82CpMpMhZK0mipqqp1PEX2FpxN
         7csNs7rLbBIEW2GA9MsAeEtT8qTAqvHnanSG/8AaztyLOHltPlcsZdkzHvMG32IY4TU/
         g60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703723048; x=1704327848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnZpCbxpG9ZXkJEKbWpCszWIDg90Dh3GgSsbG0XTifs=;
        b=V40Xt1QnYtBNBbw/p7nUVG6avL4MUAAqHP00r3vrlKDht7L62RKzQIWFWRfEFuqz2A
         A2z1DVat5fAtzkO5d3yT9/KteN3s+vU/OMkhi9BRTqChqsmnZj6Q5W5umo65wQ4DAj5G
         cUayuGF/edsxEfYnj6WWtQq6YWypV081GjpdOyDP61hK5IxxHRXDzk2icWNuG3t3J8yW
         c6pFZUbXBJuNg/pA8WqgA3TsU1Ytk4Td7dd74bFCK9K/pLFQCYgr4C57wUJ8g/mE/wQo
         2BtPEm7aWmUvEoo80N6KcdwxJEmxNVt4+XtDbep4ukj1RDSomynbW4RKenTWDCTUjTXb
         oATQ==
X-Gm-Message-State: AOJu0YxIggkFmgjpZd6XKWY1G1H2Z+EyYrvAbA7X1lyD44UY1Jk0thDt
	1Md1iK+YeGk2ZTjGo0qPjoxyu8Z7FEVw1Y7cDR1X+U9fJ3RS/g==
X-Google-Smtp-Source: AGHT+IHR03vSvnVmsAq8IM/pF0LR5N+8EMmwK+moEtYhcqnSeJ27VYApYh9cAOplXTxeV7EiRxv+ruW5Sp+tuHtRJos=
X-Received: by 2002:a0d:dd92:0:b0:5e7:bb3e:606 with SMTP id
 g140-20020a0ddd92000000b005e7bb3e0606mr5250773ywe.89.1703723047806; Wed, 27
 Dec 2023 16:24:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223191902.22857-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231223191902.22857-1-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Dec 2023 01:23:56 +0100
Message-ID: <CACRpkdYLXEA3D-_22jsios5-CdpC5CLxFbTUA-Z=dqTHmtH9XQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: samsung: constify iomem pointers
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 8:19=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Constify few pointers to iomem, where the destination memory is not
> modified, for code safety and readability.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Is this something I should just apply directly at this point?

Yours,
Linus Walleij


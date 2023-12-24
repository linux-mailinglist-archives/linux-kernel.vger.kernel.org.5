Return-Path: <linux-kernel+bounces-10647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F0081D810
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 07:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631F31F21AE3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 06:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A662111E;
	Sun, 24 Dec 2023 06:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QfkufzGZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2C0ECD
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 06:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78132affa95so99353485a.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 22:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703398829; x=1704003629; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dY6JLnVxrEsnmNyVP0wd7jgyz6XGLyt39+/qdJ/qmgc=;
        b=QfkufzGZXbFVF9F4h0qH6TjT/YyPtImUaAsvOrl0LwpRMv8ryJYHPu9z0amfjh85Dl
         aI6wzTldNqgTbFH6eRALOJcshNCNTmj7OAkD6wRZ4E1xoXJf4mBatqDYWa/jZSZNyuzP
         /aG0VDjhTG0YIVAq9NW6ttvIeljmUEsZfnGj9HysOrFUn7llcyhtCbPU+ZXm84KZ8+k1
         spdLOSYmHPBv0U6BNeI9oBgE3gPiq2HQcGxLL7rZ4iURlPgm7/kA/Xd2sY6RmnAd9Wbc
         Rbg1VXM6ccYnWSwOodOr4lof387UxujycHta++dnB8GWaeQAEhOaDl9W1a7bXaGIDb1D
         Qj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703398829; x=1704003629;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dY6JLnVxrEsnmNyVP0wd7jgyz6XGLyt39+/qdJ/qmgc=;
        b=vlbB5igmfHVILJz9rWMXQHQ7w/Pcu7T0nib721pSdUp3BBPH3H5kI27XP28qdaJxT1
         JG+yUShNF5vGpYAIsXQcLQ7urDG1n1H8jH+CGfMAEV0/a12bvYO+SvIM+5tCcGd7Bf/G
         E8NvZd5eg5pI9kWCNmtM0LoCkXYN8+xNxe0Odr/RUOttT2yPy1E7rLvy8SebiK8M6Zuz
         PHXq8NFyfSQU4v6Oo+IilvYwV5Gf1u5/Dx5kB/3hWsJDqunG29OVEKLyF6pQXStCAOHF
         V9Wx3Iug7O96pkbkqVN3XaRpwQqHuKXf4KtqTnDlTAfdz7S2VfURHTJ196CaWBtLpQ4n
         WMSg==
X-Gm-Message-State: AOJu0Yxf5BXaYVW5gyc6SsTlXLZre0Yykh+Agk8wnnLRH2QqJjU8v1Ce
	I6NwuSge69Un0Sc2Rf+9ajXFzz7BFFTZQpenz/xRfphu12SEdw==
X-Google-Smtp-Source: AGHT+IFOkGjgfNXHmSpOEjsFf/qZU6hAt4ef5UIQN1lp0Pp+H580Mc1NlscQ7QMxENom9HXHMQhwDP2uIW4atBCUMuI=
X-Received: by 2002:ae9:e214:0:b0:77e:c67:32e4 with SMTP id
 c20-20020ae9e214000000b0077e0c6732e4mr4045914qkc.23.1703398828926; Sat, 23
 Dec 2023 22:20:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223-x1e80100-phy-pcie-v2-0-223c0556908a@linaro.org> <20231223-x1e80100-phy-pcie-v2-3-223c0556908a@linaro.org>
In-Reply-To: <20231223-x1e80100-phy-pcie-v2-3-223c0556908a@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 24 Dec 2023 08:20:17 +0200
Message-ID: <CAA8EJpo_mFVvvB09e-nLT_GuTAdd_XfVLeVEzGbUV26hJ=C9ig@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] phy: qcom-qmp-pcie: Add support for X1E80100 g3x2
 and g4x2 PCIE
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 23 Dec 2023 at 13:55, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> Add the X1E80100 G3 and G4 configurations.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 173 +++++++++++++++++++++++++++++++
>  1 file changed, 173 insertions(+)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


--
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-111406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09464886BE0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6FC1C22CC8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EDC3FE3D;
	Fri, 22 Mar 2024 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IwVMaP2k"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E21224FA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711109493; cv=none; b=HqA3dCqCdt5Mhq75SaeTOfZrDkJo14CV84a7RQqxHvzY2/H2xO1Bzejxt3IL9siQZT6eTjZJlQa37Coe8hY6eTvtPVfad6z1pkFGrV/IPvoMPcjXHJWT1Zkz5W1yH4+lxXmSID5Wg+3sg+2YGWH6MZiDmu+YxnN75/hzxG0tct0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711109493; c=relaxed/simple;
	bh=ookcacqQvslMXulbynVMtpcpPlYS0qDy2qdS2UTm+nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHN5cgDAkKS8rhPaQ1xJn5Qls7OU2d75wIgP/YVKXPIf8TDWA3GTa9LxTtBBlpLkyiRw2fEyh62Jr4gfcjW74pII6tfIhxmQTP2O6FbzSFJnMRfOGF2nmhI8L81IaeKM4o1+luh2ur4vwGv1UUyN15jICQuaYgHgLv2lhU5Vf9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IwVMaP2k; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-609f1f97864so23158957b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 05:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711109490; x=1711714290; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F/FEfLL5ARXahGfD5kj2pZpy3RrSe+B9Qp8hGUm/NLI=;
        b=IwVMaP2k5UKwOLibawxM8SdE4/U4Gio52NR1UlljOKA5JUS6UsS3FfkM8H7frhobL3
         mljoclux0QxCyy0SDz4vFteM6bS5sKE8u88pZ4/zSK6SGitbga0+Y3nlVOkK4t4iHb+y
         k9Mc0J3s+u8GVI9+7WaB+r3mbMt6j48wC0NLkCz8/B/KEIUj//KElcNCmFzzxwzp00KE
         CEFlZH2XDxTTAevZDDgv8/MHbmbembh20pewjqmhVbWsDQcVkgYKtKg8y4b6z55VAFFf
         Wp3ijo+Mow0r3IlAofNs12nuRQuSQp+xadCegQO3TrI3Z8wH5kXlT9CyOsSmX86YzabJ
         Ngtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711109490; x=1711714290;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/FEfLL5ARXahGfD5kj2pZpy3RrSe+B9Qp8hGUm/NLI=;
        b=MQSU4zlpLvJO68IcWN3WBHU0RNgcj9hHfYJlRd3lYA1d/Aa1MtV/tGBs1JYi9EzOMV
         vSqtAmq+4u4Rn9yqqWwKA4LQx0/w1v0GiRptYiHl22EAzTD6Bq+j1l1hNuUe+uBGwuiF
         +NhMC8xcMK5M3oN1BrGqQ0T/IcfPCdZS0pwDnTboDv1amS2vSyC2hPzKSWpbwnnwhwG+
         TmpNx6qmqx/Y2Tw+GfFbRQB3BuH6nn9vEBvcmYy8UXhSFg9FC4f1m4X6EXUTS9H5yDS/
         Dxd8ZuH9IqF/fZ0SKM/uQRd8PNfn1sjuEui0eWsIkLJ0+hwr+lOri3nAHnbxnMXqyRnw
         dkyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiU6ieOcOoNk/nyH2Z1Dpaw9JuC9uCSS2MU4bvzugvu5oYVXT2pZ4mdsMrrK2d29pAxWPXPxgcAEyoPq9nQX7i4zwgv409fQEJYrJe
X-Gm-Message-State: AOJu0YwqdryQpV8umLk8a6ThWGfcOmv1cC4R8JyvKL8Sg/ikgx5euy7r
	HQjbLWiriN5znBq+a6wEN1Ce5UFYQ5kZKNLsXdd+RaHU2KjvQpTil6KaJ8EGZAw8rF+dYJMxX7E
	Bq34NCqhttW3H5np+VruHBwsptoP/TZb9eGmX0A==
X-Google-Smtp-Source: AGHT+IGB0HkBiPswuKP8IjOEEr+Ve7Grth1dIhr3BI6d7OWAcFJXCTnZ+hcmMSMVCmZ1rO5o9+1LQZhT6eIjuBhFXWE=
X-Received: by 2002:a25:2f0c:0:b0:dcc:f5d4:8b43 with SMTP id
 v12-20020a252f0c000000b00dccf5d48b43mr1836581ybv.9.1711109489879; Fri, 22 Mar
 2024 05:11:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322-typec-fix-sm8250-v1-0-1ac22b333ea9@linaro.org>
 <20240322-typec-fix-sm8250-v1-1-1ac22b333ea9@linaro.org> <30f71224-7340-4255-bd48-a96252985b15@linaro.org>
In-Reply-To: <30f71224-7340-4255-bd48-a96252985b15@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 22 Mar 2024 14:11:18 +0200
Message-ID: <CAA8EJpqNM8dsnX6OzZOFeV88ngJ-mE8AKjaKFurT=eKed6Yu4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8250: describe HS signals properly
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luca Weiss <luca.weiss@fairphone.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Mar 2024 at 14:03, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 22/03/2024 11:58, Dmitry Baryshkov wrote:
> > The OF graph should describe physical signals. There is no 'role switch'
> > signal between Type-C connector and the DWC3 USB controller. Instead
> > there is a HighSpeed signal lane between DWC3 controller and the USB-C
> > connector. Rename endpoints in accordance to that (this follows the
> > example lead by other plaforms, including QRB2210 RB1, QRB4210 RB2 and
> > all PMIC GLINK platforms).
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> Hmm
>
> I think if you are going to change the name here, you should also do so here
>
> grep role_switch arch/arm64/* -r | wc -l
> 54

Oh, my. I'll take a look at the qcom platforms for v2. And funny
enough sc8180x even uses old bindings for the QMP PHY.

> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>


-- 
With best wishes
Dmitry


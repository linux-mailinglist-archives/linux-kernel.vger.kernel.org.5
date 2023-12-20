Return-Path: <linux-kernel+bounces-7048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC05781A0F5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09E661C23167
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0ADA38F96;
	Wed, 20 Dec 2023 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZKX3SwHk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162C13A276
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5e86fc3f1e2so7210277b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 06:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703081936; x=1703686736; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0dJ/uTYOAXQ9/VO+SpE3eiUrHkLtjwxggeQpM/8y8I0=;
        b=ZKX3SwHkhxRkpt2AZ0SJxa/dcXoE42aLpXzmYzxyVkWrwqga54YEZJfApXi9Sm0pAq
         89zkA9pVJhnaUo2C4Bl/M9Wwh2iNjDHtTz0UzUQ311Cee3rN8dKw7pZWkYFQW+2wYqq+
         XWos3gFdTEkLRUqSTmseG5OSfg/NfM9XklLm1Bjye3qqujZ14k+Ks0uGYcazZ5XXDgvX
         MTANkztdbj6bZakjooAWdNauPIMK9+Lu/dD0NGyUYqVWYeb5Wk0RKsPrrC1ZBvYpgPq7
         ngl7jtYPN2sbYqas3gRTTRtGvOJaLSCSW5gGt+++uuPfPB+w4eoZPeJAG/LpEaCK8i9R
         /lZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703081936; x=1703686736;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0dJ/uTYOAXQ9/VO+SpE3eiUrHkLtjwxggeQpM/8y8I0=;
        b=Nsk2EI0cDKA9Ie5Cd7IlMpbrmo8ELnVlxFMV1oBN6P7ag6tkMZPP+rXGQ3VtgZgK3W
         6l9cETRQUxHehicw3P7q7DR9dC50RyfeDOLFFaWmAzY1goMmhdSE/SxKbuCnWB8ttJEA
         9P7T5no07DA3EZ7kISN9xkp5/o9NkcQubx299YJlcqOK45rozr9nf0Dts5jaIyPTUMJp
         P9reVfNEG8gxs0Pw4SJHcfDxVPr/P8TWBy7WfFT71KgX0kwUY2od6SS0hg+ZDBpkWiLa
         lK6rdtIj4S0aHAad1f+6KiOcjmULZOu6HvZ+hs1vIhKbyVJL9P/qtD96YzhKawTn2rEA
         t7zw==
X-Gm-Message-State: AOJu0Yz0XwBTA68zTadZ2yabJ1kroI/en//EzsWJF7PWbKZI5rMzIHck
	CLY/YIR2ux4ygi1xym5McPhQu18sqw0RPfGTSz/QPywnIf26DDUC
X-Google-Smtp-Source: AGHT+IGYeV0v/WtQuzYBXkz8MyIbFUmMaWaLwF2L65FzaM7MvZgbusGiiqhH18ISHE/cxMHp63q9EolKbR34g5Yw7zE=
X-Received: by 2002:a81:5b45:0:b0:5d9:36ee:50a8 with SMTP id
 p66-20020a815b45000000b005d936ee50a8mr15930266ywb.2.1703081935494; Wed, 20
 Dec 2023 06:18:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220-fp5-pmic-glink-v1-0-2a1f8e3c661c@fairphone.com> <20231220-fp5-pmic-glink-v1-2-2a1f8e3c661c@fairphone.com>
In-Reply-To: <20231220-fp5-pmic-glink-v1-2-2a1f8e3c661c@fairphone.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 20 Dec 2023 16:18:44 +0200
Message-ID: <CAA8EJprW-ZTf8azegjb6H-tx01JGRgifL+AeKiPW_pc+k4PPhQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] usb: typec: ucsi: Add qcm6490-pmic-glink as needing
 PDOS quirk
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, cros-qcom-dts-watchers@chromium.org, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Dec 2023 at 12:04, Luca Weiss <luca.weiss@fairphone.com> wrote:
>
> The QCM6490 Linux Android firmware needs this workaround as well. Add it
> to the list.
>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/usb/typec/ucsi/ucsi_glink.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


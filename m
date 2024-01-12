Return-Path: <linux-kernel+bounces-25081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BC282C760
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7A3D1F2481F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26C4182AE;
	Fri, 12 Jan 2024 22:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IIc4+vCn"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877E1182A1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 22:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e7c6f0487so7767178e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 14:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705099230; x=1705704030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32kOpc7jmHfTKnUipGkgywWo/WFBVKADG1CFjMO63QA=;
        b=IIc4+vCnY6m6uYTPT3feMgpLWU0jUnTycmofqEUYLWgsoiTM3gcq8M6va6dZbt0bgv
         y0fNw3ANaPTdY7atwqHlzGgGNm83CSGxu9uHy4CDVQvulTNCc/Yg/vn/zbj0sWX7F9B4
         3QnG1dNLvFGy2a+7mxl8HA+iD/fy1rnb4Atxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705099230; x=1705704030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=32kOpc7jmHfTKnUipGkgywWo/WFBVKADG1CFjMO63QA=;
        b=UyZI/QW6zam6txKnSE8tRYtVeG/9tFP/T+4hRjMazRR5SNjGjG2E3vO721k4/Hnpyj
         GnrmdQGJO/tjCtvZE8cYoQ4HjP18MZt20568SpVE4YdmRXukdMCQ/Cx1d8FhOFSsDsuM
         VHFptBkBTxUFlFdjSvm8wO8amwETYUbkUVkw2A1GFZnJEwexvIO2IKSYBVnT10W0fe8Y
         m15E0VL11YW3TF3H9i8Zfn4GabQ5xtSSi8TTNgMXIgO/4KDNDwwPOzT9ojTn8iDloap1
         xLkxz35ETydQN9gXjAOj/eu6PF0jD92eVVDWblxjFdfp5JoEYKQ1k+bjXSvIvCP1d3pL
         XFAA==
X-Gm-Message-State: AOJu0Yye8rJizyxRPLPQCdonag2+auT1EWIb7mwgYKMNqIfjIc1lDMXv
	eCd82YGU1SEj51XnqbSji3PwZOeFjDxK4yB9MGg5KoHhAMcg
X-Google-Smtp-Source: AGHT+IFAGDRltzrOuwOjfQw3BbOLAGH99OOdLrJfIuQiRQpUY3N7PM2+1jOwKqS+5bXXF/pZCJmDPVeNB9k5DbXpKmQ=
X-Received: by 2002:a19:9116:0:b0:50e:ab9b:c1d with SMTP id
 t22-20020a199116000000b0050eab9b0c1dmr695685lfd.37.1705099230506; Fri, 12 Jan
 2024 14:40:30 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 12 Jan 2024 14:40:29 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240112142032.909736-1-nfraprado@collabora.com>
References: <20240112142032.909736-1-nfraprado@collabora.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Fri, 12 Jan 2024 14:40:29 -0800
Message-ID: <CAE-0n52sbshmkROspU4Hg=G_-RzhkG11q8ktc9uzHuo0JXn93w@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: mt8183: jacuzzi: Remove CrosEC base
 detection node
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: kernel@collabora.com, Chen-Yu Tsai <wenst@chromium.org>, 
	Conor Dooley <conor+dt@kernel.org>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
	Ikjoon Jang <ikjn@chromium.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Quoting N=C3=ADcolas F. R. A. Prado (2024-01-12 06:20:28)
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arc=
h/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> index 7592e3b86037..8c9f7435cf4c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> @@ -484,3 +484,6 @@ volup-btn-odl {
>         };
>  };
>
> +&cros_ec {
> +       /delete-node/ cbas;
> +};

Usually we add nodes instead of delete them. Can you move the cbas node
addition to the other files that include mt8183-kukui.dtsi instead? It
will be a larger patch in number of lines but then we don't run into
problems where the node is moved later and this breaks because 'cbas'
doesn't exist.


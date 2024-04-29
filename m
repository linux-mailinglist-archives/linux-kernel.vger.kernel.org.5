Return-Path: <linux-kernel+bounces-162384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 627D88B5A69
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 905881C211AA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5F974435;
	Mon, 29 Apr 2024 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="uS5jUxoh"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D492A651B6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398378; cv=none; b=GTLYLk2fPsFzn2kWbKNYjX5Zp/j3YvnD6fbaJEybm7qOfLuya0YkrLWOBNHkGPO2Bk6ba5+HTNYTEdJH6O7Wt4mQ9oDKjp0ACN5bzPySUeCp1dhVPPakudePgzEfpRy31cD7nNw/Zb7n5MaOOe8nYZ1urYMiy/7g5EybdB2+QKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398378; c=relaxed/simple;
	bh=yOM6x4ip7qhIJTmNKPRKsHvmpY33g0qufiDZxMoO6ps=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HN0ktHY/zVQ5PdfE/sQ0ShJu9GDnS1pB3ED7QMwPfE3SgG5hNHK0qLd4mv0iYR07/NPkmAacaESSFsuQBId6505CwxvOE9cw0IS/mpxC4vOtY1pYQV1TLfsQzacHjAFm4chLya+70qpyGqM5p/NHsffbVnfmMmhL7RVEsYBDRyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=uS5jUxoh; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id ED87D3FE5A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714398373;
	bh=h6mJvCJK1Jea7r50yUqQ7vE5+7yhc8VviIpbBrR7hhY=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=uS5jUxohJWzfK3EwyqhQCmG1dV0U5QqpU5C3Atiw/U1wO2BBZ8GMW7pss8h3MTCYX
	 lU9nSWGsNpUuccehcDc5ljkyiZOwQElGVud9woNi/jVFXHdTx3TP2FT5xy1x7hRIlx
	 yCEnL116w6UA/9iSjD7oJdv563V6QgfwPA7FSH3Cx19u0fjUOzagZp5mqybIAOPQ0M
	 rYISwG5hrQ0Jh0mzpC6spAHiD2tQNg3j5lw1NDF49F9tOzJ3n9JUcswkrUI6mFpdOP
	 KHogZy4qTlU+IMRcmQ+Qwz1tba09bXnBzqGPou7YRA9UR4oM1Af2kCzErEU6FkUcsY
	 W7ZOBLnxgUf2g==
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-43ad0f1a08aso18100541cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 06:46:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714398372; x=1715003172;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h6mJvCJK1Jea7r50yUqQ7vE5+7yhc8VviIpbBrR7hhY=;
        b=v0jh9wRP5UHZRSIzyyXz79wmgSaNjL1/q96Vc4Nlv58MO3Vo+hwUK9Eo9dR2PS5wDt
         bp+UeayvDeqtCweuJICgh9RYS+lV1/ZmDTT0vj0xvLeUEEc2k8xzkqUeNlC8bYD1p29D
         CLOVxjG6wfPkwGbArTvH1/0TqFOPGg2Azq3MzEUP6VxsQEFcyL2P36FqJGUhLE2XhlbJ
         fUgu/aYvjCb4tCFpWCo30RK/UcN32cXEG7DJEaWArYY4a5xySJb15ld0+vm3/HR3NL4+
         TNAUBpXOZrjBcy/8z6TnxPUjWRscWC6c8iH7iIOcM+t+YiIwuxTdaOVrLi69xmjwyOeN
         wXnA==
X-Forwarded-Encrypted: i=1; AJvYcCX0QyVdBOdw0vKANhBiPrbanlqPqkUwdu8ihhvOwnwinjq/kIwiYcibX5vNZq1nuiiGBV8iblOjUrZrylu9rDsSWIfDMSZh4E29MXTy
X-Gm-Message-State: AOJu0YwAExxtCHhjf9G29u+1VExa2a1cIJIEwUTD4Zl84QDbOE4qryYG
	d6l2UhGOiddAyKYIzKWC7d0ntiKIluisyneeDLs3LheMe2oI/7E5qCUPz8iK829etgrwmp0zz/Q
	Xknxe9i0/RI67QdN2ooHdVvmsr2+OVVMtfbGLUX7LWMyPf2yUanQR74BEL6Mr1fkeiznMm8QNn0
	chuUiAmFwxEL+Z3mJg+X4vT746+LGUjOxl/WESYNiFYowMPI9aQpDrpkd4/9fIAPA=
X-Received: by 2002:a05:622a:18a3:b0:43b:7:6b42 with SMTP id v35-20020a05622a18a300b0043b00076b42mr1868770qtc.46.1714398372604;
        Mon, 29 Apr 2024 06:46:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIlDbe7IDabCj+xHEpXMlCy+uSz6SBjFMnmfn0odAlBGQ9fDFSnW9gobHhiUN+TFENPPlf8J74IM1KUJt/YOY=
X-Received: by 2002:a05:622a:18a3:b0:43b:7:6b42 with SMTP id
 v35-20020a05622a18a300b0043b00076b42mr1868758qtc.46.1714398372378; Mon, 29
 Apr 2024 06:46:12 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Apr 2024 08:46:12 -0500
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240429001317.432-6-jszhang@kernel.org>
References: <20240429001317.432-1-jszhang@kernel.org> <20240429001317.432-6-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 29 Apr 2024 08:46:12 -0500
Message-ID: <CAJM55Z-aoe-whriE4_MuHxtTB2OfFSaatLW_6Beg50+vrNSg6w@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] riscv: dts: starfive: visionfive 2: add tf cd-gpios
To: Jisheng Zhang <jszhang@kernel.org>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Emil Renner Berthing <kernel@esmil.dk>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Jisheng Zhang wrote:
> Per VisionFive 2 1.2B, and 1.3A boards' SCH, GPIO 41 is used as
> card detect. So add "cd-gpios" property for this.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index 910c07bd4af9..b6030d63459d 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -303,7 +303,7 @@ &mmc1 {
>  	bus-width = <4>;
>  	no-sdio;
>  	no-mmc;
> -	broken-cd;
> +	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;

nit if you need to respin this anyway: i know the properties are already not
sorted, but i'd prefer to not add more properties out of order.

In any case
Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>


>  	cap-sd-highspeed;
>  	post-power-on-delay-ms = <200>;
>  	pinctrl-names = "default";
> --
> 2.43.0
>


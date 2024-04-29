Return-Path: <linux-kernel+bounces-162386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD618B5A6D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FBF5B264C3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D84574422;
	Mon, 29 Apr 2024 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Hi7ItRKy"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE837441C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398449; cv=none; b=WbHPqfugNrfvznnO+bITV3h36z4fN7sm5kN+4TxofKLbfreXvuYTldyFG40R5iZWzU4QOQyg9jo4jlKNxeDh3yRz4V5MjGWDdmTREDgS0YaTDdjXvzX+rMwuaPI19DNu7cA7ORPHm8mnnRI0LR1WhhMrc95Y6wzvcZLimuNGhn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398449; c=relaxed/simple;
	bh=uh0m1xTwaxTzp8bpZx2WJen8mopZjaMqhRmcw3r8MFg=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bl9A3srP32qH7Az/3uPJDUqcY+qTc7+GJL7UDnzdLDcHHn2NaPDtW375UQ1tqVWZ/UzimhjEPYMxHwk5VYVbvwvW36s5nEo1CYeyf/SfJaK7lDZYGRLwx+R0yqBgmRoq7G9oXivE3MfKoQidRZ6LnbyJig3ZlX2OFxQ/5RKV63o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Hi7ItRKy; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BB7CB3FD43
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714398446;
	bh=vPe2VoBRc5KJIfuEGnKBAiJXDs81y/WyrmgODkiYq9Y=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Hi7ItRKyxwvkLed5tfDcrf9haM/Qn4W80r4TR81ZztrmQ7XkpN/NLTY5qZ2kf2GV7
	 pUwH6dZovQ1cL8LeWULFbhx0JKXej1MiVKZJdeRwtMZzPBZZA5c3x7bepu6syylXiV
	 Tphuvv4ONuVqH416PQkeZuaNdMXrPlzKoNYCRxgRQDGte8nm69gHsE8jOTbZrUcxwf
	 MvTJZKibgMxgerI/UytSRONrvmPWBSDli6InxTzmyZTotWU/ICBG96wbVaDnb5SHeO
	 yzvXu50dzmQW0DpIFrEbiiaNqyEJ+CkEhYImkQdNiP3RG1YMr6J7hULq3ynHTfAyNV
	 oK5nrNXsy/iUA==
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4396267ee26so104758481cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 06:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714398444; x=1715003244;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vPe2VoBRc5KJIfuEGnKBAiJXDs81y/WyrmgODkiYq9Y=;
        b=ph0pJSsZRSUHebkg24bwbQ6zQ+YxVbYUlcy3WuSlXV8irdrbhqfFLBqVvqamfKaQhf
         +AXNKPWmYJpgvlb3Z1BOM5MzfsnHnFkNCu0evrPEgcTQonfiXuAyTilvUZbZcetoirkT
         x7I10p98ZJZts1/7rvWOcKb2MIpQpaoJ9Chb0jj/ruUYCP2CTwxJMM1+6FOozXs+MuwF
         lwXz6vIGvnT7WeXpNxmDoyOFF4oL868OzBxODN1nCL4q6a8VETyKGPNhVHUInyD2XxUY
         eBc5sMb6ljOo2k92SiSPUsf5NDBhV70f/akbt+2C/ntPt1SduBE2oM9LSWy69qG8GmB1
         CtWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEIDsTcgjoe27VxWKRVyPLzXFMYqj4K2H+OLaNbLI6CyUrg9fYxXjCdLj5ImwjKk5uAC9LjfLLqKA+IxuGb5/QHCS/i8qL6UtyWtJw
X-Gm-Message-State: AOJu0YzokZVWlIof84zdNFrfS+PNjtNICuSPoo1yivmqWG1Ypw/W2amq
	NORb9SoacnoNYSCyTa7f3jRB/Sn/9LXZ2WiOd8kxzNbJ4XwrHJMffEsikIfSue/Bzoz+MMWQSWs
	z5+NojDGtkApj7X28BOroREshzfKcuY6Na4PLPaf91kpXVp7If3Pq3qE9OzCxga9aXrwxdiLt4s
	IUEM83drWI8EAJ8MuUEaOs4G5C7+I+gsg3JMsGUE+BAeYSBimS9jvt
X-Received: by 2002:ac8:5ac8:0:b0:43b:758:6d0 with SMTP id d8-20020ac85ac8000000b0043b075806d0mr1471482qtd.0.1714398443610;
        Mon, 29 Apr 2024 06:47:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8xb8MBQPl+w0n6G4E/6PSSCVvVKCj058nDjmR95TemmORiesDJfSh1k5bwOiMTIeHe1UFlwrkwdUpuedliyo=
X-Received: by 2002:ac8:5ac8:0:b0:43b:758:6d0 with SMTP id d8-20020ac85ac8000000b0043b075806d0mr1471446qtd.0.1714398443156;
 Mon, 29 Apr 2024 06:47:23 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Apr 2024 08:47:22 -0500
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240429001317.432-7-jszhang@kernel.org>
References: <20240429001317.432-1-jszhang@kernel.org> <20240429001317.432-7-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 29 Apr 2024 08:47:22 -0500
Message-ID: <CAJM55Z-te=b2ADP6vqjB+GSLUs5_T+hTCQVu2jCTqp-zqanJwA@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] riscv: dts: starfive: visionfive 2: add
 "disable-wp" for tfcard
To: Jisheng Zhang <jszhang@kernel.org>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Emil Renner Berthing <kernel@esmil.dk>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Jisheng Zhang wrote:
> No physical write-protect line is present, so setting "disable-wp".
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> index b6030d63459d..e19f26628054 100644
> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -304,6 +304,7 @@ &mmc1 {
>  	no-sdio;
>  	no-mmc;
>  	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
> +	disable-wp;

Same nit as patch 5/6, but in any case:

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

>  	cap-sd-highspeed;
>  	post-power-on-delay-ms = <200>;
>  	pinctrl-names = "default";
> --
> 2.43.0
>


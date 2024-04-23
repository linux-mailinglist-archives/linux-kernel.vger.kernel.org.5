Return-Path: <linux-kernel+bounces-155920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E298AF8E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1AF31C23116
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E413414387B;
	Tue, 23 Apr 2024 21:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUQzFste"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AB1143882;
	Tue, 23 Apr 2024 21:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713907395; cv=none; b=GoRYLj2sYqBJMh6FOKHB86lkddEenQcGXJSSud077mkqH1lEiXh1ElUVSTBszpOOky4MK6qXxfvThRQb+pjb/CGAXBF57SDIm7DfN9n9NQsLqJPJIjC9Wli/ngJ2M+/m3riobUXS6lEq4hRqSYets6F3fYPXQjIcIcURuwE49HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713907395; c=relaxed/simple;
	bh=HK0ujPxp34qpwUxMtRk5RYEckAapSdQ4K+GXdVo0Cqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSXItm+1JCbjurSZSdXpvrEHNK1ZTAt09tSYNCat+mOVl9fH42v7LG9z93J++x0ucSxfBVq09/2PiDK6s2fmheFpJa6x27jgAmg4zdBFkuJS+Td/m0sTMONcgIMY8h8DWmFzDokdBZjWuJs0yrxChGRvhIkUmPmNJ1qR56CaMBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUQzFste; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7370C4AF09;
	Tue, 23 Apr 2024 21:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713907394;
	bh=HK0ujPxp34qpwUxMtRk5RYEckAapSdQ4K+GXdVo0Cqk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pUQzFstejbk7piPmipfGwzTsvsQHb+BJz6gxaBOD9wBGu5ujIXaTvilrhWrPzFKUs
	 funigVyrZSsZBNfVpQyPAbu6N9p+q/76Ero/rE/BA6k5jlJZFc/qq8uJUfdSh9iLbj
	 ZX8L3YWHwvOvVnB++kQajXwIJVyXE0C529BLCEU2RQgULWDl3c51p76+8q6O/wkz0H
	 iaRbdoTSoAamZHl1VPdKxgkB953B83K1TFMT/C6TzROLXyT7DPYGVAKsfKU2ZKw4WO
	 bf55Q0KIHKHXhhkoK7RRC+4Lvb/9+pascEU22Qjybg9dAFYD3TLHWe9rIae4JCqpjt
	 pvO4wjKZbvJPg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51bafbe7509so1541098e87.1;
        Tue, 23 Apr 2024 14:23:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQBY5RWCclZt3/Dn/uoYpWWYpEAKdDK/25n9+kLNihQ5P8BhZGOTXgzZ4X5pivK0krk87XYvq9YP636+xvHCDewqSMXeETYS2csalnyvQHsyt3m2XkTgfJO3we5c6r/pT74crhCxOSaw==
X-Gm-Message-State: AOJu0YwTmpuF/8Is+fVRvb5QCRhiIw7XGv3IUZUZ4s0vjLP/T5LBhl++
	DuJ8/DT8PjBATU0mMjxY4teNe4BzOOG2nvHpav5JGngPrHCqf9CzMX0a3j+REEweEm3qqmFCj6F
	72jLAKzQYIEdHZBjoaemgOwsw0A==
X-Google-Smtp-Source: AGHT+IFSEy7Ntcs8kO5E/YWUotyQAYiFUv1GQFB5gLdH1tA5hJgWZew7wv8o02kRNGivuEr/W3u5Ti11wEYzT1Mnyl4=
X-Received: by 2002:a05:6512:601:b0:519:611f:df49 with SMTP id
 b1-20020a056512060100b00519611fdf49mr524205lfe.69.1713907393154; Tue, 23 Apr
 2024 14:23:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240317184130.157695-1-krzysztof.kozlowski@linaro.org> <20240317184130.157695-4-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240317184130.157695-4-krzysztof.kozlowski@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Tue, 23 Apr 2024 16:23:00 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJfT-jui5P56CO4Fr37kr5iNN8dpxt8ecKeFmdVGnRYbA@mail.gmail.com>
Message-ID: <CAL_JsqJfT-jui5P56CO4Fr37kr5iNN8dpxt8ecKeFmdVGnRYbA@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm: dts: allwinner: drop underscore in node names
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Corentin Labbe <clabbe@baylibre.com>, 
	Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 1:41=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Underscores should not be used in node names (dtc with W=3D2 warns about
> them), so replace them with hyphens.  Use also generic name for pwrseq
> node, because generic naming is favored by Devicetree spec.  All the
> clocks affected by this change use clock-output-names, so resulting
> clock name should not change.  Functional impact checked with comparing
> before/after DTBs with dtx_diff and fdtdump.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

This adds warnings:

13  prcm@1f01400: 'ahb0-clk', 'apb0-clk', 'apb0-gates-clk',
'apb0-rst', 'ar100-clk', 'ir-clk' do not match any of the regexes:
'^.*_(clk|rst)$', 'pinctrl-[0-9]+'

Since we documented it with underscores, I'd say just leave these at
least until if/when we define some standard names. I'd prefer we spend
time reducing warnings from the common schema. I'm looking at
root-node.yaml. simple-bus.yaml generates a lot too.

Rob


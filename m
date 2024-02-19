Return-Path: <linux-kernel+bounces-71472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8805585A5D0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17BD0B2218E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F9737702;
	Mon, 19 Feb 2024 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QK8+8CNN"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1553715E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708352566; cv=none; b=GwqtpOqB00RCZsKvufuu60pMb7XUXRL6E+lOvwCThTJw7uvmKEhACCILrzSlCrcKr6T/DyFUdkDZ79mfb8+PdVjSoHU5bd6njMFmE6I1LgwD4HcrBaDPz1xnroB5hfH6ZFT/osEUaI5RbCUDLsjKn4wUxXg8YvcBuOiCQ0ClMzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708352566; c=relaxed/simple;
	bh=/6PWkDSKkw93KI091rp+ZKivJdBGMc4Px963+IBDBT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtnUIqdxiiFWP4BE2HelHDHaAJAFu31pVGqPp+QXJpFkKt/8sm9IlgBAX5pqo0foiWlJApvFbra5CxnLuN+HzvOOSpzFaKIkzZnbzaiX84qWZSeT/g6LkJkBh9SWwqmi5QTEqpZ1z0OuPoHmWrphWdrh98yizQcvJ5LiJ+jUATQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QK8+8CNN; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-607eefeea90so29852137b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708352561; x=1708957361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6PWkDSKkw93KI091rp+ZKivJdBGMc4Px963+IBDBT8=;
        b=QK8+8CNNnTfN1raQMq9SGwcCDv94HK4cl1CPPMwtichxmoLfdE4jrnY1b1dEp6pANF
         dA0zchzFSNfBrAKQR+UDGBnvJr0xYWi3PDSoFDbapanJX8q7bqFY5WxzwZS0shgzBoZl
         PRJN2/t8q/r61pdGNBjK8EU/Ws7XKfnsLUrdcI6xKvRNZU6qGGxgJxgF6Tvh1wObtwDW
         INZTj5QqDeT/FCo06uWXKI5VlyGMQWhOhZhwFQCFXjqM/VwM8TKUxPseunrFmzpq5RcU
         HVASwkHo7+5vgO2E9qGu0FpV9niN1CwxzZRpAtZCJWdHZNDTVwDObCVYEpyOoowspzHO
         zJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708352561; x=1708957361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6PWkDSKkw93KI091rp+ZKivJdBGMc4Px963+IBDBT8=;
        b=pUbBgK4LQMcV7evakBEQj9ksgU4N3xNCEbPAao/kfe/36dOrRDXuQvYSsz+F2jtkle
         NfB1uA93uqokeeJ4TTxO+mhXlEeOSWbwg7cMorraz/KGtHlH+VCDED18awN1iR1MGliC
         VB/KrFpKfX4IJA3xuyHBS3EA+1F5mqxA3m7Zh3YFHE2dZbjwKDoeJ70J5+bVwh3sJzF5
         gi4cieHo914LZBAHyjLMINLzlXap84WKcfJv1gGqz6ijWZLgv+u0EL5jFXFPvHrXovm8
         gIO2dxMDMOCDI07xPvDlRf3yQ+TaBGA4n9s5t0S07VYv3+hzbK/tmbh+olMmJ613NH1y
         ZycQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3Wl4SuLBSuQnP1a4rujYQZzeUZ8dq7lAV8xH19vEXdsCcUbcusVRwV3SuYIq51aT0r/DbUNhokJnddPVtmCJNqUPjPrI5mCdkdIN/
X-Gm-Message-State: AOJu0YyYOPfR0U25OyZCNTfXWgChe5c4vzGUTtQUUGooxeXjUKvYVLTC
	8kpIECisXMSHOwWPg9SS1N/+69YiyVXr3iQ6febjcBPgg0HEdSAMTamf4bYOT4YihaFDQwsOBD3
	XAPvt/VZxSXPLxzx38FjjWEDXXK4t7mo2Qw809Q==
X-Google-Smtp-Source: AGHT+IHfGO3HzVvde7/SGBe6Nu45IRUjxZfAmy7HegMXKV9VObfO53W61JP8jP6VnQ6Ovt+OnS9AL46c8cvPyPnGIzg=
X-Received: by 2002:a05:690c:16:b0:608:b86:7c9f with SMTP id
 bc22-20020a05690c001600b006080b867c9fmr4632737ywb.7.1708352561399; Mon, 19
 Feb 2024 06:22:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215-mbly-i2c-v1-0-19a336e91dca@bootlin.com> <20240215-mbly-i2c-v1-9-19a336e91dca@bootlin.com>
In-Reply-To: <20240215-mbly-i2c-v1-9-19a336e91dca@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 19 Feb 2024 15:22:30 +0100
Message-ID: <CACRpkdYWi6kcCnS9EGwp-Saa7ZXQvRN+Pn9gOLetT_6Hbwq0bA@mail.gmail.com>
Subject: Re: [PATCH 09/13] i2c: nomadik: fetch timeout-usecs property from devicetree
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
	Gregory Clement <gregory.clement@bootlin.com>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 5:52=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bootl=
in.com> wrote:

> Allow overriding the default timeout value (200ms) from devicetree,
> using the timeout-usecs property.
>
> The i2c_adapter->timeout field is an unaccurate jiffies amount;
> i2c-nomadik uses hrtimers for timeouts below one jiffy.
>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

Once we agree on the binding name:

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij


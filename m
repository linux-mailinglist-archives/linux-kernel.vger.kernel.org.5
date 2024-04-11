Return-Path: <linux-kernel+bounces-140046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B37D78A0AB8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4C6B1C21DC4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5AF13F44B;
	Thu, 11 Apr 2024 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bx9uo3KM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B351013E88A;
	Thu, 11 Apr 2024 07:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712822311; cv=none; b=uHKOK7zMehOO9dFGMMaSMTV+8J/UQL2ii1dtAl0x2O5V3egcsKQhUA/gergbQNr6VcRbNGSFaqzWNjwYSTaUldnChxnG2EeY59+1B+qfTRUsvlae5ltpziQnuqR+Bbs8nx1uqH6QmLhJVVB/ZO47O343HpscAtFESlIph5lvcyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712822311; c=relaxed/simple;
	bh=aWbg5kc18x9Zuuc4S5SpEJ/QN5ER6AORhSwyaeYmPiI=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=S7BaNCNqRoBXjb/sBrLLBgeO3JT9j1oC3RROhmsFkqPN8luQlcTlx5YxJwH2fnMkaECYeIrKQgBdzgzHlafCYuDsoeZ26hzlTzG9NETgYcWgpvakSNQV8eHdLTffbgS0+7UfBBkJkkeGxuiqz+JnYpAdeU0/BySoXu2H0pX1ni0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bx9uo3KM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B9BC433C7;
	Thu, 11 Apr 2024 07:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712822311;
	bh=aWbg5kc18x9Zuuc4S5SpEJ/QN5ER6AORhSwyaeYmPiI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Bx9uo3KMDHyxwjAoss2etKPhUreOzMORGOKvYGVUcCmfY4xrKrzchLu7u9kGYRRTh
	 SN325GGdJHf63tztJVcDrcfNKIc3mzGWb2SISb8BKyigQgIxFjuRvJee3D3AS9q77X
	 vzHTHZ2j9XM4yDMzFIG8d9MV5d6eQbVxqYkKZC0Z1aQ6RLLmPrCWM3n0HG0X+y8WAh
	 NOoE+1J3ORMrr54HpG6mvqOyOyHnMfQuaq1QCtItD2vCvM+4n/XziEz9p+i0Y0Uwp1
	 XdpnsBHnsqZ+KhNG9ASrC00iW7QLq3cVNnsUphgvJRyRJ1GQAA1Ss3KZDCbQFG/Z44
	 Jp4tHGct2Fdkw==
Message-ID: <2785b4c6bf538d48c3ade3369524b781.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240402-pxa1908-lkml-v9-4-25a003e83c6f@skole.hr>
References: <20240402-pxa1908-lkml-v9-0-25a003e83c6f@skole.hr> <20240402-pxa1908-lkml-v9-4-25a003e83c6f@skole.hr>
Subject: Re: [PATCH v9 4/9] dt-bindings: clock: Add Marvell PXA1908 clock bindings
From: Stephen Boyd <sboyd@kernel.org>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Conor Dooley <conor.dooley@microchip.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Duje =?utf-8?q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, Guilherme G. Piccoli <gpiccoli@igalia.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Kees Cook <keescook@chromium.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Lubomir Rintel <lkundrak@v3.sk>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>, Tony Lindgren <tony@atomide.com>, Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>
Date: Thu, 11 Apr 2024 00:58:29 -0700
User-Agent: alot/0.10

Quoting Duje Mihanovi=C4=87 (2024-04-02 13:55:40)
> Add dt bindings and documentation for the Marvell PXA1908 clock
> controller.
>=20
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

